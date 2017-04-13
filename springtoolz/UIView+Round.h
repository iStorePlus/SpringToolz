//
//  UIView+Round.h
//  IconsWithShadowsTestProject
//
//  Created by Stoyan Stoyanov on 4/12/17.
//  Copyright © 2017 Stoyan Stoyanov. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Round)

- (void)makeSubviewsCurcular:(BOOL)circular andWithShadow:(BOOL)shadow andShadowOptions:(NSDictionary *)options;

@end