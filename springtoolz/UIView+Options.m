//
//  UIView+Options.m
//  SpringToolzSampleProject
//
//  Created by Stoyan Stoyanov on 4/23/17.
//  Copyright © 2017 Stoyan Stoyanov. All rights reserved.
//

#import "UIView+Options.h"
#import "SPGTLZIconManager.h"
#import "UIView+Shape.h"
#import "UIView+Shadow.h"
#import "UIView+Satelite.h"

@implementation UIView (Options)

#pragma mark - Public Methods

- (void)applyPageIconOptions:(NSDictionary *)iconOptions withShadowOptions:(NSDictionary *)shadowOptions inRegardsTo:(UIView *)newSuperView andNewWindow:(UIWindow *)newWindow {
    
    NSMutableDictionary *mutableIconOptions = [NSMutableDictionary dictionaryWithDictionary:iconOptions];
    [mutableIconOptions setValue:@"page_icon" forKey:@"icon_type"];
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        if (![[SPGTLZIconManager sharedInstance] isIconSizeSet]) {
            for (UIView *subview in [self subviews]) {
                if ([NSStringFromClass([subview class]) isEqualToString:@"SBIconImageView"] ||
                    [NSStringFromClass([subview class]) isEqualToString:@"SBClockApplicationIconImageView"] ||
                    [NSStringFromClass([subview class]) isEqualToString:@"SBFolderIconImageView"]) {
                    
                    [[SPGTLZIconManager sharedInstance] setIconSize:subview.bounds];
                    break;
                }
            }
        }
        
        NSString *pageIconShape = (NSString *)[iconOptions valueForKey:@"shape"];
        NSNumber *pageIconShapeRotation = (NSNumber *)[iconOptions valueForKey:@"shape_rotation"];
        [[SPGTLZIconManager sharedInstance] setPageIconsShapeName:pageIconShape withRotation:pageIconShapeRotation];
    });
    [self prepareForReuseBecauseOfNewSuperView:newSuperView andNewWindow:newWindow];
    [self applyIconOptions:mutableIconOptions withShadowOptions:shadowOptions];
}

- (void)applyDockIconOptions:(NSDictionary *)iconOptions withShadowOptions:(NSDictionary *)shadowOptions inRegardsTo:(UIView *)newSuperView andNewWindow:(UIWindow *)newWindow {
    
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
        NSNumber *dockIconShapeRotation = (NSNumber *)[iconOptions valueForKey:@"shape_rotation"];
        [[SPGTLZIconManager sharedInstance] setDockIconsShapeName:dockIconShape withRotation:dockIconShapeRotation];
    });
    [self prepareForReuseBecauseOfNewSuperView:newSuperView andNewWindow:newWindow];
    [self applyIconOptions:mutableIconOptions withShadowOptions:shadowOptions];
}

#pragma mark - Internal Helpers

- (void)applyIconOptions:(NSMutableDictionary *)iconOptions withShadowOptions:(NSDictionary *)shadowOptions {
    
    NSNumber *shadowEnabled = (NSNumber *)[iconOptions valueForKey:@"shadows"];
    NSNumber *animationsEnabled = (NSNumber *)[iconOptions valueForKey:@"animations"];
    NSNumber *satellitesEnabled = (NSNumber *)[iconOptions valueForKey:@"satellites_enabled"];
    NSNumber *satellitesCount = (NSNumber *)[iconOptions valueForKey:@"satellites_count"];
    NSString *shadowColorName = (NSString *)[shadowOptions valueForKey:@"color"];
    NSNumber *shadowIntensity = (NSNumber *)[shadowOptions valueForKey:@"intensity"];
    NSNumber *shadowHorDeviation = (NSNumber *)[shadowOptions valueForKey:@"hor_deviation"];
    NSNumber *shadowVerDeviation = (NSNumber *)[shadowOptions valueForKey:@"ver_deviation"];
    
    if (shadowEnabled == nil || animationsEnabled == nil || shadowColorName == nil || shadowIntensity == nil || shadowHorDeviation == nil || shadowVerDeviation == nil || satellitesCount == nil || satellitesEnabled == nil) {
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
            
            [subview applyShadow:shadowEnabled.boolValue
                       withShape:shape
          andHorizontalDeviation:shadowHorDeviation.floatValue
               verticalDeviation:shadowVerDeviation.floatValue
                       intensity:shadowIntensity.floatValue
                       colorName:shadowColorName];
            
            if (satellitesEnabled.boolValue) {
                [subview addSatellites:satellitesCount.unsignedIntegerValue];
            }
            [subview applyIconShape:shape shouldAnimate:animationsEnabled.boolValue];
            break;
            
        } else if ([NSStringFromClass([subview class]) isEqualToString:@"SBFolderIconImageView"]) {
            
            BOOL shadowWillBeEnabled = [(NSNumber *)[iconOptions valueForKey:@"shadows_on_folders"] boolValue];
            BOOL shapeWillBeEnabled = [(NSNumber *)[iconOptions valueForKey:@"shape_on_folders"] boolValue];
            
            if (shadowWillBeEnabled) {
                UIBezierPath *folderShadowShape = shapeWillBeEnabled ? shape : nil;
                
                [subview applyShadow:shadowEnabled.boolValue
                           withShape:folderShadowShape
              andHorizontalDeviation:shadowHorDeviation.floatValue
                   verticalDeviation:shadowVerDeviation.floatValue
                           intensity:shadowIntensity.floatValue
                           colorName:shadowColorName];
            }
            if (satellitesEnabled.boolValue) {
                [subview addSatellites:satellitesCount.unsignedIntegerValue];
            }
            if (shapeWillBeEnabled) {
                [subview applyIconShape:shape shouldAnimate:animationsEnabled.boolValue];
            }
            break;
        }
    }
    
    UIView *shadowView = [self viewWithTag:SHADOW_TAG];
    UIView *shapeContainerView = [self viewWithTag:CONTAINER_SHAPE_VIEW_TAG];
    UIView *satellitesContainerView = [self viewWithTag:CONTAINER_SATELLITES_VIEW_TAG];
    
    [self insertSubview:shadowView atIndex:0];
    [self insertSubview:shapeContainerView atIndex:1];
    [self insertSubview:satellitesContainerView atIndex:2];
}

- (void)prepareForReuseBecauseOfNewSuperView:(UIView *)newSuperView andNewWindow:(UIWindow *)newWindow {
    
    NSString *newSuperViewClass = NSStringFromClass([newSuperView class]);
    NSString *oldSuperViewClass = NSStringFromClass([self.superview class]);
                                   
    BOOL shouldRemoveShape = NO;
    if (newWindow == nil) {
        shouldRemoveShape = true;
    } else if (![newSuperViewClass isEqualToString:oldSuperViewClass] &&
               ([newSuperViewClass isEqualToString:@"SBDockIconListView"] ||
                [newSuperViewClass isEqualToString:@"SBRootIconListView"] ||
               [newSuperViewClass isEqualToString:@"SBRecycledViewContainer"])) {
        shouldRemoveShape = true;
    }
    
    
    if (shouldRemoveShape) {
        UIView *oldShapeContainerView = [self viewWithTag:CONTAINER_SHAPE_VIEW_TAG];
        
        if (oldShapeContainerView != nil) {
            
            UIView *sbIconImageView = oldShapeContainerView.subviews.firstObject;
            
            if (sbIconImageView != nil) {
                [sbIconImageView removeFromSuperview];
                [oldShapeContainerView removeFromSuperview];
                [self addSubview:sbIconImageView];
            }
        }
        
        UIView *oldSatellitesContainerView = [self viewWithTag:CONTAINER_SATELLITES_VIEW_TAG];
        
        if (oldSatellitesContainerView != nil) {
            [oldSatellitesContainerView removeFromSuperview];
        }
    }
    
}

@end
