Return-Path: <linux-btrfs+bounces-18905-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A54D5C5411C
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Nov 2025 20:09:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3BF274E0360
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Nov 2025 19:09:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8582122A4FC;
	Wed, 12 Nov 2025 19:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mail.selcloud.ru header.i=@mail.selcloud.ru header.b="ac6Alm3g";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=foxido.dev header.i=@foxido.dev header.b="oMWL5IJs";
	dkim=pass (2048-bit key) header.d=foxido.dev header.i=@foxido.dev header.b="EfKOa9ta";
	dkim=permerror (0-bit key) header.d=foxido.dev header.i=@foxido.dev header.b="ETns0IkT"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from sender5.mail.selcloud.ru (sender5.mail.selcloud.ru [5.8.75.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40CFA350A2D;
	Wed, 12 Nov 2025 19:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.8.75.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762974490; cv=none; b=J//ggGC8omR7M52DPRK7T+p1UmmWETiqI9nZn14fOEsYV1mnh4ICc8FUXt8FyZwIFzC1mEJ1LzQSJM8lkSEivmL7OjHFiXWMODszKJ6tggTIiH2z3Dym+CGVcBKugRADiNCRMxaDcm0+Y5AKw1dnhxz6He7ykmJH0pA5IdtHVnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762974490; c=relaxed/simple;
	bh=fQrGJE+8X2FBwbWDg/ghnYhMj5f7Jspd7XTALwJr9W0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C5Mpxch/h1gRXz1rPc5zbxCcl3MqBKcd4/sZ+mAdjGxRsFSx2EJ711qm0EGOLOjyBA9o9Qq95FFHFcjeCr6WPweBpH5YL4lCUxV9jqRzES0JGVjqHdslV6rcDNbU2qC/9LsjgBSR5rmpsiF4ee8vxkx3Ip3eYr7IuYiOyr7VBKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=foxido.dev; spf=pass smtp.mailfrom=mail.selcloud.ru; dkim=pass (1024-bit key) header.d=mail.selcloud.ru header.i=@mail.selcloud.ru header.b=ac6Alm3g; dkim=pass (1024-bit key) header.d=foxido.dev header.i=@foxido.dev header.b=oMWL5IJs; dkim=pass (2048-bit key) header.d=foxido.dev header.i=@foxido.dev header.b=EfKOa9ta; dkim=permerror (0-bit key) header.d=foxido.dev header.i=@foxido.dev header.b=ETns0IkT; arc=none smtp.client-ip=5.8.75.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=foxido.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.selcloud.ru
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=mail.selcloud.ru; s=selcloud; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:List-id:
	List-Unsubscribe:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Help:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=n8R0rxbpTLCew8mahpHy82EY2jf6N1sgnYoOqfypFzM=; t=1762974488; x=1763147288;
	 b=ac6Alm3goki3ihJSD6lldnEdvgTR8fm1+5BsFwehcTzPeeuA4H0ljvwVjzykDM6G9todLysrOg
	zwLG/vJ5H5r03lyOPYOw+vgVVPY6viOT/b7SOb4qh+PbmQs76f7CAAtFec1Ws3m2TCPxEK7+S7m/A
	W/LoyQxyevPAvT8+VSgY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=foxido.dev;
	 s=selcloud; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:List-id:List-Unsubscribe:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=n8R0rxbpTLCew8mahpHy82EY2jf6N1sgnYoOqfypFzM=; t=1762974488; x=1763147288;
	 b=oMWL5IJsc/5IZisrWRLUW2OWuexBDJJ+8g/+pvwoIAxRWr9XPD217jWy5v4vN5NvO6nSAi5F/Q
	ENpqtbwAcB/rcDfXurWwNjY7YgkmnaASJwCyowehaVcw7Sdeyd8VBRWphibViEJJgevDROmiXdHUp
	qrwFCWWUgSyCRLOtuMHQ=;
Precedence: bulk
X-Issuen: 1428244
X-User: 149890965
X-Postmaster-Msgtype: 3849
Feedback-ID: 1428244:15965:3849:samotpravil
X-From: foxido.dev
X-from-id: 15965
X-MSG-TYPE: bulk
List-Unsubscribe-Post: List-Unsubscribe=One-Click
X-blist-id: 3849
X-Gungo: 20251107.120132
X-SMTPUID: mlgnr59
DKIM-Signature: v=1; a=rsa-sha256; s=202508r; d=foxido.dev; c=relaxed/relaxed;
	h=Message-ID:Date:Subject:To:From; t=1762973419; bh=n8R0rxbpTLCew8mahpHy82E
	Y2jf6N1sgnYoOqfypFzM=; b=EfKOa9taXJLq9903nx2dl4LgMNbXjeZBPqFhxykk6bSeKXldL/
	KDPSWFysNGmfcbeP67EtmYawzCQGSydZhadswxuSWrFiyIzA3t792GC91LlKOYaooZqyewc7in6
	UF7sQ3IKdk43lzQ4/hs5Dx+00H9/w/U+3hS7EZEp9oI3XR5Gu+Vn5CkJhXA0NKKBvVym0JOfp2S
	/hDifwiMqOldTwn41RV5XO27XoJO5SNkZ1zi2gtKe6Zgwr2AyFPj2vTL0Kj21R8ku6qXv7yB6QN
	K6y4vAxV1BH6oriuYmGXjD6dfst6gBy5VsIzTZdRuoOzxZDjde9hX/Vd0MeufhIo3Hw==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202508e; d=foxido.dev; c=relaxed/relaxed;
	h=Message-ID:Date:Subject:To:From; t=1762973419; bh=n8R0rxbpTLCew8mahpHy82E
	Y2jf6N1sgnYoOqfypFzM=; b=ETns0IkTqnWNGMgCHcvrYq8EY/t6wgmCPgD96oHvZgUjZ2sW0C
	LlPODLpjY1RGqMRkBxhxTj7JKJwpnLQJiCCQ==;
From: Gladyshev Ilya <foxido@foxido.dev>
To: foxido@foxido.dev
Cc: Chris Mason <clm@fb.com>,
	David Sterba <dsterba@suse.com>,
	linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 4/8] btrfs: simplify function protections with guards
Date: Wed, 12 Nov 2025 21:49:40 +0300
Message-ID: <c7abcfeb7e549bf5ad9861044c97b9a111d64370.1762972845.git.foxido@foxido.dev>
X-Mailer: git-send-email 2.51.1.dirty
In-Reply-To: <cover.1762972845.git.foxido@foxido.dev>
References: <cover.1762972845.git.foxido@foxido.dev>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replaces cases like

void foo() {
    spin_lock(&lock);
    ... some code ...
    spin_unlock(&lock)
}

with

void foo() {
    guard(spinlock)(&lock);
    ... some code ...
}

While it doesn't has any measurable impact, it makes clear that whole
function body is protected under lock and removes future errors with
additional cleanup paths.

Signed-off-by: Gladyshev Ilya <foxido@foxido.dev>
---
 fs/btrfs/discard.c          | 10 +++-------
 fs/btrfs/disk-io.c          |  3 +--
 fs/btrfs/extent-io-tree.c   | 15 +++++----------
 fs/btrfs/free-space-cache.c |  4 +---
 fs/btrfs/inode.c            |  3 +--
 fs/btrfs/ordered-data.c     |  6 ++----
 fs/btrfs/qgroup.c           |  9 +++------
 fs/btrfs/raid56.c           |  7 ++-----
 fs/btrfs/send.c             |  3 +--
 fs/btrfs/subpage.c          | 36 +++++++++---------------------------
 fs/btrfs/volumes.c          |  3 +--
 11 files changed, 29 insertions(+), 70 deletions(-)

diff --git a/fs/btrfs/discard.c b/fs/btrfs/discard.c
index 89fe85778115..9bd7a8ad45c4 100644
--- a/fs/btrfs/discard.c
+++ b/fs/btrfs/discard.c
@@ -158,7 +158,7 @@ static bool remove_from_discard_list(struct btrfs_discard_ctl *discard_ctl,
 	bool running = false;
 	bool queued = false;
 
-	spin_lock(&discard_ctl->lock);
+	guard(spinlock)(&discard_ctl->lock);
 
 	if (block_group == discard_ctl->block_group) {
 		running = true;
@@ -171,8 +171,6 @@ static bool remove_from_discard_list(struct btrfs_discard_ctl *discard_ctl,
 	if (queued)
 		btrfs_put_block_group(block_group);
 
-	spin_unlock(&discard_ctl->lock);
-
 	return running;
 }
 
@@ -236,7 +234,7 @@ static struct btrfs_block_group *peek_discard_list(
 {
 	struct btrfs_block_group *block_group;
 
-	spin_lock(&discard_ctl->lock);
+	guard(spinlock)(&discard_ctl->lock);
 again:
 	block_group = find_next_block_group(discard_ctl, now);
 
@@ -276,7 +274,6 @@ static struct btrfs_block_group *peek_discard_list(
 		*discard_state = block_group->discard_state;
 		*discard_index = block_group->discard_index;
 	}
-	spin_unlock(&discard_ctl->lock);
 
 	return block_group;
 }
@@ -694,7 +691,7 @@ void btrfs_discard_punt_unused_bgs_list(struct btrfs_fs_info *fs_info)
 {
 	struct btrfs_block_group *block_group, *next;
 
-	spin_lock(&fs_info->unused_bgs_lock);
+	guard(spinlock)(&fs_info->unused_bgs_lock);
 	/* We enabled async discard, so punt all to the queue */
 	list_for_each_entry_safe(block_group, next, &fs_info->unused_bgs,
 				 bg_list) {
@@ -706,7 +703,6 @@ void btrfs_discard_punt_unused_bgs_list(struct btrfs_fs_info *fs_info)
 		 */
 		btrfs_put_block_group(block_group);
 	}
-	spin_unlock(&fs_info->unused_bgs_lock);
 }
 
 /*
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 0aa7e5d1b05f..55c29557c26c 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -4759,7 +4759,7 @@ static void btrfs_free_all_qgroup_pertrans(struct btrfs_fs_info *fs_info)
 	int i;
 	int ret;
 
-	spin_lock(&fs_info->fs_roots_radix_lock);
+	guard(spinlock)(&fs_info->fs_roots_radix_lock);
 	while (1) {
 		ret = radix_tree_gang_lookup_tag(&fs_info->fs_roots_radix,
 						 (void **)gang, 0,
@@ -4776,7 +4776,6 @@ static void btrfs_free_all_qgroup_pertrans(struct btrfs_fs_info *fs_info)
 					BTRFS_ROOT_TRANS_TAG);
 		}
 	}
-	spin_unlock(&fs_info->fs_roots_radix_lock);
 }
 
 void btrfs_cleanup_one_transaction(struct btrfs_transaction *cur_trans)
diff --git a/fs/btrfs/extent-io-tree.c b/fs/btrfs/extent-io-tree.c
index bb2ca1c9c7b0..3a9774bc714f 100644
--- a/fs/btrfs/extent-io-tree.c
+++ b/fs/btrfs/extent-io-tree.c
@@ -118,7 +118,7 @@ void btrfs_extent_io_tree_release(struct extent_io_tree *tree)
 	struct extent_state *state;
 	struct extent_state *tmp;
 
-	spin_lock(&tree->lock);
+	guard(spinlock)(&tree->lock);
 	root = tree->state;
 	tree->state = RB_ROOT;
 	rbtree_postorder_for_each_entry_safe(state, tmp, &root, rb_node) {
@@ -139,7 +139,6 @@ void btrfs_extent_io_tree_release(struct extent_io_tree *tree)
 	 * be accessing the tree anymore.
 	 */
 	ASSERT(RB_EMPTY_ROOT(&tree->state));
-	spin_unlock(&tree->lock);
 }
 
 static struct extent_state *alloc_extent_state(gfp_t mask)
@@ -958,7 +957,7 @@ bool btrfs_find_contiguous_extent_bit(struct extent_io_tree *tree, u64 start,
 
 	ASSERT(!btrfs_fs_incompat(btrfs_extent_io_tree_to_fs_info(tree), NO_HOLES));
 
-	spin_lock(&tree->lock);
+	guard(spinlock)(&tree->lock);
 	state = find_first_extent_bit_state(tree, start, bits);
 	if (state) {
 		*start_ret = state->start;
@@ -970,7 +969,6 @@ bool btrfs_find_contiguous_extent_bit(struct extent_io_tree *tree, u64 start,
 		}
 		ret = true;
 	}
-	spin_unlock(&tree->lock);
 	return ret;
 }
 
@@ -1757,7 +1755,7 @@ bool btrfs_test_range_bit_exists(struct extent_io_tree *tree, u64 start, u64 end
 
 	ASSERT(is_power_of_2(bit));
 
-	spin_lock(&tree->lock);
+	guard(spinlock)(&tree->lock);
 	state = tree_search(tree, start);
 	while (state) {
 		if (state->start > end)
@@ -1772,7 +1770,6 @@ bool btrfs_test_range_bit_exists(struct extent_io_tree *tree, u64 start, u64 end
 			break;
 		state = next_state(state);
 	}
-	spin_unlock(&tree->lock);
 	return bitset;
 }
 
@@ -1790,7 +1787,7 @@ void btrfs_get_range_bits(struct extent_io_tree *tree, u64 start, u64 end, u32 *
 
 	*bits = 0;
 
-	spin_lock(&tree->lock);
+	guard(spinlock)(&tree->lock);
 	state = tree_search(tree, start);
 	if (state && state->start < end) {
 		*cached_state = state;
@@ -1807,7 +1804,6 @@ void btrfs_get_range_bits(struct extent_io_tree *tree, u64 start, u64 end, u32 *
 
 		state = next_state(state);
 	}
-	spin_unlock(&tree->lock);
 }
 
 /*
@@ -1931,12 +1927,11 @@ struct extent_state *btrfs_next_extent_state(struct extent_io_tree *tree,
 {
 	struct extent_state *next;
 
-	spin_lock(&tree->lock);
+	guard(spinlock)(&tree->lock);
 	ASSERT(extent_state_in_tree(state));
 	next = next_state(state);
 	if (next)
 		refcount_inc(&next->refs);
-	spin_unlock(&tree->lock);
 
 	return next;
 }
diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
index ab873bd67192..30e361ab02dc 100644
--- a/fs/btrfs/free-space-cache.c
+++ b/fs/btrfs/free-space-cache.c
@@ -3845,7 +3845,7 @@ static void reset_trimming_bitmap(struct btrfs_free_space_ctl *ctl, u64 offset)
 {
 	struct btrfs_free_space *entry;
 
-	spin_lock(&ctl->tree_lock);
+	guard(spinlock)(&ctl->tree_lock);
 	entry = tree_search_offset(ctl, offset, 1, 0);
 	if (entry) {
 		if (btrfs_free_space_trimmed(entry)) {
@@ -3855,8 +3855,6 @@ static void reset_trimming_bitmap(struct btrfs_free_space_ctl *ctl, u64 offset)
 		}
 		entry->trim_state = BTRFS_TRIM_STATE_UNTRIMMED;
 	}
-
-	spin_unlock(&ctl->tree_lock);
 }
 
 static void end_trimming_bitmap(struct btrfs_free_space_ctl *ctl,
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 6282911e536f..fdcf4948fa56 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -10424,12 +10424,11 @@ void btrfs_update_inode_bytes(struct btrfs_inode *inode,
 	if (add_bytes == del_bytes)
 		return;
 
-	spin_lock(&inode->lock);
+	guard(spinlock)(&inode->lock);
 	if (del_bytes > 0)
 		inode_sub_bytes(&inode->vfs_inode, del_bytes);
 	if (add_bytes > 0)
 		inode_add_bytes(&inode->vfs_inode, add_bytes);
-	spin_unlock(&inode->lock);
 }
 
 /*
diff --git a/fs/btrfs/ordered-data.c b/fs/btrfs/ordered-data.c
index 2829f20d7bb5..27a16bacdf9c 100644
--- a/fs/btrfs/ordered-data.c
+++ b/fs/btrfs/ordered-data.c
@@ -328,9 +328,8 @@ void btrfs_add_ordered_sum(struct btrfs_ordered_extent *entry,
 {
 	struct btrfs_inode *inode = entry->inode;
 
-	spin_lock_irq(&inode->ordered_tree_lock);
+	guard(spinlock_irq)(&inode->ordered_tree_lock);
 	list_add_tail(&sum->list, &entry->list);
-	spin_unlock_irq(&inode->ordered_tree_lock);
 }
 
 void btrfs_mark_ordered_extent_error(struct btrfs_ordered_extent *ordered)
@@ -1041,7 +1040,7 @@ void btrfs_get_ordered_extents_for_logging(struct btrfs_inode *inode,
 
 	btrfs_assert_inode_locked(inode);
 
-	spin_lock_irq(&inode->ordered_tree_lock);
+	guard(spinlock_irq)(&inode->ordered_tree_lock);
 	for (n = rb_first(&inode->ordered_tree); n; n = rb_next(n)) {
 		struct btrfs_ordered_extent *ordered;
 
@@ -1055,7 +1054,6 @@ void btrfs_get_ordered_extents_for_logging(struct btrfs_inode *inode,
 		refcount_inc(&ordered->refs);
 		trace_btrfs_ordered_extent_lookup_for_logging(inode, ordered);
 	}
-	spin_unlock_irq(&inode->ordered_tree_lock);
 }
 
 /*
diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
index a8474d0a9c58..683905f4481d 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -3973,7 +3973,7 @@ qgroup_rescan_zero_tracking(struct btrfs_fs_info *fs_info)
 	struct rb_node *n;
 	struct btrfs_qgroup *qgroup;
 
-	spin_lock(&fs_info->qgroup_lock);
+	guard(spinlock)(&fs_info->qgroup_lock);
 	/* clear all current qgroup tracking information */
 	for (n = rb_first(&fs_info->qgroup_tree); n; n = rb_next(n)) {
 		qgroup = rb_entry(n, struct btrfs_qgroup, node);
@@ -3983,7 +3983,6 @@ qgroup_rescan_zero_tracking(struct btrfs_fs_info *fs_info)
 		qgroup->excl_cmpr = 0;
 		qgroup_dirty(fs_info, qgroup);
 	}
-	spin_unlock(&fs_info->qgroup_lock);
 }
 
 int
@@ -4419,12 +4418,11 @@ static void add_root_meta_rsv(struct btrfs_root *root, int num_bytes,
 	if (num_bytes == 0)
 		return;
 
-	spin_lock(&root->qgroup_meta_rsv_lock);
+	guard(spinlock)(&root->qgroup_meta_rsv_lock);
 	if (type == BTRFS_QGROUP_RSV_META_PREALLOC)
 		root->qgroup_meta_rsv_prealloc += num_bytes;
 	else
 		root->qgroup_meta_rsv_pertrans += num_bytes;
-	spin_unlock(&root->qgroup_meta_rsv_lock);
 }
 
 static int sub_root_meta_rsv(struct btrfs_root *root, int num_bytes,
@@ -4436,7 +4434,7 @@ static int sub_root_meta_rsv(struct btrfs_root *root, int num_bytes,
 	if (num_bytes == 0)
 		return 0;
 
-	spin_lock(&root->qgroup_meta_rsv_lock);
+	guard(spinlock)(&root->qgroup_meta_rsv_lock);
 	if (type == BTRFS_QGROUP_RSV_META_PREALLOC) {
 		num_bytes = min_t(u64, root->qgroup_meta_rsv_prealloc,
 				  num_bytes);
@@ -4446,7 +4444,6 @@ static int sub_root_meta_rsv(struct btrfs_root *root, int num_bytes,
 				  num_bytes);
 		root->qgroup_meta_rsv_pertrans -= num_bytes;
 	}
-	spin_unlock(&root->qgroup_meta_rsv_lock);
 	return num_bytes;
 }
 
diff --git a/fs/btrfs/raid56.c b/fs/btrfs/raid56.c
index 0135dceb7baa..6b9fda36d3c6 100644
--- a/fs/btrfs/raid56.c
+++ b/fs/btrfs/raid56.c
@@ -516,13 +516,12 @@ static void btrfs_clear_rbio_cache(struct btrfs_fs_info *info)
 
 	table = info->stripe_hash_table;
 
-	spin_lock(&table->cache_lock);
+	guard(spinlock)(&table->cache_lock);
 	while (!list_empty(&table->stripe_cache)) {
 		rbio = list_first_entry(&table->stripe_cache,
 					struct btrfs_raid_bio, stripe_cache);
 		__remove_rbio_from_cache(rbio);
 	}
-	spin_unlock(&table->cache_lock);
 }
 
 /*
@@ -1234,11 +1233,9 @@ static void index_rbio_pages(struct btrfs_raid_bio *rbio)
 {
 	struct bio *bio;
 
-	spin_lock(&rbio->bio_list_lock);
+	guard(spinlock)(&rbio->bio_list_lock);
 	bio_list_for_each(bio, &rbio->bio_list)
 		index_one_bio(rbio, bio);
-
-	spin_unlock(&rbio->bio_list_lock);
 }
 
 static void bio_get_trace_info(struct btrfs_raid_bio *rbio, struct bio *bio,
diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index 96a030d28e09..e7e33c9feca0 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -7980,7 +7980,7 @@ static int flush_delalloc_roots(struct send_ctx *sctx)
 
 static void btrfs_root_dec_send_in_progress(struct btrfs_root* root)
 {
-	spin_lock(&root->root_item_lock);
+	guard(spinlock)(&root->root_item_lock);
 	root->send_in_progress--;
 	/*
 	 * Not much left to do, we don't know why it's unbalanced and
@@ -7990,7 +7990,6 @@ static void btrfs_root_dec_send_in_progress(struct btrfs_root* root)
 		btrfs_err(root->fs_info,
 			  "send_in_progress unbalanced %d root %llu",
 			  root->send_in_progress, btrfs_root_id(root));
-	spin_unlock(&root->root_item_lock);
 }
 
 static void dedupe_in_progress_warn(const struct btrfs_root *root)
diff --git a/fs/btrfs/subpage.c b/fs/btrfs/subpage.c
index 5ca8d4db6722..8c8563e87aea 100644
--- a/fs/btrfs/subpage.c
+++ b/fs/btrfs/subpage.c
@@ -364,13 +364,11 @@ void btrfs_subpage_set_uptodate(const struct btrfs_fs_info *fs_info,
 	struct btrfs_folio_state *bfs = folio_get_private(folio);
 	unsigned int start_bit = subpage_calc_start_bit(fs_info, folio,
 							uptodate, start, len);
-	unsigned long flags;
 
-	spin_lock_irqsave(&bfs->lock, flags);
+	guard(spinlock_irqsave)(&bfs->lock);
 	bitmap_set(bfs->bitmaps, start_bit, len >> fs_info->sectorsize_bits);
 	if (subpage_test_bitmap_all_set(fs_info, folio, uptodate))
 		folio_mark_uptodate(folio);
-	spin_unlock_irqrestore(&bfs->lock, flags);
 }
 
 void btrfs_subpage_clear_uptodate(const struct btrfs_fs_info *fs_info,
@@ -379,12 +377,10 @@ void btrfs_subpage_clear_uptodate(const struct btrfs_fs_info *fs_info,
 	struct btrfs_folio_state *bfs = folio_get_private(folio);
 	unsigned int start_bit = subpage_calc_start_bit(fs_info, folio,
 							uptodate, start, len);
-	unsigned long flags;
 
-	spin_lock_irqsave(&bfs->lock, flags);
+	guard(spinlock_irqsave)(&bfs->lock);
 	bitmap_clear(bfs->bitmaps, start_bit, len >> fs_info->sectorsize_bits);
 	folio_clear_uptodate(folio);
-	spin_unlock_irqrestore(&bfs->lock, flags);
 }
 
 void btrfs_subpage_set_dirty(const struct btrfs_fs_info *fs_info,
@@ -417,14 +413,12 @@ bool btrfs_subpage_clear_and_test_dirty(const struct btrfs_fs_info *fs_info,
 	struct btrfs_folio_state *bfs = folio_get_private(folio);
 	unsigned int start_bit = subpage_calc_start_bit(fs_info, folio,
 							dirty, start, len);
-	unsigned long flags;
 	bool last = false;
 
-	spin_lock_irqsave(&bfs->lock, flags);
+	guard(spinlock_irqsave)(&bfs->lock);
 	bitmap_clear(bfs->bitmaps, start_bit, len >> fs_info->sectorsize_bits);
 	if (subpage_test_bitmap_all_zero(fs_info, folio, dirty))
 		last = true;
-	spin_unlock_irqrestore(&bfs->lock, flags);
 	return last;
 }
 
@@ -444,9 +438,8 @@ void btrfs_subpage_set_writeback(const struct btrfs_fs_info *fs_info,
 	struct btrfs_folio_state *bfs = folio_get_private(folio);
 	unsigned int start_bit = subpage_calc_start_bit(fs_info, folio,
 							writeback, start, len);
-	unsigned long flags;
 
-	spin_lock_irqsave(&bfs->lock, flags);
+	guard(spinlock_irqsave)(&bfs->lock);
 	bitmap_set(bfs->bitmaps, start_bit, len >> fs_info->sectorsize_bits);
 
 	/*
@@ -467,7 +460,6 @@ void btrfs_subpage_set_writeback(const struct btrfs_fs_info *fs_info,
 		xas_clear_mark(&xas, PAGECACHE_TAG_TOWRITE);
 		xas_unlock_irqrestore(&xas, flags);
 	}
-	spin_unlock_irqrestore(&bfs->lock, flags);
 }
 
 void btrfs_subpage_clear_writeback(const struct btrfs_fs_info *fs_info,
@@ -476,15 +468,13 @@ void btrfs_subpage_clear_writeback(const struct btrfs_fs_info *fs_info,
 	struct btrfs_folio_state *bfs = folio_get_private(folio);
 	unsigned int start_bit = subpage_calc_start_bit(fs_info, folio,
 							writeback, start, len);
-	unsigned long flags;
 
-	spin_lock_irqsave(&bfs->lock, flags);
+	guard(spinlock_irqsave)(&bfs->lock);
 	bitmap_clear(bfs->bitmaps, start_bit, len >> fs_info->sectorsize_bits);
 	if (subpage_test_bitmap_all_zero(fs_info, folio, writeback)) {
 		ASSERT(folio_test_writeback(folio));
 		folio_end_writeback(folio);
 	}
-	spin_unlock_irqrestore(&bfs->lock, flags);
 }
 
 void btrfs_subpage_set_ordered(const struct btrfs_fs_info *fs_info,
@@ -493,12 +483,10 @@ void btrfs_subpage_set_ordered(const struct btrfs_fs_info *fs_info,
 	struct btrfs_folio_state *bfs = folio_get_private(folio);
 	unsigned int start_bit = subpage_calc_start_bit(fs_info, folio,
 							ordered, start, len);
-	unsigned long flags;
 
-	spin_lock_irqsave(&bfs->lock, flags);
+	guard(spinlock_irqsave)(&bfs->lock);
 	bitmap_set(bfs->bitmaps, start_bit, len >> fs_info->sectorsize_bits);
 	folio_set_ordered(folio);
-	spin_unlock_irqrestore(&bfs->lock, flags);
 }
 
 void btrfs_subpage_clear_ordered(const struct btrfs_fs_info *fs_info,
@@ -507,13 +495,11 @@ void btrfs_subpage_clear_ordered(const struct btrfs_fs_info *fs_info,
 	struct btrfs_folio_state *bfs = folio_get_private(folio);
 	unsigned int start_bit = subpage_calc_start_bit(fs_info, folio,
 							ordered, start, len);
-	unsigned long flags;
 
-	spin_lock_irqsave(&bfs->lock, flags);
+	guard(spinlock_irqsave)(&bfs->lock);
 	bitmap_clear(bfs->bitmaps, start_bit, len >> fs_info->sectorsize_bits);
 	if (subpage_test_bitmap_all_zero(fs_info, folio, ordered))
 		folio_clear_ordered(folio);
-	spin_unlock_irqrestore(&bfs->lock, flags);
 }
 
 void btrfs_subpage_set_checked(const struct btrfs_fs_info *fs_info,
@@ -522,13 +508,11 @@ void btrfs_subpage_set_checked(const struct btrfs_fs_info *fs_info,
 	struct btrfs_folio_state *bfs = folio_get_private(folio);
 	unsigned int start_bit = subpage_calc_start_bit(fs_info, folio,
 							checked, start, len);
-	unsigned long flags;
 
-	spin_lock_irqsave(&bfs->lock, flags);
+	guard(spinlock_irqsave)(&bfs->lock);
 	bitmap_set(bfs->bitmaps, start_bit, len >> fs_info->sectorsize_bits);
 	if (subpage_test_bitmap_all_set(fs_info, folio, checked))
 		folio_set_checked(folio);
-	spin_unlock_irqrestore(&bfs->lock, flags);
 }
 
 void btrfs_subpage_clear_checked(const struct btrfs_fs_info *fs_info,
@@ -537,12 +521,10 @@ void btrfs_subpage_clear_checked(const struct btrfs_fs_info *fs_info,
 	struct btrfs_folio_state *bfs = folio_get_private(folio);
 	unsigned int start_bit = subpage_calc_start_bit(fs_info, folio,
 							checked, start, len);
-	unsigned long flags;
 
-	spin_lock_irqsave(&bfs->lock, flags);
+	guard(spinlock_irqsave)(&bfs->lock);
 	bitmap_clear(bfs->bitmaps, start_bit, len >> fs_info->sectorsize_bits);
 	folio_clear_checked(folio);
-	spin_unlock_irqrestore(&bfs->lock, flags);
 }
 
 /*
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 2bec544d8ba3..3ccf6c958388 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -8152,7 +8152,7 @@ bool btrfs_pinned_by_swapfile(struct btrfs_fs_info *fs_info, void *ptr)
 	struct btrfs_swapfile_pin *sp;
 	struct rb_node *node;
 
-	spin_lock(&fs_info->swapfile_pins_lock);
+	guard(spinlock)(&fs_info->swapfile_pins_lock);
 	node = fs_info->swapfile_pins.rb_node;
 	while (node) {
 		sp = rb_entry(node, struct btrfs_swapfile_pin, node);
@@ -8163,7 +8163,6 @@ bool btrfs_pinned_by_swapfile(struct btrfs_fs_info *fs_info, void *ptr)
 		else
 			break;
 	}
-	spin_unlock(&fs_info->swapfile_pins_lock);
 	return node != NULL;
 }
 
-- 
2.51.1.dirty


