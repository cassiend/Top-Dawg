#import "ApplicationCell.h"

@implementation ApplicationCell

@synthesize  medalIcon, icon, month, name, score, submission;

- (void)dealloc{
    [icon release];
	[medalIcon release];
    [month release];
    [name release];
    
    [super dealloc];
}

@end
