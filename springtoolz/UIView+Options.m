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

#pragma mark - Public Methods for SBIconView

- (void)applyPageIconOptions {
    NSDictionary *pageIconOptions = [[SPGTLZIconManager sharedInstance] pageIconOptions];
    UIBezierPath *shape = [[SPGTLZIconManager sharedInstance] iconShapeForOptions:pageIconOptions];
    
//    [self applyIconShapeOnImageView:shape];
    
    if ([(NSNumber *)pageIconOptions[@"shadow_enabled"] boolValue]) {
        [self removeSatellites];
        [self setShadowWithShape:shape];
    } else {
        [self removeShadow];
    }

    if ([(NSNumber *)pageIconOptions[@"satellites_enabled"] boolValue]) {
        NSUInteger satellitesCount = [(NSNumber *)pageIconOptions[@"satellites_count"] floatValue];
        [self addSatellites:satellitesCount];
    } else {
        [self removeSatellites];
    }

    [self applyOrder];
}

- (void)applyDockIconOptions {
    NSDictionary *dockIconOptions = [[SPGTLZIconManager sharedInstance] dockIconOptions];
    UIBezierPath *shape = [[SPGTLZIconManager sharedInstance] iconShapeForOptions:dockIconOptions];
//    [self applyIconShapeOnImageView:shape];
    
    if ([(NSNumber *)dockIconOptions[@"shadow_enabled"] boolValue]) {
        [self setShadowWithShape:shape];
    } else {
        [self removeShadow];
    }
    
    if ([(NSNumber *)dockIconOptions[@"satellites_enabled"] boolValue]) {
        NSUInteger satellitesCount = [(NSNumber *)dockIconOptions[@"satellites_count"] floatValue];
        [self removeSatellites];
        [self addSatellites:satellitesCount];
    } else {
        [self removeSatellites];
    }
    
    
    [self applyOrder];
}

#pragma mark - Internal Helpers

- (void)applyIconShapeOnImageView:(UIBezierPath *)shape {
    
    [self removeIconShape];
    
    for (UIView *subview in [self subviews]) {
        if ([NSStringFromClass([subview class]) isEqualToString:@"SBIconImageView"] ||
            [NSStringFromClass([subview class]) isEqualToString:@"SBClockApplicationIconImageView"]) {
            
            [subview setIconShape:shape];
            break;
        }
    }
}

- (void)applyOrder {
    UIView *shapeContainer = [self viewWithTag:CONTAINER_SHAPE_VIEW_TAG];
    UIView *satellitesContainer = [self viewWithTag:CONTAINER_SATELLITES_VIEW_TAG];
    UIView *shadowContainer = [self viewWithTag:SHADOW_TAG];
    
    if (shapeContainer) {
        [self sendSubviewToBack:shapeContainer];
    }
    
    if (satellitesContainer) {
        [self sendSubviewToBack:satellitesContainer];
    }
    
    if (shadowContainer) {
        [self sendSubviewToBack:shadowContainer];
    }
}

@end
