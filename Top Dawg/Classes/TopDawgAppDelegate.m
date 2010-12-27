#import "TopDawgAppDelegate.h"
#import "RootViewController.h"
#import "Top20.h"
#import "UploadController.h"

@implementation TopDawgAppDelegate

@synthesize window;
@synthesize navigationController;
@synthesize tabController;


- (void)applicationDidFinishLaunching:(UIApplication *)application {
	[window addSubview:[navigationController view]]; 
	[window addSubview:[tabController view]];
    [window makeKeyAndVisible];
}
 
- (void)applicationWillTerminate:(UIApplication *)application {
	[navigationController release];
	[tabController release];
    [window release];
}

- (void)dealloc{
    [navigationController release];
	[tabController release];
    [window release];
    [super dealloc];
}

@end

