//
//  SPGTLZIconManager.h
//  SpringToolzSampleProject
//
//  Created by Stoyan Stoyanov on 4/19/17.
//  Copyright © 2017 Stoyan Stoyanov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface SPGTLZIconManager : NSObject

+ (SPGTLZIconManager *)sharedInstance;
@property (nonatomic, strong) NSDictionary *pageIconOptions;
@property (nonatomic, strong) NSDictionary *dockIconOptions;
@property (nonatomic, strong) NSDictionary *shadowOptions;

@property (nonatomic, assign) CGRect iconSize;

- (UIBezierPath *)iconShapeForOptions:(NSDictionary *)options;

- (UIColor *)shadowColorForName:(NSString *)name;
@end
