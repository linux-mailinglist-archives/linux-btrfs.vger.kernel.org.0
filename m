Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DEC7D836BE
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 Aug 2019 18:29:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387889AbfHFQ2y (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 6 Aug 2019 12:28:54 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:33070 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387876AbfHFQ2y (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 6 Aug 2019 12:28:54 -0400
Received: by mail-qt1-f194.google.com with SMTP id r6so80902843qtt.0
        for <linux-btrfs@vger.kernel.org>; Tue, 06 Aug 2019 09:28:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=XhUc1rlMlTDW5tjN3bLoCwsu+vhxErPqn60oWKURhio=;
        b=z9SdPvRU9Gbm+yG3SLzq1s3Iehccv0bcg/Tss8yf7QgV6/a6H16GjAplyR6v7Djw9w
         V7fxhibQfJrB0y0+tvqO5Qz24zXhM50ZICs2YTlricVDjhy14APWwnHqwOSBT9tdQ+Hg
         CtEG4Ebf+TkzCIYNWb9hA45Y5qXBxKzm+lkJOmTgTY2SKHPIdAo8ShEITahISohygrzN
         sb8eNUJW4FKrldB8L/GdBPZn01KnQj7ydBuQjZmZoo+cdv6cXTZodJi6x2ZqvuI2J2wW
         jtXhtAHxKwOSXE2w3dTpI8VFCv/LNVlBO9+nuBSYOrLc2djsJWAVJ5R2KKiCOEMf12O0
         noNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XhUc1rlMlTDW5tjN3bLoCwsu+vhxErPqn60oWKURhio=;
        b=OMulnSuVP8R8cc1rvdXJ/GVkMsluFM9KiMJW3Svok6oYSxbIiht8XndXb9qdJ7+WEt
         4aR+7EzCiep2yz9HtjAeLWJQE7Qi5bvTkmTCoy8y7sRDqKRnJ1JBNQq17Xf5iacWbxHZ
         GbkOUldaDtevRIlemr3fRI1jdFNhoOi0dpG386lIdtv0LLYMFz9swv27E0B9TiWib9Cm
         hP8Ijo9MFHTutPFfFlYjtEbDMm5bF5WFD9nM5zEOIQTPeWFsAsww0zHwivAYa5SaZrvH
         7GIFucDjYAyNPtnPSqBP/kHhWBU3rumQP5GzqN3kSCE3CEp9pERjl7OSBLAXc7aWYkkO
         FI5Q==
X-Gm-Message-State: APjAAAX5GhBLR8zC6TYcroD26MKRwhxWRvWGL+fWbpxNRjWV+bMAAPjp
        dviBxxR3u1Ufjod4jo1CiCRdDg==
X-Google-Smtp-Source: APXvYqzTeTD/Y4dz8UCXVuq0l8GpveXa8AcD7ToP8UaY97v7jCUZFa/dPq4jYyH9UzzMc5fvEUyKSA==
X-Received: by 2002:ac8:303c:: with SMTP id f57mr3881463qte.294.1565108932932;
        Tue, 06 Aug 2019 09:28:52 -0700 (PDT)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id 2sm45843849qtz.73.2019.08.06.09.28.51
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 06 Aug 2019 09:28:52 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     kernel-team@fb.com, linux-btrfs@vger.kernel.org
Subject: [PATCH 07/15] btrfs: migrate inc/dec_block_group_ro code
Date:   Tue,  6 Aug 2019 12:28:29 -0400
Message-Id: <20190806162837.15840-8-josef@toxicpanda.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190806162837.15840-1-josef@toxicpanda.com>
References: <20190806162837.15840-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This can easily be moved now.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/block-group.c | 213 +++++++++++++++++++++++++++++++++++++++++
 fs/btrfs/block-group.h |   2 +
 fs/btrfs/ctree.h       |   2 -
 fs/btrfs/extent-tree.c | 213 -----------------------------------------
 4 files changed, 215 insertions(+), 215 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index c0ca7d60e5f4..3a0a1255aa1e 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -1802,3 +1802,216 @@ int btrfs_make_block_group(struct btrfs_trans_handle *trans, u64 bytes_used,
 	set_avail_alloc_bits(fs_info, type);
 	return 0;
 }
+
+static u64 update_block_group_flags(struct btrfs_fs_info *fs_info, u64 flags)
+{
+	u64 num_devices;
+	u64 stripped;
+
+	/*
+	 * if restripe for this chunk_type is on pick target profile and
+	 * return, otherwise do the usual balance
+	 */
+	stripped = btrfs_get_restripe_target(fs_info, flags);
+	if (stripped)
+		return extended_to_chunk(stripped);
+
+	num_devices = fs_info->fs_devices->rw_devices;
+
+	stripped = BTRFS_BLOCK_GROUP_RAID0 | BTRFS_BLOCK_GROUP_RAID56_MASK |
+		BTRFS_BLOCK_GROUP_RAID1_MASK | BTRFS_BLOCK_GROUP_RAID10;
+
+	if (num_devices == 1) {
+		stripped |= BTRFS_BLOCK_GROUP_DUP;
+		stripped = flags & ~stripped;
+
+		/* turn raid0 into single device chunks */
+		if (flags & BTRFS_BLOCK_GROUP_RAID0)
+			return stripped;
+
+		/* turn mirroring into duplication */
+		if (flags & (BTRFS_BLOCK_GROUP_RAID1_MASK |
+			     BTRFS_BLOCK_GROUP_RAID10))
+			return stripped | BTRFS_BLOCK_GROUP_DUP;
+	} else {
+		/* they already had raid on here, just return */
+		if (flags & stripped)
+			return flags;
+
+		stripped |= BTRFS_BLOCK_GROUP_DUP;
+		stripped = flags & ~stripped;
+
+		/* switch duplicated blocks with raid1 */
+		if (flags & BTRFS_BLOCK_GROUP_DUP)
+			return stripped | BTRFS_BLOCK_GROUP_RAID1;
+
+		/* this is drive concat, leave it alone */
+	}
+
+	return flags;
+}
+
+/*
+ * Mark block group @cache read-only, so later write won't happen to block
+ * group @cache.
+ *
+ * If @force is not set, this function will only mark the block group readonly
+ * if we have enough free space (1M) in other metadata/system block groups.
+ * If @force is not set, this function will mark the block group readonly
+ * without checking free space.
+ *
+ * NOTE: This function doesn't care if other block groups can contain all the
+ * data in this block group. That check should be done by relocation routine,
+ * not this function.
+ */
+int __btrfs_inc_block_group_ro(struct btrfs_block_group_cache *cache,
+			       int force)
+{
+	struct btrfs_space_info *sinfo = cache->space_info;
+	u64 num_bytes;
+	u64 sinfo_used;
+	u64 min_allocable_bytes;
+	int ret = -ENOSPC;
+
+	/*
+	 * We need some metadata space and system metadata space for
+	 * allocating chunks in some corner cases until we force to set
+	 * it to be readonly.
+	 */
+	if ((sinfo->flags &
+	     (BTRFS_BLOCK_GROUP_SYSTEM | BTRFS_BLOCK_GROUP_METADATA)) &&
+	    !force)
+		min_allocable_bytes = SZ_1M;
+	else
+		min_allocable_bytes = 0;
+
+	spin_lock(&sinfo->lock);
+	spin_lock(&cache->lock);
+
+	if (cache->ro) {
+		cache->ro++;
+		ret = 0;
+		goto out;
+	}
+
+	num_bytes = cache->key.offset - cache->reserved - cache->pinned -
+		    cache->bytes_super - btrfs_block_group_used(&cache->item);
+	sinfo_used = btrfs_space_info_used(sinfo, true);
+
+	/*
+	 * sinfo_used + num_bytes should always <= sinfo->total_bytes.
+	 *
+	 * Here we make sure if we mark this bg RO, we still have enough
+	 * free space as buffer (if min_allocable_bytes is not 0).
+	 */
+	if (sinfo_used + num_bytes + min_allocable_bytes <=
+	    sinfo->total_bytes) {
+		sinfo->bytes_readonly += num_bytes;
+		cache->ro++;
+		list_add_tail(&cache->ro_list, &sinfo->ro_bgs);
+		ret = 0;
+	}
+out:
+	spin_unlock(&cache->lock);
+	spin_unlock(&sinfo->lock);
+	if (ret == -ENOSPC && btrfs_test_opt(cache->fs_info, ENOSPC_DEBUG)) {
+		btrfs_info(cache->fs_info,
+			"unable to make block group %llu ro",
+			cache->key.objectid);
+		btrfs_info(cache->fs_info,
+			"sinfo_used=%llu bg_num_bytes=%llu min_allocable=%llu",
+			sinfo_used, num_bytes, min_allocable_bytes);
+		btrfs_dump_space_info(cache->fs_info, cache->space_info, 0, 0);
+	}
+	return ret;
+}
+
+int btrfs_inc_block_group_ro(struct btrfs_block_group_cache *cache)
+
+{
+	struct btrfs_fs_info *fs_info = cache->fs_info;
+	struct btrfs_trans_handle *trans;
+	u64 alloc_flags;
+	int ret;
+
+again:
+	trans = btrfs_join_transaction(fs_info->extent_root);
+	if (IS_ERR(trans))
+		return PTR_ERR(trans);
+
+	/*
+	 * we're not allowed to set block groups readonly after the dirty
+	 * block groups cache has started writing.  If it already started,
+	 * back off and let this transaction commit
+	 */
+	mutex_lock(&fs_info->ro_block_group_mutex);
+	if (test_bit(BTRFS_TRANS_DIRTY_BG_RUN, &trans->transaction->flags)) {
+		u64 transid = trans->transid;
+
+		mutex_unlock(&fs_info->ro_block_group_mutex);
+		btrfs_end_transaction(trans);
+
+		ret = btrfs_wait_for_commit(fs_info, transid);
+		if (ret)
+			return ret;
+		goto again;
+	}
+
+	/*
+	 * if we are changing raid levels, try to allocate a corresponding
+	 * block group with the new raid level.
+	 */
+	alloc_flags = update_block_group_flags(fs_info, cache->flags);
+	if (alloc_flags != cache->flags) {
+		ret = btrfs_chunk_alloc(trans, alloc_flags, CHUNK_ALLOC_FORCE);
+		/*
+		 * ENOSPC is allowed here, we may have enough space
+		 * already allocated at the new raid level to
+		 * carry on
+		 */
+		if (ret == -ENOSPC)
+			ret = 0;
+		if (ret < 0)
+			goto out;
+	}
+
+	ret = __btrfs_inc_block_group_ro(cache, 0);
+	if (!ret)
+		goto out;
+	alloc_flags = btrfs_get_alloc_profile(fs_info, cache->space_info->flags);
+	ret = btrfs_chunk_alloc(trans, alloc_flags, CHUNK_ALLOC_FORCE);
+	if (ret < 0)
+		goto out;
+	ret = __btrfs_inc_block_group_ro(cache, 0);
+out:
+	if (cache->flags & BTRFS_BLOCK_GROUP_SYSTEM) {
+		alloc_flags = update_block_group_flags(fs_info, cache->flags);
+		mutex_lock(&fs_info->chunk_mutex);
+		check_system_chunk(trans, alloc_flags);
+		mutex_unlock(&fs_info->chunk_mutex);
+	}
+	mutex_unlock(&fs_info->ro_block_group_mutex);
+
+	btrfs_end_transaction(trans);
+	return ret;
+}
+
+void btrfs_dec_block_group_ro(struct btrfs_block_group_cache *cache)
+{
+	struct btrfs_space_info *sinfo = cache->space_info;
+	u64 num_bytes;
+
+	BUG_ON(!cache->ro);
+
+	spin_lock(&sinfo->lock);
+	spin_lock(&cache->lock);
+	if (!--cache->ro) {
+		num_bytes = cache->key.offset - cache->reserved -
+			    cache->pinned - cache->bytes_super -
+			    btrfs_block_group_used(&cache->item);
+		sinfo->bytes_readonly -= num_bytes;
+		list_del_init(&cache->ro_list);
+	}
+	spin_unlock(&cache->lock);
+	spin_unlock(&sinfo->lock);
+}
diff --git a/fs/btrfs/block-group.h b/fs/btrfs/block-group.h
index 30bb722fce02..f8b9bcfac9e9 100644
--- a/fs/btrfs/block-group.h
+++ b/fs/btrfs/block-group.h
@@ -188,6 +188,8 @@ int btrfs_make_block_group(struct btrfs_trans_handle *trans,
 			   u64 bytes_used, u64 type, u64 chunk_offset,
 			   u64 size);
 void btrfs_create_pending_block_groups(struct btrfs_trans_handle *trans);
+int btrfs_inc_block_group_ro(struct btrfs_block_group_cache *cache);
+void btrfs_dec_block_group_ro(struct btrfs_block_group_cache *cache);
 
 static inline int btrfs_block_group_cache_done(
 		struct btrfs_block_group_cache *cache)
diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 1cfe7adddc97..65a9ee97bce5 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -2590,8 +2590,6 @@ void btrfs_delalloc_release_extents(struct btrfs_inode *inode, u64 num_bytes,
 				    bool qgroup_free);
 
 int btrfs_delalloc_reserve_metadata(struct btrfs_inode *inode, u64 num_bytes);
-int btrfs_inc_block_group_ro(struct btrfs_block_group_cache *cache);
-void btrfs_dec_block_group_ro(struct btrfs_block_group_cache *cache);
 void btrfs_put_block_group_cache(struct btrfs_fs_info *info);
 u64 btrfs_account_ro_block_groups_free_space(struct btrfs_space_info *sinfo);
 int btrfs_error_unpin_extent_range(struct btrfs_fs_info *fs_info,
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 412c93abe6a4..6d96b378a189 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -6663,199 +6663,6 @@ int btrfs_drop_subtree(struct btrfs_trans_handle *trans,
 	return ret;
 }
 
-static u64 update_block_group_flags(struct btrfs_fs_info *fs_info, u64 flags)
-{
-	u64 num_devices;
-	u64 stripped;
-
-	/*
-	 * if restripe for this chunk_type is on pick target profile and
-	 * return, otherwise do the usual balance
-	 */
-	stripped = btrfs_get_restripe_target(fs_info, flags);
-	if (stripped)
-		return extended_to_chunk(stripped);
-
-	num_devices = fs_info->fs_devices->rw_devices;
-
-	stripped = BTRFS_BLOCK_GROUP_RAID0 | BTRFS_BLOCK_GROUP_RAID56_MASK |
-		BTRFS_BLOCK_GROUP_RAID1_MASK | BTRFS_BLOCK_GROUP_RAID10;
-
-	if (num_devices == 1) {
-		stripped |= BTRFS_BLOCK_GROUP_DUP;
-		stripped = flags & ~stripped;
-
-		/* turn raid0 into single device chunks */
-		if (flags & BTRFS_BLOCK_GROUP_RAID0)
-			return stripped;
-
-		/* turn mirroring into duplication */
-		if (flags & (BTRFS_BLOCK_GROUP_RAID1_MASK |
-			     BTRFS_BLOCK_GROUP_RAID10))
-			return stripped | BTRFS_BLOCK_GROUP_DUP;
-	} else {
-		/* they already had raid on here, just return */
-		if (flags & stripped)
-			return flags;
-
-		stripped |= BTRFS_BLOCK_GROUP_DUP;
-		stripped = flags & ~stripped;
-
-		/* switch duplicated blocks with raid1 */
-		if (flags & BTRFS_BLOCK_GROUP_DUP)
-			return stripped | BTRFS_BLOCK_GROUP_RAID1;
-
-		/* this is drive concat, leave it alone */
-	}
-
-	return flags;
-}
-
-/*
- * Mark block group @cache read-only, so later write won't happen to block
- * group @cache.
- *
- * If @force is not set, this function will only mark the block group readonly
- * if we have enough free space (1M) in other metadata/system block groups.
- * If @force is not set, this function will mark the block group readonly
- * without checking free space.
- *
- * NOTE: This function doesn't care if other block groups can contain all the
- * data in this block group. That check should be done by relocation routine,
- * not this function.
- */
-int __btrfs_inc_block_group_ro(struct btrfs_block_group_cache *cache,
-			       int force)
-{
-	struct btrfs_space_info *sinfo = cache->space_info;
-	u64 num_bytes;
-	u64 sinfo_used;
-	u64 min_allocable_bytes;
-	int ret = -ENOSPC;
-
-	/*
-	 * We need some metadata space and system metadata space for
-	 * allocating chunks in some corner cases until we force to set
-	 * it to be readonly.
-	 */
-	if ((sinfo->flags &
-	     (BTRFS_BLOCK_GROUP_SYSTEM | BTRFS_BLOCK_GROUP_METADATA)) &&
-	    !force)
-		min_allocable_bytes = SZ_1M;
-	else
-		min_allocable_bytes = 0;
-
-	spin_lock(&sinfo->lock);
-	spin_lock(&cache->lock);
-
-	if (cache->ro) {
-		cache->ro++;
-		ret = 0;
-		goto out;
-	}
-
-	num_bytes = cache->key.offset - cache->reserved - cache->pinned -
-		    cache->bytes_super - btrfs_block_group_used(&cache->item);
-	sinfo_used = btrfs_space_info_used(sinfo, true);
-
-	/*
-	 * sinfo_used + num_bytes should always <= sinfo->total_bytes.
-	 *
-	 * Here we make sure if we mark this bg RO, we still have enough
-	 * free space as buffer (if min_allocable_bytes is not 0).
-	 */
-	if (sinfo_used + num_bytes + min_allocable_bytes <=
-	    sinfo->total_bytes) {
-		sinfo->bytes_readonly += num_bytes;
-		cache->ro++;
-		list_add_tail(&cache->ro_list, &sinfo->ro_bgs);
-		ret = 0;
-	}
-out:
-	spin_unlock(&cache->lock);
-	spin_unlock(&sinfo->lock);
-	if (ret == -ENOSPC && btrfs_test_opt(cache->fs_info, ENOSPC_DEBUG)) {
-		btrfs_info(cache->fs_info,
-			"unable to make block group %llu ro",
-			cache->key.objectid);
-		btrfs_info(cache->fs_info,
-			"sinfo_used=%llu bg_num_bytes=%llu min_allocable=%llu",
-			sinfo_used, num_bytes, min_allocable_bytes);
-		btrfs_dump_space_info(cache->fs_info, cache->space_info, 0, 0);
-	}
-	return ret;
-}
-
-int btrfs_inc_block_group_ro(struct btrfs_block_group_cache *cache)
-
-{
-	struct btrfs_fs_info *fs_info = cache->fs_info;
-	struct btrfs_trans_handle *trans;
-	u64 alloc_flags;
-	int ret;
-
-again:
-	trans = btrfs_join_transaction(fs_info->extent_root);
-	if (IS_ERR(trans))
-		return PTR_ERR(trans);
-
-	/*
-	 * we're not allowed to set block groups readonly after the dirty
-	 * block groups cache has started writing.  If it already started,
-	 * back off and let this transaction commit
-	 */
-	mutex_lock(&fs_info->ro_block_group_mutex);
-	if (test_bit(BTRFS_TRANS_DIRTY_BG_RUN, &trans->transaction->flags)) {
-		u64 transid = trans->transid;
-
-		mutex_unlock(&fs_info->ro_block_group_mutex);
-		btrfs_end_transaction(trans);
-
-		ret = btrfs_wait_for_commit(fs_info, transid);
-		if (ret)
-			return ret;
-		goto again;
-	}
-
-	/*
-	 * if we are changing raid levels, try to allocate a corresponding
-	 * block group with the new raid level.
-	 */
-	alloc_flags = update_block_group_flags(fs_info, cache->flags);
-	if (alloc_flags != cache->flags) {
-		ret = btrfs_chunk_alloc(trans, alloc_flags, CHUNK_ALLOC_FORCE);
-		/*
-		 * ENOSPC is allowed here, we may have enough space
-		 * already allocated at the new raid level to
-		 * carry on
-		 */
-		if (ret == -ENOSPC)
-			ret = 0;
-		if (ret < 0)
-			goto out;
-	}
-
-	ret = __btrfs_inc_block_group_ro(cache, 0);
-	if (!ret)
-		goto out;
-	alloc_flags = btrfs_get_alloc_profile(fs_info, cache->space_info->flags);
-	ret = btrfs_chunk_alloc(trans, alloc_flags, CHUNK_ALLOC_FORCE);
-	if (ret < 0)
-		goto out;
-	ret = __btrfs_inc_block_group_ro(cache, 0);
-out:
-	if (cache->flags & BTRFS_BLOCK_GROUP_SYSTEM) {
-		alloc_flags = update_block_group_flags(fs_info, cache->flags);
-		mutex_lock(&fs_info->chunk_mutex);
-		check_system_chunk(trans, alloc_flags);
-		mutex_unlock(&fs_info->chunk_mutex);
-	}
-	mutex_unlock(&fs_info->ro_block_group_mutex);
-
-	btrfs_end_transaction(trans);
-	return ret;
-}
-
 int btrfs_force_chunk_alloc(struct btrfs_trans_handle *trans, u64 type)
 {
 	u64 alloc_flags = btrfs_get_alloc_profile(trans->fs_info, type);
@@ -6898,26 +6705,6 @@ u64 btrfs_account_ro_block_groups_free_space(struct btrfs_space_info *sinfo)
 	return free_bytes;
 }
 
-void btrfs_dec_block_group_ro(struct btrfs_block_group_cache *cache)
-{
-	struct btrfs_space_info *sinfo = cache->space_info;
-	u64 num_bytes;
-
-	BUG_ON(!cache->ro);
-
-	spin_lock(&sinfo->lock);
-	spin_lock(&cache->lock);
-	if (!--cache->ro) {
-		num_bytes = cache->key.offset - cache->reserved -
-			    cache->pinned - cache->bytes_super -
-			    btrfs_block_group_used(&cache->item);
-		sinfo->bytes_readonly -= num_bytes;
-		list_del_init(&cache->ro_list);
-	}
-	spin_unlock(&cache->lock);
-	spin_unlock(&sinfo->lock);
-}
-
 void btrfs_put_block_group_cache(struct btrfs_fs_info *info)
 {
 	struct btrfs_block_group_cache *block_group;
-- 
2.21.0

