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
    [bPath applyTransform:CGAffineTransformMakeRotation(-M_PI / sides)];
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

+ (UIBezierPath *)regularPolygonWithCountOfSides:(NSUInteger)countOfSides iconSize:(CGRect)iconSize {
    
    CGFloat baseRadius = iconSize.size.height / 2.0;
    UIBezierPath *bPath = [UIBezierPath bezierPath];
    [bPath moveToPoint:CGPointZero];
    
    for (NSUInteger i = 0; i <= countOfSides; i++) {
        CGFloat currentAngle = (double)i / (double)countOfSides * 2.0 * M_PI;
        
        CGFloat xCoord = baseRadius * sin(currentAngle);
        CGFloat yCoord = baseRadius * cos(currentAngle);
        
        [bPath addLineToPoint:CGPointMake(xCoord, yCoord)];
    }
    
    [bPath closePath];
    
    // rotate the octagon to make it like a stop sign
    if (countOfSides == 8) {
        [bPath applyTransform:CGAffineTransformMakeRotation(1.0 / countOfSides * M_PI)];
    }
    return bPath;
}

+ (UIBezierPath *)circleWithNotchWidth:(CGFloat)notchWidth notchDepth:(CGFloat)depth iconSize:(CGRect)iconSize {
    CGFloat baseRadius = iconSize.size.height / 2.0;
    UIBezierPath *bPath = [UIBezierPath bezierPath];
    [bPath moveToPoint:CGPointZero];
    
    [bPath addArcWithCenter:CGPointZero radius:baseRadius - depth startAngle:0 endAngle:notchWidth clockwise:YES];
    [bPath addArcWithCenter:CGPointZero radius:baseRadius startAngle:notchWidth endAngle:2 * M_PI clockwise:YES];
    [bPath closePath];
    return bPath;
}

+ (UIBezierPath *)circleWithTwoNotchesWidth:(CGFloat)notchesWidth notchesDepth:(CGFloat)depth iconSize:(CGRect)iconSize {
    CGFloat baseRadius = iconSize.size.height / 2.0;
    UIBezierPath *bPath = [UIBezierPath bezierPath];
    [bPath moveToPoint:CGPointZero];
    
    [bPath addArcWithCenter:CGPointZero radius:baseRadius - depth startAngle:0 endAngle:notchesWidth clockwise:YES];
    [bPath addArcWithCenter:CGPointZero radius:baseRadius startAngle:notchesWidth endAngle:M_PI clockwise:YES];
    [bPath addArcWithCenter:CGPointZero radius:baseRadius - depth startAngle:M_PI endAngle:M_PI + notchesWidth clockwise:YES];
    [bPath addArcWithCenter:CGPointZero radius:baseRadius startAngle:M_PI + notchesWidth endAngle:2 * M_PI clockwise:YES];
    [bPath closePath];
    return bPath;
}

+ (UIBezierPath *)bloatedSquareWithNormalizedDeviation:(CGFloat)deviation iconSize:(CGRect)iconSize {
    CGFloat baseRadius = iconSize.size.height / 2.0;
    CGFloat croppedRadius = baseRadius * deviation;
    
    CGPoint firstPoint = CGPointMake(-croppedRadius, croppedRadius);
    CGPoint secondPoint = CGPointMake(croppedRadius, croppedRadius);
    CGPoint thirdPoint = CGPointMake(croppedRadius, -croppedRadius);
    CGPoint fourthPoint = CGPointMake(-croppedRadius, -croppedRadius);
    
    CGPoint topAnchorPoint = CGPointMake(0, baseRadius);
    CGPoint rightAnchorPoint = CGPointMake(baseRadius, 0);
    CGPoint bottomAnchorPoint = CGPointMake(0, -baseRadius);
    CGPoint leftAnchorPoint = CGPointMake(-baseRadius, 0);
    
    UIBezierPath *bPath = [UIBezierPath bezierPath];
    
    
    [bPath moveToPoint:firstPoint];
    [bPath addCurveToPoint:secondPoint controlPoint1:topAnchorPoint controlPoint2:topAnchorPoint];
    [bPath addCurveToPoint:thirdPoint controlPoint1:rightAnchorPoint controlPoint2:rightAnchorPoint];
    [bPath addCurveToPoint:fourthPoint controlPoint1:bottomAnchorPoint controlPoint2:bottomAnchorPoint];
    [bPath addCurveToPoint:firstPoint controlPoint1:leftAnchorPoint controlPoint2:leftAnchorPoint];
    
    [bPath closePath];
    return bPath;
}

@end
