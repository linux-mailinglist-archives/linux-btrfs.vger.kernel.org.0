Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C353522F77
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 May 2019 10:56:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731412AbfETIzx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 20 May 2019 04:55:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:57362 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730823AbfETIzx (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 20 May 2019 04:55:53 -0400
Received: from localhost.localdomain (bl8-197-74.dsl.telepac.pt [85.241.197.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 93FFD204FD;
        Mon, 20 May 2019 08:55:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558342552;
        bh=FKC4/wzjd7TpFPHnMtxvd09HMyMrAAoVZiX3FLZQ908=;
        h=From:To:Cc:Subject:Date:From;
        b=kVMmOKBba+2MASq5jw+7Rd5wA/ML/0BJlnCXIG7L8Wxr3Dl+OWK6DKIPWQUGQH24v
         +sdKLgP4EyLsM+tm4SU+sVSVwN39TpBtv0lxh6sp8DcB2J1I6BkkQ/tiEGtEvtiShI
         v9q3ZKW6GKwtTssrX/MxYwiATshARTMyjpXwJDoM=
From:   fdmanana@kernel.org
To:     fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
Subject: [PATCH] fstests: btrfs, test send with no-holes enabled, fallocate and hole punching
Date:   Mon, 20 May 2019 09:55:47 +0100
Message-Id: <20190520085547.29329-1-fdmanana@kernel.org>
X-Mailer: git-send-email 2.11.0
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

Test that an incremental send with not corrupt data when the source
filesystem has the no-holes feature enabled, a file has prealloc
(unwritten) extents that start after its size and hole is punched (after
the first snapshot is made) that removes all extents from some offset up
to the file's size.

This currently fails on any kernel version starting from 3.16, and it's
by a patch titled:

 "Btrfs: incremental send, fix file corruption when no-holes feature is enabled"

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 tests/btrfs/188     | 84 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/188.out | 13 +++++++++
 tests/btrfs/group   |  1 +
 3 files changed, 98 insertions(+)
 create mode 100755 tests/btrfs/188
 create mode 100644 tests/btrfs/188.out

diff --git a/tests/btrfs/188 b/tests/btrfs/188
new file mode 100755
index 00000000..36483035
--- /dev/null
+++ b/tests/btrfs/188
@@ -0,0 +1,84 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (C) 2019 SUSE Linux Products GmbH. All Rights Reserved.
+#
+# FS QA Test No. 188
+#
+# Test that an incremental send with not corrupt data when the source filesystem
+# has the no-holes feature enabled, a file has prealloc (unwritten) extents that
+# start after its size and hole is punched (after the first snapshot is made)
+# that removes all extents from some offset up to the file's size.
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
+
+# real QA test starts here
+_supported_fs btrfs
+_supported_os Linux
+_require_test
+_require_scratch
+_require_btrfs_fs_feature "no_holes"
+_require_btrfs_mkfs_feature "no-holes"
+_require_xfs_io_command "fpunch"
+_require_xfs_io_command "falloc" "-k"
+
+send_files_dir=$TEST_DIR/btrfs-test-$seq
+
+rm -f $seqres.full
+rm -fr $send_files_dir
+mkdir $send_files_dir
+
+_scratch_mkfs "-O no-holes" >>$seqres.full 2>&1
+_scratch_mount
+
+# Create our test file with a prealloc extent that starts beyond its size.
+$XFS_IO_PROG -f -c "pwrite -S 0xab 0 500K" $SCRATCH_MNT/foobar | _filter_xfs_io
+$XFS_IO_PROG -c "falloc -k 1200K 800K" $SCRATCH_MNT/foobar
+
+$BTRFS_UTIL_PROG subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/base 2>&1 \
+	| _filter_scratch
+
+$BTRFS_UTIL_PROG send -f $send_files_dir/1.snap $SCRATCH_MNT/base 2>&1 \
+	| _filter_scratch
+
+# Now punch a hole that drops all the extents within the file's size.
+$XFS_IO_PROG -c "fpunch 0 500K" $SCRATCH_MNT/foobar
+
+$BTRFS_UTIL_PROG subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/incr 2>&1 \
+	| _filter_scratch
+
+$BTRFS_UTIL_PROG send -p $SCRATCH_MNT/base -f $send_files_dir/2.snap \
+	$SCRATCH_MNT/incr 2>&1 | _filter_scratch
+
+echo "File digest in the original filesystem:"
+md5sum $SCRATCH_MNT/incr/foobar | _filter_scratch
+
+# Now recreate the filesystem by receiving both send streams and verify we get
+# the same file content that the original filesystem had.
+_scratch_unmount
+_scratch_mkfs >>$seqres.full 2>&1
+_scratch_mount
+
+$BTRFS_UTIL_PROG receive -f $send_files_dir/1.snap $SCRATCH_MNT
+$BTRFS_UTIL_PROG receive -f $send_files_dir/2.snap $SCRATCH_MNT
+
+echo "File digest in the new filesystem:"
+md5sum $SCRATCH_MNT/incr/foobar | _filter_scratch
+
+status=0
+exit
diff --git a/tests/btrfs/188.out b/tests/btrfs/188.out
new file mode 100644
index 00000000..260988e6
--- /dev/null
+++ b/tests/btrfs/188.out
@@ -0,0 +1,13 @@
+QA output created by 188
+wrote 512000/512000 bytes at offset 0
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+Create a readonly snapshot of 'SCRATCH_MNT' in 'SCRATCH_MNT/base'
+At subvol SCRATCH_MNT/base
+Create a readonly snapshot of 'SCRATCH_MNT' in 'SCRATCH_MNT/incr'
+At subvol SCRATCH_MNT/incr
+File digest in the original filesystem:
+816df6f64deba63b029ca19d880ee10a  SCRATCH_MNT/incr/foobar
+At subvol base
+At snapshot incr
+File digest in the new filesystem:
+816df6f64deba63b029ca19d880ee10a  SCRATCH_MNT/incr/foobar
diff --git a/tests/btrfs/group b/tests/btrfs/group
index 44ee0dd9..d88a0666 100644
--- a/tests/btrfs/group
+++ b/tests/btrfs/group
@@ -190,3 +190,4 @@
 185 volume
 186 auto quick send volume
 187 auto send dedupe clone balance
+188 auto quick send prealloc punch
-- 
2.11.0

