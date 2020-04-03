Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C465E19CE81
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 Apr 2020 04:11:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390363AbgDCCLM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Apr 2020 22:11:12 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:43634 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390171AbgDCCLL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 2 Apr 2020 22:11:11 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03329gfX009462;
        Fri, 3 Apr 2020 02:11:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2020-01-29;
 bh=2XHtl3IhJhB92O5pRtbnu33kxGpeLmjRIst0x+kXFNg=;
 b=AzlzykdKjgSw8NCYP2l/gxRQh0oZzWEikR6ng3KxPKyV+r8iR5Bxkigd7YlBaQARuRVU
 TEp9KVC35hlCF5uNQ2n92eIbS1Hsq6UbDu8FMFcW8Y0q3GGhR3omTOtLTJcQMArk9o/W
 oAMdK6W59EVEplivTSjDPgt6ViLjqd+Ad83NHSXgzy3ZyxITUyoOrcgk1txvxqGhJO+I
 0oDdR2b/fzEE7YXcmDBcMskeL8NXbZWLh/ERn74z1PHDufAqOG2lAaDHUHKzb9ObzId2
 Hxt+we/giVl4XIj4CA2qRp6tzKa+7M7id5h4NguEQ+mWPLEaNozv84TTN62Egbmlo+FQ 7A== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 303yunh8cq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 03 Apr 2020 02:11:08 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03327GWv087564;
        Fri, 3 Apr 2020 02:11:08 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 304sjr8xgf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 03 Apr 2020 02:11:08 +0000
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0332B7Zv029728;
        Fri, 3 Apr 2020 02:11:07 GMT
Received: from tp.localdomain (/39.109.145.141)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 02 Apr 2020 19:11:07 -0700
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Cc:     dsterba@suse.cz
Subject: [PATCH 3/4] btrfs-progs: test clean start after failures
Date:   Fri,  3 Apr 2020 10:10:42 +0800
Message-Id: <1585879843-17731-4-git-send-email-anand.jain@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1585879843-17731-1-git-send-email-anand.jain@oracle.com>
References: <1585879843-17731-1-git-send-email-anand.jain@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9579 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0 mlxscore=0
 malwarescore=0 phishscore=0 suspectscore=1 mlxlogscore=999 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004030014
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9579 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 lowpriorityscore=0
 malwarescore=0 adultscore=0 priorityscore=1501 mlxlogscore=999 bulkscore=0
 suspectscore=1 mlxscore=0 spamscore=0 impostorscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004030014
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

After a failure it fails for a different reason

=== START TEST
/btrfs-progs/tests/misc-tests/029-send-p-different-mountpoints
$TEST_DEV not given, using /btrfs-progs/tests/test.img as fallback
====== RUN MAYFAIL mkdir -p
/btrfs-progs/tests/misc-tests/029-send-p-different-mountpoints/subvol_mnt
====== RUN CHECK /btrfs-progs/mkfs.btrfs -f /btrfs-progs/tests/test.img
ERROR: /btrfs-progs/tests/test.img is mounted <====

Add clean_start() helper to unmount.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 tests/common        | 6 ++++++
 tests/misc-tests.sh | 1 +
 2 files changed, 7 insertions(+)

diff --git a/tests/common b/tests/common
index 71661e950db0..bf55500e94ec 100644
--- a/tests/common
+++ b/tests/common
@@ -788,6 +788,12 @@ cleanup_loopdevs()
 	run_check $SUDO_HELPER losetup --all
 }
 
+# add all the cleanups here
+clean_start()
+{
+	grep -q $TEST_MNT /proc/self/mounts && umount $TEST_MNT
+}
+
 init_env()
 {
 	TEST_MNT="${TEST_MNT:-$TEST_TOP/mnt}"
diff --git a/tests/misc-tests.sh b/tests/misc-tests.sh
index 3b49ab012e78..3dc96f258540 100755
--- a/tests/misc-tests.sh
+++ b/tests/misc-tests.sh
@@ -40,6 +40,7 @@ export IMAGE
 export TEST_DEV
 
 rm -f "$RESULTS"
+clean_start
 
 # test rely on corrupting blocks tool
 check_prereq btrfs-corrupt-block
-- 
1.8.3.1

