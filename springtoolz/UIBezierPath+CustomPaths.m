//
//  UIBezierPath+CustomPaths.m
//  SpringToolzSampleProject
//
//  Created by Stoyan Stoyanov on 4/19/17.
//  Copyright © 2017 Stoyan Stoyanov. All rights reserved.
//

#import "UIBezierPath+CustomPaths.h"

@implementation UIBezierPath (CustomPaths)

+ (UIBezierPath *)gearPathWithNumberOfSides:(NSUInteger)sides radiusDeviation:(CGFloat)radDeviation iconSize:(CGRect)iconSize {

    if (sides == 0) {
        return nil;
    }
    
    CGFloat baseRadius = iconSize.size.height / 2.0;
    UIBezierPath *bPath = [UIBezierPath bezierPath];
    
    for (NSInteger i = 1; i <= sides; i++) {
        
        CGFloat startAngle = ((i - 1) * 2 * M_PI / sides) - M_PI_2;
        CGFloat endAngle = (i * 2 * M_PI / sides) - M_PI_2;
        CGFloat radius = i % 2 == 0 ? baseRadius - radDeviation / 2.0 : baseRadius + radDeviation / 2.0;
        [bPath addArcWithCenter:CGPointZero radius:radius startAngle:startAngle endAngle:endAngle clockwise:YES];
    }
    [bPath closePath];
    return bPath;
}

+ (UIBezierPath *)sineCircleWithCountOfBumps:(NSUInteger)bumpsCount andDeviation:(CGFloat)deviation iconSize:(CGRect)iconSize {
    
    CGFloat baseRadius = iconSize.size.height / 2.0;
    UIBezierPath *bPath = [UIBezierPath bezierPath];
    [bPath moveToPoint:CGPointZero];
    
    NSUInteger approximationSteps = 200;
    
    for (NSUInteger i = 0; i <= approximationSteps; i++) {
        CGFloat currentAngle = (double)i / (double)approximationSteps * 2.0 * M_PI;
        CGFloat radius = deviation * sin(bumpsCount * currentAngle) + baseRadius;
        
        CGFloat xCoord = radius * sin(currentAngle);
        CGFloat yCoord = radius * cos(currentAngle);
        
        [bPath addLineToPoint:CGPointMake(xCoord, yCoord)];
    }
    
    [bPath closePath];
    return bPath;
}

@end
