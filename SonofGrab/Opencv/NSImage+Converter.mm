//
//  NSImage+Converter.m
//  SonOfGrab
//
//  Created by liuxiang on 2018/2/2.
//

#import "NSImage+Converter.h"


@implementation NSImage (Converter)


- (NSImage *)showAreaAndClipWithRect:(NSRect)rect
{
    return [self doFilter: NSMakeRect(0,0,0,0)];
}
- (IplImage *)opencvImage
{
    NSRect rc = NSMakeRect(800, 800, 800, 400);
    NSImage *image = [self doFilter: rc];
    
    static int s_index = 0;
    s_index++;
    NSString *path = @"/Users/liuxiang/Documents/screenshot/";
    path = [path stringByAppendingFormat: @"%i.jpg", s_index];
    [image writeToFileWithPath: path size: rc.size];
    
    return nil;
}


-(NSImage *)doFilter:(NSRect)rect
{
@autoreleasepool {
    CGImageSourceRef source = CGImageSourceCreateWithData((__bridge CFDataRef)[self TIFFRepresentation],NULL);
    
    CGImageRef imageRef = CGImageSourceCreateImageAtIndex(source, 0, NULL);
    CGImageRef subImage = CGImageCreateWithImageInRect(imageRef, rect);
#warning 1
    return [[self class] imageFromCGImageRef: imageRef];
};}

+ (NSImage *)imageFromCGImageRef:(CGImageRef)image
{
@autoreleasepool {
    NSRect imageRect = NSMakeRect(0.0, 0.0,
                                  CGImageGetWidth(image),
                                  CGImageGetHeight(image));

    // Create a new image to receive the Quartz image data.
    NSImage* newImage = [[NSImage alloc] initWithSize:imageRect.size];
    [newImage lockFocus];
    // Get the Quartz context and draw.
    CGContextRef imageContext = (CGContextRef)[[NSGraphicsContext currentContext] graphicsPort];
    CGContextDrawImage(imageContext, *(CGRect*)&imageRect, image);
    
    [[NSColor redColor] setFill];
    NSRectFill(NSMakeRect(800, 800, 800, 400));
    
    [newImage unlockFocus];
    
    return newImage;
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
