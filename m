Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B7307CED45
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Oct 2019 22:18:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729087AbfJGUR6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 7 Oct 2019 16:17:58 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:36527 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728187AbfJGUR5 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 7 Oct 2019 16:17:57 -0400
Received: by mail-qk1-f194.google.com with SMTP id y189so13946744qkc.3
        for <linux-btrfs@vger.kernel.org>; Mon, 07 Oct 2019 13:17:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=Znc6CSWmUawJXrzFyLl0vEfpwCOgVYbEeV0r3nCJYGY=;
        b=nqrI4r5/VUzN7BDXK2DDKZ+eaAol1YwxRmzDhpGapQknbUCaE7QaZhrwcBf24dvT+N
         +SY55/zSWGiBOxhuES9AQiBcWjOyOV7kAFNl2SQVb2JytH/3A3NPuOxzmli2qtp/htFm
         m/cTVyPL3CoQEgozkL6DF1wy8ZCPvqwKPLyWwJ95dFZ2BvZZuezgkD5L1OP1pPoFy2mD
         e8e/FWsfRrweoE3Qt8gZldsdJGTf1Qvr6xu2W+t4SixlsIOhwyTKWPMAZ5fCPlZMUVkA
         9PAsIN2ewaB4IN88Zc8Tr3YbgyY/OT9KEv/9vipctHpqcmvGLSCW1C6a+RcyjO1u5VRo
         Ya0Q==
X-Gm-Message-State: APjAAAXGrcEaVO6s2fCAFwyI4I5gA+T2ziowhzIkqpxsB+g6TEGKe3Pl
        iwLyce4UgTle30d4jDkTznuUX8wo
X-Google-Smtp-Source: APXvYqyaVktRSqfpjmz00X7Ko3xv12p5JMJeJKpfhFq6ePKxu2O9T/9NSNW8bmEi9gu53N5/kAS5LA==
X-Received: by 2002:a37:a44f:: with SMTP id n76mr3876807qke.414.1570479476772;
        Mon, 07 Oct 2019 13:17:56 -0700 (PDT)
Received: from dennisz-mbp.thefacebook.com ([163.114.130.128])
        by smtp.gmail.com with ESMTPSA id k2sm6904005qtm.42.2019.10.07.13.17.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 07 Oct 2019 13:17:56 -0700 (PDT)
From:   Dennis Zhou <dennis@kernel.org>
To:     David Sterba <dsterba@suse.com>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Omar Sandoval <osandov@osandov.com>
Cc:     kernel-team@fb.com, linux-btrfs@vger.kernel.org,
        Dennis Zhou <dennis@kernel.org>
Subject: [PATCH 03/19] btrfs: keep track of which extents have been discarded
Date:   Mon,  7 Oct 2019 16:17:34 -0400
Message-Id: <5875088b5f4ada0ef73f097b238935dd583d5b3e.1570479299.git.dennis@kernel.org>
X-Mailer: git-send-email 2.13.5
In-Reply-To: <cover.1570479299.git.dennis@kernel.org>
References: <cover.1570479299.git.dennis@kernel.org>
In-Reply-To: <cover.1570479299.git.dennis@kernel.org>
References: <cover.1570479299.git.dennis@kernel.org>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Async discard will use the free space cache as backing knowledge for
which extents to discard. This patch plumbs knowledge about which
extents need to be discarded into the free space cache from
unpin_extent_range().

An untrimmed extent can merge with everything as this is a new region.
Absorbing trimmed extents is a tradeoff to for greater coalescing which
makes life better for find_free_extent(). Additionally, it seems the
size of a trim isn't as problematic as the trim io itself.

When reading in the free space cache from disk, if sync is set, mark all
extents as trimmed. The current code ensures at transaction commit that
all free space is trimmed when sync is set, so this reflects that.

Signed-off-by: Dennis Zhou <dennis@kernel.org>
---
 fs/btrfs/extent-tree.c      | 15 ++++++++++-----
 fs/btrfs/free-space-cache.c | 38 ++++++++++++++++++++++++++++++-------
 fs/btrfs/free-space-cache.h | 10 +++++++++-
 fs/btrfs/inode-map.c        | 13 +++++++------
 4 files changed, 57 insertions(+), 19 deletions(-)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 77a5904756c5..b9e3bedad878 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -2782,7 +2782,7 @@ fetch_cluster_info(struct btrfs_fs_info *fs_info,
 }
 
 static int unpin_extent_range(struct btrfs_fs_info *fs_info,
-			      u64 start, u64 end,
+			      u64 start, u64 end, u32 fsc_flags,
 			      const bool return_free_space)
 {
 	struct btrfs_block_group_cache *cache = NULL;
@@ -2816,7 +2816,9 @@ static int unpin_extent_range(struct btrfs_fs_info *fs_info,
 		if (start < cache->last_byte_to_unpin) {
 			len = min(len, cache->last_byte_to_unpin - start);
 			if (return_free_space)
-				btrfs_add_free_space(cache, start, len);
+				__btrfs_add_free_space(fs_info,
+						       cache->free_space_ctl,
+						       start, len, fsc_flags);
 		}
 
 		start += len;
@@ -2894,6 +2896,7 @@ int btrfs_finish_extent_commit(struct btrfs_trans_handle *trans)
 
 	while (!trans->aborted) {
 		struct extent_state *cached_state = NULL;
+		u32 fsc_flags = 0;
 
 		mutex_lock(&fs_info->unused_bg_unpin_mutex);
 		ret = find_first_extent_bit(unpin, 0, &start, &end,
@@ -2903,12 +2906,14 @@ int btrfs_finish_extent_commit(struct btrfs_trans_handle *trans)
 			break;
 		}
 
-		if (btrfs_test_opt(fs_info, DISCARD_SYNC))
+		if (btrfs_test_opt(fs_info, DISCARD_SYNC)) {
 			ret = btrfs_discard_extent(fs_info, start,
 						   end + 1 - start, NULL);
+			fsc_flags |= BTRFS_FSC_TRIMMED;
+		}
 
 		clear_extent_dirty(unpin, start, end, &cached_state);
-		unpin_extent_range(fs_info, start, end, true);
+		unpin_extent_range(fs_info, start, end, fsc_flags, true);
 		mutex_unlock(&fs_info->unused_bg_unpin_mutex);
 		free_extent_state(cached_state);
 		cond_resched();
@@ -5512,7 +5517,7 @@ u64 btrfs_account_ro_block_groups_free_space(struct btrfs_space_info *sinfo)
 int btrfs_error_unpin_extent_range(struct btrfs_fs_info *fs_info,
 				   u64 start, u64 end)
 {
-	return unpin_extent_range(fs_info, start, end, false);
+	return unpin_extent_range(fs_info, start, end, 0, false);
 }
 
 /*
diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
index d54dcd0ab230..f119895292b8 100644
--- a/fs/btrfs/free-space-cache.c
+++ b/fs/btrfs/free-space-cache.c
@@ -747,6 +747,14 @@ static int __load_free_space_cache(struct btrfs_root *root, struct inode *inode,
 			goto free_cache;
 		}
 
+		/*
+		 * Sync discard ensures that the free space cache is always
+		 * trimmed.  So when reading this in, the state should reflect
+		 * that.
+		 */
+		if (btrfs_test_opt(fs_info, DISCARD_SYNC))
+			e->flags |= BTRFS_FSC_TRIMMED;
+
 		if (!e->bytes) {
 			kmem_cache_free(btrfs_free_space_cachep, e);
 			goto free_cache;
@@ -2165,6 +2173,7 @@ static bool try_merge_free_space(struct btrfs_free_space_ctl *ctl,
 	bool merged = false;
 	u64 offset = info->offset;
 	u64 bytes = info->bytes;
+	bool is_trimmed = btrfs_free_space_trimmed(info);
 
 	/*
 	 * first we want to see if there is free space adjacent to the range we
@@ -2178,7 +2187,8 @@ static bool try_merge_free_space(struct btrfs_free_space_ctl *ctl,
 	else
 		left_info = tree_search_offset(ctl, offset - 1, 0, 0);
 
-	if (right_info && !right_info->bitmap) {
+	if (right_info && !right_info->bitmap &&
+	    (!is_trimmed || btrfs_free_space_trimmed(right_info))) {
 		if (update_stat)
 			unlink_free_space(ctl, right_info);
 		else
@@ -2189,7 +2199,8 @@ static bool try_merge_free_space(struct btrfs_free_space_ctl *ctl,
 	}
 
 	if (left_info && !left_info->bitmap &&
-	    left_info->offset + left_info->bytes == offset) {
+	    left_info->offset + left_info->bytes == offset &&
+	    (!is_trimmed || btrfs_free_space_trimmed(left_info))) {
 		if (update_stat)
 			unlink_free_space(ctl, left_info);
 		else
@@ -2225,6 +2236,9 @@ static bool steal_from_bitmap_to_end(struct btrfs_free_space_ctl *ctl,
 	bytes = (j - i) * ctl->unit;
 	info->bytes += bytes;
 
+	if (!btrfs_free_space_trimmed(bitmap))
+		info->flags &= ~BTRFS_FSC_TRIMMED;
+
 	if (update_stat)
 		bitmap_clear_bits(ctl, bitmap, end, bytes);
 	else
@@ -2278,6 +2292,9 @@ static bool steal_from_bitmap_to_front(struct btrfs_free_space_ctl *ctl,
 	info->offset -= bytes;
 	info->bytes += bytes;
 
+	if (!btrfs_free_space_trimmed(bitmap))
+		info->flags &= ~BTRFS_FSC_TRIMMED;
+
 	if (update_stat)
 		bitmap_clear_bits(ctl, bitmap, info->offset, bytes);
 	else
@@ -2327,7 +2344,7 @@ static void steal_from_bitmap(struct btrfs_free_space_ctl *ctl,
 
 int __btrfs_add_free_space(struct btrfs_fs_info *fs_info,
 			   struct btrfs_free_space_ctl *ctl,
-			   u64 offset, u64 bytes)
+			   u64 offset, u64 bytes, u32 flags)
 {
 	struct btrfs_free_space *info;
 	int ret = 0;
@@ -2338,6 +2355,7 @@ int __btrfs_add_free_space(struct btrfs_fs_info *fs_info,
 
 	info->offset = offset;
 	info->bytes = bytes;
+	info->flags = flags;
 	RB_CLEAR_NODE(&info->offset_index);
 
 	spin_lock(&ctl->tree_lock);
@@ -2385,7 +2403,7 @@ int btrfs_add_free_space(struct btrfs_block_group_cache *block_group,
 {
 	return __btrfs_add_free_space(block_group->fs_info,
 				      block_group->free_space_ctl,
-				      bytenr, size);
+				      bytenr, size, 0);
 }
 
 int btrfs_remove_free_space(struct btrfs_block_group_cache *block_group,
@@ -2460,8 +2478,11 @@ int btrfs_remove_free_space(struct btrfs_block_group_cache *block_group,
 			}
 			spin_unlock(&ctl->tree_lock);
 
-			ret = btrfs_add_free_space(block_group, offset + bytes,
-						   old_end - (offset + bytes));
+			ret = __btrfs_add_free_space(block_group->fs_info,
+						     ctl,
+						     offset + bytes,
+						     old_end - (offset + bytes),
+						     info->flags);
 			WARN_ON(ret);
 			goto out;
 		}
@@ -2630,6 +2651,7 @@ u64 btrfs_find_space_for_alloc(struct btrfs_block_group_cache *block_group,
 	u64 ret = 0;
 	u64 align_gap = 0;
 	u64 align_gap_len = 0;
+	u64 align_gap_flags = 0;
 
 	spin_lock(&ctl->tree_lock);
 	entry = find_free_space(ctl, &offset, &bytes_search,
@@ -2646,6 +2668,7 @@ u64 btrfs_find_space_for_alloc(struct btrfs_block_group_cache *block_group,
 		unlink_free_space(ctl, entry);
 		align_gap_len = offset - entry->offset;
 		align_gap = entry->offset;
+		align_gap_flags = entry->flags;
 
 		entry->offset = offset + bytes;
 		WARN_ON(entry->bytes < bytes + align_gap_len);
@@ -2661,7 +2684,8 @@ u64 btrfs_find_space_for_alloc(struct btrfs_block_group_cache *block_group,
 
 	if (align_gap_len)
 		__btrfs_add_free_space(block_group->fs_info, ctl,
-				       align_gap, align_gap_len);
+				       align_gap, align_gap_len,
+				       align_gap_flags);
 	return ret;
 }
 
diff --git a/fs/btrfs/free-space-cache.h b/fs/btrfs/free-space-cache.h
index 39c32c8fc24f..ab3dfc00abb5 100644
--- a/fs/btrfs/free-space-cache.h
+++ b/fs/btrfs/free-space-cache.h
@@ -6,6 +6,8 @@
 #ifndef BTRFS_FREE_SPACE_CACHE_H
 #define BTRFS_FREE_SPACE_CACHE_H
 
+#define BTRFS_FSC_TRIMMED		(1UL << 0)
+
 struct btrfs_free_space {
 	struct rb_node offset_index;
 	u64 offset;
@@ -13,8 +15,14 @@ struct btrfs_free_space {
 	u64 max_extent_size;
 	unsigned long *bitmap;
 	struct list_head list;
+	u32 flags;
 };
 
+static inline bool btrfs_free_space_trimmed(struct btrfs_free_space *info)
+{
+	return (info->flags & BTRFS_FSC_TRIMMED);
+}
+
 struct btrfs_free_space_ctl {
 	spinlock_t tree_lock;
 	struct rb_root free_space_offset;
@@ -84,7 +92,7 @@ int btrfs_write_out_ino_cache(struct btrfs_root *root,
 void btrfs_init_free_space_ctl(struct btrfs_block_group_cache *block_group);
 int __btrfs_add_free_space(struct btrfs_fs_info *fs_info,
 			   struct btrfs_free_space_ctl *ctl,
-			   u64 bytenr, u64 size);
+			   u64 bytenr, u64 size, u32 flags);
 int btrfs_add_free_space(struct btrfs_block_group_cache *block_group,
 			 u64 bytenr, u64 size);
 int btrfs_remove_free_space(struct btrfs_block_group_cache *block_group,
diff --git a/fs/btrfs/inode-map.c b/fs/btrfs/inode-map.c
index 63cad7865d75..00e225de4fe6 100644
--- a/fs/btrfs/inode-map.c
+++ b/fs/btrfs/inode-map.c
@@ -107,7 +107,7 @@ static int caching_kthread(void *data)
 
 		if (last != (u64)-1 && last + 1 != key.objectid) {
 			__btrfs_add_free_space(fs_info, ctl, last + 1,
-					       key.objectid - last - 1);
+					       key.objectid - last - 1, 0);
 			wake_up(&root->ino_cache_wait);
 		}
 
@@ -118,7 +118,7 @@ static int caching_kthread(void *data)
 
 	if (last < root->highest_objectid - 1) {
 		__btrfs_add_free_space(fs_info, ctl, last + 1,
-				       root->highest_objectid - last - 1);
+				       root->highest_objectid - last - 1, 0);
 	}
 
 	spin_lock(&root->ino_cache_lock);
@@ -175,7 +175,8 @@ static void start_caching(struct btrfs_root *root)
 	ret = btrfs_find_free_objectid(root, &objectid);
 	if (!ret && objectid <= BTRFS_LAST_FREE_OBJECTID) {
 		__btrfs_add_free_space(fs_info, ctl, objectid,
-				       BTRFS_LAST_FREE_OBJECTID - objectid + 1);
+				       BTRFS_LAST_FREE_OBJECTID - objectid + 1,
+				       0);
 		wake_up(&root->ino_cache_wait);
 	}
 
@@ -221,7 +222,7 @@ void btrfs_return_ino(struct btrfs_root *root, u64 objectid)
 		return;
 again:
 	if (root->ino_cache_state == BTRFS_CACHE_FINISHED) {
-		__btrfs_add_free_space(fs_info, pinned, objectid, 1);
+		__btrfs_add_free_space(fs_info, pinned, objectid, 1, 0);
 	} else {
 		down_write(&fs_info->commit_root_sem);
 		spin_lock(&root->ino_cache_lock);
@@ -234,7 +235,7 @@ void btrfs_return_ino(struct btrfs_root *root, u64 objectid)
 
 		start_caching(root);
 
-		__btrfs_add_free_space(fs_info, pinned, objectid, 1);
+		__btrfs_add_free_space(fs_info, pinned, objectid, 1, 0);
 
 		up_write(&fs_info->commit_root_sem);
 	}
@@ -281,7 +282,7 @@ void btrfs_unpin_free_ino(struct btrfs_root *root)
 		spin_unlock(rbroot_lock);
 		if (count)
 			__btrfs_add_free_space(root->fs_info, ctl,
-					       info->offset, count);
+					       info->offset, count, 0);
 		kmem_cache_free(btrfs_free_space_cachep, info);
 	}
 }
-- 
2.17.1

