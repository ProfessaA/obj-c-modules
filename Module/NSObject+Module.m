#import "NSObject+Module.h"
#import <objc/runtime.h>

@interface NSObject (ModulePrivate)

+ (BOOL)_originalResolveInstanceMethod:(SEL)name;
+ (BOOL)_originalResolveClassMethod:(SEL)name;

@end

BOOL addMethodNamedToClassFromProtocolListWithSize(SEL methodName, Class klass, Protocol * __unsafe_unretained *protocolList, NSUInteger protocolListSize, BOOL isInstanceMethod)
{
    for (unsigned int i = 0; i < protocolListSize; i++) {
        Protocol *protocol = protocolList[i];
        NSString *protocolName = [NSString stringWithUTF8String:protocol_getName(protocol)];
        Class moduleClass;
        if ([protocolName hasSuffix:@"Module"] && (moduleClass = NSClassFromString(protocolName)) && moduleClass != klass) {
            Method moduleMethod = isInstanceMethod ? class_getInstanceMethod(moduleClass, methodName) : class_getClassMethod(moduleClass, methodName);
            
            if (moduleMethod != NULL) {
                Class classToAugment = isInstanceMethod ? klass : objc_getMetaClass(class_getName(klass));
                class_addMethod(classToAugment, methodName, method_getImplementation(moduleMethod), method_getTypeEncoding(moduleMethod));
                
                return YES;
            }
            
            unsigned int moduleProtocolListCount;
            Protocol * __unsafe_unretained *moduleProtocolList = protocol_copyProtocolList(protocol, &moduleProtocolListCount);
            BOOL methodAddedFromModuleProtocols = addMethodNamedToClassFromProtocolListWithSize(methodName, klass, moduleProtocolList, moduleProtocolListCount, isInstanceMethod);
            free(moduleProtocolList);
            
            if (methodAddedFromModuleProtocols) return YES;
        }
    }
    
    return NO;
}

id implementationBlock(BOOL isForInstanceMethods)
{
    return ^BOOL(id klass, SEL methodName) {
        unsigned int protocolCount;
        Protocol * __unsafe_unretained *protocolList = class_copyProtocolList(klass, &protocolCount);
        BOOL methodAddedFromModules = addMethodNamedToClassFromProtocolListWithSize(methodName, klass, protocolList, protocolCount, isForInstanceMethods);
        free(protocolList);
        
        if (methodAddedFromModules) return methodAddedFromModules;
        
        Class superClass = class_getSuperclass(klass);
        return superClass ? [superClass resolveInstanceMethod:methodName] : [klass _originalResolveInstanceMethod:methodName];
    };
}

@implementation NSObject (Module)

+ (void)load
{
    Class metaClass = objc_getMetaClass(NSStringFromClass(self).UTF8String);
    
    Method originalResolveInstanceMethod = class_getInstanceMethod(metaClass, @selector(resolveInstanceMethod:));
    IMP newResolveInstanceMethodIMP = imp_implementationWithBlock(implementationBlock(YES));
    class_replaceMethod(metaClass, @selector(_originalResolveInstanceMethod:), method_getImplementation(originalResolveInstanceMethod), method_getTypeEncoding(originalResolveInstanceMethod));
    class_replaceMethod(metaClass, @selector(resolveInstanceMethod:), newResolveInstanceMethodIMP, method_getTypeEncoding(originalResolveInstanceMethod));
    
    Method originalResolveClassMethod = class_getInstanceMethod(metaClass, @selector(resolveInstanceMethod:));
    IMP newResolveClassMethodIMP = imp_implementationWithBlock(implementationBlock(NO));
    class_replaceMethod(metaClass, @selector(_originalResolveClassMethod:), method_getImplementation(originalResolveClassMethod), method_getTypeEncoding(originalResolveClassMethod));
    class_replaceMethod(metaClass, @selector(resolveClassMethod:), newResolveClassMethodIMP, method_getTypeEncoding(originalResolveClassMethod));
}

@end