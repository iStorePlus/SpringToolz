//
//  UIView+Round.m
//  IconsWithShadowsTestProject
//
//  Created by Stoyan Stoyanov on 4/12/17.
//  Copyright © 2017 Stoyan Stoyanov. All rights reserved.
//

#import "UIView+Round.h"

@implementation UIView (Round)

- (void)makeCircular {
    
    CGFloat circleDiameter = self.frame.size.width * 0.94;
    CGFloat xOrigin = (self.frame.size.width - circleDiameter) / 2.0;
    
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    CGRect maskRect = CGRectMake(xOrigin, xOrigin, circleDiameter, circleDiameter);
    CGPathRef path = CGPathCreateWithEllipseInRect(maskRect, NULL);
    maskLayer.path = path;
    CGPathRelease(path);
    
    self.layer.mask = maskLayer;
}

- (void)dropShadow {
    UIBezierPath *shadowPath = [UIBezierPath bezierPathWithRect:self.bounds];
    self.layer.shadowPath = [shadowPath CGPath];
    self.layer.masksToBounds = NO;
    self.layer.shadowOffset = CGSizeMake(0, 0);
    self.layer.shadowRadius = 10;
    self.layer.shadowOpacity = 1;
    self.layer.shadowColor = [UIColor blackColor].CGColor;
}

@end
