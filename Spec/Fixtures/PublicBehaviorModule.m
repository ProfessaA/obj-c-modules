#import "PublicBehaviorModule.h"

@implementation PublicBehaviorModule

@dynamic bloodLust, behavior;

+ (NSString *)philosophy
{
    return [NSString stringWithFormat:@"%@ likes to %@", NSStringFromClass(self), [self likesTo]];
}

- (NSString *)exclamationWhenBumpedInto
{
    if ([self.bloodLust isEqualToString:@"high"]) {
        return @"wanna fight?";
    } else if ([self.bloodLust isEqualToString:@"low"]) {
        return @"I'm so sorry";
    } else {
        return @"excuse me";
    }
}

@end
