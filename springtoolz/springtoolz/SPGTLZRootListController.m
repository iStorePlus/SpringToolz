#include "SPGTLZRootListController.h"

@implementation SPGTLZRootListController

- (NSArray *)specifiers {
	if (!_specifiers) {
		_specifiers = [[self loadSpecifiersFromPlistName:@"Root" target:self] retain];
	}

	return _specifiers;
}

-(void)donate {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://www.paypal.me/stoqn4opm"]];
}

-(void)facebook {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://www.facebook.com/stoqn4opm"]];
}

-(void)respring {
    dispatch_async(dispatch_get_global_queue(QOS_CLASS_BACKGROUND, 0), ^{
        sleep(5);
        system("killall -9 SpringBoard");
    });
}

@end
