#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface UploadController : UIViewController <UINavigationControllerDelegate, UIImagePickerControllerDelegate> {
    IBOutlet UIButton *button;
	IBOutlet UIButton *cancelButton;
	IBOutlet UITextField *dogNameText;
	IBOutlet UITextField *emailText;
	IBOutlet UIButton *upload;
    IBOutlet UIImageView *image;
	UIImagePickerController *imgPicker;
	UIActivityIndicatorView *myActivityIndicator;
}
- (IBAction)grabImage;
- (IBAction)takeImage;
- (IBAction)uploadImage;
- (IBAction)cancel;

@property (nonatomic, assign) UIImagePickerController *imgPicker;
@property(nonatomic, retain) IBOutlet UITextField *dogNameText;
@property (nonatomic, retain) UIActivityIndicatorView *myActivityIndicator;
@property(nonatomic, retain) IBOutlet UITextField *emailText;
@end