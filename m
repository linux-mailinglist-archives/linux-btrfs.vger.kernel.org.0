Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4730C274566
	for <lists+linux-btrfs@lfdr.de>; Tue, 22 Sep 2020 17:36:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726737AbgIVPgj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 22 Sep 2020 11:36:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726566AbgIVPgj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 22 Sep 2020 11:36:39 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3769FC061755;
        Tue, 22 Sep 2020 08:36:39 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d9so12808478pfd.3;
        Tue, 22 Sep 2020 08:36:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+qleegQzhL3aP/thA/lVYXShrxssvhK8yLa+w5r2S/Q=;
        b=ZvNMys0SfEBIIG22u/e5wTpG4pb/P/+Zy88oF9AdcE6ier0melzF/LvMY4fGOr8hI0
         Ifrs3F65hpZtZ6Z7AYyrErW/gQaJvAECeU1jO6K76FO5nCjrsq0kAk+qwxTOQWh0PJPa
         hSYrtzo1HcpHHfFRV5M5boxzK2+IKOfC2FCg744F/yX3zvKdx7lPZgbzoo6gckdo3jpH
         RRapQQhakMGNt6jKUOO3lIUpt4oSTZSQwpli9Q8bKYwVh7rK2JoUdtaeyL0XwrpY3xoM
         pnyfxw5Kssmlt0t644Nw+vkdPjNgxx+DGOyoE0JmAxEdtlVaajoqS2siqE2o6072AGiX
         5qWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+qleegQzhL3aP/thA/lVYXShrxssvhK8yLa+w5r2S/Q=;
        b=IIQzHA+ogbW1hAfnRYqpkRTIhC8VtnHrqGwQlA62gqCLv9pak8bwzPaQ9GBVS2fW6X
         LP2D6iihc4SKXWjlEoyeMFJx8KLTO5awEs90jLCi/g9PJWTNMBm8BsZoJQ8jcbh150Do
         vjJf5AMplTLeaAYAl5a6kqC62VW+SJ2OnqFh6BsFMXaIN02eEMYXypf6txwsd7+f1pID
         Hr/7ZvaN0vjDC5PkOWQ3cb7DL3YqlkUwb/HyF5VjsW6l8y5HgVZQh6yxSaqTHfdEM/xJ
         4FXbolkRshhb2z2mzcwD0LspehhQ+nZ2To36O/ss99TbS7Rew/FiaJaMQKZhevyecRuW
         9X0g==
X-Gm-Message-State: AOAM5306/RVCsFUBjJU1AbqOts9sbnn4XhtN+Vxyg88jwkRhjMmLOqaN
        77gIu6WthvDsLmQIC45n7+RQkkkVEtACge9u
X-Google-Smtp-Source: ABdhPJzsu5XewU04GWOmo2/j2uxkgIoSqDXgXbhyoM711ktHC0pg+/Lx2atgjSNN+k31UDCfdBNryw==
X-Received: by 2002:a17:902:82c3:b029:d2:29fc:bee9 with SMTP id u3-20020a17090282c3b02900d229fcbee9mr5213242plz.72.1600788994927;
        Tue, 22 Sep 2020 08:36:34 -0700 (PDT)
Received: from localhost.localdomain ([175.195.128.78])
        by smtp.googlemail.com with ESMTPSA id n72sm16449582pfd.27.2020.09.22.08.36.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2020 08:36:34 -0700 (PDT)
From:   Sidong Yang <realwakka@gmail.com>
To:     linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
Cc:     Sidong Yang <realwakka@gmail.com>, Qu Wenruo <wqu@suse.com>,
        Josef Bacik <josef@toxicpanda.com>, Eryu Guan <guan@eryu.me>
Subject: [PATCH v2] btrfs: Add new test for qgroup assign functionality
Date:   Tue, 22 Sep 2020 15:36:04 +0000
Message-Id: <20200922153604.10004-1-realwakka@gmail.com>
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
v2: create new test and use the cases
---
 tests/btrfs/221     | 121 ++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/221.out |   2 +
 tests/btrfs/group   |   1 +
 3 files changed, 124 insertions(+)
 create mode 100755 tests/btrfs/221
 create mode 100644 tests/btrfs/221.out

diff --git a/tests/btrfs/221 b/tests/btrfs/221
new file mode 100755
index 00000000..7fe5d78f
--- /dev/null
+++ b/tests/btrfs/221
@@ -0,0 +1,121 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2020 YOUR NAME HERE.  All Rights Reserved.
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
+_supported_fs generic
+_supported_os Linux
+
+_require_test
+_require_scratch
+_require_btrfs_qgroup_report
+_require_cp_reflink
+
+# Test assign qgroup for submodule with shared extents by reflink
+assign_shared_test()
+{
+	echo "=== qgroup assign shared test ===" >> $seqres.full
+	_run_btrfs_util_prog quota enable $SCRATCH_MNT
+	_run_btrfs_util_prog qgroup create 1/100 $SCRATCH_MNT
+
+	_run_btrfs_util_prog subvolume create $SCRATCH_MNT/a
+	subvolid=$(_btrfs_get_subvolid $SCRATCH_MNT a)
+	_run_btrfs_util_prog qgroup assign 0/$subvolid 1/100 $SCRATCH_MNT
+
+	_run_btrfs_util_prog subvolume create $SCRATCH_MNT/b
+	subvolid=$(_btrfs_get_subvolid $SCRATCH_MNT b)
+	_run_btrfs_util_prog qgroup assign 0/$subvolid 1/100 $SCRATCH_MNT
+	_run_btrfs_util_prog quota rescan -w $SCRATCH_MNT
+
+	_ddt of="$SCRATCH_MNT"/a/file1 bs=1M count=1 >> $seqres.full 2>&1
+	cp --reflink=always "$SCRATCH_MNT"/a/file1 "$SCRATCH_MNT"/b/file1 >> $seqres.full 2>&1
+
+	_scratch_unmount
+	_run_btrfs_util_prog check $SCRATCH_DEV
+}
+
+# Test assign qgroup for submodule without shared extents
+assign_no_shared_test()
+{
+	echo "=== qgroup assign no shared test ===" >> $seqres.full
+	_run_btrfs_util_prog quota enable $SCRATCH_MNT
+	_run_btrfs_util_prog qgroup create 1/100 $SCRATCH_MNT
+
+	_run_btrfs_util_prog subvolume create $SCRATCH_MNT/a
+	subvolid=$(_btrfs_get_subvolid $SCRATCH_MNT a)
+	_run_btrfs_util_prog qgroup assign 0/$subvolid 1/100 $SCRATCH_MNT
+
+	_run_btrfs_util_prog subvolume create $SCRATCH_MNT/b
+	subvolid=$(_btrfs_get_subvolid $SCRATCH_MNT b)
+	_run_btrfs_util_prog qgroup assign 0/$subvolid 1/100 $SCRATCH_MNT
+
+	_run_btrfs_util_prog quota rescan -w $SCRATCH_MNT
+	_scratch_unmount
+
+	_run_btrfs_util_prog check $SCRATCH_DEV
+}
+
+# Test snapshot with assigning qgroup for submodule
+snapshot_test()
+{
+	echo "=== qgroup snapshot test ===" >> $seqres.full
+	_run_btrfs_util_prog quota enable $SCRATCH_MNT
+
+	_run_btrfs_util_prog subvolume create $SCRATCH_MNT/a
+	subvolid=$(_btrfs_get_subvolid $SCRATCH_MNT a)
+
+	_run_btrfs_util_prog subvolume snapshot -i 0/$subvolid $SCRATCH_MNT/a $SCRATCH_MNT/b
+	subvolid=$(_btrfs_get_subvolid $SCRATCH_MNT b)
+
+	_run_btrfs_util_prog quota rescan -w $SCRATCH_MNT
+	_scratch_unmount
+
+	_run_btrfs_util_prog check $SCRATCH_DEV
+}
+
+
+_scratch_mkfs > /dev/null 2>&1
+_scratch_mount
+assign_no_shared_test
+
+_scratch_mkfs > /dev/null 2>&1
+_scratch_mount
+assign_shared_test
+
+_scratch_mkfs > /dev/null 2>&1
+_scratch_mount
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

