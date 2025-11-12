Return-Path: <linux-btrfs+bounces-18906-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id D92E7C54129
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Nov 2025 20:10:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9AE623486EA
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Nov 2025 19:10:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD7E534CFDE;
	Wed, 12 Nov 2025 19:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mail.selcloud.ru header.i=@mail.selcloud.ru header.b="TNpWOPDW";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=foxido.dev header.i=@foxido.dev header.b="vg7W9a11";
	dkim=pass (2048-bit key) header.d=foxido.dev header.i=@foxido.dev header.b="h1L5eids";
	dkim=permerror (0-bit key) header.d=foxido.dev header.i=@foxido.dev header.b="wi5KxUWA"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from sender6.mail.selcloud.ru (sender6.mail.selcloud.ru [5.8.75.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4135135CBB4;
	Wed, 12 Nov 2025 19:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.8.75.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762974523; cv=none; b=NOAvAm9loGBTbzy9LlKu0gMdUzZ9ZWI8PDhq2KlEFKVDjZUdMg1FeyxPb2YIT1VV1Q7AFH2hBCJg99pQ01hkPB5Xyz/Th3bxyB3+Ty6XXET1gHfSQihNymtbkotBQ7QftW9cNee7mos2JLltyQoGt8h0/HR06tT7DpkryEP94jM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762974523; c=relaxed/simple;
	bh=QCB8WwHikwN2bJrZbqk/9i+LkdWvHBlkrd+J7dbaMr4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sKoV6/8mkuEyFSya1Wn8ePBdNUZNFAndpMX4iURtOdZ7znYBUjfRvvNNrI0JSUgZUr7Vy1IPxEpqs2cZHE/j1iy+f6M7V6DA5SAIHXblTirNX0rZva5EHZA6nGNIdi+RSzF1659/zpGsc1DkNR78hyrn3dDHp48oSVOyUzl78+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=foxido.dev; spf=pass smtp.mailfrom=mail.selcloud.ru; dkim=pass (1024-bit key) header.d=mail.selcloud.ru header.i=@mail.selcloud.ru header.b=TNpWOPDW; dkim=pass (1024-bit key) header.d=foxido.dev header.i=@foxido.dev header.b=vg7W9a11; dkim=pass (2048-bit key) header.d=foxido.dev header.i=@foxido.dev header.b=h1L5eids; dkim=permerror (0-bit key) header.d=foxido.dev header.i=@foxido.dev header.b=wi5KxUWA; arc=none smtp.client-ip=5.8.75.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=foxido.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.selcloud.ru
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=mail.selcloud.ru; s=selcloud; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:List-id:
	List-Unsubscribe:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Help:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=pSekVts3jD0eHpg+BeWNXTywBInmBdwKGn+yLSuE7Mg=; t=1762974520; x=1763147320;
	 b=TNpWOPDWAeYJbgw7KvfB3bcOpgYEZay789IAhOcacusLAdh2FvBsjQj8qwN1ghK32FShD806fw
	BNVY8moROvkr1NLsXTeMWd784FpiZSmMF0G4wi/rqKDn1qF+jym4C6fZOQJKSBeLILaWeuZw9SuAS
	xeGADTSLp2MpsoYDwjBc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=foxido.dev;
	 s=selcloud; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:List-id:List-Unsubscribe:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=pSekVts3jD0eHpg+BeWNXTywBInmBdwKGn+yLSuE7Mg=; t=1762974520; x=1763147320;
	 b=vg7W9a11BvUprMN63EEurkS2CbcsAzc9sKDnPgamNDaf6no/RinFFyLSkSl794sYFBKdHYY+W/
	nzaMOxQp5BZzg9IJEweTAyqyT7YkHzTnYAkIEjo81a8uKExgF7tav8c40VA3LH4gR5kQ+M9YLWqhS
	EXo5yuPSEiN93pEfvNws=;
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
X-SMTPUID: mlgnr60
DKIM-Signature: v=1; a=rsa-sha256; s=202508r; d=foxido.dev; c=relaxed/relaxed;
	h=Message-ID:Date:Subject:To:From; t=1762973419; bh=pSekVts3jD0eHpg+BeWNXTy
	wBInmBdwKGn+yLSuE7Mg=; b=h1L5eidsmVd5RjWd+qgJzUrL0MHIS86m4RI8tMp2YWPwuMS+YH
	xobP7WGPcFM3e9q15b3nwLGUUvSEVX4rj/6urAYMgMPihyi4lbIGhwnS46mORXqsF3yxnrwaHNn
	bhyA6s3uDS1s6CSfuB1ajFlpOdx3ySrhLtD0+cE4U/vSWa8VLeJVDYrwuYIB/6fKxTq+9F1t/yz
	ecvlqQjCRmmwLBnEWtURhlMeHZrXaAOhRZU3a5DaN1/79LJgq0XGqPppehUlbBqikV0XspYZ/8A
	J5D2fnFSefE26laVkOGuDALc/nrVJIeTlZx0UB5utAIbyh7jr+jo9+BRDQJAOL+n6Vw==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202508e; d=foxido.dev; c=relaxed/relaxed;
	h=Message-ID:Date:Subject:To:From; t=1762973419; bh=pSekVts3jD0eHpg+BeWNXTy
	wBInmBdwKGn+yLSuE7Mg=; b=wi5KxUWA9gXZMSPjwha2G7k6NJTg3Y6PnLbc6gCIhX9FYRDwjY
	bDOG9NwWKzCDvTQgt4K3mpFUbVUrEpmibKCA==;
From: Gladyshev Ilya <foxido@foxido.dev>
To: foxido@foxido.dev
Cc: Chris Mason <clm@fb.com>,
	David Sterba <dsterba@suse.com>,
	linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 6/8] btrfs: simplify cleanup via scoped_guard()
Date: Wed, 12 Nov 2025 21:49:42 +0300
Message-ID: <b483e6140d82a068c332b3f15fc6ef11dd438695.1762972845.git.foxido@foxido.dev>
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

Simplify cases with multiple unlock paths like

spin_lock(&lock);
if (something) {
        spin_unlock(&lock);
        goto faraway; // or return
}
spin_unlock(&lock);

with scoped_guards() to improve readability and robustness.

Signed-off-by: Gladyshev Ilya <foxido@foxido.dev>
---
 fs/btrfs/block-group.c      | 20 +++++-------
 fs/btrfs/compression.c      | 13 ++++----
 fs/btrfs/extent-tree.c      |  8 ++---
 fs/btrfs/extent_io.c        | 33 +++++++++----------
 fs/btrfs/free-space-cache.c | 63 +++++++++++++++----------------------
 fs/btrfs/qgroup.c           | 38 +++++++++++-----------
 fs/btrfs/send.c             | 37 ++++++++++------------
 fs/btrfs/tree-log.c         | 13 +++-----
 8 files changed, 97 insertions(+), 128 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 0ef8917e7a71..73c283344ea4 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -93,13 +93,11 @@ static u64 btrfs_reduce_alloc_profile(struct btrfs_fs_info *fs_info, u64 flags)
 	 * See if restripe for this chunk_type is in progress, if so try to
 	 * reduce to the target profile
 	 */
-	spin_lock(&fs_info->balance_lock);
-	target = get_restripe_target(fs_info, flags);
-	if (target) {
-		spin_unlock(&fs_info->balance_lock);
-		return extended_to_chunk(target);
+	scoped_guard(spinlock, &fs_info->balance_lock) {
+		target = get_restripe_target(fs_info, flags);
+		if (target)
+			return extended_to_chunk(target);
 	}
-	spin_unlock(&fs_info->balance_lock);
 
 	/* First, mask out the RAID levels which aren't possible */
 	for (raid_type = 0; raid_type < BTRFS_NR_RAID_TYPES; raid_type++) {
@@ -3402,13 +3400,11 @@ int btrfs_start_dirty_block_groups(struct btrfs_trans_handle *trans)
 	struct list_head *io = &cur_trans->io_bgs;
 	int loops = 0;
 
-	spin_lock(&cur_trans->dirty_bgs_lock);
-	if (list_empty(&cur_trans->dirty_bgs)) {
-		spin_unlock(&cur_trans->dirty_bgs_lock);
-		return 0;
+	scoped_guard(spinlock, &cur_trans->dirty_bgs_lock) {
+		if (list_empty(&cur_trans->dirty_bgs))
+			return 0;
+		list_splice_init(&cur_trans->dirty_bgs, &dirty);
 	}
-	list_splice_init(&cur_trans->dirty_bgs, &dirty);
-	spin_unlock(&cur_trans->dirty_bgs_lock);
 
 again:
 	/* Make sure all the block groups on our dirty list actually exist */
diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index bacad18357b3..39dbc0b2ead2 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -962,14 +962,13 @@ void btrfs_put_workspace(struct btrfs_fs_info *fs_info, int type, struct list_he
 	ws_wait	 = &gwsm->ws_wait;
 	free_ws	 = &gwsm->free_ws;
 
-	spin_lock(ws_lock);
-	if (*free_ws <= num_online_cpus()) {
-		list_add(ws, idle_ws);
-		(*free_ws)++;
-		spin_unlock(ws_lock);
-		goto wake;
+	scoped_guard(spinlock, ws_lock) {
+		if (*free_ws <= num_online_cpus()) {
+			list_add(ws, idle_ws);
+			(*free_ws)++;
+			goto wake;
+		}
 	}
-	spin_unlock(ws_lock);
 
 	free_workspace(type, ws);
 	atomic_dec(total_ws);
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index dc4ca98c3780..f9744e456c6c 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -2165,12 +2165,10 @@ int btrfs_run_delayed_refs(struct btrfs_trans_handle *trans, u64 min_bytes)
 	if (min_bytes == U64_MAX) {
 		btrfs_create_pending_block_groups(trans);
 
-		spin_lock(&delayed_refs->lock);
-		if (xa_empty(&delayed_refs->head_refs)) {
-			spin_unlock(&delayed_refs->lock);
-			return 0;
+		scoped_guard(spinlock, &delayed_refs->lock) {
+			if (xa_empty(&delayed_refs->head_refs))
+				return 0;
 		}
-		spin_unlock(&delayed_refs->lock);
 
 		cond_resched();
 		goto again;
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 23273d0e6f22..9d7501da2dda 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -4503,27 +4503,24 @@ int try_release_extent_buffer(struct folio *folio)
 	 * We need to make sure nobody is changing folio private, as we rely on
 	 * folio private as the pointer to extent buffer.
 	 */
-	spin_lock(&folio->mapping->i_private_lock);
-	if (!folio_test_private(folio)) {
-		spin_unlock(&folio->mapping->i_private_lock);
-		return 1;
-	}
+	scoped_guard(spinlock, &folio->mapping->i_private_lock) {
+		if (!folio_test_private(folio))
+			return 1;
 
-	eb = folio_get_private(folio);
-	BUG_ON(!eb);
+		eb = folio_get_private(folio);
+		BUG_ON(!eb);
 
-	/*
-	 * This is a little awful but should be ok, we need to make sure that
-	 * the eb doesn't disappear out from under us while we're looking at
-	 * this page.
-	 */
-	spin_lock(&eb->refs_lock);
-	if (refcount_read(&eb->refs) != 1 || extent_buffer_under_io(eb)) {
-		spin_unlock(&eb->refs_lock);
-		spin_unlock(&folio->mapping->i_private_lock);
-		return 0;
+		/*
+		 * This is a little awful but should be ok, we need to make sure that
+		 * the eb doesn't disappear out from under us while we're looking at
+		 * this page.
+		 */
+		spin_lock(&eb->refs_lock);
+		if (refcount_read(&eb->refs) != 1 || extent_buffer_under_io(eb)) {
+			spin_unlock(&eb->refs_lock);
+			return 0;
+		}
 	}
-	spin_unlock(&folio->mapping->i_private_lock);
 
 	/*
 	 * If tree ref isn't set then we know the ref on this eb is a real ref,
diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
index 7ad3f635576e..5e5560043eeb 100644
--- a/fs/btrfs/free-space-cache.c
+++ b/fs/btrfs/free-space-cache.c
@@ -958,12 +958,10 @@ int load_free_space_cache(struct btrfs_block_group *block_group)
 	 * If this block group has been marked to be cleared for one reason or
 	 * another then we can't trust the on disk cache, so just return.
 	 */
-	spin_lock(&block_group->lock);
-	if (block_group->disk_cache_state != BTRFS_DC_WRITTEN) {
-		spin_unlock(&block_group->lock);
-		return 0;
+	scoped_guard(spinlock, &block_group->lock) {
+		if (block_group->disk_cache_state != BTRFS_DC_WRITTEN)
+			return 0;
 	}
-	spin_unlock(&block_group->lock);
 
 	path = btrfs_alloc_path();
 	if (!path)
@@ -1525,12 +1523,10 @@ int btrfs_write_out_cache(struct btrfs_trans_handle *trans,
 	struct inode *inode;
 	int ret = 0;
 
-	spin_lock(&block_group->lock);
-	if (block_group->disk_cache_state < BTRFS_DC_SETUP) {
-		spin_unlock(&block_group->lock);
-		return 0;
+	scoped_guard(spinlock, &block_group->lock) {
+		if (block_group->disk_cache_state < BTRFS_DC_SETUP)
+			return 0;
 	}
-	spin_unlock(&block_group->lock);
 
 	inode = lookup_free_space_inode(block_group, path);
 	if (IS_ERR(inode))
@@ -3154,20 +3150,17 @@ void btrfs_return_cluster_to_free_space(
 	struct btrfs_free_space_ctl *ctl;
 
 	/* first, get a safe pointer to the block group */
-	spin_lock(&cluster->lock);
-	if (!block_group) {
-		block_group = cluster->block_group;
+	scoped_guard(spinlock, &cluster->lock) {
 		if (!block_group) {
-			spin_unlock(&cluster->lock);
+			block_group = cluster->block_group;
+			if (!block_group)
+				return;
+		} else if (cluster->block_group != block_group) {
+			/* someone else has already freed it don't redo their work */
 			return;
 		}
-	} else if (cluster->block_group != block_group) {
-		/* someone else has already freed it don't redo their work */
-		spin_unlock(&cluster->lock);
-		return;
+		btrfs_get_block_group(block_group);
 	}
-	btrfs_get_block_group(block_group);
-	spin_unlock(&cluster->lock);
 
 	ctl = block_group->free_space_ctl;
 
@@ -4018,13 +4011,11 @@ int btrfs_trim_block_group(struct btrfs_block_group *block_group,
 
 	*trimmed = 0;
 
-	spin_lock(&block_group->lock);
-	if (test_bit(BLOCK_GROUP_FLAG_REMOVED, &block_group->runtime_flags)) {
-		spin_unlock(&block_group->lock);
-		return 0;
+	scoped_guard(spinlock, &block_group->lock) {
+		if (test_bit(BLOCK_GROUP_FLAG_REMOVED, &block_group->runtime_flags))
+			return 0;
+		btrfs_freeze_block_group(block_group);
 	}
-	btrfs_freeze_block_group(block_group);
-	spin_unlock(&block_group->lock);
 
 	ret = trim_no_bitmap(block_group, trimmed, start, end, minlen, false);
 	if (ret)
@@ -4048,13 +4039,11 @@ int btrfs_trim_block_group_extents(struct btrfs_block_group *block_group,
 
 	*trimmed = 0;
 
-	spin_lock(&block_group->lock);
-	if (test_bit(BLOCK_GROUP_FLAG_REMOVED, &block_group->runtime_flags)) {
-		spin_unlock(&block_group->lock);
-		return 0;
+	scoped_guard(spinlock, &block_group->lock) {
+		if (test_bit(BLOCK_GROUP_FLAG_REMOVED, &block_group->runtime_flags))
+			return 0;
+		btrfs_freeze_block_group(block_group);
 	}
-	btrfs_freeze_block_group(block_group);
-	spin_unlock(&block_group->lock);
 
 	ret = trim_no_bitmap(block_group, trimmed, start, end, minlen, async);
 	btrfs_unfreeze_block_group(block_group);
@@ -4070,13 +4059,11 @@ int btrfs_trim_block_group_bitmaps(struct btrfs_block_group *block_group,
 
 	*trimmed = 0;
 
-	spin_lock(&block_group->lock);
-	if (test_bit(BLOCK_GROUP_FLAG_REMOVED, &block_group->runtime_flags)) {
-		spin_unlock(&block_group->lock);
-		return 0;
+	scoped_guard(spinlock, &block_group->lock) {
+		if (test_bit(BLOCK_GROUP_FLAG_REMOVED, &block_group->runtime_flags))
+			return 0;
+		btrfs_freeze_block_group(block_group);
 	}
-	btrfs_freeze_block_group(block_group);
-	spin_unlock(&block_group->lock);
 
 	ret = trim_bitmaps(block_group, trimmed, start, end, minlen, maxlen,
 			   async);
diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
index b76fc5474ae9..9b2f2c8ca505 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -4791,29 +4791,27 @@ int btrfs_qgroup_trace_subtree_after_cow(struct btrfs_trans_handle *trans,
 	if (!btrfs_is_fstree(btrfs_root_id(root)) || !root->reloc_root)
 		return 0;
 
-	spin_lock(&blocks->lock);
-	if (!blocks->swapped) {
-		spin_unlock(&blocks->lock);
-		return 0;
-	}
-	node = rb_find(&subvol_eb->start, &blocks->blocks[level],
-			qgroup_swapped_block_bytenr_key_cmp);
-	if (!node) {
-		spin_unlock(&blocks->lock);
-		goto out;
-	}
-	block = rb_entry(node, struct btrfs_qgroup_swapped_block, node);
+	scoped_guard(spinlock, &blocks->lock) {
+		if (!blocks->swapped)
+			return 0;
 
-	/* Found one, remove it from @blocks first and update blocks->swapped */
-	rb_erase(&block->node, &blocks->blocks[level]);
-	for (i = 0; i < BTRFS_MAX_LEVEL; i++) {
-		if (RB_EMPTY_ROOT(&blocks->blocks[i])) {
-			swapped = true;
-			break;
+		node = rb_find(&subvol_eb->start, &blocks->blocks[level],
+			       qgroup_swapped_block_bytenr_key_cmp);
+		if (!node)
+			goto out;
+
+		block = rb_entry(node, struct btrfs_qgroup_swapped_block, node);
+
+		/* Found one, remove it from @blocks first and update blocks->swapped */
+		rb_erase(&block->node, &blocks->blocks[level]);
+		for (i = 0; i < BTRFS_MAX_LEVEL; i++) {
+			if (RB_EMPTY_ROOT(&blocks->blocks[i])) {
+				swapped = true;
+				break;
+			}
 		}
+		blocks->swapped = swapped;
 	}
-	blocks->swapped = swapped;
-	spin_unlock(&blocks->lock);
 
 	check.level = block->level;
 	check.transid = block->reloc_generation;
diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index e7e33c9feca0..5af63c71a01a 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -8020,27 +8020,24 @@ long btrfs_ioctl_send(struct btrfs_root *send_root, const struct btrfs_ioctl_sen
 	 * The subvolume must remain read-only during send, protect against
 	 * making it RW. This also protects against deletion.
 	 */
-	spin_lock(&send_root->root_item_lock);
-	/*
-	 * Unlikely but possible, if the subvolume is marked for deletion but
-	 * is slow to remove the directory entry, send can still be started.
-	 */
-	if (btrfs_root_dead(send_root)) {
-		spin_unlock(&send_root->root_item_lock);
-		return -EPERM;
-	}
-	/* Userspace tools do the checks and warn the user if it's not RO. */
-	if (!btrfs_root_readonly(send_root)) {
-		spin_unlock(&send_root->root_item_lock);
-		return -EPERM;
-	}
-	if (send_root->dedupe_in_progress) {
-		dedupe_in_progress_warn(send_root);
-		spin_unlock(&send_root->root_item_lock);
-		return -EAGAIN;
+	scoped_guard(spinlock, &send_root->root_item_lock) {
+		/*
+		 * Unlikely but possible, if the subvolume is marked for deletion but
+		 * is slow to remove the directory entry, send can still be started.
+		 */
+		if (btrfs_root_dead(send_root))
+			return -EPERM;
+
+		/* Userspace tools do the checks and warn the user if it's not RO. */
+		if (!btrfs_root_readonly(send_root))
+			return -EPERM;
+
+		if (send_root->dedupe_in_progress) {
+			dedupe_in_progress_warn(send_root);
+			return -EAGAIN;
+		}
+		send_root->send_in_progress++;
 	}
-	send_root->send_in_progress++;
-	spin_unlock(&send_root->root_item_lock);
 
 	/*
 	 * Check that we don't overflow at later allocations, we request
diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index e7a9e9582246..f6ce72f0fbcb 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -3750,15 +3750,12 @@ static int inode_logged(const struct btrfs_trans_handle *trans,
 	 * see a positive value that is not trans->transid and assume the inode
 	 * was not logged when it was.
 	 */
-	spin_lock(&inode->lock);
-	if (inode->logged_trans == trans->transid) {
-		spin_unlock(&inode->lock);
-		return 1;
-	} else if (inode->logged_trans > 0) {
-		spin_unlock(&inode->lock);
-		return 0;
+	scoped_guard(spinlock, &inode->lock) {
+		if (inode->logged_trans == trans->transid)
+			return 1;
+		else if (inode->logged_trans > 0)
+			return 0;
 	}
-	spin_unlock(&inode->lock);
 
 	/*
 	 * If no log tree was created for this root in this transaction, then
-- 
2.51.1.dirty


