#import <UIKit/UIKit.h>
#import "UIView+Options.h"
#import "SBIconView.h"
#import "SPGTLZIconManager.h"
#import "SPGTLZDefaults.h"
#import "UIView+CrossFadeShape.h"

#pragma mark - Settings Loading

static NSDictionary *PageIconOptions = nil;
static NSDictionary *DockIconOptions = nil;
static NSDictionary *ShadowOptions = nil;

static void loadPrefsFromPlist() {
        
        NSMutableDictionary *prefs = [[NSMutableDictionary alloc] initWithContentsOfFile:PlistFileLocation];

        TweakEnabled = [prefs objectForKey:@"tweak_enabled"] ? [[prefs objectForKey:@"tweak_enabled"] boolValue] : TweakEnabled;

        NSString *pageIconShape = [prefs objectForKey:@"page_icon_shape"] ? (NSString *)[prefs objectForKey:@"page_icon_shape"] : DEFAULT_PAGE_ICON_SHAPE;
        NSNumber *pageIconShapeRotation = [prefs objectForKey:@"page_icon_shape_rotation"] ? [prefs objectForKey:@"page_icon_shape_rotation"] : @(DEFAULT_PAGE_ICON_SHAPE_ROTATION);
        BOOL pageIconsShadowsEnabled = [prefs objectForKey:@"page_icons_shadows_enabled"] ? [[prefs objectForKey:@"page_icons_shadows_enabled"] boolValue] : DEFAULT_PAGE_ICON_SHADOWS_ENABLED;
        BOOL pageIconsShapesOnFoldesEnabled = [prefs objectForKey:@"page_icons_shapes_on_folders_enabled"] ? [[prefs objectForKey:@"page_icons_shapes_on_folders_enabled"] boolValue] : DEFAULT_PAGE_ICON_SHAPES_FOLDERS_ENABLED;
        BOOL pageIconsShadowsOnFoldersEnabled = [prefs objectForKey:@"page_icons_shadows_on_folders_enabled"] ? [[prefs objectForKey:@"page_icons_shadows_on_folders_enabled"] boolValue] : DEFAULT_PAGE_ICON_SHADOWS_FOLDERS_ENABLED;
        BOOL pageIconsAnimationEnabled = [prefs objectForKey:@"page_icons_animations_enabled"] ? [[prefs objectForKey:@"page_icons_animations_enabled"] boolValue] : DEFAULT_PAGE_ICON_ANIMATIONS_ENABLED;
        BOOL pageIconsSatellitesEnabled = [prefs objectForKey:@"page_icons_satellites_enabled"] ? [[prefs objectForKey:@"page_icons_satellites_enabled"] boolValue] : DEFAULT_PAGE_ICON_SATELLITES_ENABLED;
        NSNumber *pageIconSatellitesCount = [prefs objectForKey:@"page_icon_satellites_count"] ? @([(NSString *)[prefs objectForKey:@"page_icon_satellites_count"] intValue]) : @(DEFAULT_PAGE_ICON_SATELLITES_COUNT);

        PageIconOptions = @{
            @"shape" : pageIconShape,
            @"shape_on_folders" : @(pageIconsShapesOnFoldesEnabled),
            @"shape_rotation" : pageIconShapeRotation,
            @"satellites_enabled" : @(pageIconsSatellitesEnabled),
            @"satellites_count" : pageIconSatellitesCount,
            @"shadows" : @(pageIconsShadowsEnabled),
            @"shadows_on_folders" : @(pageIconsShadowsOnFoldersEnabled),
            @"animations" : @(pageIconsAnimationEnabled)
        };

        NSString *dockIconShape = [prefs objectForKey:@"dock_icon_shape"] ? (NSString *)[prefs objectForKey:@"dock_icon_shape"] : DEFAULT_DOCK_ICON_SHAPE;
        NSNumber *dockIconShapeRotation = [prefs objectForKey:@"dock_icon_shape_rotation"] ? [prefs objectForKey:@"dock_icon_shape_rotation"] : @(DEFAULT_DOCK_ICON_SHAPE_ROTATION);
        BOOL dockIconsShadowsEnabled = [prefs objectForKey:@"dock_icons_shadows_enabled"] ? [[prefs objectForKey:@"dock_icons_shadows_enabled"] boolValue] : DEFAULT_DOCK_ICON_SHADOWS_ENABLED;
        BOOL dockIconsAnimationEnabled = [prefs objectForKey:@"dock_icons_animations_enabled"] ? [[prefs objectForKey:@"dock_icons_animations_enabled"] boolValue] : DEFAULT_DOCK_ICON_ANIMATIONS_ENABLED;
        BOOL dockIconsSatellitesEnabled = [prefs objectForKey:@"dock_icons_satellites_enabled"] ? [[prefs objectForKey:@"dock_icons_satellites_enabled"] boolValue] : DEFAULT_DOCK_ICON_SATELLITES_ENABLED;
        NSNumber *dockIconSatellitesCount = [prefs objectForKey:@"dock_icon_satellites_count"] ? @([(NSString *)[prefs objectForKey:@"dock_icon_satellites_count"] intValue]) : @(DEFAULT_DOCK_ICON_SATELLITES_COUNT);

        DockIconOptions = @{
            @"shape"        : dockIconShape,
            @"shape_rotation" : dockIconShapeRotation,
            @"satellites_enabled" : @(dockIconsSatellitesEnabled),
            @"satellites_count" : dockIconSatellitesCount,
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

static void createPrefs() {

    NSDictionary *prefs = @{
        @"tweak_enabled" : @(TweakEnabled),
        
        @"page_icon_shape" : DEFAULT_PAGE_ICON_SHAPE,
        @"page_icon_shape_rotation" : @(DEFAULT_PAGE_ICON_SHAPE_ROTATION),
        @"shape_on_folders" : @(DEFAULT_PAGE_ICON_SHAPES_FOLDERS_ENABLED),
        @"shadows_on_folders" : @(DEFAULT_PAGE_ICON_SHADOWS_FOLDERS_ENABLED),
        @"page_icons_shadows_enabled" : @(DEFAULT_PAGE_ICON_SHADOWS_ENABLED),
        @"page_icons_animations_enabled" : @(DEFAULT_PAGE_ICON_ANIMATIONS_ENABLED),
        @"page_icons_satellites_enabled" : @(DEFAULT_PAGE_ICON_SATELLITES_ENABLED),
        @"page_icon_satellites_count" : [NSString stringWithFormat:@"%@", @(DEFAULT_PAGE_ICON_SATELLITES_COUNT)],
        
        @"dock_icon_shape" : DEFAULT_DOCK_ICON_SHAPE,
        @"dock_icon_shape_rotation" : @(DEFAULT_DOCK_ICON_SHAPE_ROTATION),
        @"dock_icons_shadows_enabled" : @(DEFAULT_DOCK_ICON_SHADOWS_ENABLED),
        @"dock_icons_animations_enabled" : @(DEFAULT_DOCK_ICON_ANIMATIONS_ENABLED),
        @"dock_icons_satellites_enabled" : @(DEFAULT_DOCK_ICON_SATELLITES_ENABLED),
        @"dock_icon_satellites_count" : [NSString stringWithFormat:@"%@", @(DEFAULT_DOCK_ICON_SATELLITES_COUNT)],

        @"shadow_color" : DEFAULT_SHADOW_COLOR,
        @"shadow_intensity" : @(DEFAULT_SHADOW_INTENSITY),
        @"shadow_hor_deviation" : @(DEFAULT_SHADOW_HOR_DEVIATION),
        @"shadow_ver_deviation" : @(DEFAULT_SHADOW_VER_DEVIATION)
    };

    [prefs writeToFile:PlistFileLocation atomically:YES];
}

// tweak entry point
%ctor {
    
    NSFileManager *fileManager = [NSFileManager defaultManager];

    if ([fileManager fileExistsAtPath:PlistFileLocation]) {
        loadPrefsFromPlist();
    } else {
        createPrefs();
        loadPrefsFromPlist();
    }
}


#pragma mark - Hooking

%hook SBRootIconListView

- (void)didMoveToWindow {
    %orig;
    
    if (TweakEnabled) {
        if (self.window == nil) {
            return; // may need to perform cleanup
        }

        for (UIView *iconView in self.subviews) {
             if ([NSStringFromClass([iconView class]) isEqualToString:@"SBIconView"]) {
                SBIconView *icon = (SBIconView *)iconView;
                [icon applyIconOptionsInRegardsToSuperView:icon.superview andWindow:self.window];
            }
        }
    }
}

- (void)addSubview:(UIView *)view {
    %orig;
    
    if (TweakEnabled) {
        if ([NSStringFromClass([view class]) isEqualToString:@"SBIconView"]) {
            SBIconView *icon = (SBIconView *)view;
            [icon applyIconOptionsInRegardsToSuperView:icon.superview andWindow:self.window];
        }
    }
}

%end

%hook SBIconImageCrossfadeView

- (void)willMoveToSuperview:(UIView *)newSuperview {
    %orig;
    if (TweakEnabled) {
        [self applyCrossFadeShapeInRegardsTo:newSuperview];
    }
    
}

%end

%hook SBIconView

- (void)willMoveToSuperview:(UIView *)newSuperview {
    [self applyIconOptionsInRegardsToSuperView:newSuperview andWindow:self.superview.window];
    %orig;
}

- (void)willMoveToWindow:(UIWindow *)newWindow {
    [self applyIconOptionsInRegardsToSuperView:self.superview andWindow:newWindow];
    %orig;
}

%new
- (void)applyIconOptionsInRegardsToSuperView:(UIView *)superView andWindow:(UIWindow *)window {
    if (TweakEnabled) {
        if ([NSStringFromClass([superView class]) isEqualToString:@"SBDockIconListView"]) {
            [self applyDockIconOptions:DockIconOptions withShadowOptions:ShadowOptions inRegardsTo:superView andNewWindow:window];
        } else if ([NSStringFromClass([superView class]) isEqualToString:@"SBRootIconListView"] ||
                   [NSStringFromClass([superView class]) isEqualToString:@"SBFolderIconListView"]) {
            [self applyPageIconOptions:PageIconOptions withShadowOptions:ShadowOptions inRegardsTo:superView andNewWindow:window];
        }
    }
}

%end


%hook SBLockScreenManager

-(void)lockUIFromSource:(int)source withOptions:(id)options {
    %orig;
    [[SPGTLZIconManager sharedInstance] setAnimationDelayInstantly:4];
}

%end
