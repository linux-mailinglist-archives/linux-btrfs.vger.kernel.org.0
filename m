Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BC92EBEC84
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Sep 2019 09:26:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729048AbfIZH0j (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 26 Sep 2019 03:26:39 -0400
Received: from mx2.suse.de ([195.135.220.15]:46918 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726521AbfIZH0j (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 26 Sep 2019 03:26:39 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id DDD7FAF30;
        Thu, 26 Sep 2019 07:26:37 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, wqu@suse.com, guaneryu@gmail.com,
        Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH] btrfs: Add regression test for SINGLE profile conversion
Date:   Thu, 26 Sep 2019 10:26:35 +0300
Message-Id: <20190926072635.9310-1-nborisov@suse.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is a regression test for the bug fixed by
'btrfs: Fix a regression which we can't convert to SINGLE profile'

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 tests/btrfs/194     | 52 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/194.out |  2 ++
 tests/btrfs/group   |  1 +
 3 files changed, 55 insertions(+)
 create mode 100755 tests/btrfs/194
 create mode 100644 tests/btrfs/194.out

diff --git a/tests/btrfs/194 b/tests/btrfs/194
new file mode 100755
index 000000000000..8935defd3f5e
--- /dev/null
+++ b/tests/btrfs/194
@@ -0,0 +1,52 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2019 SUSE Linux Products GmbH. All Rights Reserved.
+#
+# FS QA Test 194
+#
+# Test that block groups profile can be converted to SINGLE. This is a regression
+# test for 'btrfs: Fix a regression which we can't convert to SINGLE profile'
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
+_require_scratch_dev_pool 2
+
+_scratch_dev_pool_get 2
+_scratch_pool_mkfs -draid1
+
+_scratch_mount 
+
+$BTRFS_UTIL_PROG balance start -dconvert=single $SCRATCH_MNT > $seqres.full 2>&1
+[ $? -eq 0 ] || _fail "Convert failed"
+
+_scratch_umount
+_scratch_dev_pool_put
+
+echo "Silence is golden"
+status=0
+exit
diff --git a/tests/btrfs/194.out b/tests/btrfs/194.out
new file mode 100644
index 000000000000..7bfd50ffb5a4
--- /dev/null
+++ b/tests/btrfs/194.out
@@ -0,0 +1,2 @@
+QA output created by 194
+Silence is golden
diff --git a/tests/btrfs/group b/tests/btrfs/group
index b92cb12ca66f..6a11eb1b8230 100644
--- a/tests/btrfs/group
+++ b/tests/btrfs/group
@@ -196,3 +196,4 @@
 191 auto quick send dedupe
 192 auto replay snapshot stress
 193 auto quick qgroup enospc limit
+194 auto quick volume balance
-- 
2.7.4

