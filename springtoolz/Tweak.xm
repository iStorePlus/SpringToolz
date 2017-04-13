#import <UIKit/UIKit.h>
#import "UIView+Round.h"
#import "SBIconView.h"

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

%hook SBIconView

- (void)willMoveToSuperview:(UIView *)newSuperview {
	
	for (UIView *subview in [self subviews]) {
    	if ([NSStringFromClass([subview class]) isEqualToString:@"SBIconImageView"]) {
			
            if (SHADOWS_ENABLED) {
                // [subview dropShadow];
            }
            [subview makeCircular];
            
            [self dropCircularShadowWithTag:0x00123f behind:subview];

    	}
	}
    
    %orig;
}

%end

