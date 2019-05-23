Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 61AB6273DA
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 May 2019 03:11:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729511AbfEWBLK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 22 May 2019 21:11:10 -0400
Received: from mx2.suse.de ([195.135.220.15]:56318 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727365AbfEWBLK (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 22 May 2019 21:11:10 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 0AA45AD4E;
        Thu, 23 May 2019 01:11:09 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
Subject: [PATCH v2] fstests: btrfs: Validate that balance and qgroups work correctly when balance needs to be resumed on mount
Date:   Thu, 23 May 2019 09:11:01 +0800
Message-Id: <20190523011101.4594-1-wqu@suse.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

There are two regressions related to balance resume:
- Kernel NULL pointer dereference at mount time
  Introduced in v5.0
- Kernel BUG_ON() just after mount
  Introduced in v5.1

The kernel fixes are:
"btrfs: qgroup: Check if @bg is NULL to avoid NULL pointer
 dereference"
"btrfs: reloc: Also queue orphan reloc tree for cleanup to
 avoid BUG_ON()"

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
changelog:
v2:
- Subject change to describe the test case in a more generic way
- Update commit message and comment to avoid ambitious/confusing words
- Add to 'balance' and 'qgroup' groups
---
 tests/btrfs/188     | 92 +++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/188.out |  2 +
 tests/btrfs/group   |  1 +
 3 files changed, 95 insertions(+)
 create mode 100755 tests/btrfs/188
 create mode 100644 tests/btrfs/188.out

diff --git a/tests/btrfs/188 b/tests/btrfs/188
new file mode 100755
index 00000000..e12db87c
--- /dev/null
+++ b/tests/btrfs/188
@@ -0,0 +1,92 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2019 SUSE Linux Products GmbH.  All Rights Reserved.
+#
+# FS QA Test 188
+#
+# A general test to validate that balance and qgroups work correctly when
+# balance needs to be resumed on mount.
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
+. ./common/dmlogwrites
+
+# remove previous $seqres.full before test
+rm -f $seqres.full
+
+# real QA test starts here
+
+# Modify as appropriate.
+_supported_fs btrfs
+_supported_os Linux
+_require_scratch
+# and we need extra device as log device
+_require_log_writes
+
+nr_files=512				# enough metadata to bump tree height
+file_size=2048				# small enough to be inlined
+
+_log_writes_init $SCRATCH_DEV
+_log_writes_mkfs >> $seqres.full 2>&1
+
+_log_writes_mount
+$BTRFS_UTIL_PROG quota enable $SCRATCH_MNT >> $seqres.full
+$BTRFS_UTIL_PROG quota rescan -w $SCRATCH_MNT >> $seqres.full
+
+# Create enough metadata for later balance
+for ((i = 0; i < $nr_files; i++)); do
+	_pwrite_byte 0xcd 0 $file_size $SCRATCH_MNT/file_$i > /dev/null
+done
+
+# Flush delalloc so that balance has work to do.
+sync
+
+# Balance metadata so we will have at least one transaction committed with
+# valid reloc tree, and hopefully another commit with orphan reloc tree.
+$BTRFS_UTIL_PROG balance start -f -m $SCRATCH_MNT >> $seqres.full
+_log_writes_unmount
+_log_writes_remove
+
+cur=$(_log_writes_find_next_fua 0)
+echo "cur=$cur" >> $seqres.full
+while [ ! -z "$cur" ]; do
+	_log_writes_replay_log_range $cur $SCRATCH_DEV >> $seqref.full
+
+	# Test that no crashes happen or any other kind of failure.
+	_scratch_mount
+	_scratch_unmount
+
+	# Don't trigger fsck here, as relocation get paused,
+	# at that transistent state, qgroup number may differ
+	# and cause false alert.
+
+	prev=$cur
+	cur=$(_log_writes_find_next_fua $(($cur + 1)))
+	[ -z "$cur" ] && break
+done
+
+# Now the fs has finished its balance and qgroup should be consistent.
+# Fstest will automatically check the fs and btrfs check will report
+# any qgroup inconsistent if something went wrong.
+
+echo "Silence is golden"
+
+# success, all done
+status=0
+exit
diff --git a/tests/btrfs/188.out b/tests/btrfs/188.out
new file mode 100644
index 00000000..6f23fda0
--- /dev/null
+++ b/tests/btrfs/188.out
@@ -0,0 +1,2 @@
+QA output created by 188
+Silence is golden
diff --git a/tests/btrfs/group b/tests/btrfs/group
index 44ee0dd9..cfad878f 100644
--- a/tests/btrfs/group
+++ b/tests/btrfs/group
@@ -190,3 +190,4 @@
 185 volume
 186 auto quick send volume
 187 auto send dedupe clone balance
+188 auto quick replay balance qgroup
-- 
2.21.0

