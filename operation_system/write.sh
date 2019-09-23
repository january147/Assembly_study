#!/bin/bash
# Date: Mon Sep 23 21:52:30 2019
# Author: January

nasm boot.asm -o boot.bin
dd if=boot.bin of=a.img bs=512 count=1 conv=notrunc

