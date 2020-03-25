Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 069EF1922BC
	for <lists+linux-btrfs@lfdr.de>; Wed, 25 Mar 2020 09:32:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727348AbgCYIca (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 25 Mar 2020 04:32:30 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:42486 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726313AbgCYIca (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 25 Mar 2020 04:32:30 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02P8TBvJ151014
        for <linux-btrfs@vger.kernel.org>; Wed, 25 Mar 2020 08:32:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id; s=corp-2020-01-29;
 bh=AzKIRxdIP8t73YquvZuUjM2hATGGga6l6fWcSTJRp4o=;
 b=NZhMirwmW3ZwLghCLL6DhRAZRIhe5stUTgiE5A17PqwkmX1OM3I2rQM1rBCBtUBaQYJ5
 kqSgmh+n6y93xj/3qjtnf1Pv/C1AbLbn0OnJTXGmAYB+XSpskEioaGqrJCPnPS7MYXip
 5vVu0Tj3Vieune1VwhH8MA6OmZ81p7n81+WcVQEwVEDGH7dqEK4IFeI8m9+wAXuAsH+0
 de6VqnZdnU9hwMpoZOirrkk9TWZqLWbz5ptysuhaMTnIN0fUYfa8aDpeW6lp1+dyyfPy
 Resj9+oynv0jk35WpJKTyS5srbnIDXLJyHuXHC5TM7m+Rp/g00f+q1WZfF8qhv+4JvIN nw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 2yx8ac5cde-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Wed, 25 Mar 2020 08:32:28 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02P8WQhr071292
        for <linux-btrfs@vger.kernel.org>; Wed, 25 Mar 2020 08:32:28 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 2yxw4r2366-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Wed, 25 Mar 2020 08:32:27 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 02P8WGIU025601
        for <linux-btrfs@vger.kernel.org>; Wed, 25 Mar 2020 08:32:16 GMT
Received: from tp.localdomain (/39.109.145.141)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 25 Mar 2020 01:32:16 -0700
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 1/2] btrfs-progs: fix fsck-test/037 skip corrupt FREE_SPACE_BITMAP
Date:   Wed, 25 Mar 2020 16:32:08 +0800
Message-Id: <1585125129-11224-1-git-send-email-anand.jain@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9570 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=4
 spamscore=0 mlxlogscore=999 adultscore=0 phishscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003250072
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9570 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 suspectscore=4 priorityscore=1501 malwarescore=0
 mlxscore=0 adultscore=0 phishscore=0 impostorscore=0 mlxlogscore=999
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003250071
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
index d7ee0f217a09..39cdd5c8b89a 100755
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
 
 	run_check "$TOP/btrfs-corrupt-block" -r 10 -K "$objectid,$type,$offset" \
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

