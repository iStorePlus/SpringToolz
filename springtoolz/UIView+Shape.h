//
//  UIView+Shape.h
//  SpringToolzSampleProject
//
//  Created by Stoyan Stoyanov on 4/23/17.
//  Copyright © 2017 Stoyan Stoyanov. All rights reserved.
//

#import <UIKit/UIKit.h>
#define CONTAINER_SHAPE_VIEW_TAG 0x234FFAC

@interface UIView (Shape)
- (void)setIconShape:(UIBezierPath *)shape;
- (void)removeIconShape;
@end
