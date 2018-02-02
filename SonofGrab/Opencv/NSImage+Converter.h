//
//  NSImage+Converter.h
//  SonOfGrab
//
//  Created by liuxiang on 2018/2/2.
//

#import <Cocoa/Cocoa.h>

@class RecognizedResult;
@interface NSImage (Converter)


+ (NSImage *)showAreaAndClipWithCGImage:(CGImageRef)ref rect:(NSRect)rect;
- (RecognizedResult *)clipWithRect:(NSRect)rect totalHeight:(float)height;

@end
