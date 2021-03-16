Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E57F33D3C0
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Mar 2021 13:23:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230401AbhCPMWm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 16 Mar 2021 08:22:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:38842 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230104AbhCPMWY (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 16 Mar 2021 08:22:24 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1AD8E65010;
        Tue, 16 Mar 2021 12:22:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615897343;
        bh=uwktJNovtA5sR4kSBtFhwHbnw/d5XVDrgl3DcjqiNcs=;
        h=From:To:Cc:Subject:Date:From;
        b=PILWQJDFwGfl4iF+VwG/pLd9u684l6LQqVVfcyE85hmSCMWZ2FJ/LJ8NoVFdG/RGs
         5kHlZ3DOIkTb679ckOrybbWerkXuIMmjyUhpneJyNmwai0ioKM0dIZ40Ek43gfV7s2
         IVqaYJ1q2w3KgBeFgWXMOWwqHMg9ia8lcOK8RmoMRbTj3qSI7gTQGx1Q8dqgbgtCg2
         DHiEPeRNVe6kN9IdvmBmCpBnYyFpZwyv3jvOVW2S+96BJI1Bez/oh1pgpXCQT4az2i
         CJR6nF5yKgks//yXu7+hIxbZRr/pbk8rBlDoMWgrct+eEOZzILHi9GjGugI1PFVX73
         unIycigca7mWg==
From:   fdmanana@kernel.org
To:     fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
Subject: [PATCH v2] btrfs: add test for cases when a dio write has to fallback to a buffered write
Date:   Tue, 16 Mar 2021 12:22:15 +0000
Message-Id: <eb23e76e03b0017715e449ff1021d758f0ad98ec.1615897006.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

Test cases where a direct IO write, with O_DSYNC, can not be done and has
to fallback to a buffered write.

This is motivated by the fact we don't have existing tests for these cases
and in fact we had a regression for one case in the 5.10 kernel. This was
the case when doing a direct IO write, with O_DSYNC, against a file offset
that is not aligned to the filesystem's block size, which resulted in
triggering an assertion failure when btrfs is built with assertions enabled
(CONFIG_BTRFS_ASSERT=y). One openSUSE Tumbleweed user hit this frequently
when using Docker and DB2.

The kernel commit in 5.10 that introduced the regression was commit
0eb79294dbe328 ("btrfs: dio iomap DSYNC workaround")). In kernel 5.11 the
regression fixed, by pure chance, by commit ecfdc08b8cc65d ("btrfs: remove
dio iomap DSYNC workaround"). Since the commit that fixed the bug in 5.11
was dependent on a large patchset, a special and simple fix was added to
the stable kernel 5.10.18 by commit a6703c71153438 ("btrfs: fix crash after
non-aligned direct IO write with O_DSYNC").

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---

V2: Resend and updated changelog.

 tests/btrfs/234     | 64 +++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/234.out | 21 +++++++++++++++
 tests/btrfs/group   |  1 +
 3 files changed, 86 insertions(+)
 create mode 100755 tests/btrfs/234
 create mode 100644 tests/btrfs/234.out

diff --git a/tests/btrfs/234 b/tests/btrfs/234
new file mode 100755
index 00000000..df64e54e
--- /dev/null
+++ b/tests/btrfs/234
@@ -0,0 +1,64 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (C) 2021 SUSE Linux Products GmbH. All Rights Reserved.
+#
+# FS QA Test No. btrfs/234
+#
+# Test cases where a direct IO write, with O_DSYNC, can not be done and has to
+# fallback to a buffered write.
+#
+seq=`basename $0`
+seqres=$RESULT_DIR/$seq
+echo "QA output created by $seq"
+
+tmp=/tmp/$$
+status=1	# failure is the default!
+trap "_cleanup; exit \$status" 0 1 2 3 15
+
+_cleanup()
+{
+	cd /
+	rm -f $tmp.*
+}
+
+# get standard environment, filters and checks
+. ./common/rc
+. ./common/filter
+. ./common/attr
+
+# real QA test starts here
+_supported_fs btrfs
+_require_scratch
+_require_odirect
+_require_chattr c
+
+rm -f $seqres.full
+
+_scratch_mkfs >>$seqres.full 2>&1
+_scratch_mount
+
+# Create a test file with compression enabled (chattr +c).
+touch $SCRATCH_MNT/foo
+$CHATTR_PROG +c $SCRATCH_MNT/foo
+
+# Now do a buffered write to create compressed extents.
+$XFS_IO_PROG -s -c "pwrite -S 0xab -b 1M 0 1M" $SCRATCH_MNT/foo | _filter_xfs_io
+
+# Now do the direct IO write with O_DSYNC into a file range that contains
+# compressed extents. It should fallback to buffered IO and succeed.
+$XFS_IO_PROG -d -s -c "pwrite -S 0xcd 512K 512K" $SCRATCH_MNT/foo | _filter_xfs_io
+
+# Now try doing a direct IO write, with O_DSYNC, for a range that starts with
+# non-aligned offset. It should also fallback to buffered IO and succeed.
+$XFS_IO_PROG -f -d -s -c "pwrite -S 0xef 1111 512K" $SCRATCH_MNT/bar | _filter_xfs_io
+
+# Unmount, mount again, and verify we have the expected data.
+_scratch_cycle_mount
+
+echo "File foo data:"
+od -A d -t x1 $SCRATCH_MNT/foo
+echo "File bar data:"
+od -A d -t x1 $SCRATCH_MNT/bar
+
+status=0
+exit
diff --git a/tests/btrfs/234.out b/tests/btrfs/234.out
new file mode 100644
index 00000000..4504a193
--- /dev/null
+++ b/tests/btrfs/234.out
@@ -0,0 +1,21 @@
+QA output created by 234
+wrote 1048576/1048576 bytes at offset 0
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 524288/524288 bytes at offset 524288
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 524288/524288 bytes at offset 1111
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+File foo data:
+0000000 ab ab ab ab ab ab ab ab ab ab ab ab ab ab ab ab
+*
+0524288 cd cd cd cd cd cd cd cd cd cd cd cd cd cd cd cd
+*
+1048576
+File bar data:
+0000000 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+*
+0001104 00 00 00 00 00 00 00 ef ef ef ef ef ef ef ef ef
+0001120 ef ef ef ef ef ef ef ef ef ef ef ef ef ef ef ef
+*
+0525392 ef ef ef ef ef ef ef
+0525399
diff --git a/tests/btrfs/group b/tests/btrfs/group
index 5214dbdb..6d0c70c0 100644
--- a/tests/btrfs/group
+++ b/tests/btrfs/group
@@ -236,3 +236,4 @@
 231 auto quick clone log replay
 232 auto quick qgroup limit
 233 auto quick subvolume
+234 auto quick compress rw
-- 
2.28.0

