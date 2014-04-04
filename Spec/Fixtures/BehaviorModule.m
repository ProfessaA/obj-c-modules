#import "BehaviorModule.h"

@implementation BehaviorModule

@dynamic behavior;

+ (BOOL)hasBehavior
{
    return YES;
}

- (BOOL)isWellBehaved
{
    if ([self.behavior isEqualToString:@"warlike"]) {
        return NO;
    }
    
    return YES;
}

@end
