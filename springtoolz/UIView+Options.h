//
//  UIView+Options.h
//  SpringToolzSampleProject
//
//  Created by Stoyan Stoyanov on 4/23/17.
//  Copyright © 2017 Stoyan Stoyanov. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Options)
- (void)applyPageIconOptions:(NSDictionary *)iconOptions withShadowOptions:(NSDictionary *)shadowOptions;
- (void)applyDockIconOptions:(NSDictionary *)iconOptions withShadowOptions:(NSDictionary *)shadowOptions;
@end
