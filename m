Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06CF027A16E
	for <lists+linux-btrfs@lfdr.de>; Sun, 27 Sep 2020 16:42:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726358AbgI0OlJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 27 Sep 2020 10:41:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726291AbgI0OlI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 27 Sep 2020 10:41:08 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5753C0613CE;
        Sun, 27 Sep 2020 07:41:08 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id 7so6047950pgm.11;
        Sun, 27 Sep 2020 07:41:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0Rt4eeV/EsYn21GOd4mZh5PWAcOA8mH4BaA3/3LrucE=;
        b=N1ZN1J7cJr7Lpuo2vseGv7tGTmFdQsrLVU2jHETCkYeD0hViUYoAN08elVviPLx2g8
         DJJ5Fukj4fwVhNyL2mbysHDsgwJL3L8pzJV3D1asqydkxq4Q6gCb0uVPBcPycG3KLLhL
         07vQMjZ/KfIl2Br2zxxPjlNEqM487IbkK/9BeK0fg6TYd7sR3xfC5PLKenG2govmfU73
         zaI22Qa2WggD+H7pgIfAleHoekFNM+LbjFtY7wQiUilhEVaR2PY6AAjMaAqbYqruWVc/
         rKt4ZacsBsv7LRkDIb6qdbVB0Ddo9l0l7Ca3nY/OlifclQJbzNWGQgxSup0zDnQlHVRt
         3BCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0Rt4eeV/EsYn21GOd4mZh5PWAcOA8mH4BaA3/3LrucE=;
        b=UXtwVSVtnU3vDS6v5uV2ZtNfvUrwMPDrEtkIlGUkkbQBRw9daCb30T7lPA7k+zp0Lx
         X4KlS8YTbdykUjHckTm4HVNkKwqey83fclx2+yhqKw0Q2E9aNymN2eIVbh9s1fCmc9EH
         BaR8D/jGxaA9cjvkeWVWEQ8GgHTIioQp7xBSKQe0etKtiVFGKf7T9VD1NL5m0v87cqNX
         2y7h6DLnip3e/+jiO6TwAq+FqdYalNXCaLWqKTcb2jfh2unUwHlbyEI4pKm7aqEmZiaM
         JNuBNd6QSMWCipLnFZWFaCs+rgrQP4s15w/YM970sJf8UJ4KRGXKRS0zlBYLMnjYNbV3
         /tzg==
X-Gm-Message-State: AOAM532SR0ktI5USokBsVsql/Xr5Q/aY1o5g2oEgB25DRq7F5TcIfMuz
        TqyYnM2YrTVyKYdamSWXE+Kw5nd6NDQauQ==
X-Google-Smtp-Source: ABdhPJzYqVSla0q8X3+OVlRmKQuEhijOL/qKZjEGbRM174zhRiFuEmSKUSELM+ReHz324AQ8jisZgw==
X-Received: by 2002:a05:6a00:15c1:b029:13e:d13d:a07a with SMTP id o1-20020a056a0015c1b029013ed13da07amr7027619pfu.17.1601217667819;
        Sun, 27 Sep 2020 07:41:07 -0700 (PDT)
Received: from localhost.localdomain ([175.195.128.78])
        by smtp.googlemail.com with ESMTPSA id fw4sm4178261pjb.55.2020.09.27.07.41.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2020 07:41:07 -0700 (PDT)
From:   Sidong Yang <realwakka@gmail.com>
To:     linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
Cc:     Sidong Yang <realwakka@gmail.com>, Qu Wenruo <wqu@suse.com>,
        Josef Bacik <josef@toxicpanda.com>, Eryu Guan <guan@eryu.me>
Subject: [PATCH v4] btrfs: Add new test for qgroup assign functionality
Date:   Sun, 27 Sep 2020 14:40:56 +0000
Message-Id: <20200927144056.1114-1-realwakka@gmail.com>
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

