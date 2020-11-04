Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BDCA2A630C
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Nov 2020 12:14:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729362AbgKDLN7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 4 Nov 2020 06:13:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:54300 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729243AbgKDLN6 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 4 Nov 2020 06:13:58 -0500
Received: from debian8.Home (bl8-197-74.dsl.telepac.pt [85.241.197.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AE3FC223BD;
        Wed,  4 Nov 2020 11:13:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604488437;
        bh=HtXdWfFcyRmD3RvV/2gEjC0LEMcnPqdV9QsZoJ3asFc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0x+ZJiQ68LF5oT01cwT14m86puv63Ctl6ljpDbpLXzwCyX71/MSLva8q/jQmBUx/3
         VoOuCIuIVKiNY6mqMQD3YLAxXC1+1IDsyKC1Noyb8oanIZHNZ2YsN9ZsNNcJhxmEbr
         3P6s63bS4SaMdUpmX06am0Uvf1d60QXzlnLRtCSg=
From:   fdmanana@kernel.org
To:     fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
Subject: [PATCH 2/2] generic: test for non-zero used blocks while writing into a file
Date:   Wed,  4 Nov 2020 11:13:53 +0000
Message-Id: <97125f898446b152fd759eba2f2c5963d3daadc0.1604487838.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1604487838.git.fdmanana@suse.com>
References: <cover.1604487838.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

Test that if we keep overwriting an entire file, either with buffered
writes or direct IO writes, the number of used blocks reported by stat(2)
is never zero while the writes and writeback are in progress.

This is motivated by a bug in btrfs and currently fails on btrfs only. It
is fixed a patchset for btrfs that has the following patches:

  btrfs: fix missing delalloc new bit for new delalloc ranges
  btrfs: refactor btrfs_drop_extents() to make it easier to extend
  btrfs: fix race when defragging that leads to unnecessary IO
  btrfs: update the number of bytes used by an inode atomically

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 tests/generic/615     | 77 +++++++++++++++++++++++++++++++++++++++++++
 tests/generic/615.out |  3 ++
 tests/generic/group   |  1 +
 3 files changed, 81 insertions(+)
 create mode 100755 tests/generic/615
 create mode 100644 tests/generic/615.out

diff --git a/tests/generic/615 b/tests/generic/615
new file mode 100755
index 00000000..e392c4a5
--- /dev/null
+++ b/tests/generic/615
@@ -0,0 +1,77 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (C) 2020 SUSE Linux Products GmbH. All Rights Reserved.
+#
+# FS QA Test No. 615
+#
+# Test that if we keep overwriting an entire file, either with buffered writes
+# or direct IO writes, the number of used blocks reported by stat(2) is never
+# zero while the writes and writeback are in progress.
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
+	cd /
+	rm -f $tmp.*
+}
+
+# get standard environment, filters and checks
+. ./common/rc
+. ./common/filter
+
+# real QA test starts here
+_supported_fs generic
+_require_scratch
+_require_odirect
+
+rm -f $seqres.full
+
+stat_loop()
+{
+	trap "wait; exit" SIGTERM
+	local filepath=$1
+	local blocks
+
+	while :; do
+		blocks=$(stat -c %b $filepath)
+		if [ $blocks -eq 0 ]; then
+		    echo "error: stat(2) reported zero blocks"
+		fi
+	done
+}
+
+_scratch_mkfs >>$seqres.full 2>&1
+_scratch_mount
+
+$XFS_IO_PROG -f -s -c "pwrite -b 64K 0 64K" $SCRATCH_MNT/foo >>$seqres.full
+
+stat_loop $SCRATCH_MNT/foo &
+loop_pid=$!
+
+echo "Testing buffered writes"
+
+# Now keep overwriting the entire file, triggering writeback after each write,
+# while another process is calling stat(2) on the file. We expect the number of
+# used blocks reported by stat(2) to be always greater than 0.
+for ((i = 0; i < 5000; i++)); do
+	$XFS_IO_PROG -s -c "pwrite -b 64K 0 64K" $SCRATCH_MNT/foo >>$seqres.full
+done
+
+echo "Testing direct IO writes"
+
+# Now similar to what we did before but for direct IO writes.
+for ((i = 0; i < 5000; i++)); do
+	$XFS_IO_PROG -d -c "pwrite -b 64K 0 64K" $SCRATCH_MNT/foo >>$seqres.full
+done
+
+kill $loop_pid &> /dev/null
+wait
+
+status=0
+exit
diff --git a/tests/generic/615.out b/tests/generic/615.out
new file mode 100644
index 00000000..3b549e96
--- /dev/null
+++ b/tests/generic/615.out
@@ -0,0 +1,3 @@
+QA output created by 615
+Testing buffered writes
+Testing direct IO writes
diff --git a/tests/generic/group b/tests/generic/group
index ab8ae74e..fb3c638c 100644
--- a/tests/generic/group
+++ b/tests/generic/group
@@ -617,3 +617,4 @@
 612 auto quick clone
 613 auto quick encrypt
 614 auto quick rw
+615 auto rw
-- 
2.28.0

