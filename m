Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DD3A28A5E3
	for <lists+linux-btrfs@lfdr.de>; Sun, 11 Oct 2020 08:20:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726685AbgJKGUf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 11 Oct 2020 02:20:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725882AbgJKGUf (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 11 Oct 2020 02:20:35 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B719C0613CE;
        Sat, 10 Oct 2020 23:20:34 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id a200so10526446pfa.10;
        Sat, 10 Oct 2020 23:20:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KBcRdIkSC2vwcAFXSyLPcmONcXV6jKUgHSkyYWfK/uo=;
        b=Xno7MNZA+qHkGAYMM4kGu7JWjThlrAPNxoHXD23zRQk7OAefspSjgb3o7X+ofkkPVb
         k5zU/U0fbrHssChpgxaXC33DlPhOaLf6m1+mmGWQ7zDpI0n6a6txVHzfeBTExuRGs/O2
         KyKGGOUXdH5yASb8eonqAzAwkbYNi2sVebTRrCDE5B6DIfkka07a7v7prkC0N9GF/HTR
         Ah4eskA5lPukAk9NnIPbWlGLEEkD4NhdUvqpcTgLCGb9LQITvsoYLOLh96ORFr9YwFlp
         uNA9KGhsmPjySY9oUouSajkrO2pzu1FurYNV4Hx1ui/fZF/NbIMRMjoRvVESKFjJvTfl
         8BIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KBcRdIkSC2vwcAFXSyLPcmONcXV6jKUgHSkyYWfK/uo=;
        b=W0fcDp4GMa6YkKm1RL1ZommezBLLyWKvGXHqNTdimVmT0NIsjbMMmdPCHwb7QAHHQo
         njqqA+3pRvzrXeKjKd/bAO6DQyRDNVOjCxNIujiObvYeeIouo2iLjGF941/CPwJtU6W2
         gan0fUSHhE8tvM352nN41gpem3wEhRzt9dJE0SGv/nnEcKREXxiZUCN6BRbxT/2MHuIa
         AIP+4X1hUSt/Yk05zR37/O4dxgpWq6T9BaNbujwSLgOrpsstoiyWFGNgfSGt8TCXfTsT
         eL/uaJ1MDBpdCPnL1BiEJDYtzOQGl+UF7ZSYDWs91Z0UVOp6ia2HyimoOb1iz7kbMECv
         r7ow==
X-Gm-Message-State: AOAM532O6nSfxIIi6IsREq6dZkJqSfUSi/BqOipR7AU4eI5Qs58Z3o1t
        sky8U/Du7HmOL17n+L19vbfll3/ajsqwq3vs
X-Google-Smtp-Source: ABdhPJydUGkZCmEvFwZLsWh+ew10QWLeEHPVOX2GueIhVmHzzlksAOHkLuPP+DlW9BkWjHNLo2qP1w==
X-Received: by 2002:a17:90a:7c03:: with SMTP id v3mr13446241pjf.233.1602397232401;
        Sat, 10 Oct 2020 23:20:32 -0700 (PDT)
Received: from localhost.localdomain ([175.195.128.78])
        by smtp.googlemail.com with ESMTPSA id q15sm18563559pjp.26.2020.10.10.23.20.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Oct 2020 23:20:31 -0700 (PDT)
From:   Sidong Yang <realwakka@gmail.com>
To:     linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
Cc:     Sidong Yang <realwakka@gmail.com>, Qu Wenruo <wqu@suse.com>,
        Josef Bacik <josef@toxicpanda.com>, Eryu Guan <guan@eryu.me>
Subject: [PATCH v6] btrfs: Add new test for qgroup assign functionality
Date:   Sun, 11 Oct 2020 06:20:19 +0000
Message-Id: <20201011062019.3798-1-realwakka@gmail.com>
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
---
 tests/btrfs/221     | 116 ++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/221.out |   2 +
 tests/btrfs/group   |   1 +
 3 files changed, 119 insertions(+)
 create mode 100755 tests/btrfs/221
 create mode 100644 tests/btrfs/221.out

diff --git a/tests/btrfs/221 b/tests/btrfs/221
new file mode 100755
index 00000000..9208d762
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

