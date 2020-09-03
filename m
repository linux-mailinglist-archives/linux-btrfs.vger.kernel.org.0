Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B2E525C070
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Sep 2020 13:37:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728713AbgICLgu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 3 Sep 2020 07:36:50 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:55242 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726327AbgICLgD (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 3 Sep 2020 07:36:03 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 083BYvkL067495;
        Thu, 3 Sep 2020 11:35:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=IfHPE+ts1nqR/b1zTYKW4SBk9DCHsmArX3d9aYEecKQ=;
 b=PI9OU564GDpWadhPd44HhZPyXVo2DLOc1/0pp6rmRfl9SFNyAm2sCRsQ6/x8S+kOqcuw
 Rp1Sv9AT7ZuZxLTaLxyngrULAWXvum2oqGF0a90aTc5AwjWCqSEg+rgRJlANOpJqO6iZ
 HEBkPwEsEN8mevNxWn/JE1a44UjZQQ1oOBa0Np/7D31VBO7JDgfKbL9f9KoNTMrEPSg5
 7dlJo+4maRC8v4bM/7WRB0Iqweb1R/qzkgCdvnQi8ZFcrYzRwo2hIMgzn1T43RVr0khC
 7QDUgQaDpcgOESVT7sCZvNO5hKapTzFGq8iZjPJDB1datFNAGLXJOyPa4Ro7mS3FbfzA bA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 337eer875s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 03 Sep 2020 11:35:59 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 083BZOpt027581;
        Thu, 3 Sep 2020 11:35:58 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 3380krmerx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 03 Sep 2020 11:35:58 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 083BZvKX011173;
        Thu, 3 Sep 2020 11:35:57 GMT
Received: from localhost.localdomain (/39.109.231.106)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 03 Sep 2020 04:35:57 -0700
From:   Anand Jain <anand.jain@oracle.com>
To:     fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, nborisov@suse.com
Subject: [PATCH] fstests: btrfs/161: extend the test case to delete seed
Date:   Thu,  3 Sep 2020 19:35:48 +0800
Message-Id: <71d375fd6409806ff919415bb1947f437a404367.1599132513.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1599091832.git.anand.jain@oracle.com>
References: <cover.1599091832.git.anand.jain@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9732 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 adultscore=0
 mlxscore=0 suspectscore=38 malwarescore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009030108
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9732 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 adultscore=0 spamscore=0 mlxscore=0
 phishscore=0 impostorscore=0 mlxlogscore=999 bulkscore=0 suspectscore=38
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009030108
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This test case btrfs/161 does the sprout tests, so after sprout
this patch deletes the seed to verify.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 tests/btrfs/161     | 16 ++++++++++++++--
 tests/btrfs/161.out |  4 ++++
 2 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/tests/btrfs/161 b/tests/btrfs/161
index dfff8b871fa3..feaa7a4de6c2 100755
--- a/tests/btrfs/161
+++ b/tests/btrfs/161
@@ -5,9 +5,13 @@
 # FS QA Test 161
 #
 # seed sprout functionality test
-#  Create a seed device, mount it and, add a new device to create a
-#  sprout filesystem.
+#  Create seed
+#  Create sprout
+#  Delete seed
 #
+# The null kobject free warning is address by the kernel patch
+#   btrfs: initialize sysfs devid and device link for seed device
+
 seq=`basename $0`
 seqres=$RESULT_DIR/$seq
 echo "QA output created by $seq"
@@ -64,11 +68,19 @@ create_sprout()
 	run_check _mount $dev_sprout $SCRATCH_MNT
 	echo -- sprout --
 	od -x $SCRATCH_MNT/foobar
+}
+
+delete_seed()
+{
+	$BTRFS_UTIL_PROG device delete $dev_seed $SCRATCH_MNT
+	echo -- seed removed --
+	od -x $SCRATCH_MNT/foobar
 	_scratch_unmount
 }
 
 create_seed
 create_sprout
+delete_seed
 
 _scratch_dev_pool_put
 
diff --git a/tests/btrfs/161.out b/tests/btrfs/161.out
index 363b8217f45c..0fe9c128dcde 100644
--- a/tests/btrfs/161.out
+++ b/tests/btrfs/161.out
@@ -7,3 +7,7 @@ QA output created by 161
 0000000 abab abab abab abab abab abab abab abab
 *
 1000000
+-- seed removed --
+0000000 abab abab abab abab abab abab abab abab
+*
+1000000
-- 
2.25.1

