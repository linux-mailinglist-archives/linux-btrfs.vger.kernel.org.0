Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E941A4DA4E
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Jun 2019 21:38:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726523AbfFTTiP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 20 Jun 2019 15:38:15 -0400
Received: from mail-yw1-f68.google.com ([209.85.161.68]:46154 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726169AbfFTTiO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 20 Jun 2019 15:38:14 -0400
Received: by mail-yw1-f68.google.com with SMTP id z197so1654946ywd.13
        for <linux-btrfs@vger.kernel.org>; Thu, 20 Jun 2019 12:38:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=ZP6+utl2S5BzTJ7t1GuR9ZuSoooDpYXHtCIBCE51Lv8=;
        b=aEhkuoYbSu3kFrM1XderAqyqVA+U3rhj+dngXL33VUzt6weL8me/anmJh/LR6Qaavq
         KbAQwhepZq3/t7+mRmUw+8725xUpTo3SUkGyxMio47NHeC4DWs1Zj+dkG1ZULdQ0hf/w
         zRg14aNqD2W2qoLTU6BV7twUTsYxUhh27N+IapU0hElgoLcChgWD87kv4zuXihUFPhCo
         QhfSZDHtJMZSQlbYnkxeukghv6TbUcqVwSaxzyPfXLTRqdgTpGnHPqEUVRV8FzHpMNvj
         7wbo0rbUHujOQM6rsT6plQESztg6EY6BVLSWHk7ZgakkkC3U4vppbi89SG35z2ov+Z+g
         gvzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=ZP6+utl2S5BzTJ7t1GuR9ZuSoooDpYXHtCIBCE51Lv8=;
        b=OvXklCCjCcwbVwjmsrz/q8IZO3z3vbBLxdxXt8/rYScycPsQDz7ZP06XUZ0hkH9AnO
         WJ5lf26VrRUqRXEi1HHAUF6DUIrQ8XJVmP79T2mYYn7Fao1xI6Nd/pgp1ytGhaXaHOOE
         Pl1mmdxUhtbdIPW0n3hUQ2XUuMGT4/Ukf5N9lBSEjEIcgBnA3dXNop2wcvH56JOKC/YV
         7i7+X5mV6KmRe6PmtPRSlv/mAlZ3/NtpBnNfkb8r8qPDsXBxDp1l59rKHXokAHu87L1n
         pu57T4Jhfmwb7XufMDk0AVUWuh70zlWVu00zKTP9JcvZMvjG8e0WeOQVLv1gBTQ92kla
         Jmog==
X-Gm-Message-State: APjAAAWazw88C4SLIq6oVBBhzDD5aWF+mBXV5Kn8DBgpGidDbJMQpIEm
        rcJ57kgS7+17HxTpxKsHdGOa24elQnXvgw==
X-Google-Smtp-Source: APXvYqxKZr6d9tW17UuBcnMk3boH3q9Rg5yrK9irbBM4wTa5TrJFSxlX4rNyF0extaBgviBZrY+NYA==
X-Received: by 2002:a81:6a05:: with SMTP id f5mr61604053ywc.368.1561059493214;
        Thu, 20 Jun 2019 12:38:13 -0700 (PDT)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id 193sm114818ywd.100.2019.06.20.12.38.12
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 20 Jun 2019 12:38:12 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 02/25] btrfs: move basic block_group definitions to their own header
Date:   Thu, 20 Jun 2019 15:37:44 -0400
Message-Id: <20190620193807.29311-3-josef@toxicpanda.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20190620193807.29311-1-josef@toxicpanda.com>
References: <20190620193807.29311-1-josef@toxicpanda.com>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is prep work for moving all of the block group cache code into its
own file.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/block-group.h                 | 156 +++++++++++++++++++++++++++++++++
 fs/btrfs/ctree.h                       | 148 +------------------------------
 fs/btrfs/disk-io.c                     |   1 +
 fs/btrfs/extent-tree.c                 |   1 +
 fs/btrfs/free-space-cache.c            |   1 +
 fs/btrfs/free-space-tree.c             |   1 +
 fs/btrfs/free-space-tree.h             |   2 +
 fs/btrfs/inode.c                       |   1 +
 fs/btrfs/ioctl.c                       |   1 +
 fs/btrfs/qgroup.c                      |   2 +-
 fs/btrfs/reada.c                       |   1 +
 fs/btrfs/relocation.c                  |   1 +
 fs/btrfs/scrub.c                       |   1 +
 fs/btrfs/space-info.c                  |   1 +
 fs/btrfs/super.c                       |   1 +
 fs/btrfs/sysfs.c                       |   1 +
 fs/btrfs/tests/btrfs-tests.c           |   1 +
 fs/btrfs/tests/free-space-tests.c      |   1 +
 fs/btrfs/tests/free-space-tree-tests.c |   1 +
 fs/btrfs/transaction.c                 |   1 +
 fs/btrfs/volumes.c                     |   1 +
 21 files changed, 177 insertions(+), 148 deletions(-)
 create mode 100644 fs/btrfs/block-group.h

diff --git a/fs/btrfs/block-group.h b/fs/btrfs/block-group.h
new file mode 100644
index 000000000000..f3f99787af86
--- /dev/null
+++ b/fs/btrfs/block-group.h
@@ -0,0 +1,156 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2019 Facebook.  All rights reserved.
+ */
+
+#ifndef BTRFS_BLOCK_GROUP_H
+#define BTRFS_BLOCK_GROUP_H
+
+enum btrfs_disk_cache_state {
+	BTRFS_DC_WRITTEN,
+	BTRFS_DC_ERROR,
+	BTRFS_DC_CLEAR,
+	BTRFS_DC_SETUP,
+};
+
+struct btrfs_caching_control {
+	struct list_head list;
+	struct mutex mutex;
+	wait_queue_head_t wait;
+	struct btrfs_work work;
+	struct btrfs_block_group_cache *block_group;
+	u64 progress;
+	refcount_t count;
+};
+
+/* Once caching_thread() finds this much free space, it will wake up waiters. */
+#define CACHING_CTL_WAKE_UP SZ_2M
+
+struct btrfs_block_group_cache {
+	struct btrfs_key key;
+	struct btrfs_block_group_item item;
+	struct btrfs_fs_info *fs_info;
+	struct inode *inode;
+	spinlock_t lock;
+	u64 pinned;
+	u64 reserved;
+	u64 delalloc_bytes;
+	u64 bytes_super;
+	u64 flags;
+	u64 cache_generation;
+
+	/*
+	 * If the free space extent count exceeds this number, convert the block
+	 * group to bitmaps.
+	 */
+	u32 bitmap_high_thresh;
+
+	/*
+	 * If the free space extent count drops below this number, convert the
+	 * block group back to extents.
+	 */
+	u32 bitmap_low_thresh;
+
+	/*
+	 * It is just used for the delayed data space allocation because
+	 * only the data space allocation and the relative metadata update
+	 * can be done cross the transaction.
+	 */
+	struct rw_semaphore data_rwsem;
+
+	/* for raid56, this is a full stripe, without parity */
+	unsigned long full_stripe_len;
+
+	unsigned int ro;
+	unsigned int iref:1;
+	unsigned int has_caching_ctl:1;
+	unsigned int removed:1;
+
+	int disk_cache_state;
+
+	/* cache tracking stuff */
+	int cached;
+	struct btrfs_caching_control *caching_ctl;
+	u64 last_byte_to_unpin;
+
+	struct btrfs_space_info *space_info;
+
+	/* free space cache stuff */
+	struct btrfs_free_space_ctl *free_space_ctl;
+
+	/* block group cache stuff */
+	struct rb_node cache_node;
+
+	/* for block groups in the same raid type */
+	struct list_head list;
+
+	/* usage count */
+	atomic_t count;
+
+	/* List of struct btrfs_free_clusters for this block group.
+	 * Today it will only have one thing on it, but that may change
+	 */
+	struct list_head cluster_list;
+
+	/* For delayed block group creation or deletion of empty block groups */
+	struct list_head bg_list;
+
+	/* For read-only block groups */
+	struct list_head ro_list;
+
+	atomic_t trimming;
+
+	/* For dirty block groups */
+	struct list_head dirty_list;
+	struct list_head io_list;
+
+	struct btrfs_io_ctl io_ctl;
+
+	/*
+	 * Incremented when doing extent allocations and holding a read lock
+	 * on the space_info's groups_sem semaphore.
+	 * Decremented when an ordered extent that represents an IO against this
+	 * block group's range is created (after it's added to its inode's
+	 * root's list of ordered extents) or immediately after the allocation
+	 * if it's a metadata extent or fallocate extent (for these cases we
+	 * don't create ordered extents).
+	 */
+	atomic_t reservations;
+
+	/*
+	 * Incremented while holding the spinlock *lock* by a task checking if
+	 * it can perform a nocow write (incremented if the value for the *ro*
+	 * field is 0). Decremented by such tasks once they create an ordered
+	 * extent or before that if some error happens before reaching that step.
+	 * This is to prevent races between block group relocation and nocow
+	 * writes through direct IO.
+	 */
+	atomic_t nocow_writers;
+
+	/* Lock for free space tree operations. */
+	struct mutex free_space_lock;
+
+	/*
+	 * Does the block group need to be added to the free space tree?
+	 * Protected by free_space_lock.
+	 */
+	int needs_free_space;
+
+	/* Record locked full stripes for RAID5/6 block group */
+	struct btrfs_full_stripe_locks_tree full_stripe_locks_root;
+};
+
+#ifdef CONFIG_BTRFS_DEBUG
+static inline int
+btrfs_should_fragment_free_space(struct btrfs_block_group_cache *block_group)
+{
+	struct btrfs_fs_info *fs_info = block_group->fs_info;
+
+	return (btrfs_test_opt(fs_info, FRAGMENT_METADATA) &&
+		block_group->flags & BTRFS_BLOCK_GROUP_METADATA) ||
+	       (btrfs_test_opt(fs_info, FRAGMENT_DATA) &&
+		block_group->flags &  BTRFS_BLOCK_GROUP_DATA);
+}
+#endif
+
+#endif /* BTRFS_BLOCK_GROUP_H */
diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 73e28d9c14bd..8a904115c553 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -39,6 +39,7 @@ struct btrfs_transaction;
 struct btrfs_pending_snapshot;
 struct btrfs_delayed_ref_root;
 struct btrfs_space_info;
+struct btrfs_block_group_cache;
 extern struct kmem_cache *btrfs_trans_handle_cachep;
 extern struct kmem_cache *btrfs_bit_radix_cachep;
 extern struct kmem_cache *btrfs_path_cachep;
@@ -431,26 +432,6 @@ enum btrfs_caching_type {
 	BTRFS_CACHE_ERROR,
 };
 
-enum btrfs_disk_cache_state {
-	BTRFS_DC_WRITTEN,
-	BTRFS_DC_ERROR,
-	BTRFS_DC_CLEAR,
-	BTRFS_DC_SETUP,
-};
-
-struct btrfs_caching_control {
-	struct list_head list;
-	struct mutex mutex;
-	wait_queue_head_t wait;
-	struct btrfs_work work;
-	struct btrfs_block_group_cache *block_group;
-	u64 progress;
-	refcount_t count;
-};
-
-/* Once caching_thread() finds this much free space, it will wake up waiters. */
-#define CACHING_CTL_WAKE_UP SZ_2M
-
 struct btrfs_io_ctl {
 	void *cur, *orig;
 	struct page *page;
@@ -473,120 +454,6 @@ struct btrfs_full_stripe_locks_tree {
 	struct mutex lock;
 };
 
-struct btrfs_block_group_cache {
-	struct btrfs_key key;
-	struct btrfs_block_group_item item;
-	struct btrfs_fs_info *fs_info;
-	struct inode *inode;
-	spinlock_t lock;
-	u64 pinned;
-	u64 reserved;
-	u64 delalloc_bytes;
-	u64 bytes_super;
-	u64 flags;
-	u64 cache_generation;
-
-	/*
-	 * If the free space extent count exceeds this number, convert the block
-	 * group to bitmaps.
-	 */
-	u32 bitmap_high_thresh;
-
-	/*
-	 * If the free space extent count drops below this number, convert the
-	 * block group back to extents.
-	 */
-	u32 bitmap_low_thresh;
-
-	/*
-	 * It is just used for the delayed data space allocation because
-	 * only the data space allocation and the relative metadata update
-	 * can be done cross the transaction.
-	 */
-	struct rw_semaphore data_rwsem;
-
-	/* for raid56, this is a full stripe, without parity */
-	unsigned long full_stripe_len;
-
-	unsigned int ro;
-	unsigned int iref:1;
-	unsigned int has_caching_ctl:1;
-	unsigned int removed:1;
-
-	int disk_cache_state;
-
-	/* cache tracking stuff */
-	int cached;
-	struct btrfs_caching_control *caching_ctl;
-	u64 last_byte_to_unpin;
-
-	struct btrfs_space_info *space_info;
-
-	/* free space cache stuff */
-	struct btrfs_free_space_ctl *free_space_ctl;
-
-	/* block group cache stuff */
-	struct rb_node cache_node;
-
-	/* for block groups in the same raid type */
-	struct list_head list;
-
-	/* usage count */
-	atomic_t count;
-
-	/* List of struct btrfs_free_clusters for this block group.
-	 * Today it will only have one thing on it, but that may change
-	 */
-	struct list_head cluster_list;
-
-	/* For delayed block group creation or deletion of empty block groups */
-	struct list_head bg_list;
-
-	/* For read-only block groups */
-	struct list_head ro_list;
-
-	atomic_t trimming;
-
-	/* For dirty block groups */
-	struct list_head dirty_list;
-	struct list_head io_list;
-
-	struct btrfs_io_ctl io_ctl;
-
-	/*
-	 * Incremented when doing extent allocations and holding a read lock
-	 * on the space_info's groups_sem semaphore.
-	 * Decremented when an ordered extent that represents an IO against this
-	 * block group's range is created (after it's added to its inode's
-	 * root's list of ordered extents) or immediately after the allocation
-	 * if it's a metadata extent or fallocate extent (for these cases we
-	 * don't create ordered extents).
-	 */
-	atomic_t reservations;
-
-	/*
-	 * Incremented while holding the spinlock *lock* by a task checking if
-	 * it can perform a nocow write (incremented if the value for the *ro*
-	 * field is 0). Decremented by such tasks once they create an ordered
-	 * extent or before that if some error happens before reaching that step.
-	 * This is to prevent races between block group relocation and nocow
-	 * writes through direct IO.
-	 */
-	atomic_t nocow_writers;
-
-	/* Lock for free space tree operations. */
-	struct mutex free_space_lock;
-
-	/*
-	 * Does the block group need to be added to the free space tree?
-	 * Protected by free_space_lock.
-	 */
-	int needs_free_space;
-
-	/* Record locked full stripes for RAID5/6 block group */
-	struct btrfs_full_stripe_locks_tree full_stripe_locks_root;
-};
-
 /* delayed seq elem */
 struct seq_list {
 	struct list_head list;
@@ -1364,19 +1231,6 @@ static inline u32 BTRFS_MAX_XATTR_SIZE(const struct btrfs_fs_info *info)
 	btrfs_clear_opt(fs_info->mount_opt, opt);			\
 }
 
-#ifdef CONFIG_BTRFS_DEBUG
-static inline int
-btrfs_should_fragment_free_space(struct btrfs_block_group_cache *block_group)
-{
-	struct btrfs_fs_info *fs_info = block_group->fs_info;
-
-	return (btrfs_test_opt(fs_info, FRAGMENT_METADATA) &&
-		block_group->flags & BTRFS_BLOCK_GROUP_METADATA) ||
-	       (btrfs_test_opt(fs_info, FRAGMENT_DATA) &&
-		block_group->flags &  BTRFS_BLOCK_GROUP_DATA);
-}
-#endif
-
 /*
  * Requests for changes that need to be done during transaction commit.
  *
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 874913eaea8c..15b4e3221e7f 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -40,6 +40,7 @@
 #include "compression.h"
 #include "tree-checker.h"
 #include "ref-verify.h"
+#include "block-group.h"
 
 #define BTRFS_SUPER_FLAG_SUPP	(BTRFS_HEADER_FLAG_WRITTEN |\
 				 BTRFS_HEADER_FLAG_RELOC |\
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index a0115e019ee8..aeb8daf2a640 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -31,6 +31,7 @@
 #include "space-info.h"
 #include "block-rsv.h"
 #include "delalloc-space.h"
+#include "block-group.h"
 
 #undef SCRAMBLE_DELAYED_REFS
 
diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
index 92cb06dd94d3..faaf57a7c289 100644
--- a/fs/btrfs/free-space-cache.c
+++ b/fs/btrfs/free-space-cache.c
@@ -20,6 +20,7 @@
 #include "volumes.h"
 #include "space-info.h"
 #include "delalloc-space.h"
+#include "block-group.h"
 
 #define BITS_PER_BITMAP		(PAGE_SIZE * 8UL)
 #define MAX_CACHE_BYTES_PER_GIG	SZ_32K
diff --git a/fs/btrfs/free-space-tree.c b/fs/btrfs/free-space-tree.c
index f5dc115ebba0..48a03f5240f5 100644
--- a/fs/btrfs/free-space-tree.c
+++ b/fs/btrfs/free-space-tree.c
@@ -10,6 +10,7 @@
 #include "locking.h"
 #include "free-space-tree.h"
 #include "transaction.h"
+#include "block-group.h"
 
 static int __add_block_group_free_space(struct btrfs_trans_handle *trans,
 					struct btrfs_block_group_cache *block_group,
diff --git a/fs/btrfs/free-space-tree.h b/fs/btrfs/free-space-tree.h
index 22b7602bde25..360d50e1cdea 100644
--- a/fs/btrfs/free-space-tree.h
+++ b/fs/btrfs/free-space-tree.h
@@ -6,6 +6,8 @@
 #ifndef BTRFS_FREE_SPACE_TREE_H
 #define BTRFS_FREE_SPACE_TREE_H
 
+struct btrfs_caching_control;
+
 /*
  * The default size for new free space bitmap items. The last bitmap in a block
  * group may be truncated, and none of the free space tree code assumes that
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 8e389c51f4e9..9f45f5a0557f 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -48,6 +48,7 @@
 #include "qgroup.h"
 #include "dedupe.h"
 #include "delalloc-space.h"
+#include "block-group.h"
 
 struct btrfs_iget_args {
 	struct btrfs_key *location;
diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index bae04a4f09d2..0ce6de929755 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -45,6 +45,7 @@
 #include "compression.h"
 #include "space-info.h"
 #include "delalloc-space.h"
+#include "block-group.h"
 
 #ifdef CONFIG_64BIT
 /* If we have a 32-bit userspace and 64-bit kernel, then the UAPI
diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
index 3e6ffbbd8b0a..0765a81fa4da 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -21,7 +21,7 @@
 #include "backref.h"
 #include "extent_io.h"
 #include "qgroup.h"
-
+#include "block-group.h"
 
 /* TODO XXX FIXME
  *  - subvol delete -> delete when ref goes to 0? delete limits also?
diff --git a/fs/btrfs/reada.c b/fs/btrfs/reada.c
index 10d9589001a9..b74daf633832 100644
--- a/fs/btrfs/reada.c
+++ b/fs/btrfs/reada.c
@@ -14,6 +14,7 @@
 #include "disk-io.h"
 #include "transaction.h"
 #include "dev-replace.h"
+#include "block-group.h"
 
 #undef DEBUG
 
diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 7f219851fa23..c857cdc911c7 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -21,6 +21,7 @@
 #include "qgroup.h"
 #include "print-tree.h"
 #include "delalloc-space.h"
+#include "block-group.h"
 
 /*
  * backref_node, mapping_node and tree_block start with this
diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index 9f0297d529d4..d4cc3e4f4126 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -18,6 +18,7 @@
 #include "check-integrity.h"
 #include "rcu-string.h"
 #include "raid56.h"
+#include "block-group.h"
 
 /*
  * This is only the first step towards a full-features scrub. It reads all
diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index 4efb817d1f0f..792509ddacb9 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -11,6 +11,7 @@
 #include "ordered-data.h"
 #include "transaction.h"
 #include "math.h"
+#include "block-group.h"
 
 u64 btrfs_space_info_used(struct btrfs_space_info *s_info,
 			  bool may_use_included)
diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 267f74b2ea8b..d71c46f671df 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -44,6 +44,7 @@
 #include "backref.h"
 #include "space-info.h"
 #include "tests/btrfs-tests.h"
+#include "block-group.h"
 
 #include "qgroup.h"
 #define CREATE_TRACE_POINTS
diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index e6493b068294..524ca61225ed 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -17,6 +17,7 @@
 #include "sysfs.h"
 #include "volumes.h"
 #include "space-info.h"
+#include "block-group.h"
 
 static inline struct btrfs_fs_info *to_fs_info(struct kobject *kobj);
 static inline struct btrfs_fs_devices *to_fs_devs(struct kobject *kobj);
diff --git a/fs/btrfs/tests/btrfs-tests.c b/fs/btrfs/tests/btrfs-tests.c
index 9238fd4f1734..aba8c9f56d3a 100644
--- a/fs/btrfs/tests/btrfs-tests.c
+++ b/fs/btrfs/tests/btrfs-tests.c
@@ -14,6 +14,7 @@
 #include "../volumes.h"
 #include "../disk-io.h"
 #include "../qgroup.h"
+#include "../block-group.h"
 
 static struct vfsmount *test_mnt = NULL;
 
diff --git a/fs/btrfs/tests/free-space-tests.c b/fs/btrfs/tests/free-space-tests.c
index af89f66f9e63..43ec7060fcd2 100644
--- a/fs/btrfs/tests/free-space-tests.c
+++ b/fs/btrfs/tests/free-space-tests.c
@@ -8,6 +8,7 @@
 #include "../ctree.h"
 #include "../disk-io.h"
 #include "../free-space-cache.h"
+#include "../block-group.h"
 
 #define BITS_PER_BITMAP		(PAGE_SIZE * 8UL)
 
diff --git a/fs/btrfs/tests/free-space-tree-tests.c b/fs/btrfs/tests/free-space-tree-tests.c
index a90dad166971..bc92df977630 100644
--- a/fs/btrfs/tests/free-space-tree-tests.c
+++ b/fs/btrfs/tests/free-space-tree-tests.c
@@ -9,6 +9,7 @@
 #include "../disk-io.h"
 #include "../free-space-tree.h"
 #include "../transaction.h"
+#include "../block-group.h"
 
 struct free_space_extent {
 	u64 start;
diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index 3b8ae1a8f02d..5ce5a5adff31 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -19,6 +19,7 @@
 #include "volumes.h"
 #include "dev-replace.h"
 #include "qgroup.h"
+#include "block-group.h"
 
 #define BTRFS_ROOT_TRANS_TAG 0
 
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 68bc894ec48e..09c99f56aac2 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -29,6 +29,7 @@
 #include "sysfs.h"
 #include "tree-checker.h"
 #include "space-info.h"
+#include "block-group.h"
 
 const struct btrfs_raid_attr btrfs_raid_array[BTRFS_NR_RAID_TYPES] = {
 	[BTRFS_RAID_RAID10] = {
-- 
2.14.3

