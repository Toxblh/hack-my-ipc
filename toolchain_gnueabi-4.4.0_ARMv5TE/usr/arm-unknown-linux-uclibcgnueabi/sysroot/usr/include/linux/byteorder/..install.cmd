cmd_/usr/src/arm-linux-3.3/buildroot-2012.02/output/toolchain/linux/include/linux/byteorder/.install := perl scripts/headers_install.pl /usr/src/arm-linux-3.3/buildroot-2012.02/output/toolchain/linux-3.3/include/linux/byteorder /usr/src/arm-linux-3.3/buildroot-2012.02/output/toolchain/linux/include/linux/byteorder arm big_endian.h little_endian.h; perl scripts/headers_install.pl /usr/src/arm-linux-3.3/buildroot-2012.02/output/toolchain/linux-3.3/include/linux/byteorder /usr/src/arm-linux-3.3/buildroot-2012.02/output/toolchain/linux/include/linux/byteorder arm ; perl scripts/headers_install.pl /usr/src/arm-linux-3.3/buildroot-2012.02/output/toolchain/linux-3.3/include/generated/linux/byteorder /usr/src/arm-linux-3.3/buildroot-2012.02/output/toolchain/linux/include/linux/byteorder arm ; for F in ; do echo "\#include <asm-generic/$$F>" > /usr/src/arm-linux-3.3/buildroot-2012.02/output/toolchain/linux/include/linux/byteorder/$$F; done; touch /usr/src/arm-linux-3.3/buildroot-2012.02/output/toolchain/linux/include/linux/byteorder/.install
