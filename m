Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBCC23BD8AF
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 Jul 2021 16:43:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232999AbhGFOqF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 6 Jul 2021 10:46:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:36786 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232686AbhGFOpu (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 6 Jul 2021 10:45:50 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6662E61447;
        Tue,  6 Jul 2021 14:43:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625582592;
        bh=I+Qjfj0jRXnQ+l9/aImguvu0qDNPNZHHuHrZucfhbxU=;
        h=From:To:Cc:Subject:Date:From;
        b=P++QDggmjdjY6FVbBnobaVsGo3HF587qOqJsKU5LivJlO81aIUX6vs6OKYdpp+eSZ
         l4d/Mppf6yHKMq1qyJ4vvOl9xFn42HnX/cMQdzTvnG3tWO7fUPbR0kqEzBYG3RmoV+
         Fn9rDNuOtLzB6O9KRQbCUgFV6QLKMVrMz5F5u5Y9G4HXYzmOQBaa5oKXg8lGnkBrcK
         Es1/eDs89WLqd4vOjOss4ZinHuDBY1FAhjPsHfkcBFmTctPOAt/bM+YrryzkU0310I
         DiDV69CIoPiTkwH+rcqwZHu6fwWXexmEBep8STEhnhcGUrCVzVqqQr0jaxOQhoZU7M
         fSs6xnKqJpttA==
From:   fdmanana@kernel.org
To:     fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
Subject: [PATCH] btrfs: test fsync after increasing file size with truncate
Date:   Tue,  6 Jul 2021 15:42:17 +0100
Message-Id: <6dedbce5e4eb410f96b946a4fe065626990a232c.1625582369.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

Test that if we explicitly fsync a file that was previously renamed and
its size was increased through a truncate operation, after a power failure
the file has the size set by the truncate operation. Also, in between the
truncation and the fsync, there was a rename of another file in the same
directory and that file was also fsynced before we fsynced the file that
was truncated.

This currently fails on a 5.13 kernel and on Linus' master branch. It is
fixed by a patch with the following subject:

  "btrfs: fix unpersisted i_size on fsync after expanding truncate"

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 tests/btrfs/242     | 93 +++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/242.out | 15 ++++++++
 2 files changed, 108 insertions(+)
 create mode 100755 tests/btrfs/242
 create mode 100644 tests/btrfs/242.out

diff --git a/tests/btrfs/242 b/tests/btrfs/242
new file mode 100755
index 00000000..7ae28751
--- /dev/null
+++ b/tests/btrfs/242
@@ -0,0 +1,93 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2021 SUSE Linux Products GmbH.  All Rights Reserved.
+#
+# FS QA Test 242
+#
+# Test that if we explicitly fsync a file that was previously renamed and its
+# size was increased through a truncate operation, after a power failure the
+# file has the size set by truncate operation. In between the truncation and
+# the fsync, there was a rename of another file in the same directory and that
+# file was also fsynced before we fsynced the file that was truncated.
+#
+. ./common/preamble
+_begin_fstest auto quick log
+
+_cleanup()
+{
+	_cleanup_flakey
+	cd /
+	rm -r -f $tmp.*
+}
+
+. ./common/rc
+. ./common/filter
+. ./common/dmflakey
+
+# real QA test starts here
+
+_supported_fs btrfs
+_require_scratch
+_require_dm_target flakey
+
+rm -f $seqres.full
+
+_scratch_mkfs >>$seqres.full 2>&1
+_require_metadata_journaling $SCRATCH_DEV
+_init_flakey
+_mount_flakey
+
+# Create our test files.
+touch $SCRATCH_MNT/foo
+$XFS_IO_PROG -f -c "pwrite -S 0xab 0 1M" $SCRATCH_MNT/bar | _filter_xfs_io
+
+# Make them durably persisted.
+sync
+
+# Fsync bar, this will be a noop since the file has not yet been modified in
+# the current transaction. The goal here is to clear BTRFS_INODE_NEEDS_FULL_SYNC
+# from the inode's runtime flags.
+$XFS_IO_PROG -c "fsync" $SCRATCH_MNT/bar
+
+# Now rename both files, without changing their parent directory.
+mv $SCRATCH_MNT/bar $SCRATCH_MNT/bar2
+mv $SCRATCH_MNT/foo $SCRATCH_MNT/foo2
+
+# Increase the size of bar2 with a truncate operation.
+$XFS_IO_PROG -c "truncate 2M" $SCRATCH_MNT/bar2
+
+# Now fsync foo2, this results in logging its parent inode (the root directory),
+# and logging the parent results in logging the inode of file bar2 (its inode
+# item and the new name). The inode of file bar2 is logged with an i_size of 0
+# bytes since it's logged in LOG_INODE_EXISTS mode, meaning we are only logging
+# its names (and xattrs if it had any) and the i_size of the inode will not be
+# changed when the log is replayed.
+$XFS_IO_PROG -c "fsync" $SCRATCH_MNT/foo2
+
+# Now explicitly fsync bar2. This resulted in doing nothing, not logging the
+# inode with the new i_size of 2M and the hole from file offset 1M to 2M.
+# Because the inode did not have the flag BTRFS_INODE_NEEDS_FULL_SYNC set, when
+# it was logged through the fsync of file foo2, its last_log_commit field was
+# updated, resulting in this explicit of file bar2 not doing anything.
+$XFS_IO_PROG -c "fsync" $SCRATCH_MNT/bar2
+
+echo "File bar2 content before power failure:"
+od -A d -t x1 $SCRATCH_MNT/bar2
+
+# Simulate a power failure and then mount again the filesystem to replay the log
+# tree.
+_flakey_drop_and_remount
+
+echo "File bar2 content after power failure:"
+od -A d -t x1 $SCRATCH_MNT/bar2
+
+# While here, also check that the rename of foo to foo2 was durably persisted,
+# even if it's not the specific regression the test is checking for.
+[ -f $SCRATCH_MNT/foo2 ] || echo "File name foo2 does not exists"
+[ -f $SCRATCH_MNT/foo ] && echo "File name foo still exists"
+
+_unmount_flakey
+
+# success, all done
+status=0
+exit
diff --git a/tests/btrfs/242.out b/tests/btrfs/242.out
new file mode 100644
index 00000000..49e184dd
--- /dev/null
+++ b/tests/btrfs/242.out
@@ -0,0 +1,15 @@
+QA output created by 242
+wrote 1048576/1048576 bytes at offset 0
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+File bar2 content before power failure:
+0000000 ab ab ab ab ab ab ab ab ab ab ab ab ab ab ab ab
+*
+1048576 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+*
+2097152
+File bar2 content after power failure:
+0000000 ab ab ab ab ab ab ab ab ab ab ab ab ab ab ab ab
+*
+1048576 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+*
+2097152
-- 
2.30.2

