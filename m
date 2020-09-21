Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D82827252D
	for <lists+linux-btrfs@lfdr.de>; Mon, 21 Sep 2020 15:16:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726630AbgIUNPi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 21 Sep 2020 09:15:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:44342 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726445AbgIUNPi (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 21 Sep 2020 09:15:38 -0400
Received: from debian8.Home (bl8-197-74.dsl.telepac.pt [85.241.197.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1A36220719;
        Mon, 21 Sep 2020 13:15:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600694137;
        bh=T+quOTiY2P4ZUT6PMc491pg9cSDAM2YMf8N6cRVFYnw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=p3HpUndH8D0dVQ72oMMXTKMZHnwanF4Ceak7x4BTFlQntdlK5Rh6BCT4sRIOeN+sU
         ybjrO8ni1hWoN3fOJ9TB1tYXBzOROJF9SX4K+8O/eRo3ujVWyQmJxSTa767Z/Ao524
         x9fP5fOircWqxc0NV5IUiMzYkpjkPIQKOByZPlK4=
From:   fdmanana@kernel.org
To:     fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
Subject: [PATCH 1/2] btrfs: test incremental send after a succession of rename and link operations
Date:   Mon, 21 Sep 2020 14:15:31 +0100
Message-Id: <83001e537cdf42258dd4b4e3212546dfd099a337.1600693732.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1600693732.git.fdmanana@suse.com>
References: <cover.1600693732.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

Test that an incremental send operation emits the correct path for link
and rename operation after swapping the names and locations of several
inodes in a way that creates a nasty dependency of rename and link
operations. Notably one file has its name and location swapped with a
directory for which it used to have a directory entry in it.

This test currently fails but a kernel patch for it exists and has the
following subject:

  "btrfs: send, orphanize first all conflicting inodes when processing references"

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 tests/btrfs/221     | 119 ++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/221.out |   6 +++
 tests/btrfs/group   |   1 +
 3 files changed, 126 insertions(+)
 create mode 100755 tests/btrfs/221
 create mode 100644 tests/btrfs/221.out

diff --git a/tests/btrfs/221 b/tests/btrfs/221
new file mode 100755
index 00000000..a482d0c5
--- /dev/null
+++ b/tests/btrfs/221
@@ -0,0 +1,119 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (C) 2020 SUSE Linux Products GmbH. All Rights Reserved.
+#
+# FS QA Test No. btrfs/221
+#
+# Test that an incremental send operation emits the correct path for link and
+# rename operation after swapping the names and locations of several inodes in
+# a way that creates a nasty dependency of rename and link operations. Notably
+# one file has its name and location swapped with a directory for which it used
+# to have a directory entry in it.
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
+touch $SCRATCH_MNT/a
+touch $SCRATCH_MNT/b
+mkdir $SCRATCH_MNT/testdir
+# We want "a" to have a lower inode number than its parent directory, so it
+# was created before the directory and then moved into it.
+mv $SCRATCH_MNT/a $SCRATCH_MNT/testdir/a
+
+# Filesystem looks like:
+#
+# .                                                      (ino 256)
+# |----- testdir/                                        (ino 259)
+# |          |----- a                                    (ino 257)
+# |
+# |----- b                                               (ino 258)
+#
+$BTRFS_UTIL_PROG subvolume snapshot -r $SCRATCH_MNT \
+	$SCRATCH_MNT/mysnap1 > /dev/null
+
+$BTRFS_UTIL_PROG send -f $send_files_dir/1.snap \
+	$SCRATCH_MNT/mysnap1 2>&1 1>/dev/null | _filter_scratch
+
+# Now rename 259 to "testdir_2", then change the name of 257 to "testdir" and
+# make it a direct descendant of the root inode (256). Also create a new link
+# for inode 257 with the old name of inode 258. By swapping the names and
+# location of several inodes and create a nasty dependency chain of rename and
+# link operations.
+mv $SCRATCH_MNT/testdir/a $SCRATCH_MNT/a2
+touch $SCRATCH_MNT/testdir/a
+mv $SCRATCH_MNT/b $SCRATCH_MNT/b2
+ln $SCRATCH_MNT/a2 $SCRATCH_MNT/b
+mv $SCRATCH_MNT/testdir $SCRATCH_MNT/testdir_2
+mv $SCRATCH_MNT/a2 $SCRATCH_MNT/testdir
+
+# Filesystem now looks like:
+#
+# .                                                      (ino 256)
+# |----- testdir_2/                                      (ino 259)
+# |          |----- a                                    (ino 260)
+# |
+# |----- testdir                                         (ino 257)
+# |----- b                                               (ino 257)
+# |----- b2                                              (ino 258)
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
+# The receive operation below used to fail because when attemping to create the
+# hard link named "b" for inode 257, the link operation contained a target path
+# of "o259-6-0/a", which caused the receiver process to fail because inode 259
+# was not yet orphanized (renamed to "o259-6-0"), it still had the name "testdir"
+# when the link operation was issued.
+$BTRFS_UTIL_PROG receive -f $send_files_dir/2.snap $SCRATCH_MNT > /dev/null
+
+$FSSUM_PROG -r $send_files_dir/1.fssum $SCRATCH_MNT/mysnap1
+$FSSUM_PROG -r $send_files_dir/2.fssum $SCRATCH_MNT/mysnap2
+
+status=0
+exit
diff --git a/tests/btrfs/221.out b/tests/btrfs/221.out
new file mode 100644
index 00000000..4c887062
--- /dev/null
+++ b/tests/btrfs/221.out
@@ -0,0 +1,6 @@
+QA output created by 221
+At subvol SCRATCH_MNT/mysnap1
+At subvol SCRATCH_MNT/mysnap2
+At subvol mysnap1
+OK
+OK
diff --git a/tests/btrfs/group b/tests/btrfs/group
index 1b5fa695..8b285dbb 100644
--- a/tests/btrfs/group
+++ b/tests/btrfs/group
@@ -222,3 +222,4 @@
 218 auto quick volume
 219 auto quick volume
 220 auto quick
+221 auto quick send
-- 
2.26.2

