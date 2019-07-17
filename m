Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4DB426BC3B
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Jul 2019 14:24:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726424AbfGQMYo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 17 Jul 2019 08:24:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:34206 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725799AbfGQMYo (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 17 Jul 2019 08:24:44 -0400
Received: from localhost.localdomain (bl8-197-74.dsl.telepac.pt [85.241.197.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EDD6E20880;
        Wed, 17 Jul 2019 12:24:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563366282;
        bh=O9hKncjz4e+nFZFzxk8DDNQeA/vhquQ5H6XGndUs5CQ=;
        h=From:To:Cc:Subject:Date:From;
        b=BNeL9jXhd2pKjx9dozVYo7HnmYTZQFD+1XPl0SFdQg7VbwMvrobeWSdBYiXl1U2ZF
         nCOGTF8VhLlZxIEVxXjO3XebYyxVkeeHxDCYagCM3pSFjcMNUvMbUo5N3dpoLJ/orQ
         OAFQWlnHD03YgUXBqomlsZw8PgA/+wskX5AfvYwE=
From:   fdmanana@kernel.org
To:     fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
Subject: [PATCH] btrfs: test incremental send after deduplication on both snapshots
Date:   Wed, 17 Jul 2019 13:24:39 +0100
Message-Id: <20190717122439.28327-1-fdmanana@kernel.org>
X-Mailer: git-send-email 2.11.0
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

Test that an incremental send operation works after deduplicating into the
same file in both the parent and send snapshots.

This currently fails on btrfs and a kernel patch to fix it was submitted
with the subject:

  Btrfs: fix incremental send failure after deduplication

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 tests/btrfs/191     | 110 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/191.out |  19 +++++++++
 tests/btrfs/group   |   1 +
 3 files changed, 130 insertions(+)
 create mode 100755 tests/btrfs/191
 create mode 100644 tests/btrfs/191.out

diff --git a/tests/btrfs/191 b/tests/btrfs/191
new file mode 100755
index 00000000..3156dfcc
--- /dev/null
+++ b/tests/btrfs/191
@@ -0,0 +1,110 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (C) 2019 SUSE Linux Products GmbH. All Rights Reserved.
+#
+# FS QA Test No. btrfs/191
+#
+# Test that an incremental send operation works after deduplicating into the
+# same file in both the parent and send snapshots.
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
+. ./common/reflink
+
+# real QA test starts here
+_supported_fs btrfs
+_supported_os Linux
+_require_test
+_require_scratch_dedupe
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
+# Create our first file. The first half of the file has several 64Kb extents
+# while the second half as a single 512Kb extent.
+$XFS_IO_PROG -f -s -c "pwrite -S 0xb8 -b 64K 0 512K" $SCRATCH_MNT/foo \
+	| _filter_xfs_io
+$XFS_IO_PROG -c "pwrite -S 0xb8 512K 512K" $SCRATCH_MNT/foo | _filter_xfs_io
+
+# Create the base snapshot and the parent send stream from it.
+$BTRFS_UTIL_PROG subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/mysnap1 \
+	| _filter_scratch
+
+$BTRFS_UTIL_PROG send -f $send_files_dir/1.snap $SCRATCH_MNT/mysnap1 2>&1 \
+	| _filter_scratch
+
+# Create our second file, that has exactly the same data as the first file.
+$XFS_IO_PROG -f -c "pwrite -S 0xb8 0 1M" $SCRATCH_MNT/bar | _filter_xfs_io
+
+# Create the second snapshot, used for the incremental send, before doing the
+# file deduplication.
+$BTRFS_UTIL_PROG subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/mysnap2 \
+	| _filter_scratch
+
+# Now before creating the incremental send stream:
+#
+# 1) Deduplicate into a subrange of file foo in snapshot mysnap1. This will drop
+#    several extent items and add a new one, also updating the inode's iversion
+#    (sequence field in inode item) by 1, but not any other field of the inode;
+#
+# 2) Deduplicate into a different subrange of file foo in snapshot mysnap2. This
+#    will replace an extent item with a new one, also updating the inode's
+#    iversion by 1 but not any other field of the inode.
+#
+# After these two deduplication operations, the inode items, for file foo, are
+# identical in both snapshots, but we have different extent items for this inode
+# in both snapshots. We want to check this doesn't cause send to fail with an
+# error or produce an incorrect stream.
+
+$XFS_IO_PROG -r -c "dedupe $SCRATCH_MNT/bar 0 0 512K" $SCRATCH_MNT/mysnap1/foo \
+	| _filter_xfs_io
+
+$XFS_IO_PROG -r -c "dedupe $SCRATCH_MNT/bar 512K 512K 512K" \
+	$SCRATCH_MNT/mysnap2/foo | _filter_xfs_io
+
+# Create the incremental send stream.
+$BTRFS_UTIL_PROG send -p $SCRATCH_MNT/mysnap1 -f $send_files_dir/2.snap \
+	$SCRATCH_MNT/mysnap2 2>&1 | _filter_scratch
+
+# Create the checksums to verify later that the send streams produce correct
+# results.
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
+$BTRFS_UTIL_PROG receive -f $send_files_dir/1.snap $SCRATCH_MNT
+$BTRFS_UTIL_PROG receive -f $send_files_dir/2.snap $SCRATCH_MNT
+$FSSUM_PROG -r $send_files_dir/1.fssum $SCRATCH_MNT/mysnap1
+$FSSUM_PROG -r $send_files_dir/2.fssum $SCRATCH_MNT/mysnap2
+
+status=0
+exit
diff --git a/tests/btrfs/191.out b/tests/btrfs/191.out
new file mode 100644
index 00000000..4269803c
--- /dev/null
+++ b/tests/btrfs/191.out
@@ -0,0 +1,19 @@
+QA output created by 191
+wrote 524288/524288 bytes at offset 0
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 524288/524288 bytes at offset 524288
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+Create a readonly snapshot of 'SCRATCH_MNT' in 'SCRATCH_MNT/mysnap1'
+At subvol SCRATCH_MNT/mysnap1
+wrote 1048576/1048576 bytes at offset 0
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+Create a readonly snapshot of 'SCRATCH_MNT' in 'SCRATCH_MNT/mysnap2'
+deduped 524288/524288 bytes at offset 0
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+deduped 524288/524288 bytes at offset 524288
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+At subvol SCRATCH_MNT/mysnap2
+At subvol mysnap1
+At snapshot mysnap2
+OK
+OK
diff --git a/tests/btrfs/group b/tests/btrfs/group
index 6937bf1c..2474d43e 100644
--- a/tests/btrfs/group
+++ b/tests/btrfs/group
@@ -193,3 +193,4 @@
 188 auto quick send prealloc punch
 189 auto quick send clone
 190 auto quick replay balance qgroup
+191 auto quick send dedupe
-- 
2.11.0

