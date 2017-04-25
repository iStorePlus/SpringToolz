//
//  UIView+Satelite.m
//  SpringToolzSampleProject
//
//  Created by Stoyan Stoyanov on 4/25/17.
//  Copyright © 2017 Stoyan Stoyanov. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "UIView+Satelite.h"

@implementation UIView (Satelite)

// self will have superview for sure
- (void)addSatellite {
    UIView *satelliteView = [[UIView alloc] initWithFrame:self.superview.frame];
    [satelliteView addSatelliteShapeLayer];
    [self.superview.superview addSubview:satelliteView];
    [satelliteView runSpinAnimation];
    satelliteView.alpha = 0.7;
}


- (void)addSatelliteShapeLayer {
    CAShapeLayer *shape = [[CAShapeLayer alloc] init];
    
    CGPoint initialSatelliteLocation = CGPointMake(self.frame.size.width * 0.1, self.frame.size.height * 0.1);
    
    UIBezierPath *satelite = [UIBezierPath bezierPathWithArcCenter:initialSatelliteLocation radius:3.5 startAngle:0 endAngle:2 * M_PI clockwise:YES];
    [shape setFillColor:[UIColor whiteColor].CGColor];
    shape.path = satelite.CGPath;
    [self.layer addSublayer:shape];
}

- (void) runSpinAnimation {
    CABasicAnimation* rotationAnimation;
    CGFloat toValue = arc4random_uniform(4) >= 2 ? M_PI : -M_PI;
    rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.toValue = [NSNumber numberWithFloat: toValue];
    rotationAnimation.duration = 3 + arc4random_uniform(10);
    rotationAnimation.cumulative = YES;
    rotationAnimation.repeatCount = HUGE_VALF;
    rotationAnimation.timeOffset = arc4random_uniform(4);
    [self.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
}

@end
