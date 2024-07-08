Return-Path: <linux-btrfs+bounces-6288-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C0E792A4EE
	for <lists+linux-btrfs@lfdr.de>; Mon,  8 Jul 2024 16:43:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D64C1C20FE0
	for <lists+linux-btrfs@lfdr.de>; Mon,  8 Jul 2024 14:43:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B66213C828;
	Mon,  8 Jul 2024 14:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TPGAtDfr"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA3B613DBBF
	for <linux-btrfs@vger.kernel.org>; Mon,  8 Jul 2024 14:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720449770; cv=none; b=gs+W12rssAKhCPXyhRnM0ZsgHnd2XCV4BwsV4WOc4VSJUGF2mNjhuvxFdhzmSMXN+dPq9zA20UQVr8Z4qa4nYuKFgH8LtezSTvMIadM8R1GbJY5BHPwq1yj8rHFe3cxRryiLeHYqCG8MU6O0/dw1w5x0GaDT566ptwBngOkMfrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720449770; c=relaxed/simple;
	bh=e5N6kTSYo077DXWnkSjOCy8Kw+bbBDDCGwyZKzDVoW0=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mxLHHdw7wW+mtElCTbPpFzF5TQQCg7wszf/8kUPieyVetoWVNXUuAagK8I05p3R9nYOayb7VejCoc7vMUIKywTDqkxEVOoKQlxh3+4CMgl+a7MOEnW5k/fKGnYl0ugeBZzktb7evepxGQMmVzUW3DshYDruEfD36j6TSwY4k6cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TPGAtDfr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 259B9C116B1
	for <linux-btrfs@vger.kernel.org>; Mon,  8 Jul 2024 14:42:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720449770;
	bh=e5N6kTSYo077DXWnkSjOCy8Kw+bbBDDCGwyZKzDVoW0=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=TPGAtDfrAwlaea6uaVvW6p0QiIt+MOacsdrIdSQrSXE6qrM8DFqtkIFI3copk2Ix5
	 cn5/wH1R82NRx2r4BthWI2muy6Sq3hWECQV62GPiaijRVyxAuHdbJr2VyR1EkS0D3B
	 DlVEdtp7OPRcEjRr6xNAlg++drvavXOJvdq5XVvGYBvLe00CXRb+yl+U/Yr8x7TIBB
	 6KXhy4LApxQDgxDGCf95l5rGfjUCts+uNjOo5F4FBahKoukaq3JWpqlaU5aFhvIP/5
	 4muERxtAm3rt07txAEIbCswzSfZwxFIDeD9VGzSXzNZ+ad9RGSZiTpe+JLWY3PYuxs
	 cBUllyncvk3zg==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 2/3] btrfs: stop extent map shrinker if reschedule is needed
Date: Mon,  8 Jul 2024 15:42:44 +0100
Message-Id: <2808b9945a3795d7d8119eb6c1966a3c27767d0e.1720448664.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1720448663.git.fdmanana@suse.com>
References: <cover.1720448663.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

The extent map shrinker can be called in a variety of contextes where we
are under memory pressure, and of them is when a task is trying to
allocate memory. For this reason the shrinker is typically called with a
value of struct shrink_control::nr_to_scan that is much smaller than what
we return in the nr_cached_objects callback of struct super_operations
(fs/btrfs/super.c:btrfs_nr_cached_objects()), so that the shrinker does
not take a long time and cause high latencies. However we can still take
a lot of time in the shrinker even for a limited amount of nr_to_scan:

1) When traversing the red black tree that tracks open inodes in a root,
   as for example with millions of open inodes we get a deep tree which
   takes time searching for an inode;

2) Iterating over the extent map tree, which is a red black tree, of an
   inode when doing the rb_next() calls and when removing an extent map
   from the tree, since often that requires rebalancing the red black
   tree;

3) When trying to write lock an inode's extent map tree we may wait for a
   significant amount of time, because there's either another task about
   to do IO and searching for an extent map in the tree or inserting an
   extent map in the tree, and we can have thousands or even millions of
   extent maps for an inode. Furthermore, there can be concurrent calls
   to the shrinker so the lock might be busy simply because there is
   already another task shrinking extent maps for the same inode;

4) We often reschedule if we need to, which further increases latency.

So improve on this by stopping the extent map shrinking code whenever we
need to reschedule and make it skip an inode if we can't immediately lock
its extent map tree.

Reported-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Reported-by: Andrea Gelmini <andrea.gelmini@gmail.com>
Link: https://lore.kernel.org/linux-btrfs/CABXGCsMmmb36ym8hVNGTiU8yfUS_cGvoUmGCcBrGWq9OxTrs+A@mail.gmail.com/
Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/extent_map.c | 39 +++++++++++++++++++++++++++++++--------
 1 file changed, 31 insertions(+), 8 deletions(-)

diff --git a/fs/btrfs/extent_map.c b/fs/btrfs/extent_map.c
index cb74d382a24f..887a0e5dc145 100644
--- a/fs/btrfs/extent_map.c
+++ b/fs/btrfs/extent_map.c
@@ -1057,7 +1057,18 @@ static long btrfs_scan_inode(struct btrfs_inode *inode, long *scanned, long nr_t
 	if (!down_read_trylock(&inode->i_mmap_lock))
 		return 0;
 
-	write_lock(&tree->lock);
+	/*
+	 * We want to be fast because we can be called from any path trying to
+	 * allocate memory, so if the lock is busy we don't want to spend time
+	 * waiting for it - either some task is about to do IO for the inode or
+	 * we may have another task shrinking extent maps, here in this code, so
+	 * skip this inode.
+	 */
+	if (!write_trylock(&tree->lock)) {
+		up_read(&inode->i_mmap_lock);
+		return 0;
+	}
+
 	node = rb_first_cached(&tree->map);
 	while (node) {
 		struct extent_map *em;
@@ -1089,12 +1100,14 @@ static long btrfs_scan_inode(struct btrfs_inode *inode, long *scanned, long nr_t
 			break;
 
 		/*
-		 * Restart if we had to reschedule, and any extent maps that were
-		 * pinned before may have become unpinned after we released the
-		 * lock and took it again.
+		 * Stop if we need to reschedule or there's contention on the
+		 * lock. This is to avoid slowing other tasks trying to take the
+		 * lock and because the shrinker might be called during a memory
+		 * allocation path and we want to avoid taking a very long time
+		 * and slowing down all sorts of tasks.
 		 */
-		if (cond_resched_rwlock_write(&tree->lock))
-			node = rb_first_cached(&tree->map);
+		if (need_resched() || rwlock_needbreak(&tree->lock))
+			break;
 	}
 	write_unlock(&tree->lock);
 	up_read(&inode->i_mmap_lock);
@@ -1120,7 +1133,13 @@ static long btrfs_scan_root(struct btrfs_root *root, long *scanned, long nr_to_s
 		if (*scanned >= nr_to_scan)
 			break;
 
-		cond_resched();
+		/*
+		 * We may be called from memory allocation paths, so we don't
+		 * want to take too much time and slowdown tasks.
+		 */
+		if (need_resched())
+			break;
+
 		inode = btrfs_find_first_inode(root, min_ino);
 	}
 
@@ -1159,7 +1178,11 @@ long btrfs_free_extent_maps(struct btrfs_fs_info *fs_info, long nr_to_scan)
 		trace_btrfs_extent_map_shrinker_scan_enter(fs_info, nr_to_scan, nr);
 	}
 
-	while (scanned < nr_to_scan) {
+	/*
+	 * We may be called from memory allocation paths, so we don't want to
+	 * take too much time and slowdown tasks, so stop if we need reschedule.
+	 */
+	while (scanned < nr_to_scan && !need_resched()) {
 		struct btrfs_root *root;
 		unsigned long count;
 
-- 
2.43.0


