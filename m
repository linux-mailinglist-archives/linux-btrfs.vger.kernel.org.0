Return-Path: <linux-btrfs+bounces-18402-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 97962C1BEEF
	for <lists+linux-btrfs@lfdr.de>; Wed, 29 Oct 2025 17:08:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 129446644A5
	for <lists+linux-btrfs@lfdr.de>; Wed, 29 Oct 2025 15:48:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ADB433A03F;
	Wed, 29 Oct 2025 15:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A6RjVtLt"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6460D325737;
	Wed, 29 Oct 2025 15:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761752796; cv=none; b=L5t4n5kJibCMRJo4kf8FVK9BqSXA0P0Uj8CgIcvk8lzWz5DOajiXdQBS0gxT8xJeaVxA+AgLX5IwcTuUPlwW44VdlY2pULfeBV0bFbEbwH25ycBRjpRvhxep0n2VP4eEy3FcmgM8kwvUTQkbduMTFaSXOzUNfDoSqOqIFjna2Gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761752796; c=relaxed/simple;
	bh=lOG3BhluQpo+8ApurJHcCLu9b4sc0GZYjvlpQXGrcAI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SJQKTjdyqb8WrNuHubzmcmkAXNeUjgq0poemb8GYAQS0KhJ1J2P5gAyhPt+yJTF8emt/Ydv1t6Dgoo3tdBucolOhbF4SgY4HRfsiWBOUgf1xFnfAH8Xi2infGP5X1yLoH1QVprVtWFEOJQuGLPUyinmjAuVQIOp/06d0dVZa3WE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A6RjVtLt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F8F9C4CEF7;
	Wed, 29 Oct 2025 15:46:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761752796;
	bh=lOG3BhluQpo+8ApurJHcCLu9b4sc0GZYjvlpQXGrcAI=;
	h=From:To:Cc:Subject:Date:From;
	b=A6RjVtLtluR8h8KTsJLOt73681zYnlZSSCHDcuUFd2Yt6MZMVZuk6dR9fCN0u4KA8
	 5HR95mwLWllC4VUNzw5MukhiClPIu/dF2Rqd2iEPywp9gpSa4pOJr2N8D8BX1T3Iwm
	 sT6ikTcHl+G9cPluf70a4JG3Q84G5K8ndy90pekgJu/6OdR1cEJCwq573KL0SO4mT2
	 IR//pzA7FgVKFFqhhb6CI8UMUSPQPvaJL6fFb2YiTxzs7OyIMLZ0u0e9YSGcPMYUvj
	 BDYCIolKS1H1xgdEb1wp6m2pFI2TXbISniOfC9+qUBxy+9HNUlUWDntwSKFSV5V7ju
	 3iSIYLtnCPjDg==
From: fdmanana@kernel.org
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org,
	Filipe Manana <fdmanana@suse.com>
Subject: [PATCH] generic: test a scenario of dir fsync after adding a link to a subdir
Date: Wed, 29 Oct 2025 15:46:30 +0000
Message-ID: <92f178d04f74f9281b97d67bdf402e7a5e3baec9.1761752457.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

Test that if we add a new directory to the root directory, change a file
in the root directory, fsync the file, add a hard link for the file inside
the new directory and then fsync the root directory, after a power failure
the root directory has the entry for the new directory.

This is a regression test for the following btrfs patch:

 "btrfs: do not update last_log_commit when logging inode due to a new name"

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 tests/generic/780     | 73 +++++++++++++++++++++++++++++++++++++++++++
 tests/generic/780.out | 10 ++++++
 2 files changed, 83 insertions(+)
 create mode 100755 tests/generic/780
 create mode 100644 tests/generic/780.out

diff --git a/tests/generic/780 b/tests/generic/780
new file mode 100755
index 00000000..d4977b06
--- /dev/null
+++ b/tests/generic/780
@@ -0,0 +1,73 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2025 SUSE S.A.  All Rights Reserved.
+#
+# FS QA Test 780
+#
+# Test that if we add a new directory to the root directory, change a file in
+# the root directory, fsync the file, add a hard link for the file inside the
+# new directory and then fsync the root directory, after a power failure the
+# root directory has the entry for the new directory.
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
+. ./common/filter
+. ./common/dmflakey
+
+_require_scratch
+_require_dm_target flakey
+
+[ "$FSTYP" = "btrfs" ] && _fixed_by_kernel_commit xxxxxxxxxxxx \
+	"btrfs: do not update last_log_commit when logging inode due to a new name"
+
+_scratch_mkfs >>$seqres.full 2>&1 || _fail "mkfs failed"
+_require_metadata_journaling $SCRATCH_DEV
+_init_flakey
+_mount_flakey
+
+# Create our test file.
+touch $SCRATCH_MNT/foo
+
+# Make sure it's durably persisted.
+_scratch_sync
+
+# Create a test directory in the root dir.
+mkdir $SCRATCH_MNT/dir
+
+# Write some data to the file and fsync it.
+$XFS_IO_PROG -c "pwrite -S 0xab 0 64K" \
+	     -c "fsync" $SCRATCH_MNT/foo | _filter_xfs_io
+
+# Add a hard link for our file inside the test directory.
+# On btrfs this causes updating the file's inode and both parent
+# directories in the log tree (in memory only).
+ln $SCRATCH_MNT/foo $SCRATCH_MNT/dir/bar
+
+# Fsync the root directory.
+# We expect it to persist the entry for directory "dir".
+$XFS_IO_PROG -c "fsync" $SCRATCH_MNT/
+
+# Simulate a power failure and then mount again the filesystem to replay the
+# journal/log.
+_flakey_drop_and_remount
+
+# The directory "dir" should be present as well as file "foo".
+# Filter the 'lost+found' that only exists in some filesystems like ext4.
+echo "Root content:"
+ls -1 $SCRATCH_MNT | grep -v 'lost+found'
+
+# Also check file "foo" has the expected data.
+echo "File data:"
+_hexdump $SCRATCH_MNT/foo
+
+_unmount_flakey
+
+_exit 0
diff --git a/tests/generic/780.out b/tests/generic/780.out
new file mode 100644
index 00000000..3be43734
--- /dev/null
+++ b/tests/generic/780.out
@@ -0,0 +1,10 @@
+QA output created by 780
+wrote 65536/65536 bytes at offset 0
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+Root content:
+dir
+foo
+File data:
+000000 ab ab ab ab ab ab ab ab ab ab ab ab ab ab ab ab  >................<
+*
+010000
-- 
2.47.2


