//
//  UIView+DominantColor.m
//  SpringToolzSampleProject
//
//  Created by Stoyan Stoyanov on 4/23/17.
//  Copyright © 2017 Stoyan Stoyanov. All rights reserved.
//

#import "UIView+DominantColor.h"

@implementation UIView (DominantColor)

- (UIColor *) dominantColorInRect:(CGRect)rect
{
    UIColor * dominantColor = nil;
    NSMutableDictionary * dictionary = [[NSMutableDictionary alloc] init];
    
    int bytesPerPixel = 4;
    int bytesPerRow = bytesPerPixel * 1;
    NSUInteger bitsPerComponent = 8;
    unsigned char pixelData[4] = { 0, 0, 0, 0 };
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = CGBitmapContextCreate(pixelData, 1, 1, bitsPerComponent, bytesPerRow, colorSpace, kCGImageAlphaPremultipliedLast);
    
    for (int x = rect.origin.x; x <= rect.size.width; x = 2 * x + 1) {
        for (int y = 0; y <= rect.size.height; y = 2 * y + 1) {
            
            context = CGBitmapContextCreate(pixelData, 1, 1, bitsPerComponent, bytesPerRow, colorSpace, kCGImageAlphaPremultipliedLast);
            
            CGContextTranslateCTM(context, -x, -y);
            
            [self.layer renderInContext:context];
            
            CGContextRelease(context);
            
            UIColor *color = [UIColor colorWithRed:pixelData[0]/255.0 green:pixelData[1]/255.0 blue:pixelData[2]/255.0 alpha:pixelData[3]/255.0];
            
            if (color) {
                
                NSInteger count = [[dictionary objectForKey:color] integerValue];
                count++;
                [dictionary setObject:[NSNumber numberWithInt:count] forKey:color];
            }
        }
    }
    
    
    CGColorSpaceRelease(colorSpace);
    
    int highestFrequency = 0;
    for (id color in dictionary) {
        NSInteger count = [[dictionary objectForKey:color] integerValue];
        //NSInteger count = [object[1] integerValue];
        if (count > highestFrequency) {
            highestFrequency = count;
            dominantColor = color;
        }
    }
    
    return dominantColor;
}

@end
