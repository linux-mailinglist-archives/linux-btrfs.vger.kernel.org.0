Return-Path: <linux-btrfs+bounces-12851-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 88601A7E8C4
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Apr 2025 19:45:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64F753BEB93
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Apr 2025 17:40:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86515253F0D;
	Mon,  7 Apr 2025 17:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="atgpo/zf"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC754253F06
	for <linux-btrfs@vger.kernel.org>; Mon,  7 Apr 2025 17:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744047400; cv=none; b=haeVcP/5LQ7FW/JNUyJ1PE7W/41OkO9E3kEOe5U+CvQzHYfduvGo28xzO1KEz+6Q0GRyiUSsAH0cJJNKSFJXcBnt7ZGobg6W9mruBPe5oGo6ZWmeGrB5pvgebjBJjgLq3GUxmKtwojxoeyaQIq/GC0m+oQqK2kW8bzoOvi2V/6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744047400; c=relaxed/simple;
	bh=nTseM5QWh3ZUYBO0VxksLYOHE44ykn922+QEreyhW7g=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PniSogtm3vFZAv9fwvNZmhKsEdMAE3ajJRvItSmvCgQWldK7ZlhcVAxsVv/XEvxqLj7VZ1lDghk52luCl8YhwbO4LVI+qb5QUVQAkc6LTYJNag44bx6lCST5Uy8QAxuGeJvWLvzis+79s76XujA8bt+ni2AH3HNlnxeRRApSmyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=atgpo/zf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5C72C4CEDD
	for <linux-btrfs@vger.kernel.org>; Mon,  7 Apr 2025 17:36:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744047400;
	bh=nTseM5QWh3ZUYBO0VxksLYOHE44ykn922+QEreyhW7g=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=atgpo/zfQghELfwpbAL34t9nx+97ItwaSVQnlskHE/brDvH97euIcqMa7hT16BJEE
	 1Qt3wEFFKWbZrfbQGOrDmjbNk4o7OSp2065FVgoDvdImtvZqYqFk9aayJDl5EkmstK
	 1mEdFnPygVhNfD5i2xwUS4h2lntq3ks2oS1jN6eCqM7QAeTXui6gxUCNvooL3UcK0t
	 XnrP3i/84WgD7ykcYM0G3FDAl2noqu3ZTYkOPZXZB4SsGjxoEMPqvu3PwT0aOR4mLn
	 bWEfbJgXd55YOJL4mHU9wB4ve1sit2Jc6AmTsoOgmNZjbuIDVzkbI/jTfcEPtor3Sr
	 qyLidkYUnunmg==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 13/16] btrfs: rename free_extent_state() to include a btrfs prefix
Date: Mon,  7 Apr 2025 18:36:20 +0100
Message-Id: <2e16b0eb178186d2b286ba5f75742fdcecab1d4f.1744046765.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1744046765.git.fdmanana@suse.com>
References: <cover.1744046765.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

This is an exported function so it should have a 'btrfs_' prefix by
convention, to make it clear it's btrfs specific and to avoid collisions
with functions from elsewhere in the kernel.

Rename the function to add 'btrfs_' prefix to it.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/dev-replace.c    |  2 +-
 fs/btrfs/disk-io.c        |  2 +-
 fs/btrfs/extent-io-tree.c | 30 +++++++++++++++---------------
 fs/btrfs/extent-io-tree.h |  2 +-
 fs/btrfs/extent-tree.c    |  2 +-
 fs/btrfs/extent_io.c      |  6 +++---
 fs/btrfs/fiemap.c         |  2 +-
 fs/btrfs/file.c           |  6 +++---
 fs/btrfs/transaction.c    |  4 ++--
 9 files changed, 28 insertions(+), 28 deletions(-)

diff --git a/fs/btrfs/dev-replace.c b/fs/btrfs/dev-replace.c
index 55608ac8dbe0..483e71e09181 100644
--- a/fs/btrfs/dev-replace.c
+++ b/fs/btrfs/dev-replace.c
@@ -804,7 +804,7 @@ static int btrfs_set_target_alloc_state(struct btrfs_device *srcdev,
 		start = found_end + 1;
 	}
 
-	free_extent_state(cached_state);
+	btrfs_free_extent_state(cached_state);
 	return ret;
 }
 
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index f90f74d8b137..aaf29b0ddf98 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -4734,7 +4734,7 @@ static void btrfs_destroy_pinned_extent(struct btrfs_fs_info *fs_info,
 		}
 
 		btrfs_clear_extent_dirty(unpin, start, end, &cached_state);
-		free_extent_state(cached_state);
+		btrfs_free_extent_state(cached_state);
 		btrfs_error_unpin_extent_range(fs_info, start, end);
 		mutex_unlock(&fs_info->unused_bg_unpin_mutex);
 		cond_resched();
diff --git a/fs/btrfs/extent-io-tree.c b/fs/btrfs/extent-io-tree.c
index 835a9463f687..6317004f36c4 100644
--- a/fs/btrfs/extent-io-tree.c
+++ b/fs/btrfs/extent-io-tree.c
@@ -130,7 +130,7 @@ void btrfs_extent_io_tree_release(struct extent_io_tree *tree)
 		 * (see wait_extent_bit()).
 		 */
 		ASSERT(!waitqueue_active(&state->wq));
-		free_extent_state(state);
+		btrfs_free_extent_state(state);
 		cond_resched_lock(&tree->lock);
 	}
 	/*
@@ -170,7 +170,7 @@ static struct extent_state *alloc_extent_state_atomic(struct extent_state *preal
 	return prealloc;
 }
 
-void free_extent_state(struct extent_state *state)
+void btrfs_free_extent_state(struct extent_state *state)
 {
 	if (!state)
 		return;
@@ -349,7 +349,7 @@ static void merge_prev_state(struct extent_io_tree *tree, struct extent_state *s
 		state->start = prev->start;
 		rb_erase(&prev->rb_node, &tree->state);
 		RB_CLEAR_NODE(&prev->rb_node);
-		free_extent_state(prev);
+		btrfs_free_extent_state(prev);
 	}
 }
 
@@ -364,7 +364,7 @@ static void merge_next_state(struct extent_io_tree *tree, struct extent_state *s
 		state->end = next->end;
 		rb_erase(&next->rb_node, &tree->state);
 		RB_CLEAR_NODE(&next->rb_node);
-		free_extent_state(next);
+		btrfs_free_extent_state(next);
 	}
 }
 
@@ -526,7 +526,7 @@ static int split_state(struct extent_io_tree *tree, struct extent_state *orig,
 		} else if (prealloc->end > entry->end) {
 			node = &(*node)->rb_right;
 		} else {
-			free_extent_state(prealloc);
+			btrfs_free_extent_state(prealloc);
 			return -EEXIST;
 		}
 	}
@@ -566,7 +566,7 @@ static struct extent_state *clear_state_bit(struct extent_io_tree *tree,
 		if (extent_state_in_tree(state)) {
 			rb_erase(&state->rb_node, &tree->state);
 			RB_CLEAR_NODE(&state->rb_node);
-			free_extent_state(state);
+			btrfs_free_extent_state(state);
 		} else {
 			WARN_ON(1);
 		}
@@ -652,7 +652,7 @@ int btrfs_clear_extent_bit_changeset(struct extent_io_tree *tree, u64 start, u64
 			goto hit_next;
 		}
 		if (clear)
-			free_extent_state(cached);
+			btrfs_free_extent_state(cached);
 	}
 
 	/* This search will find the extents that end after our range starts. */
@@ -744,7 +744,7 @@ int btrfs_clear_extent_bit_changeset(struct extent_io_tree *tree, u64 start, u64
 out:
 	spin_unlock(&tree->lock);
 	if (prealloc)
-		free_extent_state(prealloc);
+		btrfs_free_extent_state(prealloc);
 
 	return 0;
 
@@ -796,7 +796,7 @@ static void wait_extent_bit(struct extent_io_tree *tree, u64 start, u64 end,
 			schedule();
 			spin_lock(&tree->lock);
 			finish_wait(&state->wq, &wait);
-			free_extent_state(state);
+			btrfs_free_extent_state(state);
 			goto again;
 		}
 		start = state->end + 1;
@@ -814,7 +814,7 @@ static void wait_extent_bit(struct extent_io_tree *tree, u64 start, u64 end,
 	if (cached_state && *cached_state) {
 		state = *cached_state;
 		*cached_state = NULL;
-		free_extent_state(state);
+		btrfs_free_extent_state(state);
 	}
 	spin_unlock(&tree->lock);
 }
@@ -890,13 +890,13 @@ bool btrfs_find_first_extent_bit(struct extent_io_tree *tree, u64 start,
 			 * again. If we haven't found any, clear as well since
 			 * it's now useless.
 			 */
-			free_extent_state(*cached_state);
+			btrfs_free_extent_state(*cached_state);
 			*cached_state = NULL;
 			if (state)
 				goto got_it;
 			goto out;
 		}
-		free_extent_state(*cached_state);
+		btrfs_free_extent_state(*cached_state);
 		*cached_state = NULL;
 	}
 
@@ -1249,7 +1249,7 @@ static int __set_extent_bit(struct extent_io_tree *tree, u64 start, u64 end,
 out:
 	spin_unlock(&tree->lock);
 	if (prealloc)
-		free_extent_state(prealloc);
+		btrfs_free_extent_state(prealloc);
 
 	return ret;
 
@@ -1474,7 +1474,7 @@ int convert_extent_bit(struct extent_io_tree *tree, u64 start, u64 end,
 out:
 	spin_unlock(&tree->lock);
 	if (prealloc)
-		free_extent_state(prealloc);
+		btrfs_free_extent_state(prealloc);
 
 	return ret;
 }
@@ -1686,7 +1686,7 @@ u64 btrfs_count_range_bits(struct extent_io_tree *tree,
 	}
 
 	if (cached_state) {
-		free_extent_state(*cached_state);
+		btrfs_free_extent_state(*cached_state);
 		*cached_state = state;
 		if (state)
 			refcount_inc(&state->refs);
diff --git a/fs/btrfs/extent-io-tree.h b/fs/btrfs/extent-io-tree.h
index 2f5e27d96acd..238732b23e93 100644
--- a/fs/btrfs/extent-io-tree.h
+++ b/fs/btrfs/extent-io-tree.h
@@ -165,7 +165,7 @@ u64 btrfs_count_range_bits(struct extent_io_tree *tree,
 			   u64 max_bytes, u32 bits, int contig,
 			   struct extent_state **cached_state);
 
-void free_extent_state(struct extent_state *state);
+void btrfs_free_extent_state(struct extent_state *state);
 bool btrfs_test_range_bit(struct extent_io_tree *tree, u64 start, u64 end, u32 bit,
 			  struct extent_state *cached_state);
 bool btrfs_test_range_bit_exists(struct extent_io_tree *tree, u64 start, u64 end, u32 bit);
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 7ca5cfaccbfd..266a159fe5bb 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -2843,7 +2843,7 @@ int btrfs_finish_extent_commit(struct btrfs_trans_handle *trans)
 		ret = unpin_extent_range(fs_info, start, end, true);
 		BUG_ON(ret);
 		mutex_unlock(&fs_info->unused_bg_unpin_mutex);
-		free_extent_state(cached_state);
+		btrfs_free_extent_state(cached_state);
 		cond_resched();
 	}
 
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 617e08946dd5..86c6c1b1677b 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -330,7 +330,7 @@ noinline_for_stack bool find_lock_delalloc_range(struct inode *inode,
 
 		/* @delalloc_end can be -1, never go beyond @orig_end */
 		*end = min(delalloc_end, orig_end);
-		free_extent_state(cached_state);
+		btrfs_free_extent_state(cached_state);
 		return false;
 	}
 
@@ -356,7 +356,7 @@ noinline_for_stack bool find_lock_delalloc_range(struct inode *inode,
 		/* some of the folios are gone, lets avoid looping by
 		 * shortening the size of the delalloc range we're searching
 		 */
-		free_extent_state(cached_state);
+		btrfs_free_extent_state(cached_state);
 		cached_state = NULL;
 		if (!loops) {
 			max_bytes = PAGE_SIZE;
@@ -2646,7 +2646,7 @@ static bool try_release_extent_state(struct extent_io_tree *tree,
 	if (ret2 == 0)
 		ret = true;
 out:
-	free_extent_state(cached_state);
+	btrfs_free_extent_state(cached_state);
 
 	return ret;
 }
diff --git a/fs/btrfs/fiemap.c b/fs/btrfs/fiemap.c
index ba65a4821c44..43bf0979fd53 100644
--- a/fs/btrfs/fiemap.c
+++ b/fs/btrfs/fiemap.c
@@ -871,7 +871,7 @@ static int extent_fiemap(struct btrfs_inode *inode,
 
 	ret = emit_last_fiemap_cache(fieinfo, &cache);
 out:
-	free_extent_state(delalloc_cached_state);
+	btrfs_free_extent_state(delalloc_cached_state);
 	kfree(cache.entries);
 	btrfs_free_backref_share_ctx(backref_ctx);
 	return ret;
diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index ec644840fa49..57c5d12a0ff3 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -1290,7 +1290,7 @@ static int copy_one_range(struct btrfs_inode *inode, struct iov_iter *iter,
 				btrfs_unlock_extent(&inode->io_tree, lockstart, lockend,
 						    &cached_state);
 			else
-				free_extent_state(cached_state);
+				btrfs_free_extent_state(cached_state);
 			btrfs_delalloc_release_extents(inode, reserved_len);
 			release_space(inode, *data_reserved, reserved_start, reserved_len,
 				      only_release_metadata);
@@ -1319,7 +1319,7 @@ static int copy_one_range(struct btrfs_inode *inode, struct iov_iter *iter,
 	if (extents_locked)
 		btrfs_unlock_extent(&inode->io_tree, lockstart, lockend, &cached_state);
 	else
-		free_extent_state(cached_state);
+		btrfs_free_extent_state(cached_state);
 
 	btrfs_delalloc_release_extents(inode, reserved_len);
 	if (ret) {
@@ -1471,7 +1471,7 @@ int btrfs_release_file(struct inode *inode, struct file *filp)
 
 	if (private) {
 		kfree(private->filldir_buf);
-		free_extent_state(private->llseek_cached_state);
+		btrfs_free_extent_state(private->llseek_cached_state);
 		kfree(private);
 		filp->private_data = NULL;
 	}
diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index c640e80d2a20..ad6a7a25b9d9 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -1156,7 +1156,7 @@ int btrfs_write_marked_extents(struct btrfs_fs_info *fs_info,
 			ret = filemap_fdatawrite_range(mapping, start, end);
 		if (!ret && wait_writeback)
 			ret = filemap_fdatawait_range(mapping, start, end);
-		free_extent_state(cached_state);
+		btrfs_free_extent_state(cached_state);
 		if (ret)
 			break;
 		cached_state = NULL;
@@ -1197,7 +1197,7 @@ static int __btrfs_wait_marked_extents(struct btrfs_fs_info *fs_info,
 			ret = 0;
 		if (!ret)
 			ret = filemap_fdatawait_range(mapping, start, end);
-		free_extent_state(cached_state);
+		btrfs_free_extent_state(cached_state);
 		if (ret)
 			break;
 		cached_state = NULL;
-- 
2.45.2


