//
//  CustomMasksAnimationManager.m
//  SpringToolzSampleProject
//
//  Created by Stoyan Stoyanov on 4/19/17.
//  Copyright © 2017 Stoyan Stoyanov. All rights reserved.
//

#import "CustomMasksAnimationManager.h"

@interface CustomMasksAnimationManager()

@property (nonatomic, strong) NSMutableArray<UIView *> *masks;
@property (nonatomic, assign) NSUInteger viewTagHelper;
@end

@implementation CustomMasksAnimationManager

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

- (UIBezierPath *)maskForName:(NSString *)name {
    
    return [UIBezierPath bezierPathWithOvalInRect:self.iconSize];
}

- (UIColor *)shadowColorForName:(NSString *)name {
    return [UIColor blackColor];
}

@end
