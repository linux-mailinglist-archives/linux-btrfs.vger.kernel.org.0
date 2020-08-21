Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A607824D604
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 Aug 2020 15:17:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728786AbgHUNRI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 21 Aug 2020 09:17:08 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:42976 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728550AbgHUNQ6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 21 Aug 2020 09:16:58 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07LDGNJ0061421;
        Fri, 21 Aug 2020 13:16:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2020-01-29; bh=4QXkjcJdnH9zBfaMkOaTDGgo3xa5Mby1y/s0iNMgy0A=;
 b=ACIqSzfySnq87pp4gnT5d/QKVO4kPR2OWphQcUVsSVPq7nEP42n9j0mOWRwi2mwefCPZ
 97Jk1r6dTyj9RPa9Yha8nAUFRHvY5nAkiSnJsR0IHe3VqgUYfYDQ4rS0/gMtk0HZgK/w
 DB2+wJ7S4g3ND0yWjdPD0hzwSz0bs57jTj49k2DsVG1xo9qZdu7wutsPAtcOgsHmFlKF
 c9luZ649zv54Ntfdhne6HvMJodzrz4IuOZxlxVJFJ/Al1WgAl0Sr8Hb8vpPBWoZExLDk
 zEfgL2ffUvck+YHRmLbPkKUKSyowzOsci1lb9P2XMsT3juBJACsRyc02IvkwM/E/wax6 XA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 32x74rp06p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 21 Aug 2020 13:16:56 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07LD95RF116502;
        Fri, 21 Aug 2020 13:16:56 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 32xsn2jchm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 21 Aug 2020 13:16:56 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 07LDGt5a031010;
        Fri, 21 Aug 2020 13:16:55 GMT
Received: from localhost.localdomain (/39.109.231.106)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 21 Aug 2020 13:16:54 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Cc:     josef@toxicpanda.com
Subject: [PATCH RFC] btrfs/163: replace sprout instead of seed
Date:   Fri, 21 Aug 2020 21:15:20 +0800
Message-Id: <d82dc7d38ac43d88381eaa5260cee3dc9907e810.1598011271.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9719 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 bulkscore=0
 mlxlogscore=999 phishscore=0 mlxscore=0 suspectscore=1 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008210121
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9719 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0 mlxlogscore=999
 priorityscore=1501 phishscore=0 spamscore=0 mlxscore=0 adultscore=0
 suspectscore=1 lowpriorityscore=0 bulkscore=0 malwarescore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008210122
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Make this test case inline with the kernel patch [1] changes
[1]
   btrfs: fail replace of seed device

So use the sprout device as the replace target instead of the seed device.
As because the replace seed is not supported any more.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
I will send this to fstests ML once RFC is cleared.

 tests/btrfs/163     | 21 ++++++++++++++++-----
 tests/btrfs/163.out |  5 ++++-
 2 files changed, 20 insertions(+), 6 deletions(-)

diff --git a/tests/btrfs/163 b/tests/btrfs/163
index 24c725afb6b9..354d88502d47 100755
--- a/tests/btrfs/163
+++ b/tests/btrfs/163
@@ -4,11 +4,15 @@
 #
 # FS QA Test 163
 #
-# Test case to verify that a seed device can be replaced
+# Test case to verify that a sprouted device can be replaced
 #  Create a seed device
 #  Create a sprout device
 #  Remount RW
-#  Run device replace on the seed device
+#  Run device replace on the sprout device
+#
+# Depends on the kernel patch
+#   btrfs: fail replace of seed device
+
 seq=`basename $0`
 seqres=$RESULT_DIR/$seq
 echo "QA output created by $seq"
@@ -39,6 +43,7 @@ _supported_fs btrfs
 _supported_os Linux
 _require_command "$BTRFS_TUNE_PROG" btrfstune
 _require_scratch_dev_pool 3
+_require_btrfs_forget_or_module_loadable
 
 _scratch_dev_pool_get 3
 
@@ -52,7 +57,7 @@ create_seed()
 	run_check _mount $dev_seed $SCRATCH_MNT
 	$XFS_IO_PROG -f -d -c "pwrite -S 0xab 0 4M" $SCRATCH_MNT/foobar >\
 		/dev/null
-	echo -- gloden --
+	echo -- golden --
 	od -x $SCRATCH_MNT/foobar
 	_run_btrfs_util_prog filesystem show -m $SCRATCH_MNT
 	_scratch_unmount
@@ -64,22 +69,28 @@ add_sprout()
 {
 	_run_btrfs_util_prog device add -f $dev_sprout $SCRATCH_MNT
 	_run_btrfs_util_prog filesystem show -m $SCRATCH_MNT
+	_mount -o remount,rw $dev_sprout $SCRATCH_MNT
+	$XFS_IO_PROG -f -d -c "pwrite -S 0xcd 0 4M" $SCRATCH_MNT/foobar2 >\
+		/dev/null
 }
 
 replace_seed()
 {
-	_run_btrfs_util_prog replace start -fB $dev_seed $dev_replace_tgt $SCRATCH_MNT
+	_run_btrfs_util_prog replace start -fB $dev_sprout $dev_replace_tgt $SCRATCH_MNT
 	_run_btrfs_util_prog filesystem show -m $SCRATCH_MNT
 	_scratch_unmount
-	run_check _mount $dev_replace_tgt $SCRATCH_MNT
+	_btrfs_forget_or_module_reload
+	run_check _mount -o device=$dev_seed $dev_replace_tgt $SCRATCH_MNT
 	echo -- sprout --
 	od -x $SCRATCH_MNT/foobar
+	od -x $SCRATCH_MNT/foobar2
 	_scratch_unmount
 
 }
 
 seed_is_mountable()
 {
+	_btrfs_forget_or_module_reload
 	run_check _mount $dev_seed $SCRATCH_MNT
 	_run_btrfs_util_prog filesystem show -m $SCRATCH_MNT
 	_scratch_unmount
diff --git a/tests/btrfs/163.out b/tests/btrfs/163.out
index 91f6f5b6f48a..351ef7b040b2 100644
--- a/tests/btrfs/163.out
+++ b/tests/btrfs/163.out
@@ -1,5 +1,5 @@
 QA output created by 163
--- gloden --
+-- golden --
 0000000 abab abab abab abab abab abab abab abab
 *
 20000000
@@ -7,3 +7,6 @@ QA output created by 163
 0000000 abab abab abab abab abab abab abab abab
 *
 20000000
+0000000 cdcd cdcd cdcd cdcd cdcd cdcd cdcd cdcd
+*
+20000000
-- 
2.25.1

