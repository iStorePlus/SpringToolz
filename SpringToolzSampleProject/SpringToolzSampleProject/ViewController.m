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
    [self.iconView makeSubviewsCurcular:NO withGearMaskEnabled:YES gearMaskOptions:nil andWithShadow:NO andShadowOptions:nil];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
