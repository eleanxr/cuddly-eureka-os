#!/bin/bash

BUILDPATH=./build

QEMU_SYSTEM=${QEMU_SYSTEM:-qemu-system-arm}

MACHINE=raspi2
#MACHINE=versatilepb

exec ${QEMU_SYSTEM} -M ${MACHINE} -bios "$BUILDPATH"/src/kernel/kernel.img -nographic
