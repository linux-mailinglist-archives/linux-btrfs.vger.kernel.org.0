Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B3AA27DFA9
	for <lists+linux-btrfs@lfdr.de>; Wed, 30 Sep 2020 06:44:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725799AbgI3Eo2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 30 Sep 2020 00:44:28 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:51334 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725372AbgI3Eo1 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 30 Sep 2020 00:44:27 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08U4hgsN106374;
        Wed, 30 Sep 2020 04:44:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=pL4b2ORY//0zhLARhKqFVfcZS6Fa2CI6iKYTsnHCBcU=;
 b=wgF06E2/HoiQGsgsJhriz4BHUxHX2vBN6cYkxu2BHaCkzn7ccDRiReGuKHcd3fTIjXJU
 K3KZ4ldiPBBzzQ1rUCl1B8Esh9EcfwHKy7dG9lQr3moaoP+/k2GMSCYd50uHMsiV4GMb
 4aW0N55UST2JCabu85BDRKV9ctYXhiUQRN1xr8k4MCduFRxDT1IA+sAM0fPNhJvuodwu
 f6mWNTo8f1N49Al70fmUfj6jy6+UFDz41yaFn2GCdfCJTJ+RIn8umjcWqFpZIvCZwlv5
 LprotJLWkcGe+IAtjIVbQPfsxaC42Fma/npqfVc8WTDaooYrIDBsvclhNkAdHijkQh3G kQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 33swkkxe18-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 30 Sep 2020 04:44:25 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08U4eSi5054782;
        Wed, 30 Sep 2020 04:44:25 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 33tfhyhw4f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 30 Sep 2020 04:44:24 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 08U4iOKt022219;
        Wed, 30 Sep 2020 04:44:24 GMT
Received: from localhost.localdomain (/39.109.231.106)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 29 Sep 2020 21:44:23 -0700
From:   Anand Jain <anand.jain@oracle.com>
To:     fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, josef@toxicpanda.com,
        guaneryu@gmail.com, johannes.thumshirn@wdc.com
Subject: [PATCH v2] fstests: btrfs/064 add a comment to the test case header
Date:   Wed, 30 Sep 2020 12:44:16 +0800
Message-Id: <c224d095bf56d5cac6268829d2d285a48aca77e2.1601440484.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <f36fdfad33395cbf99520479b162590935f3cfd1.1601394562.git.anand.jain@oracle.com>
References: <f36fdfad33395cbf99520479b162590935f3cfd1.1601394562.git.anand.jain@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9759 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999 bulkscore=0
 phishscore=0 malwarescore=0 adultscore=0 suspectscore=1 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009300035
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9759 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 phishscore=0
 suspectscore=1 mlxlogscore=999 clxscore=1015 priorityscore=1501
 impostorscore=0 lowpriorityscore=0 bulkscore=0 spamscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009300035
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

It appears that the goal of this case was to test balance and
replace concurrency. But these two operations aren't meant to run
concurrently and the replace failing errors are captured in the
seqres.full output. Which are expected errors. To avoid further
confusion, this patch adds comments. The reason to keep this
test case is at the Link.

Link: https://patchwork.kernel.org/patch/11806307/
Reported-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
v2: 
Instead of removing the test case, add comments to clarify.
Title is changed
 old: fstests: delete btrfs/064 it makes no sens

 tests/btrfs/064 | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/tests/btrfs/064 b/tests/btrfs/064
index 683a69f113bf..ce73acf7872a 100755
--- a/tests/btrfs/064
+++ b/tests/btrfs/064
@@ -4,9 +4,11 @@
 #
 # FSQA Test No. btrfs/064
 #
-# Run btrfs balance and replace operations simultaneously with fsstress
-# running in background.
-#
+# Run btrfs balance and replace operations simultaneously with fsstress running
+# in the background, check with the scrub if all the blocks are ok.
+# Balance and replace operations are mutually exclusive operations they can't
+# run simultaneously. One of them is expected to fail when the other is running.
+
 seq=`basename $0`
 seqres=$RESULT_DIR/$seq
 echo "QA output created by $seq"
@@ -62,6 +64,8 @@ run_test()
 	$FSSTRESS_PROG $args >/dev/null 2>&1 &
 	fsstress_pid=$!
 
+	# Start both balance and replace in the background.
+	# Either balance or replace shall run, the other fails.
 	echo -n "Start balance worker: " >>$seqres.full
 	_btrfs_stress_balance $SCRATCH_MNT >/dev/null 2>&1 &
 	balance_pid=$!
-- 
2.25.1

