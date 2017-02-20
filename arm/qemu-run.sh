#!/bin/bash

QEMU_SYSTEM=${QEMU_SYSTEM:-qemu-system-arm}

MACHINE=raspi2
#MACHINE=versatilepb

exec ${QEMU_SYSTEM} -M ${MACHINE} -nographic -bios kernel.img
