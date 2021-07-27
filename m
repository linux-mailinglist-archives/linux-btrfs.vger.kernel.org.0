Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D2433D732A
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Jul 2021 12:27:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236263AbhG0KZq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 27 Jul 2021 06:25:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:47916 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236186AbhG0KZq (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 27 Jul 2021 06:25:46 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D2E67617E4;
        Tue, 27 Jul 2021 10:25:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627381546;
        bh=vzfJ9FEqcWDsy5agYuNTWuR98wOyWGY4I2rjGKnPBOc=;
        h=From:To:Cc:Subject:Date:From;
        b=S/O9eidOutXUeBT45Tb6qY8850jujqUwvlmH4YbaNIw8fJY3e/eUdSboifb3tvNNG
         338hQ9k86RGyjAbtG71X/Xsm3NaKmwYDP6W92dO6wXMWUFPa7miM1JfCxvS2ctnpRN
         T1uSgbMYNTVdCLyBBm4TVlL09YNnJKKK3IPyByCuRSvkh7vkjV1P1Es9nqepPyrI4U
         CmwZkBgqjwZ6jBL1yi1z9P2juWWM8vRqw/mMXSfTDs9nMBLLM6QoGqB4qgv105zQ/r
         KN21Jhz2+yUJ0/zpmUxzMKwG//zbOkeIvqpRQJe1K26Ar4fr4gXojRG/Ob7vyCbVU4
         qSXP4d+aqaGCg==
From:   fdmanana@kernel.org
To:     fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
Subject: [PATCH] generic: test for file loss after mix of rename, fsync and inode eviction
Date:   Tue, 27 Jul 2021 11:24:59 +0100
Message-Id: <bff6929ef4dd5c94df382bd92019388ddce60456.1627380983.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

Test that if we fsync a directory A, evict A's inode, move one file from
directory A to directory B, fsync some other inode that is not directory
A, B or any inode inside these two directories, and then power fail, the
file that was moved is not lost.

This currently fails on btrfs and is fixed by a patch that has the
following subject:

 "btrfs: fix lost inode on log replay after mix of fsync, rename and inode eviction"

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 tests/generic/640     | 101 ++++++++++++++++++++++++++++++++++++++++++
 tests/generic/640.out |   2 +
 2 files changed, 103 insertions(+)
 create mode 100755 tests/generic/640
 create mode 100644 tests/generic/640.out

diff --git a/tests/generic/640 b/tests/generic/640
new file mode 100755
index 00000000..a9346d5b
--- /dev/null
+++ b/tests/generic/640
@@ -0,0 +1,101 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (C) 2021 SUSE Linux Products GmbH. All Rights Reserved.
+#
+# FSQA Test No. 640
+#
+# Test that if we fsync a directory A, evict A's inode, move one file from
+# directory A to a directory B, fsync some other inode that is not directory A,
+# B or any inode inside these two directories, and then power fail, the file
+# that was moved is not lost.
+#
+. ./common/preamble
+_begin_fstest auto quick log
+
+# Override the default cleanup function.
+_cleanup()
+{
+	_cleanup_flakey
+	cd /
+	rm -f $tmp.*
+}
+
+# Import common functions.
+. ./common/filter
+. ./common/dmflakey
+
+# real QA test starts here
+_supported_fs generic
+_require_scratch
+_require_dm_target flakey
+
+_scratch_mkfs >>$seqres.full 2>&1
+_require_metadata_journaling $SCRATCH_DEV
+_init_flakey
+_mount_flakey
+
+# Create two test directories, one with a file we will rename later.
+mkdir $SCRATCH_MNT/A
+mkdir $SCRATCH_MNT/B
+echo -n "hello world" > $SCRATCH_MNT/A/foo
+
+# Persist everything done so far.
+sync
+
+# Add some new file to directory A and fsync the directory.
+touch $SCRATCH_MNT/A/bar
+$XFS_IO_PROG -c "fsync" $SCRATCH_MNT/A
+
+# Now evict all inodes from memory. To trigger the original problem on btrfs we
+# actually only needed to trigger eviction of A's inode, but there's no simple
+# way to evict a single inode, so evict everything.
+echo 2 > /proc/sys/vm/drop_caches
+
+# Now move file foo from directory A to directory B.
+mv $SCRATCH_MNT/A/foo $SCRATCH_MNT/B/foo
+
+# Now make an fsync to anything except A, B or any file inside them, like for
+# example create a file at the root directory and fsync this new file.
+touch $SCRATCH_MNT/baz
+$XFS_IO_PROG -c "fsync" $SCRATCH_MNT/baz
+
+# Simulate a power failure and then check file foo still exists.
+_flakey_drop_and_remount
+
+# Since file foo was not explicitly fsynced we can not guarantee that, for every
+# filesystem, after replaying the journal/log we have file foo inside directory A
+# or inside directory B. The file must exist however, and can only be found in
+# one of the directories, not on both.
+#
+# At the moment of this writing, on f2fs file foo exists always at A/foo,
+# regardless of the fsync-mode mount option ("-o fsync_mode=posix" or
+# "-o fsync_mode=strict"). On ext4 and xfs it exists at B/foo. It is also
+# supposed to exist at B/foo on btrfs (at the moment it doesn't exist in
+# either directory due to a bug).
+
+foo_in_a=0
+foo_in_b=0
+
+if [ -f $SCRATCH_MNT/A/foo ]; then
+	echo "File foo data: $(cat $SCRATCH_MNT/A/foo)"
+	foo_in_a=1
+fi
+
+if [ -f $SCRATCH_MNT/B/foo ]; then
+	echo "File foo data: $(cat $SCRATCH_MNT/B/foo)"
+	foo_in_b=1
+fi
+
+if [ $foo_in_a -eq 1 ] && [ $foo_in_b -eq 1 ]; then
+	echo "File foo found in A/ and B/"
+elif [ $foo_in_a -eq 0 ] && [ $foo_in_b -eq 0 ]; then
+	echo "File foo is missing"
+fi
+
+# While here, also check that files bar and baz exist.
+[ -f $SCRATCH_MNT/A/bar ] || echo "File A/bar is missing"
+[ -f $SCRATCH_MNT/baz ] || echo "File baz is missing"
+
+_unmount_flakey
+status=0
+exit
diff --git a/tests/generic/640.out b/tests/generic/640.out
new file mode 100644
index 00000000..a19db353
--- /dev/null
+++ b/tests/generic/640.out
@@ -0,0 +1,2 @@
+QA output created by 640
+File foo data: hello world
-- 
2.28.0

