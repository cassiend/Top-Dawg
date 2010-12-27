#import "IndividualSubviewsBasedApplicationCell.h"


@implementation IndividualSubviewsBasedApplicationCell

- (void)setBackgroundColor:(UIColor *)backgroundColor{
    [super setBackgroundColor:backgroundColor];

	iconView.backgroundColor = backgroundColor;
    monthLabel.backgroundColor = backgroundColor;
    nameLabel.backgroundColor = backgroundColor;
	name2Label.backgroundColor = backgroundColor;
    scoreLabel.backgroundColor = backgroundColor;
    submissionLabel.backgroundColor = backgroundColor;
	submission2Label.backgroundColor = backgroundColor;
	medalView.backgroundColor = backgroundColor;
}

- (void)setIcon:(UIImage *)newIcon{
    [super setIcon:newIcon];
    iconView.image = newIcon;
}

- (void)setMonth:(NSString *)newMonth{
    [super setMonth:newMonth];
    monthLabel.text = newMonth;
}

- (void)setSubmission:(NSInteger )newSubmission{
    [super setSubmission:newSubmission];
    submissionLabel.text = [NSString stringWithFormat:@"%d Submissions", newSubmission];
}

- (void)setScore:(NSInteger)newNumScore{
	if(newNumScore > 0){
		[super setScore:newNumScore];
		scoreLabel.text = [NSString stringWithFormat:@"(Score: %d)", newNumScore];
		medalView.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"medal" ofType:@"png"]];
		submission2Label.text = [NSString stringWithFormat:@" "];
		name2Label.text = [NSString stringWithFormat:@" "];
	}
	else{
		scoreLabel.text = [NSString stringWithFormat:@" "];
		nameLabel.text = [NSString stringWithFormat:@" "];
		submission2Label.text = [NSString stringWithFormat:@"Vote now!"];
	}
	
}


- (void)setName:(NSString *)newName{
    [super setName:newName];
    nameLabel.text = newName;
	name2Label.text = newName;
}

- (void)dealloc{
    [iconView release];
    [monthLabel release];
    [nameLabel release];
	[name2Label release];
    [scoreLabel release];
    [submissionLabel release];
	[submission2Label release];

    [super dealloc];
}

@end
