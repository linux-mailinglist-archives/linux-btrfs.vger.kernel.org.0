Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB02F256EBB
	for <lists+linux-btrfs@lfdr.de>; Sun, 30 Aug 2020 16:42:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727810AbgH3Omy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 30 Aug 2020 10:42:54 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:58780 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727046AbgH3Olv (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 30 Aug 2020 10:41:51 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07UEYmWF032353;
        Sun, 30 Aug 2020 14:41:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=mmGBdWbp84BR4VyFdD3Xjbyuo5UwN16Ot0X5Nupq3lo=;
 b=t2dMN8M6f3WS2zSt+Xh+GQgTXCOW0VEaG9NhePmkKkPwFm7OWNh/eiyjq40IxcYS8XWK
 JFuTujtTebbxKI43hOnUOC9hJS/yYI9+y34FZHm9GV8Ycva/NC2iMu0V5Q6onDIsHOKC
 nH7invZS31T+uYrjjdLxTJdlgV/dmVSfxmhN3eufRnNRkS+UjpcLlGoI3JudtCXm3MLa
 V0HUVk1o1WXKo/Xs4V5538C0zCdx3Z+3whDZyrocwarh5o+OIlkFfMuQTRRbR6VMsOds
 4g54llkzDLSxVRtn9xdbQZvkwYSGbdHDp5uC3hVvVwhHWXDzZLsT1KEXCdH8Fg96SFdx hQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 337eeqk0re-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sun, 30 Aug 2020 14:41:45 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07UEaqEs138894;
        Sun, 30 Aug 2020 14:41:45 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 3380sp0urj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 30 Aug 2020 14:41:45 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 07UEfiFq024971;
        Sun, 30 Aug 2020 14:41:44 GMT
Received: from localhost.localdomain (/39.109.231.106)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sun, 30 Aug 2020 07:41:43 -0700
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Cc:     dsterba@suse.com, josef@toxicpanda.com
Subject: [PATCH] fstests: btrfs/163: replace sprout instead of seed
Date:   Sun, 30 Aug 2020 22:41:07 +0800
Message-Id: <d82dc7d38ac43d88381eaa5260cee3dc9907e810.1598011271.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1598792561.git.anand.jain@oracle.com>
References: <cover.1598792561.git.anand.jain@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9728 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 phishscore=0 malwarescore=0 mlxscore=0 spamscore=0 bulkscore=0
 suspectscore=1 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008300118
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9729 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 adultscore=0 spamscore=0 mlxscore=0
 phishscore=0 impostorscore=0 mlxlogscore=999 bulkscore=0 suspectscore=1
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008300118
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

As of now, this test case replaced the seed device in a sprouted seed
filesystem. However, the kernel doesn't support the replacement of the seed
device yet. And the following kernel patch shall enforce the [1]
unsupportability and returns -EINVAL (error code is the same as in seed
device in a non sprouted filesystem replacement).

[1]
   btrfs: fix replace of seed device

So in this test case instead of seed as replacing target use the sprout
device. As we didn't have any test case which shall test the replacement of
sprout device. So now this case fills the gap.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
I will send this to fstests ML once kernel patch is integrated.

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

