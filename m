Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 582271484B5
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 Jan 2020 12:52:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731050AbgAXLwS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 24 Jan 2020 06:52:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:36602 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729308AbgAXLwS (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 24 Jan 2020 06:52:18 -0500
Received: from debian5.Home (bl8-197-74.dsl.telepac.pt [85.241.197.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 60306206D5;
        Fri, 24 Jan 2020 11:52:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579866737;
        bh=cPo/JjoutaaNbAkAaHrGJt0XcwJfrpFb8mmMZSKO0Ls=;
        h=From:To:Cc:Subject:Date:From;
        b=S6ojULhS4p2jFZMsnpsfyxp0TI7UvSH0YPaBJceg6b0KT4X+rzmlwVROvxc8QEE/U
         aPpd2/YVjLNUqeyo6oTUVN+IbBpEP95lBJ9Ad+59+m+2Vl6FSq+8dv7TrotNswCCXB
         lXgoJOF+WT9NGNZNj17m/xByACbehFIPqHignNU0=
From:   fdmanana@kernel.org
To:     fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
Subject: [PATCH] btrfs: add test for incremental send for file with shared extents
Date:   Fri, 24 Jan 2020 11:52:13 +0000
Message-Id: <20200124115213.4133-1-fdmanana@kernel.org>
X-Mailer: git-send-email 2.11.0
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

Test that an incremental send operation works correctly when a file has
shared extents with itself in the send snapshot, with a hole between them,
and the file size has increased in the send snapshot.

This currently fails in 5.5-rc kernels (regression) but is fixed by a
patch that has the following subject:

  Btrfs: send, fix emission of invalid clone operations within the same file

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 tests/btrfs/203     | 100 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/203.out |  25 +++++++++++++
 tests/btrfs/group   |   1 +
 3 files changed, 126 insertions(+)
 create mode 100755 tests/btrfs/203
 create mode 100644 tests/btrfs/203.out

diff --git a/tests/btrfs/203 b/tests/btrfs/203
new file mode 100755
index 00000000..2ba5463c
--- /dev/null
+++ b/tests/btrfs/203
@@ -0,0 +1,100 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (C) 2020 SUSE Linux Products GmbH. All Rights Reserved.
+#
+# FS QA Test No. 203
+#
+# Test that an incremental send operation works correctly when a file has shared
+# extents with itself in the send snapshot, with a hole between them, and the
+# file size has increased in the send snapshot.
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
+# Create our test file with a size of 64K in the parent snapshot.
+# After the parent snapshot is created, we will increase its size and then clone
+# one of its extents into a different offset and leave a hole between the shared
+# extents. The shared extents will be located at offsets greater then size of the
+# file in the parent snapshot.
+$XFS_IO_PROG -f -c "pwrite -S 0xf1 0 64K" $SCRATCH_MNT/foobar | _filter_xfs_io
+
+$BTRFS_UTIL_PROG subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/base 2>&1 \
+	| _filter_scratch
+
+$BTRFS_UTIL_PROG send -f $send_files_dir/1.snap $SCRATCH_MNT/base 2>&1 \
+	| _filter_scratch
+
+# Create a 320K extent at file offset 512K, with chunks of 64K having different
+# content (to check cloning operations from send refer to the correct ranges).
+# After that clone a range that includes a hole and a part of the extent created
+# before - the clone range starts at an offset (448K) lower then the extent's
+# offset (512K). We want to see the existence of the hole doesn't confuse the
+# kernel's send code to send an invalid clone operation (with a source range
+# going beyond the file's current size). The hole that confused send to issue
+# an invalid clone operation spans the file range from offset 384K to 512K.
+#
+# Use offsets and ranges that are aligned to 64K, so that the test can run on
+# machines with any page size (and therefore block size).
+#
+$XFS_IO_PROG -c "pwrite -S 0xab 512K 64K" \
+	     -c "pwrite -S 0xcd 576K 64K" \
+	     -c "pwrite -S 0xef 640K 64K" \
+	     -c "pwrite -S 0x64 704K 64K" \
+	     -c "pwrite -S 0x73 768K 64K" \
+	     -c "reflink $SCRATCH_MNT/foobar 448K 192K 192K" \
+	     $SCRATCH_MNT/foobar | _filter_xfs_io
+
+$BTRFS_UTIL_PROG subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/incr 2>&1 \
+	| _filter_scratch
+
+$BTRFS_UTIL_PROG send -p $SCRATCH_MNT/base -f $send_files_dir/2.snap \
+		 $SCRATCH_MNT/incr 2>&1 | _filter_scratch
+
+echo "File foobar digest in the original filesystem:"
+_md5_checksum $SCRATCH_MNT/incr/foobar
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
+echo "File foobar digest in the new filesystem:"
+_md5_checksum $SCRATCH_MNT/incr/foobar
+
+status=0
+exit
diff --git a/tests/btrfs/203.out b/tests/btrfs/203.out
new file mode 100644
index 00000000..58739a98
--- /dev/null
+++ b/tests/btrfs/203.out
@@ -0,0 +1,25 @@
+QA output created by 203
+wrote 65536/65536 bytes at offset 0
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+Create a readonly snapshot of 'SCRATCH_MNT' in 'SCRATCH_MNT/base'
+At subvol SCRATCH_MNT/base
+wrote 65536/65536 bytes at offset 524288
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 65536/65536 bytes at offset 589824
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 65536/65536 bytes at offset 655360
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 65536/65536 bytes at offset 720896
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 65536/65536 bytes at offset 786432
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+linked 196608/196608 bytes at offset 196608
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+Create a readonly snapshot of 'SCRATCH_MNT' in 'SCRATCH_MNT/incr'
+At subvol SCRATCH_MNT/incr
+File foobar digest in the original filesystem:
+2b76b23b62fdbbbcae1ee37eec84fd7d
+At subvol base
+At snapshot incr
+File foobar digest in the new filesystem:
+2b76b23b62fdbbbcae1ee37eec84fd7d
diff --git a/tests/btrfs/group b/tests/btrfs/group
index d21bf438..8533c5e1 100644
--- a/tests/btrfs/group
+++ b/tests/btrfs/group
@@ -205,3 +205,4 @@
 200 auto quick send clone
 201 auto quick punch log
 202 auto quick subvol snapshot
+203 auto quick send clone
-- 
2.11.0

