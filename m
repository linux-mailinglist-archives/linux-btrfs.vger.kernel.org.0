Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 472001B23B3
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Apr 2020 12:25:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728123AbgDUKZp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 21 Apr 2020 06:25:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:58732 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725920AbgDUKZn (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 21 Apr 2020 06:25:43 -0400
Received: from debian6.Home (bl8-197-74.dsl.telepac.pt [85.241.197.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 61CD22064A;
        Tue, 21 Apr 2020 10:25:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587464743;
        bh=leaT0DWHIo5C9Lt2cWErcLvPCyotAJ+Gj1HBcI56XPc=;
        h=From:To:Cc:Subject:Date:From;
        b=MiSJiVkvlTiGLUE4xt0bd7g8mmSru87PeJn2lgiTg8hQL3+AX3GHMcd6XrKw5Sw9b
         dtj0uzHyUxV8n6+6ZYwivp2eycerIng3fU2qYN36rjN7TuFk7bw7Ys5Ad4o52JECJN
         XtK112aFeMpJ6oI4bCG/tvYS0fu9ghvfoZ5UVmAQ=
From:   fdmanana@kernel.org
To:     fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
Subject: [PATCH] btrfs: add a test for fsync of file with prealloc extents crossing eof
Date:   Tue, 21 Apr 2020 11:25:39 +0100
Message-Id: <20200421102539.14786-1-fdmanana@kernel.org>
X-Mailer: git-send-email 2.11.0
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

Test that if we fsync a file with prealloc extents that start before and
after the file's size, we don't end up with missing parts of the extents
and implicit file holes after a power failure. Test both without and with
the NO_HOLES feature.

This currently fails and it is fixed by a patch that has the following
subject:

  "Btrfs: fix partial loss of prealloc extent past i_size after fsync"

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 tests/btrfs/211     | 112 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/211.out |  10 +++++
 tests/btrfs/group   |   1 +
 3 files changed, 123 insertions(+)
 create mode 100755 tests/btrfs/211
 create mode 100644 tests/btrfs/211.out

diff --git a/tests/btrfs/211 b/tests/btrfs/211
new file mode 100755
index 00000000..3495b309
--- /dev/null
+++ b/tests/btrfs/211
@@ -0,0 +1,112 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (C) 2020 SUSE Linux Products GmbH. All Rights Reserved.
+#
+# FSQA Test No. 211
+#
+# Test that if we fsync a file with prealloc extents that start before and
+# after the file's size, we don't end up with missing parts of the extents
+# and implicit file holes after a power failure. Test both without and with
+# the NO_HOLES feature.
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
+_supported_os Linux
+_require_scratch
+_require_xfs_io_command "falloc" "-k"
+# fiemap needed by _count_extents()
+_require_xfs_io_command "fiemap"
+_require_btrfs_fs_feature "no_holes"
+_require_btrfs_mkfs_feature "no-holes"
+_require_dm_target flakey
+
+rm -f $seqres.full
+
+run_test()
+{
+    # Create our test file with 2 consecutive prealloc extents, each with a size
+    # of 128Kb, and covering the range from 0 to 256Kb, with a file size of 0.
+    # Then fsync the file to record both extents in a log tree.
+    $XFS_IO_PROG -f -c "falloc -k 0 128K" $SCRATCH_MNT/foo
+    $XFS_IO_PROG -c "falloc -k 128K 128K" $SCRATCH_MNT/foo
+    $XFS_IO_PROG -c "fsync" $SCRATCH_MNT/foo
+
+    # Now do a redudant extent allocation for the range from 0 to 64Kb. This will
+    # merely increase the file size from 0 to 64Kb. Instead we could also do a
+    # truncate to set the file size to 64Kb.
+    $XFS_IO_PROG -c "falloc 0 64K" $SCRATCH_MNT/foo
+
+    # Fsync the file, so we update the log with the new file size. Here btrfs
+    # used to incorrectly set the number of bytes to 64Kb for the prealloc extent
+    # that covers the file range from 0 to 128Kb.
+    $XFS_IO_PROG -c "fsync" $SCRATCH_MNT/foo
+
+    # Now set the file size to 256K with a truncate and then fsync the file. We
+    # want to verify the log tree doesn't end up with an implicit hole for the
+    # file range from 64Kb to 128Kb. That would lead to an implicit hole after
+    # replaying the log and losing part of the prealloc extent, so a future write
+    # to anywhere in the file range from 64Kb to 128Kb would result in allocating
+    # a new extent and not use the extent previously allocated with fallocate().
+    $XFS_IO_PROG -c "truncate 256K" -c "fsync" $SCRATCH_MNT/foo
+
+    # Simulate a power failure and then mount again the filesystem to replay the
+    # log tree.
+    _flakey_drop_and_remount
+
+    # Unmount the filesystem and run 'btrfs check'/fsck to verify that we don't
+    # have a missing hole for the file range from 64K to 128K.
+    _unmount_flakey
+    _check_scratch_fs $FLAKEY_DEV
+
+    _mount_flakey
+
+    # Now write to the file range from 0 to 128K. After this we should still have
+    # rwo extents in our file, corresponding to the 2 extents we allocated before
+    # using fallocate(). In particular writing to the file range from 64Kb to
+    # 128Kb should not have allocated a new extent.
+    $XFS_IO_PROG -c "pwrite -S 0xab 0 128K" $SCRATCH_MNT/foo | _filter_xfs_io
+    echo "File extent count after write: $(_count_extents $SCRATCH_MNT/foo)"
+}
+
+_scratch_mkfs -O ^no-holes >>$seqres.full 2>&1
+_require_metadata_journaling $SCRATCH_DEV
+_init_flakey
+_mount_flakey
+
+echo "Testing without NO_HOLES feature"
+run_test
+
+_unmount_flakey
+_cleanup_flakey
+
+_scratch_mkfs -O no-holes >>$seqres.full 2>&1
+_require_metadata_journaling $SCRATCH_DEV
+_init_flakey
+_mount_flakey
+
+echo
+echo "Testing with the NO_HOLES feature"
+run_test
+
+_unmount_flakey
+status=0
+exit
diff --git a/tests/btrfs/211.out b/tests/btrfs/211.out
new file mode 100644
index 00000000..838b1a76
--- /dev/null
+++ b/tests/btrfs/211.out
@@ -0,0 +1,10 @@
+QA output created by 211
+Testing without NO_HOLES feature
+wrote 131072/131072 bytes at offset 0
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+File extent count after write: 2
+
+Testing with the NO_HOLES feature
+wrote 131072/131072 bytes at offset 0
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+File extent count after write: 2
diff --git a/tests/btrfs/group b/tests/btrfs/group
index 9426fb17..66b1beac 100644
--- a/tests/btrfs/group
+++ b/tests/btrfs/group
@@ -213,3 +213,4 @@
 208 auto quick subvol
 209 auto quick log
 210 auto quick qgroup snapshot
+211 auto quick log prealloc
-- 
2.11.0

