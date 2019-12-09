Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8E09111761E
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 Dec 2019 20:46:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726678AbfLITqS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 9 Dec 2019 14:46:18 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:36975 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726665AbfLITqS (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 9 Dec 2019 14:46:18 -0500
Received: by mail-pl1-f194.google.com with SMTP id c23so936080plz.4
        for <linux-btrfs@vger.kernel.org>; Mon, 09 Dec 2019 11:46:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=5VTdV49KK5ZhfZ9N+WDYioKCwy35p7TkEUZzs9DyRVQ=;
        b=i1st0eHQ3iWI+9kW0qvlhvVBJm/mSdp0Rqjo71sj+3GBod/1romusdOYb4oQe2jm1F
         haXh/nYWu8d1DodNeBE5GFZ+39ATpwf3hHSvIEcXV1KTGY+eDS5EXuNDHXcz1zuosI7l
         7NI6BKa9r7sIErFxsHm1aqaTvhPNr2HUjVFhj5tQd1+LQNLoeJF1Cmji7dDoLYHyT7kT
         qnM+ALQfKqenxbYc4SowxAoCIChjfpfNzEdlt0B0uHVgnhao7oSrvSu4jmDXG2m8p9sZ
         jPx0XTf6hlOznMWOZZvXDS4PPSQ16OndxGFQrYPN7bCMVYcIktuagZorsPUNiV2kZ43I
         lkPQ==
X-Gm-Message-State: APjAAAUxdmW9Gd8w6du4iDSMrKFGAHmCi9k0/pzhVmOrbBHJlbvYQUHm
        oPi0hgMQf11uMOLkeL5ozMw=
X-Google-Smtp-Source: APXvYqze8vVdlhWGGHmI1cHceNrXMlOPD0UpsoVZAft+L/nhsXiB3ixZtIgXlRfag3upOvMlThROGw==
X-Received: by 2002:a17:902:ba82:: with SMTP id k2mr31821090pls.238.1575920777106;
        Mon, 09 Dec 2019 11:46:17 -0800 (PST)
Received: from dennisz-mbp.thefacebook.com ([199.201.64.138])
        by smtp.gmail.com with ESMTPSA id b190sm282956pfg.66.2019.12.09.11.46.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 09 Dec 2019 11:46:16 -0800 (PST)
From:   Dennis Zhou <dennis@kernel.org>
To:     David Sterba <dsterba@suse.com>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Omar Sandoval <osandov@osandov.com>
Cc:     kernel-team@fb.com, linux-btrfs@vger.kernel.org,
        Dennis Zhou <dennis@kernel.org>
Subject: [PATCH 06/22] btrfs: handle empty block_group removal
Date:   Mon,  9 Dec 2019 11:45:51 -0800
Message-Id: <cf533ad1fb94db51f2eaa4ba819caf59b1b64a3a.1575919745.git.dennis@kernel.org>
X-Mailer: git-send-email 2.13.5
In-Reply-To: <cover.1575919745.git.dennis@kernel.org>
References: <cover.1575919745.git.dennis@kernel.org>
In-Reply-To: <cover.1575919745.git.dennis@kernel.org>
References: <cover.1575919745.git.dennis@kernel.org>
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
 fs/btrfs/block-group.c      |  49 +++++++++++++--
 fs/btrfs/ctree.h            |   9 ++-
 fs/btrfs/discard.c          | 120 +++++++++++++++++++++++++++++++++++-
 fs/btrfs/discard.h          |   3 +
 fs/btrfs/free-space-cache.c |  34 ++++++++++
 fs/btrfs/free-space-cache.h |   1 +
 fs/btrfs/scrub.c            |   7 ++-
 7 files changed, 213 insertions(+), 10 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index c1b1b59343bd..282961072b34 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -1246,6 +1246,7 @@ void btrfs_delete_unused_bgs(struct btrfs_fs_info *fs_info)
 	struct btrfs_block_group *block_group;
 	struct btrfs_space_info *space_info;
 	struct btrfs_trans_handle *trans;
+	bool async_trim_enabled = btrfs_test_opt(fs_info, DISCARD_ASYNC);
 	int ret = 0;
 
 	if (!test_bit(BTRFS_FS_OPEN, &fs_info->flags))
@@ -1255,6 +1256,7 @@ void btrfs_delete_unused_bgs(struct btrfs_fs_info *fs_info)
 	while (!list_empty(&fs_info->unused_bgs)) {
 		u64 start, end;
 		int trimming;
+		bool async_trimmed;
 
 		block_group = list_first_entry(&fs_info->unused_bgs,
 					       struct btrfs_block_group,
@@ -1276,9 +1278,23 @@ void btrfs_delete_unused_bgs(struct btrfs_fs_info *fs_info)
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
@@ -1378,6 +1394,17 @@ void btrfs_delete_unused_bgs(struct btrfs_fs_info *fs_info)
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
 
@@ -1422,6 +1449,13 @@ void btrfs_delete_unused_bgs(struct btrfs_fs_info *fs_info)
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
@@ -1626,6 +1660,8 @@ static struct btrfs_block_group *btrfs_create_block_group_cache(
 	cache->full_stripe_len = btrfs_full_stripe_len(fs_info, start);
 	set_free_space_tree_thresholds(cache);
 
+	cache->discard_index = BTRFS_DISCARD_INDEX_UNUSED;
+
 	atomic_set(&cache->count, 1);
 	spin_lock_init(&cache->lock);
 	init_rwsem(&cache->data_rwsem);
@@ -1792,7 +1828,10 @@ static int read_one_block_group(struct btrfs_fs_info *info,
 		inc_block_group_ro(cache, 1);
 	} else if (cache->used == 0) {
 		ASSERT(list_empty(&cache->bg_list));
-		btrfs_mark_bg_unused(cache);
+		if (btrfs_test_opt(info, DISCARD_ASYNC))
+			btrfs_discard_queue_work(&info->discard_ctl, cache);
+		else
+			btrfs_mark_bg_unused(cache);
 	}
 	return 0;
 error:
@@ -2755,8 +2794,10 @@ int btrfs_update_block_group(struct btrfs_trans_handle *trans,
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
index d67bbbb07925..2a116cdbffe7 100644
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
index 692d64025802..752b38642b6b 100644
--- a/fs/btrfs/discard.c
+++ b/fs/btrfs/discard.c
@@ -13,6 +13,7 @@
 
 /* This is an initial delay to give some chance for lba reuse. */
 #define BTRFS_DISCARD_DELAY		(120ULL * NSEC_PER_SEC)
+#define BTRFS_DISCARD_UNUSED_DELAY	(10ULL * NSEC_PER_SEC)
 
 static struct list_head *get_discard_list(struct btrfs_discard_ctl *discard_ctl,
 					  struct btrfs_block_group *block_group)
@@ -30,9 +31,13 @@ static void add_to_discard_list(struct btrfs_discard_ctl *discard_ctl,
 		return;
 	}
 
-	if (list_empty(&block_group->discard_list))
+	if (list_empty(&block_group->discard_list) ||
+	    block_group->discard_index == BTRFS_DISCARD_INDEX_UNUSED) {
+		if (block_group->discard_index == BTRFS_DISCARD_INDEX_UNUSED)
+			block_group->discard_index = BTRFS_DISCARD_INDEX_START;
 		block_group->discard_eligible_time = (ktime_get_ns() +
 						      BTRFS_DISCARD_DELAY);
+	}
 
 	list_move_tail(&block_group->discard_list,
 		       get_discard_list(discard_ctl, block_group));
@@ -40,6 +45,27 @@ static void add_to_discard_list(struct btrfs_discard_ctl *discard_ctl,
 	spin_unlock(&discard_ctl->lock);
 }
 
+static void add_to_discard_unused_list(struct btrfs_discard_ctl *discard_ctl,
+				       struct btrfs_block_group *block_group)
+{
+	spin_lock(&discard_ctl->lock);
+
+	if (!btrfs_run_discard_work(discard_ctl)) {
+		spin_unlock(&discard_ctl->lock);
+		return;
+	}
+
+	list_del_init(&block_group->discard_list);
+
+	block_group->discard_index = BTRFS_DISCARD_INDEX_UNUSED;
+	block_group->discard_eligible_time = (ktime_get_ns() +
+					      BTRFS_DISCARD_UNUSED_DELAY);
+	list_add_tail(&block_group->discard_list,
+		      &discard_ctl->discard_list[BTRFS_DISCARD_INDEX_UNUSED]);
+
+	spin_unlock(&discard_ctl->lock);
+}
+
 static bool remove_from_discard_list(struct btrfs_discard_ctl *discard_ctl,
 				     struct btrfs_block_group *block_group)
 {
@@ -155,7 +181,10 @@ void btrfs_discard_queue_work(struct btrfs_discard_ctl *discard_ctl,
 	    !btrfs_test_opt(block_group->fs_info, DISCARD_ASYNC))
 		return;
 
-	add_to_discard_list(discard_ctl, block_group);
+	if (block_group->used == 0)
+		add_to_discard_unused_list(discard_ctl, block_group);
+	else
+		add_to_discard_list(discard_ctl, block_group);
 
 	if (!delayed_work_pending(&discard_ctl->work))
 		btrfs_discard_schedule_work(discard_ctl, false);
@@ -201,6 +230,29 @@ void btrfs_discard_schedule_work(struct btrfs_discard_ctl *discard_ctl,
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
+			add_to_discard_unused_list(discard_ctl, block_group);
+	}
+}
+
 /**
  * btrfs_discard_workfn - discard work function
  * @work: work
@@ -222,7 +274,7 @@ static void btrfs_discard_workfn(struct work_struct *work)
 	btrfs_trim_block_group(block_group, &trimmed, block_group->start,
 			       btrfs_block_group_end(block_group), 0);
 
-	remove_from_discard_list(discard_ctl, block_group);
+	btrfs_finish_discard_pass(discard_ctl, block_group);
 
 	btrfs_discard_schedule_work(discard_ctl, false);
 }
@@ -243,6 +295,64 @@ bool btrfs_run_discard_work(struct btrfs_discard_ctl *discard_ctl)
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
+		btrfs_discard_queue_work(&fs_info->discard_ctl, block_group);
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
@@ -250,6 +360,8 @@ void btrfs_discard_resume(struct btrfs_fs_info *fs_info)
 		return;
 	}
 
+	btrfs_discard_punt_unused_bgs_list(fs_info);
+
 	set_bit(BTRFS_FS_DISCARD_RUNNING, &fs_info->flags);
 }
 
@@ -275,4 +387,6 @@ void btrfs_discard_cleanup(struct btrfs_fs_info *fs_info)
 {
 	btrfs_discard_stop(fs_info);
 	cancel_delayed_work_sync(&fs_info->discard_ctl.work);
+
+	btrfs_discard_purge_list(&fs_info->discard_ctl);
 }
diff --git a/fs/btrfs/discard.h b/fs/btrfs/discard.h
index f3775e84d35a..a13eb9d86ccf 100644
--- a/fs/btrfs/discard.h
+++ b/fs/btrfs/discard.h
@@ -7,6 +7,7 @@ struct btrfs_fs_info;
 struct btrfs_discard_ctl;
 struct btrfs_block_group;
 
+/* Work operations. */
 void btrfs_discard_cancel_work(struct btrfs_discard_ctl *discard_ctl,
 			       struct btrfs_block_group *block_group);
 void btrfs_discard_queue_work(struct btrfs_discard_ctl *discard_ctl,
@@ -15,6 +16,8 @@ void btrfs_discard_schedule_work(struct btrfs_discard_ctl *discard_ctl,
 				 bool override);
 bool btrfs_run_discard_work(struct btrfs_discard_ctl *discard_ctl);
 
+/* Setup/Cleanup operations. */
+void btrfs_discard_punt_unused_bgs_list(struct btrfs_fs_info *fs_info);
 void btrfs_discard_resume(struct btrfs_fs_info *fs_info);
 void btrfs_discard_stop(struct btrfs_fs_info *fs_info);
 void btrfs_discard_init(struct btrfs_fs_info *fs_info);
diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
index 0a868b6df893..af0092cafc85 100644
--- a/fs/btrfs/free-space-cache.c
+++ b/fs/btrfs/free-space-cache.c
@@ -2708,6 +2708,37 @@ void btrfs_remove_free_space_cache(struct btrfs_block_group *block_group)
 
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
@@ -2794,6 +2825,9 @@ int btrfs_return_cluster_to_free_space(
 	ret = __btrfs_return_cluster_to_free_space(block_group, cluster);
 	spin_unlock(&ctl->tree_lock);
 
+	btrfs_discard_queue_work(&block_group->fs_info->discard_ctl,
+				 block_group);
+
 	/* finally drop our ref */
 	btrfs_put_block_group(block_group);
 	return ret;
diff --git a/fs/btrfs/free-space-cache.h b/fs/btrfs/free-space-cache.h
index a88c30cb3b2b..3100c7d5e646 100644
--- a/fs/btrfs/free-space-cache.h
+++ b/fs/btrfs/free-space-cache.h
@@ -119,6 +119,7 @@ int btrfs_remove_free_space(struct btrfs_block_group *block_group,
 			    u64 bytenr, u64 size);
 void __btrfs_remove_free_space_cache(struct btrfs_free_space_ctl *ctl);
 void btrfs_remove_free_space_cache(struct btrfs_block_group *block_group);
+bool btrfs_is_free_space_trimmed(struct btrfs_block_group *block_group);
 u64 btrfs_find_space_for_alloc(struct btrfs_block_group *block_group,
 			       u64 offset, u64 bytes, u64 empty_size,
 			       u64 *max_extent_size);
diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index 21de630b0730..22cf69e6e5bc 100644
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
+				btrfs_discard_queue_work(&fs_info->discard_ctl,
+							 cache);
+			else
+				btrfs_mark_bg_unused(cache);
 		} else {
 			spin_unlock(&cache->lock);
 		}
-- 
2.17.1

