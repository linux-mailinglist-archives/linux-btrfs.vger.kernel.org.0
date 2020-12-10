Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 315C02D5A0B
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Dec 2020 13:10:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732563AbgLJMKI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 10 Dec 2020 07:10:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:55398 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728217AbgLJMKH (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 10 Dec 2020 07:10:07 -0500
From:   fdmanana@kernel.org
Authentication-Results: mail.kernel.org; dkim=permerror (bad message/signature format)
To:     fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
Subject: [PATCH] btrfs: test incremental send after removing a directory and all its files
Date:   Thu, 10 Dec 2020 12:09:17 +0000
Message-Id: <ea077f0f8a54ab3ea303494e45eb1b166de7e758.1607602049.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

Test that an incremental send operation succeeds, and produces the
correct results, after removing a directory and all its files, unmounting
the filesystem, mounting the filesystem again and creating a new file (or
directory).

This currently fails on btrfs, but is fixed by a patch that has the
following subject:

  btrfs: send, fix wrong file path when there is an inode with a pending rmdir

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 tests/btrfs/227     | 122 ++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/227.out |   6 +++
 tests/btrfs/group   |   1 +
 3 files changed, 129 insertions(+)
 create mode 100755 tests/btrfs/227
 create mode 100644 tests/btrfs/227.out

diff --git a/tests/btrfs/227 b/tests/btrfs/227
new file mode 100755
index 00000000..1cf63c85
--- /dev/null
+++ b/tests/btrfs/227
@@ -0,0 +1,122 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (C) 2020 SUSE Linux Products GmbH. All Rights Reserved.
+#
+# FS QA Test No. btrfs/227
+#
+# Test that an incremental send operation succeeds, and produces the correct
+# results, after removing a directory and all its files, unmounting the
+# filesystem, mounting the filesystem again and creating a new file (or
+# directory).
+#
+seq=`basename $0`
+seqres=$RESULT_DIR/$seq
+echo "QA output created by $seq"
+
+tmp=/tmp/$$
+status=1	# failure is the default!
+trap "_cleanup; exit \$status" 0 1 2 3 15
+
+_cleanup()
+{
+	cd /
+	rm -fr $send_files_dir
+	rm -f $tmp.*
+}
+
+# get standard environment, filters and checks
+. ./common/rc
+. ./common/filter
+
+# real QA test starts here
+_supported_fs btrfs
+_require_test
+_require_scratch
+_require_fssum
+
+send_files_dir=$TEST_DIR/btrfs-test-$seq
+
+rm -f $seqres.full
+rm -fr $send_files_dir
+mkdir $send_files_dir
+
+_scratch_mkfs >>$seqres.full 2>&1
+_scratch_mount
+
+mkdir $SCRATCH_MNT/dir
+touch $SCRATCH_MNT/dir/file1
+touch $SCRATCH_MNT/dir/file2
+touch $SCRATCH_MNT/dir/file3
+
+# Filesystem looks like:
+#
+# .                                     (ino 256)
+# |----- dir/                           (ino 257)
+#         |----- file1                  (ino 258)
+#         |----- file2                  (ino 259)
+#         |----- file3                  (ino 260)
+#
+
+# Now create the base snapshot, which is going to be the parent snapshot for
+# a later incremental send.
+$BTRFS_UTIL_PROG subvolume snapshot -r $SCRATCH_MNT \
+	$SCRATCH_MNT/mysnap1 > /dev/null
+
+$BTRFS_UTIL_PROG send -f $send_files_dir/1.snap \
+	$SCRATCH_MNT/mysnap1 2>&1 1>/dev/null | _filter_scratch
+
+# Now remove our directory and all its files.
+rm -fr $SCRATCH_MNT/dir
+
+# Unmount the filesystem and mount it again. This is to ensure that the next
+# inode that is created ends up with the same inode number that our directory
+# "dir" had, 257, which is the first free "objectid" available after mounting
+# again the filesystem.
+_scratch_cycle_mount
+
+# Now create a new file (it could be a directory as well).
+touch $SCRATCH_MNT/newfile
+
+# Filesystem now looks like:
+#
+# .                                     (ino 256)
+# |----- newfile                        (ino 257)
+#
+
+$BTRFS_UTIL_PROG subvolume snapshot -r $SCRATCH_MNT \
+		 $SCRATCH_MNT/mysnap2 > /dev/null
+$BTRFS_UTIL_PROG send -p $SCRATCH_MNT/mysnap1 -f $send_files_dir/2.snap \
+		 $SCRATCH_MNT/mysnap2 2>&1 1>/dev/null | _filter_scratch
+
+$FSSUM_PROG -A -f -w $send_files_dir/1.fssum $SCRATCH_MNT/mysnap1
+$FSSUM_PROG -A -f -w $send_files_dir/2.fssum \
+	-x $SCRATCH_MNT/mysnap2/mysnap1 $SCRATCH_MNT/mysnap2
+
+# Now recreate the filesystem by receiving both send streams and verify we get
+# the same content that the original filesystem had.
+_scratch_unmount
+_scratch_mkfs >>$seqres.full 2>&1
+_scratch_mount
+
+$BTRFS_UTIL_PROG receive -f $send_files_dir/1.snap $SCRATCH_MNT > /dev/null
+
+# The receive operation below used to fail with the following error:
+#
+#    ERROR: chown o257-9-0 failed: No such file or directory
+#
+# This is because when the kernel was processing old inode 257 (the directory),
+# it had to delay its removal because its children inodes, "file1", "file2" and
+# "file3", have higher inode numbers and will be processed (and unlinked) later.
+# Then when it processed the new inode 257 (named "newfile"), it got confused
+# and though that this inode was the one with a delayed removal and therefore
+# generate an orphan name for it ("o257-9-0") instead of its current name of
+# "newfile", causing the receiver to fail since there is no file with that
+# orphan name.
+#
+$BTRFS_UTIL_PROG receive -f $send_files_dir/2.snap $SCRATCH_MNT > /dev/null
+
+$FSSUM_PROG -r $send_files_dir/1.fssum $SCRATCH_MNT/mysnap1
+$FSSUM_PROG -r $send_files_dir/2.fssum $SCRATCH_MNT/mysnap2
+
+status=0
+exit
diff --git a/tests/btrfs/227.out b/tests/btrfs/227.out
new file mode 100644
index 00000000..251de2d5
--- /dev/null
+++ b/tests/btrfs/227.out
@@ -0,0 +1,6 @@
+QA output created by 227
+At subvol SCRATCH_MNT/mysnap1
+At subvol SCRATCH_MNT/mysnap2
+At subvol mysnap1
+OK
+OK
diff --git a/tests/btrfs/group b/tests/btrfs/group
index d18450c7..a9e53832 100644
--- a/tests/btrfs/group
+++ b/tests/btrfs/group
@@ -228,3 +228,4 @@
 224 auto quick qgroup
 225 auto quick volume seed
 226 auto quick rw snapshot clone prealloc punch
+227 auto quick send
-- 
2.28.0

