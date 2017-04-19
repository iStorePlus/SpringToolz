include $(THEOS)/makefiles/common.mk

TWEAK_NAME = SpringToolz
SpringToolz_FILES = Tweak.xm UIView+Round.m CABasicAnimation+Rotation.m UIBezierPath+CustomPaths.m CustomMasksAnimationManager.m
SpringToolz_FRAMEWORKS = UIKit CoreGraphics QuartzCore

include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "killall -9 SpringBoard"
SUBPROJECTS += springtoolz
include $(THEOS_MAKE_PATH)/aggregate.mk
