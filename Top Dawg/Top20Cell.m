#import "Top20Cell.h"

@implementation Top20Cell

@synthesize useDarkBackground, name, submission, number;

- (void)dealloc{
    [name release];
	[number release];
    [super dealloc];
}

@end
