//
//  UIView+Round.h
//  IconsWithShadowsTestProject
//
//  Created by Stoyan Stoyanov on 4/12/17.
//  Copyright © 2017 Stoyan Stoyanov. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Round)

- (void)makeCircular;
- (void)dropShadowWithOptions:(NSDictionary *)options;
- (void)dropCircularShadowWithTag:(NSInteger)tag andOptions:(NSDictionary *)options behind:(UIView *)subview;

@end
