Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BDD827F936
	for <lists+linux-btrfs@lfdr.de>; Thu,  1 Oct 2020 07:58:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730649AbgJAF6C (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 1 Oct 2020 01:58:02 -0400
Received: from mx2.suse.de ([195.135.220.15]:40152 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730534AbgJAF6C (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 1 Oct 2020 01:58:02 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1601531880;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Igp57LS3VRplvrf/mkOyjiCoHTwtGZu7czGgMCdpLXg=;
        b=hbyowyEYdfBCoSjuLqFnj4RX44+WcQjrP6vpWSkX6XRiTzBuoMpqUY7oUV2m/XNLkdtgkw
        jzMuLanbetNkEG4rvQdEtSyQWHt0js/02NmyIKyC8R58mmo1s7z40BPIS1iXZ/1+cGDhbn
        oh9IH1cXsLL9zF5o8JpqiLe5M6S3FyY=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id BAB0CB32D
        for <linux-btrfs@vger.kernel.org>; Thu,  1 Oct 2020 05:58:00 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 9 04/12] btrfs: block-group: extract the code to unlink block group from space info
Date:   Thu,  1 Oct 2020 13:57:36 +0800
Message-Id: <20201001055744.103261-5-wqu@suse.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201001055744.103261-1-wqu@suse.com>
References: <20201001055744.103261-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Introduce a new helper, unlink_block_group(), to unlink a block group
from space info.

The function will remove the block group from space info, and cleanup
the kobject if that block group is the last one of the space info.

There are two callers, btrfs_free_block_groups() and
btrfs_remove_block_group() for now.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/block-group.c | 50 +++++++++++++++++++++++-------------------
 1 file changed, 27 insertions(+), 23 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index cb6be9a3d1dc..262805b96b9b 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -900,6 +900,31 @@ static int remove_block_group_item(struct btrfs_trans_handle *trans,
 	return ret;
 }
 
+static void unlink_block_group(struct btrfs_block_group *cache)
+{
+	struct btrfs_fs_info *fs_info = cache->fs_info;
+	struct kobject *kobj = NULL;
+	int index = btrfs_bg_flags_to_raid_index(cache->flags);
+
+	down_write(&cache->space_info->groups_sem);
+	/*
+	 * we must use list_del_init so people can check to see if they
+	 * are still on the list after taking the semaphore
+	 */
+	list_del_init(&cache->list);
+	if (list_empty(&cache->space_info->block_groups[index])) {
+		kobj = cache->space_info->block_group_kobjs[index];
+		cache->space_info->block_group_kobjs[index] = NULL;
+		clear_avail_alloc_bits(fs_info, cache->flags);
+	}
+	up_write(&cache->space_info->groups_sem);
+	clear_incompat_bg_bits(fs_info, cache->flags);
+	if (kobj) {
+		kobject_del(kobj);
+		kobject_put(kobj);
+	}
+}
+
 int btrfs_remove_block_group(struct btrfs_trans_handle *trans,
 			     u64 group_start, struct extent_map *em)
 {
@@ -910,9 +935,7 @@ int btrfs_remove_block_group(struct btrfs_trans_handle *trans,
 	struct btrfs_root *tree_root = fs_info->tree_root;
 	struct btrfs_key key;
 	struct inode *inode;
-	struct kobject *kobj = NULL;
 	int ret;
-	int index;
 	int factor;
 	struct btrfs_caching_control *caching_ctl = NULL;
 	bool remove_em;
@@ -931,7 +954,6 @@ int btrfs_remove_block_group(struct btrfs_trans_handle *trans,
 	btrfs_free_ref_tree_range(fs_info, block_group->start,
 				  block_group->length);
 
-	index = btrfs_bg_flags_to_raid_index(block_group->flags);
 	factor = btrfs_bg_type_to_factor(block_group->flags);
 
 	/* make sure this block group isn't part of an allocation cluster */
@@ -1027,23 +1049,7 @@ int btrfs_remove_block_group(struct btrfs_trans_handle *trans,
 	/* Once for the block groups rbtree */
 	btrfs_put_block_group(block_group);
 
-	down_write(&block_group->space_info->groups_sem);
-	/*
-	 * we must use list_del_init so people can check to see if they
-	 * are still on the list after taking the semaphore
-	 */
-	list_del_init(&block_group->list);
-	if (list_empty(&block_group->space_info->block_groups[index])) {
-		kobj = block_group->space_info->block_group_kobjs[index];
-		block_group->space_info->block_group_kobjs[index] = NULL;
-		clear_avail_alloc_bits(fs_info, block_group->flags);
-	}
-	up_write(&block_group->space_info->groups_sem);
-	clear_incompat_bg_bits(fs_info, block_group->flags);
-	if (kobj) {
-		kobject_del(kobj);
-		kobject_put(kobj);
-	}
+	unlink_block_group(block_group);
 
 	if (block_group->has_caching_ctl)
 		caching_ctl = btrfs_get_caching_control(block_group);
@@ -3322,9 +3328,7 @@ int btrfs_free_block_groups(struct btrfs_fs_info *info)
 		RB_CLEAR_NODE(&block_group->cache_node);
 		spin_unlock(&info->block_group_cache_lock);
 
-		down_write(&block_group->space_info->groups_sem);
-		list_del(&block_group->list);
-		up_write(&block_group->space_info->groups_sem);
+		unlink_block_group(block_group);
 
 		/*
 		 * We haven't cached this block group, which means we could
-- 
2.28.0

