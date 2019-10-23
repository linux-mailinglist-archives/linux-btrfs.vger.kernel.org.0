Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 45479E20E9
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Oct 2019 18:48:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726363AbfJWQsC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 23 Oct 2019 12:48:02 -0400
Received: from mx2.suse.de ([195.135.220.15]:56994 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726259AbfJWQsC (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 23 Oct 2019 12:48:02 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id B5B1DAE99;
        Wed, 23 Oct 2019 16:47:58 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 25CD8DA734; Wed, 23 Oct 2019 18:48:11 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 1/6] btrfs: move block_group_item::used to block group
Date:   Wed, 23 Oct 2019 18:48:11 +0200
Message-Id: <84ba80aca946345b690796b01a91c9e65cffa7bb.1571848791.git.dsterba@suse.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1571848791.git.dsterba@suse.com>
References: <cover.1571848791.git.dsterba@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

For unknown reasons, the member 'used' in the block group struct is
stored in the b-tree item and accessed everywhere using the special
accessor helper. Let's unify it and make it a regular member and only
update the item before writing it to the tree.

The item is still being used for flags and chunk_objectid, there's some
duplication until the item is removed in following patches.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/block-group.c       | 50 +++++++++++++++++++++---------------
 fs/btrfs/block-group.h       |  1 +
 fs/btrfs/extent-tree.c       |  3 +--
 fs/btrfs/free-space-cache.c  |  2 +-
 fs/btrfs/ioctl.c             |  3 +--
 fs/btrfs/relocation.c        |  2 +-
 fs/btrfs/scrub.c             |  2 +-
 fs/btrfs/space-info.c        |  2 +-
 fs/btrfs/sysfs.c             |  2 +-
 fs/btrfs/volumes.c           |  4 +--
 include/trace/events/btrfs.h |  5 ++--
 11 files changed, 42 insertions(+), 34 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 540a7a63601e..4da5e0f6cb82 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -656,8 +656,7 @@ static noinline void caching_thread(struct btrfs_work *work)
 
 		spin_lock(&block_group->space_info->lock);
 		spin_lock(&block_group->lock);
-		bytes_used = block_group->key.offset -
-			btrfs_block_group_used(&block_group->item);
+		bytes_used = block_group->key.offset - block_group->used;
 		block_group->space_info->bytes_used += bytes_used >> 1;
 		spin_unlock(&block_group->lock);
 		spin_unlock(&block_group->space_info->lock);
@@ -762,8 +761,7 @@ int btrfs_cache_block_group(struct btrfs_block_group_cache *cache,
 
 			spin_lock(&cache->space_info->lock);
 			spin_lock(&cache->lock);
-			bytes_used = cache->key.offset -
-				btrfs_block_group_used(&cache->item);
+			bytes_used = cache->key.offset - cache->used;
 			cache->space_info->bytes_used += bytes_used >> 1;
 			spin_unlock(&cache->lock);
 			spin_unlock(&cache->space_info->lock);
@@ -1209,7 +1207,7 @@ static int inc_block_group_ro(struct btrfs_block_group_cache *cache, int force)
 	}
 
 	num_bytes = cache->key.offset - cache->reserved - cache->pinned -
-		    cache->bytes_super - btrfs_block_group_used(&cache->item);
+		    cache->bytes_super - cache->used;
 	sinfo_used = btrfs_space_info_used(sinfo, true);
 
 	/*
@@ -1278,8 +1276,7 @@ void btrfs_delete_unused_bgs(struct btrfs_fs_info *fs_info)
 		down_write(&space_info->groups_sem);
 		spin_lock(&block_group->lock);
 		if (block_group->reserved || block_group->pinned ||
-		    btrfs_block_group_used(&block_group->item) ||
-		    block_group->ro ||
+		    block_group->used || block_group->ro ||
 		    list_is_singular(&block_group->list)) {
 			/*
 			 * We want to bail if we made new allocations or have
@@ -1719,6 +1716,8 @@ int btrfs_read_block_groups(struct btrfs_fs_info *info)
 		need_clear = 1;
 
 	while (1) {
+		struct btrfs_block_group_item bgi;
+
 		ret = find_first_block_group(info, path, &key);
 		if (ret > 0)
 			break;
@@ -1750,9 +1749,12 @@ int btrfs_read_block_groups(struct btrfs_fs_info *info)
 				cache->disk_cache_state = BTRFS_DC_CLEAR;
 		}
 
-		read_extent_buffer(leaf, &cache->item,
+		read_extent_buffer(leaf, &bgi,
 				   btrfs_item_ptr_offset(leaf, path->slots[0]),
-				   sizeof(cache->item));
+				   sizeof(bgi));
+		/* Duplicate as the item is still partially used */
+		memcpy(&cache->item, &bgi, sizeof(bgi));
+		cache->used = btrfs_block_group_used(&bgi);
 		cache->flags = btrfs_block_group_flags(&cache->item);
 		if (!mixed &&
 		    ((cache->flags & BTRFS_BLOCK_GROUP_METADATA) &&
@@ -1791,11 +1793,11 @@ int btrfs_read_block_groups(struct btrfs_fs_info *info)
 		 * the space in and be done with it.  This saves us _a_lot_ of
 		 * time, particularly in the full case.
 		 */
-		if (found_key.offset == btrfs_block_group_used(&cache->item)) {
+		if (found_key.offset == cache->used) {
 			cache->last_byte_to_unpin = (u64)-1;
 			cache->cached = BTRFS_CACHE_FINISHED;
 			btrfs_free_excluded_extents(cache);
-		} else if (btrfs_block_group_used(&cache->item) == 0) {
+		} else if (cache->used == 0) {
 			cache->last_byte_to_unpin = (u64)-1;
 			cache->cached = BTRFS_CACHE_FINISHED;
 			add_new_free_space(cache, found_key.objectid,
@@ -1813,7 +1815,7 @@ int btrfs_read_block_groups(struct btrfs_fs_info *info)
 
 		trace_btrfs_add_block_group(info, cache, 0);
 		btrfs_update_space_info(info, cache->flags, found_key.offset,
-					btrfs_block_group_used(&cache->item),
+					cache->used,
 					cache->bytes_super, &space_info);
 
 		cache->space_info = space_info;
@@ -1823,7 +1825,7 @@ int btrfs_read_block_groups(struct btrfs_fs_info *info)
 		set_avail_alloc_bits(info, cache->flags);
 		if (btrfs_chunk_readonly(info, cache->key.objectid)) {
 			inc_block_group_ro(cache, 1);
-		} else if (btrfs_block_group_used(&cache->item) == 0) {
+		} else if (cache->used == 0) {
 			ASSERT(list_empty(&cache->bg_list));
 			btrfs_mark_bg_unused(cache);
 		}
@@ -1877,7 +1879,12 @@ void btrfs_create_pending_block_groups(struct btrfs_trans_handle *trans)
 			goto next;
 
 		spin_lock(&block_group->lock);
+		/*
+		 * Copy partially filled item from the cache and ovewrite used
+		 * that has the correct value
+		 */
 		memcpy(&item, &block_group->item, sizeof(item));
+		btrfs_set_block_group_used(&item, block_group->used);
 		memcpy(&key, &block_group->key, sizeof(key));
 		spin_unlock(&block_group->lock);
 
@@ -1910,7 +1917,7 @@ int btrfs_make_block_group(struct btrfs_trans_handle *trans, u64 bytes_used,
 	if (!cache)
 		return -ENOMEM;
 
-	btrfs_set_block_group_used(&cache->item, bytes_used);
+	cache->used = bytes_used;
 	btrfs_set_block_group_chunk_objectid(&cache->item,
 					     BTRFS_FIRST_CHUNK_TREE_OBJECTID);
 	btrfs_set_block_group_flags(&cache->item, type);
@@ -2102,8 +2109,7 @@ void btrfs_dec_block_group_ro(struct btrfs_block_group_cache *cache)
 	spin_lock(&cache->lock);
 	if (!--cache->ro) {
 		num_bytes = cache->key.offset - cache->reserved -
-			    cache->pinned - cache->bytes_super -
-			    btrfs_block_group_used(&cache->item);
+			    cache->pinned - cache->bytes_super - cache->used;
 		sinfo->bytes_readonly -= num_bytes;
 		list_del_init(&cache->ro_list);
 	}
@@ -2120,6 +2126,7 @@ static int write_one_cache_group(struct btrfs_trans_handle *trans,
 	struct btrfs_root *extent_root = fs_info->extent_root;
 	unsigned long bi;
 	struct extent_buffer *leaf;
+	struct btrfs_block_group_item bgi;
 
 	ret = btrfs_search_slot(trans, extent_root, &cache->key, path, 0, 1);
 	if (ret) {
@@ -2130,7 +2137,10 @@ static int write_one_cache_group(struct btrfs_trans_handle *trans,
 
 	leaf = path->nodes[0];
 	bi = btrfs_item_ptr_offset(leaf, path->slots[0]);
-	write_extent_buffer(leaf, &cache->item, bi, sizeof(cache->item));
+	/* Partial copy of item, update the rest from memory */
+	memcpy(&bgi, &cache->item, sizeof(bgi));
+	btrfs_set_block_group_used(&bgi, cache->used);
+	write_extent_buffer(leaf, &bgi, bi, sizeof(bgi));
 	btrfs_mark_buffer_dirty(leaf);
 fail:
 	btrfs_release_path(path);
@@ -2674,11 +2684,11 @@ int btrfs_update_block_group(struct btrfs_trans_handle *trans,
 		    cache->disk_cache_state < BTRFS_DC_CLEAR)
 			cache->disk_cache_state = BTRFS_DC_CLEAR;
 
-		old_val = btrfs_block_group_used(&cache->item);
+		old_val = cache->used;
 		num_bytes = min(total, cache->key.offset - byte_in_group);
 		if (alloc) {
 			old_val += num_bytes;
-			btrfs_set_block_group_used(&cache->item, old_val);
+			cache->used = old_val;
 			cache->reserved -= num_bytes;
 			cache->space_info->bytes_reserved -= num_bytes;
 			cache->space_info->bytes_used += num_bytes;
@@ -2687,7 +2697,7 @@ int btrfs_update_block_group(struct btrfs_trans_handle *trans,
 			spin_unlock(&cache->space_info->lock);
 		} else {
 			old_val -= num_bytes;
-			btrfs_set_block_group_used(&cache->item, old_val);
+			cache->used = old_val;
 			cache->pinned += num_bytes;
 			btrfs_space_info_update_bytes_pinned(info,
 					cache->space_info, num_bytes);
diff --git a/fs/btrfs/block-group.h b/fs/btrfs/block-group.h
index c391800388dd..8fa4a70228ee 100644
--- a/fs/btrfs/block-group.h
+++ b/fs/btrfs/block-group.h
@@ -50,6 +50,7 @@ struct btrfs_block_group_cache {
 	spinlock_t lock;
 	u64 pinned;
 	u64 reserved;
+	u64 used;
 	u64 delalloc_bytes;
 	u64 bytes_super;
 	u64 flags;
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 569fd2adecaa..e3fd4b0ca905 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -5498,8 +5498,7 @@ u64 btrfs_account_ro_block_groups_free_space(struct btrfs_space_info *sinfo)
 
 		factor = btrfs_bg_type_to_factor(block_group->flags);
 		free_bytes += (block_group->key.offset -
-			       btrfs_block_group_used(&block_group->item)) *
-			       factor;
+			       block_group->used) * factor;
 
 		spin_unlock(&block_group->lock);
 	}
diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
index 2a831eb8a66c..e4ea277d4e01 100644
--- a/fs/btrfs/free-space-cache.c
+++ b/fs/btrfs/free-space-cache.c
@@ -828,7 +828,7 @@ int load_free_space_cache(struct btrfs_block_group_cache *block_group)
 	struct btrfs_path *path;
 	int ret = 0;
 	bool matched;
-	u64 used = btrfs_block_group_used(&block_group->item);
+	u64 used = block_group->used;
 
 	/*
 	 * If this block group has been marked to be cleared for one reason or
diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index c584cb8bccf4..c214c3cd5c72 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -4039,8 +4039,7 @@ static void get_block_group_info(struct list_head *groups_list,
 	list_for_each_entry(block_group, groups_list, list) {
 		space->flags = block_group->flags;
 		space->total_bytes += block_group->key.offset;
-		space->used_bytes +=
-			btrfs_block_group_used(&block_group->item);
+		space->used_bytes += block_group->used;
 	}
 }
 
diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 0196196434cb..77863f7d5179 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -4403,7 +4403,7 @@ int btrfs_relocate_block_group(struct btrfs_fs_info *fs_info, u64 group_start)
 
 	WARN_ON(rc->block_group->pinned > 0);
 	WARN_ON(rc->block_group->reserved > 0);
-	WARN_ON(btrfs_block_group_used(&rc->block_group->item) > 0);
+	WARN_ON(rc->block_group->used > 0);
 out:
 	if (err && rw)
 		btrfs_dec_block_group_ro(rc->block_group);
diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index a7b043fd7a57..00313a182036 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -3678,7 +3678,7 @@ int scrub_enumerate_chunks(struct scrub_ctx *sctx,
 		 */
 		spin_lock(&cache->lock);
 		if (!cache->removed && !cache->ro && cache->reserved == 0 &&
-		    btrfs_block_group_used(&cache->item) == 0) {
+		    cache->used == 0) {
 			spin_unlock(&cache->lock);
 			btrfs_mark_bg_unused(cache);
 		} else {
diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index f32993efbf61..978006ac577f 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -302,7 +302,7 @@ void btrfs_dump_space_info(struct btrfs_fs_info *fs_info,
 		btrfs_info(fs_info,
 			"block group %llu has %llu bytes, %llu used %llu pinned %llu reserved %s",
 			cache->key.objectid, cache->key.offset,
-			btrfs_block_group_used(&cache->item), cache->pinned,
+			cache->used, cache->pinned,
 			cache->reserved, cache->ro ? "[readonly]" : "");
 		btrfs_dump_free_space(cache, bytes);
 		spin_unlock(&cache->lock);
diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index f6d3c80f2e28..2ad3891ff4a5 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -381,7 +381,7 @@ static ssize_t raid_bytes_show(struct kobject *kobj,
 		if (&attr->attr == BTRFS_ATTR_PTR(raid, total_bytes))
 			val += block_group->key.offset;
 		else
-			val += btrfs_block_group_used(&block_group->item);
+			val += block_group->used;
 	}
 	up_read(&sinfo->groups_sem);
 	return snprintf(buf, PAGE_SIZE, "%llu\n", val);
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 222c60b91c08..8431ea3b9abf 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -3189,7 +3189,7 @@ static int chunk_usage_range_filter(struct btrfs_fs_info *fs_info, u64 chunk_off
 	int ret = 1;
 
 	cache = btrfs_lookup_block_group(fs_info, chunk_offset);
-	chunk_used = btrfs_block_group_used(&cache->item);
+	chunk_used = cache->used;
 
 	if (bargs->usage_min == 0)
 		user_thresh_min = 0;
@@ -3220,7 +3220,7 @@ static int chunk_usage_filter(struct btrfs_fs_info *fs_info,
 	int ret = 1;
 
 	cache = btrfs_lookup_block_group(fs_info, chunk_offset);
-	chunk_used = btrfs_block_group_used(&cache->item);
+	chunk_used = cache->used;
 
 	if (bargs->usage_min == 0)
 		user_thresh = 1;
diff --git a/include/trace/events/btrfs.h b/include/trace/events/btrfs.h
index 522d1f2b13e3..7b842b049ea3 100644
--- a/include/trace/events/btrfs.h
+++ b/include/trace/events/btrfs.h
@@ -716,8 +716,7 @@ TRACE_EVENT(btrfs_add_block_group,
 		__entry->offset		= block_group->key.objectid;
 		__entry->size		= block_group->key.offset;
 		__entry->flags		= block_group->flags;
-		__entry->bytes_used	=
-			btrfs_block_group_used(&block_group->item);
+		__entry->bytes_used	= block_group->used;
 		__entry->bytes_super	= block_group->bytes_super;
 		__entry->create		= create;
 	),
@@ -1859,7 +1858,7 @@ DECLARE_EVENT_CLASS(btrfs__block_group,
 	TP_fast_assign_btrfs(bg_cache->fs_info,
 		__entry->bytenr = bg_cache->key.objectid,
 		__entry->len	= bg_cache->key.offset,
-		__entry->used	= btrfs_block_group_used(&bg_cache->item);
+		__entry->used	= bg_cache->used;
 		__entry->flags	= bg_cache->flags;
 	),
 
-- 
2.23.0

