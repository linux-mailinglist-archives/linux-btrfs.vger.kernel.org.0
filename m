Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BA757104617
	for <lists+linux-btrfs@lfdr.de>; Wed, 20 Nov 2019 22:51:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726852AbfKTVvg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 20 Nov 2019 16:51:36 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:40831 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726658AbfKTVvg (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 20 Nov 2019 16:51:36 -0500
Received: by mail-qk1-f196.google.com with SMTP id z16so1247336qkg.7
        for <linux-btrfs@vger.kernel.org>; Wed, 20 Nov 2019 13:51:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=CV0u28tbVYKKnnzQQeMixqqGVkiKdnLkWp3pE8z1ZxY=;
        b=A7lHkDKZWcIxLLdSjxpsiJgWSY8LG0YeYPrRSdPRYeLM5s3R+EST6SrQG+0R6/234R
         9Qio1POf1OwzFeawtsDOd6dEbo8iHXNK/GpCT1rNdK5zlx9Dhm0vN9rkLVG6G76aLbrq
         lOim+zNvsKx877MLY6x5nZQWfJhfnASu5cipCaYJuiEuMAKDZIQ7NPwdS3svSnk0JV/v
         T8/JPGpUFsNgfLb/BxPJuZ+nqe5KxR/MGNl0nvSZZsO1Wt+2+xWU4Lk+fWpoc6/1gXP1
         pZUr+2TYbzMMBedQFGF2f5w3UobAMaMWVEl9EX0ny4IVPj1Wq2PN1zVKhgLpsnOaelOp
         8wtA==
X-Gm-Message-State: APjAAAWJeQ0C0wvJjNxup/0oe5v1wShOIC4KQot2xMt/XjrDchh5soxe
        5D6rPOiwvlgNSTYdnZ1qK8s=
X-Google-Smtp-Source: APXvYqyYqiM6tH7nMOH4aE8wbGt8XvfvRMuPxUFMtC3RX6HnwgeFah6+PCbszrzxVSxp++5QQoiWRg==
X-Received: by 2002:a37:a603:: with SMTP id p3mr4647560qke.382.1574286694509;
        Wed, 20 Nov 2019 13:51:34 -0800 (PST)
Received: from dennisz-mbp.thefacebook.com ([163.114.130.128])
        by smtp.gmail.com with ESMTPSA id t16sm303820qkm.73.2019.11.20.13.51.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 20 Nov 2019 13:51:33 -0800 (PST)
From:   Dennis Zhou <dennis@kernel.org>
To:     David Sterba <dsterba@suse.com>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Omar Sandoval <osandov@osandov.com>
Cc:     kernel-team@fb.com, linux-btrfs@vger.kernel.org,
        Dennis Zhou <dennis@kernel.org>
Subject: [PATCH 06/22] btrfs: handle empty block_group removal
Date:   Wed, 20 Nov 2019 16:51:05 -0500
Message-Id: <41ac461c9007ece384635e600b4ab76f8e757af4.1574282259.git.dennis@kernel.org>
X-Mailer: git-send-email 2.13.5
In-Reply-To: <cover.1574282259.git.dennis@kernel.org>
References: <cover.1574282259.git.dennis@kernel.org>
In-Reply-To: <cover.1574282259.git.dennis@kernel.org>
References: <cover.1574282259.git.dennis@kernel.org>
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
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/block-group.c      |  50 +++++++++++++--
 fs/btrfs/ctree.h            |   9 ++-
 fs/btrfs/discard.c          | 117 +++++++++++++++++++++++++++++++++++-
 fs/btrfs/discard.h          |   6 ++
 fs/btrfs/free-space-cache.c |  34 +++++++++++
 fs/btrfs/free-space-cache.h |   1 +
 fs/btrfs/scrub.c            |   7 ++-
 7 files changed, 214 insertions(+), 10 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index d2bc46c365f4..aea2b2637d65 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -1250,6 +1250,7 @@ void btrfs_delete_unused_bgs(struct btrfs_fs_info *fs_info)
 	struct btrfs_block_group *block_group;
 	struct btrfs_space_info *space_info;
 	struct btrfs_trans_handle *trans;
+	bool async_trim_enabled = btrfs_test_opt(fs_info, DISCARD_ASYNC);
 	int ret = 0;
 
 	if (!test_bit(BTRFS_FS_OPEN, &fs_info->flags))
@@ -1259,6 +1260,7 @@ void btrfs_delete_unused_bgs(struct btrfs_fs_info *fs_info)
 	while (!list_empty(&fs_info->unused_bgs)) {
 		u64 start, end;
 		int trimming;
+		bool async_trimmed;
 
 		block_group = list_first_entry(&fs_info->unused_bgs,
 					       struct btrfs_block_group,
@@ -1280,9 +1282,23 @@ void btrfs_delete_unused_bgs(struct btrfs_fs_info *fs_info)
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
 		    block_group->used || block_group->ro ||
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
@@ -1365,6 +1381,17 @@ void btrfs_delete_unused_bgs(struct btrfs_fs_info *fs_info)
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
 
@@ -1409,6 +1436,13 @@ void btrfs_delete_unused_bgs(struct btrfs_fs_info *fs_info)
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
 
 void btrfs_mark_bg_unused(struct btrfs_block_group *bg)
@@ -1613,6 +1647,8 @@ static struct btrfs_block_group *btrfs_create_block_group_cache(
 	cache->full_stripe_len = btrfs_full_stripe_len(fs_info, start);
 	set_free_space_tree_thresholds(cache);
 
+	cache->discard_index = BTRFS_DISCARD_INDEX_UNUSED;
+
 	atomic_set(&cache->count, 1);
 	spin_lock_init(&cache->lock);
 	init_rwsem(&cache->data_rwsem);
@@ -1779,7 +1815,11 @@ static int read_one_block_group(struct btrfs_fs_info *info,
 		inc_block_group_ro(cache, 1);
 	} else if (cache->used == 0) {
 		ASSERT(list_empty(&cache->bg_list));
-		btrfs_mark_bg_unused(cache);
+		if (btrfs_test_opt(info, DISCARD_ASYNC))
+			btrfs_add_to_discard_unused_list(&info->discard_ctl,
+							 cache);
+		else
+			btrfs_mark_bg_unused(cache);
 	}
 	return 0;
 error:
@@ -2742,8 +2782,10 @@ int btrfs_update_block_group(struct btrfs_trans_handle *trans,
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
index d5ce8054f074..68340d65a8b6 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -443,9 +443,14 @@ struct btrfs_full_stripe_locks_tree {
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
index 15d54de3d682..e0f48d6de9a1 100644
--- a/fs/btrfs/discard.c
+++ b/fs/btrfs/discard.c
@@ -26,13 +26,33 @@ void btrfs_add_to_discard_list(struct btrfs_discard_ctl *discard_ctl,
 {
 	spin_lock(&discard_ctl->lock);
 
-	if (list_empty(&block_group->discard_list))
+	if (list_empty(&block_group->discard_list) ||
+	    block_group->discard_index == BTRFS_DISCARD_INDEX_UNUSED) {
+		if (block_group->discard_index == BTRFS_DISCARD_INDEX_UNUSED)
+			block_group->discard_index = BTRFS_DISCARD_INDEX_START;
 		block_group->discard_eligible_time = (ktime_get_ns() +
 						      BTRFS_DISCARD_DELAY);
+	}
 
 	list_move_tail(&block_group->discard_list,
 		       btrfs_get_discard_list(discard_ctl, block_group));
 
+spin_unlock(&discard_ctl->lock);
+}
+
+void btrfs_add_to_discard_unused_list(struct btrfs_discard_ctl *discard_ctl,
+				      struct btrfs_block_group *block_group)
+{
+	spin_lock(&discard_ctl->lock);
+
+	if (!list_empty(&block_group->discard_list))
+		list_del_init(&block_group->discard_list);
+
+	block_group->discard_index = BTRFS_DISCARD_INDEX_UNUSED;
+	block_group->discard_eligible_time = ktime_get_ns();
+	list_add_tail(&block_group->discard_list,
+		      &discard_ctl->discard_list[BTRFS_DISCARD_INDEX_UNUSED]);
+
 	spin_unlock(&discard_ctl->lock);
 }
 
@@ -151,7 +171,11 @@ void btrfs_discard_queue_work(struct btrfs_discard_ctl *discard_ctl,
 	    !btrfs_test_opt(block_group->fs_info, DISCARD_ASYNC))
 		return;
 
-	btrfs_add_to_discard_list(discard_ctl, block_group);
+	if (block_group->used == 0)
+		btrfs_add_to_discard_unused_list(discard_ctl, block_group);
+	else
+		btrfs_add_to_discard_list(discard_ctl, block_group);
+
 	if (!delayed_work_pending(&discard_ctl->work))
 		btrfs_discard_schedule_work(discard_ctl, false);
 }
@@ -196,6 +220,30 @@ void btrfs_discard_schedule_work(struct btrfs_discard_ctl *discard_ctl,
 	spin_unlock(&discard_ctl->lock);
 }
 
+/**
+ * btrfs_finish_discard_pass - determine next step of a block_group
+ * @discard_ctl: discard control
+ * @block_group: block_group of interest
+ *
+ * This determines the next step for a block group after it's finished going
+ * through a pass on a discard list.  If it is unused and fully trimmed, we can
+ * mark it unused and send it to the unused_bgs path.  Otherwise, pass it onto
+ * the appropriate filter list or let it fall off.
+ */
+static void btrfs_finish_discard_pass(struct btrfs_discard_ctl *discard_ctl,
+				      struct btrfs_block_group *block_group)
+{
+	remove_from_discard_list(discard_ctl, block_group);
+
+	if (block_group->used == 0) {
+		if (btrfs_is_free_space_trimmed(block_group))
+			btrfs_mark_bg_unused(block_group);
+		else
+			btrfs_add_to_discard_unused_list(discard_ctl,
+							 block_group);
+	}
+}
+
 /**
  * btrfs_discard_workfn - discard work function
  * @work: work
@@ -217,7 +265,7 @@ static void btrfs_discard_workfn(struct work_struct *work)
 	btrfs_trim_block_group(block_group, &trimmed, block_group->start,
 			       btrfs_block_group_end(block_group), 0);
 
-	remove_from_discard_list(discard_ctl, block_group);
+	btrfs_finish_discard_pass(discard_ctl, block_group);
 
 	btrfs_discard_schedule_work(discard_ctl, false);
 }
@@ -238,6 +286,65 @@ bool btrfs_run_discard_work(struct btrfs_discard_ctl *discard_ctl)
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
+	struct btrfs_block_group *block_group, *next;
+
+	spin_lock(&fs_info->unused_bgs_lock);
+
+	/* We enabled async discard, so punt all to the queue. */
+	list_for_each_entry_safe(block_group, next, &fs_info->unused_bgs,
+				 bg_list) {
+		list_del_init(&block_group->bg_list);
+		btrfs_add_to_discard_unused_list(&fs_info->discard_ctl,
+						 block_group);
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
+	struct btrfs_block_group *block_group, *next;
+	int i;
+
+	spin_lock(&discard_ctl->lock);
+
+	for (i = 0; i < BTRFS_NR_DISCARD_LISTS; i++) {
+		list_for_each_entry_safe(block_group, next,
+					 &discard_ctl->discard_list[i],
+					 discard_list) {
+			list_del_init(&block_group->discard_list);
+			spin_unlock(&discard_ctl->lock);
+			if (block_group->used == 0)
+				btrfs_mark_bg_unused(block_group);
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
@@ -245,6 +352,8 @@ void btrfs_discard_resume(struct btrfs_fs_info *fs_info)
 		return;
 	}
 
+	btrfs_discard_punt_unused_bgs_list(fs_info);
+
 	set_bit(BTRFS_FS_DISCARD_RUNNING, &fs_info->flags);
 }
 
@@ -270,4 +379,6 @@ void btrfs_discard_cleanup(struct btrfs_fs_info *fs_info)
 {
 	btrfs_discard_stop(fs_info);
 	cancel_delayed_work_sync(&fs_info->discard_ctl.work);
+
+	btrfs_discard_purge_list(&fs_info->discard_ctl);
 }
diff --git a/fs/btrfs/discard.h b/fs/btrfs/discard.h
index 439ca8c51877..b61ea684b48d 100644
--- a/fs/btrfs/discard.h
+++ b/fs/btrfs/discard.h
@@ -7,9 +7,13 @@ struct btrfs_fs_info;
 struct btrfs_discard_ctl;
 struct btrfs_block_group;
 
+/* List operations. */
 void btrfs_add_to_discard_list(struct btrfs_discard_ctl *discard_ctl,
 			       struct btrfs_block_group *block_group);
+void btrfs_add_to_discard_unused_list(struct btrfs_discard_ctl *discard_ctl,
+				      struct btrfs_block_group *block_group);
 
+/* Work operations. */
 void btrfs_discard_cancel_work(struct btrfs_discard_ctl *discard_ctl,
 			       struct btrfs_block_group *block_group);
 void btrfs_discard_queue_work(struct btrfs_discard_ctl *discard_ctl,
@@ -18,6 +22,8 @@ void btrfs_discard_schedule_work(struct btrfs_discard_ctl *discard_ctl,
 				 bool override);
 bool btrfs_run_discard_work(struct btrfs_discard_ctl *discard_ctl);
 
+/* Setup/Cleanup operations. */
+void btrfs_discard_punt_unused_bgs_list(struct btrfs_fs_info *fs_info);
 void btrfs_discard_resume(struct btrfs_fs_info *fs_info);
 void btrfs_discard_stop(struct btrfs_fs_info *fs_info);
 void btrfs_discard_init(struct btrfs_fs_info *fs_info);
diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
index 72933996e743..55d3d139c113 100644
--- a/fs/btrfs/free-space-cache.c
+++ b/fs/btrfs/free-space-cache.c
@@ -2684,6 +2684,37 @@ void btrfs_remove_free_space_cache(struct btrfs_block_group *block_group)
 
 }
 
+/**
+ * btrfs_is_free_space_trimmed - see if everything is trimmed
+ * @block_group: block_group of interest
+ *
+ * Walk @block_group's free space rb_tree to determine if everything is trimmed.
+ */
+bool btrfs_is_free_space_trimmed(struct btrfs_block_group *block_group)
+{
+	struct btrfs_free_space_ctl *ctl = block_group->free_space_ctl;
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
 u64 btrfs_find_space_for_alloc(struct btrfs_block_group *block_group,
 			       u64 offset, u64 bytes, u64 empty_size,
 			       u64 *max_extent_size)
@@ -2770,6 +2801,9 @@ int btrfs_return_cluster_to_free_space(
 	ret = __btrfs_return_cluster_to_free_space(block_group, cluster);
 	spin_unlock(&ctl->tree_lock);
 
+	btrfs_discard_queue_work(&block_group->fs_info->discard_ctl,
+				 block_group);
+
 	/* finally drop our ref */
 	btrfs_put_block_group(block_group);
 	return ret;
diff --git a/fs/btrfs/free-space-cache.h b/fs/btrfs/free-space-cache.h
index 29d16f58b40b..49ff6d6f333b 100644
--- a/fs/btrfs/free-space-cache.h
+++ b/fs/btrfs/free-space-cache.h
@@ -117,6 +117,7 @@ int btrfs_remove_free_space(struct btrfs_block_group *block_group,
 			    u64 bytenr, u64 size);
 void __btrfs_remove_free_space_cache(struct btrfs_free_space_ctl *ctl);
 void btrfs_remove_free_space_cache(struct btrfs_block_group *block_group);
+bool btrfs_is_free_space_trimmed(struct btrfs_block_group *block_group);
 u64 btrfs_find_space_for_alloc(struct btrfs_block_group *block_group,
 			       u64 offset, u64 bytes, u64 empty_size,
 			       u64 *max_extent_size);
diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index 21de630b0730..49b7afa38895 100644
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
@@ -3659,7 +3660,11 @@ int scrub_enumerate_chunks(struct scrub_ctx *sctx,
 		if (!cache->removed && !cache->ro && cache->reserved == 0 &&
 		    cache->used == 0) {
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

