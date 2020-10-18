Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F262291825
	for <lists+linux-btrfs@lfdr.de>; Sun, 18 Oct 2020 17:57:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727086AbgJRP5l (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 18 Oct 2020 11:57:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726961AbgJRP5l (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 18 Oct 2020 11:57:41 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9478C061755;
        Sun, 18 Oct 2020 08:57:40 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id 1so3751978ple.2;
        Sun, 18 Oct 2020 08:57:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=d2rU8jbtrY+VzzmEViWPDkCt5alIWbye72QsLD0DyH0=;
        b=AuZfGEe67y4BwBws9xkxfk3lkjxHibqSV01huBh5WSyIah8620BhqF2LjuQ9zrgEyB
         rdmlAxE5sdSFQEtcQyp5e62x/UO9O7ZZK2ESViAGGy05eTRE5YUZY+3G9FAA8uNL9c7b
         E9KDm/bzJDMwVsu456LxIvG67jTbCbrK7hW3P2+hqiLcC8AiDTZZ0qcwcIXJLNunYJhA
         P7e53NoH40WND24sBYyQJ3RxfO3sKueRgdW0u1l1xpcC+2dGhu0COE+Ule/Cne5gFRg8
         h2CBcptOel9i+KnImZDwEd4a1YWXP2ROZ9Ax3MK9OfmWCQlFqj3Q/9m16WsWyMkGuy0j
         nKkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=d2rU8jbtrY+VzzmEViWPDkCt5alIWbye72QsLD0DyH0=;
        b=lfog9usKue4bsAprNkUODBEdl9MAs2gCvoVu/iqKnX3HV4xsDs0qf7qJoMZCD7KUVn
         puCbSDI64I/c6KF08vA914yzQQ/oVGpkxFLER/c45afQAhAc2+Ix+xwQ36OK0DiiCC9j
         d43lUpkts3JiN1CUHvwS2VdeNqali2Zu47P0NCHFKu4lbG0I2xYjTMboULpgATgtKPZx
         6XEvRxRiXG7cHKIwwkAX2kCOsaeSHwTkLGNvG4GpAmV3T3C0MKCjO8ODRSKjZG5NFKhR
         9MR9cXhQa+akjhnl7yPrPcUdXNWzWZFh2dlljIZAPCkml/8cfrrp8qzj5/3bOu2/t1rE
         c2YQ==
X-Gm-Message-State: AOAM530LteGQdt/EvLGkPK4TafpyQ/CkaaUv3ECuceXgg4ocfPDjg1yT
        X8tpToTSdmcOkunJ3eCRNdUXbhDwcTqB1A==
X-Google-Smtp-Source: ABdhPJx30o3cm+rtsvK5/Da+3cKQ1/q6wxbO5V3qAoyFsZ/mJdaX19mMyy2CG8m0+sod63+uxuQCOg==
X-Received: by 2002:a17:902:222:b029:d3:b4d2:105e with SMTP id 31-20020a1709020222b02900d3b4d2105emr13496044plc.32.1603036659966;
        Sun, 18 Oct 2020 08:57:39 -0700 (PDT)
Received: from localhost.localdomain ([175.195.128.78])
        by smtp.googlemail.com with ESMTPSA id y126sm8818127pgb.40.2020.10.18.08.57.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2020 08:57:39 -0700 (PDT)
From:   Sidong Yang <realwakka@gmail.com>
To:     linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
Cc:     Sidong Yang <realwakka@gmail.com>, Qu Wenruo <wqu@suse.com>,
        Josef Bacik <josef@toxicpanda.com>, Eryu Guan <guan@eryu.me>
Subject: [PATCH v7] btrfs: Add new test for qgroup assign functionality
Date:   Sun, 18 Oct 2020 15:57:28 +0000
Message-Id: <20201018155728.14722-1-realwakka@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This new test will test btrfs's qgroup assign functionality. The
test has 3 cases.

 - assign, no shared extents
 - assign, shared extents
 - snapshot -i, shared extents

Each cases create subvolumes and assign qgroup in their own way
and check with the command "btrfs check".

Cc: Qu Wenruo <wqu@suse.com>
Cc: Eryu Guan <guan@eryu.me>

Signed-off-by: Sidong Yang <realwakka@gmail.com>
---
v2:
 - Create new test and use the cases
v3:
 - Fix some minor mistakes
 - Make that write some data before assign or snapshot in test
 - Put mkfs & mount pair in test function
v4:
 - Add rescan command for assign no shared
 - Use _check_scratch_fs for checking
v5:
 - Remove trailing whitespaces
v6:
 - Use _cp_reflink helper
v7:
 - Change test number to 224 for rebasing 
---
 tests/btrfs/224     | 116 ++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/224.out |   2 +
 tests/btrfs/group   |   1 +
 3 files changed, 119 insertions(+)
 create mode 100755 tests/btrfs/224
 create mode 100644 tests/btrfs/224.out

diff --git a/tests/btrfs/224 b/tests/btrfs/224
new file mode 100755
index 00000000..e17d5bac
--- /dev/null
+++ b/tests/btrfs/224
@@ -0,0 +1,116 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2020 Sidong Yang.  All Rights Reserved.
+#
+# FS QA Test 224
+#
+# Test the assign functionality of qgroups
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
+. ./common/reflink
+
+# remove previous $seqres.full before test
+rm -f $seqres.full
+
+# real QA test starts here
+
+# Modify as appropriate.
+_supported_fs btrfs
+_supported_os Linux
+
+_require_scratch
+_require_btrfs_qgroup_report
+_require_cp_reflink
+
+# Test assign qgroup for submodule with shared extents by reflink
+assign_shared_test()
+{
+	_scratch_mkfs > /dev/null 2>&1
+	_scratch_mount
+
+	echo "=== qgroup assign shared test ===" >> $seqres.full
+	$BTRFS_UTIL_PROG quota enable $SCRATCH_MNT
+	$BTRFS_UTIL_PROG quota rescan -w $SCRATCH_MNT >> $seqres.full
+
+	$BTRFS_UTIL_PROG subvolume create $SCRATCH_MNT/a >> $seqres.full
+	$BTRFS_UTIL_PROG subvolume create $SCRATCH_MNT/b >> $seqres.full
+
+	_ddt of="$SCRATCH_MNT"/a/file1 bs=1M count=1 >> $seqres.full 2>&1
+	_cp_reflink "$SCRATCH_MNT"/a/file1 "$SCRATCH_MNT"/b/file1
+
+	$BTRFS_UTIL_PROG qgroup create 1/100 $SCRATCH_MNT
+	$BTRFS_UTIL_PROG qgroup assign $SCRATCH_MNT/a 1/100 $SCRATCH_MNT
+	$BTRFS_UTIL_PROG qgroup assign $SCRATCH_MNT/b 1/100 $SCRATCH_MNT
+
+	_scratch_unmount
+	_check_scratch_fs
+}
+
+# Test assign qgroup for submodule without shared extents
+assign_no_shared_test()
+{
+	_scratch_mkfs > /dev/null 2>&1
+	_scratch_mount
+
+	echo "=== qgroup assign no shared test ===" >> $seqres.full
+	$BTRFS_UTIL_PROG quota enable $SCRATCH_MNT
+	$BTRFS_UTIL_PROG quota rescan -w $SCRATCH_MNT >> $seqres.full
+
+	$BTRFS_UTIL_PROG subvolume create $SCRATCH_MNT/a >> $seqres.full
+	$BTRFS_UTIL_PROG subvolume create $SCRATCH_MNT/b >> $seqres.full
+
+	$BTRFS_UTIL_PROG qgroup create 1/100 $SCRATCH_MNT
+	$BTRFS_UTIL_PROG qgroup assign $SCRATCH_MNT/a 1/100 $SCRATCH_MNT
+	$BTRFS_UTIL_PROG qgroup assign $SCRATCH_MNT/b 1/100 $SCRATCH_MNT
+
+	_scratch_unmount
+	_check_scratch_fs
+}
+
+# Test snapshot with assigning qgroup for submodule
+snapshot_test()
+{
+	_scratch_mkfs > /dev/null 2>&1
+	_scratch_mount
+
+	echo "=== qgroup snapshot test ===" >> $seqres.full
+	$BTRFS_UTIL_PROG quota enable $SCRATCH_MNT
+	$BTRFS_UTIL_PROG quota rescan -w $SCRATCH_MNT >> $seqres.full
+
+	$BTRFS_UTIL_PROG subvolume create $SCRATCH_MNT/a >> $seqres.full
+	_ddt of="$SCRATCH_MNT"/a/file1 bs=1M count=1 >> $seqres.full 2>&1
+	subvolid=$(_btrfs_get_subvolid $SCRATCH_MNT a)
+	$BTRFS_UTIL_PROG subvolume snapshot -i 0/$subvolid $SCRATCH_MNT/a $SCRATCH_MNT/b >> $seqres.full
+
+	_scratch_unmount
+	_check_scratch_fs
+}
+
+
+assign_no_shared_test
+
+assign_shared_test
+
+snapshot_test
+
+# success, all done
+echo "Silence is golden"
+status=0
+exit
diff --git a/tests/btrfs/224.out b/tests/btrfs/224.out
new file mode 100644
index 00000000..aa4351cd
--- /dev/null
+++ b/tests/btrfs/224.out
@@ -0,0 +1,2 @@
+QA output created by 221
+Silence is golden
diff --git a/tests/btrfs/group b/tests/btrfs/group
index 96e101ae..9ad33baa 100644
--- a/tests/btrfs/group
+++ b/tests/btrfs/group
@@ -225,3 +225,4 @@
 221 auto quick send
 222 auto quick send
 223 auto quick replace trim
+224 auto quick qgroup
-- 
2.25.1

