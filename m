Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98BB71DABD4
	for <lists+linux-btrfs@lfdr.de>; Wed, 20 May 2020 09:19:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726439AbgETHTr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 20 May 2020 03:19:47 -0400
Received: from mx2.suse.de ([195.135.220.15]:53766 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726224AbgETHTr (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 20 May 2020 03:19:47 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 05B33B21C;
        Wed, 20 May 2020 07:19:47 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
Subject: [PATCH v2] btrfs: Add a test for dead looping balance after balance cancel
Date:   Wed, 20 May 2020 15:19:38 +0800
Message-Id: <20200520071938.14253-1-wqu@suse.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Test if canceling a running balance can cause later balance to dead
loop.

The ifx is titled "btrfs: relocation: Clear the DEAD_RELOC_TREE bit for
 orphan roots to prevent runaway balance".

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
Changelog:
v2:
- Remove debugging command
---
 tests/btrfs/213     | 65 +++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/213.out |  2 ++
 tests/btrfs/group   |  1 +
 3 files changed, 68 insertions(+)
 create mode 100755 tests/btrfs/213
 create mode 100644 tests/btrfs/213.out

diff --git a/tests/btrfs/213 b/tests/btrfs/213
new file mode 100755
index 00000000..145378cb
--- /dev/null
+++ b/tests/btrfs/213
@@ -0,0 +1,65 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (C) 2020 SUSE Linux Products GmbH. All Rights Reserved.
+#
+# FS QA Test 213
+#
+# Test if canceling a running balance can lead to dead looping balance
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
+# Modify as appropriate.
+_supported_fs btrfs
+_supported_os Linux
+_require_scratch
+_require_command "$KILLALL_PROG" killall
+
+_scratch_mkfs >> $seqres.full
+_scratch_mount
+
+runtime=4
+
+# Create enough IO so that we need around $runtime seconds to relocate it
+dd if=/dev/zero bs=1M of="$SCRATCH_MNT/file" oflag=sync status=none \
+	&> /dev/null &
+dd_pid=$!
+sleep $runtime
+"$KILLALL_PROG" -q dd &> /dev/null
+wait $dd_pid
+
+ps aux >> $seqres.full
+# Now balance should take at least $runtime seconds, we can cancel it at
+# $runtime/2 to ensure a success cancel.
+$BTRFS_UTIL_PROG balance start -d --bg "$SCRATCH_MNT"
+sleep $(($runtime / 2))
+$BTRFS_UTIL_PROG balance cancel "$SCRATCH_MNT"
+
+# Now check if we can finish relocating metadata, which should finish very
+# quickly
+$BTRFS_UTIL_PROG balance start -m "$SCRATCH_MNT" >> $seqres.full
+
+echo "Silence is golden"
+
+# success, all done
+status=0
+exit
diff --git a/tests/btrfs/213.out b/tests/btrfs/213.out
new file mode 100644
index 00000000..bd8f2430
--- /dev/null
+++ b/tests/btrfs/213.out
@@ -0,0 +1,2 @@
+QA output created by 213
+Silence is golden
diff --git a/tests/btrfs/group b/tests/btrfs/group
index 8d65bddd..fe4d5bb3 100644
--- a/tests/btrfs/group
+++ b/tests/btrfs/group
@@ -215,3 +215,4 @@
 210 auto quick qgroup snapshot
 211 auto quick log prealloc
 212 auto balance dangerous
+213 auto fast balance dangerous
-- 
2.26.2

