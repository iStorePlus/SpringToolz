//
//  UIView+Round.m
//  IconsWithShadowsTestProject
//
//  Created by Stoyan Stoyanov on 4/12/17.
//  Copyright © 2017 Stoyan Stoyanov. All rights reserved.
//

#import "UIView+Round.h"
#define SHADOW_TAG 0x00123f

@implementation UIView (Round)

- (void)makeSubviewsCurcular:(BOOL)circular andWithShadow:(BOOL)shadow andShadowOptions:(NSDictionary *)options {
    for (UIView *subview in [self subviews]) {
        if ([NSStringFromClass([subview class]) isEqualToString:@"SBIconImageView"] ||
            [NSStringFromClass([subview class]) isEqualToString:@"SBClockApplicationIconImageView"]) {
            
            if (circular) {
                [subview makeCircular];
            }
            
            if (shadow) {
                if (circular) {
                    [self dropCircularShadowWithTag:SHADOW_TAG andOptions:options behind:subview];
                } else {
                    [subview dropShadowWithOptions:options];
                }
            }
        }
    }
}

#pragma mark - Internal Helpers

- (void)makeCircular {
    UIView *superView = [self superview];
    [self removeFromSuperview];
    
    CGFloat diameter = self.frame.size.width * 0.965;
    CGRect smallerFrame = CGRectMake(0, 0, diameter, diameter);
    UIView *container = [[UIView alloc] initWithFrame:smallerFrame];
    
    [container addSubview:self];
    [superView addSubview:container];
    [superView sendSubviewToBack:container];
    
    container.clipsToBounds = TRUE;
    container.layer.cornerRadius = container.frame.size.width / 2.0;
}

- (void)dropShadowWithOptions:(NSDictionary *)options {
    
    UIBezierPath *shadowPath = [UIBezierPath bezierPathWithRect:self.bounds];
    [self dropShadowWithPath:shadowPath options:options];
    [[self superview] sendSubviewToBack:self];
}

- (void)dropCircularShadowWithTag:(NSInteger)tag andOptions:(NSDictionary *)options behind:(UIView *)subview {
    
    for (UIView *subview in self.subviews) {
        if(subview.tag == tag) {
            return;
        }
    }
    
    UIView *shadowView = [[UIView alloc] initWithFrame:subview.frame];
    [shadowView setBackgroundColor:[UIColor clearColor]];
    
    UIBezierPath *shadowPath = [UIBezierPath bezierPathWithOvalInRect:subview.bounds];
    [self dropShadowWithPath:shadowPath options:options];
    
    shadowView.tag = tag;
    [self addSubview:shadowView];
    [self sendSubviewToBack:shadowView];
}

- (void)dropShadowWithPath:(UIBezierPath *)shadowPath options:(NSDictionary *)options {
    
    CGFloat verDeviation = [options valueForKey:@"ver_deviation"] ? [(NSNumber *)[options valueForKey:@"ver_deviation"] floatValue] : 0;
    CGFloat horDeviation = [options valueForKey:@"hor_deviation"] ? [(NSNumber *)[options valueForKey:@"hor_deviation"] floatValue] : 0;
    CGFloat intensity = [options valueForKey:@"intensity"] ? [(NSNumber *)[options valueForKey:@"intensity"] floatValue] : 1;
    
    self.layer.shadowPath = [shadowPath CGPath];
    self.layer.masksToBounds = NO;
    self.layer.shadowOffset = CGSizeMake(horDeviation * self.frame.size.width, verDeviation * self.frame.size.height);
    self.layer.shadowRadius = 10;
    [UIView animateWithDuration:2 delay:4 options:UIViewAnimationOptionCurveEaseOut animations:^{
        self.layer.shadowOpacity = intensity;
    } completion:nil];
    self.layer.shadowColor = [UIColor blackColor].CGColor;
}

@end
