#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ApplicationCell : UITableViewCell {
    BOOL useDarkBackground;
    UIImage *icon;
	UIImage *medalIcon;
    NSString *month;
    NSString *name;
    NSInteger score;
    NSInteger submission;
}

@property(retain) UIImage *icon;
@property(retain) UIImage *medalIcon;
@property(retain) NSString *month;
@property(retain) NSString *name;
@property NSInteger score;
@property NSInteger submission;

@end
