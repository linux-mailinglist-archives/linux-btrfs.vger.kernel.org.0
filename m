Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0D156E8347
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Apr 2023 23:17:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231239AbjDSVRp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 19 Apr 2023 17:17:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230519AbjDSVRn (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 19 Apr 2023 17:17:43 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FED944B9
        for <linux-btrfs@vger.kernel.org>; Wed, 19 Apr 2023 14:17:38 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id a23so617094qtj.8
        for <linux-btrfs@vger.kernel.org>; Wed, 19 Apr 2023 14:17:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20221208.gappssmtp.com; s=20221208; t=1681939057; x=1684531057;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8YXUPG4aLkp9XGOCHoo+6PYOF0Lh9Nehd+48is+0oCg=;
        b=Ydd/iEB8sRcS1xvUaym1U0OjEm8P2VI9UG7ylTpguAXyepUAoi2yYNFt0JYPHug4bH
         jFuhGL0nXgGHWvkv/XnG2CSh0Eg+VZXSzlNGXAcRTnpHIFDxKtxBxg7SUEPbhwyDmKLv
         gIwm0544zNW2/CqY5YOOQZp2s69XaUmUihfmklazpp9W+AomkEPs/PkpV1VxBVfhRWTK
         9V9zOxgKrm3pJ8jHrH112KM6gIvJYiAi2ZH4SzbR+6Ej6r/Aj7MxNERzZxsJ0CUSL71o
         7Rjziup6MhvPJQa4C0qbJtmNaOtSD9qxbaXjSaGUXE6p8UlNeT4DifJXCjzH7dXSRQ9/
         F58A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681939057; x=1684531057;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8YXUPG4aLkp9XGOCHoo+6PYOF0Lh9Nehd+48is+0oCg=;
        b=bUw467h5tO6yu5f1ebRFJAHd3VY8zkbVKEt1u0bpQH/VQnwVppZswpYBc/TmoaVXWj
         MvrHXXYraiCSY01zOKT28kgpntRVKseeU4XundYPxAvxa96JoRZhyxanJ9hJzYo/16g3
         KHJ/j9X73f1wziBBQJHhZa99+IQlmsQMT4PJBQeEHgTcTQmfK4MKBJocjuA9kKyilsLz
         W0zdgn1fF3CiqO91ppYk8yUBEaa0cqHA/Y3peASalsXzOvf4KmsUVlQ5fU6Mkzs7J4Ez
         P2nDtPO3/pqQhpWimOQHxIyUhduTPT+2yJGBFAsV9nxqIqz87mZy0gSrTjMLVdVNXUNm
         6ygA==
X-Gm-Message-State: AAQBX9cIh/JZEDho4JyCuzlbcIj5VdMl46bkc9h0TfJsOxLfROkv4kTN
        SE/RnLGmpJhEu7EzzQwvShMu1Mmk5SvIV0+6Co/qyg==
X-Google-Smtp-Source: AKy350aOHlnlRR4+149dtlsqUVK++Q+aR0MLtsJ71gmkZE1XS32Ym6ncC8EJFOi+JgrHDoaKVIz4Zg==
X-Received: by 2002:a05:622a:38d:b0:3e1:b06d:e9e0 with SMTP id j13-20020a05622a038d00b003e1b06de9e0mr7604109qtx.56.1681939055779;
        Wed, 19 Apr 2023 14:17:35 -0700 (PDT)
Received: from localhost (cpe-174-109-170-245.nc.res.rr.com. [174.109.170.245])
        by smtp.gmail.com with ESMTPSA id y19-20020a05620a44d300b0074adca3206asm704037qkp.90.2023.04.19.14.17.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Apr 2023 14:17:35 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 8/8] btrfs-progs: sync extent-io-tree.[ch] and misc.h from the kernel
Date:   Wed, 19 Apr 2023 17:17:19 -0400
Message-Id: <7be6046b0c4b3a85ab443ebf821b479c20cc90b2.1681938911.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <cover.1681938911.git.josef@toxicpanda.com>
References: <cover.1681938911.git.josef@toxicpanda.com>
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

This is a bit larger than the previous syncs, because we use
extent_io_tree's everywhere.  There's a lot of stuff added to
kerncompat.h, and then I went through and cleaned up all the API
changes, which were

- extent_io_tree_init takes an fs_info and an owner now.
- extent_io_tree_cleanup is now extent_io_tree_release.
- set_extent_dirty takes a gfpmask.
- clear_extent_dirty takes a cached_state.
- find_first_extent_bit takes a cached_state.

The diffstat looks insane for this, but keep in mind extent-io-tree.c
and extent-io-tree.h are ~2000 loc just by themselves.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 Makefile                       |    1 +
 check/clear-cache.c            |    8 +-
 check/common.h                 |    2 +-
 check/main.c                   |   27 +-
 check/mode-common.c            |    9 +-
 check/mode-lowmem.c            |    4 +-
 check/repair.c                 |   16 +-
 cmds/rescue-chunk-recover.c    |    2 +-
 image/main.c                   |    9 +-
 include/kerncompat.h           |  161 ++-
 kernel-lib/trace.h             |   26 +
 kernel-shared/ctree.h          |    1 +
 kernel-shared/disk-io.c        |   16 +-
 kernel-shared/extent-io-tree.c | 1733 ++++++++++++++++++++++++++++++++
 kernel-shared/extent-io-tree.h |  239 +++++
 kernel-shared/extent-tree.c    |   45 +-
 kernel-shared/extent_io.c      |  473 +--------
 kernel-shared/extent_io.h      |   39 +-
 kernel-shared/misc.h           |  143 +++
 kernel-shared/transaction.c    |    5 +-
 20 files changed, 2387 insertions(+), 572 deletions(-)
 create mode 100644 kernel-shared/extent-io-tree.c
 create mode 100644 kernel-shared/extent-io-tree.h
 create mode 100644 kernel-shared/misc.h

diff --git a/Makefile b/Makefile
index b9bc4fec..43dfd296 100644
--- a/Makefile
+++ b/Makefile
@@ -173,6 +173,7 @@ objects = \
 	kernel-shared/delayed-ref.o	\
 	kernel-shared/dir-item.o	\
 	kernel-shared/disk-io.o	\
+	kernel-shared/extent-io-tree.o	\
 	kernel-shared/extent-tree.o	\
 	kernel-shared/extent_io.o	\
 	kernel-shared/file-item.o	\
diff --git a/check/clear-cache.c b/check/clear-cache.c
index 9074557e..5ffdd430 100644
--- a/check/clear-cache.c
+++ b/check/clear-cache.c
@@ -310,7 +310,7 @@ static int verify_space_cache(struct btrfs_root *root,
 
 	while (start < bg_end) {
 		ret = find_first_extent_bit(used, cache->start, &start, &end,
-					    EXTENT_DIRTY);
+					    EXTENT_DIRTY, NULL);
 		if (ret || start >= bg_end) {
 			ret = 0;
 			break;
@@ -322,7 +322,7 @@ static int verify_space_cache(struct btrfs_root *root,
 				return ret;
 		}
 		end = min(end, bg_end - 1);
-		clear_extent_dirty(used, start, end);
+		clear_extent_dirty(used, start, end, NULL);
 		start = end + 1;
 		last_end = start;
 	}
@@ -349,7 +349,7 @@ static int check_space_cache(struct btrfs_root *root)
 	int ret;
 	int error = 0;
 
-	extent_io_tree_init(&used);
+	extent_io_tree_init(root->fs_info, &used, 0);
 	ret = btrfs_mark_used_blocks(gfs_info, &used);
 	if (ret)
 		return ret;
@@ -405,7 +405,7 @@ static int check_space_cache(struct btrfs_root *root)
 			error++;
 		}
 	}
-	extent_io_tree_cleanup(&used);
+	extent_io_tree_release(&used);
 	return error ? -EINVAL : 0;
 }
 
diff --git a/check/common.h b/check/common.h
index 645c4539..2d5db213 100644
--- a/check/common.h
+++ b/check/common.h
@@ -147,7 +147,7 @@ u64 calc_stripe_length(u64 type, u64 length, int num_stripes);
 static inline void block_group_tree_init(struct block_group_tree *tree)
 {
 	cache_tree_init(&tree->tree);
-	extent_io_tree_init(&tree->pending_extents);
+	extent_io_tree_init(NULL, &tree->pending_extents, 0);
 	INIT_LIST_HEAD(&tree->block_groups);
 }
 
diff --git a/check/main.c b/check/main.c
index 513fa553..99ff3bc3 100644
--- a/check/main.c
+++ b/check/main.c
@@ -5200,7 +5200,7 @@ static void free_block_group_record(struct cache_extent *cache)
 
 void free_block_group_tree(struct block_group_tree *tree)
 {
-	extent_io_tree_cleanup(&tree->pending_extents);
+	extent_io_tree_release(&tree->pending_extents);
 	cache_tree_free_extents(&tree->tree, free_block_group_record);
 }
 
@@ -5213,7 +5213,7 @@ static void update_block_group_used(struct block_group_tree *tree,
 	bg_item = lookup_cache_extent(&tree->tree, bytenr, num_bytes);
 	if (!bg_item) {
 		set_extent_dirty(&tree->pending_extents, bytenr,
-				 bytenr + num_bytes - 1);
+				 bytenr + num_bytes - 1, GFP_NOFS);
 		return;
 	}
 	bg_rec = container_of(bg_item, struct block_group_record, cache);
@@ -5452,7 +5452,8 @@ static int process_block_group_item(struct block_group_tree *block_group_cache,
 	}
 
 	while (!find_first_extent_bit(&block_group_cache->pending_extents,
-				      rec->objectid, &start, &end, EXTENT_DIRTY)) {
+				      rec->objectid, &start, &end, EXTENT_DIRTY,
+				      NULL)) {
 		u64 len;
 
 		if (start >= rec->objectid + rec->offset)
@@ -5461,7 +5462,7 @@ static int process_block_group_item(struct block_group_tree *block_group_cache,
 		len = min(end - start + 1, rec->objectid + rec->offset - start);
 		rec->actual_used += len;
 		clear_extent_dirty(&block_group_cache->pending_extents, start,
-				   start + len - 1);
+				   start + len - 1, NULL);
 	}
 
 	return ret;
@@ -8057,7 +8058,8 @@ static int check_extent_refs(struct btrfs_root *root,
 			rec = container_of(cache, struct extent_record, cache);
 			set_extent_dirty(gfs_info->excluded_extents,
 					 rec->start,
-					 rec->start + rec->max_size - 1);
+					 rec->start + rec->max_size - 1,
+					 GFP_NOFS);
 			cache = next_cache_extent(cache);
 		}
 
@@ -8066,7 +8068,8 @@ static int check_extent_refs(struct btrfs_root *root,
 		while (cache) {
 			set_extent_dirty(gfs_info->excluded_extents,
 					 cache->start,
-					 cache->start + cache->size - 1);
+					 cache->start + cache->size - 1,
+					 GFP_NOFS);
 			cache = next_cache_extent(cache);
 		}
 		prune_corrupt_blocks();
@@ -8221,7 +8224,8 @@ next:
 		if (!init_extent_tree && opt_check_repair && (!cur_err || fix))
 			clear_extent_dirty(gfs_info->excluded_extents,
 					   rec->start,
-					   rec->start + rec->max_size - 1);
+					   rec->start + rec->max_size - 1,
+					   NULL);
 		free(rec);
 	}
 repair_abort:
@@ -8927,7 +8931,7 @@ static int check_chunks_and_extents(void)
 	cache_tree_init(&nodes);
 	cache_tree_init(&reada);
 	cache_tree_init(&corrupt_blocks);
-	extent_io_tree_init(&excluded_extents);
+	extent_io_tree_init(gfs_info, &excluded_extents, 0);
 	INIT_LIST_HEAD(&dropping_trees);
 	INIT_LIST_HEAD(&normal_trees);
 
@@ -9015,7 +9019,7 @@ again:
 out:
 	if (opt_check_repair) {
 		free_corrupt_blocks_tree(gfs_info->corrupt_blocks);
-		extent_io_tree_cleanup(&excluded_extents);
+		extent_io_tree_release(&excluded_extents);
 		gfs_info->fsck_extent_cache = NULL;
 		gfs_info->free_extent_hook = NULL;
 		gfs_info->corrupt_blocks = NULL;
@@ -9046,7 +9050,7 @@ loop:
 	free_extent_record_cache(&extent_cache);
 	free_root_item_list(&normal_trees);
 	free_root_item_list(&dropping_trees);
-	extent_io_tree_cleanup(&excluded_extents);
+	extent_io_tree_release(&excluded_extents);
 	goto again;
 }
 
@@ -9215,7 +9219,8 @@ static int reset_block_groups(void)
 				      btrfs_chunk_type(leaf, chunk), key.offset,
 				      btrfs_chunk_length(leaf, chunk));
 		set_extent_dirty(&gfs_info->free_space_cache, key.offset,
-				 key.offset + btrfs_chunk_length(leaf, chunk));
+				 key.offset + btrfs_chunk_length(leaf, chunk),
+				 GFP_NOFS);
 		path.slots[0]++;
 	}
 	start = 0;
diff --git a/check/mode-common.c b/check/mode-common.c
index 120165aa..394c35fe 100644
--- a/check/mode-common.c
+++ b/check/mode-common.c
@@ -596,10 +596,11 @@ void reset_cached_block_groups()
 
 	while (1) {
 		ret = find_first_extent_bit(&gfs_info->free_space_cache, 0,
-					    &start, &end, EXTENT_DIRTY);
+					    &start, &end, EXTENT_DIRTY, NULL);
 		if (ret)
 			break;
-		clear_extent_dirty(&gfs_info->free_space_cache, start, end);
+		clear_extent_dirty(&gfs_info->free_space_cache, start, end,
+				   NULL);
 	}
 
 	start = 0;
@@ -626,7 +627,7 @@ int exclude_metadata_blocks(void)
 	excluded_extents = malloc(sizeof(*excluded_extents));
 	if (!excluded_extents)
 		return -ENOMEM;
-	extent_io_tree_init(excluded_extents);
+	extent_io_tree_init(gfs_info, excluded_extents, 0);
 	gfs_info->excluded_extents = excluded_extents;
 
 	return btrfs_mark_used_tree_blocks(gfs_info, excluded_extents);
@@ -635,7 +636,7 @@ int exclude_metadata_blocks(void)
 void cleanup_excluded_extents(void)
 {
 	if (gfs_info->excluded_extents) {
-		extent_io_tree_cleanup(gfs_info->excluded_extents);
+		extent_io_tree_release(gfs_info->excluded_extents);
 		free(gfs_info->excluded_extents);
 	}
 	gfs_info->excluded_extents = NULL;
diff --git a/check/mode-lowmem.c b/check/mode-lowmem.c
index 237e0fdb..0bc95930 100644
--- a/check/mode-lowmem.c
+++ b/check/mode-lowmem.c
@@ -260,12 +260,12 @@ static int modify_block_group_cache(struct btrfs_block_group *block_group, int c
 
 	if (cache && !block_group->cached) {
 		block_group->cached = 1;
-		clear_extent_dirty(free_space_cache, start, end - 1);
+		clear_extent_dirty(free_space_cache, start, end - 1, NULL);
 	}
 
 	if (!cache && block_group->cached) {
 		block_group->cached = 0;
-		clear_extent_dirty(free_space_cache, start, end - 1);
+		clear_extent_dirty(free_space_cache, start, end - 1, NULL);
 	}
 	return 0;
 }
diff --git a/check/repair.c b/check/repair.c
index 8c1e2027..07c432b3 100644
--- a/check/repair.c
+++ b/check/repair.c
@@ -79,13 +79,13 @@ static int traverse_tree_blocks(struct extent_io_tree *tree,
 	 * This can not only avoid forever loop with broken filesystem
 	 * but also give us some speedups.
 	 */
-	if (test_range_bit(tree, eb->start, end - 1, EXTENT_DIRTY, 0))
+	if (test_range_bit(tree, eb->start, end - 1, EXTENT_DIRTY, 0, NULL))
 		return 0;
 
 	if (pin)
 		btrfs_pin_extent(fs_info, eb->start, eb->len);
 	else
-		set_extent_dirty(tree, eb->start, end - 1);
+		set_extent_dirty(tree, eb->start, end - 1, GFP_NOFS);
 
 	nritems = btrfs_header_nritems(eb);
 	for (i = 0; i < nritems; i++) {
@@ -129,7 +129,7 @@ static int traverse_tree_blocks(struct extent_io_tree *tree,
 					btrfs_pin_extent(fs_info, bytenr,
 							 fs_info->nodesize);
 				else
-					set_extent_dirty(tree, bytenr, end);
+					set_extent_dirty(tree, bytenr, end, GFP_NOFS);
 				continue;
 			}
 
@@ -211,7 +211,7 @@ static int populate_used_from_extent_root(struct btrfs_root *root,
 				ret = -EINVAL;
 				break;
 			}
-			set_extent_dirty(io_tree, start, end);
+			set_extent_dirty(io_tree, start, end, GFP_NOFS);
 		}
 
 		path.slots[0]++;
@@ -260,7 +260,7 @@ int btrfs_fix_block_accounting(struct btrfs_trans_handle *trans)
 	if (ret)
 		return ret;
 
-	extent_io_tree_init(&used);
+	extent_io_tree_init(fs_info, &used, 0);
 
 	ret = btrfs_mark_used_blocks(fs_info, &used);
 	if (ret)
@@ -282,7 +282,7 @@ int btrfs_fix_block_accounting(struct btrfs_trans_handle *trans)
 	start = 0;
 	while (1) {
 		ret = find_first_extent_bit(&used, 0, &start, &end,
-					    EXTENT_DIRTY);
+					    EXTENT_DIRTY, NULL);
 		if (ret)
 			break;
 
@@ -291,12 +291,12 @@ int btrfs_fix_block_accounting(struct btrfs_trans_handle *trans)
 					       1, 0);
 		if (ret)
 			goto out;
-		clear_extent_dirty(&used, start, end);
+		clear_extent_dirty(&used, start, end, NULL);
 	}
 	btrfs_set_super_bytes_used(fs_info->super_copy, bytes_used);
 	ret = 0;
 out:
-	extent_io_tree_cleanup(&used);
+	extent_io_tree_release(&used);
 	return ret;
 }
 
diff --git a/cmds/rescue-chunk-recover.c b/cmds/rescue-chunk-recover.c
index 728f7194..ce53da2e 100644
--- a/cmds/rescue-chunk-recover.c
+++ b/cmds/rescue-chunk-recover.c
@@ -1099,7 +1099,7 @@ static int block_group_free_all_extent(struct btrfs_trans_handle *trans,
 
 	if (list_empty(&cache->dirty_list))
 		list_add_tail(&cache->dirty_list, &trans->dirty_bgs);
-	set_extent_dirty(&info->free_space_cache, start, end);
+	set_extent_dirty(&info->free_space_cache, start, end, GFP_NOFS);
 
 	cache->used = 0;
 
diff --git a/image/main.c b/image/main.c
index a90e6ff0..ae7acb96 100644
--- a/image/main.c
+++ b/image/main.c
@@ -475,7 +475,7 @@ static void metadump_destroy(struct metadump_struct *md, int num_threads)
 		free(name->sub);
 		free(name);
 	}
-	extent_io_tree_cleanup(&md->seen);
+	extent_io_tree_release(&md->seen);
 }
 
 static int metadump_init(struct metadump_struct *md, struct btrfs_root *root,
@@ -491,7 +491,7 @@ static int metadump_init(struct metadump_struct *md, struct btrfs_root *root,
 	memset(md, 0, sizeof(*md));
 	INIT_LIST_HEAD(&md->list);
 	INIT_LIST_HEAD(&md->ordered);
-	extent_io_tree_init(&md->seen);
+	extent_io_tree_init(NULL, &md->seen, 0);
 	md->root = root;
 	md->out = out;
 	md->pending_start = (u64)-1;
@@ -784,11 +784,12 @@ static int copy_tree_blocks(struct btrfs_root *root, struct extent_buffer *eb,
 
 	bytenr = btrfs_header_bytenr(eb);
 	if (test_range_bit(&metadump->seen, bytenr,
-			   bytenr + fs_info->nodesize - 1, EXTENT_DIRTY, 1))
+			   bytenr + fs_info->nodesize - 1, EXTENT_DIRTY, 1,
+			   NULL))
 		return 0;
 
 	set_extent_dirty(&metadump->seen, bytenr,
-			 bytenr + fs_info->nodesize - 1);
+			 bytenr + fs_info->nodesize - 1, GFP_NOFS);
 
 	ret = add_extent(btrfs_header_bytenr(eb), fs_info->nodesize,
 			 metadump, 0);
diff --git a/include/kerncompat.h b/include/kerncompat.h
index 6321446d..68007915 100644
--- a/include/kerncompat.h
+++ b/include/kerncompat.h
@@ -75,10 +75,17 @@
 #define BITS_PER_LONG (__SIZEOF_LONG__ * BITS_PER_BYTE)
 #define __GFP_BITS_SHIFT 20
 #define __GFP_BITS_MASK ((int)((1 << __GFP_BITS_SHIFT) - 1))
+#define __GFP_DMA32 0
+#define __GFP_HIGHMEM 0
 #define GFP_KERNEL 0
 #define GFP_NOFS 0
+#define GFP_NOWAIT 0
+#define GFP_ATOMIC 0
 #define __read_mostly
 #define ARRAY_SIZE(x) (sizeof(x) / sizeof((x)[0]))
+#define _RET_IP_ 0
+#define TASK_UNINTERRUPTIBLE 0
+#define SLAB_MEM_SPREAD 0
 
 #ifndef ULONG_MAX
 #define ULONG_MAX       (~0UL)
@@ -364,6 +371,38 @@ static inline int IS_ERR_OR_NULL(const void *ptr)
 #define kvfree(x) free(x)
 #define memalloc_nofs_save() (0)
 #define memalloc_nofs_restore(x)	((void)(x))
+#define __releases(x)
+#define __acquires(x)
+
+struct kmem_cache {
+	size_t size;
+};
+
+static inline struct kmem_cache *kmem_cache_create(const char *name,
+						   size_t size, unsigned long idk,
+						   unsigned long flags, void *private)
+{
+	struct kmem_cache *ret = malloc(sizeof(*ret));
+	if (!ret)
+		return ret;
+	ret->size = size;
+	return ret;
+}
+
+static inline void kmem_cache_destroy(struct kmem_cache *cache)
+{
+	free(cache);
+}
+
+static inline void *kmem_cache_alloc(struct kmem_cache *cache, gfp_t mask)
+{
+	return malloc(cache->size);
+}
+
+static inline void kmem_cache_free(struct kmem_cache *cache, void *ptr)
+{
+	free(ptr);
+}
 
 #define BUG_ON(c) bugon_trace(#c, __FILE__, __func__, __LINE__, (long)(c))
 #define BUG()				\
@@ -371,7 +410,13 @@ do {					\
 	BUG_ON(1);			\
 	__builtin_unreachable();	\
 } while (0)
-#define WARN_ON(c) warning_trace(#c, __FILE__, __func__, __LINE__, (long)(c))
+
+#define WARN_ON(c) ({					\
+	int __ret_warn_on = !!(c);			\
+	warning_trace(#c, __FILE__, __func__, __LINE__,	\
+		      (long)(__ret_warn_on));		\
+	__ret_warn_on;					\
+})
 
 #define container_of(ptr, type, member) ({                      \
         const typeof( ((type *)0)->member ) *__mptr = (ptr);    \
@@ -568,11 +613,33 @@ do {									\
 
 #define smp_rmb() do {} while (0)
 #define smp_mb__before_atomic() do {} while (0)
+#define smp_mb() do {} while (0)
 
 typedef struct refcount_struct {
 	int refs;
 } refcount_t;
 
+static inline void refcount_set(refcount_t *ref, int val)
+{
+	ref->refs = val;
+}
+
+static inline void refcount_inc(refcount_t *ref)
+{
+	ref->refs++;
+}
+
+static inline void refcount_dec(refcount_t *ref)
+{
+	ref->refs--;
+}
+
+static inline bool refcount_dec_and_test(refcount_t *ref)
+{
+	ref->refs--;
+	return ref->refs == 0;
+}
+
 typedef u32 blk_status_t;
 typedef u32 blk_opf_t;
 typedef int atomic_t;
@@ -589,9 +656,14 @@ struct work_struct {
 
 #define INIT_WORK(_w, _f) do { (_w)->func = (_f); } while (0)
 
-typedef struct wait_queue_head_s {
+typedef struct wait_queue_head {
 } wait_queue_head_t;
 
+struct wait_queue_entry {
+};
+
+#define DEFINE_WAIT(name)	struct wait_queue_entry name = {}
+
 struct super_block {
 	char *s_id;
 };
@@ -601,6 +673,9 @@ struct va_format {
 	va_list *va;
 };
 
+struct lock_class_key {
+};
+
 #define __init
 #define __cold
 #define __user
@@ -659,4 +734,86 @@ static inline void queue_work(struct workqueue_struct *wq, struct work_struct *w
 {
 }
 
+static inline bool wq_has_sleeper(struct wait_queue_head *wq)
+{
+	return false;
+}
+
+static inline bool waitqueue_active(struct wait_queue_head *wq)
+{
+	return false;
+}
+
+static inline void wake_up(struct wait_queue_head *wq)
+{
+}
+
+static inline void lockdep_set_class(spinlock_t *lock, struct lock_class_key *lclass)
+{
+}
+
+static inline bool cond_resched_lock(spinlock_t *lock)
+{
+	return false;
+}
+
+static inline void init_waitqueue_head(wait_queue_head_t *wqh)
+{
+}
+
+static inline bool need_resched(void)
+{
+	return false;
+}
+
+static inline bool gfpflags_allow_blocking(gfp_t mask)
+{
+	return true;
+}
+
+static inline void prepare_to_wait(wait_queue_head_t *wqh,
+				   struct wait_queue_entry *entry,
+				   unsigned long flags)
+{
+}
+
+static inline void finish_wait(wait_queue_head_t *wqh,
+			       struct wait_queue_entry *entry)
+{
+}
+
+static inline void schedule(void)
+{
+}
+
+/*
+ * Temporary definitions while syncing.
+ */
+struct btrfs_inode;
+struct extent_state;
+
+static inline void btrfs_merge_delalloc_extent(struct btrfs_inode *inode,
+					       struct extent_state *state,
+					       struct extent_state *other)
+{
+}
+
+static inline void btrfs_set_delalloc_extent(struct btrfs_inode *inode,
+					     struct extent_state *state,
+					     u32 bits)
+{
+}
+
+static inline void btrfs_split_delalloc_extent(struct btrfs_inode *inode,
+					       struct extent_state *orig,
+					       u64 split)
+{
+}
+
+static inline void btrfs_clear_delalloc_extent(struct btrfs_inode *inode,
+					       struct extent_state *state,
+					       u32 bits)
+{
+}
+
 #endif
diff --git a/kernel-lib/trace.h b/kernel-lib/trace.h
index 086bcd10..99bee344 100644
--- a/kernel-lib/trace.h
+++ b/kernel-lib/trace.h
@@ -26,4 +26,30 @@ static inline void trace_btrfs_workqueue_destroy(void *wq)
 {
 }
 
+static inline void trace_alloc_extent_state(struct extent_state *state,
+					    gfp_t mask, unsigned long ip)
+{
+}
+
+static inline void trace_free_extent_state(struct extent_state *state,
+					   unsigned long ip)
+{
+}
+
+static inline void trace_btrfs_clear_extent_bit(struct extent_io_tree *tree,
+						u64 start, u64 end, u32 bits)
+{
+}
+
+static inline void trace_btrfs_set_extent_bit(struct extent_io_tree *tree,
+					      u64 start, u64 end, u32 bits)
+{
+}
+
+static inline void trace_btrfs_convert_extent_bit(struct extent_io_tree *tree,
+						  u64 start, u64 end, u32 bits,
+						  u32 clear_bits)
+{
+}
+
 #endif /* __PROGS_TRACE_H__ */
diff --git a/kernel-shared/ctree.h b/kernel-shared/ctree.h
index 6365a1f6..8de1fba4 100644
--- a/kernel-shared/ctree.h
+++ b/kernel-shared/ctree.h
@@ -28,6 +28,7 @@
 #include "kernel-shared/uapi/btrfs.h"
 #include "kernel-shared/uapi/btrfs_tree.h"
 #include "accessors.h"
+#include "extent-io-tree.h"
 
 struct btrfs_root;
 struct btrfs_trans_handle;
diff --git a/kernel-shared/disk-io.c b/kernel-shared/disk-io.c
index 7d165720..030bc780 100644
--- a/kernel-shared/disk-io.c
+++ b/kernel-shared/disk-io.c
@@ -866,10 +866,10 @@ struct btrfs_fs_info *btrfs_new_fs_info(int writable, u64 sb_bytenr)
 		goto free_all;
 
 	extent_buffer_init_cache(fs_info);
-	extent_io_tree_init(&fs_info->dirty_buffers);
-	extent_io_tree_init(&fs_info->free_space_cache);
-	extent_io_tree_init(&fs_info->pinned_extents);
-	extent_io_tree_init(&fs_info->extent_ins);
+	extent_io_tree_init(fs_info, &fs_info->dirty_buffers, 0);
+	extent_io_tree_init(fs_info, &fs_info->free_space_cache, 0);
+	extent_io_tree_init(fs_info, &fs_info->pinned_extents, 0);
+	extent_io_tree_init(fs_info, &fs_info->extent_ins, 0);
 
 	fs_info->block_group_cache_tree = RB_ROOT;
 	fs_info->excluded_extents = NULL;
@@ -1350,11 +1350,11 @@ void btrfs_cleanup_all_caches(struct btrfs_fs_info *fs_info)
 		free_extent_buffer(eb);
 	}
 	free_mapping_cache_tree(&fs_info->mapping_tree.cache_tree);
-	extent_io_tree_cleanup(&fs_info->dirty_buffers);
+	extent_io_tree_release(&fs_info->dirty_buffers);
 	extent_buffer_free_cache(fs_info);
-	extent_io_tree_cleanup(&fs_info->free_space_cache);
-	extent_io_tree_cleanup(&fs_info->pinned_extents);
-	extent_io_tree_cleanup(&fs_info->extent_ins);
+	extent_io_tree_release(&fs_info->free_space_cache);
+	extent_io_tree_release(&fs_info->pinned_extents);
+	extent_io_tree_release(&fs_info->extent_ins);
 }
 
 int btrfs_scan_fs_devices(int fd, const char *path,
diff --git a/kernel-shared/extent-io-tree.c b/kernel-shared/extent-io-tree.c
new file mode 100644
index 00000000..206d154f
--- /dev/null
+++ b/kernel-shared/extent-io-tree.c
@@ -0,0 +1,1733 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include "messages.h"
+#include "ctree.h"
+#include "async-thread.h"
+#include "extent-io-tree.h"
+#include "misc.h"
+#include "ulist.h"
+#include "kernel-lib/trace.h"
+#include "common/internal.h"
+
+/*
+ * MODIFIED:
+ *  - temporarily define this until we can sync everything.
+ */
+struct extent_changeset {
+	u64 bytes_changed;
+	struct ulist range_changed;
+};
+
+/*
+ * MODIFIED:
+ *  - Need to set this to NULL so we init this when we init an extent_io_tree
+ *    for the first time.
+ */
+static struct kmem_cache *extent_state_cache = NULL;
+
+static inline bool extent_state_in_tree(const struct extent_state *state)
+{
+	return !RB_EMPTY_NODE(&state->rb_node);
+}
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
+
+#define btrfs_debug_check_extent_io_range(tree, start, end)		\
+	__btrfs_debug_check_extent_io_range(__func__, (tree), (start), (end))
+static inline void __btrfs_debug_check_extent_io_range(const char *caller,
+						       struct extent_io_tree *tree,
+						       u64 start, u64 end)
+{
+	struct btrfs_inode *inode = tree->inode;
+	u64 isize;
+
+	if (!inode)
+		return;
+
+	isize = i_size_read(&inode->vfs_inode);
+	if (end >= PAGE_SIZE && (end % 2) == 0 && end != isize - 1) {
+		btrfs_debug_rl(inode->root->fs_info,
+		    "%s: ino %llu isize %llu odd range [%llu,%llu]",
+			caller, btrfs_ino(inode), isize, start, end);
+	}
+}
+#else
+#define btrfs_leak_debug_add_state(state)		do {} while (0)
+#define btrfs_leak_debug_del_state(state)		do {} while (0)
+#define btrfs_extent_state_leak_debug_check()		do {} while (0)
+#define btrfs_debug_check_extent_io_range(c, s, e)	do {} while (0)
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
+struct tree_entry {
+	u64 start;
+	u64 end;
+	struct rb_node rb_node;
+};
+
+/*
+ * MODIFIED:
+ *  - We use this as an entry point for init'ing the kmem_cache.
+ */
+void extent_io_tree_init(struct btrfs_fs_info *fs_info,
+			 struct extent_io_tree *tree, unsigned int owner)
+{
+	extent_state_init_cachep();
+	tree->fs_info = fs_info;
+	tree->state = RB_ROOT;
+	spin_lock_init(&tree->lock);
+	tree->inode = NULL;
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
+static struct extent_state *alloc_extent_state(gfp_t mask)
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
+static struct extent_state *alloc_extent_state_atomic(struct extent_state *prealloc)
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
+static int add_extent_changeset(struct extent_state *state, u32 bits,
+				 struct extent_changeset *changeset,
+				 int set)
+{
+	int ret;
+
+	if (!changeset)
+		return 0;
+	if (set && (state->state & bits) == bits)
+		return 0;
+	if (!set && (state->state & bits) == 0)
+		return 0;
+	changeset->bytes_changed += state->end - state->start + 1;
+	ret = ulist_add(&changeset->range_changed, state->start, state->end,
+			GFP_ATOMIC);
+	return ret;
+}
+
+static inline struct extent_state *next_state(struct extent_state *state)
+{
+	struct rb_node *next = rb_next(&state->rb_node);
+
+	if (next)
+		return rb_entry(next, struct extent_state, rb_node);
+	else
+		return NULL;
+}
+
+static inline struct extent_state *prev_state(struct extent_state *state)
+{
+	struct rb_node *next = rb_prev(&state->rb_node);
+
+	if (next)
+		return rb_entry(next, struct extent_state, rb_node);
+	else
+		return NULL;
+}
+
+/*
+ * Search @tree for an entry that contains @offset. Such entry would have
+ * entry->start <= offset && entry->end >= offset.
+ *
+ * @tree:       the tree to search
+ * @offset:     offset that should fall within an entry in @tree
+ * @node_ret:   pointer where new node should be anchored (used when inserting an
+ *	        entry in the tree)
+ * @parent_ret: points to entry which would have been the parent of the entry,
+ *               containing @offset
+ *
+ * Return a pointer to the entry that contains @offset byte address and don't change
+ * @node_ret and @parent_ret.
+ *
+ * If no such entry exists, return pointer to entry that ends before @offset
+ * and fill parameters @node_ret and @parent_ret, ie. does not return NULL.
+ */
+static inline struct extent_state *tree_search_for_insert(struct extent_io_tree *tree,
+							  u64 offset,
+							  struct rb_node ***node_ret,
+							  struct rb_node **parent_ret)
+{
+	struct rb_root *root = &tree->state;
+	struct rb_node **node = &root->rb_node;
+	struct rb_node *prev = NULL;
+	struct extent_state *entry = NULL;
+
+	while (*node) {
+		prev = *node;
+		entry = rb_entry(prev, struct extent_state, rb_node);
+
+		if (offset < entry->start)
+			node = &(*node)->rb_left;
+		else if (offset > entry->end)
+			node = &(*node)->rb_right;
+		else
+			return entry;
+	}
+
+	if (node_ret)
+		*node_ret = node;
+	if (parent_ret)
+		*parent_ret = prev;
+
+	/* Search neighbors until we find the first one past the end */
+	while (entry && offset > entry->end)
+		entry = next_state(entry);
+
+	return entry;
+}
+
+/*
+ * Search offset in the tree or fill neighbor rbtree node pointers.
+ *
+ * @tree:      the tree to search
+ * @offset:    offset that should fall within an entry in @tree
+ * @next_ret:  pointer to the first entry whose range ends after @offset
+ * @prev_ret:  pointer to the first entry whose range begins before @offset
+ *
+ * Return a pointer to the entry that contains @offset byte address. If no
+ * such entry exists, then return NULL and fill @prev_ret and @next_ret.
+ * Otherwise return the found entry and other pointers are left untouched.
+ */
+static struct extent_state *tree_search_prev_next(struct extent_io_tree *tree,
+						  u64 offset,
+						  struct extent_state **prev_ret,
+						  struct extent_state **next_ret)
+{
+	struct rb_root *root = &tree->state;
+	struct rb_node **node = &root->rb_node;
+	struct extent_state *orig_prev;
+	struct extent_state *entry = NULL;
+
+	ASSERT(prev_ret);
+	ASSERT(next_ret);
+
+	while (*node) {
+		entry = rb_entry(*node, struct extent_state, rb_node);
+
+		if (offset < entry->start)
+			node = &(*node)->rb_left;
+		else if (offset > entry->end)
+			node = &(*node)->rb_right;
+		else
+			return entry;
+	}
+
+	orig_prev = entry;
+	while (entry && offset > entry->end)
+		entry = next_state(entry);
+	*next_ret = entry;
+	entry = orig_prev;
+
+	while (entry && offset < entry->start)
+		entry = prev_state(entry);
+	*prev_ret = entry;
+
+	return NULL;
+}
+
+/*
+ * Inexact rb-tree search, return the next entry if @offset is not found
+ */
+static inline struct extent_state *tree_search(struct extent_io_tree *tree, u64 offset)
+{
+	return tree_search_for_insert(tree, offset, NULL, NULL);
+}
+
+static void extent_io_tree_panic(struct extent_io_tree *tree, int err)
+{
+	btrfs_panic(tree->fs_info, err,
+	"locking error: extent tree was modified by another thread while locked");
+}
+
+/*
+ * Utility function to look for merge candidates inside a given range.  Any
+ * extents with matching state are merged together into a single extent in the
+ * tree.  Extents with EXTENT_IO in their state field are not merged because
+ * the end_io handlers need to be able to do operations on them without
+ * sleeping (or doing allocations/splits).
+ *
+ * This should be called with the tree lock held.
+ */
+static void merge_state(struct extent_io_tree *tree, struct extent_state *state)
+{
+	struct extent_state *other;
+
+	if (state->state & (EXTENT_LOCKED | EXTENT_BOUNDARY))
+		return;
+
+	other = prev_state(state);
+	if (other && other->end == state->start - 1 &&
+	    other->state == state->state) {
+		if (tree->inode)
+			btrfs_merge_delalloc_extent(tree->inode, state, other);
+		state->start = other->start;
+		rb_erase(&other->rb_node, &tree->state);
+		RB_CLEAR_NODE(&other->rb_node);
+		free_extent_state(other);
+	}
+	other = next_state(state);
+	if (other && other->start == state->end + 1 &&
+	    other->state == state->state) {
+		if (tree->inode)
+			btrfs_merge_delalloc_extent(tree->inode, state, other);
+		state->end = other->end;
+		rb_erase(&other->rb_node, &tree->state);
+		RB_CLEAR_NODE(&other->rb_node);
+		free_extent_state(other);
+	}
+}
+
+static void set_state_bits(struct extent_io_tree *tree,
+			   struct extent_state *state,
+			   u32 bits, struct extent_changeset *changeset)
+{
+	u32 bits_to_set = bits & ~EXTENT_CTLBITS;
+	int ret;
+
+	if (tree->inode)
+		btrfs_set_delalloc_extent(tree->inode, state, bits);
+
+	ret = add_extent_changeset(state, bits_to_set, changeset, 1);
+	BUG_ON(ret < 0);
+	state->state |= bits_to_set;
+}
+
+/*
+ * Insert an extent_state struct into the tree.  'bits' are set on the
+ * struct before it is inserted.
+ *
+ * This may return -EEXIST if the extent is already there, in which case the
+ * state struct is freed.
+ *
+ * The tree lock is not taken internally.  This is a utility function and
+ * probably isn't what you want to call (see set/clear_extent_bit).
+ */
+static int insert_state(struct extent_io_tree *tree,
+			struct extent_state *state,
+			u32 bits, struct extent_changeset *changeset)
+{
+	struct rb_node **node;
+	struct rb_node *parent = NULL;
+	const u64 end = state->end;
+
+	set_state_bits(tree, state, bits, changeset);
+
+	node = &tree->state.rb_node;
+	while (*node) {
+		struct extent_state *entry;
+
+		parent = *node;
+		entry = rb_entry(parent, struct extent_state, rb_node);
+
+		if (end < entry->start) {
+			node = &(*node)->rb_left;
+		} else if (end > entry->end) {
+			node = &(*node)->rb_right;
+		} else {
+			btrfs_err(tree->fs_info,
+			       "found node %llu %llu on insert of %llu %llu",
+			       entry->start, entry->end, state->start, end);
+			return -EEXIST;
+		}
+	}
+
+	rb_link_node(&state->rb_node, parent, node);
+	rb_insert_color(&state->rb_node, &tree->state);
+
+	merge_state(tree, state);
+	return 0;
+}
+
+/*
+ * Insert state to @tree to the location given by @node and @parent.
+ */
+static void insert_state_fast(struct extent_io_tree *tree,
+			      struct extent_state *state, struct rb_node **node,
+			      struct rb_node *parent, unsigned bits,
+			      struct extent_changeset *changeset)
+{
+	set_state_bits(tree, state, bits, changeset);
+	rb_link_node(&state->rb_node, parent, node);
+	rb_insert_color(&state->rb_node, &tree->state);
+	merge_state(tree, state);
+}
+
+/*
+ * Split a given extent state struct in two, inserting the preallocated
+ * struct 'prealloc' as the newly created second half.  'split' indicates an
+ * offset inside 'orig' where it should be split.
+ *
+ * Before calling,
+ * the tree has 'orig' at [orig->start, orig->end].  After calling, there
+ * are two extent state structs in the tree:
+ * prealloc: [orig->start, split - 1]
+ * orig: [ split, orig->end ]
+ *
+ * The tree locks are not taken by this function. They need to be held
+ * by the caller.
+ */
+static int split_state(struct extent_io_tree *tree, struct extent_state *orig,
+		       struct extent_state *prealloc, u64 split)
+{
+	struct rb_node *parent = NULL;
+	struct rb_node **node;
+
+	if (tree->inode)
+		btrfs_split_delalloc_extent(tree->inode, orig, split);
+
+	prealloc->start = orig->start;
+	prealloc->end = split - 1;
+	prealloc->state = orig->state;
+	orig->start = split;
+
+	parent = &orig->rb_node;
+	node = &parent;
+	while (*node) {
+		struct extent_state *entry;
+
+		parent = *node;
+		entry = rb_entry(parent, struct extent_state, rb_node);
+
+		if (prealloc->end < entry->start) {
+			node = &(*node)->rb_left;
+		} else if (prealloc->end > entry->end) {
+			node = &(*node)->rb_right;
+		} else {
+			free_extent_state(prealloc);
+			return -EEXIST;
+		}
+	}
+
+	rb_link_node(&prealloc->rb_node, parent, node);
+	rb_insert_color(&prealloc->rb_node, &tree->state);
+
+	return 0;
+}
+
+/*
+ * Utility function to clear some bits in an extent state struct.  It will
+ * optionally wake up anyone waiting on this state (wake == 1).
+ *
+ * If no bits are set on the state struct after clearing things, the
+ * struct is freed and removed from the tree
+ */
+static struct extent_state *clear_state_bit(struct extent_io_tree *tree,
+					    struct extent_state *state,
+					    u32 bits, int wake,
+					    struct extent_changeset *changeset)
+{
+	struct extent_state *next;
+	u32 bits_to_clear = bits & ~EXTENT_CTLBITS;
+	int ret;
+
+	if (tree->inode)
+		btrfs_clear_delalloc_extent(tree->inode, state, bits);
+
+	ret = add_extent_changeset(state, bits_to_clear, changeset, 0);
+	BUG_ON(ret < 0);
+	state->state &= ~bits_to_clear;
+	if (wake)
+		wake_up(&state->wq);
+	if (state->state == 0) {
+		next = next_state(state);
+		if (extent_state_in_tree(state)) {
+			rb_erase(&state->rb_node, &tree->state);
+			RB_CLEAR_NODE(&state->rb_node);
+			free_extent_state(state);
+		} else {
+			WARN_ON(1);
+		}
+	} else {
+		merge_state(tree, state);
+		next = next_state(state);
+	}
+	return next;
+}
+
+/*
+ * Clear some bits on a range in the tree.  This may require splitting or
+ * inserting elements in the tree, so the gfp mask is used to indicate which
+ * allocations or sleeping are allowed.
+ *
+ * Pass 'wake' == 1 to kick any sleepers, and 'delete' == 1 to remove the given
+ * range from the tree regardless of state (ie for truncate).
+ *
+ * The range [start, end] is inclusive.
+ *
+ * This takes the tree lock, and returns 0 on success and < 0 on error.
+ */
+int __clear_extent_bit(struct extent_io_tree *tree, u64 start, u64 end,
+		       u32 bits, struct extent_state **cached_state,
+		       gfp_t mask, struct extent_changeset *changeset)
+{
+	struct extent_state *state;
+	struct extent_state *cached;
+	struct extent_state *prealloc = NULL;
+	u64 last_end;
+	int err;
+	int clear = 0;
+	int wake;
+	int delete = (bits & EXTENT_CLEAR_ALL_BITS);
+
+	btrfs_debug_check_extent_io_range(tree, start, end);
+	trace_btrfs_clear_extent_bit(tree, start, end - start + 1, bits);
+
+	if (delete)
+		bits |= ~EXTENT_CTLBITS;
+
+	if (bits & EXTENT_DELALLOC)
+		bits |= EXTENT_NORESERVE;
+
+	wake = (bits & EXTENT_LOCKED) ? 1 : 0;
+	if (bits & (EXTENT_LOCKED | EXTENT_BOUNDARY))
+		clear = 1;
+again:
+	if (!prealloc) {
+		/*
+		 * Don't care for allocation failure here because we might end
+		 * up not needing the pre-allocated extent state at all, which
+		 * is the case if we only have in the tree extent states that
+		 * cover our input range and don't cover too any other range.
+		 * If we end up needing a new extent state we allocate it later.
+		 */
+		prealloc = alloc_extent_state(mask);
+	}
+
+	spin_lock(&tree->lock);
+	if (cached_state) {
+		cached = *cached_state;
+
+		if (clear) {
+			*cached_state = NULL;
+			cached_state = NULL;
+		}
+
+		if (cached && extent_state_in_tree(cached) &&
+		    cached->start <= start && cached->end > start) {
+			if (clear)
+				refcount_dec(&cached->refs);
+			state = cached;
+			goto hit_next;
+		}
+		if (clear)
+			free_extent_state(cached);
+	}
+
+	/* This search will find the extents that end after our range starts. */
+	state = tree_search(tree, start);
+	if (!state)
+		goto out;
+hit_next:
+	if (state->start > end)
+		goto out;
+	WARN_ON(state->end < start);
+	last_end = state->end;
+
+	/* The state doesn't have the wanted bits, go ahead. */
+	if (!(state->state & bits)) {
+		state = next_state(state);
+		goto next;
+	}
+
+	/*
+	 *     | ---- desired range ---- |
+	 *  | state | or
+	 *  | ------------- state -------------- |
+	 *
+	 * We need to split the extent we found, and may flip bits on second
+	 * half.
+	 *
+	 * If the extent we found extends past our range, we just split and
+	 * search again.  It'll get split again the next time though.
+	 *
+	 * If the extent we found is inside our range, we clear the desired bit
+	 * on it.
+	 */
+
+	if (state->start < start) {
+		prealloc = alloc_extent_state_atomic(prealloc);
+		if (!prealloc)
+			goto search_again;
+		err = split_state(tree, state, prealloc, start);
+		if (err)
+			extent_io_tree_panic(tree, err);
+
+		prealloc = NULL;
+		if (err)
+			goto out;
+		if (state->end <= end) {
+			state = clear_state_bit(tree, state, bits, wake, changeset);
+			goto next;
+		}
+		goto search_again;
+	}
+	/*
+	 * | ---- desired range ---- |
+	 *                        | state |
+	 * We need to split the extent, and clear the bit on the first half.
+	 */
+	if (state->start <= end && state->end > end) {
+		prealloc = alloc_extent_state_atomic(prealloc);
+		if (!prealloc)
+			goto search_again;
+		err = split_state(tree, state, prealloc, end + 1);
+		if (err)
+			extent_io_tree_panic(tree, err);
+
+		if (wake)
+			wake_up(&state->wq);
+
+		clear_state_bit(tree, prealloc, bits, wake, changeset);
+
+		prealloc = NULL;
+		goto out;
+	}
+
+	state = clear_state_bit(tree, state, bits, wake, changeset);
+next:
+	if (last_end == (u64)-1)
+		goto out;
+	start = last_end + 1;
+	if (start <= end && state && !need_resched())
+		goto hit_next;
+
+search_again:
+	if (start > end)
+		goto out;
+	spin_unlock(&tree->lock);
+	if (gfpflags_allow_blocking(mask))
+		cond_resched();
+	goto again;
+
+out:
+	spin_unlock(&tree->lock);
+	if (prealloc)
+		free_extent_state(prealloc);
+
+	return 0;
+
+}
+
+static void wait_on_state(struct extent_io_tree *tree,
+			  struct extent_state *state)
+		__releases(tree->lock)
+		__acquires(tree->lock)
+{
+	DEFINE_WAIT(wait);
+	prepare_to_wait(&state->wq, &wait, TASK_UNINTERRUPTIBLE);
+	spin_unlock(&tree->lock);
+	schedule();
+	spin_lock(&tree->lock);
+	finish_wait(&state->wq, &wait);
+}
+
+/*
+ * Wait for one or more bits to clear on a range in the state tree.
+ * The range [start, end] is inclusive.
+ * The tree lock is taken by this function
+ */
+void wait_extent_bit(struct extent_io_tree *tree, u64 start, u64 end, u32 bits,
+		     struct extent_state **cached_state)
+{
+	struct extent_state *state;
+
+	btrfs_debug_check_extent_io_range(tree, start, end);
+
+	spin_lock(&tree->lock);
+again:
+	/*
+	 * Maintain cached_state, as we may not remove it from the tree if there
+	 * are more bits than the bits we're waiting on set on this state.
+	 */
+	if (cached_state && *cached_state) {
+		state = *cached_state;
+		if (extent_state_in_tree(state) &&
+		    state->start <= start && start < state->end)
+			goto process_node;
+	}
+	while (1) {
+		/*
+		 * This search will find all the extents that end after our
+		 * range starts.
+		 */
+		state = tree_search(tree, start);
+process_node:
+		if (!state)
+			break;
+		if (state->start > end)
+			goto out;
+
+		if (state->state & bits) {
+			start = state->start;
+			refcount_inc(&state->refs);
+			wait_on_state(tree, state);
+			free_extent_state(state);
+			goto again;
+		}
+		start = state->end + 1;
+
+		if (start > end)
+			break;
+
+		if (!cond_resched_lock(&tree->lock)) {
+			state = next_state(state);
+			goto process_node;
+		}
+	}
+out:
+	/* This state is no longer useful, clear it and free it up. */
+	if (cached_state && *cached_state) {
+		state = *cached_state;
+		*cached_state = NULL;
+		free_extent_state(state);
+	}
+	spin_unlock(&tree->lock);
+}
+
+static void cache_state_if_flags(struct extent_state *state,
+				 struct extent_state **cached_ptr,
+				 unsigned flags)
+{
+	if (cached_ptr && !(*cached_ptr)) {
+		if (!flags || (state->state & flags)) {
+			*cached_ptr = state;
+			refcount_inc(&state->refs);
+		}
+	}
+}
+
+static void cache_state(struct extent_state *state,
+			struct extent_state **cached_ptr)
+{
+	return cache_state_if_flags(state, cached_ptr,
+				    EXTENT_LOCKED | EXTENT_BOUNDARY);
+}
+
+/*
+ * Find the first state struct with 'bits' set after 'start', and return it.
+ * tree->lock must be held.  NULL will returned if nothing was found after
+ * 'start'.
+ */
+static struct extent_state *find_first_extent_bit_state(struct extent_io_tree *tree,
+							u64 start, u32 bits)
+{
+	struct extent_state *state;
+
+	/*
+	 * This search will find all the extents that end after our range
+	 * starts.
+	 */
+	state = tree_search(tree, start);
+	while (state) {
+		if (state->end >= start && (state->state & bits))
+			return state;
+		state = next_state(state);
+	}
+	return NULL;
+}
+
+/*
+ * Find the first offset in the io tree with one or more @bits set.
+ *
+ * Note: If there are multiple bits set in @bits, any of them will match.
+ *
+ * Return 0 if we find something, and update @start_ret and @end_ret.
+ * Return 1 if we found nothing.
+ */
+int find_first_extent_bit(struct extent_io_tree *tree, u64 start,
+			  u64 *start_ret, u64 *end_ret, u32 bits,
+			  struct extent_state **cached_state)
+{
+	struct extent_state *state;
+	int ret = 1;
+
+	spin_lock(&tree->lock);
+	if (cached_state && *cached_state) {
+		state = *cached_state;
+		if (state->end == start - 1 && extent_state_in_tree(state)) {
+			while ((state = next_state(state)) != NULL) {
+				if (state->state & bits)
+					goto got_it;
+			}
+			free_extent_state(*cached_state);
+			*cached_state = NULL;
+			goto out;
+		}
+		free_extent_state(*cached_state);
+		*cached_state = NULL;
+	}
+
+	state = find_first_extent_bit_state(tree, start, bits);
+got_it:
+	if (state) {
+		cache_state_if_flags(state, cached_state, 0);
+		*start_ret = state->start;
+		*end_ret = state->end;
+		ret = 0;
+	}
+out:
+	spin_unlock(&tree->lock);
+	return ret;
+}
+
+/*
+ * Find a contiguous area of bits
+ *
+ * @tree:      io tree to check
+ * @start:     offset to start the search from
+ * @start_ret: the first offset we found with the bits set
+ * @end_ret:   the final contiguous range of the bits that were set
+ * @bits:      bits to look for
+ *
+ * set_extent_bit and clear_extent_bit can temporarily split contiguous ranges
+ * to set bits appropriately, and then merge them again.  During this time it
+ * will drop the tree->lock, so use this helper if you want to find the actual
+ * contiguous area for given bits.  We will search to the first bit we find, and
+ * then walk down the tree until we find a non-contiguous area.  The area
+ * returned will be the full contiguous area with the bits set.
+ */
+int find_contiguous_extent_bit(struct extent_io_tree *tree, u64 start,
+			       u64 *start_ret, u64 *end_ret, u32 bits)
+{
+	struct extent_state *state;
+	int ret = 1;
+
+	spin_lock(&tree->lock);
+	state = find_first_extent_bit_state(tree, start, bits);
+	if (state) {
+		*start_ret = state->start;
+		*end_ret = state->end;
+		while ((state = next_state(state)) != NULL) {
+			if (state->start > (*end_ret + 1))
+				break;
+			*end_ret = state->end;
+		}
+		ret = 0;
+	}
+	spin_unlock(&tree->lock);
+	return ret;
+}
+
+/*
+ * Find a contiguous range of bytes in the file marked as delalloc, not more
+ * than 'max_bytes'.  start and end are used to return the range,
+ *
+ * True is returned if we find something, false if nothing was in the tree.
+ */
+bool btrfs_find_delalloc_range(struct extent_io_tree *tree, u64 *start,
+			       u64 *end, u64 max_bytes,
+			       struct extent_state **cached_state)
+{
+	struct extent_state *state;
+	u64 cur_start = *start;
+	bool found = false;
+	u64 total_bytes = 0;
+
+	spin_lock(&tree->lock);
+
+	/*
+	 * This search will find all the extents that end after our range
+	 * starts.
+	 */
+	state = tree_search(tree, cur_start);
+	if (!state) {
+		*end = (u64)-1;
+		goto out;
+	}
+
+	while (state) {
+		if (found && (state->start != cur_start ||
+			      (state->state & EXTENT_BOUNDARY))) {
+			goto out;
+		}
+		if (!(state->state & EXTENT_DELALLOC)) {
+			if (!found)
+				*end = state->end;
+			goto out;
+		}
+		if (!found) {
+			*start = state->start;
+			*cached_state = state;
+			refcount_inc(&state->refs);
+		}
+		found = true;
+		*end = state->end;
+		cur_start = state->end + 1;
+		total_bytes += state->end - state->start + 1;
+		if (total_bytes >= max_bytes)
+			break;
+		state = next_state(state);
+	}
+out:
+	spin_unlock(&tree->lock);
+	return found;
+}
+
+/*
+ * Set some bits on a range in the tree.  This may require allocations or
+ * sleeping, so the gfp mask is used to indicate what is allowed.
+ *
+ * If any of the exclusive bits are set, this will fail with -EEXIST if some
+ * part of the range already has the desired bits set.  The extent_state of the
+ * existing range is returned in failed_state in this case, and the start of the
+ * existing range is returned in failed_start.  failed_state is used as an
+ * optimization for wait_extent_bit, failed_start must be used as the source of
+ * truth as failed_state may have changed since we returned.
+ *
+ * [start, end] is inclusive This takes the tree lock.
+ */
+static int __set_extent_bit(struct extent_io_tree *tree, u64 start, u64 end,
+			    u32 bits, u64 *failed_start,
+			    struct extent_state **failed_state,
+			    struct extent_state **cached_state,
+			    struct extent_changeset *changeset, gfp_t mask)
+{
+	struct extent_state *state;
+	struct extent_state *prealloc = NULL;
+	struct rb_node **p;
+	struct rb_node *parent;
+	int err = 0;
+	u64 last_start;
+	u64 last_end;
+	u32 exclusive_bits = (bits & EXTENT_LOCKED);
+
+	btrfs_debug_check_extent_io_range(tree, start, end);
+	trace_btrfs_set_extent_bit(tree, start, end - start + 1, bits);
+
+	if (exclusive_bits)
+		ASSERT(failed_start);
+	else
+		ASSERT(failed_start == NULL && failed_state == NULL);
+again:
+	if (!prealloc) {
+		/*
+		 * Don't care for allocation failure here because we might end
+		 * up not needing the pre-allocated extent state at all, which
+		 * is the case if we only have in the tree extent states that
+		 * cover our input range and don't cover too any other range.
+		 * If we end up needing a new extent state we allocate it later.
+		 */
+		prealloc = alloc_extent_state(mask);
+	}
+
+	spin_lock(&tree->lock);
+	if (cached_state && *cached_state) {
+		state = *cached_state;
+		if (state->start <= start && state->end > start &&
+		    extent_state_in_tree(state))
+			goto hit_next;
+	}
+	/*
+	 * This search will find all the extents that end after our range
+	 * starts.
+	 */
+	state = tree_search_for_insert(tree, start, &p, &parent);
+	if (!state) {
+		prealloc = alloc_extent_state_atomic(prealloc);
+		if (!prealloc)
+			goto search_again;
+		prealloc->start = start;
+		prealloc->end = end;
+		insert_state_fast(tree, prealloc, p, parent, bits, changeset);
+		cache_state(prealloc, cached_state);
+		prealloc = NULL;
+		goto out;
+	}
+hit_next:
+	last_start = state->start;
+	last_end = state->end;
+
+	/*
+	 * | ---- desired range ---- |
+	 * | state |
+	 *
+	 * Just lock what we found and keep going
+	 */
+	if (state->start == start && state->end <= end) {
+		if (state->state & exclusive_bits) {
+			*failed_start = state->start;
+			cache_state(state, failed_state);
+			err = -EEXIST;
+			goto out;
+		}
+
+		set_state_bits(tree, state, bits, changeset);
+		cache_state(state, cached_state);
+		merge_state(tree, state);
+		if (last_end == (u64)-1)
+			goto out;
+		start = last_end + 1;
+		state = next_state(state);
+		if (start < end && state && state->start == start &&
+		    !need_resched())
+			goto hit_next;
+		goto search_again;
+	}
+
+	/*
+	 *     | ---- desired range ---- |
+	 * | state |
+	 *   or
+	 * | ------------- state -------------- |
+	 *
+	 * We need to split the extent we found, and may flip bits on second
+	 * half.
+	 *
+	 * If the extent we found extends past our range, we just split and
+	 * search again.  It'll get split again the next time though.
+	 *
+	 * If the extent we found is inside our range, we set the desired bit
+	 * on it.
+	 */
+	if (state->start < start) {
+		if (state->state & exclusive_bits) {
+			*failed_start = start;
+			cache_state(state, failed_state);
+			err = -EEXIST;
+			goto out;
+		}
+
+		/*
+		 * If this extent already has all the bits we want set, then
+		 * skip it, not necessary to split it or do anything with it.
+		 */
+		if ((state->state & bits) == bits) {
+			start = state->end + 1;
+			cache_state(state, cached_state);
+			goto search_again;
+		}
+
+		prealloc = alloc_extent_state_atomic(prealloc);
+		if (!prealloc)
+			goto search_again;
+		err = split_state(tree, state, prealloc, start);
+		if (err)
+			extent_io_tree_panic(tree, err);
+
+		prealloc = NULL;
+		if (err)
+			goto out;
+		if (state->end <= end) {
+			set_state_bits(tree, state, bits, changeset);
+			cache_state(state, cached_state);
+			merge_state(tree, state);
+			if (last_end == (u64)-1)
+				goto out;
+			start = last_end + 1;
+			state = next_state(state);
+			if (start < end && state && state->start == start &&
+			    !need_resched())
+				goto hit_next;
+		}
+		goto search_again;
+	}
+	/*
+	 * | ---- desired range ---- |
+	 *     | state | or               | state |
+	 *
+	 * There's a hole, we need to insert something in it and ignore the
+	 * extent we found.
+	 */
+	if (state->start > start) {
+		u64 this_end;
+		if (end < last_start)
+			this_end = end;
+		else
+			this_end = last_start - 1;
+
+		prealloc = alloc_extent_state_atomic(prealloc);
+		if (!prealloc)
+			goto search_again;
+
+		/*
+		 * Avoid to free 'prealloc' if it can be merged with the later
+		 * extent.
+		 */
+		prealloc->start = start;
+		prealloc->end = this_end;
+		err = insert_state(tree, prealloc, bits, changeset);
+		if (err)
+			extent_io_tree_panic(tree, err);
+
+		cache_state(prealloc, cached_state);
+		prealloc = NULL;
+		start = this_end + 1;
+		goto search_again;
+	}
+	/*
+	 * | ---- desired range ---- |
+	 *                        | state |
+	 *
+	 * We need to split the extent, and set the bit on the first half
+	 */
+	if (state->start <= end && state->end > end) {
+		if (state->state & exclusive_bits) {
+			*failed_start = start;
+			cache_state(state, failed_state);
+			err = -EEXIST;
+			goto out;
+		}
+
+		prealloc = alloc_extent_state_atomic(prealloc);
+		if (!prealloc)
+			goto search_again;
+		err = split_state(tree, state, prealloc, end + 1);
+		if (err)
+			extent_io_tree_panic(tree, err);
+
+		set_state_bits(tree, prealloc, bits, changeset);
+		cache_state(prealloc, cached_state);
+		merge_state(tree, prealloc);
+		prealloc = NULL;
+		goto out;
+	}
+
+search_again:
+	if (start > end)
+		goto out;
+	spin_unlock(&tree->lock);
+	if (gfpflags_allow_blocking(mask))
+		cond_resched();
+	goto again;
+
+out:
+	spin_unlock(&tree->lock);
+	if (prealloc)
+		free_extent_state(prealloc);
+
+	return err;
+
+}
+
+int set_extent_bit(struct extent_io_tree *tree, u64 start, u64 end,
+		   u32 bits, struct extent_state **cached_state, gfp_t mask)
+{
+	return __set_extent_bit(tree, start, end, bits, NULL, NULL,
+				cached_state, NULL, mask);
+}
+
+/*
+ * Convert all bits in a given range from one bit to another
+ *
+ * @tree:	the io tree to search
+ * @start:	the start offset in bytes
+ * @end:	the end offset in bytes (inclusive)
+ * @bits:	the bits to set in this range
+ * @clear_bits:	the bits to clear in this range
+ * @cached_state:	state that we're going to cache
+ *
+ * This will go through and set bits for the given range.  If any states exist
+ * already in this range they are set with the given bit and cleared of the
+ * clear_bits.  This is only meant to be used by things that are mergeable, ie.
+ * converting from say DELALLOC to DIRTY.  This is not meant to be used with
+ * boundary bits like LOCK.
+ *
+ * All allocations are done with GFP_NOFS.
+ */
+int convert_extent_bit(struct extent_io_tree *tree, u64 start, u64 end,
+		       u32 bits, u32 clear_bits,
+		       struct extent_state **cached_state)
+{
+	struct extent_state *state;
+	struct extent_state *prealloc = NULL;
+	struct rb_node **p;
+	struct rb_node *parent;
+	int err = 0;
+	u64 last_start;
+	u64 last_end;
+	bool first_iteration = true;
+
+	btrfs_debug_check_extent_io_range(tree, start, end);
+	trace_btrfs_convert_extent_bit(tree, start, end - start + 1, bits,
+				       clear_bits);
+
+again:
+	if (!prealloc) {
+		/*
+		 * Best effort, don't worry if extent state allocation fails
+		 * here for the first iteration. We might have a cached state
+		 * that matches exactly the target range, in which case no
+		 * extent state allocations are needed. We'll only know this
+		 * after locking the tree.
+		 */
+		prealloc = alloc_extent_state(GFP_NOFS);
+		if (!prealloc && !first_iteration)
+			return -ENOMEM;
+	}
+
+	spin_lock(&tree->lock);
+	if (cached_state && *cached_state) {
+		state = *cached_state;
+		if (state->start <= start && state->end > start &&
+		    extent_state_in_tree(state))
+			goto hit_next;
+	}
+
+	/*
+	 * This search will find all the extents that end after our range
+	 * starts.
+	 */
+	state = tree_search_for_insert(tree, start, &p, &parent);
+	if (!state) {
+		prealloc = alloc_extent_state_atomic(prealloc);
+		if (!prealloc) {
+			err = -ENOMEM;
+			goto out;
+		}
+		prealloc->start = start;
+		prealloc->end = end;
+		insert_state_fast(tree, prealloc, p, parent, bits, NULL);
+		cache_state(prealloc, cached_state);
+		prealloc = NULL;
+		goto out;
+	}
+hit_next:
+	last_start = state->start;
+	last_end = state->end;
+
+	/*
+	 * | ---- desired range ---- |
+	 * | state |
+	 *
+	 * Just lock what we found and keep going.
+	 */
+	if (state->start == start && state->end <= end) {
+		set_state_bits(tree, state, bits, NULL);
+		cache_state(state, cached_state);
+		state = clear_state_bit(tree, state, clear_bits, 0, NULL);
+		if (last_end == (u64)-1)
+			goto out;
+		start = last_end + 1;
+		if (start < end && state && state->start == start &&
+		    !need_resched())
+			goto hit_next;
+		goto search_again;
+	}
+
+	/*
+	 *     | ---- desired range ---- |
+	 * | state |
+	 *   or
+	 * | ------------- state -------------- |
+	 *
+	 * We need to split the extent we found, and may flip bits on second
+	 * half.
+	 *
+	 * If the extent we found extends past our range, we just split and
+	 * search again.  It'll get split again the next time though.
+	 *
+	 * If the extent we found is inside our range, we set the desired bit
+	 * on it.
+	 */
+	if (state->start < start) {
+		prealloc = alloc_extent_state_atomic(prealloc);
+		if (!prealloc) {
+			err = -ENOMEM;
+			goto out;
+		}
+		err = split_state(tree, state, prealloc, start);
+		if (err)
+			extent_io_tree_panic(tree, err);
+		prealloc = NULL;
+		if (err)
+			goto out;
+		if (state->end <= end) {
+			set_state_bits(tree, state, bits, NULL);
+			cache_state(state, cached_state);
+			state = clear_state_bit(tree, state, clear_bits, 0, NULL);
+			if (last_end == (u64)-1)
+				goto out;
+			start = last_end + 1;
+			if (start < end && state && state->start == start &&
+			    !need_resched())
+				goto hit_next;
+		}
+		goto search_again;
+	}
+	/*
+	 * | ---- desired range ---- |
+	 *     | state | or               | state |
+	 *
+	 * There's a hole, we need to insert something in it and ignore the
+	 * extent we found.
+	 */
+	if (state->start > start) {
+		u64 this_end;
+		if (end < last_start)
+			this_end = end;
+		else
+			this_end = last_start - 1;
+
+		prealloc = alloc_extent_state_atomic(prealloc);
+		if (!prealloc) {
+			err = -ENOMEM;
+			goto out;
+		}
+
+		/*
+		 * Avoid to free 'prealloc' if it can be merged with the later
+		 * extent.
+		 */
+		prealloc->start = start;
+		prealloc->end = this_end;
+		err = insert_state(tree, prealloc, bits, NULL);
+		if (err)
+			extent_io_tree_panic(tree, err);
+		cache_state(prealloc, cached_state);
+		prealloc = NULL;
+		start = this_end + 1;
+		goto search_again;
+	}
+	/*
+	 * | ---- desired range ---- |
+	 *                        | state |
+	 *
+	 * We need to split the extent, and set the bit on the first half.
+	 */
+	if (state->start <= end && state->end > end) {
+		prealloc = alloc_extent_state_atomic(prealloc);
+		if (!prealloc) {
+			err = -ENOMEM;
+			goto out;
+		}
+
+		err = split_state(tree, state, prealloc, end + 1);
+		if (err)
+			extent_io_tree_panic(tree, err);
+
+		set_state_bits(tree, prealloc, bits, NULL);
+		cache_state(prealloc, cached_state);
+		clear_state_bit(tree, prealloc, clear_bits, 0, NULL);
+		prealloc = NULL;
+		goto out;
+	}
+
+search_again:
+	if (start > end)
+		goto out;
+	spin_unlock(&tree->lock);
+	cond_resched();
+	first_iteration = false;
+	goto again;
+
+out:
+	spin_unlock(&tree->lock);
+	if (prealloc)
+		free_extent_state(prealloc);
+
+	return err;
+}
+
+/*
+ * Find the first range that has @bits not set. This range could start before
+ * @start.
+ *
+ * @tree:      the tree to search
+ * @start:     offset at/after which the found extent should start
+ * @start_ret: records the beginning of the range
+ * @end_ret:   records the end of the range (inclusive)
+ * @bits:      the set of bits which must be unset
+ *
+ * Since unallocated range is also considered one which doesn't have the bits
+ * set it's possible that @end_ret contains -1, this happens in case the range
+ * spans (last_range_end, end of device]. In this case it's up to the caller to
+ * trim @end_ret to the appropriate size.
+ */
+void find_first_clear_extent_bit(struct extent_io_tree *tree, u64 start,
+				 u64 *start_ret, u64 *end_ret, u32 bits)
+{
+	struct extent_state *state;
+	struct extent_state *prev = NULL, *next = NULL;
+
+	spin_lock(&tree->lock);
+
+	/* Find first extent with bits cleared */
+	while (1) {
+		state = tree_search_prev_next(tree, start, &prev, &next);
+		if (!state && !next && !prev) {
+			/*
+			 * Tree is completely empty, send full range and let
+			 * caller deal with it
+			 */
+			*start_ret = 0;
+			*end_ret = -1;
+			goto out;
+		} else if (!state && !next) {
+			/*
+			 * We are past the last allocated chunk, set start at
+			 * the end of the last extent.
+			 */
+			*start_ret = prev->end + 1;
+			*end_ret = -1;
+			goto out;
+		} else if (!state) {
+			state = next;
+		}
+
+		/*
+		 * At this point 'state' either contains 'start' or start is
+		 * before 'state'
+		 */
+		if (in_range(start, state->start, state->end - state->start + 1)) {
+			if (state->state & bits) {
+				/*
+				 * |--range with bits sets--|
+				 *    |
+				 *    start
+				 */
+				start = state->end + 1;
+			} else {
+				/*
+				 * 'start' falls within a range that doesn't
+				 * have the bits set, so take its start as the
+				 * beginning of the desired range
+				 *
+				 * |--range with bits cleared----|
+				 *      |
+				 *      start
+				 */
+				*start_ret = state->start;
+				break;
+			}
+		} else {
+			/*
+			 * |---prev range---|---hole/unset---|---node range---|
+			 *                          |
+			 *                        start
+			 *
+			 *                        or
+			 *
+			 * |---hole/unset--||--first node--|
+			 * 0   |
+			 *    start
+			 */
+			if (prev)
+				*start_ret = prev->end + 1;
+			else
+				*start_ret = 0;
+			break;
+		}
+	}
+
+	/*
+	 * Find the longest stretch from start until an entry which has the
+	 * bits set
+	 */
+	while (state) {
+		if (state->end >= start && !(state->state & bits)) {
+			*end_ret = state->end;
+		} else {
+			*end_ret = state->start - 1;
+			break;
+		}
+		state = next_state(state);
+	}
+out:
+	spin_unlock(&tree->lock);
+}
+
+/*
+ * Count the number of bytes in the tree that have a given bit(s) set.  This
+ * can be fairly slow, except for EXTENT_DIRTY which is cached.  The total
+ * number found is returned.
+ */
+u64 count_range_bits(struct extent_io_tree *tree,
+		     u64 *start, u64 search_end, u64 max_bytes,
+		     u32 bits, int contig)
+{
+	struct extent_state *state;
+	u64 cur_start = *start;
+	u64 total_bytes = 0;
+	u64 last = 0;
+	int found = 0;
+
+	if (WARN_ON(search_end <= cur_start))
+		return 0;
+
+	spin_lock(&tree->lock);
+
+	/*
+	 * This search will find all the extents that end after our range
+	 * starts.
+	 */
+	state = tree_search(tree, cur_start);
+	while (state) {
+		if (state->start > search_end)
+			break;
+		if (contig && found && state->start > last + 1)
+			break;
+		if (state->end >= cur_start && (state->state & bits) == bits) {
+			total_bytes += min(search_end, state->end) + 1 -
+				       max(cur_start, state->start);
+			if (total_bytes >= max_bytes)
+				break;
+			if (!found) {
+				*start = max(cur_start, state->start);
+				found = 1;
+			}
+			last = state->end;
+		} else if (contig && found) {
+			break;
+		}
+		state = next_state(state);
+	}
+	spin_unlock(&tree->lock);
+	return total_bytes;
+}
+
+/*
+ * Searche a range in the state tree for a given mask.  If 'filled' == 1, this
+ * returns 1 only if every extent in the tree has the bits set.  Otherwise, 1
+ * is returned if any bit in the range is found set.
+ */
+int test_range_bit(struct extent_io_tree *tree, u64 start, u64 end,
+		   u32 bits, int filled, struct extent_state *cached)
+{
+	struct extent_state *state = NULL;
+	int bitset = 0;
+
+	spin_lock(&tree->lock);
+	if (cached && extent_state_in_tree(cached) && cached->start <= start &&
+	    cached->end > start)
+		state = cached;
+	else
+		state = tree_search(tree, start);
+	while (state && start <= end) {
+		if (filled && state->start > start) {
+			bitset = 0;
+			break;
+		}
+
+		if (state->start > end)
+			break;
+
+		if (state->state & bits) {
+			bitset = 1;
+			if (!filled)
+				break;
+		} else if (filled) {
+			bitset = 0;
+			break;
+		}
+
+		if (state->end == (u64)-1)
+			break;
+
+		start = state->end + 1;
+		if (start > end)
+			break;
+		state = next_state(state);
+	}
+
+	/* We ran out of states and were still inside of our range. */
+	if (filled && !state)
+		bitset = 0;
+	spin_unlock(&tree->lock);
+	return bitset;
+}
+
+/* Wrappers around set/clear extent bit */
+int set_record_extent_bits(struct extent_io_tree *tree, u64 start, u64 end,
+			   u32 bits, struct extent_changeset *changeset)
+{
+	/*
+	 * We don't support EXTENT_LOCKED yet, as current changeset will
+	 * record any bits changed, so for EXTENT_LOCKED case, it will
+	 * either fail with -EEXIST or changeset will record the whole
+	 * range.
+	 */
+	ASSERT(!(bits & EXTENT_LOCKED));
+
+	return __set_extent_bit(tree, start, end, bits, NULL, NULL, NULL,
+				changeset, GFP_NOFS);
+}
+
+int clear_record_extent_bits(struct extent_io_tree *tree, u64 start, u64 end,
+			     u32 bits, struct extent_changeset *changeset)
+{
+	/*
+	 * Don't support EXTENT_LOCKED case, same reason as
+	 * set_record_extent_bits().
+	 */
+	ASSERT(!(bits & EXTENT_LOCKED));
+
+	return __clear_extent_bit(tree, start, end, bits, NULL, GFP_NOFS,
+				  changeset);
+}
+
+int try_lock_extent(struct extent_io_tree *tree, u64 start, u64 end,
+		    struct extent_state **cached)
+{
+	int err;
+	u64 failed_start;
+
+	err = __set_extent_bit(tree, start, end, EXTENT_LOCKED, &failed_start,
+			       NULL, cached, NULL, GFP_NOFS);
+	if (err == -EEXIST) {
+		if (failed_start > start)
+			clear_extent_bit(tree, start, failed_start - 1,
+					 EXTENT_LOCKED, cached);
+		return 0;
+	}
+	return 1;
+}
+
+/*
+ * Either insert or lock state struct between start and end use mask to tell
+ * us if waiting is desired.
+ */
+int lock_extent(struct extent_io_tree *tree, u64 start, u64 end,
+		struct extent_state **cached_state)
+{
+	struct extent_state *failed_state = NULL;
+	int err;
+	u64 failed_start;
+
+	err = __set_extent_bit(tree, start, end, EXTENT_LOCKED, &failed_start,
+			       &failed_state, cached_state, NULL, GFP_NOFS);
+	while (err == -EEXIST) {
+		if (failed_start != start)
+			clear_extent_bit(tree, start, failed_start - 1,
+					 EXTENT_LOCKED, cached_state);
+
+		wait_extent_bit(tree, failed_start, end, EXTENT_LOCKED,
+				&failed_state);
+		err = __set_extent_bit(tree, start, end, EXTENT_LOCKED,
+				       &failed_start, &failed_state,
+				       cached_state, NULL, GFP_NOFS);
+	}
+	return err;
+}
+
+void __cold extent_state_free_cachep(void)
+{
+	btrfs_extent_state_leak_debug_check();
+	kmem_cache_destroy(extent_state_cache);
+}
+
+/*
+ * MODIFIED:
+ *  - This gets called by extent_io_tree_init, so only init if the cache isn't
+ *    NULL.
+ */
+int __init extent_state_init_cachep(void)
+{
+	if (extent_state_cache)
+		return 0;
+
+	extent_state_cache = kmem_cache_create("btrfs_extent_state",
+			sizeof(struct extent_state), 0,
+			SLAB_MEM_SPREAD, NULL);
+	if (!extent_state_cache)
+		return -ENOMEM;
+
+	return 0;
+}
diff --git a/kernel-shared/extent-io-tree.h b/kernel-shared/extent-io-tree.h
new file mode 100644
index 00000000..cdee8c08
--- /dev/null
+++ b/kernel-shared/extent-io-tree.h
@@ -0,0 +1,239 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef BTRFS_EXTENT_IO_TREE_H
+#define BTRFS_EXTENT_IO_TREE_H
+
+#include "misc.h"
+
+struct extent_changeset;
+struct io_failure_record;
+
+/* Bits for the extent state */
+enum {
+	ENUM_BIT(EXTENT_DIRTY),
+	ENUM_BIT(EXTENT_UPTODATE),
+	ENUM_BIT(EXTENT_LOCKED),
+	ENUM_BIT(EXTENT_NEW),
+	ENUM_BIT(EXTENT_DELALLOC),
+	ENUM_BIT(EXTENT_DEFRAG),
+	ENUM_BIT(EXTENT_BOUNDARY),
+	ENUM_BIT(EXTENT_NODATASUM),
+	ENUM_BIT(EXTENT_CLEAR_META_RESV),
+	ENUM_BIT(EXTENT_NEED_WAIT),
+	ENUM_BIT(EXTENT_NORESERVE),
+	ENUM_BIT(EXTENT_QGROUP_RESERVED),
+	ENUM_BIT(EXTENT_CLEAR_DATA_RESV),
+	/*
+	 * Must be cleared only during ordered extent completion or on error
+	 * paths if we did not manage to submit bios and create the ordered
+	 * extents for the range.  Should not be cleared during page release
+	 * and page invalidation (if there is an ordered extent in flight),
+	 * that is left for the ordered extent completion.
+	 */
+	ENUM_BIT(EXTENT_DELALLOC_NEW),
+	/*
+	 * When an ordered extent successfully completes for a region marked as
+	 * a new delalloc range, use this flag when clearing a new delalloc
+	 * range to indicate that the VFS' inode number of bytes should be
+	 * incremented and the inode's new delalloc bytes decremented, in an
+	 * atomic way to prevent races with stat(2).
+	 */
+	ENUM_BIT(EXTENT_ADD_INODE_BYTES),
+	/*
+	 * Set during truncate when we're clearing an entire range and we just
+	 * want the extent states to go away.
+	 */
+	ENUM_BIT(EXTENT_CLEAR_ALL_BITS),
+};
+
+#define EXTENT_DO_ACCOUNTING    (EXTENT_CLEAR_META_RESV | \
+				 EXTENT_CLEAR_DATA_RESV)
+#define EXTENT_CTLBITS		(EXTENT_DO_ACCOUNTING | \
+				 EXTENT_ADD_INODE_BYTES | \
+				 EXTENT_CLEAR_ALL_BITS)
+
+/*
+ * Redefined bits above which are used only in the device allocation tree,
+ * shouldn't be using EXTENT_LOCKED / EXTENT_BOUNDARY / EXTENT_CLEAR_META_RESV
+ * / EXTENT_CLEAR_DATA_RESV because they have special meaning to the bit
+ * manipulation functions
+ */
+#define CHUNK_ALLOCATED				EXTENT_DIRTY
+#define CHUNK_TRIMMED				EXTENT_DEFRAG
+#define CHUNK_STATE_MASK			(CHUNK_ALLOCATED |		\
+						 CHUNK_TRIMMED)
+
+enum {
+	IO_TREE_FS_PINNED_EXTENTS,
+	IO_TREE_FS_EXCLUDED_EXTENTS,
+	IO_TREE_BTREE_INODE_IO,
+	IO_TREE_INODE_IO,
+	IO_TREE_RELOC_BLOCKS,
+	IO_TREE_TRANS_DIRTY_PAGES,
+	IO_TREE_ROOT_DIRTY_LOG_PAGES,
+	IO_TREE_INODE_FILE_EXTENT,
+	IO_TREE_LOG_CSUM_RANGE,
+	IO_TREE_SELFTEST,
+	IO_TREE_DEVICE_ALLOC_STATE,
+};
+
+struct extent_io_tree {
+	struct rb_root state;
+	struct btrfs_fs_info *fs_info;
+	/* Inode associated with this tree, or NULL. */
+	struct btrfs_inode *inode;
+
+	/* Who owns this io tree, should be one of IO_TREE_* */
+	u8 owner;
+
+	spinlock_t lock;
+};
+
+struct extent_state {
+	u64 start;
+	u64 end; /* inclusive */
+	struct rb_node rb_node;
+
+	/* ADD NEW ELEMENTS AFTER THIS */
+	wait_queue_head_t wq;
+	refcount_t refs;
+	u32 state;
+
+#ifdef CONFIG_BTRFS_DEBUG
+	struct list_head leak_list;
+#endif
+};
+
+void extent_io_tree_init(struct btrfs_fs_info *fs_info,
+			 struct extent_io_tree *tree, unsigned int owner);
+void extent_io_tree_release(struct extent_io_tree *tree);
+
+int lock_extent(struct extent_io_tree *tree, u64 start, u64 end,
+		struct extent_state **cached);
+
+int try_lock_extent(struct extent_io_tree *tree, u64 start, u64 end,
+		    struct extent_state **cached);
+
+int __init extent_state_init_cachep(void);
+void __cold extent_state_free_cachep(void);
+
+u64 count_range_bits(struct extent_io_tree *tree,
+		     u64 *start, u64 search_end,
+		     u64 max_bytes, u32 bits, int contig);
+
+void free_extent_state(struct extent_state *state);
+int test_range_bit(struct extent_io_tree *tree, u64 start, u64 end,
+		   u32 bits, int filled, struct extent_state *cached_state);
+int clear_record_extent_bits(struct extent_io_tree *tree, u64 start, u64 end,
+			     u32 bits, struct extent_changeset *changeset);
+int __clear_extent_bit(struct extent_io_tree *tree, u64 start, u64 end,
+		       u32 bits, struct extent_state **cached, gfp_t mask,
+		       struct extent_changeset *changeset);
+
+static inline int clear_extent_bit(struct extent_io_tree *tree, u64 start,
+				   u64 end, u32 bits,
+				   struct extent_state **cached)
+{
+	return __clear_extent_bit(tree, start, end, bits, cached,
+				  GFP_NOFS, NULL);
+}
+
+static inline int unlock_extent(struct extent_io_tree *tree, u64 start, u64 end,
+				struct extent_state **cached)
+{
+	return __clear_extent_bit(tree, start, end, EXTENT_LOCKED, cached,
+				  GFP_NOFS, NULL);
+}
+
+static inline int clear_extent_bits(struct extent_io_tree *tree, u64 start,
+				    u64 end, u32 bits)
+{
+	return clear_extent_bit(tree, start, end, bits, NULL);
+}
+
+int set_record_extent_bits(struct extent_io_tree *tree, u64 start, u64 end,
+			   u32 bits, struct extent_changeset *changeset);
+int set_extent_bit(struct extent_io_tree *tree, u64 start, u64 end,
+		   u32 bits, struct extent_state **cached_state, gfp_t mask);
+
+static inline int set_extent_bits_nowait(struct extent_io_tree *tree, u64 start,
+					 u64 end, u32 bits)
+{
+	return set_extent_bit(tree, start, end, bits, NULL, GFP_NOWAIT);
+}
+
+static inline int set_extent_bits(struct extent_io_tree *tree, u64 start,
+		u64 end, u32 bits)
+{
+	return set_extent_bit(tree, start, end, bits, NULL, GFP_NOFS);
+}
+
+static inline int clear_extent_uptodate(struct extent_io_tree *tree, u64 start,
+		u64 end, struct extent_state **cached_state)
+{
+	return __clear_extent_bit(tree, start, end, EXTENT_UPTODATE,
+				  cached_state, GFP_NOFS, NULL);
+}
+
+static inline int set_extent_dirty(struct extent_io_tree *tree, u64 start,
+		u64 end, gfp_t mask)
+{
+	return set_extent_bit(tree, start, end, EXTENT_DIRTY, NULL, mask);
+}
+
+static inline int clear_extent_dirty(struct extent_io_tree *tree, u64 start,
+				     u64 end, struct extent_state **cached)
+{
+	return clear_extent_bit(tree, start, end,
+				EXTENT_DIRTY | EXTENT_DELALLOC |
+				EXTENT_DO_ACCOUNTING, cached);
+}
+
+int convert_extent_bit(struct extent_io_tree *tree, u64 start, u64 end,
+		       u32 bits, u32 clear_bits,
+		       struct extent_state **cached_state);
+
+static inline int set_extent_delalloc(struct extent_io_tree *tree, u64 start,
+				      u64 end, u32 extra_bits,
+				      struct extent_state **cached_state)
+{
+	return set_extent_bit(tree, start, end,
+			      EXTENT_DELALLOC | extra_bits,
+			      cached_state, GFP_NOFS);
+}
+
+static inline int set_extent_defrag(struct extent_io_tree *tree, u64 start,
+		u64 end, struct extent_state **cached_state)
+{
+	return set_extent_bit(tree, start, end,
+			      EXTENT_DELALLOC | EXTENT_DEFRAG,
+			      cached_state, GFP_NOFS);
+}
+
+static inline int set_extent_new(struct extent_io_tree *tree, u64 start,
+		u64 end)
+{
+	return set_extent_bit(tree, start, end, EXTENT_NEW, NULL, GFP_NOFS);
+}
+
+static inline int set_extent_uptodate(struct extent_io_tree *tree, u64 start,
+		u64 end, struct extent_state **cached_state, gfp_t mask)
+{
+	return set_extent_bit(tree, start, end, EXTENT_UPTODATE,
+			      cached_state, mask);
+}
+
+int find_first_extent_bit(struct extent_io_tree *tree, u64 start,
+			  u64 *start_ret, u64 *end_ret, u32 bits,
+			  struct extent_state **cached_state);
+void find_first_clear_extent_bit(struct extent_io_tree *tree, u64 start,
+				 u64 *start_ret, u64 *end_ret, u32 bits);
+int find_contiguous_extent_bit(struct extent_io_tree *tree, u64 start,
+			       u64 *start_ret, u64 *end_ret, u32 bits);
+bool btrfs_find_delalloc_range(struct extent_io_tree *tree, u64 *start,
+			       u64 *end, u64 max_bytes,
+			       struct extent_state **cached_state);
+void wait_extent_bit(struct extent_io_tree *tree, u64 start, u64 end, u32 bits,
+		     struct extent_state **cached_state);
+
+#endif /* BTRFS_EXTENT_IO_TREE_H */
diff --git a/kernel-shared/extent-tree.c b/kernel-shared/extent-tree.c
index 5613012c..2a71b97a 100644
--- a/kernel-shared/extent-tree.c
+++ b/kernel-shared/extent-tree.c
@@ -34,6 +34,7 @@
 #include "kernel-shared/zoned.h"
 #include "common/utils.h"
 #include "file-item.h"
+#include "extent-io-tree.h"
 
 #define PENDING_EXTENT_INSERT 0
 #define PENDING_EXTENT_DELETE 1
@@ -74,7 +75,7 @@ static int remove_sb_from_cache(struct btrfs_root *root,
 		BUG_ON(ret);
 		while (nr--) {
 			clear_extent_dirty(free_space_cache, logical[nr],
-				logical[nr] + stripe_len - 1);
+				logical[nr] + stripe_len - 1, NULL);
 		}
 		kfree(logical);
 	}
@@ -142,7 +143,7 @@ static int cache_block_group(struct btrfs_root *root,
 			if (key.objectid > last) {
 				hole_size = key.objectid - last;
 				set_extent_dirty(free_space_cache, last,
-						 last + hole_size - 1);
+						 last + hole_size - 1, GFP_NOFS);
 			}
 			if (key.type == BTRFS_METADATA_ITEM_KEY)
 				last = key.objectid + root->fs_info->nodesize;
@@ -155,7 +156,8 @@ next:
 
 	if (block_group->start + block_group->length > last) {
 		hole_size = block_group->start + block_group->length - last;
-		set_extent_dirty(free_space_cache, last, last + hole_size - 1);
+		set_extent_dirty(free_space_cache, last, last + hole_size - 1,
+				 GFP_NOFS);
 	}
 	remove_sb_from_cache(root, block_group);
 	block_group->cached = 1;
@@ -295,7 +297,8 @@ again:
 
 	while(1) {
 		ret = find_first_extent_bit(&root->fs_info->free_space_cache,
-					    last, &start, &end, EXTENT_DIRTY);
+					    last, &start, &end, EXTENT_DIRTY,
+					    NULL);
 		if (ret) {
 			goto new_group;
 		}
@@ -1803,7 +1806,8 @@ static int update_block_group(struct btrfs_trans_handle *trans, u64 bytenr,
 			cache->space_info->bytes_used -= num_bytes;
 			if (mark_free) {
 				set_extent_dirty(&info->free_space_cache,
-						bytenr, bytenr + num_bytes - 1);
+						bytenr, bytenr + num_bytes - 1,
+						GFP_NOFS);
 			}
 		}
 		cache->used = old_val;
@@ -1821,10 +1825,10 @@ static int update_pinned_extents(struct btrfs_fs_info *fs_info,
 
 	if (pin) {
 		set_extent_dirty(&fs_info->pinned_extents,
-				bytenr, bytenr + num - 1);
+				bytenr, bytenr + num - 1, GFP_NOFS);
 	} else {
 		clear_extent_dirty(&fs_info->pinned_extents,
-				bytenr, bytenr + num - 1);
+				bytenr, bytenr + num - 1, NULL);
 	}
 	while (num > 0) {
 		cache = btrfs_lookup_block_group(fs_info, bytenr);
@@ -1861,13 +1865,13 @@ void btrfs_finish_extent_commit(struct btrfs_trans_handle *trans)
 
 	while(1) {
 		ret = find_first_extent_bit(pinned_extents, 0, &start, &end,
-					    EXTENT_DIRTY);
+					    EXTENT_DIRTY, NULL);
 		if (ret)
 			break;
 		update_pinned_extents(trans->fs_info, start, end + 1 - start,
 				      0);
-		clear_extent_dirty(pinned_extents, start, end);
-		set_extent_dirty(free_space_cache, start, end);
+		clear_extent_dirty(pinned_extents, start, end, NULL);
+		set_extent_dirty(free_space_cache, start, end, GFP_NOFS);
 	}
 }
 
@@ -2254,20 +2258,23 @@ check_failed:
 	}
 
 	if (test_range_bit(&info->extent_ins, ins->objectid,
-			   ins->objectid + num_bytes -1, EXTENT_LOCKED, 0)) {
+			   ins->objectid + num_bytes -1, EXTENT_LOCKED, 0,
+			   NULL)) {
 		search_start = ins->objectid + num_bytes;
 		goto new_group;
 	}
 
 	if (test_range_bit(&info->pinned_extents, ins->objectid,
-			   ins->objectid + num_bytes -1, EXTENT_DIRTY, 0)) {
+			   ins->objectid + num_bytes -1, EXTENT_DIRTY, 0,
+			   NULL)) {
 		search_start = ins->objectid + num_bytes;
 		goto new_group;
 	}
 
 	if (info->excluded_extents &&
 	    test_range_bit(info->excluded_extents, ins->objectid,
-			   ins->objectid + num_bytes -1, EXTENT_DIRTY, 0)) {
+			   ins->objectid + num_bytes -1, EXTENT_DIRTY, 0,
+			   NULL)) {
 		search_start = ins->objectid + num_bytes;
 		goto new_group;
 	}
@@ -2377,7 +2384,8 @@ int btrfs_reserve_extent(struct btrfs_trans_handle *trans,
 	if (ret < 0)
 		return ret;
 	clear_extent_dirty(&info->free_space_cache,
-			   ins->objectid, ins->objectid + ins->offset - 1);
+			   ins->objectid, ins->objectid + ins->offset - 1,
+			   NULL);
 	return ret;
 }
 
@@ -2418,7 +2426,7 @@ static int alloc_reserved_tree_block(struct btrfs_trans_handle *trans,
 	if (ref->root == BTRFS_EXTENT_TREE_OBJECTID) {
 		ret = find_first_extent_bit(&trans->fs_info->extent_ins,
 					    node->bytenr, &start, &end,
-					    EXTENT_LOCKED);
+					    EXTENT_LOCKED, NULL);
 		ASSERT(!ret);
 		ASSERT(start == node->bytenr);
 		ASSERT(end == node->bytenr + node->num_bytes - 1);
@@ -2600,10 +2608,10 @@ int btrfs_free_block_groups(struct btrfs_fs_info *info)
 
 	while(1) {
 		ret = find_first_extent_bit(&info->free_space_cache, 0,
-					    &start, &end, EXTENT_DIRTY);
+					    &start, &end, EXTENT_DIRTY, NULL);
 		if (ret)
 			break;
-		clear_extent_dirty(&info->free_space_cache, start, end);
+		clear_extent_dirty(&info->free_space_cache, start, end, NULL);
 	}
 
 	while (!list_empty(&info->space_info)) {
@@ -3838,7 +3846,8 @@ u64 add_new_free_space(struct btrfs_block_group *block_group,
 	while (start < end) {
 		ret = find_first_extent_bit(&info->pinned_extents, start,
 					    &extent_start, &extent_end,
-					    EXTENT_DIRTY | EXTENT_UPTODATE);
+					    EXTENT_DIRTY | EXTENT_UPTODATE,
+					    NULL);
 		if (ret)
 			break;
 
diff --git a/kernel-shared/extent_io.c b/kernel-shared/extent_io.c
index ab80700a..46c0fb3f 100644
--- a/kernel-shared/extent_io.c
+++ b/kernel-shared/extent_io.c
@@ -70,174 +70,6 @@ void extent_buffer_free_cache(struct btrfs_fs_info *fs_info)
 	fs_info->cache_size = 0;
 }
 
-void extent_io_tree_init(struct extent_io_tree *tree)
-{
-	cache_tree_init(&tree->state);
-	cache_tree_init(&tree->cache);
-	INIT_LIST_HEAD(&tree->lru);
-}
-
-static struct extent_state *alloc_extent_state(void)
-{
-	struct extent_state *state;
-
-	state = malloc(sizeof(*state));
-	if (!state)
-		return NULL;
-	state->cache_node.objectid = 0;
-	state->refs = 1;
-	state->state = 0;
-	state->xprivate = 0;
-	return state;
-}
-
-static void btrfs_free_extent_state(struct extent_state *state)
-{
-	state->refs--;
-	BUG_ON(state->refs < 0);
-	if (state->refs == 0)
-		free(state);
-}
-
-static void free_extent_state_func(struct cache_extent *cache)
-{
-	struct extent_state *es;
-
-	es = container_of(cache, struct extent_state, cache_node);
-	btrfs_free_extent_state(es);
-}
-
-void extent_io_tree_cleanup(struct extent_io_tree *tree)
-{
-	struct extent_buffer *eb;
-
-	while(!list_empty(&tree->lru)) {
-		eb = list_entry(tree->lru.next, struct extent_buffer, lru);
-		if (eb->refs) {
-			/*
-			 * Reset extent buffer refs to 1, so the
-			 * free_extent_buffer_nocache() can free it for sure.
-			 */
-			eb->refs = 1;
-			fprintf(stderr,
-				"extent buffer leak: start %llu len %u\n",
-				(unsigned long long)eb->start, eb->len);
-			free_extent_buffer_nocache(eb);
-		} else {
-			free_extent_buffer_final(eb);
-		}
-	}
-
-	cache_tree_free_extents(&tree->state, free_extent_state_func);
-}
-
-static inline void update_extent_state(struct extent_state *state)
-{
-	state->cache_node.start = state->start;
-	state->cache_node.size = state->end + 1 - state->start;
-}
-
-/*
- * Utility function to look for merge candidates inside a given range.
- * Any extents with matching state are merged together into a single
- * extent in the tree. Extents with EXTENT_IO in their state field are
- * not merged
- */
-static int merge_state(struct extent_io_tree *tree,
-		       struct extent_state *state)
-{
-	struct extent_state *other;
-	struct cache_extent *other_node;
-
-	if (state->state & EXTENT_IOBITS)
-		return 0;
-
-	other_node = prev_cache_extent(&state->cache_node);
-	if (other_node) {
-		other = container_of(other_node, struct extent_state,
-				     cache_node);
-		if (other->end == state->start - 1 &&
-		    other->state == state->state) {
-			state->start = other->start;
-			update_extent_state(state);
-			remove_cache_extent(&tree->state, &other->cache_node);
-			btrfs_free_extent_state(other);
-		}
-	}
-	other_node = next_cache_extent(&state->cache_node);
-	if (other_node) {
-		other = container_of(other_node, struct extent_state,
-				     cache_node);
-		if (other->start == state->end + 1 &&
-		    other->state == state->state) {
-			other->start = state->start;
-			update_extent_state(other);
-			remove_cache_extent(&tree->state, &state->cache_node);
-			btrfs_free_extent_state(state);
-		}
-	}
-	return 0;
-}
-
-/*
- * insert an extent_state struct into the tree.  'bits' are set on the
- * struct before it is inserted.
- */
-static int insert_state(struct extent_io_tree *tree,
-			struct extent_state *state, u64 start, u64 end,
-			int bits)
-{
-	int ret;
-
-	BUG_ON(end < start);
-	state->state |= bits;
-	state->start = start;
-	state->end = end;
-	update_extent_state(state);
-	ret = insert_cache_extent(&tree->state, &state->cache_node);
-	BUG_ON(ret);
-	merge_state(tree, state);
-	return 0;
-}
-
-/*
- * split a given extent state struct in two, inserting the preallocated
- * struct 'prealloc' as the newly created second half.  'split' indicates an
- * offset inside 'orig' where it should be split.
- */
-static int split_state(struct extent_io_tree *tree, struct extent_state *orig,
-		       struct extent_state *prealloc, u64 split)
-{
-	int ret;
-	prealloc->start = orig->start;
-	prealloc->end = split - 1;
-	prealloc->state = orig->state;
-	update_extent_state(prealloc);
-	orig->start = split;
-	update_extent_state(orig);
-	ret = insert_cache_extent(&tree->state, &prealloc->cache_node);
-	BUG_ON(ret);
-	return 0;
-}
-
-/*
- * clear some bits on a range in the tree.
- */
-static int clear_state_bit(struct extent_io_tree *tree,
-			    struct extent_state *state, int bits)
-{
-	int ret = state->state & bits;
-
-	state->state &= ~bits;
-	if (state->state == 0) {
-		remove_cache_extent(&tree->state, &state->cache_node);
-		btrfs_free_extent_state(state);
-	} else {
-		merge_state(tree, state);
-	}
-	return ret;
-}
-
 /*
  * extent_buffer_bitmap_set - set an area of a bitmap
  * @eb: the extent buffer
@@ -294,305 +126,6 @@ void extent_buffer_bitmap_clear(struct extent_buffer *eb, unsigned long start,
 	}
 }
 
-/*
- * clear some bits on a range in the tree.
- */
-int clear_extent_bits(struct extent_io_tree *tree, u64 start, u64 end, int bits)
-{
-	struct extent_state *state;
-	struct extent_state *prealloc = NULL;
-	struct cache_extent *node;
-	u64 last_end;
-	int err;
-	int set = 0;
-
-again:
-	if (!prealloc) {
-		prealloc = alloc_extent_state();
-		if (!prealloc)
-			return -ENOMEM;
-	}
-
-	/*
-	 * this search will find the extents that end after
-	 * our range starts
-	 */
-	node = search_cache_extent(&tree->state, start);
-	if (!node)
-		goto out;
-	state = container_of(node, struct extent_state, cache_node);
-	if (state->start > end)
-		goto out;
-	last_end = state->end;
-
-	/*
-	 *     | ---- desired range ---- |
-	 *  | state | or
-	 *  | ------------- state -------------- |
-	 *
-	 * We need to split the extent we found, and may flip
-	 * bits on second half.
-	 *
-	 * If the extent we found extends past our range, we
-	 * just split and search again.  It'll get split again
-	 * the next time though.
-	 *
-	 * If the extent we found is inside our range, we clear
-	 * the desired bit on it.
-	 */
-	if (state->start < start) {
-		err = split_state(tree, state, prealloc, start);
-		BUG_ON(err == -EEXIST);
-		prealloc = NULL;
-		if (err)
-			goto out;
-		if (state->end <= end) {
-			set |= clear_state_bit(tree, state, bits);
-			if (last_end == (u64)-1)
-				goto out;
-			start = last_end + 1;
-		} else {
-			start = state->start;
-		}
-		goto search_again;
-	}
-	/*
-	 * | ---- desired range ---- |
-	 *                        | state |
-	 * We need to split the extent, and clear the bit
-	 * on the first half
-	 */
-	if (state->start <= end && state->end > end) {
-		err = split_state(tree, state, prealloc, end + 1);
-		BUG_ON(err == -EEXIST);
-
-		set |= clear_state_bit(tree, prealloc, bits);
-		prealloc = NULL;
-		goto out;
-	}
-
-	start = state->end + 1;
-	set |= clear_state_bit(tree, state, bits);
-	if (last_end == (u64)-1)
-		goto out;
-	start = last_end + 1;
-	goto search_again;
-out:
-	if (prealloc)
-		btrfs_free_extent_state(prealloc);
-	return set;
-
-search_again:
-	if (start > end)
-		goto out;
-	goto again;
-}
-
-/*
- * set some bits on a range in the tree.
- */
-int set_extent_bits(struct extent_io_tree *tree, u64 start, u64 end, int bits)
-{
-	struct extent_state *state;
-	struct extent_state *prealloc = NULL;
-	struct cache_extent *node;
-	int err = 0;
-	u64 last_start;
-	u64 last_end;
-again:
-	if (!prealloc) {
-		prealloc = alloc_extent_state();
-		if (!prealloc)
-			return -ENOMEM;
-	}
-
-	/*
-	 * this search will find the extents that end after
-	 * our range starts
-	 */
-	node = search_cache_extent(&tree->state, start);
-	if (!node) {
-		err = insert_state(tree, prealloc, start, end, bits);
-		BUG_ON(err == -EEXIST);
-		prealloc = NULL;
-		goto out;
-	}
-
-	state = container_of(node, struct extent_state, cache_node);
-	last_start = state->start;
-	last_end = state->end;
-
-	/*
-	 * | ---- desired range ---- |
-	 * | state |
-	 *
-	 * Just lock what we found and keep going
-	 */
-	if (state->start == start && state->end <= end) {
-		state->state |= bits;
-		merge_state(tree, state);
-		if (last_end == (u64)-1)
-			goto out;
-		start = last_end + 1;
-		goto search_again;
-	}
-	/*
-	 *     | ---- desired range ---- |
-	 * | state |
-	 *   or
-	 * | ------------- state -------------- |
-	 *
-	 * We need to split the extent we found, and may flip bits on
-	 * second half.
-	 *
-	 * If the extent we found extends past our
-	 * range, we just split and search again.  It'll get split
-	 * again the next time though.
-	 *
-	 * If the extent we found is inside our range, we set the
-	 * desired bit on it.
-	 */
-	if (state->start < start) {
-		err = split_state(tree, state, prealloc, start);
-		BUG_ON(err == -EEXIST);
-		prealloc = NULL;
-		if (err)
-			goto out;
-		if (state->end <= end) {
-			state->state |= bits;
-			start = state->end + 1;
-			merge_state(tree, state);
-			if (last_end == (u64)-1)
-				goto out;
-			start = last_end + 1;
-		} else {
-			start = state->start;
-		}
-		goto search_again;
-	}
-	/*
-	 * | ---- desired range ---- |
-	 *     | state | or               | state |
-	 *
-	 * There's a hole, we need to insert something in it and
-	 * ignore the extent we found.
-	 */
-	if (state->start > start) {
-		u64 this_end;
-		if (end < last_start)
-			this_end = end;
-		else
-			this_end = last_start -1;
-		err = insert_state(tree, prealloc, start, this_end,
-				bits);
-		BUG_ON(err == -EEXIST);
-		prealloc = NULL;
-		if (err)
-			goto out;
-		start = this_end + 1;
-		goto search_again;
-	}
-	/*
-	 * | ---- desired range ---- |
-	 * | ---------- state ---------- |
-	 * We need to split the extent, and set the bit
-	 * on the first half
-	 */
-	err = split_state(tree, state, prealloc, end + 1);
-	BUG_ON(err == -EEXIST);
-
-	state->state |= bits;
-	merge_state(tree, prealloc);
-	prealloc = NULL;
-out:
-	if (prealloc)
-		btrfs_free_extent_state(prealloc);
-	return err;
-search_again:
-	if (start > end)
-		goto out;
-	goto again;
-}
-
-int set_extent_dirty(struct extent_io_tree *tree, u64 start, u64 end)
-{
-	return set_extent_bits(tree, start, end, EXTENT_DIRTY);
-}
-
-int clear_extent_dirty(struct extent_io_tree *tree, u64 start, u64 end)
-{
-	return clear_extent_bits(tree, start, end, EXTENT_DIRTY);
-}
-
-int find_first_extent_bit(struct extent_io_tree *tree, u64 start,
-			  u64 *start_ret, u64 *end_ret, int bits)
-{
-	struct cache_extent *node;
-	struct extent_state *state;
-	int ret = 1;
-
-	/*
-	 * this search will find all the extents that end after
-	 * our range starts.
-	 */
-	node = search_cache_extent(&tree->state, start);
-	if (!node)
-		goto out;
-
-	while(1) {
-		state = container_of(node, struct extent_state, cache_node);
-		if (state->end >= start && (state->state & bits)) {
-			*start_ret = state->start;
-			*end_ret = state->end;
-			ret = 0;
-			break;
-		}
-		node = next_cache_extent(node);
-		if (!node)
-			break;
-	}
-out:
-	return ret;
-}
-
-int test_range_bit(struct extent_io_tree *tree, u64 start, u64 end,
-		   int bits, int filled)
-{
-	struct extent_state *state = NULL;
-	struct cache_extent *node;
-	int bitset = 0;
-
-	node = search_cache_extent(&tree->state, start);
-	while (node && start <= end) {
-		state = container_of(node, struct extent_state, cache_node);
-
-		if (filled && state->start > start) {
-			bitset = 0;
-			break;
-		}
-		if (state->start > end)
-			break;
-		if (state->state & bits) {
-			bitset = 1;
-			if (!filled)
-				break;
-		} else if (filled) {
-			bitset = 0;
-			break;
-		}
-		start = state->end + 1;
-		if (start > end)
-			break;
-		node = next_cache_extent(node);
-		if (!node) {
-			if (filled)
-				bitset = 0;
-			break;
-		}
-	}
-	return bitset;
-}
-
 static struct extent_buffer *__alloc_extent_buffer(struct btrfs_fs_info *info,
 						   u64 bytenr, u32 blocksize)
 {
@@ -1039,7 +572,8 @@ int set_extent_buffer_dirty(struct extent_buffer *eb)
 	struct extent_io_tree *tree = &eb->fs_info->dirty_buffers;
 	if (!(eb->flags & EXTENT_BUFFER_DIRTY)) {
 		eb->flags |= EXTENT_BUFFER_DIRTY;
-		set_extent_dirty(tree, eb->start, eb->start + eb->len - 1);
+		set_extent_dirty(tree, eb->start, eb->start + eb->len - 1,
+				 GFP_NOFS);
 		extent_buffer_get(eb);
 	}
 	return 0;
@@ -1050,7 +584,8 @@ int clear_extent_buffer_dirty(struct extent_buffer *eb)
 	struct extent_io_tree *tree = &eb->fs_info->dirty_buffers;
 	if (eb->flags & EXTENT_BUFFER_DIRTY) {
 		eb->flags &= ~EXTENT_BUFFER_DIRTY;
-		clear_extent_dirty(tree, eb->start, eb->start + eb->len - 1);
+		clear_extent_dirty(tree, eb->start, eb->start + eb->len - 1,
+				   NULL);
 		free_extent_buffer(eb);
 	}
 	return 0;
diff --git a/kernel-shared/extent_io.h b/kernel-shared/extent_io.h
index d824d467..8ba56eed 100644
--- a/kernel-shared/extent_io.h
+++ b/kernel-shared/extent_io.h
@@ -23,17 +23,7 @@
 #include "common/extent-cache.h"
 #include "kernel-lib/list.h"
 
-#define EXTENT_DIRTY		(1U << 0)
-#define EXTENT_WRITEBACK	(1U << 1)
-#define EXTENT_UPTODATE		(1U << 2)
-#define EXTENT_LOCKED		(1U << 3)
-#define EXTENT_NEW		(1U << 4)
-#define EXTENT_DELALLOC		(1U << 5)
-#define EXTENT_DEFRAG		(1U << 6)
-#define EXTENT_DEFRAG_DONE	(1U << 7)
-#define EXTENT_BUFFER_FILLED	(1U << 8)
-#define EXTENT_CSUM		(1U << 9)
-#define EXTENT_IOBITS (EXTENT_LOCKED | EXTENT_WRITEBACK)
+struct extent_io_tree;
 
 #define EXTENT_BUFFER_UPTODATE		(1U << 0)
 #define EXTENT_BUFFER_DIRTY		(1U << 1)
@@ -65,23 +55,6 @@ static inline int le_test_bit(int nr, const u8 *addr)
 
 struct btrfs_fs_info;
 
-struct extent_io_tree {
-	struct cache_tree state;
-	struct cache_tree cache;
-	struct list_head lru;
-	u64 cache_size;
-	u64 max_cache_size;
-};
-
-struct extent_state {
-	struct cache_extent cache_node;
-	u64 start;
-	u64 end;
-	int refs;
-	unsigned long state;
-	u64 xprivate;
-};
-
 struct extent_buffer {
 	struct cache_extent cache_node;
 	u64 start;
@@ -99,16 +72,6 @@ static inline void extent_buffer_get(struct extent_buffer *eb)
 	eb->refs++;
 }
 
-void extent_io_tree_init(struct extent_io_tree *tree);
-void extent_io_tree_cleanup(struct extent_io_tree *tree);
-int set_extent_bits(struct extent_io_tree *tree, u64 start, u64 end, int bits);
-int clear_extent_bits(struct extent_io_tree *tree, u64 start, u64 end, int bits);
-int find_first_extent_bit(struct extent_io_tree *tree, u64 start,
-			  u64 *start_ret, u64 *end_ret, int bits);
-int test_range_bit(struct extent_io_tree *tree, u64 start, u64 end,
-		   int bits, int filled);
-int set_extent_dirty(struct extent_io_tree *tree, u64 start, u64 end);
-int clear_extent_dirty(struct extent_io_tree *tree, u64 start, u64 end);
 static inline int set_extent_buffer_uptodate(struct extent_buffer *eb)
 {
 	eb->flags |= EXTENT_BUFFER_UPTODATE;
diff --git a/kernel-shared/misc.h b/kernel-shared/misc.h
new file mode 100644
index 00000000..99c4951b
--- /dev/null
+++ b/kernel-shared/misc.h
@@ -0,0 +1,143 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef BTRFS_MISC_H
+#define BTRFS_MISC_H
+
+#include "kerncompat.h"
+
+#define in_range(b, first, len) ((b) >= (first) && (b) < (first) + (len))
+
+/*
+ * Enumerate bits using enum autoincrement. Define the @name as the n-th bit.
+ */
+#define ENUM_BIT(name)                                  \
+	__ ## name ## _BIT,                             \
+	name = (1U << __ ## name ## _BIT),              \
+	__ ## name ## _SEQ = __ ## name ## _BIT
+
+static inline void cond_wake_up(struct wait_queue_head *wq)
+{
+	/*
+	 * This implies a full smp_mb barrier, see comments for
+	 * waitqueue_active why.
+	 */
+	if (wq_has_sleeper(wq))
+		wake_up(wq);
+}
+
+static inline void cond_wake_up_nomb(struct wait_queue_head *wq)
+{
+	/*
+	 * Special case for conditional wakeup where the barrier required for
+	 * waitqueue_active is implied by some of the preceding code. Eg. one
+	 * of such atomic operations (atomic_dec_and_return, ...), or a
+	 * unlock/lock sequence, etc.
+	 */
+	if (waitqueue_active(wq))
+		wake_up(wq);
+}
+
+static inline u64 mult_perc(u64 num, u32 percent)
+{
+	return div_u64(num * percent, 100);
+}
+/* Copy of is_power_of_two that is 64bit safe */
+static inline bool is_power_of_two_u64(u64 n)
+{
+	return n != 0 && (n & (n - 1)) == 0;
+}
+
+static inline bool has_single_bit_set(u64 n)
+{
+	return is_power_of_two_u64(n);
+}
+
+/*
+ * Simple bytenr based rb_tree relate structures
+ *
+ * Any structure wants to use bytenr as single search index should have their
+ * structure start with these members.
+ */
+struct rb_simple_node {
+	struct rb_node rb_node;
+	u64 bytenr;
+};
+
+static inline struct rb_node *rb_simple_search(struct rb_root *root, u64 bytenr)
+{
+	struct rb_node *node = root->rb_node;
+	struct rb_simple_node *entry;
+
+	while (node) {
+		entry = rb_entry(node, struct rb_simple_node, rb_node);
+
+		if (bytenr < entry->bytenr)
+			node = node->rb_left;
+		else if (bytenr > entry->bytenr)
+			node = node->rb_right;
+		else
+			return node;
+	}
+	return NULL;
+}
+
+/*
+ * Search @root from an entry that starts or comes after @bytenr.
+ *
+ * @root:	the root to search.
+ * @bytenr:	bytenr to search from.
+ *
+ * Return the rb_node that start at or after @bytenr.  If there is no entry at
+ * or after @bytner return NULL.
+ */
+static inline struct rb_node *rb_simple_search_first(struct rb_root *root,
+						     u64 bytenr)
+{
+	struct rb_node *node = root->rb_node, *ret = NULL;
+	struct rb_simple_node *entry, *ret_entry = NULL;
+
+	while (node) {
+		entry = rb_entry(node, struct rb_simple_node, rb_node);
+
+		if (bytenr < entry->bytenr) {
+			if (!ret || entry->bytenr < ret_entry->bytenr) {
+				ret = node;
+				ret_entry = entry;
+			}
+
+			node = node->rb_left;
+		} else if (bytenr > entry->bytenr) {
+			node = node->rb_right;
+		} else {
+			return node;
+		}
+	}
+
+	return ret;
+}
+
+static inline struct rb_node *rb_simple_insert(struct rb_root *root, u64 bytenr,
+					       struct rb_node *node)
+{
+	struct rb_node **p = &root->rb_node;
+	struct rb_node *parent = NULL;
+	struct rb_simple_node *entry;
+
+	while (*p) {
+		parent = *p;
+		entry = rb_entry(parent, struct rb_simple_node, rb_node);
+
+		if (bytenr < entry->bytenr)
+			p = &(*p)->rb_left;
+		else if (bytenr > entry->bytenr)
+			p = &(*p)->rb_right;
+		else
+			return parent;
+	}
+
+	rb_link_node(node, parent, p);
+	rb_insert_color(node, root);
+	return NULL;
+}
+
+#endif
diff --git a/kernel-shared/transaction.c b/kernel-shared/transaction.c
index c1364d69..b16c07c3 100644
--- a/kernel-shared/transaction.c
+++ b/kernel-shared/transaction.c
@@ -142,7 +142,7 @@ int __commit_transaction(struct btrfs_trans_handle *trans,
 	while(1) {
 again:
 		ret = find_first_extent_bit(tree, 0, &start, &end,
-					    EXTENT_DIRTY);
+					    EXTENT_DIRTY, NULL);
 		if (ret)
 			break;
 
@@ -174,7 +174,8 @@ cleanup:
 	while (1) {
 		int find_ret;
 
-		find_ret = find_first_extent_bit(tree, 0, &start, &end, EXTENT_DIRTY);
+		find_ret = find_first_extent_bit(tree, 0, &start, &end,
+						 EXTENT_DIRTY, NULL);
 
 		if (find_ret)
 			break;
-- 
2.40.0

