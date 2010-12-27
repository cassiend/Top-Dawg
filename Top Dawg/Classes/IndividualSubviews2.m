#import "IndividualSubviews2.h"


@implementation IndividualSubviews2

- (void)setBackgroundColor:(UIColor *)backgroundColor{
    [super setBackgroundColor:backgroundColor];
	
    nameLabel.backgroundColor = backgroundColor;
    submissionLabel.backgroundColor = backgroundColor;
	numberLabel.backgroundColor = backgroundColor;
}


- (void)setSubmission:(NSInteger )newSubmission{
    [super setSubmission:newSubmission];
    submissionLabel.text = [NSString stringWithFormat:@"Score: %d", newSubmission];
}

- (void)setName:(NSString *)newName{
    [super setName:newName];
    nameLabel.text = newName;
}

- (void)setNumber:(NSString *)newNumber{
    [super setNumber:newNumber];
    numberLabel.text = newNumber;
}


- (void)dealloc{
	[numberLabel release];
    [nameLabel release];
    [submissionLabel release];
	
    [super dealloc];
}

@end