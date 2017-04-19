//
//  CABasicAnimation+Rotation.m
//  SpringToolzSampleProject
//
//  Created by Stoyan Stoyanov on 4/19/17.
//  Copyright © 2017 Stoyan Stoyanov. All rights reserved.
//

#import "CABasicAnimation+Rotation.h"

@implementation CABasicAnimation (Rotation)

+ (CABasicAnimation *)endlessRotationForLayer:(CALayer *)layer withSpeed:(NSTimeInterval)speed {
    CABasicAnimation *rotationAnimation = [CABasicAnimation animation];
    rotationAnimation.keyPath = @"transform";
    rotationAnimation.toValue = [NSValue valueWithCATransform3D:CATransform3DRotate(layer.transform, M_PI, 0, 0, 1.0)];
    rotationAnimation.duration = speed;
    rotationAnimation.repeatCount = HUGE_VALF;
    return rotationAnimation;
}

@end
