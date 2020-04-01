Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 543A219A406
	for <lists+linux-btrfs@lfdr.de>; Wed,  1 Apr 2020 05:47:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731630AbgDADrr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 31 Mar 2020 23:47:47 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:34630 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731611AbgDADrq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 31 Mar 2020 23:47:46 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0313iAG3133192;
        Wed, 1 Apr 2020 03:47:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=/e7i7eS2Uv0HYThUgvcHpdXJicyanl7pU5SYdZx2O3c=;
 b=f6LCVmsnIX/c4Rv3oR+XFV9VeC0wgFaWjvPY/1HTMnDg5novRnqMoPO3QmLyNXim24YT
 MSu8czWb3luHL6j1EBofyGciyYJteCNkiyph8hm8FrFE5ugNxv49iSW8o1LYsvWLrag+
 TE1+gKw7g4AYBqKFqV3YP1GM+sQp8+oow+LR6hySR3ob4eSkjFwzeJFbjqF4l2lMTcxY
 Q+g0eUNoprOLhpF9Nn8sC0RP0o+SDU+LSqOhwmDee0rFwbrxmsEh5sOTNtuEnb7G0SGM
 De9aT91LnkeFWfTRI98kPQC6nBbtDCTyIPdzYb6hVBvfKqTJZFkiLNEOwf7MILNSW6eq bQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 303cev317t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Apr 2020 03:47:40 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0313gE4n061337;
        Wed, 1 Apr 2020 03:47:40 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 302g4ss7py-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Apr 2020 03:47:40 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0313lddV022667;
        Wed, 1 Apr 2020 03:47:39 GMT
Received: from localhost.localdomain (/39.109.145.141)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 31 Mar 2020 20:47:38 -0700
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Cc:     dsterba@suse.cz
Subject: [PATCH 2/2 v2] btrfs-progs: fix misc-test/029 provide device for mount
Date:   Wed,  1 Apr 2020 11:47:34 +0800
Message-Id: <20200401034734.4119-1-anand.jain@oracle.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <1585125129-11224-2-git-send-email-anand.jain@oracle.com>
References: <1585125129-11224-2-git-send-email-anand.jain@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9577 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 suspectscore=1
 mlxscore=0 spamscore=0 malwarescore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004010033
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9577 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 adultscore=0
 clxscore=1015 phishscore=0 lowpriorityscore=0 spamscore=0 malwarescore=0
 suspectscore=1 mlxscore=0 impostorscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004010033
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
    update change log

 tests/misc-tests/029-send-p-different-mountpoints/test.sh | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tests/misc-tests/029-send-p-different-mountpoints/test.sh b/tests/misc-tests/029-send-p-different-mountpoints/test.sh
index a478b3d26495..0ab98f93416d 100755
--- a/tests/misc-tests/029-send-p-different-mountpoints/test.sh
+++ b/tests/misc-tests/029-send-p-different-mountpoints/test.sh
@@ -19,8 +19,9 @@ run_mayfail $SUDO_HELPER mkdir -p "$SUBVOL_MNT" ||
 run_check_mkfs_test_dev
 run_check_mount_test_dev
 
+lodev=$(losetup  | grep $(readlink -f ${TEST_DEV}) | awk '{print $1}')
 run_check $SUDO_HELPER "$TOP/btrfs" subvolume create "$TEST_MNT/subv1"
-run_check $SUDO_HELPER mount -t btrfs -o subvol=subv1 "$TEST_DEV" "$SUBVOL_MNT"
+run_check $SUDO_HELPER mount -t btrfs -o subvol=subv1 "$lodev" "$SUBVOL_MNT"
 
 run_check $SUDO_HELPER "$TOP/btrfs" subvolume create "$TEST_MNT/test-subvol"
 run_check $SUDO_HELPER "$TOP/btrfs" subvolume snapshot -r \
-- 
1.8.3.1

