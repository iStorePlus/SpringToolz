//
//  CABasicAnimation+Rotation.h
//  SpringToolzSampleProject
//
//  Created by Stoyan Stoyanov on 4/19/17.
//  Copyright © 2017 Stoyan Stoyanov. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

@interface CABasicAnimation (Rotation)
+ (CABasicAnimation *)endlessRotationForLayer:(CALayer *)layer withSpeed:(NSTimeInterval)speed;
@end
