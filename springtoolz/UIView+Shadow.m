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

#pragma mark - Setting Shadow

- (void)setShadowWithShape:(UIBezierPath *)shape {
    
    if ([self viewWithTag:SHADOW_TAG]) {
        return; // bacause shadow is already set and it can change only on respring
    }
    
    NSDictionary *shadowOpt = [[SPGTLZIconManager sharedInstance] shadowOptions];
    NSString *shadowColorName = (NSString *)[shadowOpt valueForKey:@"color"];
    CGFloat intensity = [(NSNumber *)[shadowOpt valueForKey:@"intensity"] floatValue];
    CGFloat horDeviation = [(NSNumber *)[shadowOpt valueForKey:@"hor_deviation"] floatValue];
    CGFloat verDeviation = [(NSNumber *)[shadowOpt valueForKey:@"ver_deviation"] floatValue];
    
    UIColor *color = [[SPGTLZIconManager sharedInstance] shadowColorForName:shadowColorName];
    
    if (shape == nil) {
        shape = [UIBezierPath bezierPathWithRect:self.bounds];
    }
    
    CGSize offset = CGSizeMake(horDeviation * self.frame.size.width, verDeviation * self.frame.size.width);
    
    UIView *shadowView = [[UIView alloc] initWithFrame:self.frame];
    shadowView.tag = SHADOW_TAG;
    
    for (NSUInteger i = 0; i < 2; i++) {
        UIView *shadowSubview = [self shadowViewForFrame:shadowView.bounds withOffset:offset shape:shape intensity:intensity color:color];
        [shadowView addSubview:shadowSubview];
    }
    
    [self.superview addSubview:shadowView];
}

#pragma mark - Setting Shadow Helper

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

#pragma mark - Removing Shadow

- (void)removeShadow {
    UIView *shadowContainer = [self viewWithTag:SHADOW_TAG];
    if (shadowContainer) {
        [shadowContainer removeFromSuperview];
    }
}

@end
