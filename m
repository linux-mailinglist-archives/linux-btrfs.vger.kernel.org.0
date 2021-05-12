Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 054CA37C9B7
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 May 2021 18:48:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235680AbhELQUw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 12 May 2021 12:20:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:38260 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235960AbhELPzC (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 12 May 2021 11:55:02 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4C7456142E;
        Wed, 12 May 2021 15:27:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620833267;
        bh=e3cT9gG1XFdHECRmkj6YKti6hFiKU8VBvIz3dH0uRvM=;
        h=From:To:Cc:Subject:Date:From;
        b=vEeRJc0hOFLe8Ch08qVy3GdChCCZr0iSN/jCKoDYgXtVXDN5RQKieGZVeZ976Grpq
         P+3kEzc09yhWuX+SLuyLLDEFmSVYLlyRuFRowjk0ePva1hKoKZ68miMK7c5DGmKZ0Q
         PXd7ZM81yOlFIBdkOJqL+QfcVWX6AE2OTJesjyztRPRJGbzKiVSG4N61sTA2JD5hLJ
         jd+Zm5sKcamDgBOusdDVrxSQ+Sg2sHR1KWC8iC6y/oPl+U9PEelWaSsqxZgJ4YuWP3
         eU4+Z/e1cdEnTrT64m7oHcwA9xBLVnnKN6pmQKHFKfBlxa3y3MCfqY2U5ik1xoHZnq
         HUjUOrf2l3nGA==
From:   fdmanana@kernel.org
To:     fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
Subject: [PATCH] btrfs: test log replay after directory fsync and moving a child directory
Date:   Wed, 12 May 2021 16:27:35 +0100
Message-Id: <4280408d6915963e1517a169b61f97c0f4486b4b.1620832936.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

Test a particular scenario where we fsync a directory, then move one of
its children directories into another directory and then finally sync the
log trees by fsyncing any other inode. We want to check that after a power
failure we are able to mount the filesystem and that the moved directory
exists only as a child of the directory we moved it into.

This currently fails on a 5.12 kernel (and 5.13-rc1) but is fixed by a
patch with the following subject:

  "btrfs: fix removed dentries still existing after log is synced"

The failure is due to ending up with a directory that has 2 hard links
(two parent directories) as soon as the log replay procedure finishes,
which causes the tree checker to detect the issue and cause the mount
operation to fail with -EIO.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 tests/btrfs/238     | 198 ++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/238.out |   5 ++
 tests/btrfs/group   |   1 +
 3 files changed, 204 insertions(+)
 create mode 100755 tests/btrfs/238
 create mode 100644 tests/btrfs/238.out

diff --git a/tests/btrfs/238 b/tests/btrfs/238
new file mode 100755
index 00000000..d43ae802
--- /dev/null
+++ b/tests/btrfs/238
@@ -0,0 +1,198 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (C) 2021 SUSE Linux Products GmbH. All Rights Reserved.
+#
+# FSQA Test No. 238
+#
+# Test a particular scenario where we fsync a directory, then move one of its
+# children directories into another directory and then finally sync the log
+# trees by fsyncing any other inode. We want to check that after a power failure
+# we are able to mount the filesystem and that the moved directory exists only
+# as a child of the directory we moved it into.
+#
+seq=`basename $0`
+seqres=$RESULT_DIR/$seq
+echo "QA output created by $seq"
+tmp=/tmp/$$
+status=1	# failure is the default!
+trap "_cleanup; exit \$status" 0 1 2 3 15
+
+_cleanup()
+{
+	_cleanup_flakey
+	cd /
+	rm -f $tmp.*
+}
+
+# get standard environment, filters and checks
+. ./common/rc
+. ./common/filter
+. ./common/dmflakey
+
+# real QA test starts here
+_supported_fs btrfs
+_require_scratch
+_require_dm_target flakey
+
+rm -f $seqres.full
+
+# The test requires a very specific layout of keys and items in the fs/subvolume
+# btree to trigger a bug. So we want to make sure that on whatever platform we
+# are, we have the same leaf/node size.
+#
+# Currently in btrfs the node/leaf size can not be smaller than the page
+# size (but it can be greater than the page size). So use the largest
+# supported node/leaf size (64K).
+#
+_scratch_mkfs "-n 65536" >>$seqres.full 2>&1
+_require_metadata_journaling $SCRATCH_DEV
+_init_flakey
+_mount_flakey
+
+# "testdir" is inode 257.
+mkdir $SCRATCH_MNT/testdir
+chmod 755 $SCRATCH_MNT/testdir
+
+# Create several empty files to have the directory "testdir" with its items
+# spread over several leaves (7 in this case).
+for ((i = 1; i <= 1200; i++)); do
+	echo -n > $SCRATCH_MNT/testdir/file$i
+done
+
+# Create our test directory "dira", inode number 1458, which gets all its items
+# in leaf 7.
+#
+# The BTRFS_DIR_ITEM_KEY item for inode 257 ("testdir") that points to the entry
+# named "dira" is in leaf 2, while the BTRFS_DIR_INDEX_KEY item that points to
+# that entry is in leaf 3.
+#
+# For this particular filesystem node size (64K), file count and file names, we
+# endup with the directory entry items from inode 257 in leaves 2 and 3, as
+# previously mentioned - what matters for triggering the bug exercised by this
+# test case is that those items are not placed in leaf 1, they must be placed in
+# a leaf different from the one containing the inode item for inode 257.
+#
+# The corresponding BTRFS_DIR_ITEM_KEY and BTRFS_DIR_INDEX_KEY items for the
+# parent inode (257) are the following:
+#
+#           item 460 key (257 DIR_ITEM 3724298081) itemoff 48344 itemsize 34
+#                location key (1458 INODE_ITEM 0) type DIR
+#                transid 6 data_len 0 name_len 4
+#                name: dira
+#
+# and:
+#
+#           item 771 key (257 DIR_INDEX 1202) itemoff 36673 itemsize 34
+#                location key (1458 INODE_ITEM 0) type DIR
+#                transid 6 data_len 0 name_len 4
+#                name: dira
+#
+mkdir $SCRATCH_MNT/testdir/dira
+
+# Make sure everything done so far is durably persisted.
+sync
+
+# Now do a change to inode 257 ("testdir") that does not result in COWing leaves
+# 2 and 3 - the leaves that contain the directory items pointing to inode 1458
+# (directory "dira").
+#
+# Changing permissions, the owner/group, updating or adding a xattr, etc, will
+# not change (COW) leaves 2 and 3. So for the sake of simplicity change the
+# permissions of inode 257, which results in updating its inode item and
+# therefore change (COW) only leaf 1.
+#
+chmod 700 $SCRATCH_MNT/testdir
+
+# Now fsync directory inode 257.
+#
+# Since only the first leaf was changed/COWed, we log the inode item of inode 257
+# and only the entries found in the first leaf, all with a key of type
+# BTRFS_DIR_ITEM_KEY, and no keys of type BTRFS_DIR_INDEX_KEY, because they sort
+# after the former type and none exist in the first leaf.
+#
+# We also log 3 items that represent ranges for dir items and dir indexes for
+# which the log is authoritative:
+#
+# 1) a key of type BTRFS_DIR_LOG_ITEM_KEY, which indicates the log is
+#    authoritative for all BTRFS_DIR_ITEM_KEY keys that have an offset in the
+#    range [0, 2285968570] (the offset here is the crc32c of the dentry's
+#    name). The value 2285968570 corresponds to the offset of the first key
+#    of leaf 2 (which is of type BTRFS_DIR_ITEM_KEY);
+#
+# 2) a key of type BTRFS_DIR_LOG_ITEM_KEY, which indicates the log is
+#    authoritative for all BTRFS_DIR_ITEM_KEY keys that have an offset in the
+#    range [4293818216, (u64)-1] (the offset here is the crc32c of the dentry's
+#    name). The value 4293818216 corresponds to the offset of the highest key
+#    of type BTRFS_DIR_ITEM_KEY plus 1 (4293818215 + 1), which is located in
+#    leaf 2;
+#
+# 3) a key of type BTRFS_DIR_LOG_INDEX_KEY, with an offset of 1203, which
+#    indicates the log is authoritative for all keys of type BTRFS_DIR_INDEX_KEY
+#    that have an offset in the range [1203, (u64)-1]. The value 1203 corresponds
+#    to the offset of the last key of type BTRFS_DIR_INDEX_KEY plus 1 (1202 + 1),
+#    which is located in leaf 3;
+#
+# Also, because "testdir" is a directory and inode 1458 ("dira") is a child
+# directory, we log inode 1458 too.
+#
+$XFS_IO_PROG -c "fsync" $SCRATCH_MNT/testdir
+
+# Now move "dira", inode 1458, to be a child of the root directory (inode 256).
+#
+# Because this inode was previously logged, when "testdir" was fsynced, the
+# log is updated so that the old inode reference, referring to inode 257 as
+# the parent, is deleted and the new inode reference, referring to inode 256
+# as the parent, is added to the log.
+#
+mv $SCRATCH_MNT/testdir/dira $SCRATCH_MNT/
+
+# Now change some file and fsync it. This guarantees the log changes made by
+# the previous move/rename operation are persisted. We do not need to do any
+# special modification to the file, just any change to any file and sync the
+# log.
+$XFS_IO_PROG -c "pwrite -S 0xab 0 64K" \
+	     -c "fsync" \
+	     $SCRATCH_MNT/testdir/file1 >>$seqres.full
+
+# Simulate a power failure and then mount again the filesystem to replay the log
+# tree. We want to verify that we are able to mount the filesystem, meaning log
+# replay was successful, and that directory inode 1458 ("dira") only has inode
+# 256 (the filesystem's root) as its parent (and no longer a child of inode 257).
+#
+# It used to happen that during log replay we would end up having inode 1458
+# (directory "dira") with 2 hard links, being a child of inode 257 ("testdir")
+# and inode 256 (the filesystem's root). This resulted in the tree checker
+# detecting the issue and causing the mount operation to fail (with -EIO).
+#
+# This happened because in the log we have the new name/parent for inode 1458,
+# which results in adding the new dentry with inode 256 as the parent, but the
+# previous dentry, under inode 257 was never removed - this is because the
+# ranges for dir items and dir indexes of inode 257 for which the log is
+# authoritative do not include the old dir item and dir index for the dentry
+# of inode 257 referring to inode 1458:
+#
+# - for dir items, the log is authoritative for the ranges [0, 2285968570] and
+#   [4293818216, (u64)-1]. The dir item at inode 257 pointing to inode 1458 has
+#   a key of (257 DIR_ITEM 3724298081), as previously mentioned, so the dir item
+#   is not deleted when the log replay procedure processes the authoritative
+#   ranges, as 3724298081 is outside both ranges;
+#
+# - for dir indexes, the log is authoritative for the range [1203, (u64)-1], and
+#   the dir index item of inode 257 pointing to inode 1458 has a key of
+#   (257 DIR_INDEX 1202), as previously mentioned, so the dir index item is not
+#   deleted when the log replay procedure processes the authoritative range.
+#
+_flakey_drop_and_remount
+
+[ -d $SCRATCH_MNT/testdir/dira ] && echo "/testdir/dira still exists"
+[ -d $SCRATCH_MNT/dira ] || echo "/dira does not exists"
+
+# While at it also check that the data we wrote was not lost, just for the sake
+# of completeness.
+echo "File $SCRATCH_MNT/testdir/file1 data:" | _filter_scratch
+od -A d -t x1 $SCRATCH_MNT/testdir/file1
+
+_unmount_flakey
+
+status=0
+exit
diff --git a/tests/btrfs/238.out b/tests/btrfs/238.out
new file mode 100644
index 00000000..792de99d
--- /dev/null
+++ b/tests/btrfs/238.out
@@ -0,0 +1,5 @@
+QA output created by 238
+File SCRATCH_MNT/testdir/file1 data:
+0000000 ab ab ab ab ab ab ab ab ab ab ab ab ab ab ab ab
+*
+0065536
diff --git a/tests/btrfs/group b/tests/btrfs/group
index 20a8ee3b..940da1bd 100644
--- a/tests/btrfs/group
+++ b/tests/btrfs/group
@@ -240,3 +240,4 @@
 235 auto quick send
 236 auto quick log
 237 auto quick zone balance
+238 auto quick log
-- 
2.28.0

