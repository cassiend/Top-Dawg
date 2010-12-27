#import "RootViewController.h"
#import "RootViewImage.h"
#import "RootViewImage2.h"
#import "Utilities.h"
#import "NetworkError.h"
#import "FBConnect.h"

#define DARK_BACKGROUND  [UIColor colorWithRed:151.0/255.0 green:152.0/255.0 blue:155.0/255.0 alpha:0.0]


@implementation RootViewController

@synthesize tmpCell, data, iconimage, myActivityIndicator, myDictionary;


- (void)viewDidLoad{
	[super viewDidLoad];
	self.tableView.rowHeight = 100.0;
	self.tableView.backgroundColor = DARK_BACKGROUND;
	self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;

	CGRect frame = CGRectMake(135, 240, 40, 40);
	self.myActivityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
	[self.myActivityIndicator setFrame:frame];
	[(UIWindow *)([[UIApplication sharedApplication].windows objectAtIndex:0]) addSubview:self.myActivityIndicator];
	
	self.myDictionary = [NSMutableDictionary dictionary];
	NSString *urlString = @"http://www.topdawgcontest.com/topmonthdog.php";
	NSURL *url2 = [[NSURL alloc] initWithString:urlString];
	NSURLRequest *theRequest=[NSURLRequest requestWithURL:url2
											  cachePolicy:NSURLRequestUseProtocolCachePolicy
										  timeoutInterval:30.0];
	NSURLConnection *theConnection=[[NSURLConnection alloc] initWithRequest:theRequest delegate:self];

	if (theConnection){
		NSURL *url = [[NSURL alloc] initWithString:@"http://www.topdawgcontest.com/Month.plist"];
		NSURLRequest *theRequest2=[NSURLRequest requestWithURL:url
												  cachePolicy:NSURLRequestUseProtocolCachePolicy
											  timeoutInterval:60.0];
		NSURLConnection *theConnection2=[[NSURLConnection alloc] initWithRequest:theRequest2 delegate:self];
		if(theConnection2 != nil){
			self.data = [NSArray arrayWithContentsOfURL:url];
		}
	}
	
	UIBarButtonItem *temporaryBarButtonItem = [[UIBarButtonItem alloc] init];
	temporaryBarButtonItem.title = @"Back";
	self.navigationItem.backBarButtonItem = temporaryBarButtonItem;
	[temporaryBarButtonItem release];
}


- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
	NetworkError *imageNetwork = [[NetworkError alloc] initWithNibName:@"NetworkError" bundle:nil];
	imageNetwork.title = @"Top Dawg";
	[[self navigationController] pushViewController:imageNetwork animated:NO];
	[imageNetwork release];	
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
	return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
	return [data count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
	static NSString *CellIdentifier = @"ApplicationCell";
	
	ApplicationCell *cell = (ApplicationCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	
	if (cell == nil) {
		
		[[NSBundle mainBundle] loadNibNamed:@"IndividualSubviewsBasedApplicationCell" owner:self options:nil];
		cell = tmpCell;
		self.tmpCell = nil;
	}
	
	NSDictionary *dataItem2 = [self.data objectAtIndex:indexPath.row];
	
	Utilities *myCacheObject = [[Utilities alloc] init];
	NSString *dogCacheName = [NSString stringWithFormat:@"Cache%@", [dataItem2 objectForKey:@"ID"]];
	UIImage *image = [myCacheObject getCachedImage:[dataItem2 objectForKey:@"Icon"] cacheName:dogCacheName];
	cell.icon = image;
	cell.month = [dataItem2 objectForKey:@"Month"];
	cell.name = [dataItem2 objectForKey:@"Name"];
	cell.score = [[dataItem2 objectForKey:@"Score"] intValue];
	cell.submission = [[dataItem2 objectForKey:@"Submission"] intValue];

	return cell;
	[dataItem2 release];
}


- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
	UIView *cellBack = [[[UIView alloc] init] autorelease];
	cellBack.backgroundColor = [UIColor clearColor];
	cell.selectedBackgroundView = cellBack;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {	
	[NSThread detachNewThreadSelector:@selector(myIndicator) toTarget:self withObject:nil]; 
	if(indexPath.row == 0){
		RootViewImage *imageRoot = [[RootViewImage alloc] initWithNibName:@"ListDogImages" bundle:nil];
		
		imageRoot.title = @"Top Dawg";
		self.hidesBottomBarWhenPushed = YES;
		imageRoot.number = (NSInteger)indexPath.row;
		imageRoot.myDictionary = self.myDictionary;
		[[self navigationController] pushViewController:imageRoot animated:YES];
		
		self.hidesBottomBarWhenPushed = NO;
		[self.myActivityIndicator stopAnimating];
	}
	else{
		RootViewImage2 *imageRoot2 = [[RootViewImage2 alloc] initWithNibName:@"ListDogImages2" bundle:nil];
		
		imageRoot2.title = @"Top Dawg";
		self.hidesBottomBarWhenPushed = YES;
		
		imageRoot2.number = (NSInteger)indexPath.row;
		[[self navigationController] pushViewController:imageRoot2 animated:YES];

		self.hidesBottomBarWhenPushed = NO;
		[self.myActivityIndicator stopAnimating];
	}
}

- (void)myIndicator { 
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
	[self.myActivityIndicator startAnimating];
	[pool release]; 
} 

- (void)dealloc {
	[myDictionary release];
	[myActivityIndicator release];
	[iconimage release];
	[data release];
	[super dealloc];
}

@end

