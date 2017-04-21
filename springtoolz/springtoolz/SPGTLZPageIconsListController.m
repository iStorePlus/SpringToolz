#include "SPGTLZPageIconsListController.h"

@implementation SPGTLZPageIconsListController

- (NSArray *)specifiers {
	if (!_specifiers) {
		_specifiers = [[self loadSpecifiersFromPlistName:@"PageIcons" target:self] retain];
	}

	return _specifiers;
}

@end
