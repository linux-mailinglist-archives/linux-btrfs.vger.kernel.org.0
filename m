Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35FD46742FF
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 Jan 2023 20:40:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230491AbjASTkP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 19 Jan 2023 14:40:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230499AbjASTjv (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 19 Jan 2023 14:39:51 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73BF19373D
        for <linux-btrfs@vger.kernel.org>; Thu, 19 Jan 2023 11:39:49 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0AE5261D23
        for <linux-btrfs@vger.kernel.org>; Thu, 19 Jan 2023 19:39:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01B62C433F0
        for <linux-btrfs@vger.kernel.org>; Thu, 19 Jan 2023 19:39:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674157188;
        bh=edcfNdFSwDx9LPVNFT3b8hURuIK97kxk61HDwOveid8=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=Qw8ZAhTgtfO1aRENKDKc46OfplmvRYMD0+aJl/jfpP3knqm5fzI+MaNdbNKwNIpiU
         H13jc1JejXGeIzKPvIEpkfgzZBQSp9nywxUrQuqteDMyfmaD1BVbe27/iCA23OFpP6
         nlXqHVUpo0tJHMPjB5ahM3PnJL45oudZQw9ChenC8sbgbu/BOebvV2FJEGa34zz4tL
         hPKa0STp6zcJtMd4Zsycs9D300jriBiau9jkR8y9+uLilOB98dA4CmOIEm+M9iUjE2
         XQA5TZGSiNqtZc/4sujsB4CNHWLLtpb2oX7lxNK/I6m/nsBnUcvv4C9cHMUZew7wB8
         3/ZtOUJs4apsg==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 16/18] btrfs: send: use the lru cache to implement the name cache
Date:   Thu, 19 Jan 2023 19:39:28 +0000
Message-Id: <a1c6cda8f6154519dc7b78e0dd141464043b895e.1674157020.git.fdmanana@suse.com>
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

The name cache in send is basically a lru cache implemented with a radix
tree and linked lists, very similar to the lru cache module which is used
for the send backref cache and the cache of previously created directories
during a send operation. So remove all the custom caching code for the
name cache and make it use the lru cache instead.

One particular detail to note is that the current cache behaves a bit
differently when it comes to eviction of entries. Namely when after
inserting a new name in the cache, if the cache now has 256 entries, we
evict the last 128 LRU entries. The lru_cache.{c,h} module behaves a bit
differently in that once we reach the cache limit, we evict a single LRU
entry. In practice this doesn't make much difference, but it's actually
better to evict just one entry instead of half of the entries, as there's
always a chance we will need a name stored in one of that last 128 removed
entries.

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
 fs/btrfs/send.c | 164 +++++++-----------------------------------------
 1 file changed, 24 insertions(+), 140 deletions(-)

diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index 3966f8ce7e49..7d327d977fa0 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -81,8 +81,7 @@ struct clone_root {
 	bool found_ref;
 };
 
-#define SEND_CTX_MAX_NAME_CACHE_SIZE 128
-#define SEND_CTX_NAME_CACHE_CLEAN_SIZE (SEND_CTX_MAX_NAME_CACHE_SIZE * 2)
+#define SEND_MAX_NAME_CACHE_SIZE 256
 
 /*
  * Limit the root_ids array of struct backref_cache_entry to 12 elements.
@@ -183,9 +182,7 @@ struct send_ctx {
 	struct list_head new_refs;
 	struct list_head deleted_refs;
 
-	struct radix_tree_root name_cache;
-	struct list_head name_cache_list;
-	int name_cache_size;
+	struct btrfs_lru_cache name_cache;
 
 	/*
 	 * The inode we are currently processing. It's not NULL only when we
@@ -331,18 +328,11 @@ struct orphan_dir_info {
 };
 
 struct name_cache_entry {
-	struct list_head list;
 	/*
-	 * radix_tree has only 32bit entries but we need to handle 64bit inums.
-	 * We use the lower 32bit of the 64bit inum to store it in the tree. If
-	 * more then one inum would fall into the same entry, we use radix_list
-	 * to store the additional entries. radix_list is also used to store
-	 * entries where two entries have the same inum but different
-	 * generations.
+	 * The key in the entry is an inode number, and the generation matches
+	 * the inode's generation.
 	 */
-	struct list_head radix_list;
-	u64 ino;
-	u64 gen;
+	struct btrfs_lru_cache_entry entry;
 	u64 parent_ino;
 	u64 parent_gen;
 	int ret;
@@ -351,6 +341,9 @@ struct name_cache_entry {
 	char name[];
 };
 
+/* See the comment at lru_cache.h about struct btrfs_lru_cache_entry. */
+static_assert(offsetof(struct name_cache_entry, entry) == 0);
+
 #define ADVANCE							1
 #define ADVANCE_ONLY_NEXT					-1
 
@@ -2261,113 +2254,16 @@ static int did_overwrite_first_ref(struct send_ctx *sctx, u64 ino, u64 gen)
 	return ret;
 }
 
-/*
- * Insert a name cache entry. On 32bit kernels the radix tree index is 32bit,
- * so we need to do some special handling in case we have clashes. This function
- * takes care of this with the help of name_cache_entry::radix_list.
- * In case of error, nce is kfreed.
- */
-static int name_cache_insert(struct send_ctx *sctx,
-			     struct name_cache_entry *nce)
-{
-	int ret = 0;
-	struct list_head *nce_head;
-
-	nce_head = radix_tree_lookup(&sctx->name_cache,
-			(unsigned long)nce->ino);
-	if (!nce_head) {
-		nce_head = kmalloc(sizeof(*nce_head), GFP_KERNEL);
-		if (!nce_head) {
-			kfree(nce);
-			return -ENOMEM;
-		}
-		INIT_LIST_HEAD(nce_head);
-
-		ret = radix_tree_insert(&sctx->name_cache, nce->ino, nce_head);
-		if (ret < 0) {
-			kfree(nce_head);
-			kfree(nce);
-			return ret;
-		}
-	}
-	list_add_tail(&nce->radix_list, nce_head);
-	list_add_tail(&nce->list, &sctx->name_cache_list);
-	sctx->name_cache_size++;
-
-	return ret;
-}
-
-static void name_cache_delete(struct send_ctx *sctx,
-			      struct name_cache_entry *nce)
-{
-	struct list_head *nce_head;
-
-	nce_head = radix_tree_lookup(&sctx->name_cache,
-			(unsigned long)nce->ino);
-	if (!nce_head) {
-		btrfs_err(sctx->send_root->fs_info,
-	      "name_cache_delete lookup failed ino %llu cache size %d, leaking memory",
-			nce->ino, sctx->name_cache_size);
-	}
-
-	list_del(&nce->radix_list);
-	list_del(&nce->list);
-	sctx->name_cache_size--;
-
-	/*
-	 * We may not get to the final release of nce_head if the lookup fails
-	 */
-	if (nce_head && list_empty(nce_head)) {
-		radix_tree_delete(&sctx->name_cache, (unsigned long)nce->ino);
-		kfree(nce_head);
-	}
-}
-
-static struct name_cache_entry *name_cache_search(struct send_ctx *sctx,
-						    u64 ino, u64 gen)
+static inline struct name_cache_entry *name_cache_search(struct send_ctx *sctx,
+							 u64 ino, u64 gen)
 {
-	struct list_head *nce_head;
-	struct name_cache_entry *cur;
+	struct btrfs_lru_cache_entry *entry;
 
-	nce_head = radix_tree_lookup(&sctx->name_cache, (unsigned long)ino);
-	if (!nce_head)
+	entry = btrfs_lru_cache_lookup(&sctx->name_cache, ino, gen);
+	if (!entry)
 		return NULL;
 
-	list_for_each_entry(cur, nce_head, radix_list) {
-		if (cur->ino == ino && cur->gen == gen)
-			return cur;
-	}
-	return NULL;
-}
-
-/*
- * Remove some entries from the beginning of name_cache_list.
- */
-static void name_cache_clean_unused(struct send_ctx *sctx)
-{
-	struct name_cache_entry *nce;
-
-	if (sctx->name_cache_size < SEND_CTX_NAME_CACHE_CLEAN_SIZE)
-		return;
-
-	while (sctx->name_cache_size > SEND_CTX_MAX_NAME_CACHE_SIZE) {
-		nce = list_entry(sctx->name_cache_list.next,
-				struct name_cache_entry, list);
-		name_cache_delete(sctx, nce);
-		kfree(nce);
-	}
-}
-
-static void name_cache_free(struct send_ctx *sctx)
-{
-	struct name_cache_entry *nce;
-
-	while (!list_empty(&sctx->name_cache_list)) {
-		nce = list_entry(sctx->name_cache_list.next,
-				struct name_cache_entry, list);
-		name_cache_delete(sctx, nce);
-		kfree(nce);
-	}
+	return container_of(entry, struct name_cache_entry, entry);
 }
 
 /*
@@ -2386,7 +2282,7 @@ static int __get_cur_name_and_parent(struct send_ctx *sctx,
 {
 	int ret;
 	int nce_ret;
-	struct name_cache_entry *nce = NULL;
+	struct name_cache_entry *nce;
 
 	/*
 	 * First check if we already did a call to this function with the same
@@ -2396,17 +2292,9 @@ static int __get_cur_name_and_parent(struct send_ctx *sctx,
 	nce = name_cache_search(sctx, ino, gen);
 	if (nce) {
 		if (ino < sctx->send_progress && nce->need_later_update) {
-			name_cache_delete(sctx, nce);
-			kfree(nce);
+			btrfs_lru_cache_remove(&sctx->name_cache, &nce->entry);
 			nce = NULL;
 		} else {
-			/*
-			 * Removes the entry from the list and adds it back to
-			 * the end.  This marks the entry as recently used so
-			 * that name_cache_clean_unused does not remove it.
-			 */
-			list_move_tail(&nce->list, &sctx->name_cache_list);
-
 			*parent_ino = nce->parent_ino;
 			*parent_gen = nce->parent_gen;
 			ret = fs_path_add(dest, nce->name, nce->name_len);
@@ -2473,8 +2361,8 @@ static int __get_cur_name_and_parent(struct send_ctx *sctx,
 		goto out;
 	}
 
-	nce->ino = ino;
-	nce->gen = gen;
+	nce->entry.key = ino;
+	nce->entry.gen = gen;
 	nce->parent_ino = *parent_ino;
 	nce->parent_gen = *parent_gen;
 	nce->name_len = fs_path_len(dest);
@@ -2486,10 +2374,9 @@ static int __get_cur_name_and_parent(struct send_ctx *sctx,
 	else
 		nce->need_later_update = 1;
 
-	nce_ret = name_cache_insert(sctx, nce);
+	nce_ret = btrfs_lru_cache_store(&sctx->name_cache, &nce->entry, GFP_KERNEL);
 	if (nce_ret < 0)
 		ret = nce_ret;
-	name_cache_clean_unused(sctx);
 
 out:
 	return ret;
@@ -4356,10 +4243,9 @@ static int process_recorded_refs(struct send_ctx *sctx, int *pending_move)
 				 * and get instead the orphan name.
 				 */
 				nce = name_cache_search(sctx, ow_inode, ow_gen);
-				if (nce) {
-					name_cache_delete(sctx, nce);
-					kfree(nce);
-				}
+				if (nce)
+					btrfs_lru_cache_remove(&sctx->name_cache,
+							       &nce->entry);
 
 				/*
 				 * ow_inode might currently be an ancestor of
@@ -8143,9 +8029,8 @@ long btrfs_ioctl_send(struct inode *inode, struct btrfs_ioctl_send_args *arg)
 
 	INIT_LIST_HEAD(&sctx->new_refs);
 	INIT_LIST_HEAD(&sctx->deleted_refs);
-	INIT_RADIX_TREE(&sctx->name_cache, GFP_KERNEL);
-	INIT_LIST_HEAD(&sctx->name_cache_list);
 
+	btrfs_lru_cache_init(&sctx->name_cache, SEND_MAX_NAME_CACHE_SIZE);
 	btrfs_lru_cache_init(&sctx->backref_cache, SEND_MAX_BACKREF_CACHE_SIZE);
 	btrfs_lru_cache_init(&sctx->dir_created_cache,
 			     SEND_MAX_DIR_CREATED_CACHE_SIZE);
@@ -8408,10 +8293,9 @@ long btrfs_ioctl_send(struct inode *inode, struct btrfs_ioctl_send_args *arg)
 		kvfree(sctx->send_buf);
 		kvfree(sctx->verity_descriptor);
 
-		name_cache_free(sctx);
-
 		close_current_inode(sctx);
 
+		btrfs_lru_cache_clear(&sctx->name_cache);
 		btrfs_lru_cache_clear(&sctx->backref_cache);
 		btrfs_lru_cache_clear(&sctx->dir_created_cache);
 
-- 
2.35.1

