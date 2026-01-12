Return-Path: <linux-btrfs+bounces-20412-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ACA47D13F1C
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 Jan 2026 17:20:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6086C303E401
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 Jan 2026 16:17:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02018364049;
	Mon, 12 Jan 2026 16:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=urbackup.org header.i=@urbackup.org header.b="lfKfnyY6";
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="m9PMHYJt"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from a4-1.smtp-out.eu-west-1.amazonses.com (a4-1.smtp-out.eu-west-1.amazonses.com [54.240.4.1])
	(using TLSv1.2 with cipher AES128-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A6C335F8A6
	for <linux-btrfs@vger.kernel.org>; Mon, 12 Jan 2026 16:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.240.4.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768234640; cv=none; b=eDA26GfeZnTukKZGfCjfY9ZdB9R67qwfO8cSM0F3jFXO48hzQ6HK5aFBeCSwTdJS/FOLoCn6KTaiD33m48CnzeIdDgb/C20y1dQJKq6Ht77m9EIg97N4F5fCLOC5llf+d/OUycV7x02jfySv3H8uG3+1WClybZWhJ0PCoSbakEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768234640; c=relaxed/simple;
	bh=Ilr01J3TwcQgER0hrYLat92nuZWMKIn8cytbvqrHkhU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j7TuEIo2mIfbWXi2BguTk3OdlUG0rnji7pye7GxY8837g2datxA20jPw1mgAw21iNCcvT/qiWNDBFyki1ECv+Atls5PH65Bk+AxCMTMSYBHlBGGRGhtexVKP+AKzRTCMyYYaFxm03i648ATqTXLtr8Vce/FKCoyfBNoR21i/cX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=urbackup.org; spf=pass smtp.mailfrom=bounce.urbackup.org; dkim=pass (1024-bit key) header.d=urbackup.org header.i=@urbackup.org header.b=lfKfnyY6; dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b=m9PMHYJt; arc=none smtp.client-ip=54.240.4.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=urbackup.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bounce.urbackup.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=ob2ngmaigrjtzxgmrxn2h6b3gszyqty3; d=urbackup.org; t=1768234637;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=Ilr01J3TwcQgER0hrYLat92nuZWMKIn8cytbvqrHkhU=;
	b=lfKfnyY6YwcGDtNX6DXKdMKlAQ9xkUWkcR5HrNr2oClI2KUAwnbjicvyURwSu215
	kxCtehbWcbs9qYPNKgSMhHk2gH8Hotjbfq9inKpocuq37s99OVzqWEoatpB1WBLIElT
	2fkE9NmeR6+E12fMl/mzjaBwCYAAFhIhHrCjXr9U=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=ihchhvubuqgjsxyuhssfvqohv7z3u4hn; d=amazonses.com; t=1768234637;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Feedback-ID;
	bh=Ilr01J3TwcQgER0hrYLat92nuZWMKIn8cytbvqrHkhU=;
	b=m9PMHYJtDG+7iNIUfh95AlyMb8Benu6EmktOj0bwjCaw8PbOnOpZ+k+qAEsbaRtn
	o6v2N/33dgFfwegG9xzwpBmEP/MxpX5UsmKO614YX8oNCclSP1QHjImWqeu4F5GZih5
	MkGYT9l8KY2eXf92QRm48gA9qLPyh5LMtYMtRmkI=
From: Martin Raiber <martin@urbackup.org>
To: linux-btrfs@vger.kernel.org
Cc: Martin Raiber <martin@urbackup.org>
Subject: [PATCH 1/7] btrfs: Use percpu refcounting for block groups
Date: Mon, 12 Jan 2026 16:17:16 +0000
Message-ID: <0102019bb2ff56b7-9302e783-c17d-452d-b6a7-11f773776ae7-000000@eu-west-1.amazonses.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260112161549.2786827-1-martin@urbackup.org>
References: <20260112161549.2786827-1-martin@urbackup.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Feedback-ID: ::1.eu-west-1.zKMZH6MF2g3oUhhjaE2f3oQ8IBjABPbvixQzV8APwT0=:AmazonSES
X-SES-Outgoing: 2026.01.12-54.240.4.1

Use a percpu counter to keep track of the block group refs.
This prevents CPU synchronization completely as long as the main reference
is not freed via btrfs_remove_block_group, improving performance of
btrfs_put_block_group, btrfs_get_block_group significantly.

Signed-off-by: Martin Raiber <martin@urbackup.org>
---
 fs/btrfs/block-group.c | 111 +++++++++++++++++++++++------------------
 fs/btrfs/block-group.h |   2 +-
 2 files changed, 63 insertions(+), 50 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index a1119f06b6d1..7569438ccbd5 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -153,37 +153,44 @@ u64 btrfs_get_alloc_profile(struct btrfs_fs_info *fs_info, u64 orig_flags)
 
 void btrfs_get_block_group(struct btrfs_block_group *cache)
 {
-	refcount_inc(&cache->refs);
+	percpu_ref_get(&cache->refs);
 }
 
-void btrfs_put_block_group(struct btrfs_block_group *cache)
+static void btrfs_free_block_group(struct percpu_ref *ref)
 {
-	if (refcount_dec_and_test(&cache->refs)) {
-		WARN_ON(cache->pinned > 0);
-		/*
-		 * If there was a failure to cleanup a log tree, very likely due
-		 * to an IO failure on a writeback attempt of one or more of its
-		 * extent buffers, we could not do proper (and cheap) unaccounting
-		 * of their reserved space, so don't warn on reserved > 0 in that
-		 * case.
-		 */
-		if (!(cache->flags & BTRFS_BLOCK_GROUP_METADATA) ||
-		    !BTRFS_FS_LOG_CLEANUP_ERROR(cache->fs_info))
-			WARN_ON(cache->reserved > 0);
+	struct btrfs_block_group *cache =
+		container_of(ref, struct btrfs_block_group, refs);
 
-		/*
-		 * A block_group shouldn't be on the discard_list anymore.
-		 * Remove the block_group from the discard_list to prevent us
-		 * from causing a panic due to NULL pointer dereference.
-		 */
-		if (WARN_ON(!list_empty(&cache->discard_list)))
-			btrfs_discard_cancel_work(&cache->fs_info->discard_ctl,
-						  cache);
+	WARN_ON(cache->pinned > 0);
+	/*
+	* If there was a failure to cleanup a log tree, very likely due
+	* to an IO failure on a writeback attempt of one or more of its
+	* extent buffers, we could not do proper (and cheap) unaccounting
+	* of their reserved space, so don't warn on reserved > 0 in that
+	* case.
+	*/
+	if (!(cache->flags & BTRFS_BLOCK_GROUP_METADATA) ||
+		!BTRFS_FS_LOG_CLEANUP_ERROR(cache->fs_info))
+		WARN_ON(cache->reserved > 0);
 
-		kfree(cache->free_space_ctl);
-		btrfs_free_chunk_map(cache->physical_map);
-		kfree(cache);
-	}
+	/*
+	* A block_group shouldn't be on the discard_list anymore.
+	* Remove the block_group from the discard_list to prevent us
+	* from causing a panic due to NULL pointer dereference.
+	*/
+	if (WARN_ON(!list_empty(&cache->discard_list)))
+		btrfs_discard_cancel_work(&cache->fs_info->discard_ctl,
+						cache);
+
+	percpu_ref_exit(&cache->refs);
+	kfree(cache->free_space_ctl);
+	btrfs_free_chunk_map(cache->physical_map);
+	kfree(cache);
+}
+
+void btrfs_put_block_group(struct btrfs_block_group *cache)
+{
+	percpu_ref_put(&cache->refs);
 }
 
 static int btrfs_bg_start_cmp(const struct rb_node *new,
@@ -406,8 +413,8 @@ void btrfs_wait_block_group_reservations(struct btrfs_block_group *bg)
 	 * on the groups' semaphore is held and decremented after releasing
 	 * the read access on that semaphore and creating the ordered extent.
 	 */
-	down_write(&space_info->groups_sem);
-	up_write(&space_info->groups_sem);
+	percpu_down_write(&space_info->groups_sem);
+	percpu_up_write(&space_info->groups_sem);
 
 	wait_var_event(&bg->reservations, !atomic_read(&bg->reservations));
 }
@@ -1012,7 +1019,7 @@ static void clear_incompat_bg_bits(struct btrfs_fs_info *fs_info, u64 flags)
 		struct btrfs_space_info *sinfo;
 
 		list_for_each_entry_rcu(sinfo, head, list) {
-			down_read(&sinfo->groups_sem);
+			percpu_down_read(&sinfo->groups_sem);
 			if (!list_empty(&sinfo->block_groups[BTRFS_RAID_RAID5]))
 				found_raid56 = true;
 			if (!list_empty(&sinfo->block_groups[BTRFS_RAID_RAID6]))
@@ -1021,7 +1028,7 @@ static void clear_incompat_bg_bits(struct btrfs_fs_info *fs_info, u64 flags)
 				found_raid1c34 = true;
 			if (!list_empty(&sinfo->block_groups[BTRFS_RAID_RAID1C4]))
 				found_raid1c34 = true;
-			up_read(&sinfo->groups_sem);
+			percpu_up_read(&sinfo->groups_sem);
 		}
 		if (!found_raid56)
 			btrfs_clear_fs_incompat(fs_info, RAID56);
@@ -1159,11 +1166,11 @@ int btrfs_remove_block_group(struct btrfs_trans_handle *trans,
 	RB_CLEAR_NODE(&block_group->cache_node);
 
 	/* Once for the block groups rbtree */
-	btrfs_put_block_group(block_group);
+	percpu_ref_kill(&block_group->refs);
 
 	write_unlock(&fs_info->block_group_cache_lock);
 
-	down_write(&block_group->space_info->groups_sem);
+	percpu_down_write(&block_group->space_info->groups_sem);
 	/*
 	 * we must use list_del_init so people can check to see if they
 	 * are still on the list after taking the semaphore
@@ -1174,7 +1181,7 @@ int btrfs_remove_block_group(struct btrfs_trans_handle *trans,
 		block_group->space_info->block_group_kobjs[index] = NULL;
 		clear_avail_alloc_bits(fs_info, block_group->flags);
 	}
-	up_write(&block_group->space_info->groups_sem);
+	percpu_up_write(&block_group->space_info->groups_sem);
 	clear_incompat_bg_bits(fs_info, block_group->flags);
 	if (kobj) {
 		kobject_del(kobj);
@@ -1544,7 +1551,7 @@ void btrfs_delete_unused_bgs(struct btrfs_fs_info *fs_info)
 		btrfs_discard_cancel_work(&fs_info->discard_ctl, block_group);
 
 		/* Don't want to race with allocators so take the groups_sem */
-		down_write(&space_info->groups_sem);
+		percpu_down_write(&space_info->groups_sem);
 
 		/*
 		 * Async discard moves the final block group discard to be prior
@@ -1554,7 +1561,7 @@ void btrfs_delete_unused_bgs(struct btrfs_fs_info *fs_info)
 		if (btrfs_test_opt(fs_info, DISCARD_ASYNC) &&
 		    !btrfs_is_free_space_trimmed(block_group)) {
 			trace_btrfs_skip_unused_block_group(block_group);
-			up_write(&space_info->groups_sem);
+			percpu_up_write(&space_info->groups_sem);
 			/* Requeue if we failed because of async discard */
 			btrfs_discard_queue_work(&fs_info->discard_ctl,
 						 block_group);
@@ -1581,7 +1588,7 @@ void btrfs_delete_unused_bgs(struct btrfs_fs_info *fs_info)
 			trace_btrfs_skip_unused_block_group(block_group);
 			spin_unlock(&block_group->lock);
 			spin_unlock(&space_info->lock);
-			up_write(&space_info->groups_sem);
+			percpu_up_write(&space_info->groups_sem);
 			goto next;
 		}
 
@@ -1618,7 +1625,7 @@ void btrfs_delete_unused_bgs(struct btrfs_fs_info *fs_info)
 			trace_btrfs_skip_unused_block_group(block_group);
 			spin_unlock(&block_group->lock);
 			spin_unlock(&space_info->lock);
-			up_write(&space_info->groups_sem);
+			percpu_up_write(&space_info->groups_sem);
 			goto next;
 		}
 
@@ -1627,7 +1634,7 @@ void btrfs_delete_unused_bgs(struct btrfs_fs_info *fs_info)
 
 		/* We don't want to force the issue, only flip if it's ok. */
 		ret = inc_block_group_ro(block_group, 0);
-		up_write(&space_info->groups_sem);
+		percpu_up_write(&space_info->groups_sem);
 		if (ret < 0) {
 			ret = 0;
 			goto next;
@@ -1882,7 +1889,7 @@ void btrfs_reclaim_bgs_work(struct work_struct *work)
 		spin_unlock(&fs_info->unused_bgs_lock);
 
 		/* Don't race with allocators so take the groups_sem */
-		down_write(&space_info->groups_sem);
+		percpu_down_write(&space_info->groups_sem);
 
 		spin_lock(&space_info->lock);
 		spin_lock(&bg->lock);
@@ -1895,7 +1902,7 @@ void btrfs_reclaim_bgs_work(struct work_struct *work)
 			 */
 			spin_unlock(&bg->lock);
 			spin_unlock(&space_info->lock);
-			up_write(&space_info->groups_sem);
+			percpu_up_write(&space_info->groups_sem);
 			goto next;
 		}
 		if (bg->used == 0) {
@@ -1914,7 +1921,7 @@ void btrfs_reclaim_bgs_work(struct work_struct *work)
 				btrfs_mark_bg_unused(bg);
 			spin_unlock(&bg->lock);
 			spin_unlock(&space_info->lock);
-			up_write(&space_info->groups_sem);
+			percpu_up_write(&space_info->groups_sem);
 			goto next;
 
 		}
@@ -1931,7 +1938,7 @@ void btrfs_reclaim_bgs_work(struct work_struct *work)
 		if (!should_reclaim_block_group(bg, bg->length)) {
 			spin_unlock(&bg->lock);
 			spin_unlock(&space_info->lock);
-			up_write(&space_info->groups_sem);
+			percpu_up_write(&space_info->groups_sem);
 			goto next;
 		}
 
@@ -1947,12 +1954,12 @@ void btrfs_reclaim_bgs_work(struct work_struct *work)
 		 * never gets back to read-write to let us reclaim again.
 		 */
 		if (btrfs_need_cleaner_sleep(fs_info)) {
-			up_write(&space_info->groups_sem);
+			percpu_up_write(&space_info->groups_sem);
 			goto next;
 		}
 
 		ret = inc_block_group_ro(bg, 0);
-		up_write(&space_info->groups_sem);
+		percpu_up_write(&space_info->groups_sem);
 		if (ret < 0)
 			goto next;
 
@@ -2288,7 +2295,12 @@ static struct btrfs_block_group *btrfs_create_block_group(
 
 	cache->discard_index = BTRFS_DISCARD_INDEX_UNUSED;
 
-	refcount_set(&cache->refs, 1);
+	if (percpu_ref_init(&cache->refs, btrfs_free_block_group,
+			  0, GFP_NOFS)) {
+		kfree(cache->free_space_ctl);
+		kfree(cache);
+		return NULL;
+	}
 	spin_lock_init(&cache->lock);
 	init_rwsem(&cache->data_rwsem);
 	INIT_LIST_HEAD(&cache->list);
@@ -4550,9 +4562,9 @@ int btrfs_free_block_groups(struct btrfs_fs_info *info)
 		RB_CLEAR_NODE(&block_group->cache_node);
 		write_unlock(&info->block_group_cache_lock);
 
-		down_write(&block_group->space_info->groups_sem);
+		percpu_down_write(&block_group->space_info->groups_sem);
 		list_del(&block_group->list);
-		up_write(&block_group->space_info->groups_sem);
+		percpu_up_write(&block_group->space_info->groups_sem);
 
 		/*
 		 * We haven't cached this block group, which means we could
@@ -4567,9 +4579,10 @@ int btrfs_free_block_groups(struct btrfs_fs_info *info)
 		ASSERT(list_empty(&block_group->dirty_list));
 		ASSERT(list_empty(&block_group->io_list));
 		ASSERT(list_empty(&block_group->bg_list));
-		ASSERT(refcount_read(&block_group->refs) == 1);
+		ASSERT(!percpu_ref_is_zero(&block_group->refs));
 		ASSERT(block_group->swap_extents == 0);
-		btrfs_put_block_group(block_group);
+		percpu_ref_kill(&block_group->refs);
+		ASSERT(percpu_ref_is_zero(&block_group->refs));
 
 		write_lock(&info->block_group_cache_lock);
 	}
diff --git a/fs/btrfs/block-group.h b/fs/btrfs/block-group.h
index 5f933455118c..d44675f9d601 100644
--- a/fs/btrfs/block-group.h
+++ b/fs/btrfs/block-group.h
@@ -178,7 +178,7 @@ struct btrfs_block_group {
 	/* For block groups in the same raid type */
 	struct list_head list;
 
-	refcount_t refs;
+	struct percpu_ref refs;
 
 	/*
 	 * List of struct btrfs_free_clusters for this block group.
-- 
2.39.5


