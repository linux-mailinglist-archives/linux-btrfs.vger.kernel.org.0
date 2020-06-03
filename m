Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BEC61ECD4B
	for <lists+linux-btrfs@lfdr.de>; Wed,  3 Jun 2020 12:13:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726733AbgFCKMg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 3 Jun 2020 06:12:36 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:50568 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725888AbgFCKMg (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 3 Jun 2020 06:12:36 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 053A75Di156683
        for <linux-btrfs@vger.kernel.org>; Wed, 3 Jun 2020 10:12:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=YZAFvT5KhYXMYxXhwHwxCvP3dsJ1tmlqJqq0dPUwWX8=;
 b=ZsJk8LT3gYEzBGK53HcjiSWPS/Ncf6diWQ0kgwO3jChyy4H44jmWIwX1MOsziVWWbAhV
 BP8B8XXX7hxKHa8I8W9L90nQogvOuPwk08uBEEA0HnSC+Et77DdWNmlerWpTc2dNWipY
 SudniDKZXmpNRHbjjAvzkmLKsASDMtvMu82YIH24H4FUxxwaQg8VLsk9+JvcMdfl74JX
 oCnXBeKiDCdhdFd8FTSMR4io7Z1eX/0d1SpN+jsV/5fPXcuFU3c1zc3+LkLbIiBZoAe8
 m1hH9siGPJVNjIVMHWf3LhN3DQlo0airYHW7/Bz1WA2J/V5FOjrA85WfrogaadoCReu/ tw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 31bfem8djb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
        for <linux-btrfs@vger.kernel.org>; Wed, 03 Jun 2020 10:12:35 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 053A81RB089337
        for <linux-btrfs@vger.kernel.org>; Wed, 3 Jun 2020 10:10:34 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 31dju30dbx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Wed, 03 Jun 2020 10:10:34 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 053AAXkt003611
        for <linux-btrfs@vger.kernel.org>; Wed, 3 Jun 2020 10:10:33 GMT
Received: from localhost.localdomain (/39.109.231.106)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 03 Jun 2020 03:10:33 -0700
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 2/3] btrfs: rename btrfs_block_group::count
Date:   Wed,  3 Jun 2020 18:10:19 +0800
Message-Id: <20200603101020.143372-3-anand.jain@oracle.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200603101020.143372-1-anand.jain@oracle.com>
References: <20200603101020.143372-1-anand.jain@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9640 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 phishscore=0 malwarescore=0 mlxscore=0 adultscore=0 bulkscore=0
 suspectscore=3 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2006030079
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9640 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=3
 mlxlogscore=999 priorityscore=1501 bulkscore=0 phishscore=0 clxscore=1015
 impostorscore=0 adultscore=0 spamscore=0 mlxscore=0 lowpriorityscore=0
 cotscore=-2147483648 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2006030079
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The name 'count' is a very commonly used name. It is often difficult to
review the code to check if there is any leak. So rename it to
'bg_count', which is unique enough.

This patch also serves as a preparatory patch to either make sure
btrfs_get_block_group() is used instead of open coded the same or just
open code every where as btrfs_get_block_group() is a one-liner.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 fs/btrfs/block-group.c      | 8 ++++----
 fs/btrfs/block-group.h      | 2 +-
 fs/btrfs/free-space-cache.c | 4 ++--
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 31ca2cfb7e3e..8111f6750063 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -118,12 +118,12 @@ u64 btrfs_get_alloc_profile(struct btrfs_fs_info *fs_info, u64 orig_flags)
 
 void btrfs_get_block_group(struct btrfs_block_group *cache)
 {
-	atomic_inc(&cache->count);
+	atomic_inc(&cache->bg_count);
 }
 
 void btrfs_put_block_group(struct btrfs_block_group *cache)
 {
-	if (atomic_dec_and_test(&cache->count)) {
+	if (atomic_dec_and_test(&cache->bg_count)) {
 		WARN_ON(cache->pinned > 0);
 		WARN_ON(cache->reserved > 0);
 
@@ -1805,7 +1805,7 @@ static struct btrfs_block_group *btrfs_create_block_group_cache(
 
 	cache->discard_index = BTRFS_DISCARD_INDEX_UNUSED;
 
-	atomic_set(&cache->count, 1);
+	atomic_set(&cache->bg_count, 1);
 	spin_lock_init(&cache->lock);
 	init_rwsem(&cache->data_rwsem);
 	INIT_LIST_HEAD(&cache->list);
@@ -3379,7 +3379,7 @@ int btrfs_free_block_groups(struct btrfs_fs_info *info)
 		ASSERT(list_empty(&block_group->dirty_list));
 		ASSERT(list_empty(&block_group->io_list));
 		ASSERT(list_empty(&block_group->bg_list));
-		ASSERT(atomic_read(&block_group->count) == 1);
+		ASSERT(atomic_read(&block_group->bg_count) == 1);
 		btrfs_put_block_group(block_group);
 
 		spin_lock(&info->block_group_cache_lock);
diff --git a/fs/btrfs/block-group.h b/fs/btrfs/block-group.h
index b6ee70a039c7..f0ef8be08747 100644
--- a/fs/btrfs/block-group.h
+++ b/fs/btrfs/block-group.h
@@ -115,7 +115,7 @@ struct btrfs_block_group {
 	struct list_head list;
 
 	/* Usage count */
-	atomic_t count;
+	atomic_t bg_count;
 
 	/*
 	 * List of struct btrfs_free_clusters for this block group.
diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
index 1bf08c855edb..169b1117c1a3 100644
--- a/fs/btrfs/free-space-cache.c
+++ b/fs/btrfs/free-space-cache.c
@@ -2925,7 +2925,7 @@ void btrfs_return_cluster_to_free_space(
 		spin_unlock(&cluster->lock);
 		return;
 	}
-	atomic_inc(&block_group->count);
+	atomic_inc(&block_group->bg_count);
 	spin_unlock(&cluster->lock);
 
 	ctl = block_group->free_space_ctl;
@@ -3355,7 +3355,7 @@ int btrfs_find_space_cluster(struct btrfs_block_group *block_group,
 		list_del_init(&entry->list);
 
 	if (!ret) {
-		atomic_inc(&block_group->count);
+		atomic_inc(&block_group->bg_count);
 		list_add_tail(&cluster->block_group_list,
 			      &block_group->cluster_list);
 		cluster->block_group = block_group;
-- 
2.25.1

