Return-Path: <linux-btrfs+bounces-2661-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A11B860BC4
	for <lists+linux-btrfs@lfdr.de>; Fri, 23 Feb 2024 09:09:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D6EF1C21964
	for <lists+linux-btrfs@lfdr.de>; Fri, 23 Feb 2024 08:09:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A323817BA5;
	Fri, 23 Feb 2024 08:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A37fYzqa"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9CA11642A
	for <linux-btrfs@vger.kernel.org>; Fri, 23 Feb 2024 08:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708675722; cv=none; b=Xq1jRLHvA+4WqrCtdDxWuQvIQ19EBryfF50AK/N0Zymz3EVORG4PzZMxPZltnLZ9RjN2a08XPOav3ljqQxCzPpc4Qzw36JQckGI9B2lAsNKwUrECraxaeykgD5lMJrvmt+ldGSOnghf71p/bgYdnMD0hgjKpTbMc28lULhL6UGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708675722; c=relaxed/simple;
	bh=gCiV540fFV2fP1hdleeCMxZj26EcRQtqBcCYfLvT6ZI=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lDTI7/Tt5vdTf5hOrhZofyfl8fkjctB8XZsWnTXVbjcUjrtcgJbB0gbRyRFpLz9yiS7DISGK4dVUvDRk9JNpz5cF9mt6iIo6qVxFyXT5oJ3UUlwAFT22bIenYCFwqFYkz0ose4lo7drL8YIpj5Kttz7z+jSHEioLUdzetU++4DY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A37fYzqa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6C07C433C7
	for <linux-btrfs@vger.kernel.org>; Fri, 23 Feb 2024 08:08:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708675722;
	bh=gCiV540fFV2fP1hdleeCMxZj26EcRQtqBcCYfLvT6ZI=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=A37fYzqavcRojg1pu+74dSiVSvPV3uznoD24tcfATOBBkPrjbvWL5sg1qNSZc+dbI
	 aDvk3PZBjS7JxWQO4fUMi0WR4Y04YgieD4vFzwWpasY0c8h62IJR4eiiyuxMba9cp/
	 VoH4fUA7BLdOpcPzi5uexwc7d6RhfohPtRhvgZc82g2yCqJ0xlBPvgp1YlyXJHSGwz
	 pccIS15n66lOh5tjXIzxHJ8vnahXuvONVW4FiuihksWcdYaUVcJA3XgommLDgp6458
	 GEPrKcpT1bnNtinAaDDIvjjPHHRslfO1joGm+ZZenD5f/sa7nrvrpzRKeOx1YOMksv
	 UZGIUPWWybNyQ==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 2/2] btrfs: ensure fiemap doesn't race with writes when FIEMAP_FLAG_SYNC is given
Date: Fri, 23 Feb 2024 08:08:32 +0000
Message-Id: <fb98e6d4ee76db708f324a1e42cdd801f521dc05.1708635463.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1708635463.git.fdmanana@suse.com>
References: <cover.1708635463.git.fdmanana@suse.com>
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
index eab23cb2bb93..a4f6a3656862 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -2917,17 +2917,15 @@ int extent_fiemap(struct btrfs_inode *inode, struct fiemap_extent_info *fieinfo,
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
@@ -2974,7 +2972,7 @@ int extent_fiemap(struct btrfs_inode *inode, struct fiemap_extent_info *fieinfo,
 						  backref_ctx, 0, 0, 0,
 						  prev_extent_end, hole_end);
 			if (ret < 0) {
-				goto out_unlock;
+				goto out;
 			} else if (ret > 0) {
 				/* fiemap_fill_next_extent() told us to stop. */
 				stopped = true;
@@ -3030,7 +3028,7 @@ int extent_fiemap(struct btrfs_inode *inode, struct fiemap_extent_info *fieinfo,
 								  extent_gen,
 								  backref_ctx);
 				if (ret < 0)
-					goto out_unlock;
+					goto out;
 				else if (ret > 0)
 					flags |= FIEMAP_EXTENT_SHARED;
 			}
@@ -3041,7 +3039,7 @@ int extent_fiemap(struct btrfs_inode *inode, struct fiemap_extent_info *fieinfo,
 		}
 
 		if (ret < 0) {
-			goto out_unlock;
+			goto out;
 		} else if (ret > 0) {
 			/* fiemap_fill_next_extent() told us to stop. */
 			stopped = true;
@@ -3052,12 +3050,12 @@ int extent_fiemap(struct btrfs_inode *inode, struct fiemap_extent_info *fieinfo,
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
@@ -3081,7 +3079,7 @@ int extent_fiemap(struct btrfs_inode *inode, struct fiemap_extent_info *fieinfo,
 					  &delalloc_cached_state, backref_ctx,
 					  0, 0, 0, prev_extent_end, range_end - 1);
 		if (ret < 0)
-			goto out_unlock;
+			goto out;
 		prev_extent_end = range_end;
 	}
 
@@ -3119,9 +3117,6 @@ int extent_fiemap(struct btrfs_inode *inode, struct fiemap_extent_info *fieinfo,
 	}
 
 	ret = emit_last_fiemap_cache(fieinfo, &cache);
-
-out_unlock:
-	btrfs_inode_unlock(inode, BTRFS_ILOCK_SHARED);
 out:
 	free_extent_state(delalloc_cached_state);
 	btrfs_free_backref_share_ctx(backref_ctx);
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index f93cb23ae1ee..cb23b3834c3d 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -7869,6 +7869,7 @@ struct iomap_dio *btrfs_dio_write(struct kiocb *iocb, struct iov_iter *iter,
 static int btrfs_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
 			u64 start, u64 len)
 {
+	struct btrfs_inode *btrfs_inode = BTRFS_I(inode);
 	int	ret;
 
 	ret = fiemap_prep(inode, fieinfo, start, &len, 0);
@@ -7894,7 +7895,26 @@ static int btrfs_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
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


