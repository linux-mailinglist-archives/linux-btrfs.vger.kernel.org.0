Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C6D23A110E
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Jun 2021 12:50:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235338AbhFIK1R (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 9 Jun 2021 06:27:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:38572 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236353AbhFIK1P (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 9 Jun 2021 06:27:15 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7102B61181;
        Wed,  9 Jun 2021 10:25:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623234321;
        bh=eiEb4gH91Za/lqH6iKzWMw1/pnt+zZii3cfekM5/ExM=;
        h=From:To:Cc:Subject:Date:From;
        b=btTNw6Q/21EKDbwrfukYOvvHg0UZiptiEyNYE9fk2q2KZYCmQsCP2U6wymllWEJYY
         QD7PiSIvKHXxgjnoiNnTcbGXQ7Lfu73QIQ+cyF/bqUSJxtV8hJYo6+nS9/Jbl3GNP0
         LQcdzpVzqx8u2IcbJRJeWVuRqj2G42l5gkTqU3hRXe5GmeF2wr8uiWWBmoj0R906XY
         MZvYmunrg1iq8G6SEnHAqFIbYKk9wzbJGQ6wXbIfd1bwHVzMCTzQl5bmskdKp3QWq6
         cxl/PuakKUdJ0PcrFqVTyzQHTZi8Cm6HLJRC2MgAYtSMSKfyWbzpFMLOEpXCXDpO+n
         faekvB3zjDg3Q==
From:   fdmanana@kernel.org
To:     fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
Subject: [PATCH] btrfs: test incremental send swapping location of a directory with a file
Date:   Wed,  9 Jun 2021 11:25:14 +0100
Message-Id: <64a68b520d170b21c5f72837f32d735a5d5471d8.1623234115.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

Test that an incremental send operation succeeds, and produces the
correct results, after renaming and moving around directories and files
with multiple hardlinks, in such a way that one of the files gets the old
name and location of a directory and another name (hardlink) with the old
name and location of another file that was located in that same directory.

This currently fails on btrfs but is fixed by a kernel patch with the
following subject:

  "btrfs: send: fix invalid path for unlink operations after parent orphanization"

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 tests/btrfs/241     | 148 ++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/241.out |   6 ++
 tests/btrfs/group   |   1 +
 3 files changed, 155 insertions(+)
 create mode 100755 tests/btrfs/241
 create mode 100644 tests/btrfs/241.out

diff --git a/tests/btrfs/241 b/tests/btrfs/241
new file mode 100755
index 00000000..96f2e190
--- /dev/null
+++ b/tests/btrfs/241
@@ -0,0 +1,148 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (C) 2021 SUSE Linux Products GmbH. All Rights Reserved.
+#
+# FS QA Test No. btrfs/241
+#
+# Test that an incremental send operation succeeds, and produces the correct
+# results, after renaming and moving around directories and files with multiple
+# hardlinks, in such a way that one of the files gets the old name and location
+# of a directory and another name (hardlink) with the old name and location of
+# another file that was located in that same directory.
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
+# Create our test files and directory. Inode 259 (file3) has two hard links.
+touch $SCRATCH_MNT/file1
+touch $SCRATCH_MNT/file2
+touch $SCRATCH_MNT/file3
+
+mkdir $SCRATCH_MNT/A
+ln $SCRATCH_MNT/file3 $SCRATCH_MNT/A/hard_link
+
+# Filesystem looks like:
+#
+# .                                     (ino 256)
+# |----- file1                          (ino 257)
+# |----- file2                          (ino 258)
+# |----- file3                          (ino 259)
+# |----- A/                             (ino 260)
+#        |---- hard_link                (ino 259)
+#
+
+# Now create the base snapshot, which is going to be the parent snapshot for
+# a later incremental send and receive.
+$BTRFS_UTIL_PROG subvolume snapshot -r $SCRATCH_MNT \
+	$SCRATCH_MNT/mysnap1 > /dev/null
+
+$BTRFS_UTIL_PROG send -f $send_files_dir/1.snap \
+	$SCRATCH_MNT/mysnap1 2>&1 1>/dev/null | _filter_scratch
+
+# Move inode 257 into directory inode 260. This results in computing the path
+# for inode 260 as "/A" and caching it.
+mv $SCRATCH_MNT/file1 $SCRATCH_MNT/A/file1
+
+# Move inode 258 (file2) into directory inode 260, with a name of "hard_link",
+# moving first inode 259 away since it currently has that location and name.
+mv $SCRATCH_MNT/A/hard_link $SCRATCH_MNT/tmp
+mv $SCRATCH_MNT/file2 $SCRATCH_MNT/A/hard_link
+
+# Now rename inode 260 to something else (B for example) and then create a hard
+# link for inode 258 that has the old name and location of inode 260 ("/A").
+mv $SCRATCH_MNT/A $SCRATCH_MNT/B
+ln $SCRATCH_MNT/B/hard_link $SCRATCH_MNT/A
+
+# Filesystem now looks like:
+#
+# .                                     (ino 256)
+# |----- tmp                            (ino 259)
+# |----- file3                          (ino 259)
+# |----- B/                             (ino 260)
+# |      |---- file1                    (ino 257)
+# |      |---- hard_link                (ino 258)
+# |
+# |----- A                              (ino 258)
+
+# Create another snapshot of our subvolume and use it for an incremental send.
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
+# First add the first snapshot to the new filesystem by applying the first send
+# stream.
+$BTRFS_UTIL_PROG receive -f $send_files_dir/1.snap $SCRATCH_MNT > /dev/null
+
+# The incremental receive operation below used to fail with the following error:
+#
+#    ERROR: unlink A/hard_link failed: No such file or directory
+#
+# This is because when send is processing inode 257, it generates the path for
+# inode 260 as "/A", since that inode is its parent in the send snapshot, and
+# caches that path.
+#
+# Later when processing inode 258, it first processes its new reference that has
+# the path of "/A", which results in orphanizing inode 260 because there is a
+# a path collision. This results in issuing a rename operation from "/A" to
+# "/o260-6-0".
+#
+# Finally when processing the new reference "B/hard_link" for inode 258, it
+# notices that it collides with inode 259 (not yet processed, because it has a
+# higher inode number), since that inode has the name "hard_link" under the
+# directory inode 260. It also checks that inode 259 has two hardlinks, so it
+# decides to issue a unlink operation for the name "hard_link" for inode 259.
+# However the path passed to the unlink operation is "/A/hard_link", which is
+# incorrect since currently "/A" does not exists, due to the orphanization of
+# inode 260 mentioned before. The path is incorrect because it was computed and
+# cached before the orphanization. This results in the receiver to fail with the
+# above error.
+#
+$BTRFS_UTIL_PROG receive -f $send_files_dir/2.snap $SCRATCH_MNT > /dev/null
+
+$FSSUM_PROG -r $send_files_dir/1.fssum $SCRATCH_MNT/mysnap1
+$FSSUM_PROG -r $send_files_dir/2.fssum $SCRATCH_MNT/mysnap2
+
+status=0
+exit
diff --git a/tests/btrfs/241.out b/tests/btrfs/241.out
new file mode 100644
index 00000000..c47940d7
--- /dev/null
+++ b/tests/btrfs/241.out
@@ -0,0 +1,6 @@
+QA output created by 241
+At subvol SCRATCH_MNT/mysnap1
+At subvol SCRATCH_MNT/mysnap2
+At subvol mysnap1
+OK
+OK
diff --git a/tests/btrfs/group b/tests/btrfs/group
index ad59ed3e..4fdd4d44 100644
--- a/tests/btrfs/group
+++ b/tests/btrfs/group
@@ -243,3 +243,4 @@
 238 auto quick seed trim
 239 auto quick log
 240 auto quick prealloc log
+241 auto quick send
-- 
2.28.0

