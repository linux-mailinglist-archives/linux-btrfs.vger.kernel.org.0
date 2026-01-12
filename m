Return-Path: <linux-btrfs+bounces-20414-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EEC6ED13F2E
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 Jan 2026 17:20:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 968AB30AF54E
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 Jan 2026 16:17:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 208FB364E92;
	Mon, 12 Jan 2026 16:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=urbackup.org header.i=@urbackup.org header.b="jE8dsgkw";
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="bK4D5t/0"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from a4-2.smtp-out.eu-west-1.amazonses.com (a4-2.smtp-out.eu-west-1.amazonses.com [54.240.4.2])
	(using TLSv1.2 with cipher AES128-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 824B3364EA2
	for <linux-btrfs@vger.kernel.org>; Mon, 12 Jan 2026 16:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.240.4.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768234641; cv=none; b=Shytl9YSATgotJQW21Hwmv/OEOtI538R5j0xRBh18TY2EOtUsEZwl9hXgU0SP9eNrWhv+Lr3/kEKcZKrUYtt3WxYUp6G2up/9ovYy29f6nCd8BtSBmZPSYjNkjfVxaKgqUFDjDEw/3a4AHwAfzS87WQQMZNoawgAIpcHgDyjq6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768234641; c=relaxed/simple;
	bh=KAzcaw/7XmxKH3C3gfi56B+uMDPTh7sM+vG9mVvUB9w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OC1Hpq3LVcTeNSIc6dJLmRRaocJEYRCDKvCsnAmkltTDlJo3qAW67eggxKU1faZHfFSD1PNKOg0yzYLb2qd38ccv3vNSG7Gb56GTaZclzDzcBXVT07FcfN4m9CRxF0PcD3SW8087UZpgz3bxtOfb/880I4XAefczmNFMXBI+8wI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=urbackup.org; spf=pass smtp.mailfrom=bounce.urbackup.org; dkim=pass (1024-bit key) header.d=urbackup.org header.i=@urbackup.org header.b=jE8dsgkw; dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b=bK4D5t/0; arc=none smtp.client-ip=54.240.4.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=urbackup.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bounce.urbackup.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=ob2ngmaigrjtzxgmrxn2h6b3gszyqty3; d=urbackup.org; t=1768234638;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=KAzcaw/7XmxKH3C3gfi56B+uMDPTh7sM+vG9mVvUB9w=;
	b=jE8dsgkw9R46vijbCjjZ7jCllGhjj5izgRouLt6LhFH4C9vFNHFKRNpvJ7qwUjVb
	QDtnbKAXmelpsZvUnL0kOW1Z+3Zh0AihBnJYF6IeyoG0A97K9OuDvs8LWda4XBy55HA
	Jhm8h+NbrJEJa6HU5clcmGaA9qlHeH4PO9NwwxWg=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=ihchhvubuqgjsxyuhssfvqohv7z3u4hn; d=amazonses.com; t=1768234638;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Feedback-ID;
	bh=KAzcaw/7XmxKH3C3gfi56B+uMDPTh7sM+vG9mVvUB9w=;
	b=bK4D5t/0FiExpqy5MLmL/PY3BFIyOykvJZqkjluSuUc2X4+BGiRgK9+JSGuBUWdx
	CakzUOE2MpbzVoy8j9D9XpbyU6bsbAuu/U02fQXvxV/YnuxW4JbUrQ7RXSxGw2wToGJ
	ktVX43Lwv/f1I3tAj3xSTZo84zmZamxCM1w1/YvY=
From: Martin Raiber <martin@urbackup.org>
To: linux-btrfs@vger.kernel.org
Cc: Martin Raiber <martin@urbackup.org>
Subject: [PATCH 4/7] btrfs: Use percpu sem for block_group_cache_lock
Date: Mon, 12 Jan 2026 16:17:18 +0000
Message-ID: <0102019bb2ff5ada-4fba6833-dcae-406c-bd97-137232b6d2f4-000000@eu-west-1.amazonses.com>
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
X-SES-Outgoing: 2026.01.12-54.240.4.2

block_group_cache_lock is only locked for write when adding or
removing a block group which is rare, whereas it is locked for
read frequently on every find_free_extent via e.g. first_logical_byte.
Convert it to a percpu rwsem to improve performance
significantly.

Signed-off-by: Martin Raiber <martin@urbackup.org>
---
 fs/btrfs/block-group.c | 38 +++++++++++++++++++-------------------
 fs/btrfs/disk-io.c     |  6 +++++-
 fs/btrfs/extent-tree.c |  4 ++--
 fs/btrfs/fs.h          |  2 +-
 4 files changed, 27 insertions(+), 23 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index d9ea62c32587..702b8e7a67a4 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -219,13 +219,13 @@ static int btrfs_add_block_group_cache(struct btrfs_block_group *block_group)
 
 	ASSERT(block_group->length != 0);
 
-	write_lock(&fs_info->block_group_cache_lock);
+	percpu_down_write(&fs_info->block_group_cache_lock);
 
 	exist = rb_find_add_cached(&block_group->cache_node,
 			&fs_info->block_group_cache_tree, btrfs_bg_start_cmp);
 	if (exist)
 		ret = -EEXIST;
-	write_unlock(&fs_info->block_group_cache_lock);
+	percpu_up_write(&fs_info->block_group_cache_lock);
 
 	return ret;
 }
@@ -241,7 +241,7 @@ static struct btrfs_block_group *block_group_cache_tree_search(
 	struct rb_node *n;
 	u64 end, start;
 
-	read_lock(&info->block_group_cache_lock);
+	percpu_down_read(&info->block_group_cache_lock);
 	n = info->block_group_cache_tree.rb_root.rb_node;
 
 	while (n) {
@@ -266,7 +266,7 @@ static struct btrfs_block_group *block_group_cache_tree_search(
 	}
 	if (ret)
 		btrfs_get_block_group(ret);
-	read_unlock(&info->block_group_cache_lock);
+	percpu_up_read(&info->block_group_cache_lock);
 
 	return ret;
 }
@@ -295,13 +295,13 @@ struct btrfs_block_group *btrfs_next_block_group(
 	struct btrfs_fs_info *fs_info = cache->fs_info;
 	struct rb_node *node;
 
-	read_lock(&fs_info->block_group_cache_lock);
+	percpu_down_read(&fs_info->block_group_cache_lock);
 
 	/* If our block group was removed, we need a full search. */
 	if (RB_EMPTY_NODE(&cache->cache_node)) {
 		const u64 next_bytenr = cache->start + cache->length;
 
-		read_unlock(&fs_info->block_group_cache_lock);
+		percpu_up_read(&fs_info->block_group_cache_lock);
 		btrfs_put_block_group(cache);
 		return btrfs_lookup_first_block_group(fs_info, next_bytenr);
 	}
@@ -312,7 +312,7 @@ struct btrfs_block_group *btrfs_next_block_group(
 		btrfs_get_block_group(cache);
 	} else
 		cache = NULL;
-	read_unlock(&fs_info->block_group_cache_lock);
+	percpu_up_read(&fs_info->block_group_cache_lock);
 	return cache;
 }
 
@@ -967,10 +967,10 @@ int btrfs_cache_block_group(struct btrfs_block_group *cache, bool wait)
 	cache->cached = BTRFS_CACHE_STARTED;
 	spin_unlock(&cache->lock);
 
-	write_lock(&fs_info->block_group_cache_lock);
+	percpu_down_write(&fs_info->block_group_cache_lock);
 	refcount_inc(&caching_ctl->count);
 	list_add_tail(&caching_ctl->list, &fs_info->caching_block_groups);
-	write_unlock(&fs_info->block_group_cache_lock);
+	percpu_up_write(&fs_info->block_group_cache_lock);
 
 	btrfs_get_block_group(cache);
 
@@ -1160,7 +1160,7 @@ int btrfs_remove_block_group(struct btrfs_trans_handle *trans,
 	if (ret)
 		goto out;
 
-	write_lock(&fs_info->block_group_cache_lock);
+	percpu_down_write(&fs_info->block_group_cache_lock);
 	rb_erase_cached(&block_group->cache_node,
 			&fs_info->block_group_cache_tree);
 	RB_CLEAR_NODE(&block_group->cache_node);
@@ -1168,7 +1168,7 @@ int btrfs_remove_block_group(struct btrfs_trans_handle *trans,
 	/* Once for the block groups rbtree */
 	percpu_ref_kill(&block_group->refs);
 
-	write_unlock(&fs_info->block_group_cache_lock);
+	percpu_up_write(&fs_info->block_group_cache_lock);
 
 	percpu_down_write(&block_group->space_info->groups_sem);
 	/*
@@ -1191,7 +1191,7 @@ int btrfs_remove_block_group(struct btrfs_trans_handle *trans,
 	if (block_group->cached == BTRFS_CACHE_STARTED)
 		btrfs_wait_block_group_cache_done(block_group);
 
-	write_lock(&fs_info->block_group_cache_lock);
+	percpu_down_write(&fs_info->block_group_cache_lock);
 	caching_ctl = btrfs_get_caching_control(block_group);
 	if (!caching_ctl) {
 		struct btrfs_caching_control *ctl;
@@ -1206,7 +1206,7 @@ int btrfs_remove_block_group(struct btrfs_trans_handle *trans,
 	}
 	if (caching_ctl)
 		list_del_init(&caching_ctl->list);
-	write_unlock(&fs_info->block_group_cache_lock);
+	percpu_up_write(&fs_info->block_group_cache_lock);
 
 	if (caching_ctl) {
 		/* Once for the caching bgs list and once for us. */
@@ -4519,14 +4519,14 @@ int btrfs_free_block_groups(struct btrfs_fs_info *info)
 		}
 	}
 
-	write_lock(&info->block_group_cache_lock);
+	percpu_down_write(&info->block_group_cache_lock);
 	while (!list_empty(&info->caching_block_groups)) {
 		caching_ctl = list_first_entry(&info->caching_block_groups,
 					       struct btrfs_caching_control, list);
 		list_del(&caching_ctl->list);
 		btrfs_put_caching_control(caching_ctl);
 	}
-	write_unlock(&info->block_group_cache_lock);
+	percpu_up_write(&info->block_group_cache_lock);
 
 	spin_lock(&info->unused_bgs_lock);
 	while (!list_empty(&info->unused_bgs)) {
@@ -4556,14 +4556,14 @@ int btrfs_free_block_groups(struct btrfs_fs_info *info)
 	}
 	spin_unlock(&info->zone_active_bgs_lock);
 
-	write_lock(&info->block_group_cache_lock);
+	percpu_down_write(&info->block_group_cache_lock);
 	while ((n = rb_last(&info->block_group_cache_tree.rb_root)) != NULL) {
 		block_group = rb_entry(n, struct btrfs_block_group,
 				       cache_node);
 		rb_erase_cached(&block_group->cache_node,
 				&info->block_group_cache_tree);
 		RB_CLEAR_NODE(&block_group->cache_node);
-		write_unlock(&info->block_group_cache_lock);
+		percpu_up_write(&info->block_group_cache_lock);
 
 		percpu_down_write(&block_group->space_info->groups_sem);
 		list_del(&block_group->list);
@@ -4587,9 +4587,9 @@ int btrfs_free_block_groups(struct btrfs_fs_info *info)
 		percpu_ref_kill(&block_group->refs);
 		ASSERT(percpu_ref_is_zero(&block_group->refs));
 
-		write_lock(&info->block_group_cache_lock);
+		percpu_down_write(&info->block_group_cache_lock);
 	}
-	write_unlock(&info->block_group_cache_lock);
+	percpu_up_write(&info->block_group_cache_lock);
 
 	btrfs_release_global_block_rsv(info);
 
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index cecb81d0f9e0..d443cdebb38e 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -1227,6 +1227,7 @@ void btrfs_free_fs_info(struct btrfs_fs_info *fs_info)
 		btrfs_close_devices(fs_info->fs_devices);
 	btrfs_free_compress_wsm(fs_info);
 	percpu_counter_destroy(&fs_info->stats_read_blocks);
+	percpu_free_rwsem(&fs_info->block_group_cache_lock);
 	percpu_counter_destroy(&fs_info->dirty_metadata_bytes);
 	percpu_counter_destroy(&fs_info->delalloc_bytes);
 	percpu_counter_destroy(&fs_info->ordered_bytes);
@@ -2804,7 +2805,6 @@ void btrfs_init_fs_info(struct btrfs_fs_info *fs_info)
 	btrfs_init_async_reclaim_work(fs_info);
 	btrfs_init_extent_map_shrinker_work(fs_info);
 
-	rwlock_init(&fs_info->block_group_cache_lock);
 	fs_info->block_group_cache_tree = RB_ROOT_CACHED;
 
 	btrfs_extent_io_tree_init(fs_info, &fs_info->excluded_extents,
@@ -2861,6 +2861,10 @@ static int init_mount_fs_info(struct btrfs_fs_info *fs_info, struct super_block
 	sb->s_blocksize = BTRFS_BDEV_BLOCKSIZE;
 	sb->s_blocksize_bits = blksize_bits(BTRFS_BDEV_BLOCKSIZE);
 
+	ret = percpu_init_rwsem(&fs_info->block_group_cache_lock);
+	if (ret)
+		return ret;
+
 	ret = percpu_counter_init(&fs_info->ordered_bytes, 0, GFP_KERNEL);
 	if (ret)
 		return ret;
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 7a5e4efd6cd8..5ec8b1cfc317 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -2575,7 +2575,7 @@ static u64 first_logical_byte(struct btrfs_fs_info *fs_info)
 	struct rb_node *leftmost;
 	u64 bytenr = 0;
 
-	read_lock(&fs_info->block_group_cache_lock);
+	percpu_down_read(&fs_info->block_group_cache_lock);
 	/* Get the block group with the lowest logical start address. */
 	leftmost = rb_first_cached(&fs_info->block_group_cache_tree);
 	if (leftmost) {
@@ -2584,7 +2584,7 @@ static u64 first_logical_byte(struct btrfs_fs_info *fs_info)
 		bg = rb_entry(leftmost, struct btrfs_block_group, cache_node);
 		bytenr = bg->start;
 	}
-	read_unlock(&fs_info->block_group_cache_lock);
+	percpu_up_read(&fs_info->block_group_cache_lock);
 
 	return bytenr;
 }
diff --git a/fs/btrfs/fs.h b/fs/btrfs/fs.h
index 859551cf9bee..353bbc5ad49c 100644
--- a/fs/btrfs/fs.h
+++ b/fs/btrfs/fs.h
@@ -479,7 +479,7 @@ struct btrfs_fs_info {
 	struct radix_tree_root fs_roots_radix;
 
 	/* Block group cache stuff */
-	rwlock_t block_group_cache_lock;
+	struct percpu_rw_semaphore block_group_cache_lock;
 	struct rb_root_cached block_group_cache_tree;
 
 	/* Keep track of unallocated space */
-- 
2.39.5


