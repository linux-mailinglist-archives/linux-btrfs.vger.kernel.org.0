Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8F912DA6FE
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Dec 2020 05:01:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725997AbgLOEAG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 14 Dec 2020 23:00:06 -0500
Received: from mail.synology.com ([211.23.38.101]:34740 "EHLO synology.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725945AbgLOEAG (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 14 Dec 2020 23:00:06 -0500
From:   ethanwu <ethanwu@synology.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synology.com; s=123;
        t=1608004764; bh=eONTHYlh7hFNP11s5x3eVU8vMw7z9yd3I51VV3uawqM=;
        h=From:To:Cc:Subject:Date;
        b=cooldKHJQAjaGdZtzD4kVRVwXF4w3OtphUXjhSDAQmML/Ckhds6btxp1OtIF8siRy
         bQGW0eC0nkjT4o61KF5qjQ/YJCS0FnzQbQMc5eG9v8ifuQRSoODRPxsEKcaqFtupyQ
         tfrHcn7BK2XY3+kjWbxjSS6m+WOxBTAwoMPx30S0=
To:     fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, ethanwu <ethanwu@synology.com>
Subject: [PATCH v2] btrfs: test if rename handles dir item collision correctly
Date:   Tue, 15 Dec 2020 11:59:06 +0800
Message-Id: <20201215035906.233272-1-ethanwu@synology.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Synology-MCP-Status: no
X-Synology-Spam-Flag: no
X-Synology-Spam-Status: score=0, required 6, WHITELIST_FROM_ADDRESS 0
X-Synology-Virus-Status: no
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is a regression test for the issue fixed by the kernel commit titled
"btrfs: correctly calculate item size used when item key collision happens"

In this case, we'll simply rename many forged filename that cause collision
under a directory to see if rename failed and filesystem is forced readonly.

Signed-off-by: ethanwu <ethanwu@synology.com>
---
v2:
- Add a python script to generate the forged name at run-time rather than
from hardcoded names
- Fix , Btrfs->btrfs, and typo mentioned in v1

 src/btrfs_crc32c_forged_name.py | 92 +++++++++++++++++++++++++++++++++
 tests/btrfs/228                 | 72 ++++++++++++++++++++++++++
 tests/btrfs/228.out             |  2 +
 tests/btrfs/group               |  1 +
 4 files changed, 167 insertions(+)
 create mode 100755 src/btrfs_crc32c_forged_name.py
 create mode 100755 tests/btrfs/228
 create mode 100644 tests/btrfs/228.out

diff --git a/src/btrfs_crc32c_forged_name.py b/src/btrfs_crc32c_forged_name.py
new file mode 100755
index 00000000..d8abedde
--- /dev/null
+++ b/src/btrfs_crc32c_forged_name.py
@@ -0,0 +1,92 @@
+# SPDX-License-Identifier: GPL-2.0
+
+import struct
+import sys
+import os
+import argparse
+
+class CRC32(object):
+  """A class to calculate and manipulate CRC32."""
+  def __init__(self):
+    self.polynom = 0x82F63B78
+    self.table, self.reverse = [0]*256, [0]*256
+    self._build_tables()
+
+  def _build_tables(self):
+    for i in range(256):
+      fwd = i
+      rev = i << 24
+      for j in range(8, 0, -1):
+        # build normal table
+        if (fwd & 1) == 1:
+          fwd = (fwd >> 1) ^ self.polynom
+        else:
+          fwd >>= 1
+        self.table[i] = fwd & 0xffffffff
+        # build reverse table =)
+        if rev & 0x80000000 == 0x80000000:
+          rev = ((rev ^ self.polynom) << 1) | 1
+        else:
+          rev <<= 1
+        rev &= 0xffffffff
+        self.reverse[i] = rev
+
+  def calc(self, s):
+    """Calculate crc32 of a string.
+       Same crc32 as in (binascii.crc32)&0xffffffff.
+    """
+    crc = 0xffffffff
+    for c in s:
+      crc = (crc >> 8) ^ self.table[(crc ^ ord(c)) & 0xff]
+    return crc^0xffffffff
+
+  def forge(self, wanted_crc, s, pos=None):
+    """Forge crc32 of a string by adding 4 bytes at position pos."""
+    if pos is None:
+      pos = len(s)
+
+    # forward calculation of CRC up to pos, sets current forward CRC state
+    fwd_crc = 0xffffffff
+    for c in s[:pos]:
+      fwd_crc = (fwd_crc >> 8) ^ self.table[(fwd_crc ^ ord(c)) & 0xff]
+
+    # backward calculation of CRC up to pos, sets wanted backward CRC state
+    bkd_crc = wanted_crc^0xffffffff
+    for c in s[pos:][::-1]:
+      bkd_crc = ((bkd_crc << 8) & 0xffffffff) ^ self.reverse[bkd_crc >> 24]
+      bkd_crc ^= ord(c)
+
+    # deduce the 4 bytes we need to insert
+    for c in struct.pack('<L',fwd_crc)[::-1]:
+      bkd_crc = ((bkd_crc << 8) & 0xffffffff) ^ self.reverse[bkd_crc >> 24]
+      bkd_crc ^= ord(c)
+
+    res = s[:pos] + struct.pack('<L', bkd_crc) + s[pos:]
+    return res
+
+  def parse_args(self):
+    parser = argparse.ArgumentParser()
+    parser.add_argument("-d", default=os.getcwd(), dest='dir',
+                        help="directory to generate forged names")
+    parser.add_argument("-c", default=1, type=int, dest='count',
+                        help="number of forged names to create")
+    return parser.parse_args()
+
+if __name__=='__main__':
+
+  crc = CRC32()
+  wanted_crc = 0x00000000
+  count = 0
+  args = crc.parse_args()
+  dirpath=args.dir
+  while count < args.count :
+    origname = os.urandom (89).encode ("hex")[:-1].strip ("\x00")
+    forgename = crc.forge(wanted_crc, origname, 4)
+    if ("/" not in forgename) and ("\x00" not in forgename):
+      srcpath=dirpath + '/' + str(count)
+      dstpath=dirpath + '/' + forgename
+      file (srcpath, 'a').close()
+      os.rename(srcpath, dstpath)
+      os.system('btrfs fi sync %s' % (dirpath))
+      count+=1;
+
diff --git a/tests/btrfs/228 b/tests/btrfs/228
new file mode 100755
index 00000000..e38da19b
--- /dev/null
+++ b/tests/btrfs/228
@@ -0,0 +1,72 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2020 Synology.  All Rights Reserved.
+#
+# FS QA Test 228
+#
+# Test if btrfs rename handle dir item collision correctly
+# Without patch fix, rename will fail with EOVERFLOW, and filesystem
+# is forced readonly.
+#
+# This bug is going to be fixed by a patch for kernel titled
+# "btrfs: correctly calculate item size used when item key collision happens"
+#
+seq=`basename $0`
+seqres=$RESULT_DIR/$seq
+echo "QA output created by $seq"
+
+here=`pwd`
+tmp=/tmp/$$
+status=1	# failure is the default!
+trap "_cleanup; exit \$status" 0 1 2 3 15
+
+_cleanup()
+{
+	cd /
+	rm -f $tmp.*
+}
+
+# get standard environment, filters and checks
+. ./common/rc
+. ./common/filter
+
+# real QA test starts here
+
+_supported_fs btrfs
+_require_scratch
+_require_command $PYTHON2_PROG python2
+
+rm -f $seqres.full
+
+# Currently in btrfs the node/leaf size can not be smaller than the page
+# size (but it can be greater than the page size). So use the largest
+# supported node/leaf size (64Kb) so that the test can run on any platform
+# that Linux supports.
+_scratch_mkfs "--nodesize 65536" >>$seqres.full 2>&1
+_scratch_mount
+
+#
+# In the following for loop, we'll create a leaf fully occupied by
+# only one dir item with many forged collision names in it.
+#
+# leaf 22544384 items 1 free space 0 generation 6 owner FS_TREE
+# leaf 22544384 flags 0x1(WRITTEN) backref revision 1
+# fs uuid 9064ba52-3d2c-4840-8e26-35db08fa17d7
+# chunk uuid 9ba39317-3159-46c9-a75a-965ab1e94267
+#    item 0 key (256 DIR_ITEM 3737737011) itemoff 25 itemsize 65410
+#    ...
+#
+
+$PYTHON2_PROG $here/src/btrfs_crc32c_forged_name.py -d $SCRATCH_MNT -c 310
+
+ISRW=$(_fs_options $SCRATCH_DEV | grep -w "rw")
+if [ -n "$ISRW" ]; then
+	echo "FS is Read-Write Test OK"
+else
+	echo "FS is Read-Only. Test Failed"
+	status=1
+	exit
+fi
+
+# success, all done
+status=0; exit
diff --git a/tests/btrfs/228.out b/tests/btrfs/228.out
new file mode 100644
index 00000000..eae514f0
--- /dev/null
+++ b/tests/btrfs/228.out
@@ -0,0 +1,2 @@
+QA output created by 228
+FS is Read-Write Test OK
diff --git a/tests/btrfs/group b/tests/btrfs/group
index d18450c7..f8021668 100644
--- a/tests/btrfs/group
+++ b/tests/btrfs/group
@@ -228,3 +228,4 @@
 224 auto quick qgroup
 225 auto quick volume seed
 226 auto quick rw snapshot clone prealloc punch
+228 auto quick
-- 
2.25.1

