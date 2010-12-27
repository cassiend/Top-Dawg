#import "AboutController.h"
@implementation AboutController

@synthesize textView;


- (void)viewDidLoad {
	
	NSString *termsConditions1 = @"Each month, submit a photo of your dog and enter him/her to compete against dogs from all over the globe in an iPhone-based beauty pageant. You can vote on the current dogs, your own dog, view past winners and share the submitted photos with your friends. The highest number of votes determines the winner, and the proud owner will get the official title of the Top Dawg!";
	NSString *termsConditions3 = @"This app is brought to you by";
	NSString *space  = @"\n";
	
	termsConditions1 = [termsConditions1 stringByAppendingString:space];
	termsConditions1 = [termsConditions1 stringByAppendingString:space];
	termsConditions1 = [termsConditions1 stringByAppendingString:termsConditions3];
	
	self.textView.text = termsConditions1;
	self.textView.font = [UIFont fontWithName:@"Arial-BoldMT" size:14];
	
	UIBarButtonItem *temporaryBarButtonItem = [[UIBarButtonItem alloc] init];
	temporaryBarButtonItem.title = @"Back";
	self.navigationItem.backBarButtonItem = temporaryBarButtonItem;
	[temporaryBarButtonItem release];

}

- (IBAction)hooray:(id)sender{
	[[UIApplication sharedApplication] openURL:[NSURL URLWithString: @"http://www.hooraysociety.com"]];
}

- (IBAction)terms:(id)sender{
	Terms *terms = [[Terms alloc] initWithNibName:@"Terms" bundle:nil];
	
	terms.title = @"Terms and Conditions";
	[[self navigationController] pushViewController:terms animated:YES];
	
	
}



- (void)viewDidUnload {
	textView = nil;
}


- (void)dealloc {
    [textView release];
	[super dealloc];
}

@end