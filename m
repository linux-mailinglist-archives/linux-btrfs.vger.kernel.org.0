Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3E7A665A61
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Jan 2023 12:39:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238522AbjAKLjj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 11 Jan 2023 06:39:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238368AbjAKLjI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 11 Jan 2023 06:39:08 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7688BF52
        for <linux-btrfs@vger.kernel.org>; Wed, 11 Jan 2023 03:36:38 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7110A61C4B
        for <linux-btrfs@vger.kernel.org>; Wed, 11 Jan 2023 11:36:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F8D9C433F1
        for <linux-btrfs@vger.kernel.org>; Wed, 11 Jan 2023 11:36:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673436997;
        bh=Au6clPOEmouJABkMQxT/fuYcNhHEI8NAvw2yr78ElsI=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=EznKf77DcNv+yJGBcWAPLohLDPWieK4yQT4inrmH17mvriPFg0qnW3UCLt+hbPCDC
         j48Cdz/iDYeW6FA42/QCX4rds9sTqv4B4B6+ExWzLFbZIb4Bgi7RTGoXpfAmJEVc6a
         80tJk/gG9zvlVFfPxYZ6lqVJa7ebexKcDJ13nWOmL9yZJv4jKqJ1JCUfxbfEJP5unx
         4hdrl1aEpm2v1nR/NssXmmONDJPyB6EJ96WPvB26ODiOd7xodMaUwNbUOPhCOxNURy
         2DKkj2B6idDjrHDA1vW0bhrH4ZvZRury8RgUkzvRoMwADrRWjuWr3m1txXNJ+mQmMi
         2gjST/VsgzGHA==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 16/19] btrfs: add an api to delete a specific entry from the lru cache
Date:   Wed, 11 Jan 2023 11:36:17 +0000
Message-Id: <ae7c9d42d0afb05010ff544844cefaa07aed195d.1673436276.git.fdmanana@suse.com>
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

In order to replace the open coded name cache in send with the lru cache,
we need an API for the lru cache to delete a specific entry for which we
did a previous lookup. This adds the API for it, and a next patch in the
series will use it.

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
 fs/btrfs/lru_cache.c | 16 ++++++++++++----
 fs/btrfs/lru_cache.h |  2 ++
 2 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/lru_cache.c b/fs/btrfs/lru_cache.c
index d85341946213..602801235921 100644
--- a/fs/btrfs/lru_cache.c
+++ b/fs/btrfs/lru_cache.c
@@ -56,8 +56,16 @@ struct btrfs_lru_cache_entry *btrfs_lru_cache_lookup(struct btrfs_lru_cache *cac
 	return entry;
 }
 
-static void delete_entry(struct btrfs_lru_cache *cache,
-			 struct btrfs_lru_cache_entry *entry)
+/*
+ * Remove an entry from the cache.
+ *
+ * @cache:     The cache to remove from.
+ * @entry:     The entry to remove from the cache.
+ *
+ * Note: this also frees the memory used by the entry.
+ */
+void btrfs_lru_cache_remove(struct btrfs_lru_cache *cache,
+			    struct btrfs_lru_cache_entry *entry)
 {
 	struct list_head *prev = entry->list.prev;
 
@@ -126,7 +134,7 @@ int btrfs_lru_cache_store(struct btrfs_lru_cache *cache,
 		lru_entry = list_first_entry(&cache->lru_list,
 					     struct btrfs_lru_cache_entry,
 					     lru_list);
-		delete_entry(cache, lru_entry);
+		btrfs_lru_cache_remove(cache, lru_entry);
 	}
 
 	list_add_tail(&new_entry->lru_list, &cache->lru_list);
@@ -148,7 +156,7 @@ void btrfs_lru_cache_clear(struct btrfs_lru_cache *cache)
 	struct btrfs_lru_cache_entry *tmp;
 
 	list_for_each_entry_safe(entry, tmp, &cache->lru_list, lru_list)
-		delete_entry(cache, entry);
+		btrfs_lru_cache_remove(cache, entry);
 
 	ASSERT(cache->size == 0);
 	ASSERT(mtree_empty(&cache->entries));
diff --git a/fs/btrfs/lru_cache.h b/fs/btrfs/lru_cache.h
index de887d438cfb..57e5bdc57e6d 100644
--- a/fs/btrfs/lru_cache.h
+++ b/fs/btrfs/lru_cache.h
@@ -58,6 +58,8 @@ struct btrfs_lru_cache_entry *btrfs_lru_cache_lookup(struct btrfs_lru_cache *cac
 int btrfs_lru_cache_store(struct btrfs_lru_cache *cache,
 			  struct btrfs_lru_cache_entry *new_entry,
 			  gfp_t gfp);
+void btrfs_lru_cache_remove(struct btrfs_lru_cache *cache,
+			    struct btrfs_lru_cache_entry *entry);
 void btrfs_lru_cache_clear(struct btrfs_lru_cache *cache);
 
 #endif /* BTRFS_LRU_CACHE_H */
-- 
2.35.1

