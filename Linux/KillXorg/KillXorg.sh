#!/bin/bash

# This is used to fix black screen in RDP caused by too many running XORG
# https://blog.csdn.net/qq_40308101/article/details/108578581
# Modify the numbers in "cut -c" to adapt to your PC's PID width

# Kull all xorg processes
ps -ef | grep xorg | grep -v grep | cut -c 9-17 | xargs kill - s 9

# Test output
ps -ef | grep xorg | grep -v grep | cut -c 9-17 | xargs echo

