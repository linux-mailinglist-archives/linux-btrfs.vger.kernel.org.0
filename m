Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED8DF6742FC
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 Jan 2023 20:40:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230502AbjASTjv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 19 Jan 2023 14:39:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230491AbjASTjr (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 19 Jan 2023 14:39:47 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28328A5FD
        for <linux-btrfs@vger.kernel.org>; Thu, 19 Jan 2023 11:39:45 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A38AA61D59
        for <linux-btrfs@vger.kernel.org>; Thu, 19 Jan 2023 19:39:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CFE0C433F0
        for <linux-btrfs@vger.kernel.org>; Thu, 19 Jan 2023 19:39:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674157184;
        bh=fPoTMWyYA1ILhMLB+0rjRlkVG8J4spXI8RdtvJ7EAug=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=YGnpy05K3/DcCgnbahdUI183+xmYponZB7wcKJWp9wbfWMZaDLlrZhWn1N7L9E7Si
         rwKreRhZ9QDius2WOmE8nTMrjxYYPnOd8pHfz0fa6kSX1byiHKx5UD8N8XVR/Fk68w
         Rl7p9ZATyUzpSPOYZkaxTp3ESPifmj+khk/p8M7iurqb+Co94duWCOp9aeyDwgWfha
         tEPOQorXqCFka+IbTs75AFKecc2fiyy5zVVqWq2C+56ZPYmFzd692ugO4Y1mjozuWq
         qydZRnBMwi2cZ0pRP8TH5dI+8toux9uoKHvn97vGUmeapkgzDpS+amW9JF8yXjiviO
         W3Wq7UHcovWfw==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 11/18] btrfs: send: genericize the backref cache to allow it to be reused
Date:   Thu, 19 Jan 2023 19:39:23 +0000
Message-Id: <7985d2b1ee134dab7f55c1a12f964327ec898ae6.1674157020.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1674157020.git.fdmanana@suse.com>
References: <cover.1674157020.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

The backref cache is a cache backed by a maple tree and a linked list to
keep track of temporal access to cached entries (the LRU entry always at
the head of the list). This type of caching method is going to be useful
in other scenarios, so make the cache implementation more generic and
move it into its own header and source files.

This patch is part of a larger patchset and the changelog of the last
patch in the series contains a sample performance test and results.
The patches that comprise the patchset are the following:

  btrfs: send: directly return from did_overwrite_ref() and simplify it
  btrfs: send: avoid unnecessary generation search at did_overwrite_ref()
  btrfs: send: directly return from will_overwrite_ref() and simplify it
  btrfs: send: avoid extra b+tree searches when checking reference overrides
  btrfs: send: remove send_progress argument from can_rmdir()
  btrfs: send: avoid duplicated orphan dir allocation and initialization
  btrfs: send: avoid unnecessary orphan dir rbtree search at can_rmdir()
  btrfs: send: reduce searches on parent root when checking if dir can be removed
  btrfs: send: iterate waiting dir move rbtree only once when processing refs
  btrfs: send: initialize all the red black trees earlier
  btrfs: send: genericize the backref cache to allow it to be reused
  btrfs: adapt lru cache to allow for 64 bits keys on 32 bits systems
  btrfs: send: cache information about created directories
  btrfs: allow a generation number to be associated with lru cache entries
  btrfs: add an api to delete a specific entry from the lru cache
  btrfs: send: use the lru cache to implement the name cache
  btrfs: send: update size of roots array for backref cache entries
  btrfs: send: cache utimes operations for directories if possible

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/Makefile    |  3 +-
 fs/btrfs/lru_cache.c | 97 ++++++++++++++++++++++++++++++++++++++++++++
 fs/btrfs/lru_cache.h | 44 ++++++++++++++++++++
 fs/btrfs/send.c      | 80 +++++++++++-------------------------
 4 files changed, 167 insertions(+), 57 deletions(-)
 create mode 100644 fs/btrfs/lru_cache.c
 create mode 100644 fs/btrfs/lru_cache.h

diff --git a/fs/btrfs/Makefile b/fs/btrfs/Makefile
index 460eced3f5bd..90d53209755b 100644
--- a/fs/btrfs/Makefile
+++ b/fs/btrfs/Makefile
@@ -32,7 +32,8 @@ btrfs-y += super.o ctree.o extent-tree.o print-tree.o root-tree.o dir-item.o \
 	   backref.o ulist.o qgroup.o send.o dev-replace.o raid56.o \
 	   uuid-tree.o props.o free-space-tree.o tree-checker.o space-info.o \
 	   block-rsv.o delalloc-space.o block-group.o discard.o reflink.o \
-	   subpage.o tree-mod-log.o extent-io-tree.o fs.o messages.o bio.o
+	   subpage.o tree-mod-log.o extent-io-tree.o fs.o messages.o bio.o \
+	   lru_cache.o
 
 btrfs-$(CONFIG_BTRFS_FS_POSIX_ACL) += acl.o
 btrfs-$(CONFIG_BTRFS_FS_CHECK_INTEGRITY) += check-integrity.o
diff --git a/fs/btrfs/lru_cache.c b/fs/btrfs/lru_cache.c
new file mode 100644
index 000000000000..177e7e705363
--- /dev/null
+++ b/fs/btrfs/lru_cache.c
@@ -0,0 +1,97 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/mm.h>
+#include "lru_cache.h"
+#include "messages.h"
+
+/*
+ * Initialize a cache object.
+ *
+ * @cache:      The cache.
+ * @max_size:   Maximum size (number of entries) for the cache.
+ */
+void btrfs_lru_cache_init(struct btrfs_lru_cache *cache, unsigned int max_size)
+{
+	INIT_LIST_HEAD(&cache->lru_list);
+	mt_init(&cache->entries);
+	cache->size = 0;
+	cache->max_size = max_size;
+}
+
+/*
+ * Lookup for an entry in the cache.
+ *
+ * @cache:      The cache.
+ * @key:        The key of the entry we are looking for.
+ *
+ * Returns the entry associated with the key or NULL if none found.
+ */
+struct btrfs_lru_cache_entry *btrfs_lru_cache_lookup(struct btrfs_lru_cache *cache,
+						     u64 key)
+{
+	struct btrfs_lru_cache_entry *entry;
+
+	entry = mtree_load(&cache->entries, key);
+	if (entry)
+		list_move_tail(&entry->lru_list, &cache->lru_list);
+
+	return entry;
+}
+
+/*
+ * Store an entry in the cache.
+ *
+ * @cache:      The cache.
+ * @entry:      The entry to store.
+ *
+ * Returns 0 on success and < 0 on error.
+ */
+int btrfs_lru_cache_store(struct btrfs_lru_cache *cache,
+			  struct btrfs_lru_cache_entry *new_entry,
+			  gfp_t gfp)
+{
+	int ret;
+
+	if (cache->size == cache->max_size) {
+		struct btrfs_lru_cache_entry *lru_entry;
+		struct btrfs_lru_cache_entry *mt_entry;
+
+		lru_entry = list_first_entry(&cache->lru_list,
+					     struct btrfs_lru_cache_entry,
+					     lru_list);
+		mt_entry = mtree_erase(&cache->entries, lru_entry->key);
+		ASSERT(mt_entry == lru_entry);
+		list_del(&mt_entry->lru_list);
+		kfree(mt_entry);
+		cache->size--;
+	}
+
+	ret = mtree_insert(&cache->entries, new_entry->key, new_entry, gfp);
+	if (ret < 0)
+		return ret;
+
+	list_add_tail(&new_entry->lru_list, &cache->lru_list);
+	cache->size++;
+
+	return 0;
+}
+
+/*
+ * Empty a cache.
+ *
+ * @cache:     The cache to empty.
+ *
+ * Removes all entries from the cache.
+ */
+void btrfs_lru_cache_clear(struct btrfs_lru_cache *cache)
+{
+	struct btrfs_lru_cache_entry *entry;
+	struct btrfs_lru_cache_entry *tmp;
+
+	list_for_each_entry_safe(entry, tmp, &cache->lru_list, lru_list)
+		kfree(entry);
+
+	INIT_LIST_HEAD(&cache->lru_list);
+	mtree_destroy(&cache->entries);
+	cache->size = 0;
+}
diff --git a/fs/btrfs/lru_cache.h b/fs/btrfs/lru_cache.h
new file mode 100644
index 000000000000..189be5be0a8d
--- /dev/null
+++ b/fs/btrfs/lru_cache.h
@@ -0,0 +1,44 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef BTRFS_LRU_CACHE_H
+#define BTRFS_LRU_CACHE_H
+
+#include <linux/maple_tree.h>
+#include <linux/list.h>
+
+/*
+ * A cache entry. This is meant to be embedded in a structure of a user of
+ * this module. Similar to how struct list_head and struct rb_node are used.
+ *
+ * Note: it should be embedded as the first element in a struct (offset 0), and
+ * this module assumes it was allocated with kmalloc(), so it calls kfree() when
+ * it needs to free an entry.
+ */
+struct btrfs_lru_cache_entry {
+	struct list_head lru_list;
+	u64 key;
+};
+
+struct btrfs_lru_cache {
+	struct list_head lru_list;
+	struct maple_tree entries;
+	/* Number of entries stored in the cache. */
+	unsigned int size;
+	/* Maximum number of entries the cache can have. */
+	unsigned int max_size;
+};
+
+static inline unsigned int btrfs_lru_cache_size(const struct btrfs_lru_cache *cache)
+{
+	return cache->size;
+}
+
+void btrfs_lru_cache_init(struct btrfs_lru_cache *cache, unsigned int max_size);
+struct btrfs_lru_cache_entry *btrfs_lru_cache_lookup(struct btrfs_lru_cache *cache,
+						     u64 key);
+int btrfs_lru_cache_store(struct btrfs_lru_cache *cache,
+			  struct btrfs_lru_cache_entry *new_entry,
+			  gfp_t gfp);
+void btrfs_lru_cache_clear(struct btrfs_lru_cache *cache);
+
+#endif /* BTRFS_LRU_CACHE_H */
diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index 38319d0354d4..b31af939bea8 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -32,6 +32,7 @@
 #include "file-item.h"
 #include "ioctl.h"
 #include "verity.h"
+#include "lru_cache.h"
 
 /*
  * Maximum number of references an extent can have in order for us to attempt to
@@ -107,15 +108,15 @@ struct clone_root {
  * x86_64).
  */
 struct backref_cache_entry {
-	/* List to link to the cache's lru list. */
-	struct list_head list;
-	/* The key for this entry in the cache. */
-	u64 key;
+	struct btrfs_lru_cache_entry entry;
 	u64 root_ids[SEND_MAX_BACKREF_CACHE_ROOTS];
 	/* Number of valid elements in the root_ids array. */
 	int num_roots;
 };
 
+/* See the comment at lru_cache.h about struct btrfs_lru_cache_entry. */
+static_assert(offsetof(struct backref_cache_entry, entry) == 0);
+
 struct send_ctx {
 	struct file *send_filp;
 	loff_t send_off;
@@ -285,13 +286,8 @@ struct send_ctx {
 	struct rb_root rbtree_new_refs;
 	struct rb_root rbtree_deleted_refs;
 
-	struct {
-		u64 last_reloc_trans;
-		struct list_head lru_list;
-		struct maple_tree entries;
-		/* Number of entries stored in the cache. */
-		int size;
-	} backref_cache;
+	struct btrfs_lru_cache backref_cache;
+	u64 backref_cache_last_reloc_trans;
 };
 
 struct pending_dir_move {
@@ -1387,19 +1383,6 @@ static int iterate_backrefs(u64 ino, u64 offset, u64 num_bytes, u64 root_id,
 	return 0;
 }
 
-static void empty_backref_cache(struct send_ctx *sctx)
-{
-	struct backref_cache_entry *entry;
-	struct backref_cache_entry *tmp;
-
-	list_for_each_entry_safe(entry, tmp, &sctx->backref_cache.lru_list, list)
-		kfree(entry);
-
-	INIT_LIST_HEAD(&sctx->backref_cache.lru_list);
-	mtree_destroy(&sctx->backref_cache.entries);
-	sctx->backref_cache.size = 0;
-}
-
 static bool lookup_backref_cache(u64 leaf_bytenr, void *ctx,
 				 const u64 **root_ids_ret, int *root_count_ret)
 {
@@ -1407,9 +1390,10 @@ static bool lookup_backref_cache(u64 leaf_bytenr, void *ctx,
 	struct send_ctx *sctx = bctx->sctx;
 	struct btrfs_fs_info *fs_info = sctx->send_root->fs_info;
 	const u64 key = leaf_bytenr >> fs_info->sectorsize_bits;
+	struct btrfs_lru_cache_entry *raw_entry;
 	struct backref_cache_entry *entry;
 
-	if (sctx->backref_cache.size == 0)
+	if (btrfs_lru_cache_size(&sctx->backref_cache) == 0)
 		return false;
 
 	/*
@@ -1423,18 +1407,18 @@ static bool lookup_backref_cache(u64 leaf_bytenr, void *ctx,
 	 * transaction handle or holding fs_info->commit_root_sem, so no need
 	 * to take any lock here.
 	 */
-	if (fs_info->last_reloc_trans > sctx->backref_cache.last_reloc_trans) {
-		empty_backref_cache(sctx);
+	if (fs_info->last_reloc_trans > sctx->backref_cache_last_reloc_trans) {
+		btrfs_lru_cache_clear(&sctx->backref_cache);
 		return false;
 	}
 
-	entry = mtree_load(&sctx->backref_cache.entries, key);
-	if (!entry)
+	raw_entry = btrfs_lru_cache_lookup(&sctx->backref_cache, key);
+	if (!raw_entry)
 		return false;
 
+	entry = container_of(raw_entry, struct backref_cache_entry, entry);
 	*root_ids_ret = entry->root_ids;
 	*root_count_ret = entry->num_roots;
-	list_move_tail(&entry->list, &sctx->backref_cache.lru_list);
 
 	return true;
 }
@@ -1460,7 +1444,7 @@ static void store_backref_cache(u64 leaf_bytenr, const struct ulist *root_ids,
 	if (!new_entry)
 		return;
 
-	new_entry->key = leaf_bytenr >> fs_info->sectorsize_bits;
+	new_entry->entry.key = leaf_bytenr >> fs_info->sectorsize_bits;
 	new_entry->num_roots = 0;
 	ULIST_ITER_INIT(&uiter);
 	while ((node = ulist_next(root_ids, &uiter)) != NULL) {
@@ -1488,23 +1472,12 @@ static void store_backref_cache(u64 leaf_bytenr, const struct ulist *root_ids,
 	 * none of the roots is part of the list of roots from which we are
 	 * allowed to clone. Cache the new entry as it's still useful to avoid
 	 * backref walking to determine which roots have a path to the leaf.
+	 *
+	 * Also use GFP_NOFS because we're called while holding a transaction
+	 * handle or while holding fs_info->commit_root_sem.
 	 */
-
-	if (sctx->backref_cache.size >= SEND_MAX_BACKREF_CACHE_SIZE) {
-		struct backref_cache_entry *lru_entry;
-		struct backref_cache_entry *mt_entry;
-
-		lru_entry = list_first_entry(&sctx->backref_cache.lru_list,
-					     struct backref_cache_entry, list);
-		mt_entry = mtree_erase(&sctx->backref_cache.entries, lru_entry->key);
-		ASSERT(mt_entry == lru_entry);
-		list_del(&mt_entry->list);
-		kfree(mt_entry);
-		sctx->backref_cache.size--;
-	}
-
-	ret = mtree_insert(&sctx->backref_cache.entries, new_entry->key,
-			   new_entry, GFP_NOFS);
+	ret = btrfs_lru_cache_store(&sctx->backref_cache, &new_entry->entry,
+				    GFP_NOFS);
 	ASSERT(ret == 0 || ret == -ENOMEM);
 	if (ret) {
 		/* Caching is optional, no worries. */
@@ -1512,17 +1485,13 @@ static void store_backref_cache(u64 leaf_bytenr, const struct ulist *root_ids,
 		return;
 	}
 
-	list_add_tail(&new_entry->list, &sctx->backref_cache.lru_list);
-
 	/*
 	 * We are called from iterate_extent_inodes() while either holding a
 	 * transaction handle or holding fs_info->commit_root_sem, so no need
 	 * to take any lock here.
 	 */
-	if (sctx->backref_cache.size == 0)
-		sctx->backref_cache.last_reloc_trans = fs_info->last_reloc_trans;
-
-	sctx->backref_cache.size++;
+	if (btrfs_lru_cache_size(&sctx->backref_cache) == 1)
+		sctx->backref_cache_last_reloc_trans = fs_info->last_reloc_trans;
 }
 
 static int check_extent_item(u64 bytenr, const struct btrfs_extent_item *ei,
@@ -8139,8 +8108,7 @@ long btrfs_ioctl_send(struct inode *inode, struct btrfs_ioctl_send_args *arg)
 	INIT_RADIX_TREE(&sctx->name_cache, GFP_KERNEL);
 	INIT_LIST_HEAD(&sctx->name_cache_list);
 
-	INIT_LIST_HEAD(&sctx->backref_cache.lru_list);
-	mt_init(&sctx->backref_cache.entries);
+	btrfs_lru_cache_init(&sctx->backref_cache, SEND_MAX_BACKREF_CACHE_SIZE);
 
 	sctx->pending_dir_moves = RB_ROOT;
 	sctx->waiting_dir_moves = RB_ROOT;
@@ -8404,7 +8372,7 @@ long btrfs_ioctl_send(struct inode *inode, struct btrfs_ioctl_send_args *arg)
 
 		close_current_inode(sctx);
 
-		empty_backref_cache(sctx);
+		btrfs_lru_cache_clear(&sctx->backref_cache);
 
 		kfree(sctx);
 	}
-- 
2.35.1

