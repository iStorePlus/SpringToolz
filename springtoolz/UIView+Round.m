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

- (void)applyIconOptions:(NSDictionary *)iconOptions withShadowOptions:(NSDictionary *)shadowOptions {
    
    NSString *shapeName = (NSString *)[iconOptions valueForKey:@"shape"];
    NSNumber *shadowEnabled = (NSNumber *)[iconOptions valueForKey:@"shadows"];
    NSNumber *animationsEnabled = (NSNumber *)[iconOptions valueForKey:@"animations"];
    NSString *shadowColorName = (NSString *)[shadowOptions valueForKey:@"color"];
    NSNumber *shadowIntensity = (NSNumber *)[shadowOptions valueForKey:@"intensity"];
    NSNumber *shadowHorDeviation = (NSNumber *)[shadowOptions valueForKey:@"hor_deviation"];
    NSNumber *shadowVerDeviation = (NSNumber *)[shadowOptions valueForKey:@"ver_deviation"];
    
    
    if (shapeName == nil || shadowEnabled == nil || animationsEnabled == nil ||
        shadowColorName == nil || shadowIntensity == nil || shadowHorDeviation == nil || shadowVerDeviation == nil) {
        return;
    }
    
    
    for (UIView *subview in [self subviews]) {
        if ([NSStringFromClass([subview class]) isEqualToString:@"SBIconImageView"] ||
            [NSStringFromClass([subview class]) isEqualToString:@"SBClockApplicationIconImageView"]) {
     
            static dispatch_once_t onceToken;
            dispatch_once(&onceToken, ^{
                [[CustomMasksAnimationManager sharedInstance] setIconSize:subview.bounds];
            });
            
            [subview applyIconShapeWithName:shapeName];
            
            [subview applyShadow:shadowEnabled.boolValue
                   withShapeName:shapeName
          andHorizontalDeviation:shadowHorDeviation.floatValue
               verticalDeviation:shadowVerDeviation.floatValue
                       intensity:shadowIntensity.floatValue
                       colorName:shadowColorName];
        }
    }
}

#pragma mark - Internal Helpers

- (void)applyIconShapeWithName:(NSString *)shapeName {
    
    UIBezierPath *shape = [[CustomMasksAnimationManager sharedInstance] maskForName:shapeName];
    
    if (shape == nil) {
        self.maskView = nil;
        return;
    }

    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    
    maskLayer.path = shape.CGPath;
//    maskLayer.transform = CATransform3DMakeTranslation(self.frame.size.width / 2.0, self.frame.size.height / 2.0, 0);
    
    UIView *mask = [[UIView alloc] initWithFrame:self.bounds];
    [mask.layer addSublayer:maskLayer];
    
    self.maskView = mask;
    
    self.superview.layer.shouldRasterize = TRUE;
    self.superview.layer.rasterizationScale = [UIScreen mainScreen].scale;
    
    [[CustomMasksAnimationManager sharedInstance] addMaskView:mask];
}

- (void)applyShadow:(BOOL)shadowEnabled withShapeName:(NSString *)shapeName andHorizontalDeviation:(CGFloat)horDeviation verticalDeviation:(CGFloat)verDeviation intensity:(CGFloat)intensity colorName:(NSString *)colorName {
    
    UIBezierPath *shape = [[CustomMasksAnimationManager sharedInstance] maskForName:shapeName];
    UIColor *color = [[CustomMasksAnimationManager sharedInstance] shadowColorForName:colorName];
    
    if (shadowEnabled == NO || color == nil || self.superview == nil) {
        return;
    }
    
    for (UIView *subview in self.superview.subviews) {
        if(subview.tag == SHADOW_TAG) {
            return;
        }
    }
    
    if (shape == nil) {
        shape = [UIBezierPath bezierPathWithRect:self.bounds];
    }
    
    UIView *shadowView = [[UIView alloc] initWithFrame:self.frame];
    shadowView.tag = SHADOW_TAG;
    
    shadowView.layer.shadowPath = [shape CGPath];
    shadowView.layer.masksToBounds = NO;
    shadowView.layer.shadowOffset = CGSizeMake(horDeviation * self.frame.size.width, verDeviation * self.frame.size.height);
    shadowView.layer.shadowRadius = 10;
    
    shadowView.layer.shadowOpacity = intensity;
    shadowView.layer.shadowColor = color.CGColor;
    
    [self.superview addSubview:shadowView];
    [self.superview sendSubviewToBack:shadowView];
}

@end
