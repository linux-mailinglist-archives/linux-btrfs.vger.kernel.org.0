Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DE25CD0FA1
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Oct 2019 15:08:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731145AbfJINH4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 9 Oct 2019 09:07:56 -0400
Received: from mx2.suse.de ([195.135.220.15]:34826 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730858AbfJINHz (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 9 Oct 2019 09:07:55 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 0897CABCB;
        Wed,  9 Oct 2019 13:07:53 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Johannes Thumshirn <jthumshirn@suse.de>,
        Anand Jain <anand.jain@oracle.com>
Subject: [PATCH 1/3] btrfs: block-group: Refactor btrfs_read_block_groups()
Date:   Wed,  9 Oct 2019 21:07:47 +0800
Message-Id: <20191009130747.47252-1-wqu@suse.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191008044909.157750-2-wqu@suse.com>
References: <20191008044909.157750-2-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Refactor the work inside the loop of btrfs_read_block_groups() into one
separate function, read_one_block_group().

This allows read_one_block_group to be reused for later BG_TREE feature.

The refactor does the following extra fixes:
- Use btrfs_fs_incompat() to replace open-coded feature check
- Fix a missing "btrfs_put_block_group(cache)" in error path

Signed-off-by: Qu Wenruo <wqu@suse.com>
Reviewed-by: Johannes Thumshirn <jthumshirn@suse.de>
Reviewed-by: Anand Jain <anand.jain@oracle.com>
---
Changelog:
v2.1->v2
- Add commit message for the fixes done in the refactor
- Add reviewed-by tags
---
 fs/btrfs/block-group.c | 214 +++++++++++++++++++++--------------------
 1 file changed, 108 insertions(+), 106 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index bf7e3f23bba7..0c5eef0610fa 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -1687,6 +1687,109 @@ static int check_chunk_block_group_mappings(struct btrfs_fs_info *fs_info)
 	return ret;
 }
 
+static int read_one_block_group(struct btrfs_fs_info *info,
+				struct btrfs_path *path,
+				int need_clear)
+{
+	struct extent_buffer *leaf = path->nodes[0];
+	struct btrfs_block_group_cache *cache;
+	struct btrfs_space_info *space_info;
+	struct btrfs_key key;
+	int mixed = btrfs_fs_incompat(info, MIXED_GROUPS);
+	int slot = path->slots[0];
+	int ret;
+
+	btrfs_item_key_to_cpu(leaf, &key, slot);
+	ASSERT(key.type == BTRFS_BLOCK_GROUP_ITEM_KEY);
+
+	cache = btrfs_create_block_group_cache(info, key.objectid,
+					       key.offset);
+	if (!cache)
+		return -ENOMEM;
+
+	if (need_clear) {
+		/*
+		 * When we mount with old space cache, we need to
+		 * set BTRFS_DC_CLEAR and set dirty flag.
+		 *
+		 * a) Setting 'BTRFS_DC_CLEAR' makes sure that we
+		 *    truncate the old free space cache inode and
+		 *    setup a new one.
+		 * b) Setting 'dirty flag' makes sure that we flush
+		 *    the new space cache info onto disk.
+		 */
+		if (btrfs_test_opt(info, SPACE_CACHE))
+			cache->disk_cache_state = BTRFS_DC_CLEAR;
+	}
+	read_extent_buffer(leaf, &cache->item,
+			   btrfs_item_ptr_offset(leaf, slot),
+			   sizeof(cache->item));
+	cache->flags = btrfs_block_group_flags(&cache->item);
+	if (!mixed && ((cache->flags & BTRFS_BLOCK_GROUP_METADATA) &&
+	    (cache->flags & BTRFS_BLOCK_GROUP_DATA))) {
+			btrfs_err(info,
+"bg %llu is a mixed block group but filesystem hasn't enabled mixed block groups",
+				  cache->key.objectid);
+			ret = -EINVAL;
+			goto error;
+	}
+
+	/*
+	 * We need to exclude the super stripes now so that the space info has
+	 * super bytes accounted for, otherwise we'll think we have more space
+	 * than we actually do.
+	 */
+	ret = exclude_super_stripes(cache);
+	if (ret) {
+		/* We may have excluded something, so call this just in case. */
+		btrfs_free_excluded_extents(cache);
+		goto error;
+	}
+
+	/*
+	 * Check for two cases, either we are full, and therefore don't need
+	 * to bother with the caching work since we won't find any space, or we
+	 * are empty, and we can just add all the space in and be done with it.
+	 * This saves us _a_lot_ of time, particularly in the full case.
+	 */
+	if (key.offset == btrfs_block_group_used(&cache->item)) {
+		cache->last_byte_to_unpin = (u64)-1;
+		cache->cached = BTRFS_CACHE_FINISHED;
+		btrfs_free_excluded_extents(cache);
+	} else if (btrfs_block_group_used(&cache->item) == 0) {
+		cache->last_byte_to_unpin = (u64)-1;
+		cache->cached = BTRFS_CACHE_FINISHED;
+		add_new_free_space(cache, key.objectid,
+				   key.objectid + key.offset);
+		btrfs_free_excluded_extents(cache);
+	}
+	ret = btrfs_add_block_group_cache(info, cache);
+	if (ret) {
+		btrfs_remove_free_space_cache(cache);
+		goto error;
+	}
+	trace_btrfs_add_block_group(info, cache, 0);
+	btrfs_update_space_info(info, cache->flags, key.offset,
+				btrfs_block_group_used(&cache->item),
+				cache->bytes_super, &space_info);
+
+	cache->space_info = space_info;
+
+	link_block_group(cache);
+
+	set_avail_alloc_bits(info, cache->flags);
+	if (btrfs_chunk_readonly(info, cache->key.objectid)) {
+		inc_block_group_ro(cache, 1);
+	} else if (btrfs_block_group_used(&cache->item) == 0) {
+		ASSERT(list_empty(&cache->bg_list));
+		btrfs_mark_bg_unused(cache);
+	}
+	return 0;
+error:
+	btrfs_put_block_group(cache);
+	return ret;
+}
+
 int btrfs_read_block_groups(struct btrfs_fs_info *info)
 {
 	struct btrfs_path *path;
@@ -1694,15 +1797,8 @@ int btrfs_read_block_groups(struct btrfs_fs_info *info)
 	struct btrfs_block_group_cache *cache;
 	struct btrfs_space_info *space_info;
 	struct btrfs_key key;
-	struct btrfs_key found_key;
-	struct extent_buffer *leaf;
 	int need_clear = 0;
 	u64 cache_gen;
-	u64 feature;
-	int mixed;
-
-	feature = btrfs_super_incompat_flags(info->super_copy);
-	mixed = !!(feature & BTRFS_FEATURE_INCOMPAT_MIXED_GROUPS);
 
 	key.objectid = 0;
 	key.offset = 0;
@@ -1726,107 +1822,13 @@ int btrfs_read_block_groups(struct btrfs_fs_info *info)
 		if (ret != 0)
 			goto error;
 
-		leaf = path->nodes[0];
-		btrfs_item_key_to_cpu(leaf, &found_key, path->slots[0]);
-
-		cache = btrfs_create_block_group_cache(info, found_key.objectid,
-						       found_key.offset);
-		if (!cache) {
-			ret = -ENOMEM;
-			goto error;
-		}
-
-		if (need_clear) {
-			/*
-			 * When we mount with old space cache, we need to
-			 * set BTRFS_DC_CLEAR and set dirty flag.
-			 *
-			 * a) Setting 'BTRFS_DC_CLEAR' makes sure that we
-			 *    truncate the old free space cache inode and
-			 *    setup a new one.
-			 * b) Setting 'dirty flag' makes sure that we flush
-			 *    the new space cache info onto disk.
-			 */
-			if (btrfs_test_opt(info, SPACE_CACHE))
-				cache->disk_cache_state = BTRFS_DC_CLEAR;
-		}
-
-		read_extent_buffer(leaf, &cache->item,
-				   btrfs_item_ptr_offset(leaf, path->slots[0]),
-				   sizeof(cache->item));
-		cache->flags = btrfs_block_group_flags(&cache->item);
-		if (!mixed &&
-		    ((cache->flags & BTRFS_BLOCK_GROUP_METADATA) &&
-		    (cache->flags & BTRFS_BLOCK_GROUP_DATA))) {
-			btrfs_err(info,
-"bg %llu is a mixed block group but filesystem hasn't enabled mixed block groups",
-				  cache->key.objectid);
-			ret = -EINVAL;
+		btrfs_item_key_to_cpu(path->nodes[0], &key, path->slots[0]);
+		ret = read_one_block_group(info, path, need_clear);
+		if (ret < 0)
 			goto error;
-		}
-
-		key.objectid = found_key.objectid + found_key.offset;
+		key.objectid += key.offset;
+		key.offset = 0;
 		btrfs_release_path(path);
-
-		/*
-		 * We need to exclude the super stripes now so that the space
-		 * info has super bytes accounted for, otherwise we'll think
-		 * we have more space than we actually do.
-		 */
-		ret = exclude_super_stripes(cache);
-		if (ret) {
-			/*
-			 * We may have excluded something, so call this just in
-			 * case.
-			 */
-			btrfs_free_excluded_extents(cache);
-			btrfs_put_block_group(cache);
-			goto error;
-		}
-
-		/*
-		 * Check for two cases, either we are full, and therefore
-		 * don't need to bother with the caching work since we won't
-		 * find any space, or we are empty, and we can just add all
-		 * the space in and be done with it.  This saves us _a_lot_ of
-		 * time, particularly in the full case.
-		 */
-		if (found_key.offset == btrfs_block_group_used(&cache->item)) {
-			cache->last_byte_to_unpin = (u64)-1;
-			cache->cached = BTRFS_CACHE_FINISHED;
-			btrfs_free_excluded_extents(cache);
-		} else if (btrfs_block_group_used(&cache->item) == 0) {
-			cache->last_byte_to_unpin = (u64)-1;
-			cache->cached = BTRFS_CACHE_FINISHED;
-			add_new_free_space(cache, found_key.objectid,
-					   found_key.objectid +
-					   found_key.offset);
-			btrfs_free_excluded_extents(cache);
-		}
-
-		ret = btrfs_add_block_group_cache(info, cache);
-		if (ret) {
-			btrfs_remove_free_space_cache(cache);
-			btrfs_put_block_group(cache);
-			goto error;
-		}
-
-		trace_btrfs_add_block_group(info, cache, 0);
-		btrfs_update_space_info(info, cache->flags, found_key.offset,
-					btrfs_block_group_used(&cache->item),
-					cache->bytes_super, &space_info);
-
-		cache->space_info = space_info;
-
-		link_block_group(cache);
-
-		set_avail_alloc_bits(info, cache->flags);
-		if (btrfs_chunk_readonly(info, cache->key.objectid)) {
-			inc_block_group_ro(cache, 1);
-		} else if (btrfs_block_group_used(&cache->item) == 0) {
-			ASSERT(list_empty(&cache->bg_list));
-			btrfs_mark_bg_unused(cache);
-		}
 	}
 
 	list_for_each_entry_rcu(space_info, &info->space_info, list) {
-- 
2.23.0

