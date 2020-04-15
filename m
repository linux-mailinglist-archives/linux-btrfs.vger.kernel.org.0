Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A5DB1A93AC
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Apr 2020 08:49:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390771AbgDOGt0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 15 Apr 2020 02:49:26 -0400
Received: from mx2.suse.de ([195.135.220.15]:46890 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390686AbgDOGtY (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 15 Apr 2020 02:49:24 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id D65B5AC19;
        Wed, 15 Apr 2020 06:49:21 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
Subject: [PATCH] btrfs: Test snapshot creation with qgroup inherit would mark qgroup inconsistent
Date:   Wed, 15 Apr 2020 14:49:16 +0800
Message-Id: <20200415064916.49958-1-wqu@suse.com>
X-Mailer: git-send-email 2.26.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Test that a new snapshot created with qgroup inherit passed should mark
qgroup numbers inconsistent.

Such inconsistent flag is required to show that we need a qgroup rescan
to make qgroup numbers correct again.

This is unavoidable since snapshot creation with qgroup inherit acts as
snapshot creation + qgroup relationship assign.
See btrfs(5) for why such operation needs qgroup rescan.

This test failed on current kernel, the fix is submitted to the btrfs
mail list titled:
  "btrfs: qgroup: Mark qgroup inconsistent if we're inherting snapshot to a new qgroup"

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 tests/btrfs/210     | 62 +++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/210.out |  2 ++
 tests/btrfs/group   |  1 +
 3 files changed, 65 insertions(+)
 create mode 100755 tests/btrfs/210
 create mode 100644 tests/btrfs/210.out

diff --git a/tests/btrfs/210 b/tests/btrfs/210
new file mode 100755
index 00000000..daa76a87
--- /dev/null
+++ b/tests/btrfs/210
@@ -0,0 +1,62 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (C) 2020 SUSE Linux Products GmbH. All Rights Reserved.
+#
+# FS QA Test 210
+#
+# Test that a new snapshot created with qgroup inherit passed should mark
+# qgroup numbers inconsistent.
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
+_require_scratch
+
+_scratch_mkfs >/dev/null
+_scratch_mount
+
+$BTRFS_UTIL_PROG subvolume create "$SCRATCH_MNT/src" > /dev/null
+_pwrite_byte 0xcd 0 16M "$SCRATCH_MNT/src/file" > /dev/null
+
+# Sync the fs to ensure data written to disk so that they can be accounted
+# by qgroup
+sync
+$BTRFS_UTIL_PROG quota enable "$SCRATCH_MNT"
+$BTRFS_UTIL_PROG quota rescan -w "$SCRATCH_MNT"
+$BTRFS_UTIL_PROG qgroup create 1/0 "$SCRATCH_MNT"
+
+# Create a snapshot with qgroup inherit
+$BTRFS_UTIL_PROG subvolume snapshot -i 1/0 "$SCRATCH_MNT/src" \
+	"$SCRATCH_MNT/snapshot" > /dev/null
+
+echo "Silence is golden"
+# If qgroup is not marked inconsistent automatically, btrfs check would
+# report error.
+
+# success, all done
+status=0
+exit
diff --git a/tests/btrfs/210.out b/tests/btrfs/210.out
new file mode 100644
index 00000000..0d9f3fa0
--- /dev/null
+++ b/tests/btrfs/210.out
@@ -0,0 +1,2 @@
+QA output created by 210
+Silence is golden
diff --git a/tests/btrfs/group b/tests/btrfs/group
index 657ec548..e7255c46 100644
--- a/tests/btrfs/group
+++ b/tests/btrfs/group
@@ -212,3 +212,4 @@
 207 auto rw raid
 208 auto quick subvol
 209 auto quick log
+210 auto quick qgroup snapshot
-- 
2.23.0

