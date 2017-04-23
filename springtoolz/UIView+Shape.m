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

    UIView *sbIconView = self.superview;
    [self removeFromSuperview];
    
    UIView *containerView = [[UIView alloc] initWithFrame:self.frame];
    [sbIconView addSubview:containerView];

    [containerView addSubview:self];
    
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.path = shape.CGPath;

    UIView *mask = [[UIView alloc] initWithFrame:self.bounds];
    [mask.layer addSublayer:maskLayer];

    self.maskView = mask;
    containerView.layer.shouldRasterize = TRUE;
    containerView.layer.rasterizationScale = [UIScreen mainScreen].scale;
    containerView.tag = CONTAINER_SHAPE_VIEW_TAG;
    
    if (shouldAnimate) {
        [[SPGTLZIconManager sharedInstance] addMaskView:mask];
    }
}

@end
