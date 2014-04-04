#import "Warmonger.h"

@interface Warmonger ()

@property (nonatomic, strong, readwrite) NSString *bloodLust;
@property (nonatomic, strong, readwrite) NSString *behavior;

@end

@implementation Warmonger

- (id)init
{
    self = [super init];
    if (self) {
        self.bloodLust = @"high";
        self.behavior = @"warlike";
    }
    return self;
}

+ (NSString *)likesTo
{
    return @"fight";
}

@end
