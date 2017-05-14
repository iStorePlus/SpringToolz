//
//  UIBezierPath+CustomPaths.h
//  SpringToolzSampleProject
//
//  Created by Stoyan Stoyanov on 4/19/17.
//  Copyright © 2017 Stoyan Stoyanov. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBezierPath (CustomPaths)
+ (UIBezierPath *)gearPathWithNumberOfSides:(NSUInteger)sides radiusDeviation:(CGFloat)radDeviation iconSize:(CGRect)iconSize;
+ (UIBezierPath *)sineCircleWithCountOfBumps:(NSUInteger)bumpsCount andDeviation:(CGFloat)deviation iconSize:(CGRect)iconSize;
+ (UIBezierPath *)regularPolygonWithCountOfSides:(NSUInteger)countOfSides iconSize:(CGRect)iconSize;
+ (UIBezierPath *)circleWithNotchWidth:(CGFloat)notchWidth notchDepth:(CGFloat)depth iconSize:(CGRect)iconSize;
+ (UIBezierPath *)circleWithTwoNotchesWidth:(CGFloat)notchesWidth notchesDepth:(CGFloat)depth iconSize:(CGRect)iconSize;
+ (UIBezierPath *)bloatedSquareWithNormalizedDeviation:(CGFloat)deviation iconSize:(CGRect)iconSize;
+ (UIBezierPath *)roundedSquareWithCornerRadius:(CGFloat)cornerRadius iconSize:(CGRect)iconSize;
@end
