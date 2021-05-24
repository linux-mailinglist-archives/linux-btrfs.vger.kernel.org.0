Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7EF238E430
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 May 2021 12:37:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232582AbhEXKjG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 24 May 2021 06:39:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:50164 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232653AbhEXKi4 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 24 May 2021 06:38:56 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3C636606A5;
        Mon, 24 May 2021 10:37:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621852648;
        bh=ZDUflN/w0O2X3GCUnXx303dn+nfQtLVu2pQXJm8MF/4=;
        h=From:To:Cc:Subject:Date:From;
        b=Dnx0UehvtPPFICyN6LcB+HsLB/JSIpFAdO2BmxMODXoqUDshjWOwn+fuwhvmR2kgp
         k9efXahrq5++Z2BvOiLlzM7h9TknNSBj1UkKunIuB6PVlhjA7tCSZ6X6RoTVLyu3ZX
         ymCpYeQBCha2wzP3tI4tU3ju6AAVccOliJQnCLlhARWKKx14833Qh1reBMEzf7qW4z
         ynGloQbV7Tum23uTP90u7yIImyiISyNYxUs8a7GLqdla9H/5G86kzYx0dSEvZcnnNh
         Z5ut4ju5xa5YjmjZ9U+UM6AYXDtJwHrJOC85Q6oS8YJemlYi1v3KfHbsnShfIFgqyl
         /k0qgPJm5jztg==
From:   fdmanana@kernel.org
To:     fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
Subject: [PATCH] btrfs: add test for multiple fsync with adjacent preallocated extents
Date:   Mon, 24 May 2021 11:37:21 +0100
Message-Id: <4c3dd698cb68ea0c465ea5028d677b3443b8cf3c.1621852397.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

Test a scenario where we do several partial writes into multiple
preallocated extents across two transactions and with several fsyncs
in between. The goal is to check that the fsyncs succeed.

Currently the last fsync fails with an -EIO error, and it aborts the
current transaction. This issue is fixed by a patch with the following
subject:

  "btrfs: fix fsync failure and transaction abort after writes to prealloc extents"

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 tests/btrfs/240     | 173 ++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/240.out |  29 ++++++++
 tests/btrfs/group   |   1 +
 3 files changed, 203 insertions(+)
 create mode 100755 tests/btrfs/240
 create mode 100644 tests/btrfs/240.out

diff --git a/tests/btrfs/240 b/tests/btrfs/240
new file mode 100755
index 00000000..c799848f
--- /dev/null
+++ b/tests/btrfs/240
@@ -0,0 +1,173 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (C) 2021 SUSE Linux Products GmbH. All Rights Reserved.
+#
+# FSQA Test No. 240
+#
+# Test a scenario where we do several partial writes into multiple preallocated
+# extents across two transactions and with several fsyncs in between. The goal
+# is to check that the fsyncs succeed. This scenario used to trigger an -EIO
+# failure on the last fsync and turn the filesystem to RO mode because of a
+# transaction abort.
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
+_require_xfs_io_command "falloc"
+
+rm -f $seqres.full
+
+_scratch_mkfs >>$seqres.full 2>&1
+_require_metadata_journaling $SCRATCH_DEV
+_init_flakey
+_mount_flakey
+
+
+# Create our test file with 2 preallocated extents. Leave a 1M hole between them
+# to ensure that we get two file extent items that will never be merged into a
+# single one. The extents are contiguous on disk, which will later result in the
+# checksums for their data to be merged into a single checksum item in the csums
+# btree.
+#
+$XFS_IO_PROG -f \
+	     -c "falloc 0 1M" \
+	     -c "falloc 3M 3M" \
+	     $SCRATCH_MNT/foobar
+
+# Now write to the second extent and leave only 1M of it as unwritten, which
+# corresponds to the file range [4M, 5M[.
+#
+# Then fsync the file to flush delalloc and to clear full sync flag from the
+# inode, so that a future fsync will use the fast code path.
+#
+# After the writeback triggered by the fsync we have 3 file extent items that
+# point to the second extent we previously allocated with fallocate():
+#
+# 1) One file extent item of type BTRFS_FILE_EXTENT_REG that covers the file
+#    range [3M, 4M[
+#
+# 2) One file extent item of type BTRFS_FILE_EXTENT_PREALLOC that covers the
+#    file range [4M, 5M[
+#
+# 3) One file extent item of type BTRFS_FILE_EXTENT_REG that covers the file
+#    range [5M, 6M[
+#
+# All these file extent items have a generation of 6, which is the ID of the
+# transaction where they were created. The split of the original file extent
+# item is done at btrfs_mark_extent_written() when ordered extents complete for
+# the file ranges [3M, 4M[ and [5M, 6M[.
+#
+$XFS_IO_PROG -c "pwrite -S 0xab 3M 1M" \
+	     -c "pwrite -S 0xef 5M 1M" \
+	     -c "fsync" \
+	     $SCRATCH_MNT/foobar | _filter_xfs_io
+
+# Commit the current transaction. This wipes out the log tree created by the
+# previous fsync.
+sync
+
+# Now write to the unwritten range of the second extent we allocated,
+# corresponding to the file range [4M, 5M[, and fsync the file, which triggers
+# the fast fsync code path.
+#
+# The fast fsync code path sees that there is a new extent map covering the file
+# range [4M, 5M[ and therefore it will log a checksum item covering the range
+# [1M, 2M[ of the second extent we allocated.
+#
+# Also, after the fsync finishes we no longer have the 3 file extent items that
+# pointed to 3 sections of the second extent we allocated. Instead we end up
+# with a single file extent item pointing to the whole extent, with a type of
+# BTRFS_FILE_EXTENT_REG and a generation of 7 (the current transaction ID). This
+# is due to the file extent item merging we do when completing ordered extents
+# into ranges that point to unwritten (preallocated) extents. This merging is
+# done at btrfs_mark_extent_written().
+#
+$XFS_IO_PROG -c "pwrite -S 0xcd 4M 1M" \
+	     -c "fsync" \
+	     $SCRATCH_MNT/foobar | _filter_xfs_io
+
+# Now do some write to our file outside the range of the second extent that we
+# allocated with fallocate() and truncate the file size from 6M down to 5M.
+#
+# The truncate operation sets the full sync runtime flag on the inode, forcing
+# the next fsync to use the slow code path. It also changes the length of the
+# second file extent item so that it represents the file range [3M, 5M[ and not
+# the range [3M, 6M[ anymore.
+#
+# Finally fsync the file. Since this is a fsync that triggers the slow code path,
+# it will remove all items associated to the inode from the log tree and then it
+# will scan for file extent items in the fs/subvolume tree that have a generation
+# matching the current transaction ID, which is 7. This means it will log 2 file
+# extent items:
+#
+# 1) One for the first extent we allocated, covering the file range [0, 1M[
+#
+# 2) Another for the first 2M of the second extent we allocated, covering the
+#    file range [3M, 5M[
+#
+# When logging the first file extent item we log a single checksum item that has
+# all the checksums for the entire extent.
+#
+# When logging the second file extent item, we also lookup for the checksums that
+# are associated with the range [0, 2M[ of the second extent we allocated (file
+# range [3M, 5M[), and then we log them with btrfs_csum_file_blocks(). However
+# that results in ending up with a log that has two checksum items with ranges
+# that overlap:
+#
+# 1) One for the range [1M, 2M[ of the second extent we allocated, corresponding
+#    to the file range [4M, 5M[, which we logged in the previous fsync that used
+#    the fast code path;
+#
+# 2) One for the ranges [0, 1M[ and [0, 2M[ of the first and second extents,
+#    respectively, corresponding to the files ranges [0, 1M[ and [3M, 5M[.
+#    This one was added during this last fsync that uses the slow code path
+#    and overlaps with the previous one logged by the previous fast fsync.
+#
+# This happens because when logging the checksums for the second extent, we
+# notice they start at an offset that matches the end of the checksums item that
+# we logged for the first extent, and because both extents are contiguous on
+# disk, btrfs_csum_file_blocks() decides to extend that existing checksums item
+# and append the checksums for the second extent to this item. The end result is
+# we end up with two checksum items in the log tree that have overlapping ranges,
+# as listed before, resulting in the fsync to fail with -EIO and aborting the
+# transaction, turning the filesystem into RO mode.
+#
+$XFS_IO_PROG -c "pwrite -S 0xff 0 1M" \
+	     -c "truncate 5M" \
+	     -c "fsync" \
+	     $SCRATCH_MNT/foobar | _filter_xfs_io
+
+echo "File content before power failure:"
+od -A d -t x1 $SCRATCH_MNT/foobar
+
+# Simulate a power failure and mount again the filesystem. The file content
+# must be the same that we had before.
+_flakey_drop_and_remount
+
+echo "File content before after failure:"
+od -A d -t x1 $SCRATCH_MNT/foobar
+
+_unmount_flakey
+
+status=0
+exit
diff --git a/tests/btrfs/240.out b/tests/btrfs/240.out
new file mode 100644
index 00000000..ffd03ee6
--- /dev/null
+++ b/tests/btrfs/240.out
@@ -0,0 +1,29 @@
+QA output created by 240
+wrote 1048576/1048576 bytes at offset 3145728
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 1048576/1048576 bytes at offset 5242880
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 1048576/1048576 bytes at offset 4194304
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 1048576/1048576 bytes at offset 0
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+File content before power failure:
+0000000 ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
+*
+1048576 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+*
+3145728 ab ab ab ab ab ab ab ab ab ab ab ab ab ab ab ab
+*
+4194304 cd cd cd cd cd cd cd cd cd cd cd cd cd cd cd cd
+*
+5242880
+File content before after failure:
+0000000 ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
+*
+1048576 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+*
+3145728 ab ab ab ab ab ab ab ab ab ab ab ab ab ab ab ab
+*
+4194304 cd cd cd cd cd cd cd cd cd cd cd cd cd cd cd cd
+*
+5242880
diff --git a/tests/btrfs/group b/tests/btrfs/group
index d7f2f3e5..ad59ed3e 100644
--- a/tests/btrfs/group
+++ b/tests/btrfs/group
@@ -242,3 +242,4 @@
 237 auto quick zone balance
 238 auto quick seed trim
 239 auto quick log
+240 auto quick prealloc log
-- 
2.28.0

