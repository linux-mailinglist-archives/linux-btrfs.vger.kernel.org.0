Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A09C0293BB2
	for <lists+linux-btrfs@lfdr.de>; Tue, 20 Oct 2020 14:34:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406171AbgJTMeX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 20 Oct 2020 08:34:23 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:34112 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406160AbgJTMeX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 20 Oct 2020 08:34:23 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09KCTCV7030421;
        Tue, 20 Oct 2020 12:34:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=ZS4CwhgYwVKJ622blqkQk7o9ZDMdG1GJvoXCkjVyYe4=;
 b=dsegsVC4LniL9dBdYwZUPWCPWY6nMueT8+7wMN4bYjUJzTuuUmy5HprhYYh8LzVVeLT2
 9xvBdDq1CA6xUyBrhEJwvtskQqmf4j34jwR32X2M6cpdtqc2g9ToWZf07YOkin7MsEMS
 X98B8eyXztv4yIBffSpSRTFtYkp/z7vCoO3q0LtpToukuHHWB0/TDGDN/5yiDyXO7caJ
 PYewsKXK56ZbuUPLDH10m3HZto75pKfmwL0PSZDc0xFfHlSOGdFuKL89rWAFcL+Ssqkg
 7KO9YRQUv3r3eHa4I0J5YAnZs5kHJmg4h9N4TfFieaOyqaTlht1qJebXu5kWZnpGnR40 4w== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 349jrpjr9m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 20 Oct 2020 12:34:21 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09KCVnDl006505;
        Tue, 20 Oct 2020 12:34:20 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 348agxb5x9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 20 Oct 2020 12:34:20 +0000
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 09KCYKPs023945;
        Tue, 20 Oct 2020 12:34:20 GMT
Received: from localhost.localdomain (/39.109.231.106)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 20 Oct 2020 05:34:19 -0700
From:   Anand Jain <anand.jain@oracle.com>
To:     fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, fdmanana@gmail.com
Subject: [PATCH v3 2/2] btrfs/163: replace sprout instead of seed
Date:   Tue, 20 Oct 2020 20:32:57 +0800
Message-Id: <da8894afef8f5186ee2876c6a3cff32bd28e8cb6.1603196609.git.anand.jain@oracle.com>
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

Make this test case inline with the kernel patch [1] changes
[1] c6a5d954950c btrfs: fix replace of seed device

So use the sprout device as the replace target instead of the seed device.
This change is compatible with the older kernels.

While at this, this patch also fixes a typo fix as well.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
v3:
  add kernel commit id in the change log and in the header.
  remove directio in xfs_io.
  rename replace_seed() to replace_sprout().

v2:
  none

 tests/btrfs/163     | 25 ++++++++++++++++++-------
 tests/btrfs/163.out |  5 ++++-
 2 files changed, 22 insertions(+), 8 deletions(-)

diff --git a/tests/btrfs/163 b/tests/btrfs/163
index 3047862f9e15..735881c6936e 100755
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
+#   c6a5d954950c btrfs: fail replace of seed device
+
 seq=`basename $0`
 seqres=$RESULT_DIR/$seq
 echo "QA output created by $seq"
@@ -38,6 +42,7 @@ rm -f $seqres.full
 _supported_fs btrfs
 _require_command "$BTRFS_TUNE_PROG" btrfstune
 _require_scratch_dev_pool 3
+_require_btrfs_forget_or_module_loadable
 
 _scratch_dev_pool_get 3
 
@@ -51,7 +56,7 @@ create_seed()
 	run_check _mount $dev_seed $SCRATCH_MNT
 	$XFS_IO_PROG -f -d -c "pwrite -S 0xab 0 4M" $SCRATCH_MNT/foobar >\
 		/dev/null
-	echo -- gloden --
+	echo -- golden --
 	od -x $SCRATCH_MNT/foobar
 	_run_btrfs_util_prog filesystem show -m $SCRATCH_MNT
 	_scratch_unmount
@@ -63,22 +68,28 @@ add_sprout()
 {
 	_run_btrfs_util_prog device add -f $dev_sprout $SCRATCH_MNT
 	_run_btrfs_util_prog filesystem show -m $SCRATCH_MNT
+	_mount -o remount,rw $dev_sprout $SCRATCH_MNT
+	$XFS_IO_PROG -f -c "pwrite -S 0xcd 0 4M" $SCRATCH_MNT/foobar2 >\
+		/dev/null
 }
 
-replace_seed()
+replace_sprout()
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
@@ -86,7 +97,7 @@ seed_is_mountable()
 
 create_seed
 add_sprout
-replace_seed
+replace_sprout
 
 seed_is_mountable
 
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

