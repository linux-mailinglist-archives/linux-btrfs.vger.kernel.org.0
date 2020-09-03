Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D04125B811
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Sep 2020 02:58:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727973AbgICA6d (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 2 Sep 2020 20:58:33 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:57150 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727991AbgICA6c (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 2 Sep 2020 20:58:32 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0830rh0e176256
        for <linux-btrfs@vger.kernel.org>; Thu, 3 Sep 2020 00:58:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=Vc083YnFtu97ZqoePL72twNfwsR+MAZn8t1SUl/+4qU=;
 b=FHSYMiL2/ABdnbZgavmi1uogXLLiLlnEQqRhJ8rO3OUgoWHW/tVbym30roDKm6Dw4nb4
 VdaMWroa1nJ9fzyzIP5KZenZPA0aO8oycgRMULGADOb+6XG/ge5LV6RwzKn9/5nuwlCb
 t/2+bnLDIxoba6eoBYc1DgJoqhOoQsuLHqwPN4UrPwKJp0mV9YLB6Oj+1hAuqdy4ES9s
 dyFI9kEsbs7g0UUdDWdgLHqrWIw8dQpdTuWs0+/fbmmmtU7PXN/VnIGbV4aXEOG5L20p
 POpnodAAV4Bol7YObQIVPAdwtFFQxhWfXpjNzkCF3ZmKWa2iYreE370Lbvqk/tjvMAid cg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 339dmn4b20-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
        for <linux-btrfs@vger.kernel.org>; Thu, 03 Sep 2020 00:58:30 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0830t5Qb179397
        for <linux-btrfs@vger.kernel.org>; Thu, 3 Sep 2020 00:58:30 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 3380sv16h1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Thu, 03 Sep 2020 00:58:30 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0830wTqY017189
        for <linux-btrfs@vger.kernel.org>; Thu, 3 Sep 2020 00:58:29 GMT
Received: from localhost.localdomain (/39.109.231.106)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 02 Sep 2020 17:58:29 -0700
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 14/15] btrfs: btrfs_dev_replace_update_device_in_mapping_tree drop file global declare
Date:   Thu,  3 Sep 2020 08:57:50 +0800
Message-Id: <30bd83fdbebb6d8f2f3eedf7b7861363af927145.1599091832.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1599091832.git.anand.jain@oracle.com>
References: <cover.1599091832.git.anand.jain@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9732 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 phishscore=0 malwarescore=0 mlxscore=0 spamscore=0 bulkscore=0
 suspectscore=3 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009030004
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9732 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0
 mlxlogscore=999 adultscore=0 impostorscore=0 mlxscore=0 suspectscore=3
 spamscore=0 clxscore=1015 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009030004
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
Reviewed-by: Nikolay Borisov <nborisov@suse.com>
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

