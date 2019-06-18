Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BECF44AB71
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Jun 2019 22:09:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730512AbfFRUJj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 18 Jun 2019 16:09:39 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:41751 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729331AbfFRUJi (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 18 Jun 2019 16:09:38 -0400
Received: by mail-qt1-f193.google.com with SMTP id d17so12060602qtj.8
        for <linux-btrfs@vger.kernel.org>; Tue, 18 Jun 2019 13:09:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=BcQbEcZbTf8y17vcmDd2iemPRQ8zGasSMS+Yr3IbRf4=;
        b=JY1PHuN4/XyQPAgK38Dn0xHS/asJ8qexRXKWUYpRU+6ze466Jt8AB0l1FvkXjj3HTC
         tKDvMo804ln/OUaVHGk7R+1q1pYLkXj9TmtwknmeYQ4Zb6tFfCdkw03n1sfw/R6fvCZn
         H5056SnW2AMCB93WAGeCNru6OYv0wjoLi0xfnQwKWTVKSP9yxksLE7dR80r8SY/Z/W84
         Zk7WiJubFEnGJBE26IBw2Z4q4l+uYCq+AMlZ2NYAfyelk7wuQEsUXiEVTpr3r3KJhsJn
         O2eJlNOFmH7jAm/k1L7KXoNbXctPqMDPBTTkUW6l5Xiy8zhuK4RxRSR5RoQlU2XWE5qy
         H8yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=BcQbEcZbTf8y17vcmDd2iemPRQ8zGasSMS+Yr3IbRf4=;
        b=p02vvfPofMA3rCs7PNRpOUq899Ho8tWJF17hBk292dYU5y9JF+EVdk5TlTnk/G1VPF
         5YTXP3NeWxZ6tIK1RJHRSKpZav1+UL4AHIVvwxlj4LKsLlIjCzBjpHIsqhVbv3uVrb5N
         e5r4UMiuQr++n7MAI5cYYtqULxcYUHdwi158a4aYPNXLxLV1NOA4fsPfyeBNO5F6bMFM
         napuoxp8m4Ch4e5xLZWhOzeb8T/QzQe7KcFmUkQa44+SFYCvQUH5/tp898q7c5IEOzW5
         yHbfN0mVZA7I3ruxjdQq2ybsP0yt17jr/3CPFtizcyyHk4xeXOl+nvwfym9kV9Vy5X06
         owbw==
X-Gm-Message-State: APjAAAVP8b6FeFC5UM6/ay3syOX3ZDp0yDd2tX3cCSVU6JJC0eTmLhTg
        eMj52PXmlBcMg4taCcBI6KGO4LUx0W04OQ==
X-Google-Smtp-Source: APXvYqyp80ygntZODxkwrplGpWZWUfGY55ck2OpQXNLPq0+olzZJVyCgQHRxySS7T6UnPU8tamewLA==
X-Received: by 2002:ac8:38c5:: with SMTP id g5mr103706669qtc.299.1560888576901;
        Tue, 18 Jun 2019 13:09:36 -0700 (PDT)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id j26sm11440048qtj.70.2019.06.18.13.09.36
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 18 Jun 2019 13:09:36 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 04/11] btrfs: move the space_info handling code to space-info.c
Date:   Tue, 18 Jun 2019 16:09:19 -0400
Message-Id: <20190618200926.3352-5-josef@toxicpanda.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20190618200926.3352-1-josef@toxicpanda.com>
References: <20190618200926.3352-1-josef@toxicpanda.com>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

These are the basic init and lookup functions and some helper functions,
fairly straightforward before the bad stuff starts.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/Makefile      |   2 +-
 fs/btrfs/extent-tree.c | 205 +++++--------------------------------------------
 fs/btrfs/space-info.c  | 177 ++++++++++++++++++++++++++++++++++++++++++
 fs/btrfs/space-info.h  |  11 +++
 4 files changed, 208 insertions(+), 187 deletions(-)
 create mode 100644 fs/btrfs/space-info.c

diff --git a/fs/btrfs/Makefile b/fs/btrfs/Makefile
index ca693dd554e9..ae5fad57bc9c 100644
--- a/fs/btrfs/Makefile
+++ b/fs/btrfs/Makefile
@@ -10,7 +10,7 @@ btrfs-y += super.o ctree.o extent-tree.o print-tree.o root-tree.o dir-item.o \
 	   export.o tree-log.o free-space-cache.o zlib.o lzo.o zstd.o \
 	   compression.o delayed-ref.o relocation.o delayed-inode.o scrub.o \
 	   reada.o backref.o ulist.o qgroup.o send.o dev-replace.o raid56.o \
-	   uuid-tree.o props.o free-space-tree.o tree-checker.o
+	   uuid-tree.o props.o free-space-tree.o tree-checker.o space-info.o
 
 btrfs-$(CONFIG_BTRFS_FS_POSIX_ACL) += acl.o
 btrfs-$(CONFIG_BTRFS_FS_CHECK_INTEGRITY) += check-integrity.o
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 9dcda96ef309..a30d265fee5e 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -713,25 +713,6 @@ struct btrfs_block_group_cache *btrfs_lookup_block_group(
 	return block_group_cache_tree_search(info, bytenr, 1);
 }
 
-static struct btrfs_space_info *__find_space_info(struct btrfs_fs_info *info,
-						  u64 flags)
-{
-	struct list_head *head = &info->space_info;
-	struct btrfs_space_info *found;
-
-	flags &= BTRFS_BLOCK_GROUP_TYPE_MASK;
-
-	rcu_read_lock();
-	list_for_each_entry_rcu(found, head, list) {
-		if (found->flags & flags) {
-			rcu_read_unlock();
-			return found;
-		}
-	}
-	rcu_read_unlock();
-	return NULL;
-}
-
 static u64 generic_ref_to_space_flags(struct btrfs_ref *ref)
 {
 	if (ref->type == BTRFS_REF_METADATA) {
@@ -749,7 +730,7 @@ static void add_pinned_bytes(struct btrfs_fs_info *fs_info,
 	struct btrfs_space_info *space_info;
 	u64 flags = generic_ref_to_space_flags(ref);
 
-	space_info = __find_space_info(fs_info, flags);
+	space_info = btrfs_find_space_info(fs_info, flags);
 	ASSERT(space_info);
 	percpu_counter_add_batch(&space_info->total_bytes_pinned, ref->len,
 		    BTRFS_TOTAL_BYTES_PINNED_BATCH);
@@ -761,27 +742,12 @@ static void sub_pinned_bytes(struct btrfs_fs_info *fs_info,
 	struct btrfs_space_info *space_info;
 	u64 flags = generic_ref_to_space_flags(ref);
 
-	space_info = __find_space_info(fs_info, flags);
+	space_info = btrfs_find_space_info(fs_info, flags);
 	ASSERT(space_info);
 	percpu_counter_add_batch(&space_info->total_bytes_pinned, -ref->len,
 		    BTRFS_TOTAL_BYTES_PINNED_BATCH);
 }
 
-/*
- * after adding space to the filesystem, we need to clear the full flags
- * on all the space infos.
- */
-void btrfs_clear_space_info_full(struct btrfs_fs_info *info)
-{
-	struct list_head *head = &info->space_info;
-	struct btrfs_space_info *found;
-
-	rcu_read_lock();
-	list_for_each_entry_rcu(found, head, list)
-		found->full = 0;
-	rcu_read_unlock();
-}
-
 /* simple helper to search for an existing data extent at a given offset */
 int btrfs_lookup_data_extent(struct btrfs_fs_info *fs_info, u64 start, u64 len)
 {
@@ -2449,7 +2415,7 @@ void btrfs_cleanup_ref_head_accounting(struct btrfs_fs_info *fs_info,
 			flags = BTRFS_BLOCK_GROUP_SYSTEM;
 		else
 			flags = BTRFS_BLOCK_GROUP_METADATA;
-		space_info = __find_space_info(fs_info, flags);
+		space_info = btrfs_find_space_info(fs_info, flags);
 		ASSERT(space_info);
 		percpu_counter_add_batch(&space_info->total_bytes_pinned,
 				   -head->num_bytes,
@@ -3821,93 +3787,6 @@ void btrfs_wait_nocow_writers(struct btrfs_block_group_cache *bg)
 	wait_var_event(&bg->nocow_writers, !atomic_read(&bg->nocow_writers));
 }
 
-static const char *alloc_name(u64 flags)
-{
-	switch (flags) {
-	case BTRFS_BLOCK_GROUP_METADATA|BTRFS_BLOCK_GROUP_DATA:
-		return "mixed";
-	case BTRFS_BLOCK_GROUP_METADATA:
-		return "metadata";
-	case BTRFS_BLOCK_GROUP_DATA:
-		return "data";
-	case BTRFS_BLOCK_GROUP_SYSTEM:
-		return "system";
-	default:
-		WARN_ON(1);
-		return "invalid-combination";
-	};
-}
-
-static int create_space_info(struct btrfs_fs_info *info, u64 flags)
-{
-
-	struct btrfs_space_info *space_info;
-	int i;
-	int ret;
-
-	space_info = kzalloc(sizeof(*space_info), GFP_NOFS);
-	if (!space_info)
-		return -ENOMEM;
-
-	ret = percpu_counter_init(&space_info->total_bytes_pinned, 0,
-				 GFP_KERNEL);
-	if (ret) {
-		kfree(space_info);
-		return ret;
-	}
-
-	for (i = 0; i < BTRFS_NR_RAID_TYPES; i++)
-		INIT_LIST_HEAD(&space_info->block_groups[i]);
-	init_rwsem(&space_info->groups_sem);
-	spin_lock_init(&space_info->lock);
-	space_info->flags = flags & BTRFS_BLOCK_GROUP_TYPE_MASK;
-	space_info->force_alloc = CHUNK_ALLOC_NO_FORCE;
-	init_waitqueue_head(&space_info->wait);
-	INIT_LIST_HEAD(&space_info->ro_bgs);
-	INIT_LIST_HEAD(&space_info->tickets);
-	INIT_LIST_HEAD(&space_info->priority_tickets);
-
-	ret = kobject_init_and_add(&space_info->kobj, &space_info_ktype,
-				    info->space_info_kobj, "%s",
-				    alloc_name(space_info->flags));
-	if (ret) {
-		kobject_put(&space_info->kobj);
-		return ret;
-	}
-
-	list_add_rcu(&space_info->list, &info->space_info);
-	if (flags & BTRFS_BLOCK_GROUP_DATA)
-		info->data_sinfo = space_info;
-
-	return ret;
-}
-
-static void update_space_info(struct btrfs_fs_info *info, u64 flags,
-			     u64 total_bytes, u64 bytes_used,
-			     u64 bytes_readonly,
-			     struct btrfs_space_info **space_info)
-{
-	struct btrfs_space_info *found;
-	int factor;
-
-	factor = btrfs_bg_type_to_factor(flags);
-
-	found = __find_space_info(info, flags);
-	ASSERT(found);
-	spin_lock(&found->lock);
-	found->total_bytes += total_bytes;
-	found->disk_total += total_bytes * factor;
-	found->bytes_used += bytes_used;
-	found->disk_used += bytes_used * factor;
-	found->bytes_readonly += bytes_readonly;
-	if (total_bytes > 0)
-		found->full = 0;
-	btrfs_space_info_add_new_bytes(info, found, total_bytes -
-				       bytes_used - bytes_readonly);
-	spin_unlock(&found->lock);
-	*space_info = found;
-}
-
 static void set_avail_alloc_bits(struct btrfs_fs_info *fs_info, u64 flags)
 {
 	u64 extra_flags = chunk_to_extended(flags) &
@@ -4055,15 +3934,6 @@ u64 btrfs_system_alloc_profile(struct btrfs_fs_info *fs_info)
 	return get_alloc_profile(fs_info, BTRFS_BLOCK_GROUP_SYSTEM);
 }
 
-static u64 btrfs_space_info_used(struct btrfs_space_info *s_info,
-				 bool may_use_included)
-{
-	ASSERT(s_info);
-	return s_info->bytes_used + s_info->bytes_reserved +
-		s_info->bytes_pinned + s_info->bytes_readonly +
-		(may_use_included ? s_info->bytes_may_use : 0);
-}
-
 int btrfs_alloc_data_chunk_ondemand(struct btrfs_inode *inode, u64 bytes)
 {
 	struct btrfs_root *root = inode->root;
@@ -4339,7 +4209,7 @@ void check_system_chunk(struct btrfs_trans_handle *trans, u64 type)
 	 */
 	lockdep_assert_held(&fs_info->chunk_mutex);
 
-	info = __find_space_info(fs_info, BTRFS_BLOCK_GROUP_SYSTEM);
+	info = btrfs_find_space_info(fs_info, BTRFS_BLOCK_GROUP_SYSTEM);
 	spin_lock(&info->lock);
 	left = info->total_bytes - btrfs_space_info_used(info, true);
 	spin_unlock(&info->lock);
@@ -4400,7 +4270,7 @@ int btrfs_chunk_alloc(struct btrfs_trans_handle *trans, u64 flags,
 	if (trans->allocating_chunk)
 		return -ENOSPC;
 
-	space_info = __find_space_info(fs_info, flags);
+	space_info = btrfs_find_space_info(fs_info, flags);
 	ASSERT(space_info);
 
 	do {
@@ -4629,7 +4499,7 @@ static void shrink_delalloc(struct btrfs_fs_info *fs_info, u64 to_reclaim,
 	to_reclaim = items * EXTENT_SIZE_PER_ITEM;
 
 	trans = (struct btrfs_trans_handle *)current->journal_info;
-	space_info = __find_space_info(fs_info, BTRFS_BLOCK_GROUP_METADATA);
+	space_info = btrfs_find_space_info(fs_info, BTRFS_BLOCK_GROUP_METADATA);
 
 	delalloc_bytes = percpu_counter_sum_positive(
 						&fs_info->delalloc_bytes);
@@ -4967,7 +4837,7 @@ static void btrfs_async_reclaim_metadata_space(struct work_struct *work)
 	u64 last_tickets_id;
 
 	fs_info = container_of(work, struct btrfs_fs_info, async_reclaim_work);
-	space_info = __find_space_info(fs_info, BTRFS_BLOCK_GROUP_METADATA);
+	space_info = btrfs_find_space_info(fs_info, BTRFS_BLOCK_GROUP_METADATA);
 
 	spin_lock(&space_info->lock);
 	to_reclaim = btrfs_calc_reclaim_metadata_size(fs_info, space_info,
@@ -5614,7 +5484,7 @@ void btrfs_init_metadata_block_rsv(struct btrfs_fs_info *fs_info,
 				   unsigned short type)
 {
 	btrfs_init_block_rsv(rsv, type);
-	rsv->space_info = __find_space_info(fs_info,
+	rsv->space_info = btrfs_find_space_info(fs_info,
 					    BTRFS_BLOCK_GROUP_METADATA);
 }
 
@@ -5839,10 +5709,10 @@ static void init_global_block_rsv(struct btrfs_fs_info *fs_info)
 {
 	struct btrfs_space_info *space_info;
 
-	space_info = __find_space_info(fs_info, BTRFS_BLOCK_GROUP_SYSTEM);
+	space_info = btrfs_find_space_info(fs_info, BTRFS_BLOCK_GROUP_SYSTEM);
 	fs_info->chunk_block_rsv.space_info = space_info;
 
-	space_info = __find_space_info(fs_info, BTRFS_BLOCK_GROUP_METADATA);
+	space_info = btrfs_find_space_info(fs_info, BTRFS_BLOCK_GROUP_METADATA);
 	fs_info->global_block_rsv.space_info = space_info;
 	fs_info->trans_block_rsv.space_info = space_info;
 	fs_info->empty_block_rsv.space_info = space_info;
@@ -5951,7 +5821,7 @@ int btrfs_subvolume_reserve_metadata(struct btrfs_root *root,
 	}
 
 	num_bytes = btrfs_calc_trans_metadata_size(fs_info, items);
-	rsv->space_info = __find_space_info(fs_info,
+	rsv->space_info = btrfs_find_space_info(fs_info,
 					    BTRFS_BLOCK_GROUP_METADATA);
 	ret = btrfs_block_rsv_add(root, rsv, num_bytes,
 				  BTRFS_RESERVE_FLUSH_ALL);
@@ -7747,7 +7617,7 @@ static noinline int find_free_extent(struct btrfs_fs_info *fs_info,
 
 	trace_find_free_extent(fs_info, num_bytes, empty_size, flags);
 
-	space_info = __find_space_info(fs_info, flags);
+	space_info = btrfs_find_space_info(fs_info, flags);
 	if (!space_info) {
 		btrfs_err(fs_info, "No space info for %llu", flags);
 		return -ENOSPC;
@@ -8102,7 +7972,7 @@ int btrfs_reserve_extent(struct btrfs_root *root, u64 ram_bytes,
 		} else if (btrfs_test_opt(fs_info, ENOSPC_DEBUG)) {
 			struct btrfs_space_info *sinfo;
 
-			sinfo = __find_space_info(fs_info, flags);
+			sinfo = btrfs_find_space_info(fs_info, flags);
 			btrfs_err(fs_info,
 				  "allocation failed flags %llu, wanted %llu",
 				  flags, num_bytes);
@@ -10137,7 +10007,7 @@ void btrfs_add_raid_kobjects(struct btrfs_fs_info *fs_info)
 	spin_unlock(&fs_info->pending_raid_kobjs_lock);
 
 	list_for_each_entry(rkobj, &list, list) {
-		space_info = __find_space_info(fs_info, rkobj->flags);
+		space_info = btrfs_find_space_info(fs_info, rkobj->flags);
 
 		ret = kobject_add(&rkobj->kobj, &space_info->kobj,
 				"%s", btrfs_bg_type_to_raid_name(rkobj->flags));
@@ -10404,9 +10274,9 @@ int btrfs_read_block_groups(struct btrfs_fs_info *info)
 		}
 
 		trace_btrfs_add_block_group(info, cache, 0);
-		update_space_info(info, cache->flags, found_key.offset,
-				  btrfs_block_group_used(&cache->item),
-				  cache->bytes_super, &space_info);
+		btrfs_update_space_info(info, cache->flags, found_key.offset,
+					btrfs_block_group_used(&cache->item),
+					cache->bytes_super, &space_info);
 
 		cache->space_info = space_info;
 
@@ -10541,7 +10411,7 @@ int btrfs_make_block_group(struct btrfs_trans_handle *trans, u64 bytes_used,
 	 * assigned to our block group. We want our bg to be added to the rbtree
 	 * with its ->space_info set.
 	 */
-	cache->space_info = __find_space_info(fs_info, cache->flags);
+	cache->space_info = btrfs_find_space_info(fs_info, cache->flags);
 	ASSERT(cache->space_info);
 
 	ret = btrfs_add_block_group_cache(fs_info, cache);
@@ -10556,7 +10426,7 @@ int btrfs_make_block_group(struct btrfs_trans_handle *trans, u64 bytes_used,
 	 * the rbtree, update the space info's counters.
 	 */
 	trace_btrfs_add_block_group(fs_info, cache, 1);
-	update_space_info(fs_info, cache->flags, size, bytes_used,
+	btrfs_update_space_info(fs_info, cache->flags, size, bytes_used,
 				cache->bytes_super, &cache->space_info);
 	update_global_block_rsv(fs_info);
 
@@ -11061,43 +10931,6 @@ void btrfs_delete_unused_bgs(struct btrfs_fs_info *fs_info)
 	spin_unlock(&fs_info->unused_bgs_lock);
 }
 
-int btrfs_init_space_info(struct btrfs_fs_info *fs_info)
-{
-	struct btrfs_super_block *disk_super;
-	u64 features;
-	u64 flags;
-	int mixed = 0;
-	int ret;
-
-	disk_super = fs_info->super_copy;
-	if (!btrfs_super_root(disk_super))
-		return -EINVAL;
-
-	features = btrfs_super_incompat_flags(disk_super);
-	if (features & BTRFS_FEATURE_INCOMPAT_MIXED_GROUPS)
-		mixed = 1;
-
-	flags = BTRFS_BLOCK_GROUP_SYSTEM;
-	ret = create_space_info(fs_info, flags);
-	if (ret)
-		goto out;
-
-	if (mixed) {
-		flags = BTRFS_BLOCK_GROUP_METADATA | BTRFS_BLOCK_GROUP_DATA;
-		ret = create_space_info(fs_info, flags);
-	} else {
-		flags = BTRFS_BLOCK_GROUP_METADATA;
-		ret = create_space_info(fs_info, flags);
-		if (ret)
-			goto out;
-
-		flags = BTRFS_BLOCK_GROUP_DATA;
-		ret = create_space_info(fs_info, flags);
-	}
-out:
-	return ret;
-}
-
 int btrfs_error_unpin_extent_range(struct btrfs_fs_info *fs_info,
 				   u64 start, u64 end)
 {
diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
new file mode 100644
index 000000000000..348b57055d77
--- /dev/null
+++ b/fs/btrfs/space-info.c
@@ -0,0 +1,177 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2019 Facebook.  All rights reserved.
+ */
+
+#include "ctree.h"
+#include "space-info.h"
+#include "sysfs.h"
+#include "volumes.h"
+
+u64 btrfs_space_info_used(struct btrfs_space_info *s_info,
+			  bool may_use_included)
+{
+	ASSERT(s_info);
+	return s_info->bytes_used + s_info->bytes_reserved +
+		s_info->bytes_pinned + s_info->bytes_readonly +
+		(may_use_included ? s_info->bytes_may_use : 0);
+}
+
+/*
+ * after adding space to the filesystem, we need to clear the full flags
+ * on all the space infos.
+ */
+void btrfs_clear_space_info_full(struct btrfs_fs_info *info)
+{
+	struct list_head *head = &info->space_info;
+	struct btrfs_space_info *found;
+
+	rcu_read_lock();
+	list_for_each_entry_rcu(found, head, list)
+		found->full = 0;
+	rcu_read_unlock();
+}
+
+static const char *alloc_name(u64 flags)
+{
+	switch (flags) {
+	case BTRFS_BLOCK_GROUP_METADATA|BTRFS_BLOCK_GROUP_DATA:
+		return "mixed";
+	case BTRFS_BLOCK_GROUP_METADATA:
+		return "metadata";
+	case BTRFS_BLOCK_GROUP_DATA:
+		return "data";
+	case BTRFS_BLOCK_GROUP_SYSTEM:
+		return "system";
+	default:
+		WARN_ON(1);
+		return "invalid-combination";
+	};
+}
+
+static int create_space_info(struct btrfs_fs_info *info, u64 flags)
+{
+
+	struct btrfs_space_info *space_info;
+	int i;
+	int ret;
+
+	space_info = kzalloc(sizeof(*space_info), GFP_NOFS);
+	if (!space_info)
+		return -ENOMEM;
+
+	ret = percpu_counter_init(&space_info->total_bytes_pinned, 0,
+				 GFP_KERNEL);
+	if (ret) {
+		kfree(space_info);
+		return ret;
+	}
+
+	for (i = 0; i < BTRFS_NR_RAID_TYPES; i++)
+		INIT_LIST_HEAD(&space_info->block_groups[i]);
+	init_rwsem(&space_info->groups_sem);
+	spin_lock_init(&space_info->lock);
+	space_info->flags = flags & BTRFS_BLOCK_GROUP_TYPE_MASK;
+	space_info->force_alloc = CHUNK_ALLOC_NO_FORCE;
+	init_waitqueue_head(&space_info->wait);
+	INIT_LIST_HEAD(&space_info->ro_bgs);
+	INIT_LIST_HEAD(&space_info->tickets);
+	INIT_LIST_HEAD(&space_info->priority_tickets);
+
+	ret = kobject_init_and_add(&space_info->kobj, &space_info_ktype,
+				    info->space_info_kobj, "%s",
+				    alloc_name(space_info->flags));
+	if (ret) {
+		kobject_put(&space_info->kobj);
+		return ret;
+	}
+
+	list_add_rcu(&space_info->list, &info->space_info);
+	if (flags & BTRFS_BLOCK_GROUP_DATA)
+		info->data_sinfo = space_info;
+
+	return ret;
+}
+
+int btrfs_init_space_info(struct btrfs_fs_info *fs_info)
+{
+	struct btrfs_super_block *disk_super;
+	u64 features;
+	u64 flags;
+	int mixed = 0;
+	int ret;
+
+	disk_super = fs_info->super_copy;
+	if (!btrfs_super_root(disk_super))
+		return -EINVAL;
+
+	features = btrfs_super_incompat_flags(disk_super);
+	if (features & BTRFS_FEATURE_INCOMPAT_MIXED_GROUPS)
+		mixed = 1;
+
+	flags = BTRFS_BLOCK_GROUP_SYSTEM;
+	ret = create_space_info(fs_info, flags);
+	if (ret)
+		goto out;
+
+	if (mixed) {
+		flags = BTRFS_BLOCK_GROUP_METADATA | BTRFS_BLOCK_GROUP_DATA;
+		ret = create_space_info(fs_info, flags);
+	} else {
+		flags = BTRFS_BLOCK_GROUP_METADATA;
+		ret = create_space_info(fs_info, flags);
+		if (ret)
+			goto out;
+
+		flags = BTRFS_BLOCK_GROUP_DATA;
+		ret = create_space_info(fs_info, flags);
+	}
+out:
+	return ret;
+}
+
+void btrfs_update_space_info(struct btrfs_fs_info *info, u64 flags,
+			     u64 total_bytes, u64 bytes_used,
+			     u64 bytes_readonly,
+			     struct btrfs_space_info **space_info)
+{
+	struct btrfs_space_info *found;
+	int factor;
+
+	factor = btrfs_bg_type_to_factor(flags);
+
+	found = btrfs_find_space_info(info, flags);
+	ASSERT(found);
+	spin_lock(&found->lock);
+	found->total_bytes += total_bytes;
+	found->disk_total += total_bytes * factor;
+	found->bytes_used += bytes_used;
+	found->disk_used += bytes_used * factor;
+	found->bytes_readonly += bytes_readonly;
+	if (total_bytes > 0)
+		found->full = 0;
+	btrfs_space_info_add_new_bytes(info, found,
+				       total_bytes - bytes_used -
+				       bytes_readonly);
+	spin_unlock(&found->lock);
+	*space_info = found;
+}
+
+struct btrfs_space_info *btrfs_find_space_info(struct btrfs_fs_info *info,
+					       u64 flags)
+{
+	struct list_head *head = &info->space_info;
+	struct btrfs_space_info *found;
+
+	flags &= BTRFS_BLOCK_GROUP_TYPE_MASK;
+
+	rcu_read_lock();
+	list_for_each_entry_rcu(found, head, list) {
+		if (found->flags & flags) {
+			rcu_read_unlock();
+			return found;
+		}
+	}
+	rcu_read_unlock();
+	return NULL;
+}
diff --git a/fs/btrfs/space-info.h b/fs/btrfs/space-info.h
index b3a43fe62b7c..a5a228b59806 100644
--- a/fs/btrfs/space-info.h
+++ b/fs/btrfs/space-info.h
@@ -84,4 +84,15 @@ void btrfs_space_info_add_new_bytes(struct btrfs_fs_info *fs_info,
 void btrfs_space_info_add_old_bytes(struct btrfs_fs_info *fs_info,
 				    struct btrfs_space_info *space_info,
 				    u64 num_bytes);
+int btrfs_init_space_info(struct btrfs_fs_info *fs_info);
+void btrfs_update_space_info(struct btrfs_fs_info *info, u64 flags,
+			     u64 total_bytes, u64 bytes_used,
+			     u64 bytes_readonly,
+			     struct btrfs_space_info **space_info);
+struct btrfs_space_info *btrfs_find_space_info(struct btrfs_fs_info *info,
+					       u64 flags);
+u64 btrfs_space_info_used(struct btrfs_space_info *s_info,
+			  bool may_use_included);
+void btrfs_clear_space_info_full(struct btrfs_fs_info *info);
+
 #endif /* BTRFS_SPACE_INFO_H */
-- 
2.14.3

