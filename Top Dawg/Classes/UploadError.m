#import "UploadError.h"

@implementation UploadError

@synthesize textView, textView2;


- (void)viewDidLoad {
		
		self.navigationItem.hidesBackButton = TRUE; 
		NSString *termsConditions = @"Sorry";
		NSString *termsConditions1 = @"An upload error occurred due to lack of network connection.";
		NSString *termsConditions2 = @"Please try again later.";
		
		NSString *space  = @"\n";
		
		termsConditions1 = [termsConditions1 stringByAppendingString:space];
		termsConditions1 = [termsConditions1 stringByAppendingString:termsConditions2];
		
		self.textView.text = termsConditions;
		self.textView.font = [UIFont fontWithName:@"Arial-BoldMT" size:24];
		self.textView2.text = termsConditions1;
		self.textView2.font = [UIFont fontWithName:@"Arial-BoldMT" size:16];
		
		[NSTimer scheduledTimerWithTimeInterval:7.0f
										 target:self
									   selector:@selector(goHome:)
									   userInfo:nil
										repeats:NO];
	
}

- (void)goHome:(NSTimer *)theTimer {	
	self.tabBarController.selectedIndex = 0;
	[self.tabBarController.selectedViewController viewDidAppear:YES];
	[self.navigationController popToRootViewControllerAnimated:NO];
	
}


- (void)viewDidUnload {
	textView = nil;
	textView2 = nil;
}


- (void)dealloc {
	[self.navigationController popToRootViewControllerAnimated:YES];
    [textView release];
	[textView2 release];
	[super dealloc];
}

@end