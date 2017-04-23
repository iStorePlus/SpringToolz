//
//  UIView+Shape.h
//  SpringToolzSampleProject
//
//  Created by Stoyan Stoyanov on 4/23/17.
//  Copyright © 2017 Stoyan Stoyanov. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Shape)
- (void)applyIconShape:(UIBezierPath *)shape shouldAnimate:(BOOL)shouldAnimate;
@end
