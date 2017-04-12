#import <UIKit/UIKit.h>
#import "UIView+Round.h"

#pragma mark - Hooking

%hook UIView

- (void)willMoveToSuperview:(UIView *)newSuperview {
    if ([NSStringFromClass([self class]) isEqualToString:@"SBIconView"]) {
    	
		for (UIView *subview in [self subviews]) {
        	if ([NSStringFromClass([subview class]) isEqualToString:@"SBIconImageView"]) {
				[subview dropShadow];
                // [subview makeCircular];
        	}
    	}
    }
    %orig;
}

%end

