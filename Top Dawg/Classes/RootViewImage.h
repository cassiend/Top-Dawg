@interface RootViewImage : UIViewController{
	UIImageView *imageView;
	UIToolbar *bar;
	NSInteger number, dogNumber;
	UILabel *dogLabel, *totalNumber;
	UIImageView *five, *four, *three, *two, *one;
	NSDictionary *dataItem2;
	NSArray *data2;
	NSMutableDictionary *myDictionary;
	UIBarButtonItem *oneButton, *twoButton, *threeButton, *fourButton, *fiveButton;
	UIButton *leftArrow, *rightArrow, *leftArrow2, *rightArrow2;
	UIActivityIndicatorView *myActivityIndicator;
}

@property(nonatomic, retain) IBOutlet UIImageView *imageView, *five, *four, *three, *two, *one;
@property(nonatomic, retain) IBOutlet UIToolbar *bar;
@property(nonatomic, retain) IBOutlet UILabel *dogLabel,*totalNumber;
@property(nonatomic, assign) NSInteger number, dogNumber;
@property(nonatomic, retain) NSDictionary *dataItem2;
@property(nonatomic, retain) NSArray *data2;
@property(nonatomic, retain) NSMutableDictionary *myDictionary;
@property(nonatomic, retain) IBOutlet UIBarButtonItem *fiveButton, *fourButton, *threeButton, *twoButton, *oneButton;
@property(nonatomic, retain) IBOutlet UIButton *leftArrow, *rightArrow, *leftArrow2, *rightArrow2;
@property (nonatomic, retain) UIActivityIndicatorView *myActivityIndicator;



- (void) share;	
- (void) duplicates: (NSString *) IDdog;
- (void) disableRating;
- (void) enableRating;
- (BOOL) connectionMonth;
- (void) showDogImage;
- (void) showNoStars;
- (void) showOneStar;
- (void) showFourStars;
- (void) showTwoStars;
- (void) showFiveStars;
- (void) showThreeStars;
- (IBAction)moveForward:(id)sender;	
- (IBAction)moveBackward:(id)sender;	
- (IBAction)rateFive:(id)sender;
- (IBAction)rateFour:(id)sender;
- (IBAction)rateThree:(id)sender;
- (IBAction)rateTwo:(id)sender;
- (IBAction)rateOne:(id)sender;

@end
