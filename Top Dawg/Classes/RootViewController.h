#import <UIKit/UIKit.h>
#import "ApplicationCell.h"

@interface RootViewController : UITableViewController {
	
	ApplicationCell *tmpCell;
    NSArray *data;
	UIImage *iconimage;
	UIActivityIndicatorView *myActivityIndicator;
	NSMutableDictionary *myDictionary;
}

@property (nonatomic, assign) IBOutlet ApplicationCell *tmpCell;
@property (nonatomic, retain) NSArray *data;
@property (nonatomic, retain) UIImage *iconimage;
@property (nonatomic, retain) UIActivityIndicatorView *myActivityIndicator;
@property (nonatomic, retain) NSMutableDictionary *myDictionary;

@end
