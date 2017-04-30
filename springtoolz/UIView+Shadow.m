//
//  UIView+Shadow.m
//  SpringToolzSampleProject
//
//  Created by Stoyan Stoyanov on 4/23/17.
//  Copyright © 2017 Stoyan Stoyanov. All rights reserved.
//

#import "UIView+Shadow.h"
#import "SPGTLZIconManager.h"

@implementation UIView (Shadow)

- (void)applyShadow:(BOOL)shadowEnabled withShape:(UIBezierPath *)shape andHorizontalDeviation:(CGFloat)horDeviation verticalDeviation:(CGFloat)verDeviation intensity:(CGFloat)intensity colorName:(NSString *)colorName {
    
    UIColor *color = [[SPGTLZIconManager sharedInstance] shadowColorForName:colorName];
    
    if (shadowEnabled == NO || color == nil || self.superview == nil) {
        return;
    }
    
    for (UIView *subview in self.superview.subviews) {
        if(subview.tag == SHADOW_TAG) {
            [subview removeFromSuperview];
        }
    }
    
    if (shape == nil) {
        shape = [UIBezierPath bezierPathWithRect:self.bounds];
    }
    
    CGSize offset = CGSizeMake(horDeviation * self.frame.size.width, verDeviation * self.frame.size.height);
    
    UIView *shadowView = [[UIView alloc] initWithFrame:self.frame];
    shadowView.tag = SHADOW_TAG;
    
    for (NSUInteger i = 0; i < 2; i++) {
        UIView *shadowSubview = [self shadowViewForFrame:shadowView.bounds withOffset:offset shape:shape intensity:intensity color:color];
        [shadowView addSubview:shadowSubview];
    }
    
    [self.superview addSubview:shadowView];
}

- (UIView *)shadowViewForFrame:(CGRect)frame withOffset:(CGSize)offset shape:(UIBezierPath *)shape intensity:(CGFloat)intensity color:(UIColor *)color {
    
    UIView *shadowView = [[UIView alloc] initWithFrame:frame];
    
    shadowView.layer.shadowPath = [shape CGPath];
    shadowView.layer.masksToBounds = NO;
    shadowView.layer.shadowOffset = offset;
    shadowView.layer.shadowRadius = 10;
    
    shadowView.layer.shadowOpacity = intensity;
    shadowView.layer.shadowColor = color.CGColor;
    
    return shadowView;
}

@end
