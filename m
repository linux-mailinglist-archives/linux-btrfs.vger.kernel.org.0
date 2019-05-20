Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2C9C522F97
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 May 2019 10:59:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731744AbfETI7V (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 20 May 2019 04:59:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:59402 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730385AbfETI7V (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 20 May 2019 04:59:21 -0400
Received: from localhost.localdomain (bl8-197-74.dsl.telepac.pt [85.241.197.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 28C4E204FD;
        Mon, 20 May 2019 08:59:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558342759;
        bh=arZzoVWTbl4Kbb9tn47TSOaLowExEpGw8OnfUwFu31E=;
        h=From:To:Cc:Subject:Date:From;
        b=xO0USy+aY9nyuTtgpGwAzvNHK6Ixnvo4JTuGgQsN4I8uZgeAnIqP6mUq2feyFkJZV
         xOcayQ71tlhPEktFq/fArm6WoUjlfjNKZtEpmwFw7YfhNn0Mnix9LwKzI5yEYbtFGf
         M+JNLN1EVLwo98Y82zzSo4d8qt9WuQx8cRbTMIl0=
From:   fdmanana@kernel.org
To:     fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
Subject: [PATCH] fstests: btrfs, test for send after cloning and truncating source file
Date:   Mon, 20 May 2019 09:59:15 +0100
Message-Id: <20190520085915.29480-1-fdmanana@kernel.org>
X-Mailer: git-send-email 2.11.0
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

Test that an incremental send receive does not issue clone operations
that attempt to clone the last block of a file, with a size not aligned to
the filesystem's sector size, into the middle of some other file. Such
clone request causes the receiver to fail (with EINVAL), for kernels that
include commit ac765f83f1397646 ("Btrfs: fix data corruption due to
cloning of eof block"), or cause silent data corruption for older kernels.

This test is motived by a recent regression introduced in kernel 5.2-rc1,
commit 040ee6120cb6706 ("Btrfs: send, improve clone range"), and the
following patch fixes it:

  "Btrfs: incremental send, fix emission of invalid clone perations"

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 tests/btrfs/189     | 105 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/189.out |  21 +++++++++++
 tests/btrfs/group   |   1 +
 3 files changed, 127 insertions(+)
 create mode 100755 tests/btrfs/189
 create mode 100644 tests/btrfs/189.out

diff --git a/tests/btrfs/189 b/tests/btrfs/189
new file mode 100755
index 00000000..5f736d73
--- /dev/null
+++ b/tests/btrfs/189
@@ -0,0 +1,105 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (C) 2019 SUSE Linux Products GmbH. All Rights Reserved.
+#
+# FS QA Test No. 189
+#
+# Test that an incremental send receive does not issue clone operations that
+# attempt to clone the last block of a file, with a size not aligned to the
+# filesystem's sector size, into the middle of some other file. Such clone
+# request causes the receiver to fail (with EINVAL), for kernels that include
+# commit ac765f83f1397646 ("Btrfs: fix data corruption due to cloning of eof
+# block"), or cause silent data corruption for older kernels.
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
+	cd /
+	rm -f $tmp.*
+	rm -fr $send_files_dir
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
+_require_fssum
+_require_test
+_require_scratch_reflink
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
+$XFS_IO_PROG -f -c "pwrite -S 0xb1 0 2M" $SCRATCH_MNT/foo | _filter_xfs_io
+$XFS_IO_PROG -f -c "pwrite -S 0xc7 0 2M" $SCRATCH_MNT/bar | _filter_xfs_io
+$XFS_IO_PROG -f -c "pwrite -S 0x4d 0 2M" $SCRATCH_MNT/baz | _filter_xfs_io
+$XFS_IO_PROG -f -c "pwrite -S 0xe2 0 2M" $SCRATCH_MNT/zoo | _filter_xfs_io
+
+$BTRFS_UTIL_PROG subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/base 2>&1 \
+	| _filter_scratch
+
+$BTRFS_UTIL_PROG send -f $send_files_dir/1.snap $SCRATCH_MNT/base 2>&1 \
+	| _filter_scratch
+
+# Clone part of the extent from a higher offset to a lower offset of the same
+# file.
+$XFS_IO_PROG -c "reflink $SCRATCH_MNT/bar 1560K 500K 100K" $SCRATCH_MNT/bar \
+	| _filter_xfs_io
+
+# Now clone from the previous file, same range, into the middle of another file,
+# such that the end offset at the destination is smaller than the destination's
+# file size.
+$XFS_IO_PROG -c "reflink $SCRATCH_MNT/bar 1560K 0 100K" $SCRATCH_MNT/zoo \
+	| _filter_xfs_io
+
+# Truncate the source file of the previous clone operation to a smaller size,
+# which ends up in the middle of the range of previous clone operation from file
+# bar to file bar. We want to check this doesn't confuse send to issue invalid
+# clone operations.
+$XFS_IO_PROG -c "truncate 550K" $SCRATCH_MNT/bar
+
+$BTRFS_UTIL_PROG subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/incr 2>&1 \
+	| _filter_scratch
+
+$BTRFS_UTIL_PROG send -p $SCRATCH_MNT/base -f $send_files_dir/2.snap \
+	$SCRATCH_MNT/incr 2>&1 | _filter_scratch
+
+# Compute digests of the snapshot trees so that later we can compare against
+# digests of the trees in the new filesystem, to see if they match (no data or
+# metadata corruption happened).
+$FSSUM_PROG -A -f -w $send_files_dir/base.fssum $SCRATCH_MNT/base
+$FSSUM_PROG -A -f -w $send_files_dir/incr.fssum \
+	-x $SCRATCH_MNT/incr/base $SCRATCH_MNT/incr
+
+# Now recreate the filesystem by receiving both send streams and verify we get
+# the same file contents that the original filesystem had.
+_scratch_unmount
+_scratch_mkfs >>$seqres.full 2>&1
+_scratch_mount
+
+$BTRFS_UTIL_PROG receive -f $send_files_dir/1.snap $SCRATCH_MNT
+$BTRFS_UTIL_PROG receive -f $send_files_dir/2.snap $SCRATCH_MNT
+
+# Compute digests of the snapshot trees in the new filesystem and compare them
+# to the ones in the original filesystem, they must match.
+$FSSUM_PROG -r $send_files_dir/base.fssum $SCRATCH_MNT/base
+$FSSUM_PROG -r $send_files_dir/incr.fssum $SCRATCH_MNT/incr
+
+status=0
+exit
diff --git a/tests/btrfs/189.out b/tests/btrfs/189.out
new file mode 100644
index 00000000..0ae3cdce
--- /dev/null
+++ b/tests/btrfs/189.out
@@ -0,0 +1,21 @@
+QA output created by 189
+wrote 2097152/2097152 bytes at offset 0
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 2097152/2097152 bytes at offset 0
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 2097152/2097152 bytes at offset 0
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 2097152/2097152 bytes at offset 0
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+Create a readonly snapshot of 'SCRATCH_MNT' in 'SCRATCH_MNT/base'
+At subvol SCRATCH_MNT/base
+linked 102400/102400 bytes at offset 512000
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+linked 102400/102400 bytes at offset 0
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+Create a readonly snapshot of 'SCRATCH_MNT' in 'SCRATCH_MNT/incr'
+At subvol SCRATCH_MNT/incr
+At subvol base
+At snapshot incr
+OK
+OK
diff --git a/tests/btrfs/group b/tests/btrfs/group
index d88a0666..37c7ffc2 100644
--- a/tests/btrfs/group
+++ b/tests/btrfs/group
@@ -191,3 +191,4 @@
 186 auto quick send volume
 187 auto send dedupe clone balance
 188 auto quick send prealloc punch
+189 auto quick send clone
-- 
2.11.0

