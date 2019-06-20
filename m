Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CF25B4DA5D
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Jun 2019 21:38:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726786AbfFTTij (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 20 Jun 2019 15:38:39 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:41841 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726506AbfFTTii (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 20 Jun 2019 15:38:38 -0400
Received: by mail-qt1-f196.google.com with SMTP id d17so4376785qtj.8
        for <linux-btrfs@vger.kernel.org>; Thu, 20 Jun 2019 12:38:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=O7NrhG128wWbPu+szEmUpbvfnh40gBptbhPcnRG23aM=;
        b=OHFFq65AGN3jOiBYuz56/Rp5Sf2XIsu47cghOYZcxaKNpLd19wG8PIUije1wf5F86/
         sOy/XsOwAHQfH7M8eJzkfyNLKg7EpkIov6R7v0Nt7Sm7tfaMKqxgXv+ByiFaCIPqBUlN
         Bxa8276aosTi/Dcfim3qA1MhY0pF4gGrBNK1wqhJEyLZVGacmraJUwP6j/WAgVA4fpzK
         Luv78HrrFVAXIaj3imCMDy2Te8q0agUS/WtNr+zE/jA2HcYBD39MWXN/5d2usNNh8sRW
         ENlyaCH7pP4nhzUWUXmkGk0Qced7mAPhfUmyKZ21rzdmvwWibaZ8w4HN/d5oXkX8Bctq
         5OHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=O7NrhG128wWbPu+szEmUpbvfnh40gBptbhPcnRG23aM=;
        b=aAquosCfO3e6qNLi+LMGqcDN1uL8H75pqwvwSb0oy3MKs1NG8ycATalAqEICUXnn/0
         Lz0MXKb2co4hxJx6mZLd8jH4GbxSR+hjPvLEH9EyqH/fZkjaSaLPF1JFoP3W6LyzaRko
         tUGGdoXJ+MYHiNs1gjN177KvRnGmGQY3+y67hc2VzasXSYD41EcvFZN91gFzqU+JorZX
         FYRlgaqpPMrV+zQ0p1uhTmoBAKGindSHIuYEEUkdX1XBJfQGavmilwZTgLTj9ixdmOwz
         p4L5g2B0o2ii6DambQJhd45/OOzjORsoujd8tekQyve42ndsfZVx9gBW+3aWY6vz98OB
         9Blw==
X-Gm-Message-State: APjAAAU58C2aJJGSrCq6WIWuMVRrvbwKQIMekpjA/jD3y5Ifuf2/5xPF
        tClY1Wn5SH2Eamig88bvBT/h8sWykWM+fQ==
X-Google-Smtp-Source: APXvYqxlhUrqHGsqtfTgh8USPt62PA1EXJLBUgGcTOWU7krMhU68BM0qE2aa9X+DnSg25FiAUnmUpA==
X-Received: by 2002:a0c:bf4a:: with SMTP id b10mr16466868qvj.120.1561059517302;
        Thu, 20 Jun 2019 12:38:37 -0700 (PDT)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id j141sm280232qke.28.2019.06.20.12.38.36
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 20 Jun 2019 12:38:36 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 17/25] btrfs: migrate inc/dec_block_group_ro code
Date:   Thu, 20 Jun 2019 15:37:59 -0400
Message-Id: <20190620193807.29311-18-josef@toxicpanda.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20190620193807.29311-1-josef@toxicpanda.com>
References: <20190620193807.29311-1-josef@toxicpanda.com>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This can easily be moved now.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/block-group.c | 196 +++++++++++++++++++++++++++++++++++++++++++++++++
 fs/btrfs/block-group.h |   2 +
 fs/btrfs/ctree.h       |   2 -
 fs/btrfs/extent-tree.c | 196 -------------------------------------------------
 4 files changed, 198 insertions(+), 198 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index de9ebbcd971a..cc69a6a14bc9 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -1789,3 +1789,199 @@ int btrfs_make_block_group(struct btrfs_trans_handle *trans, u64 bytes_used,
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
+	stripped = BTRFS_BLOCK_GROUP_RAID0 |
+		BTRFS_BLOCK_GROUP_RAID5 | BTRFS_BLOCK_GROUP_RAID6 |
+		BTRFS_BLOCK_GROUP_RAID1 | BTRFS_BLOCK_GROUP_RAID10;
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
+		if (flags & (BTRFS_BLOCK_GROUP_RAID1 |
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
+		ret = btrfs_chunk_alloc(trans, alloc_flags,
+					CHUNK_ALLOC_FORCE);
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
index 4ea744e29c1c..bccf2b02908a 100644
--- a/fs/btrfs/block-group.h
+++ b/fs/btrfs/block-group.h
@@ -191,6 +191,8 @@ int btrfs_make_block_group(struct btrfs_trans_handle *trans,
 			   u64 bytes_used, u64 type, u64 chunk_offset,
 			   u64 size);
 void btrfs_create_pending_block_groups(struct btrfs_trans_handle *trans);
+int btrfs_inc_block_group_ro(struct btrfs_block_group_cache *cache);
+void btrfs_dec_block_group_ro(struct btrfs_block_group_cache *cache);
 
 static inline int
 btrfs_block_group_cache_done(struct btrfs_block_group_cache *cache)
diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index e36c949a25c7..b609ec239cc7 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -2586,8 +2586,6 @@ void btrfs_delalloc_release_extents(struct btrfs_inode *inode, u64 num_bytes,
 				    bool qgroup_free);
 
 int btrfs_delalloc_reserve_metadata(struct btrfs_inode *inode, u64 num_bytes);
-int btrfs_inc_block_group_ro(struct btrfs_block_group_cache *cache);
-void btrfs_dec_block_group_ro(struct btrfs_block_group_cache *cache);
 void btrfs_put_block_group_cache(struct btrfs_fs_info *info);
 u64 btrfs_account_ro_block_groups_free_space(struct btrfs_space_info *sinfo);
 int btrfs_error_unpin_extent_range(struct btrfs_fs_info *fs_info,
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index f6e2cbe383dd..129bc04fcffd 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -6524,182 +6524,6 @@ int btrfs_drop_subtree(struct btrfs_trans_handle *trans,
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
-	stripped = BTRFS_BLOCK_GROUP_RAID0 |
-		BTRFS_BLOCK_GROUP_RAID5 | BTRFS_BLOCK_GROUP_RAID6 |
-		BTRFS_BLOCK_GROUP_RAID1 | BTRFS_BLOCK_GROUP_RAID10;
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
-		if (flags & (BTRFS_BLOCK_GROUP_RAID1 |
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
-		ret = btrfs_chunk_alloc(trans, alloc_flags,
-					CHUNK_ALLOC_FORCE);
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
@@ -6742,26 +6566,6 @@ u64 btrfs_account_ro_block_groups_free_space(struct btrfs_space_info *sinfo)
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
 /*
  * Checks to see if it's even possible to relocate this block group.
  *
-- 
2.14.3

