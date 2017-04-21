//
//  UIView+Round.m
//  IconsWithShadowsTestProject
//
//  Created by Stoyan Stoyanov on 4/12/17.
//  Copyright © 2017 Stoyan Stoyanov. All rights reserved.
//

#import "UIView+Round.h"
#import "SPGTLZIconManager.h"

#define SHADOW_TAG 0x00123f

@implementation UIView (Round)


#pragma mark - Public Methods

- (void)applyPageIconOptions:(NSDictionary *)iconOptions withShadowOptions:(NSDictionary *)shadowOptions {

    NSMutableDictionary *mutableIconOptions = [NSMutableDictionary dictionaryWithDictionary:iconOptions];
    [mutableIconOptions setValue:@"page_icon" forKey:@"icon_type"];
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        if (![[SPGTLZIconManager sharedInstance] isIconSizeSet]) {
            for (UIView *subview in [self subviews]) {
                if ([NSStringFromClass([subview class]) isEqualToString:@"SBIconImageView"] ||
                    [NSStringFromClass([subview class]) isEqualToString:@"SBClockApplicationIconImageView"]) {
                    
                    [[SPGTLZIconManager sharedInstance] setIconSize:subview.bounds];
                    break;
                }
            }
        }
        
        NSString *pageIconShape = (NSString *)[iconOptions valueForKey:@"shape"];
        [[SPGTLZIconManager sharedInstance] setPageIconsShapeName:pageIconShape];
    });
    
    [self applyIconOptions:mutableIconOptions withShadowOptions:shadowOptions];
}

- (void)applyDockIconOptions:(NSDictionary *)iconOptions withShadowOptions:(NSDictionary *)shadowOptions {
    
    NSMutableDictionary *mutableIconOptions = [NSMutableDictionary dictionaryWithDictionary:iconOptions];
    [mutableIconOptions setValue:@"dock_icon" forKey:@"icon_type"];
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{

        if (![[SPGTLZIconManager sharedInstance] isIconSizeSet]) {
            for (UIView *subview in [self subviews]) {
                if ([NSStringFromClass([subview class]) isEqualToString:@"SBIconImageView"] ||
                    [NSStringFromClass([subview class]) isEqualToString:@"SBClockApplicationIconImageView"]) {
                    
                    [[SPGTLZIconManager sharedInstance] setIconSize:subview.bounds];
                    break;
                }
            }
        }
        
        
        NSString *dockIconShape = (NSString *)[iconOptions valueForKey:@"shape"];
        [[SPGTLZIconManager sharedInstance] setDockIconsShapeName:dockIconShape];
    });
    
    [self applyIconOptions:mutableIconOptions withShadowOptions:shadowOptions];
}

#pragma mark - Internal Helpers

- (void)applyIconOptions:(NSMutableDictionary *)iconOptions withShadowOptions:(NSDictionary *)shadowOptions {
    
    NSNumber *shadowEnabled = (NSNumber *)[iconOptions valueForKey:@"shadows"];
    NSNumber *animationsEnabled = (NSNumber *)[iconOptions valueForKey:@"animations"];
    NSString *shadowColorName = (NSString *)[shadowOptions valueForKey:@"color"];
    NSNumber *shadowIntensity = (NSNumber *)[shadowOptions valueForKey:@"intensity"];
    NSNumber *shadowHorDeviation = (NSNumber *)[shadowOptions valueForKey:@"hor_deviation"];
    NSNumber *shadowVerDeviation = (NSNumber *)[shadowOptions valueForKey:@"ver_deviation"];
    
    
    if (shadowEnabled == nil || animationsEnabled == nil || shadowColorName == nil || shadowIntensity == nil || shadowHorDeviation == nil || shadowVerDeviation == nil) {
        return;
    }

    UIBezierPath *shape = nil;
    if ([(NSString *)[iconOptions valueForKey:@"icon_type"] isEqualToString:@"page_icon"]) {
        shape = [[SPGTLZIconManager sharedInstance] shapeForPageIcons];
    } else if ([(NSString *)[iconOptions valueForKey:@"icon_type"] isEqualToString:@"dock_icon"]) {
        shape = [[SPGTLZIconManager sharedInstance] shapeForDockIcons];
    }
    
    for (UIView *subview in [self subviews]) {
        if ([NSStringFromClass([subview class]) isEqualToString:@"SBIconImageView"] ||
            [NSStringFromClass([subview class]) isEqualToString:@"SBClockApplicationIconImageView"]) {

            [subview applyIconShape:shape shouldAnimate:animationsEnabled.boolValue];
            
            [subview applyShadow:shadowEnabled.boolValue
                       withShape:shape
          andHorizontalDeviation:shadowHorDeviation.floatValue
               verticalDeviation:shadowVerDeviation.floatValue
                       intensity:shadowIntensity.floatValue
                       colorName:shadowColorName];
        }
    }
}

- (void)applyIconShape:(UIBezierPath *)shape shouldAnimate:(BOOL)shouldAnimate {
    
    if (shape == nil) {
        self.maskView = nil;
        return;
    }

    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.path = shape.CGPath;
    
    UIView *mask = [[UIView alloc] initWithFrame:self.bounds];
    [mask.layer addSublayer:maskLayer];
    
    self.maskView = mask;
    self.superview.layer.shouldRasterize = TRUE;
    self.superview.layer.rasterizationScale = [UIScreen mainScreen].scale;
    
    if (shouldAnimate) {
        [[SPGTLZIconManager sharedInstance] addMaskView:mask];
    }
}

- (void)applyShadow:(BOOL)shadowEnabled withShape:(UIBezierPath *)shape andHorizontalDeviation:(CGFloat)horDeviation verticalDeviation:(CGFloat)verDeviation intensity:(CGFloat)intensity colorName:(NSString *)colorName {
    
    UIColor *color = [[SPGTLZIconManager sharedInstance] shadowColorForName:colorName];
    
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
