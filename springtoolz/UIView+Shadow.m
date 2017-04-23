//
//  UIView+Shadow.m
//  SpringToolzSampleProject
//
//  Created by Stoyan Stoyanov on 4/23/17.
//  Copyright © 2017 Stoyan Stoyanov. All rights reserved.
//

#import "UIView+Shadow.h"
#import "SPGTLZIconManager.h"

#define SHADOW_TAG 0x00123f

@implementation UIView (Shadow)

- (void)applyShadow:(BOOL)shadowEnabled withShape:(UIBezierPath *)shape andHorizontalDeviation:(CGFloat)horDeviation verticalDeviation:(CGFloat)verDeviation intensity:(CGFloat)intensity colorName:(NSString *)colorName {
    
    UIColor *color = [[SPGTLZIconManager sharedInstance] shadowColorForName:colorName];
    
    if (shadowEnabled == NO || color == nil || self.superview == nil) {
        return;
    }
    
    for (UIView *subview in self.superview.subviews) {
        if(subview.tag == SHADOW_TAG) {
            return;
        }
    }
    
    if (shape == nil) {
        shape = [UIBezierPath bezierPathWithRect:self.bounds];
    }
    
    UIView *shadowView = [[UIView alloc] initWithFrame:self.frame];
    shadowView.tag = SHADOW_TAG;
    
    shadowView.layer.shadowPath = [shape CGPath];
    shadowView.layer.masksToBounds = NO;
    shadowView.layer.shadowOffset = CGSizeMake(horDeviation * self.frame.size.width, verDeviation * self.frame.size.height);
    shadowView.layer.shadowRadius = 10;
    
    shadowView.layer.shadowOpacity = intensity;
    shadowView.layer.shadowColor = color.CGColor;
    
    [self.superview addSubview:shadowView];
    [self.superview sendSubviewToBack:shadowView];
}

@end
