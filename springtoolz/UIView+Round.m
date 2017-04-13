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
    [self dropShadowWithPath:shadowPath];
}

- (void)dropCircularShadowWithTag:(NSInteger)tag behind:(UIView *)subview {
    
    for (UIView *subview in self.subviews) {
        if(subview.tag == tag) {
            return;
        }
    }
    
    UIView *shadowView = [[UIView alloc] initWithFrame:subview.frame];
    [shadowView setBackgroundColor:[UIColor clearColor]];
    
    UIBezierPath *shadowPath = [UIBezierPath bezierPathWithOvalInRect:subview.bounds];
    [shadowView dropShadowWithPath:shadowPath];
    
    shadowView.tag = tag;
    [self insertSubview:shadowView belowSubview:subview];
}

#pragma mark - Internal Helpers

- (void)dropShadowWithPath:(UIBezierPath *)shadowPath {
    self.layer.shadowPath = [shadowPath CGPath];
    self.layer.masksToBounds = NO;
    self.layer.shadowOffset = CGSizeMake(0, 0);
    self.layer.shadowRadius = 10;
    self.layer.shadowOpacity = 1;
    self.layer.shadowColor = [UIColor blackColor].CGColor;
}

@end
