Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B9A2519CE7F
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 Apr 2020 04:11:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390308AbgDCCLK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Apr 2020 22:11:10 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:43602 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390171AbgDCCLJ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 2 Apr 2020 22:11:09 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03329iFU009569;
        Fri, 3 Apr 2020 02:11:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2020-01-29;
 bh=8d7yknR8R75cnmX2qDxiuXFIXa7v9FiW0RWCjfvsu7I=;
 b=huPUN8cApyBaVaCkE4GQazvYOMjtXh3hDDWLqDaXdIbU0oW43WkujvVzGRGtRzaVT14y
 eKwfDA7ZcgT9dxlUkvm7pMIcWEjoRZcPFRKrn7m6GCZVKxy32+Xhs9NKZEP5ZoqTSES9
 zidVKul8COIb4Rp23g5ho/RQuF76rpw5H5rT3/9hJ3k0hiHp08BzvNb26y+pUIaB+NAv
 7fGrdOUDYl6/SVdZoQ9+6zBH3aBVPBZzoybMJCGiJX3UzNZUPBVuDtv0p18tAIQBRPGk
 z+aVNrmrvfXFxmv8L8uL7MGIfIMKEskilQFElPiHBcqjRwNiYXOcYuL2QRcIjesM2u1R JA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 303yunh8ck-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 03 Apr 2020 02:11:05 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03328IZC101521;
        Fri, 3 Apr 2020 02:11:04 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 302ga3jgn9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 03 Apr 2020 02:11:04 +0000
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0332B2bE029625;
        Fri, 3 Apr 2020 02:11:03 GMT
Received: from tp.localdomain (/39.109.145.141)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 02 Apr 2020 19:11:02 -0700
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Cc:     dsterba@suse.cz
Subject: [PATCH 1/4] btrfs-progs: fix fsck-test/037 skip corrupt FREE_SPACE_BITMAP
Date:   Fri,  3 Apr 2020 10:10:40 +0800
Message-Id: <1585879843-17731-2-git-send-email-anand.jain@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1585879843-17731-1-git-send-email-anand.jain@oracle.com>
References: <1585879843-17731-1-git-send-email-anand.jain@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9579 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=4 malwarescore=0
 mlxlogscore=999 bulkscore=0 mlxscore=0 spamscore=0 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004030014
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9579 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 lowpriorityscore=0
 malwarescore=0 adultscore=0 priorityscore=1501 mlxlogscore=999 bulkscore=0
 suspectscore=4 mlxscore=0 spamscore=0 impostorscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004030014
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We don't have the FREE_SPACE_BITMAP in the default filesystem,
skip the sub test by checking if the objectid is null for the
FREE_SPACE_BITMAP. The null objectid check for the FREE_SPACE_EXTENT
is not actually required, it is added to maintain similar flow in
the code above it.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 tests/fsck-tests/037-freespacetree-repair/test.sh | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/tests/fsck-tests/037-freespacetree-repair/test.sh b/tests/fsck-tests/037-freespacetree-repair/test.sh
index 49165fcd7390..607a4e9dff9a 100755
--- a/tests/fsck-tests/037-freespacetree-repair/test.sh
+++ b/tests/fsck-tests/037-freespacetree-repair/test.sh
@@ -29,6 +29,9 @@ corrupt_fst_item()
 		objectid=$("$TOP/btrfs" inspect-internal dump-tree -t 10 "$TEST_DEV" | \
 			grep -o "[[:digit:]]* FREE_SPACE_BITMAP [[:digit:]]*" | \
 			cut -d' ' -f1 | tail -2 | head -1)
+		if [[ $objectid == "" ]]; then
+			return 1
+		fi
 		offset=$("$TOP/btrfs" inspect-internal dump-tree -t 10 "$TEST_DEV" | \
 			grep -o "[[:digit:]]* FREE_SPACE_BITMAP [[:digit:]]*" | \
 			cut -d' ' -f3 | tail -2 | head -1)
@@ -38,6 +41,9 @@ corrupt_fst_item()
 		objectid=$("$TOP/btrfs" inspect-internal dump-tree -t 10 "$TEST_DEV" | \
 			grep -o "[[:digit:]]* FREE_SPACE_EXTENT [[:digit:]]*" | \
 			cut -d' ' -f1 | tail -2 | head -1)
+		if [[ $objectid == "" ]]; then
+			return 1
+		fi
 		offset=$("$TOP/btrfs" inspect-internal dump-tree -t 10 "$TEST_DEV" | \
 			grep -o "[[:digit:]]* FREE_SPACE_EXTENT [[:digit:]]*" | \
 			cut -d' ' -f3 | tail -2 | head -1)
@@ -48,6 +54,8 @@ corrupt_fst_item()
 
 	run_check "$INTERNAL_BIN/btrfs-corrupt-block" -r 10 -K "$objectid,$type,$offset" \
 		-f offset "$TEST_DEV"
+
+	return 0
 }
 
 if ! [ -f "/sys/fs/btrfs/features/free_space_tree" ]; then
@@ -69,8 +77,7 @@ done
 run_check_umount_test_dev
 
 # now corrupt one of the bitmap items
-corrupt_fst_item "bitmap"
-check_image "$TEST_DEV"
+corrupt_fst_item "bitmap" && check_image "$TEST_DEV"
 
 # change the freespace such that we now have at least one free_space_extent
 # object
@@ -80,5 +87,4 @@ run_check $SUDO_HELPER fallocate -l 50m "$TEST_MNT/file"
 run_check_umount_test_dev
 
 # now corrupt an extent
-corrupt_fst_item "extent"
-check_image "$TEST_DEV"
+corrupt_fst_item "extent" && check_image "$TEST_DEV"
-- 
1.8.3.1

