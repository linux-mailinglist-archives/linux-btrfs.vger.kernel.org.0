Return-Path: <linux-btrfs+bounces-19489-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C96FDCA088A
	for <lists+linux-btrfs@lfdr.de>; Wed, 03 Dec 2025 18:38:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2C7EC3007C84
	for <lists+linux-btrfs@lfdr.de>; Wed,  3 Dec 2025 17:38:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC851347FEB;
	Wed,  3 Dec 2025 17:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nlPQHlKN"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D767E346FA9;
	Wed,  3 Dec 2025 17:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764783500; cv=none; b=h3/peLUgFOfkgMkKllAQ3OkimW7Gejv53EpUlinjcJLFDNyGkfIXpWRzffEBb1JpOBQGRePwsWJx/6C3+68f1eoT9Qm4SQzVxxYr5AG1QaFiHDlojJ+c8MFTKuQgFZ1mg2TZrKFb0eJ8bs1gAVXfmXWUcTUuGHSwARvkpEOMoqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764783500; c=relaxed/simple;
	bh=tmfRmA28K+PaL9EZVq8H10oTJ8A5bJG2yVQavw67f9s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ui6o7XGRjE0T37NxlVt/nG+lCnHBrfgu6Do97r8054vs1cduFuqGY+AI6Shq3QzUHvnGMjIVOfbWTkz35jhLmUVtews3Rsr9qYa+h72+sgNhFb4Kx+lUvD9ktEVEdKHhJ5rvUZWfSRC2AzH98t0oU1xy3Txbu6v9UI3x2k8LP8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nlPQHlKN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90E4AC4CEF5;
	Wed,  3 Dec 2025 17:38:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764783500;
	bh=tmfRmA28K+PaL9EZVq8H10oTJ8A5bJG2yVQavw67f9s=;
	h=From:To:Cc:Subject:Date:From;
	b=nlPQHlKNlcSNFOK+lXjEdcQyj6QKTioNbHPRdrX/6nGGJ8NafufaPibWbTaGCOe3L
	 mK0cE3vJwFN8WhZDFAeixqr/GVWukOhRA18GR3TftKqtt3ZWQZ7gfN6DxvelRjGw4N
	 RgrCfKWjQLSlj376fNk9r0BDl7iGjilXjh5ewh0tTQ9MUCg+tH+88MRveBBMVFEp4o
	 h9yqTiDZ2x9io9+pFSLzX/e/jgv4Jfx6JjO7O/sY4bQgx6jMqWH6kE+hYh1yiCLT3E
	 ZKZCOmuBdc0NGuVK3hT9hBFJiz9dGsivT7RqOXBOPEBUcGfPSwS32vhHnZHEIyNtVS
	 6lGSwcm7gznYg==
From: fdmanana@kernel.org
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org,
	Filipe Manana <fdmanana@suse.com>
Subject: [PATCH] generic: test journaling after renaming fsynced file and fsync parent dir
Date: Wed,  3 Dec 2025 17:38:14 +0000
Message-ID: <a883e236548bec41bb0b043fe0105b4da4fd0749.1764783252.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

Test that if we fsync a file, create a directory in the same parent
directory of the file, add a file to the new directory, rename the
initial file and then fsync the parent directory of the first file, after
a power failure the new directory exists, with its new entry and the first
file has the new name and any data we wrote to it before its fsync.

This exercises a reported btrfs bug which is fixed by a patch with the
following subject:

  "btrfs: do not skip logging new dentries when logging a new name"

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 tests/generic/785     | 73 +++++++++++++++++++++++++++++++++++++++++++
 tests/generic/785.out |  4 +++
 2 files changed, 77 insertions(+)
 create mode 100755 tests/generic/785
 create mode 100644 tests/generic/785.out

diff --git a/tests/generic/785 b/tests/generic/785
new file mode 100755
index 00000000..a6cfdd87
--- /dev/null
+++ b/tests/generic/785
@@ -0,0 +1,73 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2025 SUSE S.A.  All Rights Reserved.
+#
+# FS QA Test 785
+#
+# Test that if we fsync a file, create a directory in the same parent directory
+# of the file, add a file to the new directory, rename the initial file and then
+# fsync the parent directory of the first file, after a power failure the new
+# directory exists, with its new entry and the first file has the new name and
+# any data we wrote to it before its fsync.
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
+_require_fssum
+
+[ "$FSTYP" = "btrfs" ] && _fixed_by_kernel_commit xxxxxxxxxxxx \
+	"btrfs: do not skip logging new dentries when logging a new name"
+
+_scratch_mkfs >>$seqres.full 2>&1 || _fail "mkfs failed"
+_require_metadata_journaling $SCRATCH_DEV
+_init_flakey
+_mount_flakey
+
+# Create our first test file.
+echo -n > $SCRATCH_MNT/file1
+
+# Persist the file and commit the current transaction.
+_scratch_sync
+
+# Change the file (by writing some data to it for example) and fsync it.
+$XFS_IO_PROG -c "pwrite -S 0xab 0 1000" \
+	     -c "fsync" $SCRATCH_MNT/file1 | _filter_xfs_io
+
+# Create a new directory in the same parent directory as the previous file.
+mkdir $SCRATCH_MNT/dir
+# Add a new file to this new directory.
+echo -n > $SCRATCH_MNT/dir/foo
+
+# Rename the first file, but keeping it in the same parent directory.
+mv $SCRATCH_MNT/file1 $SCRATCH_MNT/file2
+
+# Fsync the parent directory of the first file.
+$XFS_IO_PROG -c "fsync" $SCRATCH_MNT/
+
+# Create a digest of the filesystem's content.
+$FSSUM_PROG -A -f -w $tmp.fssum $SCRATCH_MNT/
+
+# Simulate a power failure and then mount again the filesystem to replay the
+# journal/log.
+_flakey_drop_and_remount
+
+# Verify the filesystem has the same content that it had right before the power
+# failure and after the last fsync.
+$FSSUM_PROG -r $tmp.fssum $SCRATCH_MNT/
+
+_unmount_flakey
+
+# success, all done
+_exit 0
diff --git a/tests/generic/785.out b/tests/generic/785.out
new file mode 100644
index 00000000..b509508b
--- /dev/null
+++ b/tests/generic/785.out
@@ -0,0 +1,4 @@
+QA output created by 785
+wrote 1000/1000 bytes at offset 0
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+OK
-- 
2.47.2


