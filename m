Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A19D27252E
	for <lists+linux-btrfs@lfdr.de>; Mon, 21 Sep 2020 15:16:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726795AbgIUNPk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 21 Sep 2020 09:15:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:44354 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726445AbgIUNPk (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 21 Sep 2020 09:15:40 -0400
Received: from debian8.Home (bl8-197-74.dsl.telepac.pt [85.241.197.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 408BE21789;
        Mon, 21 Sep 2020 13:15:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600694139;
        bh=qJhpdYjpnba+2A/Z0duqTIyXEWwPxdXaL2zODSwbcjo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1+RwN+STFHNZB2tl/zsDY/hie5g0VzrGAGPidZL8NY5ebwFrn5urVbCoE3ARekBs6
         55wdfo87tj4T5Y31ViWELG/nzXOE4SjAIUXhn9Qsju/1REBihJgxAxoA/VE1ns2bvd
         hszlwPmg5inhYT4mn0y+fFTwhKj3nbv6RNk50/24=
From:   fdmanana@kernel.org
To:     fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
Subject: [PATCH 2/2] btrfs: test incremental send after swapping same file with two directories
Date:   Mon, 21 Sep 2020 14:15:32 +0100
Message-Id: <86d811965c984a6b16afa12ecb7e6e7512780ba6.1600693732.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1600693732.git.fdmanana@suse.com>
References: <cover.1600693732.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

Test an incremental send operation after doing a series of changes in a
tree such that one inode gets two hardlinks with names and locations
swapped with two other inodes that correspond to different directories,
and one of these directories is the parent of the other directory.

This currently fails on btrfs, the receive of the incremental send stream
fails. This is fixed by a patchset for btrfs which has two patches with the
following subjects:

  "btrfs: send, orphanize first all conflicting inodes when processing references"
  "btrfs: send, recompute reference path after orphanization of a directory"

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 tests/btrfs/222     | 142 ++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/222.out |   6 ++
 tests/btrfs/group   |   1 +
 3 files changed, 149 insertions(+)
 create mode 100755 tests/btrfs/222
 create mode 100644 tests/btrfs/222.out

diff --git a/tests/btrfs/222 b/tests/btrfs/222
new file mode 100755
index 00000000..51fd052a
--- /dev/null
+++ b/tests/btrfs/222
@@ -0,0 +1,142 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (C) 2020 SUSE Linux Products GmbH. All Rights Reserved.
+#
+# FS QA Test No. btrfs/222
+#
+# Test an incremental send operation after doing a series of changes in a tree
+# such that one inode gets two hardlinks with names and locations swapped with
+# two other inodes that correspond to different directories, and one of these
+# directories is the parent of the other directory.
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
+touch $SCRATCH_MNT/f1
+touch $SCRATCH_MNT/f2
+mkdir $SCRATCH_MNT/d1
+mkdir $SCRATCH_MNT/d1/d2
+
+# Filesystem looks like:
+#
+# .                                     (ino 256)
+# |----- f1                             (ino 257)
+# |----- f2                             (ino 258)
+# |----- d1/                            (ino 259)
+#        |----- d2/                     (ino 260)
+#
+$BTRFS_UTIL_PROG subvolume snapshot -r $SCRATCH_MNT \
+	$SCRATCH_MNT/mysnap1 > /dev/null
+
+$BTRFS_UTIL_PROG send -f $send_files_dir/1.snap \
+	$SCRATCH_MNT/mysnap1 2>&1 1>/dev/null | _filter_scratch
+
+# Now do a series of changes such that:
+#
+# *) inode 258 has one new hardlink and the previous name changed
+#
+# *) both names conflict with the old names of two other inodes:
+#
+#    1) the new name "d1" conflicts with the old name of inode 259, under
+#       directory inode 256 (root)
+#
+#    2) the new name "d2" conflicts with the old name of inode 260 under
+#       directory inode 259
+#
+# *) inodes 259 and 260 now have the old names of inode 258
+#
+# *) inode 257 is now located under inode 260 - an inode with a number
+#    smaller than the inode (258) for which we created a second hard link
+#    and swapped its names with inodes 259 and 260
+#
+ln $SCRATCH_MNT/f2 $SCRATCH_MNT/d1/f2_link
+mv $SCRATCH_MNT/f1 $SCRATCH_MNT/d1/d2/f1
+
+# Swap d1 and f2.
+mv $SCRATCH_MNT/d1 $SCRATCH_MNT/tmp
+mv $SCRATCH_MNT/f2 $SCRATCH_MNT/d1
+mv $SCRATCH_MNT/tmp $SCRATCH_MNT/f2
+
+# Swap d2 and f2_link
+mv $SCRATCH_MNT/f2/d2 $SCRATCH_MNT/tmp
+mv $SCRATCH_MNT/f2/f2_link $SCRATCH_MNT/f2/d2
+mv $SCRATCH_MNT/tmp $SCRATCH_MNT/f2/f2_link
+
+# Filesystem now looks like:
+#
+# .                                     (ino 256)
+# |----- d1                             (ino 258)
+# |----- f2/                            (ino 259)
+#        |----- f2_link/                (ino 260)
+#        |       |----- f1              (ino 257)
+#        |
+#        |----- d2                      (ino 258)
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
+#    ERROR: rename d1/d2 -> o260-6-0 failed: No such file or directory
+#
+# Because when processing inode 258, the kernel orphanized first inode 259,
+# renaming it from "d1" to "o259-6-0", since it the new reference named "d1"
+# for inode 258 conflicts with the old one of inode 259, which was not yet
+# processed. After that, because the new reference named "d2" for inode 258
+# conflicts with the old reference of the not yet processed inode 260, it
+# tried to orphanize inode 260 - however the corresponding rename operation
+# used a source path of "d1/d2", instead of "o259-6-0/d2".
+#
+$BTRFS_UTIL_PROG receive -f $send_files_dir/2.snap $SCRATCH_MNT > /dev/null
+
+$FSSUM_PROG -r $send_files_dir/1.fssum $SCRATCH_MNT/mysnap1
+$FSSUM_PROG -r $send_files_dir/2.fssum $SCRATCH_MNT/mysnap2
+
+status=0
+exit
diff --git a/tests/btrfs/222.out b/tests/btrfs/222.out
new file mode 100644
index 00000000..4fea113d
--- /dev/null
+++ b/tests/btrfs/222.out
@@ -0,0 +1,6 @@
+QA output created by 222
+At subvol SCRATCH_MNT/mysnap1
+At subvol SCRATCH_MNT/mysnap2
+At subvol mysnap1
+OK
+OK
diff --git a/tests/btrfs/group b/tests/btrfs/group
index 8b285dbb..3b009220 100644
--- a/tests/btrfs/group
+++ b/tests/btrfs/group
@@ -223,3 +223,4 @@
 219 auto quick volume
 220 auto quick
 221 auto quick send
+222 auto quick send
-- 
2.26.2

