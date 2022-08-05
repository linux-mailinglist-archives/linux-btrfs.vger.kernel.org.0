Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2670D58AC3F
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Aug 2022 16:15:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240915AbiHEOPQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 5 Aug 2022 10:15:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240906AbiHEOPN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 5 Aug 2022 10:15:13 -0400
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00AB65B7A1
        for <linux-btrfs@vger.kernel.org>; Fri,  5 Aug 2022 07:15:08 -0700 (PDT)
Received: by mail-qv1-xf32.google.com with SMTP id q3so1825909qvp.5
        for <linux-btrfs@vger.kernel.org>; Fri, 05 Aug 2022 07:15:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=X4wVgbe3qe1ltUu0nTkT2sbl8LKLkqfpzbqBfMqtmtM=;
        b=whpSBXhzQft/9Dz6NhSSYV+sqCA9yJ6e52WKDm+9DoHnZiolI5IV0ow3ljI4prO+Xi
         mnHCZjqUKOqSYuOQS+BTeTr20+HeaBfFboMAaz156n0d7LTwefvICrvyldvht4YKU4o8
         IHujEJN21mAm/iExiamxxnosHVccf+DM0qTSuH7l5j1lpLKSGozsjhJJFHmZYzhWfLTL
         RiJmr5r+JChm66adMxrAG7GIn4a/8stkuEMtiPEXLDqAfDMVvwi7TJ2Xs5dvEW9dhjb1
         f0/QCyXK99pVgfvXOi5S90Ivi4JXbvQj6AS4SmZO9swoITBrl+zE8ly1KGogrckstMra
         +RXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=X4wVgbe3qe1ltUu0nTkT2sbl8LKLkqfpzbqBfMqtmtM=;
        b=vWmDpGV6NWn0FBf+bJ5v94jt6l0E+O2068V2r70oAHXGSIn7aJqSyNQuS8YrvkyG4/
         ynDGNXk/NHthMFMVcblV6NK6cucXt+xy9GHsfrKy77TB8lp3GrhaNU2I4/UmpxSHFHn/
         Hqz+SRkcm5Xc101ZyQKyT1v9U0pYtEVq9Ca7iMUBpGRSaYqAiVLoiHKWSvOlNxBv+Nf0
         PFzkJo4sTzQo/88kMDQpqlrOsSrnnNHod3KNLsrRWFkbgm/kHXz7JWApCAd2AzNvO2kn
         ZZhtAHU9xSTXGxegllalzjDD3+O8PhhGMev8SqhNbd2gBy3MajU+6FISm1uUQO7nLgWl
         jxjw==
X-Gm-Message-State: ACgBeo3TcZsFZ38KpL9+z69t8cinnjYm+sdgBHG/DTWZjbJil7NJMMIq
        AoPFFcosbP1jDcJcJoTODrLadeqdfF2sSg==
X-Google-Smtp-Source: AA6agR5knR0/9x+pfKnkcqeVzApz+aR7lmWDYFKe5iQi6QlNu0CUVidlfgL4zzYnZ/gAvGRJcBX6KQ==
X-Received: by 2002:ad4:5967:0:b0:476:b16b:3b22 with SMTP id eq7-20020ad45967000000b00476b16b3b22mr5727892qvb.30.1659708907273;
        Fri, 05 Aug 2022 07:15:07 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id g18-20020a05620a40d200b006b5f9b7ac87sm3486288qko.26.2022.08.05.07.15.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Aug 2022 07:15:06 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v3 4/9] btrfs: convert block group bit field to use bit helpers
Date:   Fri,  5 Aug 2022 10:14:55 -0400
Message-Id: <6fd91db0572ea748ab9cd965d91dabdd8c1b5f35.1659708822.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1659708822.git.josef@toxicpanda.com>
References: <cover.1659708822.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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
index 5f062c5d3b6f..8fd54f4dd2de 100644
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
@@ -2426,7 +2431,8 @@ void btrfs_create_pending_block_groups(struct btrfs_trans_handle *trans)
 		ret = insert_block_group_item(trans, block_group);
 		if (ret)
 			btrfs_abort_transaction(trans, ret);
-		if (!block_group->chunk_item_inserted) {
+		if (!test_bit(BLOCK_GROUP_FLAG_CHUNK_ITEM_INSERTED,
+			      &block_group->runtime_flags)) {
 			mutex_lock(&fs_info->chunk_mutex);
 			ret = btrfs_chunk_alloc_add_chunk_item(trans, block_group);
 			mutex_unlock(&fs_info->chunk_mutex);
@@ -3972,7 +3978,8 @@ void btrfs_put_block_group_cache(struct btrfs_fs_info *info)
 		while (block_group) {
 			btrfs_wait_block_group_cache_done(block_group);
 			spin_lock(&block_group->lock);
-			if (block_group->iref)
+			if (test_bit(BLOCK_GROUP_FLAG_IREF,
+				     &block_group->runtime_flags))
 				break;
 			spin_unlock(&block_group->lock);
 			block_group = btrfs_next_block_group(block_group);
@@ -3985,7 +3992,7 @@ void btrfs_put_block_group_cache(struct btrfs_fs_info *info)
 		}
 
 		inode = block_group->inode;
-		block_group->iref = 0;
+		clear_bit(BLOCK_GROUP_FLAG_IREF, &block_group->runtime_flags);
 		block_group->inode = NULL;
 		spin_unlock(&block_group->lock);
 		ASSERT(block_group->io_ctl.inode == NULL);
@@ -4127,7 +4134,7 @@ void btrfs_unfreeze_block_group(struct btrfs_block_group *block_group)
 
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
index ea3ec1e761e8..fbf10cd0155e 100644
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
index 22bfc7806ccb..4de09c730d3c 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -5592,7 +5592,7 @@ int btrfs_chunk_alloc_add_chunk_item(struct btrfs_trans_handle *trans,
 	if (ret)
 		goto out;
 
-	bg->chunk_item_inserted = 1;
+	set_bit(BLOCK_GROUP_FLAG_CHUNK_ITEM_INSERTED, &bg->runtime_flags);
 
 	if (map->type & BTRFS_BLOCK_GROUP_SYSTEM) {
 		ret = btrfs_add_system_chunk(fs_info, &key, chunk, item_size);
@@ -6151,7 +6151,7 @@ static bool is_block_group_to_copy(struct btrfs_fs_info *fs_info, u64 logical)
 	cache = btrfs_lookup_block_group(fs_info, logical);
 
 	spin_lock(&cache->lock);
-	ret = cache->to_copy;
+	ret = test_bit(BLOCK_GROUP_FLAG_TO_COPY, &cache->runtime_flags);
 	spin_unlock(&cache->lock);
 
 	btrfs_put_block_group(cache);
@@ -8241,7 +8241,8 @@ static int relocating_repair_kthread(void *data)
 	if (!cache)
 		goto out;
 
-	if (!cache->relocating_repair)
+	if (!test_bit(BLOCK_GROUP_FLAG_RELOCATING_REPAIR,
+		      &cache->runtime_flags))
 		goto out;
 
 	ret = btrfs_may_alloc_data_chunk(fs_info, target);
@@ -8279,12 +8280,12 @@ bool btrfs_repair_one_zone(struct btrfs_fs_info *fs_info, u64 logical)
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
index b150b07ba1a7..dd2704bee6b4 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -1443,7 +1443,9 @@ int btrfs_load_block_group_zone_info(struct btrfs_block_group *cache, bool new)
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
@@ -1477,7 +1479,9 @@ int btrfs_load_block_group_zone_info(struct btrfs_block_group *cache, bool new)
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
@@ -1495,7 +1499,7 @@ int btrfs_load_block_group_zone_info(struct btrfs_block_group *cache, bool new)
 		goto out;
 	}
 
-	if (cache->zone_is_active) {
+	if (test_bit(BLOCK_GROUP_FLAG_ZONE_IS_ACTIVE, &cache->runtime_flags)) {
 		btrfs_get_block_group(cache);
 		spin_lock(&fs_info->zone_active_bgs_lock);
 		list_add_tail(&cache->active_bg_list, &fs_info->zone_active_bgs);
@@ -1863,7 +1867,8 @@ bool btrfs_zone_activate(struct btrfs_block_group *block_group)
 
 	spin_lock(&space_info->lock);
 	spin_lock(&block_group->lock);
-	if (block_group->zone_is_active) {
+	if (test_bit(BLOCK_GROUP_FLAG_ZONE_IS_ACTIVE,
+		     &block_group->runtime_flags)) {
 		ret = true;
 		goto out_unlock;
 	}
@@ -1889,8 +1894,7 @@ bool btrfs_zone_activate(struct btrfs_block_group *block_group)
 	}
 
 	/* Successfully activated all the zones */
-	block_group->zone_is_active = 1;
-	space_info->active_total_bytes += block_group->length;
+	set_bit(BLOCK_GROUP_FLAG_ZONE_IS_ACTIVE, &block_group->runtime_flags);
 	spin_unlock(&block_group->lock);
 	btrfs_try_granting_tickets(fs_info, space_info);
 	spin_unlock(&space_info->lock);
@@ -1918,7 +1922,8 @@ static int do_zone_finish(struct btrfs_block_group *block_group, bool fully_writ
 	int i;
 
 	spin_lock(&block_group->lock);
-	if (!block_group->zone_is_active) {
+	if (!test_bit(BLOCK_GROUP_FLAG_ZONE_IS_ACTIVE,
+		      &block_group->runtime_flags)) {
 		spin_unlock(&block_group->lock);
 		return 0;
 	}
@@ -1957,7 +1962,8 @@ static int do_zone_finish(struct btrfs_block_group *block_group, bool fully_writ
 		 * Bail out if someone already deactivated the block group, or
 		 * allocated space is left in the block group.
 		 */
-		if (!block_group->zone_is_active) {
+		if (!test_bit(BLOCK_GROUP_FLAG_ZONE_IS_ACTIVE,
+			      &block_group->runtime_flags)) {
 			spin_unlock(&block_group->lock);
 			btrfs_dec_block_group_ro(block_group);
 			return 0;
@@ -1970,7 +1976,7 @@ static int do_zone_finish(struct btrfs_block_group *block_group, bool fully_writ
 		}
 	}
 
-	block_group->zone_is_active = 0;
+	clear_bit(BLOCK_GROUP_FLAG_ZONE_IS_ACTIVE, &block_group->runtime_flags);
 	block_group->alloc_offset = block_group->zone_capacity;
 	block_group->free_space_ctl->free_space = 0;
 	btrfs_clear_treelog_bg(block_group);
@@ -2179,13 +2185,15 @@ void btrfs_zoned_release_data_reloc_bg(struct btrfs_fs_info *fs_info, u64 logica
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
@@ -2257,7 +2265,9 @@ int btrfs_zoned_activate_one_bg(struct btrfs_fs_info *fs_info,
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

