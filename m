Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C291127678E
	for <lists+linux-btrfs@lfdr.de>; Thu, 24 Sep 2020 06:12:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726785AbgIXEMB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 24 Sep 2020 00:12:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726743AbgIXEL7 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 24 Sep 2020 00:11:59 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 255DEC0613CE;
        Wed, 23 Sep 2020 21:11:59 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id bw23so956267pjb.2;
        Wed, 23 Sep 2020 21:11:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6KszFkYnO6TLLQTQ/xebLMP2dSFjPgwF3++rSRfYcEk=;
        b=qHRre3nScrCIWz7tL/GBNdKPCkewMbQonJ3hoE9fHvzhdZWb2jeIs+Fb30Cpfyj0ax
         v2mQaLGYJUDYrKHD4oEQXWmFoPVtkusXv4tvPLC14TnDhuRDZsHM2UGULCtc1g9Ks9LF
         hWdrRnCXdDGzYriP7DJ/eZ2BYzLSHbnDztZm2m2L9f1BQFiVXdrIMDutM0PoxS4z1/Ds
         okKzr9A1txezKfOh8f4VXmA90o+jI8v5jILd3SwMQAgEqB0+tmUuf5X09LfA/0LaoSM2
         EOA4ScoPPsldaj0DzRBUibQ1HRJq+v2JhHRI8sPyAm/2q/f2rxLWuFIsoc0+NhSfwUVg
         6xZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6KszFkYnO6TLLQTQ/xebLMP2dSFjPgwF3++rSRfYcEk=;
        b=cMoOBDW3w3DkFDX3z59JtJ+r1/RHxBHuNZBreto4jDq5dkqrb1ongipWquHSf++gs4
         QVwXSKXWPVo2mZHSFl61g8oHjLljvEQ+ECBu2eo9yRH0QbUaTeQbgzwbHSL62NUSBklu
         VMWzrb4fu98yPDUCuVF6eHLtJMvIzLL6dE17K37sJ4TD3Bcg/LgC0RznSIEOL+3hu9Bs
         /XSMpLKwd3FJh9ZF6PaEVb+tLVvf2leg38QsciwzwO1kx+QFUSYv/2ulUJfAh4M9b8em
         CRbQfG/2gobl0ljuD6C9UOl9DLFA6DZtwspuzZO/qoY03BM+cm4UeYTOpOU/eabB31gl
         dG5w==
X-Gm-Message-State: AOAM533TKyQoKpm3PDw6TKHyt6xbOTuLDOsKKOjT5qhjjEujhJKWZCpb
        se7Wd6BmdV2lpxePAe29geNksiHweCccL08E
X-Google-Smtp-Source: ABdhPJyLmbHokyZ0PUZ9fABv9sgroJ5PO2ppWeZamgm/CX7aa1voes6zuqCSminfZSuUaTX9OQBkpA==
X-Received: by 2002:a17:902:b682:b029:d2:4ca:281e with SMTP id c2-20020a170902b682b02900d204ca281emr2820185pls.13.1600920718280;
        Wed, 23 Sep 2020 21:11:58 -0700 (PDT)
Received: from localhost.localdomain ([175.195.128.78])
        by smtp.googlemail.com with ESMTPSA id 124sm1061334pfd.132.2020.09.23.21.11.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2020 21:11:57 -0700 (PDT)
From:   Sidong Yang <realwakka@gmail.com>
To:     linux-btrfs@vger.kernel.org, fstests@vger.kernel.org,
        Qu Wenruo <wqu@suse.com>
Cc:     Sidong Yang <realwakka@gmail.com>,
        Josef Bacik <josef@toxicpanda.com>, Eryu Guan <guan@eryu.me>
Subject: [PATCH v3] btrfs: Add new test for qgroup assign functionality
Date:   Thu, 24 Sep 2020 04:11:45 +0000
Message-Id: <20200924041146.32577-1-realwakka@gmail.com>
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
---
 tests/btrfs/221     | 118 ++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/221.out |   2 +
 tests/btrfs/group   |   1 +
 3 files changed, 121 insertions(+)
 create mode 100755 tests/btrfs/221
 create mode 100644 tests/btrfs/221.out

diff --git a/tests/btrfs/221 b/tests/btrfs/221
new file mode 100755
index 00000000..71591765
--- /dev/null
+++ b/tests/btrfs/221
@@ -0,0 +1,118 @@
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
+	$BTRFS_UTIL_PROG check $SCRATCH_DEV >> $seqres.full 2>&1
+	[ $? -eq 0 ] || _fail "btrfs check failed"
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
+	$BTRFS_UTIL_PROG qgroup create 1/100 $SCRATCH_MNT
+
+	$BTRFS_UTIL_PROG subvolume create $SCRATCH_MNT/a >> $seqres.full
+	$BTRFS_UTIL_PROG subvolume create $SCRATCH_MNT/b >> $seqres.full
+
+	$BTRFS_UTIL_PROG qgroup assign $SCRATCH_MNT/a 1/100 $SCRATCH_MNT
+	$BTRFS_UTIL_PROG qgroup assign $SCRATCH_MNT/b 1/100 $SCRATCH_MNT
+	_scratch_unmount
+
+	$BTRFS_UTIL_PROG check $SCRATCH_DEV >> $seqres.full 2>&1
+	[ $? -eq 0 ] || _fail "btrfs check failed"
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
+	_scratch_unmount
+
+	$BTRFS_UTIL_PROG check $SCRATCH_DEV >> $seqres.full 2>&1
+	[ $? -eq 0 ] || _fail "btrfs check failed"
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

