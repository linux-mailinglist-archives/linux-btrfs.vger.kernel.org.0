Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCE2C25E420
	for <lists+linux-btrfs@lfdr.de>; Sat,  5 Sep 2020 01:25:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728247AbgIDXZd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 4 Sep 2020 19:25:33 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:42948 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728222AbgIDXZc (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 4 Sep 2020 19:25:32 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 084NPSDM085989;
        Fri, 4 Sep 2020 23:25:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=9OTAy4sU/21plY2WHNOUqrYfzjwcm/BarrkAYF8QnbY=;
 b=Ukk8bdrVYKdGNSW7MyRwEJxSEVDBmhAVtSJuRz7ArYZF4IrAUPKwYWcI5XfeoFnBeQAp
 EruYiCwuUqi2iaLvEhZ8ZS8a3sD3vY3vzar/HjA5vGPOcB3QGCGHvI0EJPF1P+AMwKsi
 2SHA+PGKsqJwBaAUrKdN6Xr5fWxndSGAfNxOW4HxgLZhaqCfjLhqujQDesPjnWH5N7dL
 /LZqETTI4goEMO0cXyRKOrG1gdfyoyceTrijaIEIcq3u370gcu5feHHUN0Nihozvc3qg
 FyIHZSSWlkv0lEqWIVb4ck3ldWLqYp+npcEw3afAOkHSP5TzuVTCoFF3J9e5PkJZTxWz zQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 337eymrrhs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 04 Sep 2020 23:25:28 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 084NPMos022078;
        Fri, 4 Sep 2020 23:25:28 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 3380ku6mdw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 04 Sep 2020 23:25:27 +0000
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 084NPQs8026746;
        Fri, 4 Sep 2020 23:25:26 GMT
Received: from localhost.localdomain (/39.109.231.106)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 04 Sep 2020 16:25:26 -0700
From:   Anand Jain <anand.jain@oracle.com>
To:     fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, dsterba@suse.com
Subject: [PATCH v2 1/2] btrfs: add a test case for btrfs seed device delete
Date:   Sat,  5 Sep 2020 07:25:15 +0800
Message-Id: <53f76be87a0b414d6074f358b45b40cf1419950b.1599233551.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1599233551.git.anand.jain@oracle.com>
References: <cover.1599233551.git.anand.jain@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9734 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 adultscore=0
 mlxscore=0 suspectscore=1 malwarescore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009040197
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9734 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 adultscore=0
 priorityscore=1501 phishscore=0 mlxlogscore=999 mlxscore=0
 lowpriorityscore=0 clxscore=1015 spamscore=0 bulkscore=0 impostorscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009040197
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is a regression test for the issue fixed by the kernel patch
   btrfs: fix put of uninitialized kobject after seed device delete

In this test case, we verify the seed device delete on a sprouted
filesystem.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
v2 drop the sysfs layout check as it breaks the test-case backward
compatibility.

 tests/btrfs/219     | 83 +++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/219.out | 15 ++++++++
 tests/btrfs/group   |  1 +
 3 files changed, 99 insertions(+)
 create mode 100755 tests/btrfs/219
 create mode 100644 tests/btrfs/219.out

diff --git a/tests/btrfs/219 b/tests/btrfs/219
new file mode 100755
index 000000000000..86f2a6991bd7
--- /dev/null
+++ b/tests/btrfs/219
@@ -0,0 +1,83 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2020 Oracle. All Rights Reserved.
+#
+# FS QA Test 219
+#
+# Test for seed device-delete on a sprouted FS.
+# Requires kernel patch
+#    btrfs: fix put of uninitialized kobject after seed device delete
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
+od -x $SCRATCH_MNT/foo
+od -x $SCRATCH_MNT/bar
+
+$BTRFS_UTIL_PROG device delete $seed $SCRATCH_MNT
+_scratch_unmount
+_btrfs_forget_or_module_reload
+_mount $sprout $SCRATCH_MNT
+
+echo --- after delete ----
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
index 000000000000..d39e0d8ffafd
--- /dev/null
+++ b/tests/btrfs/219.out
@@ -0,0 +1,15 @@
+QA output created by 219
+--- before delete ----
+0000000 abab abab abab abab abab abab abab abab
+*
+4000000
+0000000 cdcd cdcd cdcd cdcd cdcd cdcd cdcd cdcd
+*
+4000000
+--- after delete ----
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

