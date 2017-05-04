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

#pragma mark - Add Satellites

- (void)addSatellites:(NSUInteger)count {
    
    UIView *satelliteContainerView = [[UIView alloc] initWithFrame:CGRectMake(-1.5, -1.5, self.frame.size.width, self.frame.size.height)];
    satelliteContainerView.tag = CONTAINER_SATELLITES_VIEW_TAG;
    satelliteContainerView.alpha = 0;
    
    for (NSUInteger i = 0; i < count; i++) {
        
        UIView *satellite = [[UIView alloc] initWithFrame:self.bounds];
        [satellite addSatelliteShapeLayerAtAngle:(double)i / (double)count * 2.0 * M_PI];
        [self addSubview:satellite];
    }
    
    [self addSubview:satelliteContainerView];
}

#pragma mark - Shape Layer Helper

- (void)addSatelliteShapeLayerAtAngle:(CGFloat)angle {
    CAShapeLayer *shape = [[CAShapeLayer alloc] init];
    
    CGPoint initialSatelliteLocation = CGPointMake(self.frame.size.width * 0.1, self.frame.size.height * 0.1);
    UIBezierPath *satelite = [UIBezierPath bezierPathWithArcCenter:initialSatelliteLocation radius:3.5 startAngle:0 endAngle:2 * M_PI clockwise:YES];

    [shape setFillColor:[UIColor whiteColor].CGColor];
    shape.path = satelite.CGPath;

    self.layer.transform = CATransform3DMakeRotation(angle + M_PI_4, 0, 0, 1);
    [self.layer addSublayer:shape];
}


#pragma mark - Remove Satellites

- (void)removeSatellites {
    UIView *satellitesContainer = [self viewWithTag:CONTAINER_SATELLITES_VIEW_TAG];
    if (satellitesContainer) {
        [satellitesContainer removeFromSuperview];
    }
}

@end
