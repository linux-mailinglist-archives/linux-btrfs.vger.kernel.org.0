Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4E5433D9E2
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Mar 2021 17:55:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230050AbhCPQzG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 16 Mar 2021 12:55:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:47956 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234702AbhCPQyi (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 16 Mar 2021 12:54:38 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E0C886510E;
        Tue, 16 Mar 2021 16:54:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615913678;
        bh=WrD0NbkKDgUuDd31tZcpNQ2x79XPjWLSfbeZg5qppZY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=I8dceY1rxs0C2nODgzcHbYC4x/Jifrho1Z6j7Hq7FpLycRDIxjasREAR0gSEYklvC
         Ymo9CVt7g1u7LqAYcinsr7MWuXWZmwYoVyjPID5DNMCa4FBVZtL7Ll7Xu1tI/7LnLN
         Uim6cSD8eaJ8F9/oBSV8RQrXXHB2CWx2WjknxUvKVvJ4RJshjL3FCDpnqvCQsjp/Dd
         3hV6dWUbAfYe8NGdrlfhcKbRl4He2omBElZAuxHXGpS4/8V63FVNxts7lXRqb7cff7
         vEkB7Pp4Z7RjnAAFNn8ZsdqYU/zfkvY6xbsPsukR1LH6BkoAyfgaxvvU2zfdMJkkcf
         Pc4XWsg425nMg==
From:   fdmanana@kernel.org
To:     fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
Subject: [PATCH v2] btrfs: test delayed subvolume deletion on mount and remount
Date:   Tue, 16 Mar 2021 16:54:28 +0000
Message-Id: <89df93218c94b53dd44b12daaeb65fd0e6117392.1615912196.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <7afeaebb8b944a11afc40bafb9e0dff3529c4d52.1615896998.git.fdmanana@suse.com>
References: <7afeaebb8b944a11afc40bafb9e0dff3529c4d52.1615896998.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

Test that subvolume deletion is resumed on RW mounts, that it is not
performed on RO mounts and that after remounting a filesystem from RO
to RW mode, it is also performed.

This triggers a regression introduced in kernel 5.11 which is fixed
by a patch that has the following subject:

   "btrfs: fix subvolume/snapshot deletion not triggered on mount"

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---

V2: Updated test to actually check if the subvolume's btree is deleted
    and make it not racy by calling 'btrfs subvolume sync'.

 tests/btrfs/233     | 152 ++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/233.out |   5 ++
 tests/btrfs/group   |   1 +
 3 files changed, 158 insertions(+)
 create mode 100755 tests/btrfs/233
 create mode 100644 tests/btrfs/233.out

diff --git a/tests/btrfs/233 b/tests/btrfs/233
new file mode 100755
index 00000000..10e77358
--- /dev/null
+++ b/tests/btrfs/233
@@ -0,0 +1,152 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (C) 2021 SUSE Linux Products GmbH. All Rights Reserved.
+#
+# FSQA Test No. 233
+#
+# Test that subvolume deletion is resumed on RW mounts, that it is not performed
+# on RO mounts and that after remounting a filesystem from RO to RW mode, it is
+# performed.
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
+_require_dm_target flakey
+_require_btrfs_command inspect-internal dump-tree
+
+rm -f $seqres.full
+
+_scratch_mkfs >>$seqres.full 2>&1
+_require_metadata_journaling $SCRATCH_DEV
+_init_flakey
+_mount_flakey
+
+check_subvol_orphan_item_exists()
+{
+	# Check that the orphan item for our subvolume exists in the root tree.
+	$BTRFS_UTIL_PROG inspect-internal dump-tree -t 1 $SCRATCH_DEV | \
+		grep -q 'ORPHAN ORPHAN_ITEM 256'
+	[ $? -ne 0 ] && echo "subvolume orphan item is missing"
+}
+
+check_subvol_orphan_item_not_exists()
+{
+	# Check that the orphan item for our subvolume does not exists in the
+	# root tree.
+	$BTRFS_UTIL_PROG inspect-internal dump-tree -t 1 $SCRATCH_DEV | \
+		grep -q 'ORPHAN ORPHAN_ITEM 256'
+	[ $? -eq 0 ] && echo "subvolume orphan item still exists"
+}
+
+check_subvol_btree_exists()
+{
+	$BTRFS_UTIL_PROG inspect-internal dump-tree $SCRATCH_DEV | \
+		grep -q 'file tree key (256 ROOT_ITEM 0)'
+	[ $? -ne 0 ] && echo "subvolume btree is missing"
+}
+
+check_subvol_btree_not_exists()
+{
+	$BTRFS_UTIL_PROG inspect-internal dump-tree $SCRATCH_DEV | \
+		grep -q 'file tree key (256 ROOT_ITEM 0)'
+	[ $? -eq 0 ] && echo "subvolume btree still exists"
+}
+
+create_subvol_with_orphan()
+{
+	$BTRFS_UTIL_PROG subvolume create $SCRATCH_MNT/testsv | _filter_scratch
+
+	# Create a file in our subvolume and make it durably persisted.
+	touch $SCRATCH_MNT/testsv/foobar
+	sync
+
+	# Now open a file descriptor on the file and, while holding the file
+	# open, delete the subvolume, then 'sync' to durably persist the orphan
+	# item for the subvolume.
+	exec 73< $SCRATCH_MNT/testsv/foobar
+	$BTRFS_UTIL_PROG subvolume delete $SCRATCH_MNT/testsv | _filter_scratch
+	sync
+
+	# Now silently drop writes on the device, close the file descriptor and
+	# unmount the filesystem. After this we should have an orphan item in
+	# root tree for the subvolume, so that its tree is deleted on the next
+	# RW mount.
+	_load_flakey_table $FLAKEY_DROP_WRITES
+	exec 73>&-
+	_unmount_flakey
+
+	check_subvol_orphan_item_exists
+	check_subvol_btree_exists
+
+	_load_flakey_table $FLAKEY_ALLOW_WRITES
+}
+
+create_subvol_with_orphan
+
+# Mount the filesystem in RW mode and unmount it. After that, the subvolume
+# and its orphan item should not exist anymore.
+# Use a commit interval lower than the default (30 seconds) so that the test
+# is faster and we spend less time waiting for transaction commits.
+MOUNT_OPTIONS="-o commit=1"
+_mount_flakey
+$BTRFS_UTIL_PROG subvolume sync $SCRATCH_MNT >>$seqres.full
+_unmount_flakey
+
+check_subvol_orphan_item_not_exists
+check_subvol_btree_not_exists
+
+# Now lets check a RO mount does not trigger subvolume deletion.
+_cleanup_flakey
+_scratch_mkfs >>$seqres.full 2>&1
+_init_flakey
+_mount_flakey
+
+create_subvol_with_orphan
+MOUNT_OPTIONS="-o ro,commit=1"
+_mount_flakey
+# The subvolume path should not be accessible anymore, even if deletion of the
+# subvolume btree did not happen yet.
+[ -e $SCRATCH_MNT/testsv ] && echo "subvolume path still exists"
+_unmount_flakey
+
+# The subvolume btree should still exist, even though the path is not accessible.
+check_subvol_btree_exists
+# The orphan item for the subvolume should still exist, as the subvolume btree
+# was not yet deleted.
+check_subvol_orphan_item_exists
+
+# Mount the filesystem RO again.
+_mount_flakey
+
+# Now remount RW, then unmount and then check the subvolume's orphan item, btree
+# and path don't exist anymore.
+MOUNT_OPTIONS="-o remount,rw"
+_mount_flakey
+$BTRFS_UTIL_PROG subvolume sync $SCRATCH_MNT >>$seqres.full
+[ -e $SCRATCH_MNT/testsv ] && echo "subvolume path still exists"
+_unmount_flakey
+
+check_subvol_orphan_item_not_exists
+check_subvol_btree_not_exists
+
+status=0
+exit
diff --git a/tests/btrfs/233.out b/tests/btrfs/233.out
new file mode 100644
index 00000000..492e959d
--- /dev/null
+++ b/tests/btrfs/233.out
@@ -0,0 +1,5 @@
+QA output created by 233
+Create subvolume 'SCRATCH_MNT/testsv'
+Delete subvolume (no-commit): 'SCRATCH_MNT/testsv'
+Create subvolume 'SCRATCH_MNT/testsv'
+Delete subvolume (no-commit): 'SCRATCH_MNT/testsv'
diff --git a/tests/btrfs/group b/tests/btrfs/group
index c0d7a53c..5214dbdb 100644
--- a/tests/btrfs/group
+++ b/tests/btrfs/group
@@ -235,3 +235,4 @@
 230 auto quick qgroup limit
 231 auto quick clone log replay
 232 auto quick qgroup limit
+233 auto quick subvolume
-- 
2.28.0

