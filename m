Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94E3C27743C
	for <lists+linux-btrfs@lfdr.de>; Thu, 24 Sep 2020 16:44:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728225AbgIXOoF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 24 Sep 2020 10:44:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728210AbgIXOoF (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 24 Sep 2020 10:44:05 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF80DC0613CE;
        Thu, 24 Sep 2020 07:44:04 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id f1so1762152plo.13;
        Thu, 24 Sep 2020 07:44:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9SyRtT6MD5KPFhAxgoDH0gXgqlVLFpprtBL5T926LdE=;
        b=K9urqHTarSXLjLL5p+jb9vSd9B1MMIdS6PicycZ9P1LfNhtibJZ+nwPZtvPvpRKMID
         64Gt9yFRy6V+bxB1BiVIwefFAJES0PsXAs7k9ljsrlDrbqsHVD/br+xkERdIXL/gueFu
         AfP+nPcDTu7LDySNASSTInjrnZpEptHTJFLtQ4UdfcxMVqC7P70WUeArRedcjVUPhKhs
         lMv78qFxuVIFUECHZZzimZjshYrK0xrxxHPAUM1aGBf+ZNc4dxkqk4vy3WOZS/mBlIS2
         S2SZCAY7OiETQM0ENy7BJp71WRCuIT6FzBZZNIwWzTOfZzGpdQT9VYtjYcLdct/x3hEZ
         Z08Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9SyRtT6MD5KPFhAxgoDH0gXgqlVLFpprtBL5T926LdE=;
        b=i/hB+nA2LvM9hAHb5r35aXa83BeQnfD9Qt49/BX+fuXmtB9SJJ2E7uufV1FQ/iQuM1
         bmiZqjz9Zug65Ny9nFcoFAhOtU/CMu3tmpTY93vOqgmixb7qSGly+MRpwM2aYzGbxsEg
         wVbDYffHPTbMDZOirKbXL883WPWPtdLp/GY5D6rs7uIc8pgG0pdtaexz9ZwfZriHehIe
         LysaeOcG77bLV/d9i4gmpH32JTVgmmoP69wKDNK9Hee+bx4uWsTtJU2FVR6MLbhbtMsq
         lGV+Edfk9zAwLkB0OTdNw3leyf2cgNInQLNDL/GuC7iE0vGvP7QHFQYcTfF6/t7gUHAn
         ccfQ==
X-Gm-Message-State: AOAM531O62dSbLSN9PV+sfVmJ9XdR5D/8SvB/4prP28gZdnu6XX2c0fo
        riMLbv2wPjtH0/SUceVFYhduv/zMJfXFVR5R
X-Google-Smtp-Source: ABdhPJzsemwI6PizWi1J22IyVKqQeduMhIIfaeWNuFZDTxjZJedXrGEa7FYAxxO7BVXyGbR9lPNlIg==
X-Received: by 2002:a17:902:ee83:b029:d0:cb2d:f271 with SMTP id a3-20020a170902ee83b02900d0cb2df271mr4985339pld.10.1600958643862;
        Thu, 24 Sep 2020 07:44:03 -0700 (PDT)
Received: from localhost.localdomain ([175.195.128.78])
        by smtp.googlemail.com with ESMTPSA id w192sm3277828pfd.156.2020.09.24.07.44.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2020 07:44:03 -0700 (PDT)
From:   Sidong Yang <realwakka@gmail.com>
To:     linux-btrfs@vger.kernel.org, fstests@vger.kernel.org,
        Qu Wenruo <wqu@suse.com>
Cc:     Sidong Yang <realwakka@gmail.com>,
        Josef Bacik <josef@toxicpanda.com>, Eryu Guan <guan@eryu.me>
Subject: [PATCH v4] btrfs: Add new test for qgroup assign functionality
Date:   Thu, 24 Sep 2020 14:43:48 +0000
Message-Id: <20200924144348.46203-1-realwakka@gmail.com>
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
---
 tests/btrfs/221     | 116 ++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/221.out |   2 +
 tests/btrfs/group   |   1 +
 3 files changed, 119 insertions(+)
 create mode 100755 tests/btrfs/221
 create mode 100644 tests/btrfs/221.out

diff --git a/tests/btrfs/221 b/tests/btrfs/221
new file mode 100755
index 00000000..6b7c9674
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

