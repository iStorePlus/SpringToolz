//
//  ViewController.m
//  SpringToolzSampleProject
//
//  Created by Stoyan Stoyanov on 4/19/17.
//  Copyright © 2017 Stoyan Stoyanov. All rights reserved.
//

#import "ViewController.h"
#import "UIView+Options.h"
#import "SBIconView.h"
#import "SPGTLZIconManager.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet SBIconView *iconView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor greenColor];
    
    [self.iconView
     applyPageIconOptions:@{
                        @"shape" : @"hexagon",
                        @"shape_rotation" : @(M_PI_2),
                        @"shadows" : @(YES),
                        @"animations" : @(NO)}
     withShadowOptions:@{
                         @"color"            : @"black",
                         @"intensity"        : @1,
                         @"hor_deviation"    : @0,
                         @"ver_deviation"    : @0} inRegardsTo:self.iconView.superview andNewWindow:self.iconView.superview.window];
    
    
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [[SPGTLZIconManager sharedInstance] animate];
//    });
}

@end
