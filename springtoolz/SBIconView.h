//
//  UIView+Round.h
//  IconsWithShadowsTestProject
//
//  Created by Stoyan Stoyanov on 4/12/17.
//  Copyright © 2017 Stoyan Stoyanov. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SBIconView: UIView
- (BOOL)isInDock; // not working properly for now
- (struct CGPoint)iconImageCenter;
- (struct CGRect)iconImageFrame;
@end


@interface SBIconImageView: UIImageView
@end


@interface SBRootIconListView: UIView
- (void)applyOptionsForIcon:(SBIconView *)icon;
@end
