#import "Utilities.h"
#define TMP NSTemporaryDirectory()

@implementation Utilities

-(void) cacheImage: (NSString *)ImageURLString getCacheName:(NSString *)ImageNameString{
    NSURL *ImageURL = [NSURL URLWithString: ImageURLString];
    
    NSString *filename = ImageNameString;
    NSString *uniquePath = [TMP stringByAppendingPathComponent: filename];
	
    if(![[NSFileManager defaultManager] fileExistsAtPath: uniquePath]){
        NSData *data = [[NSData alloc] initWithContentsOfURL: ImageURL];
        UIImage *image = [[UIImage alloc] initWithData: data];
        
        if([ImageURLString rangeOfString: @".png" options: NSCaseInsensitiveSearch].location != NSNotFound){
            [UIImagePNGRepresentation(image) writeToFile: uniquePath atomically: YES];
        }
        else if(
                [ImageURLString rangeOfString: @".jpg" options: NSCaseInsensitiveSearch].location != NSNotFound || 
                [ImageURLString rangeOfString: @".jpeg" options: NSCaseInsensitiveSearch].location != NSNotFound
                ){
            [UIImageJPEGRepresentation(image, 100) writeToFile: uniquePath atomically: YES];
        }
    }
}

-(UIImage *) getCachedImage:(NSString *)ImageURLString cacheName:(NSString *)ImageNameString{
    NSString *filename = ImageNameString;
    NSString *uniquePath = [TMP stringByAppendingPathComponent:filename];
    
    UIImage *image;
    
    if([[NSFileManager defaultManager] fileExistsAtPath: uniquePath]){
        image = [UIImage imageWithContentsOfFile: uniquePath];
    }
    else{
        [self cacheImage:ImageURLString getCacheName:ImageNameString];
        image = [UIImage imageWithContentsOfFile: uniquePath];
    }
    return image;
}

@end