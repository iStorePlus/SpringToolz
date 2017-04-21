#import <UIKit/UIKit.h>
#import "UIView+Round.h"
#import "SBIconView.h"
#import "CustomMasksAnimationManager.h"

#pragma mark - Settings Defaults

static BOOL TweakEnabled = YES;

static NSString *DEFAULT_PAGE_ICON_SHAPE = @"default";
static BOOL DEFAULT_PAGE_ICON_SHADOWS_ENABLED = YES;
static BOOL DEFAULT_PAGE_ICON_ANIMATIONS_ENABLED = NO;

static NSString *DEFAULT_DOCK_ICON_SHAPE = @"default";
static BOOL DEFAULT_DOCK_ICON_SHADOWS_ENABLED = YES;
static BOOL DEFAULT_DOCK_ICON_ANIMATIONS_ENABLED = NO;

static NSString *DEFAULT_SHADOW_COLOR = @"black";
static CGFloat DEFAULT_SHADOW_INTENSITY = 1.0;
static CGFloat DEFAULT_SHADOW_HOR_DEVIATION = 0.0;
static CGFloat DEFAULT_SHADOW_VER_DEVIATION = 0.0;

#pragma mark - Settings Loading

static NSDictionary *PageIconOptions = nil;
static NSDictionary *DockIconOptions = nil;
static NSDictionary *ShadowOptions = nil;

static void loadPrefs() {
    NSMutableDictionary *prefs = [[NSMutableDictionary alloc] initWithContentsOfFile:@"/var/mobile/Library/Preferences/com.stoqn4opm.springtoolz.plist"];
    if(prefs) {
        
        TweakEnabled = [prefs objectForKey:@"tweak_enabled"] ? [[prefs objectForKey:@"tweak_enabled"] boolValue] : TweakEnabled;

        NSString *pageIconShape = [prefs objectForKey:@"page_icon_shape"] ? (NSString *)[prefs objectForKey:@"page_icon_shape"] : DEFAULT_PAGE_ICON_SHAPE;
        BOOL pageIconsShadowsEnabled = [prefs objectForKey:@"page_icons_shadows_enabled"] ? [[prefs objectForKey:@"page_icons_shadows_enabled"] boolValue] : DEFAULT_PAGE_ICON_SHADOWS_ENABLED;
        BOOL pageIconsAnimationEnabled = [prefs objectForKey:@"page_icons_animations_enabled"] ? [[prefs objectForKey:@"page_icons_animations_enabled"] boolValue] : DEFAULT_PAGE_ICON_ANIMATIONS_ENABLED;

        PageIconOptions = @{
            @"shape" : pageIconShape,
            @"shadows" : @(pageIconsShadowsEnabled),
            @"animations" : @(pageIconsAnimationEnabled)
        };

        NSString *dockIconShape = [prefs objectForKey:@"dock_icon_shape"] ? (NSString *)[prefs objectForKey:@"dock_icon_shape"] : DEFAULT_DOCK_ICON_SHAPE;
        BOOL dockIconsShadowsEnabled = [prefs objectForKey:@"dock_icons_shadows_enabled"] ? [[prefs objectForKey:@"dock_icons_shadows_enabled"] boolValue] : DEFAULT_DOCK_ICON_SHADOWS_ENABLED;
        BOOL dockIconsAnimationEnabled = [prefs objectForKey:@"dock_icons_animations_enabled"] ? [[prefs objectForKey:@"dock_icons_animations_enabled"] boolValue] : DEFAULT_DOCK_ICON_ANIMATIONS_ENABLED;

        DockIconOptions = @{
            @"shape"        : dockIconShape,
            @"shadows"      : @(dockIconsShadowsEnabled),
            @"animations"   : @(dockIconsAnimationEnabled)
        };


        NSString *shadowColor = [prefs objectForKey:@"shadow_color"] ? (NSString *)[prefs objectForKey:@"shadow_color"] : DEFAULT_SHADOW_COLOR;
        NSNumber *shadowIntensity = [prefs objectForKey:@"shadow_intensity"] ? [prefs objectForKey:@"shadow_intensity"] : @(DEFAULT_SHADOW_INTENSITY);
        NSNumber *shadowHorDeviation = [prefs objectForKey:@"shadow_hor_deviation"] ? [prefs objectForKey:@"shadow_hor_deviation"] : @(DEFAULT_SHADOW_HOR_DEVIATION);
        NSNumber *shadowVerDeviation = [prefs objectForKey:@"shadow_ver_deviation"] ? [prefs objectForKey:@"shadow_ver_deviation"] : @(DEFAULT_SHADOW_VER_DEVIATION);

        ShadowOptions = @{
            @"color"            : shadowColor,
            @"intensity"        : shadowIntensity,
            @"hor_deviation"    : shadowHorDeviation,
            @"ver_deviation"    : shadowVerDeviation
        };
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

        // for (UIView *subview in [self subviews]) {
        //     if ([NSStringFromClass([subview class]) isEqualToString:@"SBIconImageView"] ||
        //         [NSStringFromClass([subview class]) isEqualToString:@"SBClockApplicationIconImageView"]) {
                    
        //         [[CustomMasksAnimationManager sharedInstance] removeMaskView:subview.maskView];
        //     }
        // }

        return;
    }

    if ([NSStringFromClass([newSuperview class]) isEqualToString:@"SBDockIconListView"]) {
        [self applyIconOptions:DockIconOptions withShadowOptions:ShadowOptions];
    } else {
        [self applyIconOptions:PageIconOptions withShadowOptions:ShadowOptions];
    }

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
