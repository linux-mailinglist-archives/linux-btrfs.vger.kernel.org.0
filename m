Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70F4327A1FB
	for <lists+linux-btrfs@lfdr.de>; Sun, 27 Sep 2020 19:15:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726303AbgI0RP2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 27 Sep 2020 13:15:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726255AbgI0RP2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 27 Sep 2020 13:15:28 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76EA2C0613CE;
        Sun, 27 Sep 2020 10:15:28 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id 7so6184120pgm.11;
        Sun, 27 Sep 2020 10:15:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bCB/gR5DCf/duOs2FcxvscpF3biWclepxbmD5HHNBoQ=;
        b=fvaYWIT2/1nVyTBMOd34hdm6YE0a0B2yo9iud5iCajIs4fK3VSs9aSIkU99IJmg0+z
         Ak57wtviiRtBntAEi0Fyf5Zt+X3d5pwByPwm7QUFcToWQfMR2RfEZtVdfTou7PhuhgfC
         DUfiHVNAxTpKkY1r9WSieiOsHvU5G4r/APTVzus2pTrfws0W1jh2zzrxA+gWxhpd1MKu
         D2unhZQenpUInnloccG4ohYrNAyMLU1dFaORWuq9GZhNxEtPFzFrpjaJpJ77EO1IP9L7
         p/GJkzqpFSaCh6uISrPlcbTWHK1GI40vQfTFWxmN8zx1pVR8YGxk/xbj6YAaozepMeAt
         eR3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bCB/gR5DCf/duOs2FcxvscpF3biWclepxbmD5HHNBoQ=;
        b=FhCW8qw/943Orcj0mslyf0jAwBzAYAWobpvK7OMbFq5yA4HMQJ903YDygpikH6bVMZ
         OfDLQQX9c0Q/nHlrnTARB5M6sbQ87QUbSpROV7ufhEQkAFcZju5A1FaEqEYpkgYrMzwO
         fulM0xg8aqmt4mn9n3yW88IXO4WqvgNqPMPkmzyREN2+3wg1nd9BuuEc8ZVRlN+EaCoD
         v2FMylYNrDShhdjGCLQS60jA+9wSic8kNIGeYaVv83n6jGSJtD36JJVah3fXDzhBXhY9
         qJOKb6oxoheD2gG6Ynp6ZMXTlHSf9r/mz6jXiOUD3/SCS3PqdvIQJ6KszFRewMQp3+t/
         AMKw==
X-Gm-Message-State: AOAM531PrPEEdUQo+JUYD1cVzJUWs7HiZIllSoo0wTp/skOj3Mh/5agH
        aFFyoDVtyQCXRKMwJ1oihmk2K5FcQ093Uvho
X-Google-Smtp-Source: ABdhPJzKVDpaGrr0DinRJ0FJU1fKuzykxhYwTFwy1S1ONliPmskXtVTtgwnp5RxXLWtLCQKs4MsqtA==
X-Received: by 2002:a63:5d0e:: with SMTP id r14mr6040901pgb.278.1601226927377;
        Sun, 27 Sep 2020 10:15:27 -0700 (PDT)
Received: from localhost.localdomain ([175.195.128.78])
        by smtp.googlemail.com with ESMTPSA id m188sm8867248pfd.56.2020.09.27.10.15.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2020 10:15:26 -0700 (PDT)
From:   Sidong Yang <realwakka@gmail.com>
To:     linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
Cc:     Sidong Yang <realwakka@gmail.com>, Qu Wenruo <wqu@suse.com>,
        Josef Bacik <josef@toxicpanda.com>, Eryu Guan <guan@eryu.me>
Subject: [PATCH v5] btrfs: Add new test for qgroup assign functionality
Date:   Sun, 27 Sep 2020 17:15:12 +0000
Message-Id: <20200927171512.1253-1-realwakka@gmail.com>
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

Signed-off-by: Sidong Yang <realwakka@gmail.com>
Reviewed-by: Qu Wenruo <wqu@suse.com>
Reviewed-by: Eryu Guan <guan@eryu.me>

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
---
 tests/btrfs/221     | 116 ++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/221.out |   2 +
 tests/btrfs/group   |   1 +
 3 files changed, 119 insertions(+)
 create mode 100755 tests/btrfs/221
 create mode 100644 tests/btrfs/221.out

diff --git a/tests/btrfs/221 b/tests/btrfs/221
new file mode 100755
index 00000000..19b3740b
--- /dev/null
+++ b/tests/btrfs/221
@@ -0,0 +1,116 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2020 Sidong Yang.  All Rights Reserved.
+#
+# FS QA Test 221
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
+	cp --reflink=always "$SCRATCH_MNT"/a/file1 "$SCRATCH_MNT"/b/file1
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
diff --git a/tests/btrfs/221.out b/tests/btrfs/221.out
new file mode 100644
index 00000000..aa4351cd
--- /dev/null
+++ b/tests/btrfs/221.out
@@ -0,0 +1,2 @@
+QA output created by 221
+Silence is golden
diff --git a/tests/btrfs/group b/tests/btrfs/group
index 1b5fa695..cdda38f3 100644
--- a/tests/btrfs/group
+++ b/tests/btrfs/group
@@ -222,3 +222,4 @@
 218 auto quick volume
 219 auto quick volume
 220 auto quick
+221 auto quick qgroup
-- 
2.25.1

