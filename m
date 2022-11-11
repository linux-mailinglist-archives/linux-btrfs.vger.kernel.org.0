Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BC9A6259D2
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Nov 2022 12:50:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233446AbiKKLuu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 11 Nov 2022 06:50:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233426AbiKKLus (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 11 Nov 2022 06:50:48 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1B8F27910
        for <linux-btrfs@vger.kernel.org>; Fri, 11 Nov 2022 03:50:46 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8CFC4B825D2
        for <linux-btrfs@vger.kernel.org>; Fri, 11 Nov 2022 11:50:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA552C433D6
        for <linux-btrfs@vger.kernel.org>; Fri, 11 Nov 2022 11:50:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668167444;
        bh=SLaN3flFkRefdXdkhA2P2UmXgAW4s+Hy7QIBAM2yyCU=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=ft17+chNWUaiNbZy9GXhSU8Lf8qUybip+5G1I+BDUkqPmwChNGMQfcUSR3ocY6Xxl
         TBGOzLsovO77heYrtvQuVitktTknaghRuh2tVD4p4xSPvTg9wFR80SVDhJmVw43GF7
         X/pSwyQCUKpfRQVQhwC1JLVJhYavmPeDsdeq7BWDUIh3dG7tl+pBegYi+Y8SG5gwz2
         6IM+EVdE2quTMqIX8iw7b08LFKu7ZJeLE0neATbd7ko8rh9LZPASqncDizfH7Fzm69
         mUrxsUTHxTVI8ba7SRzhhZb507dxfghRIGYfvgrNdZqWha2WFzqNNNQq90MvnCeYy8
         OHPrayopYwPXw==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 6/9] btrfs: allow passing a cached state record to count_range_bits()
Date:   Fri, 11 Nov 2022 11:50:32 +0000
Message-Id: <76708fd3ce546fb710ddc6f8792cc85f8d592620.1668166764.git.fdmanana@suse.com>
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

An inode's io_tree can be quite large and there are cases where due to
delalloc it can have thousands of extent state records, which makes the
red black tree have a depth of 10 or more, making the operation of
count_range_bits() slow if we repeatedly call it for a range that starts
where, or after, the previous one we called it for. Such use cases are
when searching for delalloc in a file range that corresponds to a hole or
a prealloc extent, which is done during lseek SEEK_HOLE/DATA and fiemap.

So introduce a cached state parameter to count_range_bits() which we use
to store the last extent state record we visited, and then allow the
caller to pass it again on its next call to count_range_bits(). The next
patches in the series will make fiemap and lseek use the new parameter.

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
 fs/btrfs/extent-io-tree.c | 47 ++++++++++++++++++++++++++++++++++++---
 fs/btrfs/extent-io-tree.h |  3 ++-
 fs/btrfs/file.c           |  3 ++-
 fs/btrfs/inode.c          |  2 +-
 4 files changed, 49 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/extent-io-tree.c b/fs/btrfs/extent-io-tree.c
index 285b0ff6e953..6b0d78df7eee 100644
--- a/fs/btrfs/extent-io-tree.c
+++ b/fs/btrfs/extent-io-tree.c
@@ -1521,9 +1521,11 @@ void find_first_clear_extent_bit(struct extent_io_tree *tree, u64 start,
  */
 u64 count_range_bits(struct extent_io_tree *tree,
 		     u64 *start, u64 search_end, u64 max_bytes,
-		     u32 bits, int contig)
+		     u32 bits, int contig,
+		     struct extent_state **cached_state)
 {
-	struct extent_state *state;
+	struct extent_state *state = NULL;
+	struct extent_state *cached;
 	u64 cur_start = *start;
 	u64 total_bytes = 0;
 	u64 last = 0;
@@ -1534,11 +1536,41 @@ u64 count_range_bits(struct extent_io_tree *tree,
 
 	spin_lock(&tree->lock);
 
+	if (!cached_state || !*cached_state)
+		goto search;
+
+	cached = *cached_state;
+
+	if (!extent_state_in_tree(cached))
+		goto search;
+
+	if (cached->start <= cur_start && cur_start <= cached->end) {
+		state = cached;
+	} else if (cached->start > cur_start) {
+		struct extent_state *prev;
+
+		/*
+		 * The cached state starts after our search range's start. Check
+		 * if the previous state record starts at or before the range we
+		 * are looking for, and if so, use it - this is a common case
+		 * when there are holes between records in the tree. If there is
+		 * no previous state record, we can start from our cached state.
+		 */
+		prev = prev_state(cached);
+		if (!prev)
+			state = cached;
+		else if (prev->start <= cur_start && cur_start <= prev->end)
+			state = prev;
+	}
+
 	/*
 	 * This search will find all the extents that end after our range
 	 * starts.
 	 */
-	state = tree_search(tree, cur_start);
+search:
+	if (!state)
+		state = tree_search(tree, cur_start);
+
 	while (state) {
 		if (state->start > search_end)
 			break;
@@ -1559,7 +1591,16 @@ u64 count_range_bits(struct extent_io_tree *tree,
 		}
 		state = next_state(state);
 	}
+
+	if (cached_state) {
+		free_extent_state(*cached_state);
+		*cached_state = state;
+		if (state)
+			refcount_inc(&state->refs);
+	}
+
 	spin_unlock(&tree->lock);
+
 	return total_bytes;
 }
 
diff --git a/fs/btrfs/extent-io-tree.h b/fs/btrfs/extent-io-tree.h
index 18ab82f62611..e3eeec380844 100644
--- a/fs/btrfs/extent-io-tree.h
+++ b/fs/btrfs/extent-io-tree.h
@@ -119,7 +119,8 @@ void __cold extent_state_free_cachep(void);
 
 u64 count_range_bits(struct extent_io_tree *tree,
 		     u64 *start, u64 search_end,
-		     u64 max_bytes, u32 bits, int contig);
+		     u64 max_bytes, u32 bits, int contig,
+		     struct extent_state **cached_state);
 
 void free_extent_state(struct extent_state *state);
 int test_range_bit(struct extent_io_tree *tree, u64 start, u64 end,
diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 6bc2397e324c..dc8399610ca3 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -3235,7 +3235,8 @@ static bool find_delalloc_subrange(struct btrfs_inode *inode, u64 start, u64 end
 			*delalloc_start_ret = start;
 			delalloc_len = count_range_bits(&inode->io_tree,
 							delalloc_start_ret, end,
-							len, EXTENT_DELALLOC, 1);
+							len, EXTENT_DELALLOC, 1,
+							NULL);
 		} else {
 			spin_unlock(&inode->lock);
 		}
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index aec1b232a71c..83898bca39d5 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -1769,7 +1769,7 @@ static int fallback_to_cow(struct btrfs_inode *inode, struct page *locked_page,
 	 * when starting writeback.
 	 */
 	count = count_range_bits(io_tree, &range_start, end, range_bytes,
-				 EXTENT_NORESERVE, 0);
+				 EXTENT_NORESERVE, 0, NULL);
 	if (count > 0 || is_space_ino || is_reloc_ino) {
 		u64 bytes = count;
 		struct btrfs_fs_info *fs_info = inode->root->fs_info;
-- 
2.35.1

