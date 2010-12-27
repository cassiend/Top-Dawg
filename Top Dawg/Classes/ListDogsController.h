@interface ListDogsController : UIViewController 
{
	IBOutlet UIScrollView *scrollView;
	NSArray *listofImages;
	NSDictionary *dataItem;
//	NSString *month;
//	NSUInteger kNumImages;
}

@property (nonatomic, retain) UIView *scrollView;
@property (nonatomic, retain) NSArray *listofImages;
@property (nonatomic, retain) NSDictionary *dataItem;
//@property (nonatomic, retain) NSString *month;
//@property (nonatomic, assign) NSUInteger kNumImages;
@end
