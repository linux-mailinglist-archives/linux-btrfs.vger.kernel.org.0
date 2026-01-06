Return-Path: <linux-btrfs+bounces-20160-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B8FFCF8662
	for <lists+linux-btrfs@lfdr.de>; Tue, 06 Jan 2026 13:59:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E95A23009266
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 Jan 2026 12:59:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B26532E692;
	Tue,  6 Jan 2026 12:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DnYZT9Og"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E6CA32694F;
	Tue,  6 Jan 2026 12:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767704351; cv=none; b=e1qCMO1uJS7AeTKn9LBSU9eiEcposQWAvnSw0IBOaq1OzzTV8S+VMk/6dpkyQFCJBs0OamQ+eIkIOFmtDP4Dreyb6mcMB2zCHBsVwpfo+3kYDiw/ZfjMqBfhGO5vh2aHREFSriGnF4s0SAnoZ5flGkBE5DrmfXAjJdxEN0aY0BU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767704351; c=relaxed/simple;
	bh=qsZo1CkCU6x6KE9vn2C+7QXzDEsW7+XmCXn5LiqZng0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nWVCP9QsJMXULCQtpJRi/DN+enPwNYDrOZq6XyJv0hIzlKsgVWuYvfRw2BCWF4xwqzxEW5flinYnkc2q28ITjr4rBCvzR9Sfb/dRxeA0mlouLm0HZsFLS9XMTr5lDwnqoj8CgmU2kxQHfve6D0nshi8FNrOfeDe7L5buZausWjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DnYZT9Og; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44288C16AAE;
	Tue,  6 Jan 2026 12:59:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767704351;
	bh=qsZo1CkCU6x6KE9vn2C+7QXzDEsW7+XmCXn5LiqZng0=;
	h=From:To:Cc:Subject:Date:From;
	b=DnYZT9OggnT9OejBD4KimZYVtizM6zZH6vzgKPKk8vUb7xF5rqee31XAJRrWnPpjq
	 fNiws4qMV3yC++F/iASRtbGQO4Z4YMVVrg2FHYJaaRgkLJIeLfMENQwVTAV7/ld/On
	 NozIV+Wk+uHjaJE0Kh9vKjv33mhiGMVGNzAq3+vbmrcRzL4ZK52zeJCpsXpQNGC2hN
	 7s2PVTWmuPxXsCyUE3cCY/b8e+82M/xvxC1oS1hquA6jNuadEdhY3BR5CnpKMLb8lF
	 MaBWb1e+YfAWnr3tbfJltSFoIsSUwdV4i9+O7vAHGnqGJUw7ikJOw+myL369hVRO1T
	 krhlFZnW5kENQ==
From: fdmanana@kernel.org
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org,
	Filipe Manana <fdmanana@suse.com>
Subject: [PATCH v2] btrfs: test power failure after fsync and rename exchanging directories
Date: Tue,  6 Jan 2026 12:59:05 +0000
Message-ID: <a28c38d771946a662a9596449f63e6060f3fc7a4.1767704259.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

Test renaming one directory over another one that has a subvolume inside
it and fsync a file in the other directory that was previously renamed.
We want to verify that after a power failure we are able to mount the
filesystem and it has the correct content (all renames visible).

This exercises a bug fixed by the following kernel commit:

  7ba0b6461bc4 ("btrfs: always detect conflicting inodes when logging inode refs")

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---

V2: Rebase to latest for-next, include kernel fix commit ID since it
    was merged to Linus' tree yesterday.

 tests/btrfs/341     | 73 +++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/341.out | 15 ++++++++++
 2 files changed, 88 insertions(+)
 create mode 100755 tests/btrfs/341
 create mode 100644 tests/btrfs/341.out

diff --git a/tests/btrfs/341 b/tests/btrfs/341
new file mode 100755
index 00000000..d92f9614
--- /dev/null
+++ b/tests/btrfs/341
@@ -0,0 +1,73 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2026 SUSE S.A.  All Rights Reserved.
+#
+# FS QA Test 341
+#
+# Test renaming one directory over another one that has a subvolume inside it
+# and fsync a file in the other directory that was previously renamed. We want
+# to verify that after a power failure we are able to mount the filesystem and
+# it has the correct content (all renames visible).
+#
+. ./common/preamble
+_begin_fstest auto quick subvol rename log
+
+_cleanup()
+{
+	_cleanup_flakey
+	cd /
+	rm -r -f $tmp.*
+}
+
+. ./common/filter
+. ./common/dmflakey
+. ./common/renameat2
+
+_require_scratch
+_require_dm_target flakey
+_require_renameat2 exchange
+
+_fixed_by_kernel_commit 7ba0b6461bc4 \
+	"btrfs: always detect conflicting inodes when logging inode refs"
+
+_scratch_mkfs >>$seqres.full 2>&1 || _fail "mkfs failed"
+_require_metadata_journaling $SCRATCH_DEV
+_init_flakey
+_scratch_mount
+
+# Create our test directories, one with a file inside, another with a subvolume
+# that is not empty (has one file).
+mkdir $SCRATCH_MNT/dir1
+echo -n > $SCRATCH_MNT/dir1/foo
+
+mkdir $SCRATCH_MNT/dir2
+_btrfs subvolume create $SCRATCH_MNT/dir2/subvol
+echo -n > $SCRATCH_MNT/dir2/subvol/subvol_file
+
+_scratch_sync
+
+# Rename file foo so that its inode's last_unlink_trans is updated to the
+# current transaction.
+mv $SCRATCH_MNT/dir1/foo $SCRATCH_MNT/dir1/bar
+
+# Rename exchange dir1 with dir2.
+$here/src/renameat2 -x $SCRATCH_MNT/dir1 $SCRATCH_MNT/dir2
+
+# Fsync file bar, we just renamed from foo.
+# Until the kernel fix mentioned above, it would result in logging dir2 without
+# logging dir1, causing log replay to attempt to remove the inode for dir1 since
+# the inode for dir2 has the same name in the same parent directory. Not only
+# this was not correct, since we did not delete the directory, but it would also
+# result in a log replay failure (and therefore mount failure) because we would
+# be attempting to delete a directory with a non-empty subvolume inside it.
+$XFS_IO_PROG -c "fsync" $SCRATCH_MNT/dir2/bar
+
+# Simulate a power failure and then mount again the filesystem to replay the
+# journal/log. We should be able to replay the log tree and mount successfully.
+_flakey_drop_and_remount
+
+echo -e "Filesystem contents after power failure:\n"
+ls -1R $SCRATCH_MNT | _filter_scratch
+
+# success, all done
+_exit 0
diff --git a/tests/btrfs/341.out b/tests/btrfs/341.out
new file mode 100644
index 00000000..bd46bdea
--- /dev/null
+++ b/tests/btrfs/341.out
@@ -0,0 +1,15 @@
+QA output created by 341
+Filesystem contents after power failure:
+
+SCRATCH_MNT:
+dir1
+dir2
+
+SCRATCH_MNT/dir1:
+subvol
+
+SCRATCH_MNT/dir1/subvol:
+subvol_file
+
+SCRATCH_MNT/dir2:
+bar
-- 
2.47.2


