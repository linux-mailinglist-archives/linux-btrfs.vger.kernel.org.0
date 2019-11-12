Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 44A29F93CA
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Nov 2019 16:13:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727168AbfKLPNp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 12 Nov 2019 10:13:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:34632 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726896AbfKLPNp (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 12 Nov 2019 10:13:45 -0500
Received: from localhost.localdomain (bl8-197-74.dsl.telepac.pt [85.241.197.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CB0A92067B;
        Tue, 12 Nov 2019 15:13:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573571624;
        bh=kKklsAScypZ0Cmqv8ZxvfGiMcXlsxZsytkVhcht98Hg=;
        h=From:To:Cc:Subject:Date:From;
        b=FN4orMJKDBkN5DUCFdpLyeCluIXM4WV4IOv5GlDk5fphwpyzV0BPVKvSUIW6iO5VA
         K1tgzjXnb72z3R2b40fOkEBYEVRZVvDvwDn+0oSDT1Ci6HDO/n4ORHDJ13vLYDjzw+
         0OTkAVoPiKd0rJepKzrdvaGsUaVPAge7F2g/SMRo=
From:   fdmanana@kernel.org
To:     fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
Subject: [PATCH] btrfs: test fsync after hole punching when using the no-holes feature
Date:   Tue, 12 Nov 2019 15:13:40 +0000
Message-Id: <20191112151340.3688-1-fdmanana@kernel.org>
X-Mailer: git-send-email 2.11.0
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

Test that when we have the no-holes feature enabled and a specific metadata
layout, if we punch a hole that starts at file offset 0 and fsync the file,
after replaying the log the hole exists.

This currently fails on btrfs but is fixed by a patch for the linux kernel
with the following subject:

 "Btrfs: fix missing hole after hole punching and fsync when using NO_HOLES"

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 tests/btrfs/201     | 100 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/201.out |   5 +++
 tests/btrfs/group   |   1 +
 3 files changed, 106 insertions(+)
 create mode 100755 tests/btrfs/201
 create mode 100644 tests/btrfs/201.out

diff --git a/tests/btrfs/201 b/tests/btrfs/201
new file mode 100755
index 00000000..592ae23d
--- /dev/null
+++ b/tests/btrfs/201
@@ -0,0 +1,100 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (C) 2019 SUSE Linux Products GmbH. All Rights Reserved.
+#
+# FSQA Test No. 201
+#
+# Test that when we have the no-holes feature enabled and a specific metadata
+# layout, if we punch a hole that starts at file offset 0 and fsync the file,
+# after replaying the log the hole exists.
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
+_require_attrs
+_require_xfs_io_command "fpunch"
+_require_btrfs_fs_feature "no_holes"
+_require_btrfs_mkfs_feature "no-holes"
+_require_odirect
+
+rm -f $seqres.full
+
+# We create the filesystem with a node size of 64Kb because we need to create a
+# specific metadata layout in order to trigger the bug we are testing. At the
+# moment the node size can not be smaller then the system's page size, so given
+# that the largest possible page size is 64Kb and by default the node size is
+# set to the system's page size value, we explicitly create a filesystem with a
+# 64Kb node size, so that the test can run reliably independently of the system's
+# page size.
+_scratch_mkfs -O no-holes -n $((64 * 1024)) >>$seqres.full 2>&1
+_require_metadata_journaling $SCRATCH_DEV
+_init_flakey
+_mount_flakey
+
+# Create our first file, which is used just to fill space in a leaf. Its items
+# ocuppy most of the first leaf. We use a large xattr since it's an easy and
+# fast way to fill a lot of leaf space.
+touch $SCRATCH_MNT/foo
+$SETFATTR_PROG -n 'user.x1' -v $(printf '%0.sX' $(seq 1 63617)) $SCRATCH_MNT/foo
+
+# Create our second file, which we will use to test if fsync persists a hole
+# punch operation against it. Create several extent items for the file, all with
+# a size of 64Kb. The first extent item of this file is located within the first
+# leaf of the fs tree, as its last item, and all the remaining extent items in
+# another leaf.
+offset=0
+for ((i = 0; i <= 10; i++)); do
+	$XFS_IO_PROG -f -d -c "pwrite -S 0xab -b 64K $offset 64K" \
+		$SCRATCH_MNT/bar >/dev/null
+	offset=$(($offset + 64 * 1024))
+done
+
+# Make sure everything done so far is durably persisted. We also want to start a
+# new transaction and bump the filesystem generation. We don't fsync because we
+# want to keep the 'full sync' flag in the inode of file 'bar', so that the
+# fsync after the hole punch operation uses the slow path, which is necessary to
+# trigger the bug we are testing.
+sync
+
+# Now punch a hole that covers only the first extent item of file bar. That is
+# the only extent item in the first leaf of the first tree, so the hole punch
+# operation will drop it and will not touch the second leaf which contains the
+# remaining extent items. These conditions are necessary to trigger the bug we
+# are testing.
+$XFS_IO_PROG -c "fpunch 0 64K" -c "fsync" $SCRATCH_MNT/bar
+
+echo "File digest before power failure:"
+md5sum $SCRATCH_MNT/bar | _filter_scratch
+# Simulate a power failure and mount the filesystem to check that replaying the
+# log tree succeeds and our file bar has the expected content.
+_flakey_drop_and_remount
+echo "File digest after power failure and log replay:"
+md5sum $SCRATCH_MNT/bar | _filter_scratch
+
+_unmount_flakey
+_cleanup_flakey
+
+status=0
+exit
diff --git a/tests/btrfs/201.out b/tests/btrfs/201.out
new file mode 100644
index 00000000..66631658
--- /dev/null
+++ b/tests/btrfs/201.out
@@ -0,0 +1,5 @@
+QA output created by 201
+File digest before power failure:
+e1e40ea5ab31cc36fb74830a6293eb2b  SCRATCH_MNT/bar
+File digest after power failure and log replay:
+e1e40ea5ab31cc36fb74830a6293eb2b  SCRATCH_MNT/bar
diff --git a/tests/btrfs/group b/tests/btrfs/group
index d56dcafa..d7eeb45d 100755
--- a/tests/btrfs/group
+++ b/tests/btrfs/group
@@ -203,3 +203,4 @@
 198 auto quick volume
 199 auto quick trim
 200 auto quick send clone
+201 auto quick punch log
-- 
2.11.0

