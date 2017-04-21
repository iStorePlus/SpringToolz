//
//  CustomMasksAnimationManager.h
//  SpringToolzSampleProject
//
//  Created by Stoyan Stoyanov on 4/19/17.
//  Copyright © 2017 Stoyan Stoyanov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface CustomMasksAnimationManager : NSObject

+ (CustomMasksAnimationManager *)sharedInstance;

@property (nonatomic, assign) CGRect iconSize;

- (void)addMaskView:(UIView *)mask;
- (void)removeMaskView:(UIView *)mask;
- (void)animate;

- (UIBezierPath *)maskForName:(NSString *)name;
- (UIColor *)shadowColorForName:(NSString *)name;
@end
