cmd_/usr/src/arm-linux-3.3/buildroot-2012.02/output/toolchain/linux/include/linux/raid/.install := perl scripts/headers_install.pl /usr/src/arm-linux-3.3/buildroot-2012.02/output/toolchain/linux-3.3/include/linux/raid /usr/src/arm-linux-3.3/buildroot-2012.02/output/toolchain/linux/include/linux/raid arm md_p.h md_u.h; perl scripts/headers_install.pl /usr/src/arm-linux-3.3/buildroot-2012.02/output/toolchain/linux-3.3/include/linux/raid /usr/src/arm-linux-3.3/buildroot-2012.02/output/toolchain/linux/include/linux/raid arm ; perl scripts/headers_install.pl /usr/src/arm-linux-3.3/buildroot-2012.02/output/toolchain/linux-3.3/include/generated/linux/raid /usr/src/arm-linux-3.3/buildroot-2012.02/output/toolchain/linux/include/linux/raid arm ; for F in ; do echo "\#include <asm-generic/$$F>" > /usr/src/arm-linux-3.3/buildroot-2012.02/output/toolchain/linux/include/linux/raid/$$F; done; touch /usr/src/arm-linux-3.3/buildroot-2012.02/output/toolchain/linux/include/linux/raid/.install
