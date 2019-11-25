Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DD42E109461
	for <lists+linux-btrfs@lfdr.de>; Mon, 25 Nov 2019 20:47:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727088AbfKYTrM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 25 Nov 2019 14:47:12 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:35914 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726957AbfKYTrM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 25 Nov 2019 14:47:12 -0500
Received: by mail-qk1-f195.google.com with SMTP id d13so13947020qko.3
        for <linux-btrfs@vger.kernel.org>; Mon, 25 Nov 2019 11:47:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=lB1QXmAW7riylv4Mc7k01AjgFWEzsrRqRj9bR4kpKwg=;
        b=lKP/J54KCLcw5grFXLmdL/IVNUsDrHJ8OjPkrAEjIgYyrU/vQuC80g17T3vW3LQff3
         ghb5SL9+Fe8WgMXNsTwCXIwp81Xzqs8mf8AqvDP7furcYB26LOilolx/DRNaN6o3ammR
         cZsDEhnp+7U9K/rliDyLGUXCQFHfo9TGDhjaPDNG7br63WEcXJJS/vK4ybkDh0fbOo3e
         sSL7Zfy10jfc2pzM+yPKpZVXfuc9h1FlAc7K07e8am/LRoLXhjiRIRMSgaQuBI3KQWbI
         FXoJmHayAN/5r8yUeCayV9tx3yjTcO+q2nePnfuAwBzyCrl9vyFMe4fF9w+Ro6AByRBU
         JyRA==
X-Gm-Message-State: APjAAAVFhAxkEMSfnFQd6qbfGyeOb1Sb39xXz7mKWY/T/0jiw9Q1JeGD
        4YNbeZQ1fp3lorXRDcUfzEc=
X-Google-Smtp-Source: APXvYqwRrKqDYw6Eff1h2YEU862apvLddS42i31b0u3CAJVuyS31kISRFeoY9seEC8X3prcHkQDbyg==
X-Received: by 2002:a05:620a:16ba:: with SMTP id s26mr28086674qkj.107.1574711230506;
        Mon, 25 Nov 2019 11:47:10 -0800 (PST)
Received: from dennisz-mbp.thefacebook.com ([163.114.130.128])
        by smtp.gmail.com with ESMTPSA id o13sm4481033qto.96.2019.11.25.11.47.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 25 Nov 2019 11:47:09 -0800 (PST)
From:   Dennis Zhou <dennis@kernel.org>
To:     David Sterba <dsterba@suse.com>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Omar Sandoval <osandov@osandov.com>
Cc:     kernel-team@fb.com, linux-btrfs@vger.kernel.org,
        Dennis Zhou <dennis@kernel.org>
Subject: [PATCH 03/22] btrfs: keep track of which extents have been discarded
Date:   Mon, 25 Nov 2019 14:46:43 -0500
Message-Id: <31532cb444464300c846198448e24c6739f805e7.1574709825.git.dennis@kernel.org>
X-Mailer: git-send-email 2.13.5
In-Reply-To: <cover.1574709825.git.dennis@kernel.org>
References: <cover.1574709825.git.dennis@kernel.org>
In-Reply-To: <cover.1574709825.git.dennis@kernel.org>
References: <cover.1574709825.git.dennis@kernel.org>
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
 fs/btrfs/extent-tree.c      | 15 +++++++---
 fs/btrfs/free-space-cache.c | 59 ++++++++++++++++++++++++++++++++-----
 fs/btrfs/free-space-cache.h | 17 ++++++++++-
 fs/btrfs/inode-map.c        | 13 ++++----
 4 files changed, 86 insertions(+), 18 deletions(-)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index f979f4c1a385..5dc696d0c5b2 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -2803,6 +2803,7 @@ fetch_cluster_info(struct btrfs_fs_info *fs_info,
 
 static int unpin_extent_range(struct btrfs_fs_info *fs_info,
 			      u64 start, u64 end,
+			      enum btrfs_trim_state trim_state,
 			      const bool return_free_space)
 {
 	struct btrfs_block_group *cache = NULL;
@@ -2836,7 +2837,9 @@ static int unpin_extent_range(struct btrfs_fs_info *fs_info,
 		if (start < cache->last_byte_to_unpin) {
 			len = min(len, cache->last_byte_to_unpin - start);
 			if (return_free_space)
-				btrfs_add_free_space(cache, start, len);
+				__btrfs_add_free_space(fs_info,
+						       cache->free_space_ctl,
+						       start, len, trim_state);
 		}
 
 		start += len;
@@ -2914,6 +2917,7 @@ int btrfs_finish_extent_commit(struct btrfs_trans_handle *trans)
 
 	while (!trans->aborted) {
 		struct extent_state *cached_state = NULL;
+		enum btrfs_trim_state trim_state = BTRFS_TRIM_STATE_UNTRIMMED;
 
 		mutex_lock(&fs_info->unused_bg_unpin_mutex);
 		ret = find_first_extent_bit(unpin, 0, &start, &end,
@@ -2923,12 +2927,14 @@ int btrfs_finish_extent_commit(struct btrfs_trans_handle *trans)
 			break;
 		}
 
-		if (btrfs_test_opt(fs_info, DISCARD_SYNC))
+		if (btrfs_test_opt(fs_info, DISCARD_SYNC)) {
 			ret = btrfs_discard_extent(fs_info, start,
 						   end + 1 - start, NULL);
+			trim_state = BTRFS_TRIM_STATE_TRIMMED;
+		}
 
 		clear_extent_dirty(unpin, start, end, &cached_state);
-		unpin_extent_range(fs_info, start, end, true);
+		unpin_extent_range(fs_info, start, end, trim_state, true);
 		mutex_unlock(&fs_info->unused_bg_unpin_mutex);
 		free_extent_state(cached_state);
 		cond_resched();
@@ -5546,7 +5552,8 @@ u64 btrfs_account_ro_block_groups_free_space(struct btrfs_space_info *sinfo)
 int btrfs_error_unpin_extent_range(struct btrfs_fs_info *fs_info,
 				   u64 start, u64 end)
 {
-	return unpin_extent_range(fs_info, start, end, false);
+	return unpin_extent_range(fs_info, start, end,
+				  BTRFS_TRIM_STATE_UNTRIMMED, false);
 }
 
 /*
diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
index 3283da419200..399c641440bc 100644
--- a/fs/btrfs/free-space-cache.c
+++ b/fs/btrfs/free-space-cache.c
@@ -752,6 +752,14 @@ static int __load_free_space_cache(struct btrfs_root *root, struct inode *inode,
 			goto free_cache;
 		}
 
+		/*
+		 * Sync discard ensures that the free space cache is always
+		 * trimmed.  So when reading this in, the state should reflect
+		 * that.
+		 */
+		if (btrfs_test_opt(fs_info, DISCARD_SYNC))
+			e->trim_state = BTRFS_TRIM_STATE_TRIMMED;
+
 		if (!e->bytes) {
 			kmem_cache_free(btrfs_free_space_cachep, e);
 			goto free_cache;
@@ -2161,6 +2169,22 @@ static int insert_into_bitmap(struct btrfs_free_space_ctl *ctl,
 	return ret;
 }
 
+/*
+ * Free space merging rules:
+ *  1) Merge trimmed areas together
+ *  2) Let untrimmed areas coalesce with trimmed areas
+ *  3) Always pull neighboring regions from bitmaps
+ *
+ * The above rules are for when we merge free space based on btrfs_trim_state.
+ * Rules 2 and 3 are subtle because they are suboptimal, but are done for the
+ * same reason: to promote larger extent regions which makes life easier for
+ * find_free_extent().  Rule 2 enables coalescing based on the common path
+ * being returning free space from btrfs_finish_extent_commit().  So when free
+ * space is trimmed, it will prevent aggregating trimmed new region and
+ * untrimmed regions in the rb_tree.  Rule 3 is purely to obtain larger extents
+ * and provide find_free_extent() with the largest extents possible hoping for
+ * the reuse path.
+ */
 static bool try_merge_free_space(struct btrfs_free_space_ctl *ctl,
 			  struct btrfs_free_space *info, bool update_stat)
 {
@@ -2169,6 +2193,7 @@ static bool try_merge_free_space(struct btrfs_free_space_ctl *ctl,
 	bool merged = false;
 	u64 offset = info->offset;
 	u64 bytes = info->bytes;
+	const bool is_trimmed = btrfs_free_space_trimmed(info);
 
 	/*
 	 * first we want to see if there is free space adjacent to the range we
@@ -2182,7 +2207,9 @@ static bool try_merge_free_space(struct btrfs_free_space_ctl *ctl,
 	else
 		left_info = tree_search_offset(ctl, offset - 1, 0, 0);
 
-	if (right_info && !right_info->bitmap) {
+	/* See try_merge_free_space() comment. */
+	if (right_info && !right_info->bitmap &&
+	    (!is_trimmed || btrfs_free_space_trimmed(right_info))) {
 		if (update_stat)
 			unlink_free_space(ctl, right_info);
 		else
@@ -2192,8 +2219,10 @@ static bool try_merge_free_space(struct btrfs_free_space_ctl *ctl,
 		merged = true;
 	}
 
+	/* See try_merge_free_space() comment. */
 	if (left_info && !left_info->bitmap &&
-	    left_info->offset + left_info->bytes == offset) {
+	    left_info->offset + left_info->bytes == offset &&
+	    (!is_trimmed || btrfs_free_space_trimmed(left_info))) {
 		if (update_stat)
 			unlink_free_space(ctl, left_info);
 		else
@@ -2229,6 +2258,10 @@ static bool steal_from_bitmap_to_end(struct btrfs_free_space_ctl *ctl,
 	bytes = (j - i) * ctl->unit;
 	info->bytes += bytes;
 
+	/* See try_merge_free_space() comment. */
+	if (!btrfs_free_space_trimmed(bitmap))
+		info->trim_state = BTRFS_TRIM_STATE_UNTRIMMED;
+
 	if (update_stat)
 		bitmap_clear_bits(ctl, bitmap, end, bytes);
 	else
@@ -2282,6 +2315,10 @@ static bool steal_from_bitmap_to_front(struct btrfs_free_space_ctl *ctl,
 	info->offset -= bytes;
 	info->bytes += bytes;
 
+	/* See try_merge_free_space() comment. */
+	if (!btrfs_free_space_trimmed(bitmap))
+		info->trim_state = BTRFS_TRIM_STATE_UNTRIMMED;
+
 	if (update_stat)
 		bitmap_clear_bits(ctl, bitmap, info->offset, bytes);
 	else
@@ -2331,7 +2368,8 @@ static void steal_from_bitmap(struct btrfs_free_space_ctl *ctl,
 
 int __btrfs_add_free_space(struct btrfs_fs_info *fs_info,
 			   struct btrfs_free_space_ctl *ctl,
-			   u64 offset, u64 bytes)
+			   u64 offset, u64 bytes,
+			   enum btrfs_trim_state trim_state)
 {
 	struct btrfs_free_space *info;
 	int ret = 0;
@@ -2342,6 +2380,7 @@ int __btrfs_add_free_space(struct btrfs_fs_info *fs_info,
 
 	info->offset = offset;
 	info->bytes = bytes;
+	info->trim_state = trim_state;
 	RB_CLEAR_NODE(&info->offset_index);
 
 	spin_lock(&ctl->tree_lock);
@@ -2389,7 +2428,7 @@ int btrfs_add_free_space(struct btrfs_block_group *block_group,
 {
 	return __btrfs_add_free_space(block_group->fs_info,
 				      block_group->free_space_ctl,
-				      bytenr, size);
+				      bytenr, size, 0);
 }
 
 int btrfs_remove_free_space(struct btrfs_block_group *block_group,
@@ -2464,8 +2503,11 @@ int btrfs_remove_free_space(struct btrfs_block_group *block_group,
 			}
 			spin_unlock(&ctl->tree_lock);
 
-			ret = btrfs_add_free_space(block_group, offset + bytes,
-						   old_end - (offset + bytes));
+			ret = __btrfs_add_free_space(block_group->fs_info,
+						     ctl,
+						     offset + bytes,
+						     old_end - (offset + bytes),
+						     info->trim_state);
 			WARN_ON(ret);
 			goto out;
 		}
@@ -2634,6 +2676,7 @@ u64 btrfs_find_space_for_alloc(struct btrfs_block_group *block_group,
 	u64 ret = 0;
 	u64 align_gap = 0;
 	u64 align_gap_len = 0;
+	enum btrfs_trim_state align_gap_trim_state = BTRFS_TRIM_STATE_UNTRIMMED;
 
 	spin_lock(&ctl->tree_lock);
 	entry = find_free_space(ctl, &offset, &bytes_search,
@@ -2650,6 +2693,7 @@ u64 btrfs_find_space_for_alloc(struct btrfs_block_group *block_group,
 		unlink_free_space(ctl, entry);
 		align_gap_len = offset - entry->offset;
 		align_gap = entry->offset;
+		align_gap_trim_state = entry->trim_state;
 
 		entry->offset = offset + bytes;
 		WARN_ON(entry->bytes < bytes + align_gap_len);
@@ -2665,7 +2709,8 @@ u64 btrfs_find_space_for_alloc(struct btrfs_block_group *block_group,
 
 	if (align_gap_len)
 		__btrfs_add_free_space(block_group->fs_info, ctl,
-				       align_gap, align_gap_len);
+				       align_gap, align_gap_len,
+				       align_gap_trim_state);
 	return ret;
 }
 
diff --git a/fs/btrfs/free-space-cache.h b/fs/btrfs/free-space-cache.h
index ba9a23241101..66c073f854dc 100644
--- a/fs/btrfs/free-space-cache.h
+++ b/fs/btrfs/free-space-cache.h
@@ -6,6 +6,14 @@
 #ifndef BTRFS_FREE_SPACE_CACHE_H
 #define BTRFS_FREE_SPACE_CACHE_H
 
+/*
+ * This is the trim state of an extent or bitmap.
+ */
+enum btrfs_trim_state {
+	BTRFS_TRIM_STATE_UNTRIMMED,
+	BTRFS_TRIM_STATE_TRIMMED,
+};
+
 struct btrfs_free_space {
 	struct rb_node offset_index;
 	u64 offset;
@@ -13,8 +21,14 @@ struct btrfs_free_space {
 	u64 max_extent_size;
 	unsigned long *bitmap;
 	struct list_head list;
+	enum btrfs_trim_state trim_state;
 };
 
+static inline bool btrfs_free_space_trimmed(struct btrfs_free_space *info)
+{
+	return (info->trim_state == BTRFS_TRIM_STATE_TRIMMED);
+}
+
 struct btrfs_free_space_ctl {
 	spinlock_t tree_lock;
 	struct rb_root free_space_offset;
@@ -83,7 +97,8 @@ int btrfs_write_out_ino_cache(struct btrfs_root *root,
 void btrfs_init_free_space_ctl(struct btrfs_block_group *block_group);
 int __btrfs_add_free_space(struct btrfs_fs_info *fs_info,
 			   struct btrfs_free_space_ctl *ctl,
-			   u64 bytenr, u64 size);
+			   u64 bytenr, u64 size,
+			   enum btrfs_trim_state trim_state);
 int btrfs_add_free_space(struct btrfs_block_group *block_group,
 			 u64 bytenr, u64 size);
 int btrfs_remove_free_space(struct btrfs_block_group *block_group,
diff --git a/fs/btrfs/inode-map.c b/fs/btrfs/inode-map.c
index 37345fb6191d..d5c9c69d8263 100644
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

