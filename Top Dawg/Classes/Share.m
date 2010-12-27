#import "Share.h"
#import <sys/utsname.h>

@implementation Share
@synthesize image, name, dogNumber, updateButton, textFieldName, textFieldPassword;
UIAlertView  *alert2;
UIAlertView  *alert1;

- (void)viewDidLoad {
	[super viewDidLoad];
	fbAgent = [[FacebookAgent alloc] initWithApiKey:@"a561e5453051ab0a530cbeab94601829"  
                                          ApiSecret:@"e2c24a7d2cfee0caf8b1e00b84fb2d07"  
										   ApiProxy:nil];
	fbAgent.delegate = self;
}

-(IBAction)launchFacebook:(id)sender{
	fbAgent.shouldResumeSession =YES;
	NSString *userMessage = [NSString stringWithFormat:@"Post a message with Top Dawg:"];
	NSString *message = [NSString stringWithFormat:@"I've just discovered %@ with Top Dawg! http://tinyurl.com/ydtnh6o", name];
	[fbAgent publishFeedWithName:message 
					 captionText:@""
						imageurl:dogNumber
						 linkurl:@"http://tinyurl.com/ydtnh6o"
			   userMessagePrompt:userMessage 
					 actionLabel:nil
					  actionText:nil
					  actionLink:nil];
	
}
- (void) facebookAgent:(FacebookAgent*)agent requestFailed:(NSString*) message{
	fbAgent.shouldResumeSession = NO;
}

- (void) facebookAgent:(FacebookAgent*)agent statusChanged:(BOOL) success{
	fbAgent.shouldResumeSession = NO;
}

- (void) facebookAgent:(FacebookAgent*)agent loginStatus:(BOOL) loggedIn{
	fbAgent.shouldResumeSession = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
	
}
-(IBAction)sendSMS: (id) sender{
	struct utsname systemInfo;
    uname(&systemInfo);
    NSString *platform = [NSString stringWithCString:systemInfo.machine
											encoding:NSUTF8StringEncoding];
	if ([platform isEqualToString:@"iPod1,1"] || [platform isEqualToString:@"iPod2,1"] || [platform isEqualToString:@"i386"]){
		UIAlertView *alert;
		alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"This device does not support this function."
										  delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
		[alert show];
	}
	else{
	alert1;
	alert1 = [[UIAlertView alloc] initWithTitle:@"Share by SMS" message:@"Sharing via SMS will copy the share message to the clipboard and take you to the iPhone text app. Once there, hold your finger down in the textbox to paste the message."
									  delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Share", nil];
	[alert1 show];
	[alert1 release];
	}
}

-(void) sms{
	UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
	NSString *message = [NSString stringWithFormat:@"I've just discovered %@ with Top Dawg! http://tinyurl.com/ydtnh6o", name];
	pasteboard.string = message;
	
	NSString *stringURL = @"sms:// ";
	NSURL *urlSMS = [NSURL URLWithString:stringURL];
	[[UIApplication sharedApplication] openURL:urlSMS];
	
}

-(void) twitterPost{
	TwitterRequest *twitterRequest = [[TwitterRequest alloc] init];
	twitterRequest.username = [NSString stringWithFormat:@"%@", [textFieldName text]];
	twitterRequest.password = [NSString stringWithFormat:@"%@", [textFieldPassword text]];
	[textFieldName resignFirstResponder];
	[textFieldPassword resignFirstResponder];
	
	NSString *twitterMessage = [NSString stringWithFormat:@"I've just discovered %@ with Top Dawg! http://tinyurl.com/ydtnh6o", name];
	
	loadingActionSheet = [[UIActionSheet alloc] initWithTitle:@"Posting To Twitter..." delegate:nil 
											cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:nil];
	
	
	[loadingActionSheet showInView:self.view];
	[twitterRequest statuses_update:twitterMessage delegate:self requestSelector:@selector(viewDidUnload)];
	[NSTimer scheduledTimerWithTimeInterval:2.0f
									 target:self
								   selector:@selector (status_updateCallback:)
								   userInfo:nil
									repeats:NO];
}

-(IBAction)cancel: (id) sender{
	self.tabBarController.selectedIndex = 0;
	[self.tabBarController.selectedViewController viewDidAppear:YES];
	[self.navigationController popToRootViewControllerAnimated:YES];
}

-(IBAction)postTweet:(id) sender{
	NSString *twitter = [NSString stringWithFormat:@"I've just discovered %@ with Top Dawg", name];
	alert2 = [[UIAlertView alloc] 
			  initWithTitle:twitter 
			  message:@"                                              Enter Twitter info to log in. "
			  delegate:self
			  cancelButtonTitle:@"Cancel"
			  otherButtonTitles:@"Post", nil];
	alert2.frame = CGRectMake( 0, 0, 300, 260);
    textFieldName = [[UITextField alloc] initWithFrame:CGRectMake(20.0, 65.0, 240.0, 25.0)];
    [textFieldName setBackgroundColor:[UIColor whiteColor]];
    textFieldName.placeholder = @"Enter Twitter username";
    textFieldName.borderStyle = UITextBorderStyleRoundedRect;
    textFieldName.backgroundColor = [UIColor blackColor];
	textFieldName.clearButtonMode = UITextFieldViewModeWhileEditing;
	textFieldName.keyboardType = UIKeyboardTypeAlphabet;
	textFieldName.keyboardAppearance = UIKeyboardAppearanceAlert;
	textFieldName.autocapitalizationType = UITextAutocapitalizationTypeWords;
	textFieldName.autocorrectionType = UITextAutocorrectionTypeNo;
	
	textFieldPassword = [[UITextField alloc] initWithFrame:CGRectMake(20.0, 90.0, 240.0, 25.0)];
    [textFieldPassword setBackgroundColor:[UIColor whiteColor]];
    textFieldPassword.placeholder = @"Enter Twitter password";
	textFieldPassword.borderStyle = UITextBorderStyleRoundedRect;
    textFieldPassword.backgroundColor = [UIColor blackColor];
	textFieldPassword.clearButtonMode = UITextFieldViewModeWhileEditing;
	textFieldPassword.keyboardType = UIKeyboardTypeAlphabet;
	textFieldPassword.keyboardAppearance = UIKeyboardAppearanceAlert;
	textFieldPassword.autocapitalizationType = UITextAutocapitalizationTypeNone;
	textFieldPassword.autocorrectionType = UITextAutocorrectionTypeNo;
	textFieldPassword.secureTextEntry = YES;
	
    textFieldName.tag = 1;
	textFieldPassword.tag = 2;
    [alert2 addSubview:textFieldName];
	[alert2 addSubview:textFieldPassword];
	[alert2 setAutoresizingMask:UIViewAutoresizingNone];
    CGAffineTransform myTransform = CGAffineTransformMakeTranslation(0.0, 0.0);
    [alert2 setTransform:myTransform];
	
	[alert2 show];
	[alert2 release];

}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex { 
	if(alertView == alert1){
		switch(buttonIndex) {
			case 0:
				break;
			case 1:
				[self sms];
				break;
			default:
				break;
		}
		
	}
	if(alertView == alert2){
		switch(buttonIndex) {
			case 0:
				break;
			case 1:
				[self twitterPost];
			break;
			default:
				break;
		}
	}
}

-(void) status_updateCallback: (NSData *) content{
	[loadingActionSheet dismissWithClickedButtonIndex:0	animated:YES];
	[loadingActionSheet release];
}

-(IBAction)showPicker:(id)sender{	
	Class mailClass = (NSClassFromString(@"MFMailComposeViewController"));
	if (mailClass != nil){
		if ([mailClass canSendMail]){
			[self displayComposerSheet];
		}
		else{
			UIAlertView *alert;
			alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"This device does not support this function."
											  delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
			[alert show];
		}
	}
	else{
		UIAlertView *alert;
		alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"This device does not support this function."
										  delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
		[alert show];
	}
}

-(void)displayComposerSheet {
	MFMailComposeViewController *picker = [[MFMailComposeViewController alloc] init];
	picker.mailComposeDelegate = self;
	
	[picker setSubject:@"Top Dawg Alert!"];
	NSString *emailBody = [NSString stringWithFormat:@"<html>I've just discovered %@ using Top Dawg! Don't have Top Dawg for iPhone? Go here: <a href='http://tinyurl.com/ydtnh6o'>http://tinyurl.com/ydtnh6o</a></html>", name];

	
	[picker setMessageBody:emailBody isHTML:YES];
	[picker addAttachmentData:self.image mimeType:@"image/png" fileName:@"icon"];
	
	[self presentModalViewController:picker animated:YES];
    [picker release];
}


- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error {	
	[self dismissModalViewControllerAnimated:YES];
}


-(void)launchMailAppOnDevice{
	NSString *recipients = @"&subject=A dog pic from Top Dawg!";
	NSString *body = @"&body=A dog pic from Top Dawg!";
	
	NSString *email = [NSString stringWithFormat:@"%@%@", recipients, body];
	email = [email stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
	
	[[UIApplication sharedApplication] openURL:[NSURL URLWithString:email]];
}


- (void)viewDidUnload {
	self.image = nil;
}

- (void)dealloc {
    [image release];
	[super dealloc];
}

@end