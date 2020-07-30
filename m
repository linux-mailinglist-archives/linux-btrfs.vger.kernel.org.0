Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D32B02331E6
	for <lists+linux-btrfs@lfdr.de>; Thu, 30 Jul 2020 14:18:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727797AbgG3MSh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 30 Jul 2020 08:18:37 -0400
Received: from mx2.suse.de ([195.135.220.15]:46600 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726631AbgG3MSh (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 30 Jul 2020 08:18:37 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 1939BAF52;
        Thu, 30 Jul 2020 12:18:48 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
Subject: [PATCH] fstests: btrfs/214: Add test to check if shrink works well with fstrim
Date:   Thu, 30 Jul 2020 20:17:35 +0800
Message-Id: <20200730121735.55389-1-wqu@suse.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

There is a bug in trim code which leads to fstrim accessing beyond
device boundary.

The test case will check if fstrim, then shrink, then fstrim, all of
them works without problem.

The fix is titled "btrfs: trim: fix underflow in trim length to prevent
access beyond device boundary".

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 tests/btrfs/214     | 62 +++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/214.out |  2 ++
 tests/btrfs/group   |  1 +
 3 files changed, 65 insertions(+)
 create mode 100755 tests/btrfs/214
 create mode 100644 tests/btrfs/214.out

diff --git a/tests/btrfs/214 b/tests/btrfs/214
new file mode 100755
index 00000000..6cd9f444
--- /dev/null
+++ b/tests/btrfs/214
@@ -0,0 +1,62 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (C) 2020 SUSE Linux Products GmbH. All Rights Reserved.
+#
+# FS QA Test 214
+#
+# Test if the following workload would cause problem:
+# - fstrim
+# - shrink device
+# - fstrim
+#
+seq=`basename $0`
+seqres=$RESULT_DIR/$seq
+echo "QA output created by $seq"
+
+here=`pwd`
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
+# remove previous $seqres.full before test
+rm -f $seqres.full
+
+# real QA test starts here
+
+# Modify as appropriate.
+_supported_fs btrfs 
+_supported_os Linux
+_require_scratch_size $((5 * 1024 * 1024)) #kB
+_require_fstrim
+
+# Create a 5G fs
+_scratch_mkfs_sized $((5 * 1024 * 1024 * 1024)) >> $seqres.full
+_scratch_mount
+
+# Fstrim to populate the device->alloc_status CHUNK_TRIMMED bits
+$FSTRIM_PROG -v $SCRATCH_MNT >> $seqres.full 2>&1 || \
+	_notrun "FSTRIM not supported"
+
+
+# Shrink the fs to 4G, so the existing CHUNK_TRIMMED bits are beyond
+# device boundary
+$BTRFS_UTIL_PROG filesystem resize 1:-1G "$SCRATCH_MNT" >> $seqres.full
+
+# Do fstrim again to trigger the bug
+$FSTRIM_PROG -v $SCRATCH_MNT >> $seqres.full
+
+echo "Silence is golden"
+
+# success, all done
+status=0
+exit
diff --git a/tests/btrfs/214.out b/tests/btrfs/214.out
new file mode 100644
index 00000000..dafb6086
--- /dev/null
+++ b/tests/btrfs/214.out
@@ -0,0 +1,2 @@
+QA output created by 214
+Silence is golden
diff --git a/tests/btrfs/group b/tests/btrfs/group
index 59e8ecce..e306fea5 100644
--- a/tests/btrfs/group
+++ b/tests/btrfs/group
@@ -216,3 +216,4 @@
 211 auto quick log prealloc
 212 auto balance dangerous
 213 auto quick balance dangerous
+214 auto quick trim dangerous
-- 
2.27.0

