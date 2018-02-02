//
//  NSImage+Converter.m
//  SonOfGrab
//
//  Created by liuxiang on 2018/2/2.
//

#import "NSImage+Converter.h"
#import "MainTrainning.h"


static MainTrainning *s_sharedInstance = nil;

@implementation NSImage (Converter)







+ (NSImage *)showAreaAndClipWithCGImage:(CGImageRef)ref rect:(NSRect)rect
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        s_sharedInstance = [[MainTrainning alloc] init];
    });
@autoreleasepool {
    NSRect imageRect = NSMakeRect(0.0, 0.0,
                                  CGImageGetWidth(ref),
                                  CGImageGetHeight(ref));
    
    // Create a new image to receive the Quartz image data.
    NSImage* newImage = [[NSImage alloc] initWithSize:imageRect.size];
    [newImage lockFocus];
    CGContextRef imageContext = (CGContextRef)[[NSGraphicsContext currentContext] graphicsPort];
    CGContextDrawImage(imageContext, *(CGRect*)&imageRect, ref);
    
    // 2. draw lines
    [[NSColor redColor] setFill];
    CGFloat x = rect.origin.x, y = rect.origin.y, w = rect.size.width, h = rect.size.height;
    NSRect lineRc;
    lineRc = NSMakeRect(x, y, w, 10);
    NSRectFill(lineRc);
    
    lineRc.origin.y = y + h;
    NSRectFill(lineRc);
    
    lineRc = NSMakeRect(x, y, 10, h);
    NSRectFill(lineRc);
    
    lineRc.origin.x = x + w;
    NSRectFill(lineRc);
    
    [newImage unlockFocus];
    
    
//    [newImage clipWithRect:rect context: imageContext image:<#(CGImageRef)#>]
    
    //    CGContextRelease(imageContext);
    return newImage;
};}
- (RecognizedResult *)clipWithRect:(NSRect)rect totalHeight:(float)height// context:(CGContextRef)ctx image:(CGImageRef)srcImgRef
{
@autoreleasepool{
    rect.origin.x = 2000;
    rect.origin.y = 1900;
    rect.size.width = 1000;
    rect.size.height = 500;
    CGFloat w = rect.size.width, h = rect.size.height;
    
    NSImage*   recognizeImage = [[NSImage alloc] initWithSize: rect.size];
    [recognizeImage lockFocus];
    
    // 2. clip the recognize area
    CGImageSourceRef source = CGImageSourceCreateWithData((CFDataRef)[self TIFFRepresentation], NULL);
    CGContextRef ctx = (CGContextRef)[[NSGraphicsContext currentContext] graphicsPort];
    CGImageRef srcImgRef = CGImageSourceCreateImageAtIndex(source, 0, NULL);
    
    CGImageRef recognizeImageRef = CGImageCreateWithImageInRect(srcImgRef, rect);
    CGContextDrawImage(ctx, CGRectMake(0, 0, w, h), recognizeImageRef);
    
    //[[NSColor greenColor] setFill];
    //NSRectFill(NSMakeRect(0, 0, w, h));
    
    [recognizeImage unlockFocus];
    
    
    // 3. write recognize image to file
    NSString *path = @"/Users/liuxiang/Documents/screenshot/";
    static int s_index = 0;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSFileManager *fm = [NSFileManager defaultManager];
        if ([fm fileExistsAtPath: path])
        {
            NSError *error = nil;
//            [fm removeItemAtPath: path error: &error];
            if (error)
            {
                NSLog(@"Remove old pictures error : %@", error);
            }
            else
            {
//                [fm createDirectoryAtPath: path attributes: nil];
            }
        }
    });
    s_index++;
    
    path = [path stringByAppendingFormat: @"%i.jpg", s_index];
    [recognizeImage writeToFileWithPath: path size: NSMakeSize(w, h)];

    RecognizedResult *rst =  [s_sharedInstance recognize: (char *)[path UTF8String]];
    static int last_index = 0;
    if (last_index == rst.count)
    {
        NSError *error = nil;
        [[NSFileManager defaultManager] removeItemAtPath: path error: &error];
        if (error)
        {
            NSLog(@"Remove file error: %@", error);
        }
    }
    last_index = rst.count;
    return rst;
};}

- (BOOL)writeToFileWithPath:(NSString *)path size:(NSSize)size
{
    NSData *imageData = [self TIFFRepresentation];
    NSBitmapImageRep *imageRep = [NSBitmapImageRep imageRepWithData:imageData];
    [imageRep setSize: size];
    
    NSData *data = nil;
#if 0
    // png
    data = [imageRep representationUsingType:NSPNGFileType properties:nil];
#else
    // jpg
    NSDictionary *imageProps = nil;
    NSNumber *quality = [NSNumber numberWithFloat:.85];
    imageProps = [NSDictionary dictionaryWithObject:quality forKey:NSImageCompressionFactor];
    data = [imageRep representationUsingType:NSJPEGFileType properties:imageProps];
#endif
    
    [data writeToFile: path atomically: NO];
}


@end


#if 0
NSBitmapImageRep *bitmap2 = [NSBitmapImageRep imageRepWithData:[self TIFFRepresentation]];

NSImage* bild1 = [[NSImage alloc] initWithSize:NSMakeSize([bitmap2 pixelsWide], [bitmap2 pixelsHigh])];

int depth       = [bitmap2 bitsPerSample];
int channels    = [bitmap2 samplesPerPixel];
int height      = [bild1 size].height;
int width       = [bild1 size].width;


IplImage *iplpic = cvCreateImage(cvSize(width, height), depth, channels);
#endif
