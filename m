Return-Path: <linux-btrfs+bounces-2697-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C2FD38620C5
	for <lists+linux-btrfs@lfdr.de>; Sat, 24 Feb 2024 00:47:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E6DE91C23A8C
	for <lists+linux-btrfs@lfdr.de>; Fri, 23 Feb 2024 23:47:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8566F14DFFA;
	Fri, 23 Feb 2024 23:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hIprd/iq"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B12C914DFDD
	for <linux-btrfs@vger.kernel.org>; Fri, 23 Feb 2024 23:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708732052; cv=none; b=l7stOuY4igfV9w2lyDpcbWzFDO+mMFt6e9j1oKqAcn90dQfsnoEcnI4wEsB9GEqFexktcE/b7/n1uLzYYTDYJjOHsRBLHd/Lq0lvCR84sqkmUMF2Ail1MrrFjirM57tY5FWDrewmGdOV5syrpSfdr3D1b1s14YriSbHG4rtEf8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708732052; c=relaxed/simple;
	bh=bi6gGd2lFISrktSqSTYZzmpyf/hNA97MuFfENzQDv/M=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KWuvcZF7umKLC6T5EzeuAteraa/WKrIRmuFy3LB3EsuSye+LFbHrLWFZMJ0+ZULr9X7TYao18ocomyqO1sA/kY/XdYU+c/YK+BEZG819tHnLzNiI3W4gO95rLy0TCMpxzuMSjwYenVjvY528jtj+ERupUrrVIYjoUT1FBDtejvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hIprd/iq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4D88C43390
	for <linux-btrfs@vger.kernel.org>; Fri, 23 Feb 2024 23:47:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708732052;
	bh=bi6gGd2lFISrktSqSTYZzmpyf/hNA97MuFfENzQDv/M=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=hIprd/iqapDDOJC+RQDhOSjveUNCvmuZw4+/O0I0gaK3NwHaO4/BzzDYHOxuQa5YK
	 VAiToXDuTBb22TmYMrwkARYv9V1YucUo5Vc0Lbrcxj5BudVvXa2jR8yz1hLcVySvfo
	 RBlqDil2wEFMnCz8x60QvTncFbTHJeSykvMWGLh6d8xmDEoVKej7PVc8QDlm4+mo2z
	 f6k/Jx15ispVKLWYpa35yLCxNMhyzL0HooaEWaiun3ipvYG9VAahTqOUjILHso5OPi
	 AtrSO2Q5B/sOF2FnLKgOR22Bm1E3hBSI9Wgk1FHFk/RrBSw/5kLYhLbxS6Jng4jzEa
	 IvjcwVfX2QH3g==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v3 2/2] btrfs: ensure fiemap doesn't race with writes when FIEMAP_FLAG_SYNC is given
Date: Fri, 23 Feb 2024 23:47:26 +0000
Message-Id: <aa150e345a6278828f569aa211cd4cd7c1042f1c.1708730657.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1708730657.git.fdmanana@suse.com>
References: <cover.1708730657.git.fdmanana@suse.com>
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
index 583e3f98d951..e18f566feb16 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -2931,17 +2931,15 @@ int extent_fiemap(struct btrfs_inode *inode, struct fiemap_extent_info *fieinfo,
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
@@ -2988,7 +2986,7 @@ int extent_fiemap(struct btrfs_inode *inode, struct fiemap_extent_info *fieinfo,
 						  backref_ctx, 0, 0, 0,
 						  prev_extent_end, hole_end);
 			if (ret < 0) {
-				goto out_unlock;
+				goto out;
 			} else if (ret > 0) {
 				/* fiemap_fill_next_extent() told us to stop. */
 				stopped = true;
@@ -3044,7 +3042,7 @@ int extent_fiemap(struct btrfs_inode *inode, struct fiemap_extent_info *fieinfo,
 								  extent_gen,
 								  backref_ctx);
 				if (ret < 0)
-					goto out_unlock;
+					goto out;
 				else if (ret > 0)
 					flags |= FIEMAP_EXTENT_SHARED;
 			}
@@ -3055,7 +3053,7 @@ int extent_fiemap(struct btrfs_inode *inode, struct fiemap_extent_info *fieinfo,
 		}
 
 		if (ret < 0) {
-			goto out_unlock;
+			goto out;
 		} else if (ret > 0) {
 			/* fiemap_fill_next_extent() told us to stop. */
 			stopped = true;
@@ -3066,12 +3064,12 @@ int extent_fiemap(struct btrfs_inode *inode, struct fiemap_extent_info *fieinfo,
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
@@ -3095,7 +3093,7 @@ int extent_fiemap(struct btrfs_inode *inode, struct fiemap_extent_info *fieinfo,
 					  &delalloc_cached_state, backref_ctx,
 					  0, 0, 0, prev_extent_end, range_end - 1);
 		if (ret < 0)
-			goto out_unlock;
+			goto out;
 		prev_extent_end = range_end;
 	}
 
@@ -3133,9 +3131,6 @@ int extent_fiemap(struct btrfs_inode *inode, struct fiemap_extent_info *fieinfo,
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


