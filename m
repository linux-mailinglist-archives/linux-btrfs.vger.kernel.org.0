Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2F6EBCED48
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Oct 2019 22:18:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729212AbfJGUSC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 7 Oct 2019 16:18:02 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:40868 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729119AbfJGUSB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 7 Oct 2019 16:18:01 -0400
Received: by mail-qt1-f196.google.com with SMTP id m61so10047476qte.7
        for <linux-btrfs@vger.kernel.org>; Mon, 07 Oct 2019 13:18:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=4zhJvEVozzXfi+Fj0SQVIfiRXkv+yyPRxFgZt5dIYbs=;
        b=nZ+BBDLZzmy7yCm9JMBHKhf5sNZVOulUPM3XLqQZMWrR0PjHIbpwQKDyJmcg4QTA4x
         nJnr8/Wp1OvF+7Og0ib/tplkaAmu+1o4YcOH4sWjPFk6vNSINnr+Nixt6oESGRpEL9+q
         mT0avfdAXRjRkl0Gg36RDldgSjAagVrMB7TmhcrELtYNC+B1igtD5x9R1lC2lI1Kzn9r
         JGjT2dunFOSF5iJaBAQL4gtsjPxOQdRJXeEiCxtLPj+EZoOFhQ9LusicgTEhGIAZtAoC
         D9Xz5vu6R7U5pOtNTlBOdSxM5RadNNkL7Z7nVf2As7PLXrMzR4qnYVGVz5e8QM2b8Rh7
         +rgw==
X-Gm-Message-State: APjAAAWmGHKoF8F1+mQ6SuNFxL9YWTibMs7F3l2JxgYqYBQ6QSxqZjUk
        kHXklJBZTXwjZmyvqYduEZo=
X-Google-Smtp-Source: APXvYqzL5kY/IztbiB4A7iIf0PpkGa+CLocoHkjcEja0pcGp1bBVlUk/eQ8cf8UUdgu4CxdZC+BTAw==
X-Received: by 2002:aed:27c1:: with SMTP id m1mr32171290qtg.197.1570479480128;
        Mon, 07 Oct 2019 13:18:00 -0700 (PDT)
Received: from dennisz-mbp.thefacebook.com ([163.114.130.128])
        by smtp.gmail.com with ESMTPSA id k2sm6904005qtm.42.2019.10.07.13.17.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 07 Oct 2019 13:17:59 -0700 (PDT)
From:   Dennis Zhou <dennis@kernel.org>
To:     David Sterba <dsterba@suse.com>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Omar Sandoval <osandov@osandov.com>
Cc:     kernel-team@fb.com, linux-btrfs@vger.kernel.org,
        Dennis Zhou <dennis@kernel.org>
Subject: [PATCH 06/19] btrfs: handle empty block_group removal
Date:   Mon,  7 Oct 2019 16:17:37 -0400
Message-Id: <a1d52aa93f0e9e36fcf89979664a55bccf1a0459.1570479299.git.dennis@kernel.org>
X-Mailer: git-send-email 2.13.5
In-Reply-To: <cover.1570479299.git.dennis@kernel.org>
References: <cover.1570479299.git.dennis@kernel.org>
In-Reply-To: <cover.1570479299.git.dennis@kernel.org>
References: <cover.1570479299.git.dennis@kernel.org>
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
discard queue first. Once it's processed, it will be placed on the
unusued_bgs list and then the original sequence of events will happen,
just without the final whole block_group discard.

The mount flags can change when processing unused_bgs, so when flipping
from DISCARD to DISCARD_ASYNC, the unused_bgs must be punted to the
discard_list to be trimmed. If we flip off DISCARD_ASYNC, we punt
free block groups on the discard_list to the unused_bg queue which will
do the final discard for us.

Signed-off-by: Dennis Zhou <dennis@kernel.org>
---
 fs/btrfs/block-group.c      | 39 ++++++++++++++++++---
 fs/btrfs/ctree.h            |  2 +-
 fs/btrfs/discard.c          | 68 ++++++++++++++++++++++++++++++++++++-
 fs/btrfs/discard.h          | 11 +++++-
 fs/btrfs/free-space-cache.c | 33 ++++++++++++++++++
 fs/btrfs/free-space-cache.h |  1 +
 fs/btrfs/scrub.c            |  7 +++-
 7 files changed, 153 insertions(+), 8 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 8bbbe7488328..73e5a9384491 100644
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
@@ -1281,10 +1283,20 @@ void btrfs_delete_unused_bgs(struct btrfs_fs_info *fs_info)
 		/* Don't want to race with allocators so take the groups_sem */
 		down_write(&space_info->groups_sem);
 		spin_lock(&block_group->lock);
+
+		/* async discard requires block groups to be fully trimmed */
+		async_trimmed = (!btrfs_test_opt(fs_info, DISCARD_ASYNC) ||
+				 btrfs_is_free_space_trimmed(block_group));
+
 		if (block_group->reserved || block_group->pinned ||
 		    btrfs_block_group_used(&block_group->item) ||
 		    block_group->ro ||
-		    list_is_singular(&block_group->list)) {
+		    list_is_singular(&block_group->list) ||
+		    !async_trimmed) {
+			/* requeue if we failed because of async discard */
+			if (!async_trimmed)
+				btrfs_discard_queue_work(&fs_info->discard_ctl,
+							 block_group);
 			/*
 			 * We want to bail if we made new allocations or have
 			 * outstanding allocations in this block group.  We do
@@ -1367,6 +1379,10 @@ void btrfs_delete_unused_bgs(struct btrfs_fs_info *fs_info)
 		spin_unlock(&block_group->lock);
 		spin_unlock(&space_info->lock);
 
+		if (!async_trim_enabled &&
+		    btrfs_test_opt(fs_info, DISCARD_ASYNC))
+			goto flip_async;
+
 		/* DISCARD can flip during remount */
 		trimming = btrfs_test_opt(fs_info, DISCARD_SYNC);
 
@@ -1411,6 +1427,13 @@ void btrfs_delete_unused_bgs(struct btrfs_fs_info *fs_info)
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
@@ -1618,6 +1641,8 @@ static struct btrfs_block_group_cache *btrfs_create_block_group_cache(
 	cache->full_stripe_len = btrfs_full_stripe_len(fs_info, start);
 	set_free_space_tree_thresholds(cache);
 
+	cache->discard_index = 1;
+
 	atomic_set(&cache->count, 1);
 	spin_lock_init(&cache->lock);
 	init_rwsem(&cache->data_rwsem);
@@ -1829,7 +1854,11 @@ int btrfs_read_block_groups(struct btrfs_fs_info *info)
 			inc_block_group_ro(cache, 1);
 		} else if (btrfs_block_group_used(&cache->item) == 0) {
 			ASSERT(list_empty(&cache->bg_list));
-			btrfs_mark_bg_unused(cache);
+			if (btrfs_test_opt(info, DISCARD_ASYNC))
+				btrfs_add_to_discard_free_list(
+						&info->discard_ctl, cache);
+			else
+				btrfs_mark_bg_unused(cache);
 		}
 	}
 
@@ -2724,8 +2753,10 @@ int btrfs_update_block_group(struct btrfs_trans_handle *trans,
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
index 419445868909..c328d2e85e4d 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -439,7 +439,7 @@ struct btrfs_full_stripe_locks_tree {
 };
 
 /* discard control */
-#define BTRFS_NR_DISCARD_LISTS		1
+#define BTRFS_NR_DISCARD_LISTS		2
 
 struct btrfs_discard_ctl {
 	struct workqueue_struct *discard_workers;
diff --git a/fs/btrfs/discard.c b/fs/btrfs/discard.c
index 6df124639e55..fb92b888774d 100644
--- a/fs/btrfs/discard.c
+++ b/fs/btrfs/discard.c
@@ -29,8 +29,11 @@ void btrfs_add_to_discard_list(struct btrfs_discard_ctl *discard_ctl,
 
 	spin_lock(&discard_ctl->lock);
 
-	if (list_empty(&cache->discard_list))
+	if (list_empty(&cache->discard_list) || !cache->discard_index) {
+		if (!cache->discard_index)
+			cache->discard_index = 1;
 		cache->discard_delay = now + BTRFS_DISCARD_DELAY;
+	}
 
 	list_move_tail(&cache->discard_list,
 		       btrfs_get_discard_list(discard_ctl, cache));
@@ -38,6 +41,23 @@ void btrfs_add_to_discard_list(struct btrfs_discard_ctl *discard_ctl,
 	spin_unlock(&discard_ctl->lock);
 }
 
+void btrfs_add_to_discard_free_list(struct btrfs_discard_ctl *discard_ctl,
+				    struct btrfs_block_group_cache *cache)
+{
+	u64 now = ktime_get_ns();
+
+	spin_lock(&discard_ctl->lock);
+
+	if (!list_empty(&cache->discard_list))
+		list_del_init(&cache->discard_list);
+
+	cache->discard_index = 0;
+	cache->discard_delay = now;
+	list_add_tail(&cache->discard_list, &discard_ctl->discard_list[0]);
+
+	spin_unlock(&discard_ctl->lock);
+}
+
 static bool remove_from_discard_list(struct btrfs_discard_ctl *discard_ctl,
 				     struct btrfs_block_group_cache *cache)
 {
@@ -161,10 +181,52 @@ static void btrfs_discard_workfn(struct work_struct *work)
 			       btrfs_block_group_end(cache), 0);
 
 	remove_from_discard_list(discard_ctl, cache);
+	if (btrfs_is_free_space_trimmed(cache))
+		btrfs_mark_bg_unused(cache);
+	else if (cache->free_space_ctl->free_space == cache->key.offset)
+		btrfs_add_to_discard_free_list(discard_ctl, cache);
 
 	btrfs_discard_schedule_work(discard_ctl, false);
 }
 
+void btrfs_discard_punt_unused_bgs_list(struct btrfs_fs_info *fs_info)
+{
+	struct btrfs_block_group_cache *cache, *next;
+
+	/* we enabled async discard, so punt all to the queue */
+	spin_lock(&fs_info->unused_bgs_lock);
+
+	list_for_each_entry_safe(cache, next, &fs_info->unused_bgs, bg_list) {
+		list_del_init(&cache->bg_list);
+		btrfs_add_to_discard_free_list(&fs_info->discard_ctl, cache);
+	}
+
+	spin_unlock(&fs_info->unused_bgs_lock);
+}
+
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
+			if (cache->free_space_ctl->free_space ==
+			    cache->key.offset)
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
@@ -172,6 +234,8 @@ void btrfs_discard_resume(struct btrfs_fs_info *fs_info)
 		return;
 	}
 
+	btrfs_discard_punt_unused_bgs_list(fs_info);
+
 	set_bit(BTRFS_FS_DISCARD_RUNNING, &fs_info->flags);
 }
 
@@ -197,4 +261,6 @@ void btrfs_discard_cleanup(struct btrfs_fs_info *fs_info)
 {
 	btrfs_discard_stop(fs_info);
 	cancel_delayed_work_sync(&fs_info->discard_ctl.work);
+
+	btrfs_discard_purge_list(&fs_info->discard_ctl);
 }
diff --git a/fs/btrfs/discard.h b/fs/btrfs/discard.h
index 6d7805bb0eb7..55f79b624943 100644
--- a/fs/btrfs/discard.h
+++ b/fs/btrfs/discard.h
@@ -10,9 +10,14 @@
 #include <linux/workqueue.h>
 
 #include "ctree.h"
+#include "block-group.h"
+#include "free-space-cache.h"
 
 void btrfs_add_to_discard_list(struct btrfs_discard_ctl *discard_ctl,
 			       struct btrfs_block_group_cache *cache);
+void btrfs_add_to_discard_free_list(struct btrfs_discard_ctl *discard_ctl,
+				    struct btrfs_block_group_cache *cache);
+void btrfs_discard_punt_unused_bgs_list(struct btrfs_fs_info *fs_info);
 
 void btrfs_discard_cancel_work(struct btrfs_discard_ctl *discard_ctl,
 			       struct btrfs_block_group_cache *cache);
@@ -41,7 +46,11 @@ void btrfs_discard_queue_work(struct btrfs_discard_ctl *discard_ctl,
 	if (!cache || !btrfs_test_opt(cache->fs_info, DISCARD_ASYNC))
 		return;
 
-	btrfs_add_to_discard_list(discard_ctl, cache);
+	if (cache->free_space_ctl->free_space == cache->key.offset)
+		btrfs_add_to_discard_free_list(discard_ctl, cache);
+	else
+		btrfs_add_to_discard_list(discard_ctl, cache);
+
 	if (!delayed_work_pending(&discard_ctl->work))
 		btrfs_discard_schedule_work(discard_ctl, false);
 }
diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
index 54ff1bc97777..ed0e7ee4c78d 100644
--- a/fs/btrfs/free-space-cache.c
+++ b/fs/btrfs/free-space-cache.c
@@ -2653,6 +2653,31 @@ void btrfs_remove_free_space_cache(struct btrfs_block_group_cache *block_group)
 
 }
 
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
@@ -2739,6 +2764,9 @@ int btrfs_return_cluster_to_free_space(
 	ret = __btrfs_return_cluster_to_free_space(block_group, cluster);
 	spin_unlock(&ctl->tree_lock);
 
+	btrfs_discard_queue_work(&block_group->fs_info->discard_ctl,
+				 block_group);
+
 	/* finally drop our ref */
 	btrfs_put_block_group(block_group);
 	return ret;
@@ -3097,6 +3125,7 @@ int btrfs_find_space_cluster(struct btrfs_block_group_cache *block_group,
 	u64 min_bytes;
 	u64 cont1_bytes;
 	int ret;
+	bool found_cluster = false;
 
 	/*
 	 * Choose the minimum extent size we'll require for this
@@ -3149,6 +3178,7 @@ int btrfs_find_space_cluster(struct btrfs_block_group_cache *block_group,
 		list_del_init(&entry->list);
 
 	if (!ret) {
+		found_cluster = true;
 		atomic_inc(&block_group->count);
 		list_add_tail(&cluster->block_group_list,
 			      &block_group->cluster_list);
@@ -3160,6 +3190,9 @@ int btrfs_find_space_cluster(struct btrfs_block_group_cache *block_group,
 	spin_unlock(&cluster->lock);
 	spin_unlock(&ctl->tree_lock);
 
+	if (found_cluster)
+		btrfs_discard_cancel_work(&fs_info->discard_ctl, block_group);
+
 	return ret;
 }
 
diff --git a/fs/btrfs/free-space-cache.h b/fs/btrfs/free-space-cache.h
index dc73ec8d34bb..b688e70a7512 100644
--- a/fs/btrfs/free-space-cache.h
+++ b/fs/btrfs/free-space-cache.h
@@ -107,6 +107,7 @@ int btrfs_remove_free_space(struct btrfs_block_group_cache *block_group,
 void __btrfs_remove_free_space_cache(struct btrfs_free_space_ctl *ctl);
 void btrfs_remove_free_space_cache(struct btrfs_block_group_cache
 				     *block_group);
+bool btrfs_is_free_space_trimmed(struct btrfs_block_group_cache *cache);
 u64 btrfs_find_space_for_alloc(struct btrfs_block_group_cache *block_group,
 			       u64 offset, u64 bytes, u64 empty_size,
 			       u64 *max_extent_size);
diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index f7d4e03f4c5d..49927a642b5a 100644
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
+				btrfs_add_to_discard_free_list(
+						&fs_info->discard_ctl, cache);
+			else
+				btrfs_mark_bg_unused(cache);
 		} else {
 			spin_unlock(&cache->lock);
 		}
-- 
2.17.1

