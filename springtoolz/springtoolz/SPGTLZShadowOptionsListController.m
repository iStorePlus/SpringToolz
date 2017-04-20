#include "SPGTLZShadowOptionsListController.h"

@implementation SPGTLZShadowOptionsListController

- (NSArray *)specifiers {
	if (!_specifiers) {
		_specifiers = [[self loadSpecifiersFromPlistName:@"ShadowOptions" target:self] retain];
	}

	return _specifiers;
}

@end
