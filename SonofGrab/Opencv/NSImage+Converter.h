//
//  NSImage+Converter.h
//  SonOfGrab
//
//  Created by liuxiang on 2018/2/2.
//

#import <Cocoa/Cocoa.h>

@interface NSImage (Converter)

- (IplImage *)opencvImage;

- (NSImage *)showAreaAndClipWithRect:(NSRect)rect;
@end
