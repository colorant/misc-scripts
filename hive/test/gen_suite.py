#!/usr/bin/python
import os
import sys
import re


class ScanAndGen():

    def __init__(self):
        self.results = list()
        self.select_all = list()
        self.cmd_count = 0
        self.file_count = 0
        self.select_count = 0

    def scan_folder(self, folder, resultfolder):
        self.resultfolder = resultfolder
        current_path = os.getcwd()
        os.chdir(folder)
        for f in os.listdir("."):
                if f.endswith(".q"):
                    self.scan(f)
                self.file_count += 1

        self.select = self.reserveStr(set(self.select_all), "from src")
        self.select = self.reservePattern(self.select,
            " (where|having|group) ")
        self.select = self.excludePattern(self.select, "(explain|grant)")
        self.select = self.excludeStr(self.select, " partition(")
        self.select = self.excludePattern(self.select, "^insert")
        self.select = self.excludePattern(self.select, "^create")
        # self.select = self.excludePattern(self.select, "^from")
        self.select = self.excludePattern(self.select,
            " src(_|2|3|part|bucket|thrift)")
        self.select = self.excludePattern(self.select,
            "(ba_test|test_udf_get)")

        os.chdir(current_path)

    def scan(self, fname):
        f = open(fname, 'r')
        lines = f.readlines()
        qbuf = ""
        for line in lines:
            line = line.strip()

            # remove duplicated space
            line = " ".join(line.split())

            if len(line) == 0:
                continue
            if  ';' in line:
                qbuf += line
                self.collect(qbuf)
                self.cmd_count += 1
                qbuf = ""
            else:
                qbuf += line
                qbuf += " "
        f.close()

    def collect(self, cmd):
        issql = False
        cmd = cmd.lower()
        ret = False

        if self.notQuery(cmd):
            return

        if 'select' in cmd:
            issql = True
            self.select_count += 1
            self.select_all.append(cmd)
        else:
            issql = False

        if issql:
            self.results.append(cmd)

    def printall(self):
        f = open("allqueries.lst", 'w')
        no = 1
        if len(self.resultfolder) == 0:
            self.resultfolder = "gen_queries"
        if os.path.exists(self.resultfolder):
            print "Result folder already exists: ", self.resultfolder
            sys.exit(1)
        os.mkdir(self.resultfolder)
        for q in self.select:
            f.write(q+"\n")
            qfilename = "ut{0:04d}.q".format(no)
            qf = open(self.resultfolder+"/"+qfilename, 'w')
            qf.write(q.rstrip(';')+"\n")
            qf.close()
            no += 1
        f.close()
        print "Total No. of Commands         : ", self.cmd_count
        print "Total No. of SQLs             : ", len(self.results)
        print "Total No. of Select Queries   : ", len(self.select)

    def excludeStr(self, srcList, str):
        ret = [i for i in srcList if not self.isStr(i, str)]
        return ret

    def reserveStr(self, srcList, str):
        ret = [i for i in srcList if self.isStr(i, str)]
        return ret

    def excludePattern(self, srcList, pattern):
        re_pattern = re.compile(pattern)
        ret = [i for i in srcList if not re_pattern.search(i)]
        return ret

    def reservePattern(self, srcList, pattern):
        re_pattern = re.compile(pattern)
        ret = [i for i in srcList if re_pattern.search(i)]
        return ret

    def isStr(self, cmd, str):
        if str in cmd:
            return True
        return False

    def isExplain(self, cmd):
        return self.isStr(cmd, "explain")

    def notQuery(self, query):
        ret = False
        if "--" in query:
            ret = True

        return ret

if __name__ == '__main__':
    f = ScanAndGen()
    f.scan_folder(sys.argv[1], sys.argv[2])
    f.printall()
