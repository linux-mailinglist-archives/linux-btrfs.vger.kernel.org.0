Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D228BC2F90
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Oct 2019 11:05:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733210AbfJAJEY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 1 Oct 2019 05:04:24 -0400
Received: from mx2.suse.de ([195.135.220.15]:49554 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727957AbfJAJEY (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 1 Oct 2019 05:04:24 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id BAD0EAD69;
        Tue,  1 Oct 2019 09:04:22 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH v2 2/2] btrfs: Add test for btrfs balance convert functionality
Date:   Tue,  1 Oct 2019 12:04:19 +0300
Message-Id: <20191001090419.22153-2-nborisov@suse.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191001090419.22153-1-nborisov@suse.com>
References: <20191001090419.22153-1-nborisov@suse.com>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Add basic test to ensure btrfs conversion functionality is tested. This test
exercies conversion to all possible types of the data portion. This is sufficient
since from the POV of relocation we are only moving blockgroups. 

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 tests/btrfs/194     | 84 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/194.out |  2 ++
 tests/btrfs/group   |  1 +
 3 files changed, 87 insertions(+)
 create mode 100755 tests/btrfs/194
 create mode 100644 tests/btrfs/194.out

diff --git a/tests/btrfs/194 b/tests/btrfs/194
new file mode 100755
index 000000000000..39b6e0a969c1
--- /dev/null
+++ b/tests/btrfs/194
@@ -0,0 +1,84 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2019 SUSE Linux Products GmbH. All Rights Reserved.
+#
+# FS QA Test 194
+#
+# Test raid profile conversion. It's sufficient to test all dest profiles as 
+# source profiles just rely on being able to read the metadata. 
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
+_require_scratch_dev_pool 4
+
+
+declare -a TEST_VECTORS=(
+# $nr_dev_min:$data:$metadata:$data_convert:$metadata_convert
+"4:single:raid1"
+"4:single:raid0"
+"4:single:raid10"
+"4:single:dup"
+"4:single:raid5"
+"4:single:raid6"
+"2:raid1:single"
+)
+
+run_testcase() {
+	IFS=':' read -ra args <<< $1
+	num_disks=${args[0]}
+	src_type=${args[1]}
+	dst_type=${args[2]}
+
+	_scratch_dev_pool_get $num_disks
+
+	echo "=== Running test: $1 ===" >> $seqres.full 
+
+	_scratch_pool_mkfs -d$src_type >> $seqres.full 2>&1
+	_scratch_mount 
+
+	# Create random filesystem with 20k write ops
+	run_check $FSSTRESS_PROG -d $SCRATCH_MNT -w -n 10000 $FSSTRESS_AVOID
+
+	$BTRFS_UTIL_PROG balance start -f -dconvert=$dst_type $SCRATCH_MNT >> $seqres.full 2>&1
+	[ $? -eq 0 ] || echo "$1: Failed convert"
+
+	$BTRFS_UTIL_PROG scrub start -B $SCRATCH_MNT >>$seqres.full 2>&1
+	[ $? -eq 0 ] || echo "$1: Scrub failed"
+
+	_scratch_unmount
+	_check_btrfs_filesystem $SCRATCH_DEV
+	_scratch_dev_pool_put
+}
+
+for i in "${TEST_VECTORS[@]}"; do 
+	run_testcase $i
+done
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
index b92cb12ca66f..a2c0ad87d0f6 100644
--- a/tests/btrfs/group
+++ b/tests/btrfs/group
@@ -196,3 +196,4 @@
 191 auto quick send dedupe
 192 auto replay snapshot stress
 193 auto quick qgroup enospc limit
+194 auto volume balance
-- 
2.7.4

