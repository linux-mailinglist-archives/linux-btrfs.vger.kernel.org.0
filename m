Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06A0D25E0F0
	for <lists+linux-btrfs@lfdr.de>; Fri,  4 Sep 2020 19:35:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728020AbgIDRff (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 4 Sep 2020 13:35:35 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:50144 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727978AbgIDRfb (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 4 Sep 2020 13:35:31 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 084HXuZN037485;
        Fri, 4 Sep 2020 17:35:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=M8A4ASh1ESqqVB5+VPiZ+lUs/slLX84K5bk9MWLgz8k=;
 b=n/9zQYBYELdKygFcDAf/i1UX6nRBtww+ok3Uco1QhW3kN+VaWdQCXMYSFv/2WXLaSaip
 Fn/lLk9WPs/y/2L3wcWXMhPpZs4leLLjRn+LKQLsOEu4zK5vPHO3N8GOlChFNV22bhfX
 IhucZeoOuoVmJVvOTt3MvfXbBtClITCzsp7fAkCVrCwUssUKNHdJWn/Zq/4KkRZrUeak
 TBvAY9S8vP4L0wxKmYg614ag77qKURjfKmQnYUrPQ4GyALN66ZEVgBH55ZRmJCWZxLlr
 PYkNNfSdoW2HSudbBXmMSffNNkvt+mtvvJZMloBdkLjGzI+ah7uP9U2n6HHvnmCi8Zrk JQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 339dmne3b4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 04 Sep 2020 17:35:26 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 084HTrqW187052;
        Fri, 4 Sep 2020 17:35:26 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 33b7v30up0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 04 Sep 2020 17:35:26 +0000
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 084HZP0k009038;
        Fri, 4 Sep 2020 17:35:25 GMT
Received: from localhost.localdomain (/39.109.231.106)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 04 Sep 2020 10:35:25 -0700
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Cc:     dsterba@suse.com, josef@toxicpanda.com, nborisov@suse.com
Subject: [PATCH 16/16] btrfs: btrfs_dev_replace_update_device_in_mapping_tree drop file global declare
Date:   Sat,  5 Sep 2020 01:34:36 +0800
Message-Id: <431734f5ce390a27adc311f4b25880e20ecebc46.1599234146.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1599234146.git.anand.jain@oracle.com>
References: <cover.1599234146.git.anand.jain@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9734 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 spamscore=0
 mlxlogscore=999 phishscore=0 bulkscore=0 suspectscore=3 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009040152
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9734 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0
 mlxlogscore=999 adultscore=0 impostorscore=0 mlxscore=0 suspectscore=3
 spamscore=0 clxscore=1015 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009040152
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
index f7325a748f89..02b7b3edf9a3 100644
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

