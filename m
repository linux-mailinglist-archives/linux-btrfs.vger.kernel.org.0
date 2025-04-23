Return-Path: <linux-btrfs+bounces-13318-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F192A98CC9
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Apr 2025 16:22:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 42803188B8F3
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Apr 2025 14:21:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AD8A281356;
	Wed, 23 Apr 2025 14:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rCF/UpHY"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5026E281344
	for <linux-btrfs@vger.kernel.org>; Wed, 23 Apr 2025 14:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745418029; cv=none; b=GDSHIDuxHpVygHP+pzV1o38WnB1eoPssuWcC50IefPAH/FVouptqkapkhgbS8PcFi7jlBTwHcBY8f0Kp6InNryQevHdyIGCcFViw4isQaGNdcMNMnQ20y/2GQoPLRBZOMDx18Xvez04pHmrdDKpxYTAzAj8gFNjtsRGTAt5exx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745418029; c=relaxed/simple;
	bh=NG1mRXzaq11+5jzu6s7tURmYq+TwM9OGCsWxByHUz28=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=i6x/KRptoKb3is2yxSKqYIQyHSvecQbq4obHaCjKkMnsG0nf1yx9PE3wdVrrGYMY9oC19UjS2fKSprIZOB2dUZAqiMilknQCcDtoWteGlSSPcBzL6FUNRuhp/F7V5XpuB660MQM+BQtPXqWHD2iZO/gN68saBukz9h4lXeWt/LA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rCF/UpHY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23EC5C4CEE8
	for <linux-btrfs@vger.kernel.org>; Wed, 23 Apr 2025 14:20:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745418028;
	bh=NG1mRXzaq11+5jzu6s7tURmYq+TwM9OGCsWxByHUz28=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=rCF/UpHYv3qcB46kt2Tmimw5lreIjvoVijKktwEnCnDInOKMJKIubhsDr27G51daF
	 812l/q3/04NuFaEegyGuTuYcq+DNVn9T6eFpRst1rI1pi34ztpZvzD+YqNzRAIxcQc
	 Awc/RLT4eyzstHKL5OUiG78ymc9VPhdxmQCkgNmurSEmGXtw3vw/tnSdqetsvbqz5L
	 z8YRGNtucFAD/yBxcEKazvtVW+qVTwriiRqIxXIubhqaDuP9IbnmNYcMS0xI0RZF4O
	 xpd2vyQye/c9UoMg9Ossx+JJV7/G9UOwCcFXZkgejwulPEkezCH9DjGy8DKSXteSCV
	 tM6aluBeJpliA==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 22/22] btrfs: make extent unpinning more efficient when committing transaction
Date: Wed, 23 Apr 2025 15:20:02 +0100
Message-Id: <530fabed25bb07916ae5af0c3d7a8511eb6a2096.1745401628.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1745401627.git.fdmanana@suse.com>
References: <cover.1745401627.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

At btrfs_finish_extent_commit() we have this loop that keeps finding an
extent range to unpin in the transaction's pinned_extents io tree, caches
the extent state and then passes that cached extent state to
btrfs_clear_extent_dirty(), which will free that extent state since we
clear the only bit it can have set. So on each loop iteration we do a
full io tree search and the cached state is used only to avoid having
a tree search done by btrfs_clear_extent_dirty().

During the lifetime of a transaction we can pin many thousands of extents,
resulting in a large and deep rb tree that backs the io tree. For example,
for the following fs_mark run on a 12 cores boxes:

  $ cat test.sh
  #!/bin/bash

  DEV=/dev/nullb0
  MNT=/mnt/nullb0
  FILES=100000
  THREADS=$(nproc --all)

  echo "performance" | \
      tee /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor

  mkfs.btrfs -f $DEV
  mount $DEV $MNT

  OPTS="-S 0 -L 8 -n $FILES -s 0 -t $THREADS -k"
  for ((i = 1; i <= $THREADS; i++)); do
      OPTS="$OPTS -d $MNT/d$i"
  done

  fs_mark $OPTS

  umount $MNT

an histogram for the number of ranges (elements) in the pinned extents
io tree of a transaction was the following:

  Count: 76
  Range: 5440.000 - 51088.000; Mean: 27354.368; Median: 28312.000; Stddev: 9800.767
  Percentiles:  90th: 40486.000; 95th: 43322.000; 99th: 51088.000
  5440.000 - 6805.809:     1 ###
  6805.809 - 10652.034:     1 ###
  10652.034 - 13326.178:     3 ########
  13326.178 - 16671.590:     8 ######################
  16671.590 - 20856.773:     7 ####################
  20856.773 - 26092.528:    13 ####################################
  26092.528 - 32642.571:    19 #####################################################
  32642.571 - 40836.818:    17 ###############################################
  40836.818 - 51088.000:     7 ####################

We can improve on this by grabbing the next state before calling
btrfs_clear_extent_dirty(), avoiding a full tree search on the next
iteration which always has an O(log n) complexity while grabbing the next
element (rb_next() rbtree operation) is in the worst case O(log n) too,
but very often much less than that, making it more efficient.

Here follow histograms for the execution times, in nanoseconds, of
btrfs_finish_extent_commit() before and after applying this patch and all
the other patches in the same patchset.

Before patchset:

  Count: 32
  Range: 3925691.000 - 269990635.000; Mean: 133814526.906; Median: 122758052.000; Stddev: 65776550.375
  Percentiles:  90th: 228672087.000; 95th: 265187000.000; 99th: 269990635.000
  3925691.000 - 5993208.660:     1 ####
  5993208.660 - 75878537.656:     4 ##################
  75878537.656 - 115840974.514:    12 #####################################################
  115840974.514 - 176850157.761:     6 ###########################
  176850157.761 - 269990635.000:     9 ########################################

After patchset:

  Count: 32
  Range: 1849393.000 - 231491064.000; Mean: 126978584.625; Median: 123732897.000; Stddev: 58007821.806
  Percentiles:  90th: 203055491.000; 95th: 219952699.000; 99th: 231491064.000
  1849393.000 - 2997642.092:     1 ####
  2997642.092 - 88111637.071:     9 #####################################
  88111637.071 - 142818264.414:     9 #####################################
  142818264.414 - 231491064.000:    13 #####################################################

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/extent-io-tree.c | 20 ++++++++++++++++++++
 fs/btrfs/extent-io-tree.h |  3 +++
 fs/btrfs/extent-tree.c    | 40 ++++++++++++++++++++++++++-------------
 3 files changed, 50 insertions(+), 13 deletions(-)

diff --git a/fs/btrfs/extent-io-tree.c b/fs/btrfs/extent-io-tree.c
index f7fe7d23b40a..15652dcd66a1 100644
--- a/fs/btrfs/extent-io-tree.c
+++ b/fs/btrfs/extent-io-tree.c
@@ -1923,6 +1923,26 @@ int btrfs_lock_extent_bits(struct extent_io_tree *tree, u64 start, u64 end, u32
 	return err;
 }
 
+/*
+ * Get the extent state that follows the given extent state.
+ * This is meant to be used in a context where we know no other tasks can
+ * concurrently modify the tree.
+ */
+struct extent_state *btrfs_next_extent_state(struct extent_io_tree *tree,
+					     struct extent_state *state)
+{
+	struct extent_state *next;
+
+	spin_lock(&tree->lock);
+	ASSERT(extent_state_in_tree(state));
+	next = next_state(state);
+	if (next)
+		refcount_inc(&next->refs);
+	spin_unlock(&tree->lock);
+
+	return next;
+}
+
 void __cold btrfs_extent_state_free_cachep(void)
 {
 	btrfs_extent_state_leak_debug_check();
diff --git a/fs/btrfs/extent-io-tree.h b/fs/btrfs/extent-io-tree.h
index d8c01d857667..0a18ca9c59c3 100644
--- a/fs/btrfs/extent-io-tree.h
+++ b/fs/btrfs/extent-io-tree.h
@@ -243,4 +243,7 @@ static inline int btrfs_unlock_dio_extent(struct extent_io_tree *tree, u64 start
 						cached, NULL);
 }
 
+struct extent_state *btrfs_next_extent_state(struct extent_io_tree *tree,
+					     struct extent_state *state);
+
 #endif /* BTRFS_EXTENT_IO_TREE_H */
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 36a29739eac2..711a4f2410dc 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -2818,28 +2818,25 @@ int btrfs_finish_extent_commit(struct btrfs_trans_handle *trans)
 	struct btrfs_fs_info *fs_info = trans->fs_info;
 	struct btrfs_block_group *block_group, *tmp;
 	struct list_head *deleted_bgs;
-	struct extent_io_tree *unpin;
+	struct extent_io_tree *unpin = &trans->transaction->pinned_extents;
+	struct extent_state *cached_state = NULL;
 	u64 start;
 	u64 end;
 	int unpin_error = 0;
 	int ret;
 
-	unpin = &trans->transaction->pinned_extents;
+	mutex_lock(&fs_info->unused_bg_unpin_mutex);
+	btrfs_find_first_extent_bit(unpin, 0, &start, &end, EXTENT_DIRTY,
+				    &cached_state);
 
-	while (!TRANS_ABORTED(trans)) {
-		struct extent_state *cached_state = NULL;
-
-		mutex_lock(&fs_info->unused_bg_unpin_mutex);
-		if (!btrfs_find_first_extent_bit(unpin, 0, &start, &end,
-						 EXTENT_DIRTY, &cached_state)) {
-			mutex_unlock(&fs_info->unused_bg_unpin_mutex);
-			break;
-		}
+	while (!TRANS_ABORTED(trans) && cached_state) {
+		struct extent_state *next_state;
 
 		if (btrfs_test_opt(fs_info, DISCARD_SYNC))
 			ret = btrfs_discard_extent(fs_info, start,
 						   end + 1 - start, NULL);
 
+		next_state = btrfs_next_extent_state(unpin, cached_state);
 		btrfs_clear_extent_dirty(unpin, start, end, &cached_state);
 		ret = unpin_extent_range(fs_info, start, end, true);
 		/*
@@ -2858,10 +2855,27 @@ int btrfs_finish_extent_commit(struct btrfs_trans_handle *trans)
 			if (!unpin_error)
 				unpin_error = ret;
 		}
-		mutex_unlock(&fs_info->unused_bg_unpin_mutex);
+
 		btrfs_free_extent_state(cached_state);
-		cond_resched();
+
+		if (need_resched()) {
+			btrfs_free_extent_state(next_state);
+			mutex_unlock(&fs_info->unused_bg_unpin_mutex);
+			cond_resched();
+			cached_state = NULL;
+			mutex_lock(&fs_info->unused_bg_unpin_mutex);
+			btrfs_find_first_extent_bit(unpin, 0, &start, &end,
+						    EXTENT_DIRTY, &cached_state);
+		} else {
+			cached_state = next_state;
+			if (cached_state) {
+				start = cached_state->start;
+				end = cached_state->end;
+			}
+		}
 	}
+	mutex_unlock(&fs_info->unused_bg_unpin_mutex);
+	btrfs_free_extent_state(cached_state);
 
 	if (btrfs_test_opt(fs_info, DISCARD_ASYNC)) {
 		btrfs_discard_calc_delay(&fs_info->discard_ctl);
-- 
2.47.2


