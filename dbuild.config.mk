RASPPI	?= 2

ifeq ($(strip $(RASPPI)),1)
ARCH	?= -march=armv6j -mtune=arm1176jzf-s -mfloat-abi=hard 
else
#ARCH	?= -march=armv7-a -mtune=cortex-a7 -mfloat-abi=hard
ARCH	?= -march=armv7-a -mtune=cortex-a7 -mfloat-abi=softfp
endif

AFLAGS ?= $(ARCH) -DRASPPI=$(RASPPI)
CFLAGS += $(ARCH) -g -std=gnu99 -Wno-psabi -fsigned-char -DRASPPI=$(RASPPI) -nostdlib -Wno-implicit -mfloat-abi=softfp 
#CFLAGS += $(ARCH) -g -std=gnu99 -Wno-psabi -fsigned-char -DRASPPI=$(RASPPI) -nostdlib -Wno-implicit -mfloat-abi=hard 
CFLAGS += -finstrument-functions
CFLAGS += -mno-unaligned-access
CFLAGS += -I $(BASE)FreeRTOS/Source/portable/GCC/RaspberryPi/
CFLAGS += -I $(BASE)FreeRTOS/Source/include/
CFLAGS += -I $(BASE)Drivers/
CFLAGS += -I $(BASE)Drivers/lan9514/include/
CFLAGS += -I $(BASE)Drivers/FreeRTOS-Plus-TCP/include/

#TOOLCHAIN=armv7a-hardfloat-linux-gnueabi-
#TOOLCHAIN=arm-softfloat-linux-gnueabi-
TOOLCHAIN=armv7a-softfloat-linux-gnueabi-
