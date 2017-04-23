//
//  UIView+Shape.m
//  SpringToolzSampleProject
//
//  Created by Stoyan Stoyanov on 4/23/17.
//  Copyright © 2017 Stoyan Stoyanov. All rights reserved.
//

#import "UIView+Shape.h"
#import "SPGTLZIconManager.h"

@implementation UIView (Shape)

// will be called by SBIconImageView or SBClockApplicationIconImageView that certainly has superview

- (void)applyIconShape:(UIBezierPath *)shape shouldAnimate:(BOOL)shouldAnimate {
    
    if (shape == nil) {
        self.maskView = nil;
        return;
    }
    
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.path = shape.CGPath;
    
    UIView *mask = [[UIView alloc] initWithFrame:self.bounds];
    [mask.layer addSublayer:maskLayer];
    
    self.maskView = mask;
    self.superview.layer.shouldRasterize = TRUE;
    self.superview.layer.rasterizationScale = [UIScreen mainScreen].scale;
    
    if (shouldAnimate) {
        [[SPGTLZIconManager sharedInstance] addMaskView:mask];
    }
}

@end
