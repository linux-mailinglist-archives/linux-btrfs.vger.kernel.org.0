Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4CB434DA64
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Jun 2019 21:38:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726882AbfFTTiv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 20 Jun 2019 15:38:51 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:41302 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726865AbfFTTit (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 20 Jun 2019 15:38:49 -0400
Received: by mail-qk1-f193.google.com with SMTP id c11so2750171qkk.8
        for <linux-btrfs@vger.kernel.org>; Thu, 20 Jun 2019 12:38:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=XnotkebnQ4lWsV8WegKjWHa0dguvxeoSla8oZ1uft2M=;
        b=Tqaj3bcF4V89UEsqg6aWQW0W9updMbFjG/P/oDoTNpP+90nRThP9ZIONZ7Y5dsQMog
         FRpfOHUl1uNOuPmcoI7tq7nhYxs6kxgvos5YewH1KSb6PIMdVZwib91FwHBCgeCq1w1j
         VDZFAzKuGx1y6eWf9vyKaywaK9TYgCPj4V9zA0RotiJ9eJ1HVHppw/zi53emxAAMIkTq
         yCr4yeYhPbipt0rlDDYVUH/EoUiXdoNW20vI6fFkaYxxp1UpDmXwaDfPvoPiPOhM+cjT
         /8Nmxra1RnTo04X6gc7Ksmox/TIF2YaLiwtxIYfgChDsgAUIZoz9Q8sgjF+PWh4H0DTt
         YkIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=XnotkebnQ4lWsV8WegKjWHa0dguvxeoSla8oZ1uft2M=;
        b=kxGgrLzw3lZQyu+MvN+zc6huQ5AWNjSws2NvF03coVzhndVRyFKPNbczEFag0ypwie
         enxUan1qOkam+jAMrOe7vxk2pfk2kW+PI+AWeRUwihduGbncDKBTxEnmBSJWufP5Ytqz
         PhbSrVLPD7UEJJrbF5G0+YqEOMosh5to7c8WhgqZKmtDgcKJqx3A/uyjn/sNyLLV81Hb
         xtG1q0/6/n2yVXJW7CzYuioVvIUqJFBHHE8MGHrjWId4OiPIWfWw5qa+UBewNg+quoHV
         IRn7AkRaMaAFqL2wmwTuolrCU8ysTMOJulo87+SQV55EMF18ypmiFMuLgXeFlZIQaacV
         OxOQ==
X-Gm-Message-State: APjAAAUFRZsa0HRdVwmRcyQN1Xjq9MwQGLuzVAs7r0wNtyFKBolLZRbV
        4NTo9d6VpVOH3x4Ul/dJOWUtTEheG6+PKA==
X-Google-Smtp-Source: APXvYqxMrrAP9sLy3MHdw76RhzWttHzGO945drzw+8EAL1Uo6DfAOoIJby9UzKU6NyaWIpE6Vg9zoQ==
X-Received: by 2002:a37:6282:: with SMTP id w124mr63719355qkb.33.1561059528370;
        Thu, 20 Jun 2019 12:38:48 -0700 (PDT)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id n5sm472556qta.29.2019.06.20.12.38.47
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 20 Jun 2019 12:38:47 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 24/25] btrfs: migrate the block group cleanup code
Date:   Thu, 20 Jun 2019 15:38:06 -0400
Message-Id: <20190620193807.29311-25-josef@toxicpanda.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20190620193807.29311-1-josef@toxicpanda.com>
References: <20190620193807.29311-1-josef@toxicpanda.com>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This can now be easily migrated as well.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/block-group.c | 140 +++++++++++++++++++++++++++++++++++++++++++++++++
 fs/btrfs/block-group.h |   2 +
 fs/btrfs/ctree.h       |   2 -
 fs/btrfs/extent-tree.c | 140 -------------------------------------------------
 4 files changed, 142 insertions(+), 142 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 579073ec62c3..57ac375ae847 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -3167,3 +3167,143 @@ void check_system_chunk(struct btrfs_trans_handle *trans, u64 type)
 			trans->chunk_bytes_reserved += thresh;
 	}
 }
+
+void btrfs_put_block_group_cache(struct btrfs_fs_info *info)
+{
+	struct btrfs_block_group_cache *block_group;
+	u64 last = 0;
+
+	while (1) {
+		struct inode *inode;
+
+		block_group = btrfs_lookup_first_block_group(info, last);
+		while (block_group) {
+			btrfs_wait_block_group_cache_done(block_group);
+			spin_lock(&block_group->lock);
+			if (block_group->iref)
+				break;
+			spin_unlock(&block_group->lock);
+			block_group = btrfs_next_block_group(block_group);
+		}
+		if (!block_group) {
+			if (last == 0)
+				break;
+			last = 0;
+			continue;
+		}
+
+		inode = block_group->inode;
+		block_group->iref = 0;
+		block_group->inode = NULL;
+		spin_unlock(&block_group->lock);
+		ASSERT(block_group->io_ctl.inode == NULL);
+		iput(inode);
+		last = block_group->key.objectid + block_group->key.offset;
+		btrfs_put_block_group(block_group);
+	}
+}
+
+/*
+ * Must be called only after stopping all workers, since we could have block
+ * group caching kthreads running, and therefore they could race with us if we
+ * freed the block groups before stopping them.
+ */
+int btrfs_free_block_groups(struct btrfs_fs_info *info)
+{
+	struct btrfs_block_group_cache *block_group;
+	struct btrfs_space_info *space_info;
+	struct btrfs_caching_control *caching_ctl;
+	struct rb_node *n;
+
+	down_write(&info->commit_root_sem);
+	while (!list_empty(&info->caching_block_groups)) {
+		caching_ctl = list_entry(info->caching_block_groups.next,
+					 struct btrfs_caching_control, list);
+		list_del(&caching_ctl->list);
+		btrfs_put_caching_control(caching_ctl);
+	}
+	up_write(&info->commit_root_sem);
+
+	spin_lock(&info->unused_bgs_lock);
+	while (!list_empty(&info->unused_bgs)) {
+		block_group = list_first_entry(&info->unused_bgs,
+					       struct btrfs_block_group_cache,
+					       bg_list);
+		list_del_init(&block_group->bg_list);
+		btrfs_put_block_group(block_group);
+	}
+	spin_unlock(&info->unused_bgs_lock);
+
+	spin_lock(&info->block_group_cache_lock);
+	while ((n = rb_last(&info->block_group_cache_tree)) != NULL) {
+		block_group = rb_entry(n, struct btrfs_block_group_cache,
+				       cache_node);
+		rb_erase(&block_group->cache_node,
+			 &info->block_group_cache_tree);
+		RB_CLEAR_NODE(&block_group->cache_node);
+		spin_unlock(&info->block_group_cache_lock);
+
+		down_write(&block_group->space_info->groups_sem);
+		list_del(&block_group->list);
+		up_write(&block_group->space_info->groups_sem);
+
+		/*
+		 * We haven't cached this block group, which means we could
+		 * possibly have excluded extents on this block group.
+		 */
+		if (block_group->cached == BTRFS_CACHE_NO ||
+		    block_group->cached == BTRFS_CACHE_ERROR)
+			btrfs_free_excluded_extents(block_group);
+
+		btrfs_remove_free_space_cache(block_group);
+		ASSERT(block_group->cached != BTRFS_CACHE_STARTED);
+		ASSERT(list_empty(&block_group->dirty_list));
+		ASSERT(list_empty(&block_group->io_list));
+		ASSERT(list_empty(&block_group->bg_list));
+		ASSERT(atomic_read(&block_group->count) == 1);
+		btrfs_put_block_group(block_group);
+
+		spin_lock(&info->block_group_cache_lock);
+	}
+	spin_unlock(&info->block_group_cache_lock);
+
+	/* now that all the block groups are freed, go through and
+	 * free all the space_info structs.  This is only called during
+	 * the final stages of unmount, and so we know nobody is
+	 * using them.  We call synchronize_rcu() once before we start,
+	 * just to be on the safe side.
+	 */
+	synchronize_rcu();
+
+	btrfs_release_global_block_rsv(info);
+
+	while (!list_empty(&info->space_info)) {
+		int i;
+
+		space_info = list_entry(info->space_info.next,
+					struct btrfs_space_info,
+					list);
+
+		/*
+		 * Do not hide this behind enospc_debug, this is actually
+		 * important and indicates a real bug if this happens.
+		 */
+		if (WARN_ON(space_info->bytes_pinned > 0 ||
+			    space_info->bytes_reserved > 0 ||
+			    space_info->bytes_may_use > 0))
+			btrfs_dump_space_info(info, space_info, 0, 0);
+		list_del(&space_info->list);
+		for (i = 0; i < BTRFS_NR_RAID_TYPES; i++) {
+			struct kobject *kobj;
+			kobj = space_info->block_group_kobjs[i];
+			space_info->block_group_kobjs[i] = NULL;
+			if (kobj) {
+				kobject_del(kobj);
+				kobject_put(kobj);
+			}
+		}
+		kobject_del(&space_info->kobj);
+		kobject_put(&space_info->kobj);
+	}
+	return 0;
+}
diff --git a/fs/btrfs/block-group.h b/fs/btrfs/block-group.h
index 9f6ddb5c9fef..3c6cf7477990 100644
--- a/fs/btrfs/block-group.h
+++ b/fs/btrfs/block-group.h
@@ -228,6 +228,8 @@ int btrfs_chunk_alloc(struct btrfs_trans_handle *trans, u64 flags,
 int btrfs_force_chunk_alloc(struct btrfs_trans_handle *trans, u64 type);
 void check_system_chunk(struct btrfs_trans_handle *trans, const u64 type);
 u64 btrfs_get_alloc_profile(struct btrfs_fs_info *fs_info, u64 orig_flags);
+void btrfs_put_block_group_cache(struct btrfs_fs_info *info);
+int btrfs_free_block_groups(struct btrfs_fs_info *info);
 
 static inline u64 btrfs_data_alloc_profile(struct btrfs_fs_info *fs_info)
 {
diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 1d1872e93996..412cfda54e5e 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -2518,7 +2518,6 @@ int btrfs_inc_extent_ref(struct btrfs_trans_handle *trans,
 			 struct btrfs_ref *generic_ref);
 
 int btrfs_extent_readonly(struct btrfs_fs_info *fs_info, u64 bytenr);
-int btrfs_free_block_groups(struct btrfs_fs_info *info);
 void btrfs_add_raid_kobjects(struct btrfs_fs_info *fs_info);
 void btrfs_get_block_group_trimming(struct btrfs_block_group_cache *cache);
 void btrfs_put_block_group_trimming(struct btrfs_block_group_cache *cache);
@@ -2556,7 +2555,6 @@ void btrfs_delalloc_release_extents(struct btrfs_inode *inode, u64 num_bytes,
 				    bool qgroup_free);
 
 int btrfs_delalloc_reserve_metadata(struct btrfs_inode *inode, u64 num_bytes);
-void btrfs_put_block_group_cache(struct btrfs_fs_info *info);
 u64 btrfs_account_ro_block_groups_free_space(struct btrfs_space_info *sinfo);
 int btrfs_error_unpin_extent_range(struct btrfs_fs_info *fs_info,
 				   u64 start, u64 end);
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 53b164964b3b..82e4b62dc51b 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -5512,146 +5512,6 @@ u64 btrfs_account_ro_block_groups_free_space(struct btrfs_space_info *sinfo)
 	return free_bytes;
 }
 
-void btrfs_put_block_group_cache(struct btrfs_fs_info *info)
-{
-	struct btrfs_block_group_cache *block_group;
-	u64 last = 0;
-
-	while (1) {
-		struct inode *inode;
-
-		block_group = btrfs_lookup_first_block_group(info, last);
-		while (block_group) {
-			btrfs_wait_block_group_cache_done(block_group);
-			spin_lock(&block_group->lock);
-			if (block_group->iref)
-				break;
-			spin_unlock(&block_group->lock);
-			block_group = btrfs_next_block_group(block_group);
-		}
-		if (!block_group) {
-			if (last == 0)
-				break;
-			last = 0;
-			continue;
-		}
-
-		inode = block_group->inode;
-		block_group->iref = 0;
-		block_group->inode = NULL;
-		spin_unlock(&block_group->lock);
-		ASSERT(block_group->io_ctl.inode == NULL);
-		iput(inode);
-		last = block_group->key.objectid + block_group->key.offset;
-		btrfs_put_block_group(block_group);
-	}
-}
-
-/*
- * Must be called only after stopping all workers, since we could have block
- * group caching kthreads running, and therefore they could race with us if we
- * freed the block groups before stopping them.
- */
-int btrfs_free_block_groups(struct btrfs_fs_info *info)
-{
-	struct btrfs_block_group_cache *block_group;
-	struct btrfs_space_info *space_info;
-	struct btrfs_caching_control *caching_ctl;
-	struct rb_node *n;
-
-	down_write(&info->commit_root_sem);
-	while (!list_empty(&info->caching_block_groups)) {
-		caching_ctl = list_entry(info->caching_block_groups.next,
-					 struct btrfs_caching_control, list);
-		list_del(&caching_ctl->list);
-		btrfs_put_caching_control(caching_ctl);
-	}
-	up_write(&info->commit_root_sem);
-
-	spin_lock(&info->unused_bgs_lock);
-	while (!list_empty(&info->unused_bgs)) {
-		block_group = list_first_entry(&info->unused_bgs,
-					       struct btrfs_block_group_cache,
-					       bg_list);
-		list_del_init(&block_group->bg_list);
-		btrfs_put_block_group(block_group);
-	}
-	spin_unlock(&info->unused_bgs_lock);
-
-	spin_lock(&info->block_group_cache_lock);
-	while ((n = rb_last(&info->block_group_cache_tree)) != NULL) {
-		block_group = rb_entry(n, struct btrfs_block_group_cache,
-				       cache_node);
-		rb_erase(&block_group->cache_node,
-			 &info->block_group_cache_tree);
-		RB_CLEAR_NODE(&block_group->cache_node);
-		spin_unlock(&info->block_group_cache_lock);
-
-		down_write(&block_group->space_info->groups_sem);
-		list_del(&block_group->list);
-		up_write(&block_group->space_info->groups_sem);
-
-		/*
-		 * We haven't cached this block group, which means we could
-		 * possibly have excluded extents on this block group.
-		 */
-		if (block_group->cached == BTRFS_CACHE_NO ||
-		    block_group->cached == BTRFS_CACHE_ERROR)
-			btrfs_free_excluded_extents(block_group);
-
-		btrfs_remove_free_space_cache(block_group);
-		ASSERT(block_group->cached != BTRFS_CACHE_STARTED);
-		ASSERT(list_empty(&block_group->dirty_list));
-		ASSERT(list_empty(&block_group->io_list));
-		ASSERT(list_empty(&block_group->bg_list));
-		ASSERT(atomic_read(&block_group->count) == 1);
-		btrfs_put_block_group(block_group);
-
-		spin_lock(&info->block_group_cache_lock);
-	}
-	spin_unlock(&info->block_group_cache_lock);
-
-	/* now that all the block groups are freed, go through and
-	 * free all the space_info structs.  This is only called during
-	 * the final stages of unmount, and so we know nobody is
-	 * using them.  We call synchronize_rcu() once before we start,
-	 * just to be on the safe side.
-	 */
-	synchronize_rcu();
-
-	btrfs_release_global_block_rsv(info);
-
-	while (!list_empty(&info->space_info)) {
-		int i;
-
-		space_info = list_entry(info->space_info.next,
-					struct btrfs_space_info,
-					list);
-
-		/*
-		 * Do not hide this behind enospc_debug, this is actually
-		 * important and indicates a real bug if this happens.
-		 */
-		if (WARN_ON(space_info->bytes_pinned > 0 ||
-			    space_info->bytes_reserved > 0 ||
-			    space_info->bytes_may_use > 0))
-			btrfs_dump_space_info(info, space_info, 0, 0);
-		list_del(&space_info->list);
-		for (i = 0; i < BTRFS_NR_RAID_TYPES; i++) {
-			struct kobject *kobj;
-			kobj = space_info->block_group_kobjs[i];
-			space_info->block_group_kobjs[i] = NULL;
-			if (kobj) {
-				kobject_del(kobj);
-				kobject_put(kobj);
-			}
-		}
-		kobject_del(&space_info->kobj);
-		kobject_put(&space_info->kobj);
-	}
-	return 0;
-}
-
 /* link_block_group will queue up kobjects to add when we're reclaim-safe */
 void btrfs_add_raid_kobjects(struct btrfs_fs_info *fs_info)
 {
-- 
2.14.3

