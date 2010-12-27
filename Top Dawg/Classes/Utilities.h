#import <Foundation/Foundation.h>


@interface Utilities : NSObject 
-(void) cacheImage: (NSString *)ImageURLString getCacheName:(NSString *)ImageNameString;
-(UIImage *) getCachedImage:(NSString *)ImageURLString cacheName:(NSString *)ImageNameString;

@end

