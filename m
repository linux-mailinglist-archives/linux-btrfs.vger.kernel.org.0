Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 640164DA62
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Jun 2019 21:38:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726866AbfFTTit (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 20 Jun 2019 15:38:49 -0400
Received: from mail-yw1-f68.google.com ([209.85.161.68]:38815 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726822AbfFTTis (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 20 Jun 2019 15:38:48 -0400
Received: by mail-yw1-f68.google.com with SMTP id k125so1676015ywe.5
        for <linux-btrfs@vger.kernel.org>; Thu, 20 Jun 2019 12:38:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=x2vinYXuKIwb5OIqYMrn/GVlP/6Wr/VmJ4OH36sqdKc=;
        b=gWQuPIrpdzFYsNTcVVc+kmj3xllLcn//QhKKZyyjg+WJpdPlLjypYr7ozxAK6nj2P9
         c9leR24/4carQOHetvlZDu79AL3nHNli/4eJEUyWd6xRFe40cn+nT0Gyb4+xPBlto5mk
         BwvmXgZ3QKcg4DOG+g3w0vB3Zc7t6b8odJPLmp4Mj1ZKrYyTXfFPoF61B6OitFSduZiD
         RiD0fh0K7T1m6CfQsNbOIpiP0Tq8UJY/oFgqaueXvR9YhNUjgo/RDBr8uKJy3KlP47zN
         cSpP2V4uHy0prJUKVX2sO8y+nH3KMFaaaCEslK41J/JXYtMFrdBFr96Rli5N6RxZLfrE
         WvzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=x2vinYXuKIwb5OIqYMrn/GVlP/6Wr/VmJ4OH36sqdKc=;
        b=Peza0tbdhHeu0vTZL+cRuNQscM7I2wbYqvk8GAqmoLWmb962iAjSEUqRc30oA6Gmo7
         kI9fqyTto1WLPo6/X0YvZyBpj+bkPxyIQ8PuAyI7dChvwxV7ToMlzre2+lOoOQ9q88K6
         fdIOomyQ8NmeKndzTWPlfzuQytZ+ilmgFgKXQ0FPrUkFkMKub5NlAifKqA5iuHnR8Jy8
         c7nwYRpk4BmAxldXrIFymgPMEdG0FUXSx5zlOVcM24U4mhyk3bmekCh1foeH/S81DcZt
         7Hk9epSr1FrdAcWD+r8eBT4QpwN+tpTtTVUe/PDMvE3rjuEmscVYz5OJAL11BVw5Nh0W
         CEPA==
X-Gm-Message-State: APjAAAWXlLkHkaovxPcSe/A0UA3ib3Htj3SVhkBNOueZExRJmzc7ZQoE
        oQuCE/X5V0W19TJhL8uHhdOXilAECVrYgw==
X-Google-Smtp-Source: APXvYqzb+bDKG3EtGPC7E8Gf5O8i0fy6l2im1BS5mjOlW1NoZggd5b1RD61fk4ZTLwEWq/Ej5jzcsg==
X-Received: by 2002:a0d:db51:: with SMTP id d78mr10712738ywe.500.1561059526817;
        Thu, 20 Jun 2019 12:38:46 -0700 (PDT)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id g10sm111692ywa.9.2019.06.20.12.38.46
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 20 Jun 2019 12:38:46 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 23/25] btrfs: migrate the alloc_profile helpers
Date:   Thu, 20 Jun 2019 15:38:05 -0400
Message-Id: <20190620193807.29311-24-josef@toxicpanda.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20190620193807.29311-1-josef@toxicpanda.com>
References: <20190620193807.29311-1-josef@toxicpanda.com>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

These feel more at home in block-group.c.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/block-group.c | 100 ++++++++++++++++++++++++++++++++++++++++++
 fs/btrfs/block-group.h |  16 +++++++
 fs/btrfs/ctree.h       |   4 --
 fs/btrfs/extent-tree.c | 115 -------------------------------------------------
 4 files changed, 116 insertions(+), 119 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 942763738457..579073ec62c3 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -17,6 +17,106 @@
 #include "delalloc-space.h"
 #include "math.h"
 
+/*
+ * returns target flags in extended format or 0 if restripe for this
+ * chunk_type is not in progress
+ *
+ * should be called with balance_lock held
+ */
+u64 btrfs_get_restripe_target(struct btrfs_fs_info *fs_info, u64 flags)
+{
+	struct btrfs_balance_control *bctl = fs_info->balance_ctl;
+	u64 target = 0;
+
+	if (!bctl)
+		return 0;
+
+	if (flags & BTRFS_BLOCK_GROUP_DATA &&
+	    bctl->data.flags & BTRFS_BALANCE_ARGS_CONVERT) {
+		target = BTRFS_BLOCK_GROUP_DATA | bctl->data.target;
+	} else if (flags & BTRFS_BLOCK_GROUP_SYSTEM &&
+		   bctl->sys.flags & BTRFS_BALANCE_ARGS_CONVERT) {
+		target = BTRFS_BLOCK_GROUP_SYSTEM | bctl->sys.target;
+	} else if (flags & BTRFS_BLOCK_GROUP_METADATA &&
+		   bctl->meta.flags & BTRFS_BALANCE_ARGS_CONVERT) {
+		target = BTRFS_BLOCK_GROUP_METADATA | bctl->meta.target;
+	}
+
+	return target;
+}
+
+/*
+ * @flags: available profiles in extended format (see ctree.h)
+ *
+ * Returns reduced profile in chunk format.  If profile changing is in
+ * progress (either running or paused) picks the target profile (if it's
+ * already available), otherwise falls back to plain reducing.
+ */
+static u64 btrfs_reduce_alloc_profile(struct btrfs_fs_info *fs_info, u64 flags)
+{
+	u64 num_devices = fs_info->fs_devices->rw_devices;
+	u64 target;
+	u64 raid_type;
+	u64 allowed = 0;
+
+	/*
+	 * see if restripe for this chunk_type is in progress, if so
+	 * try to reduce to the target profile
+	 */
+	spin_lock(&fs_info->balance_lock);
+	target = btrfs_get_restripe_target(fs_info, flags);
+	if (target) {
+		/* pick target profile only if it's already available */
+		if ((flags & target) & BTRFS_EXTENDED_PROFILE_MASK) {
+			spin_unlock(&fs_info->balance_lock);
+			return extended_to_chunk(target);
+		}
+	}
+	spin_unlock(&fs_info->balance_lock);
+
+	/* First, mask out the RAID levels which aren't possible */
+	for (raid_type = 0; raid_type < BTRFS_NR_RAID_TYPES; raid_type++) {
+		if (num_devices >= btrfs_raid_array[raid_type].devs_min)
+			allowed |= btrfs_raid_array[raid_type].bg_flag;
+	}
+	allowed &= flags;
+
+	if (allowed & BTRFS_BLOCK_GROUP_RAID6)
+		allowed = BTRFS_BLOCK_GROUP_RAID6;
+	else if (allowed & BTRFS_BLOCK_GROUP_RAID5)
+		allowed = BTRFS_BLOCK_GROUP_RAID5;
+	else if (allowed & BTRFS_BLOCK_GROUP_RAID10)
+		allowed = BTRFS_BLOCK_GROUP_RAID10;
+	else if (allowed & BTRFS_BLOCK_GROUP_RAID1)
+		allowed = BTRFS_BLOCK_GROUP_RAID1;
+	else if (allowed & BTRFS_BLOCK_GROUP_RAID0)
+		allowed = BTRFS_BLOCK_GROUP_RAID0;
+
+	flags &= ~BTRFS_BLOCK_GROUP_PROFILE_MASK;
+
+	return extended_to_chunk(flags | allowed);
+}
+
+u64 btrfs_get_alloc_profile(struct btrfs_fs_info *fs_info, u64 orig_flags)
+{
+	unsigned seq;
+	u64 flags;
+
+	do {
+		flags = orig_flags;
+		seq = read_seqbegin(&fs_info->profiles_lock);
+
+		if (flags & BTRFS_BLOCK_GROUP_DATA)
+			flags |= fs_info->avail_data_alloc_bits;
+		else if (flags & BTRFS_BLOCK_GROUP_SYSTEM)
+			flags |= fs_info->avail_system_alloc_bits;
+		else if (flags & BTRFS_BLOCK_GROUP_METADATA)
+			flags |= fs_info->avail_metadata_alloc_bits;
+	} while (read_seqretry(&fs_info->profiles_lock, seq));
+
+	return btrfs_reduce_alloc_profile(fs_info, flags);
+}
+
 void btrfs_get_block_group(struct btrfs_block_group_cache *cache)
 {
 	atomic_inc(&cache->count);
diff --git a/fs/btrfs/block-group.h b/fs/btrfs/block-group.h
index ee34d4e9d0b7..9f6ddb5c9fef 100644
--- a/fs/btrfs/block-group.h
+++ b/fs/btrfs/block-group.h
@@ -227,6 +227,22 @@ int btrfs_chunk_alloc(struct btrfs_trans_handle *trans, u64 flags,
 		      enum btrfs_chunk_alloc_enum force);
 int btrfs_force_chunk_alloc(struct btrfs_trans_handle *trans, u64 type);
 void check_system_chunk(struct btrfs_trans_handle *trans, const u64 type);
+u64 btrfs_get_alloc_profile(struct btrfs_fs_info *fs_info, u64 orig_flags);
+
+static inline u64 btrfs_data_alloc_profile(struct btrfs_fs_info *fs_info)
+{
+	return btrfs_get_alloc_profile(fs_info, BTRFS_BLOCK_GROUP_DATA);
+}
+
+static inline u64 btrfs_metadata_alloc_profile(struct btrfs_fs_info *fs_info)
+{
+	return btrfs_get_alloc_profile(fs_info, BTRFS_BLOCK_GROUP_METADATA);
+}
+
+static inline u64 btrfs_system_alloc_profile(struct btrfs_fs_info *fs_info)
+{
+	return btrfs_get_alloc_profile(fs_info, BTRFS_BLOCK_GROUP_SYSTEM);
+}
 
 static inline int
 btrfs_block_group_cache_done(struct btrfs_block_group_cache *cache)
diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 1cf7f47484b6..1d1872e93996 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -2463,7 +2463,6 @@ static inline u64 btrfs_calc_trunc_metadata_size(struct btrfs_fs_info *fs_info,
 int btrfs_add_excluded_extent(struct btrfs_fs_info *fs_info,
 			      u64 start, u64 num_bytes);
 void btrfs_free_excluded_extents(struct btrfs_block_group_cache *cache);
-u64 btrfs_get_alloc_profile(struct btrfs_fs_info *fs_info, u64 orig_flags);
 int btrfs_run_delayed_refs(struct btrfs_trans_handle *trans,
 			   unsigned long count);
 void btrfs_cleanup_ref_head_accounting(struct btrfs_fs_info *fs_info,
@@ -2523,9 +2522,6 @@ int btrfs_free_block_groups(struct btrfs_fs_info *info);
 void btrfs_add_raid_kobjects(struct btrfs_fs_info *fs_info);
 void btrfs_get_block_group_trimming(struct btrfs_block_group_cache *cache);
 void btrfs_put_block_group_trimming(struct btrfs_block_group_cache *cache);
-u64 btrfs_data_alloc_profile(struct btrfs_fs_info *fs_info);
-u64 btrfs_metadata_alloc_profile(struct btrfs_fs_info *fs_info);
-u64 btrfs_system_alloc_profile(struct btrfs_fs_info *fs_info);
 void btrfs_clear_space_info_full(struct btrfs_fs_info *info);
 
 enum btrfs_reserve_flush_enum {
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 70f6d5fce42e..53b164964b3b 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -2524,106 +2524,6 @@ int btrfs_extent_readonly(struct btrfs_fs_info *fs_info, u64 bytenr)
 	return readonly;
 }
 
-/*
- * returns target flags in extended format or 0 if restripe for this
- * chunk_type is not in progress
- *
- * should be called with balance_lock held
- */
-u64 btrfs_get_restripe_target(struct btrfs_fs_info *fs_info, u64 flags)
-{
-	struct btrfs_balance_control *bctl = fs_info->balance_ctl;
-	u64 target = 0;
-
-	if (!bctl)
-		return 0;
-
-	if (flags & BTRFS_BLOCK_GROUP_DATA &&
-	    bctl->data.flags & BTRFS_BALANCE_ARGS_CONVERT) {
-		target = BTRFS_BLOCK_GROUP_DATA | bctl->data.target;
-	} else if (flags & BTRFS_BLOCK_GROUP_SYSTEM &&
-		   bctl->sys.flags & BTRFS_BALANCE_ARGS_CONVERT) {
-		target = BTRFS_BLOCK_GROUP_SYSTEM | bctl->sys.target;
-	} else if (flags & BTRFS_BLOCK_GROUP_METADATA &&
-		   bctl->meta.flags & BTRFS_BALANCE_ARGS_CONVERT) {
-		target = BTRFS_BLOCK_GROUP_METADATA | bctl->meta.target;
-	}
-
-	return target;
-}
-
-/*
- * @flags: available profiles in extended format (see ctree.h)
- *
- * Returns reduced profile in chunk format.  If profile changing is in
- * progress (either running or paused) picks the target profile (if it's
- * already available), otherwise falls back to plain reducing.
- */
-static u64 btrfs_reduce_alloc_profile(struct btrfs_fs_info *fs_info, u64 flags)
-{
-	u64 num_devices = fs_info->fs_devices->rw_devices;
-	u64 target;
-	u64 raid_type;
-	u64 allowed = 0;
-
-	/*
-	 * see if restripe for this chunk_type is in progress, if so
-	 * try to reduce to the target profile
-	 */
-	spin_lock(&fs_info->balance_lock);
-	target = btrfs_get_restripe_target(fs_info, flags);
-	if (target) {
-		/* pick target profile only if it's already available */
-		if ((flags & target) & BTRFS_EXTENDED_PROFILE_MASK) {
-			spin_unlock(&fs_info->balance_lock);
-			return extended_to_chunk(target);
-		}
-	}
-	spin_unlock(&fs_info->balance_lock);
-
-	/* First, mask out the RAID levels which aren't possible */
-	for (raid_type = 0; raid_type < BTRFS_NR_RAID_TYPES; raid_type++) {
-		if (num_devices >= btrfs_raid_array[raid_type].devs_min)
-			allowed |= btrfs_raid_array[raid_type].bg_flag;
-	}
-	allowed &= flags;
-
-	if (allowed & BTRFS_BLOCK_GROUP_RAID6)
-		allowed = BTRFS_BLOCK_GROUP_RAID6;
-	else if (allowed & BTRFS_BLOCK_GROUP_RAID5)
-		allowed = BTRFS_BLOCK_GROUP_RAID5;
-	else if (allowed & BTRFS_BLOCK_GROUP_RAID10)
-		allowed = BTRFS_BLOCK_GROUP_RAID10;
-	else if (allowed & BTRFS_BLOCK_GROUP_RAID1)
-		allowed = BTRFS_BLOCK_GROUP_RAID1;
-	else if (allowed & BTRFS_BLOCK_GROUP_RAID0)
-		allowed = BTRFS_BLOCK_GROUP_RAID0;
-
-	flags &= ~BTRFS_BLOCK_GROUP_PROFILE_MASK;
-
-	return extended_to_chunk(flags | allowed);
-}
-
-u64 btrfs_get_alloc_profile(struct btrfs_fs_info *fs_info, u64 orig_flags)
-{
-	unsigned seq;
-	u64 flags;
-
-	do {
-		flags = orig_flags;
-		seq = read_seqbegin(&fs_info->profiles_lock);
-
-		if (flags & BTRFS_BLOCK_GROUP_DATA)
-			flags |= fs_info->avail_data_alloc_bits;
-		else if (flags & BTRFS_BLOCK_GROUP_SYSTEM)
-			flags |= fs_info->avail_system_alloc_bits;
-		else if (flags & BTRFS_BLOCK_GROUP_METADATA)
-			flags |= fs_info->avail_metadata_alloc_bits;
-	} while (read_seqretry(&fs_info->profiles_lock, seq));
-
-	return btrfs_reduce_alloc_profile(fs_info, flags);
-}
-
 static u64 get_alloc_profile_by_root(struct btrfs_root *root, int data)
 {
 	struct btrfs_fs_info *fs_info = root->fs_info;
@@ -2641,21 +2541,6 @@ static u64 get_alloc_profile_by_root(struct btrfs_root *root, int data)
 	return ret;
 }
 
-u64 btrfs_data_alloc_profile(struct btrfs_fs_info *fs_info)
-{
-	return btrfs_get_alloc_profile(fs_info, BTRFS_BLOCK_GROUP_DATA);
-}
-
-u64 btrfs_metadata_alloc_profile(struct btrfs_fs_info *fs_info)
-{
-	return btrfs_get_alloc_profile(fs_info, BTRFS_BLOCK_GROUP_METADATA);
-}
-
-u64 btrfs_system_alloc_profile(struct btrfs_fs_info *fs_info)
-{
-	return btrfs_get_alloc_profile(fs_info, BTRFS_BLOCK_GROUP_SYSTEM);
-}
-
 static u64 first_logical_byte(struct btrfs_fs_info *fs_info, u64 search_start)
 {
 	struct btrfs_block_group_cache *cache;
-- 
2.14.3

