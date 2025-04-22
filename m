Return-Path: <linux-btrfs+bounces-13249-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E9224A9727B
	for <lists+linux-btrfs@lfdr.de>; Tue, 22 Apr 2025 18:23:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C405400C60
	for <lists+linux-btrfs@lfdr.de>; Tue, 22 Apr 2025 16:21:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C3D6290BAC;
	Tue, 22 Apr 2025 16:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="NG/nc5N/";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="NG/nc5N/"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A65B028F527
	for <linux-btrfs@vger.kernel.org>; Tue, 22 Apr 2025 16:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745338926; cv=none; b=nJCRSXn/ugIlqYugLTwK3dBNWNmgfRiEjMFxEpZ7aX7cnmiIgJ+/h7xO45rsP2tXI6aj9BbrodC5BhpK9e7u3SjxsE/5jxBc9gjoTFq617oQOtZi997a7B9DZW3Lqj581zLSLBOLoDCjkal8r3kk/hpP2Znmdz5jLO3/7yE+VlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745338926; c=relaxed/simple;
	bh=F7fkSnXN1vXD/rvxwqchYkuxwjjkTvH28yU/7PW8qh0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Sp3ocS+rZrkCOg+/hlWeMQoWi28rZziNT1AHSor4cthLObp95vK7f09Zt7wMJYVHQqQdZYmwFAC8ZkYr6ytJ2dEfIHxnfsYUaIcelN/r58ly72EmUJUzpFEO4MEkQZ1t76/8Yju2OW8eAW3DK89fXM6rG0FeCrEdUbvVbpF50I4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=NG/nc5N/; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=NG/nc5N/; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 92DFD1F38D;
	Tue, 22 Apr 2025 16:22:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1745338920; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=oFbTcQ+rNLerVAnJpCP/gFe7cv+/gF0X0FDO4aH3SD0=;
	b=NG/nc5N/m8bImY4WBBPWXx57rbqIf+uOdQAkNQ8kuv0x1PZX23ecnMVFVuvhsQN5BILn/O
	xGbrorA2Ut6OlPqOIdm33RvbTmWSGQqR7YBQ0eEqIVemMxWIADQ8oGtIkg641V0d8A3Mwt
	Zd87RTNq97tA0hWDEUYjBDDJN+WVgAI=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1745338920; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=oFbTcQ+rNLerVAnJpCP/gFe7cv+/gF0X0FDO4aH3SD0=;
	b=NG/nc5N/m8bImY4WBBPWXx57rbqIf+uOdQAkNQ8kuv0x1PZX23ecnMVFVuvhsQN5BILn/O
	xGbrorA2Ut6OlPqOIdm33RvbTmWSGQqR7YBQ0eEqIVemMxWIADQ8oGtIkg641V0d8A3Mwt
	Zd87RTNq97tA0hWDEUYjBDDJN+WVgAI=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8B81D137CF;
	Tue, 22 Apr 2025 16:22:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 6IQJIijCB2h8bwAAD6G6ig
	(envelope-from <dsterba@suse.com>); Tue, 22 Apr 2025 16:22:00 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH] btrfs: use list_first_entry() everywhere
Date: Tue, 22 Apr 2025 18:21:51 +0200
Message-ID: <20250422162151.390526-1-dsterba@suse.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email,suse.com:mid];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Score: -2.80
X-Spam-Flag: NO

Using the helper makes it a bit more clear that we're accessing the
first list entry.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/async-thread.c     |  3 +--
 fs/btrfs/backref.c          |  8 ++++----
 fs/btrfs/block-group.c      |  9 ++++-----
 fs/btrfs/disk-io.c          |  4 ++--
 fs/btrfs/extent-io-tree.c   |  2 +-
 fs/btrfs/free-space-cache.c | 10 ++++------
 fs/btrfs/inode.c            |  6 +++---
 fs/btrfs/raid56.c           |  9 ++++-----
 fs/btrfs/relocation.c       | 36 +++++++++++++++++-------------------
 fs/btrfs/send.c             |  5 ++---
 fs/btrfs/tree-log.c         | 14 +++++++-------
 fs/btrfs/volumes.c          |  8 ++++----
 12 files changed, 53 insertions(+), 61 deletions(-)

diff --git a/fs/btrfs/async-thread.c b/fs/btrfs/async-thread.c
index f3bffe08b290aa..6c6f3bb58f4ead 100644
--- a/fs/btrfs/async-thread.c
+++ b/fs/btrfs/async-thread.c
@@ -219,8 +219,7 @@ static void run_ordered_work(struct btrfs_workqueue *wq,
 		spin_lock_irqsave(lock, flags);
 		if (list_empty(list))
 			break;
-		work = list_entry(list->next, struct btrfs_work,
-				  ordered_list);
+		work = list_first_entry(list, struct btrfs_work, ordered_list);
 		if (!test_bit(WORK_DONE_BIT, &work->flags))
 			break;
 		/*
diff --git a/fs/btrfs/backref.c b/fs/btrfs/backref.c
index 5936cff80ff3d3..b1c39455e92716 100644
--- a/fs/btrfs/backref.c
+++ b/fs/btrfs/backref.c
@@ -3134,8 +3134,8 @@ void btrfs_backref_cleanup_node(struct btrfs_backref_cache *cache,
 		return;
 
 	while (!list_empty(&node->upper)) {
-		edge = list_entry(node->upper.next, struct btrfs_backref_edge,
-				  list[LOWER]);
+		edge = list_first_entry(&node->upper, struct btrfs_backref_edge,
+					list[LOWER]);
 		list_del(&edge->list[LOWER]);
 		list_del(&edge->list[UPPER]);
 		btrfs_backref_free_edge(cache, edge);
@@ -3473,8 +3473,8 @@ int btrfs_backref_add_tree_node(struct btrfs_trans_handle *trans,
 		 * type BTRFS_TREE_BLOCK_REF_KEY
 		 */
 		ASSERT(list_is_singular(&cur->upper));
-		edge = list_entry(cur->upper.next, struct btrfs_backref_edge,
-				  list[LOWER]);
+		edge = list_first_entry(&cur->upper, struct btrfs_backref_edge,
+					list[LOWER]);
 		ASSERT(list_empty(&edge->list[UPPER]));
 		exist = edge->node[UPPER];
 		/*
diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 91807d29436699..1a37066afccff2 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -4425,8 +4425,8 @@ int btrfs_free_block_groups(struct btrfs_fs_info *info)
 
 	write_lock(&info->block_group_cache_lock);
 	while (!list_empty(&info->caching_block_groups)) {
-		caching_ctl = list_entry(info->caching_block_groups.next,
-					 struct btrfs_caching_control, list);
+		caching_ctl = list_first_entry(&info->caching_block_groups,
+					       struct btrfs_caching_control, list);
 		list_del(&caching_ctl->list);
 		btrfs_put_caching_control(caching_ctl);
 	}
@@ -4497,9 +4497,8 @@ int btrfs_free_block_groups(struct btrfs_fs_info *info)
 	btrfs_release_global_block_rsv(info);
 
 	while (!list_empty(&info->space_info)) {
-		space_info = list_entry(info->space_info.next,
-					struct btrfs_space_info,
-					list);
+		space_info = list_first_entry(&info->space_info,
+					      struct btrfs_space_info, list);
 
 		/*
 		 * Do not hide this behind enospc_debug, this is actually
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 280bc0ee60465f..8252d41ba242dc 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -1857,8 +1857,8 @@ void btrfs_free_fs_roots(struct btrfs_fs_info *fs_info)
 	int i;
 
 	while (!list_empty(&fs_info->dead_roots)) {
-		gang[0] = list_entry(fs_info->dead_roots.next,
-				     struct btrfs_root, root_list);
+		gang[0] = list_first_entry(&fs_info->dead_roots,
+					   struct btrfs_root, root_list);
 		list_del(&gang[0]->root_list);
 
 		if (test_bit(BTRFS_ROOT_IN_RADIX, &gang[0]->state))
diff --git a/fs/btrfs/extent-io-tree.c b/fs/btrfs/extent-io-tree.c
index cae3980f4291c0..9f4f5829c55ca6 100644
--- a/fs/btrfs/extent-io-tree.c
+++ b/fs/btrfs/extent-io-tree.c
@@ -42,7 +42,7 @@ static inline void btrfs_extent_state_leak_debug_check(void)
 	struct extent_state *state;
 
 	while (!list_empty(&states)) {
-		state = list_entry(states.next, struct extent_state, leak_list);
+		state = list_first_entry(&states, struct extent_state, leak_list);
 		pr_err("BTRFS: state leak: start %llu end %llu state %u in tree %d refs %d\n",
 		       state->start, state->end, state->state,
 		       extent_state_in_tree(state),
diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
index 3c4dbe160f13d4..b9ec7de990c91c 100644
--- a/fs/btrfs/free-space-cache.c
+++ b/fs/btrfs/free-space-cache.c
@@ -1071,9 +1071,8 @@ int write_cache_extent_entries(struct btrfs_io_ctl *io_ctl,
 
 	/* Get the cluster for this block_group if it exists */
 	if (block_group && !list_empty(&block_group->cluster_list)) {
-		cluster = list_entry(block_group->cluster_list.next,
-				     struct btrfs_free_cluster,
-				     block_group_list);
+		cluster = list_first_entry(&block_group->cluster_list,
+					   struct btrfs_free_cluster, block_group_list);
 	}
 
 	if (!node && cluster) {
@@ -2333,9 +2332,8 @@ static int insert_into_bitmap(struct btrfs_free_space_ctl *ctl,
 		struct rb_node *node;
 		struct btrfs_free_space *entry;
 
-		cluster = list_entry(block_group->cluster_list.next,
-				     struct btrfs_free_cluster,
-				     block_group_list);
+		cluster = list_first_entry(&block_group->cluster_list,
+					   struct btrfs_free_cluster, block_group_list);
 		spin_lock(&cluster->lock);
 		node = rb_first(&cluster->root);
 		if (!node) {
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 652db811e5cabd..1f54f1954715f9 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -1563,8 +1563,8 @@ static noinline void submit_compressed_extents(struct btrfs_work *work, bool do_
 		PAGE_SHIFT;
 
 	while (!list_empty(&async_chunk->extents)) {
-		async_extent = list_entry(async_chunk->extents.next,
-					  struct async_extent, list);
+		async_extent = list_first_entry(&async_chunk->extents,
+						struct async_extent, list);
 		list_del(&async_extent->list);
 		submit_one_async_extent(async_chunk, async_extent, &alloc_hint);
 	}
@@ -8518,7 +8518,7 @@ static int start_delalloc_inodes(struct btrfs_root *root,
 		struct btrfs_inode *inode;
 		struct inode *tmp_inode;
 
-		inode = list_entry(splice.next, struct btrfs_inode, delalloc_inodes);
+		inode = list_first_entry(&splice, struct btrfs_inode, delalloc_inodes);
 
 		list_move_tail(&inode->delalloc_inodes, &root->delalloc_inodes);
 
diff --git a/fs/btrfs/raid56.c b/fs/btrfs/raid56.c
index 4657517f5480b7..90b3ebf3b443ad 100644
--- a/fs/btrfs/raid56.c
+++ b/fs/btrfs/raid56.c
@@ -519,9 +519,8 @@ static void btrfs_clear_rbio_cache(struct btrfs_fs_info *info)
 
 	spin_lock(&table->cache_lock);
 	while (!list_empty(&table->stripe_cache)) {
-		rbio = list_entry(table->stripe_cache.next,
-				  struct btrfs_raid_bio,
-				  stripe_cache);
+		rbio = list_first_entry(&table->stripe_cache,
+					struct btrfs_raid_bio, stripe_cache);
 		__remove_rbio_from_cache(rbio);
 	}
 	spin_unlock(&table->cache_lock);
@@ -1702,8 +1701,8 @@ static void raid_unplug(struct blk_plug_cb *cb, bool from_schedule)
 	list_sort(NULL, &plug->rbio_list, plug_cmp);
 
 	while (!list_empty(&plug->rbio_list)) {
-		cur = list_entry(plug->rbio_list.next,
-				 struct btrfs_raid_bio, plug_list);
+		cur = list_first_entry(&plug->rbio_list,
+				       struct btrfs_raid_bio, plug_list);
 		list_del_init(&cur->plug_list);
 
 		if (rbio_is_full(cur)) {
diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 19acdd9ede7964..45570a242c6685 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -196,8 +196,8 @@ static struct btrfs_backref_node *walk_up_backref(
 	int idx = *index;
 
 	while (!list_empty(&node->upper)) {
-		edge = list_entry(node->upper.next,
-				  struct btrfs_backref_edge, list[LOWER]);
+		edge = list_first_entry(&node->upper, struct btrfs_backref_edge,
+					list[LOWER]);
 		edges[idx++] = edge;
 		node = edge->node[UPPER];
 	}
@@ -223,8 +223,8 @@ static struct btrfs_backref_node *walk_down_backref(
 			idx--;
 			continue;
 		}
-		edge = list_entry(edge->list[LOWER].next,
-				  struct btrfs_backref_edge, list[LOWER]);
+		edge = list_first_entry(&edge->list[LOWER], struct btrfs_backref_edge,
+					list[LOWER]);
 		edges[idx - 1] = edge;
 		*index = idx;
 		return edge->node[UPPER];
@@ -348,8 +348,8 @@ static bool handle_useless_nodes(struct reloc_control *rc,
 			struct btrfs_backref_edge *edge;
 			struct btrfs_backref_node *lower;
 
-			edge = list_entry(cur->lower.next,
-					struct btrfs_backref_edge, list[UPPER]);
+			edge = list_first_entry(&cur->lower, struct btrfs_backref_edge,
+						list[UPPER]);
 			list_del(&edge->list[UPPER]);
 			list_del(&edge->list[LOWER]);
 			lower = edge->node[LOWER];
@@ -1698,8 +1698,8 @@ int prepare_to_merge(struct reloc_control *rc, int err)
 	rc->merge_reloc_tree = true;
 
 	while (!list_empty(&rc->reloc_roots)) {
-		reloc_root = list_entry(rc->reloc_roots.next,
-					struct btrfs_root, root_list);
+		reloc_root = list_first_entry(&rc->reloc_roots,
+					      struct btrfs_root, root_list);
 		list_del_init(&reloc_root->root_list);
 
 		root = btrfs_get_fs_root(fs_info, reloc_root->root_key.offset,
@@ -1814,8 +1814,7 @@ void merge_reloc_roots(struct reloc_control *rc)
 
 	while (!list_empty(&reloc_roots)) {
 		found = 1;
-		reloc_root = list_entry(reloc_roots.next,
-					struct btrfs_root, root_list);
+		reloc_root = list_first_entry(&reloc_roots, struct btrfs_root, root_list);
 
 		root = btrfs_get_fs_root(fs_info, reloc_root->root_key.offset,
 					 false);
@@ -2110,8 +2109,8 @@ static noinline_for_stack u64 calcu_metadata_size(struct reloc_control *rc,
 			if (list_empty(&next->upper))
 				break;
 
-			edge = list_entry(next->upper.next,
-					struct btrfs_backref_edge, list[LOWER]);
+			edge = list_first_entry(&next->upper, struct btrfs_backref_edge,
+						list[LOWER]);
 			edges[index++] = edge;
 			next = edge->node[UPPER];
 		}
@@ -2357,8 +2356,8 @@ static int finish_pending_nodes(struct btrfs_trans_handle *trans,
 
 	for (level = 0; level < BTRFS_MAX_LEVEL; level++) {
 		while (!list_empty(&cache->pending[level])) {
-			node = list_entry(cache->pending[level].next,
-					  struct btrfs_backref_node, list);
+			node = list_first_entry(&cache->pending[level],
+						struct btrfs_backref_node, list);
 			list_move_tail(&node->list, &list);
 			BUG_ON(!node->pending);
 
@@ -2396,8 +2395,8 @@ static void update_processed_blocks(struct reloc_control *rc,
 			if (list_empty(&next->upper))
 				break;
 
-			edge = list_entry(next->upper.next,
-					struct btrfs_backref_edge, list[LOWER]);
+			edge = list_first_entry(&next->upper, struct btrfs_backref_edge,
+						list[LOWER]);
 			edges[index++] = edge;
 			next = edge->node[UPPER];
 		}
@@ -4183,8 +4182,7 @@ int btrfs_recover_relocation(struct btrfs_fs_info *fs_info)
 	rc->merge_reloc_tree = true;
 
 	while (!list_empty(&reloc_roots)) {
-		reloc_root = list_entry(reloc_roots.next,
-					struct btrfs_root, root_list);
+		reloc_root = list_first_entry(&reloc_roots, struct btrfs_root, root_list);
 		list_del(&reloc_root->root_list);
 
 		if (btrfs_root_refs(&reloc_root->root_item) == 0) {
@@ -4277,7 +4275,7 @@ int btrfs_reloc_clone_csums(struct btrfs_ordered_extent *ordered)
 
 	while (!list_empty(&list)) {
 		struct btrfs_ordered_sum *sums =
-			list_entry(list.next, struct btrfs_ordered_sum, list);
+			list_first_entry(&list, struct btrfs_ordered_sum, list);
 
 		list_del_init(&sums->list);
 
diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index f0e49a813ccbbf..96a7ef9a4451bb 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -3098,7 +3098,7 @@ static void __free_recorded_refs(struct list_head *head)
 	struct recorded_ref *cur;
 
 	while (!list_empty(head)) {
-		cur = list_entry(head->next, struct recorded_ref, list);
+		cur = list_first_entry(head, struct recorded_ref, list);
 		recorded_ref_free(cur);
 	}
 }
@@ -4560,8 +4560,7 @@ static int process_recorded_refs(struct send_ctx *sctx, int *pending_move)
 		/*
 		 * We have a moved dir. Add the old parent to check_dirs
 		 */
-		cur = list_entry(sctx->deleted_refs.next, struct recorded_ref,
-				list);
+		cur = list_first_entry(&sctx->deleted_refs, struct recorded_ref, list);
 		ret = dup_ref(cur, &check_dirs);
 		if (ret < 0)
 			goto out;
diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 411dad8860a8f8..97e933113b822f 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -860,9 +860,9 @@ static noinline int replay_one_extent(struct btrfs_trans_handle *trans,
 				struct btrfs_ordered_sum *sums;
 				struct btrfs_root *csum_root;
 
-				sums = list_entry(ordered_sums.next,
-						struct btrfs_ordered_sum,
-						list);
+				sums = list_first_entry(&ordered_sums,
+							struct btrfs_ordered_sum,
+							list);
 				csum_root = btrfs_csum_root(fs_info,
 							    sums->logical);
 				if (!ret)
@@ -4667,9 +4667,9 @@ static int log_extent_csums(struct btrfs_trans_handle *trans,
 	ret = 0;
 
 	while (!list_empty(&ordered_sums)) {
-		struct btrfs_ordered_sum *sums = list_entry(ordered_sums.next,
-						   struct btrfs_ordered_sum,
-						   list);
+		struct btrfs_ordered_sum *sums = list_first_entry(&ordered_sums,
+								  struct btrfs_ordered_sum,
+								  list);
 		if (!ret)
 			ret = log_csums(trans, inode, log_root, sums);
 		list_del(&sums->list);
@@ -4947,7 +4947,7 @@ static int btrfs_log_changed_extents(struct btrfs_trans_handle *trans,
 	list_sort(NULL, &extents, extent_cmp);
 process:
 	while (!list_empty(&extents)) {
-		em = list_entry(extents.next, struct extent_map, list);
+		em = list_first_entry(&extents, struct extent_map, list);
 
 		list_del_init(&em->list);
 
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 4d5c59083003ff..37083708d93cb1 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -415,8 +415,8 @@ static void free_fs_devices(struct btrfs_fs_devices *fs_devices)
 
 	WARN_ON(fs_devices->opened);
 	while (!list_empty(&fs_devices->devices)) {
-		device = list_entry(fs_devices->devices.next,
-				    struct btrfs_device, dev_list);
+		device = list_first_entry(&fs_devices->devices,
+					  struct btrfs_device, dev_list);
 		list_del(&device->dev_list);
 		btrfs_free_device(device);
 	}
@@ -428,8 +428,8 @@ void __exit btrfs_cleanup_fs_uuids(void)
 	struct btrfs_fs_devices *fs_devices;
 
 	while (!list_empty(&fs_uuids)) {
-		fs_devices = list_entry(fs_uuids.next,
-					struct btrfs_fs_devices, fs_list);
+		fs_devices = list_first_entry(&fs_uuids, struct btrfs_fs_devices,
+					      fs_list);
 		list_del(&fs_devices->fs_list);
 		free_fs_devices(fs_devices);
 	}
-- 
2.49.0


