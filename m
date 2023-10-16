Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B37E07CB244
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 Oct 2023 20:22:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233931AbjJPSWJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 16 Oct 2023 14:22:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233713AbjJPSWG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 16 Oct 2023 14:22:06 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5D85A2
        for <linux-btrfs@vger.kernel.org>; Mon, 16 Oct 2023 11:22:04 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id af79cd13be357-77574c6cab0so348152385a.3
        for <linux-btrfs@vger.kernel.org>; Mon, 16 Oct 2023 11:22:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1697480523; x=1698085323; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gnxchsTqt7xlkIIa+flWeo9ILMxv8/p1t4FXazb249Y=;
        b=d3W+qRZvmZBHQxv/ibqCXbP6GAMj4EepTIMnOINy6AT6/iiLtKJn2/fnaHA27jJOXA
         KcG+qOm7WNmx122LEExKiWDWUM2m9tgmfwJwmt/Hyvs7/Cq9x4m6IEMriHO4TJe0x0W9
         wyAIFD4sqcrlajibftIiZ9t9vDFrPBJtX5tHijT1lqwQjuAIeI3oCHtwwSuSLt2yIiO2
         Csl5eYjUAmSXZTa1QipNsENHcPj567F+tsHZuOTphT3kzKvIZuJbGemhVHfb3ks30Mf1
         jjZDAi4NfH2MZ7U+qzbnd6kmPyW2VDq5QyFMH+D0lE6bMrZC7SsQrCzMYKDrsSfylq4N
         kA8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697480523; x=1698085323;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gnxchsTqt7xlkIIa+flWeo9ILMxv8/p1t4FXazb249Y=;
        b=X1hw74EE23a6lceynbPcfAAUBkHsaGfR2rZfPx8OAhw5wcTXcUJJNclcUHDYqTw7xm
         Jg+6D8+ILh02/xrcpU/fSYGx6jeVMHDT8G1fTvcg0NqAip+FEt6YnMtrnEYYRW5gr0aH
         Z1Hc87IcOd6L+Ar//8/LnZqeuOO8uIru/Kk7raAmdEtrY1PIfSAM/0GsQ9rG0xpaj3L0
         WZ5M3A8A6//t7s2cD3GUFiF00/R8eyzI+VAqZ1twnx68yfIbegLO2DLDG/0wl0iR4QJz
         X+9R6hXNqaNWJdZI+R/XyNGvMi5Bxr6FIWKUDe/xb+0qzX8m8NBvKTLoNQjXOog7EArD
         a34A==
X-Gm-Message-State: AOJu0YxVorULPiOgOzJpUXF1gXrzkcx4378t5GsC7qoswrKxh0wO+lnH
        +68f/vg5IyHoMPjahJ9KlMJCMJO+SOcmv/RRI5ETaw==
X-Google-Smtp-Source: AGHT+IH++npFBeddWbFpaxH3fZW6+AwQ7DXjUdv/Y7TGn1l8XdPkbodfb/icF3Z1gs5SLOAo0HXrew==
X-Received: by 2002:a05:620a:24cf:b0:775:a3fc:a9d1 with SMTP id m15-20020a05620a24cf00b00775a3fca9d1mr47045469qkn.23.1697480523597;
        Mon, 16 Oct 2023 11:22:03 -0700 (PDT)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id t11-20020a05620a034b00b0076eee688a95sm3196340qkm.0.2023.10.16.11.22.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Oct 2023 11:22:03 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v3 06/34] btrfs: add infrastructure for safe em freeing
Date:   Mon, 16 Oct 2023 14:21:13 -0400
Message-ID: <844f5be59020bf6120741ffd88ea8a241ffd8458.1697480198.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1697480198.git.josef@toxicpanda.com>
References: <cover.1697480198.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

When we add fscrypt support we're going to have fscrypt objects hanging
off of extent_maps.  This includes a block key, which if we're the last
one freeing the key we may have to unregister it from the block layer.
This requires taking a semaphore in the block layer, which means we
can't free em's under the extent map tree lock.

Thankfully we only do this in two places, one where we're dropping a
range of extent maps, and when we're freeing logged extents.  Add a
free_extent_map_safe() which will add the em to a list in the em_tree if
we free'd the object.  Currently this is unconditional but will be
changed to conditional on the fscrypt object we will add in a later
patch.

To process these delayed objects add a free_pending_extent_maps() that
is called after the lock has been dropped on the em_tree.  This will
process the extent maps on the freed list and do the appropriate freeing
work in a safe manner.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/extent_map.c | 80 ++++++++++++++++++++++++++++++++++++++++---
 fs/btrfs/extent_map.h | 10 ++++++
 fs/btrfs/tree-log.c   |  6 ++--
 3 files changed, 89 insertions(+), 7 deletions(-)

diff --git a/fs/btrfs/extent_map.c b/fs/btrfs/extent_map.c
index a6d8368ed0ed..af5ff6b10865 100644
--- a/fs/btrfs/extent_map.c
+++ b/fs/btrfs/extent_map.c
@@ -35,7 +35,9 @@ void __cold extent_map_exit(void)
 void extent_map_tree_init(struct extent_map_tree *tree)
 {
 	tree->map = RB_ROOT_CACHED;
+	tree->flags = 0;
 	INIT_LIST_HEAD(&tree->modified_extents);
+	INIT_LIST_HEAD(&tree->freed_extents);
 	rwlock_init(&tree->lock);
 }
 
@@ -53,9 +55,17 @@ struct extent_map *alloc_extent_map(void)
 	em->compress_type = BTRFS_COMPRESS_NONE;
 	refcount_set(&em->refs, 1);
 	INIT_LIST_HEAD(&em->list);
+	INIT_LIST_HEAD(&em->free_list);
 	return em;
 }
 
+static void __free_extent_map(struct extent_map *em)
+{
+	if (test_bit(EXTENT_FLAG_FS_MAPPING, &em->flags))
+		kfree(em->map_lookup);
+	kmem_cache_free(extent_map_cache, em);
+}
+
 /*
  * Drop the reference out on @em by one and free the structure if the reference
  * count hits zero.
@@ -67,12 +77,69 @@ void free_extent_map(struct extent_map *em)
 	if (refcount_dec_and_test(&em->refs)) {
 		WARN_ON(extent_map_in_tree(em));
 		WARN_ON(!list_empty(&em->list));
-		if (test_bit(EXTENT_FLAG_FS_MAPPING, &em->flags))
-			kfree(em->map_lookup);
-		kmem_cache_free(extent_map_cache, em);
+		__free_extent_map(em);
 	}
 }
 
+/*
+ * Drop a ref for the extent map in the given tree.
+ *
+ * @tree:	tree that the em is a part of.
+ * @em:		the em to drop the reference to.
+ *
+ * Drop the reference count on @em by one, if the reference count hits 0 and
+ * there is an object on the em that can't be safely freed in the current
+ * context (if we are holding the extent_map_tree->lock for example), then add
+ * it to the freed_extents list on the extent_map_tree for later processing.
+ *
+ * This must be followed by a free_pending_extent_maps() to clear the pending
+ * frees.
+ */
+void free_extent_map_safe(struct extent_map_tree *tree,
+			  struct extent_map *em)
+{
+	lockdep_assert_held_write(&tree->lock);
+
+	if (!em)
+		return;
+
+	if (refcount_dec_and_test(&em->refs)) {
+		WARN_ON(extent_map_in_tree(em));
+		WARN_ON(!list_empty(&em->list));
+		list_add_tail(&em->free_list, &tree->freed_extents);
+		set_bit(EXTENT_MAP_TREE_PENDING_FREES, &tree->flags);
+	}
+}
+
+/*
+ * Free the em objects that exist on the em tree
+ *
+ * @tree:	the tree to free the objects from.
+ *
+ * If there are any objects on the em->freed_extents list go ahead and free them
+ * here in a safe way.  This is to be coupled with any uses of
+ * free_extent_map_safe().
+ */
+void free_pending_extent_maps(struct extent_map_tree *tree)
+{
+	struct extent_map *em;
+
+	/* Avoid taking the write lock if we don't have any pending frees. */
+	if (!test_and_clear_bit(EXTENT_MAP_TREE_PENDING_FREES, &tree->flags))
+		return;
+
+	write_lock(&tree->lock);
+	while ((em = list_first_entry_or_null(&tree->freed_extents,
+					      struct extent_map, free_list))) {
+		list_del_init(&em->free_list);
+		write_unlock(&tree->lock);
+		__free_extent_map(em);
+		cond_resched();
+		write_lock(&tree->lock);
+	}
+	write_unlock(&tree->lock);
+}
+
 /* Do the math around the end of an extent, handling wrapping. */
 static u64 range_end(u64 start, u64 len)
 {
@@ -684,10 +751,12 @@ static void drop_all_extent_maps_fast(struct extent_map_tree *tree)
 		clear_bit(EXTENT_FLAG_PINNED, &em->flags);
 		clear_bit(EXTENT_FLAG_LOGGING, &em->flags);
 		remove_extent_mapping(tree, em);
-		free_extent_map(em);
+		free_extent_map_safe(tree, em);
 		cond_resched_rwlock_write(&tree->lock);
 	}
 	write_unlock(&tree->lock);
+
+	free_pending_extent_maps(tree);
 }
 
 /*
@@ -908,13 +977,14 @@ void btrfs_drop_extent_map_range(struct btrfs_inode *inode, u64 start, u64 end,
 		free_extent_map(em);
 next:
 		/* Once for us (for our lookup reference). */
-		free_extent_map(em);
+		free_extent_map_safe(em_tree, em);
 
 		em = next_em;
 	}
 
 	write_unlock(&em_tree->lock);
 
+	free_pending_extent_maps(em_tree);
 	free_extent_map(split);
 	free_extent_map(split2);
 }
diff --git a/fs/btrfs/extent_map.h b/fs/btrfs/extent_map.h
index 35d27c756e08..2093720271ea 100644
--- a/fs/btrfs/extent_map.h
+++ b/fs/btrfs/extent_map.h
@@ -55,11 +55,18 @@ struct extent_map {
 	refcount_t refs;
 	unsigned int compress_type;
 	struct list_head list;
+	struct list_head free_list;
+};
+
+enum extent_map_flags {
+	EXTENT_MAP_TREE_PENDING_FREES,
 };
 
 struct extent_map_tree {
 	struct rb_root_cached map;
+	unsigned long flags;
 	struct list_head modified_extents;
+	struct list_head freed_extents;
 	rwlock_t lock;
 };
 
@@ -95,6 +102,9 @@ int split_extent_map(struct btrfs_inode *inode, u64 start, u64 len, u64 pre,
 
 struct extent_map *alloc_extent_map(void);
 void free_extent_map(struct extent_map *em);
+void free_extent_map_safe(struct extent_map_tree *tree,
+			  struct extent_map *em);
+void free_pending_extent_maps(struct extent_map_tree *tree);
 int __init extent_map_init(void);
 void __cold extent_map_exit(void);
 int unpin_extent_cache(struct extent_map_tree *tree, u64 start, u64 len, u64 gen);
diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 8b3893c01734..d3803db10939 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -4884,7 +4884,7 @@ static int btrfs_log_changed_extents(struct btrfs_trans_handle *trans,
 		 */
 		if (ret) {
 			clear_em_logging(tree, em);
-			free_extent_map(em);
+			free_extent_map_safe(tree, em);
 			continue;
 		}
 
@@ -4893,11 +4893,13 @@ static int btrfs_log_changed_extents(struct btrfs_trans_handle *trans,
 		ret = log_one_extent(trans, inode, em, path, ctx);
 		write_lock(&tree->lock);
 		clear_em_logging(tree, em);
-		free_extent_map(em);
+		free_extent_map_safe(tree, em);
 	}
 	WARN_ON(!list_empty(&extents));
 	write_unlock(&tree->lock);
 
+	free_pending_extent_maps(tree);
+
 	if (!ret)
 		ret = btrfs_log_prealloc_extents(trans, inode, path);
 	if (ret)
-- 
2.41.0

