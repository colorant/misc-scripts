#!/usr/bin/python
import os
import sys
import re


class AvgLoad():

    def __init__(self):
        self.file_count = 0

    def getAvg(self, fname, skiphead, skiptail):
        f = open(fname, 'r')

        lines = f.readlines(1000)
        totalLines = len(lines)
        toScan = totalLines - skiphead - skiptail

        print "total lines in file : ", totalLines
        print "skip head / tail lines : ", skiphead, skiptail
        print "will scan : ", toScan, " lines"

        if toScan <= 1:
            print "too few line to scan, stop now."
            return

        lineNum = 0
        lineScaned = 0
        cpuUser = 0
        cpuSys = 0
        cpuIdle = 0
        IOWait = 0
        totalIO = 0
        disku1 = 0.0
        disku2 = 0.0
        disku3 = 0.0
        disku4 = 0.0

        for line in lines:
            lineNum += 1
            if lineNum <= skiphead:
                continue
            words = line.split()
            cpuUser += int(words[0])
            cpuSys += int(words[1])
            cpuIdle += int(words[2])
            IOWait += int(words[3])

            diskIOStr = words[6]
            diskIO = int(diskIOStr.strip('BkM'))

            if diskIOStr.endswith("k"):
                diskIO /= 1024
            if diskIOStr.endswith("B"):
                diskIO /= (1024*1024)
            totalIO += diskIO

            disku1 += float(words[24])
            disku2 += float(words[25])
            disku3 += float(words[26])
            disku4 += float(words[27])

            lineScaned += 1
            if lineScaned >= toScan:
                break

        disku1 /= lineScaned
        disku2 /= lineScaned
        disku3 /= lineScaned
        disku4 /= lineScaned
        diskuavg = (disku1 + disku2 + disku3 + disku4) / 4

        print lineScaned, " line of data scanned"
        print "cpu Load : ", (cpuUser + cpuSys) / lineScaned
        print "cpu Idle : ", cpuIdle / lineScaned
        print "Disk IO  : ", totalIO / lineScaned, "MB/s"
        print "IOWait   : ", IOWait / lineScaned
        print "Disk Util avg,d1,d2,d3,d4 :", diskuavg, ",", disku1, ",", disku2, ",", disku3, ",", disku4


if __name__ == '__main__':
    f = AvgLoad()
    f.getAvg(sys.argv[1], int(sys.argv[2]), int(sys.argv[3]))
