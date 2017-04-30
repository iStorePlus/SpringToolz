#import <UIKit/UIKit.h>
#import "UIView+Options.h"
#import "SBIconView.h"
#import "SPGTLZIconManager.h"
#import "UIView+Shape.h"
#import "UIView+Satelite.h"

#pragma mark - Settings Defaults

static BOOL TweakEnabled = YES;

static NSString *DEFAULT_PAGE_ICON_SHAPE = @"default";
static CGFloat DEFAULT_PAGE_ICON_SHAPE_ROTATION = 0.0;
static BOOL DEFAULT_PAGE_ICON_SHADOWS_ENABLED = YES;
static BOOL DEFAULT_PAGE_ICON_ANIMATIONS_ENABLED = NO;
static BOOL DEFAULT_PAGE_ICON_SATELLITES_ENABLED = NO;
static NSUInteger DEFAULT_PAGE_ICON_SATELLITES_COUNT = 1;

static NSString *DEFAULT_DOCK_ICON_SHAPE = @"default";
static CGFloat DEFAULT_DOCK_ICON_SHAPE_ROTATION = 0.0;
static BOOL DEFAULT_DOCK_ICON_SHADOWS_ENABLED = YES;
static BOOL DEFAULT_DOCK_ICON_ANIMATIONS_ENABLED = NO;
static BOOL DEFAULT_DOCK_ICON_SATELLITES_ENABLED = NO;
static NSUInteger DEFAULT_DOCK_ICON_SATELLITES_COUNT = 1;

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
        NSNumber *pageIconShapeRotation = [prefs objectForKey:@"page_icon_shape_rotation"] ? [prefs objectForKey:@"page_icon_shape_rotation"] : @(DEFAULT_PAGE_ICON_SHAPE_ROTATION);
        BOOL pageIconsShadowsEnabled = [prefs objectForKey:@"page_icons_shadows_enabled"] ? [[prefs objectForKey:@"page_icons_shadows_enabled"] boolValue] : DEFAULT_PAGE_ICON_SHADOWS_ENABLED;
        BOOL pageIconsAnimationEnabled = [prefs objectForKey:@"page_icons_animations_enabled"] ? [[prefs objectForKey:@"page_icons_animations_enabled"] boolValue] : DEFAULT_PAGE_ICON_ANIMATIONS_ENABLED;
        BOOL pageIconsSatellitesEnabled = [prefs objectForKey:@"page_icons_satellites_enabled"] ? [[prefs objectForKey:@"page_icons_satellites_enabled"] boolValue] : DEFAULT_PAGE_ICON_SATELLITES_ENABLED;
        NSNumber *pageIconSatellitesCount = [prefs objectForKey:@"page_icon_satellites_count"] ? @([(NSString *)[prefs objectForKey:@"page_icon_satellites_count"] intValue]) : @(DEFAULT_PAGE_ICON_SATELLITES_COUNT);

        PageIconOptions = @{
            @"shape" : pageIconShape,
            @"shape_rotation" : pageIconShapeRotation,
            @"satellites_enabled" : @(pageIconsSatellitesEnabled),
            @"satellites_count" : pageIconSatellitesCount,
            @"shadows" : @(pageIconsShadowsEnabled),
            @"animations" : @(pageIconsAnimationEnabled)
        };

        NSString *dockIconShape = [prefs objectForKey:@"dock_icon_shape"] ? (NSString *)[prefs objectForKey:@"dock_icon_shape"] : DEFAULT_DOCK_ICON_SHAPE;
        NSNumber *dockIconShapeRotation = [prefs objectForKey:@"dock_icon_shape_rotation"] ? [prefs objectForKey:@"dock_icon_shape_rotation"] : @(DEFAULT_DOCK_ICON_SHAPE_ROTATION);
        BOOL dockIconsShadowsEnabled = [prefs objectForKey:@"dock_icons_shadows_enabled"] ? [[prefs objectForKey:@"dock_icons_shadows_enabled"] boolValue] : DEFAULT_DOCK_ICON_SHADOWS_ENABLED;
        BOOL dockIconsAnimationEnabled = [prefs objectForKey:@"dock_icons_animations_enabled"] ? [[prefs objectForKey:@"dock_icons_animations_enabled"] boolValue] : DEFAULT_DOCK_ICON_ANIMATIONS_ENABLED;
        BOOL dockIconsSatellitesEnabled = [prefs objectForKey:@"dock_icons_satellites_enabled"] ? [[prefs objectForKey:@"dock_icons_satellites_enabled"] boolValue] : DEFAULT_DOCK_ICON_SATELLITES_ENABLED;
        NSNumber *dockIconSatellitesCount = [prefs objectForKey:@"dock_icon_satellites_count"] ? @([(NSString *)[prefs objectForKey:@"dock_icon_satellites_count"] intValue]) : @(DEFAULT_DOCK_ICON_SATELLITES_COUNT);
        
        // NSLog(@"%lu %@", (unsigned long)DEFAULT_DOCK_ICON_SATELLITES_COUNT, dockIconSatellitesCount);

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
}

%ctor {
    loadPrefs();
}

#pragma mark - Hooking

%hook SBRootIconListView

- (void)didMoveToWindow {
    %orig;

    if (self.window == nil) {
        return; // may need to perform cleanup
    }

    for (UIView *iconView in self.subviews) {
         if ([NSStringFromClass([iconView class]) isEqualToString:@"SBIconView"]) {
            SBIconView *icon = (SBIconView *)iconView;
            [self applyOptionsForIcon:icon];
        }
    }
}

- (void)addSubview:(UIView *)view {
    %orig;
    
    if (TweakEnabled) {
        if ([NSStringFromClass([view class]) isEqualToString:@"SBIconView"]) {
            SBIconView *icon = (SBIconView *)view;
            [self applyOptionsForIcon:icon];
        }
    }
}

%new 

- (void)applyOptionsForIcon:(SBIconView *)icon {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [[SPGTLZIconManager sharedInstance] setIconSize:[icon iconImageFrame]];
    });

    if ([NSStringFromClass([icon.superview class]) isEqualToString:@"SBDockIconListView"]) {

        static dispatch_once_t onceTokenDock;
        dispatch_once(&onceTokenDock, ^{
            NSString *dockIconShape = (NSString *)[DockIconOptions valueForKey:@"shape"];
            NSNumber *dockIconShapeRotation = (NSNumber *)[DockIconOptions valueForKey:@"shape_rotation"];
            [[SPGTLZIconManager sharedInstance] setDockIconsShapeName:dockIconShape withRotation:dockIconShapeRotation];
        });

        [icon applyDockIconOptions:DockIconOptions withShadowOptions:ShadowOptions];

    } else if ([NSStringFromClass([icon.superview class]) isEqualToString:@"SBRootIconListView"]) {
        
        static dispatch_once_t onceTokenPage;
        dispatch_once(&onceTokenPage, ^{
            NSString *pageIconShape = (NSString *)[PageIconOptions valueForKey:@"shape"];
            NSNumber *pageIconShapeRotation = (NSNumber *)[PageIconOptions valueForKey:@"shape_rotation"];
            [[SPGTLZIconManager sharedInstance] setPageIconsShapeName:pageIconShape withRotation:pageIconShapeRotation];
        });

       [icon applyPageIconOptions:PageIconOptions withShadowOptions:ShadowOptions];
    }
}

%end

%hook UIView

- (void)addSubview:(UIView *)view {
    %orig;

    if (view.tag == CONTAINER_SHAPE_VIEW_TAG) {
            
        [UIView animateWithDuration:5 delay:0 options:UIViewAnimationOptionRepeat | UIViewAnimationOptionShowHideTransitionViews | UIViewAnimationOptionAutoreverse | UIViewAnimationOptionBeginFromCurrentState animations:^{
            view.transform = CGAffineTransformMakeRotation(M_PI);
        } completion:nil];

    }
    else if (view.tag == CONTAINER_SATELLITES_VIEW_TAG) {
        [view orbit];
    }
}
%end
