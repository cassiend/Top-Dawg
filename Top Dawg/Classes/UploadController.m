#import "UploadController.h"
#import "Thanks.h"
#import "UploadError.h"
#import <sys/utsname.h>

@implementation UploadController

@synthesize imgPicker, dogNameText, emailText, myActivityIndicator;

- (void)viewDidLoad {
	[super viewDidLoad];
	dogNameText.text = nil;
	dogNameText.adjustsFontSizeToFitWidth = YES;
	emailText.adjustsFontSizeToFitWidth = YES;
	
	emailText.text = nil;
	self.imgPicker = [[UIImagePickerController alloc] init];
	self.imgPicker.allowsEditing = YES;
	self.imgPicker.delegate = self;	
	
	CGRect frame = CGRectMake(135, 240, 40, 40);
	self.myActivityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
	[self.myActivityIndicator setFrame:frame];
	[(UIWindow *)([[UIApplication sharedApplication].windows objectAtIndex:0]) addSubview:self.myActivityIndicator];
}

- (IBAction)grabImage {
	self.imgPicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
	[self presentModalViewController:self.imgPicker animated:YES];

}

- (IBAction)takeImage {
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
		self.imgPicker.sourceType = UIImagePickerControllerSourceTypeCamera;
		[self presentModalViewController:self.imgPicker animated:YES];
	}
	
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
	[emailText resignFirstResponder];
	[dogNameText resignFirstResponder];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
	[dogNameText resignFirstResponder];
	[emailText resignFirstResponder];
	return YES;
}


-(IBAction)cancel{
	dogNameText.text = nil;
	emailText.text = nil;
	image.image = [UIImage imageNamed:@"Submission.png"];
}

- (IBAction)uploadImage {
	[NSThread detachNewThreadSelector:@selector(myIndicator) toTarget:self withObject:nil]; 
	NSString *dogName = dogNameText.text;
	NSString *email = emailText.text;
	NSData *imageData = UIImageJPEGRepresentation(image.image, 90);

	if (dogNameText.text != nil && emailText.text != nil){
		if (image.image != [UIImage imageNamed:@"Submission.png"]){
			if (!(([email rangeOfString:@"@"].location != NSNotFound) && ([email rangeOfString:@"."].location != NSNotFound))){
				UIAlertView *alert;
				alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Enter a valid email address."
												  delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
				[alert show];
				[self.myActivityIndicator stopAnimating];
			}
			else{				
				NSString *urlString = @"http://www.topdawgcontest.com/addtempdog.php";
	
				NSMutableURLRequest *request = [[[NSMutableURLRequest alloc] init] autorelease];
				[request setURL:[NSURL URLWithString:urlString]];
				[request setHTTPMethod:@"POST"];

				NSString *submit = @"Submit";
				NSString *boundary = [NSString stringWithString:@"---------------------------14737809831466499882746641449"];
				NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@",boundary];
				[request addValue:contentType forHTTPHeaderField: @"Content-Type"];
	
				NSMutableData *body = [NSMutableData data];
				[body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];	
				[body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"NameOfDog\"\r\n\r\n%@", dogName]dataUsingEncoding:NSUTF8StringEncoding]];
				[body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];	
				[body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"Email\"\r\n\r\n%@", email]dataUsingEncoding:NSUTF8StringEncoding]];
				[body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
				[body appendData:[[NSString stringWithString:@"Content-Disposition: form-data; name=\"image\"; filename=\"ipodfile.jpg\"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
				[body appendData:[[NSString stringWithString:@"Content-Type: application/octet-stream\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
				[body appendData:[NSData dataWithData:imageData]];
				[body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];	
				[body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"Submit\"\r\n\r\n%@", submit]dataUsingEncoding:NSUTF8StringEncoding]];
				[body appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];

				[request setHTTPBody:body];
	
				NSData *returnData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
				
				if (returnData == nil){
				UploadError *imageUpload = [[UploadError alloc] initWithNibName:@"UploadError" bundle:nil];
				imageUpload.title = @"Top Dawg";
				
				[[self navigationController] pushViewController:imageUpload animated:YES];
				[imageUpload release];
				}
				else{
					Thanks *imageThanks = [[Thanks alloc] initWithNibName:@"Thanks" bundle:nil];
					imageThanks.title = @"Top Dawg";
					
					[[self navigationController] pushViewController:imageThanks animated:YES];
					[imageThanks release];
				}
				[self.myActivityIndicator stopAnimating];
				dogNameText.text = nil;
				emailText.text = nil;
				image.image = [UIImage imageNamed:@"Submission.png"];
			}
		}
		else{
			UIAlertView *alert;
			alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Need to upload an image."
											  delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
			[alert show];
			[self.myActivityIndicator stopAnimating];
		}
	}
	else{
		UIAlertView *alert;
		alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Need to fill in required fields."
											  delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
		[alert show];
		[self.myActivityIndicator stopAnimating];

	}
}


- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)img editingInfo:(NSDictionary *)editInfo {
	image.image = img;	
	[[picker parentViewController] dismissModalViewControllerAnimated:YES];
	upload.hidden = NO;
}

- (void)myIndicator{ 
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
	[self.myActivityIndicator startAnimating];
	[pool release]; 
} 

- (void)viewDidUnload {
	myActivityIndicator = nil;
	imgPicker = nil;
	emailText = nil;
	dogNameText = nil;
}


- (void)dealloc {
	[myActivityIndicator release];
	[dogNameText release];
    [imgPicker release];
	[emailText release];
	[super dealloc];
}
@end