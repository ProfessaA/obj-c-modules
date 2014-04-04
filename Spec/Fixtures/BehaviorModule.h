#import <Foundation/Foundation.h>
#import "Module.h"

MODULE(BehaviorModule)

@property (nonatomic, strong, readonly) NSString *behavior;

MODULE_METHODS

+ (BOOL)hasBehavior;

- (BOOL)isWellBehaved;

END_MODULE(BehaviorModule)
