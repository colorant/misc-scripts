#!/usr/bin/python
import os
import sys
import re


class NumToString():

    def __init__(self):
        self.file_count = 0

    def scan_folder(self, folder, resultfolder):
        self.resultfolder = resultfolder
        current_path = os.getcwd()

        if os.path.exists(self.resultfolder):
            print "Result folder already exists: ", self.resultfolder
            sys.exit(1)

        os.mkdir(self.resultfolder)
        self.outdir = os.getcwd() + "/" + self.resultfolder
        os.chdir(folder)

        for f in os.listdir("."):
            if os.path.isfile(f):
                self.scan(f)
                self.file_count += 1

        os.chdir(current_path)

    def scan(self, fname):
        f = open(fname, 'r')

        qbuf = ""
        lines = f.readlines()
        for line in lines:
            words = line.split()
            for w in words:
                if w.isdigit():
                    qbuf += "'" + w + "' "
                else:
                    qbuf += w + " "
            qbuf = qbuf.rstrip()
            qbuf += "\n"

        outputf = open(self.outdir+"/"+fname, 'w')
        outputf.write(qbuf)
        outputf.close()
        f.close()


if __name__ == '__main__':
    f = NumToString()
    f.scan_folder(sys.argv[1], sys.argv[2])
