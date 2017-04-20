//
//  UIView+Round.m
//  IconsWithShadowsTestProject
//
//  Created by Stoyan Stoyanov on 4/12/17.
//  Copyright © 2017 Stoyan Stoyanov. All rights reserved.
//

#import "UIView+Round.h"
#import "UIBezierPath+CustomPaths.h"
#import "CABasicAnimation+Rotation.h"
#import "CustomMasksAnimationManager.h"

#define SHADOW_TAG 0x00123f

@implementation UIView (Round)

//    @"shape"
//    @"shadows"
//    @"animations"
//
//    @"color"
//    @"intensity"
//    @"hor_deviation"
//    @"ver_deviation"

- (void)applyIconOptions:(NSDictionary *)iconOptions withShadowOptions:(NSDictionary *)shadowOptions {
    
    NSString *shapeName = (NSString *)[iconOptions valueForKey:@"shape"];
    NSNumber *shadowEnabled = (NSNumber *)[iconOptions valueForKey:@"shadows"];
    NSNumber *animationsEnabled = (NSNumber *)[iconOptions valueForKey:@"animations"];
    NSString *shadowColor = (NSString *)[shadowOptions valueForKey:@"color"];
    NSNumber *shadowIntensity = (NSNumber *)[shadowOptions valueForKey:@"intensity"];
    NSNumber *shadowHorDeviation = (NSNumber *)[shadowOptions valueForKey:@"hor_deviation"];
    NSNumber *shadowVerDeviation = (NSNumber *)[shadowOptions valueForKey:@"ver_deviation"];
    
    
    if (shapeName == nil || shadowEnabled == nil || animationsEnabled == nil ||
        shadowColor == nil || shadowIntensity == nil || shadowHorDeviation == nil || shadowVerDeviation == nil) {
        return;
    }
    
    UIBezierPath *shape = [[CustomMasksAnimationManager sharedInstance] maskForName:shapeName];
    
    for (UIView *subview in [self subviews]) {
        if ([NSStringFromClass([subview class]) isEqualToString:@"SBIconImageView"] ||
            [NSStringFromClass([subview class]) isEqualToString:@"SBClockApplicationIconImageView"]) {
     
            [subview applyIconShape:shape];
        }
    }
}

- (void)makeSubviewsCurcular:(BOOL)circular
         withGearMaskEnabled:(BOOL)gearMask gearMaskOptions:(NSDictionary *)gearMaskOptions
               andWithShadow:(BOOL)shadow andShadowOptions:(NSDictionary *)shadowOptions {
    
    for (UIView *subview in [self subviews]) {
        if ([NSStringFromClass([subview class]) isEqualToString:@"SBIconImageView"] ||
            [NSStringFromClass([subview class]) isEqualToString:@"SBClockApplicationIconImageView"]) {
            
            
            if (gearMask) {
                [subview applyGearMaskWithOptions:gearMaskOptions];
                if (shadow) {
                    [self dropCircularShadowWithTag:SHADOW_TAG andOptions:shadowOptions behind:subview];
                }
                continue;
            }
            
            if (circular) {
                [subview makeCircular];
            }
            
            if (shadow) {
                if (circular) {
                    [self dropCircularShadowWithTag:SHADOW_TAG andOptions:shadowOptions behind:subview];
                } else {
                    [subview dropShadowWithOptions:shadowOptions];
                }
            }
        }
    }
}

- (void)applyIconShape:(UIBezierPath *)shape {
    
    if (shape == nil) {
        self.maskView = nil;
        return;
    }
    
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    
    maskLayer.path = shape.CGPath;
    maskLayer.transform = CATransform3DMakeTranslation(self.frame.size.width / 2.0, self.frame.size.height / 2.0, 0);
    
    UIView *mask = [[UIView alloc] initWithFrame:self.bounds];
    [mask.layer addSublayer:maskLayer];
    
    self.maskView = mask;
    
    self.superview.layer.shouldRasterize = TRUE;
    self.superview.layer.rasterizationScale = [UIScreen mainScreen].scale;
    
    [[CustomMasksAnimationManager sharedInstance] addMaskView:mask];
}


//    self.layer.allowsEdgeAntialiasing = TRUE;
//    mask.layer.allowsEdgeAntialiasing = TRUE;
//
//    self.layer.drawsAsynchronously = TRUE;
//    mask.layer.drawsAsynchronously = TRUE;
//    self.alpha = 1.0;
//    self.layer.opaque = YES;
//
//    mask.alpha = 1.0;
//    mask.layer.opaque = YES;

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

    self.layer.opaque = TRUE;
    container.layer.opaque = TRUE;
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

    self.layer.shadowOpacity = intensity;
    self.layer.shadowColor = [UIColor blackColor].CGColor;
}

@end
