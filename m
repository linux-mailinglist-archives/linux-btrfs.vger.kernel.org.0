Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 75C22E26A5
	for <lists+linux-btrfs@lfdr.de>; Thu, 24 Oct 2019 00:54:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436911AbfJWWx2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 23 Oct 2019 18:53:28 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:45406 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436901AbfJWWx1 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 23 Oct 2019 18:53:27 -0400
Received: by mail-qt1-f194.google.com with SMTP id c21so34694124qtj.12
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Oct 2019 15:53:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=UcCS18MW6I27O91LZcZBlA1ZkOOabi+x/dQBqSBv9EI=;
        b=gG5h6sI4Or6K4PBuATsqOM5icmHF9BDuWggOsUGMhCPBUcM3bClUvyejF+ChJJA9MS
         yhicHemZalIY7hteamJHddffv36yUvRd1vapbNhrb/ktl/IyWRZi01n+6sY9sEvHcfXr
         BFf3wxqnJq5MQRndHnmjqE7lPrMBSidCGzAZtRz+7Sxnhj+5QkNTRmA41U1Cldhy716e
         /eDlzfgbuEuuJmJ2uonHsr+z1PDx69GzuIhResPYrTgH3XjuzHe7wdyTQEABdr+SN5da
         JdjY/8L/jcOSVRqJ2WBuDYW+t6IOlYXOYjn9UKf//mezFdT5xuHXPmAKAfJXFUbhJBTH
         hvqA==
X-Gm-Message-State: APjAAAWtR140M/1NErX5pJPpGHnqSwut1HK4S3+wXvYWAjj2fpMtDcsX
        q/ISbDCVjLNEnpWicIgNNQs=
X-Google-Smtp-Source: APXvYqzzqJcyBDWqsC78eiXqNiUlJfi7+hJP58Vk4S+351SZoDKCZVQ6rpX7wvtg//V5cZJNVAISEw==
X-Received: by 2002:a05:6214:1812:: with SMTP id o18mr3970896qvw.33.1571871206102;
        Wed, 23 Oct 2019 15:53:26 -0700 (PDT)
Received: from dennisz-mbp.thefacebook.com ([163.114.130.128])
        by smtp.gmail.com with ESMTPSA id j4sm11767542qkf.116.2019.10.23.15.53.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 23 Oct 2019 15:53:25 -0700 (PDT)
From:   Dennis Zhou <dennis@kernel.org>
To:     David Sterba <dsterba@suse.com>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Omar Sandoval <osandov@osandov.com>
Cc:     kernel-team@fb.com, linux-btrfs@vger.kernel.org,
        Dennis Zhou <dennis@kernel.org>
Subject: [PATCH 06/22] btrfs: handle empty block_group removal
Date:   Wed, 23 Oct 2019 18:53:00 -0400
Message-Id: <2232e97f78d01b39e48454844c7a462b1b7b7cb8.1571865774.git.dennis@kernel.org>
X-Mailer: git-send-email 2.13.5
In-Reply-To: <cover.1571865774.git.dennis@kernel.org>
References: <cover.1571865774.git.dennis@kernel.org>
In-Reply-To: <cover.1571865774.git.dennis@kernel.org>
References: <cover.1571865774.git.dennis@kernel.org>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

block_group removal is a little tricky. It can race with the extent
allocator, the cleaner thread, and balancing. The current path is for a
block_group to be added to the unused_bgs list. Then, when the cleaner
thread comes around, it starts a transaction and then proceeds with
removing the block_group. Extents that are pinned are subsequently
removed from the pinned trees and then eventually a discard is issued
for the entire block_group.

Async discard introduces another player into the game, the discard
workqueue. While it has none of the racing issues, the new problem is
ensuring we don't leave free space untrimmed prior to forgetting the
block_group.  This is handled by placing fully free block_groups on a
separate discard queue. This is necessary to maintain discarding order
as in the future we will slowly trim even fully free block_groups. The
ordering helps us make progress on the same block_group rather than say
the last fully freed block_group or needing to search through the fully
freed block groups at the beginning of a list and insert after.

The new order of events is a fully freed block group gets placed on the
unused discard queue first. Once it's processed, it will be placed on
the unusued_bgs list and then the original sequence of events will
happen, just without the final whole block_group discard.

The mount flags can change when processing unused_bgs, so when flipping
from DISCARD to DISCARD_ASYNC, the unused_bgs must be punted to the
discard_list to be trimmed. If we flip off DISCARD_ASYNC, we punt
free block groups on the discard_list to the unused_bg queue which will
do the final discard for us.

Signed-off-by: Dennis Zhou <dennis@kernel.org>
---
 fs/btrfs/block-group.c      |  50 ++++++++++++++--
 fs/btrfs/ctree.h            |   9 ++-
 fs/btrfs/discard.c          | 112 +++++++++++++++++++++++++++++++++++-
 fs/btrfs/discard.h          |   6 ++
 fs/btrfs/free-space-cache.c |  36 ++++++++++++
 fs/btrfs/free-space-cache.h |   1 +
 fs/btrfs/scrub.c            |   7 ++-
 7 files changed, 211 insertions(+), 10 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 8bbbe7488328..b447a7c5ac34 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -1251,6 +1251,7 @@ void btrfs_delete_unused_bgs(struct btrfs_fs_info *fs_info)
 	struct btrfs_block_group_cache *block_group;
 	struct btrfs_space_info *space_info;
 	struct btrfs_trans_handle *trans;
+	bool async_trim_enabled = btrfs_test_opt(fs_info, DISCARD_ASYNC);
 	int ret = 0;
 
 	if (!test_bit(BTRFS_FS_OPEN, &fs_info->flags))
@@ -1260,6 +1261,7 @@ void btrfs_delete_unused_bgs(struct btrfs_fs_info *fs_info)
 	while (!list_empty(&fs_info->unused_bgs)) {
 		u64 start, end;
 		int trimming;
+		bool async_trimmed;
 
 		block_group = list_first_entry(&fs_info->unused_bgs,
 					       struct btrfs_block_group_cache,
@@ -1281,10 +1283,24 @@ void btrfs_delete_unused_bgs(struct btrfs_fs_info *fs_info)
 		/* Don't want to race with allocators so take the groups_sem */
 		down_write(&space_info->groups_sem);
 		spin_lock(&block_group->lock);
+
+		/*
+		 * Async discard moves the final block group discard to be prior
+		 * to the unused_bgs code path.  Therefore, if it's not fully
+		 * trimmed, punt it back to the async discard lists.
+		 */
+		async_trimmed = (!btrfs_test_opt(fs_info, DISCARD_ASYNC) ||
+				 btrfs_is_free_space_trimmed(block_group));
+
 		if (block_group->reserved || block_group->pinned ||
 		    btrfs_block_group_used(&block_group->item) ||
 		    block_group->ro ||
-		    list_is_singular(&block_group->list)) {
+		    list_is_singular(&block_group->list) ||
+		    !async_trimmed) {
+			/* Requeue if we failed because of async discard. */
+			if (!async_trimmed)
+				btrfs_discard_queue_work(&fs_info->discard_ctl,
+							 block_group);
 			/*
 			 * We want to bail if we made new allocations or have
 			 * outstanding allocations in this block group.  We do
@@ -1367,6 +1383,17 @@ void btrfs_delete_unused_bgs(struct btrfs_fs_info *fs_info)
 		spin_unlock(&block_group->lock);
 		spin_unlock(&space_info->lock);
 
+		/*
+		 * The normal path here is an unused block group is passed here,
+		 * then trimming is handled in the transaction commit path.
+		 * Async discard interposes before this to do the trimming
+		 * before coming down the unused block group path as trimming
+		 * will no longer be done later in the transaction commit path.
+		 */
+		if (!async_trim_enabled &&
+		    btrfs_test_opt(fs_info, DISCARD_ASYNC))
+			goto flip_async;
+
 		/* DISCARD can flip during remount */
 		trimming = btrfs_test_opt(fs_info, DISCARD_SYNC);
 
@@ -1411,6 +1438,13 @@ void btrfs_delete_unused_bgs(struct btrfs_fs_info *fs_info)
 		spin_lock(&fs_info->unused_bgs_lock);
 	}
 	spin_unlock(&fs_info->unused_bgs_lock);
+	return;
+
+flip_async:
+	btrfs_end_transaction(trans);
+	mutex_unlock(&fs_info->delete_unused_bgs_mutex);
+	btrfs_put_block_group(block_group);
+	btrfs_discard_punt_unused_bgs_list(fs_info);
 }
 
 void btrfs_mark_bg_unused(struct btrfs_block_group_cache *bg)
@@ -1618,6 +1652,8 @@ static struct btrfs_block_group_cache *btrfs_create_block_group_cache(
 	cache->full_stripe_len = btrfs_full_stripe_len(fs_info, start);
 	set_free_space_tree_thresholds(cache);
 
+	cache->discard_index = BTRFS_DISCARD_INDEX_UNUSED;
+
 	atomic_set(&cache->count, 1);
 	spin_lock_init(&cache->lock);
 	init_rwsem(&cache->data_rwsem);
@@ -1829,7 +1865,11 @@ int btrfs_read_block_groups(struct btrfs_fs_info *info)
 			inc_block_group_ro(cache, 1);
 		} else if (btrfs_block_group_used(&cache->item) == 0) {
 			ASSERT(list_empty(&cache->bg_list));
-			btrfs_mark_bg_unused(cache);
+			if (btrfs_test_opt(info, DISCARD_ASYNC))
+				btrfs_add_to_discard_unused_list(
+						&info->discard_ctl, cache);
+			else
+				btrfs_mark_bg_unused(cache);
 		}
 	}
 
@@ -2724,8 +2764,10 @@ int btrfs_update_block_group(struct btrfs_trans_handle *trans,
 		 * dirty list to avoid races between cleaner kthread and space
 		 * cache writeout.
 		 */
-		if (!alloc && old_val == 0)
-			btrfs_mark_bg_unused(cache);
+		if (!alloc && old_val == 0) {
+			if (!btrfs_test_opt(info, DISCARD_ASYNC))
+				btrfs_mark_bg_unused(cache);
+		}
 
 		btrfs_put_block_group(cache);
 		total -= num_bytes;
diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index efa8390e8419..e21aeb3a2266 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -441,9 +441,14 @@ struct btrfs_full_stripe_locks_tree {
 /* Discard control. */
 /*
  * Async discard uses multiple lists to differentiate the discard filter
- * parameters.
+ * parameters.  Index 0 is for completely free block groups where we need to
+ * ensure the entire block group is trimmed without being lossy.  Indices
+ * afterwards represent monotonically decreasing discard filter sizes to
+ * prioritize what should be discarded next.
  */
-#define BTRFS_NR_DISCARD_LISTS		1
+#define BTRFS_NR_DISCARD_LISTS		2
+#define BTRFS_DISCARD_INDEX_UNUSED	0
+#define BTRFS_DISCARD_INDEX_START	1
 
 struct btrfs_discard_ctl {
 	struct workqueue_struct *discard_workers;
diff --git a/fs/btrfs/discard.c b/fs/btrfs/discard.c
index 0a72a1902ca6..5b5be658c397 100644
--- a/fs/btrfs/discard.c
+++ b/fs/btrfs/discard.c
@@ -28,9 +28,13 @@ void btrfs_add_to_discard_list(struct btrfs_discard_ctl *discard_ctl,
 {
 	spin_lock(&discard_ctl->lock);
 
-	if (list_empty(&cache->discard_list))
+	if (list_empty(&cache->discard_list) ||
+	    cache->discard_index == BTRFS_DISCARD_INDEX_UNUSED) {
+		if (cache->discard_index == BTRFS_DISCARD_INDEX_UNUSED)
+			cache->discard_index = BTRFS_DISCARD_INDEX_START;
 		cache->discard_eligible_time = (ktime_get_ns() +
 						BTRFS_DISCARD_DELAY);
+	}
 
 	list_move_tail(&cache->discard_list,
 		       btrfs_get_discard_list(discard_ctl, cache));
@@ -38,6 +42,22 @@ void btrfs_add_to_discard_list(struct btrfs_discard_ctl *discard_ctl,
 	spin_unlock(&discard_ctl->lock);
 }
 
+void btrfs_add_to_discard_unused_list(struct btrfs_discard_ctl *discard_ctl,
+				      struct btrfs_block_group_cache *cache)
+{
+	spin_lock(&discard_ctl->lock);
+
+	if (!list_empty(&cache->discard_list))
+		list_del_init(&cache->discard_list);
+
+	cache->discard_index = BTRFS_DISCARD_INDEX_UNUSED;
+	cache->discard_eligible_time = ktime_get_ns();
+	list_add_tail(&cache->discard_list,
+		      &discard_ctl->discard_list[BTRFS_DISCARD_INDEX_UNUSED]);
+
+	spin_unlock(&discard_ctl->lock);
+}
+
 static bool remove_from_discard_list(struct btrfs_discard_ctl *discard_ctl,
 				     struct btrfs_block_group_cache *cache)
 {
@@ -152,7 +172,11 @@ void btrfs_discard_queue_work(struct btrfs_discard_ctl *discard_ctl,
 	if (!cache || !btrfs_test_opt(cache->fs_info, DISCARD_ASYNC))
 		return;
 
-	btrfs_add_to_discard_list(discard_ctl, cache);
+	if (btrfs_block_group_used(&cache->item) == 0)
+		btrfs_add_to_discard_unused_list(discard_ctl, cache);
+	else
+		btrfs_add_to_discard_list(discard_ctl, cache);
+
 	if (!delayed_work_pending(&discard_ctl->work))
 		btrfs_discard_schedule_work(discard_ctl, false);
 }
@@ -197,6 +221,27 @@ void btrfs_discard_schedule_work(struct btrfs_discard_ctl *discard_ctl,
 	spin_unlock(&discard_ctl->lock);
 }
 
+/**
+ * btrfs_finish_discard_pass - determine next step of a block_group
+ *
+ * This determines the next step for a block group after it's finished going
+ * through a pass on a discard list.  If it is unused and fully trimmed, we can
+ * mark it unused and send it to the unused_bgs path.  Otherwise, pass it onto
+ * the appropriate filter list or let it fall off.
+ */
+static void btrfs_finish_discard_pass(struct btrfs_discard_ctl *discard_ctl,
+				      struct btrfs_block_group_cache *cache)
+{
+	remove_from_discard_list(discard_ctl, cache);
+
+	if (btrfs_block_group_used(&cache->item) == 0) {
+		if (btrfs_is_free_space_trimmed(cache))
+			btrfs_mark_bg_unused(cache);
+		else
+			btrfs_add_to_discard_unused_list(discard_ctl, cache);
+	}
+}
+
 /**
  * btrfs_discard_workfn - discard work function
  * @work: work
@@ -218,7 +263,7 @@ static void btrfs_discard_workfn(struct work_struct *work)
 	btrfs_trim_block_group(cache, &trimmed, cache->key.objectid,
 			       btrfs_block_group_end(cache), 0);
 
-	remove_from_discard_list(discard_ctl, cache);
+	btrfs_finish_discard_pass(discard_ctl, cache);
 
 	btrfs_discard_schedule_work(discard_ctl, false);
 }
@@ -239,6 +284,63 @@ bool btrfs_run_discard_work(struct btrfs_discard_ctl *discard_ctl)
 		test_bit(BTRFS_FS_DISCARD_RUNNING, &fs_info->flags));
 }
 
+/**
+ * btrfs_discard_punt_unused_bgs_list - punt unused_bgs list to discard lists
+ * @fs_info: fs_info of interest
+ *
+ * The unused_bgs list needs to be punted to the discard lists because the
+ * order of operations is changed.  In the normal sychronous discard path, the
+ * block groups are trimmed via a single large trim in transaction commit.  This
+ * is ultimately what we are trying to avoid with asynchronous discard.  Thus,
+ * it must be done before going down the unused_bgs path.
+ */
+void btrfs_discard_punt_unused_bgs_list(struct btrfs_fs_info *fs_info)
+{
+	struct btrfs_block_group_cache *cache, *next;
+
+	spin_lock(&fs_info->unused_bgs_lock);
+
+	/* We enabled async discard, so punt all to the queue. */
+	list_for_each_entry_safe(cache, next, &fs_info->unused_bgs, bg_list) {
+		list_del_init(&cache->bg_list);
+		btrfs_add_to_discard_unused_list(&fs_info->discard_ctl, cache);
+	}
+
+	spin_unlock(&fs_info->unused_bgs_lock);
+}
+
+/**
+ * btrfs_discard_purge_list - purge discard lists
+ * @discard_ctl: discard control
+ *
+ * If we are disabling async discard, we may have intercepted block groups that
+ * are completely free and ready for the unused_bgs path.  As discarding will
+ * now happen in transaction commit or not at all, we can safely mark the
+ * corresponding block groups as unused and they will be sent on their merry
+ * way to the unused_bgs list.
+ */
+static void btrfs_discard_purge_list(struct btrfs_discard_ctl *discard_ctl)
+{
+	struct btrfs_block_group_cache *cache, *next;
+	int i;
+
+	spin_lock(&discard_ctl->lock);
+
+	for (i = 0; i < BTRFS_NR_DISCARD_LISTS; i++) {
+		list_for_each_entry_safe(cache, next,
+					 &discard_ctl->discard_list[i],
+					 discard_list) {
+			list_del_init(&cache->discard_list);
+			spin_unlock(&discard_ctl->lock);
+			if (btrfs_block_group_used(&cache->item) == 0)
+				btrfs_mark_bg_unused(cache);
+			spin_lock(&discard_ctl->lock);
+		}
+	}
+
+	spin_unlock(&discard_ctl->lock);
+}
+
 void btrfs_discard_resume(struct btrfs_fs_info *fs_info)
 {
 	if (!btrfs_test_opt(fs_info, DISCARD_ASYNC)) {
@@ -246,6 +348,8 @@ void btrfs_discard_resume(struct btrfs_fs_info *fs_info)
 		return;
 	}
 
+	btrfs_discard_punt_unused_bgs_list(fs_info);
+
 	set_bit(BTRFS_FS_DISCARD_RUNNING, &fs_info->flags);
 }
 
@@ -271,4 +375,6 @@ void btrfs_discard_cleanup(struct btrfs_fs_info *fs_info)
 {
 	btrfs_discard_stop(fs_info);
 	cancel_delayed_work_sync(&fs_info->discard_ctl.work);
+
+	btrfs_discard_purge_list(&fs_info->discard_ctl);
 }
diff --git a/fs/btrfs/discard.h b/fs/btrfs/discard.h
index 48b4710a80d0..db003a244eb7 100644
--- a/fs/btrfs/discard.h
+++ b/fs/btrfs/discard.h
@@ -9,9 +9,13 @@ struct btrfs_fs_info;
 struct btrfs_discard_ctl;
 struct btrfs_block_group_cache;
 
+/* List operations. */
 void btrfs_add_to_discard_list(struct btrfs_discard_ctl *discard_ctl,
 			       struct btrfs_block_group_cache *cache);
+void btrfs_add_to_discard_unused_list(struct btrfs_discard_ctl *discard_ctl,
+				      struct btrfs_block_group_cache *cache);
 
+/* Work operations. */
 void btrfs_discard_cancel_work(struct btrfs_discard_ctl *discard_ctl,
 			       struct btrfs_block_group_cache *cache);
 void btrfs_discard_queue_work(struct btrfs_discard_ctl *discard_ctl,
@@ -20,6 +24,8 @@ void btrfs_discard_schedule_work(struct btrfs_discard_ctl *discard_ctl,
 				 bool override);
 bool btrfs_run_discard_work(struct btrfs_discard_ctl *discard_ctl);
 
+/* Setup/Cleanup operations. */
+void btrfs_discard_punt_unused_bgs_list(struct btrfs_fs_info *fs_info);
 void btrfs_discard_resume(struct btrfs_fs_info *fs_info);
 void btrfs_discard_stop(struct btrfs_fs_info *fs_info);
 void btrfs_discard_init(struct btrfs_fs_info *fs_info);
diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
index 8120630e4439..80a205449547 100644
--- a/fs/btrfs/free-space-cache.c
+++ b/fs/btrfs/free-space-cache.c
@@ -2681,6 +2681,37 @@ void btrfs_remove_free_space_cache(struct btrfs_block_group_cache *block_group)
 
 }
 
+/**
+ * btrfs_is_free_space_trimmed - see if everything is trimmed
+ * @cache: block_group of interest
+ *
+ * Walk the @cache's free space rb_tree to determine if everything is trimmed.
+ */
+bool btrfs_is_free_space_trimmed(struct btrfs_block_group_cache *cache)
+{
+	struct btrfs_free_space_ctl *ctl = cache->free_space_ctl;
+	struct btrfs_free_space *info;
+	struct rb_node *node;
+	bool ret = true;
+
+	spin_lock(&ctl->tree_lock);
+	node = rb_first(&ctl->free_space_offset);
+
+	while (node) {
+		info = rb_entry(node, struct btrfs_free_space, offset_index);
+
+		if (!btrfs_free_space_trimmed(info)) {
+			ret = false;
+			break;
+		}
+
+		node = rb_next(node);
+	}
+
+	spin_unlock(&ctl->tree_lock);
+	return ret;
+}
+
 u64 btrfs_find_space_for_alloc(struct btrfs_block_group_cache *block_group,
 			       u64 offset, u64 bytes, u64 empty_size,
 			       u64 *max_extent_size)
@@ -2767,6 +2798,9 @@ int btrfs_return_cluster_to_free_space(
 	ret = __btrfs_return_cluster_to_free_space(block_group, cluster);
 	spin_unlock(&ctl->tree_lock);
 
+	btrfs_discard_queue_work(&block_group->fs_info->discard_ctl,
+				 block_group);
+
 	/* finally drop our ref */
 	btrfs_put_block_group(block_group);
 	return ret;
@@ -3125,6 +3159,7 @@ int btrfs_find_space_cluster(struct btrfs_block_group_cache *block_group,
 	u64 min_bytes;
 	u64 cont1_bytes;
 	int ret;
+	bool found_cluster = false;
 
 	/*
 	 * Choose the minimum extent size we'll require for this
@@ -3177,6 +3212,7 @@ int btrfs_find_space_cluster(struct btrfs_block_group_cache *block_group,
 		list_del_init(&entry->list);
 
 	if (!ret) {
+		found_cluster = true;
 		atomic_inc(&block_group->count);
 		list_add_tail(&cluster->block_group_list,
 			      &block_group->cluster_list);
diff --git a/fs/btrfs/free-space-cache.h b/fs/btrfs/free-space-cache.h
index b9d1aad2f7e5..e703f9e09461 100644
--- a/fs/btrfs/free-space-cache.h
+++ b/fs/btrfs/free-space-cache.h
@@ -119,6 +119,7 @@ int btrfs_remove_free_space(struct btrfs_block_group_cache *block_group,
 void __btrfs_remove_free_space_cache(struct btrfs_free_space_ctl *ctl);
 void btrfs_remove_free_space_cache(struct btrfs_block_group_cache
 				     *block_group);
+bool btrfs_is_free_space_trimmed(struct btrfs_block_group_cache *cache);
 u64 btrfs_find_space_for_alloc(struct btrfs_block_group_cache *block_group,
 			       u64 offset, u64 bytes, u64 empty_size,
 			       u64 *max_extent_size);
diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index f7d4e03f4c5d..5abc736f965c 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -8,6 +8,7 @@
 #include <linux/sched/mm.h>
 #include <crypto/hash.h>
 #include "ctree.h"
+#include "discard.h"
 #include "volumes.h"
 #include "disk-io.h"
 #include "ordered-data.h"
@@ -3683,7 +3684,11 @@ int scrub_enumerate_chunks(struct scrub_ctx *sctx,
 		if (!cache->removed && !cache->ro && cache->reserved == 0 &&
 		    btrfs_block_group_used(&cache->item) == 0) {
 			spin_unlock(&cache->lock);
-			btrfs_mark_bg_unused(cache);
+			if (btrfs_test_opt(fs_info, DISCARD_ASYNC))
+				btrfs_add_to_discard_unused_list(
+						&fs_info->discard_ctl, cache);
+			else
+				btrfs_mark_bg_unused(cache);
 		} else {
 			spin_unlock(&cache->lock);
 		}
-- 
2.17.1

