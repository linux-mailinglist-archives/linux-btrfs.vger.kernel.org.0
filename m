Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D610F674C9B
	for <lists+linux-btrfs@lfdr.de>; Fri, 20 Jan 2023 06:37:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231342AbjATFhd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 20 Jan 2023 00:37:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230168AbjATFgs (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 20 Jan 2023 00:36:48 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4C4159B4A
        for <linux-btrfs@vger.kernel.org>; Thu, 19 Jan 2023 21:33:24 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3AB03B8271B
        for <linux-btrfs@vger.kernel.org>; Thu, 19 Jan 2023 19:39:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DB7EC433D2
        for <linux-btrfs@vger.kernel.org>; Thu, 19 Jan 2023 19:39:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674157185;
        bh=ecDDAqw5cfInxQMnoLZCSI1nzupUv25AKmgpGtVv4f8=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=mlv0+xxflceryloTX3k8x76Bx6WdABryLFom9ohCDk37DKoGAKzPuNFiGulq04aYx
         v+9ahxkUSgCeR5RxZh5nucLB7RhAqzO8Sxt6G7zU/0FzqxLScSLhWPr0q824JUjcJn
         nDpsDyhMf8PE7JI9gH9X46Lz9LzI+eEgPpK2QQi7km+6YTcRIuJjqGB/U1/DV3KeTT
         uHsH4baJm4Urqmxg4Ag/+5kchzPCL+GuIK923GmORQAMyWoMjZ4fX/1S9EaqTu5mbi
         HiMpXMrlMMzhszNrlIL0ckdDiGhROx8fyStvIVl7vYMsz7KIu3WkqrjPaxDdQceM8l
         e7v5arf0v+uAA==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 12/18] btrfs: adapt lru cache to allow for 64 bits keys on 32 bits systems
Date:   Thu, 19 Jan 2023 19:39:24 +0000
Message-Id: <b6bdf894284b4ba75e92b682839254e0d681a626.1674157020.git.fdmanana@suse.com>
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

The lru cache is backed by a maple tree, which uses the unsigned long
type for keys, and that type has a width of 32 bits on 32 bits systems
and a width of 64 bits on 64 bits systems.

Currently there is only one user of the lru cache, the send backref cache,
which uses a sector number as a key, a logical address right shifted by
fs_info->sectorsize_bits, so a 32 bits width is not yet a problem (the
same happens with the radix tree we use to track extent buffers,
fs_info->buffer_radix).

However the next patches in the series will start using the lru cache for
cases where inode numbers are the keys, and the inode numbers are always
64 bits, even if we are running on a 32 bits system.

So adapt the lru cache to allow multiple values under the same key, by
having the maple tree store a head entry that points to a list of entries
instead of pointing to a single entry. This is a similar approach to what
we currently do for the name cache in send (which uses a radix tree that
has indexes with an unsigned long type as well), and will allow later to
use the lru cache for the send name cache as well.

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
 fs/btrfs/lru_cache.c | 86 ++++++++++++++++++++++++++++++++++++--------
 fs/btrfs/lru_cache.h | 12 +++++++
 2 files changed, 83 insertions(+), 15 deletions(-)

diff --git a/fs/btrfs/lru_cache.c b/fs/btrfs/lru_cache.c
index 177e7e705363..96a71bb6a374 100644
--- a/fs/btrfs/lru_cache.c
+++ b/fs/btrfs/lru_cache.c
@@ -18,6 +18,17 @@ void btrfs_lru_cache_init(struct btrfs_lru_cache *cache, unsigned int max_size)
 	cache->max_size = max_size;
 }
 
+static struct btrfs_lru_cache_entry *match_entry(struct list_head *head, u64 key)
+{
+	struct btrfs_lru_cache_entry *entry;
+
+	list_for_each_entry(entry, head, list)
+		if (entry->key == key)
+			return entry;
+
+	return NULL;
+}
+
 /*
  * Lookup for an entry in the cache.
  *
@@ -29,15 +40,48 @@ void btrfs_lru_cache_init(struct btrfs_lru_cache *cache, unsigned int max_size)
 struct btrfs_lru_cache_entry *btrfs_lru_cache_lookup(struct btrfs_lru_cache *cache,
 						     u64 key)
 {
+	struct list_head *head;
 	struct btrfs_lru_cache_entry *entry;
 
-	entry = mtree_load(&cache->entries, key);
+	head = mtree_load(&cache->entries, key);
+	if (!head)
+		return NULL;
+
+	entry = match_entry(head, key);
 	if (entry)
 		list_move_tail(&entry->lru_list, &cache->lru_list);
 
 	return entry;
 }
 
+static void delete_entry(struct btrfs_lru_cache *cache,
+			 struct btrfs_lru_cache_entry *entry)
+{
+	struct list_head *prev = entry->list.prev;
+
+	ASSERT(cache->size > 0);
+	ASSERT(!mtree_empty(&cache->entries));
+
+	list_del(&entry->list);
+	list_del(&entry->lru_list);
+
+	if (list_empty(prev)) {
+		struct list_head *head;
+
+		/*
+		 * If previous element in the list entry->list is now empty, it
+		 * means it's a head entry not pointing to any cached entries,
+		 * so remove it from the maple tree and free it.
+		 */
+		head = mtree_erase(&cache->entries, entry->key);
+		ASSERT(head == prev);
+		kfree(head);
+	}
+
+	kfree(entry);
+	cache->size--;
+}
+
 /*
  * Store an entry in the cache.
  *
@@ -50,26 +94,39 @@ int btrfs_lru_cache_store(struct btrfs_lru_cache *cache,
 			  struct btrfs_lru_cache_entry *new_entry,
 			  gfp_t gfp)
 {
+	const u64 key = new_entry->key;
+	struct list_head *head;
 	int ret;
 
+	head = kmalloc(sizeof(*head), gfp);
+	if (!head)
+		return -ENOMEM;
+
+	ret = mtree_insert(&cache->entries, key, head, gfp);
+	if (ret == 0) {
+		INIT_LIST_HEAD(head);
+		list_add_tail(&new_entry->list, head);
+	} else if (ret == -EEXIST) {
+		kfree(head);
+		head = mtree_load(&cache->entries, key);
+		ASSERT(head != NULL);
+		if (match_entry(head, key) != NULL)
+			return -EEXIST;
+		list_add_tail(&new_entry->list, head);
+	} else if (ret < 0) {
+		kfree(head);
+		return ret;
+	}
+
 	if (cache->size == cache->max_size) {
 		struct btrfs_lru_cache_entry *lru_entry;
-		struct btrfs_lru_cache_entry *mt_entry;
 
 		lru_entry = list_first_entry(&cache->lru_list,
 					     struct btrfs_lru_cache_entry,
 					     lru_list);
-		mt_entry = mtree_erase(&cache->entries, lru_entry->key);
-		ASSERT(mt_entry == lru_entry);
-		list_del(&mt_entry->lru_list);
-		kfree(mt_entry);
-		cache->size--;
+		delete_entry(cache, lru_entry);
 	}
 
-	ret = mtree_insert(&cache->entries, new_entry->key, new_entry, gfp);
-	if (ret < 0)
-		return ret;
-
 	list_add_tail(&new_entry->lru_list, &cache->lru_list);
 	cache->size++;
 
@@ -89,9 +146,8 @@ void btrfs_lru_cache_clear(struct btrfs_lru_cache *cache)
 	struct btrfs_lru_cache_entry *tmp;
 
 	list_for_each_entry_safe(entry, tmp, &cache->lru_list, lru_list)
-		kfree(entry);
+		delete_entry(cache, entry);
 
-	INIT_LIST_HEAD(&cache->lru_list);
-	mtree_destroy(&cache->entries);
-	cache->size = 0;
+	ASSERT(cache->size == 0);
+	ASSERT(mtree_empty(&cache->entries));
 }
diff --git a/fs/btrfs/lru_cache.h b/fs/btrfs/lru_cache.h
index 189be5be0a8d..368248be42a2 100644
--- a/fs/btrfs/lru_cache.h
+++ b/fs/btrfs/lru_cache.h
@@ -17,6 +17,18 @@
 struct btrfs_lru_cache_entry {
 	struct list_head lru_list;
 	u64 key;
+	/*
+	 * The maple tree uses unsigned long type for the keys, which is 32 bits
+	 * on 32 bits systems, and 64 bits on 64 bits systems. So if we want to
+	 * use something like inode numbers as keys, which are always a u64, we
+	 * have to deal with this in a special way - we store the key in the
+	 * entry itself, as a u64, and the values inserted into the maple tree
+	 * are linked lists of entries - so in case we are on a 64 bits system,
+	 * that list always has a single entry, while on 32 bits systems it
+	 * may have more than one, with each entry having the same value for
+	 * their lower 32 bits of the u64 key.
+	 */
+	struct list_head list;
 };
 
 struct btrfs_lru_cache {
-- 
2.35.1

