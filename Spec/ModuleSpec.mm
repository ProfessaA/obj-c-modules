#import "Warmonger.h"
#import "Pacifist.h"
#import "AngryPacifist.h"

using namespace Cedar::Matchers;
using namespace Cedar::Doubles;

SPEC_BEGIN(ModuleSpec)

describe(@"Module", ^{
    __block Warmonger *warmonger;
    __block Pacifist *pacifist;
    __block AngryPacifist *angryPacifist;

    beforeEach(^{
        warmonger = [Warmonger new];
        pacifist = [Pacifist new];
        angryPacifist = [AngryPacifist new];
    });
    
    it(@"does not allow modules to be directly initialized", ^{
        ^{ [PublicBehaviorModule new]; } should raise_exception;
    });
    
    describe(@"instance methods", ^{
        it(@"adds the module's instance methods to the classes conforming to the module protocol", ^{
            [warmonger exclamationWhenBumpedInto] should equal(@"wanna fight?");
            [pacifist exclamationWhenBumpedInto] should equal(@"I'm so sorry");
        });
        
        it(@"adds the module's instance methods to classes that inherit from classes conforming to the module protocol", ^{
            [angryPacifist exclamationWhenBumpedInto] should equal(@"excuse me");
        });
        
        it(@"adds the instance methods of any modules included by another module to the class", ^{
            pacifist.isWellBehaved should be_truthy;
            warmonger.isWellBehaved should be_falsy;
        });
    });
    
    describe(@"class methods", ^{
        it(@"adds the module's class methods to the classes conforming to the module protocol", ^{
            [Warmonger philosophy] should equal(@"Warmonger likes to fight");
            [Pacifist philosophy] should equal(@"Pacifist likes to avoid violent conflict");
        });
        
        it(@"adds the module's class methods to classes that inherit from classes conforming to the module protocol", ^{
            [AngryPacifist philosophy] should equal(@"AngryPacifist likes to exercise self control");
        });
        
        it(@"adds the class methods of any modules included by another module to the class", ^{
            [Pacifist hasBehavior] should be_truthy;
            [Warmonger hasBehavior] should be_truthy;
        });
    });
});

SPEC_END
