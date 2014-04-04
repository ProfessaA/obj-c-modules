#import <Foundation/Foundation.h>
#import "BehaviorModule.h"

MODULE(PublicBehaviorModule)
MODULE_INCLUDE(BehaviorModule)

@property (nonatomic, readonly) NSString *bloodLust;

MODULE_METHODS

+ (NSString *)philosophy;
+ (NSString *)likesTo;

- (NSString *)exclamationWhenBumpedInto;

END_MODULE(PublicBehaviorModule)