Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DF073A43FF
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Jun 2021 16:23:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231445AbhFKOZ3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 11 Jun 2021 10:25:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230346AbhFKOZ0 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 11 Jun 2021 10:25:26 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 624D5C061574
        for <linux-btrfs@vger.kernel.org>; Fri, 11 Jun 2021 07:23:19 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id i67so31084531qkc.4
        for <linux-btrfs@vger.kernel.org>; Fri, 11 Jun 2021 07:23:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=4y37BT3TyqjSkYgL4kliFSLhuITwVKI0eMiMhzPCIFA=;
        b=Dz8pAqsTMDZb+H6cS2UbiXszJArW+7uoegphtftI0cI+Wlf684cYgyD9Jlz9uw8GT5
         0a/G9MfczmYpI2pEf4KhsOHeDSbomTC1NntfE1azAboclvwJTb+AMuK8sQ/INwm3efVU
         hdstwLbbMgEB77aDH8WLTyRwcQnzCUyxxDX+ci39GRDAMZn48TO1dh/dywPi+tSp+ffp
         Xm1Tf7+mHGVCskDiHzmH9feoB6/CufbAVR9o9zGqtvnAhpNUWtBW0SmCS92kMFzEKCNm
         uFbcNQnp9pCuA1K2Tjhhe3Kp3i4PvJTrV3g5JCFyy9sjLbjUiIOy1Mvu3xHEAFAsCXtT
         erSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4y37BT3TyqjSkYgL4kliFSLhuITwVKI0eMiMhzPCIFA=;
        b=CdNLIy1mZ/9BguXwC21ZYojdzGqvgtO4F1zHKVLyCarHWpwf5KNVUOueu2Mqx+vAUi
         rnVcHKYA/TnCueJrHZw2YSZA/tn5/6zh/ZmWq/7Wubkr4rrRC4supJ9iR8mf41JbUjnn
         kQ1XVIrsJBUFPSthpmxMtYHHWptGyAYEwerEz7T6XbULqtVFW6jdEL/5/tzlLbOSBWXa
         BY3av3xOKGC2lrgsxq7IxfS96+BBo3tEVe+ug5aKHpQ9uVg4nd9cj9/QvK5GQyGzZgE4
         Lb6tjn5zznHT50b4Def6oPIavq97YMT2p3mxSLzjOiUt0tCfV2BjrX1QU9gD7WhOG8Ei
         oLyw==
X-Gm-Message-State: AOAM532gn71zUQBWd1ytGU4ixFE8W8OUePuBo9DfbTkLcY8I7FSa71vS
        ydt6u5wevqjvc3sQgLOhRoyNv76wM0Xl9Q==
X-Google-Smtp-Source: ABdhPJy2Kx+Knu/lOslFD2kzE4xRYsvMJZ83vmGqYi67OVtd8k81C7AEYXt5OmoIXoK/iY4KX2LAhg==
X-Received: by 2002:a37:7287:: with SMTP id n129mr3892767qkc.457.1623421398154;
        Fri, 11 Jun 2021 07:23:18 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id p199sm4560070qka.128.2021.06.11.07.23.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jun 2021 07:23:16 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 3/3] btrfs: rip out ->total_bytes_pinned
Date:   Fri, 11 Jun 2021 10:23:10 -0400
Message-Id: <072e28fb01c2b17c0f48d9315a84530e5917f899.1623421213.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1623421213.git.josef@toxicpanda.com>
References: <cover.1623421213.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We used this in may_commit_transaction() in order to determine if we
needed to commit the transaction.  However we no longer have that logic
and thus have no use of this counter anymore, so delete it.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/block-group.c |  3 ---
 fs/btrfs/delayed-ref.c | 26 --------------------------
 fs/btrfs/disk-io.c     |  3 ---
 fs/btrfs/extent-tree.c | 15 ---------------
 fs/btrfs/space-info.c  |  7 -------
 fs/btrfs/space-info.h  | 30 ------------------------------
 fs/btrfs/sysfs.c       | 13 -------------
 7 files changed, 97 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 38885b29e6e5..e624e1d9840f 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -1399,7 +1399,6 @@ void btrfs_delete_unused_bgs(struct btrfs_fs_info *fs_info)
 		btrfs_space_info_update_bytes_pinned(fs_info, space_info,
 						     -block_group->pinned);
 		space_info->bytes_readonly += block_group->pinned;
-		__btrfs_mod_total_bytes_pinned(space_info, -block_group->pinned);
 		block_group->pinned = 0;
 
 		spin_unlock(&block_group->lock);
@@ -3062,8 +3061,6 @@ int btrfs_update_block_group(struct btrfs_trans_handle *trans,
 			spin_unlock(&cache->lock);
 			spin_unlock(&cache->space_info->lock);
 
-			__btrfs_mod_total_bytes_pinned(cache->space_info,
-						       num_bytes);
 			set_extent_dirty(&trans->transaction->pinned_extents,
 					 bytenr, bytenr + num_bytes - 1,
 					 GFP_NOFS | __GFP_NOFAIL);
diff --git a/fs/btrfs/delayed-ref.c b/fs/btrfs/delayed-ref.c
index c92d9d4f5f46..06bc842ecdb3 100644
--- a/fs/btrfs/delayed-ref.c
+++ b/fs/btrfs/delayed-ref.c
@@ -641,7 +641,6 @@ static noinline void update_existing_head_ref(struct btrfs_trans_handle *trans,
 	struct btrfs_delayed_ref_root *delayed_refs =
 		&trans->transaction->delayed_refs;
 	struct btrfs_fs_info *fs_info = trans->fs_info;
-	u64 flags = btrfs_ref_head_to_space_flags(existing);
 	int old_ref_mod;
 
 	BUG_ON(existing->is_data != update->is_data);
@@ -711,26 +710,6 @@ static noinline void update_existing_head_ref(struct btrfs_trans_handle *trans,
 		}
 	}
 
-	/*
-	 * This handles the following conditions:
-	 *
-	 * 1. We had a ref mod of 0 or more and went negative, indicating that
-	 *    we may be freeing space, so add our space to the
-	 *    total_bytes_pinned counter.
-	 * 2. We were negative and went to 0 or positive, so no longer can say
-	 *    that the space would be pinned, decrement our counter from the
-	 *    total_bytes_pinned counter.
-	 * 3. We are now at 0 and have ->must_insert_reserved set, which means
-	 *    this was a new allocation and then we dropped it, and thus must
-	 *    add our space to the total_bytes_pinned counter.
-	 */
-	if (existing->total_ref_mod < 0 && old_ref_mod >= 0)
-		btrfs_mod_total_bytes_pinned(fs_info, flags, existing->num_bytes);
-	else if (existing->total_ref_mod >= 0 && old_ref_mod < 0)
-		btrfs_mod_total_bytes_pinned(fs_info, flags, -existing->num_bytes);
-	else if (existing->total_ref_mod == 0 && existing->must_insert_reserved)
-		btrfs_mod_total_bytes_pinned(fs_info, flags, existing->num_bytes);
-
 	spin_unlock(&existing->lock);
 }
 
@@ -835,17 +814,12 @@ add_delayed_ref_head(struct btrfs_trans_handle *trans,
 		kmem_cache_free(btrfs_delayed_ref_head_cachep, head_ref);
 		head_ref = existing;
 	} else {
-		u64 flags = btrfs_ref_head_to_space_flags(head_ref);
-
 		if (head_ref->is_data && head_ref->ref_mod < 0) {
 			delayed_refs->pending_csums += head_ref->num_bytes;
 			trans->delayed_ref_updates +=
 				btrfs_csum_bytes_to_leaves(trans->fs_info,
 							   head_ref->num_bytes);
 		}
-		if (head_ref->ref_mod < 0)
-			btrfs_mod_total_bytes_pinned(trans->fs_info, flags,
-						     head_ref->num_bytes);
 		delayed_refs->num_heads++;
 		delayed_refs->num_heads_ready++;
 		atomic_inc(&delayed_refs->num_entries);
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index d1d5091a8385..9966168ac324 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -4696,9 +4696,6 @@ static int btrfs_destroy_delayed_refs(struct btrfs_transaction *trans,
 			cache->space_info->bytes_reserved -= head->num_bytes;
 			spin_unlock(&cache->lock);
 			spin_unlock(&cache->space_info->lock);
-			percpu_counter_add_batch(
-				&cache->space_info->total_bytes_pinned,
-				head->num_bytes, BTRFS_TOTAL_BYTES_PINNED_BATCH);
 
 			btrfs_put_block_group(cache);
 
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index d2f39a122d89..ae33b4418395 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -1804,19 +1804,6 @@ void btrfs_cleanup_ref_head_accounting(struct btrfs_fs_info *fs_info,
 		nr_items += btrfs_csum_bytes_to_leaves(fs_info, head->num_bytes);
 	}
 
-	/*
-	 * We were dropping refs, or had a new ref and dropped it, and thus must
-	 * adjust down our total_bytes_pinned, the space may or may not have
-	 * been pinned and so is accounted for properly in the pinned space by
-	 * now.
-	 */
-	if (head->total_ref_mod < 0 ||
-	    (head->total_ref_mod == 0 && head->must_insert_reserved)) {
-		u64 flags = btrfs_ref_head_to_space_flags(head);
-
-		btrfs_mod_total_bytes_pinned(fs_info, flags, -head->num_bytes);
-	}
-
 	btrfs_delayed_refs_rsv_release(fs_info, nr_items);
 }
 
@@ -2551,7 +2538,6 @@ static int pin_down_extent(struct btrfs_trans_handle *trans,
 	spin_unlock(&cache->lock);
 	spin_unlock(&cache->space_info->lock);
 
-	__btrfs_mod_total_bytes_pinned(cache->space_info, num_bytes);
 	set_extent_dirty(&trans->transaction->pinned_extents, bytenr,
 			 bytenr + num_bytes - 1, GFP_NOFS | __GFP_NOFAIL);
 	return 0;
@@ -2762,7 +2748,6 @@ static int unpin_extent_range(struct btrfs_fs_info *fs_info,
 		cache->pinned -= len;
 		btrfs_space_info_update_bytes_pinned(fs_info, space_info, -len);
 		space_info->max_extent_size = 0;
-		__btrfs_mod_total_bytes_pinned(space_info, -len);
 		if (cache->ro) {
 			space_info->bytes_readonly += len;
 			readonly = true;
diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index a2bf13206d8b..c46d2b9998be 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -192,13 +192,6 @@ static int create_space_info(struct btrfs_fs_info *info, u64 flags)
 	if (!space_info)
 		return -ENOMEM;
 
-	ret = percpu_counter_init(&space_info->total_bytes_pinned, 0,
-				 GFP_KERNEL);
-	if (ret) {
-		kfree(space_info);
-		return ret;
-	}
-
 	for (i = 0; i < BTRFS_NR_RAID_TYPES; i++)
 		INIT_LIST_HEAD(&space_info->block_groups[i]);
 	init_rwsem(&space_info->groups_sem);
diff --git a/fs/btrfs/space-info.h b/fs/btrfs/space-info.h
index 11eff2139aae..46a024f5aa70 100644
--- a/fs/btrfs/space-info.h
+++ b/fs/btrfs/space-info.h
@@ -43,18 +43,6 @@ struct btrfs_space_info {
 
 	u64 flags;
 
-	/*
-	 * bytes_pinned is kept in line with what is actually pinned, as in
-	 * we've called update_block_group and dropped the bytes_used counter
-	 * and increased the bytes_pinned counter.  However this means that
-	 * bytes_pinned does not reflect the bytes that will be pinned once the
-	 * delayed refs are flushed, so this counter is inc'ed every time we
-	 * call btrfs_free_extent so it is a realtime count of what will be
-	 * freed once the transaction is committed.  It will be zeroed every
-	 * time the transaction commits.
-	 */
-	struct percpu_counter total_bytes_pinned;
-
 	struct list_head list;
 	/* Protected by the spinlock 'lock'. */
 	struct list_head ro_bgs;
@@ -163,22 +151,4 @@ static inline void btrfs_space_info_free_bytes_may_use(
 }
 int btrfs_reserve_data_bytes(struct btrfs_fs_info *fs_info, u64 bytes,
 			     enum btrfs_reserve_flush_enum flush);
-
-static inline void __btrfs_mod_total_bytes_pinned(
-					struct btrfs_space_info *space_info,
-					s64 mod)
-{
-	percpu_counter_add_batch(&space_info->total_bytes_pinned, mod,
-				 BTRFS_TOTAL_BYTES_PINNED_BATCH);
-}
-
-static inline void btrfs_mod_total_bytes_pinned(struct btrfs_fs_info *fs_info,
-						u64 flags, s64 mod)
-{
-	struct btrfs_space_info *space_info = btrfs_find_space_info(fs_info, flags);
-
-	ASSERT(space_info);
-	__btrfs_mod_total_bytes_pinned(space_info, mod);
-}
-
 #endif /* BTRFS_SPACE_INFO_H */
diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index 52c5311873d3..e68c0afb7ada 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -665,15 +665,6 @@ static ssize_t btrfs_space_info_show_##field(struct kobject *kobj,	\
 }									\
 BTRFS_ATTR(space_info, field, btrfs_space_info_show_##field)
 
-static ssize_t btrfs_space_info_show_total_bytes_pinned(struct kobject *kobj,
-						       struct kobj_attribute *a,
-						       char *buf)
-{
-	struct btrfs_space_info *sinfo = to_space_info(kobj);
-	s64 val = percpu_counter_sum(&sinfo->total_bytes_pinned);
-	return scnprintf(buf, PAGE_SIZE, "%lld\n", val);
-}
-
 static ssize_t btrfs_space_info_show_enospc_events(struct kobject *kobj,
 						   struct kobj_attribute *a,
 						   char *buf)
@@ -693,8 +684,6 @@ SPACE_INFO_ATTR(bytes_readonly);
 SPACE_INFO_ATTR(bytes_zone_unusable);
 SPACE_INFO_ATTR(disk_used);
 SPACE_INFO_ATTR(disk_total);
-BTRFS_ATTR(space_info, total_bytes_pinned,
-	   btrfs_space_info_show_total_bytes_pinned);
 BTRFS_ATTR(space_info, enospc_events,
 	   btrfs_space_info_show_enospc_events);
 
@@ -709,7 +698,6 @@ static struct attribute *space_info_attrs[] = {
 	BTRFS_ATTR_PTR(space_info, bytes_zone_unusable),
 	BTRFS_ATTR_PTR(space_info, disk_used),
 	BTRFS_ATTR_PTR(space_info, disk_total),
-	BTRFS_ATTR_PTR(space_info, total_bytes_pinned),
 	BTRFS_ATTR_PTR(space_info, enospc_events),
 	NULL,
 };
@@ -718,7 +706,6 @@ ATTRIBUTE_GROUPS(space_info);
 static void space_info_release(struct kobject *kobj)
 {
 	struct btrfs_space_info *sinfo = to_space_info(kobj);
-	percpu_counter_destroy(&sinfo->total_bytes_pinned);
 	kfree(sinfo);
 }
 
-- 
2.26.3

