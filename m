Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EBFC5F5ABE
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Oct 2022 21:49:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230495AbiJETtk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 5 Oct 2022 15:49:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230476AbiJETtj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 5 Oct 2022 15:49:39 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7AA37F246
        for <linux-btrfs@vger.kernel.org>; Wed,  5 Oct 2022 12:49:31 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 2CB135C00A3;
        Wed,  5 Oct 2022 15:49:31 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Wed, 05 Oct 2022 15:49:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
        :content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1664999371; x=1665085771; bh=LU
        bpPjaeocUTtwGMjPaXdCryHa2KfojK4IcZ/nNn+WQ=; b=fVzpOR4KfC4HzGe5hh
        72oVIlF9zTiCOM1WlKI/doHT2KHL+ecggy3efOQV28ORSrrYa2zjKuTW/qj/cPCf
        kZGcuDjjIxpesRqOFdfilnmJQ6MvpfPTwLHXHE+rr5MMEoubAmaVpIHydfruECLS
        2AuAztEmW9I0tyi4eaqIBx2a5JQ1l9XKdTwulbC8zhRuVvUfs0CdMDwNPX59rPPk
        UIR8DrHmqnXh+AO78XvFprl90vjL5Nvwt2VJprEIay+tZEzVEudQuvyb2CUb4iN4
        LIk/nC8iVnK/u6RYep2VOZKEVBdU51hHyXOP9pYCedBifsun40pLgX10sfnhU38e
        SULQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1664999371; x=1665085771; bh=LUbpPjaeocUTt
        wGMjPaXdCryHa2KfojK4IcZ/nNn+WQ=; b=hw7HQozGe2a6NFfmbjkR8mwljhA6y
        6e6qkvsrjaUJsOy7y/oOi30C5UaAlnhwuc1LLEIRz9lEfiqzK99YrSo6btr0uODV
        NjEc6xVGvirbzcMQbG9s2SXsZqYJQZt46KoarJN11nYy0UED6Hbw4g7AEMHJ+zC8
        AHurUAbW+5aS12RVvQZN7229wtVmh34qi/Wb0nTodu1W/y4bZcORhVAOKbo7J0y/
        fIBV9jPeBnm65Da9WY7hd6GHJlqMY8VdfCLWIEodE+7ZZiOudgsrxpX6v7CUHObx
        66yhj0KSPyL8xb3qbKA24+MN3vFGUa9rJSJgh6ih7No4rWBkQjJIGUGDQ==
X-ME-Sender: <xms:y989Yyt_kzf_wAIi5j_HMRRTP4aI7YUwg1LZvZBNkcmUeyx_FnCIng>
    <xme:y989Y3fjp_sLB-LrCUZjyTPp4pQVWcuVhErRrvFNhbKUsByuHrmin33-sfpEiIdEe
    G5-XZsczRY_MNnCKgg>
X-ME-Received: <xmr:y989Y9wb7dcZRHcdFhGJAUb9q3exAWJpqSF-PSzB3kn5a_xIro1J0x5UVKugGu8589XZ9efMaDloJNP4zGQyKvwaE9J-Ow>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfeeifedgudegudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhr
    rdhioheqnecuggftrfgrthhtvghrnhepkeekteffteefvedtvedtudethefgtedvjeffue
    euheekvdeftdelieejjeegudejnecuffhomhgrihhnpehgihhthhhusgdrtghomhdpsghu
    rhdrihhonecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epsghorhhishessghurhdrihho
X-ME-Proxy: <xmx:y989Y9Pwr7IKMuf2nw0H_WhS0Oywc-fzbI0T9vZ-kGqLSgy1rWrKIw>
    <xmx:y989Yy_gDmAK1nmsBbmAM12lqpv8TO90krhjAslqo3IyeaX_KNNd5w>
    <xmx:y989Y1VK-jFnkV2gnjxGLhiFWaDGcaASWV-3VCiXCu3I0wqm2op6bQ>
    <xmx:y989Y3FY9-yw11Ck28kk6oR8tK40Yldt_Wr89MTFD-kYuRNoWc4-nQ>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 5 Oct 2022 15:49:30 -0400 (EDT)
From:   Boris Burkov <boris@bur.io>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 4/5] btrfs: introduce size class to block group allocator
Date:   Wed,  5 Oct 2022 12:49:21 -0700
Message-Id: <f3081d544ff0b5c3670442815a033553e20dd2ad.1664999303.git.boris@bur.io>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <cover.1664999303.git.boris@bur.io>
References: <cover.1664999303.git.boris@bur.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The aim of this patch is to reduce the fragmentation of block groups
under certain unhappy workloads. It is particularly effective when the
size of extents correlates with their lifetime, which is something we
have observed causing fragmentation in the fleet at Meta.

This patch categorizes extents into size classes:
x < 128KiB: "small"
128KiB < x < 8MiB: "medium"
x > 8MiB: "large"
and as much as possible reduces allocations of extents into block groups
that don't match the size class. This takes advantage of any (possible)
correlation between size and lifetime and also leaves behind predictable
re-usable gaps when extents are freed; small writes don't gum up bigger
holes.

Size classes are implemented in the following way:
- Mark each new block group with a size class of the first allocation
  that goes into it.

- Add two new passes to ffe: "unset size class" and "wrong size class".
  First, try only matching block groups, then try unset ones, then allow
  allocation of new ones, and finally allow mismatched block groups.

- Filtering is done just by skipping inappropriate ones, there is no
  special size class indexing.

Other solutions I considered were:
- A best fit allocator with an rb-tree. This worked well, as small
  writes didn't leak big holes from large freed extents, but led to
  regressions in ffe and write performance due to lock contention on
  the rb-tree with every allocation possibly updating it in parallel.
  Perhaps something clever could be done to do the updates in the
  background while being "right enough".

- A fixed size "working set". This prevents freeing an extent
  drastically changing where writes currently land, and seems like a
  good option too. Doesn't take advantage of size in any way.

- The same size class idea, but implemented with xarray marks. This
  turned out to be slower than looping the linked list and skipping
  wrong block groups, and is also less flexible since we must have only
  3 size classes (max #marks). With the current approach we can have as
  many as we like.

Performance testing was done via:
https://github.com/josefbacik/fsperf
Of particular relevance are the new fragmentation specific tests.

A brief summary of the testing results:
- Neutral results on existing tests. There are some minor regressions
  and improvements here and there, but nothing that truly stands out as
  notable.
- Improvement on new tests where size class and extent lifetime are
  correlated. Fragmentation in these cases is completely eliminated
  and write performance is generally a little better. There is also
  significant improvement where extent sizes are just a bit larger than
  the size class boundaries.
- Regression on one new tests: where the allocations are sized
  intentionally a hair under the borders of the size classes. Results
  are neutral on the test that intentionally attacks this new scheme by
  mixing extent size and lifetime.

The full dump of the performance results can be found here:
https://bur.io/fsperf/size-class-2022-10-04.txt
(there are ansi escape codes, so best to curl and view in terminal)

On the balance, the drastic 1->0 improvement in the happy cases seems
worth the regressions we do observe.

Some considerations for future work:
- Experimenting with more size classes
- More hinting/search ordering work to approximate a best-fit allocator

Signed-off-by: Boris Burkov <boris@bur.io>
---
 fs/btrfs/block-group.c       | 104 +++++++++++++++++++++++++++++------
 fs/btrfs/block-group.h       |  15 ++++-
 fs/btrfs/extent-tree.c       |  71 ++++++++++++------------
 fs/btrfs/extent-tree.h       |   3 +
 include/trace/events/btrfs.h |  10 +++-
 5 files changed, 150 insertions(+), 53 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 32c415cfbdfe..d16a982aa593 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 
+#include "linux/sizes.h"
 #include <linux/list_sort.h>
 #include "misc.h"
 #include "ctree.h"
@@ -3309,6 +3310,7 @@ int btrfs_update_block_group(struct btrfs_trans_handle *trans,
 			cache->space_info->disk_used -= num_bytes * factor;
 
 			reclaim = should_reclaim_block_group(cache, num_bytes);
+
 			spin_unlock(&cache->lock);
 			spin_unlock(&cache->space_info->lock);
 
@@ -3362,32 +3364,42 @@ int btrfs_update_block_group(struct btrfs_trans_handle *trans,
  * reservation and return -EAGAIN, otherwise this function always succeeds.
  */
 int btrfs_add_reserved_bytes(struct btrfs_block_group *cache,
-			     u64 ram_bytes, u64 num_bytes, int delalloc)
+			     u64 ram_bytes, u64 num_bytes, int delalloc,
+			     bool force_wrong_size_class)
 {
 	struct btrfs_space_info *space_info = cache->space_info;
+	enum btrfs_block_group_size_class size_class;
 	int ret = 0;
 
 	spin_lock(&space_info->lock);
 	spin_lock(&cache->lock);
 	if (cache->ro) {
 		ret = -EAGAIN;
-	} else {
-		cache->reserved += num_bytes;
-		space_info->bytes_reserved += num_bytes;
-		trace_btrfs_space_reservation(cache->fs_info, "space_info",
-					      space_info->flags, num_bytes, 1);
-		btrfs_space_info_update_bytes_may_use(cache->fs_info,
-						      space_info, -ram_bytes);
-		if (delalloc)
-			cache->delalloc_bytes += num_bytes;
+		goto out;
+	}
 
-		/*
-		 * Compression can use less space than we reserved, so wake
-		 * tickets if that happens
-		 */
-		if (num_bytes < ram_bytes)
-			btrfs_try_granting_tickets(cache->fs_info, space_info);
+	if (btrfs_is_block_group_data_only(cache)) {
+		size_class = btrfs_calc_block_group_size_class(num_bytes);
+		ret = btrfs_use_block_group_size_class(cache, size_class, force_wrong_size_class);
+		if (ret)
+			goto out;
 	}
+	cache->reserved += num_bytes;
+	space_info->bytes_reserved += num_bytes;
+	trace_btrfs_space_reservation(cache->fs_info, "space_info",
+				      space_info->flags, num_bytes, 1);
+	btrfs_space_info_update_bytes_may_use(cache->fs_info,
+					      space_info, -ram_bytes);
+	if (delalloc)
+		cache->delalloc_bytes += num_bytes;
+
+	/*
+	 * Compression can use less space than we reserved, so wake
+	 * tickets if that happens
+	 */
+	if (num_bytes < ram_bytes)
+		btrfs_try_granting_tickets(cache->fs_info, space_info);
+out:
 	spin_unlock(&cache->lock);
 	spin_unlock(&space_info->lock);
 	return ret;
@@ -4146,3 +4158,63 @@ void btrfs_dec_block_group_swap_extents(struct btrfs_block_group *bg, int amount
 	bg->swap_extents -= amount;
 	spin_unlock(&bg->lock);
 }
+
+enum btrfs_block_group_size_class btrfs_calc_block_group_size_class(u64 size)
+{
+	if (size <= SZ_128K)
+		return BTRFS_BG_SZ_SMALL;
+	if (size <= SZ_8M)
+		return BTRFS_BG_SZ_MEDIUM;
+	return BTRFS_BG_SZ_LARGE;
+}
+
+/*
+ * Handle a block group allocating an extent in a size class
+ *
+ * @bg:				The block group we allocated in.
+ * @size_class:			The size class of the allocation.
+ * @force_wrong_size_class:	Whether we are desperate enough to allow
+ *				mismatched size classes.
+ *
+ * Returns: 0 if the size class was valid for this block_group, -EAGAIN in the
+ * case of a race that leads to the wrong size class without
+ * force_wrong_size_class set.
+ *
+ * find_free_extent will skip block groups with a mismatched size class until
+ * it really needs to avoid ENOSPC. In that case it will set
+ * force_wrong_size_class. However, if a block group is newly allocated and
+ * doesn't yet have a size class, then it is possible for two allocations of
+ * different sizes to race and both try to use it. The loser is caught here and
+ * has to retry.
+ */
+int btrfs_use_block_group_size_class(struct btrfs_block_group *bg,
+				     enum btrfs_block_group_size_class size_class,
+				     bool force_wrong_size_class)
+{
+	ASSERT(size_class != BTRFS_BG_SZ_NONE);
+
+	/* The new allocation is in the right size class, do nothing */
+	if (bg->size_class == size_class)
+		return 0;
+	/*
+	 * The new allocation is in a mismatched size class.
+	 * This means one of two things:
+	 * 1. Two tasks in find_free_extent for different size_classes raced
+	 *    and hit the same empty block_group. Make the loser try again.
+	 * 2. A call to find_free_extent got desperate enough to set
+	 *    'force_wrong_slab'. Don't change the size_class, but allow the
+	 *    allocation.
+	 */
+	if (bg->size_class != BTRFS_BG_SZ_NONE) {
+		if (force_wrong_size_class)
+			return 0;
+		return -EAGAIN;
+	}
+	/*
+	 * The happy new block group case: the new allocation is the first
+	 * one in the block_group so we set size_class.
+	 */
+	bg->size_class = size_class;
+
+	return 0;
+}
diff --git a/fs/btrfs/block-group.h b/fs/btrfs/block-group.h
index 8fb14b99a1d1..650a066c03d5 100644
--- a/fs/btrfs/block-group.h
+++ b/fs/btrfs/block-group.h
@@ -12,6 +12,13 @@ enum btrfs_disk_cache_state {
 	BTRFS_DC_SETUP,
 };
 
+enum btrfs_block_group_size_class {
+	BTRFS_BG_SZ_NONE,	/* unset		*/
+	BTRFS_BG_SZ_SMALL,	/* 0 < sz <= 128K	*/
+	BTRFS_BG_SZ_MEDIUM,	/* 128K < sz <= 8M	*/
+	BTRFS_BG_SZ_LARGE,	/* 8M < sz < BG_LEN	*/
+};
+
 /*
  * This describes the state of the block_group for async discard.  This is due
  * to the two pass nature of it where extent discarding is prioritized over
@@ -232,6 +239,7 @@ struct btrfs_block_group {
 	struct list_head active_bg_list;
 	struct work_struct zone_finish_work;
 	struct extent_buffer *last_eb;
+	enum btrfs_block_group_size_class size_class;
 };
 
 static inline u64 btrfs_block_group_end(struct btrfs_block_group *block_group)
@@ -310,7 +318,8 @@ int btrfs_setup_space_cache(struct btrfs_trans_handle *trans);
 int btrfs_update_block_group(struct btrfs_trans_handle *trans,
 			     u64 bytenr, u64 num_bytes, bool alloc);
 int btrfs_add_reserved_bytes(struct btrfs_block_group *cache,
-			     u64 ram_bytes, u64 num_bytes, int delalloc);
+			     u64 ram_bytes, u64 num_bytes, int delalloc,
+			     bool force_wrong_size_class);
 void btrfs_free_reserved_bytes(struct btrfs_block_group *cache,
 			       u64 num_bytes, int delalloc);
 int btrfs_chunk_alloc(struct btrfs_trans_handle *trans, u64 flags,
@@ -354,4 +363,8 @@ void btrfs_unfreeze_block_group(struct btrfs_block_group *cache);
 bool btrfs_inc_block_group_swap_extents(struct btrfs_block_group *bg);
 void btrfs_dec_block_group_swap_extents(struct btrfs_block_group *bg, int amount);
 
+enum btrfs_block_group_size_class btrfs_calc_block_group_size_class(u64 size);
+int btrfs_use_block_group_size_class(struct btrfs_block_group *bg,
+				     enum btrfs_block_group_size_class size_class,
+				     bool force_wrong_size_class);
 #endif /* BTRFS_BLOCK_GROUP_H */
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 069761529398..63219887f534 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -3373,7 +3373,9 @@ int btrfs_free_extent(struct btrfs_trans_handle *trans, struct btrfs_ref *ref)
 enum btrfs_loop_type {
 	LOOP_CACHING_NOWAIT,
 	LOOP_CACHING_WAIT,
+	LOOP_UNSET_SIZE_CLASS,
 	LOOP_ALLOC_CHUNK,
+	LOOP_WRONG_SIZE_CLASS,
 	LOOP_NO_EMPTY_SIZE,
 };
 
@@ -3938,24 +3940,6 @@ static int can_allocate_chunk(struct btrfs_fs_info *fs_info,
 	}
 }
 
-static int chunk_allocation_failed(struct find_free_extent_ctl *ffe_ctl)
-{
-	switch (ffe_ctl->policy) {
-	case BTRFS_EXTENT_ALLOC_CLUSTERED:
-		/*
-		 * If we can't allocate a new chunk we've already looped through
-		 * at least once, move on to the NO_EMPTY_SIZE case.
-		 */
-		ffe_ctl->loop = LOOP_NO_EMPTY_SIZE;
-		return 0;
-	case BTRFS_EXTENT_ALLOC_ZONED:
-		/* Give up here */
-		return -ENOSPC;
-	default:
-		BUG();
-	}
-}
-
 /*
  * Return >0 means caller needs to re-search for free extent
  * Return 0 means we have the needed free extent.
@@ -3989,31 +3973,28 @@ static int find_free_extent_update_loop(struct btrfs_fs_info *fs_info,
 	 * LOOP_CACHING_NOWAIT, search partially cached block groups, kicking
 	 *			caching kthreads as we move along
 	 * LOOP_CACHING_WAIT, search everything, and wait if our bg is caching
+	 * LOOP_UNSET_SIZE_CLASS, allow unset size class
 	 * LOOP_ALLOC_CHUNK, force a chunk allocation and try again
 	 * LOOP_NO_EMPTY_SIZE, set empty_size and empty_cluster to 0 and try
 	 *		       again
 	 */
 	if (ffe_ctl->loop < LOOP_NO_EMPTY_SIZE) {
 		ffe_ctl->index = 0;
-		if (ffe_ctl->loop == LOOP_CACHING_NOWAIT) {
-			/*
-			 * We want to skip the LOOP_CACHING_WAIT step if we
-			 * don't have any uncached bgs and we've already done a
-			 * full search through.
-			 */
-			if (ffe_ctl->orig_have_caching_bg || !full_search)
-				ffe_ctl->loop = LOOP_CACHING_WAIT;
-			else
-				ffe_ctl->loop = LOOP_ALLOC_CHUNK;
-		} else {
+		/*
+		 * We want to skip the LOOP_CACHING_WAIT step if we
+		 * don't have any uncached bgs and we've already done a
+		 * full search through.
+		 */
+		if (ffe_ctl->loop == LOOP_CACHING_NOWAIT &&
+		    (!ffe_ctl->orig_have_caching_bg && full_search))
 			ffe_ctl->loop++;
-		}
+		ffe_ctl->loop++;
 
 		if (ffe_ctl->loop == LOOP_ALLOC_CHUNK) {
 			struct btrfs_trans_handle *trans;
 			int exist = 0;
 
-			/*Check if allocation policy allows to create a new chunk */
+			/* Check if allocation policy allows to create a new chunk */
 			ret = can_allocate_chunk(fs_info, ffe_ctl);
 			if (ret)
 				return ret;
@@ -4033,8 +4014,10 @@ static int find_free_extent_update_loop(struct btrfs_fs_info *fs_info,
 						CHUNK_ALLOC_FORCE_FOR_EXTENT);
 
 			/* Do not bail out on ENOSPC since we can do more. */
-			if (ret == -ENOSPC)
-				ret = chunk_allocation_failed(ffe_ctl);
+			if (ret == -ENOSPC) {
+				ret = 0;
+				ffe_ctl->loop++;
+			}
 			else if (ret < 0)
 				btrfs_abort_transaction(trans, ret);
 			else
@@ -4064,6 +4047,21 @@ static int find_free_extent_update_loop(struct btrfs_fs_info *fs_info,
 	return -ENOSPC;
 }
 
+static bool find_free_extent_check_size_class(struct find_free_extent_ctl *ffe_ctl,
+					      struct btrfs_block_group *bg)
+{
+	if (ffe_ctl->policy == BTRFS_EXTENT_ALLOC_ZONED)
+		return true;
+	if (!btrfs_is_block_group_data_only(bg))
+		return true;
+	if (ffe_ctl->loop >= LOOP_WRONG_SIZE_CLASS)
+		return true;
+	if (ffe_ctl->loop >= LOOP_UNSET_SIZE_CLASS &&
+	    bg->size_class == BTRFS_BG_SZ_NONE)
+		return true;
+	return ffe_ctl->size_class == bg->size_class;
+}
+
 static int prepare_allocation_clustered(struct btrfs_fs_info *fs_info,
 					struct find_free_extent_ctl *ffe_ctl,
 					struct btrfs_space_info *space_info,
@@ -4198,6 +4196,7 @@ static noinline int find_free_extent(struct btrfs_root *root,
 	ffe_ctl->total_free_space = 0;
 	ffe_ctl->found_offset = 0;
 	ffe_ctl->policy = BTRFS_EXTENT_ALLOC_CLUSTERED;
+	ffe_ctl->size_class = btrfs_calc_block_group_size_class(ffe_ctl->num_bytes);
 
 	if (btrfs_is_zoned(fs_info))
 		ffe_ctl->policy = BTRFS_EXTENT_ALLOC_ZONED;
@@ -4334,6 +4333,9 @@ static noinline int find_free_extent(struct btrfs_root *root,
 		if (unlikely(block_group->cached == BTRFS_CACHE_ERROR))
 			goto loop;
 
+		if (!find_free_extent_check_size_class(ffe_ctl, block_group))
+			goto loop;
+
 		bg_ret = NULL;
 		ret = do_allocation(block_group, ffe_ctl, &bg_ret);
 		if (ret == 0) {
@@ -4368,7 +4370,8 @@ static noinline int find_free_extent(struct btrfs_root *root,
 
 		ret = btrfs_add_reserved_bytes(block_group, ffe_ctl->ram_bytes,
 					       ffe_ctl->num_bytes,
-					       ffe_ctl->delalloc);
+					       ffe_ctl->delalloc,
+					       ffe_ctl->loop >= LOOP_WRONG_SIZE_CLASS);
 		if (ret == -EAGAIN) {
 			btrfs_add_free_space_unused(block_group,
 					ffe_ctl->found_offset,
diff --git a/fs/btrfs/extent-tree.h b/fs/btrfs/extent-tree.h
index 38bddb3ed224..a3e42e54e00b 100644
--- a/fs/btrfs/extent-tree.h
+++ b/fs/btrfs/extent-tree.h
@@ -78,6 +78,9 @@ struct find_free_extent_ctl {
 
 	/* Whether or not the allocator is currently following a hint */
 	bool hinted;
+
+	/* Size class of block groups to prefer in early loops */
+	enum btrfs_block_group_size_class size_class;
 };
 
 #endif /* BTRFS_EXTENT_TREE_H */
diff --git a/include/trace/events/btrfs.h b/include/trace/events/btrfs.h
index caf0ce6ce718..39ead38f7765 100644
--- a/include/trace/events/btrfs.h
+++ b/include/trace/events/btrfs.h
@@ -1351,28 +1351,34 @@ DECLARE_EVENT_CLASS(btrfs__reserve_extent,
 	TP_STRUCT__entry_btrfs(
 		__field(	u64,	bg_objectid		)
 		__field(	u64,	flags			)
+		__field(	int,	bg_size_class		)
 		__field(	u64,	start			)
 		__field(	u64,	len			)
 		__field(	u64,	loop			)
 		__field(	bool,	hinted			)
+		__field(	int,	size_class		)
 	),
 
 	TP_fast_assign_btrfs(block_group->fs_info,
 		__entry->bg_objectid	= block_group->start;
 		__entry->flags		= block_group->flags;
+		__entry->bg_size_class	= block_group->size_class;
 		__entry->start		= ffe_ctl->search_start;
 		__entry->len		= ffe_ctl->num_bytes;
 		__entry->loop		= ffe_ctl->loop;
 		__entry->hinted		= ffe_ctl->hinted;
+		__entry->size_class	= ffe_ctl->size_class;
 	),
 
 	TP_printk_btrfs("root=%llu(%s) block_group=%llu flags=%llu(%s) "
-			"start=%llu len=%llu loop=%llu hinted=%d",
+			"bg_size_class=%d start=%llu len=%llu loop=%llu "
+			"hinted=%d size_class=%d",
 		  show_root_type(BTRFS_EXTENT_TREE_OBJECTID),
 		  __entry->bg_objectid,
 		  __entry->flags, __print_flags((unsigned long)__entry->flags,
 						"|", BTRFS_GROUP_FLAGS),
-		  __entry->start, __entry->len, __entry->loop, __entry->hinted)
+		  __entry->bg_size_class, __entry->start, __entry->len,
+		  __entry->loop, __entry->hinted, __entry->size_class)
 );
 
 DEFINE_EVENT(btrfs__reserve_extent, btrfs_reserve_extent,
-- 
2.37.2

