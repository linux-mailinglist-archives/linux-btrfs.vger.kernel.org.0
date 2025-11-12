Return-Path: <linux-btrfs+bounces-18901-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id D2687C54113
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Nov 2025 20:08:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B287A3471DF
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Nov 2025 19:08:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E2F434E75D;
	Wed, 12 Nov 2025 19:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mail.selcloud.ru header.i=@mail.selcloud.ru header.b="tBzfAJy8";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=foxido.dev header.i=@foxido.dev header.b="dT0BVuCZ";
	dkim=pass (2048-bit key) header.d=foxido.dev header.i=@foxido.dev header.b="WVe4q9Nf";
	dkim=permerror (0-bit key) header.d=foxido.dev header.i=@foxido.dev header.b="2Fc+iwDG"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from sender8.mail.selcloud.ru (sender8.mail.selcloud.ru [5.8.75.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C5B134C83A;
	Wed, 12 Nov 2025 19:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.8.75.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762974477; cv=none; b=E4wL0YjiFG20rsuMR23v8LvKe+Kjxssj6drhON6+l7SKTcTVQobKul2Qf4h1G1m4rsYyhJZ6cmp2x25gnx0WUgDhSxgFCWypaXDYUT3fRUXRelGcKKc0WUT0iKpeRrS/Zhfy68G//8ttM14kk1TOTCNqYHBJDXo4AfwoSJ7hTxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762974477; c=relaxed/simple;
	bh=4PLs+WUgqBx5bFa82SBuvXzcrkcDRh1gMjdrfEzpWTw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eM0AGYhaNGDldPfwpBWIdBvXbts2pfR6PYKw2MeTcQo1DExDeY51IJKVZpwXuAIGQLsmFBspYgZjoHci/AemXkNC6UBPxNteIk5etRToc1BS8UsyL4uHZUcQfJatMJ+KzXaHD17MPg0fiwQ8tj4+u0aWaipthibsyCeqK8rZFpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=foxido.dev; spf=pass smtp.mailfrom=mail.selcloud.ru; dkim=pass (1024-bit key) header.d=mail.selcloud.ru header.i=@mail.selcloud.ru header.b=tBzfAJy8; dkim=pass (1024-bit key) header.d=foxido.dev header.i=@foxido.dev header.b=dT0BVuCZ; dkim=pass (2048-bit key) header.d=foxido.dev header.i=@foxido.dev header.b=WVe4q9Nf; dkim=permerror (0-bit key) header.d=foxido.dev header.i=@foxido.dev header.b=2Fc+iwDG; arc=none smtp.client-ip=5.8.75.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=foxido.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.selcloud.ru
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=mail.selcloud.ru; s=selcloud; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:List-id:
	List-Unsubscribe:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Help:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=H8OlNQEg1ENEo5qBu7hKEVVI6gg5bAmLVgMtxjcxTg8=; t=1762974472; x=1763147272;
	 b=tBzfAJy8eBmqMZYlkYYAgQhmeAMcWVG5LiTPDH+kPnPiGrAeiPY5bFvpCDmcHSrvoqtUf3vLrX
	ADJJwpsaaT2sreK7HsGh5uqtm6ZSNbmy3UujX4Ce9Z5i9TaVSu8RgF9j3APT+Vz78Gn2SMtuqhyUv
	AnfD3sRNiypbTDFPPtpI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=foxido.dev;
	 s=selcloud; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:List-id:List-Unsubscribe:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=H8OlNQEg1ENEo5qBu7hKEVVI6gg5bAmLVgMtxjcxTg8=; t=1762974472; x=1763147272;
	 b=dT0BVuCZKAdgbTFUVZ35VpT9zYECP9CSc1pxWHCavymnla7j+UnVA1KLCOqWFnknI06Dl8/1D8
	pYnbe0bXAK0hKHWt4IpwpJ37FFadPcIpZj4+dJ5XJznokSLb79rSn7r7u56YSl4luoydRP/Kcr8Di
	TSngQsEHr+vjO6UGKAkA=;
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
X-SMTPUID: mlgnr62
DKIM-Signature: v=1; a=rsa-sha256; s=202508r; d=foxido.dev; c=relaxed/relaxed;
	h=Message-ID:Date:Subject:To:From; t=1762973419; bh=H8OlNQEg1ENEo5qBu7hKEVV
	I6gg5bAmLVgMtxjcxTg8=; b=WVe4q9Nf17ncJzF25jOpscKRN4xvhRdX6NVcWITjj6XRDI5ERn
	KPzC39OfprJCmEpd/9Rn50RAGbgSjQPEncGL8h66t+QRLLdVwqzbWUQheMBuxgyTgE3Ecf4OIXv
	YPFDC+XoBodkGYizkVmj8z4Dtb4Ma5ID+gqbHi0LZ2IUBpVYjGIeDSIT97YMLYw9wW+2KU4pKVc
	yBJdQT3i5i2eqMOqdlwtlqoQkPYF2hzVwDMeLi4HMJYCdDpT5Ln3mhBsKSBVX76k/bMJWxc9PhK
	BcJa9xakQghDnnxhUdH5j/nIOObsHT5nt1O+4t22Svy3IgGMq1IWOBEl0vOAAB6rl7Q==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202508e; d=foxido.dev; c=relaxed/relaxed;
	h=Message-ID:Date:Subject:To:From; t=1762973419; bh=H8OlNQEg1ENEo5qBu7hKEVV
	I6gg5bAmLVgMtxjcxTg8=; b=2Fc+iwDGtaOuOKCOMYrAFQG5JzeoeybODXS8d/di1I5vH9VD3J
	uXYTRpEg2dblaLdKjGXRkTZH11tSRhJhUzAg==;
From: Gladyshev Ilya <foxido@foxido.dev>
To: foxido@foxido.dev
Cc: Chris Mason <clm@fb.com>,
	David Sterba <dsterba@suse.com>,
	linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 5/8] btrfs: use cleanup.h guard()s to simplify unlocks on return
Date: Wed, 12 Nov 2025 21:49:41 +0300
Message-ID: <3982cbff072fb85b8fc6a89cd48414d6f457aa37.1762972845.git.foxido@foxido.dev>
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

Simplify cleanup in functions with multiple exit paths / cleanup gotos.
While it's only measurable benefit is slightly reduced code size, it
improves readability and robustness of resource cleanups, eliminating
future errors.

Signed-off-by: Gladyshev Ilya <foxido@foxido.dev>
---
 fs/btrfs/block-group.c      |  4 +--
 fs/btrfs/discard.c          | 10 ++-----
 fs/btrfs/disk-io.c          |  6 ++--
 fs/btrfs/extent-io-tree.c   | 36 +++++++++--------------
 fs/btrfs/file-item.c        |  6 ++--
 fs/btrfs/free-space-cache.c | 20 ++++---------
 fs/btrfs/fs.c               |  9 ++----
 fs/btrfs/ordered-data.c     | 15 ++++------
 fs/btrfs/qgroup.c           | 57 +++++++++++++------------------------
 fs/btrfs/raid56.c           | 13 ++-------
 fs/btrfs/space-info.c       |  4 +--
 fs/btrfs/subpage.c          |  5 +---
 fs/btrfs/tree-log.c         | 15 +++++-----
 fs/btrfs/zoned.c            | 13 +++------
 fs/btrfs/zstd.c             | 13 +++------
 15 files changed, 73 insertions(+), 153 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 5322ef2ae015..0ef8917e7a71 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -416,16 +416,14 @@ struct btrfs_caching_control *btrfs_get_caching_control(
 		struct btrfs_block_group *cache)
 {
 	struct btrfs_caching_control *ctl;
+	guard(spinlock)(&cache->lock);
 
-	spin_lock(&cache->lock);
 	if (!cache->caching_ctl) {
-		spin_unlock(&cache->lock);
 		return NULL;
 	}
 
 	ctl = cache->caching_ctl;
 	refcount_inc(&ctl->count);
-	spin_unlock(&cache->lock);
 	return ctl;
 }
 
diff --git a/fs/btrfs/discard.c b/fs/btrfs/discard.c
index 9bd7a8ad45c4..4dd9f58118bc 100644
--- a/fs/btrfs/discard.c
+++ b/fs/btrfs/discard.c
@@ -129,12 +129,11 @@ static void add_to_discard_unused_list(struct btrfs_discard_ctl *discard_ctl,
 {
 	bool queued;
 
-	spin_lock(&discard_ctl->lock);
+	guard(spinlock)(&discard_ctl->lock);
 
 	queued = !list_empty(&block_group->discard_list);
 
 	if (!btrfs_run_discard_work(discard_ctl)) {
-		spin_unlock(&discard_ctl->lock);
 		return;
 	}
 
@@ -148,8 +147,6 @@ static void add_to_discard_unused_list(struct btrfs_discard_ctl *discard_ctl,
 		btrfs_get_block_group(block_group);
 	list_add_tail(&block_group->discard_list,
 		      &discard_ctl->discard_list[BTRFS_DISCARD_INDEX_UNUSED]);
-
-	spin_unlock(&discard_ctl->lock);
 }
 
 static bool remove_from_discard_list(struct btrfs_discard_ctl *discard_ctl,
@@ -592,7 +589,7 @@ void btrfs_discard_calc_delay(struct btrfs_discard_ctl *discard_ctl)
 	if (!discardable_extents)
 		return;
 
-	spin_lock(&discard_ctl->lock);
+	guard(spinlock)(&discard_ctl->lock);
 
 	/*
 	 * The following is to fix a potential -1 discrepancy that we're not
@@ -611,7 +608,6 @@ void btrfs_discard_calc_delay(struct btrfs_discard_ctl *discard_ctl)
 			     &discard_ctl->discardable_bytes);
 
 	if (discardable_extents <= 0) {
-		spin_unlock(&discard_ctl->lock);
 		return;
 	}
 
@@ -630,8 +626,6 @@ void btrfs_discard_calc_delay(struct btrfs_discard_ctl *discard_ctl)
 
 	delay = clamp(delay, min_delay, BTRFS_DISCARD_MAX_DELAY_MSEC);
 	discard_ctl->delay_ms = delay;
-
-	spin_unlock(&discard_ctl->lock);
 }
 
 /*
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 55c29557c26c..23dd82a944ee 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -1142,12 +1142,10 @@ static struct btrfs_root *btrfs_lookup_fs_root(struct btrfs_fs_info *fs_info,
 {
 	struct btrfs_root *root;
 
-	spin_lock(&fs_info->fs_roots_radix_lock);
+	guard(spinlock)(&fs_info->fs_roots_radix_lock);
 	root = radix_tree_lookup(&fs_info->fs_roots_radix,
 				 (unsigned long)root_id);
-	root = btrfs_grab_root(root);
-	spin_unlock(&fs_info->fs_roots_radix_lock);
-	return root;
+	return btrfs_grab_root(root);
 }
 
 static struct btrfs_root *btrfs_get_global_root(struct btrfs_fs_info *fs_info,
diff --git a/fs/btrfs/extent-io-tree.c b/fs/btrfs/extent-io-tree.c
index 3a9774bc714f..69ea2bd359a6 100644
--- a/fs/btrfs/extent-io-tree.c
+++ b/fs/btrfs/extent-io-tree.c
@@ -987,7 +987,7 @@ bool btrfs_find_delalloc_range(struct extent_io_tree *tree, u64 *start,
 	bool found = false;
 	u64 total_bytes = 0;
 
-	spin_lock(&tree->lock);
+	guard(spinlock)(&tree->lock);
 
 	/*
 	 * This search will find all the extents that end after our range
@@ -996,18 +996,18 @@ bool btrfs_find_delalloc_range(struct extent_io_tree *tree, u64 *start,
 	state = tree_search(tree, cur_start);
 	if (!state) {
 		*end = (u64)-1;
-		goto out;
+		return false;
 	}
 
 	while (state) {
 		if (found && (state->start != cur_start ||
 			      (state->state & EXTENT_BOUNDARY))) {
-			goto out;
+			return true;
 		}
 		if (!(state->state & EXTENT_DELALLOC)) {
 			if (!found)
 				*end = state->end;
-			goto out;
+			return found;
 		}
 		if (!found) {
 			*start = state->start;
@@ -1019,11 +1019,9 @@ bool btrfs_find_delalloc_range(struct extent_io_tree *tree, u64 *start,
 		cur_start = state->end + 1;
 		total_bytes += state->end - state->start + 1;
 		if (total_bytes >= max_bytes)
-			break;
+			return true;
 		state = next_state(state);
 	}
-out:
-	spin_unlock(&tree->lock);
 	return found;
 }
 
@@ -1548,7 +1546,7 @@ void btrfs_find_first_clear_extent_bit(struct extent_io_tree *tree, u64 start,
 	struct extent_state *state;
 	struct extent_state *prev = NULL, *next = NULL;
 
-	spin_lock(&tree->lock);
+	guard(spinlock)(&tree->lock);
 
 	/* Find first extent with bits cleared */
 	while (1) {
@@ -1560,7 +1558,7 @@ void btrfs_find_first_clear_extent_bit(struct extent_io_tree *tree, u64 start,
 			 */
 			*start_ret = 0;
 			*end_ret = -1;
-			goto out;
+			return;
 		} else if (!state && !next) {
 			/*
 			 * We are past the last allocated chunk, set start at
@@ -1568,7 +1566,7 @@ void btrfs_find_first_clear_extent_bit(struct extent_io_tree *tree, u64 start,
 			 */
 			*start_ret = prev->end + 1;
 			*end_ret = -1;
-			goto out;
+			return;
 		} else if (!state) {
 			state = next;
 		}
@@ -1631,8 +1629,6 @@ void btrfs_find_first_clear_extent_bit(struct extent_io_tree *tree, u64 start,
 		}
 		state = next_state(state);
 	}
-out:
-	spin_unlock(&tree->lock);
 }
 
 /*
@@ -1813,12 +1809,11 @@ bool btrfs_test_range_bit(struct extent_io_tree *tree, u64 start, u64 end, u32 b
 			  struct extent_state *cached)
 {
 	struct extent_state *state;
-	bool bitset = true;
 
 	ASSERT(is_power_of_2(bit));
 	ASSERT(start < end);
 
-	spin_lock(&tree->lock);
+	guard(spinlock)(&tree->lock);
 	if (cached && extent_state_in_tree(cached) && cached->start <= start &&
 	    cached->end > start)
 		state = cached;
@@ -1826,17 +1821,15 @@ bool btrfs_test_range_bit(struct extent_io_tree *tree, u64 start, u64 end, u32 b
 		state = tree_search(tree, start);
 	while (state) {
 		if (state->start > start) {
-			bitset = false;
-			break;
+			return false;
 		}
 
 		if ((state->state & bit) == 0) {
-			bitset = false;
-			break;
+			return false;
 		}
 
 		if (state->end >= end)
-			break;
+			return true;
 
 		/* Next state must start where this one ends. */
 		start = state->end + 1;
@@ -1844,10 +1837,7 @@ bool btrfs_test_range_bit(struct extent_io_tree *tree, u64 start, u64 end, u32 b
 	}
 
 	/* We ran out of states and were still inside of our range. */
-	if (!state)
-		bitset = false;
-	spin_unlock(&tree->lock);
-	return bitset;
+	return false;
 }
 
 /* Wrappers around set/clear extent bit */
diff --git a/fs/btrfs/file-item.c b/fs/btrfs/file-item.c
index a42e6d54e7cd..7dfbfe468a34 100644
--- a/fs/btrfs/file-item.c
+++ b/fs/btrfs/file-item.c
@@ -48,11 +48,11 @@ void btrfs_inode_safe_disk_i_size_write(struct btrfs_inode *inode, u64 new_i_siz
 	u64 start, end, i_size;
 	bool found;
 
-	spin_lock(&inode->lock);
+	guard(spinlock)(&inode->lock);
 	i_size = new_i_size ?: i_size_read(&inode->vfs_inode);
 	if (!inode->file_extent_tree) {
 		inode->disk_i_size = i_size;
-		goto out_unlock;
+		return;
 	}
 
 	found = btrfs_find_contiguous_extent_bit(inode->file_extent_tree, 0, &start,
@@ -62,8 +62,6 @@ void btrfs_inode_safe_disk_i_size_write(struct btrfs_inode *inode, u64 new_i_siz
 	else
 		i_size = 0;
 	inode->disk_i_size = i_size;
-out_unlock:
-	spin_unlock(&inode->lock);
 }
 
 /*
diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
index 30e361ab02dc..7ad3f635576e 100644
--- a/fs/btrfs/free-space-cache.c
+++ b/fs/btrfs/free-space-cache.c
@@ -3061,24 +3061,21 @@ bool btrfs_is_free_space_trimmed(struct btrfs_block_group *block_group)
 	struct btrfs_free_space_ctl *ctl = block_group->free_space_ctl;
 	struct btrfs_free_space *info;
 	struct rb_node *node;
-	bool ret = true;
 
-	spin_lock(&ctl->tree_lock);
+	guard(spinlock)(&ctl->tree_lock);
 	node = rb_first(&ctl->free_space_offset);
 
 	while (node) {
 		info = rb_entry(node, struct btrfs_free_space, offset_index);
 
 		if (!btrfs_free_space_trimmed(info)) {
-			ret = false;
-			break;
+			return false;
 		}
 
 		node = rb_next(node);
 	}
 
-	spin_unlock(&ctl->tree_lock);
-	return ret;
+	return true;
 }
 
 u64 btrfs_find_space_for_alloc(struct btrfs_block_group *block_group,
@@ -3583,23 +3580,21 @@ int btrfs_find_space_cluster(struct btrfs_block_group *block_group,
 		min_bytes = fs_info->sectorsize;
 	}
 
-	spin_lock(&ctl->tree_lock);
+	guard(spinlock)(&ctl->tree_lock);
 
 	/*
 	 * If we know we don't have enough space to make a cluster don't even
 	 * bother doing all the work to try and find one.
 	 */
 	if (ctl->free_space < bytes) {
-		spin_unlock(&ctl->tree_lock);
 		return -ENOSPC;
 	}
 
-	spin_lock(&cluster->lock);
+	guard(spinlock)(&cluster->lock);
 
 	/* someone already found a cluster, hooray */
 	if (cluster->block_group) {
-		ret = 0;
-		goto out;
+		return 0;
 	}
 
 	trace_btrfs_find_cluster(block_group, offset, bytes, empty_size,
@@ -3625,9 +3620,6 @@ int btrfs_find_space_cluster(struct btrfs_block_group *block_group,
 	} else {
 		trace_btrfs_failed_cluster_setup(block_group);
 	}
-out:
-	spin_unlock(&cluster->lock);
-	spin_unlock(&ctl->tree_lock);
 
 	return ret;
 }
diff --git a/fs/btrfs/fs.c b/fs/btrfs/fs.c
index feb0a2faa837..774c1ffa032c 100644
--- a/fs/btrfs/fs.c
+++ b/fs/btrfs/fs.c
@@ -108,16 +108,13 @@ bool __attribute_const__ btrfs_supported_blocksize(u32 blocksize)
 bool btrfs_exclop_start(struct btrfs_fs_info *fs_info,
 			enum btrfs_exclusive_operation type)
 {
-	bool ret = false;
-
-	spin_lock(&fs_info->super_lock);
+	guard(spinlock)(&fs_info->super_lock);
 	if (fs_info->exclusive_operation == BTRFS_EXCLOP_NONE) {
 		fs_info->exclusive_operation = type;
-		ret = true;
+		return true;
 	}
-	spin_unlock(&fs_info->super_lock);
 
-	return ret;
+	return false;
 }
 
 /*
diff --git a/fs/btrfs/ordered-data.c b/fs/btrfs/ordered-data.c
index 27a16bacdf9c..451b60de4550 100644
--- a/fs/btrfs/ordered-data.c
+++ b/fs/btrfs/ordered-data.c
@@ -970,22 +970,19 @@ struct btrfs_ordered_extent *btrfs_lookup_ordered_extent(struct btrfs_inode *ino
 {
 	struct rb_node *node;
 	struct btrfs_ordered_extent *entry = NULL;
-	unsigned long flags;
 
-	spin_lock_irqsave(&inode->ordered_tree_lock, flags);
+	guard(spinlock_irqsave)(&inode->ordered_tree_lock);
 	node = ordered_tree_search(inode, file_offset);
 	if (!node)
-		goto out;
+		return NULL;
 
 	entry = rb_entry(node, struct btrfs_ordered_extent, rb_node);
 	if (!in_range(file_offset, entry->file_offset, entry->num_bytes))
-		entry = NULL;
+		return NULL;
 	if (entry) {
 		refcount_inc(&entry->refs);
 		trace_btrfs_ordered_extent_lookup(inode, entry);
 	}
-out:
-	spin_unlock_irqrestore(&inode->ordered_tree_lock, flags);
 	return entry;
 }
 
@@ -1066,16 +1063,14 @@ btrfs_lookup_first_ordered_extent(struct btrfs_inode *inode, u64 file_offset)
 	struct rb_node *node;
 	struct btrfs_ordered_extent *entry = NULL;
 
-	spin_lock_irq(&inode->ordered_tree_lock);
+	guard(spinlock_irq)(&inode->ordered_tree_lock);
 	node = ordered_tree_search(inode, file_offset);
 	if (!node)
-		goto out;
+		return NULL;
 
 	entry = rb_entry(node, struct btrfs_ordered_extent, rb_node);
 	refcount_inc(&entry->refs);
 	trace_btrfs_ordered_extent_lookup_first(inode, entry);
-out:
-	spin_unlock_irq(&inode->ordered_tree_lock);
 	return entry;
 }
 
diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
index 683905f4481d..b76fc5474ae9 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -1662,38 +1662,31 @@ int btrfs_create_qgroup(struct btrfs_trans_handle *trans, u64 qgroupid)
 	struct btrfs_qgroup *prealloc;
 	int ret = 0;
 
-	mutex_lock(&fs_info->qgroup_ioctl_lock);
-	if (!fs_info->quota_root) {
-		ret = -ENOTCONN;
-		goto out;
-	}
+	guard(mutex)(&fs_info->qgroup_ioctl_lock);
+
+	if (!fs_info->quota_root)
+		return -ENOTCONN;
+
 	quota_root = fs_info->quota_root;
 	qgroup = find_qgroup_rb(fs_info, qgroupid);
-	if (qgroup) {
-		ret = -EEXIST;
-		goto out;
-	}
+	if (qgroup)
+		return -EEXIST;
 
 	prealloc = kzalloc(sizeof(*prealloc), GFP_NOFS);
-	if (!prealloc) {
-		ret = -ENOMEM;
-		goto out;
-	}
+	if (!prealloc)
+		return -ENOMEM;
 
 	ret = add_qgroup_item(trans, quota_root, qgroupid);
 	if (ret) {
 		kfree(prealloc);
-		goto out;
+		return ret;
 	}
 
 	spin_lock(&fs_info->qgroup_lock);
 	qgroup = add_qgroup_rb(fs_info, prealloc, qgroupid);
 	spin_unlock(&fs_info->qgroup_lock);
 
-	ret = btrfs_sysfs_add_one_qgroup(fs_info, qgroup);
-out:
-	mutex_unlock(&fs_info->qgroup_ioctl_lock);
-	return ret;
+	return btrfs_sysfs_add_one_qgroup(fs_info, qgroup);
 }
 
 /*
@@ -3175,13 +3168,10 @@ int btrfs_qgroup_check_inherit(struct btrfs_fs_info *fs_info,
 		if (btrfs_qgroup_level(qgroupid) == 0)
 			return -EINVAL;
 
-		spin_lock(&fs_info->qgroup_lock);
+		guard(spinlock)(&fs_info->qgroup_lock);
 		qgroup = find_qgroup_rb(fs_info, qgroupid);
-		if (!qgroup) {
-			spin_unlock(&fs_info->qgroup_lock);
+		if (!qgroup)
 			return -ENOENT;
-		}
-		spin_unlock(&fs_info->qgroup_lock);
 	}
 	return 0;
 }
@@ -4640,9 +4630,9 @@ void btrfs_qgroup_clean_swapped_blocks(struct btrfs_root *root)
 
 	swapped_blocks = &root->swapped_blocks;
 
-	spin_lock(&swapped_blocks->lock);
+	guard(spinlock)(&swapped_blocks->lock);
 	if (!swapped_blocks->swapped)
-		goto out;
+		return;
 	for (i = 0; i < BTRFS_MAX_LEVEL; i++) {
 		struct rb_root *cur_root = &swapped_blocks->blocks[i];
 		struct btrfs_qgroup_swapped_block *entry;
@@ -4654,8 +4644,6 @@ void btrfs_qgroup_clean_swapped_blocks(struct btrfs_root *root)
 		swapped_blocks->blocks[i] = RB_ROOT;
 	}
 	swapped_blocks->swapped = false;
-out:
-	spin_unlock(&swapped_blocks->lock);
 }
 
 static int qgroup_swapped_block_bytenr_key_cmp(const void *key, const struct rb_node *node)
@@ -4873,7 +4861,6 @@ void btrfs_qgroup_destroy_extent_records(struct btrfs_transaction *trans)
 int btrfs_record_squota_delta(struct btrfs_fs_info *fs_info,
 			      const struct btrfs_squota_delta *delta)
 {
-	int ret;
 	struct btrfs_qgroup *qgroup;
 	struct btrfs_qgroup *qg;
 	LIST_HEAD(qgroup_list);
@@ -4891,14 +4878,11 @@ int btrfs_record_squota_delta(struct btrfs_fs_info *fs_info,
 	if (delta->generation < fs_info->qgroup_enable_gen)
 		return 0;
 
-	spin_lock(&fs_info->qgroup_lock);
+	guard(spinlock)(&fs_info->qgroup_lock);
 	qgroup = find_qgroup_rb(fs_info, root);
-	if (!qgroup) {
-		ret = -ENOENT;
-		goto out;
-	}
+	if (!qgroup)
+		return -ENOENT;
 
-	ret = 0;
 	qgroup_iterator_add(&qgroup_list, qgroup);
 	list_for_each_entry(qg, &qgroup_list, iterator) {
 		struct btrfs_qgroup_list *glist;
@@ -4911,8 +4895,5 @@ int btrfs_record_squota_delta(struct btrfs_fs_info *fs_info,
 			qgroup_iterator_add(&qgroup_list, glist->group);
 	}
 	qgroup_iterator_clean(&qgroup_list);
-
-out:
-	spin_unlock(&fs_info->qgroup_lock);
-	return ret;
+	return 0;
 }
diff --git a/fs/btrfs/raid56.c b/fs/btrfs/raid56.c
index 6b9fda36d3c6..98959d35132e 100644
--- a/fs/btrfs/raid56.c
+++ b/fs/btrfs/raid56.c
@@ -614,15 +614,10 @@ static void run_xor(void **pages, int src_cnt, ssize_t len)
 static int rbio_is_full(struct btrfs_raid_bio *rbio)
 {
 	unsigned long size = rbio->bio_list_bytes;
-	int ret = 1;
 
-	spin_lock(&rbio->bio_list_lock);
-	if (size != rbio->nr_data * BTRFS_STRIPE_LEN)
-		ret = 0;
+	guard(spinlock)(&rbio->bio_list_lock);
 	BUG_ON(size > rbio->nr_data * BTRFS_STRIPE_LEN);
-	spin_unlock(&rbio->bio_list_lock);
-
-	return ret;
+	return size == rbio->nr_data * BTRFS_STRIPE_LEN;
 }
 
 /*
@@ -969,16 +964,14 @@ static struct sector_ptr *sector_in_rbio(struct btrfs_raid_bio *rbio,
 	index = stripe_nr * rbio->stripe_nsectors + sector_nr;
 	ASSERT(index >= 0 && index < rbio->nr_sectors);
 
-	spin_lock(&rbio->bio_list_lock);
+	guard(spinlock)(&rbio->bio_list_lock);
 	sector = &rbio->bio_sectors[index];
 	if (sector->has_paddr || bio_list_only) {
 		/* Don't return sector without a valid page pointer */
 		if (!sector->has_paddr)
 			sector = NULL;
-		spin_unlock(&rbio->bio_list_lock);
 		return sector;
 	}
-	spin_unlock(&rbio->bio_list_lock);
 
 	return &rbio->stripe_sectors[index];
 }
diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index 97452fb5d29b..01b68037296b 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -1050,10 +1050,9 @@ static bool steal_from_global_rsv(struct btrfs_fs_info *fs_info,
 	if (global_rsv->space_info != space_info)
 		return false;
 
-	spin_lock(&global_rsv->lock);
+	guard(spinlock)(&global_rsv->lock);
 	min_bytes = mult_perc(global_rsv->size, 10);
 	if (global_rsv->reserved < min_bytes + ticket->bytes) {
-		spin_unlock(&global_rsv->lock);
 		return false;
 	}
 	global_rsv->reserved -= ticket->bytes;
@@ -1063,7 +1062,6 @@ static bool steal_from_global_rsv(struct btrfs_fs_info *fs_info,
 	space_info->tickets_id++;
 	if (global_rsv->reserved < global_rsv->size)
 		global_rsv->full = 0;
-	spin_unlock(&global_rsv->lock);
 
 	return true;
 }
diff --git a/fs/btrfs/subpage.c b/fs/btrfs/subpage.c
index 8c8563e87aea..89c8e2a4c590 100644
--- a/fs/btrfs/subpage.c
+++ b/fs/btrfs/subpage.c
@@ -226,14 +226,13 @@ static bool btrfs_subpage_end_and_test_lock(const struct btrfs_fs_info *fs_info,
 	struct btrfs_folio_state *bfs = folio_get_private(folio);
 	const int start_bit = subpage_calc_start_bit(fs_info, folio, locked, start, len);
 	const int nbits = (len >> fs_info->sectorsize_bits);
-	unsigned long flags;
 	unsigned int cleared = 0;
 	int bit = start_bit;
 	bool last;
 
 	btrfs_subpage_assert(fs_info, folio, start, len);
 
-	spin_lock_irqsave(&bfs->lock, flags);
+	guard(spinlock_irqsave)(&bfs->lock);
 	/*
 	 * We have call sites passing @lock_page into
 	 * extent_clear_unlock_delalloc() for compression path.
@@ -242,7 +241,6 @@ static bool btrfs_subpage_end_and_test_lock(const struct btrfs_fs_info *fs_info,
 	 * subpage::locked is 0.  Handle them in a special way.
 	 */
 	if (atomic_read(&bfs->nr_locked) == 0) {
-		spin_unlock_irqrestore(&bfs->lock, flags);
 		return true;
 	}
 
@@ -252,7 +250,6 @@ static bool btrfs_subpage_end_and_test_lock(const struct btrfs_fs_info *fs_info,
 	}
 	ASSERT(atomic_read(&bfs->nr_locked) >= cleared);
 	last = atomic_sub_and_test(cleared, &bfs->nr_locked);
-	spin_unlock_irqrestore(&bfs->lock, flags);
 	return last;
 }
 
diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 30f3c3b849c1..e7a9e9582246 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -3695,8 +3695,6 @@ int btrfs_free_log_root_tree(struct btrfs_trans_handle *trans,
 static bool mark_inode_as_not_logged(const struct btrfs_trans_handle *trans,
 				     struct btrfs_inode *inode)
 {
-	bool ret = false;
-
 	/*
 	 * Do this only if ->logged_trans is still 0 to prevent races with
 	 * concurrent logging as we may see the inode not logged when
@@ -3707,14 +3705,15 @@ static bool mark_inode_as_not_logged(const struct btrfs_trans_handle *trans,
 	 * and link operations may end up not logging new names and removing old
 	 * names from the log.
 	 */
-	spin_lock(&inode->lock);
-	if (inode->logged_trans == 0)
+	guard(spinlock)(&inode->lock);
+	if (inode->logged_trans == 0) {
 		inode->logged_trans = trans->transid - 1;
-	else if (inode->logged_trans == trans->transid)
-		ret = true;
-	spin_unlock(&inode->lock);
+		return false;
+	} else if (inode->logged_trans == trans->transid) {
+		return true;
+	}
 
-	return ret;
+	return false;
 }
 
 /*
diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index d1db7fa1fe58..3e1d9e8eab78 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -2690,9 +2690,9 @@ void btrfs_zoned_release_data_reloc_bg(struct btrfs_fs_info *fs_info, u64 logica
 	/* It should be called on a previous data relocation block group. */
 	ASSERT(block_group && (block_group->flags & BTRFS_BLOCK_GROUP_DATA));
 
-	spin_lock(&block_group->lock);
+	guard(spinlock)(&block_group->lock);
 	if (!test_bit(BLOCK_GROUP_FLAG_ZONED_DATA_RELOC, &block_group->runtime_flags))
-		goto out;
+		return;
 
 	/* All relocation extents are written. */
 	if (block_group->start + block_group->alloc_offset == logical + length) {
@@ -2704,8 +2704,6 @@ void btrfs_zoned_release_data_reloc_bg(struct btrfs_fs_info *fs_info, u64 logica
 			  &block_group->runtime_flags);
 	}
 
-out:
-	spin_unlock(&block_group->lock);
 	btrfs_put_block_group(block_group);
 }
 
@@ -2720,14 +2718,12 @@ int btrfs_zone_finish_one_bg(struct btrfs_fs_info *fs_info)
 	list_for_each_entry(block_group, &fs_info->zone_active_bgs,
 			    active_bg_list) {
 		u64 avail;
+		guard(spinlock)(&block_group->lock);
 
-		spin_lock(&block_group->lock);
 		if (block_group->reserved || block_group->alloc_offset == 0 ||
 		    !(block_group->flags & BTRFS_BLOCK_GROUP_DATA) ||
-		    test_bit(BLOCK_GROUP_FLAG_ZONED_DATA_RELOC, &block_group->runtime_flags)) {
-			spin_unlock(&block_group->lock);
+		    test_bit(BLOCK_GROUP_FLAG_ZONED_DATA_RELOC, &block_group->runtime_flags))
 			continue;
-		}
 
 		avail = block_group->zone_capacity - block_group->alloc_offset;
 		if (min_avail > avail) {
@@ -2737,7 +2733,6 @@ int btrfs_zone_finish_one_bg(struct btrfs_fs_info *fs_info)
 			min_avail = avail;
 			btrfs_get_block_group(min_bg);
 		}
-		spin_unlock(&block_group->lock);
 	}
 	spin_unlock(&fs_info->zone_active_bgs_lock);
 
diff --git a/fs/btrfs/zstd.c b/fs/btrfs/zstd.c
index c9cddcfa337b..ce59214a3778 100644
--- a/fs/btrfs/zstd.c
+++ b/fs/btrfs/zstd.c
@@ -114,12 +114,10 @@ static void zstd_reclaim_timer_fn(struct timer_list *timer)
 	unsigned long reclaim_threshold = jiffies - ZSTD_BTRFS_RECLAIM_JIFFIES;
 	struct list_head *pos, *next;
 
-	spin_lock(&zwsm->lock);
+	guard(spinlock)(&zwsm->lock);
 
-	if (list_empty(&zwsm->lru_list)) {
-		spin_unlock(&zwsm->lock);
+	if (list_empty(&zwsm->lru_list))
 		return;
-	}
 
 	list_for_each_prev_safe(pos, next, &zwsm->lru_list) {
 		struct workspace *victim = container_of(pos, struct workspace,
@@ -145,8 +143,6 @@ static void zstd_reclaim_timer_fn(struct timer_list *timer)
 
 	if (!list_empty(&zwsm->lru_list))
 		mod_timer(&zwsm->timer, jiffies + ZSTD_BTRFS_RECLAIM_JIFFIES);
-
-	spin_unlock(&zwsm->lock);
 }
 
 /*
@@ -251,7 +247,8 @@ static struct list_head *zstd_find_workspace(struct btrfs_fs_info *fs_info, int
 	int i = clip_level(level);
 
 	ASSERT(zwsm);
-	spin_lock_bh(&zwsm->lock);
+	guard(spinlock_bh)(&zwsm->lock);
+
 	for_each_set_bit_from(i, &zwsm->active_map, ZSTD_BTRFS_MAX_LEVEL) {
 		if (!list_empty(&zwsm->idle_ws[i])) {
 			ws = zwsm->idle_ws[i].next;
@@ -263,11 +260,9 @@ static struct list_head *zstd_find_workspace(struct btrfs_fs_info *fs_info, int
 				list_del(&workspace->lru_list);
 			if (list_empty(&zwsm->idle_ws[i]))
 				clear_bit(i, &zwsm->active_map);
-			spin_unlock_bh(&zwsm->lock);
 			return ws;
 		}
 	}
-	spin_unlock_bh(&zwsm->lock);
 
 	return NULL;
 }
-- 
2.51.1.dirty


