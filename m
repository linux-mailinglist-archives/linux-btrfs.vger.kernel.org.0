Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0DF44836BC
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 Aug 2019 18:29:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387883AbfHFQ2v (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 6 Aug 2019 12:28:51 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:46284 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387867AbfHFQ2v (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 6 Aug 2019 12:28:51 -0400
Received: by mail-qk1-f193.google.com with SMTP id r4so63258396qkm.13
        for <linux-btrfs@vger.kernel.org>; Tue, 06 Aug 2019 09:28:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=pJlesvmZhGUqHEWxVIuLryjx685nKCQEKlvDiLuu+9E=;
        b=X2/WhXCl8OAvR3zpMoux8tcD+IkBdmHI7h2EnPYFcQ4+ed3zO+sTYgVW/Q7xG10XTX
         2ak1zUvRYWJIOBTW5OyLxPylNdW3MVZEuXEeHradbi/ckjj7H6aJDGikEDN1mrqBLfCF
         MTNcUjqsJWiBWzX5yVxt4KhECQm+/42FHyjlp3DuzKD+X4PIKcClQrwiyE9ANd/btVv7
         VoVl3EXqlEELbFa07JAZ+S5T8gQTDOPm3lUOSnJWt5SkAjT/WLwcfXemhuZVgPpTRViI
         RMuKtcwEt65280+odOs+mivfCGGUNUPN0vjWFwNlVcfTF11YvbS7AcTrsUTMJyvaB3XU
         6FVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pJlesvmZhGUqHEWxVIuLryjx685nKCQEKlvDiLuu+9E=;
        b=GCiuqYlKZrlr31u5IuRJ+1rcoezGLQyryIzaYSBHaFN9bR3iYLU+hQbxIrRahCAaE/
         NelwMFgMRxGeqAyElMymCr08thrZylF111wNsV0MhzUGL/hF9gWj2GuqHGsrIWWxPxSx
         +TlIhQb0QXKZbrFXFJPfzLf/QENV2W6Y0Vnyei6GlCe3a+o8NfxrZIZ8gE4OTqjbM0GX
         Z0GDyXlW3A6MoCHW58fIYJeBT39h12AXsTf66avQLAHL2NAEHyPGLqLomiPJc2SxYxiD
         m8gQaCF/kfFmTumaYcYWaiQ93VZ6wAsE0Q24NrGklIQ2RNeqqChMGlL1KtsrRL98b8xw
         GIyQ==
X-Gm-Message-State: APjAAAVWimtoYaeRi24QhP7DpLEfkTrW0BwXQcPq+aq3ln4FrPNAe959
        r7O7yz8YlRNTFpv2K7TOCRFHYzbOFyiDHQ==
X-Google-Smtp-Source: APXvYqwVnH+tZa/IWkFkbu8j8yO5ClCbx+ssHqIVLSJC5MuiQ8lUXOyVySV5bIYKaba52mkQf6So4w==
X-Received: by 2002:a05:620a:1097:: with SMTP id g23mr4071974qkk.185.1565108929265;
        Tue, 06 Aug 2019 09:28:49 -0700 (PDT)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id 42sm45706761qtm.27.2019.08.06.09.28.48
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 06 Aug 2019 09:28:48 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     kernel-team@fb.com, linux-btrfs@vger.kernel.org
Subject: [PATCH 05/15] btrfs: migrate the block group read/creation code
Date:   Tue,  6 Aug 2019 12:28:27 -0400
Message-Id: <20190806162837.15840-6-josef@toxicpanda.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190806162837.15840-1-josef@toxicpanda.com>
References: <20190806162837.15840-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

All of the prep work has been done so we can now cleanly move this chunk
over.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/block-group.c | 598 +++++++++++++++++++++++++++++++++++++++++
 fs/btrfs/block-group.h |   5 +
 fs/btrfs/ctree.h       |   5 -
 fs/btrfs/extent-tree.c | 596 ----------------------------------------
 4 files changed, 603 insertions(+), 601 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 0bc51bfe4904..c0ca7d60e5f4 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -10,6 +10,8 @@
 #include "volumes.h"
 #include "transaction.h"
 #include "ref-verify.h"
+#include "sysfs.h"
+#include "tree-log.h"
 
 void btrfs_get_block_group(struct btrfs_block_group_cache *cache)
 {
@@ -36,6 +38,46 @@ void btrfs_put_block_group(struct btrfs_block_group_cache *cache)
 	}
 }
 
+/*
+ * this adds the block group to the fs_info rb tree for the block group
+ * cache
+ */
+static int btrfs_add_block_group_cache(struct btrfs_fs_info *info,
+				struct btrfs_block_group_cache *block_group)
+{
+	struct rb_node **p;
+	struct rb_node *parent = NULL;
+	struct btrfs_block_group_cache *cache;
+
+	spin_lock(&info->block_group_cache_lock);
+	p = &info->block_group_cache_tree.rb_node;
+
+	while (*p) {
+		parent = *p;
+		cache = rb_entry(parent, struct btrfs_block_group_cache,
+				 cache_node);
+		if (block_group->key.objectid < cache->key.objectid) {
+			p = &(*p)->rb_left;
+		} else if (block_group->key.objectid > cache->key.objectid) {
+			p = &(*p)->rb_right;
+		} else {
+			spin_unlock(&info->block_group_cache_lock);
+			return -EEXIST;
+		}
+	}
+
+	rb_link_node(&block_group->cache_node, parent, p);
+	rb_insert_color(&block_group->cache_node,
+			&info->block_group_cache_tree);
+
+	if (info->first_logical_byte > block_group->key.objectid)
+		info->first_logical_byte = block_group->key.objectid;
+
+	spin_unlock(&info->block_group_cache_lock);
+
+	return 0;
+}
+
 /*
  * This will return the block group at or after bytenr if contains is 0, else
  * it will return the block group that contains the bytenr
@@ -1204,3 +1246,559 @@ void btrfs_mark_bg_unused(struct btrfs_block_group_cache *bg)
 	}
 	spin_unlock(&fs_info->unused_bgs_lock);
 }
+
+static int find_first_block_group(struct btrfs_fs_info *fs_info,
+				  struct btrfs_path *path,
+				  struct btrfs_key *key)
+{
+	struct btrfs_root *root = fs_info->extent_root;
+	int ret = 0;
+	struct btrfs_key found_key;
+	struct extent_buffer *leaf;
+	struct btrfs_block_group_item bg;
+	u64 flags;
+	int slot;
+
+	ret = btrfs_search_slot(NULL, root, key, path, 0, 0);
+	if (ret < 0)
+		goto out;
+
+	while (1) {
+		slot = path->slots[0];
+		leaf = path->nodes[0];
+		if (slot >= btrfs_header_nritems(leaf)) {
+			ret = btrfs_next_leaf(root, path);
+			if (ret == 0)
+				continue;
+			if (ret < 0)
+				goto out;
+			break;
+		}
+		btrfs_item_key_to_cpu(leaf, &found_key, slot);
+
+		if (found_key.objectid >= key->objectid &&
+		    found_key.type == BTRFS_BLOCK_GROUP_ITEM_KEY) {
+			struct extent_map_tree *em_tree;
+			struct extent_map *em;
+
+			em_tree = &root->fs_info->mapping_tree;
+			read_lock(&em_tree->lock);
+			em = lookup_extent_mapping(em_tree, found_key.objectid,
+						   found_key.offset);
+			read_unlock(&em_tree->lock);
+			if (!em) {
+				btrfs_err(fs_info,
+			"logical %llu len %llu found bg but no related chunk",
+					  found_key.objectid, found_key.offset);
+				ret = -ENOENT;
+			} else if (em->start != found_key.objectid ||
+				   em->len != found_key.offset) {
+				btrfs_err(fs_info,
+		"block group %llu len %llu mismatch with chunk %llu len %llu",
+					  found_key.objectid, found_key.offset,
+					  em->start, em->len);
+				ret = -EUCLEAN;
+			} else {
+				read_extent_buffer(leaf, &bg,
+					btrfs_item_ptr_offset(leaf, slot),
+					sizeof(bg));
+				flags = btrfs_block_group_flags(&bg) &
+					BTRFS_BLOCK_GROUP_TYPE_MASK;
+
+				if (flags != (em->map_lookup->type &
+					      BTRFS_BLOCK_GROUP_TYPE_MASK)) {
+					btrfs_err(fs_info,
+"block group %llu len %llu type flags 0x%llx mismatch with chunk type flags 0x%llx",
+						found_key.objectid,
+						found_key.offset, flags,
+						(BTRFS_BLOCK_GROUP_TYPE_MASK &
+						 em->map_lookup->type));
+					ret = -EUCLEAN;
+				} else {
+					ret = 0;
+				}
+			}
+			free_extent_map(em);
+			goto out;
+		}
+		path->slots[0]++;
+	}
+out:
+	return ret;
+}
+
+static void set_avail_alloc_bits(struct btrfs_fs_info *fs_info, u64 flags)
+{
+	u64 extra_flags = chunk_to_extended(flags) &
+				BTRFS_EXTENDED_PROFILE_MASK;
+
+	write_seqlock(&fs_info->profiles_lock);
+	if (flags & BTRFS_BLOCK_GROUP_DATA)
+		fs_info->avail_data_alloc_bits |= extra_flags;
+	if (flags & BTRFS_BLOCK_GROUP_METADATA)
+		fs_info->avail_metadata_alloc_bits |= extra_flags;
+	if (flags & BTRFS_BLOCK_GROUP_SYSTEM)
+		fs_info->avail_system_alloc_bits |= extra_flags;
+	write_sequnlock(&fs_info->profiles_lock);
+}
+
+static int exclude_super_stripes(struct btrfs_block_group_cache *cache)
+{
+	struct btrfs_fs_info *fs_info = cache->fs_info;
+	u64 bytenr;
+	u64 *logical;
+	int stripe_len;
+	int i, nr, ret;
+
+	if (cache->key.objectid < BTRFS_SUPER_INFO_OFFSET) {
+		stripe_len = BTRFS_SUPER_INFO_OFFSET - cache->key.objectid;
+		cache->bytes_super += stripe_len;
+		ret = btrfs_add_excluded_extent(fs_info, cache->key.objectid,
+						stripe_len);
+		if (ret)
+			return ret;
+	}
+
+	for (i = 0; i < BTRFS_SUPER_MIRROR_MAX; i++) {
+		bytenr = btrfs_sb_offset(i);
+		ret = btrfs_rmap_block(fs_info, cache->key.objectid,
+				       bytenr, &logical, &nr, &stripe_len);
+		if (ret)
+			return ret;
+
+		while (nr--) {
+			u64 start, len;
+
+			if (logical[nr] > cache->key.objectid +
+			    cache->key.offset)
+				continue;
+
+			if (logical[nr] + stripe_len <= cache->key.objectid)
+				continue;
+
+			start = logical[nr];
+			if (start < cache->key.objectid) {
+				start = cache->key.objectid;
+				len = (logical[nr] + stripe_len) - start;
+			} else {
+				len = min_t(u64, stripe_len,
+					    cache->key.objectid +
+					    cache->key.offset - start);
+			}
+
+			cache->bytes_super += len;
+			ret = btrfs_add_excluded_extent(fs_info, start, len);
+			if (ret) {
+				kfree(logical);
+				return ret;
+			}
+		}
+
+		kfree(logical);
+	}
+	return 0;
+}
+
+static void link_block_group(struct btrfs_block_group_cache *cache)
+{
+	struct btrfs_space_info *space_info = cache->space_info;
+	int index = btrfs_bg_flags_to_raid_index(cache->flags);
+	bool first = false;
+
+	down_write(&space_info->groups_sem);
+	if (list_empty(&space_info->block_groups[index]))
+		first = true;
+	list_add_tail(&cache->list, &space_info->block_groups[index]);
+	up_write(&space_info->groups_sem);
+
+	if (first)
+		btrfs_sysfs_add_block_group_type(cache);
+}
+
+static struct btrfs_block_group_cache *
+btrfs_create_block_group_cache(struct btrfs_fs_info *fs_info,
+			       u64 start, u64 size)
+{
+	struct btrfs_block_group_cache *cache;
+
+	cache = kzalloc(sizeof(*cache), GFP_NOFS);
+	if (!cache)
+		return NULL;
+
+	cache->free_space_ctl = kzalloc(sizeof(*cache->free_space_ctl),
+					GFP_NOFS);
+	if (!cache->free_space_ctl) {
+		kfree(cache);
+		return NULL;
+	}
+
+	cache->key.objectid = start;
+	cache->key.offset = size;
+	cache->key.type = BTRFS_BLOCK_GROUP_ITEM_KEY;
+
+	cache->fs_info = fs_info;
+	cache->full_stripe_len = btrfs_full_stripe_len(fs_info, start);
+	set_free_space_tree_thresholds(cache);
+
+	atomic_set(&cache->count, 1);
+	spin_lock_init(&cache->lock);
+	init_rwsem(&cache->data_rwsem);
+	INIT_LIST_HEAD(&cache->list);
+	INIT_LIST_HEAD(&cache->cluster_list);
+	INIT_LIST_HEAD(&cache->bg_list);
+	INIT_LIST_HEAD(&cache->ro_list);
+	INIT_LIST_HEAD(&cache->dirty_list);
+	INIT_LIST_HEAD(&cache->io_list);
+	btrfs_init_free_space_ctl(cache);
+	atomic_set(&cache->trimming, 0);
+	mutex_init(&cache->free_space_lock);
+	btrfs_init_full_stripe_locks_tree(&cache->full_stripe_locks_root);
+
+	return cache;
+}
+
+
+/*
+ * Iterate all chunks and verify that each of them has the corresponding block
+ * group
+ */
+static int check_chunk_block_group_mappings(struct btrfs_fs_info *fs_info)
+{
+	struct extent_map_tree *map_tree = &fs_info->mapping_tree;
+	struct extent_map *em;
+	struct btrfs_block_group_cache *bg;
+	u64 start = 0;
+	int ret = 0;
+
+	while (1) {
+		read_lock(&map_tree->lock);
+		/*
+		 * lookup_extent_mapping will return the first extent map
+		 * intersecting the range, so setting @len to 1 is enough to
+		 * get the first chunk.
+		 */
+		em = lookup_extent_mapping(map_tree, start, 1);
+		read_unlock(&map_tree->lock);
+		if (!em)
+			break;
+
+		bg = btrfs_lookup_block_group(fs_info, em->start);
+		if (!bg) {
+			btrfs_err(fs_info,
+	"chunk start=%llu len=%llu doesn't have corresponding block group",
+				     em->start, em->len);
+			ret = -EUCLEAN;
+			free_extent_map(em);
+			break;
+		}
+		if (bg->key.objectid != em->start ||
+		    bg->key.offset != em->len ||
+		    (bg->flags & BTRFS_BLOCK_GROUP_TYPE_MASK) !=
+		    (em->map_lookup->type & BTRFS_BLOCK_GROUP_TYPE_MASK)) {
+			btrfs_err(fs_info,
+"chunk start=%llu len=%llu flags=0x%llx doesn't match block group start=%llu len=%llu flags=0x%llx",
+				em->start, em->len,
+				em->map_lookup->type & BTRFS_BLOCK_GROUP_TYPE_MASK,
+				bg->key.objectid, bg->key.offset,
+				bg->flags & BTRFS_BLOCK_GROUP_TYPE_MASK);
+			ret = -EUCLEAN;
+			free_extent_map(em);
+			btrfs_put_block_group(bg);
+			break;
+		}
+		start = em->start + em->len;
+		free_extent_map(em);
+		btrfs_put_block_group(bg);
+	}
+	return ret;
+}
+
+int btrfs_read_block_groups(struct btrfs_fs_info *info)
+{
+	struct btrfs_path *path;
+	int ret;
+	struct btrfs_block_group_cache *cache;
+	struct btrfs_space_info *space_info;
+	struct btrfs_key key;
+	struct btrfs_key found_key;
+	struct extent_buffer *leaf;
+	int need_clear = 0;
+	u64 cache_gen;
+	u64 feature;
+	int mixed;
+
+	feature = btrfs_super_incompat_flags(info->super_copy);
+	mixed = !!(feature & BTRFS_FEATURE_INCOMPAT_MIXED_GROUPS);
+
+	key.objectid = 0;
+	key.offset = 0;
+	key.type = BTRFS_BLOCK_GROUP_ITEM_KEY;
+	path = btrfs_alloc_path();
+	if (!path)
+		return -ENOMEM;
+	path->reada = READA_FORWARD;
+
+	cache_gen = btrfs_super_cache_generation(info->super_copy);
+	if (btrfs_test_opt(info, SPACE_CACHE) &&
+	    btrfs_super_generation(info->super_copy) != cache_gen)
+		need_clear = 1;
+	if (btrfs_test_opt(info, CLEAR_CACHE))
+		need_clear = 1;
+
+	while (1) {
+		ret = find_first_block_group(info, path, &key);
+		if (ret > 0)
+			break;
+		if (ret != 0)
+			goto error;
+
+		leaf = path->nodes[0];
+		btrfs_item_key_to_cpu(leaf, &found_key, path->slots[0]);
+
+		cache = btrfs_create_block_group_cache(info, found_key.objectid,
+						       found_key.offset);
+		if (!cache) {
+			ret = -ENOMEM;
+			goto error;
+		}
+
+		if (need_clear) {
+			/*
+			 * When we mount with old space cache, we need to
+			 * set BTRFS_DC_CLEAR and set dirty flag.
+			 *
+			 * a) Setting 'BTRFS_DC_CLEAR' makes sure that we
+			 *    truncate the old free space cache inode and
+			 *    setup a new one.
+			 * b) Setting 'dirty flag' makes sure that we flush
+			 *    the new space cache info onto disk.
+			 */
+			if (btrfs_test_opt(info, SPACE_CACHE))
+				cache->disk_cache_state = BTRFS_DC_CLEAR;
+		}
+
+		read_extent_buffer(leaf, &cache->item,
+				   btrfs_item_ptr_offset(leaf, path->slots[0]),
+				   sizeof(cache->item));
+		cache->flags = btrfs_block_group_flags(&cache->item);
+		if (!mixed &&
+		    ((cache->flags & BTRFS_BLOCK_GROUP_METADATA) &&
+		    (cache->flags & BTRFS_BLOCK_GROUP_DATA))) {
+			btrfs_err(info,
+"bg %llu is a mixed block group but filesystem hasn't enabled mixed block groups",
+				  cache->key.objectid);
+			ret = -EINVAL;
+			goto error;
+		}
+
+		key.objectid = found_key.objectid + found_key.offset;
+		btrfs_release_path(path);
+
+		/*
+		 * We need to exclude the super stripes now so that the space
+		 * info has super bytes accounted for, otherwise we'll think
+		 * we have more space than we actually do.
+		 */
+		ret = exclude_super_stripes(cache);
+		if (ret) {
+			/*
+			 * We may have excluded something, so call this just in
+			 * case.
+			 */
+			btrfs_free_excluded_extents(cache);
+			btrfs_put_block_group(cache);
+			goto error;
+		}
+
+		/*
+		 * check for two cases, either we are full, and therefore
+		 * don't need to bother with the caching work since we won't
+		 * find any space, or we are empty, and we can just add all
+		 * the space in and be done with it.  This saves us _a_lot_ of
+		 * time, particularly in the full case.
+		 */
+		if (found_key.offset == btrfs_block_group_used(&cache->item)) {
+			cache->last_byte_to_unpin = (u64)-1;
+			cache->cached = BTRFS_CACHE_FINISHED;
+			btrfs_free_excluded_extents(cache);
+		} else if (btrfs_block_group_used(&cache->item) == 0) {
+			cache->last_byte_to_unpin = (u64)-1;
+			cache->cached = BTRFS_CACHE_FINISHED;
+			add_new_free_space(cache, found_key.objectid,
+					   found_key.objectid +
+					   found_key.offset);
+			btrfs_free_excluded_extents(cache);
+		}
+
+		ret = btrfs_add_block_group_cache(info, cache);
+		if (ret) {
+			btrfs_remove_free_space_cache(cache);
+			btrfs_put_block_group(cache);
+			goto error;
+		}
+
+		trace_btrfs_add_block_group(info, cache, 0);
+		btrfs_update_space_info(info, cache->flags, found_key.offset,
+					btrfs_block_group_used(&cache->item),
+					cache->bytes_super, &space_info);
+
+		cache->space_info = space_info;
+
+		link_block_group(cache);
+
+		set_avail_alloc_bits(info, cache->flags);
+		if (btrfs_chunk_readonly(info, cache->key.objectid)) {
+			__btrfs_inc_block_group_ro(cache, 1);
+		} else if (btrfs_block_group_used(&cache->item) == 0) {
+			ASSERT(list_empty(&cache->bg_list));
+			btrfs_mark_bg_unused(cache);
+		}
+	}
+
+	list_for_each_entry_rcu(space_info, &info->space_info, list) {
+		if (!(btrfs_get_alloc_profile(info, space_info->flags) &
+		      (BTRFS_BLOCK_GROUP_RAID10 |
+		       BTRFS_BLOCK_GROUP_RAID1_MASK |
+		       BTRFS_BLOCK_GROUP_RAID56_MASK |
+		       BTRFS_BLOCK_GROUP_DUP)))
+			continue;
+		/*
+		 * avoid allocating from un-mirrored block group if there are
+		 * mirrored block groups.
+		 */
+		list_for_each_entry(cache,
+				&space_info->block_groups[BTRFS_RAID_RAID0],
+				list)
+			__btrfs_inc_block_group_ro(cache, 1);
+		list_for_each_entry(cache,
+				&space_info->block_groups[BTRFS_RAID_SINGLE],
+				list)
+			__btrfs_inc_block_group_ro(cache, 1);
+	}
+
+	btrfs_add_raid_kobjects(info);
+	btrfs_init_global_block_rsv(info);
+	ret = check_chunk_block_group_mappings(info);
+error:
+	btrfs_free_path(path);
+	return ret;
+}
+
+void btrfs_create_pending_block_groups(struct btrfs_trans_handle *trans)
+{
+	struct btrfs_fs_info *fs_info = trans->fs_info;
+	struct btrfs_block_group_cache *block_group;
+	struct btrfs_root *extent_root = fs_info->extent_root;
+	struct btrfs_block_group_item item;
+	struct btrfs_key key;
+	int ret = 0;
+
+	if (!trans->can_flush_pending_bgs)
+		return;
+
+	while (!list_empty(&trans->new_bgs)) {
+		block_group = list_first_entry(&trans->new_bgs,
+					       struct btrfs_block_group_cache,
+					       bg_list);
+		if (ret)
+			goto next;
+
+		spin_lock(&block_group->lock);
+		memcpy(&item, &block_group->item, sizeof(item));
+		memcpy(&key, &block_group->key, sizeof(key));
+		spin_unlock(&block_group->lock);
+
+		ret = btrfs_insert_item(trans, extent_root, &key, &item,
+					sizeof(item));
+		if (ret)
+			btrfs_abort_transaction(trans, ret);
+		ret = btrfs_finish_chunk_alloc(trans, key.objectid, key.offset);
+		if (ret)
+			btrfs_abort_transaction(trans, ret);
+		add_block_group_free_space(trans, block_group);
+		/* already aborted the transaction if it failed. */
+next:
+		btrfs_delayed_refs_rsv_release(fs_info, 1);
+		list_del_init(&block_group->bg_list);
+	}
+	btrfs_trans_release_chunk_metadata(trans);
+}
+
+int btrfs_make_block_group(struct btrfs_trans_handle *trans, u64 bytes_used,
+			   u64 type, u64 chunk_offset, u64 size)
+{
+	struct btrfs_fs_info *fs_info = trans->fs_info;
+	struct btrfs_block_group_cache *cache;
+	int ret;
+
+	btrfs_set_log_full_commit(trans);
+
+	cache = btrfs_create_block_group_cache(fs_info, chunk_offset, size);
+	if (!cache)
+		return -ENOMEM;
+
+	btrfs_set_block_group_used(&cache->item, bytes_used);
+	btrfs_set_block_group_chunk_objectid(&cache->item,
+					     BTRFS_FIRST_CHUNK_TREE_OBJECTID);
+	btrfs_set_block_group_flags(&cache->item, type);
+
+	cache->flags = type;
+	cache->last_byte_to_unpin = (u64)-1;
+	cache->cached = BTRFS_CACHE_FINISHED;
+	cache->needs_free_space = 1;
+	ret = exclude_super_stripes(cache);
+	if (ret) {
+		/*
+		 * We may have excluded something, so call this just in
+		 * case.
+		 */
+		btrfs_free_excluded_extents(cache);
+		btrfs_put_block_group(cache);
+		return ret;
+	}
+
+	add_new_free_space(cache, chunk_offset, chunk_offset + size);
+
+	btrfs_free_excluded_extents(cache);
+
+#ifdef CONFIG_BTRFS_DEBUG
+	if (btrfs_should_fragment_free_space(cache)) {
+		u64 new_bytes_used = size - bytes_used;
+
+		bytes_used += new_bytes_used >> 1;
+		btrfs_fragment_free_space(cache);
+	}
+#endif
+	/*
+	 * Ensure the corresponding space_info object is created and
+	 * assigned to our block group. We want our bg to be added to the rbtree
+	 * with its ->space_info set.
+	 */
+	cache->space_info = btrfs_find_space_info(fs_info, cache->flags);
+	ASSERT(cache->space_info);
+
+	ret = btrfs_add_block_group_cache(fs_info, cache);
+	if (ret) {
+		btrfs_remove_free_space_cache(cache);
+		btrfs_put_block_group(cache);
+		return ret;
+	}
+
+	/*
+	 * Now that our block group has its ->space_info set and is inserted in
+	 * the rbtree, update the space info's counters.
+	 */
+	trace_btrfs_add_block_group(fs_info, cache, 1);
+	btrfs_update_space_info(fs_info, cache->flags, size, bytes_used,
+				cache->bytes_super, &cache->space_info);
+	btrfs_update_global_block_rsv(fs_info);
+
+	link_block_group(cache);
+
+	list_add_tail(&cache->bg_list, &trans->new_bgs);
+	trans->delayed_ref_updates++;
+	btrfs_update_delayed_refs_rsv(trans);
+
+	set_avail_alloc_bits(fs_info, type);
+	return 0;
+}
diff --git a/fs/btrfs/block-group.h b/fs/btrfs/block-group.h
index 5ee2ea695ab0..2745b99e5ae2 100644
--- a/fs/btrfs/block-group.h
+++ b/fs/btrfs/block-group.h
@@ -183,6 +183,11 @@ int btrfs_remove_block_group(struct btrfs_trans_handle *trans,
 			     u64 group_start, struct extent_map *em);
 void btrfs_delete_unused_bgs(struct btrfs_fs_info *fs_info);
 void btrfs_mark_bg_unused(struct btrfs_block_group_cache *bg);
+int btrfs_read_block_groups(struct btrfs_fs_info *info);
+int btrfs_make_block_group(struct btrfs_trans_handle *trans,
+			   u64 bytes_used, u64 type, u64 chunk_offset,
+			   u64 size);
+void btrfs_create_pending_block_groups(struct btrfs_trans_handle *trans);
 
 static inline int btrfs_block_group_cache_done(
 		struct btrfs_block_group_cache *cache)
diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 460f2c53e428..1cfe7adddc97 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -2527,13 +2527,8 @@ int btrfs_write_dirty_block_groups(struct btrfs_trans_handle *trans);
 int btrfs_setup_space_cache(struct btrfs_trans_handle *trans);
 int btrfs_extent_readonly(struct btrfs_fs_info *fs_info, u64 bytenr);
 int btrfs_free_block_groups(struct btrfs_fs_info *info);
-int btrfs_read_block_groups(struct btrfs_fs_info *info);
-int btrfs_make_block_group(struct btrfs_trans_handle *trans,
-			   u64 bytes_used, u64 type, u64 chunk_offset,
-			   u64 size);
 void btrfs_get_block_group_trimming(struct btrfs_block_group_cache *cache);
 void btrfs_put_block_group_trimming(struct btrfs_block_group_cache *cache);
-void btrfs_create_pending_block_groups(struct btrfs_trans_handle *trans);
 u64 btrfs_data_alloc_profile(struct btrfs_fs_info *fs_info);
 u64 btrfs_metadata_alloc_profile(struct btrfs_fs_info *fs_info);
 u64 btrfs_system_alloc_profile(struct btrfs_fs_info *fs_info);
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 791a2c43a1c0..37556ce36d68 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -59,46 +59,6 @@ static int block_group_bits(struct btrfs_block_group_cache *cache, u64 bits)
 	return (cache->flags & bits) == bits;
 }
 
-/*
- * this adds the block group to the fs_info rb tree for the block group
- * cache
- */
-static int btrfs_add_block_group_cache(struct btrfs_fs_info *info,
-				struct btrfs_block_group_cache *block_group)
-{
-	struct rb_node **p;
-	struct rb_node *parent = NULL;
-	struct btrfs_block_group_cache *cache;
-
-	spin_lock(&info->block_group_cache_lock);
-	p = &info->block_group_cache_tree.rb_node;
-
-	while (*p) {
-		parent = *p;
-		cache = rb_entry(parent, struct btrfs_block_group_cache,
-				 cache_node);
-		if (block_group->key.objectid < cache->key.objectid) {
-			p = &(*p)->rb_left;
-		} else if (block_group->key.objectid > cache->key.objectid) {
-			p = &(*p)->rb_right;
-		} else {
-			spin_unlock(&info->block_group_cache_lock);
-			return -EEXIST;
-		}
-	}
-
-	rb_link_node(&block_group->cache_node, parent, p);
-	rb_insert_color(&block_group->cache_node,
-			&info->block_group_cache_tree);
-
-	if (info->first_logical_byte > block_group->key.objectid)
-		info->first_logical_byte = block_group->key.objectid;
-
-	spin_unlock(&info->block_group_cache_lock);
-
-	return 0;
-}
-
 int btrfs_add_excluded_extent(struct btrfs_fs_info *fs_info,
 			      u64 start, u64 num_bytes)
 {
@@ -124,63 +84,6 @@ void btrfs_free_excluded_extents(struct btrfs_block_group_cache *cache)
 			  start, end, EXTENT_UPTODATE);
 }
 
-static int exclude_super_stripes(struct btrfs_block_group_cache *cache)
-{
-	struct btrfs_fs_info *fs_info = cache->fs_info;
-	u64 bytenr;
-	u64 *logical;
-	int stripe_len;
-	int i, nr, ret;
-
-	if (cache->key.objectid < BTRFS_SUPER_INFO_OFFSET) {
-		stripe_len = BTRFS_SUPER_INFO_OFFSET - cache->key.objectid;
-		cache->bytes_super += stripe_len;
-		ret = btrfs_add_excluded_extent(fs_info, cache->key.objectid,
-						stripe_len);
-		if (ret)
-			return ret;
-	}
-
-	for (i = 0; i < BTRFS_SUPER_MIRROR_MAX; i++) {
-		bytenr = btrfs_sb_offset(i);
-		ret = btrfs_rmap_block(fs_info, cache->key.objectid,
-				       bytenr, &logical, &nr, &stripe_len);
-		if (ret)
-			return ret;
-
-		while (nr--) {
-			u64 start, len;
-
-			if (logical[nr] > cache->key.objectid +
-			    cache->key.offset)
-				continue;
-
-			if (logical[nr] + stripe_len <= cache->key.objectid)
-				continue;
-
-			start = logical[nr];
-			if (start < cache->key.objectid) {
-				start = cache->key.objectid;
-				len = (logical[nr] + stripe_len) - start;
-			} else {
-				len = min_t(u64, stripe_len,
-					    cache->key.objectid +
-					    cache->key.offset - start);
-			}
-
-			cache->bytes_super += len;
-			ret = btrfs_add_excluded_extent(fs_info, start, len);
-			if (ret) {
-				kfree(logical);
-				return ret;
-			}
-		}
-
-		kfree(logical);
-	}
-	return 0;
-}
-
 static u64 generic_ref_to_space_flags(struct btrfs_ref *ref)
 {
 	if (ref->type == BTRFS_REF_METADATA) {
@@ -3160,21 +3063,6 @@ int btrfs_extent_readonly(struct btrfs_fs_info *fs_info, u64 bytenr)
 	return readonly;
 }
 
-static void set_avail_alloc_bits(struct btrfs_fs_info *fs_info, u64 flags)
-{
-	u64 extra_flags = chunk_to_extended(flags) &
-				BTRFS_EXTENDED_PROFILE_MASK;
-
-	write_seqlock(&fs_info->profiles_lock);
-	if (flags & BTRFS_BLOCK_GROUP_DATA)
-		fs_info->avail_data_alloc_bits |= extra_flags;
-	if (flags & BTRFS_BLOCK_GROUP_METADATA)
-		fs_info->avail_metadata_alloc_bits |= extra_flags;
-	if (flags & BTRFS_BLOCK_GROUP_SYSTEM)
-		fs_info->avail_system_alloc_bits |= extra_flags;
-	write_sequnlock(&fs_info->profiles_lock);
-}
-
 /*
  * returns target flags in extended format or 0 if restripe for this
  * chunk_type is not in progress
@@ -7030,86 +6918,6 @@ void btrfs_dec_block_group_ro(struct btrfs_block_group_cache *cache)
 	spin_unlock(&sinfo->lock);
 }
 
-static int find_first_block_group(struct btrfs_fs_info *fs_info,
-				  struct btrfs_path *path,
-				  struct btrfs_key *key)
-{
-	struct btrfs_root *root = fs_info->extent_root;
-	int ret = 0;
-	struct btrfs_key found_key;
-	struct extent_buffer *leaf;
-	struct btrfs_block_group_item bg;
-	u64 flags;
-	int slot;
-
-	ret = btrfs_search_slot(NULL, root, key, path, 0, 0);
-	if (ret < 0)
-		goto out;
-
-	while (1) {
-		slot = path->slots[0];
-		leaf = path->nodes[0];
-		if (slot >= btrfs_header_nritems(leaf)) {
-			ret = btrfs_next_leaf(root, path);
-			if (ret == 0)
-				continue;
-			if (ret < 0)
-				goto out;
-			break;
-		}
-		btrfs_item_key_to_cpu(leaf, &found_key, slot);
-
-		if (found_key.objectid >= key->objectid &&
-		    found_key.type == BTRFS_BLOCK_GROUP_ITEM_KEY) {
-			struct extent_map_tree *em_tree;
-			struct extent_map *em;
-
-			em_tree = &root->fs_info->mapping_tree;
-			read_lock(&em_tree->lock);
-			em = lookup_extent_mapping(em_tree, found_key.objectid,
-						   found_key.offset);
-			read_unlock(&em_tree->lock);
-			if (!em) {
-				btrfs_err(fs_info,
-			"logical %llu len %llu found bg but no related chunk",
-					  found_key.objectid, found_key.offset);
-				ret = -ENOENT;
-			} else if (em->start != found_key.objectid ||
-				   em->len != found_key.offset) {
-				btrfs_err(fs_info,
-		"block group %llu len %llu mismatch with chunk %llu len %llu",
-					  found_key.objectid, found_key.offset,
-					  em->start, em->len);
-				ret = -EUCLEAN;
-			} else {
-				read_extent_buffer(leaf, &bg,
-					btrfs_item_ptr_offset(leaf, slot),
-					sizeof(bg));
-				flags = btrfs_block_group_flags(&bg) &
-					BTRFS_BLOCK_GROUP_TYPE_MASK;
-
-				if (flags != (em->map_lookup->type &
-					      BTRFS_BLOCK_GROUP_TYPE_MASK)) {
-					btrfs_err(fs_info,
-"block group %llu len %llu type flags 0x%llx mismatch with chunk type flags 0x%llx",
-						found_key.objectid,
-						found_key.offset, flags,
-						(BTRFS_BLOCK_GROUP_TYPE_MASK &
-						 em->map_lookup->type));
-					ret = -EUCLEAN;
-				} else {
-					ret = 0;
-				}
-			}
-			free_extent_map(em);
-			goto out;
-		}
-		path->slots[0]++;
-	}
-out:
-	return ret;
-}
-
 void btrfs_put_block_group_cache(struct btrfs_fs_info *info)
 {
 	struct btrfs_block_group_cache *block_group;
@@ -7238,410 +7046,6 @@ int btrfs_free_block_groups(struct btrfs_fs_info *info)
 	return 0;
 }
 
-static void link_block_group(struct btrfs_block_group_cache *cache)
-{
-	struct btrfs_space_info *space_info = cache->space_info;
-	int index = btrfs_bg_flags_to_raid_index(cache->flags);
-	bool first = false;
-
-	down_write(&space_info->groups_sem);
-	if (list_empty(&space_info->block_groups[index]))
-		first = true;
-	list_add_tail(&cache->list, &space_info->block_groups[index]);
-	up_write(&space_info->groups_sem);
-
-	if (first)
-		btrfs_sysfs_add_block_group_type(cache);
-}
-
-static struct btrfs_block_group_cache *
-btrfs_create_block_group_cache(struct btrfs_fs_info *fs_info,
-			       u64 start, u64 size)
-{
-	struct btrfs_block_group_cache *cache;
-
-	cache = kzalloc(sizeof(*cache), GFP_NOFS);
-	if (!cache)
-		return NULL;
-
-	cache->free_space_ctl = kzalloc(sizeof(*cache->free_space_ctl),
-					GFP_NOFS);
-	if (!cache->free_space_ctl) {
-		kfree(cache);
-		return NULL;
-	}
-
-	cache->key.objectid = start;
-	cache->key.offset = size;
-	cache->key.type = BTRFS_BLOCK_GROUP_ITEM_KEY;
-
-	cache->fs_info = fs_info;
-	cache->full_stripe_len = btrfs_full_stripe_len(fs_info, start);
-	set_free_space_tree_thresholds(cache);
-
-	atomic_set(&cache->count, 1);
-	spin_lock_init(&cache->lock);
-	init_rwsem(&cache->data_rwsem);
-	INIT_LIST_HEAD(&cache->list);
-	INIT_LIST_HEAD(&cache->cluster_list);
-	INIT_LIST_HEAD(&cache->bg_list);
-	INIT_LIST_HEAD(&cache->ro_list);
-	INIT_LIST_HEAD(&cache->dirty_list);
-	INIT_LIST_HEAD(&cache->io_list);
-	btrfs_init_free_space_ctl(cache);
-	atomic_set(&cache->trimming, 0);
-	mutex_init(&cache->free_space_lock);
-	btrfs_init_full_stripe_locks_tree(&cache->full_stripe_locks_root);
-
-	return cache;
-}
-
-
-/*
- * Iterate all chunks and verify that each of them has the corresponding block
- * group
- */
-static int check_chunk_block_group_mappings(struct btrfs_fs_info *fs_info)
-{
-	struct extent_map_tree *map_tree = &fs_info->mapping_tree;
-	struct extent_map *em;
-	struct btrfs_block_group_cache *bg;
-	u64 start = 0;
-	int ret = 0;
-
-	while (1) {
-		read_lock(&map_tree->lock);
-		/*
-		 * lookup_extent_mapping will return the first extent map
-		 * intersecting the range, so setting @len to 1 is enough to
-		 * get the first chunk.
-		 */
-		em = lookup_extent_mapping(map_tree, start, 1);
-		read_unlock(&map_tree->lock);
-		if (!em)
-			break;
-
-		bg = btrfs_lookup_block_group(fs_info, em->start);
-		if (!bg) {
-			btrfs_err(fs_info,
-	"chunk start=%llu len=%llu doesn't have corresponding block group",
-				     em->start, em->len);
-			ret = -EUCLEAN;
-			free_extent_map(em);
-			break;
-		}
-		if (bg->key.objectid != em->start ||
-		    bg->key.offset != em->len ||
-		    (bg->flags & BTRFS_BLOCK_GROUP_TYPE_MASK) !=
-		    (em->map_lookup->type & BTRFS_BLOCK_GROUP_TYPE_MASK)) {
-			btrfs_err(fs_info,
-"chunk start=%llu len=%llu flags=0x%llx doesn't match block group start=%llu len=%llu flags=0x%llx",
-				em->start, em->len,
-				em->map_lookup->type & BTRFS_BLOCK_GROUP_TYPE_MASK,
-				bg->key.objectid, bg->key.offset,
-				bg->flags & BTRFS_BLOCK_GROUP_TYPE_MASK);
-			ret = -EUCLEAN;
-			free_extent_map(em);
-			btrfs_put_block_group(bg);
-			break;
-		}
-		start = em->start + em->len;
-		free_extent_map(em);
-		btrfs_put_block_group(bg);
-	}
-	return ret;
-}
-
-int btrfs_read_block_groups(struct btrfs_fs_info *info)
-{
-	struct btrfs_path *path;
-	int ret;
-	struct btrfs_block_group_cache *cache;
-	struct btrfs_space_info *space_info;
-	struct btrfs_key key;
-	struct btrfs_key found_key;
-	struct extent_buffer *leaf;
-	int need_clear = 0;
-	u64 cache_gen;
-	u64 feature;
-	int mixed;
-
-	feature = btrfs_super_incompat_flags(info->super_copy);
-	mixed = !!(feature & BTRFS_FEATURE_INCOMPAT_MIXED_GROUPS);
-
-	key.objectid = 0;
-	key.offset = 0;
-	key.type = BTRFS_BLOCK_GROUP_ITEM_KEY;
-	path = btrfs_alloc_path();
-	if (!path)
-		return -ENOMEM;
-	path->reada = READA_FORWARD;
-
-	cache_gen = btrfs_super_cache_generation(info->super_copy);
-	if (btrfs_test_opt(info, SPACE_CACHE) &&
-	    btrfs_super_generation(info->super_copy) != cache_gen)
-		need_clear = 1;
-	if (btrfs_test_opt(info, CLEAR_CACHE))
-		need_clear = 1;
-
-	while (1) {
-		ret = find_first_block_group(info, path, &key);
-		if (ret > 0)
-			break;
-		if (ret != 0)
-			goto error;
-
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
-			goto error;
-		}
-
-		key.objectid = found_key.objectid + found_key.offset;
-		btrfs_release_path(path);
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
-		 * check for two cases, either we are full, and therefore
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
-			__btrfs_inc_block_group_ro(cache, 1);
-		} else if (btrfs_block_group_used(&cache->item) == 0) {
-			ASSERT(list_empty(&cache->bg_list));
-			btrfs_mark_bg_unused(cache);
-		}
-	}
-
-	list_for_each_entry_rcu(space_info, &info->space_info, list) {
-		if (!(btrfs_get_alloc_profile(info, space_info->flags) &
-		      (BTRFS_BLOCK_GROUP_RAID10 |
-		       BTRFS_BLOCK_GROUP_RAID1_MASK |
-		       BTRFS_BLOCK_GROUP_RAID56_MASK |
-		       BTRFS_BLOCK_GROUP_DUP)))
-			continue;
-		/*
-		 * avoid allocating from un-mirrored block group if there are
-		 * mirrored block groups.
-		 */
-		list_for_each_entry(cache,
-				&space_info->block_groups[BTRFS_RAID_RAID0],
-				list)
-			__btrfs_inc_block_group_ro(cache, 1);
-		list_for_each_entry(cache,
-				&space_info->block_groups[BTRFS_RAID_SINGLE],
-				list)
-			__btrfs_inc_block_group_ro(cache, 1);
-	}
-
-	btrfs_add_raid_kobjects(info);
-	btrfs_init_global_block_rsv(info);
-	ret = check_chunk_block_group_mappings(info);
-error:
-	btrfs_free_path(path);
-	return ret;
-}
-
-void btrfs_create_pending_block_groups(struct btrfs_trans_handle *trans)
-{
-	struct btrfs_fs_info *fs_info = trans->fs_info;
-	struct btrfs_block_group_cache *block_group;
-	struct btrfs_root *extent_root = fs_info->extent_root;
-	struct btrfs_block_group_item item;
-	struct btrfs_key key;
-	int ret = 0;
-
-	if (!trans->can_flush_pending_bgs)
-		return;
-
-	while (!list_empty(&trans->new_bgs)) {
-		block_group = list_first_entry(&trans->new_bgs,
-					       struct btrfs_block_group_cache,
-					       bg_list);
-		if (ret)
-			goto next;
-
-		spin_lock(&block_group->lock);
-		memcpy(&item, &block_group->item, sizeof(item));
-		memcpy(&key, &block_group->key, sizeof(key));
-		spin_unlock(&block_group->lock);
-
-		ret = btrfs_insert_item(trans, extent_root, &key, &item,
-					sizeof(item));
-		if (ret)
-			btrfs_abort_transaction(trans, ret);
-		ret = btrfs_finish_chunk_alloc(trans, key.objectid, key.offset);
-		if (ret)
-			btrfs_abort_transaction(trans, ret);
-		add_block_group_free_space(trans, block_group);
-		/* already aborted the transaction if it failed. */
-next:
-		btrfs_delayed_refs_rsv_release(fs_info, 1);
-		list_del_init(&block_group->bg_list);
-	}
-	btrfs_trans_release_chunk_metadata(trans);
-}
-
-int btrfs_make_block_group(struct btrfs_trans_handle *trans, u64 bytes_used,
-			   u64 type, u64 chunk_offset, u64 size)
-{
-	struct btrfs_fs_info *fs_info = trans->fs_info;
-	struct btrfs_block_group_cache *cache;
-	int ret;
-
-	btrfs_set_log_full_commit(trans);
-
-	cache = btrfs_create_block_group_cache(fs_info, chunk_offset, size);
-	if (!cache)
-		return -ENOMEM;
-
-	btrfs_set_block_group_used(&cache->item, bytes_used);
-	btrfs_set_block_group_chunk_objectid(&cache->item,
-					     BTRFS_FIRST_CHUNK_TREE_OBJECTID);
-	btrfs_set_block_group_flags(&cache->item, type);
-
-	cache->flags = type;
-	cache->last_byte_to_unpin = (u64)-1;
-	cache->cached = BTRFS_CACHE_FINISHED;
-	cache->needs_free_space = 1;
-	ret = exclude_super_stripes(cache);
-	if (ret) {
-		/*
-		 * We may have excluded something, so call this just in
-		 * case.
-		 */
-		btrfs_free_excluded_extents(cache);
-		btrfs_put_block_group(cache);
-		return ret;
-	}
-
-	add_new_free_space(cache, chunk_offset, chunk_offset + size);
-
-	btrfs_free_excluded_extents(cache);
-
-#ifdef CONFIG_BTRFS_DEBUG
-	if (btrfs_should_fragment_free_space(cache)) {
-		u64 new_bytes_used = size - bytes_used;
-
-		bytes_used += new_bytes_used >> 1;
-		btrfs_fragment_free_space(cache);
-	}
-#endif
-	/*
-	 * Ensure the corresponding space_info object is created and
-	 * assigned to our block group. We want our bg to be added to the rbtree
-	 * with its ->space_info set.
-	 */
-	cache->space_info = btrfs_find_space_info(fs_info, cache->flags);
-	ASSERT(cache->space_info);
-
-	ret = btrfs_add_block_group_cache(fs_info, cache);
-	if (ret) {
-		btrfs_remove_free_space_cache(cache);
-		btrfs_put_block_group(cache);
-		return ret;
-	}
-
-	/*
-	 * Now that our block group has its ->space_info set and is inserted in
-	 * the rbtree, update the space info's counters.
-	 */
-	trace_btrfs_add_block_group(fs_info, cache, 1);
-	btrfs_update_space_info(fs_info, cache->flags, size, bytes_used,
-				cache->bytes_super, &cache->space_info);
-	btrfs_update_global_block_rsv(fs_info);
-
-	link_block_group(cache);
-
-	list_add_tail(&cache->bg_list, &trans->new_bgs);
-	trans->delayed_ref_updates++;
-	btrfs_update_delayed_refs_rsv(trans);
-
-	set_avail_alloc_bits(fs_info, type);
-	return 0;
-}
-
 int btrfs_error_unpin_extent_range(struct btrfs_fs_info *fs_info,
 				   u64 start, u64 end)
 {
-- 
2.21.0

