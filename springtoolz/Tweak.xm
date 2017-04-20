#import <UIKit/UIKit.h>
#import "UIView+Round.h"
#import "SBIconView.h"
#import "CustomMasksAnimationManager.h"

#pragma mark - Settings Related Stuff

static BOOL TweakEnabled = YES;

static NSString *PageIconShape = @"default";
static BOOL PageIconsShadowsEnabled = YES;
static BOOL PageIconsAnimationEnabled = NO;

static NSString *DockIconShape = @"default";
static BOOL DockIconsShadowsEnabled = YES;
static BOOL DockIconsAnimationEnabled = NO;

static NSString *ShadowColor = @"black";
static NSNumber *ShadowIntensity = @1;
static NSNumber *ShadowHorDeviation = @0;
static NSNumber *ShadowVerDeviation = @0;

static void loadPrefs() {
    NSMutableDictionary *prefs = [[NSMutableDictionary alloc] initWithContentsOfFile:@"/var/mobile/Library/Preferences/com.stoqn4opm.springtoolz.plist"];
    if(prefs) {
        
        TweakEnabled = [prefs objectForKey:@"tweak_enabled"] ? [[prefs objectForKey:@"tweak_enabled"] boolValue] : TweakEnabled;

        PageIconShape = [prefs objectForKey:@"page_icon_shape"] ? (NSString *)[prefs objectForKey:@"page_icon_shape"] : PageIconShape;
        PageIconsShadowsEnabled = [prefs objectForKey:@"page_icons_shadows_enabled"] ? [[prefs objectForKey:@"page_icons_shadows_enabled"] boolValue] : PageIconsShadowsEnabled;
        PageIconsAnimationEnabled = [prefs objectForKey:@"page_icons_animations_enabled"] ? [[prefs objectForKey:@"page_icons_animations_enabled"] boolValue] : PageIconsAnimationEnabled;

        DockIconShape = [prefs objectForKey:@"dock_icon_shape"] ? (NSString *)[prefs objectForKey:@"dock_icon_shape"] : DockIconShape;
        DockIconsShadowsEnabled = [prefs objectForKey:@"dock_icons_shadows_enabled"] ? [[prefs objectForKey:@"dock_icons_shadows_enabled"] boolValue] : DockIconsShadowsEnabled;
        DockIconsAnimationEnabled = [prefs objectForKey:@"dock_icons_animations_enabled"] ? [[prefs objectForKey:@"dock_icons_animations_enabled"] boolValue] : DockIconsAnimationEnabled;


        ShadowColor = [prefs objectForKey:@"shadow_color"] ? (NSString *)[prefs objectForKey:@"shadow_color"] : ShadowColor;
        ShadowIntensity = [prefs objectForKey:@"shadow_intensity"] ? [prefs objectForKey:@"shadow_intensity"] : ShadowIntensity;
        ShadowHorDeviation = [prefs objectForKey:@"shadow_hor_deviation"] ? [prefs objectForKey:@"shadow_hor_deviation"] : ShadowHorDeviation;
        ShadowVerDeviation = [prefs objectForKey:@"shadow_ver_deviation"] ? [prefs objectForKey:@"shadow_ver_deviation"] : ShadowVerDeviation;
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

        for (UIView *subview in [self subviews]) {
            if ([NSStringFromClass([subview class]) isEqualToString:@"SBIconImageView"] ||
                [NSStringFromClass([subview class]) isEqualToString:@"SBClockApplicationIconImageView"]) {
                    
                [[CustomMasksAnimationManager sharedInstance] removeMaskView:subview.maskView];
            }
        }

        return;
    }

    // if ([NSStringFromClass([newSuperview class]) isEqualToString:@"SBDockIconListView"]) {
    //     [self makeSubviewsCurcular:USE_CIRCULAR_ICONS_IN_DOCK withGearMaskEnabled:YES gearMaskOptions:@{@"sides_count": @3, @"rad_deviation": @2.5, @"speed" : @10} andWithShadow:SHADOWS_ENABLED_IN_DOCK andShadowOptions:SHADOW_OPTIONS];
    // } else {
    //     [self makeSubviewsCurcular:USE_CIRCULAR_ICONS withGearMaskEnabled:YES gearMaskOptions:@{@"sides_count": @3, @"rad_deviation": @2.5, @"speed" : @10} andWithShadow:SHADOWS_ENABLED andShadowOptions:SHADOW_OPTIONS];
    // }

    %orig;
}

%end

%hook SBLockScreenManager

- (void)unlockUIFromSource:(int)arg1 withOptions:(id)arg2 {
    %orig;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [[CustomMasksAnimationManager sharedInstance] animate];
    });
}

%end

    // UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"asd" message:@"dsfsdg" delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil];
    // [alert show];
