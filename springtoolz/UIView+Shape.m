//
//  UIView+Shape.m
//  SpringToolzSampleProject
//
//  Created by Stoyan Stoyanov on 4/23/17.
//  Copyright © 2017 Stoyan Stoyanov. All rights reserved.
//

#import "UIView+Shape.h"

@implementation UIView (Shape)

// will be called by SBIconImageView or SBClockApplicationIconImageView that certainly has superview

- (void)setIconShape:(UIBezierPath *)shape {
    if (shape == nil) {
        self.layer.mask = nil;
        return;
    }
    
    UIView *sbIconView = self.superview;
    [self removeFromSuperview];
    
    UIView *containerView = [[UIView alloc] initWithFrame:self.frame];
    containerView.tag = CONTAINER_SHAPE_VIEW_TAG;
    [sbIconView addSubview:containerView];
    
    [containerView addSubview:self];
    
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.path = shape.CGPath;
    
    self.layer.mask = maskLayer;
    containerView.layer.shouldRasterize = TRUE;
    containerView.layer.rasterizationScale = [UIScreen mainScreen].scale;
}

// SBIconView
- (void)removeIconShape {
    
    UIView *shapeContainer = [self viewWithTag:CONTAINER_SHAPE_VIEW_TAG];
    if (shapeContainer) {
        
        UIView *originalIcon = shapeContainer.subviews.firstObject;
        if (originalIcon) {
            originalIcon.layer.mask = nil;
            [originalIcon removeFromSuperview];
            [self addSubview:originalIcon];
        }
        
        [shapeContainer removeFromSuperview];
    }
}

@end
