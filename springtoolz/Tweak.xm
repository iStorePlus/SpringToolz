#import <UIKit/UIKit.h>
#import "UIView+Round.h"
#import "SBIconView.h"

#pragma mark - Settings Related Stuff

static BOOL USE_CIRCULAR_ICONS = YES;
static BOOL SHADOWS_ENABLED = YES;
static NSDictionary *SHADOW_OPTIONS = nil;

static void loadPrefs() {
    NSMutableDictionary *prefs = [[NSMutableDictionary alloc] initWithContentsOfFile:@"/var/mobile/Library/Preferences/com.stoqn4opm.springtoolz.plist"];
    if(prefs) {
        
        USE_CIRCULAR_ICONS = ([prefs objectForKey:@"circular_icons_enabled"] ? [[prefs objectForKey:@"circular_icons_enabled"] boolValue] : USE_CIRCULAR_ICONS);
        SHADOWS_ENABLED = ([prefs objectForKey:@"shadows_enabled"] ? [[prefs objectForKey:@"shadows_enabled"] boolValue] : SHADOWS_ENABLED);
        
        NSNumber *intensity = ([prefs objectForKey:@"intensity"] ? [prefs objectForKey:@"intensity"] : @1);
        NSNumber *horDeviation = ([prefs objectForKey:@"hor_deviation"] ? [prefs objectForKey:@"hor_deviation"] : @0);
        NSNumber *verDeviation = ([prefs objectForKey:@"ver_deviation"] ? [prefs objectForKey:@"ver_deviation"] : @0);
        
        SHADOW_OPTIONS = @{ @"ver_deviation" : verDeviation,
                            @"hor_deviation" : horDeviation,
                            @"intensity"    : intensity };
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
			
            if (USE_CIRCULAR_ICONS) {
                [subview makeCircular];
            }

            if (SHADOWS_ENABLED) {
                if (USE_CIRCULAR_ICONS) {
                    [self dropCircularShadowWithTag:0x00123f andOptions:SHADOW_OPTIONS behind:subview];
                } else {
                    [subview dropShadowWithOptions:SHADOW_OPTIONS];
                }
            }
    	}
	}
    
    %orig;
}

%end

