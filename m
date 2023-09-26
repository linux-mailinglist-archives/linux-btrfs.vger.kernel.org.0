Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B53F7AF34D
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Sep 2023 20:51:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235543AbjIZSvE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 26 Sep 2023 14:51:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235600AbjIZSvD (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 26 Sep 2023 14:51:03 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D666192
        for <linux-btrfs@vger.kernel.org>; Tue, 26 Sep 2023 11:50:56 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 074DE21847;
        Tue, 26 Sep 2023 18:50:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1695754255; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0hh1vz6PpoaFmXA0hiyeZ5sqR+GpId6h9w/Rhpj/5Yc=;
        b=FtJ3noSDoC0C6A3C8CTvTt2WDo0NIquufWOBwKp71XYqr2TQxAhrgH7AGT34eal3zWHs3Z
        440UbkvqLWC8YnlQ83CBxN/+M1x/t4HM7ymGURqVRrayjzMvbuvW8LhjZsooqLTMprijx4
        4VqO/EYXBmOqLJ2+Xq35ysBukCoUqG0=
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id DEA7B2C142;
        Tue, 26 Sep 2023 18:50:54 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 82B72DA832; Tue, 26 Sep 2023 20:44:18 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 1/2] btrfs: add specific helper for range bit test exists
Date:   Tue, 26 Sep 2023 20:44:18 +0200
Message-ID: <a1e1f3d2e46d0e80e770cd91ec29a88fd9e0702b.1695753339.git.dsterba@suse.com>
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

The existing helper test_range_bit works in two ways, checks if the whole
range contains all the bits, or stop on the first occurrence.  By adding
a specific helper for the latter case, the inner loop can be simplified
and contains fewer conditionals, making it a bit faster.

There's no caller that uses the cached state pointer so this reduces the
argument count further.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/defrag.c         |  4 ++--
 fs/btrfs/extent-io-tree.c | 31 +++++++++++++++++++++++++++++++
 fs/btrfs/extent-io-tree.h |  1 +
 fs/btrfs/extent_io.c      |  8 ++++----
 fs/btrfs/inode.c          |  6 ++----
 5 files changed, 40 insertions(+), 10 deletions(-)

diff --git a/fs/btrfs/defrag.c b/fs/btrfs/defrag.c
index dde70f358d6f..7e379987f76a 100644
--- a/fs/btrfs/defrag.c
+++ b/fs/btrfs/defrag.c
@@ -930,8 +930,8 @@ static int defrag_collect_targets(struct btrfs_inode *inode,
 		 *    very likely resulting in a larger extent after writeback is
 		 *    triggered (except in a case of free space fragmentation).
 		 */
-		if (test_range_bit(&inode->io_tree, cur, cur + range_len - 1,
-				   EXTENT_DELALLOC, 0, NULL))
+		if (test_range_bit_exists(&inode->io_tree, cur, cur + range_len - 1,
+					  EXTENT_DELALLOC))
 			goto next;
 
 		/*
diff --git a/fs/btrfs/extent-io-tree.c b/fs/btrfs/extent-io-tree.c
index ff8e117a1ace..02414cc86def 100644
--- a/fs/btrfs/extent-io-tree.c
+++ b/fs/btrfs/extent-io-tree.c
@@ -1639,6 +1639,37 @@ u64 count_range_bits(struct extent_io_tree *tree,
 	return total_bytes;
 }
 
+/*
+ * Check if the single @bit exists in the given range.
+ */
+bool test_range_bit_exists(struct extent_io_tree *tree, u64 start, u64 end, u32 bit)
+{
+	struct extent_state *state = NULL;
+	bool bitset = false;
+
+	ASSERT(is_power_of_2(bit));
+
+	spin_lock(&tree->lock);
+	state = tree_search(tree, start);
+	while (state && start <= end) {
+		if (state->start > end)
+			break;
+
+		if (state->state & bit) {
+			bitset = true;
+			break;
+		}
+
+		/* If state->end is (u64)-1, start will overflow to 0 */
+		start = state->end + 1;
+		if (start > end || start == 0)
+			break;
+		state = next_state(state);
+	}
+	spin_unlock(&tree->lock);
+	return bitset;
+}
+
 /*
  * Search a range in the state tree for a given mask.  If 'filled' == 1, this
  * returns 1 only if every extent in the tree has the bits set.  Otherwise, 1
diff --git a/fs/btrfs/extent-io-tree.h b/fs/btrfs/extent-io-tree.h
index 28c23a23d121..336b7e8c0f86 100644
--- a/fs/btrfs/extent-io-tree.h
+++ b/fs/btrfs/extent-io-tree.h
@@ -133,6 +133,7 @@ u64 count_range_bits(struct extent_io_tree *tree,
 void free_extent_state(struct extent_state *state);
 int test_range_bit(struct extent_io_tree *tree, u64 start, u64 end,
 		   u32 bits, int filled, struct extent_state *cached_state);
+bool test_range_bit_exists(struct extent_io_tree *tree, u64 start, u64 end, u32 bit);
 int clear_record_extent_bits(struct extent_io_tree *tree, u64 start, u64 end,
 			     u32 bits, struct extent_changeset *changeset);
 int __clear_extent_bit(struct extent_io_tree *tree, u64 start, u64 end,
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 5e5852a4ffb5..ffd0be61ef77 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -2293,7 +2293,7 @@ static int try_release_extent_state(struct extent_io_tree *tree,
 	u64 end = start + PAGE_SIZE - 1;
 	int ret = 1;
 
-	if (test_range_bit(tree, start, end, EXTENT_LOCKED, 0, NULL)) {
+	if (test_range_bit_exists(tree, start, end, EXTENT_LOCKED)) {
 		ret = 0;
 	} else {
 		u32 clear_bits = ~(EXTENT_LOCKED | EXTENT_NODATASUM |
@@ -2352,9 +2352,9 @@ int try_release_extent_mapping(struct page *page, gfp_t mask)
 				free_extent_map(em);
 				break;
 			}
-			if (test_range_bit(tree, em->start,
-					   extent_map_end(em) - 1,
-					   EXTENT_LOCKED, 0, NULL))
+			if (test_range_bit_exists(tree, em->start,
+						  extent_map_end(em) - 1,
+						  EXTENT_LOCKED))
 				goto next;
 			/*
 			 * If it's not in the list of modified extents, used
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 780537abeba7..0f14f85111f7 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -2239,8 +2239,7 @@ static bool should_nocow(struct btrfs_inode *inode, u64 start, u64 end)
 {
 	if (inode->flags & (BTRFS_INODE_NODATACOW | BTRFS_INODE_PREALLOC)) {
 		if (inode->defrag_bytes &&
-		    test_range_bit(&inode->io_tree, start, end, EXTENT_DEFRAG,
-				   0, NULL))
+		    test_range_bit_exists(&inode->io_tree, start, end, EXTENT_DEFRAG))
 			return false;
 		return true;
 	}
@@ -7110,8 +7109,7 @@ noinline int can_nocow_extent(struct inode *inode, u64 offset, u64 *len,
 
 		range_end = round_up(offset + nocow_args.num_bytes,
 				     root->fs_info->sectorsize) - 1;
-		ret = test_range_bit(io_tree, offset, range_end,
-				     EXTENT_DELALLOC, 0, NULL);
+		ret = test_range_bit_exists(io_tree, offset, range_end, EXTENT_DELALLOC);
 		if (ret) {
 			ret = -EAGAIN;
 			goto out;
-- 
2.41.0

