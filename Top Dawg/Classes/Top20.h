#import <UIKit/UIKit.h>
#import "Top20Cell.h"

@interface Top20 : UITableViewController {
	
	Top20Cell *tmpCell;
    NSArray *data;
	NSDictionary *dataItem;
	NSDictionary *dataItem2;
	UIActivityIndicatorView *myActivityIndicator;
}

@property (nonatomic, assign) IBOutlet Top20Cell *tmpCell;
@property (nonatomic, retain) NSArray *data;
@property (nonatomic, retain) NSDictionary *dataItem;
@property (nonatomic, retain) NSDictionary *dataItem2;
@property (nonatomic, retain) UIActivityIndicatorView *myActivityIndicator;
@end

