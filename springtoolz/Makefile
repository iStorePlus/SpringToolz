# export ARCHS = armv7 armv7s arm64
include $(THEOS)/makefiles/common.mk

TWEAK_NAME = SpringToolz
SpringToolz_FILES = Tweak.xm UIView+Round.m CABasicAnimation+Rotation.m UIBezierPath+CustomPaths.m SPGTLZIconManager.m
SpringToolz_FRAMEWORKS = UIKit CoreGraphics QuartzCore

ADDITIONAL_OBJCFLAGS = -fobjc-arc

include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "killall -9 SpringBoard"
SUBPROJECTS += springtoolz
include $(THEOS_MAKE_PATH)/aggregate.mk
