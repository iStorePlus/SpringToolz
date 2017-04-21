//
//  CustomMasksAnimationManager.m
//  SpringToolzSampleProject
//
//  Created by Stoyan Stoyanov on 4/19/17.
//  Copyright © 2017 Stoyan Stoyanov. All rights reserved.
//

#import "CustomMasksAnimationManager.h"
#import "UIBezierPath+CustomPaths.h"

@interface CustomMasksAnimationManager()

@property (nonatomic, strong) NSMutableArray<UIView *> *masks;
@property (nonatomic, assign) NSUInteger viewTagHelper;
@end

@implementation CustomMasksAnimationManager {
    UIBezierPath *_currentMask;
}

#pragma mark - Singleton Refference

+ (instancetype)sharedInstance {
    static CustomMasksAnimationManager *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[CustomMasksAnimationManager alloc] init];
        sharedInstance.masks = [NSMutableArray new];
        sharedInstance.viewTagHelper = 0;
        
    });
    return sharedInstance;
}

#pragma mark - Public Methods

- (void)setIconSize:(CGRect)iconSize {
    CGFloat newLenght = iconSize.size.width * 0.9;
    CGFloat xDelta = iconSize.size.width - newLenght;
    CGFloat yDelta = iconSize.size.height - newLenght;
    
    _iconSize = CGRectMake( xDelta / 2.0, yDelta / 2.0, newLenght, newLenght);
}

- (void)addMaskView:(UIView *)mask {
    mask.tag = self.viewTagHelper;
    self.viewTagHelper++;
    
    [self.masks addObject:mask];
}

- (void)removeMaskView:(UIView *)mask {
    [self.masks removeObject:mask];
}

- (void)animate {
    [UIView animateWithDuration:5 delay:0 options:UIViewAnimationOptionRepeat | UIViewAnimationOptionShowHideTransitionViews | UIViewAnimationOptionAutoreverse | UIViewAnimationOptionBeginFromCurrentState animations:^{
        
        for (UIView *mask in self.masks) {
            mask.transform = CGAffineTransformMakeRotation(M_PI);
        }
        [self.masks removeAllObjects];
        
    } completion:nil];
}

/*
 supported icon shapes:
 default
 circle
 gear_wheel_1
 gear_wheel_2
 gear_wheel_3
 circle_radius_deviation
 */

- (UIBezierPath *)maskForName:(NSString *)name {
    
    if (_currentMask) {
        return _currentMask;
    }
    
    if ([name isEqualToString:@"default"]) {
        _currentMask = nil;
    } else if ([name isEqualToString:@"circle"]) {
        _currentMask = [UIBezierPath bezierPathWithOvalInRect:self.iconSize];
    } else if ([name isEqualToString:@"gear_wheel_1"]) {
        _currentMask = [UIBezierPath gearPathWithNumberOfSides:4 radiusDeviation:5 baseRadius:self.iconSize.size.width / 2.0];
    } else if ([name isEqualToString:@"gear_wheel_2"]) {
        _currentMask = [UIBezierPath gearPathWithNumberOfSides:12 radiusDeviation:2 baseRadius:self.iconSize.size.width / 2.0];
    } else if ([name isEqualToString:@"gear_wheel_3"]) {
        _currentMask = [UIBezierPath gearPathWithNumberOfSides:100 radiusDeviation:6 baseRadius:self.iconSize.size.width / 2.0];
    } else if ([name isEqualToString:@"circle_radius_deviation"]) {
        _currentMask = [UIBezierPath gearPathWithNumberOfSides:3 radiusDeviation:5 baseRadius:self.iconSize.size.width / 2.0];
    }
    
    return _currentMask;
}

/*
 supported color names:
 - black
 - green
 - blue
 - yellow
 - white
 - gray
 */

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
