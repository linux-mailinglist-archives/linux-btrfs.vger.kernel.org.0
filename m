Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A577311D26D
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Dec 2019 17:37:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729907AbfLLQhW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 12 Dec 2019 11:37:22 -0500
Received: from mail.halfdog.net ([37.186.9.82]:62942 "EHLO mail.halfdog.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729883AbfLLQhW (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 12 Dec 2019 11:37:22 -0500
X-Greylist: delayed 1241 seconds by postgrey-1.27 at vger.kernel.org; Thu, 12 Dec 2019 11:37:21 EST
Received: from [37.186.9.82] (helo=localhost)
        by mail.halfdog.net with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <me@halfdog.net>)
        id 1ifR7u-0000ol-0B
        for linux-btrfs@vger.kernel.org; Thu, 12 Dec 2019 16:15:42 +0000
From:   halfdog <me@halfdog.net>
To:     linux-btrfs@vger.kernel.org
Subject: FIDEDUPERANGE woes
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="----- =_aaaaaaaaaa0"
Date:   Thu, 12 Dec 2019 16:15:49 +0000
Message-ID: <2019-1576167349.500456@svIo.N5dq.dFFD>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

------- =_aaaaaaaaaa0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hello list,

Using btrfs on

Linux version 5.3.0-2-amd64 (debian-kernel@lists.debian.org) (gcc version =
9.2.1 20191109 (Debian 9.2.1-19)) #1 SMP Debian 5.3.9-3 (2019-11-19)

the FIDEDUPERANGE exposes weird behaviour on two identical but
not too large files that seems to be depending on the file size.
Before FIDEDUPERANGE both files have a single extent, afterwards
first file is still single extent, second file has all bytes sharing
with the extent of the first file except for the last 4096 bytes.

Is there anything known about a bug fixed since the above mentioned
kernel version?



If no, does following reproducer still show the same behaviour
on current Linux kernel (my Python test tools also attached)?

> dd if=3D/dev/zero bs=3D1M count=3D32 of=3Ddisk
> mkfs.btrfs --mixed --metadata single --data single --nodesize 4096 disk
> mount disk /mnt/test
> mkdir /mnt/test/x
> dd bs=3D1 count=3D155489 if=3D/dev/urandom of=3D/mnt/test/x/file-0
> cat /mnt/test/x/file-0 > /mnt/test/x/file-1

> ./SimpleIndexer x > x.json
> ./IndexDeduplicationAnalyzer --IndexFile /mnt/test/x.json /mnt/test/x > =
dedup.list
Got dict: {b'/mnt/test/x/file-0': [(0, 5316608, 155648)], b'/mnt/test/x/fi=
le-1': [(0, 5472256, 155648)]}
...
> strace -s256 -f btrfs-extent-same 155489 /mnt/test/x/file-0 0 /mnt/test/=
x/file-1 0 2>&1 | grep -E -e FIDEDUPERANGE
ioctl(3, BTRFS_IOC_FILE_EXTENT_SAME or FIDEDUPERANGE, {src_offset=3D0, src=
_length=3D155489, dest_count=3D1, info=3D[{dest_fd=3D4, dest_offset=3D0}]}=
 =3D> {info=3D[{bytes_deduped=3D155489, status=3D0}]}) =3D 0
> ./IndexDeduplicationAnalyzer --IndexFile /mnt/test/x.json /mnt/test/x > =
dedup.list
Got dict: {b'/mnt/test/x/file-0': [(0, 5316608, 155648)], b'/mnt/test/x/fi=
le-1': [(0, 5316608, 151552), (151552, 5623808, 4096)]}
...
> strace -s256 -f btrfs-extent-same 155489 /mnt/test/x/file-0 0 /mnt/test/=
x/file-1 0 2>&1 | grep -E -e FIDEDUPERANGE
ioctl(3, BTRFS_IOC_FILE_EXTENT_SAME or FIDEDUPERANGE, {src_offset=3D0, src=
_length=3D155489, dest_count=3D1, info=3D[{dest_fd=3D4, dest_offset=3D0}]}=
 =3D> {info=3D[{bytes_deduped=3D155489, status=3D0}]}) =3D 0
> strace -s256 -f btrfs-extent-same 4096 /mnt/test/x/file-0 151552 /mnt/te=
st/x/file-1 151552 2>&1 | grep -E -e FIDEDUPERANGE
ioctl(3, BTRFS_IOC_FILE_EXTENT_SAME or FIDEDUPERANGE, {src_offset=3D151552=
, src_length=3D4096, dest_count=3D1, info=3D[{dest_fd=3D4, dest_offset=3D1=
51552}]}) =3D -1 EINVAL (Invalid argument)

------- =_aaaaaaaaaa0
Content-Type: text/plain; name="SimpleIndexer"; charset="us-ascii"
Content-Description: SimpleIndexer
Content-Disposition: attachment; filename="SimpleIndexer"
Content-Transfer-Encoding: quoted-printable

#!/usr/bin/python3 -BbbEIsSttW all

"""This module implements a simple file system indexer creating
a JSON intermediate format to be then imported to the standard
backup tools chain. This allows indexing of file systems without
having the full Java based backup stack installed.

This software is provided by the copyright owner "as is" and
without any expressed or implied warranties, including, but not
limited to, the implied warranties of merchantability and fitness
for a particular purpose are disclaimed. In no event shall the
copyright owner be liable for any direct, indirect, incidential,
special, exemplary or consequential damages, including, but not
limited to, procurement of substitute goods or services, loss
of use, data or profits or business interruption, however caused
and on any theory of liability, whether in contract, strict liability,
or tort, including negligence or otherwise, arising in any way
out of the use of this software, even if advised of the possibility
of such damage.

Copyright (c) 2019 halfdog <me (%) halfdog.net>

You may not distribute copies, re-license, sell or make any kind
of profit with this software without proper prior written consent
from the author. You may not remove this copyright notice, license
or terms of use.

PS: Restrictive license as I did not have time to publish this
backup data quality verification, deduplication, data synchronization
tools. I would be be willing to do so if someone assists in getting
software distributed as Debian package."""

import hashlib
import json
import os
import re
import stat
import sys


def fileNameToResourceName(fileName):
  nameBytes =3D fileName.encode(sys.getdefaultencoding(), errors=3D'surrog=
ateescape')
  nameBytesSanitized =3D [chr(val) if val in b'0123456789-.ABCDEFGHIJKLMNO=
PQRSTUVWXYZ_abcdefghijklmnopqrstuvwxyz~' else ('%%%02x' % (val&0xff)) for =
val in nameBytes]
  return ''.join(nameBytesSanitized)

def listDir(pathName, parentResourceUrl, excludeRegexList):
  """List the directory, apply exclude rules, sort all results
  and return the list suitable for indexing stack use."""
  resultList =3D []
  for fileName in os.listdir(pathName):
    filePathName =3D os.path.join(pathName, fileName)
    resourceName =3D fileNameToResourceName(fileName)
    fileResourceName =3D parentResourceUrl+resourceName
# Add '/' to directories but not links pointing to directories.
    if stat.S_ISDIR(os.lstat(filePathName).st_mode):
      fileResourceName +=3D '/'

    if excludeRegexList:
      for regex in excludeRegexList:
        if regex.match(fileResourceName):
          fileResourceName =3D None
          break
    if fileResourceName is not None:
      resultList.append((filePathName, fileResourceName))
  resultList.sort(key=3Dlambda x: x[1])
  return resultList

def createDigest(pathName):
  """Create a hexadecimal digest string for the file pointed
  out by pathname."""
  digestObj =3D hashlib.md5()
  digestFile =3D open(pathName, 'rb')
  while True:
    digestData =3D digestFile.read(1<<24)
    if not digestData:
      break
    digestObj.update(digestData)
  digestFile.close()
  return digestObj.hexdigest()


def doIndex(rootPathName, excludeRegexStrList=3DNone, indexStartPath=3DNon=
e,
    updateIndexFile=3DNone):
  """Create an index for a given file system part.
  @param rootPathName byte string pointing to the file system
  root for indexing.
  @param excludeRegexStrList a list of regular expression strings
  to match against the ResourceUrl."""

  excludeRegexList =3D None
  if excludeRegexStrList:
    excludeRegexList =3D [re.compile(regexStr) for regexStr in excludeRege=
xStrList]

  oldIndexData =3D []
  oldIndexDataPos =3D 0
  if updateIndexFile:
    indexFile =3D open(updateIndexFile, 'rb')
    oldIndexData =3D indexFile.read()
    indexFile.close()
    oldIndexData =3D json.loads(str(oldIndexData, 'ascii'))

# Have an indexing stack with a sorted list of elements to visit,
# the index of the next element and the ResourceUrl up to the
# level currently being processed.
  indexStack =3D []
  indexStack.append([[(rootPathName, '/')], 0, '/'])

# Begin the JSON output format list.
  continuationFlag =3D False
  print('[')
  while indexStack:
    stackFrame =3D indexStack[-1]
    fileSystemPath, resourceUrl =3D stackFrame[0][stackFrame[1]]
# Zero out the element to avoid having all large number of items
# linked when not needed any more.
    stackFrame[0][stackFrame[1]] =3D None
    stackFrame[1] +=3D 1
    if stackFrame[1] =3D=3D len(stackFrame[0]):
      del indexStack[-1]

    oldRecord =3D None
    for oldIndexDataPos in range(oldIndexDataPos, len(oldIndexData)):
      if oldIndexData[oldIndexDataPos]['url'] < resourceUrl:
        continue
      if oldIndexData[oldIndexDataPos]['url'] =3D=3D resourceUrl:
        oldRecord =3D oldIndexData[oldIndexDataPos]
      break

    indexResult =3D {}
    statData =3D os.lstat(fileSystemPath)
    indexResult['group'] =3D statData.st_gid
    indexResult['inode'] =3D statData.st_ino
    indexResult['length'] =3D statData.st_size
    indexResult['mode'] =3D statData.st_mode & 0o7777
    indexResult['mtime'] =3D statData.st_mtime
    indexResult['type'] =3D None
    indexResult['url'] =3D resourceUrl
    indexResult['user'] =3D statData.st_uid

    if stat.S_ISDIR(statData.st_mode):
      indexResult['type'] =3D 'dir'
      subResourceList =3D listDir(
          fileSystemPath, resourceUrl, excludeRegexList)
      if subResourceList:
        indexStack.append([subResourceList, 0, resourceUrl])
    elif stat.S_ISFIFO(statData.st_mode):
      indexResult['type'] =3D 'pipe'
    elif stat.S_ISLNK(statData.st_mode):
      indexResult['type'] =3D 'link'
      indexResult['typedata'] =3D os.readlink(fileSystemPath)
    elif stat.S_ISREG(statData.st_mode):
      indexResult['type'] =3D 'file'
# Only this step should be skipped if old and new entry are identical.
      if oldRecord is not None:
        indexResult['digest-md5'] =3D oldRecord['digest-md5']
      if oldRecord !=3D indexResult:
        indexResult['digest-md5'] =3D createDigest(fileSystemPath)
    elif stat.S_ISSOCK(statData.st_mode):
      indexResult['type'] =3D 'socket'
    else:
      raise Exception('Unhandled file type for %s' % fileSystemPath)
    recordData =3D json.dumps(indexResult, sort_keys=3DTrue)
    if(continuationFlag):
      sys.stdout.write(',\n%s' % recordData)
    else:
      sys.stdout.write('%s' % recordData)
      continuationFlag =3D True
  print(']')


def mainFunction():
  """This is the main function to analyze the program call arguments
  and invoke indexing."""

  excludeRegexStrList =3D []
  indexStartPath =3D None
  updateIndexFile =3D None

  argPos =3D 1
  while argPos < len(sys.argv)-1:
    argName =3D sys.argv[argPos]
    argPos +=3D 1
    if argName =3D=3D '--':
      break
    if argName =3D=3D '--Exclude':
      excludeRegexStrList.append(sys.argv[argPos])
      argPos +=3D 1
      continue
    if argName =3D=3D '--Include':
      indexStartPath =3D sys.argv[argPos]
      argPos +=3D 1
      continue
    if argName =3D=3D '--Update':
      updateIndexFile =3D sys.argv[argPos]
      argPos +=3D 1
      continue
    break

  if argPos+1 !=3D len(sys.argv):
    print('No indexing root path given (last argument)', file=3Dsys.stderr=
)
    sys.exit(1)
  rootPathName =3D sys.argv[argPos]
  doIndex(
      rootPathName, excludeRegexStrList=3DexcludeRegexStrList,
      indexStartPath=3DindexStartPath, updateIndexFile=3DupdateIndexFile)


if __name__ =3D=3D '__main__':
  mainFunction()

------- =_aaaaaaaaaa0
Content-Type: text/plain; name="IndexDeduplicationAnalyzer";
	charset="us-ascii"
Content-Description: IndexDeduplicationAnalyzer
Content-Disposition: attachment; filename="IndexDeduplicationAnalyzer"
Content-Transfer-Encoding: quoted-printable

#!/usr/bin/python3 -BbbEIsSttW all

"""This module implements a simple index file analyzer to find
resources eligible for deduplication based on the file digest.
Therefore block based deduplication candidates cannot be found
by this tool.

As all duperemove does not use the FS_IOC_FIEMAP system call
for some reason, duperemove runs are VERY slow. Therefore perform
these checks here.


This software is provided by the copyright owner "as is" and
without any expressed or implied warranties, including, but not
limited to, the implied warranties of merchantability and fitness
for a particular purpose are disclaimed. In no event shall the
copyright owner be liable for any direct, indirect, incidential,
special, exemplary or consequential damages, including, but not
limited to, procurement of substitute goods or services, loss
of use, data or profits or business interruption, however caused
and on any theory of liability, whether in contract, strict liability,
or tort, including negligence or otherwise, arising in any way
out of the use of this software, even if advised of the possibility
of such damage.

Copyright (c) 2019 halfdog <me (%) halfdog.net>

You may not distribute copies, re-license, sell or make any kind
of profit with this software without proper prior written consent
from the author. You may not remove this copyright notice, license
or terms of use.

PS: Restrictive license as I did not have time to publish this
backup data quality verification, deduplication, data synchronization
tools. I would be be willing to do so if someone assists in getting
software distributed as Debian package."""

import ctypes
import fcntl
import json
import os
import subprocess
import sys


class FiemapExtentStruct(ctypes.Structure):
  _fields_ =3D [('logicalOffset', ctypes.c_int64), ('physicalOffset', ctyp=
es.c_int64), ('length', ctypes.c_int64), ('reserved64', ctypes.c_int64*2),=
 ('flags', ctypes.c_int32), ('reserved32', ctypes.c_int32*3)]

class FiemapStruct(ctypes.Structure):
  _fields_ =3D [('startOffset', ctypes.c_int64), ('mapLength', ctypes.c_in=
t64), ('flags', ctypes.c_int32), ('extentCopied', ctypes.c_int32), ('exten=
tsAvailable', ctypes.c_int32), ('reserved', ctypes.c_int32)]


class FiemapExtentHelper():
  """This class wraps the helper for checking a list of files
  if their extends are already deduplicated."""

  def __init__(self):
    self.fiemap =3D FiemapStruct()
    self.maxExtentsCount =3D 4096
    self.fiemapExtent =3D FiemapExtentStruct()
    self.buffer =3D (ctypes.c_int8*(ctypes.sizeof(self.fiemap)+ctypes.size=
of(FiemapExtentStruct)*self.maxExtentsCount))()

  def checkFiemapExtentsMatch(self, dataCheckLength, fileNameList):
    """Check if all extents alread match.
    @return True when all extents are the same."""
    extentDataDict =3D {}
    for fileName in fileNameList:
      self.fiemap.startOffset =3D 0
      self.fiemap.mapLength =3D dataCheckLength
# FIEMAP_FLAG_SYNC 1
      self.fiemap.flags =3D 1
      self.fiemap.extentCopied =3D 0
      self.fiemap.extentsAvailable =3D self.maxExtentsCount
      ctypes.memmove(
          ctypes.addressof(self.buffer), ctypes.addressof(self.fiemap),
          ctypes.sizeof(self.fiemap))

      testFd =3D os.open(fileName, os.O_RDONLY|os.O_NOFOLLOW|os.O_NOCTTY)
      result =3D fcntl.ioctl(testFd, 0xc020660b, self.buffer, True)
      os.close(testFd)
      if result !=3D 0:
        raise Exception()
      ctypes.memmove(
          ctypes.addressof(self.fiemap), self.buffer,
          ctypes.sizeof(FiemapStruct))
      if (self.fiemap.extentCopied >=3D self.maxExtentsCount) or \
          (self.fiemap.extentsAvailable > self.maxExtentsCount):
        raise Exception(
            'Extents list exhausted: copied %d, available %d' % (
                self.fiemap.extentCopied, self.fiemap.extentsAvailable))
      extentList =3D []
      for extentPos in range(0, self.fiemap.extentCopied):
        ctypes.memmove(
            ctypes.addressof(self.fiemapExtent),
            ctypes.addressof(self.buffer)+ctypes.sizeof(FiemapStruct)+exte=
ntPos*ctypes.sizeof(FiemapExtentStruct),
            ctypes.sizeof(FiemapExtentStruct))
        extentList.append((
            self.fiemapExtent.logicalOffset,
            self.fiemapExtent.physicalOffset,
            self.fiemapExtent.length))
      extentDataDict[fileName] =3D extentList
    print('Got dict: %s' % repr(extentDataDict), file=3Dsys.stderr)
    refExtentList =3D None
    for fileName, extentList in extentDataDict.items():
      if refExtentList is None:
        refExtentList =3D extentList
      else:
        if extentList !=3D refExtentList:
          return False
    return True


class IndexedLocation():
  """This class stores information about each indexed location."""

  def __init__(self, dataPathName, indexFileName):
    self.dataPathName =3D dataPathName
    self.indexFileName =3D indexFileName

  def getDataPath(self):
    return self.dataPathName

  def getIndexData(self):
    indexFile =3D open(self.indexFileName, 'rb')
    indexData =3D indexFile.read()
    indexFile.close()
    return json.loads(str(indexData, 'ascii'))


class DedupAnalyzer():
  def __init__(self):
# 0: normal, 1: info, 2: debug
    self.logLevel =3D 0
    self.fiemapExtentHelper =3D FiemapExtentHelper()
    self.dedupFileList =3D []

  def addFile(self, fileNameBytes):
    """Add the given filename to the output performing the appropriate
    resource URL transformations."""
    if fileNameBytes.find(b'\n') >=3D 0:
      raise Exception('Output format does not support newlines')
    checkPos =3D 0
    while True:
      checkPos =3D fileNameBytes.find(b'%', checkPos)
      if checkPos < 0:
        break
      replaceByte =3D int.to_bytes(
          int(fileNameBytes[checkPos+1:checkPos+3], 16), 1, 'big')
      fileNameBytes =3D fileNameBytes[:checkPos]+replaceByte+fileNameBytes=
[checkPos+3:]
      checkPos +=3D 1
    self.dedupFileList.append(fileNameBytes)


  def flushDedupList(self, dataCheckLength):
    if len(self.dedupFileList) > 1:
      if self.fiemapExtentHelper.checkFiemapExtentsMatch(
          dataCheckLength, self.dedupFileList):
        if self.logLevel >=3D 1:
          print(
              'Files %s already deduplicated' % repr(self.dedupFileList),
              file=3Dsys.stderr)
      else:
        sys.stdout.buffer.write(b'\n'.join(self.dedupFileList)+b'\n\n')
    self.dedupFileList =3D []


  def createDeduplicationData(self, indexLocationList):
    """Create the deduplication data to be feed into duperemove.
    The function extracts all hash/length/path results from all
    indices, passes them to sort for memory efficient sorting and
    uses the output to create the duperemove output format."""

    sortProcess =3D subprocess.Popen(
        ['/usr/bin/sort'], stdin=3Dsubprocess.PIPE, stdout=3Dsubprocess.PI=
PE)
    for indexLocation in indexLocationList:
      dataPath =3D bytes(indexLocation.getDataPath(), 'ascii')
      indexData =3D indexLocation.getIndexData()
      for indexRecord in indexData:
        if indexRecord['type'] in ['dir', 'link', 'pipe', 'socket']:
          continue
        if 'digest-md5' not in indexRecord:
          raise Exception('Strange %s' % repr(indexRecord))
        sortProcess.stdin.write(b'%s %d %s%s\n' % (
            bytes(indexRecord['digest-md5'], 'ascii'), indexRecord['length=
'],
            dataPath, bytes(indexRecord['url'], 'ascii')))
    sortProcess.stdin.close()

# Now read all entries.
    lastDigest =3D None
    lastLength =3D None
    dataBuffer =3D b''
    while True:
      lineEnd =3D dataBuffer.find(b'\n')
      if lineEnd < 0:
        inputData =3D sortProcess.stdout.read(1<<20)
        if not inputData:
          if len(dataBuffer):
            raise Exception('Unhandled input data %s' % repr(dataBuffer))
          self.flushDedupList(lastLength)
          sys.stdout.buffer.write(b'\n')
          break
        dataBuffer +=3D inputData
        continue
      lineData =3D dataBuffer[:lineEnd].split(b' ')
      dataBuffer =3D dataBuffer[lineEnd+1:]

      if len(lineData) !=3D 3:
        raise Exception('Malformed line %s' % repr(lineData))

      if lineData[0] !=3D lastDigest:
        self.flushDedupList(lastLength)
        dedupFileList =3D []

        lastDigest =3D lineData[0]
        lastLength =3D int(lineData[1])
        self.addFile(lineData[2])
        continue

      if int(lineData[1]) !=3D lastLength:
        raise Exception('Collision')

# Ignore empty files.
      if lastLength =3D=3D 0:
        continue

# This is a duplicate.
      self.addFile(lineData[2])

    sortProcess.stdout.close()
    processResult =3D sortProcess.wait()
    if processResult !=3D 0:
      print('Sort terminated with error %d' % processResult, file=3Dsys.st=
derr)
      sys.exit(1)
    print('Dedupe search complete', file=3Dsys.stderr)


def mainFunction():
  """This is the main function to analyze the program call arguments
  and invoke indexing."""

  indexLocationList =3D []

  argPos =3D 1
  while argPos < len(sys.argv)-1:
    argName =3D sys.argv[argPos]
    argPos +=3D 1
    if argName =3D=3D '--':
      break
    if argName =3D=3D '--IndexedDir':
      dataPathName =3D os.path.realpath(sys.argv[argPos])
      argPos +=3D 1
      if dataPathName =3D=3D '/':
        print(
            'Cannot use %s as indexed dir as no parent directory exists' %=
 dataPathName, file=3Dsys.stderr)
        sys.exit(1)
      indexFileName =3D os.path.normpath('%s-Index.json' % dataPathName)
      if (not os.path.isdir(dataPathName)) or \
          (not os.path.exists(indexFileName)):
        print(
            'Data path %s or index file %s does not exist' % (
                repr(dataPathName), repr(indexFileName)), file=3Dsys.stder=
r)
        sys.exit(1)
      indexLocationList.append(IndexedLocation(dataPathName, indexFileName=
))
      continue
    if argName =3D=3D '--IndexFile':
      if argPos+2 > len(sys.argv):
        print(
            '--IndexFile requires index file and data path argument',
            file=3Dsys.stderr)
        sys.exit(1)
      indexFileName =3D os.path.realpath(sys.argv[argPos])
      argPos +=3D 1
      dataPathName =3D os.path.realpath(sys.argv[argPos])
      argPos +=3D 1
      if (not os.path.isdir(dataPathName)) or \
          (not os.path.exists(indexFileName)):
        print(
            'Data path %s or index file %s does not exist' % (
                repr(dataPathName), repr(indexFileName)), file=3Dsys.stder=
r)
        sys.exit(1)
      indexLocationList.append(IndexedLocation(dataPathName, indexFileName=
))
      continue

    print('Unsupported argument %s' % argName, file=3Dsys.stderr)
    sys.exit(1)

  analyzer =3D DedupAnalyzer()
  analyzer.createDeduplicationData(indexLocationList)

if __name__ =3D=3D '__main__':
  mainFunction()

------- =_aaaaaaaaaa0--

