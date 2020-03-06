Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 766B317C4E9
	for <lists+linux-btrfs@lfdr.de>; Fri,  6 Mar 2020 18:51:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726733AbgCFRvG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 6 Mar 2020 12:51:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:44332 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726083AbgCFRvG (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 6 Mar 2020 12:51:06 -0500
Received: from debian6.Home (bl8-197-74.dsl.telepac.pt [85.241.197.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CF1C4206D7;
        Fri,  6 Mar 2020 17:51:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583517065;
        bh=/WmzF9haJT3ZbXBRBIlyda+oaAofNEqZgYMOyBTf7GY=;
        h=From:To:Cc:Subject:Date:From;
        b=jlPqwOCtRijcSTwsfUk4fHwnqZnMBF0KBS85S3FURvfFW4Ayh4jgd1QPOD77UB5R1
         mOOx4MT1vSdfyXxTMT+AJiMrNI6qpKqkbFuRvP9UF1sfeC3rhZGRJGc+5WtPu39u0z
         YbIsQqMGg6aLfNkmtwlhhEUZQh0zdLS8P8ZwLas8=
From:   fdmanana@kernel.org
To:     fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, josef@toxicpanda.com,
        Filipe Manana <fdmanana@suse.com>
Subject: [PATCH] btrfs: test power fail after a ranged fsync when not using the no-holes feature
Date:   Fri,  6 Mar 2020 17:51:02 +0000
Message-Id: <20200306175102.5539-1-fdmanana@kernel.org>
X-Mailer: git-send-email 2.11.0
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

Test a scenario were we fsync a range of a file and have a power failure.
We want to check that after a power failure and mounting the filesystem,
we do not end up with a missing file extent representing a hole. This
applies only when not using the NO_HOLES feature.

This currently fails on btrfs but it is fixed by a patch for the kernel
that has the following subject:

  "Btrfs: fix missing file extent item for hole after ranged fsync"

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 tests/btrfs/207     | 87 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/207.out |  7 +++++
 tests/btrfs/group   |  3 +-
 3 files changed, 96 insertions(+), 1 deletion(-)
 create mode 100755 tests/btrfs/207
 create mode 100644 tests/btrfs/207.out

diff --git a/tests/btrfs/207 b/tests/btrfs/207
new file mode 100755
index 00000000..4a7cbb87
--- /dev/null
+++ b/tests/btrfs/207
@@ -0,0 +1,87 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (C) 2020 SUSE Linux Products GmbH. All Rights Reserved.
+#
+# FSQA Test No. 207
+#
+# Test a scenario were we fsync a range of a file and have a power failure.
+# We want to check that after a power failure and mounting the filesystem, we
+# do not end up with a missing file extent representing a hole. This applies
+# only when not using the NO_HOLES feature.
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
+. ./common/attr
+. ./common/filter
+. ./common/dmflakey
+
+# real QA test starts here
+_supported_fs btrfs
+_supported_os Linux
+_require_scratch
+_require_dm_target flakey
+_require_btrfs_fs_feature "no_holes"
+_require_btrfs_mkfs_feature "no-holes"
+_require_xfs_io_command "sync_range"
+
+rm -f $seqres.full
+
+_scratch_mkfs -O ^no-holes >>$seqres.full 2>&1
+_require_metadata_journaling $SCRATCH_DEV
+_init_flakey
+_mount_flakey
+
+# Create a 256K file with a single extent and fsync it to clear the full sync
+# bit from the inode - we want the msync below to trigger a fast fsync.
+$XFS_IO_PROG -f \
+	     -c "pwrite -S 0xab 0 256K" \
+	     -c "fsync" \
+	     $SCRATCH_MNT/foo | _filter_xfs_io
+
+# Force a transaction commit and wipe out the log tree.
+sync
+
+# Dirty 768K of data, increasing the file size to 1Mb, and flush only the range
+# from 256K to 512K without updating the log tree (sync_file_range() does not
+# trigger fsync, it only starts writeback and waits for it to finish).
+$XFS_IO_PROG -c "pwrite -S 0xcd 256K 768K" \
+	     -c "sync_range -abw 256K 256K" \
+	     $SCRATCH_MNT/foo | _filter_xfs_io
+
+# Now dirty the range from 768K to 1M again and sync that range.
+$XFS_IO_PROG \
+    -c "mmap -w 768K 256K"        \
+    -c "mwrite -S 0xef 768K 256K" \
+    -c "msync -s 768K 256K"       \
+    -c "munmap"                   \
+    $SCRATCH_MNT/foo | _filter_xfs_io
+
+echo "File digest before power failure: $(_md5_checksum $SCRATCH_MNT/foo)"
+
+# Simulate a power failure and mount again the filesystem.
+_flakey_drop_and_remount
+
+# Should match what we got before the power failure.
+echo "File digest after power failure: $(_md5_checksum $SCRATCH_MNT/foo)"
+
+# We also want to check that fsck doesn't fail due to an error of a missing
+# file extent item that represents a hole for the range 256K to 512K. The
+# fstests framework does the fsck once the test exits.
+_unmount_flakey
+
+status=0
+exit
diff --git a/tests/btrfs/207.out b/tests/btrfs/207.out
new file mode 100644
index 00000000..d49a6f24
--- /dev/null
+++ b/tests/btrfs/207.out
@@ -0,0 +1,7 @@
+QA output created by 207
+wrote 262144/262144 bytes at offset 0
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 786432/786432 bytes at offset 262144
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+File digest before power failure: c0bf141ef2500fcc894f754ead04f02d
+File digest after power failure: c0bf141ef2500fcc894f754ead04f02d
diff --git a/tests/btrfs/group b/tests/btrfs/group
index fd1943e3..0b1a06d9 100644
--- a/tests/btrfs/group
+++ b/tests/btrfs/group
@@ -208,4 +208,5 @@
 203 auto quick send clone
 204 auto quick punch
 205 auto quick clone compress
-204 auto quick log replay
+206 auto quick log replay
+207 auto quick log
-- 
2.11.0

