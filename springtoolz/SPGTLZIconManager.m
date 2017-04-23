//
//  SPGTLZIconManager.m
//  SpringToolzSampleProject
//
//  Created by Stoyan Stoyanov on 4/19/17.
//  Copyright © 2017 Stoyan Stoyanov. All rights reserved.
//

#import "SPGTLZIconManager.h"
#import "UIBezierPath+CustomPaths.h"
#import "UIView+DominantColor.h"

@interface SPGTLZIconManager()

@property (nonatomic, assign) BOOL isIconSizeSet;

@property (nonatomic, strong) NSMutableArray<UIView *> *masks;

@property (nonatomic, strong) UIBezierPath *pageIconsShape;
@property (nonatomic, strong) UIBezierPath *dockIconsShape;

@property (nonatomic, strong) NSTimer *animationTimer;
@end

@implementation SPGTLZIconManager

#pragma mark - Singleton Reference

+ (instancetype)sharedInstance {
    static SPGTLZIconManager *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[SPGTLZIconManager alloc] init];
        sharedInstance.masks = [NSMutableArray new];
    });
    return sharedInstance;
}

#pragma mark - Shape Animation

- (void)addMaskView:(UIView *)mask {
    [self.masks addObject:mask];
}

- (void)animateIfNeeded {
    [self.animationTimer invalidate];
    self.animationTimer = [NSTimer scheduledTimerWithTimeInterval:4 target:self selector:@selector(animate) userInfo:nil repeats:NO];
}

- (void)animate {
    [UIView animateWithDuration:5 delay:0 options:UIViewAnimationOptionRepeat | UIViewAnimationOptionShowHideTransitionViews | UIViewAnimationOptionAutoreverse | UIViewAnimationOptionBeginFromCurrentState animations:^{
        
        for (UIView *mask in self.masks) {
            mask.transform = CGAffineTransformMakeRotation(M_PI);
        }
        [self.masks removeAllObjects];
        
    } completion:nil];
}

#pragma mark - Icon Shapes

// supported icon shapes: default, circle, gear_wheel_1, gear_wheel_2, gear_wheel_3, circle_radius_deviation

- (void)setIconSize:(CGRect)iconSize {
    CGFloat newLenght = iconSize.size.width * 0.88;
    CGFloat xDelta = iconSize.size.width - newLenght;
    CGFloat yDelta = iconSize.size.height - newLenght;
    
    _iconSize = CGRectMake( xDelta / 2.0, yDelta / 2.0, newLenght, newLenght);
    self.isIconSizeSet = YES;
}

- (void)setPageIconsShapeName:(NSString *)pageIconsShapeName {
    self.pageIconsShape = [self shapeForName:pageIconsShapeName];
}

- (void)setDockIconsShapeName:(NSString *)dockIconsShapeName {
    self.dockIconsShape = [self shapeForName:dockIconsShapeName];
}

- (UIBezierPath *)shapeForPageIcons {
    return self.pageIconsShape;
}

- (UIBezierPath *)shapeForDockIcons {
    return self.dockIconsShape;
}

- (UIBezierPath *)shapeForName:(NSString *)name {
    
    if ([name isEqualToString:@"default"]) {
        return nil;
    } else if ([name isEqualToString:@"circle"]) {
        return [UIBezierPath bezierPathWithOvalInRect:self.iconSize];
    } else if ([name isEqualToString:@"gear_wheel_1"]) {
        return [UIBezierPath gearPathWithNumberOfSides:4 radiusDeviation:5 iconSize:self.iconSize];
    } else if ([name isEqualToString:@"gear_wheel_2"]) {
        return [UIBezierPath gearPathWithNumberOfSides:12 radiusDeviation:2 iconSize:self.iconSize];
    } else if ([name isEqualToString:@"gear_wheel_3"]) {
        return [UIBezierPath gearPathWithNumberOfSides:100 radiusDeviation:6 iconSize:self.iconSize];
    } else if ([name isEqualToString:@"circle_radius_deviation"]) {
        return [UIBezierPath gearPathWithNumberOfSides:3 radiusDeviation:5 iconSize:self.iconSize];
    }
    
    return nil;
}

#pragma mark - Icon Shadows

// supported color names: black, green, blue, yellow, white, gray

- (UIColor *)shadowColorWithName:(NSString *)name forView:(UIView *)view {
    
    if ([name isEqualToString:@"black"]) {
        return [UIColor blackColor];
    } else if ([name isEqualToString:@"green"]) {
        return [UIColor greenColor];
    } else if ([name isEqualToString:@"blue"]) {
        return [UIColor blueColor];
    } else if ([name isEqualToString:@"yellow"]) {
        return [UIColor yellowColor];
    } else if ([name isEqualToString:@"white"]) {
        return [UIColor whiteColor];
    } else if ([name isEqualToString:@"gray"]) {
        return [UIColor grayColor];
    } else if ([name isEqualToString:@"dominant"]) {
        return [view dominantColorInRect:view.frame];
    }
    return nil;
}

@end
