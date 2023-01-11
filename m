Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4598A665A69
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Jan 2023 12:39:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238397AbjAKLjk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 11 Jan 2023 06:39:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238380AbjAKLjJ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 11 Jan 2023 06:39:09 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5905BE3C
        for <linux-btrfs@vger.kernel.org>; Wed, 11 Jan 2023 03:36:39 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 41FBCB81BAD
        for <linux-btrfs@vger.kernel.org>; Wed, 11 Jan 2023 11:36:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A017C433D2
        for <linux-btrfs@vger.kernel.org>; Wed, 11 Jan 2023 11:36:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673436997;
        bh=9j5W0lVj6TIU1yHV7NhWjifyNHGaw9QD8f4IlOIMQeE=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=M6sfizGH1RdJH9uTUYtDnGeywS3ETEDob4S5njDP9A8FPM2C67jGlOtHvcksCcG1n
         p+LB5eGzkvM7eaT6SiHytwti4IhLbwmdRvJCyQq9TjYKr+aRHeB565KnVSawm5CKTB
         NRUn5hi+GSK5qrzQG7ocP0abS5rdSaat/vUdqqGxoW+OqVHX1so6GSuvPp9jzZqkig
         aDqM/JLcEUybA2PvBXBfX2xbwFouUeTWhNjkypg0d7RsWw8sqGXmrSfJA1hwNy6Q+5
         rvLrrIn3udUHnkQ0qP2v7+M83du70/JpOMZR8li8eLqx4uRP+XyGATk7VSciX6dpNH
         jyG+LlNOKmhJQ==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 15/19] btrfs: allow a generation number to be associated with lru cache entries
Date:   Wed, 11 Jan 2023 11:36:16 +0000
Message-Id: <226a658a3260bb4b25b43bc08345a79c8578fe9f.1673436276.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1673436276.git.fdmanana@suse.com>
References: <cover.1673436276.git.fdmanana@suse.com>
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

This allows an optional generation number to be associated to each entry
of the lru cache. Entries with the same key but different generations, are
stored in the linked list to which the maple tree points to. This is meant
to be used when there's a small number of different generations, so the
impact of searching a linked list is negligible. The goal is to get rid of
the open coded name cache in the send code (which uses a radix tree and a
a similar linked list of values/entries) and use instead the lru cache
module. For that particular use case we have at most 2 generations that
are associated to each key (inode number): one generation for the send
root and another generation for the parent root. The actual migration of
the send name cache is done in the next patch in the series.

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
  btrfs: send: use MT_FLAGS_LOCK_EXTERN for the backref cache maple tree
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
 fs/btrfs/lru_cache.c | 12 +++++++-----
 fs/btrfs/lru_cache.h |  9 ++++++++-
 fs/btrfs/send.c      |  8 +++++---
 3 files changed, 20 insertions(+), 9 deletions(-)

diff --git a/fs/btrfs/lru_cache.c b/fs/btrfs/lru_cache.c
index 10c1f9ceb706..d85341946213 100644
--- a/fs/btrfs/lru_cache.c
+++ b/fs/btrfs/lru_cache.c
@@ -18,12 +18,13 @@ void btrfs_lru_cache_init(struct btrfs_lru_cache *cache, unsigned int max_size)
 	cache->max_size = max_size;
 }
 
-static struct btrfs_lru_cache_entry *match_entry(struct list_head *head, u64 key)
+static struct btrfs_lru_cache_entry *match_entry(struct list_head *head, u64 key,
+						 u64 gen)
 {
 	struct btrfs_lru_cache_entry *entry;
 
 	list_for_each_entry(entry, head, list)
-		if (entry->key == key)
+		if (entry->key == key && entry->gen == gen)
 			return entry;
 
 	return NULL;
@@ -34,11 +35,12 @@ static struct btrfs_lru_cache_entry *match_entry(struct list_head *head, u64 key
  *
  * @cache:      The cache.
  * @key:        The key of the entry we are looking for.
+ * @gen:        Generation associated to the key.
  *
  * Returns the entry associated with the key or NULL if none found.
  */
 struct btrfs_lru_cache_entry *btrfs_lru_cache_lookup(struct btrfs_lru_cache *cache,
-						     u64 key)
+						     u64 key, u64 gen)
 {
 	struct list_head *head;
 	struct btrfs_lru_cache_entry *entry;
@@ -47,7 +49,7 @@ struct btrfs_lru_cache_entry *btrfs_lru_cache_lookup(struct btrfs_lru_cache *cac
 	if (!head)
 		return NULL;
 
-	entry = match_entry(head, key);
+	entry = match_entry(head, key, gen);
 	if (entry)
 		list_move_tail(&entry->lru_list, &cache->lru_list);
 
@@ -110,7 +112,7 @@ int btrfs_lru_cache_store(struct btrfs_lru_cache *cache,
 		kfree(head);
 		head = mtree_load(&cache->entries, key);
 		ASSERT(head != NULL);
-		if (match_entry(head, key) != NULL)
+		if (match_entry(head, key, new_entry->gen) != NULL)
 			return -EEXIST;
 		list_add_tail(&new_entry->list, head);
 	} else if (ret < 0) {
diff --git a/fs/btrfs/lru_cache.h b/fs/btrfs/lru_cache.h
index 368248be42a2..de887d438cfb 100644
--- a/fs/btrfs/lru_cache.h
+++ b/fs/btrfs/lru_cache.h
@@ -17,6 +17,13 @@
 struct btrfs_lru_cache_entry {
 	struct list_head lru_list;
 	u64 key;
+	/*
+	 * Optional generation associated to a key. Use 0 if not needed/used.
+	 * Entries with the same key and different generations are stored in a
+	 * linked list, so use this only for cases where there's a small number
+	 * of different generations.
+	 */
+	u64 gen;
 	/*
 	 * The maple tree uses unsigned long type for the keys, which is 32 bits
 	 * on 32 bits systems, and 64 bits on 64 bits systems. So if we want to
@@ -47,7 +54,7 @@ static inline unsigned int btrfs_lru_cache_size(const struct btrfs_lru_cache *ca
 
 void btrfs_lru_cache_init(struct btrfs_lru_cache *cache, unsigned int max_size);
 struct btrfs_lru_cache_entry *btrfs_lru_cache_lookup(struct btrfs_lru_cache *cache,
-						     u64 key);
+						     u64 key, u64 gen);
 int btrfs_lru_cache_store(struct btrfs_lru_cache *cache,
 			  struct btrfs_lru_cache_entry *new_entry,
 			  gfp_t gfp);
diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index bc232eb60e68..3966f8ce7e49 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -120,7 +120,7 @@ static_assert(offsetof(struct backref_cache_entry, entry) == 0);
 /*
  * Max number of entries in the cache that stores directories that were already
  * created. The cache uses raw struct btrfs_lru_cache_entry entries, so it uses
- * at most 4096 bytes - sizeof(struct btrfs_lru_cache_entry) is 40 bytes, but
+ * at most 4096 bytes - sizeof(struct btrfs_lru_cache_entry) is 48 bytes, but
  * the kmalloc-64 slab is used, so we get 4096 bytes (64 bytes * 64).
  */
 #define SEND_MAX_DIR_CREATED_CACHE_SIZE 64
@@ -1422,7 +1422,7 @@ static bool lookup_backref_cache(u64 leaf_bytenr, void *ctx,
 		return false;
 	}
 
-	raw_entry = btrfs_lru_cache_lookup(&sctx->backref_cache, key);
+	raw_entry = btrfs_lru_cache_lookup(&sctx->backref_cache, key, 0);
 	if (!raw_entry)
 		return false;
 
@@ -1455,6 +1455,7 @@ static void store_backref_cache(u64 leaf_bytenr, const struct ulist *root_ids,
 		return;
 
 	new_entry->entry.key = leaf_bytenr >> fs_info->sectorsize_bits;
+	new_entry->entry.gen = 0;
 	new_entry->num_roots = 0;
 	ULIST_ITER_INIT(&uiter);
 	while ((node = ulist_next(root_ids, &uiter)) != NULL) {
@@ -2957,6 +2958,7 @@ static void cache_dir_created(struct send_ctx *sctx, u64 dir)
 		return;
 
 	entry->key = dir;
+	entry->gen = 0;
 	ret = btrfs_lru_cache_store(&sctx->dir_created_cache, entry, GFP_KERNEL);
 	if (ret < 0)
 		kfree(entry);
@@ -2977,7 +2979,7 @@ static int did_create_dir(struct send_ctx *sctx, u64 dir)
 	struct btrfs_key di_key;
 	struct btrfs_dir_item *di;
 
-	if (btrfs_lru_cache_lookup(&sctx->dir_created_cache, dir))
+	if (btrfs_lru_cache_lookup(&sctx->dir_created_cache, dir, 0))
 		return 1;
 
 	path = alloc_path_for_send();
-- 
2.35.1

