Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86D7A275A0E
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Sep 2020 16:31:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726652AbgIWOby (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 23 Sep 2020 10:31:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:36920 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726130AbgIWObx (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 23 Sep 2020 10:31:53 -0400
Received: from debian8.Home (bl8-197-74.dsl.telepac.pt [85.241.197.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 490CD206FB;
        Wed, 23 Sep 2020 14:31:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600871513;
        bh=lU6OwE4eUEWFBbVwJKucIgejPd7mWnmPcUWGfOplYzQ=;
        h=From:To:Cc:Subject:Date:From;
        b=c2Cbw2kKMmXEsIhv9rgAh6+5ZY//3AKdHb+oj6p1tnkZswLQfLatrLCryfG0012fS
         xfEui2UwWtrXyM3D/zVtj70sLsWHffjYd1LHkSJXOo1VAMIb257Ql3h4+ICmZ0HVtT
         7gigSKmGpBuAzmlSbkd4majIGf5/CMVZJGtd7IKQ=
From:   fdmanana@kernel.org
To:     fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
Subject: [PATCH] btrfs: test fstrim after doing a device replace
Date:   Wed, 23 Sep 2020 15:31:47 +0100
Message-Id: <a8f27095c014466444a70b77810ba826df68e623.1600870988.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

Test that after replacing a device, if we run fstrim against the filesystem
we do not trim/discard allocated chunks in the new device. We verify that
allocated chunks in the new device were not trim/discarded by mounting the
new device only in degraded mode, as this is the easiest way to verify it.

This currently fails on btrfs (since kernel 5.2) and is fixed by a patch
that has the following subject:

  "btrfs: fix filesystem corruption after a device replace"

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 tests/btrfs/223     | 71 +++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/223.out |  7 +++++
 tests/btrfs/group   |  1 +
 3 files changed, 79 insertions(+)
 create mode 100755 tests/btrfs/223
 create mode 100644 tests/btrfs/223.out

diff --git a/tests/btrfs/223 b/tests/btrfs/223
new file mode 100755
index 00000000..d8529262
--- /dev/null
+++ b/tests/btrfs/223
@@ -0,0 +1,71 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (C) 2020 SUSE Linux Products GmbH. All Rights Reserved.
+#
+# FS QA Test No. btrfs/223
+#
+# Test that after replacing a device, if we run fstrim against the filesystem
+# we do not trim/discard allocated chunks in the new device. We verify that
+# allocated chunks in the new device were not trim/discarded by mounting the
+# new device only in degraded mode, as this is the easiest way to verify it.
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
+
+# real QA test starts here
+_supported_fs btrfs
+_require_scratch_dev_pool 3
+_require_command "$WIPEFS_PROG" wipefs
+
+rm -f $seqres.full
+
+_scratch_dev_pool_get 2
+_spare_dev_get
+dev1=$(echo $SCRATCH_DEV_POOL | $AWK_PROG '{ print $1 }')
+dev2=$(echo $SCRATCH_DEV_POOL | $AWK_PROG '{ print $2 }')
+
+_scratch_pool_mkfs "-m raid1 -d raid1"
+_scratch_mount
+_require_batched_discard $SCRATCH_MNT
+
+# Add a test file with some data.
+$XFS_IO_PROG -f -c "pwrite -S 0xab 0 10M" $SCRATCH_MNT/foo | _filter_xfs_io
+
+# Replace the first device, $dev1, with a new device.
+$BTRFS_UTIL_PROG replace start -Bf $dev1 $SPARE_DEV $SCRATCH_MNT
+
+# Run fstrim, it should not trim/discard allocated extents in the new device.
+$FSTRIM_PROG $SCRATCH_MNT
+
+# Unmount the filesystem.
+_scratch_unmount
+
+# Mount the filesystem in degraded mode using the new device and verify that the
+# mount succeeds and our file exists, with a size of 10Mb and all its bytes have
+# a value of 0xab.
+$WIPEFS_PROG -a $dev1 $dev2 >> $seqres.full 2>&1
+_mount -o degraded $SPARE_DEV $SCRATCH_MNT
+
+echo "File foo data:"
+od -A d -t x1 $SCRATCH_MNT/foo
+
+_spare_dev_put
+_scratch_dev_pool_put
+
+status=0
+exit
diff --git a/tests/btrfs/223.out b/tests/btrfs/223.out
new file mode 100644
index 00000000..bd570743
--- /dev/null
+++ b/tests/btrfs/223.out
@@ -0,0 +1,7 @@
+QA output created by 223
+wrote 10485760/10485760 bytes at offset 0
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+File foo data:
+0000000 ab ab ab ab ab ab ab ab ab ab ab ab ab ab ab ab
+*
+10485760
diff --git a/tests/btrfs/group b/tests/btrfs/group
index 3b009220..cbf1bb9a 100644
--- a/tests/btrfs/group
+++ b/tests/btrfs/group
@@ -224,3 +224,4 @@
 220 auto quick
 221 auto quick send
 222 auto quick send
+223 auto quick replace trim
-- 
2.28.0

