@interface RootViewImage2 : UIViewController
{
	UIImageView *imageView;
	UIToolbar *bar;
	NSInteger number, dogNumber;
	UILabel *dogLabel, *totalNumber, *scoreLabel;
	NSDictionary *dataItem2;
	NSArray *data2;
	UIButton  *leftArrow, *rightArrow, *leftArrow2, *rightArrow2;
	UIActivityIndicatorView *myActivityIndicator;
}

@property(nonatomic, retain) IBOutlet UIImageView *imageView;
@property(nonatomic, retain) IBOutlet UIToolbar *bar;
@property(nonatomic, retain) IBOutlet UILabel *dogLabel, *scoreLabel, *totalNumber;
@property(nonatomic, assign) NSInteger number, dogNumber;
@property(nonatomic, retain) NSDictionary *dataItem2;
@property(nonatomic, retain) NSArray *data2;
@property(nonatomic, retain) IBOutlet UIButton *leftArrow, *rightArrow, *leftArrow2, *rightArrow2;
@property (nonatomic, retain) UIActivityIndicatorView *myActivityIndicator;

- (BOOL) connectionMonth;
- (void) share;
- (void) showDogImage;
- (IBAction)moveForward:(id)sender;	
- (IBAction)moveBackward:(id)sender;

@end