//
//  UIView+Shadow.h
//  SpringToolzSampleProject
//
//  Created by Stoyan Stoyanov on 4/23/17.
//  Copyright © 2017 Stoyan Stoyanov. All rights reserved.
//

#import <UIKit/UIKit.h>

#define SHADOW_TAG 0x00123f

@interface UIView (Shadow)

- (void)setShadowWithShape:(UIBezierPath *)shape;
- (void)removeShadow;

@end
