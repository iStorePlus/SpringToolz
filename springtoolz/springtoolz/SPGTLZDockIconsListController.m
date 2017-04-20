#include "SPGTLZDockIconsListController.h"

@implementation SPGTLZDockIconsListController

- (NSArray *)specifiers {
	if (!_specifiers) {
		_specifiers = [[self loadSpecifiersFromPlistName:@"DockIcons" target:self] retain];
	}

	return _specifiers;
}

@end
