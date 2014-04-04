#import "AngryPacifist.h"

@interface AngryPacifist ()

@property (nonatomic, strong, readwrite) NSString *bloodLust;

@end

@implementation AngryPacifist

- (id)init
{
    self = [super init];
    if (self) {
        self.bloodLust = @"pretty low";
    }
    return self;
}

+ (NSString *)likesTo
{
    return @"exercise self control";
}

@end
