Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F6122A6307
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Nov 2020 12:13:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729136AbgKDLNq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 4 Nov 2020 06:13:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:54178 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726344AbgKDLNp (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 4 Nov 2020 06:13:45 -0500
Received: from debian8.Home (bl8-197-74.dsl.telepac.pt [85.241.197.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2446121556;
        Wed,  4 Nov 2020 11:13:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604488424;
        bh=rgHl1wCbLFW7G9jYHhhzzPLH0vXrYyHOigkIv81RW8Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VL1WjIB5plrGRjf5XV70VkKj9vA5Q4PvnHk0bLwA0CnrKsP/oAtsGvxYpVPA2ljuV
         //+4TIpeBgtZDLVMNNd1Ble0wa8bq0babVLcuxVH1fr42SkH8yFuL2zOAklNE9jrPS
         J3mTljN8zroE1ZZzg+J+bewHuc9B7XW1wxmpHVKY=
From:   fdmanana@kernel.org
To:     fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
Subject: [PATCH 1/2] generic: test number of blocks used by a file after mwrite into a hole
Date:   Wed,  4 Nov 2020 11:13:37 +0000
Message-Id: <289e1444dc95cb86945126b2677ca25879fdb8dd.1604487838.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1604487838.git.fdmanana@suse.com>
References: <cover.1604487838.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

Test that after doing a memory mapped write to an empty file, a call to
stat(2) reports a non-zero number of used blocks.

This is motivated by a bug in btrfs where the number of blocks used does
not change. It currenly fails on btrfs and it is fixed by a patch that
has the following subject:

  "btrfs: fix missing delalloc new bit for new delalloc ranges"

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 tests/generic/614     | 50 +++++++++++++++++++++++++++++++++++++++++++
 tests/generic/614.out |  2 ++
 tests/generic/group   |  1 +
 3 files changed, 53 insertions(+)
 create mode 100755 tests/generic/614
 create mode 100644 tests/generic/614.out

diff --git a/tests/generic/614 b/tests/generic/614
new file mode 100755
index 00000000..80edf9cd
--- /dev/null
+++ b/tests/generic/614
@@ -0,0 +1,50 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (C) 2020 SUSE Linux Products GmbH. All Rights Reserved.
+#
+# FS QA Test No. 614
+#
+# Test that after doing a memory mapped write to an empty file, a call to
+# stat(2) reports a non-zero number of used blocks.
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
+
+rm -f $seqres.full
+
+_scratch_mkfs >>$seqres.full 2>&1
+_scratch_mount
+
+$XFS_IO_PROG -f -c "truncate 64K"      \
+	     -c "mmap -w 0 64K"        \
+	     -c "mwrite -S 0xab 0 64K" \
+	     -c "munmap"               \
+	     $SCRATCH_MNT/foobar | _filter_xfs_io
+
+blocks_used=$(stat -c %b $SCRATCH_MNT/foobar)
+if [ $blocks_used -eq 0 ]; then
+    echo "error: stat(2) reported 0 used blocks"
+fi
+
+echo "Silence is golden"
+
+status=0
+exit
diff --git a/tests/generic/614.out b/tests/generic/614.out
new file mode 100644
index 00000000..3db70236
--- /dev/null
+++ b/tests/generic/614.out
@@ -0,0 +1,2 @@
+QA output created by 614
+Silence is golden
diff --git a/tests/generic/group b/tests/generic/group
index 31057ac8..ab8ae74e 100644
--- a/tests/generic/group
+++ b/tests/generic/group
@@ -616,3 +616,4 @@
 611 auto quick attr
 612 auto quick clone
 613 auto quick encrypt
+614 auto quick rw
-- 
2.28.0

