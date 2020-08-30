Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C1F0256EBC
	for <lists+linux-btrfs@lfdr.de>; Sun, 30 Aug 2020 16:43:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727929AbgH3Om6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 30 Aug 2020 10:42:58 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:59242 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727013AbgH3Olr (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 30 Aug 2020 10:41:47 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07UEXUwB130509;
        Sun, 30 Aug 2020 14:41:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=S/sS92JAW3p3LFhh6FAWdmHn/oucfJ2piY7L0Wy9+sg=;
 b=BIuOJsYV7eFgCOA0Ol+TKLY2kkVnwF0YrvmbCp/w17j5BIdAU1sPqYV2Ks9lIVEMkbo6
 H7RQayKFxhyfMIo4/++rxaeCoFAMdFW3qH2ujjPxzyAdtBYOdfPpmmNLMMwhYnpjTIrk
 ZDF6NH99daUG5VIV55HG5HgtPchgAewvS/MbUQ8+KhZaYxKGUHeKUTuDeXjNRaxy3RkY
 c9EVWI6pfiI8kfOELfrSUmSyRPq3p9iSylpIBMhfNOcwpDX1xyv6L7947YwKGdlYlJMl
 nBdV8WMyJHJUprdMDHPxKXLKCBYzQxdWUQI7qUnZpq1IhnQepqoSAwQCJKov/LfGbtg9 3g== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 337qrha2d7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sun, 30 Aug 2020 14:41:41 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07UEZ4qK104543;
        Sun, 30 Aug 2020 14:41:40 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 3380kjq01x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 30 Aug 2020 14:41:40 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 07UEfehw015603;
        Sun, 30 Aug 2020 14:41:40 GMT
Received: from localhost.localdomain (/39.109.231.106)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sun, 30 Aug 2020 07:41:39 -0700
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Cc:     dsterba@suse.com, josef@toxicpanda.com
Subject: [PATCH 10/11] btrfs: btrfs_dev_replace_update_device_in_mapping_tree drop file global declare
Date:   Sun, 30 Aug 2020 22:41:05 +0800
Message-Id: <cdcd7e83c8f549718c391fb8119e2649c9335b2c.1598792561.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1598792561.git.anand.jain@oracle.com>
References: <cover.1598792561.git.anand.jain@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9729 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 adultscore=0
 mlxscore=0 suspectscore=3 malwarescore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008300118
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9729 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0
 adultscore=0 mlxscore=0 lowpriorityscore=0 phishscore=0 clxscore=1015
 suspectscore=3 priorityscore=1501 spamscore=0 malwarescore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008300118
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

There isn't any convoluted child functions inside the
btrfs_dev_replace_update_device_in_mapping_tree() function. With the
function moved before where it is called, we can drop its file local
declare.

No functional changes.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 fs/btrfs/dev-replace.c | 56 ++++++++++++++++++++----------------------
 1 file changed, 26 insertions(+), 30 deletions(-)

diff --git a/fs/btrfs/dev-replace.c b/fs/btrfs/dev-replace.c
index aea1c782c009..656d8ba642af 100644
--- a/fs/btrfs/dev-replace.c
+++ b/fs/btrfs/dev-replace.c
@@ -64,10 +64,6 @@
 
 static int btrfs_dev_replace_finishing(struct btrfs_fs_info *fs_info,
 				       int scrub_ret);
-static void btrfs_dev_replace_update_device_in_mapping_tree(
-						struct btrfs_fs_info *fs_info,
-						struct btrfs_device *srcdev,
-						struct btrfs_device *tgtdev);
 static int btrfs_dev_replace_kthread(void *data);
 
 int btrfs_init_dev_replace(struct btrfs_fs_info *fs_info)
@@ -597,6 +593,32 @@ static void btrfs_rm_dev_replace_unblocked(struct btrfs_fs_info *fs_info)
 	wake_up(&fs_info->dev_replace.replace_wait);
 }
 
+static void btrfs_dev_replace_update_device_in_mapping_tree(
+						struct btrfs_fs_info *fs_info,
+						struct btrfs_device *srcdev,
+						struct btrfs_device *tgtdev)
+{
+	struct extent_map_tree *em_tree = &fs_info->mapping_tree;
+	struct extent_map *em;
+	struct map_lookup *map;
+	u64 start = 0;
+	int i;
+
+	write_lock(&em_tree->lock);
+	do {
+		em = lookup_extent_mapping(em_tree, start, (u64)-1);
+		if (!em)
+			break;
+		map = em->map_lookup;
+		for (i = 0; i < map->num_stripes; i++)
+			if (srcdev == map->stripes[i].dev)
+				map->stripes[i].dev = tgtdev;
+		start = em->start + em->len;
+		free_extent_map(em);
+	} while (start);
+	write_unlock(&em_tree->lock);
+}
+
 static int btrfs_dev_replace_finishing(struct btrfs_fs_info *fs_info,
 				       int scrub_ret)
 {
@@ -759,32 +781,6 @@ static int btrfs_dev_replace_finishing(struct btrfs_fs_info *fs_info,
 	return 0;
 }
 
-static void btrfs_dev_replace_update_device_in_mapping_tree(
-						struct btrfs_fs_info *fs_info,
-						struct btrfs_device *srcdev,
-						struct btrfs_device *tgtdev)
-{
-	struct extent_map_tree *em_tree = &fs_info->mapping_tree;
-	struct extent_map *em;
-	struct map_lookup *map;
-	u64 start = 0;
-	int i;
-
-	write_lock(&em_tree->lock);
-	do {
-		em = lookup_extent_mapping(em_tree, start, (u64)-1);
-		if (!em)
-			break;
-		map = em->map_lookup;
-		for (i = 0; i < map->num_stripes; i++)
-			if (srcdev == map->stripes[i].dev)
-				map->stripes[i].dev = tgtdev;
-		start = em->start + em->len;
-		free_extent_map(em);
-	} while (start);
-	write_unlock(&em_tree->lock);
-}
-
 /*
  * Read progress of device replace status according to the state and last
  * stored position. The value format is the same as for
-- 
2.25.1

