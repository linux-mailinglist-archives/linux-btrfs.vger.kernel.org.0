Return-Path: <linux-btrfs+bounces-9146-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EDDC9AEBEB
	for <lists+linux-btrfs@lfdr.de>; Thu, 24 Oct 2024 18:25:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B11C1F235A0
	for <lists+linux-btrfs@lfdr.de>; Thu, 24 Oct 2024 16:25:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0995D1FAEE0;
	Thu, 24 Oct 2024 16:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="StYQKkOo"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 310CD1F9EC7
	for <linux-btrfs@vger.kernel.org>; Thu, 24 Oct 2024 16:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729787088; cv=none; b=LLqZB1RkGBw5sIpGx+7s8rdVodBC8apCLvML+KgUBC900JT4JcgdrfUvBywlp9ebT356Da6pXyhQfhRQPvYSThwYSPRR9SXxznPqY/qcviOzviImzkmljhnOP9t7qypDklrkRdNGHyGRGO9DYUd6MxyuNcA3k95dxUrP5AbhwEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729787088; c=relaxed/simple;
	bh=SY9+aA1kkF03N+4qsNp8tyGlTlYB/6kFF0AcDWyPtb8=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AobKlfsWmvgMEruH+WpYVuReJVvDrRYmR0Co1Rm07/JSgsYUJvRW/lvI3ytQKKFHp5nu/uVtRiORGEG0gVD8HJjvRFoK0M1B3ahit1usAsCLkblfWr5DcYOTT6Ji8xqiI1tWIbKi36A1+aKcum0GbJlajwgVrDylJvKyclPOX8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=StYQKkOo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFE17C4CEE3
	for <linux-btrfs@vger.kernel.org>; Thu, 24 Oct 2024 16:24:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729787087;
	bh=SY9+aA1kkF03N+4qsNp8tyGlTlYB/6kFF0AcDWyPtb8=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=StYQKkOo/5ol7WejYcmbB2dev5LX10hXR5NzZtBrixKFF1/y4uFimbq/7S1H2cM8w
	 cXqWcKgdHRbtBhX3gINxvtcWdoquq/hnMCgpdxj20kb467DX1+6byI+KJHDfanOyJt
	 rq/IZqm/gzPPnJmkyw1/XQ2bPMysBMuPsRgcthXPMlys3k5M5VQ4hVYMPQ+thHur/F
	 Z/jEhrlCOx+HgrigXcXNW+0gnq5PcpwwdZDOAvrHdWIr3q8pJiyV6U9vMspYpfmTMj
	 WBmQJMj6WSl1YgGsu+yKFUGJ/Imj2RDdpNNegZchngiw51Sp813TaLpT6f84PZIeRi
	 qMLbymouRco8g==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 17/18] btrfs: track delayed ref heads in an xarray
Date: Thu, 24 Oct 2024 17:24:25 +0100
Message-Id: <529e3a34a057b4389dd779bc6cddfb075d9c5c34.1729784713.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1729784712.git.fdmanana@suse.com>
References: <cover.1729784712.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

Currently we use a red black tree (rb-tree) to track the delayed ref
heads (in struct btrfs_delayed_ref_root::href_root). This however is not
very efficient when the number of delayed ref heads is large (and it's
very common to be at least in the order of thousands) since rb-trees are
binary trees. For example for 10K delayed ref heads, the tree has a depth
of 13. Besides that, inserting into the tree requires navigating through
it and pulling useless cache lines in the process since the red black tree
nodes are embedded within the delayed ref head structure - on the other
hand, by being embedded, it requires no extra memory allocations.

We can improve this by using an xarray instead which has a much higher
branching factor than a red black tree (binary balanced tree) and is more
cache friendly and behaves like a resizable array, with a much better
search and insertion complexity than a red black tree. This only has one
small disadvantage which is that insertion will sometimes require
allocating memory for the xarray - which may fail (not that often since
it uses a kmem_cache) - but on the other hand we can reduce the delayed
ref head structure size by 24 bytes (from 152 down to 128 bytes) after
removing the embedded red black tree node, meaning than we can now fit
32 delayed ref heads per 4K page instead of 26, and that gain compensates
for the occasional memory allocations needed for the xarray nodes. We
also end up using only 2 cache lines instead of 3 per delayed ref head.

Running the following fs_mark test showed some improvements:

    $ cat test.sh
    #!/bin/bash

    DEV=/dev/nullb0
    MNT=/mnt/nullb0
    MOUNT_OPTIONS="-o ssd"
    FILES=100000
    THREADS=$(nproc --all)

    echo "performance" | \
        tee /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor

    mkfs.btrfs -f $DEV
    mount $MOUNT_OPTIONS $DEV $MNT

    OPTS="-S 0 -L 5 -n $FILES -s 0 -t $THREADS -k"
    for ((i = 1; i <= $THREADS; i++)); do
        OPTS="$OPTS -d $MNT/d$i"
    done

    fs_mark $OPTS

    umount $MNT

Before this patch:

   FSUse%        Count         Size    Files/sec     App Overhead
       10      1200000            0     171845.7         12253839
       16      2400000            0     230898.7         12308254
       23      3600000            0     212292.9         12467768
       30      4800000            0     195737.8         12627554
       46      6000000            0     171055.2         12783329

After this patch:

   FSUse%        Count         Size    Files/sec     App Overhead
       10      1200000            0     173835.0         12246131
       16      2400000            0     233537.8         12271746
       23      3600000            0     220398.7         12307737
       30      4800000            0     204483.6         12392318
       40      6000000            0     182923.3         12771843

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/delayed-ref.c | 192 +++++++++++++++++++----------------------
 fs/btrfs/delayed-ref.h |  26 +++---
 fs/btrfs/extent-tree.c |   2 +-
 fs/btrfs/transaction.c |   5 +-
 4 files changed, 106 insertions(+), 119 deletions(-)

diff --git a/fs/btrfs/delayed-ref.c b/fs/btrfs/delayed-ref.c
index 2b6a636ba4b5..e4ca5285e614 100644
--- a/fs/btrfs/delayed-ref.c
+++ b/fs/btrfs/delayed-ref.c
@@ -314,39 +314,6 @@ static int comp_refs(struct btrfs_delayed_ref_node *ref1,
 	return 0;
 }
 
-/* insert a new ref to head ref rbtree */
-static struct btrfs_delayed_ref_head *htree_insert(struct rb_root_cached *root,
-						   struct rb_node *node)
-{
-	struct rb_node **p = &root->rb_root.rb_node;
-	struct rb_node *parent_node = NULL;
-	struct btrfs_delayed_ref_head *entry;
-	struct btrfs_delayed_ref_head *ins;
-	u64 bytenr;
-	bool leftmost = true;
-
-	ins = rb_entry(node, struct btrfs_delayed_ref_head, href_node);
-	bytenr = ins->bytenr;
-	while (*p) {
-		parent_node = *p;
-		entry = rb_entry(parent_node, struct btrfs_delayed_ref_head,
-				 href_node);
-
-		if (bytenr < entry->bytenr) {
-			p = &(*p)->rb_left;
-		} else if (bytenr > entry->bytenr) {
-			p = &(*p)->rb_right;
-			leftmost = false;
-		} else {
-			return entry;
-		}
-	}
-
-	rb_link_node(node, parent_node, p);
-	rb_insert_color_cached(node, root, leftmost);
-	return NULL;
-}
-
 static struct btrfs_delayed_ref_node* tree_insert(struct rb_root_cached *root,
 		struct btrfs_delayed_ref_node *ins)
 {
@@ -381,18 +348,11 @@ static struct btrfs_delayed_ref_node* tree_insert(struct rb_root_cached *root,
 static struct btrfs_delayed_ref_head *find_first_ref_head(
 		struct btrfs_delayed_ref_root *dr)
 {
-	struct rb_node *n;
-	struct btrfs_delayed_ref_head *entry;
+	unsigned long from = 0;
 
 	lockdep_assert_held(&dr->lock);
 
-	n = rb_first_cached(&dr->href_root);
-	if (!n)
-		return NULL;
-
-	entry = rb_entry(n, struct btrfs_delayed_ref_head, href_node);
-
-	return entry;
+	return xa_find(&dr->head_refs, &from, ULONG_MAX, XA_PRESENT);
 }
 
 /*
@@ -405,35 +365,22 @@ static struct btrfs_delayed_ref_head *find_ref_head(
 		struct btrfs_delayed_ref_root *dr, u64 bytenr,
 		bool return_bigger)
 {
-	struct rb_root *root = &dr->href_root.rb_root;
-	struct rb_node *n;
+	const unsigned long target_index = (bytenr >> fs_info->sectorsize_bits);
+	unsigned long found_index = target_index;
 	struct btrfs_delayed_ref_head *entry;
 
 	lockdep_assert_held(&dr->lock);
 
-	n = root->rb_node;
-	entry = NULL;
-	while (n) {
-		entry = rb_entry(n, struct btrfs_delayed_ref_head, href_node);
+	entry = xa_find(&dr->head_refs, &found_index, ULONG_MAX, XA_PRESENT);
+	if (!entry)
+		return NULL;
+
+	ASSERT(found_index >= target_index);
 
-		if (bytenr < entry->bytenr)
-			n = n->rb_left;
-		else if (bytenr > entry->bytenr)
-			n = n->rb_right;
-		else
-			return entry;
-	}
-	if (entry && return_bigger) {
-		if (bytenr > entry->bytenr) {
-			n = rb_next(&entry->href_node);
-			if (!n)
-				return NULL;
-			entry = rb_entry(n, struct btrfs_delayed_ref_head,
-					 href_node);
-		}
-		return entry;
-	}
-	return NULL;
+	if (found_index != target_index && !return_bigger)
+		return NULL;
+
+	return entry;
 }
 
 static bool btrfs_delayed_ref_lock(struct btrfs_delayed_ref_root *delayed_refs,
@@ -448,7 +395,7 @@ static bool btrfs_delayed_ref_lock(struct btrfs_delayed_ref_root *delayed_refs,
 
 	mutex_lock(&head->mutex);
 	spin_lock(&delayed_refs->lock);
-	if (RB_EMPTY_NODE(&head->href_node)) {
+	if (!head->tracked) {
 		mutex_unlock(&head->mutex);
 		btrfs_put_delayed_ref_head(head);
 		return false;
@@ -567,35 +514,27 @@ struct btrfs_delayed_ref_head *btrfs_select_ref_head(
 		struct btrfs_delayed_ref_root *delayed_refs)
 {
 	struct btrfs_delayed_ref_head *head;
+	unsigned long start_index;
+	unsigned long found_index;
+	bool found_head = false;
 	bool locked;
 
 	spin_lock(&delayed_refs->lock);
 again:
-	head = find_ref_head(fs_info, delayed_refs,
-			     delayed_refs->run_delayed_start, true);
-	if (!head && delayed_refs->run_delayed_start != 0) {
-		delayed_refs->run_delayed_start = 0;
-		head = find_first_ref_head(delayed_refs);
-	}
-	if (!head) {
-		spin_unlock(&delayed_refs->lock);
-		return NULL;
+	start_index = (delayed_refs->run_delayed_start >> fs_info->sectorsize_bits);
+	xa_for_each_start(&delayed_refs->head_refs, found_index, head, start_index) {
+		if (!head->processing) {
+			found_head = true;
+			break;
+		}
 	}
-
-	while (head->processing) {
-		struct rb_node *node;
-
-		node = rb_next(&head->href_node);
-		if (!node) {
-			if (delayed_refs->run_delayed_start == 0) {
-				spin_unlock(&delayed_refs->lock);
-				return NULL;
-			}
-			delayed_refs->run_delayed_start = 0;
-			goto again;
+	if (!found_head) {
+		if (delayed_refs->run_delayed_start == 0) {
+			spin_unlock(&delayed_refs->lock);
+			return NULL;
 		}
-		head = rb_entry(node, struct btrfs_delayed_ref_head,
-				href_node);
+		delayed_refs->run_delayed_start = 0;
+		goto again;
 	}
 
 	head->processing = true;
@@ -632,11 +571,13 @@ void btrfs_delete_ref_head(struct btrfs_fs_info *fs_info,
 			   struct btrfs_delayed_ref_root *delayed_refs,
 			   struct btrfs_delayed_ref_head *head)
 {
+	const unsigned long index = (head->bytenr >> fs_info->sectorsize_bits);
+
 	lockdep_assert_held(&delayed_refs->lock);
 	lockdep_assert_held(&head->lock);
 
-	rb_erase_cached(&head->href_node, &delayed_refs->href_root);
-	RB_CLEAR_NODE(&head->href_node);
+	xa_erase(&delayed_refs->head_refs, index);
+	head->tracked = false;
 	delayed_refs->num_heads--;
 	if (!head->processing)
 		delayed_refs->num_heads_ready--;
@@ -845,7 +786,7 @@ static void init_delayed_ref_head(struct btrfs_delayed_ref_head *head_ref,
 	head_ref->is_system = (generic_ref->ref_root == BTRFS_CHUNK_TREE_OBJECTID);
 	head_ref->ref_tree = RB_ROOT_CACHED;
 	INIT_LIST_HEAD(&head_ref->ref_add_list);
-	RB_CLEAR_NODE(&head_ref->href_node);
+	head_ref->tracked = false;
 	head_ref->processing = false;
 	head_ref->total_ref_mod = count_mod;
 	spin_lock_init(&head_ref->lock);
@@ -883,11 +824,24 @@ add_delayed_ref_head(struct btrfs_trans_handle *trans,
 	struct btrfs_fs_info *fs_info = trans->fs_info;
 	struct btrfs_delayed_ref_head *existing;
 	struct btrfs_delayed_ref_root *delayed_refs;
+	const unsigned long index = (head_ref->bytenr >> fs_info->sectorsize_bits);
 	bool qrecord_inserted = false;
 
 	delayed_refs = &trans->transaction->delayed_refs;
 	lockdep_assert_held(&delayed_refs->lock);
 
+#if BITS_PER_LONG == 32
+	if (head_ref->bytenr >= MAX_LFS_FILESIZE) {
+		if (qrecord)
+			xa_release(&delayed_refs->dirty_extents, index);
+		btrfs_err_rl(fs_info,
+"delayed ref head %llu is beyond 32bit page cache and xarray index limit",
+			     head_ref->bytenr);
+		btrfs_err_32bit_limit(fs_info);
+		return ERR_PTR(-EOVERFLOW);
+	}
+#endif
+
 	/* Record qgroup extent info if provided */
 	if (qrecord) {
 		int ret;
@@ -896,8 +850,7 @@ add_delayed_ref_head(struct btrfs_trans_handle *trans,
 						       head_ref->bytenr);
 		if (ret) {
 			/* Clean up if insertion fails or item exists. */
-			xa_release(&delayed_refs->dirty_extents,
-				   head_ref->bytenr >> fs_info->sectorsize_bits);
+			xa_release(&delayed_refs->dirty_extents, index);
 			/* Caller responsible for freeing qrecord on error. */
 			if (ret < 0)
 				return ERR_PTR(ret);
@@ -909,8 +862,7 @@ add_delayed_ref_head(struct btrfs_trans_handle *trans,
 
 	trace_add_delayed_ref_head(fs_info, head_ref, action);
 
-	existing = htree_insert(&delayed_refs->href_root,
-				&head_ref->href_node);
+	existing = xa_load(&delayed_refs->head_refs, index);
 	if (existing) {
 		update_existing_head_ref(trans, existing, head_ref);
 		/*
@@ -920,6 +872,19 @@ add_delayed_ref_head(struct btrfs_trans_handle *trans,
 		kmem_cache_free(btrfs_delayed_ref_head_cachep, head_ref);
 		head_ref = existing;
 	} else {
+		existing = xa_store(&delayed_refs->head_refs, index, head_ref, GFP_ATOMIC);
+		if (xa_is_err(existing)) {
+			/* Memory was preallocated by the caller. */
+			ASSERT(xa_err(existing) != -ENOMEM);
+			return ERR_CAST(existing);
+		} else if (WARN_ON(existing)) {
+			/*
+			 * Shouldn't happen we just did a lookup before under
+			 * delayed_refs->lock.
+			 */
+			return ERR_PTR(-EEXIST);
+		}
+		head_ref->tracked = true;
 		/*
 		 * We reserve the amount of bytes needed to delete csums when
 		 * adding the ref head and not when adding individual drop refs
@@ -1040,6 +1005,8 @@ static int add_delayed_ref(struct btrfs_trans_handle *trans,
 	struct btrfs_delayed_ref_head *new_head_ref;
 	struct btrfs_delayed_ref_root *delayed_refs;
 	struct btrfs_qgroup_extent_record *record = NULL;
+	const unsigned long index = (generic_ref->bytenr >> fs_info->sectorsize_bits);
+	bool qrecord_reserved = false;
 	bool qrecord_inserted;
 	int action = generic_ref->action;
 	bool merged;
@@ -1055,25 +1022,32 @@ static int add_delayed_ref(struct btrfs_trans_handle *trans,
 		goto free_node;
 	}
 
+	delayed_refs = &trans->transaction->delayed_refs;
+
 	if (btrfs_qgroup_full_accounting(fs_info) && !generic_ref->skip_qgroup) {
 		record = kzalloc(sizeof(*record), GFP_NOFS);
 		if (!record) {
 			ret = -ENOMEM;
 			goto free_head_ref;
 		}
-		if (xa_reserve(&trans->transaction->delayed_refs.dirty_extents,
-			       generic_ref->bytenr >> fs_info->sectorsize_bits,
-			       GFP_NOFS)) {
+		if (xa_reserve(&delayed_refs->dirty_extents, index, GFP_NOFS)) {
 			ret = -ENOMEM;
 			goto free_record;
 		}
+		qrecord_reserved = true;
+	}
+
+	ret = xa_reserve(&delayed_refs->head_refs, index, GFP_NOFS);
+	if (ret) {
+		if (qrecord_reserved)
+			xa_release(&delayed_refs->dirty_extents, index);
+		goto free_record;
 	}
 
 	init_delayed_ref_common(fs_info, node, generic_ref);
 	init_delayed_ref_head(head_ref, generic_ref, record, reserved);
 	head_ref->extent_op = extent_op;
 
-	delayed_refs = &trans->transaction->delayed_refs;
 	spin_lock(&delayed_refs->lock);
 
 	/*
@@ -1083,6 +1057,7 @@ static int add_delayed_ref(struct btrfs_trans_handle *trans,
 	new_head_ref = add_delayed_ref_head(trans, head_ref, record,
 					    action, &qrecord_inserted);
 	if (IS_ERR(new_head_ref)) {
+		xa_release(&delayed_refs->head_refs, index);
 		spin_unlock(&delayed_refs->lock);
 		ret = PTR_ERR(new_head_ref);
 		goto free_record;
@@ -1145,6 +1120,7 @@ int btrfs_add_delayed_extent_op(struct btrfs_trans_handle *trans,
 				u64 bytenr, u64 num_bytes, u8 level,
 				struct btrfs_delayed_extent_op *extent_op)
 {
+	const unsigned long index = (bytenr >> trans->fs_info->sectorsize_bits);
 	struct btrfs_delayed_ref_head *head_ref;
 	struct btrfs_delayed_ref_head *head_ref_ret;
 	struct btrfs_delayed_ref_root *delayed_refs;
@@ -1155,6 +1131,7 @@ int btrfs_add_delayed_extent_op(struct btrfs_trans_handle *trans,
 		.num_bytes = num_bytes,
 		.tree_ref.level = level,
 	};
+	int ret;
 
 	head_ref = kmem_cache_alloc(btrfs_delayed_ref_head_cachep, GFP_NOFS);
 	if (!head_ref)
@@ -1164,16 +1141,23 @@ int btrfs_add_delayed_extent_op(struct btrfs_trans_handle *trans,
 	head_ref->extent_op = extent_op;
 
 	delayed_refs = &trans->transaction->delayed_refs;
-	spin_lock(&delayed_refs->lock);
 
+	ret = xa_reserve(&delayed_refs->head_refs, index, GFP_NOFS);
+	if (ret) {
+		kmem_cache_free(btrfs_delayed_ref_head_cachep, head_ref);
+		return ret;
+	}
+
+	spin_lock(&delayed_refs->lock);
 	head_ref_ret = add_delayed_ref_head(trans, head_ref, NULL,
 					    BTRFS_UPDATE_DELAYED_HEAD, NULL);
-	spin_unlock(&delayed_refs->lock);
-
 	if (IS_ERR(head_ref_ret)) {
+		xa_release(&delayed_refs->head_refs, index);
+		spin_unlock(&delayed_refs->lock);
 		kmem_cache_free(btrfs_delayed_ref_head_cachep, head_ref);
 		return PTR_ERR(head_ref_ret);
 	}
+	spin_unlock(&delayed_refs->lock);
 
 	/*
 	 * Need to update the delayed_refs_rsv with any changes we may have
diff --git a/fs/btrfs/delayed-ref.h b/fs/btrfs/delayed-ref.h
index 0a9f4d7dd87b..c7c4d62744b4 100644
--- a/fs/btrfs/delayed-ref.h
+++ b/fs/btrfs/delayed-ref.h
@@ -122,12 +122,6 @@ struct btrfs_delayed_extent_op {
 struct btrfs_delayed_ref_head {
 	u64 bytenr;
 	u64 num_bytes;
-	/*
-	 * For insertion into struct btrfs_delayed_ref_root::href_root.
-	 * Keep it in the same cache line as 'bytenr' for more efficient
-	 * searches in the rbtree.
-	 */
-	struct rb_node href_node;
 	/*
 	 * the mutex is held while running the refs, and it is also
 	 * held when checking the sum of reference modifications.
@@ -191,6 +185,11 @@ struct btrfs_delayed_ref_head {
 	bool is_data;
 	bool is_system;
 	bool processing;
+	/*
+	 * Indicate if it's currently in the data structure that tracks head
+	 * refs (struct btrfs_delayed_ref_root::head_refs).
+	 */
+	bool tracked;
 };
 
 enum btrfs_delayed_ref_flags {
@@ -199,22 +198,27 @@ enum btrfs_delayed_ref_flags {
 };
 
 struct btrfs_delayed_ref_root {
-	/* head ref rbtree */
-	struct rb_root_cached href_root;
-
 	/*
-	 * Track dirty extent records.
+	 * Track head references.
 	 * The keys correspond to the logical address of the extent ("bytenr")
 	 * right shifted by fs_info->sectorsize_bits. This is both to get a more
 	 * dense index space (optimizes xarray structure) and because indexes in
 	 * xarrays are of "unsigned long" type, meaning they are 32 bits wide on
 	 * 32 bits platforms, limiting the extent range to 4G which is too low
 	 * and makes it unusable (truncated index values) on 32 bits platforms.
+	 * Protected by the spinlock 'lock' defined below.
+	 */
+	struct xarray head_refs;
+
+	/*
+	 * Track dirty extent records.
+	 * The keys correspond to the logical address of the extent ("bytenr")
+	 * right shifted by fs_info->sectorsize_bits, for same reasons as above.
 	 */
 	struct xarray dirty_extents;
 
 	/*
-	 * Protects the rbtree href_root, its entries and the following fields:
+	 * Protects the xarray head_refs, its entries and the following fields:
 	 * num_heads, num_heads_ready, pending_csums and run_delayed_start.
 	 */
 	spinlock_t lock;
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 33f911476a4d..1571b5a1d905 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -2176,7 +2176,7 @@ int btrfs_run_delayed_refs(struct btrfs_trans_handle *trans, u64 min_bytes)
 		btrfs_create_pending_block_groups(trans);
 
 		spin_lock(&delayed_refs->lock);
-		if (RB_EMPTY_ROOT(&delayed_refs->href_root.rb_root)) {
+		if (xa_empty(&delayed_refs->head_refs)) {
 			spin_unlock(&delayed_refs->lock);
 			return 0;
 		}
diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index 9ccf68ab53f9..dc0b837efd5d 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -141,8 +141,7 @@ void btrfs_put_transaction(struct btrfs_transaction *transaction)
 	WARN_ON(refcount_read(&transaction->use_count) == 0);
 	if (refcount_dec_and_test(&transaction->use_count)) {
 		BUG_ON(!list_empty(&transaction->list));
-		WARN_ON(!RB_EMPTY_ROOT(
-				&transaction->delayed_refs.href_root.rb_root));
+		WARN_ON(!xa_empty(&transaction->delayed_refs.head_refs));
 		WARN_ON(!xa_empty(&transaction->delayed_refs.dirty_extents));
 		if (transaction->delayed_refs.pending_csums)
 			btrfs_err(transaction->fs_info,
@@ -349,7 +348,7 @@ static noinline int join_transaction(struct btrfs_fs_info *fs_info,
 
 	memset(&cur_trans->delayed_refs, 0, sizeof(cur_trans->delayed_refs));
 
-	cur_trans->delayed_refs.href_root = RB_ROOT_CACHED;
+	xa_init(&cur_trans->delayed_refs.head_refs);
 	xa_init(&cur_trans->delayed_refs.dirty_extents);
 
 	/*
-- 
2.43.0


