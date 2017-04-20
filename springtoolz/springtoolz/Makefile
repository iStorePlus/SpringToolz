include $(THEOS)/makefiles/common.mk

BUNDLE_NAME = SpringToolz
SpringToolz_FILES = SPGTLZDockIconsListController.m SPGTLZPageIconsListController.m SPGTLZRootListController.m SPGTLZShadowOptionsListController.m SPGTLZBaseListController.m
SpringToolz_INSTALL_PATH = /Library/PreferenceBundles
SpringToolz_FRAMEWORKS = UIKit
SpringToolz_PRIVATE_FRAMEWORKS = Preferences

include $(THEOS_MAKE_PATH)/bundle.mk

internal-stage::
	$(ECHO_NOTHING)mkdir -p $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences$(ECHO_END)
	$(ECHO_NOTHING)cp entry.plist $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences/SpringToolz.plist$(ECHO_END)
