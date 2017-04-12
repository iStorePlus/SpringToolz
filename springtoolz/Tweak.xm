#import <UIKit/UIKit.h>
#import "UIView+Round.h"

#pragma mark - Settings Related Stuff

static BOOL SHADOWS_ENABLED = YES;

static void loadPrefs() {
    NSMutableDictionary *prefs = [[NSMutableDictionary alloc] initWithContentsOfFile:@"/var/mobile/Library/Preferences/com.stoqn4opm.springtoolz.plist"];
    if(prefs) {
        SHADOWS_ENABLED = ([prefs objectForKey:@"shadows_enabled"] ? [[prefs objectForKey:@"shadows_enabled"] boolValue] : SHADOWS_ENABLED);
    }
}

%ctor {
    loadPrefs();
}

#pragma mark - Hooking

%hook UIView

- (void)willMoveToSuperview:(UIView *)newSuperview {
    if ([NSStringFromClass([self class]) isEqualToString:@"SBIconView"]) {
    	
		for (UIView *subview in [self subviews]) {
        	if ([NSStringFromClass([subview class]) isEqualToString:@"SBIconImageView"]) {
				
                if (SHADOWS_ENABLED) {
                    [subview dropShadow];
                }


                // [subview makeCircular];
        	}
    	}
    }
    %orig;
}

%end

