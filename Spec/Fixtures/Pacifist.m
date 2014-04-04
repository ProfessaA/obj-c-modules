#import "Pacifist.h"

@interface Pacifist ()

@property (nonatomic, strong, readwrite) NSString *bloodLust;
@property (nonatomic, strong, readwrite) NSString *behavior;

@end

@implementation Pacifist

- (id)init
{
    self = [super init];
    if (self) {
        self.bloodLust = @"low";
        self.behavior = @"mellow";
    }
    return self;
}

+ (NSString *)likesTo
{
    return @"avoid violent conflict";
}

@end
