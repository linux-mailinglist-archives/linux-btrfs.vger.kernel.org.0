Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1A055155744
	for <lists+linux-btrfs@lfdr.de>; Fri,  7 Feb 2020 13:01:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726890AbgBGMBr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 7 Feb 2020 07:01:47 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:56782 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726827AbgBGMBq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 7 Feb 2020 07:01:46 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 017Bw32U125576;
        Fri, 7 Feb 2020 12:01:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2020-01-29;
 bh=tw1l+ZIFAhpMXBAv6xGVW3DvVVt52Z9Y7HHZgkdDbdc=;
 b=kqqqeIAHiQWVjg8hgOHGymfuaPTtXb+nILNIXt0sNSKhHUZHPaLRicDQpQNHwRQIHKO3
 C+N9ua5bHIbNJa7FP/3Tx9TP0nq2v9IhGvxw+JFxa7MVqBgfw7EE+6NtU4ydm6WAycZl
 1SQcOVAmHYYcGJMTotrFPb+NQm2T5DWOA3VNSmF2aNpw+d+tBDCw2GOkp2fXocOt0xX3
 u0ew5yBsqu4F2JgedUmcdXQX4L0f0u0lhTnPm/4e2OwAOXIUn0IvLWlzcljALqymFI6A
 cC7rDF4xmuDSQxtr5efsH7XDhYW0Xqbfc8rpU9RtUHZLD5mMrAkt1BMtpzBKLEOySAcf Cw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 2xykbpfkhg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 07 Feb 2020 12:01:45 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 017BweK6058772;
        Fri, 7 Feb 2020 12:01:44 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 2y0mk173na-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 07 Feb 2020 12:01:44 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 017C1iSs001018;
        Fri, 7 Feb 2020 12:01:44 GMT
Received: from tp.wifi.oracle.com (/192.188.170.104)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 07 Feb 2020 04:01:43 -0800
From:   Anand Jain <anand.jain@oracle.com>
To:     fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: [PATCH] fstests: btrfs/179 call quota rescan
Date:   Fri,  7 Feb 2020 20:01:35 +0800
Message-Id: <1581076895-6688-1-git-send-email-anand.jain@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9523 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=13 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2002070094
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9523 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=13 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2002070094
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On some systems btrfs/179 fails as the check finds that there is
difference in the qgroup counts.

By the async nature of qgroup tree scan, the latest qgroup counts at the
time of umount might not be upto date, if it isn't then the check will
report the difference in count. The difference in qgroup counts are anyway
updated in the following mount, so it is not a real issue that this test
case is trying to verify. So make sure the qgroup counts are updated
before unmount happens and make the check happy.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 tests/btrfs/179 | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tests/btrfs/179 b/tests/btrfs/179
index 4a24ea419a7e..74e91841eaa6 100755
--- a/tests/btrfs/179
+++ b/tests/btrfs/179
@@ -109,6 +109,14 @@ wait $snapshot_pid
 kill $delete_pid
 wait $delete_pid
 
+# By the async nature of qgroup tree scan, the latest qgroup counts at the time
+# of umount might not be upto date, if it isn't then the check will report the
+# difference in count. The difference in qgroup counts are anyway updated in the
+# following mount, so it is not a real issue that this test case is trying to
+# verify. So make sure the qgroup counts are updated before unmount happens.
+
+$BTRFS_UTIL_PROG quota rescan -w $SCRATCH_MNT >> $seqres.full
+
 # success, all done
 echo "Silence is golden"
 
-- 
1.8.3.1

