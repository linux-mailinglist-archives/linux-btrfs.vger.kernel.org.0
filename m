Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BD731D8D7D
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 May 2020 04:13:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727798AbgESCNh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 18 May 2020 22:13:37 -0400
Received: from mx2.suse.de ([195.135.220.15]:35818 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726302AbgESCNh (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 18 May 2020 22:13:37 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 4053DADC2;
        Tue, 19 May 2020 02:13:38 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
Subject: [PATCH] btrfs: Add a test for leaking root crash at unmount time
Date:   Tue, 19 May 2020 10:13:31 +0800
Message-Id: <20200519021331.14028-1-wqu@suse.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Test if canceled balance could lead to root leakage.
If the kernel has CONFIG_BTRFS_DEBUG compiled, unmount time root leakge
check would detect it, and cause NULL pointer dereference as the pages
of the leaked root is already freed.

The fix is titled "btrfs: relocation: Fix reloc root leakage and the NULL
 pointer reference caused by the leakage".

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 tests/btrfs/212     | 85 +++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/212.out |  2 ++
 tests/btrfs/group   |  1 +
 3 files changed, 88 insertions(+)
 create mode 100755 tests/btrfs/212
 create mode 100644 tests/btrfs/212.out

diff --git a/tests/btrfs/212 b/tests/btrfs/212
new file mode 100755
index 00000000..4f4e177b
--- /dev/null
+++ b/tests/btrfs/212
@@ -0,0 +1,85 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (C) 2020 SUSE Linux Products GmbH. All Rights Reserved.
+#
+# FS QA Test 212
+#
+# Test if unmounting a fs with balance canceled can lead to crash.
+# This needs CONFIG_BTRFS_DEBUG compiled, which includes extra unmount time self-test
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
+	kill $balance_pid &> /dev/null
+	kill $cancel_pid &> /dev/null
+	"$KILLALL_PROG" -q $FSSTRESS_PROG &> /dev/null
+	$BTRFS_UTIL_PROG balance cancel $SCRATCH_MNT &> /dev/null
+	wait
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
+_require_scratch
+_require_command "$KILLALL_PROG" killall
+
+_scratch_mkfs >> $seqres.full
+_scratch_mount
+
+runtime=15
+
+balance_workload()
+{
+	trap "wait; exit" SIGTERM
+	while true; do
+		$BTRFS_UTIL_PROG balance start -f --full $SCRATCH_MNT &> /dev/null
+	done
+}
+
+cancel_workload()
+{
+	trap "wait; exit" SIGTERM
+	while true; do
+		$BTRFS_UTIL_PROG balance cancel $SCRATCH_MNT &> /dev/null
+		sleep 2
+	done
+}
+
+$FSSTRESS_PROG -d $SCRATCH_MNT -w -n 100000  >> $seqres.full 2>/dev/null &
+balance_workload &
+balance_pid=$!
+
+cancel_workload &
+cancel_pid=$!
+
+sleep $runtime
+
+kill $balance_pid
+kill $cancel_pid
+"$KILLALL_PROG" -q $FSSTRESS_PROG &> /dev/null
+$BTRFS_UTIL_PROG balance cancel $SCRATCH_MNT &> /dev/null
+wait
+
+echo "Silence is golden"
+# success, all done
+status=0
+exit
diff --git a/tests/btrfs/212.out b/tests/btrfs/212.out
new file mode 100644
index 00000000..32d11390
--- /dev/null
+++ b/tests/btrfs/212.out
@@ -0,0 +1,2 @@
+QA output created by 212
+Silence is golden
diff --git a/tests/btrfs/group b/tests/btrfs/group
index 66b1beac..8d65bddd 100644
--- a/tests/btrfs/group
+++ b/tests/btrfs/group
@@ -214,3 +214,4 @@
 209 auto quick log
 210 auto quick qgroup snapshot
 211 auto quick log prealloc
+212 auto balance dangerous
-- 
2.26.2

