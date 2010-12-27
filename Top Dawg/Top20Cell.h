#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Top20Cell : UITableViewCell {
    BOOL useDarkBackground;
	
    NSString *name;
	NSString *number;
    NSInteger submission;
}

@property BOOL useDarkBackground;

@property(retain) NSString *name;
@property(retain) NSString *number;
@property NSInteger submission;

@end
