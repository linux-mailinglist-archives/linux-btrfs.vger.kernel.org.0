Return-Path: <linux-btrfs+bounces-19021-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 55575C5F13C
	for <lists+linux-btrfs@lfdr.de>; Fri, 14 Nov 2025 20:45:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2EE094E055D
	for <lists+linux-btrfs@lfdr.de>; Fri, 14 Nov 2025 19:45:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 744642561AE;
	Fri, 14 Nov 2025 19:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=swemel.ru header.i=@swemel.ru header.b="vzjuzpLP"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx.swemel.ru (mx.swemel.ru [95.143.211.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA6FD31AF36;
	Fri, 14 Nov 2025 19:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.143.211.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763149503; cv=none; b=QTt5lAH8UFtnX1zcIkjrQFflDGcJU0093SFzz03SadvS5T2l9m/9bhSsP1c2bsqNeTuzxOUwlPwU57xkLdTb8Tpq3F8KytEkmB5hEvdIhJFo1g1QxQnzVKg8VtlUYNsPbNrdE/cuScQ9X/W4t5i+FJzRkkFTfgiCO+F7aS4VWIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763149503; c=relaxed/simple;
	bh=0zK3xdevFrR/nuXLq9IeclzSR7v7wNKSTGNicejY3aU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eJBYkkyH2rsrQM3dAi4T2bkar2EWh47b2+pdXmQsFoSfKhEUb7XdxjIdm29V/XF41pIMLGHwAO76GxWIKYhZ2Q8RfD9na2WKgm+WoireEBf6GtGKWY0la4OohNpNyf+vIsjugFoqiLTLUw+jUzvJXIUhU1WHDmwrCVvIXa7ptA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=swemel.ru; spf=pass smtp.mailfrom=swemel.ru; dkim=pass (1024-bit key) header.d=swemel.ru header.i=@swemel.ru header.b=vzjuzpLP; arc=none smtp.client-ip=95.143.211.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=swemel.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=swemel.ru
From: Andrey Kalachev <kalachev@swemel.ru>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=swemel.ru; s=mail;
	t=1763149492;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=se0+/gPrDCi8+Y1E4zBtNeMVWEdwmKWFg6EuOog7LSk=;
	b=vzjuzpLPBXCZpT8PY2JPuyjgzMGlIZnoaNmI1BVgxu0Esgtt47F4NwhlTY9DUXgrcaZ2Wb
	sgGlaAt0bTQqxtPWS2nffrPBiIjgw5UmZ1M4A6Pb2OZwJNEX7vr+fvxpjrX6H4Fkw6Us/U
	CEI0tLcpCzSs3fyD0bjz2HYIeWYkUIs=
To: linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	fdmanana@suse.com,
	josef@toxicpanda.com,
	dsterba@suse.com
Cc: stable@vger.kernel.org,
	kalachev@swemel.ru,
	lvc-project@linuxtesting.org
Subject: [PATCH 6.1.y v2 3/6] btrfs: ensure fiemap doesn't race with writes when FIEMAP_FLAG_SYNC is given
Date: Fri, 14 Nov 2025 22:44:35 +0300
Message-Id: <20251114194438.5694-4-kalachev@swemel.ru>
In-Reply-To: <20251114194438.5694-1-kalachev@swemel.ru>
References: <20251030131254.9225-1-kalachev@swemel.ru>
 <20251114194438.5694-1-kalachev@swemel.ru>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

[ Upstream commit 418b09027743d9a9fb39116bed46a192f868a3c3 ]

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

CC: stable@vger.kernel.org # 6.1
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Filipe Manana <fdmanana@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
[ backport to v6.1.158 ]
Signed-off-by: Andrey Kalachev <kalachev@swemel.ru>
---
 fs/btrfs/extent_io.c | 20 ++++++++------------
 fs/btrfs/inode.c     | 22 +++++++++++++++++++++-
 2 files changed, 29 insertions(+), 13 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 2c2c66c26869..4f5e5b6380f7 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -4050,17 +4050,15 @@ int extent_fiemap(struct btrfs_inode *inode, struct fiemap_extent_info *fieinfo,
 	range_end = round_up(start + len, sectorsize);
 	prev_extent_end = range_start;
 
-	btrfs_inode_lock(&inode->vfs_inode, BTRFS_ILOCK_SHARED);
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
@@ -4105,7 +4103,7 @@ int extent_fiemap(struct btrfs_inode *inode, struct fiemap_extent_info *fieinfo,
 						  roots, tmp_ulist,
 						  prev_extent_end, hole_end);
 			if (ret < 0) {
-				goto out_unlock;
+				goto out;
 			} else if (ret > 0) {
 				/* fiemap_fill_next_extent() told us to stop. */
 				stopped = true;
@@ -4162,7 +4160,7 @@ int extent_fiemap(struct btrfs_inode *inode, struct fiemap_extent_info *fieinfo,
 								  tmp_ulist,
 								  backref_cache);
 				if (ret < 0)
-					goto out_unlock;
+					goto out;
 				else if (ret > 0)
 					flags |= FIEMAP_EXTENT_SHARED;
 			}
@@ -4173,7 +4171,7 @@ int extent_fiemap(struct btrfs_inode *inode, struct fiemap_extent_info *fieinfo,
 		}
 
 		if (ret < 0) {
-			goto out_unlock;
+			goto out;
 		} else if (ret > 0) {
 			/* fiemap_fill_next_extent() told us to stop. */
 			stopped = true;
@@ -4184,12 +4182,12 @@ int extent_fiemap(struct btrfs_inode *inode, struct fiemap_extent_info *fieinfo,
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
@@ -4213,7 +4211,7 @@ int extent_fiemap(struct btrfs_inode *inode, struct fiemap_extent_info *fieinfo,
 					  0, 0, 0, roots, tmp_ulist,
 					  prev_extent_end, range_end - 1);
 		if (ret < 0)
-			goto out_unlock;
+			goto out;
 		prev_extent_end = range_end;
 	}
 
@@ -4251,8 +4249,6 @@ int extent_fiemap(struct btrfs_inode *inode, struct fiemap_extent_info *fieinfo,
 
 	ret = emit_last_fiemap_cache(fieinfo, &cache);
 
-out_unlock:
-	btrfs_inode_unlock(&inode->vfs_inode, BTRFS_ILOCK_SHARED);
 out:
 	kfree(backref_cache);
 	btrfs_free_path(path);
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 78cd7b8ccfc8..a389d0b06fea 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -8269,6 +8269,7 @@ struct iomap_dio *btrfs_dio_write(struct kiocb *iocb, struct iov_iter *iter,
 static int btrfs_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
 			u64 start, u64 len)
 {
+	struct btrfs_inode *btrfs_inode = BTRFS_I(inode);
 	int	ret;
 
 	ret = fiemap_prep(inode, fieinfo, start, &len, 0);
@@ -8294,7 +8295,26 @@ static int btrfs_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
 			return ret;
 	}
 
-	return extent_fiemap(BTRFS_I(inode), fieinfo, start, len);
+	btrfs_inode_lock(inode, BTRFS_ILOCK_SHARED);
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
+			btrfs_inode_unlock(inode, BTRFS_ILOCK_SHARED);
+			return ret;
+		}
+	}
+
+	ret = extent_fiemap(btrfs_inode, fieinfo, start, len);
+	btrfs_inode_unlock(inode, BTRFS_ILOCK_SHARED);
+
+	return ret;
 }
 
 static int btrfs_writepages(struct address_space *mapping,
-- 
2.39.5


