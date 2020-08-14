Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAC132441DB
	for <lists+linux-btrfs@lfdr.de>; Fri, 14 Aug 2020 02:04:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726678AbgHNAEO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 13 Aug 2020 20:04:14 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:32868 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726674AbgHNAEO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 13 Aug 2020 20:04:14 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07E025MX184841
        for <linux-btrfs@vger.kernel.org>; Fri, 14 Aug 2020 00:04:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=k84un67RbnSx0bmgOmjtT/HtJBvm773UuiGW25ut9vo=;
 b=QNdNo49PhGPYUNSuRD6w6pdr8Vq6BZB+9LJ4NK+ICUvETQqgkZ7OChQDinfZ3Levh7D0
 XMsNC/spDqmzsp41FSExIG6saaB8Pp1Ty6cvETXpjOZiTFWZFNmD5SC3dBaG9mfU5l5c
 osNAjg2lXrIEiw00YckJE4QHRLZq12qxD2RuX4A1SfvZHfwVB4l6sGwEB52VcBUUWsqz
 O2zAnbHaW4JUIQyCVlpq4HlXEERoZcnGOVSpyGRAQq1OScr1zsiL1Gi30bZEVRKlOaU+
 JxXQSH5d5GCcnIr+P85qQi+yqB5xcKAMfq9zvU9LqUlLtTh4nlHd5ywwNruRp0+fD5bN Qg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 32t2ye1ydf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
        for <linux-btrfs@vger.kernel.org>; Fri, 14 Aug 2020 00:04:12 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07DNvflV030201
        for <linux-btrfs@vger.kernel.org>; Fri, 14 Aug 2020 00:04:11 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 32t5msejvh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Fri, 14 Aug 2020 00:04:11 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 07E04BZU003115
        for <linux-btrfs@vger.kernel.org>; Fri, 14 Aug 2020 00:04:11 GMT
Received: from localhost.localdomain (/39.109.231.106)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 14 Aug 2020 00:04:10 +0000
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 7/7] btrfs: btrfs_dev_replace_update_device_in_mapping_tree drop file global declare
Date:   Fri, 14 Aug 2020 08:03:52 +0800
Message-Id: <20200814000352.124179-8-anand.jain@oracle.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200814000352.124179-1-anand.jain@oracle.com>
References: <20200814000352.124179-1-anand.jain@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9712 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 mlxscore=0
 adultscore=0 malwarescore=0 mlxlogscore=999 phishscore=0 suspectscore=3
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008130164
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9712 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 priorityscore=1501
 malwarescore=0 impostorscore=0 lowpriorityscore=0 mlxscore=0 bulkscore=0
 suspectscore=3 phishscore=0 adultscore=0 spamscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008130164
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
index 76dda11d441b..2706c09f117a 100644
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
@@ -755,32 +777,6 @@ static int btrfs_dev_replace_finishing(struct btrfs_fs_info *fs_info,
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
2.18.2

