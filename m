Return-Path: <linux-btrfs+bounces-6060-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9D8B91DB52
	for <lists+linux-btrfs@lfdr.de>; Mon,  1 Jul 2024 11:23:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C22241C2175F
	for <lists+linux-btrfs@lfdr.de>; Mon,  1 Jul 2024 09:23:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 270DD84A5E;
	Mon,  1 Jul 2024 09:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ozirq49q"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53FCE71747
	for <linux-btrfs@vger.kernel.org>; Mon,  1 Jul 2024 09:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719825815; cv=none; b=EvXgRIlwB5VjNyx+tlximjmDYNz4R7W792X3L1/yysZmsCInL1U10sGmQyLCCfqmrI+pwx/svJmIYD684Dw9tssiVzjYnyhQbOzwHiRn7o5XerbhuGot8Lt7ointDUquVHA1m0Uj1N92NWxLji4OMlH5tZbdITbDvyx68EEcTqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719825815; c=relaxed/simple;
	bh=wNDsudBt9U6yws/J6zLdz6wKLQxzltb4ZYN3aowADhs=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=usFd5a933A/Nd8FZALZwV+rLQNsCgng+LKXDY0RemgNgqxtFuO9fiZaORUGKjdNsvBVoU7YE+r0/QSPzqs/Bp/G9jyfbaKPhnNW+KogtiBhVChzXbmyIyQ+3tOKQ+n8GRqusVn0qpodlYsgJB+4fKBZFb7Txcz0nDf9H+/446Nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ozirq49q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60ADCC116B1
	for <linux-btrfs@vger.kernel.org>; Mon,  1 Jul 2024 09:23:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719825814;
	bh=wNDsudBt9U6yws/J6zLdz6wKLQxzltb4ZYN3aowADhs=;
	h=From:To:Subject:Date:From;
	b=Ozirq49q2QAxu33eD61dGhpOWg/n/DljnVIgdVatwtXzedex3JPL0ZJrs1py9kV6K
	 tk7YTy34ELG5hu0JBRZagmfqxrsIx9E8cp005aeCFrA/2cD/0SL003R+n0V3m4OQaQ
	 T+ktd/PlD2dpCZwtdcaze1iBDILiwyuD5JhWHGVmiMZ7AxOUjnJf9zrOKythdknsHQ
	 hQLaF8i5/Yb3AbxTAGbi2qF/nkC3w35cKZG27JShod4YSMb9SITNPXKInC4cI2/vpd
	 FmneCjHdpYvuYJ6/cK3ncZfBvyNWNQimqKtIo5Lj8CElep/DtPezBoRRPBzT8+IOXn
	 L/1vfz/l613YA==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: don't loop again over pinned extent maps when shrinking extent maps
Date: Mon,  1 Jul 2024 10:23:31 +0100
Message-Id: <cb12212b9c599817507f3978c9102767267625b2.1719825714.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

During extent map shrinking, while iterating over the extent maps of an
inode, if we happen to find a lot of pinned extent maps and we need to
reschedule, we'll start iterating the extent map tree from its first
extent map. This can result in visiting the same extent maps again, and if
they are not yet unpinned, we are just wasting time and can end up
iterating over them again if we happen to reschedule again before finding
an extent map that is not pinned - this could happen yet more times if the
unpinning doesn't happen soon (at ordered extent completion).

So improve on this by starting on the next extent map everytime we need
to reschedule. Any previously pinned extent maps we be checked again the
next time the extent map shrinker is run (if needed).

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---

This applies against the "for-next" branch, for a version that
applies cleanly to 6.10-rcX:

https://gist.githubusercontent.com/fdmanana/5262e608b3eecb9a3b2631f8dad49863/raw/1a82fe8eafbd5f6958dddf34d3c9648d7335018e/btrfs-don-t-loop-again-over-pinned-extent-maps-when-.patch

 fs/btrfs/extent_map.c | 24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/extent_map.c b/fs/btrfs/extent_map.c
index b869a0ee24d2..2d75059eedd8 100644
--- a/fs/btrfs/extent_map.c
+++ b/fs/btrfs/extent_map.c
@@ -1139,8 +1139,10 @@ static long btrfs_scan_inode(struct btrfs_inode *inode, long *scanned, long nr_t
 	while (node) {
 		struct rb_node *next = rb_next(node);
 		struct extent_map *em;
+		u64 next_min_offset;
 
 		em = rb_entry(node, struct extent_map, rb_node);
+		next_min_offset = extent_map_end(em);
 		(*scanned)++;
 
 		if (em->flags & EXTENT_FLAG_PINNED)
@@ -1166,14 +1168,24 @@ static long btrfs_scan_inode(struct btrfs_inode *inode, long *scanned, long nr_t
 			break;
 
 		/*
-		 * Restart if we had to reschedule, and any extent maps that were
-		 * pinned before may have become unpinned after we released the
-		 * lock and took it again.
+		 * If we had to reschedule start from where we were before. We
+		 * could start from the first extent map in the tree in case we
+		 * passed through pinned extent maps that may have become
+		 * unpinned in the meanwhile, but it might be the case that they
+		 * haven't been unpinned yet, so if we have many still unpinned
+		 * extent maps, we could be wasting a lot of time and cpu. So
+		 * don't consider previously pinned extent maps, we'll consider
+		 * them in future calls of the extent map shrinker.
 		 */
-		if (cond_resched_rwlock_write(&tree->lock))
-			node = rb_first(&tree->root);
-		else
+		if (cond_resched_rwlock_write(&tree->lock)) {
+			em = search_extent_mapping(tree, next_min_offset, 0);
+			if (em)
+				node = &em->rb_node;
+			else
+				node = NULL;
+		} else {
 			node = next;
+		}
 	}
 	write_unlock(&tree->lock);
 	up_read(&inode->i_mmap_lock);
-- 
2.43.0


