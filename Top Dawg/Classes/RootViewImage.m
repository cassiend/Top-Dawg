#import "RootViewImage.h"
#import "RootViewController.h"
#import "Share.h"
#import "Utilities.h"
#import "NetworkError.h"

@implementation RootViewImage

@synthesize imageView, bar;
@synthesize one, two, three, four, five;
@synthesize oneButton, twoButton, threeButton, fourButton, fiveButton, leftArrow, rightArrow, leftArrow2, rightArrow2;
@synthesize number, dogLabel, dogNumber, totalNumber, dataItem2, data2;
@synthesize myDictionary, myActivityIndicator;

- (void)loadView{
	[super loadView];
	
	CGRect frame = CGRectMake(135, 175, 40, 40);
	self.myActivityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
	[self.myActivityIndicator setFrame:frame];
	[self.view addSubview:self.myActivityIndicator];
	
	dogNumber = 0;
	[self connectionMonth];

	Utilities *myCacheObject = [[Utilities alloc] init];
	UIImage *image = [myCacheObject getCachedImage:[dataItem2 objectForKey:@"Icon"] cacheName:[self.dataItem2 objectForKey:@"ID"]];
	imageView.image = image;
	[self duplicates:[self.dataItem2 objectForKey:@"ID"]];

	NSString *nameOfDog = [dataItem2 objectForKey:@"Name"];
	dogLabel.text = nameOfDog;
	

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

-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
	NetworkError *imageNetwork = [[NetworkError alloc] initWithNibName:@"NetworkError" bundle:nil];
	imageNetwork.title = @"Top Dawg";
	[[self navigationController] pushViewController:imageNetwork animated:NO];
	[imageNetwork release];
	}

- (void)share{
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

- (void) duplicates: (NSString *) IDdog{
	int count2 = [self.myDictionary count];
	NSArray *myArray = [self.myDictionary allKeys];
	if(count2 != 0){
		for (int i = 0; i < count2; i++) { 
			if([[myArray objectAtIndex:i] isEqualToString:IDdog] == YES){
				NSString *rateNumber = [self.myDictionary valueForKey:IDdog];
				if ([rateNumber isEqualToString:@"1"] == YES){
						[self showOneStar];
				}
				else if ([rateNumber isEqualToString:@"2"] == YES){
						[self showTwoStars];
				}
				else if ([rateNumber isEqualToString:@"3"] == YES){
						[self showThreeStars];
				}
				else if ([rateNumber isEqualToString:@"4"] == YES){
						[self showFourStars];
				}
				else if ([rateNumber isEqualToString:@"5"] == YES){
						[self showFiveStars];
				}
				else{
						[self showNoStars];
				}
				[self disableRating];
				break;
			}
			else{
				[self enableRating];
				[self showNoStars];
			}
		}
	}
}

- (void) showOneStar{
	five.hidden =YES;
	four.hidden =YES;
	three.hidden=YES;
	two.hidden =YES;
	one.hidden =NO;
}

- (void) showTwoStars{
	five.hidden =YES;
	four.hidden =YES;
	three.hidden=YES;
	two.hidden =NO;
	one.hidden =NO;
}

- (void) showThreeStars{
	five.hidden =YES;
	four.hidden =YES;
	three.hidden=NO;
	two.hidden =NO;
	one.hidden =NO;
}

- (void) showFourStars{
	five.hidden =YES;
	four.hidden =NO;
	three.hidden=NO;
	two.hidden =NO;
	one.hidden =NO;
}

- (void) showFiveStars{
	five.hidden =NO;
	four.hidden =NO;
	three.hidden=NO;
	two.hidden =NO;
	one.hidden =NO;
}

- (void) showNoStars{
	five.hidden =YES;
	four.hidden =YES;
	three.hidden=YES;
	two.hidden =YES;
	one.hidden =YES;
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
	
	NSInteger totalNumberOfDogs =  [self.data2 count];
	Utilities *myCacheObject = [[Utilities alloc] init];
	UIImage *image = [myCacheObject getCachedImage:[self.dataItem2 objectForKey:@"Icon"] cacheName:[self.dataItem2 objectForKey:@"ID"]];

	imageView.image = image;
	NSString *total = [NSString stringWithFormat:@"%d/%d", dogNumber+1, totalNumberOfDogs];
	totalNumber.text = total;
		
	NSString *nameOfDog = [self.dataItem2 objectForKey:@"Name"];
	dogLabel.text = [NSString stringWithFormat:@"%@ ", nameOfDog];
		
	[self duplicates:[self.dataItem2 objectForKey:@"ID"]];
}

- (void)myIndicator{ 
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
	[self.myActivityIndicator startAnimating];
	[pool release]; 
}


- (void)disableRating{
	[self.fiveButton setEnabled: NO];
	[self.fourButton setEnabled: NO];
	[self.threeButton setEnabled: NO];
	[self.twoButton setEnabled: NO];
	[self.oneButton setEnabled: NO];
}

- (void)enableRating{
	[self.fiveButton setEnabled: YES];
	[self.fourButton setEnabled: YES];
	[self.threeButton setEnabled: YES];
	[self.twoButton setEnabled: YES];
	[self.oneButton setEnabled: YES];
}

-(IBAction)rateFive:(id)sender{	
	NSString *ID = [self.dataItem2 objectForKey:@"ID"];
	NSString *urlPlist = [NSString stringWithFormat:@"http://www.topdawgcontest.com/ratedog.php?rate=5&dog=%@&submit=Rate!", ID];
	NSURL *urlPlist2 = [[NSURL alloc] initWithString:urlPlist];
	NSURLRequest *theRequest=[NSURLRequest requestWithURL:urlPlist2
                                              cachePolicy:NSURLRequestUseProtocolCachePolicy
                                          timeoutInterval:60.0];
	NSURLConnection *theConnection=[[NSURLConnection alloc] initWithRequest:theRequest delegate:self];
	
	if (theConnection) {
		[self.myDictionary  setObject:@"5" forKey:ID]; 
		[self duplicates:[self.dataItem2 objectForKey:@"ID"]];
	}
}

-(IBAction)rateFour:(id)sender{
	NSString *ID = [self.dataItem2 objectForKey:@"ID"];
	NSString *urlPlist = [NSString stringWithFormat:@"http://www.topdawgcontest.com/ratedog.php?rate=4&dog=%@&submit=Rate!", ID];
	NSURL *urlPlist2 = [[NSURL alloc] initWithString:urlPlist];
	NSURLRequest *theRequest=[NSURLRequest requestWithURL:urlPlist2
                                              cachePolicy:NSURLRequestUseProtocolCachePolicy
                                          timeoutInterval:60.0];
	NSURLConnection *theConnection=[[NSURLConnection alloc] initWithRequest:theRequest delegate:self];
	
	if (theConnection) {
		[self.myDictionary  setObject:@"4" forKey:ID]; 
		[self duplicates:[self.dataItem2 objectForKey:@"ID"]];
	}
}

-(IBAction)rateThree:(id)sender{
	NSString *ID = [self.dataItem2 objectForKey:@"ID"];
	NSString *urlPlist = [NSString stringWithFormat:@"http://www.topdawgcontest.com/ratedog.php?rate=3&dog=%@&submit=Rate!", ID];
	NSURL *urlPlist2 = [[NSURL alloc] initWithString:urlPlist];
	NSURLRequest *theRequest=[NSURLRequest requestWithURL:urlPlist2
                                              cachePolicy:NSURLRequestUseProtocolCachePolicy
                                          timeoutInterval:60.0];
	NSURLConnection *theConnection=[[NSURLConnection alloc] initWithRequest:theRequest delegate:self];
	
	if (theConnection) {
		[self.myDictionary  setObject:@"3" forKey:ID]; 
		[self duplicates:[self.dataItem2 objectForKey:@"ID"]];
	}
}

-(IBAction)rateTwo:(id)sender{
	NSString *ID = [self.dataItem2 objectForKey:@"ID"];
	NSString *urlPlist = [NSString stringWithFormat:@"http://www.topdawgcontest.com/ratedog.php?rate=2&dog=%@&submit=Rate!", ID];
	NSURL *urlPlist2 = [[NSURL alloc] initWithString:urlPlist];
	NSURLRequest *theRequest=[NSURLRequest requestWithURL:urlPlist2
                                              cachePolicy:NSURLRequestUseProtocolCachePolicy
                                          timeoutInterval:60.0];
	NSURLConnection *theConnection=[[NSURLConnection alloc] initWithRequest:theRequest delegate:self];
	
	if (theConnection) {
		[self.myDictionary setObject:@"2" forKey:ID]; 
		[self duplicates:[self.dataItem2 objectForKey:@"ID"]];
	} 
}

-(IBAction)rateOne:(id)sender{
	NSString *ID = [self.dataItem2 objectForKey:@"ID"];
	NSString *urlPlist = [NSString stringWithFormat:@"http://www.topdawgcontest.com/ratedog.php?rate=1&dog=%@&submit=Rate!", ID];
	NSURL *urlPlist2 = [[NSURL alloc] initWithString:urlPlist];
	NSURLRequest *theRequest=[NSURLRequest requestWithURL:urlPlist2
                                              cachePolicy:NSURLRequestUseProtocolCachePolicy
                                          timeoutInterval:60.0];
	NSURLConnection *theConnection=[[NSURLConnection alloc] initWithRequest:theRequest delegate:self];
	
	if (theConnection) {
		[self.myDictionary  setObject:@"1" forKey:ID]; 
		[self duplicates:[self.dataItem2 objectForKey:@"ID"]];
	} 
}


- (void)viewDidUnload {
	self.totalNumber = nil;
    self.imageView = nil;
	self.bar = nil;
	self.dogLabel = nil;
	[super viewDidUnload];
}

- (void)dealloc 
{
	[myDictionary release];
	[data2 release];
	[dataItem2 release];
	[totalNumber release];
	[bar release];
	[dogLabel release];
    [imageView release];
    [super dealloc];
}

@end
