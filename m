Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62C3431C96E
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Feb 2021 12:12:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230197AbhBPLLz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 16 Feb 2021 06:11:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:36098 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230049AbhBPLLD (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 16 Feb 2021 06:11:03 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id F1C2F64DEC;
        Tue, 16 Feb 2021 11:10:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613473821;
        bh=hOGq63Vcn2noy0pigCTc4z8TRW2DIDi2V9SW0uQR45o=;
        h=From:To:Cc:Subject:Date:From;
        b=ZEnzN/hExiiAdQPzc57e70jTkAPg8GSh1Pemm3gIoSQ1oDbsuTFVBIBGY099zqEba
         cgEWnsJFGMLiVikdpz3l08y0mEEyMoghmZ25xa8LvR+PuifkoJWzI2wKQblmVsUcuM
         1Q/Cgto6VEgs4VJhNRUcFRHN398YNHyl5lVYtRA7GTrLNhI1giWDDBxXjX0AbowXBR
         zDJQZDlKGqDABo9UG/Rw0ybvw95U4E+VjOBQ76gHhAj39KJFaYYVzHVzDXV5HwxPo7
         qhwYKJwZfd4yLDHBWoVbZkA8bRRX+yq2Q15+3yioebult6szoO90p4rIQU46XUAAQc
         RUBsJseK5Z2yQ==
From:   fdmanana@kernel.org
To:     fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
Subject: [PATCH] btrfs: add test for cloning a hole post eof when using NO_HOLES feature
Date:   Tue, 16 Feb 2021 11:10:15 +0000
Message-Id: <845bba7c2f3d46ef521858cebcc95231a4fba507.1613473625.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

Test that when using the NO_HOLES feature, if we truncate down a file,
clone a file range covering only a hole into an offset beyond the current
file size, and then fsync the file, after a power failure we get the
expected file content and we do not get stale data corresponding to file
extents that existed before truncating the file.

This currently fails on btrfs and is fixed by a patch for the kernel that
has the following subject:

  "btrfs: fix stale data exposure after cloning a hole with NO_HOLES enabled"

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 tests/btrfs/232     | 87 +++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/232.out | 35 ++++++++++++++++++
 tests/btrfs/group   |  1 +
 3 files changed, 123 insertions(+)
 create mode 100755 tests/btrfs/232
 create mode 100644 tests/btrfs/232.out

diff --git a/tests/btrfs/232 b/tests/btrfs/232
new file mode 100755
index 00000000..5b69dbf2
--- /dev/null
+++ b/tests/btrfs/232
@@ -0,0 +1,87 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (C) 2021 SUSE Linux Products GmbH. All Rights Reserved.
+#
+# FSQA Test No. 232
+#
+# Test that when using the NO_HOLES feature, if we truncate down a file, clone a
+# file range covering only a hole into an offset beyond the current file size,
+# and then fsync the file, after a power failure we get the expected file content
+# and we do not get stale data corresponding to file extents that existed before
+# truncating the file.
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
+_require_btrfs_fs_feature "no_holes"
+_require_btrfs_mkfs_feature "no-holes"
+_require_dm_target flakey
+
+rm -f $seqres.full
+
+_scratch_mkfs -O no-holes >>$seqres.full 2>&1
+_require_metadata_journaling $SCRATCH_DEV
+_init_flakey
+_mount_flakey
+
+# Create our test file with 3 extents of 256K and a 256K hole at offset 256K.
+# The file has a size of 1280K.
+$XFS_IO_PROG -f -s \
+	     -c "pwrite -S 0xab -b 256K 0 256K" \
+	     -c "pwrite -S 0xcd -b 256K 512K 256K" \
+	     -c "pwrite -S 0xef -b 256K 768K 256K" \
+	     -c "pwrite -S 0x73 -b 256K 1024K 256K" \
+	     $SCRATCH_MNT/foobar | _filter_xfs_io
+
+# Make sure it's durably persisted. We want the last committed super block to
+# point to this particular file extent layout.
+sync
+
+# Now truncate our file to a smaller size, falling within a position of the
+# second extent. This sets the full sync runtime flag on the inode.
+# Then fsync the file to log it and clear the full sync flag from the inode.
+# The third extent is no longer part of the file and therefore it is not logged.
+$XFS_IO_PROG -c "truncate 800K" -c "fsync" $SCRATCH_MNT/foobar
+
+# Now do a clone operation that only clones the hole and sets back the file size
+# to match the size it had before the truncate operation (1280K).
+$XFS_IO_PROG \
+	-c "reflink $SCRATCH_MNT/foobar 256K 1024K 256K" \
+	-c "fsync" \
+	$SCRATCH_MNT/foobar | _filter_xfs_io
+
+echo "File data before power failure:"
+od -A d -t x1 $SCRATCH_MNT/foobar
+
+# Simulate a power failure and then mount again the filesystem to replay the log
+# tree.
+_flakey_drop_and_remount
+
+# This should match what we got before the power failure. The range from 1024K
+# to 1280K should be a hole and not point to an extent full of bytes with a
+# value of 0x73.
+echo "File data after power failure:"
+od -A d -t x1 $SCRATCH_MNT/foobar
+
+_unmount_flakey
+status=0
+exit
diff --git a/tests/btrfs/232.out b/tests/btrfs/232.out
new file mode 100644
index 00000000..3c0f061f
--- /dev/null
+++ b/tests/btrfs/232.out
@@ -0,0 +1,35 @@
+QA output created by 232
+wrote 262144/262144 bytes at offset 0
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 262144/262144 bytes at offset 524288
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 262144/262144 bytes at offset 786432
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 262144/262144 bytes at offset 1048576
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+linked 262144/262144 bytes at offset 1048576
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+File data before power failure:
+0000000 ab ab ab ab ab ab ab ab ab ab ab ab ab ab ab ab
+*
+0262144 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+*
+0524288 cd cd cd cd cd cd cd cd cd cd cd cd cd cd cd cd
+*
+0786432 ef ef ef ef ef ef ef ef ef ef ef ef ef ef ef ef
+*
+0819200 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+*
+1310720
+File data after power failure:
+0000000 ab ab ab ab ab ab ab ab ab ab ab ab ab ab ab ab
+*
+0262144 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+*
+0524288 cd cd cd cd cd cd cd cd cd cd cd cd cd cd cd cd
+*
+0786432 ef ef ef ef ef ef ef ef ef ef ef ef ef ef ef ef
+*
+0819200 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+*
+1310720
diff --git a/tests/btrfs/group b/tests/btrfs/group
index 9f63db69..440270bb 100644
--- a/tests/btrfs/group
+++ b/tests/btrfs/group
@@ -234,3 +234,4 @@
 229 auto quick send clone
 230 auto quick qgroup limit
 231 auto quick compress rw
+232 auto quick clone log replay
-- 
2.28.0

