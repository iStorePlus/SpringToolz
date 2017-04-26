//
//  UIView+Satelite.m
//  SpringToolzSampleProject
//
//  Created by Stoyan Stoyanov on 4/25/17.
//  Copyright © 2017 Stoyan Stoyanov. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "UIView+Satelite.h"
#import "SPGTLZIconManager.h"

@implementation UIView (Satelite)

// self will have superview for sure
- (void)addSatellites:(NSUInteger)count {
    
    UIView *satelliteContainerView = [[UIView alloc] initWithFrame:CGRectMake(-1.5, -1.5, self.frame.size.width, self.frame.size.height)];
    satelliteContainerView.tag = CONTAINER_SATELLITES_VIEW_TAG;
    satelliteContainerView.alpha = 0;
    for (NSUInteger i = 0; i < count; i++) {
        [satelliteContainerView addSatelliteWithIndex:i fromCount:count];
    }
    
    [self.superview addSubview:satelliteContainerView];
    [[SPGTLZIconManager sharedInstance] addSatellite:satelliteContainerView];
}

- (void)addSatelliteWithIndex:(NSUInteger)index fromCount:(NSUInteger)count {
    UIView *satellite = [[UIView alloc] initWithFrame:self.bounds];
    [satellite addSatelliteShapeLayerAtAngle:(double)index / (double)count * 2.0 * M_PI];
    [self addSubview:satellite];
}

- (void)addSatelliteShapeLayerAtAngle:(CGFloat)angle {
    CAShapeLayer *shape = [[CAShapeLayer alloc] init];
    
    CGPoint initialSatelliteLocation = CGPointMake(self.frame.size.width * 0.1, self.frame.size.height * 0.1);
    UIBezierPath *satelite = [UIBezierPath bezierPathWithArcCenter:initialSatelliteLocation radius:3.5 startAngle:0 endAngle:2 * M_PI clockwise:YES];

    [shape setFillColor:[UIColor whiteColor].CGColor];
    shape.path = satelite.CGPath;

    self.layer.transform = CATransform3DMakeRotation(angle + M_PI_4, 0, 0, 1);
    [self.layer addSublayer:shape];
}

- (void)orbit {
    
    [UIView animateWithDuration:1 animations:^{
        self.alpha = 0.5;
    } completion:^(BOOL finished) {
        self.alpha = 0.5;
    }];
    
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
