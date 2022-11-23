Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AD0C636D4A
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Nov 2022 23:39:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229788AbiKWWi3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 23 Nov 2022 17:38:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229764AbiKWWiE (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 23 Nov 2022 17:38:04 -0500
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 428C31759D
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Nov 2022 14:38:02 -0800 (PST)
Received: by mail-qk1-x733.google.com with SMTP id d7so13485998qkk.3
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Nov 2022 14:38:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gxRflk/AZejra4oEnnwbIhPblcA7v3IrlRRNU2k7alA=;
        b=e2RJNJIwfShwemKcUsduoZqwuQaDQlH3agVQ7df78IkTiVXF1FMihnalcEMIbxyzL7
         jL9dzlo/wcNNrg9qq++eBnrs9SA0DyF9CyFfpPT3CdKQPGbVnaJcQOY55bU45K/hXQmf
         vhA6lmhIj2/nBGlTYQwakBq+RZ8pU4zBZlDcL71fRZ9bNCMCQqSzA0HeQL1XsKs21Emw
         wOAmWgJl6IN2aeovDAFABAbdB5APi641AIa9eL3qBbOrNOsHiSpZ4rik2tpukNtFjtXe
         U5ZIPrRqPNYd6AAfu/q7MCLQqUXo11Zl9Rj0c9SrmcPHZt6j38fUwTCtfQAA8or1QfXx
         j3ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gxRflk/AZejra4oEnnwbIhPblcA7v3IrlRRNU2k7alA=;
        b=wOIBJvl57KxPUSDKA+R9TULjRz7y66Jl+LATuNioiFrO57tRB6MiOsrKylLLQ2Rp3Q
         sh5u2RMmR2ReBJp8P9r4CElGujf7jIpCOb+z12q4OsC7BFBEBdKbPmm/Nfva9uqYRE4k
         a8Sk8lk22XYGsN7OafD1O7wfLu5mvZKbOOrJdO/ZTgg8Qws23y/+Y5ci4n4gcvTRRHK9
         i4gWbqEu9ZTLCbtvaODdZNKAKqyZZpRJnFAVyY4I85bBa/6JNfeQriau2aSpoccHzEzq
         Bp2hSfoEhZvm4jdOSbxhRyB1gipBg0svy/i3ZcEE2Z2MyNR/XFANskOChItKX7B1nwxJ
         1g5g==
X-Gm-Message-State: ANoB5pnJDI67LHDFid+XZ4aABy5fgQj2ujIDRbJGOTIuhyS4ZqmOEZZr
        W5rlo27fBpT5ThFJF4KaMWiEwEU14tB8UQ==
X-Google-Smtp-Source: AA0mqf7T2AMtVF9HjlI82Damm24l3D1GXOcKsTVS/q+KO3C+r3TDqL116UCkqXVHR4x0/6GGyLQitg==
X-Received: by 2002:a05:620a:8c8:b0:6fb:cf37:a30e with SMTP id z8-20020a05620a08c800b006fbcf37a30emr24195079qkz.306.1669243081479;
        Wed, 23 Nov 2022 14:38:01 -0800 (PST)
Received: from localhost (cpe-174-109-170-245.nc.res.rr.com. [174.109.170.245])
        by smtp.gmail.com with ESMTPSA id d12-20020ac8060c000000b0039d085a2571sm10446978qth.55.2022.11.23.14.38.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Nov 2022 14:38:01 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v3 17/29] btrfs-progs: move extent cache code directly into btrfs_fs_info
Date:   Wed, 23 Nov 2022 17:37:25 -0500
Message-Id: <d590af211b6c9eb743875166e1beab21878042a6.1669242804.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1669242804.git.josef@toxicpanda.com>
References: <cover.1669242804.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We have some extra features in the btrfs-progs copy of the
extent_io_tree that don't exist in the kernel.  In order to make syncing
easier simply move this functionality into btrfs_fs_info, that way we
can sync in the new extent_io_tree code and not have to worry about
breaking anything.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 kernel-shared/ctree.h     |  6 +++-
 kernel-shared/disk-io.c   |  4 +--
 kernel-shared/extent_io.c | 76 ++++++++++++++++++++++++++-------------
 kernel-shared/extent_io.h |  2 ++
 4 files changed, 60 insertions(+), 28 deletions(-)

diff --git a/kernel-shared/ctree.h b/kernel-shared/ctree.h
index b9a58325..d359753b 100644
--- a/kernel-shared/ctree.h
+++ b/kernel-shared/ctree.h
@@ -1217,7 +1217,11 @@ struct btrfs_fs_info {
 	/* the log root tree is a directory of all the other log roots */
 	struct btrfs_root *log_root_tree;
 
-	struct extent_io_tree extent_cache;
+	struct cache_tree extent_cache;
+	u64 max_cache_size;
+	u64 cache_size;
+	struct list_head lru;
+
 	struct extent_io_tree dirty_buffers;
 	struct extent_io_tree free_space_cache;
 	struct extent_io_tree pinned_extents;
diff --git a/kernel-shared/disk-io.c b/kernel-shared/disk-io.c
index 8c428ade..c266f9c2 100644
--- a/kernel-shared/disk-io.c
+++ b/kernel-shared/disk-io.c
@@ -864,7 +864,7 @@ struct btrfs_fs_info *btrfs_new_fs_info(int writable, u64 sb_bytenr)
 	    !fs_info->block_group_root || !fs_info->super_copy)
 		goto free_all;
 
-	extent_io_tree_init(&fs_info->extent_cache);
+	extent_buffer_init_cache(fs_info);
 	extent_io_tree_init(&fs_info->dirty_buffers);
 	extent_io_tree_init(&fs_info->free_space_cache);
 	extent_io_tree_init(&fs_info->pinned_extents);
@@ -1350,7 +1350,7 @@ void btrfs_cleanup_all_caches(struct btrfs_fs_info *fs_info)
 	}
 	free_mapping_cache_tree(&fs_info->mapping_tree.cache_tree);
 	extent_io_tree_cleanup(&fs_info->dirty_buffers);
-	extent_io_tree_cleanup(&fs_info->extent_cache);
+	extent_buffer_free_cache(fs_info);
 	extent_io_tree_cleanup(&fs_info->free_space_cache);
 	extent_io_tree_cleanup(&fs_info->pinned_extents);
 	extent_io_tree_cleanup(&fs_info->extent_ins);
diff --git a/kernel-shared/extent_io.c b/kernel-shared/extent_io.c
index 4b6e0bee..492857b0 100644
--- a/kernel-shared/extent_io.c
+++ b/kernel-shared/extent_io.c
@@ -34,13 +34,45 @@
 #include "common/device-utils.h"
 #include "common/internal.h"
 
+static void free_extent_buffer_final(struct extent_buffer *eb);
+
+void extent_buffer_init_cache(struct btrfs_fs_info *fs_info)
+{
+	fs_info->max_cache_size = total_memory() / 4;
+	fs_info->cache_size = 0;
+	INIT_LIST_HEAD(&fs_info->lru);
+}
+
+void extent_buffer_free_cache(struct btrfs_fs_info *fs_info)
+{
+	struct extent_buffer *eb;
+
+	while(!list_empty(&fs_info->lru)) {
+		eb = list_entry(fs_info->lru.next, struct extent_buffer, lru);
+		if (eb->refs) {
+			/*
+			 * Reset extent buffer refs to 1, so the
+			 * free_extent_buffer_nocache() can free it for sure.
+			 */
+			eb->refs = 1;
+			fprintf(stderr,
+				"extent buffer leak: start %llu len %u\n",
+				(unsigned long long)eb->start, eb->len);
+			free_extent_buffer_nocache(eb);
+		} else {
+			free_extent_buffer_final(eb);
+		}
+	}
+
+	free_extent_cache_tree(&fs_info->extent_cache);
+	fs_info->cache_size = 0;
+}
+
 void extent_io_tree_init(struct extent_io_tree *tree)
 {
 	cache_tree_init(&tree->state);
 	cache_tree_init(&tree->cache);
 	INIT_LIST_HEAD(&tree->lru);
-	tree->cache_size = 0;
-	tree->max_cache_size = (u64)total_memory() / 4;
 }
 
 static struct extent_state *alloc_extent_state(void)
@@ -73,7 +105,6 @@ static void free_extent_state_func(struct cache_extent *cache)
 	btrfs_free_extent_state(es);
 }
 
-static void free_extent_buffer_final(struct extent_buffer *eb);
 void extent_io_tree_cleanup(struct extent_io_tree *tree)
 {
 	struct extent_buffer *eb;
@@ -644,11 +675,9 @@ static void free_extent_buffer_final(struct extent_buffer *eb)
 	BUG_ON(eb->refs);
 	list_del_init(&eb->lru);
 	if (!(eb->flags & EXTENT_BUFFER_DUMMY)) {
-		struct extent_io_tree *tree = &eb->fs_info->extent_cache;
-
-		remove_cache_extent(&tree->cache, &eb->cache_node);
-		BUG_ON(tree->cache_size < eb->len);
-		tree->cache_size -= eb->len;
+		remove_cache_extent(&eb->fs_info->extent_cache, &eb->cache_node);
+		BUG_ON(eb->fs_info->cache_size < eb->len);
+		eb->fs_info->cache_size -= eb->len;
 	}
 	free(eb);
 }
@@ -685,15 +714,14 @@ void free_extent_buffer_nocache(struct extent_buffer *eb)
 struct extent_buffer *find_extent_buffer(struct btrfs_fs_info *fs_info,
 					 u64 bytenr, u32 blocksize)
 {
-	struct extent_io_tree *tree = &fs_info->extent_cache;
 	struct extent_buffer *eb = NULL;
 	struct cache_extent *cache;
 
-	cache = lookup_cache_extent(&tree->cache, bytenr, blocksize);
+	cache = lookup_cache_extent(&fs_info->extent_cache, bytenr, blocksize);
 	if (cache && cache->start == bytenr &&
 	    cache->size == blocksize) {
 		eb = container_of(cache, struct extent_buffer, cache_node);
-		list_move_tail(&eb->lru, &tree->lru);
+		list_move_tail(&eb->lru, &fs_info->lru);
 		eb->refs++;
 	}
 	return eb;
@@ -702,27 +730,26 @@ struct extent_buffer *find_extent_buffer(struct btrfs_fs_info *fs_info,
 struct extent_buffer *find_first_extent_buffer(struct btrfs_fs_info *fs_info,
 					       u64 start)
 {
-	struct extent_io_tree *tree = &fs_info->extent_cache;
 	struct extent_buffer *eb = NULL;
 	struct cache_extent *cache;
 
-	cache = search_cache_extent(&tree->cache, start);
+	cache = search_cache_extent(&fs_info->extent_cache, start);
 	if (cache) {
 		eb = container_of(cache, struct extent_buffer, cache_node);
-		list_move_tail(&eb->lru, &tree->lru);
+		list_move_tail(&eb->lru, &fs_info->lru);
 		eb->refs++;
 	}
 	return eb;
 }
 
-static void trim_extent_buffer_cache(struct extent_io_tree *tree)
+static void trim_extent_buffer_cache(struct btrfs_fs_info *fs_info)
 {
 	struct extent_buffer *eb, *tmp;
 
-	list_for_each_entry_safe(eb, tmp, &tree->lru, lru) {
+	list_for_each_entry_safe(eb, tmp, &fs_info->lru, lru) {
 		if (eb->refs == 0)
 			free_extent_buffer_final(eb);
-		if (tree->cache_size <= ((tree->max_cache_size * 9) / 10))
+		if (fs_info->cache_size <= ((fs_info->max_cache_size * 9) / 10))
 			break;
 	}
 }
@@ -731,14 +758,13 @@ struct extent_buffer *alloc_extent_buffer(struct btrfs_fs_info *fs_info,
 					  u64 bytenr, u32 blocksize)
 {
 	struct extent_buffer *eb;
-	struct extent_io_tree *tree = &fs_info->extent_cache;
 	struct cache_extent *cache;
 
-	cache = lookup_cache_extent(&tree->cache, bytenr, blocksize);
+	cache = lookup_cache_extent(&fs_info->extent_cache, bytenr, blocksize);
 	if (cache && cache->start == bytenr &&
 	    cache->size == blocksize) {
 		eb = container_of(cache, struct extent_buffer, cache_node);
-		list_move_tail(&eb->lru, &tree->lru);
+		list_move_tail(&eb->lru, &fs_info->lru);
 		eb->refs++;
 	} else {
 		int ret;
@@ -751,15 +777,15 @@ struct extent_buffer *alloc_extent_buffer(struct btrfs_fs_info *fs_info,
 		eb = __alloc_extent_buffer(fs_info, bytenr, blocksize);
 		if (!eb)
 			return NULL;
-		ret = insert_cache_extent(&tree->cache, &eb->cache_node);
+		ret = insert_cache_extent(&fs_info->extent_cache, &eb->cache_node);
 		if (ret) {
 			free(eb);
 			return NULL;
 		}
-		list_add_tail(&eb->lru, &tree->lru);
-		tree->cache_size += blocksize;
-		if (tree->cache_size >= tree->max_cache_size)
-			trim_extent_buffer_cache(tree);
+		list_add_tail(&eb->lru, &fs_info->lru);
+		fs_info->cache_size += blocksize;
+		if (fs_info->cache_size >= fs_info->max_cache_size)
+			trim_extent_buffer_cache(fs_info);
 	}
 	return eb;
 }
diff --git a/kernel-shared/extent_io.h b/kernel-shared/extent_io.h
index e4ae2dcd..1c7dbc51 100644
--- a/kernel-shared/extent_io.h
+++ b/kernel-shared/extent_io.h
@@ -165,5 +165,7 @@ void extent_buffer_bitmap_clear(struct extent_buffer *eb, unsigned long start,
                                 unsigned long pos, unsigned long len);
 void extent_buffer_bitmap_set(struct extent_buffer *eb, unsigned long start,
                               unsigned long pos, unsigned long len);
+void extent_buffer_init_cache(struct btrfs_fs_info *fs_info);
+void extent_buffer_free_cache(struct btrfs_fs_info *fs_info);
 
 #endif
-- 
2.26.3

