Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D07066CBB6D
	for <lists+linux-btrfs@lfdr.de>; Tue, 28 Mar 2023 11:47:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229664AbjC1JrE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 28 Mar 2023 05:47:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232936AbjC1Jq2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 28 Mar 2023 05:46:28 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE79A7EC6
        for <linux-btrfs@vger.kernel.org>; Tue, 28 Mar 2023 02:45:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 395BAB80976
        for <linux-btrfs@vger.kernel.org>; Tue, 28 Mar 2023 09:45:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7817FC433D2
        for <linux-btrfs@vger.kernel.org>; Tue, 28 Mar 2023 09:45:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679996727;
        bh=is/8m4XGl89z4WG16TxvDZ2A4UngLFiaGCLBm+40Jk8=;
        h=From:To:Subject:Date:From;
        b=ZGWrSCkY7iAuPNWWqEN7xlSgtDE/KewCvn79wDY9g0KUdYMHVeIoYJVYthV+W2HSg
         KBBxltFfzucnRKo+QmicA8V5mLPlw3hqF2hIl5P0VcDzHWMr1gZtLAX8ShFGVMz6Sq
         /i1AznHX4O3dztphf1PbnWj5QpuYEQ24oL5iXvCDyOFrocSQMoTzGPntw6S79YUPyP
         I+ENPiJHQUQb54x8Fft9Tp2NohcJyrw5nCQsBnf6pF7Rel6euyv5HCnCaMeYzW6qE4
         TXkk0NMw0QAyaJy3VmOG5oYQL4oZ+GCR0vpAycL7M+QczsDY8NYoInMfsKE74Lh4TB
         kRPn07iyT3z7w==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: ignore fiemap path cache when there are multiple paths for a node
Date:   Tue, 28 Mar 2023 10:45:20 +0100
Message-Id: <0322b6ece3502da4d8243882c9658c9cfbb22a28.1679996288.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

During fiemap, when walking backreferences to determine if a b+tree
node/leaf is shared, we may find a tree block (leaf or node) for which
two parents were added to the references ulist. This happens if we get
for example one direct ref (shared tree block ref) and one indirect ref
(non-shared tree block ref) for the tree block at the current level,
which can happen during relocation.

In that case the fiemap path cache can not be used since it's meant for
a single path, with one tree block at each possible level, so having
multiple references for a tree block at any level may result in getting
the level counter exceed BTRFS_MAX_LEVEL and eventually trigger the
warning:

   WARN_ON_ONCE(level >= BTRFS_MAX_LEVEL)

at lookup_backref_shared_cache() and at store_backref_shared_cache().
This is harmless since the code ignores any level >= BTRFS_MAX_LEVEL, the
warning is there just to catch any unexpected case like the one described
above. However if a user finds this it may be scary and get reported.

So just ignore the path cache once we find a tree block for which there
are more than one reference, which is the less common case, and update
the cache with the sharedness check result for all levels below the level
for which we found multiple references.

Reported-by: Jarno Pelkonen <jarno.pelkonen@gmail.com>
Link: https://lore.kernel.org/linux-btrfs/CAKv8qLmDNAGJGCtsevxx_VZ_YOvvs1L83iEJkTgyA4joJertng@mail.gmail.com/
Fixes: 12a824dc67a6 ("btrfs: speedup checking for extent sharedness during fiemap")
Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/backref.c | 85 ++++++++++++++++++++++++++++++++++------------
 1 file changed, 63 insertions(+), 22 deletions(-)

diff --git a/fs/btrfs/backref.c b/fs/btrfs/backref.c
index 90e40d5ceccd..e54f0884802a 100644
--- a/fs/btrfs/backref.c
+++ b/fs/btrfs/backref.c
@@ -1921,8 +1921,7 @@ int btrfs_is_data_extent_shared(struct btrfs_inode *inode, u64 bytenr,
 	level = -1;
 	ULIST_ITER_INIT(&uiter);
 	while (1) {
-		bool is_shared;
-		bool cached;
+		const unsigned long prev_ref_count = ctx->refs.nnodes;
 
 		walk_ctx.bytenr = bytenr;
 		ret = find_parent_nodes(&walk_ctx, &shared);
@@ -1940,21 +1939,36 @@ int btrfs_is_data_extent_shared(struct btrfs_inode *inode, u64 bytenr,
 		ret = 0;
 
 		/*
-		 * If our data extent was not directly shared (without multiple
-		 * reference items), than it might have a single reference item
-		 * with a count > 1 for the same offset, which means there are 2
-		 * (or more) file extent items that point to the data extent -
-		 * this happens when a file extent item needs to be split and
-		 * then one item gets moved to another leaf due to a b+tree leaf
-		 * split when inserting some item. In this case the file extent
-		 * items may be located in different leaves and therefore some
-		 * of the leaves may be referenced through shared subtrees while
-		 * others are not. Since our extent buffer cache only works for
-		 * a single path (by far the most common case and simpler to
-		 * deal with), we can not use it if we have multiple leaves
-		 * (which implies multiple paths).
+		 * More than one extent buffer (bytenr) may have been added to
+		 * the ctx->refs ulist, in which case we have to check multiple
+		 * tree paths in case the first one is not shared, so we can not
+		 * use the path cache which is made for a single path. Multiple
+		 * extent buffers at the current level happen when:
+		 *
+		 * 1) level -1, the data extent: If our data extent was not
+		 *    directly shared (without multiple reference items), then
+		 *    it might have a single reference item with a count > 1 for
+		 *    the same offset, which means there are 2 (or more) file
+		 *    extent items that point to the data extent - this happens
+		 *    when a file extent item needs to be split and then one
+		 *    item gets moved to another leaf due to a b+tree leaf split
+		 *    when inserting some item. In this case the file extent
+		 *    items may be located in different leaves and therefore
+		 *    some of the leaves may be referenced through shared
+		 *    subtrees while others are not. Since our extent buffer
+		 *    cache only works for a single path (by far the most common
+		 *    case and simpler to deal with), we can not use it if we
+		 *    have multiple leaves (which implies multiple paths).
+		 *
+		 * 2) level >= 0, a tree node/leaf: We can have a mix of direct
+		 *    and indirect references on a b+tree node/leaf, so we have
+		 *    to check multiple paths, and the extent buffer (the
+		 *    current bytenr) may be shared or not. One example is
+		 *    during relocation as we may get a shared tree block ref
+		 *    (direct ref) and a non-shared tree block ref (indirect
+		 *    ref) for the same node/leaf.
 		 */
-		if (level == -1 && ctx->refs.nnodes > 1)
+		if ((ctx->refs.nnodes - prev_ref_count) > 1)
 			ctx->use_path_cache = false;
 
 		if (level >= 0)
@@ -1964,18 +1978,45 @@ int btrfs_is_data_extent_shared(struct btrfs_inode *inode, u64 bytenr,
 		if (!node)
 			break;
 		bytenr = node->val;
-		level++;
-		cached = lookup_backref_shared_cache(ctx, root, bytenr, level,
-						     &is_shared);
-		if (cached) {
-			ret = (is_shared ? 1 : 0);
-			break;
+		if (ctx->use_path_cache) {
+			bool is_shared;
+			bool cached;
+
+			level++;
+			cached = lookup_backref_shared_cache(ctx, root, bytenr,
+							     level, &is_shared);
+			if (cached) {
+				ret = (is_shared ? 1 : 0);
+				break;
+			}
 		}
 		shared.share_count = 0;
 		shared.have_delayed_delete_refs = false;
 		cond_resched();
 	}
 
+	/*
+	 * If the path cache is disabled, then it means at some tree level we
+	 * got multiple parents due to a mix of direct and indirect backrefs or
+	 * multiple leaves with file extent items pointing to the same data
+	 * extent. We have to invalidate the cache and cache only the sharedness
+	 * result for the levels where we got only one node/reference.
+	 */
+	if (!ctx->use_path_cache) {
+		int i = 0;
+
+		level--;
+		if (ret >= 0 && level >= 0) {
+			bytenr = ctx->path_cache_entries[level].bytenr;
+			ctx->use_path_cache = true;
+			store_backref_shared_cache(ctx, root, bytenr, level, ret);
+			i = level + 1;
+		}
+
+		for ( ; i < BTRFS_MAX_LEVEL; i++)
+			ctx->path_cache_entries[i].bytenr = 0;
+	}
+
 	/*
 	 * Cache the sharedness result for the data extent if we know our inode
 	 * has more than 1 file extent item that refers to the data extent.
-- 
2.34.1

