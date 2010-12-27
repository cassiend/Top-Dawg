#import <UIKit/UIKit.h>
#import "AboutController.h"
#import "Terms.h"

@interface AboutController :  UIViewController{
	IBOutlet UITextView *textView;
	IBOutlet UIImageView *imageView;
	IBOutlet UITextView *terms;
}

@property (nonatomic, retain) IBOutlet UITextView *textView;
- (IBAction)hooray:(id)sender;
- (IBAction)terms:(id)sender;

@end
