Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 717444DA60
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Jun 2019 21:38:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726810AbfFTTio (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 20 Jun 2019 15:38:44 -0400
Received: from mail-yb1-f194.google.com ([209.85.219.194]:37542 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726789AbfFTTin (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 20 Jun 2019 15:38:43 -0400
Received: by mail-yb1-f194.google.com with SMTP id 189so1678233ybh.4
        for <linux-btrfs@vger.kernel.org>; Thu, 20 Jun 2019 12:38:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=Wq/vnMLH6/zfBJZu/59WwUW8CCUKDEpOzWYphem3EAk=;
        b=TwKrakwqrNsIhz2doBcrjDsghu0RFOr4m4HIS2enMZG4VnMvT2eOQR/idVXSEnUA3c
         8hDJmj+mZjWHb/UwZaoiTBDXf4debzOcJqhmHZxbnFVyFCFzvOQZOct5XUwWW4cm94OV
         6d5rCXt3y67fCJPucKgGf8t2sYS3tsWG8KKGXXHblEsO5jbMOFzZQCTSpUk/EvA4bf3F
         MwxrfB+JD3TWYg3Pn0v5Gm3HlZOl8qR+OXtTK7FoskMbubFw9GxvOuKQiMigpLaS+B9A
         EGXUlqiC1mj4GNjQoKh7/JQCe2tnCcT7DwgDdMZroQ5hoo+r0xWHo0pBtAmywsN3SX6O
         eyuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=Wq/vnMLH6/zfBJZu/59WwUW8CCUKDEpOzWYphem3EAk=;
        b=OuatZnhO5Tl6DPcSkfkqdFPB884/bqO0TTTiQBP/AH1xBEMe7MS6iFYRwUm5db2qR3
         c0QLSKJrvZc1iXA93Glsu9z4BwKkTkSEUvfTjpd0nazeYSZ8Q+rEwWCJYuCRFRZvn4yO
         4MtMEBGidqfN6j+UNeu+dvtVrzqkH7GqMIbzutbKAXIUKTK9doZhQXGf1Fe/xBaMS+fe
         aBrQj++cZBeBAhYKuA5wLTN2mtGF6dN1wrLmCTtOLmQPbEZ76cIsPWqvFPtAqte5EFO9
         WbjchUYQTJWbPUOWaoqvBOZ3Jq4ajCuiJTrUMyntFwQpsYAtj/a+S57KTTyNdnfcDzrN
         hIxw==
X-Gm-Message-State: APjAAAWz7j6eeVlk6/SOOPu/fF8CPf+6RBLERPLZUFH5GaYRv5llOVn1
        isJIT5EBn9R72k3e6jJgIWR8mCzwC0jAnw==
X-Google-Smtp-Source: APXvYqzZXPTInsNHwT1D+AmMEPzE1hsaulNxMk1FHKq2xwljfvYFLIHDtqOOPP6zhxtCIpdBB42s0w==
X-Received: by 2002:a5b:481:: with SMTP id n1mr66764749ybp.103.1561059522180;
        Thu, 20 Jun 2019 12:38:42 -0700 (PDT)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id b196sm109308ywh.51.2019.06.20.12.38.41
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 20 Jun 2019 12:38:41 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 20/25] btrfs: migrate the block group space accounting helpers
Date:   Thu, 20 Jun 2019 15:38:02 -0400
Message-Id: <20190620193807.29311-21-josef@toxicpanda.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20190620193807.29311-1-josef@toxicpanda.com>
References: <20190620193807.29311-1-josef@toxicpanda.com>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We can now easily migrate this code as well.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/block-group.c | 174 +++++++++++++++++++++++++++++++++++++++++++++++++
 fs/btrfs/extent-tree.c | 174 -------------------------------------------------
 2 files changed, 174 insertions(+), 174 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 540dc7219f48..6a189ad3e7e1 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -2505,3 +2505,177 @@ int btrfs_write_dirty_block_groups(struct btrfs_trans_handle *trans)
 	return ret;
 }
 
+int btrfs_update_block_group(struct btrfs_trans_handle *trans,
+			     u64 bytenr, u64 num_bytes, int alloc)
+{
+	struct btrfs_fs_info *info = trans->fs_info;
+	struct btrfs_block_group_cache *cache = NULL;
+	u64 total = num_bytes;
+	u64 old_val;
+	u64 byte_in_group;
+	int factor;
+	int ret = 0;
+
+	/* block accounting for super block */
+	spin_lock(&info->delalloc_root_lock);
+	old_val = btrfs_super_bytes_used(info->super_copy);
+	if (alloc)
+		old_val += num_bytes;
+	else
+		old_val -= num_bytes;
+	btrfs_set_super_bytes_used(info->super_copy, old_val);
+	spin_unlock(&info->delalloc_root_lock);
+
+	while (total) {
+		cache = btrfs_lookup_block_group(info, bytenr);
+		if (!cache) {
+			ret = -ENOENT;
+			break;
+		}
+		factor = btrfs_bg_type_to_factor(cache->flags);
+
+		/*
+		 * If this block group has free space cache written out, we
+		 * need to make sure to load it if we are removing space.  This
+		 * is because we need the unpinning stage to actually add the
+		 * space back to the block group, otherwise we will leak space.
+		 */
+		if (!alloc && cache->cached == BTRFS_CACHE_NO)
+			btrfs_cache_block_group(cache, 1);
+
+		byte_in_group = bytenr - cache->key.objectid;
+		WARN_ON(byte_in_group > cache->key.offset);
+
+		spin_lock(&cache->space_info->lock);
+		spin_lock(&cache->lock);
+
+		if (btrfs_test_opt(info, SPACE_CACHE) &&
+		    cache->disk_cache_state < BTRFS_DC_CLEAR)
+			cache->disk_cache_state = BTRFS_DC_CLEAR;
+
+		old_val = btrfs_block_group_used(&cache->item);
+		num_bytes = min(total, cache->key.offset - byte_in_group);
+		if (alloc) {
+			old_val += num_bytes;
+			btrfs_set_block_group_used(&cache->item, old_val);
+			cache->reserved -= num_bytes;
+			cache->space_info->bytes_reserved -= num_bytes;
+			cache->space_info->bytes_used += num_bytes;
+			cache->space_info->disk_used += num_bytes * factor;
+			spin_unlock(&cache->lock);
+			spin_unlock(&cache->space_info->lock);
+		} else {
+			old_val -= num_bytes;
+			btrfs_set_block_group_used(&cache->item, old_val);
+			cache->pinned += num_bytes;
+			btrfs_space_info_update_bytes_pinned(info,
+							     cache->space_info,
+							     num_bytes);
+			cache->space_info->bytes_used -= num_bytes;
+			cache->space_info->disk_used -= num_bytes * factor;
+			spin_unlock(&cache->lock);
+			spin_unlock(&cache->space_info->lock);
+
+			trace_btrfs_space_reservation(info, "pinned",
+						      cache->space_info->flags,
+						      num_bytes, 1);
+			percpu_counter_add_batch(&cache->space_info->total_bytes_pinned,
+					   num_bytes,
+					   BTRFS_TOTAL_BYTES_PINNED_BATCH);
+			set_extent_dirty(info->pinned_extents,
+					 bytenr, bytenr + num_bytes - 1,
+					 GFP_NOFS | __GFP_NOFAIL);
+		}
+
+		spin_lock(&trans->transaction->dirty_bgs_lock);
+		if (list_empty(&cache->dirty_list)) {
+			list_add_tail(&cache->dirty_list,
+				      &trans->transaction->dirty_bgs);
+			trans->delayed_ref_updates++;
+			btrfs_get_block_group(cache);
+		}
+		spin_unlock(&trans->transaction->dirty_bgs_lock);
+
+		/*
+		 * No longer have used bytes in this block group, queue it for
+		 * deletion. We do this after adding the block group to the
+		 * dirty list to avoid races between cleaner kthread and space
+		 * cache writeout.
+		 */
+		if (!alloc && old_val == 0)
+			btrfs_mark_bg_unused(cache);
+
+		btrfs_put_block_group(cache);
+		total -= num_bytes;
+		bytenr += num_bytes;
+	}
+
+	/* Modified block groups are accounted for in the delayed_refs_rsv. */
+	btrfs_update_delayed_refs_rsv(trans);
+	return ret;
+}
+
+/**
+ * btrfs_add_reserved_bytes - update the block_group and space info counters
+ * @cache:	The cache we are manipulating
+ * @ram_bytes:  The number of bytes of file content, and will be same to
+ *              @num_bytes except for the compress path.
+ * @num_bytes:	The number of bytes in question
+ * @delalloc:   The blocks are allocated for the delalloc write
+ *
+ * This is called by the allocator when it reserves space. If this is a
+ * reservation and the block group has become read only we cannot make the
+ * reservation and return -EAGAIN, otherwise this function always succeeds.
+ */
+int btrfs_add_reserved_bytes(struct btrfs_block_group_cache *cache,
+			     u64 ram_bytes, u64 num_bytes, int delalloc)
+{
+	struct btrfs_space_info *space_info = cache->space_info;
+	int ret = 0;
+
+	spin_lock(&space_info->lock);
+	spin_lock(&cache->lock);
+	if (cache->ro) {
+		ret = -EAGAIN;
+	} else {
+		cache->reserved += num_bytes;
+		space_info->bytes_reserved += num_bytes;
+		btrfs_space_info_update_bytes_may_use(cache->fs_info,
+						      space_info, -ram_bytes);
+		if (delalloc)
+			cache->delalloc_bytes += num_bytes;
+	}
+	spin_unlock(&cache->lock);
+	spin_unlock(&space_info->lock);
+	return ret;
+}
+
+/**
+ * btrfs_free_reserved_bytes - update the block_group and space info counters
+ * @cache:      The cache we are manipulating
+ * @num_bytes:  The number of bytes in question
+ * @delalloc:   The blocks are allocated for the delalloc write
+ *
+ * This is called by somebody who is freeing space that was never actually used
+ * on disk.  For example if you reserve some space for a new leaf in transaction
+ * A and before transaction A commits you free that leaf, you call this with
+ * reserve set to 0 in order to clear the reservation.
+ */
+void btrfs_free_reserved_bytes(struct btrfs_block_group_cache *cache,
+			       u64 num_bytes, int delalloc)
+{
+	struct btrfs_space_info *space_info = cache->space_info;
+
+	spin_lock(&space_info->lock);
+	spin_lock(&cache->lock);
+	if (cache->ro)
+		space_info->bytes_readonly += num_bytes;
+	cache->reserved -= num_bytes;
+	space_info->bytes_reserved -= num_bytes;
+	space_info->max_extent_size = 0;
+
+	if (delalloc)
+		cache->delalloc_bytes -= num_bytes;
+	spin_unlock(&cache->lock);
+	spin_unlock(&space_info->lock);
+}
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index e44a6c3d7a9a..971d0e336fc2 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -2895,116 +2895,6 @@ int btrfs_chunk_alloc(struct btrfs_trans_handle *trans, u64 flags,
 	return ret;
 }
 
-int btrfs_update_block_group(struct btrfs_trans_handle *trans,
-			     u64 bytenr, u64 num_bytes, int alloc)
-{
-	struct btrfs_fs_info *info = trans->fs_info;
-	struct btrfs_block_group_cache *cache = NULL;
-	u64 total = num_bytes;
-	u64 old_val;
-	u64 byte_in_group;
-	int factor;
-	int ret = 0;
-
-	/* block accounting for super block */
-	spin_lock(&info->delalloc_root_lock);
-	old_val = btrfs_super_bytes_used(info->super_copy);
-	if (alloc)
-		old_val += num_bytes;
-	else
-		old_val -= num_bytes;
-	btrfs_set_super_bytes_used(info->super_copy, old_val);
-	spin_unlock(&info->delalloc_root_lock);
-
-	while (total) {
-		cache = btrfs_lookup_block_group(info, bytenr);
-		if (!cache) {
-			ret = -ENOENT;
-			break;
-		}
-		factor = btrfs_bg_type_to_factor(cache->flags);
-
-		/*
-		 * If this block group has free space cache written out, we
-		 * need to make sure to load it if we are removing space.  This
-		 * is because we need the unpinning stage to actually add the
-		 * space back to the block group, otherwise we will leak space.
-		 */
-		if (!alloc && cache->cached == BTRFS_CACHE_NO)
-			btrfs_cache_block_group(cache, 1);
-
-		byte_in_group = bytenr - cache->key.objectid;
-		WARN_ON(byte_in_group > cache->key.offset);
-
-		spin_lock(&cache->space_info->lock);
-		spin_lock(&cache->lock);
-
-		if (btrfs_test_opt(info, SPACE_CACHE) &&
-		    cache->disk_cache_state < BTRFS_DC_CLEAR)
-			cache->disk_cache_state = BTRFS_DC_CLEAR;
-
-		old_val = btrfs_block_group_used(&cache->item);
-		num_bytes = min(total, cache->key.offset - byte_in_group);
-		if (alloc) {
-			old_val += num_bytes;
-			btrfs_set_block_group_used(&cache->item, old_val);
-			cache->reserved -= num_bytes;
-			cache->space_info->bytes_reserved -= num_bytes;
-			cache->space_info->bytes_used += num_bytes;
-			cache->space_info->disk_used += num_bytes * factor;
-			spin_unlock(&cache->lock);
-			spin_unlock(&cache->space_info->lock);
-		} else {
-			old_val -= num_bytes;
-			btrfs_set_block_group_used(&cache->item, old_val);
-			cache->pinned += num_bytes;
-			btrfs_space_info_update_bytes_pinned(info,
-							     cache->space_info,
-							     num_bytes);
-			cache->space_info->bytes_used -= num_bytes;
-			cache->space_info->disk_used -= num_bytes * factor;
-			spin_unlock(&cache->lock);
-			spin_unlock(&cache->space_info->lock);
-
-			trace_btrfs_space_reservation(info, "pinned",
-						      cache->space_info->flags,
-						      num_bytes, 1);
-			percpu_counter_add_batch(&cache->space_info->total_bytes_pinned,
-					   num_bytes,
-					   BTRFS_TOTAL_BYTES_PINNED_BATCH);
-			set_extent_dirty(info->pinned_extents,
-					 bytenr, bytenr + num_bytes - 1,
-					 GFP_NOFS | __GFP_NOFAIL);
-		}
-
-		spin_lock(&trans->transaction->dirty_bgs_lock);
-		if (list_empty(&cache->dirty_list)) {
-			list_add_tail(&cache->dirty_list,
-				      &trans->transaction->dirty_bgs);
-			trans->delayed_ref_updates++;
-			btrfs_get_block_group(cache);
-		}
-		spin_unlock(&trans->transaction->dirty_bgs_lock);
-
-		/*
-		 * No longer have used bytes in this block group, queue it for
-		 * deletion. We do this after adding the block group to the
-		 * dirty list to avoid races between cleaner kthread and space
-		 * cache writeout.
-		 */
-		if (!alloc && old_val == 0)
-			btrfs_mark_bg_unused(cache);
-
-		btrfs_put_block_group(cache);
-		total -= num_bytes;
-		bytenr += num_bytes;
-	}
-
-	/* Modified block groups are accounted for in the delayed_refs_rsv. */
-	btrfs_update_delayed_refs_rsv(trans);
-	return ret;
-}
-
 static u64 first_logical_byte(struct btrfs_fs_info *fs_info, u64 search_start)
 {
 	struct btrfs_block_group_cache *cache;
@@ -3185,70 +3075,6 @@ btrfs_inc_block_group_reservations(struct btrfs_block_group_cache *bg)
 	atomic_inc(&bg->reservations);
 }
 
-/**
- * btrfs_add_reserved_bytes - update the block_group and space info counters
- * @cache:	The cache we are manipulating
- * @ram_bytes:  The number of bytes of file content, and will be same to
- *              @num_bytes except for the compress path.
- * @num_bytes:	The number of bytes in question
- * @delalloc:   The blocks are allocated for the delalloc write
- *
- * This is called by the allocator when it reserves space. If this is a
- * reservation and the block group has become read only we cannot make the
- * reservation and return -EAGAIN, otherwise this function always succeeds.
- */
-int btrfs_add_reserved_bytes(struct btrfs_block_group_cache *cache,
-			     u64 ram_bytes, u64 num_bytes, int delalloc)
-{
-	struct btrfs_space_info *space_info = cache->space_info;
-	int ret = 0;
-
-	spin_lock(&space_info->lock);
-	spin_lock(&cache->lock);
-	if (cache->ro) {
-		ret = -EAGAIN;
-	} else {
-		cache->reserved += num_bytes;
-		space_info->bytes_reserved += num_bytes;
-		btrfs_space_info_update_bytes_may_use(cache->fs_info,
-						      space_info, -ram_bytes);
-		if (delalloc)
-			cache->delalloc_bytes += num_bytes;
-	}
-	spin_unlock(&cache->lock);
-	spin_unlock(&space_info->lock);
-	return ret;
-}
-
-/**
- * btrfs_free_reserved_bytes - update the block_group and space info counters
- * @cache:      The cache we are manipulating
- * @num_bytes:  The number of bytes in question
- * @delalloc:   The blocks are allocated for the delalloc write
- *
- * This is called by somebody who is freeing space that was never actually used
- * on disk.  For example if you reserve some space for a new leaf in transaction
- * A and before transaction A commits you free that leaf, you call this with
- * reserve set to 0 in order to clear the reservation.
- */
-void btrfs_free_reserved_bytes(struct btrfs_block_group_cache *cache,
-			       u64 num_bytes, int delalloc)
-{
-	struct btrfs_space_info *space_info = cache->space_info;
-
-	spin_lock(&space_info->lock);
-	spin_lock(&cache->lock);
-	if (cache->ro)
-		space_info->bytes_readonly += num_bytes;
-	cache->reserved -= num_bytes;
-	space_info->bytes_reserved -= num_bytes;
-	space_info->max_extent_size = 0;
-
-	if (delalloc)
-		cache->delalloc_bytes -= num_bytes;
-	spin_unlock(&cache->lock);
-	spin_unlock(&space_info->lock);
-}
 void btrfs_prepare_extent_commit(struct btrfs_fs_info *fs_info)
 {
 	struct btrfs_caching_control *next;
-- 
2.14.3

