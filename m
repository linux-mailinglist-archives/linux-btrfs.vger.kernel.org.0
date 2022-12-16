Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 088CE64E4F6
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 Dec 2022 01:07:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229825AbiLPAGr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 15 Dec 2022 19:06:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229708AbiLPAGo (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 15 Dec 2022 19:06:44 -0500
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D22F25C0E7
        for <linux-btrfs@vger.kernel.org>; Thu, 15 Dec 2022 16:06:42 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 4D2D15C0061;
        Thu, 15 Dec 2022 19:06:42 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Thu, 15 Dec 2022 19:06:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
        :content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1671149202; x=1671235602; bh=xz
        dQfU2rSWFVszHRK3ZyUJTN+oxT/IAyAjcpGPsapI0=; b=sWlNilxEVi0Kn4ozsf
        RfqgFBwhIV4lY5qjua+KZBGZwF/QBVvYO3AjJScdfN6ywkJQykgj1lf/9M+U9B8D
        4utDWu27mp84vSyJuIVbK4adVVsli8Y9idGAKAVNGJ1J3oDbpKZqNeOtTdyq32O0
        dCVjD9k18L/pPWCnY5ygZ3EpCi99C5r594WfzL4nK1ZGGOoGe0VEhimRdnE3Lb7u
        RRCgsMVnqYfcGUKkIlAVF7qALG4qR3hSHVzqcAAFzaWT06cTkE+Sq6jfe4b+Udcn
        xZBijlsY1TCA+JciFwm2ni+D8yriMYIjfMlRkI0Paq9YOnKkACVxG1rb+MSGQ3kc
        l5CQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1671149202; x=1671235602; bh=xzdQfU2rSWFVs
        zHRK3ZyUJTN+oxT/IAyAjcpGPsapI0=; b=S+fTYhWOYfVGPA38Gkvuy+YZrHpM1
        G2/+s+SjWfgpwYaiecd+C0lNR11C5zYlZ1+1s+vnip0ZkwUlySA/stDEmgC0WNWC
        JAxMrTVDHDIeKU46ETLHVlKLEzXu1XLFxJn6yk2H6Guifa63K2MRU4KVfDxfstXr
        ys0kG5d6KguifUEUiLSiQFhemPI9tgL+Cc85iCPB5nCLQF8suWYraIczD1xT5cwu
        WWnbcdh3/B9dn8lisKOifh7+RDLV+3JpHVQjOkzbu6Mu8hIblraDrhG544b7Flpx
        MVVnOlwjdPkySeBk8W28cUd/hDl90tyK9QKBRCb+pVufPsWhALkq/hZ4w==
X-ME-Sender: <xms:krabYx0nyfwLC2SyiNpzsVJbZRoMveHL-LgO0u-rpL1wNwCteKpoGQ>
    <xme:krabY4HRe9eslH0eF66HQawX8Y1TX3AJGKNpAI68RvE04mucIYkwkXdPvV7EXOGI_
    vQfKCmdevfagdZxmO4>
X-ME-Received: <xmr:krabYx5yPvazd60Us8Ici4BgwuuW7Ij9Hlef1Pv7z0-WI7aZTqiSIryZ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeeigdduhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtkeertd
    ertddtnecuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhi
    oheqnecuggftrfgrthhtvghrnhepkeekteffteefvedtvedtudethefgtedvjeffueeuhe
    ekvdeftdelieejjeegudejnecuffhomhgrihhnpehgihhthhhusgdrtghomhdpsghurhdr
    ihhonecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsg
    horhhishessghurhdrihho
X-ME-Proxy: <xmx:krabY-32qG-luj1Ux0rNbEnXmjq-Gr-Uao8hfiFSX9lIG12Q5kBCTQ>
    <xmx:krabY0HVib2bEZdoad1Cd3KjuD_upCfEzQ6z8_Nm1wE6xZEx34zpog>
    <xmx:krabY__OGgBq9t595xjNXT_ecSsOWR2KgYXSfph-g4EWP6LbLe4TEQ>
    <xmx:krabY_N0kM9ABgWtWUvibfTpOuOi4eAb1ItCOyXB2pShy8AS9euLUg>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 15 Dec 2022 19:06:41 -0500 (EST)
From:   Boris Burkov <boris@bur.io>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v4 3/5] btrfs: introduce size class to block group allocator
Date:   Thu, 15 Dec 2022 16:06:33 -0800
Message-Id: <6f1b902d4284c1139caf7abbbc32c85960a0f2d5.1671149056.git.boris@bur.io>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <cover.1671149056.git.boris@bur.io>
References: <cover.1671149056.git.boris@bur.io>
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
https://bur.io/fsperf/size-class-2022-11-15.txt
(there are ansi escape codes, so best to curl and view in terminal)

Here is a snippet from the full results for a new test which mixes
buffered writes appending to a long lived set of files and large short
lived fallocates:

bufferedappendvsfallocate results
         metric             baseline       current        stdev            diff
======================================================================================
avg_commit_ms                    31.13         29.20          2.67     -6.22%
bg_count                            14         15.60             0     11.43%
commits                          11.10         12.20          0.32      9.91%
elapsed                          27.30         26.40          2.98     -3.30%
end_state_mount_ns         11122551.90   10635118.90     851143.04     -4.38%
end_state_umount_ns           1.36e+09      1.35e+09   12248056.65     -1.07%
find_free_extent_calls       116244.30     114354.30        964.56     -1.63%
find_free_extent_ns_max      599507.20    1047168.20     103337.08     74.67%
find_free_extent_ns_mean       3607.19       3672.11        101.20      1.80%
find_free_extent_ns_min            500           512          6.67      2.40%
find_free_extent_ns_p50           2848          2876         37.65      0.98%
find_free_extent_ns_p95           4916          5000         75.45      1.71%
find_free_extent_ns_p99       20734.49      20920.48       1670.93      0.90%
frag_pct_max                     61.67             0          8.05   -100.00%
frag_pct_mean                    43.59             0          6.10   -100.00%
frag_pct_min                     25.91             0         16.60   -100.00%
frag_pct_p50                     42.53             0          7.25   -100.00%
frag_pct_p95                     61.67             0          8.05   -100.00%
frag_pct_p99                     61.67             0          8.05   -100.00%
fragmented_bg_count               6.10             0          1.45   -100.00%
max_commit_ms                    49.80            46          5.37     -7.63%
sys_cpu                           2.59          2.62          0.29      1.39%
write_bw_bytes                1.62e+08      1.68e+08   17975843.50      3.23%
write_clat_ns_mean            57426.39      54475.95       2292.72     -5.14%
write_clat_ns_p50             46950.40      42905.60       2101.35     -8.62%
write_clat_ns_p99            148070.40     143769.60       2115.17     -2.90%
write_io_kbytes                4194304       4194304             0      0.00%
write_iops                     2476.15       2556.10        274.29      3.23%
write_lat_ns_max            2101667.60    2251129.50     370556.59      7.11%
write_lat_ns_mean             59374.91      55682.00       2523.09     -6.22%
write_lat_ns_min              17353.10         16250       1646.08     -6.36%

There are some mixed improvements/regressions in most metrics along with
an elimination of fragmentation in this workload.

On the balance, the drastic 1->0 improvement in the happy cases seems
worth the mix of regressions and improvements we do observe.

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
index 708d843daa72..fa1ab56fe6b3 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 
+#include "linux/sizes.h"
 #include <linux/list_sort.h>
 #include "misc.h"
 #include "ctree.h"
@@ -3379,6 +3380,7 @@ int btrfs_update_block_group(struct btrfs_trans_handle *trans,
 			cache->space_info->disk_used -= num_bytes * factor;
 
 			reclaim = should_reclaim_block_group(cache, num_bytes);
+
 			spin_unlock(&cache->lock);
 			spin_unlock(&cache->space_info->lock);
 
@@ -3433,32 +3435,42 @@ int btrfs_update_block_group(struct btrfs_trans_handle *trans,
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
@@ -4218,3 +4230,63 @@ void btrfs_dec_block_group_swap_extents(struct btrfs_block_group *bg, int amount
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
index a02ea76fd6cf..aaf5ca49defb 100644
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
@@ -233,6 +240,7 @@ struct btrfs_block_group {
 	struct list_head active_bg_list;
 	struct work_struct zone_finish_work;
 	struct extent_buffer *last_eb;
+	enum btrfs_block_group_size_class size_class;
 };
 
 static inline u64 btrfs_block_group_end(struct btrfs_block_group *block_group)
@@ -302,7 +310,8 @@ int btrfs_setup_space_cache(struct btrfs_trans_handle *trans);
 int btrfs_update_block_group(struct btrfs_trans_handle *trans,
 			     u64 bytenr, u64 num_bytes, bool alloc);
 int btrfs_add_reserved_bytes(struct btrfs_block_group *cache,
-			     u64 ram_bytes, u64 num_bytes, int delalloc);
+			     u64 ram_bytes, u64 num_bytes, int delalloc,
+			     bool force_wrong_size_class);
 void btrfs_free_reserved_bytes(struct btrfs_block_group *cache,
 			       u64 num_bytes, int delalloc);
 int btrfs_chunk_alloc(struct btrfs_trans_handle *trans, u64 flags,
@@ -346,4 +355,8 @@ void btrfs_unfreeze_block_group(struct btrfs_block_group *cache);
 bool btrfs_inc_block_group_swap_extents(struct btrfs_block_group *bg);
 void btrfs_dec_block_group_swap_extents(struct btrfs_block_group *bg, int amount);
 
+enum btrfs_block_group_size_class btrfs_calc_block_group_size_class(u64 size);
+int btrfs_use_block_group_size_class(struct btrfs_block_group *bg,
+				     enum btrfs_block_group_size_class size_class,
+				     bool force_wrong_size_class);
 #endif /* BTRFS_BLOCK_GROUP_H */
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 4f5cbdfc0fe5..f39d9117c8db 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -3382,7 +3382,9 @@ int btrfs_free_extent(struct btrfs_trans_handle *trans, struct btrfs_ref *ref)
 enum btrfs_loop_type {
 	LOOP_CACHING_NOWAIT,
 	LOOP_CACHING_WAIT,
+	LOOP_UNSET_SIZE_CLASS,
 	LOOP_ALLOC_CHUNK,
+	LOOP_WRONG_SIZE_CLASS,
 	LOOP_NO_EMPTY_SIZE,
 };
 
@@ -3947,24 +3949,6 @@ static int can_allocate_chunk(struct btrfs_fs_info *fs_info,
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
@@ -3998,31 +3982,28 @@ static int find_free_extent_update_loop(struct btrfs_fs_info *fs_info,
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
@@ -4042,8 +4023,10 @@ static int find_free_extent_update_loop(struct btrfs_fs_info *fs_info,
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
@@ -4073,6 +4056,21 @@ static int find_free_extent_update_loop(struct btrfs_fs_info *fs_info,
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
@@ -4207,6 +4205,7 @@ static noinline int find_free_extent(struct btrfs_root *root,
 	ffe_ctl->total_free_space = 0;
 	ffe_ctl->found_offset = 0;
 	ffe_ctl->policy = BTRFS_EXTENT_ALLOC_CLUSTERED;
+	ffe_ctl->size_class = btrfs_calc_block_group_size_class(ffe_ctl->num_bytes);
 
 	if (btrfs_is_zoned(fs_info))
 		ffe_ctl->policy = BTRFS_EXTENT_ALLOC_ZONED;
@@ -4343,6 +4342,9 @@ static noinline int find_free_extent(struct btrfs_root *root,
 		if (unlikely(block_group->cached == BTRFS_CACHE_ERROR))
 			goto loop;
 
+		if (!find_free_extent_check_size_class(ffe_ctl, block_group))
+			goto loop;
+
 		bg_ret = NULL;
 		ret = do_allocation(block_group, ffe_ctl, &bg_ret);
 		if (ret == 0) {
@@ -4377,7 +4379,8 @@ static noinline int find_free_extent(struct btrfs_root *root,
 
 		ret = btrfs_add_reserved_bytes(block_group, ffe_ctl->ram_bytes,
 					       ffe_ctl->num_bytes,
-					       ffe_ctl->delalloc);
+					       ffe_ctl->delalloc,
+					       ffe_ctl->loop >= LOOP_WRONG_SIZE_CLASS);
 		if (ret == -EAGAIN) {
 			btrfs_add_free_space_unused(block_group,
 					ffe_ctl->found_offset,
diff --git a/fs/btrfs/extent-tree.h b/fs/btrfs/extent-tree.h
index 14a697bed422..429d5c570061 100644
--- a/fs/btrfs/extent-tree.h
+++ b/fs/btrfs/extent-tree.h
@@ -79,6 +79,9 @@ struct find_free_extent_ctl {
 
 	/* Whether or not the allocator is currently following a hint */
 	bool hinted;
+
+	/* Size class of block groups to prefer in early loops */
+	enum btrfs_block_group_size_class size_class;
 };
 
 enum btrfs_inline_ref_type {
diff --git a/include/trace/events/btrfs.h b/include/trace/events/btrfs.h
index 48cb0025313a..f7a513f2891b 100644
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
2.38.1

