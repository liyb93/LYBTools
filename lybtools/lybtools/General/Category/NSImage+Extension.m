//
//  NSImage+Extension.m
//  Image
//
//  Created by liyb on 2019/5/27.
//  Copyright © 2019 qzc. All rights reserved.
//

#import "NSImage+Extension.h"

@implementation NSImage (Extension)

void addRoundedRectToPath(CGContextRef context, CGRect rect, float ovalWidth, float ovalHeight) {
    float fw, fh;
    if (ovalWidth == 0 || ovalHeight == 0) {
        CGContextAddRect(context, rect);
        return;
    }
    CGContextSaveGState(context);
    CGContextTranslateCTM (context, CGRectGetMinX(rect), CGRectGetMinY(rect));
    CGContextScaleCTM (context, ovalWidth, ovalHeight);
    fw = CGRectGetWidth (rect) / ovalWidth;
    fh = CGRectGetHeight (rect) / ovalHeight;
    CGContextMoveToPoint(context, fw, fh/2);
    CGContextAddArcToPoint(context, fw, fh, fw/2, fh, 1);
    CGContextAddArcToPoint(context, 0, fh, 0, fh/2, 1);
    CGContextAddArcToPoint(context, 0, 0, fw/2, 0, 1);
    CGContextAddArcToPoint(context, fw, 0, fw, fh/2, 1);
    CGContextClosePath(context);
    CGContextRestoreGState(context);
}

- (NSImage *)roundCornersImageCornerRadius:(NSInteger)radius {
    int w = (int) self.size.width;
    int h = (int) self.size.height;
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = CGBitmapContextCreate(NULL, w, h, 8, 4 * w, colorSpace, kCGImageAlphaPremultipliedFirst);
    
    CGContextBeginPath(context);
    CGRect rect = CGRectMake(0, 0, w, h);
    addRoundedRectToPath(context, rect, radius, radius);
    CGContextClosePath(context);
    CGContextClip(context);
    
    CGImageRef cgImage = [[NSBitmapImageRep imageRepWithData:[self TIFFRepresentation]] CGImage];
    
    CGContextDrawImage(context, CGRectMake(0, 0, w, h), cgImage);
    
    CGImageRef imageMasked = CGBitmapContextCreateImage(context);
    CGContextRelease(context);
    CGColorSpaceRelease(colorSpace);
    
    NSImage *tmpImage = [[NSImage alloc] initWithCGImage:imageMasked size:self.size];
    NSData *imageData = [tmpImage TIFFRepresentation];
    NSImage *image = [[NSImage alloc] initWithData:imageData];
    return image;
}

- (NSImage *)compressWithRate:(CGFloat)rate {
    NSData *data = [self TIFFRepresentation];
    if (!data) {
        return nil;
    }
    NSBitmapImageRep *imageRep = [NSBitmapImageRep imageRepWithData:data];
    NSDictionary *imageProps = [NSDictionary dictionaryWithObject:[NSNumber numberWithFloat:rate] forKey:NSImageCompressionFactor];
    data = [imageRep representationUsingType:NSBitmapImageFileTypeJPEG properties:imageProps];
    return [[NSImage alloc] initWithData:data];
}

- (NSImage *)scaleToSize:(CGSize)size {
    NSRect targetFrame = NSMakeRect(0, 0, size.width, size.height);
    NSImage *targetImage = [[NSImage alloc] initWithSize:size];
    [targetImage lockFocus];
    [self drawInRect:targetFrame fromRect:CGRectMake(0, 0, self.size.width, self.size.height) operation:NSCompositingOperationCopy fraction:1.0];
    [targetImage unlockFocus];
    return targetImage;
}

@end
