Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B2BB6A75FE
	for <lists+linux-btrfs@lfdr.de>; Wed,  1 Mar 2023 22:14:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229595AbjCAVO4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 1 Mar 2023 16:14:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229737AbjCAVOy (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 1 Mar 2023 16:14:54 -0500
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3617A4615E
        for <linux-btrfs@vger.kernel.org>; Wed,  1 Mar 2023 13:14:52 -0800 (PST)
Received: by mail-qt1-x835.google.com with SMTP id ay9so15916630qtb.9
        for <linux-btrfs@vger.kernel.org>; Wed, 01 Mar 2023 13:14:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112; t=1677705291;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dwFZmhYcR45bZRfzwQ/cmY8RFpr5Rz2JVt8NJOyjcHw=;
        b=TZUHxTBBB6+p4rIrJdAhxjxkSMeUnhUqH0QluXxj/tqVbduP8wpOK8ATNaNBqe+jqn
         SkXNmnOONY1gT3GYp8uLGl1I0SPxgL9sdq7UYbwjZpHoj9He1DIoyVioPDymCsBcsbi7
         l8kYjqybfuV3jxEJNYbOc3Zqr+UnH6XMzzYiSYXNcL9kLkm088YTlwyDqXBYYsgZ1VP2
         2K9ko4PDff+cdiB79KS5TwzqC+fkfnUmKRAnWVO7nWG5gCsftWDmtqQ+k121GVL5TyeQ
         glXNwYH6oF19LyRV+P1T91LuM18pUSr8Z8XBYPirNlbDdUk4xF7IImcpuNUJtSSYh6Fb
         yfVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677705291;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dwFZmhYcR45bZRfzwQ/cmY8RFpr5Rz2JVt8NJOyjcHw=;
        b=Xf+3AzGDme2TgLheLNldiO44CeP4D7fAG2DRJ1PBYylRKvYq+ZVa0s1QKmnlueIYGR
         nJDLvBPoviZ/hwVN5ySIIwXsSDEzPy0YMdKaAQe8jnru2KhL1Jz+95m+nDVEnnPVDAQa
         zMouMSlmGMkZbApof0UHgBKwoBTAyhr4FiZihA/q+vWrThc63ereK6bcyWfzvpU1oDqI
         KgzeO0tSQfOhM93GC9JmaGqzzSO+88m2sdzHAAg1t0vhKmYodM1AnzQILE96R3uMaUNu
         gGZ36YvrnFBR7tEXzJ4b/FVkU9HJpx9ALyKPtv+Twp51kSlh3rxbdjYB02SWLK3bAnBs
         75GQ==
X-Gm-Message-State: AO0yUKVOPkrcW3AEGF7MGjLfWen9pFVWwmmFZfhEVIZ5ziWdQ0QkggJG
        WcZEGa8JiG8xmRKSyoz6IL469Qpsrsc6GQjtl3Y=
X-Google-Smtp-Source: AK7set/B+dkpvLufyqDpEUpU4Ls6HLJMsFmCgz3nhPjZiE7anCbk7CGhxICU85RuY6lXmLqEpWi5Uw==
X-Received: by 2002:a05:622a:1053:b0:3bf:c1ba:4fcd with SMTP id f19-20020a05622a105300b003bfc1ba4fcdmr14407667qte.64.1677705290804;
        Wed, 01 Mar 2023 13:14:50 -0800 (PST)
Received: from localhost (cpe-174-109-170-245.nc.res.rr.com. [174.109.170.245])
        by smtp.gmail.com with ESMTPSA id a4-20020a05622a02c400b003b323387c1asm9047950qtx.18.2023.03.01.13.14.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Mar 2023 13:14:50 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 3/3] btrfs: handle active zone accounting properly
Date:   Wed,  1 Mar 2023 16:14:44 -0500
Message-Id: <ed93f2d59affd91bf2d0582b70c16d93341600e4.1677705092.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1677705092.git.josef@toxicpanda.com>
References: <cover.1677705092.git.josef@toxicpanda.com>
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

Running xfstests on my ZNS drives uncovered a problem where I was
allocating the entire device with metadata block groups.  The root cause
of this was we would get ENOSPC on mount, and while trying to satisfy
tickets we'd allocate more block groups.

The reason we were getting ENOSPC was because ->bytes_zone_unusable was
set to 40gib, but ->active_total_bytes was set to 8gib, which was the
maximum number of active block groups we're allowed to have at one time.
This was because we always update ->bytes_zone_unusable with the
unusable amount from every block group, but we only update
->active_total_bytes with the active block groups.

This is actually much worse however, because we could potentially have
other counters potentially well above the ->active_total_bytes, which
would lead to this early enospc situation.

Fix this by mirroring the counters for active block groups into their
own counters.  This allows us to keep the full space_info counters
consistent, which is needed for things like sysfs and the space info
ioctl, and then track the actual usage for ENOSPC reasons for only the
active block groups.

Additionally, when de-activating we weren't properly updating the
->active_total_bytes, which could lead to other problems.  Unifying all
of this with the proper helpers will make sure our accounting is
correct.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/block-group.c | 29 +++++++++++++--
 fs/btrfs/disk-io.c     |  6 +++
 fs/btrfs/extent-tree.c | 13 +++++++
 fs/btrfs/space-info.c  | 83 ++++++++++++++++++++++++++++++++++++++++--
 fs/btrfs/space-info.h  | 20 +++++++++-
 fs/btrfs/zoned.c       | 14 +++++--
 6 files changed, 152 insertions(+), 13 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 3eff0b35e139..7d5b73b2689e 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -1166,6 +1166,9 @@ int btrfs_remove_block_group(struct btrfs_trans_handle *trans,
 		btrfs_put_caching_control(caching_ctl);
 	}
 
+	ASSERT(!test_bit(BLOCK_GROUP_FLAG_ZONE_IS_ACTIVE,
+			 &block_group->runtime_flags));
+
 	spin_lock(&trans->transaction->dirty_bgs_lock);
 	WARN_ON(!list_empty(&block_group->dirty_list));
 	WARN_ON(!list_empty(&block_group->io_list));
@@ -1191,12 +1194,8 @@ int btrfs_remove_block_group(struct btrfs_trans_handle *trans,
 			< block_group->length);
 	}
 	block_group->space_info->total_bytes -= block_group->length;
-	if (test_bit(BLOCK_GROUP_FLAG_ZONE_IS_ACTIVE, &block_group->runtime_flags))
-		block_group->space_info->active_total_bytes -= block_group->length;
 	block_group->space_info->bytes_readonly -=
 		(block_group->length - block_group->zone_unusable);
-	block_group->space_info->bytes_zone_unusable -=
-		block_group->zone_unusable;
 	block_group->space_info->disk_total -= block_group->length * factor;
 
 	spin_unlock(&block_group->space_info->lock);
@@ -1377,10 +1376,14 @@ static int inc_block_group_ro(struct btrfs_block_group *cache, int force)
 
 	if (!ret) {
 		sinfo->bytes_readonly += num_bytes;
+		ASSERT(!test_bit(BLOCK_GROUP_FLAG_ZONE_IS_ACTIVE,
+				 &cache->runtime_flags));
+
 		if (btrfs_is_zoned(cache->fs_info)) {
 			/* Migrate zone_unusable bytes to readonly */
 			sinfo->bytes_readonly += cache->zone_unusable;
 			sinfo->bytes_zone_unusable -= cache->zone_unusable;
+
 			cache->zone_unusable = 0;
 		}
 		cache->ro++;
@@ -1575,6 +1578,9 @@ void btrfs_delete_unused_bgs(struct btrfs_fs_info *fs_info)
 		}
 		spin_unlock(&fs_info->discard_ctl.lock);
 
+		ASSERT(!test_bit(BLOCK_GROUP_FLAG_ZONE_IS_ACTIVE,
+				 &block_group->runtime_flags));
+
 		/* Reset pinned so btrfs_put_block_group doesn't complain */
 		spin_lock(&space_info->lock);
 		spin_lock(&block_group->lock);
@@ -1582,6 +1588,7 @@ void btrfs_delete_unused_bgs(struct btrfs_fs_info *fs_info)
 		btrfs_space_info_update_bytes_pinned(fs_info, space_info,
 						     -block_group->pinned);
 		space_info->bytes_readonly += block_group->pinned;
+
 		block_group->pinned = 0;
 
 		spin_unlock(&block_group->lock);
@@ -2876,6 +2883,9 @@ void btrfs_dec_block_group_ro(struct btrfs_block_group *cache)
 
 	BUG_ON(!cache->ro);
 
+	ASSERT(!test_bit(BLOCK_GROUP_FLAG_ZONE_IS_ACTIVE,
+			 &cache->runtime_flags));
+
 	spin_lock(&sinfo->lock);
 	spin_lock(&cache->lock);
 	if (!--cache->ro) {
@@ -3513,6 +3523,11 @@ int btrfs_update_block_group(struct btrfs_trans_handle *trans,
 			space_info->bytes_reserved -= num_bytes;
 			space_info->bytes_used += num_bytes;
 			space_info->disk_used += num_bytes * factor;
+
+			if (test_bit(BLOCK_GROUP_FLAG_ZONE_IS_ACTIVE,
+				     &cache->runtime_flags))
+				space_info->active_bytes_used += num_bytes;
+
 			spin_unlock(&cache->lock);
 			spin_unlock(&space_info->lock);
 		} else {
@@ -3524,6 +3539,12 @@ int btrfs_update_block_group(struct btrfs_trans_handle *trans,
 			space_info->bytes_used -= num_bytes;
 			space_info->disk_used -= num_bytes * factor;
 
+			if (test_bit(BLOCK_GROUP_FLAG_ZONE_IS_ACTIVE,
+				     &cache->runtime_flags)) {
+				space_info->active_bytes_pinned += num_bytes;
+				space_info->active_bytes_used -= num_bytes;
+			}
+
 			reclaim = should_reclaim_block_group(cache, num_bytes);
 
 			spin_unlock(&cache->lock);
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index b53f0e30ce2b..4cec057f4358 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -4883,6 +4883,12 @@ static int btrfs_destroy_delayed_refs(struct btrfs_transaction *trans,
 				cache->space_info, head->num_bytes);
 			cache->reserved -= head->num_bytes;
 			cache->space_info->bytes_reserved -= head->num_bytes;
+
+			if (test_bit(BLOCK_GROUP_FLAG_ZONE_IS_ACTIVE,
+				     &cache->runtime_flags))
+				cache->space_info->active_bytes_pinned +=
+					head->num_bytes;
+
 			spin_unlock(&cache->lock);
 			spin_unlock(&cache->space_info->lock);
 
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 824c657f59e8..29fb3b2b7370 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -2530,6 +2530,11 @@ static int pin_down_extent(struct btrfs_trans_handle *trans,
 		cache->reserved -= num_bytes;
 		cache->space_info->bytes_reserved -= num_bytes;
 	}
+
+	if (test_bit(BLOCK_GROUP_FLAG_ZONE_IS_ACTIVE,
+		     &cache->runtime_flags))
+		cache->space_info->active_bytes_pinned += num_bytes;
+
 	spin_unlock(&cache->lock);
 	spin_unlock(&cache->space_info->lock);
 
@@ -2725,6 +2730,14 @@ static int unpin_extent_range(struct btrfs_fs_info *fs_info,
 		spin_lock(&cache->lock);
 		cache->pinned -= len;
 		btrfs_space_info_update_bytes_pinned(fs_info, space_info, -len);
+
+		if (test_bit(BLOCK_GROUP_FLAG_ZONE_IS_ACTIVE,
+			     &cache->runtime_flags)) {
+			ASSERT(!cache->ro);
+			space_info->active_bytes_zone_unusable += len;
+			space_info->active_bytes_pinned -= len;
+		}
+
 		space_info->max_extent_size = 0;
 		if (cache->ro) {
 			space_info->bytes_readonly += len;
diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index 2237685d1ed0..d9a8d8ba38d7 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -166,6 +166,14 @@ u64 __pure btrfs_space_info_used(struct btrfs_space_info *s_info,
 			  bool may_use_included)
 {
 	ASSERT(s_info);
+
+	if (s_info->active_total_bytes)
+		return s_info->bytes_reserved +
+			s_info->active_bytes_used +
+			s_info->active_bytes_pinned +
+			s_info->active_bytes_zone_unusable +
+			(may_use_included ? s_info->bytes_may_use : 0);
+
 	return s_info->bytes_used + s_info->bytes_reserved +
 		s_info->bytes_pinned + s_info->bytes_readonly +
 		s_info->bytes_zone_unusable +
@@ -296,6 +304,66 @@ int btrfs_init_space_info(struct btrfs_fs_info *fs_info)
 	return ret;
 }
 
+static void update_block_group_activation(struct btrfs_block_group *block_group,
+					  bool activate)
+{
+	struct btrfs_fs_info *fs_info = block_group->fs_info;
+	struct btrfs_space_info *space_info = block_group->space_info;
+
+	lockdep_assert_held(&space_info->lock);
+
+	if (!test_bit(BTRFS_FS_ACTIVE_ZONE_TRACKING, &fs_info->flags))
+		return;
+
+	if (!test_bit(BLOCK_GROUP_FLAG_ZONE_IS_ACTIVE,
+		      &block_group->runtime_flags))
+		return;
+
+	if (activate) {
+		space_info->active_total_bytes += block_group->length;
+		space_info->active_bytes_used += block_group->used;
+		space_info->active_bytes_pinned += block_group->pinned;
+		space_info->active_bytes_zone_unusable +=
+			block_group->zone_unusable;
+	} else {
+		space_info->active_total_bytes -= block_group->length;
+		space_info->active_bytes_used -= block_group->used;
+		space_info->active_bytes_pinned -= block_group->pinned;
+		space_info->active_bytes_zone_unusable -=
+			block_group->zone_unusable;
+	}
+}
+
+/*
+ * Set the block group as active and update the counters.
+ *
+ * @block_group: The block group we're activating.
+ *
+ * If we have BTRFS_FS_ACTIVE_ZONE_TRACKING, this will update
+ * ->active_* counters for the space_info and set
+ *  BLOCK_GROUP_FLAG_ZONE_IS_ACTIVE on the block group.
+ */
+void btrfs_activate_block_group(struct btrfs_block_group *block_group)
+{
+	set_bit(BLOCK_GROUP_FLAG_ZONE_IS_ACTIVE, &block_group->runtime_flags);
+	update_block_group_activation(block_group, true);
+}
+
+/*
+ * Deactivate the block group and update the counters.
+ *
+ * @block_group: The block group we're deactivating.
+ *
+ * If we have BTRFS_FS_ACTIVE_ZONE_TRACKING, this will update
+ * ->active_* counters for the space_info and clear
+ *  BLOCK_GROUP_FLAG_ZONE_IS_ACTIVE on the block group.
+ */
+void btrfs_deactivate_block_group(struct btrfs_block_group *block_group)
+{
+	update_block_group_activation(block_group, false);
+	clear_bit(BLOCK_GROUP_FLAG_ZONE_IS_ACTIVE, &block_group->runtime_flags);
+}
+
 void btrfs_add_bg_to_space_info(struct btrfs_fs_info *info,
 				struct btrfs_block_group *block_group)
 {
@@ -306,10 +374,10 @@ void btrfs_add_bg_to_space_info(struct btrfs_fs_info *info,
 
 	found = btrfs_find_space_info(info, block_group->flags);
 	ASSERT(found);
+	block_group->space_info = found;
+
 	spin_lock(&found->lock);
 	found->total_bytes += block_group->length;
-	if (test_bit(BLOCK_GROUP_FLAG_ZONE_IS_ACTIVE, &block_group->runtime_flags))
-		found->active_total_bytes += block_group->length;
 	found->disk_total += block_group->length * factor;
 	found->bytes_used += block_group->used;
 	found->disk_used += block_group->used * factor;
@@ -317,11 +385,11 @@ void btrfs_add_bg_to_space_info(struct btrfs_fs_info *info,
 	found->bytes_zone_unusable += block_group->zone_unusable;
 	if (block_group->length > 0)
 		found->full = 0;
+
+	update_block_group_activation(block_group, true);
 	btrfs_try_granting_tickets(info, found);
 	spin_unlock(&found->lock);
 
-	block_group->space_info = found;
-
 	index = btrfs_bg_flags_to_raid_index(block_group->flags);
 	down_write(&found->groups_sem);
 	list_add_tail(&block_group->list, &found->block_groups[index]);
@@ -521,6 +589,13 @@ static void __btrfs_dump_space_info(struct btrfs_fs_info *fs_info,
 		info->total_bytes, info->bytes_used, info->bytes_pinned,
 		info->bytes_reserved, info->bytes_may_use,
 		info->bytes_readonly, info->bytes_zone_unusable);
+	if (info->active_total_bytes == 0)
+		return;
+	btrfs_info(fs_info,
+"space_info active counters total=%llu, used=%llu, pinned=%llu, zone_unusable=%llu",
+		info->active_total_bytes, info->active_bytes_used,
+		info->active_bytes_pinned, info->active_bytes_zone_unusable);
+
 }
 
 void btrfs_dump_space_info(struct btrfs_fs_info *fs_info,
diff --git a/fs/btrfs/space-info.h b/fs/btrfs/space-info.h
index fc99ea2b0c34..d072d6c26d3a 100644
--- a/fs/btrfs/space-info.h
+++ b/fs/btrfs/space-info.h
@@ -96,11 +96,25 @@ struct btrfs_space_info {
 	u64 bytes_may_use;	/* number of bytes that may be used for
 				   delalloc/allocations */
 	u64 bytes_readonly;	/* total bytes that are read only */
-	/* Total bytes in the space, but only accounts active block groups. */
-	u64 active_total_bytes;
+
 	u64 bytes_zone_unusable;	/* total bytes that are unusable until
 					   resetting the device zone */
 
+	/*
+	 * This are mirrors of the above countesr.
+	 *
+	 * We need to mirror a lot of the counters for ENOSPC reasons if we're
+	 * doing active block group management.  The only exceptions are
+	 * bytes_reserved, which would be correct as we can only be allocating
+	 * from active block groups, and bytes_may_use which again is uptodate
+	 * based on what is currently being reserved.  Everything else has to be
+	 * mirrored and only accounted for in the active block groups.
+	 * */
+	u64 active_total_bytes;
+	u64 active_bytes_used;
+	u64 active_bytes_pinned;
+	u64 active_bytes_zone_unusable;
+
 	u64 max_extent_size;	/* This will hold the maximum extent size of
 				   the space info if we had an ENOSPC in the
 				   allocator. */
@@ -237,5 +251,7 @@ int btrfs_reserve_data_bytes(struct btrfs_fs_info *fs_info, u64 bytes,
 void btrfs_dump_space_info_for_trans_abort(struct btrfs_fs_info *fs_info);
 void btrfs_init_async_reclaim_work(struct btrfs_fs_info *fs_info);
 u64 btrfs_account_ro_block_groups_free_space(struct btrfs_space_info *sinfo);
+void btrfs_deactivate_block_group(struct btrfs_block_group *block_group);
+void btrfs_activate_block_group(struct btrfs_block_group *block_group);
 
 #endif /* BTRFS_SPACE_INFO_H */
diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index 808cfa3091c5..8a863004d750 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -1900,8 +1900,7 @@ bool btrfs_zone_activate(struct btrfs_block_group *block_group)
 	}
 
 	/* Successfully activated all the zones */
-	set_bit(BLOCK_GROUP_FLAG_ZONE_IS_ACTIVE, &block_group->runtime_flags);
-	space_info->active_total_bytes += block_group->length;
+	btrfs_activate_block_group(block_group);
 	spin_unlock(&block_group->lock);
 	btrfs_try_granting_tickets(fs_info, space_info);
 	spin_unlock(&space_info->lock);
@@ -1956,15 +1955,18 @@ static void wait_eb_writebacks(struct btrfs_block_group *block_group)
 static int do_zone_finish(struct btrfs_block_group *block_group, bool fully_written)
 {
 	struct btrfs_fs_info *fs_info = block_group->fs_info;
+	struct btrfs_space_info *space_info = block_group->space_info;
 	struct map_lookup *map;
 	const bool is_metadata = (block_group->flags &
 			(BTRFS_BLOCK_GROUP_METADATA | BTRFS_BLOCK_GROUP_SYSTEM));
 	int ret = 0;
 	int i;
 
+	spin_lock(&space_info->lock);
 	spin_lock(&block_group->lock);
 	if (!test_bit(BLOCK_GROUP_FLAG_ZONE_IS_ACTIVE, &block_group->runtime_flags)) {
 		spin_unlock(&block_group->lock);
+		spin_unlock(&space_info->lock);
 		return 0;
 	}
 
@@ -1972,6 +1974,7 @@ static int do_zone_finish(struct btrfs_block_group *block_group, bool fully_writ
 	if (is_metadata &&
 	    block_group->start + block_group->alloc_offset > block_group->meta_write_pointer) {
 		spin_unlock(&block_group->lock);
+		spin_unlock(&space_info->lock);
 		return -EAGAIN;
 	}
 
@@ -1984,6 +1987,7 @@ static int do_zone_finish(struct btrfs_block_group *block_group, bool fully_writ
 	 */
 	if (!fully_written) {
 		spin_unlock(&block_group->lock);
+		spin_unlock(&space_info->lock);
 
 		ret = btrfs_inc_block_group_ro(block_group, false);
 		if (ret)
@@ -1998,6 +2002,7 @@ static int do_zone_finish(struct btrfs_block_group *block_group, bool fully_writ
 		if (is_metadata)
 			wait_eb_writebacks(block_group);
 
+		spin_lock(&space_info->lock);
 		spin_lock(&block_group->lock);
 
 		/*
@@ -2007,23 +2012,26 @@ static int do_zone_finish(struct btrfs_block_group *block_group, bool fully_writ
 		if (!test_bit(BLOCK_GROUP_FLAG_ZONE_IS_ACTIVE,
 			      &block_group->runtime_flags)) {
 			spin_unlock(&block_group->lock);
+			spin_unlock(&space_info->lock);
 			btrfs_dec_block_group_ro(block_group);
 			return 0;
 		}
 
 		if (block_group->reserved) {
 			spin_unlock(&block_group->lock);
+			spin_unlock(&space_info->lock);
 			btrfs_dec_block_group_ro(block_group);
 			return -EAGAIN;
 		}
 	}
 
-	clear_bit(BLOCK_GROUP_FLAG_ZONE_IS_ACTIVE, &block_group->runtime_flags);
+	btrfs_deactivate_block_group(block_group);
 	block_group->alloc_offset = block_group->zone_capacity;
 	block_group->free_space_ctl->free_space = 0;
 	btrfs_clear_treelog_bg(block_group);
 	btrfs_clear_data_reloc_bg(block_group);
 	spin_unlock(&block_group->lock);
+	spin_unlock(&space_info->lock);
 
 	map = block_group->physical_map;
 	for (i = 0; i < map->num_stripes; i++) {
-- 
2.26.3

