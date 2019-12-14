Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 88AB411EF1E
	for <lists+linux-btrfs@lfdr.de>; Sat, 14 Dec 2019 01:22:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726813AbfLNAWo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 13 Dec 2019 19:22:44 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:34195 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726793AbfLNAWo (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 13 Dec 2019 19:22:44 -0500
Received: by mail-pg1-f195.google.com with SMTP id r11so289847pgf.1
        for <linux-btrfs@vger.kernel.org>; Fri, 13 Dec 2019 16:22:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=pTfkZpUsk8TW5/uUec3dgTOzQeeMGyB7XDkZ7Ipi1dQ=;
        b=pEZ0zUwyry91C+QMGvNgpVge87sjcqy8hv6NdexYKrrUSAzkMloeVAQgJHfwgqgypQ
         GUIahNQeGqDWcDq2IfWOhRLIQZy/9N/J1vAcvqNLQOn9pI35iZ6cTHpJ5zYpNSEGmfWg
         jzN3FPbG4Njv8lm9d5ed/EciLlYZAZ6uNbF2v+ODnaxP4XJ/MVOakr6dJnc2murWnCj/
         ls/Ih76mVD7IzZJlRKwpQpPqUaIWKyCobp/rqAtEv7SrVtafqY0pJSeMwIdGbnICEImR
         D07ZFvT4QEsTyGi9EVEGASGVJaeIFoK6wm7JQc5QSEeD+8ziKyI7b75PnW+ZzOSzHDEH
         OOng==
X-Gm-Message-State: APjAAAXvqzTzFyFm9hfkw6/rBXdi5lL85Ku5H4PofXoIm+x02lunnwCY
        bYTd/sI8ys+bWzj0l2Lr3dw=
X-Google-Smtp-Source: APXvYqwIdH8iTqRuJM7Bg5l2GxQP25NitpjVWwaSF2UoDUO48rcbCU2J5DuwyGheYdqoF03+A95yrw==
X-Received: by 2002:a63:a54d:: with SMTP id r13mr2615195pgu.138.1576282963115;
        Fri, 13 Dec 2019 16:22:43 -0800 (PST)
Received: from dennisz-mbp.thefacebook.com ([199.201.64.138])
        by smtp.gmail.com with ESMTPSA id m12sm11911430pgr.87.2019.12.13.16.22.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 13 Dec 2019 16:22:42 -0800 (PST)
From:   Dennis Zhou <dennis@kernel.org>
To:     David Sterba <dsterba@suse.com>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Omar Sandoval <osandov@osandov.com>
Cc:     kernel-team@fb.com, linux-btrfs@vger.kernel.org,
        Dennis Zhou <dennis@kernel.org>
Subject: [PATCH 03/22] btrfs: keep track of which extents have been discarded
Date:   Fri, 13 Dec 2019 16:22:12 -0800
Message-Id: <5e4b98059da649f39e2866f707129561cd5de049.1576195673.git.dennis@kernel.org>
X-Mailer: git-send-email 2.13.5
In-Reply-To: <cover.1576195673.git.dennis@kernel.org>
References: <cover.1576195673.git.dennis@kernel.org>
In-Reply-To: <cover.1576195673.git.dennis@kernel.org>
References: <cover.1576195673.git.dennis@kernel.org>
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
 fs/btrfs/free-space-cache.c | 64 +++++++++++++++++++++++++++++++++----
 fs/btrfs/free-space-cache.h | 17 +++++++++-
 fs/btrfs/inode-map.c        | 13 ++++----
 3 files changed, 80 insertions(+), 14 deletions(-)

diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
index 3283da419200..5f8e2171efbf 100644
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
@@ -2387,9 +2426,14 @@ int __btrfs_add_free_space(struct btrfs_fs_info *fs_info,
 int btrfs_add_free_space(struct btrfs_block_group *block_group,
 			 u64 bytenr, u64 size)
 {
+	enum btrfs_trim_state trim_state = BTRFS_TRIM_STATE_UNTRIMMED;
+
+	if (btrfs_test_opt(block_group->fs_info, DISCARD_SYNC))
+		trim_state = BTRFS_TRIM_STATE_TRIMMED;
+
 	return __btrfs_add_free_space(block_group->fs_info,
 				      block_group->free_space_ctl,
-				      bytenr, size);
+				      bytenr, size, trim_state);
 }
 
 int btrfs_remove_free_space(struct btrfs_block_group *block_group,
@@ -2464,8 +2508,11 @@ int btrfs_remove_free_space(struct btrfs_block_group *block_group,
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
@@ -2634,6 +2681,7 @@ u64 btrfs_find_space_for_alloc(struct btrfs_block_group *block_group,
 	u64 ret = 0;
 	u64 align_gap = 0;
 	u64 align_gap_len = 0;
+	enum btrfs_trim_state align_gap_trim_state = BTRFS_TRIM_STATE_UNTRIMMED;
 
 	spin_lock(&ctl->tree_lock);
 	entry = find_free_space(ctl, &offset, &bytes_search,
@@ -2650,6 +2698,7 @@ u64 btrfs_find_space_for_alloc(struct btrfs_block_group *block_group,
 		unlink_free_space(ctl, entry);
 		align_gap_len = offset - entry->offset;
 		align_gap = entry->offset;
+		align_gap_trim_state = entry->trim_state;
 
 		entry->offset = offset + bytes;
 		WARN_ON(entry->bytes < bytes + align_gap_len);
@@ -2665,7 +2714,8 @@ u64 btrfs_find_space_for_alloc(struct btrfs_block_group *block_group,
 
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

