#import "NetworkError.h"

@implementation NetworkError

@synthesize textView, textView2;


- (void)viewDidLoad {
	
	self.navigationItem.hidesBackButton = TRUE; 
	NSString *termsConditions = @"Sorry";
	NSString *termsConditions1 = @"You need a network connection.";
	
	NSString *space  = @"\n";
	
	termsConditions1 = [termsConditions1 stringByAppendingString:space];
	
	self.textView.text = termsConditions;
	self.textView.font = [UIFont fontWithName:@"Arial-BoldMT" size:24];
	self.textView2.text = termsConditions1;
	self.textView2.font = [UIFont fontWithName:@"Arial-BoldMT" size:16];

}


- (void)viewDidUnload {
	textView = nil;
	textView2 = nil;
}


- (void)dealloc {
    [textView release];
	[textView2 release];
	[super dealloc];
}

@end