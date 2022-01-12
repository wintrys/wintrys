#!/bin/bash
#统计根分区使用率

rate=$(df -h | grep '/dev/vda1' |awk '{print $5}' | cut -d "%" -f 1
)

if [ $rate -ge 80 ]
   then
           echo "Warning! /dev/vda1 is full!"
fi