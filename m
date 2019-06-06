Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CA7B73727C
	for <lists+linux-btrfs@lfdr.de>; Thu,  6 Jun 2019 13:08:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726717AbfFFLHy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 6 Jun 2019 07:07:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:57564 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726551AbfFFLHy (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 6 Jun 2019 07:07:54 -0400
Received: from localhost.localdomain (bl8-197-74.dsl.telepac.pt [85.241.197.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 312AB20868;
        Thu,  6 Jun 2019 11:07:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559819273;
        bh=gGCNcJUnoR4OJFSmlMOScrrePnBi3TdumjW/YfN3tpc=;
        h=From:To:Cc:Subject:Date:From;
        b=tjDPuEV5RMHPzB3aUyyzuDeR94SencGsd35t0H+Hb4B4QmSvJvhGWONTmRDkU5dpO
         Eh6/ciolLMDlH9MkY2BCB02nxj3n5leEeOmmkmFLURlhbj202FVnj9YTYwVInLmv7r
         Sq+0BfKNNzWmUrGZ+an6W0Z4j9WfufN2QKRIKZ5k=
From:   fdmanana@kernel.org
To:     fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
Subject: [PATCH] generic: test for data loss on fsync after evicting an inode and renaming it
Date:   Thu,  6 Jun 2019 12:07:47 +0100
Message-Id: <20190606110747.20908-1-fdmanana@kernel.org>
X-Mailer: git-send-email 2.11.0
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

Check that if we write some data to a file, its inode gets evicted (while
its parent directory's inode is not evicted due to being in use), then we
rename the file and fsync it, after a power failure the file data is not
lost.

This currently passes on xfs, ext4 and f2fs but fails on btrfs. The
following patch for btrfs fixes it:

  "Btrfs: fix data loss after inode eviction, renaming it, and fsync it"

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 tests/generic/552     | 98 +++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/generic/552.out |  7 ++++
 tests/generic/group   |  1 +
 3 files changed, 106 insertions(+)
 create mode 100755 tests/generic/552
 create mode 100644 tests/generic/552.out

diff --git a/tests/generic/552 b/tests/generic/552
new file mode 100755
index 00000000..7dc5916f
--- /dev/null
+++ b/tests/generic/552
@@ -0,0 +1,98 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (C) 2019 SUSE Linux Products GmbH. All Rights Reserved.
+#
+# FSQA Test No. 552
+#
+# Check that if we write some data to a file, its inode gets evicted (while its
+# parent directory's inode is not evicted due to being in use), then we rename
+# the file and fsync it, after a power failure the file data is not lost.
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
+_require_odirect
+_require_dm_target flakey
+
+rm -f $seqres.full
+
+_scratch_mkfs >>$seqres.full 2>&1
+_require_metadata_journaling $SCRATCH_DEV
+_init_flakey
+_mount_flakey
+
+# Create our test directory with two files in it.
+mkdir $SCRATCH_MNT/dir
+touch $SCRATCH_MNT/dir/foo
+touch $SCRATCH_MNT/dir/bar
+
+# Do a direct IO write into file bar.
+# To trigger the bug found in btrfs, doing a buffered write would also work as
+# long as writeback completes before the file's inode is evicted (the inode can
+# not be evicted while delalloc exists). But since that is hard to trigger from
+# a user space test, without resulting in a transaction commit as well, just do
+# a direct IO write since it is much simpler.
+$XFS_IO_PROG -d -c "pwrite -S 0xd3 0 4K" $SCRATCH_MNT/dir/bar | _filter_xfs_io
+
+# Keep the directory in use while we evict all inodes. This is to prevent
+# eviction of the directory's inode (a necessary condition to trigger the bug
+# found in btrfs, as evicting the directory inode would result in commiting the
+# current transaction when the fsync of file foo happens below).
+(
+	cd $SCRATCH_MNT/dir
+	while true; do
+		:
+	done
+) &
+pid=$!
+# Wait a bit to give time to the background process to chdir to the directory.
+sleep 0.1
+
+# Evict all inodes from memory, except the directory's inode because a background
+# process is using it.
+echo 2 > /proc/sys/vm/drop_caches
+
+# Now fsync our file foo, which ends up persisting information about its parent
+# directory inode because it is a new inode.
+$XFS_IO_PROG -c "fsync" $SCRATCH_MNT/dir/foo
+
+# Rename our file bar to baz right before we fsync it.
+mv $SCRATCH_MNT/dir/bar $SCRATCH_MNT/dir/baz
+
+# Fsync our file baz, after a power failure we expect to see the data we
+# previously wrote to it.
+$XFS_IO_PROG -c "fsync" $SCRATCH_MNT/dir/baz
+
+# Kill the background process using our test directory.
+kill $pid
+wait $pid
+
+# Simulate a power failure and then check no data loss happened.
+_flakey_drop_and_remount
+
+echo "File data after power failure:"
+od -t x1 -A d $SCRATCH_MNT/dir/baz
+
+_unmount_flakey
+status=0
+exit
diff --git a/tests/generic/552.out b/tests/generic/552.out
new file mode 100644
index 00000000..43c5c521
--- /dev/null
+++ b/tests/generic/552.out
@@ -0,0 +1,7 @@
+QA output created by 552
+wrote 4096/4096 bytes at offset 0
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+File data after power failure:
+0000000 d3 d3 d3 d3 d3 d3 d3 d3 d3 d3 d3 d3 d3 d3 d3 d3
+*
+0004096
diff --git a/tests/generic/group b/tests/generic/group
index 35f98124..5b3c1616 100644
--- a/tests/generic/group
+++ b/tests/generic/group
@@ -554,3 +554,4 @@
 549 auto quick encrypt
 550 auto quick encrypt
 551 auto stress aio
+552 auto quick log
-- 
2.11.0

