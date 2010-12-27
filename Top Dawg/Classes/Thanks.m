#import "Thanks.h"

@implementation Thanks

@synthesize textView, textView2;


- (void)viewDidLoad {
	
	
	CFGregorianDate currentDate = CFAbsoluteTimeGetGregorianDate(CFAbsoluteTimeGetCurrent(), CFTimeZoneCopySystem());
	if (currentDate.day >= 27){
	
	self.navigationItem.hidesBackButton = TRUE; 
	NSString *termsConditions = @"Thank you";
	NSString *termsConditions1 = @"The Top Dawg team will process";
	NSString *termsConditions2 = @"your submission within 24 hours.";
	NSString *termsConditions3 = @"Since your submission has occurred";
	NSString *termsConditions4 = @"after the cut off time it’ll be added";
	NSString *termsConditions5 = @"to next month’s contest.";
	
	NSString *space  = @"\n";
	
	termsConditions1 = [termsConditions1 stringByAppendingString:space];
	termsConditions1 = [termsConditions1 stringByAppendingString:termsConditions2];
	termsConditions1 = [termsConditions1 stringByAppendingString:space];
	termsConditions1 = [termsConditions1 stringByAppendingString:termsConditions3];
	termsConditions1 = [termsConditions1 stringByAppendingString:space];
	termsConditions1 = [termsConditions1 stringByAppendingString:termsConditions4];	
	termsConditions1 = [termsConditions1 stringByAppendingString:space];
	termsConditions1 = [termsConditions1 stringByAppendingString:termsConditions5];
		
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
	else{
		
		self.navigationItem.hidesBackButton = TRUE; 
		NSString *termsConditions = @"Thank you";
		NSString *termsConditions1 = @"The Top Dawg team will process";
		NSString *termsConditions2 = @"your submission within 24 hours.";
		
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
    [textView release];
	[textView2 release];
	[super dealloc];
}

@end