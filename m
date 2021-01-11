Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B67BD2F11AB
	for <lists+linux-btrfs@lfdr.de>; Mon, 11 Jan 2021 12:42:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729751AbhAKLmm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 11 Jan 2021 06:42:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:35196 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729674AbhAKLmm (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 11 Jan 2021 06:42:42 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7BD1820735;
        Mon, 11 Jan 2021 11:42:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610365321;
        bh=8iWjMGAjtpoEUdqOeZSy456SqX09Ik6Edy26Nr/njsQ=;
        h=From:To:Cc:Subject:Date:From;
        b=ZCA9MBXfLNpRy9xDCBj9H1pcrBrhqqPP9nXns+uHkrZQtymekFs7Km1WYjGuwqWoT
         GAERn6yCI2wprg4sG/+AucVKonAG6LuSVelWWN4UMd7fNtPB48AhQDSJIZvAmfGIgG
         IG8fOnh6ULUUK39aq+0pTLHsRdA/+sNMfIRrLti/0stiJiNOZqSUhLWDzg+HCVohdQ
         MdnxlrqvFg4TBQsZFjofcne6xyDM1EgWFssT9qc5W7fojXYfnPknLC5fDjdDK/0g4G
         BoM1rEjHkWtfh9IDRTHu+QXciiyPV2FFiSEwClbhtgHuteCmzGOO6koV9DTSjSchN9
         n30W1hHFwk55Q==
From:   fdmanana@kernel.org
To:     fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
Subject: [PATCH] btrfs: test incremental send after cloning extents from the same file
Date:   Mon, 11 Jan 2021 11:41:54 +0000
Message-Id: <8337e3633d362dba6c2df168bd13ff3b75c68a92.1610363747.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

Test that an incremental send operation correctly issues clone operations
for a file that had different parts of one of its extents cloned into
itself, at different offsets, and a large part of that extent was
overwritten, so all the reflinks only point to subranges of the extent.

This currently fails on btrfs but is fixed by a patch for the kernel that
has the following subject:

 "btrfs: send, fix invalid clone operations when cloning from the same file and root"

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 tests/btrfs/228     | 109 ++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/228.out |  24 ++++++++++
 tests/btrfs/group   |   1 +
 3 files changed, 134 insertions(+)
 create mode 100755 tests/btrfs/228
 create mode 100644 tests/btrfs/228.out

diff --git a/tests/btrfs/228 b/tests/btrfs/228
new file mode 100755
index 00000000..0a3fb249
--- /dev/null
+++ b/tests/btrfs/228
@@ -0,0 +1,109 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (C) 2021 SUSE Linux Products GmbH. All Rights Reserved.
+#
+# FS QA Test No. btrfs/228
+#
+# Test that an incremental send operation correctly issues clone operations for
+# a file that had different parts of one of its extents cloned into itself, at
+# different offsets, and a large part of that extent was overwritten, so all the
+# reflinks only point to subranges of the extent.
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
+# Create our test file with a single and large extent (1M) and with different
+# content for different file ranges that will be reflinked later.
+$XFS_IO_PROG -f \
+	     -c "pwrite -S 0xab 0 128K" \
+	     -c "pwrite -S 0xcd 128K 128K" \
+	     -c "pwrite -S 0xef 256K 256K" \
+	     -c "pwrite -S 0x1a 512K 512K" \
+	     $SCRATCH_MNT/foobar | _filter_xfs_io
+
+# Now create the base snapshot, which is going to be the parent snapshot for
+# a later incremental send.
+$BTRFS_UTIL_PROG subvolume snapshot -r $SCRATCH_MNT \
+	$SCRATCH_MNT/mysnap1 > /dev/null
+
+$BTRFS_UTIL_PROG send -f $send_files_dir/1.snap \
+	$SCRATCH_MNT/mysnap1 2>&1 1>/dev/null | _filter_scratch
+
+# Now do a series of changes to our file such that we end up with different
+# parts of the extent reflinked into different file offsets and we overwrite
+# a large part of the extent too, so no file extent items refer to that part
+# that was overwritten. This used to confure the algorithm used by the kernel
+# to figure out which file ranges to clone, making it attempt to clone from
+# a source range starting at the current eof of the file, resulting in the
+# receiver to fail since it is an invalid clone operation.
+#
+$XFS_IO_PROG -c "reflink $SCRATCH_MNT/foobar 64K 1M 960K" \
+	     -c "reflink $SCRATCH_MNT/foobar 0K 512K 256K" \
+	     -c "reflink $SCRATCH_MNT/foobar 512K 128K 256K" \
+	     -c "pwrite -S 0x73 384K 640K" \
+	     $SCRATCH_MNT/foobar | _filter_xfs_io
+
+$BTRFS_UTIL_PROG subvolume snapshot -r $SCRATCH_MNT \
+		 $SCRATCH_MNT/mysnap2 > /dev/null
+$BTRFS_UTIL_PROG send -p $SCRATCH_MNT/mysnap1 -f $send_files_dir/2.snap \
+		 $SCRATCH_MNT/mysnap2 2>&1 1>/dev/null | _filter_scratch
+
+echo "File digest in the original filesystem:"
+_md5_checksum $SCRATCH_MNT/mysnap2/foobar
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
+#    ERROR: failed to clone extents to foobar: Invalid argument
+#
+# This is because the send stream included a clone operation to clone from the
+# current file eof into eof (we can't clone from eof and neither the source
+# range can overlap with the destination range), resulting in the receiver to
+# fail with -EINVAL when attempting the clone operation.
+#
+$BTRFS_UTIL_PROG receive -f $send_files_dir/2.snap $SCRATCH_MNT > /dev/null
+
+# Must match what we had in the original filesystem.
+echo "File digest in the new filesystem:"
+_md5_checksum $SCRATCH_MNT/mysnap2/foobar
+
+status=0
+exit
diff --git a/tests/btrfs/228.out b/tests/btrfs/228.out
new file mode 100644
index 00000000..b6e76fe3
--- /dev/null
+++ b/tests/btrfs/228.out
@@ -0,0 +1,24 @@
+QA output created by 228
+wrote 131072/131072 bytes at offset 0
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 131072/131072 bytes at offset 131072
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 262144/262144 bytes at offset 262144
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 524288/524288 bytes at offset 524288
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+At subvol SCRATCH_MNT/mysnap1
+linked 983040/983040 bytes at offset 1048576
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+linked 262144/262144 bytes at offset 524288
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+linked 262144/262144 bytes at offset 131072
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 655360/655360 bytes at offset 393216
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+At subvol SCRATCH_MNT/mysnap2
+File digest in the original filesystem:
+9c13c61cb0b9f5abf45344375cb04dfa
+At subvol mysnap1
+File digest in the new filesystem:
+9c13c61cb0b9f5abf45344375cb04dfa
diff --git a/tests/btrfs/group b/tests/btrfs/group
index a9e53832..61e14bf4 100644
--- a/tests/btrfs/group
+++ b/tests/btrfs/group
@@ -229,3 +229,4 @@
 225 auto quick volume seed
 226 auto quick rw snapshot clone prealloc punch
 227 auto quick send
+228 auto quick send clone
-- 
2.28.0

