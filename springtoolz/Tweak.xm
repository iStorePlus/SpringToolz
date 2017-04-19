#import <UIKit/UIKit.h>
#import "UIView+Round.h"
#import "SBIconView.h"
#import "CustomMasksAnimationManager.h"

#pragma mark - Settings Related Stuff

static BOOL USE_CIRCULAR_ICONS = YES;
static BOOL SHADOWS_ENABLED = YES;

static BOOL USE_CIRCULAR_ICONS_IN_DOCK = YES;
static BOOL SHADOWS_ENABLED_IN_DOCK = YES;

static NSDictionary *SHADOW_OPTIONS = nil;

static void loadPrefs() {
    NSMutableDictionary *prefs = [[NSMutableDictionary alloc] initWithContentsOfFile:@"/var/mobile/Library/Preferences/com.stoqn4opm.springtoolz.plist"];
    if(prefs) {
        
        USE_CIRCULAR_ICONS = ([prefs objectForKey:@"circular_icons_enabled"] ? [[prefs objectForKey:@"circular_icons_enabled"] boolValue] : USE_CIRCULAR_ICONS);
        SHADOWS_ENABLED = ([prefs objectForKey:@"shadows_enabled"] ? [[prefs objectForKey:@"shadows_enabled"] boolValue] : SHADOWS_ENABLED);
        
        USE_CIRCULAR_ICONS_IN_DOCK = ([prefs objectForKey:@"circular_icons_in_dock_enabled"] ? [[prefs objectForKey:@"circular_icons_in_dock_enabled"] boolValue] : USE_CIRCULAR_ICONS_IN_DOCK);
        SHADOWS_ENABLED_IN_DOCK = ([prefs objectForKey:@"shadows_in_dock_enabled"] ? [[prefs objectForKey:@"shadows_in_dock_enabled"] boolValue] : SHADOWS_ENABLED_IN_DOCK);

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

- (void)prepareForReuse {
    %orig;
    [[CustomMasksAnimationManager sharedInstance] animate];
}

- (void)willMoveToSuperview:(UIView *)newSuperview {

    if (newSuperview == nil) {
        return;
    }

    if ([NSStringFromClass([newSuperview class]) isEqualToString:@"SBDockIconListView"]) {
        [self makeSubviewsCurcular:USE_CIRCULAR_ICONS_IN_DOCK withGearMaskEnabled:YES gearMaskOptions:@{@"sides_count": @16, @"rad_deviation": @5, @"speed" : @5} andWithShadow:SHADOWS_ENABLED_IN_DOCK andShadowOptions:SHADOW_OPTIONS];
    } else {
        [self makeSubviewsCurcular:USE_CIRCULAR_ICONS withGearMaskEnabled:YES gearMaskOptions:@{@"sides_count": @16, @"rad_deviation": @5, @"speed" : @5} andWithShadow:SHADOWS_ENABLED andShadowOptions:SHADOW_OPTIONS];
    }

    %orig;
}

%end

%hook SBLockScreenManager

- (void)unlockUIFromSource:(int)arg1 withOptions:(id)arg2 {
    %orig;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [[CustomMasksAnimationManager sharedInstance] animate];
    });
}

%end

    // UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"asd" message:@"dsfsdg" delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil];
    // [alert show];
