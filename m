Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8CAD719CE83
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 Apr 2020 04:13:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389366AbgDCCNO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Apr 2020 22:13:14 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:36152 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388951AbgDCCNO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 2 Apr 2020 22:13:14 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0332DB6U080677;
        Fri, 3 Apr 2020 02:13:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2020-01-29;
 bh=A89lGwCayIYjYjyE3/f7zfc9wqfAgsyiR2HaLqP+hCs=;
 b=fyEMKTVJwEJCh11aIsuKsvCqqjX/9ApXad8QqA1yxzclrVMpOXP1pMPSQ7lPppJ5P07v
 JI0rCR5RqBhxT44caBO6ujN8LJ/PnQcg+ohmBYmNn1nH1fKrzBkB/mSaR2e7pDo4QY5Q
 CMlB0Fy54Ws22hhzVAhoJCBqPOMp30c02g3EvcyAkJVIzFsIwnJGxkbZhbkhwWmGGBNH
 9mAHPIB0iIAKBVJymo12zRE/GuNjMoSQef+XsplTdqnec64/6q2TVltn5bGp2th6vX3f
 FTntD27TFDtbnDbn9Ui1UZprPuYW7cDKYnhtVFnKMU+hNr0SNXSYPSLRwGa9AQbt5aEf 0g== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 303aqhy48a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 03 Apr 2020 02:13:11 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03328IsS101518;
        Fri, 3 Apr 2020 02:11:10 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 302ga3jgte-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 03 Apr 2020 02:11:10 +0000
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0332BA7i030598;
        Fri, 3 Apr 2020 02:11:10 GMT
Received: from tp.localdomain (/39.109.145.141)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 02 Apr 2020 19:11:09 -0700
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Cc:     dsterba@suse.cz
Subject: [PATCH v3 4/4] btrfs-progs: fix misc-test/029 provide device for mount
Date:   Fri,  3 Apr 2020 10:10:43 +0800
Message-Id: <1585879843-17731-5-git-send-email-anand.jain@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1585879843-17731-1-git-send-email-anand.jain@oracle.com>
References: <1585879843-17731-1-git-send-email-anand.jain@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9579 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 mlxlogscore=999 bulkscore=0 mlxscore=0 spamscore=0 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004030014
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9579 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0 clxscore=1015
 malwarescore=0 impostorscore=0 mlxlogscore=999 spamscore=0 mlxscore=0
 priorityscore=1501 lowpriorityscore=0 adultscore=0 suspectscore=1
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004030015
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The mount fails with 'file exists' error. Fix it by providing the device
name.

$ make TEST=029\* test-misc
    [TEST]   misc-tests.sh
    [TEST/misc]   029-send-p-different-mountpoints
failed: mount -t btrfs -o subvol=subv1 /btrfs-progs/tests//test.img /btrfs-progs/tests/misc-tests/029-send-p-different-mountpoints/subvol_mnt
test failed for case 029-send-p-different-mountpoints
make: *** [test-misc] Error 1

====== RUN CHECK mount -t btrfs -o subvol=subv1
/btrfs-progs/tests//test.img
/btrfs-progs/tests/misc-tests/029-send-p-different-mountpoints/subvol_mnt
mount: mount /dev/loop1 on
/btrfs-progs/tests/misc-tests/029-send-p-different-mountpoints/subvol_mnt
failed: File exists
failed: mount -t btrfs -o subvol=subv1 /btrfs-progs/tests//test.img
/btrfs-progs/tests/misc-tests/029-send-p-different-mountpoints/subvol_mnt
test failed for case 029-send-p-different-mountpoints

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
v2: use readlink to sanitize the TEST_DEV path
v3: readlink for TEST_DEV is not needed drop it

 tests/misc-tests/029-send-p-different-mountpoints/test.sh | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tests/misc-tests/029-send-p-different-mountpoints/test.sh b/tests/misc-tests/029-send-p-different-mountpoints/test.sh
index a478b3d26495..b05e4172ca0f 100755
--- a/tests/misc-tests/029-send-p-different-mountpoints/test.sh
+++ b/tests/misc-tests/029-send-p-different-mountpoints/test.sh
@@ -20,7 +20,8 @@ run_check_mkfs_test_dev
 run_check_mount_test_dev
 
 run_check $SUDO_HELPER "$TOP/btrfs" subvolume create "$TEST_MNT/subv1"
-run_check $SUDO_HELPER mount -t btrfs -o subvol=subv1 "$TEST_DEV" "$SUBVOL_MNT"
+lodev=$(losetup  | grep ${TEST_DEV} | awk '{print $1}')
+run_check $SUDO_HELPER mount -t btrfs -o subvol=subv1 "$lodev" "$SUBVOL_MNT"
 
 run_check $SUDO_HELPER "$TOP/btrfs" subvolume create "$TEST_MNT/test-subvol"
 run_check $SUDO_HELPER "$TOP/btrfs" subvolume snapshot -r \
-- 
1.8.3.1

