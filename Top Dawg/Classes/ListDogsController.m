#import "ListDogsController.h"

@implementation ListDogsController

@synthesize scrollView, listofImages;

const CGFloat kScrollObjHeight	= 460.0;
const CGFloat kScrollObjWidth	= 320.0;
const NSUInteger kNumImages		= 2;


- (void)layoutScrollImages
{
	UIImageView *view = nil;
	NSArray *subviews = [scrollView subviews];
	
	// reposition all image subviews in a horizontal serial fashion
	CGFloat curXLoc = 0;
	for (view in subviews)
	{
		if ([view isKindOfClass:[UIImageView class]] && view.tag > 0)
		{
			CGRect frame = view.frame;
			frame.origin = CGPointMake(curXLoc, 0);
			view.frame = frame;
			
			curXLoc += (kScrollObjWidth);
		}
	}
	
	// set the content size so it can be scrollable
	[scrollView setContentSize:CGSizeMake((kNumImages * kScrollObjWidth), [scrollView bounds].size.height)];
}

- (void)viewDidLoad
{
//	NSString *monthDog = [[NSString alloc] initWithString:self.month];
//	NSString *dogURL1 = [@"http://fjptkqaa.joyent.us/" stringByAppendingString:monthDog];
//	NSString* dogURL = [dogURL1 stringByAppendingString: @".plist"];
	
	//self.kNumImages = listofImages.count;
	self.view.backgroundColor = [UIColor viewFlipsideBackgroundColor];
	
	[scrollView setBackgroundColor:[UIColor blackColor]];
	[scrollView setCanCancelContentTouches:NO];
	scrollView.indicatorStyle = UIScrollViewIndicatorStyleWhite;
	scrollView.clipsToBounds = YES;
	scrollView.scrollEnabled = YES;
	
	scrollView.pagingEnabled = YES;
	
	NSString *dataPath = [[NSBundle mainBundle] pathForResource:@"Data" ofType:@"plist"];
	self.listofImages = [NSArray arrayWithContentsOfFile:dataPath];
	
//	NSURL *url = [[NSURL alloc] initWithString:@"http://fjptkqaa.joyent.us/October.plist"];	
//	self.listofImages = [NSArray arrayWithContentsOfURL:url];
	NSUInteger i;
	for (i = 1; i <= kNumImages; i++)
	{
		self.dataItem = [listofImages objectAtIndex:i];
	//	NSString *imageName = [NSString stringWithFormat:@"image%d.jpg", i];
		
	//	UIImage *image = [[UIImage alloc] initWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[dataItem objectForKey:@"Icon"]]]];
	//	UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
	//	UIImage *image = [UIImage imageNamed:imageName];
		UIImageView *imageView = [[UIImageView alloc] initWithImage:[[UIImage alloc] initWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[dataItem objectForKey:@"Icon"]]]]];
		
		// setup each frame to a default height and width, it will be properly placed when we call "updateScrollList"
		CGRect rect = imageView.frame;
		rect.size.height = kScrollObjHeight;
		rect.size.width = kScrollObjWidth;
		imageView.frame = rect;
		imageView.tag = i;	// tag our images for later use when we place them in serial fashion
		[scrollView addSubview:imageView];
		[imageView release];
	}
	[self layoutScrollImages];
}

- (void)dealloc
{	
	[listofImages release];
	[dataItem release];
	//[month release];

	[scrollView release];
	
	[super dealloc];
}

- (void)didReceiveMemoryWarning
{
	[super didReceiveMemoryWarning];
}

@end