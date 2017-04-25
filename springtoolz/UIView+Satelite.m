//
//  UIView+Satelite.m
//  SpringToolzSampleProject
//
//  Created by Stoyan Stoyanov on 4/25/17.
//  Copyright © 2017 Stoyan Stoyanov. All rights reserved.
//

#import "UIView+Satelite.h"

@implementation UIView (Satelite)

// self will have superview for sure
- (void)addSatellite {
    UIView *satelliteView = [[UIView alloc] initWithFrame:self.superview.frame];
    satelliteView.backgroundColor = [UIColor redColor];
    [self.superview addSubview:satelliteView];
}

@end
