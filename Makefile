#
#	Makefile for FreeRTOS demo on Raspberry Pi
#
BASE=$(shell pwd)/
BUILD_DIR=$(shell pwd)/build/

MODULE_NAME="RaspberryPi BSP"

TARGETS=kernel7.img kernel.list kernel.syms kernel.elf kernel.map
LINKER_SCRIPT=raspberrypi.ld

-include .dbuild/dbuild.mk


all: kernel.list kernel7.img kernel.syms
	@$(SIZE) kernel.elf

kernel7.img: kernel.elf
	$(Q)$(PRETTY) IMAGE $(MODULE_NAME) $@
	$(Q)$(OBJCOPY) kernel.elf -O binary $@

kernel.list: kernel.elf
	$(Q)$(PRETTY) LIST $(MODULE_NAME) $@
	$(Q)$(OBJDUMP) -D -S  kernel.elf > $@

kernel.syms: kernel.elf
	$(Q)$(PRETTY) SYMS $(MODULE_NAME) $@
	$(Q)$(OBJDUMP) -t kernel.elf > $@

#kernel.elf: LDFLAGS += -L "/usr/lib/gcc/armv7a-hardfloat-linux-gnueabi/7.3.0" -lgcc
#kernel.elf: LDFLAGS += -L "/usr/armv7a-hardfloat-linux-gnueabi/usr/lib" -lc
kernel.elf: LDFLAGS += -L "/usr/lib/gcc/arm-softfloat-linux-gnueabi/8.1.0" -lgcc
kernel.elf: LDFLAGS += -L "/usr/arm-softfloat-linux-gnueabi/usr/lib" -lc
kernel.elf: $(OBJECTS)
	$(Q)$(LD) $(OBJECTS) -Map kernel.map -o $@ -T $(LINKER_SCRIPT) $(LDFLAGS)
