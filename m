Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 710C525E421
	for <lists+linux-btrfs@lfdr.de>; Sat,  5 Sep 2020 01:25:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728258AbgIDXZg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 4 Sep 2020 19:25:36 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:34120 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728222AbgIDXZf (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 4 Sep 2020 19:25:35 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 084NPUTd138765;
        Fri, 4 Sep 2020 23:25:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=04g6Ede1ZPpw9QoXAYdvHObA5/zD/lukGjV1id12ud0=;
 b=f7aGMdYa0D5b+vl1HfNarX1cgbl3HvnK5GltJk460acRkSeWxBsOz6jPpNx9uXOSFym1
 G+wTRHeXmXuks0mGqPdPcT7zc47wWjPU0OQZXnhJzfKs+UlTLFBuYAuaY3ZbqOSP0Z3v
 1RZxbDq9ohvZ+hRwoPIBDTawJnGLO6vpu5vyC6bHwxsDtaRKrsPB11OeO4R+I59M2bY6
 1GGqpoubVd7B8GnPtiU9CtwZbZ4SQWQ6YojRh7Dm5+8WZmWLxZh3C7UTDA7FgLhbbN0w
 HhJho14nBg6XyPqzIMnIG1yTJnfocpNfFvuhq53UtixHZgVOA+UsoXMdA15pEfP0fcIK uw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 337eergv7k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 04 Sep 2020 23:25:30 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 084NPMrf022119;
        Fri, 4 Sep 2020 23:25:29 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 3380ku6mes-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 04 Sep 2020 23:25:29 +0000
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 084NPScj000391;
        Fri, 4 Sep 2020 23:25:28 GMT
Received: from localhost.localdomain (/39.109.231.106)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 04 Sep 2020 16:25:28 -0700
From:   Anand Jain <anand.jain@oracle.com>
To:     fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, dsterba@suse.com
Subject: [PATCH 2/2] btrfs/163: replace sprout instead of seed
Date:   Sat,  5 Sep 2020 07:25:16 +0800
Message-Id: <2378cbf0ec6f649de7269a756b652f0b7a6619b3.1599233551.git.anand.jain@oracle.com>
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
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 adultscore=0 spamscore=0 mlxscore=0
 phishscore=0 impostorscore=0 mlxlogscore=999 bulkscore=0 suspectscore=1
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009040197
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Make this test case inline with the kernel patch [1] changes
[1] btrfs: fix replace of seed device

So use the sprout device as the replace target instead of the seed device.
This change is compatible with the older kernels.

While at this, this patch also fixes a typo fix as well.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
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

