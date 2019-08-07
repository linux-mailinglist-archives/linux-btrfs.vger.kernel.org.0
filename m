Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7FBF384705
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 Aug 2019 10:21:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387543AbfHGIV1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 7 Aug 2019 04:21:27 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:42648 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387498AbfHGIV0 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 7 Aug 2019 04:21:26 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x778IxiS192122
        for <linux-btrfs@vger.kernel.org>; Wed, 7 Aug 2019 08:21:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : mime-version : content-transfer-encoding;
 s=corp-2018-07-02; bh=gIFCC8ULJnOwByKnjamXXFWvDO+HA++u9bilB3g4H84=;
 b=F/f8Pmk5i4Ehua0PZHVJ88aDaOYBu5deoF5l9g1NiveTuRNu0pv1EyCIkvtsGDetupFN
 l7aSpLdFoxZYrCcTd3MmJgeI/Hm5cD1aT8arGMLdV9FVumAeHTNynVf4+6DtckGKXQMD
 cba1GFWgGVeyEYh+2oFOum3o7rVO5Ua7sov1ev3N2rj5m6jRwzUOoCT+Z6D1TopZU87B
 EZzTc/GELV841ogLw0YON38JEWL+w3WTqQjFQ78GfjcMYK28VgNRouNns7geQSYt91NA
 dEEBIGj6ovi8IAthIa+0gwt+2E4M+fOOabu6GmZJcycewe1Cu1g+jIVGw/SrGp+myw3M UA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 2u52wrarek-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Wed, 07 Aug 2019 08:21:25 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x778I5ZC069990
        for <linux-btrfs@vger.kernel.org>; Wed, 7 Aug 2019 08:21:24 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 2u7667c43x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Wed, 07 Aug 2019 08:21:24 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x778LObA001386
        for <linux-btrfs@vger.kernel.org>; Wed, 7 Aug 2019 08:21:24 GMT
Received: from mb.wifi.oracle.com (/192.188.170.109)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 07 Aug 2019 01:21:23 -0700
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 1/2] btrfs: reset device stat using btrfs_dev_stat_set
Date:   Wed,  7 Aug 2019 16:21:19 +0800
Message-Id: <20190807082120.1973-1-anand.jain@oracle.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-120)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9341 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1908070090
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9341 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1908070090
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

btrfs_dev_stat_reset() is an overdo in terms of wrapping. So this patch
open codes btrfs_dev_stat_reset().

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 fs/btrfs/volumes.c | 6 +++---
 fs/btrfs/volumes.h | 6 ------
 2 files changed, 3 insertions(+), 9 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index ea9ff506681a..3eed7968fe16 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -7316,7 +7316,7 @@ static void __btrfs_reset_dev_stats(struct btrfs_device *dev)
 	int i;
 
 	for (i = 0; i < BTRFS_DEV_STAT_VALUES_MAX; i++)
-		btrfs_dev_stat_reset(dev, i);
+		btrfs_dev_stat_set(dev, i, 0);
 }
 
 int btrfs_init_dev_stats(struct btrfs_fs_info *fs_info)
@@ -7366,7 +7366,7 @@ int btrfs_init_dev_stats(struct btrfs_fs_info *fs_info)
 				btrfs_dev_stat_set(device, i,
 					btrfs_dev_stats_value(eb, ptr, i));
 			else
-				btrfs_dev_stat_reset(device, i);
+				btrfs_dev_stat_set(device, i, 0);
 		}
 
 		device->dev_stats_valid = 1;
@@ -7549,7 +7549,7 @@ int btrfs_get_dev_stats(struct btrfs_fs_info *fs_info,
 				stats->values[i] =
 					btrfs_dev_stat_read_and_reset(dev, i);
 			else
-				btrfs_dev_stat_reset(dev, i);
+				btrfs_dev_stat_set(dev, i, 0);
 		}
 	} else {
 		for (i = 0; i < BTRFS_DEV_STAT_VALUES_MAX; i++)
diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index 081cb734a239..a7da1f3e3627 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -547,12 +547,6 @@ static inline void btrfs_dev_stat_set(struct btrfs_device *dev,
 	atomic_inc(&dev->dev_stats_ccnt);
 }
 
-static inline void btrfs_dev_stat_reset(struct btrfs_device *dev,
-					int index)
-{
-	btrfs_dev_stat_set(dev, index, 0);
-}
-
 /*
  * Convert block group flags (BTRFS_BLOCK_GROUP_*) to btrfs_raid_types, which
  * can be used as index to access btrfs_raid_array[].
-- 
2.21.0 (Apple Git-120)

