Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FB12322E01
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 Feb 2021 16:53:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233488AbhBWPvi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 23 Feb 2021 10:51:38 -0500
Received: from mx2.suse.de ([195.135.220.15]:40606 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233481AbhBWPva (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 23 Feb 2021 10:51:30 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1614095443; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=NgOfg6jWGO7AvvrNSVrFFpdf1zLdYSP5bHa6kdkpCpk=;
        b=TAkbx4hcqF9/9OpnO7y3Bi9981c7lQEsigE2eqH/U1MSENKUxdJ5qOFutNosZHGelHaKMB
        BtkJP5uL8XIMME7IOSq50lxfgmpTXSQ5tU02e2HyOAQzkhVAchu7jiTNgee8Tti5ndIsmE
        E23hMVXRMfq4vmeTA+NrWWXbT9hOsdI=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id A6D67AF23;
        Tue, 23 Feb 2021 15:50:43 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH] btrfs: Add simple stress test when qgroup limits are reached
Date:   Tue, 23 Feb 2021 17:50:42 +0200
Message-Id: <20210223155042.1208106-1-nborisov@suse.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This test uncovered 2 deadlocks with qgroups when their limit was
reached.

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 tests/btrfs/231     | 72 +++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/231.out |  2 ++
 tests/btrfs/group   |  1 +
 3 files changed, 75 insertions(+)
 create mode 100755 tests/btrfs/231
 create mode 100644 tests/btrfs/231.out

diff --git a/tests/btrfs/231 b/tests/btrfs/231
new file mode 100755
index 000000000000..d2026b55485f
--- /dev/null
+++ b/tests/btrfs/231
@@ -0,0 +1,72 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2021 SUSE Linux Products GmbH. All Rights Reserved.
+#
+# FS QA Test 231
+#
+# Test that performing io and exhausting qgroup limit won't deadlock. This
+# exercises issues fixed by the following kernel commits:
+#
+# btrfs: Unlock extents in btrfs_zero_range in case of errors
+# btrfs: Don't flush from btrfs_delayed_inode_reserve_metadata
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
+writer() {
+	while [ 1 ]
+	do
+		args=`_scale_fsstress_args -p 20 -n 1000 $FSSTRESS_AVOID -d $SCRATCH_MNT/stressdir`
+		$FSSTRESS_PROG $args >/dev/null 2>&1
+	done
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
+_supported_fs btrfs
+
+_require_scratch_size $((2 * 1024 * 1024))
+_scratch_mkfs > /dev/null 2>&1
+_scratch_mount
+
+_pwrite_byte 0xcd 0 900m $SCRATCH_MNT/file >> $seqres.full
+# Make sure the data reach disk so later qgroup scan can see it
+sync
+
+$BTRFS_UTIL_PROG quota enable $SCRATCH_MNT
+$BTRFS_UTIL_PROG quota rescan -w $SCRATCH_MNT >> $seqres.full
+# set the limit to 1 g, leaving us just 100mb of slack space
+$BTRFS_UTIL_PROG qgroup limit 1G 0/5 $SCRATCH_MNT
+
+writer &
+writer_pid=$!
+
+# Give time for the background thread to generate some load
+sleep 30
+
+kill $writer_pid
+wait
+
+# success, all done
+echo "Silence is golden"
+status=0
+exit
diff --git a/tests/btrfs/231.out b/tests/btrfs/231.out
new file mode 100644
index 000000000000..a31b87a289bf
--- /dev/null
+++ b/tests/btrfs/231.out
@@ -0,0 +1,2 @@
+QA output created by 231
+Silence is golden
diff --git a/tests/btrfs/group b/tests/btrfs/group
index a7c6598326c4..db3d20fb5bb8 100644
--- a/tests/btrfs/group
+++ b/tests/btrfs/group
@@ -233,3 +233,4 @@
 228 auto quick volume
 229 auto quick send clone
 230 auto quick qgroup limit
+231 auto quick qgroup limit
-- 
2.17.1

