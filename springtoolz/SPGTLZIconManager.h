//
//  SPGTLZIconManager.h
//  SpringToolzSampleProject
//
//  Created by Stoyan Stoyanov on 4/19/17.
//  Copyright © 2017 Stoyan Stoyanov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface SPGTLZIconManager : NSObject

+ (SPGTLZIconManager *)sharedInstance;

@property (nonatomic, assign) CGRect iconSize;
@property (nonatomic, assign, readonly) BOOL isIconSizeSet;

@property (nonatomic, assign, readonly) NSTimeInterval animationDelay;
- (void)setAnimationDelayInstantly:(NSTimeInterval)delay;
- (void)setAnimationDelayWithDelay:(NSTimeInterval)animationDelay;

- (void)setPageIconsShapeName:(NSString *)pageIconsShapeName withRotation:(NSNumber *)rotation;
- (void)setDockIconsShapeName:(NSString *)dockIconsShapeName withRotation:(NSNumber *)rotation;

- (UIBezierPath *)shapeForPageIcons;
- (UIBezierPath *)shapeForDockIcons;

- (void)addMaskView:(UIView *)mask;
- (void)addSatellite:(UIView *)mask;
- (void)animateIfNeeded;

- (UIColor *)shadowColorForName:(NSString *)name;
@end
