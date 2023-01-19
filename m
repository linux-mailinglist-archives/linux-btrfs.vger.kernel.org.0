Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FF5A674C8D
	for <lists+linux-btrfs@lfdr.de>; Fri, 20 Jan 2023 06:37:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231270AbjATFhD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 20 Jan 2023 00:37:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231146AbjATFgl (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 20 Jan 2023 00:36:41 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE5FB6A31B
        for <linux-btrfs@vger.kernel.org>; Thu, 19 Jan 2023 21:33:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DE47CB82719
        for <linux-btrfs@vger.kernel.org>; Thu, 19 Jan 2023 19:39:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F3DCC433D2
        for <linux-btrfs@vger.kernel.org>; Thu, 19 Jan 2023 19:39:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674157187;
        bh=gTL2A9flNzkxUhEVw4BmoY/h7oH7FnjGI79Re274aMY=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=L0T+fWiINVZt6OZLWTyFJlGoQqoUBsoaLptviQXj4CajRwCXUjYcB8iQkWr7UwOsj
         6pmCBkngR8ae0p/72EXM1RA54goPf7okyrJvArV0uuRioKfVVpZou74EAHjk1UgacZ
         0j+7blQfpX+eBKNaJ2wLgUfoDQTGd/siM7bB7XkFC5GIM/LGfGbNRXzJTg0Cdi3BM7
         f/IvUoknOfvdPC2klA2koXROIJP44YjdjePQ8PoqH3HdAs9TzD0fTDuLVk0nTBkHDw
         WGTNDjbKjN4btmvhjrBl1qPnNqrMB/l5Lh8y8sH9hPloFqDUs/atyMK83US4Qr90OI
         mNIMqRphKqnOg==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 15/18] btrfs: add an api to delete a specific entry from the lru cache
Date:   Thu, 19 Jan 2023 19:39:27 +0000
Message-Id: <0bd767c7525178993f30cb2dc71a82c383b9518e.1674157020.git.fdmanana@suse.com>
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
index 23b061b69f65..260b4e5213a2 100644
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

