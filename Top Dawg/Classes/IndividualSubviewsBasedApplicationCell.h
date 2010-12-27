#import <Foundation/Foundation.h>
#import "ApplicationCell.h"
#import "Top20Cell.h"

@interface IndividualSubviewsBasedApplicationCell : ApplicationCell {
    IBOutlet UIImageView *iconView;
	IBOutlet UIImageView *medalView;
    IBOutlet UILabel *monthLabel;
    IBOutlet UILabel *nameLabel;
	IBOutlet UILabel *name2Label;
    IBOutlet UILabel *scoreLabel;
    IBOutlet UILabel *submissionLabel;
	IBOutlet UILabel *submission2Label;
}

@end
