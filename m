Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 85BE61922BB
	for <lists+linux-btrfs@lfdr.de>; Wed, 25 Mar 2020 09:32:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727291AbgCYIcU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 25 Mar 2020 04:32:20 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:42344 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726105AbgCYIcU (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 25 Mar 2020 04:32:20 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02P8SGbG150271
        for <linux-btrfs@vger.kernel.org>; Wed, 25 Mar 2020 08:32:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references; s=corp-2020-01-29;
 bh=HB+WcflJr5pG6lJgDLCnhb76mnb6njKgjwIOKGHS89Y=;
 b=n4pkxD4i6nJ2Gi/RxwOhlRp0I9+ksuF9KejarbV+CHog1DXxApD61zVs0hX4rSDEyM4M
 z4iwSOLc9xseS5k+4OQK4Mu7hsFiIOK9vP24UjwmwzbT7z1az2fsyWyk+6wKX15j9iI+
 dByg6TtuPT2AkRe4KLCar6jO0qVHK0+SnvU/L7+N2RSgGJQhnYUsTqrJ65u8ab0QH3sg
 yQqWl8gHVM6jTEmh5danIUNKZKFdYTO88pxS/AJPZDXyl50l4Hhbazr+i5gve/gIBZMP
 SSfiuYtdCMJ67WifXf3ndyLuiCQqSzbrqsW9EG1bC75YofPz3vMZPmFQvg3VkfTybbJ7 hA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 2yx8ac5ccm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Wed, 25 Mar 2020 08:32:19 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02P8S97K063536
        for <linux-btrfs@vger.kernel.org>; Wed, 25 Mar 2020 08:32:18 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 3003gh95jt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Wed, 25 Mar 2020 08:32:18 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 02P8WIm4011390
        for <linux-btrfs@vger.kernel.org>; Wed, 25 Mar 2020 08:32:18 GMT
Received: from tp.localdomain (/39.109.145.141)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 25 Mar 2020 01:32:17 -0700
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 2/2] btrfs-progs: fix misc-test/029 provide device for mount
Date:   Wed, 25 Mar 2020 16:32:09 +0800
Message-Id: <1585125129-11224-2-git-send-email-anand.jain@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1585125129-11224-1-git-send-email-anand.jain@oracle.com>
References: <1585125129-11224-1-git-send-email-anand.jain@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9570 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999 bulkscore=0
 phishscore=0 adultscore=0 spamscore=0 malwarescore=0 suspectscore=1
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2003250071
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9570 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 suspectscore=1 priorityscore=1501 malwarescore=0
 mlxscore=0 adultscore=0 phishscore=0 impostorscore=0 mlxlogscore=999
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003250071
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The mount fails with 'file exists' error. Fix it by providing the device
name.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 tests/misc-tests/029-send-p-different-mountpoints/test.sh | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tests/misc-tests/029-send-p-different-mountpoints/test.sh b/tests/misc-tests/029-send-p-different-mountpoints/test.sh
index a478b3d26495..e34402d9ec06 100755
--- a/tests/misc-tests/029-send-p-different-mountpoints/test.sh
+++ b/tests/misc-tests/029-send-p-different-mountpoints/test.sh
@@ -19,8 +19,10 @@ run_mayfail $SUDO_HELPER mkdir -p "$SUBVOL_MNT" ||
 run_check_mkfs_test_dev
 run_check_mount_test_dev
 
+# The sed part is to replace double forward-slash with single forward-slash
+lodev=$(losetup  | grep $(echo $TEST_DEV | sed 's/\/\//\//') | awk '{print $1}')
 run_check $SUDO_HELPER "$TOP/btrfs" subvolume create "$TEST_MNT/subv1"
-run_check $SUDO_HELPER mount -t btrfs -o subvol=subv1 "$TEST_DEV" "$SUBVOL_MNT"
+run_check $SUDO_HELPER mount -t btrfs -o subvol=subv1 "$lodev" "$SUBVOL_MNT"
 
 run_check $SUDO_HELPER "$TOP/btrfs" subvolume create "$TEST_MNT/test-subvol"
 run_check $SUDO_HELPER "$TOP/btrfs" subvolume snapshot -r \
-- 
1.8.3.1

