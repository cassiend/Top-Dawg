@interface Top20Image : UIViewController{
	UIImageView *imageView;
	UIToolbar *bar;
	NSInteger number;
	UILabel *dogLabel;
}

@property(nonatomic, retain) IBOutlet UIImageView *imageView;
@property(nonatomic, retain) IBOutlet UIToolbar *bar;
@property(nonatomic, retain) IBOutlet UILabel *dogLabel;
@property(nonatomic, assign) NSInteger number;

@end

