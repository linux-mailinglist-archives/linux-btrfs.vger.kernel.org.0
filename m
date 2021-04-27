Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16B9C36C3ED
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Apr 2021 12:31:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238254AbhD0Kbn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 27 Apr 2021 06:31:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:51788 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238355AbhD0Kal (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 27 Apr 2021 06:30:41 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5410660FDC;
        Tue, 27 Apr 2021 10:29:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619519398;
        bh=JuFQSSdjTAshSNbLTWlbr7EBUfwEO2Qbi8I3Fsx2qq4=;
        h=From:To:Cc:Subject:Date:From;
        b=hXm0Jh+FKkRrUyNUYMf9F1NqtZV8pnybt1EoSoaQmmedMRV3fofFz2OU0UoDa7B5a
         MfvY5wZnd+ZBVsA1NNNXGM5+Ajas84HvoSXC7mhDtu+UJ2Bc9Mh83OMRg1EDpWHre8
         9blHn49Q0Y2nDnCNbjgU3IN/dtk2dLjfr9Y1EbzqTGodC7e/P9bTLhr9DTyUC9Qfrb
         vAoZc+lH2t2TcDUnOh0dLQ9BYfacH6m/zQ2T4IXNphbqOsYcfoGk9is/T1Lg6XOD7z
         oJl64VJta8YsTC6jCZwA3+qnYFzfICUCjToP2WvfEMlrdNXR+MPNDFrSBA0uELE7Pe
         L2QaMKsD3HeFA==
From:   fdmanana@kernel.org
To:     fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
Subject: [PATCH] btrfs: test fsync after rename and link with cow and nocow writes
Date:   Tue, 27 Apr 2021 11:29:50 +0100
Message-Id: <aebb03f059047c083e0c5e089d9815f547198474.1619519116.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

Test for fsync data loss after renaming a file or adding a hard link,
with a previous fsync of another file, as well as that mtime and ctime
are correct after a power failure. Test both with COW and NOCOW writes.

This currently fails differently on different kernels:

- For kernels older than 4.19 (<= 4.18) and kernels starting from 5.10,
  the NOCOW tests are expected to fail very often on the mtime and ctime
  checks.

  The data loss check has slim chances of failing on a virtualized
  environment, because the race that leads to the data loss is due to
  the fsync() returning after writeback of the data finishes and
  returning without issuing barriers (sending REQ_PREFLUSH to the
  device), as explained in the test's comments.

  For kernels between 4.19 (inclusive) and 5.9 (inclusive), it is not
  expected to fail.

- For the btrfs integration branch (misc-next), and what is currently in
  Linus' master branch (5.13 merge window changes), in addition to the
  failures mentioned before, the test should fail very often on the data
  loss and mtime/ctime checks for COW writes.

The issues are fixed by a patch for the kernel that has the following
subject:

  "btrfs: fix race leading to unpersisted data and metadata on fsync"

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 tests/btrfs/236     | 199 ++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/236.out |   5 ++
 tests/btrfs/group   |   1 +
 3 files changed, 205 insertions(+)
 create mode 100755 tests/btrfs/236
 create mode 100644 tests/btrfs/236.out

diff --git a/tests/btrfs/236 b/tests/btrfs/236
new file mode 100755
index 00000000..58c86427
--- /dev/null
+++ b/tests/btrfs/236
@@ -0,0 +1,199 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (C) 2021 SUSE Linux Products GmbH. All Rights Reserved.
+#
+# FSQA Test No. 236
+#
+# Test for fsync data loss after renaming a file or adding a hard link, with a
+# previous fsync of another file, as well as that mtime and ctime are correct.
+# Test both with COW and NOCOW writes.
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
+# The comments inside the function mentioning specific inode numbers and IDs
+# (transactions, log commits, etc) are for the case where the function is run
+# on a freshly created filesystem, but the logic and reasoning still applies
+# for future invocations.
+test_fsync()
+{
+	local suffix=$1
+	local op_type=$2
+	local foo="$SCRATCH_MNT/foo_$suffix"
+	local bar="$SCRATCH_MNT/bar_$suffix"
+	local baz="$SCRATCH_MNT/baz_$suffix"
+	local digest_before
+	local digest_after
+	local mtime_before
+	local ctime_before
+	local mtime_after
+	local ctime_after
+
+	if [ "$op_type" != "rename" ] && [ "$op_type" != "link" ]; then
+		_fail "Operation type, 2nd argument, must be 'rename' or 'link'"
+	fi
+
+	# Create an extra empty file to be used later for syncing the log and
+	# bumping the committed log transaction ID by +1.
+	touch $bar
+
+	# This is the file we are interested in testing for data loss after an
+	# fsync. Create it and fill it with initial data, then fsync it.
+	#
+	# Before the fsync the inode has the full sync flag set, the current
+	# log transaction has an ID of 0 (first log transaction), the inode's
+	# ->logged_trans is 0, ->last_sub_trans is 0 and ->last_log_commit is -1.
+	#
+	# After the fsync the full sync flag is not set anymore, ->logged_trans
+	# is 6 (generation of the current transaction), ->last_log_commit is 0
+	# (which is the value of ->last_sub_trans) and ->last_sub_trans remains
+	# as 0.
+	#
+	# Also, after the fsync, the log transaction ID is bumped from 0 to 1.
+	#
+	$XFS_IO_PROG -f -c "pwrite -S 0xab 0 1M" -c "fsync" $baz >>$seqres.full
+	# File bar is inode 257.
+	# File baz is inode 258.
+
+	# During the rename or link operation below the following happens:
+	#
+	# We update inode 258 and that causes its ->last_sub_trans to be set to
+	# 1 (the current log transaction ID), and its ->last_log_commit remains
+	# with a value of 0 (meaning it was committed in the previous log
+	# transaction).
+	#
+	# After updating inode 258, because we have previously fsynced it, we
+	# log again the inode because it has a new name/dentry now. This results
+	# in updating its ->last_log_commit from 0 to 1 (the current value of
+	# its ->last_sub_trans).
+	#
+	if [ "$op_type" == "rename" ]; then
+		mv $baz $foo
+	else
+		ln $baz $foo
+	fi
+	# File bar is inode 257.
+	# File foo is inode 258.
+
+	# Before the next write, sleep for 1 second so that we can test if mtime
+	# and ctime are preserved after the power failure.
+	sleep 1
+
+	# This buffered write leaves ->last_sub_trans of inode 258 as 1, the ID
+	# of the current log transaction (inode->root->log_transid).
+	$XFS_IO_PROG -c "pwrite -S 0xcd 0 1M" $foo >>$seqres.full
+
+	# The fsync against inode 257, file bar, results in committing the log
+	# transaction with ID 1, updating inode->root->last_log_commit to 1, and
+	# bumping root->log_transid from 1 to 2.
+	$XFS_IO_PROG -c "fsync" $bar
+
+	# Now on fsync of inode 258, file foo, delalloc is flushed and, because
+	# the inode does not have the full sync flag set anymore, it only waits
+	# for the writeback to finish, it does not wait for the ordered extent
+	# to complete.
+	#
+	# If the ordered extent does not complete before btrfs_sync_file() calls
+	# btrfs_inode_in_log(), then we would not update the inode the log and
+	# sync the log, resulting in a guaranteed data loss after a power failure
+	# for COW writes and with slim chances for data loss as well for NOCOW
+	# writes, because the fsync would return success to user space without
+	# issuing barriers (REQ_PREFLUSH not sent to the block layer).
+	# That happened because btrfs_inode_in_log() would return true before the
+	# ordered extent completes, as in that case the inode has ->last_sub_trans
+	# set to 1, ->last_log_commit as 1 and root->last_log_commit is 1 as well.
+	#
+	# Also, for both COW and NOCOW writes, when the race happens we ended up
+	# not logging the inode, resulting in an outdated mtime and ctime after
+	# replaying the log.
+	#
+	$XFS_IO_PROG -c "fsync" $foo
+
+	# Simulate a power failure and then mount again the filesystem to replay
+	# the log tree.
+	# After the power failure We expect $foo, inode 258, to have 1M of data
+	# full of bytes with a value of 0xcd, and not 0xab.
+
+	digest_before=$(_md5_checksum $foo)
+	mtime_before=$(stat -c %Y $foo)
+	ctime_before=$(stat -c %Z $foo)
+
+	_flakey_drop_and_remount
+
+	digest_after=$(_md5_checksum $foo)
+	mtime_after=$(stat -c %Y $foo)
+	ctime_after=$(stat -c %Z $foo)
+
+	if [ $digest_after != $digest_before ]; then
+		echo -n "Incorrect data after log replay, "
+		echo "expected digest: $digest_before got: $digest_after"
+	fi
+
+	if [ $mtime_after != $mtime_before ]; then
+		echo "mtime not preserved, expected: $mtime_before got: $mtime_after"
+	fi
+
+	if [ $ctime_after != $ctime_before ]; then
+		echo "ctime not preserved, expected: $ctime_before got: $ctime_after"
+	fi
+}
+
+# Test first with data cow (it's the default, but be explicit to make it clear).
+_scratch_mkfs >>$seqres.full 2>&1
+_require_metadata_journaling $SCRATCH_DEV
+_init_flakey
+MOUNT_OPTIONS="-o datacow"
+_mount_flakey
+
+# Test a few times each scenario because this test was motivated by a race
+# condition.
+echo "Testing fsync after rename with COW writes"
+for ((i = 1; i <= 3; i++)); do
+	test_fsync "rename_cow_$i" "rename"
+done
+echo "Testing fsync after link with COW writes"
+for ((i = 1; i <= 3; i++)); do
+	test_fsync "link_cow_$i" "link"
+done
+
+# Now lets test with nodatacow.
+_unmount_flakey
+MOUNT_OPTIONS="-o nodatacow"
+_mount_flakey
+
+echo "Testing fsync after rename with NOCOW writes"
+for ((i = 1; i <= 3; i++)); do
+	test_fsync "rename_nocow_$i" "rename"
+done
+echo "Testing fsync after link with NOCOW writes"
+for ((i = 1; i <= 3; i++)); do
+	test_fsync "link_nocow_$i" "link"
+done
+
+_unmount_flakey
+
+status=0
+exit
diff --git a/tests/btrfs/236.out b/tests/btrfs/236.out
new file mode 100644
index 00000000..5e1692fd
--- /dev/null
+++ b/tests/btrfs/236.out
@@ -0,0 +1,5 @@
+QA output created by 236
+Testing fsync after rename with COW writes
+Testing fsync after link with COW writes
+Testing fsync after rename with NOCOW writes
+Testing fsync after link with NOCOW writes
diff --git a/tests/btrfs/group b/tests/btrfs/group
index 331dd432..864730f8 100644
--- a/tests/btrfs/group
+++ b/tests/btrfs/group
@@ -238,3 +238,4 @@
 233 auto quick subvolume
 234 auto quick compress rw
 235 auto quick send
+236 auto quick log
-- 
2.28.0

