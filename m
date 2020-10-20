Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5702293BB1
	for <lists+linux-btrfs@lfdr.de>; Tue, 20 Oct 2020 14:34:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406161AbgJTMeQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 20 Oct 2020 08:34:16 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:34048 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406160AbgJTMeQ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 20 Oct 2020 08:34:16 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09KCSqU1013455;
        Tue, 20 Oct 2020 12:34:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=ccEiv40ZQrW+Dz4qi6vvKKUTEPCAtNk5roG781WSGis=;
 b=q71OEBg6WUoOJRV+swzh49VinzMRdmGt+QC7+FOImjLs/rtynEf3dNVwlfiwElOohmyj
 2mfWbcptRrSzq5TbBsERmwrhLQkrhx/SyYjpxQpMhJJawn16XEBV8UjF4hDdob6Tl8J2
 PvzUeHaaO5IKW7omVhUknR3XY2qScFFb2TbGR8vZXlmPGrzcYiMyjySJZ4CCbQ5YUMOd
 jqBTprLatnSe0KdUsjodqAoFUNfkWRjlK2GsVKx7jXG419wMZy7+VPm66H7sm+tGTAW3
 okyZshovbwucO1y9RUa+HywDPH/knRxhZEUl2Acd3a5O0TwegB1sCINvw/9WEY7c5BXX yg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 349jrpjr92-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 20 Oct 2020 12:34:14 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09KCVo1v006605;
        Tue, 20 Oct 2020 12:34:14 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 348agxb5ue-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 20 Oct 2020 12:34:13 +0000
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 09KCYDHF027891;
        Tue, 20 Oct 2020 12:34:13 GMT
Received: from localhost.localdomain (/39.109.231.106)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 20 Oct 2020 05:34:10 -0700
From:   Anand Jain <anand.jain@oracle.com>
To:     fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, fdmanana@gmail.com
Subject: [PATCH v3 1/2] btrfs: add a test case for btrfs seed device delete
Date:   Tue, 20 Oct 2020 20:32:56 +0800
Message-Id: <07f630546b05c655fc68c38a695f67176673aa21.1603196609.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1603196609.git.anand.jain@oracle.com>
References: <cover.1603196609.git.anand.jain@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9779 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 phishscore=0
 malwarescore=0 spamscore=0 suspectscore=1 bulkscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010200086
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9779 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 lowpriorityscore=0
 priorityscore=1501 impostorscore=0 adultscore=0 bulkscore=0 malwarescore=0
 mlxlogscore=999 mlxscore=0 spamscore=0 suspectscore=1 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010200086
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is a regression test for the issue fixed by the kernel commit
b5ddcffa3777 (btrfs: fix put of uninitialized kobject after seed device
delete).

In this test case, we verify the seed device delete on a sprouted
filesystem.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
v3: Add commit id for the kernel patch mentioned in the change log and
the header.
    Fix to _supported_fs btrfs
    Drop _supported_os Linux
    Use define AWK_PROG
    Drop the directIO in xfs_io it has no use
    Make it a new test case 225

v2: drop the sysfs layout check as it breaks the test-case backward
compatibility.

 tests/btrfs/225     | 82 +++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/225.out | 15 +++++++++
 tests/btrfs/group   |  1 +
 3 files changed, 98 insertions(+)
 create mode 100755 tests/btrfs/225
 create mode 100644 tests/btrfs/225.out

diff --git a/tests/btrfs/225 b/tests/btrfs/225
new file mode 100755
index 000000000000..730d9645f34c
--- /dev/null
+++ b/tests/btrfs/225
@@ -0,0 +1,82 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2020 Oracle. All Rights Reserved.
+#
+# FS QA Test 225
+#
+# Test for seed device-delete on a sprouted FS.
+# Requires kernel patch
+#    b5ddcffa3777  btrfs: fix put of uninitialized kobject after seed device delete
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
+_supported_fs btrfs
+_require_test
+_require_scratch_dev_pool 2
+
+_scratch_dev_pool_get 2
+
+seed=$(echo $SCRATCH_DEV_POOL | $AWK_PROG '{print $1}')
+sprout=$(echo $SCRATCH_DEV_POOL | $AWK_PROG '{print $2}')
+
+_mkfs_dev $seed
+_mount $seed $SCRATCH_MNT
+
+$XFS_IO_PROG -f -c "pwrite -S 0xab 0 1M" $SCRATCH_MNT/foo > /dev/null
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
+$XFS_IO_PROG -f -c "pwrite -S 0xcd 0 1M" $SCRATCH_MNT/bar > /dev/null
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
diff --git a/tests/btrfs/225.out b/tests/btrfs/225.out
new file mode 100644
index 000000000000..2e5d6ebee2c3
--- /dev/null
+++ b/tests/btrfs/225.out
@@ -0,0 +1,15 @@
+QA output created by 225
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
index 9ad33baa8119..960981e57eb1 100644
--- a/tests/btrfs/group
+++ b/tests/btrfs/group
@@ -226,3 +226,4 @@
 222 auto quick send
 223 auto quick replace trim
 224 auto quick qgroup
+225 auto quick volume seed
-- 
2.25.1

