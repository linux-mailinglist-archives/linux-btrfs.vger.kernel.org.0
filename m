Return-Path: <linux-btrfs+bounces-18903-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 869A2C54134
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Nov 2025 20:11:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99A013B3D68
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Nov 2025 19:08:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46B6834E74D;
	Wed, 12 Nov 2025 19:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mail.selcloud.ru header.i=@mail.selcloud.ru header.b="FE1m9y8L";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=foxido.dev header.i=@foxido.dev header.b="ryGf81ZQ";
	dkim=pass (2048-bit key) header.d=foxido.dev header.i=@foxido.dev header.b="r8y7iish";
	dkim=permerror (0-bit key) header.d=foxido.dev header.i=@foxido.dev header.b="poZyJc1L"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from sender7.mail.selcloud.ru (sender7.mail.selcloud.ru [5.8.75.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DC4D34CFAC;
	Wed, 12 Nov 2025 19:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.8.75.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762974480; cv=none; b=Fx9BWfgo+U6sqa1djJpiSNq9QjvDtgtbyzOME5yYYG32+m9/ahNJUIvl9A/AiFhSzH1jp71HNmzyRlZQtrtuttwE9Q03moTdeS/gpMzAI7mwzFgwOo7KBEO6ebdJyIqlhEPt3GT5z0QVK4vbW3DAfkyKzaZSbrLjTe2Pmzz7SdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762974480; c=relaxed/simple;
	bh=ma5dc96pRCrKaOzJCcMdK00g4KFJGc5hIGii0nGxXM8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QVBYDnQXCNGR5LDQrxUaaeM2QTiIu3rSg64ROKV0KWJq+cwKc0S+2cQ0S3bw1uRIffcsubQovWryMFdJeRuAMspfzSZjuHyr0cpKzVQ7FP0TWiwb+sEl/SySSE7fLyUrpOuTl7M5u0RZ9+ZFMVYeSkW9tbrZ/E0An40jJWJk7Fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=foxido.dev; spf=pass smtp.mailfrom=mail.selcloud.ru; dkim=pass (1024-bit key) header.d=mail.selcloud.ru header.i=@mail.selcloud.ru header.b=FE1m9y8L; dkim=pass (1024-bit key) header.d=foxido.dev header.i=@foxido.dev header.b=ryGf81ZQ; dkim=pass (2048-bit key) header.d=foxido.dev header.i=@foxido.dev header.b=r8y7iish; dkim=permerror (0-bit key) header.d=foxido.dev header.i=@foxido.dev header.b=poZyJc1L; arc=none smtp.client-ip=5.8.75.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=foxido.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.selcloud.ru
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=mail.selcloud.ru; s=selcloud; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:List-id:
	List-Unsubscribe:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Help:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=/2dMeMUqKQTF4zNO3r0R2955Uy+cnwBTGpQwHwijTgE=; t=1762974476; x=1763147276;
	 b=FE1m9y8LZuK7BAsFNxExA45UQYryvbvwsUTYNKusjTtqQa0gB6mDbBjcTKsQ35ur/d3Hs2e91p
	cQJzSPr5SeRwFog+evLvaICTbcyVV3xO39yxf1TAJ9qCi41cGYezRSjhOYgsqBL5vED6pPjIkAd54
	uYZcFeT7SdsXhNxoHRNk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=foxido.dev;
	 s=selcloud; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:List-id:List-Unsubscribe:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=/2dMeMUqKQTF4zNO3r0R2955Uy+cnwBTGpQwHwijTgE=; t=1762974476; x=1763147276;
	 b=ryGf81ZQV64AHDsrgrkEw/s2/EENUOa0RmYoVAYBou9/qp62f3GK6kgMK5uFd8LCzSi9u+UBSE
	4YvWDaMyOyTBos+2Wtv48U/lwYZYCsY/tBQ7LPbOqG4PJOsee1b1ZmNaDIgvCrRHRfpKLRZaB19UK
	EJ3HIomyRsMhiwILuwZY=;
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
X-SMTPUID: mlgnr61
DKIM-Signature: v=1; a=rsa-sha256; s=202508r; d=foxido.dev; c=relaxed/relaxed;
	h=Message-ID:Date:Subject:To:From; t=1762973419; bh=/2dMeMUqKQTF4zNO3r0R295
	5Uy+cnwBTGpQwHwijTgE=; b=r8y7iishl/IFHSxeSyU06ARrVfAfKD4/kkgU4I1VKAVsbUzjbC
	Zv8/wZYYfdhXaS4UeIDiG+G3em/fSwZ4SC/Sx+1bjJlifrMtGaQ1W2m9zXuVhO3EVXHGcSPNs93
	19g5GV+LrajTNofoTmnoBcAAPNSrCz6Xp0uKOHipYVJacQ4Xo9ko8o9OiYXnu5nLOlbj7sboOP3
	E5fInnQR0sEtsJFV/YpbtGznBhwY88DutcZQhDKPKn477sg5PxOsjlx4U6uypQrnb13L83IDGL9
	yX4BxZgUQYShm/8QsBBdWkW3SUNsdcFVcd02zS8DuNCl3C6HTGwliLXVOgTDMDxt6HQ==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202508e; d=foxido.dev; c=relaxed/relaxed;
	h=Message-ID:Date:Subject:To:From; t=1762973419; bh=/2dMeMUqKQTF4zNO3r0R295
	5Uy+cnwBTGpQwHwijTgE=; b=poZyJc1LoBzFqqsf5sAa1QSir6M3cwihT8w8i9G9dryIYwDFXq
	bHEdGrtGGgcZXj8NfTfQLHPJlveurtSvbHBQ==;
From: Gladyshev Ilya <foxido@foxido.dev>
To: foxido@foxido.dev
Cc: Chris Mason <clm@fb.com>,
	David Sterba <dsterba@suse.com>,
	linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 7/8] btrfs: simplify return path via cleanup.h
Date: Wed, 12 Nov 2025 21:49:43 +0300
Message-ID: <5bfb05436ed8f80bc060a745805d54309cdba59c.1762972845.git.foxido@foxido.dev>
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

In some functions removing cleanup paths allows to overall simplify it's
code, so replace cleanup paths with guard()s.

Signed-off-by: Gladyshev Ilya <foxido@foxido.dev>
---
 fs/btrfs/extent-io-tree.c | 21 ++++-----
 fs/btrfs/extent-tree.c    | 96 ++++++++++++++++-----------------------
 fs/btrfs/ordered-data.c   | 46 ++++++++-----------
 3 files changed, 68 insertions(+), 95 deletions(-)

diff --git a/fs/btrfs/extent-io-tree.c b/fs/btrfs/extent-io-tree.c
index 69ea2bd359a6..88d7aed7055f 100644
--- a/fs/btrfs/extent-io-tree.c
+++ b/fs/btrfs/extent-io-tree.c
@@ -890,9 +890,8 @@ bool btrfs_find_first_extent_bit(struct extent_io_tree *tree, u64 start,
 				 struct extent_state **cached_state)
 {
 	struct extent_state *state;
-	bool ret = false;
 
-	spin_lock(&tree->lock);
+	guard(spinlock)(&tree->lock);
 	if (cached_state && *cached_state) {
 		state = *cached_state;
 		if (state->end == start - 1 && extent_state_in_tree(state)) {
@@ -911,23 +910,21 @@ bool btrfs_find_first_extent_bit(struct extent_io_tree *tree, u64 start,
 			*cached_state = NULL;
 			if (state)
 				goto got_it;
-			goto out;
+			return false;
 		}
 		btrfs_free_extent_state(*cached_state);
 		*cached_state = NULL;
 	}
 
 	state = find_first_extent_bit_state(tree, start, bits);
+	if (!state)
+		return false;
+
 got_it:
-	if (state) {
-		cache_state_if_flags(state, cached_state, 0);
-		*start_ret = state->start;
-		*end_ret = state->end;
-		ret = true;
-	}
-out:
-	spin_unlock(&tree->lock);
-	return ret;
+	cache_state_if_flags(state, cached_state, 0);
+	*start_ret = state->start;
+	*end_ret = state->end;
+	return true;
 }
 
 /*
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index f9744e456c6c..cb3d61d96e66 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -1878,16 +1878,14 @@ static int cleanup_ref_head(struct btrfs_trans_handle *trans,
 	 * and then re-check to make sure nobody got added.
 	 */
 	spin_unlock(&head->lock);
-	spin_lock(&delayed_refs->lock);
-	spin_lock(&head->lock);
-	if (!RB_EMPTY_ROOT(&head->ref_tree.rb_root) || head->extent_op) {
-		spin_unlock(&head->lock);
-		spin_unlock(&delayed_refs->lock);
-		return 1;
+	{
+		guard(spinlock)(&delayed_refs->lock);
+		guard(spinlock)(&head->lock);
+
+		if (!RB_EMPTY_ROOT(&head->ref_tree.rb_root) || head->extent_op)
+			return 1;
+		btrfs_delete_ref_head(fs_info, delayed_refs, head);
 	}
-	btrfs_delete_ref_head(fs_info, delayed_refs, head);
-	spin_unlock(&head->lock);
-	spin_unlock(&delayed_refs->lock);
 
 	if (head->must_insert_reserved) {
 		btrfs_pin_extent(trans, head->bytenr, head->num_bytes, 1);
@@ -3391,30 +3389,29 @@ static noinline int check_ref_cleanup(struct btrfs_trans_handle *trans,
 	int ret = 0;
 
 	delayed_refs = &trans->transaction->delayed_refs;
-	spin_lock(&delayed_refs->lock);
-	head = btrfs_find_delayed_ref_head(fs_info, delayed_refs, bytenr);
-	if (!head)
-		goto out_delayed_unlock;
-
-	spin_lock(&head->lock);
-	if (!RB_EMPTY_ROOT(&head->ref_tree.rb_root))
-		goto out;
+	{
+		guard(spinlock)(&delayed_refs->lock);
+		head = btrfs_find_delayed_ref_head(fs_info, delayed_refs, bytenr);
+		if (!head)
+			return 0;
 
-	if (cleanup_extent_op(head) != NULL)
-		goto out;
+		guard(spinlock)(&head->lock);
+		if (!RB_EMPTY_ROOT(&head->ref_tree.rb_root))
+			return 0;
 
-	/*
-	 * waiting for the lock here would deadlock.  If someone else has it
-	 * locked they are already in the process of dropping it anyway
-	 */
-	if (!mutex_trylock(&head->mutex))
-		goto out;
+		if (cleanup_extent_op(head) != NULL)
+			return 0;
 
-	btrfs_delete_ref_head(fs_info, delayed_refs, head);
-	head->processing = false;
+		/*
+		 * waiting for the lock here would deadlock.  If someone else has it
+		 * locked they are already in the process of dropping it anyway
+		 */
+		if (!mutex_trylock(&head->mutex))
+			return 0;
 
-	spin_unlock(&head->lock);
-	spin_unlock(&delayed_refs->lock);
+		btrfs_delete_ref_head(fs_info, delayed_refs, head);
+		head->processing = false;
+	}
 
 	BUG_ON(head->extent_op);
 	if (head->must_insert_reserved)
@@ -3424,12 +3421,6 @@ static noinline int check_ref_cleanup(struct btrfs_trans_handle *trans,
 	mutex_unlock(&head->mutex);
 	btrfs_put_delayed_ref_head(head);
 	return ret;
-out:
-	spin_unlock(&head->lock);
-
-out_delayed_unlock:
-	spin_unlock(&delayed_refs->lock);
-	return 0;
 }
 
 int btrfs_free_tree_block(struct btrfs_trans_handle *trans,
@@ -3910,13 +3901,13 @@ static int do_allocation_zoned(struct btrfs_block_group *block_group,
 		 */
 	}
 
-	spin_lock(&space_info->lock);
-	spin_lock(&block_group->lock);
-	spin_lock(&fs_info->treelog_bg_lock);
-	spin_lock(&fs_info->relocation_bg_lock);
+	guard(spinlock)(&space_info->lock);
+	guard(spinlock)(&block_group->lock);
+	guard(spinlock)(&fs_info->treelog_bg_lock);
+	guard(spinlock)(&fs_info->relocation_bg_lock);
 
 	if (ret)
-		goto out;
+		goto err;
 
 	ASSERT(!ffe_ctl->for_treelog ||
 	       block_group->start == fs_info->treelog_bg ||
@@ -3928,8 +3919,7 @@ static int do_allocation_zoned(struct btrfs_block_group *block_group,
 	if (block_group->ro ||
 	    (!ffe_ctl->for_data_reloc &&
 	     test_bit(BLOCK_GROUP_FLAG_ZONED_DATA_RELOC, &block_group->runtime_flags))) {
-		ret = 1;
-		goto out;
+		goto err;
 	}
 
 	/*
@@ -3938,8 +3928,7 @@ static int do_allocation_zoned(struct btrfs_block_group *block_group,
 	 */
 	if (ffe_ctl->for_treelog && !fs_info->treelog_bg &&
 	    (block_group->used || block_group->reserved)) {
-		ret = 1;
-		goto out;
+		goto err;
 	}
 
 	/*
@@ -3948,8 +3937,7 @@ static int do_allocation_zoned(struct btrfs_block_group *block_group,
 	 */
 	if (ffe_ctl->for_data_reloc && !fs_info->data_reloc_bg &&
 	    (block_group->used || block_group->reserved)) {
-		ret = 1;
-		goto out;
+		goto err;
 	}
 
 	WARN_ON_ONCE(block_group->alloc_offset > block_group->zone_capacity);
@@ -3963,8 +3951,7 @@ static int do_allocation_zoned(struct btrfs_block_group *block_group,
 			ffe_ctl->max_extent_size = avail;
 			ffe_ctl->total_free_space = avail;
 		}
-		ret = 1;
-		goto out;
+		goto err;
 	}
 
 	if (ffe_ctl->for_treelog && !fs_info->treelog_bg)
@@ -4003,17 +3990,14 @@ static int do_allocation_zoned(struct btrfs_block_group *block_group,
 	 */
 
 	ffe_ctl->search_start = ffe_ctl->found_offset;
+	return 0;
 
-out:
-	if (ret && ffe_ctl->for_treelog)
+err:
+	if (ffe_ctl->for_treelog)
 		fs_info->treelog_bg = 0;
-	if (ret && ffe_ctl->for_data_reloc)
+	if (ffe_ctl->for_data_reloc)
 		fs_info->data_reloc_bg = 0;
-	spin_unlock(&fs_info->relocation_bg_lock);
-	spin_unlock(&fs_info->treelog_bg_lock);
-	spin_unlock(&block_group->lock);
-	spin_unlock(&space_info->lock);
-	return ret;
+	return 1;
 }
 
 static int do_allocation(struct btrfs_block_group *block_group,
diff --git a/fs/btrfs/ordered-data.c b/fs/btrfs/ordered-data.c
index 451b60de4550..4dbec4ef4ffd 100644
--- a/fs/btrfs/ordered-data.c
+++ b/fs/btrfs/ordered-data.c
@@ -995,35 +995,29 @@ struct btrfs_ordered_extent *btrfs_lookup_ordered_range(
 	struct rb_node *node;
 	struct btrfs_ordered_extent *entry = NULL;
 
-	spin_lock_irq(&inode->ordered_tree_lock);
+	guard(spinlock_irq)(&inode->ordered_tree_lock);
 	node = ordered_tree_search(inode, file_offset);
 	if (!node) {
 		node = ordered_tree_search(inode, file_offset + len);
 		if (!node)
-			goto out;
+			return NULL;
 	}
 
 	while (1) {
 		entry = rb_entry(node, struct btrfs_ordered_extent, rb_node);
-		if (btrfs_range_overlaps(entry, file_offset, len))
-			break;
+		if (btrfs_range_overlaps(entry, file_offset, len)) {
+			refcount_inc(&entry->refs);
+			trace_btrfs_ordered_extent_lookup_range(inode, entry);
+			return entry;
+		}
 
 		if (entry->file_offset >= file_offset + len) {
-			entry = NULL;
-			break;
+			return NULL;
 		}
-		entry = NULL;
 		node = rb_next(node);
 		if (!node)
-			break;
+			return NULL;
 	}
-out:
-	if (entry) {
-		refcount_inc(&entry->refs);
-		trace_btrfs_ordered_extent_lookup_range(inode, entry);
-	}
-	spin_unlock_irq(&inode->ordered_tree_lock);
-	return entry;
 }
 
 /*
@@ -1092,7 +1086,7 @@ struct btrfs_ordered_extent *btrfs_lookup_first_ordered_range(
 	struct rb_node *next;
 	struct btrfs_ordered_extent *entry = NULL;
 
-	spin_lock_irq(&inode->ordered_tree_lock);
+	guard(spinlock_irq)(&inode->ordered_tree_lock);
 	node = inode->ordered_tree.rb_node;
 	/*
 	 * Here we don't want to use tree_search() which will use tree->last
@@ -1112,12 +1106,12 @@ struct btrfs_ordered_extent *btrfs_lookup_first_ordered_range(
 			 * Direct hit, got an ordered extent that starts at
 			 * @file_offset
 			 */
-			goto out;
+			goto ret_entry;
 		}
 	}
 	if (!entry) {
 		/* Empty tree */
-		goto out;
+		return NULL;
 	}
 
 	cur = &entry->rb_node;
@@ -1132,22 +1126,20 @@ struct btrfs_ordered_extent *btrfs_lookup_first_ordered_range(
 	if (prev) {
 		entry = rb_entry(prev, struct btrfs_ordered_extent, rb_node);
 		if (btrfs_range_overlaps(entry, file_offset, len))
-			goto out;
+			goto ret_entry;
 	}
 	if (next) {
 		entry = rb_entry(next, struct btrfs_ordered_extent, rb_node);
 		if (btrfs_range_overlaps(entry, file_offset, len))
-			goto out;
+			goto ret_entry;
 	}
 	/* No ordered extent in the range */
-	entry = NULL;
-out:
-	if (entry) {
-		refcount_inc(&entry->refs);
-		trace_btrfs_ordered_extent_lookup_first_range(inode, entry);
-	}
+	return NULL;
+
+ret_entry:
+	refcount_inc(&entry->refs);
+	trace_btrfs_ordered_extent_lookup_first_range(inode, entry);
 
-	spin_unlock_irq(&inode->ordered_tree_lock);
 	return entry;
 }
 
-- 
2.51.1.dirty


