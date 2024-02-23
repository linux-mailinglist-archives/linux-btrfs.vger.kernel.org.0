Return-Path: <linux-btrfs+bounces-2671-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1805A861564
	for <lists+linux-btrfs@lfdr.de>; Fri, 23 Feb 2024 16:20:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B9041C23B47
	for <lists+linux-btrfs@lfdr.de>; Fri, 23 Feb 2024 15:20:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84EFF823D8;
	Fri, 23 Feb 2024 15:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lnO86VCZ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2D34823B3
	for <linux-btrfs@vger.kernel.org>; Fri, 23 Feb 2024 15:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708701597; cv=none; b=Qv/NkFQ4biIEWqNdd7jebgvLnGU7Avq8vZg3VrLnB0Dq8bW6ndWUod0DYjGgcwaAkfaNVff+q82fVEv5gyx+iEJgMszJfprrRPJkgP7iaXUhKSzYQ5r7c70rymQmed9ZttZlafS0MdKeTintZV/eofRYhtrnAkiqlv30eE4GgVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708701597; c=relaxed/simple;
	bh=gKYJ3JRCk/i8Bt1i8MQS9IiwhJyg+Z86+5wxNN7efb8=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lLPg7iQBHAymL5qdFrTxnH0s4R+pqCVBWWJergj+Ugf46iVid1PYQoexDanwMcYWjouW2pCtMlRqR6mdeFCZvjLa2ASM0xEQd8xHxuK9b9U2LiDaZHWva9WPTPhotq8yvmibRoMG8B+5+GmO+ibrii4jbZsmgDmrLT2vI9QUHtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lnO86VCZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19EE6C43390
	for <linux-btrfs@vger.kernel.org>; Fri, 23 Feb 2024 15:19:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708701597;
	bh=gKYJ3JRCk/i8Bt1i8MQS9IiwhJyg+Z86+5wxNN7efb8=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=lnO86VCZWS1LeA/35IIJZuhC/153FhT4jv0UNTnuD5AeJCrNodQ/r5BplkbOYUl4y
	 0Uu/eKdF88+dj+C8uM50zn/wKFwSGWACEnvLwnpAUY+5CazIh0PgNEXP0q//8pyugH
	 0mNDc/92ZsMsl95Xgj04+p/SDYgEv4huFi7O2lFmN8Q4o6ZgFY3FtRnFQ3AURv50R3
	 5dDPEwXEgXyh8KNBQsSmv2hcPtKrv3sCMnG40/K1hUieouxYb5KTUMDVZNdGnZGGCR
	 82v+phshlSBcC8artDD4Db4Nf5wmE2mdLnCWpwTILNCRhHqPo7tMKSunBsSMciQiRE
	 Z1welfW870hhw==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2 2/2] btrfs: ensure fiemap doesn't race with writes when FIEMAP_FLAG_SYNC is given
Date: Fri, 23 Feb 2024 15:19:49 +0000
Message-Id: <b57d5e54e228d640ee6e21ec5f70adecce4d394d.1708701186.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1708701186.git.fdmanana@suse.com>
References: <cover.1708701186.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

When FIEMAP_FLAG_SYNC is given to fiemap the expectation is that that
are no concurrent writes and we get a stable view of the inode's extent
layout.

When the flag is given we flush all IO (and wait for ordered extents to
complete) and then lock the inode in shared mode, however that leaves open
the possibility that a write might happen right after the flushing and
before locking the inode. So fix this by flushing again after locking the
inode - we leave the initial flushing before locking the inode to avoid
holding the lock and blocking other RO operations while waiting for IO
and ordered extents to complete. The second flushing while holding the
inode's lock will most of the time do nothing or very little since the
time window for new writes to have happened is small.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/extent_io.c | 21 ++++++++-------------
 fs/btrfs/inode.c     | 22 +++++++++++++++++++++-
 2 files changed, 29 insertions(+), 14 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 4ae2076756f6..72b9b005e20a 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -2936,17 +2936,15 @@ int extent_fiemap(struct btrfs_inode *inode, struct fiemap_extent_info *fieinfo,
 	range_end = round_up(start + len, sectorsize);
 	prev_extent_end = range_start;
 
-	btrfs_inode_lock(inode, BTRFS_ILOCK_SHARED);
-
 	ret = fiemap_find_last_extent_offset(inode, path, &last_extent_end);
 	if (ret < 0)
-		goto out_unlock;
+		goto out;
 	btrfs_release_path(path);
 
 	path->reada = READA_FORWARD;
 	ret = fiemap_search_slot(inode, path, range_start);
 	if (ret < 0) {
-		goto out_unlock;
+		goto out;
 	} else if (ret > 0) {
 		/*
 		 * No file extent item found, but we may have delalloc between
@@ -2993,7 +2991,7 @@ int extent_fiemap(struct btrfs_inode *inode, struct fiemap_extent_info *fieinfo,
 						  backref_ctx, 0, 0, 0,
 						  prev_extent_end, hole_end);
 			if (ret < 0) {
-				goto out_unlock;
+				goto out;
 			} else if (ret > 0) {
 				/* fiemap_fill_next_extent() told us to stop. */
 				stopped = true;
@@ -3049,7 +3047,7 @@ int extent_fiemap(struct btrfs_inode *inode, struct fiemap_extent_info *fieinfo,
 								  extent_gen,
 								  backref_ctx);
 				if (ret < 0)
-					goto out_unlock;
+					goto out;
 				else if (ret > 0)
 					flags |= FIEMAP_EXTENT_SHARED;
 			}
@@ -3060,7 +3058,7 @@ int extent_fiemap(struct btrfs_inode *inode, struct fiemap_extent_info *fieinfo,
 		}
 
 		if (ret < 0) {
-			goto out_unlock;
+			goto out;
 		} else if (ret > 0) {
 			/* fiemap_fill_next_extent() told us to stop. */
 			stopped = true;
@@ -3071,12 +3069,12 @@ int extent_fiemap(struct btrfs_inode *inode, struct fiemap_extent_info *fieinfo,
 next_item:
 		if (fatal_signal_pending(current)) {
 			ret = -EINTR;
-			goto out_unlock;
+			goto out;
 		}
 
 		ret = fiemap_next_leaf_item(inode, path);
 		if (ret < 0) {
-			goto out_unlock;
+			goto out;
 		} else if (ret > 0) {
 			/* No more file extent items for this inode. */
 			break;
@@ -3100,7 +3098,7 @@ int extent_fiemap(struct btrfs_inode *inode, struct fiemap_extent_info *fieinfo,
 					  &delalloc_cached_state, backref_ctx,
 					  0, 0, 0, prev_extent_end, range_end - 1);
 		if (ret < 0)
-			goto out_unlock;
+			goto out;
 		prev_extent_end = range_end;
 	}
 
@@ -3138,9 +3136,6 @@ int extent_fiemap(struct btrfs_inode *inode, struct fiemap_extent_info *fieinfo,
 	}
 
 	ret = emit_last_fiemap_cache(fieinfo, &cache);
-
-out_unlock:
-	btrfs_inode_unlock(inode, BTRFS_ILOCK_SHARED);
 out:
 	free_extent_state(delalloc_cached_state);
 	btrfs_free_backref_share_ctx(backref_ctx);
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index d931cb40fb7a..904fff3d72f5 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -7865,6 +7865,7 @@ struct iomap_dio *btrfs_dio_write(struct kiocb *iocb, struct iov_iter *iter,
 static int btrfs_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
 			u64 start, u64 len)
 {
+	struct btrfs_inode *btrfs_inode = BTRFS_I(inode);
 	int	ret;
 
 	ret = fiemap_prep(inode, fieinfo, start, &len, 0);
@@ -7890,7 +7891,26 @@ static int btrfs_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
 			return ret;
 	}
 
-	return extent_fiemap(BTRFS_I(inode), fieinfo, start, len);
+	btrfs_inode_lock(btrfs_inode, BTRFS_ILOCK_SHARED);
+
+	/*
+	 * We did an initial flush to avoid holding the inode's lock while
+	 * triggering writeback and waiting for the completion of IO and ordered
+	 * extents. Now after we locked the inode we do it again, because it's
+	 * possible a new write may have happened in between those two steps.
+	 */
+	if (fieinfo->fi_flags & FIEMAP_FLAG_SYNC) {
+		ret = btrfs_wait_ordered_range(inode, 0, LLONG_MAX);
+		if (ret) {
+			btrfs_inode_unlock(btrfs_inode, BTRFS_ILOCK_SHARED);
+			return ret;
+		}
+	}
+
+	ret = extent_fiemap(btrfs_inode, fieinfo, start, len);
+	btrfs_inode_unlock(btrfs_inode, BTRFS_ILOCK_SHARED);
+
+	return ret;
 }
 
 static int btrfs_writepages(struct address_space *mapping,
-- 
2.40.1


