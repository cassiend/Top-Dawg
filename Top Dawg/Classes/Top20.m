#import "Top20.h"
#import "Top20Image.h"
#import "NetworkError.h"

#define DARK_BACKGROUND  [UIColor colorWithRed:151.0/255.0 green:152.0/255.0 blue:155.0/255.0 alpha:0.0]


@implementation Top20

@synthesize tmpCell, data, dataItem, dataItem2, myActivityIndicator;

- (void)viewDidLoad
{
	[super viewDidLoad];
    self.tableView.rowHeight = 75.0;
    self.tableView.backgroundColor = DARK_BACKGROUND;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;

	
	CGRect frame = CGRectMake(135, 240, 40, 40);
	self.myActivityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
	[self.myActivityIndicator setFrame:frame];
	[(UIWindow *)([[UIApplication sharedApplication].windows objectAtIndex:0]) addSubview:self.myActivityIndicator];
	
	NSURL *url2 = [[NSURL alloc] initWithString:@"http://www.topdawgcontest.com/listdog.php"];
	NSURLRequest *theRequest=[NSURLRequest requestWithURL:url2
                                              cachePolicy:NSURLRequestUseProtocolCachePolicy
                                          timeoutInterval:60.0];
	NSURLConnection *theConnection=[[NSURLConnection alloc] initWithRequest:theRequest delegate:self];
	
	if (theConnection) {
		NSURL *url = [[NSURL alloc] initWithString:@"http://www.topdawgcontest.com/Top20.plist"];
		NSURLRequest *theRequest2=[NSURLRequest requestWithURL:url
												   cachePolicy:NSURLRequestUseProtocolCachePolicy
											   timeoutInterval:60.0];
		NSURLConnection *theConnection2=[[NSURLConnection alloc] initWithRequest:theRequest2 delegate:self];
		if(theConnection2){
			
		self.data = [NSArray arrayWithContentsOfURL:url];
		}
	}
	UIBarButtonItem *temporaryBarButtonItem = [[UIBarButtonItem alloc] init];
	temporaryBarButtonItem.title = @"Back";
	self.navigationItem.backBarButtonItem = temporaryBarButtonItem;
	[temporaryBarButtonItem release];
}

-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse*)response{
}

-(void)connectionDidFinishLoading:(NSURLConnection*)connection{
}

- (void)connection:(NSURLConnection *)connection
  didFailWithError:(NSError *)error{
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
    static NSString *CellIdentifier = @"Top20Cell";
    
    Top20Cell *cell = (Top20Cell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	
    if (cell == nil) {
		[[NSBundle mainBundle] loadNibNamed:@"IndividualSubviews2" owner:self options:nil];
        cell = tmpCell;
        self.tmpCell = nil;
    }
    
    cell.useDarkBackground = (indexPath.row % 2 == 0);
	
 	self.dataItem2 = [data objectAtIndex:indexPath.row];
	
    cell.name = [dataItem2 objectForKey:@"Name"];
	cell.number = [dataItem2 objectForKey:@"Number"];
    cell.submission = [[dataItem2 objectForKey:@"Score"] intValue];
    return cell;
}


- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    UIView *cellBack = [[[UIView alloc] init] autorelease];
	cellBack.backgroundColor = [UIColor clearColor];
	cell.selectedBackgroundView = cellBack;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
	[NSThread detachNewThreadSelector:@selector(myIndicator) toTarget:self withObject:nil]; 
	Top20Image *imagetop20 = [[Top20Image alloc] initWithNibName:@"Top20Image" bundle:nil];

	imagetop20.title = @"Top Dawg";
	self.hidesBottomBarWhenPushed = YES;
	imagetop20.number = (NSInteger)indexPath.row;
	
	[[self navigationController] pushViewController:imagetop20 animated:YES];
	[imagetop20 release];
	self.hidesBottomBarWhenPushed = NO;
	[self.myActivityIndicator stopAnimating];
}

- (void)myIndicator{ 
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
	[self.myActivityIndicator startAnimating];
	[pool release]; 
} 

- (void)dealloc{
	[myActivityIndicator release];
	[dataItem2 release];
	[dataItem release];
    [data release];
    [super dealloc];
}

@end
