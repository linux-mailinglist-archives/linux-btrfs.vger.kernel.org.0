Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5212845A601
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 Nov 2021 15:44:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234844AbhKWOsE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 23 Nov 2021 09:48:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238143AbhKWOsE (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 23 Nov 2021 09:48:04 -0500
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BA94C06173E
        for <linux-btrfs@vger.kernel.org>; Tue, 23 Nov 2021 06:44:56 -0800 (PST)
Received: by mail-qk1-x730.google.com with SMTP id d2so21986260qki.12
        for <linux-btrfs@vger.kernel.org>; Tue, 23 Nov 2021 06:44:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PDdlONOAE1h3ZuTeUNBsJs1MthbapZ6EUSv6GscjLgs=;
        b=T1KeWjmMH7HnX4teXNG1yWgxcS9LI2/SJZask7FJjCwq0ySy/Pj/TZHVk5/MfcQRWr
         SGaEsX+JQ33buda2dcecyBnW+7R4GsfM1BuywHDvXSawTUqGtPnOZkaptD35ZTTgR8uB
         zCFdTsMr42z1q68iqGI4LNYg9B2uYy0Y1l4EWKZWb3LJiBv953PTXPYPtS6CckmCFCKc
         uDFtjJtudvuGXbc/MXi/MCwYOa5G3YDHZKTC1uLiFEQYGwRBPIlo5KjpecpAyQLrUPZ0
         lL5kRO31yYEFYzl6hg5MEtA//ujO1JETiVfWY+KEjPPbUTnI79hfyTQXADY8KE18pexY
         5D2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PDdlONOAE1h3ZuTeUNBsJs1MthbapZ6EUSv6GscjLgs=;
        b=b8L0atssqIU0gDC+VRFFBPZllsZfpEaChfZq1bUrm6PSDEpk0luNuFZWTwHAjycLqL
         QBtPOPAsyhVAvHgwAKG49Ztz1/nr54JZ3hppNUTnPFLJaUJ86eTjVMgUSbS4fZwZQUjB
         efUzgnDZCqQ5yG6D5m247mXJ9wxC5G60MZOMRIs3pQUfsUukvPH2PLZLEakckBz9UfFC
         nvU0KbsS1MPHmHM2VG3SHnY7c99lB2o9gvzZOav6freaEG/fS4z9aFSd7s4cpIRHFVBX
         7uQQmgxeOFK68jVukHyPHrI8414/tSgc/Fqkosrp2CF9AsCMhCFYsIVUCfSG3WtOkRwS
         67Yw==
X-Gm-Message-State: AOAM532GQm+NKyz+bglTdTSk8xchN3yfJikuJv/KzbQ2+TlQsYMFZCyU
        2dECWuxOA78ETuKlatgi1afRZ92xhEkvlA==
X-Google-Smtp-Source: ABdhPJxrFGaJ0hH1GW1I3ZP5+fvy/4Sv8Xtpl8PfM/KI6S7SQMbPhGX/6Yfco0AE59VndLwfwFeVsA==
X-Received: by 2002:a05:620a:2484:: with SMTP id i4mr5077538qkn.184.1637678695282;
        Tue, 23 Nov 2021 06:44:55 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id r26sm5867444qtm.67.2021.11.23.06.44.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Nov 2021 06:44:54 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, fstests@vger.kernel.org,
        kernel-team@fb.com
Subject: [PATCH] fstests: test normal qgroup operations in a compress friendly way
Date:   Tue, 23 Nov 2021 09:44:53 -0500
Message-Id: <86cf6bb2f19f0681e1b7b9fd88774e517848be04.1637678662.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We fail btrfs/022 with -o compress because we test qgroup limits for one
of the variations.  However this test also tests rescan and a few other
things that pass fine with compression enabled.  Handle this by using
the _require_no_compress helper for btrfs/022, and then creating a new
test that is a copy of 022 without the limit exceed test.  This will
allow us to still be able to test the basic functionality with
compression enabled, and keep us from failing the limit check.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 tests/btrfs/022     |   3 ++
 tests/btrfs/251     | 108 ++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/251.out |   2 +
 3 files changed, 113 insertions(+)
 create mode 100755 tests/btrfs/251
 create mode 100644 tests/btrfs/251.out

diff --git a/tests/btrfs/022 b/tests/btrfs/022
index bfd6ac7f..e126e82a 100755
--- a/tests/btrfs/022
+++ b/tests/btrfs/022
@@ -16,6 +16,9 @@ _supported_fs btrfs
 _require_scratch
 _require_btrfs_qgroup_report
 
+# This test requires specific data usage, skip if we have compression enabled
+_require_no_compress
+
 # Test to make sure we can actually turn it on and it makes sense
 _basic_test()
 {
diff --git a/tests/btrfs/251 b/tests/btrfs/251
new file mode 100755
index 00000000..ba23cdce
--- /dev/null
+++ b/tests/btrfs/251
@@ -0,0 +1,108 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2021 Facebook.  All Rights Reserved.
+#
+# FS QA Test No. 251
+#
+# Test the basic functionality of qgroups except for the limit enforcement,
+# this is just btrfs/022 without the limit check so we can test it with
+# compression enabled.
+#
+. ./common/preamble
+_begin_fstest auto qgroup limit
+
+# Import common functions.
+. ./common/filter
+
+_supported_fs btrfs
+_require_scratch
+_require_btrfs_qgroup_report
+
+# Test to make sure we can actually turn it on and it makes sense
+_basic_test()
+{
+	echo "=== basic test ===" >> $seqres.full
+	_run_btrfs_util_prog subvolume create $SCRATCH_MNT/a
+	_run_btrfs_util_prog quota enable $SCRATCH_MNT/a
+	_run_btrfs_util_prog quota rescan -w $SCRATCH_MNT
+	subvolid=$(_btrfs_get_subvolid $SCRATCH_MNT a)
+	$BTRFS_UTIL_PROG qgroup show $units $SCRATCH_MNT | grep $subvolid >> \
+		$seqres.full 2>&1
+	[ $? -eq 0 ] || _fail "couldn't find our subvols quota group"
+	run_check $FSSTRESS_PROG -d $SCRATCH_MNT/a -w -p 1 -n 2000 \
+		$FSSTRESS_AVOID
+	_run_btrfs_util_prog subvolume snapshot $SCRATCH_MNT/a \
+		$SCRATCH_MNT/b
+
+	# the shared values of both the original subvol and snapshot should
+	# match
+	a_shared=$($BTRFS_UTIL_PROG qgroup show $units $SCRATCH_MNT | grep "0/$subvolid")
+	a_shared=$(echo $a_shared | awk '{ print $2 }')
+	echo "subvol a id=$subvolid" >> $seqres.full
+	subvolid=$(_btrfs_get_subvolid $SCRATCH_MNT b)
+	echo "subvol b id=$subvolid" >> $seqres.full
+	b_shared=$($BTRFS_UTIL_PROG qgroup show $units $SCRATCH_MNT | grep "0/$subvolid")
+	b_shared=$(echo $b_shared | awk '{ print $2 }')
+	$BTRFS_UTIL_PROG qgroup show $units $SCRATCH_MNT >> $seqres.full
+	[ $b_shared -eq $a_shared ] || _fail "shared values don't match"
+}
+
+#enable quotas, do some work, check our values and then rescan and make sure we
+#come up with the same answer
+_rescan_test()
+{
+	echo "=== rescan test ===" >> $seqres.full
+	# first with a blank subvol
+	_run_btrfs_util_prog subvolume create $SCRATCH_MNT/a
+	_run_btrfs_util_prog quota enable $SCRATCH_MNT/a
+	subvolid=$(_btrfs_get_subvolid $SCRATCH_MNT a)
+	run_check $FSSTRESS_PROG -d $SCRATCH_MNT/a -w -p 1 -n 2000 \
+		$FSSTRESS_AVOID
+	sync
+	output=$($BTRFS_UTIL_PROG qgroup show $units $SCRATCH_MNT | grep "0/$subvolid")
+	echo "qgroup values before rescan: $output" >> $seqres.full
+	refer=$(echo $output | awk '{ print $2 }')
+	excl=$(echo $output | awk '{ print $3 }')
+	_run_btrfs_util_prog quota rescan -w $SCRATCH_MNT
+	output=$($BTRFS_UTIL_PROG qgroup show $units $SCRATCH_MNT | grep "0/$subvolid")
+	echo "qgroup values after rescan: $output" >> $seqres.full
+	[ $refer -eq $(echo $output | awk '{ print $2 }') ] || \
+		_fail "reference values don't match after rescan"
+	[ $excl -eq $(echo $output | awk '{ print $3 }') ] || \
+		_fail "exclusive values don't match after rescan"
+}
+
+#basic noexceed limit testing
+_limit_test_noexceed()
+{
+	echo "=== limit not exceed test ===" >> $seqres.full
+	_run_btrfs_util_prog subvolume create $SCRATCH_MNT/a
+	_run_btrfs_util_prog quota enable $SCRATCH_MNT
+	subvolid=$(_btrfs_get_subvolid $SCRATCH_MNT a)
+	_run_btrfs_util_prog qgroup limit 5M 0/$subvolid $SCRATCH_MNT
+	_ddt of=$SCRATCH_MNT/a/file bs=4M count=1 >> $seqres.full 2>&1
+	[ $? -eq 0 ] || _fail "should have been allowed to write"
+}
+
+units=`_btrfs_qgroup_units`
+
+_scratch_mkfs > /dev/null 2>&1
+_scratch_mount
+_basic_test
+_scratch_unmount
+_check_scratch_fs
+
+_scratch_mkfs > /dev/null 2>&1
+_scratch_mount
+_rescan_test
+_scratch_unmount
+_check_scratch_fs
+
+_scratch_mkfs > /dev/null 2>&1
+_scratch_mount
+_limit_test_noexceed
+
+# success, all done
+echo "Silence is golden"
+status=0
+exit
diff --git a/tests/btrfs/251.out b/tests/btrfs/251.out
new file mode 100644
index 00000000..e5cd36a9
--- /dev/null
+++ b/tests/btrfs/251.out
@@ -0,0 +1,2 @@
+QA output created by 251
+Silence is golden
-- 
2.26.3

