//
//  UIView+CrossFadeShape.m
//  SpringToolzSampleProject
//
//  Created by Stoyan Stoyanov on 5/18/17.
//  Copyright © 2017 Stoyan Stoyanov. All rights reserved.
//

#import "UIView+CrossFadeShape.h"
#import "SBIconView.h"
#import "SPGTLZIconManager.h"

@implementation UIView (CrossFadeShape)

- (void)applyCrossFadeShapeInRegardsTo:(UIView *)newSuperview {
    if ([NSStringFromClass([newSuperview class]) isEqualToString:@"SBIconView"]) {
        SBIconView *icon = (SBIconView *)newSuperview;
        
        UIBezierPath *shape = nil;
        if ([icon isInDock]) {
            shape = [[SPGTLZIconManager sharedInstance] shapeForDockIcons];
        } else {
            shape = [[SPGTLZIconManager sharedInstance] shapeForPageIcons];
        }
        
        CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
        maskLayer.path = shape.CGPath;
        
        UIView *mask = [[UIView alloc] initWithFrame:self.bounds];
        [mask.layer addSublayer:maskLayer];
        
        UIView *scalingView = (UIView *)[self valueForKey:@"iconImageView"];
        scalingView.maskView = mask;
    }
}

@end
