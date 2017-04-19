//
//  ViewController.m
//  SpringToolzSampleProject
//
//  Created by Stoyan Stoyanov on 4/19/17.
//  Copyright © 2017 Stoyan Stoyanov. All rights reserved.
//

#import "ViewController.h"
#import "UIView+Round.h"
#import "SBIconView.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet SBIconView *iconView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.iconView makeSubviewsCurcular:NO
                    withGearMaskEnabled:YES
                        gearMaskOptions:@{@"sides_count": @100, @"rad_deviation": @5, @"speed" : @2.5}
                          andWithShadow:YES
                       andShadowOptions:nil];
}

@end
