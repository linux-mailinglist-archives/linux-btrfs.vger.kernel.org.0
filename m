Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 387CC5767A8
	for <lists+linux-btrfs@lfdr.de>; Fri, 15 Jul 2022 21:45:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230310AbiGOTpl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 15 Jul 2022 15:45:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbiGOTpj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 15 Jul 2022 15:45:39 -0400
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDE1E67CA2
        for <linux-btrfs@vger.kernel.org>; Fri, 15 Jul 2022 12:45:37 -0700 (PDT)
Received: by mail-qv1-xf31.google.com with SMTP id m6so4414716qvq.10
        for <linux-btrfs@vger.kernel.org>; Fri, 15 Jul 2022 12:45:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=ud0sdWJ0ib0bS0E6tcfLyFWOy6TXIBdH5GsVh0bSqSo=;
        b=0m3amP/0cGVXsCI8995smEiUy96eUXwvLj4A4tcT7ubBirxYl8PKoJkNBrz1VNtKFE
         FdyaMeWR6yXKuQLn/nTNwW0z0rhTqEIpU3P+311+LD37LR41s4e+rjVPzCYkquHbYjoc
         nCqyX9aCMg+mJgEuRkIii6B191JQuHifcfRSdx+uXhd65q1+3C9WFrcLxV4lftdj7Zkr
         041gUgoFQY/CbJqmyU2EWxQZ/8PPqwD7Hvwuh3AIs5dhqeUriPzgo7nlE05fJAVHtGtS
         Mt/NHvLTALHhWfTJ3qGIkZubrSChV5/0LxM2Miy/+obqVwmu5NRn/Q914Y9q05m0fXKp
         bDhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ud0sdWJ0ib0bS0E6tcfLyFWOy6TXIBdH5GsVh0bSqSo=;
        b=bTzR2Lbm+/72KiVwQlZUMksBp+7rI1sHvFdKd1YyZY9fbhNmLE8Y939SwRX0m+3jCh
         aBqTauhvJ5cd/mZOBKhEiSuHBMMMjZ6j6x5RgLmRpF7C4S+7B7u8jyWx8yNFCupfTfOX
         AAzG63C/uIdWwExZ+Evfp52QuZQ9BTkpz5yFy74oVha9QX3Is1mCkRP8N+3DLaMLGyqk
         CyxMLRzr4DbNkXT26orF4HefOacnYoGIqilfuhg9MhUWd6eanzKWDoKVUxrBkmWNWM3V
         64upzUbcpG9SxRA0lHHvJHcsZVeMEDNEr6LBwEGNpMFgRvQ1YTb4BsCbJC7azhrV1F8d
         GCnA==
X-Gm-Message-State: AJIora+YtbHORiKSDPHRkv9yiLmMxCXoI7MESi8V/bv5JdSsk/tB51JG
        YKsijy14i+x+I8WuLTOGWJrHEVxTY/3JkQ==
X-Google-Smtp-Source: AGRyM1uPmUFowIGc7nC5l6s+dFKcc74xAcTtqyXVjfBjNgCmNFSKjgawD/lsr5zM/VDBYl1zQbctsg==
X-Received: by 2002:a05:6214:5285:b0:472:ed70:23a0 with SMTP id kj5-20020a056214528500b00472ed7023a0mr13266347qvb.121.1657914336511;
        Fri, 15 Jul 2022 12:45:36 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id o17-20020a05620a2a1100b006b5d6ab6a3bsm854893qkp.76.2022.07.15.12.45.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jul 2022 12:45:36 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 4/9] btrfs: convert block group bit field to use bit helpers
Date:   Fri, 15 Jul 2022 15:45:24 -0400
Message-Id: <50ec2803f650fd1aae042b40ad1df77b4bf5980a.1657914198.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1657914198.git.josef@toxicpanda.com>
References: <cover.1657914198.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We use a bit field in the btrfs_block_group for different flags, however
this is awkward because we have to hold the block_group->lock for any
modification of any of these fields, and makes the code clunky for a few
of these flags.  Convert these to a properly flags setup so we can
utilize the bit helpers.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/block-group.c      | 27 +++++++++++++++++----------
 fs/btrfs/block-group.h      | 20 ++++++++++++--------
 fs/btrfs/dev-replace.c      |  6 +++---
 fs/btrfs/extent-tree.c      |  7 +++++--
 fs/btrfs/free-space-cache.c | 18 +++++++++---------
 fs/btrfs/scrub.c            | 13 +++++++------
 fs/btrfs/space-info.c       |  2 +-
 fs/btrfs/volumes.c          | 11 ++++++-----
 fs/btrfs/zoned.c            | 34 ++++++++++++++++++++++------------
 9 files changed, 82 insertions(+), 56 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 5669e3cd25c0..2aa756a0d56d 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -789,7 +789,7 @@ int btrfs_cache_block_group(struct btrfs_block_group *cache, int load_cache_only
 		cache->cached = BTRFS_CACHE_FAST;
 	else
 		cache->cached = BTRFS_CACHE_STARTED;
-	cache->has_caching_ctl = 1;
+	set_bit(BLOCK_GROUP_FLAG_HAS_CACHING_CTL, &cache->runtime_flags);
 	spin_unlock(&cache->lock);
 
 	write_lock(&fs_info->block_group_cache_lock);
@@ -1005,11 +1005,14 @@ int btrfs_remove_block_group(struct btrfs_trans_handle *trans,
 		kobject_put(kobj);
 	}
 
-	if (block_group->has_caching_ctl)
+
+	if (test_bit(BLOCK_GROUP_FLAG_HAS_CACHING_CTL,
+		     &block_group->runtime_flags))
 		caching_ctl = btrfs_get_caching_control(block_group);
 	if (block_group->cached == BTRFS_CACHE_STARTED)
 		btrfs_wait_block_group_cache_done(block_group);
-	if (block_group->has_caching_ctl) {
+	if (test_bit(BLOCK_GROUP_FLAG_HAS_CACHING_CTL,
+		     &block_group->runtime_flags)) {
 		write_lock(&fs_info->block_group_cache_lock);
 		if (!caching_ctl) {
 			struct btrfs_caching_control *ctl;
@@ -1051,12 +1054,13 @@ int btrfs_remove_block_group(struct btrfs_trans_handle *trans,
 			< block_group->zone_unusable);
 		WARN_ON(block_group->space_info->disk_total
 			< block_group->length * factor);
-		WARN_ON(block_group->zone_is_active &&
+		WARN_ON(test_bit(BLOCK_GROUP_FLAG_ZONE_IS_ACTIVE,
+				 &block_group->runtime_flags) &&
 			block_group->space_info->active_total_bytes
 			< block_group->length);
 	}
 	block_group->space_info->total_bytes -= block_group->length;
-	if (block_group->zone_is_active)
+	if (test_bit(BLOCK_GROUP_FLAG_ZONE_IS_ACTIVE, &block_group->runtime_flags))
 		block_group->space_info->active_total_bytes -= block_group->length;
 	block_group->space_info->bytes_readonly -=
 		(block_group->length - block_group->zone_unusable);
@@ -1086,7 +1090,8 @@ int btrfs_remove_block_group(struct btrfs_trans_handle *trans,
 		goto out;
 
 	spin_lock(&block_group->lock);
-	block_group->removed = 1;
+	set_bit(BLOCK_GROUP_FLAG_REMOVED, &block_group->runtime_flags);
+
 	/*
 	 * At this point trimming or scrub can't start on this block group,
 	 * because we removed the block group from the rbtree
@@ -2418,7 +2423,8 @@ void btrfs_create_pending_block_groups(struct btrfs_trans_handle *trans)
 		ret = insert_block_group_item(trans, block_group);
 		if (ret)
 			btrfs_abort_transaction(trans, ret);
-		if (!block_group->chunk_item_inserted) {
+		if (!test_bit(BLOCK_GROUP_FLAG_CHUNK_ITEM_INSERTED,
+			      &block_group->runtime_flags)) {
 			mutex_lock(&fs_info->chunk_mutex);
 			ret = btrfs_chunk_alloc_add_chunk_item(trans, block_group);
 			mutex_unlock(&fs_info->chunk_mutex);
@@ -3964,7 +3970,8 @@ void btrfs_put_block_group_cache(struct btrfs_fs_info *info)
 		while (block_group) {
 			btrfs_wait_block_group_cache_done(block_group);
 			spin_lock(&block_group->lock);
-			if (block_group->iref)
+			if (test_bit(BLOCK_GROUP_FLAG_IREF,
+				     &block_group->runtime_flags))
 				break;
 			spin_unlock(&block_group->lock);
 			block_group = btrfs_next_block_group(block_group);
@@ -3977,7 +3984,7 @@ void btrfs_put_block_group_cache(struct btrfs_fs_info *info)
 		}
 
 		inode = block_group->inode;
-		block_group->iref = 0;
+		clear_bit(BLOCK_GROUP_FLAG_IREF, &block_group->runtime_flags);
 		block_group->inode = NULL;
 		spin_unlock(&block_group->lock);
 		ASSERT(block_group->io_ctl.inode == NULL);
@@ -4119,7 +4126,7 @@ void btrfs_unfreeze_block_group(struct btrfs_block_group *block_group)
 
 	spin_lock(&block_group->lock);
 	cleanup = (atomic_dec_and_test(&block_group->frozen) &&
-		   block_group->removed);
+		   test_bit(BLOCK_GROUP_FLAG_REMOVED, &block_group->runtime_flags));
 	spin_unlock(&block_group->lock);
 
 	if (cleanup) {
diff --git a/fs/btrfs/block-group.h b/fs/btrfs/block-group.h
index 35e0e860cc0b..8008a391ed8c 100644
--- a/fs/btrfs/block-group.h
+++ b/fs/btrfs/block-group.h
@@ -46,6 +46,17 @@ enum btrfs_chunk_alloc_enum {
 	CHUNK_ALLOC_FORCE_FOR_EXTENT,
 };
 
+enum btrfs_block_group_flags {
+	BLOCK_GROUP_FLAG_IREF,
+	BLOCK_GROUP_FLAG_HAS_CACHING_CTL,
+	BLOCK_GROUP_FLAG_REMOVED,
+	BLOCK_GROUP_FLAG_TO_COPY,
+	BLOCK_GROUP_FLAG_RELOCATING_REPAIR,
+	BLOCK_GROUP_FLAG_CHUNK_ITEM_INSERTED,
+	BLOCK_GROUP_FLAG_ZONE_IS_ACTIVE,
+	BLOCK_GROUP_FLAG_ZONED_DATA_RELOC,
+};
+
 struct btrfs_caching_control {
 	struct list_head list;
 	struct mutex mutex;
@@ -95,16 +106,9 @@ struct btrfs_block_group {
 
 	/* For raid56, this is a full stripe, without parity */
 	unsigned long full_stripe_len;
+	unsigned long runtime_flags;
 
 	unsigned int ro;
-	unsigned int iref:1;
-	unsigned int has_caching_ctl:1;
-	unsigned int removed:1;
-	unsigned int to_copy:1;
-	unsigned int relocating_repair:1;
-	unsigned int chunk_item_inserted:1;
-	unsigned int zone_is_active:1;
-	unsigned int zoned_data_reloc_ongoing:1;
 
 	int disk_cache_state;
 
diff --git a/fs/btrfs/dev-replace.c b/fs/btrfs/dev-replace.c
index f43196a893ca..f85bbd99230b 100644
--- a/fs/btrfs/dev-replace.c
+++ b/fs/btrfs/dev-replace.c
@@ -546,7 +546,7 @@ static int mark_block_group_to_copy(struct btrfs_fs_info *fs_info,
 			continue;
 
 		spin_lock(&cache->lock);
-		cache->to_copy = 1;
+		set_bit(BLOCK_GROUP_FLAG_TO_COPY, &cache->runtime_flags);
 		spin_unlock(&cache->lock);
 
 		btrfs_put_block_group(cache);
@@ -577,7 +577,7 @@ bool btrfs_finish_block_group_to_copy(struct btrfs_device *srcdev,
 		return true;
 
 	spin_lock(&cache->lock);
-	if (cache->removed) {
+	if (test_bit(BLOCK_GROUP_FLAG_REMOVED, &cache->runtime_flags)) {
 		spin_unlock(&cache->lock);
 		return true;
 	}
@@ -611,7 +611,7 @@ bool btrfs_finish_block_group_to_copy(struct btrfs_device *srcdev,
 
 	/* Last stripe on this device */
 	spin_lock(&cache->lock);
-	cache->to_copy = 0;
+	clear_bit(BLOCK_GROUP_FLAG_TO_COPY, &cache->runtime_flags);
 	spin_unlock(&cache->lock);
 
 	return true;
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index c6a9237b31b9..151f254d5c11 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -3816,7 +3816,9 @@ static int do_allocation_zoned(struct btrfs_block_group *block_group,
 	       block_group->start == fs_info->data_reloc_bg ||
 	       fs_info->data_reloc_bg == 0);
 
-	if (block_group->ro || block_group->zoned_data_reloc_ongoing) {
+	if (block_group->ro ||
+	    test_bit(BLOCK_GROUP_FLAG_ZONED_DATA_RELOC,
+		     &block_group->runtime_flags)) {
 		ret = 1;
 		goto out;
 	}
@@ -3893,7 +3895,8 @@ static int do_allocation_zoned(struct btrfs_block_group *block_group,
 		 * regular extents) at the same time to the same zone, which
 		 * easily break the write pointer.
 		 */
-		block_group->zoned_data_reloc_ongoing = 1;
+		set_bit(BLOCK_GROUP_FLAG_ZONED_DATA_RELOC,
+			&block_group->runtime_flags);
 		fs_info->data_reloc_bg = 0;
 	}
 	spin_unlock(&fs_info->relocation_bg_lock);
diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
index 996da650ecdc..fd73327134ac 100644
--- a/fs/btrfs/free-space-cache.c
+++ b/fs/btrfs/free-space-cache.c
@@ -126,10 +126,9 @@ struct inode *lookup_free_space_inode(struct btrfs_block_group *block_group,
 		block_group->disk_cache_state = BTRFS_DC_CLEAR;
 	}
 
-	if (!block_group->iref) {
+	if (!test_and_set_bit(BLOCK_GROUP_FLAG_IREF,
+			      &block_group->runtime_flags))
 		block_group->inode = igrab(inode);
-		block_group->iref = 1;
-	}
 	spin_unlock(&block_group->lock);
 
 	return inode;
@@ -241,8 +240,8 @@ int btrfs_remove_free_space_inode(struct btrfs_trans_handle *trans,
 	clear_nlink(inode);
 	/* One for the block groups ref */
 	spin_lock(&block_group->lock);
-	if (block_group->iref) {
-		block_group->iref = 0;
+	if (test_and_clear_bit(BLOCK_GROUP_FLAG_IREF,
+			       &block_group->runtime_flags)) {
 		block_group->inode = NULL;
 		spin_unlock(&block_group->lock);
 		iput(inode);
@@ -2860,7 +2859,8 @@ void btrfs_dump_free_space(struct btrfs_block_group *block_group,
 	if (btrfs_is_zoned(fs_info)) {
 		btrfs_info(fs_info, "free space %llu active %d",
 			   block_group->zone_capacity - block_group->alloc_offset,
-			   block_group->zone_is_active);
+			   test_bit(BLOCK_GROUP_FLAG_ZONE_IS_ACTIVE,
+				    &block_group->runtime_flags));
 		return;
 	}
 
@@ -3992,7 +3992,7 @@ int btrfs_trim_block_group(struct btrfs_block_group *block_group,
 	*trimmed = 0;
 
 	spin_lock(&block_group->lock);
-	if (block_group->removed) {
+	if (test_bit(BLOCK_GROUP_FLAG_REMOVED, &block_group->runtime_flags)) {
 		spin_unlock(&block_group->lock);
 		return 0;
 	}
@@ -4022,7 +4022,7 @@ int btrfs_trim_block_group_extents(struct btrfs_block_group *block_group,
 	*trimmed = 0;
 
 	spin_lock(&block_group->lock);
-	if (block_group->removed) {
+	if (test_bit(BLOCK_GROUP_FLAG_REMOVED, &block_group->runtime_flags)) {
 		spin_unlock(&block_group->lock);
 		return 0;
 	}
@@ -4044,7 +4044,7 @@ int btrfs_trim_block_group_bitmaps(struct btrfs_block_group *block_group,
 	*trimmed = 0;
 
 	spin_lock(&block_group->lock);
-	if (block_group->removed) {
+	if (test_bit(BLOCK_GROUP_FLAG_REMOVED, &block_group->runtime_flags)) {
 		spin_unlock(&block_group->lock);
 		return 0;
 	}
diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index 3afe5fa50a63..b7be62f1cd8e 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -3266,7 +3266,7 @@ static int scrub_simple_mirror(struct scrub_ctx *sctx,
 		}
 		/* Block group removed? */
 		spin_lock(&bg->lock);
-		if (bg->removed) {
+		if (test_bit(BLOCK_GROUP_FLAG_REMOVED, &bg->runtime_flags)) {
 			spin_unlock(&bg->lock);
 			ret = 0;
 			break;
@@ -3606,7 +3606,7 @@ static noinline_for_stack int scrub_chunk(struct scrub_ctx *sctx,
 		 * kthread or relocation.
 		 */
 		spin_lock(&bg->lock);
-		if (!bg->removed)
+		if (!test_bit(BLOCK_GROUP_FLAG_REMOVED, &bg->runtime_flags))
 			ret = -EINVAL;
 		spin_unlock(&bg->lock);
 
@@ -3765,7 +3765,8 @@ int scrub_enumerate_chunks(struct scrub_ctx *sctx,
 
 		if (sctx->is_dev_replace && btrfs_is_zoned(fs_info)) {
 			spin_lock(&cache->lock);
-			if (!cache->to_copy) {
+			if (!test_bit(BLOCK_GROUP_FLAG_TO_COPY,
+				      &cache->runtime_flags)) {
 				spin_unlock(&cache->lock);
 				btrfs_put_block_group(cache);
 				goto skip;
@@ -3782,7 +3783,7 @@ int scrub_enumerate_chunks(struct scrub_ctx *sctx,
 		 * repair extents.
 		 */
 		spin_lock(&cache->lock);
-		if (cache->removed) {
+		if (test_bit(BLOCK_GROUP_FLAG_REMOVED, &cache->runtime_flags)) {
 			spin_unlock(&cache->lock);
 			btrfs_put_block_group(cache);
 			goto skip;
@@ -3942,8 +3943,8 @@ int scrub_enumerate_chunks(struct scrub_ctx *sctx,
 		 * balance is triggered or it becomes used and unused again.
 		 */
 		spin_lock(&cache->lock);
-		if (!cache->removed && !cache->ro && cache->reserved == 0 &&
-		    cache->used == 0) {
+		if (!test_bit(BLOCK_GROUP_FLAG_REMOVED, &cache->runtime_flags) &&
+		    !cache->ro && cache->reserved == 0 && cache->used == 0) {
 			spin_unlock(&cache->lock);
 			if (btrfs_test_opt(fs_info, DISCARD_ASYNC))
 				btrfs_discard_queue_work(&fs_info->discard_ctl,
diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index f89aa49f53d4..477e57ace48d 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -305,7 +305,7 @@ void btrfs_add_bg_to_space_info(struct btrfs_fs_info *info,
 	ASSERT(found);
 	spin_lock(&found->lock);
 	found->total_bytes += block_group->length;
-	if (block_group->zone_is_active)
+	if (test_bit(BLOCK_GROUP_FLAG_ZONE_IS_ACTIVE, &block_group->runtime_flags))
 		found->active_total_bytes += block_group->length;
 	found->disk_total += block_group->length * factor;
 	found->bytes_used += block_group->used;
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index bf4e140f6bfc..7637eae1a699 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -5590,7 +5590,7 @@ int btrfs_chunk_alloc_add_chunk_item(struct btrfs_trans_handle *trans,
 	if (ret)
 		goto out;
 
-	bg->chunk_item_inserted = 1;
+	set_bit(BLOCK_GROUP_FLAG_CHUNK_ITEM_INSERTED, &bg->runtime_flags);
 
 	if (map->type & BTRFS_BLOCK_GROUP_SYSTEM) {
 		ret = btrfs_add_system_chunk(fs_info, &key, chunk, item_size);
@@ -6149,7 +6149,7 @@ static bool is_block_group_to_copy(struct btrfs_fs_info *fs_info, u64 logical)
 	cache = btrfs_lookup_block_group(fs_info, logical);
 
 	spin_lock(&cache->lock);
-	ret = cache->to_copy;
+	ret = test_bit(BLOCK_GROUP_FLAG_TO_COPY, &cache->runtime_flags);
 	spin_unlock(&cache->lock);
 
 	btrfs_put_block_group(cache);
@@ -8243,7 +8243,8 @@ static int relocating_repair_kthread(void *data)
 	if (!cache)
 		goto out;
 
-	if (!cache->relocating_repair)
+	if (!test_bit(BLOCK_GROUP_FLAG_RELOCATING_REPAIR,
+		      &cache->runtime_flags))
 		goto out;
 
 	ret = btrfs_may_alloc_data_chunk(fs_info, target);
@@ -8281,12 +8282,12 @@ bool btrfs_repair_one_zone(struct btrfs_fs_info *fs_info, u64 logical)
 		return true;
 
 	spin_lock(&cache->lock);
-	if (cache->relocating_repair) {
+	if (test_and_set_bit(BLOCK_GROUP_FLAG_RELOCATING_REPAIR,
+			     &cache->runtime_flags)) {
 		spin_unlock(&cache->lock);
 		btrfs_put_block_group(cache);
 		return true;
 	}
-	cache->relocating_repair = 1;
 	spin_unlock(&cache->lock);
 
 	kthread_run(relocating_repair_kthread, cache,
diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index 9deb7bf417ca..cb8a70643885 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -1442,7 +1442,9 @@ int btrfs_load_block_group_zone_info(struct btrfs_block_group *cache, bool new)
 		}
 		cache->alloc_offset = alloc_offsets[0];
 		cache->zone_capacity = caps[0];
-		cache->zone_is_active = test_bit(0, active);
+		if (test_bit(0, active))
+			set_bit(BLOCK_GROUP_FLAG_ZONE_IS_ACTIVE,
+				&cache->runtime_flags);
 		break;
 	case BTRFS_BLOCK_GROUP_DUP:
 		if (map->type & BTRFS_BLOCK_GROUP_DATA) {
@@ -1476,7 +1478,9 @@ int btrfs_load_block_group_zone_info(struct btrfs_block_group *cache, bool new)
 				goto out;
 			}
 		} else {
-			cache->zone_is_active = test_bit(0, active);
+			if (test_bit(0, active))
+				set_bit(BLOCK_GROUP_FLAG_ZONE_IS_ACTIVE,
+					&cache->runtime_flags);
 		}
 		cache->alloc_offset = alloc_offsets[0];
 		cache->zone_capacity = min(caps[0], caps[1]);
@@ -1494,7 +1498,7 @@ int btrfs_load_block_group_zone_info(struct btrfs_block_group *cache, bool new)
 		goto out;
 	}
 
-	if (cache->zone_is_active) {
+	if (test_bit(BLOCK_GROUP_FLAG_ZONE_IS_ACTIVE, &cache->runtime_flags)) {
 		btrfs_get_block_group(cache);
 		spin_lock(&fs_info->zone_active_bgs_lock);
 		list_add_tail(&cache->active_bg_list, &fs_info->zone_active_bgs);
@@ -1862,7 +1866,8 @@ bool btrfs_zone_activate(struct btrfs_block_group *block_group)
 
 	spin_lock(&space_info->lock);
 	spin_lock(&block_group->lock);
-	if (block_group->zone_is_active) {
+	if (test_bit(BLOCK_GROUP_FLAG_ZONE_IS_ACTIVE,
+		     &block_group->runtime_flags)) {
 		ret = true;
 		goto out_unlock;
 	}
@@ -1888,8 +1893,7 @@ bool btrfs_zone_activate(struct btrfs_block_group *block_group)
 	}
 
 	/* Successfully activated all the zones */
-	block_group->zone_is_active = 1;
-	space_info->active_total_bytes += block_group->length;
+	set_bit(BLOCK_GROUP_FLAG_ZONE_IS_ACTIVE, &block_group->runtime_flags);
 	spin_unlock(&block_group->lock);
 	btrfs_try_granting_tickets(fs_info, space_info);
 	spin_unlock(&space_info->lock);
@@ -1917,7 +1921,8 @@ static int do_zone_finish(struct btrfs_block_group *block_group, bool fully_writ
 	int i;
 
 	spin_lock(&block_group->lock);
-	if (!block_group->zone_is_active) {
+	if (!test_bit(BLOCK_GROUP_FLAG_ZONE_IS_ACTIVE,
+		      &block_group->runtime_flags)) {
 		spin_unlock(&block_group->lock);
 		return 0;
 	}
@@ -1956,7 +1961,8 @@ static int do_zone_finish(struct btrfs_block_group *block_group, bool fully_writ
 		 * Bail out if someone already deactivated the block group, or
 		 * allocated space is left in the block group.
 		 */
-		if (!block_group->zone_is_active) {
+		if (!test_bit(BLOCK_GROUP_FLAG_ZONE_IS_ACTIVE,
+			      &block_group->runtime_flags)) {
 			spin_unlock(&block_group->lock);
 			btrfs_dec_block_group_ro(block_group);
 			return 0;
@@ -1969,7 +1975,7 @@ static int do_zone_finish(struct btrfs_block_group *block_group, bool fully_writ
 		}
 	}
 
-	block_group->zone_is_active = 0;
+	clear_bit(BLOCK_GROUP_FLAG_ZONE_IS_ACTIVE, &block_group->runtime_flags);
 	block_group->alloc_offset = block_group->zone_capacity;
 	block_group->free_space_ctl->free_space = 0;
 	btrfs_clear_treelog_bg(block_group);
@@ -2178,13 +2184,15 @@ void btrfs_zoned_release_data_reloc_bg(struct btrfs_fs_info *fs_info, u64 logica
 	ASSERT(block_group && (block_group->flags & BTRFS_BLOCK_GROUP_DATA));
 
 	spin_lock(&block_group->lock);
-	if (!block_group->zoned_data_reloc_ongoing)
+	if (!test_bit(BLOCK_GROUP_FLAG_ZONED_DATA_RELOC,
+		      &block_group->runtime_flags))
 		goto out;
 
 	/* All relocation extents are written. */
 	if (block_group->start + block_group->alloc_offset == logical + length) {
 		/* Now, release this block group for further allocations. */
-		block_group->zoned_data_reloc_ongoing = 0;
+		clear_bit(BLOCK_GROUP_FLAG_ZONED_DATA_RELOC,
+			  &block_group->runtime_flags);
 	}
 
 out:
@@ -2256,7 +2264,9 @@ int btrfs_zoned_activate_one_bg(struct btrfs_fs_info *fs_info,
 					    list) {
 				if (!spin_trylock(&bg->lock))
 					continue;
-				if (btrfs_zoned_bg_is_full(bg) || bg->zone_is_active) {
+				if (btrfs_zoned_bg_is_full(bg) ||
+				    test_bit(BLOCK_GROUP_FLAG_ZONE_IS_ACTIVE,
+					     &bg->runtime_flags)) {
 					spin_unlock(&bg->lock);
 					continue;
 				}
-- 
2.26.3

