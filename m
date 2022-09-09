Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41DD35B41C0
	for <lists+linux-btrfs@lfdr.de>; Fri,  9 Sep 2022 23:54:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231807AbiIIVyG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 9 Sep 2022 17:54:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231795AbiIIVyF (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 9 Sep 2022 17:54:05 -0400
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4288C10B009
        for <linux-btrfs@vger.kernel.org>; Fri,  9 Sep 2022 14:54:04 -0700 (PDT)
Received: by mail-qv1-xf2b.google.com with SMTP id w4so2291232qvp.2
        for <linux-btrfs@vger.kernel.org>; Fri, 09 Sep 2022 14:54:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date;
        bh=k83Y1tpedwsgPm+X+YCt+4idZsENLEvibTy18VT8XJ0=;
        b=kzKDs8/aD3mpwVTJGbiIylR65vh29ssc2/scXs5aSD4b9/dhYngL1Tj1Jnk4/2f79D
         O7lx6fv7IxYnAYy/cTv5LELKfs4RaHpH/66KGdKqmxX8TU9/qKSsDMaYL2lFHVuwSiXX
         YMjKujOpn3BZzzC7QaudsDfoMCzXEPVt/FzncWRdM7n3TF7fK36i2pg8t1Lkpipy55en
         qXQ99JoGLSYRTmz3SKcK3eUfCC3MG96WCzTJ0PpkOiDEp21D3w4jmicGtAbeFvoZPrV9
         6oob6tyQqSV0T5g2AtqSVZR5Pmgln34fwgnWN8uxCorD6esiEOBF9ldkwMcVoE0dz1D6
         eeZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=k83Y1tpedwsgPm+X+YCt+4idZsENLEvibTy18VT8XJ0=;
        b=aEJYOjtdcEFlAxJfbxOwrdN0FfEB7zAjf4Tx6zTJnp9le/mNAhfWVmtBAO8QOC5ASt
         UwjFDTaXwDdFhUCTg338Q/UNR3sr5EV/JIAybapMetvFiqdcgKH9p7oZgHu1xmo5nL6S
         yKdJjst4FtbeKUwApbbnaRJMmsvZ7lEw2c12+bKJ9sox1emhbFmZfdtaAexxW7krTinV
         yxrR7nYa/jC81lYWyd1i325O1/w4hH0AMAQS8SfFwm8Be2wuGkvHJjAnoGUW7/FJSLy7
         nzX45LYFr2HbpisUB7lFeaVwmrUTxa/CEcAAwo1YxVaSwnD7L7wQOxaPT2OCNQLG9yut
         t6Fg==
X-Gm-Message-State: ACgBeo1GG/iwdNArlVLQ1+8DqmcI/uC9ri7MJcDBHP6cQDAF9KfUtzpl
        3x/PLCi2lCUxVaZsPOsHjtwSMYsKhGFfgw==
X-Google-Smtp-Source: AA6agR66tLjrNkkGL7anQgD/C/NskMLP0ywJXD+/5alTscUs6BUDB5MEPmCfk/pdambqdAbRdFSF5g==
X-Received: by 2002:ad4:5f4b:0:b0:49e:61df:c46b with SMTP id p11-20020ad45f4b000000b0049e61dfc46bmr14099381qvg.30.1662760442844;
        Fri, 09 Sep 2022 14:54:02 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id 16-20020a370a10000000b006b949afa980sm1192357qkk.56.2022.09.09.14.54.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Sep 2022 14:54:02 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 08/36] btrfs: move extent state init and alloc functions to their own file
Date:   Fri,  9 Sep 2022 17:53:21 -0400
Message-Id: <ec5caec1bf29b39232ad0a3bf3a2806760a33534.1662760286.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1662760286.git.josef@toxicpanda.com>
References: <cover.1662760286.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Start cleaning up extent_io.c by moving the extent state code out of it.
This patch starts with the extent state allocation code and the
extent_io_tree init code.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/Makefile         |   2 +-
 fs/btrfs/extent-io-tree.c | 160 ++++++++++++++++++++++++++++++++++++++
 fs/btrfs/extent-io-tree.h |   5 ++
 fs/btrfs/extent_io.c      | 155 ------------------------------------
 4 files changed, 166 insertions(+), 156 deletions(-)
 create mode 100644 fs/btrfs/extent-io-tree.c

diff --git a/fs/btrfs/Makefile b/fs/btrfs/Makefile
index 99f9995670ea..fa9ddcc9eb0b 100644
--- a/fs/btrfs/Makefile
+++ b/fs/btrfs/Makefile
@@ -31,7 +31,7 @@ btrfs-y += super.o ctree.o extent-tree.o print-tree.o root-tree.o dir-item.o \
 	   backref.o ulist.o qgroup.o send.o dev-replace.o raid56.o \
 	   uuid-tree.o props.o free-space-tree.o tree-checker.o space-info.o \
 	   block-rsv.o delalloc-space.o block-group.o discard.o reflink.o \
-	   subpage.o tree-mod-log.o
+	   subpage.o tree-mod-log.o extent-io-tree.o
 
 btrfs-$(CONFIG_BTRFS_FS_POSIX_ACL) += acl.o
 btrfs-$(CONFIG_BTRFS_FS_CHECK_INTEGRITY) += check-integrity.o
diff --git a/fs/btrfs/extent-io-tree.c b/fs/btrfs/extent-io-tree.c
new file mode 100644
index 000000000000..2aedac452636
--- /dev/null
+++ b/fs/btrfs/extent-io-tree.c
@@ -0,0 +1,160 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/slab.h>
+#include <trace/events/btrfs.h>
+#include "ctree.h"
+#include "extent-io-tree.h"
+
+static struct kmem_cache *extent_state_cache;
+
+#ifdef CONFIG_BTRFS_DEBUG
+static LIST_HEAD(states);
+static DEFINE_SPINLOCK(leak_lock);
+
+static inline void btrfs_leak_debug_add_state(struct extent_state *state)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&leak_lock, flags);
+	list_add(&state->leak_list, &states);
+	spin_unlock_irqrestore(&leak_lock, flags);
+}
+
+static inline void btrfs_leak_debug_del_state(struct extent_state *state)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&leak_lock, flags);
+	list_del(&state->leak_list);
+	spin_unlock_irqrestore(&leak_lock, flags);
+}
+
+static inline void btrfs_extent_state_leak_debug_check(void)
+{
+	struct extent_state *state;
+
+	while (!list_empty(&states)) {
+		state = list_entry(states.next, struct extent_state, leak_list);
+		pr_err("BTRFS: state leak: start %llu end %llu state %u in tree %d refs %d\n",
+		       state->start, state->end, state->state,
+		       extent_state_in_tree(state),
+		       refcount_read(&state->refs));
+		list_del(&state->leak_list);
+		kmem_cache_free(extent_state_cache, state);
+	}
+}
+#else
+#define btrfs_leak_debug_add_state(state)		do {} while (0)
+#define btrfs_leak_debug_del_state(state)		do {} while (0)
+#define btrfs_extent_state_leak_debug_check()		do {} while (0)
+#endif
+
+/*
+ * For the file_extent_tree, we want to hold the inode lock when we lookup and
+ * update the disk_i_size, but lockdep will complain because our io_tree we hold
+ * the tree lock and get the inode lock when setting delalloc.  These two things
+ * are unrelated, so make a class for the file_extent_tree so we don't get the
+ * two locking patterns mixed up.
+ */
+static struct lock_class_key file_extent_tree_class;
+
+void extent_io_tree_init(struct btrfs_fs_info *fs_info,
+			 struct extent_io_tree *tree, unsigned int owner,
+			 void *private_data)
+{
+	tree->fs_info = fs_info;
+	tree->state = RB_ROOT;
+	tree->dirty_bytes = 0;
+	spin_lock_init(&tree->lock);
+	tree->private_data = private_data;
+	tree->owner = owner;
+	if (owner == IO_TREE_INODE_FILE_EXTENT)
+		lockdep_set_class(&tree->lock, &file_extent_tree_class);
+}
+
+void extent_io_tree_release(struct extent_io_tree *tree)
+{
+	spin_lock(&tree->lock);
+	/*
+	 * Do a single barrier for the waitqueue_active check here, the state
+	 * of the waitqueue should not change once extent_io_tree_release is
+	 * called.
+	 */
+	smp_mb();
+	while (!RB_EMPTY_ROOT(&tree->state)) {
+		struct rb_node *node;
+		struct extent_state *state;
+
+		node = rb_first(&tree->state);
+		state = rb_entry(node, struct extent_state, rb_node);
+		rb_erase(&state->rb_node, &tree->state);
+		RB_CLEAR_NODE(&state->rb_node);
+		/*
+		 * btree io trees aren't supposed to have tasks waiting for
+		 * changes in the flags of extent states ever.
+		 */
+		ASSERT(!waitqueue_active(&state->wq));
+		free_extent_state(state);
+
+		cond_resched_lock(&tree->lock);
+	}
+	spin_unlock(&tree->lock);
+}
+
+struct extent_state *alloc_extent_state(gfp_t mask)
+{
+	struct extent_state *state;
+
+	/*
+	 * The given mask might be not appropriate for the slab allocator,
+	 * drop the unsupported bits
+	 */
+	mask &= ~(__GFP_DMA32|__GFP_HIGHMEM);
+	state = kmem_cache_alloc(extent_state_cache, mask);
+	if (!state)
+		return state;
+	state->state = 0;
+	RB_CLEAR_NODE(&state->rb_node);
+	btrfs_leak_debug_add_state(state);
+	refcount_set(&state->refs, 1);
+	init_waitqueue_head(&state->wq);
+	trace_alloc_extent_state(state, mask, _RET_IP_);
+	return state;
+}
+
+struct extent_state *alloc_extent_state_atomic(struct extent_state *prealloc)
+{
+	if (!prealloc)
+		prealloc = alloc_extent_state(GFP_ATOMIC);
+
+	return prealloc;
+}
+
+void free_extent_state(struct extent_state *state)
+{
+	if (!state)
+		return;
+	if (refcount_dec_and_test(&state->refs)) {
+		WARN_ON(extent_state_in_tree(state));
+		btrfs_leak_debug_del_state(state);
+		trace_free_extent_state(state, _RET_IP_);
+		kmem_cache_free(extent_state_cache, state);
+	}
+}
+
+void __cold extent_state_free_cachep(void)
+{
+	btrfs_extent_state_leak_debug_check();
+	kmem_cache_destroy(extent_state_cache);
+}
+
+int __init extent_state_init_cachep(void)
+{
+	extent_state_cache = kmem_cache_create("btrfs_extent_state",
+			sizeof(struct extent_state), 0,
+			SLAB_MEM_SPREAD, NULL);
+	if (!extent_state_cache)
+		return -ENOMEM;
+
+	return 0;
+}
diff --git a/fs/btrfs/extent-io-tree.h b/fs/btrfs/extent-io-tree.h
index 8e7a548b88e9..56266e75b4fe 100644
--- a/fs/btrfs/extent-io-tree.h
+++ b/fs/btrfs/extent-io-tree.h
@@ -253,4 +253,9 @@ int btrfs_clean_io_failure(struct btrfs_inode *inode, u64 start,
 struct extent_state *alloc_extent_state_atomic(struct extent_state *prealloc);
 struct extent_state *alloc_extent_state(gfp_t mask);
 
+static inline bool extent_state_in_tree(const struct extent_state *state)
+{
+	return !RB_EMPTY_NODE(&state->rb_node);
+}
+
 #endif /* BTRFS_EXTENT_IO_TREE_H */
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 412dabccb1f4..ae746857dd6c 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -31,18 +31,9 @@
 #include "block-group.h"
 #include "compression.h"
 
-static struct kmem_cache *extent_state_cache;
 static struct kmem_cache *extent_buffer_cache;
 
-static inline bool extent_state_in_tree(const struct extent_state *state)
-{
-	return !RB_EMPTY_NODE(&state->rb_node);
-}
-
 #ifdef CONFIG_BTRFS_DEBUG
-static LIST_HEAD(states);
-static DEFINE_SPINLOCK(leak_lock);
-
 static inline void btrfs_leak_debug_add_eb(struct extent_buffer *eb)
 {
 	struct btrfs_fs_info *fs_info = eb->fs_info;
@@ -53,15 +44,6 @@ static inline void btrfs_leak_debug_add_eb(struct extent_buffer *eb)
 	spin_unlock_irqrestore(&fs_info->eb_leak_lock, flags);
 }
 
-static inline void btrfs_leak_debug_add_state(struct extent_state *state)
-{
-	unsigned long flags;
-
-	spin_lock_irqsave(&leak_lock, flags);
-	list_add(&state->leak_list, &states);
-	spin_unlock_irqrestore(&leak_lock, flags);
-}
-
 static inline void btrfs_leak_debug_del_eb(struct extent_buffer *eb)
 {
 	struct btrfs_fs_info *fs_info = eb->fs_info;
@@ -72,15 +54,6 @@ static inline void btrfs_leak_debug_del_eb(struct extent_buffer *eb)
 	spin_unlock_irqrestore(&fs_info->eb_leak_lock, flags);
 }
 
-static inline void btrfs_leak_debug_del_state(struct extent_state *state)
-{
-	unsigned long flags;
-
-	spin_lock_irqsave(&leak_lock, flags);
-	list_del(&state->leak_list);
-	spin_unlock_irqrestore(&leak_lock, flags);
-}
-
 void btrfs_extent_buffer_leak_debug_check(struct btrfs_fs_info *fs_info)
 {
 	struct extent_buffer *eb;
@@ -108,21 +81,6 @@ void btrfs_extent_buffer_leak_debug_check(struct btrfs_fs_info *fs_info)
 	spin_unlock_irqrestore(&fs_info->eb_leak_lock, flags);
 }
 
-static inline void btrfs_extent_state_leak_debug_check(void)
-{
-	struct extent_state *state;
-
-	while (!list_empty(&states)) {
-		state = list_entry(states.next, struct extent_state, leak_list);
-		pr_err("BTRFS: state leak: start %llu end %llu state %u in tree %d refs %d\n",
-		       state->start, state->end, state->state,
-		       extent_state_in_tree(state),
-		       refcount_read(&state->refs));
-		list_del(&state->leak_list);
-		kmem_cache_free(extent_state_cache, state);
-	}
-}
-
 #define btrfs_debug_check_extent_io_range(tree, start, end)		\
 	__btrfs_debug_check_extent_io_range(__func__, (tree), (start), (end))
 static inline void __btrfs_debug_check_extent_io_range(const char *caller,
@@ -143,10 +101,7 @@ static inline void __btrfs_debug_check_extent_io_range(const char *caller,
 }
 #else
 #define btrfs_leak_debug_add_eb(eb)			do {} while (0)
-#define btrfs_leak_debug_add_state(state)		do {} while (0)
 #define btrfs_leak_debug_del_eb(eb)			do {} while (0)
-#define btrfs_leak_debug_del_state(state)		do {} while (0)
-#define btrfs_extent_state_leak_debug_check()		do {} while (0)
 #define btrfs_debug_check_extent_io_range(c, s, e)	do {} while (0)
 #endif
 
@@ -249,17 +204,6 @@ static void submit_write_bio(struct extent_page_data *epd, int ret)
 	}
 }
 
-int __init extent_state_init_cachep(void)
-{
-	extent_state_cache = kmem_cache_create("btrfs_extent_state",
-			sizeof(struct extent_state), 0,
-			SLAB_MEM_SPREAD, NULL);
-	if (!extent_state_cache)
-		return -ENOMEM;
-
-	return 0;
-}
-
 int __init extent_buffer_init_cachep(void)
 {
 	extent_buffer_cache = kmem_cache_create("btrfs_extent_buffer",
@@ -271,12 +215,6 @@ int __init extent_buffer_init_cachep(void)
 	return 0;
 }
 
-void __cold extent_state_free_cachep(void)
-{
-	btrfs_extent_state_leak_debug_check();
-	kmem_cache_destroy(extent_state_cache);
-}
-
 void __cold extent_buffer_free_cachep(void)
 {
 	/*
@@ -287,91 +225,6 @@ void __cold extent_buffer_free_cachep(void)
 	kmem_cache_destroy(extent_buffer_cache);
 }
 
-/*
- * For the file_extent_tree, we want to hold the inode lock when we lookup and
- * update the disk_i_size, but lockdep will complain because our io_tree we hold
- * the tree lock and get the inode lock when setting delalloc.  These two things
- * are unrelated, so make a class for the file_extent_tree so we don't get the
- * two locking patterns mixed up.
- */
-static struct lock_class_key file_extent_tree_class;
-
-void extent_io_tree_init(struct btrfs_fs_info *fs_info,
-			 struct extent_io_tree *tree, unsigned int owner,
-			 void *private_data)
-{
-	tree->fs_info = fs_info;
-	tree->state = RB_ROOT;
-	tree->dirty_bytes = 0;
-	spin_lock_init(&tree->lock);
-	tree->private_data = private_data;
-	tree->owner = owner;
-	if (owner == IO_TREE_INODE_FILE_EXTENT)
-		lockdep_set_class(&tree->lock, &file_extent_tree_class);
-}
-
-void extent_io_tree_release(struct extent_io_tree *tree)
-{
-	spin_lock(&tree->lock);
-	/*
-	 * Do a single barrier for the waitqueue_active check here, the state
-	 * of the waitqueue should not change once extent_io_tree_release is
-	 * called.
-	 */
-	smp_mb();
-	while (!RB_EMPTY_ROOT(&tree->state)) {
-		struct rb_node *node;
-		struct extent_state *state;
-
-		node = rb_first(&tree->state);
-		state = rb_entry(node, struct extent_state, rb_node);
-		rb_erase(&state->rb_node, &tree->state);
-		RB_CLEAR_NODE(&state->rb_node);
-		/*
-		 * btree io trees aren't supposed to have tasks waiting for
-		 * changes in the flags of extent states ever.
-		 */
-		ASSERT(!waitqueue_active(&state->wq));
-		free_extent_state(state);
-
-		cond_resched_lock(&tree->lock);
-	}
-	spin_unlock(&tree->lock);
-}
-
-struct extent_state *alloc_extent_state(gfp_t mask)
-{
-	struct extent_state *state;
-
-	/*
-	 * The given mask might be not appropriate for the slab allocator,
-	 * drop the unsupported bits
-	 */
-	mask &= ~(__GFP_DMA32|__GFP_HIGHMEM);
-	state = kmem_cache_alloc(extent_state_cache, mask);
-	if (!state)
-		return state;
-	state->state = 0;
-	RB_CLEAR_NODE(&state->rb_node);
-	btrfs_leak_debug_add_state(state);
-	refcount_set(&state->refs, 1);
-	init_waitqueue_head(&state->wq);
-	trace_alloc_extent_state(state, mask, _RET_IP_);
-	return state;
-}
-
-void free_extent_state(struct extent_state *state)
-{
-	if (!state)
-		return;
-	if (refcount_dec_and_test(&state->refs)) {
-		WARN_ON(extent_state_in_tree(state));
-		btrfs_leak_debug_del_state(state);
-		trace_free_extent_state(state, _RET_IP_);
-		kmem_cache_free(extent_state_cache, state);
-	}
-}
-
 /**
  * Search @tree for an entry that contains @offset. Such entry would have
  * entry->start <= offset && entry->end >= offset.
@@ -710,14 +563,6 @@ static struct extent_state *clear_state_bit(struct extent_io_tree *tree,
 	return next;
 }
 
-struct extent_state *alloc_extent_state_atomic(struct extent_state *prealloc)
-{
-	if (!prealloc)
-		prealloc = alloc_extent_state(GFP_ATOMIC);
-
-	return prealloc;
-}
-
 static void extent_io_tree_panic(struct extent_io_tree *tree, int err)
 {
 	btrfs_panic(tree->fs_info, err,
-- 
2.26.3

