Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 069392A468C
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Nov 2020 14:32:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729266AbgKCNcF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 3 Nov 2020 08:32:05 -0500
Received: from mx2.suse.de ([195.135.220.15]:44918 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729355AbgKCNcE (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 3 Nov 2020 08:32:04 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1604410322;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EKiRCVMNFR9U61javOv/fMb4uhRPeER7LTDCMTusNr4=;
        b=uFF0i0GBzbXSdYMVOGiJR2trxJHDAss7HJstEA8FhBHCqcbErRwOFtiyZxM1VfCKoclyNd
        2QreRbSOT1kSyp5X5duV9jcEl2tE2cN4xJR5g7rDLGGL8matOcEoFwiCkD25GRTmqlLAGb
        IWUpgV+mLvycVdmxjhvcFNJgOVUPPI4=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 729E5ABF4
        for <linux-btrfs@vger.kernel.org>; Tue,  3 Nov 2020 13:32:02 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 16/32] btrfs: extent_io: allow find_first_extent_bit() to find a range with exact bits match
Date:   Tue,  3 Nov 2020 21:30:52 +0800
Message-Id: <20201103133108.148112-17-wqu@suse.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201103133108.148112-1-wqu@suse.com>
References: <20201103133108.148112-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Currently if we pass mutliple @bits to find_first_extent_bit(), it will
return the first range with one or more bits matching @bits.

This is fine for current code, since most of them are just doing their
own extra checks, and all existing callers only call it with 1 or 2
bits.

But for the incoming subpage support, we want the ability to return range
with exact match, so that caller can skip some extra checks.

So this patch will add a new bool parameter, @exact_match, to
find_first_extent_bit() and its callees.
Currently all callers just pass 'false' to the new parameter, thus no
functional change is introduced.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/block-group.c      |  2 +-
 fs/btrfs/dev-replace.c      |  2 +-
 fs/btrfs/disk-io.c          |  4 ++--
 fs/btrfs/extent-io-tree.h   |  2 +-
 fs/btrfs/extent-tree.c      |  2 +-
 fs/btrfs/extent_io.c        | 42 +++++++++++++++++++++++++------------
 fs/btrfs/free-space-cache.c |  2 +-
 fs/btrfs/relocation.c       |  2 +-
 fs/btrfs/transaction.c      |  4 ++--
 fs/btrfs/volumes.c          |  2 +-
 10 files changed, 40 insertions(+), 24 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index bb6685711824..19d84766568c 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -461,7 +461,7 @@ u64 add_new_free_space(struct btrfs_block_group *block_group, u64 start, u64 end
 		ret = find_first_extent_bit(&info->excluded_extents, start,
 					    &extent_start, &extent_end,
 					    EXTENT_DIRTY | EXTENT_UPTODATE,
-					    NULL);
+					    false, NULL);
 		if (ret)
 			break;
 
diff --git a/fs/btrfs/dev-replace.c b/fs/btrfs/dev-replace.c
index 5b9e3f3ace22..c102a704ead2 100644
--- a/fs/btrfs/dev-replace.c
+++ b/fs/btrfs/dev-replace.c
@@ -612,7 +612,7 @@ static int btrfs_set_target_alloc_state(struct btrfs_device *srcdev,
 
 	while (!find_first_extent_bit(&srcdev->alloc_state, start,
 				      &found_start, &found_end,
-				      CHUNK_ALLOCATED, &cached_state)) {
+				      CHUNK_ALLOCATED, false, &cached_state)) {
 		ret = set_extent_bits(&tgtdev->alloc_state, found_start,
 				      found_end, CHUNK_ALLOCATED);
 		if (ret)
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 3259a5b32caf..7a847513708d 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -4515,7 +4515,7 @@ static int btrfs_destroy_marked_extents(struct btrfs_fs_info *fs_info,
 
 	while (1) {
 		ret = find_first_extent_bit(dirty_pages, start, &start, &end,
-					    mark, NULL);
+					    mark, false, NULL);
 		if (ret)
 			break;
 
@@ -4555,7 +4555,7 @@ static int btrfs_destroy_pinned_extent(struct btrfs_fs_info *fs_info,
 		 */
 		mutex_lock(&fs_info->unused_bg_unpin_mutex);
 		ret = find_first_extent_bit(unpin, 0, &start, &end,
-					    EXTENT_DIRTY, &cached_state);
+					    EXTENT_DIRTY, false, &cached_state);
 		if (ret) {
 			mutex_unlock(&fs_info->unused_bg_unpin_mutex);
 			break;
diff --git a/fs/btrfs/extent-io-tree.h b/fs/btrfs/extent-io-tree.h
index b5dab64d5f85..516e76c806d7 100644
--- a/fs/btrfs/extent-io-tree.h
+++ b/fs/btrfs/extent-io-tree.h
@@ -257,7 +257,7 @@ static inline int set_extent_uptodate(struct extent_io_tree *tree, u64 start,
 
 int find_first_extent_bit(struct extent_io_tree *tree, u64 start,
 			  u64 *start_ret, u64 *end_ret, unsigned bits,
-			  struct extent_state **cached_state);
+			  bool exact_match, struct extent_state **cached_state);
 void find_first_clear_extent_bit(struct extent_io_tree *tree, u64 start,
 				 u64 *start_ret, u64 *end_ret, unsigned bits);
 int find_contiguous_extent_bit(struct extent_io_tree *tree, u64 start,
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index a27caa47aa62..06630bd7ae04 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -2877,7 +2877,7 @@ int btrfs_finish_extent_commit(struct btrfs_trans_handle *trans)
 
 		mutex_lock(&fs_info->unused_bg_unpin_mutex);
 		ret = find_first_extent_bit(unpin, 0, &start, &end,
-					    EXTENT_DIRTY, &cached_state);
+					    EXTENT_DIRTY, false, &cached_state);
 		if (ret) {
 			mutex_unlock(&fs_info->unused_bg_unpin_mutex);
 			break;
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 614759ad02b3..30768e49cf47 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -1558,13 +1558,27 @@ void extent_range_redirty_for_io(struct inode *inode, u64 start, u64 end)
 	}
 }
 
-/* find the first state struct with 'bits' set after 'start', and
- * return it.  tree->lock must be held.  NULL will returned if
- * nothing was found after 'start'
+static bool match_extent_state(struct extent_state *state, unsigned bits,
+			       bool exact_match)
+{
+	if (exact_match)
+		return ((state->state & bits) == bits);
+	return (state->state & bits);
+}
+
+/*
+ * Find the first state struct with @bits set after @start.
+ *
+ * NOTE: tree->lock must be hold.
+ *
+ * @exact_match:	Do we need to have all @bits set, or just any of
+ * 			the @bits.
+ *
+ * Return NULL if we can't find a match.
  */
 static struct extent_state *
 find_first_extent_bit_state(struct extent_io_tree *tree,
-			    u64 start, unsigned bits)
+			    u64 start, unsigned bits, bool exact_match)
 {
 	struct rb_node *node;
 	struct extent_state *state;
@@ -1579,7 +1593,8 @@ find_first_extent_bit_state(struct extent_io_tree *tree,
 
 	while (1) {
 		state = rb_entry(node, struct extent_state, rb_node);
-		if (state->end >= start && (state->state & bits))
+		if (state->end >= start &&
+		    match_extent_state(state, bits, exact_match))
 			return state;
 
 		node = rb_next(node);
@@ -1600,7 +1615,7 @@ find_first_extent_bit_state(struct extent_io_tree *tree,
  */
 int find_first_extent_bit(struct extent_io_tree *tree, u64 start,
 			  u64 *start_ret, u64 *end_ret, unsigned bits,
-			  struct extent_state **cached_state)
+			  bool exact_match, struct extent_state **cached_state)
 {
 	struct extent_state *state;
 	int ret = 1;
@@ -1610,7 +1625,8 @@ int find_first_extent_bit(struct extent_io_tree *tree, u64 start,
 		state = *cached_state;
 		if (state->end == start - 1 && extent_state_in_tree(state)) {
 			while ((state = next_state(state)) != NULL) {
-				if (state->state & bits)
+				if (match_extent_state(state, bits,
+				    exact_match))
 					goto got_it;
 			}
 			free_extent_state(*cached_state);
@@ -1621,7 +1637,7 @@ int find_first_extent_bit(struct extent_io_tree *tree, u64 start,
 		*cached_state = NULL;
 	}
 
-	state = find_first_extent_bit_state(tree, start, bits);
+	state = find_first_extent_bit_state(tree, start, bits, exact_match);
 got_it:
 	if (state) {
 		cache_state_if_flags(state, cached_state, 0);
@@ -1656,7 +1672,7 @@ int find_contiguous_extent_bit(struct extent_io_tree *tree, u64 start,
 	int ret = 1;
 
 	spin_lock(&tree->lock);
-	state = find_first_extent_bit_state(tree, start, bits);
+	state = find_first_extent_bit_state(tree, start, bits, false);
 	if (state) {
 		*start_ret = state->start;
 		*end_ret = state->end;
@@ -2432,9 +2448,8 @@ int clean_io_failure(struct btrfs_fs_info *fs_info,
 		goto out;
 
 	spin_lock(&io_tree->lock);
-	state = find_first_extent_bit_state(io_tree,
-					    failrec->start,
-					    EXTENT_LOCKED);
+	state = find_first_extent_bit_state(io_tree, failrec->start,
+					    EXTENT_LOCKED, false);
 	spin_unlock(&io_tree->lock);
 
 	if (state && state->start <= failrec->start &&
@@ -2470,7 +2485,8 @@ void btrfs_free_io_failure_record(struct btrfs_inode *inode, u64 start, u64 end)
 		return;
 
 	spin_lock(&failure_tree->lock);
-	state = find_first_extent_bit_state(failure_tree, start, EXTENT_DIRTY);
+	state = find_first_extent_bit_state(failure_tree, start, EXTENT_DIRTY,
+					    false);
 	while (state) {
 		if (state->start > end)
 			break;
diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
index 5ea36a06e514..2fcc685ac8eb 100644
--- a/fs/btrfs/free-space-cache.c
+++ b/fs/btrfs/free-space-cache.c
@@ -1090,7 +1090,7 @@ static noinline_for_stack int write_pinned_extent_entries(
 	while (start < block_group->start + block_group->length) {
 		ret = find_first_extent_bit(unpin, start,
 					    &extent_start, &extent_end,
-					    EXTENT_DIRTY, NULL);
+					    EXTENT_DIRTY, false, NULL);
 		if (ret)
 			return 0;
 
diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 3d4618a01ef3..206e9c8dc269 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -3158,7 +3158,7 @@ int find_next_extent(struct reloc_control *rc, struct btrfs_path *path,
 
 		ret = find_first_extent_bit(&rc->processed_blocks,
 					    key.objectid, &start, &end,
-					    EXTENT_DIRTY, NULL);
+					    EXTENT_DIRTY, false, NULL);
 
 		if (ret == 0 && start <= key.objectid) {
 			btrfs_release_path(path);
diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index 8f70d7135497..3894be14bf57 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -976,7 +976,7 @@ int btrfs_write_marked_extents(struct btrfs_fs_info *fs_info,
 
 	atomic_inc(&BTRFS_I(fs_info->btree_inode)->sync_writers);
 	while (!find_first_extent_bit(dirty_pages, start, &start, &end,
-				      mark, &cached_state)) {
+				      mark, false, &cached_state)) {
 		bool wait_writeback = false;
 
 		err = convert_extent_bit(dirty_pages, start, end,
@@ -1031,7 +1031,7 @@ static int __btrfs_wait_marked_extents(struct btrfs_fs_info *fs_info,
 	u64 end;
 
 	while (!find_first_extent_bit(dirty_pages, start, &start, &end,
-				      EXTENT_NEED_WAIT, &cached_state)) {
+				      EXTENT_NEED_WAIT, false, &cached_state)) {
 		/*
 		 * Ignore -ENOMEM errors returned by clear_extent_bit().
 		 * When committing the transaction, we'll remove any entries
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index eb9ee7c2998f..a4ee38a47b1f 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -1391,7 +1391,7 @@ static bool contains_pending_extent(struct btrfs_device *device, u64 *start,
 
 	if (!find_first_extent_bit(&device->alloc_state, *start,
 				   &physical_start, &physical_end,
-				   CHUNK_ALLOCATED, NULL)) {
+				   CHUNK_ALLOCATED, false, NULL)) {
 
 		if (in_range(physical_start, *start, len) ||
 		    in_range(*start, physical_start,
-- 
2.29.2

