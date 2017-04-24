//
//  SPGTLZIconManager.m
//  SpringToolzSampleProject
//
//  Created by Stoyan Stoyanov on 4/19/17.
//  Copyright © 2017 Stoyan Stoyanov. All rights reserved.
//

#import "SPGTLZIconManager.h"
#import "UIBezierPath+CustomPaths.h"

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

// supported icon shapes: default, circle, gear_wheel_1, gear_wheel_2, gear_wheel_3, circle_radius_deviation, sine_circle_1, sine_circle_2, sine_circle_3, sine_circle_4, sine_circle_5, sine_circle_6

- (void)setIconSize:(CGRect)iconSize {
    CGFloat newLenght = iconSize.size.width * 0.88;
    CGFloat xDelta = iconSize.size.width - newLenght;
    CGFloat yDelta = iconSize.size.height - newLenght;
    
    _iconSize = CGRectMake( xDelta / 2.0, yDelta / 2.0, newLenght, newLenght);
    self.isIconSizeSet = YES;
}

- (void)setPageIconsShapeName:(NSString *)pageIconsShapeName withRotation:(NSNumber *)rotation {
    UIBezierPath *shape = [self shapeForName:pageIconsShapeName];
    [shape applyTransform:CGAffineTransformMakeRotation(rotation.floatValue)];
    [shape applyTransform:CGAffineTransformMakeTranslation(self.iconSize.size.width / 2.0 + self.iconSize.origin.x,
                                                           self.iconSize.size.width / 2.0 + self.iconSize.origin.y)];
    self.pageIconsShape = shape;
}

- (void)setDockIconsShapeName:(NSString *)dockIconsShapeName withRotation:(NSNumber *)rotation {
    UIBezierPath *shape = [self shapeForName:dockIconsShapeName];
    [shape applyTransform:CGAffineTransformMakeRotation(rotation.floatValue)];
    [shape applyTransform:CGAffineTransformMakeTranslation(self.iconSize.size.width / 2.0 + self.iconSize.origin.x,
                                                           self.iconSize.size.width / 2.0 + self.iconSize.origin.y)];
    self.dockIconsShape = shape;
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
        return [UIBezierPath gearPathWithNumberOfSides:24 radiusDeviation:2.5 iconSize:self.iconSize];
    } else if ([name isEqualToString:@"gear_wheel_2"]) {
        return [UIBezierPath gearPathWithNumberOfSides:12 radiusDeviation:4 iconSize:self.iconSize];
    } else if ([name isEqualToString:@"gear_wheel_3"]) {
        return [UIBezierPath gearPathWithNumberOfSides:100 radiusDeviation:2 iconSize:self.iconSize];
    } else if ([name isEqualToString:@"gear_wheel_4"]) {
        return [UIBezierPath gearPathWithNumberOfSides:6 radiusDeviation:5 iconSize:self.iconSize];
    } else if ([name isEqualToString:@"gear_wheel_5"]) {
        return [UIBezierPath gearPathWithNumberOfSides:12 radiusDeviation:5 iconSize:self.iconSize];
    } else if ([name isEqualToString:@"gear_wheel_6"]) {
        return [UIBezierPath gearPathWithNumberOfSides:100 radiusDeviation:4 iconSize:self.iconSize];
    } else if ([name isEqualToString:@"circle_radius_deviation"]) {
        return [UIBezierPath gearPathWithNumberOfSides:3 radiusDeviation:5 iconSize:self.iconSize];
    } else if ([name isEqualToString:@"sine_circle_1"]) {
        return [UIBezierPath sineCircleWithCountOfBumps:16 andDeviation:3 iconSize:self.iconSize];
    } else if ([name isEqualToString:@"sine_circle_2"]) {
        return [UIBezierPath sineCircleWithCountOfBumps:10 andDeviation:3 iconSize:self.iconSize];
    } else if ([name isEqualToString:@"sine_circle_3"]) {
        return [UIBezierPath sineCircleWithCountOfBumps:32 andDeviation:3 iconSize:self.iconSize];
    } else if ([name isEqualToString:@"sine_circle_4"]) {
        return [UIBezierPath sineCircleWithCountOfBumps:16 andDeviation:1.8 iconSize:self.iconSize];
    } else if ([name isEqualToString:@"sine_circle_5"]) {
        return [UIBezierPath sineCircleWithCountOfBumps:10 andDeviation:1.8 iconSize:self.iconSize];
    } else if ([name isEqualToString:@"sine_circle_6"]) {
        return [UIBezierPath sineCircleWithCountOfBumps:32 andDeviation:1.8 iconSize:self.iconSize];
    } else if ([name isEqualToString:@"hexagon"]) {
        return [UIBezierPath regularPolygonWithCountOfSides:6 iconSize:self.iconSize];
    } else if ([name isEqualToString:@"octagon"]) {
        return [UIBezierPath regularPolygonWithCountOfSides:8 iconSize:self.iconSize];
    } else if ([name isEqualToString:@"circle_with_notch_1"]) {
        return [UIBezierPath circleWithNotchWidth:M_PI_4 / 2.0 notchDepth:10 iconSize:self.iconSize];
    } else if ([name isEqualToString:@"circle_with_notch_2"]) {
        return [UIBezierPath circleWithNotchWidth:M_PI_4 / 2.0 notchDepth:4 iconSize:self.iconSize];
    } else if ([name isEqualToString:@"circle_with_notch_3"]) {
        return [UIBezierPath circleWithNotchWidth:M_PI_4 notchDepth:3 iconSize:self.iconSize];
    }
    
    
    return nil;
}

#pragma mark - Icon Shadows

// supported color names: black, green, blue, yellow, white, gray

- (UIColor *)shadowColorForName:(NSString *)name {
    
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
    }
    return nil;
}
@end
