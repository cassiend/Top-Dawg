#import "RootViewImage2.h"
#import "RootViewController.h"
#import "Share.h"
#import "Utilities.h"
#import "NetworkError.h"

@implementation RootViewImage2

@synthesize imageView, bar;
@synthesize number, dogLabel, dogNumber, totalNumber, scoreLabel, leftArrow, rightArrow, leftArrow2, rightArrow2;
@synthesize data2, dataItem2, myActivityIndicator;

- (void)loadView{
	[super loadView];
	
	CGRect frame = CGRectMake(135, 175, 40, 40);
	self.myActivityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
	[self.myActivityIndicator setFrame:frame];
	[self.view addSubview:self.myActivityIndicator];
	[self connectionMonth];
	
	dogNumber = 0;
		[self connectionMonth];
	Utilities *myCacheObject = [[Utilities alloc] init];
	UIImage *image = [myCacheObject getCachedImage:[self.dataItem2 objectForKey:@"Icon"] cacheName:[self.dataItem2 objectForKey:@"ID"]];
	imageView.image = image;
	
	NSString *nameOfDog = [self.dataItem2 objectForKey:@"Name"];
	dogLabel.text = [NSString stringWithFormat:@"%@ ", nameOfDog];
	
	NSString *scoreOfDog = [self.dataItem2 objectForKey:@"Score"];
	scoreLabel.text = [NSString stringWithFormat:@"Score: %@ ", scoreOfDog];
	
	UIBarButtonItem * shareButton = [[UIBarButtonItem alloc] initWithTitle:@"Share" style:UIBarButtonItemStyleBordered target:self action:@selector(share)];
	[self.navigationItem setRightBarButtonItem:shareButton animated:YES];
	[shareButton release];
	self.hidesBottomBarWhenPushed = YES;
}	

-(BOOL) connectionMonth{
	
	NSURL *url = [[NSURL alloc] initWithString:@"http://www.topdawgcontest.com/Month.plist"];
	NSURLRequest *theRequest=[NSURLRequest requestWithURL:url
                                              cachePolicy:NSURLRequestUseProtocolCachePolicy
                                          timeoutInterval:60.0];
	NSURLConnection *theConnection=[[NSURLConnection alloc] initWithRequest:theRequest delegate:self];
	
	if (theConnection){
		NSArray *data = [NSArray arrayWithContentsOfURL:url];
		NSDictionary *dataItem = [data objectAtIndex:number];
		NSString *monthDog = [dataItem objectForKey:@"Month"];
		NSString *dateDog = [dataItem objectForKey:@"Date"];
		NSString *urlPlist = [NSString stringWithFormat:@"http://www.topdawgcontest.com/monthdog.php?date=%@&post=submit", dateDog];	
		
		NSURL *urlPlist2 = [[NSURL alloc] initWithString:urlPlist];
		NSURLRequest *theRequest2=[NSURLRequest requestWithURL:urlPlist2
												   cachePolicy:NSURLRequestUseProtocolCachePolicy
											   timeoutInterval:60.0];
		NSURLConnection *theConnection2=[[NSURLConnection alloc] initWithRequest:theRequest2 delegate:self];
		
		if (theConnection2){
			NSString *monthURL = [NSString stringWithFormat:@"http://www.topdawgcontest.com/%@.plist", monthDog];
			
			NSURL *url2 = [[NSURL alloc] initWithString:monthURL];
			self.data2 = [NSArray arrayWithContentsOfURL:url2];
			if (self.data2 != nil) {
				NSInteger size =  [self.data2 count];
				NSString *total = [NSString stringWithFormat:@"%d/%d", dogNumber+1, size];
				totalNumber.text = total;
				self.dataItem2 = [self.data2 objectAtIndex:dogNumber];
				if (self.dataItem2 != nil) {
					return TRUE;
				}
				[self.myActivityIndicator stopAnimating];
				return FALSE;
			}
			else {
				[self.myActivityIndicator stopAnimating];
				return FALSE;
			}
			
		}
		else {
			[self.myActivityIndicator stopAnimating];
			return FALSE;
		}
		
	}
	else {
		[self.myActivityIndicator stopAnimating];
		return FALSE;
	}
	
}

-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse*)response{
}

-(void)connectionDidFinishLoading:(NSURLConnection*)connection{
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
	NetworkError *imageNetwork = [[NetworkError alloc] initWithNibName:@"NetworkError" bundle:nil];
	imageNetwork.title = @"Top Dawg";
	[[self navigationController] pushViewController:imageNetwork animated:NO];
	[imageNetwork release];
	
}

- (void) share
{
	Share *share= [[Share alloc] initWithNibName:@"Share" bundle:nil];
	[self connectionMonth];	
	share.image = [NSData dataWithContentsOfURL:[NSURL URLWithString:[self.dataItem2 objectForKey:@"Icon"]]];
	share.name = [self.dataItem2 objectForKey:@"Name"];
	share.dogNumber = [self.dataItem2 objectForKey:@"Icon"];
	
	[[self navigationController] pushViewController:share animated:YES];
	
	UIBarButtonItem *temporaryBarButtonItem = [[UIBarButtonItem alloc] init];
	temporaryBarButtonItem.title = @"Back";
	self.navigationItem.backBarButtonItem = temporaryBarButtonItem;
	[temporaryBarButtonItem release];
}

- (IBAction)moveForward:(id)sender{
	[NSThread detachNewThreadSelector:@selector(myIndicator) toTarget:self withObject:nil]; 
	if ([self connectionMonth]) {

	NSInteger dogNumberCount =  [self.data2 count];
	if(dogNumber < dogNumberCount-1){
		dogNumber = dogNumber+1;
		[self showDogImage];
	}
	else{
		dogNumber = 0;
		[self showDogImage];
	}
	[self.myActivityIndicator stopAnimating];
	}
}

- (IBAction)moveBackward:(id)sender{
	[NSThread detachNewThreadSelector:@selector(myIndicator) toTarget:self withObject:nil]; 
	if ([self connectionMonth]) {
		NSInteger dogNumberCount =  [self.data2 count];
		if(dogNumber >= 1){
			dogNumber = dogNumber-1;
			[self showDogImage];
		}
		else{
			dogNumber = dogNumberCount-1;
			[self showDogImage];
		}
	[self.myActivityIndicator stopAnimating];
	}	
}

-(void) showDogImage{
	NSInteger dogNumberCount =  [self.data2 count];
	Utilities *myCacheObject = [[Utilities alloc] init];
	UIImage *image = [myCacheObject getCachedImage:[self.dataItem2 objectForKey:@"Icon"] cacheName:[self.dataItem2 objectForKey:@"ID"]];
	imageView.image = image;
	
	NSString *total = [NSString stringWithFormat:@"%d/%d", dogNumber+1, dogNumberCount];
	totalNumber.text = total;
	
	NSString *nameOfDog = [self.dataItem2 objectForKey:@"Name"];
	dogLabel.text = [NSString stringWithFormat:@"%@ ", nameOfDog];
	
	NSString *scoreOfDog = [self.dataItem2 objectForKey:@"Score"];
	scoreLabel.text = [NSString stringWithFormat:@"Score: %@ ", scoreOfDog];
}

- (void)myIndicator{ 
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
	[self.myActivityIndicator startAnimating];
	[pool release]; 
}

- (void)viewDidUnload {
	self.totalNumber = nil;
	self.scoreLabel = nil;
    self.imageView = nil;
	self.bar = nil;
	self.dogLabel = nil;
	[super viewDidUnload];
}


- (void)dealloc {
	[dataItem2 release];
	[data2 release];
	[scoreLabel release];
	[totalNumber release];
	[bar release];
	[dogLabel release];
    [imageView release];
    [super dealloc];
}


@end