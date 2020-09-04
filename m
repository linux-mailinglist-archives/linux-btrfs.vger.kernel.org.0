Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5877025D45F
	for <lists+linux-btrfs@lfdr.de>; Fri,  4 Sep 2020 11:13:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729677AbgIDJNk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 4 Sep 2020 05:13:40 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:35648 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726575AbgIDJNk (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 4 Sep 2020 05:13:40 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08494HI1152783;
        Fri, 4 Sep 2020 09:13:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=gJLsj62C/Va2QPe6srseOEZEtvrgb4O5u7/wmvToEmI=;
 b=TZrwZeUX7f3g8JNa/+sfy3WjGd65O/Xd5VzYEOJr8XW2AEBxW+NkbAB4QcyNfIvmykVF
 2AIyZlCmIGm6J/vaQiZZNXWFD8Tl1wgkpUCfNuAF9GBkBZHiTOdWoY4SZ5Vogq2ZCNu1
 h/CyxXZyQWt4v/0GXcKx5eWD1csE5aWCYkHpiMImncxHAxlG+dg4N3ZcOlaxK8qmpV/z
 LYel9J5ot1aGgcR+68unhQP1MFQSc8XuNoVA9CUOVyfSOz6s/qiRXank3SIE1DgkepyZ
 +A1dk4a58YtjuYwgy4tiV1dFT4vcTlkDmkT85M+upC/zUGnE8pq+8FF9wwjmmX3JnJdP Vg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 337eymnehf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 04 Sep 2020 09:13:37 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08499nZ8139996;
        Fri, 4 Sep 2020 09:13:37 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 33b7v27va1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 04 Sep 2020 09:13:37 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0849DZME000741;
        Fri, 4 Sep 2020 09:13:35 GMT
Received: from localhost.localdomain (/39.109.231.106)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 04 Sep 2020 02:13:35 -0700
From:   Anand Jain <anand.jain@oracle.com>
To:     fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, josef@toxicpanda.com
Subject: [PATCH] btrfs: add a test case for btrfs seed device delete
Date:   Fri,  4 Sep 2020 17:13:27 +0800
Message-Id: <3700450aa442d01eedb1da6d02ff9b2f96116b60.1599210586.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <637723ad-d34c-6dde-6837-508ba68bbd42@toxicpanda.com>
References: <637723ad-d34c-6dde-6837-508ba68bbd42@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9733 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 spamscore=0
 mlxlogscore=999 phishscore=0 bulkscore=0 suspectscore=1 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009040086
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9733 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 adultscore=0
 priorityscore=1501 phishscore=0 mlxlogscore=999 mlxscore=0
 lowpriorityscore=0 clxscore=1015 spamscore=0 bulkscore=0 impostorscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009040085
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is a regression test for the issue fixed by the kernel patch
   btrfs: initialize sysfs devid and device link for seed device

In this test case, we verify the seed device delete on a sprouted
filesystem.

This patch also adds a filter to filter the scratch pool devices
without the device path.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 common/filter       | 13 +++++++
 tests/btrfs/219     | 94 +++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/219.out | 39 +++++++++++++++++++
 tests/btrfs/group   |  1 +
 4 files changed, 147 insertions(+)
 create mode 100755 tests/btrfs/219
 create mode 100644 tests/btrfs/219.out

diff --git a/common/filter b/common/filter
index 2477f3860151..7c5f288692e7 100644
--- a/common/filter
+++ b/common/filter
@@ -304,6 +304,19 @@ _filter_testdir_and_scratch()
 	fi
 }
 
+_filter_scratch_pool_short()
+{
+	SHORT=""
+
+	for DEV in $SCRATCH_DEV_POOL
+	do
+		SHORT="$SHORT $(echo $DEV| rev | awk -F / '{print $1}' | rev)"
+	done
+
+	FILTER_STRING=$(echo $SHORT | sed -e 's/\s\+/\\\|/g')
+	sed -e "s,$FILTER_STRING,SCRATCH_DEV,g"
+}
+
 # Turn any device in the scratch pool into SCRATCH_DEV
 _filter_scratch_pool()
 {
diff --git a/tests/btrfs/219 b/tests/btrfs/219
new file mode 100755
index 000000000000..deb2857af004
--- /dev/null
+++ b/tests/btrfs/219
@@ -0,0 +1,94 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2020 Oracle. All Rights Reserved.
+#
+# FS QA Test 219
+#
+# Test for seed device-delete on a sprouted FS.
+# Requires kernel patch
+#    btrfs: initialize sysfs devid and device link for seed device
+#
+# Steps:
+#  Create a seed FS. Add a RW device to make it sprout FS and then delete
+#  the seed device.
+
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
+. ./common/filter.btrfs
+
+# remove previous $seqres.full before test
+rm -f $seqres.full
+
+# real QA test starts here
+
+# Modify as appropriate.
+_supported_fs generic
+_supported_os Linux
+_require_test
+_require_scratch_dev_pool 2
+
+_scratch_dev_pool_get 2
+
+seed=$(echo $SCRATCH_DEV_POOL | awk '{print $1}')
+sprout=$(echo $SCRATCH_DEV_POOL | awk '{print $2}')
+
+_mkfs_dev $seed
+_mount $seed $SCRATCH_MNT
+
+$XFS_IO_PROG -f -d -c "pwrite -S 0xab 0 1M" $SCRATCH_MNT/foo > /dev/null
+_scratch_unmount
+$BTRFS_TUNE_PROG -S 1 $seed
+
+# Mount the seed device and add the rw device
+_mount -o ro $seed $SCRATCH_MNT
+$BTRFS_UTIL_PROG device add -f $sprout $SCRATCH_MNT
+_scratch_unmount
+
+# Now remount
+_mount $sprout $SCRATCH_MNT
+$XFS_IO_PROG -f -d -c "pwrite -S 0xcd 0 1M" $SCRATCH_MNT/bar > /dev/null
+
+echo --- before delete ----
+UUID=$($BTRFS_UTIL_PROG filesystem show -m $SCRATCH_MNT | head -1 | \
+							awk '{print $4}')
+find /sys/fs/btrfs/$UUID/devinfo/ | rev | awk -F /  '{print $1}' | rev
+find /sys/fs/btrfs/$UUID/devices/ | rev | awk -F /  '{print $1}' | rev | \
+						_filter_scratch_pool_short
+echo
+od -x $SCRATCH_MNT/foo
+od -x $SCRATCH_MNT/bar
+
+$BTRFS_UTIL_PROG device delete $seed $SCRATCH_MNT
+_scratch_unmount
+_btrfs_forget_or_module_reload
+_mount $sprout $SCRATCH_MNT
+
+echo --- after delete ----
+find /sys/fs/btrfs/$UUID/devinfo/ | rev | awk -F /  '{print $1}' | rev
+find /sys/fs/btrfs/$UUID/devices/ | rev | awk -F /  '{print $1}' | rev | \
+						_filter_scratch_pool_short
+echo
+od -x $SCRATCH_MNT/foo
+od -x $SCRATCH_MNT/bar
+
+_scratch_dev_pool_put
+
+# success, all done
+status=0
+exit
diff --git a/tests/btrfs/219.out b/tests/btrfs/219.out
new file mode 100644
index 000000000000..6b054ccce95d
--- /dev/null
+++ b/tests/btrfs/219.out
@@ -0,0 +1,39 @@
+QA output created by 219
+--- before delete ----
+
+1
+in_fs_metadata
+replace_target
+writeable
+missing
+2
+in_fs_metadata
+replace_target
+writeable
+missing
+
+SCRATCH_DEV
+SCRATCH_DEV
+
+0000000 abab abab abab abab abab abab abab abab
+*
+4000000
+0000000 cdcd cdcd cdcd cdcd cdcd cdcd cdcd cdcd
+*
+4000000
+--- after delete ----
+
+2
+in_fs_metadata
+replace_target
+writeable
+missing
+
+SCRATCH_DEV
+
+0000000 abab abab abab abab abab abab abab abab
+*
+4000000
+0000000 cdcd cdcd cdcd cdcd cdcd cdcd cdcd cdcd
+*
+4000000
diff --git a/tests/btrfs/group b/tests/btrfs/group
index 3295856d0c8c..3633fa66abe4 100644
--- a/tests/btrfs/group
+++ b/tests/btrfs/group
@@ -221,3 +221,4 @@
 216 auto quick seed
 217 auto quick trim dangerous
 218 auto quick volume
+219 auto quick volume seed
-- 
2.25.1

