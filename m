Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E2077AF34C
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Sep 2023 20:51:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235601AbjIZSvI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 26 Sep 2023 14:51:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235613AbjIZSvG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 26 Sep 2023 14:51:06 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B96C8139
        for <linux-btrfs@vger.kernel.org>; Tue, 26 Sep 2023 11:50:58 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 6CB7D2185F;
        Tue, 26 Sep 2023 18:50:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1695754257; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=x5DAibUT2IrmsJk1r9ykvKsg44kRqCPfCHprDRvUCVc=;
        b=c2YhbhC4Y809tBLN1tb430M5G1ft1Paspp961VYqIwBO4gVSEcTEjwYFqa2mBB3kmCvlWt
        ucObBUPNpZH7IuHsBIgh8K1d/k/i0XBikHSkEXMSdrUayATsjRXIYI5OIBv405sphQpJpH
        /G04E0M34mXv3ru6I0Gpov/3+vZZPnI=
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 4D3FD2C142;
        Tue, 26 Sep 2023 18:50:57 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id DDED5DA832; Tue, 26 Sep 2023 20:44:20 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 2/2] btrfs: change test_range_bit to scan the whole range
Date:   Tue, 26 Sep 2023 20:44:20 +0200
Message-ID: <d2a112f18eff2bd59d35cca0f5e776dfdd6fae5b.1695753339.git.dsterba@suse.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1695753339.git.dsterba@suse.com>
References: <cover.1695753339.git.dsterba@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_SOFTFAIL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The semantics of test_range_bit() with filled == 0 is now in it's own
helper so test_range_bit will check the whole range unconditionally.
The detection logic is flipped and assumes success by default and
catches exceptions.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/extent-io-tree.c | 34 +++++++++++++++++-----------------
 fs/btrfs/extent-io-tree.h |  4 ++--
 fs/btrfs/extent_io.c      |  2 +-
 fs/btrfs/inode.c          |  2 +-
 fs/btrfs/relocation.c     |  2 +-
 5 files changed, 22 insertions(+), 22 deletions(-)

diff --git a/fs/btrfs/extent-io-tree.c b/fs/btrfs/extent-io-tree.c
index 02414cc86def..def9c6a602ee 100644
--- a/fs/btrfs/extent-io-tree.c
+++ b/fs/btrfs/extent-io-tree.c
@@ -1671,15 +1671,15 @@ bool test_range_bit_exists(struct extent_io_tree *tree, u64 start, u64 end, u32
 }
 
 /*
- * Search a range in the state tree for a given mask.  If 'filled' == 1, this
- * returns 1 only if every extent in the tree has the bits set.  Otherwise, 1
- * is returned if any bit in the range is found set.
+ * Check if the whole range [@start,@end) contains the single @bit set.
  */
-int test_range_bit(struct extent_io_tree *tree, u64 start, u64 end,
-		   u32 bits, int filled, struct extent_state *cached)
+bool test_range_bit(struct extent_io_tree *tree, u64 start, u64 end, u32 bit,
+		    struct extent_state *cached)
 {
 	struct extent_state *state = NULL;
-	int bitset = 0;
+	bool bitset = true;
+
+	ASSERT(is_power_of_2(bit));
 
 	spin_lock(&tree->lock);
 	if (cached && extent_state_in_tree(cached) && cached->start <= start &&
@@ -1688,35 +1688,35 @@ int test_range_bit(struct extent_io_tree *tree, u64 start, u64 end,
 	else
 		state = tree_search(tree, start);
 	while (state && start <= end) {
-		if (filled && state->start > start) {
-			bitset = 0;
+		if (state->start > start) {
+			bitset = false;
 			break;
 		}
 
 		if (state->start > end)
 			break;
 
-		if (state->state & bits) {
-			bitset = 1;
-			if (!filled)
-				break;
-		} else if (filled) {
-			bitset = 0;
+		if ((state->state & bit) == 0) {
+			bitset = false;
 			break;
 		}
 
 		if (state->end == (u64)-1)
 			break;
 
+		/*
+		 * Last entry (if state->end is (u64)-1 and overflow happens),
+		 * or next entry starts after the range.
+		 */
 		start = state->end + 1;
-		if (start > end)
+		if (start > end || start == 0)
 			break;
 		state = next_state(state);
 	}
 
 	/* We ran out of states and were still inside of our range. */
-	if (filled && !state)
-		bitset = 0;
+	if (!state)
+		bitset = false;
 	spin_unlock(&tree->lock);
 	return bitset;
 }
diff --git a/fs/btrfs/extent-io-tree.h b/fs/btrfs/extent-io-tree.h
index 336b7e8c0f86..93c8eddadc03 100644
--- a/fs/btrfs/extent-io-tree.h
+++ b/fs/btrfs/extent-io-tree.h
@@ -131,8 +131,8 @@ u64 count_range_bits(struct extent_io_tree *tree,
 		     struct extent_state **cached_state);
 
 void free_extent_state(struct extent_state *state);
-int test_range_bit(struct extent_io_tree *tree, u64 start, u64 end,
-		   u32 bits, int filled, struct extent_state *cached_state);
+bool test_range_bit(struct extent_io_tree *tree, u64 start, u64 end, u32 bit,
+		    struct extent_state *cached_state);
 bool test_range_bit_exists(struct extent_io_tree *tree, u64 start, u64 end, u32 bit);
 int clear_record_extent_bits(struct extent_io_tree *tree, u64 start, u64 end,
 			     u32 bits, struct extent_changeset *changeset);
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index ffd0be61ef77..03cef28d9e37 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -394,7 +394,7 @@ noinline_for_stack bool find_lock_delalloc_range(struct inode *inode,
 
 	/* then test to make sure it is all still delalloc */
 	ret = test_range_bit(tree, delalloc_start, delalloc_end,
-			     EXTENT_DELALLOC, 1, cached_state);
+			     EXTENT_DELALLOC, cached_state);
 	if (!ret) {
 		unlock_extent(tree, delalloc_start, delalloc_end,
 			      &cached_state);
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 0f14f85111f7..1c14778ac248 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -3290,7 +3290,7 @@ bool btrfs_data_csum_ok(struct btrfs_bio *bbio, struct btrfs_device *dev,
 
 	if (btrfs_is_data_reloc_root(inode->root) &&
 	    test_range_bit(&inode->io_tree, file_offset, end, EXTENT_NODATASUM,
-			   1, NULL)) {
+			   NULL)) {
 		/* Skip the range without csum for data reloc inode */
 		clear_extent_bits(&inode->io_tree, file_offset, end,
 				  EXTENT_NODATASUM);
diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index cdadb4af58ea..d987ee5cfea5 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -2630,7 +2630,7 @@ static int tree_block_processed(u64 bytenr, struct reloc_control *rc)
 	u32 blocksize = rc->extent_root->fs_info->nodesize;
 
 	if (test_range_bit(&rc->processed_blocks, bytenr,
-			   bytenr + blocksize - 1, EXTENT_DIRTY, 1, NULL))
+			   bytenr + blocksize - 1, EXTENT_DIRTY, NULL))
 		return 1;
 	return 0;
 }
-- 
2.41.0

