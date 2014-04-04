#import <Foundation/Foundation.h>

#define MODULE(moduleName)                                 \
@protocol moduleName

#define MODULE_INCLUDE(...)                                 \
<__VA_ARGS__>

#define MODULE_METHODS @optional

#define END_MODULE(moduleName)                             \
@end                                                       \
@interface moduleName : Module<moduleName>                 \
@end

@interface Module : NSObject
@end