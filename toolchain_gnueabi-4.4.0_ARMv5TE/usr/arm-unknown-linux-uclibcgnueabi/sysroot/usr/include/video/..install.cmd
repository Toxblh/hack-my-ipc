cmd_/usr/src/arm-linux-3.3/buildroot-2012.02/output/toolchain/linux/include/video/.install := perl scripts/headers_install.pl /usr/src/arm-linux-3.3/buildroot-2012.02/output/toolchain/linux-3.3/include/video /usr/src/arm-linux-3.3/buildroot-2012.02/output/toolchain/linux/include/video arm edid.h sisfb.h uvesafb.h; perl scripts/headers_install.pl /usr/src/arm-linux-3.3/buildroot-2012.02/output/toolchain/linux-3.3/include/video /usr/src/arm-linux-3.3/buildroot-2012.02/output/toolchain/linux/include/video arm ; perl scripts/headers_install.pl /usr/src/arm-linux-3.3/buildroot-2012.02/output/toolchain/linux-3.3/include/generated/video /usr/src/arm-linux-3.3/buildroot-2012.02/output/toolchain/linux/include/video arm ; for F in ; do echo "\#include <asm-generic/$$F>" > /usr/src/arm-linux-3.3/buildroot-2012.02/output/toolchain/linux/include/video/$$F; done; touch /usr/src/arm-linux-3.3/buildroot-2012.02/output/toolchain/linux/include/video/.install
