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
@end
