Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C2A2C4B7A0
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Jun 2019 14:06:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731624AbfFSMGO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 19 Jun 2019 08:06:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:45784 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726246AbfFSMGO (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 19 Jun 2019 08:06:14 -0400
Received: from localhost.localdomain (bl8-197-74.dsl.telepac.pt [85.241.197.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1E906206E0;
        Wed, 19 Jun 2019 12:06:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560945972;
        bh=2e25v3tLR34fEEuDqNA8PPtm5zwHn9CHWXs3JAkzQRs=;
        h=From:To:Cc:Subject:Date:From;
        b=N1lKytHt55tDO6Rg/f5A8F9eewrcTBM1ed41kykMy9dh5weckXtcGKD1Dnc9mWCVo
         AKd9FFUNyVYEmUL69S0sAIPaLVZ9kxzIxE4nBpkN/AY5A4ohLPLbDC/NtmK9gxh/ER
         MEN/RZ/75VfwJQyvKPp/WJO9wf7UOjj9r/rcVOxc=
From:   fdmanana@kernel.org
To:     fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
Subject: [PATCH 1/2] generic: test dir fsync after deleting dentry post eviction of its inode
Date:   Wed, 19 Jun 2019 13:06:08 +0100
Message-Id: <20190619120608.9872-1-fdmanana@kernel.org>
X-Mailer: git-send-email 2.11.0
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

Test that if we fsync a file, evict its inode, unlink it and then fsync
its parent directory, after a power failure the file does not exists.

This is motivated by a bug found in btrfs, which is fixed by the following
patch for the linux kernel:

 "Btrfs: fix fsync not persisting dentry deletions due to inode evictions"

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 tests/generic/557     | 79 +++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/generic/557.out |  2 ++
 tests/generic/group   |  1 +
 3 files changed, 82 insertions(+)
 create mode 100755 tests/generic/557
 create mode 100644 tests/generic/557.out

diff --git a/tests/generic/557 b/tests/generic/557
new file mode 100755
index 00000000..64a4dbf7
--- /dev/null
+++ b/tests/generic/557
@@ -0,0 +1,79 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (C) 2019 SUSE Linux Products GmbH. All Rights Reserved.
+#
+# FSQA Test No. 557
+#
+# Test that if we fsync a file, evict its inode, unlink it and then fsync its
+# parent directory, after a power failure the file does not exists.
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
+_supported_fs generic
+_supported_os Linux
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
+# Create our test directory with one file in it and fsync the file.
+mkdir $SCRATCH_MNT/dir
+touch $SCRATCH_MNT/dir/foo
+$XFS_IO_PROG -c "fsync" $SCRATCH_MNT/dir/foo
+
+# Keep an open file descriptor on our directory while we evict inodes. We just
+# want to evict the file's inode, the directory's inode must not be evicted.
+(
+	cd $SCRATCH_MNT/dir
+	while true; do
+		:
+	done
+) &
+pid=$!
+# Wait a bit to give time to background process to chdir to our test directory.
+sleep 0.1
+
+# Trigger eviction of the file's inode.
+echo 2 > /proc/sys/vm/drop_caches
+
+# Unlink our file and fsync the parent directory. After a power failure we don't
+# expect to see the file anymore, since we fsync'ed the parent directory.
+unlink $SCRATCH_MNT/dir/foo
+$XFS_IO_PROG -c "fsync" $SCRATCH_MNT/dir
+
+# Kill the background process using our test directory.
+kill $pid
+wait $pid
+
+# Simulate a power failure and then check file foo does not exists anymore.
+_flakey_drop_and_remount
+
+[ -f $SCRATCH_MNT/dir/foo ] && echo "File foo still exists"
+
+_unmount_flakey
+echo "Silence is golden"
+status=0
+exit
diff --git a/tests/generic/557.out b/tests/generic/557.out
new file mode 100644
index 00000000..1f1ae1d4
--- /dev/null
+++ b/tests/generic/557.out
@@ -0,0 +1,2 @@
+QA output created by 557
+Silence is golden
diff --git a/tests/generic/group b/tests/generic/group
index 0867e455..543c0627 100644
--- a/tests/generic/group
+++ b/tests/generic/group
@@ -559,3 +559,4 @@
 554 auto quick copy_range swap
 555 auto quick cap
 556 auto quick casefold
+557 auto quick log
-- 
2.11.0

