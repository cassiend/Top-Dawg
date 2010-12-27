#import "Top20Image.h"
#import "Top20.h"
#import "Utilities.h"

@implementation Top20Image

@synthesize imageView, bar;
@synthesize number, dogLabel;

- (void)loadView {
	[super loadView];
	
	NSURL *url = [[NSURL alloc] initWithString:@"http://www.topdawgcontest.com/Top20.plist"];
	NSURLRequest *theRequest=[NSURLRequest requestWithURL:url
												   cachePolicy:NSURLRequestUseProtocolCachePolicy
											   timeoutInterval:60.0];
	NSURLConnection *theConnection=[[NSURLConnection alloc] initWithRequest:theRequest delegate:self];
	if(theConnection){
		NSArray *data = [NSArray arrayWithContentsOfURL:url];
		NSDictionary *dataItem = [data objectAtIndex:number];
		Utilities *myCacheObject = [[Utilities alloc] init];
		UIImage *image = [myCacheObject getCachedImage:[dataItem objectForKey:@"Icon"] cacheName:[dataItem objectForKey:@"ID"]];
		imageView.image = image;
		
		NSString *nameOfDog = [dataItem objectForKey:@"Name"];
		dogLabel.text = nameOfDog;
	}
	else{
		UIAlertView *alert;
		alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Network Timed Out."
											delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
		[alert show];
	}
}	

- (void)viewDidUnload {
    self.imageView = nil;
	self.bar = nil;
	self.dogLabel = nil;
	[super viewDidUnload];
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}


- (void)dealloc {
	[bar release];
	[dogLabel release];
    [imageView release];
    [super dealloc];
}


@end

