Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 70A5415A4ED
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Feb 2020 10:35:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728835AbgBLJfV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 12 Feb 2020 04:35:21 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:45216 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728626AbgBLJfU (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 12 Feb 2020 04:35:20 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01C9WenN157848;
        Wed, 12 Feb 2020 09:35:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2020-01-29;
 bh=UZgTeNn3pFfDcQDEzGHX4wvZEumYLpiPqufzcgnzhzM=;
 b=l5rDAAoBXbYSNDm63UQes8gq3pht7ZLMM7TI5meUOEoE56p0rosGjphKpAfWY2WSH5fK
 80LiJOtNL3rFP3zcdoueJWh6eqW6OMsQ3ziQkp6jd++p42G2CMbx1OxiCPXW2aW4k5Jw
 GK9Q5NusirRKKFBFZlG9qNhUciO8Irxkjw8NWgiuPdk5Y+j8dJ3ORivxA0cKthAHEcyR
 ALvIKFmBWPliwgKWNdhOtsTVLgJUto/1c4+tS1LI7zM3zqx2tb3Uy0Tf3OKFgKgczYB7
 gTELIjWgYE9t3oenvEezBRaPeEgwRiVzfZ9gnKWQ9uXxXU4U6mxZy+9/4LmliHX6KRL4 gw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 2y2k88914p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 12 Feb 2020 09:35:19 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01C9WVq2068296;
        Wed, 12 Feb 2020 09:35:18 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 2y26svxrd5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 12 Feb 2020 09:35:18 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 01C9ZIuP015123;
        Wed, 12 Feb 2020 09:35:18 GMT
Received: from tp.localdomain (/39.109.145.141)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 12 Feb 2020 01:35:18 -0800
From:   Anand Jain <anand.jain@oracle.com>
To:     fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2] fstests: btrfs/179 call sync qgroup counts
Date:   Wed, 12 Feb 2020 17:35:09 +0800
Message-Id: <1581500109-22736-1-git-send-email-anand.jain@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9528 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 mlxscore=0
 malwarescore=0 bulkscore=0 spamscore=0 suspectscore=13 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002120076
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9528 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 lowpriorityscore=0
 suspectscore=13 bulkscore=0 phishscore=0 mlxlogscore=999 mlxscore=0
 malwarescore=0 impostorscore=0 clxscore=1015 spamscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002120076
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On some systems btrfs/179 fails because the check finds that there is
difference in the qgroup counts.

So as the intention of the test case is to test any hang like situation
during heavy snapshot create/delete operation with quota enabled, so
make sure the qgroup counts are consistent at the end of the test case,
so to make the check happy.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
v2: Use subvolume sync at the end of the test case.
    Patch title changed.

 tests/btrfs/179 | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/tests/btrfs/179 b/tests/btrfs/179
index 4a24ea419a7e..8795d59c01f8 100755
--- a/tests/btrfs/179
+++ b/tests/btrfs/179
@@ -109,6 +109,15 @@ wait $snapshot_pid
 kill $delete_pid
 wait $delete_pid
 
+# By the async nature of qgroup tree scan and subvolume delete, the latest
+# qgroup counts at the time of umount might not be upto date, if it isn't
+# then the check will report the difference in count. The difference in
+# qgroup counts are anyway updated in the following mount, so it is not a
+# real issue that this test case is trying to verify. So make sure the
+# qgroup counts are in sync before unmount happens.
+
+$BTRFS_UTIL_PROG subvolume sync $SCRATCH_MNT >> $seqres.full
+
 # success, all done
 echo "Silence is golden"
 
-- 
1.8.3.1

