Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D15CB6259D3
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Nov 2022 12:50:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233445AbiKKLuu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 11 Nov 2022 06:50:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233419AbiKKLuq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 11 Nov 2022 06:50:46 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09EAD28E2F
        for <linux-btrfs@vger.kernel.org>; Fri, 11 Nov 2022 03:50:46 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BC624B825D3
        for <linux-btrfs@vger.kernel.org>; Fri, 11 Nov 2022 11:50:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7515C433C1
        for <linux-btrfs@vger.kernel.org>; Fri, 11 Nov 2022 11:50:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668167443;
        bh=3Eyo43gep3ia/fK0YlO/Psb2SHw4e89BF9edrDc546E=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=RNLlMuAI2OzI2vgfoN1ViClvNH7aMOBUUIoxVS6TG8roixzU/yC+c6gpVUFScbjJp
         4tyzhHgzdNo7hb1AZPBO8XozjAydJfNmWHsC+LzIzTh1KaA7oHKqwfzgD4UG9kIqFK
         XPE0Yuo+Xxg7kTzTK32LTgs+3NwTGF8JVLqBBZhTuWIrAKn76AVZiKSMWtPBzXq1MQ
         +l+FN0+PUZ7IdYQovCGyROVpgkhCi8Ju/Yh1+KHgHXykkCufCZd4yGfx+at8qhJ0K6
         BAWLVMiBLWAaTrs93B8TYFiLGida/ek6+18kAAtpt9fUNgJ49gmuHn/+KwI29uRZES
         jvGJXU12A6VeA==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 5/9] btrfs: remove no longer used btrfs_next_extent_map()
Date:   Fri, 11 Nov 2022 11:50:31 +0000
Message-Id: <4f391eb6008e716ecda0dc0c64924e86cfd1944a.1668166764.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1668166764.git.fdmanana@suse.com>
References: <cover.1668166764.git.fdmanana@suse.com>
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

There are no more users of btrfs_next_extent_map(), the previous patch
in the series ("btrfs: search for delalloc more efficiently during
lseek/fiemap") removed the last usage of the function, so delete it.

This change is part of a patchset that has the goal to make performance
better for applications that use lseek's SEEK_HOLE and SEEK_DATA modes to
iterate over the extents of a file. Two examples are the cp program from
coreutils 9.0+ and the tar program (when using its --sparse / -S option).
A sample test and results are listed in the changelog of the last patch
in the series:

  1/9 btrfs: remove leftover setting of EXTENT_UPTODATE state in an inode's io_tree
  2/9 btrfs: add an early exit when searching for delalloc range for lseek/fiemap
  3/9 btrfs: skip unnecessary delalloc searches during lseek/fiemap
  4/9 btrfs: search for delalloc more efficiently during lseek/fiemap
  5/9 btrfs: remove no longer used btrfs_next_extent_map()
  6/9 btrfs: allow passing a cached state record to count_range_bits()
  7/9 btrfs: update stale comment for count_range_bits()
  8/9 btrfs: use cached state when looking for delalloc ranges with fiemap
  9/9 btrfs: use cached state when looking for delalloc ranges with lseek

Reported-by: Wang Yugui <wangyugui@e16-tech.com>
Link: https://lore.kernel.org/linux-btrfs/20221106073028.71F9.409509F4@e16-tech.com/
Link: https://lore.kernel.org/linux-btrfs/CAL3q7H5NSVicm7nYBJ7x8fFkDpno8z3PYt5aPU43Bajc1H0h1Q@mail.gmail.com/
Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/extent_map.c | 29 -----------------------------
 fs/btrfs/extent_map.h |  2 --
 2 files changed, 31 deletions(-)

diff --git a/fs/btrfs/extent_map.c b/fs/btrfs/extent_map.c
index 4a4362f5cc52..be94030e1dfb 100644
--- a/fs/btrfs/extent_map.c
+++ b/fs/btrfs/extent_map.c
@@ -529,35 +529,6 @@ static struct extent_map *next_extent_map(const struct extent_map *em)
 	return container_of(next, struct extent_map, rb_node);
 }
 
-/*
- * Get the extent map that immediately follows another one.
- *
- * @tree:       The extent map tree that the extent map belong to.
- *              Holding read or write access on the tree's lock is required.
- * @em:         An extent map from the given tree. The caller must ensure that
- *              between getting @em and between calling this function, the
- *              extent map @em is not removed from the tree - for example, by
- *              holding the tree's lock for the duration of those 2 operations.
- *
- * Returns the extent map that immediately follows @em, or NULL if @em is the
- * last extent map in the tree.
- */
-struct extent_map *btrfs_next_extent_map(const struct extent_map_tree *tree,
-					 const struct extent_map *em)
-{
-	struct extent_map *next;
-
-	/* The lock must be acquired either in read mode or write mode. */
-	lockdep_assert_held(&tree->lock);
-	ASSERT(extent_map_in_tree(em));
-
-	next = next_extent_map(em);
-	if (next)
-		refcount_inc(&next->refs);
-
-	return next;
-}
-
 static struct extent_map *prev_extent_map(struct extent_map *em)
 {
 	struct rb_node *prev;
diff --git a/fs/btrfs/extent_map.h b/fs/btrfs/extent_map.h
index 68d3f2c9ea1d..ad311864272a 100644
--- a/fs/btrfs/extent_map.h
+++ b/fs/btrfs/extent_map.h
@@ -87,8 +87,6 @@ static inline u64 extent_map_block_end(struct extent_map *em)
 void extent_map_tree_init(struct extent_map_tree *tree);
 struct extent_map *lookup_extent_mapping(struct extent_map_tree *tree,
 					 u64 start, u64 len);
-struct extent_map *btrfs_next_extent_map(const struct extent_map_tree *tree,
-					 const struct extent_map *em);
 int add_extent_mapping(struct extent_map_tree *tree,
 		       struct extent_map *em, int modified);
 void remove_extent_mapping(struct extent_map_tree *tree, struct extent_map *em);
-- 
2.35.1

