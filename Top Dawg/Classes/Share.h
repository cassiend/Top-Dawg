#import <UIKit/UIKit.h>
#import "FacebookAgent.h"
#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMailComposeViewController.h>
#import "TwitterRequest.h";

@interface Share: UIViewController <MFMailComposeViewControllerDelegate, FacebookAgentDelegate>{
	UIButton *updateButton;
	UIActionSheet *loadingActionSheet;
	NSData *image;
	NSString *name;
	NSString *dogNumber;
	UITextField *textFieldPassword;
	UITextField *textFieldName;
	FacebookAgent *fbAgent;
}

@property (nonatomic, retain) NSData *image;
@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSString *dogNumber;
@property (nonatomic, retain) UIButton *updateButton;
@property (nonatomic, retain) UITextField *textFieldPassword;
@property (nonatomic, retain) UITextField *textFieldName;

-(IBAction)showPicker:(id)sender;
-(void)displayComposerSheet;
-(void)launchMailAppOnDevice;
-(IBAction)launchFacebook:(id)sender;
-(IBAction)postTweet: (id) sender;
-(IBAction)cancel: (id) sender;
-(IBAction)sendSMS: (id) sender;

@end
