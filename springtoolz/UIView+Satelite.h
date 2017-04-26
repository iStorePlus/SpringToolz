//
//  UIView+Satelite.h
//  SpringToolzSampleProject
//
//  Created by Stoyan Stoyanov on 4/25/17.
//  Copyright © 2017 Stoyan Stoyanov. All rights reserved.
//

#import <UIKit/UIKit.h>
#define CONTAINER_SATELLITES_VIEW_TAG 0xbadF00d

@interface UIView (Satelite)
- (void)addSatellites:(NSUInteger)count;
- (void)orbit;
@end
