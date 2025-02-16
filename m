Return-Path: <linux-btrfs+bounces-11486-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 42A12A3747E
	for <lists+linux-btrfs@lfdr.de>; Sun, 16 Feb 2025 14:16:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC2C6188E9BA
	for <lists+linux-btrfs@lfdr.de>; Sun, 16 Feb 2025 13:16:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 313CD194091;
	Sun, 16 Feb 2025 13:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gSY4EFDk"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7741B1624C3
	for <linux-btrfs@vger.kernel.org>; Sun, 16 Feb 2025 13:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739711771; cv=none; b=Oo8Cjtnd7exqM2y4oU8SjB2Lnj6W1k74ZoHcJwXn3MqeOtw3hA/95AnVhf23wVXWsfZRZz+SNXIi7n6TfWgsSz5O5bEAWeSpEvN/X2M3dCgSluYpAc2BvXe0qik1g1tkuIRaR8XKn1NOIBE9uQPD5bpRLzb5Un82fffHluReY/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739711771; c=relaxed/simple;
	bh=2q7trBFAL3cV9faEKWKR6V4pOiW1LOUVGqjk8eqTxdw=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FUZCAzpyVZOBR8Gyp2pB38cvtAbQNP1DpPgizlTII1hwq9gu/DmUCM4nAQf1AGoHUHOiX/Zdtin94ZruOXXH179d0KqcLsd0hnXOzAtk0A9zTG6BwgY/gDt2+NtKYNiWJSalGqgtAUyAnxJR5rILSmjAK+VWMcXtcgHbNXk1s2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gSY4EFDk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77647C4CEDD
	for <linux-btrfs@vger.kernel.org>; Sun, 16 Feb 2025 13:16:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739711771;
	bh=2q7trBFAL3cV9faEKWKR6V4pOiW1LOUVGqjk8eqTxdw=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=gSY4EFDkaOfkJeNk/erLIgrtEFveci1xlTn1R+TBETgIIRIMHjtOxz4A1W2hXAroa
	 Oqz5W+WUjIS378RN24cAiYK/jp7nPJOBh0bBN6ioUoVpbHB9DuN4U0S4XiPSmfyrbS
	 KXanBs7LNjf3ZHEZJzMhU8mYf95LyLk5E3ODBpZlaEZIEdM0/Z4ZY6tyoywAF9MvBQ
	 75jdJu533Hh2sOsiOgSv1hy8XIpTk0Nc8ieEcQpVbsjbHLVyStxgIqxu/ndxQ5QMxI
	 bJUmujht460Oua1Y/2c7Ryl+f0/jNlOzIrJE7nuMXqxaTVubLKzIXGTbJui7BzQxxX
	 wKHL37/LwtN1g==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 2/3] btrfs: skip inodes without loaded extent maps when shrinking extent maps
Date: Sun, 16 Feb 2025 13:16:04 +0000
Message-Id: <663658b73e3cd9dd5e34e8eee34f4959f6ccb5ec.1739710434.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1739710434.git.fdmanana@suse.com>
References: <cover.1739710434.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

If there are inodes that don't have any loaded extent maps, we end up
grabbing a reference on them and later adding a delayed iput, which wakes
up the cleaner and makes it do unnecessary work. This is common when for
example the inodes were open only to run stat(2) or all their extent maps
were already released through the folio release callback
(btrfs_release_folio()) or released by a previous run of the shrinker, or
directories which never have extent maps.

Reported-by: Ivan Shapovalov <intelfx@intelfx.name>
Tested-by: Ivan Shapovalov <intelfx@intelfx.name>
Link: https://lore.kernel.org/linux-btrfs/0414d690ac5680d0d77dfc930606cdc36e42e12f.camel@intelfx.name/
CC: stable@vger.kernel.org # 6.13+
Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/extent_map.c | 77 +++++++++++++++++++++++++++++++------------
 1 file changed, 56 insertions(+), 21 deletions(-)

diff --git a/fs/btrfs/extent_map.c b/fs/btrfs/extent_map.c
index bee1b94a1049..820aef514238 100644
--- a/fs/btrfs/extent_map.c
+++ b/fs/btrfs/extent_map.c
@@ -1128,6 +1128,8 @@ static long btrfs_scan_inode(struct btrfs_inode *inode, struct btrfs_em_shrink_c
 	long nr_dropped = 0;
 	struct rb_node *node;
 
+	lockdep_assert_held_write(&tree->lock);
+
 	/*
 	 * Take the mmap lock so that we serialize with the inode logging phase
 	 * of fsync because we may need to set the full sync flag on the inode,
@@ -1139,28 +1141,12 @@ static long btrfs_scan_inode(struct btrfs_inode *inode, struct btrfs_em_shrink_c
 	 * to find new extents, which may not be there yet because ordered
 	 * extents haven't completed yet.
 	 *
-	 * We also do a try lock because otherwise we could deadlock. This is
-	 * because the shrinker for this filesystem may be invoked while we are
-	 * in a path that is holding the mmap lock in write mode. For example in
-	 * a reflink operation while COWing an extent buffer, when allocating
-	 * pages for a new extent buffer and under memory pressure, the shrinker
-	 * may be invoked, and therefore we would deadlock by attempting to read
-	 * lock the mmap lock while we are holding already a write lock on it.
+	 * We also do a try lock because we don't want to block for too long and
+	 * we are holding the extent map tree's lock in write mode.
 	 */
 	if (!down_read_trylock(&inode->i_mmap_lock))
 		return 0;
 
-	/*
-	 * We want to be fast so if the lock is busy we don't want to spend time
-	 * waiting for it - either some task is about to do IO for the inode or
-	 * we may have another task shrinking extent maps, here in this code, so
-	 * skip this inode.
-	 */
-	if (!write_trylock(&tree->lock)) {
-		up_read(&inode->i_mmap_lock);
-		return 0;
-	}
-
 	node = rb_first(&tree->root);
 	while (node) {
 		struct rb_node *next = rb_next(node);
@@ -1201,12 +1187,60 @@ static long btrfs_scan_inode(struct btrfs_inode *inode, struct btrfs_em_shrink_c
 			break;
 		node = next;
 	}
-	write_unlock(&tree->lock);
 	up_read(&inode->i_mmap_lock);
 
 	return nr_dropped;
 }
 
+static struct btrfs_inode *find_first_inode(struct btrfs_root *root, u64 min_ino)
+{
+	struct btrfs_inode *inode;
+	unsigned long from = min_ino;
+
+	xa_lock(&root->inodes);
+	while (true) {
+		struct extent_map_tree *tree;
+
+		inode = xa_find(&root->inodes, &from, ULONG_MAX, XA_PRESENT);
+		if (!inode)
+			break;
+
+		tree = &inode->extent_tree;
+
+		/*
+		 * We want to be fast so if the lock is busy we don't want to
+		 * spend time waiting for it (some task is about to do IO for
+		 * the inode).
+		 */
+		if (!write_trylock(&tree->lock))
+			goto next;
+
+		/*
+		 * Skip inode if it doesn't have loaded extent maps, so we avoid
+		 * getting a reference and doing an iput later. This includes
+		 * cases like files that were opened for things like stat(2), or
+		 * files with all extent maps previously released through the
+		 * release folio callback (btrfs_release_folio()) or released in
+		 * a previous run, or directories which never have extent maps.
+		 */
+		if (RB_EMPTY_ROOT(&tree->root)) {
+			write_unlock(&tree->lock);
+			goto next;
+		}
+
+		if (igrab(&inode->vfs_inode))
+			break;
+
+		write_unlock(&tree->lock);
+next:
+		from = btrfs_ino(inode) + 1;
+		cond_resched_lock(&root->inodes.xa_lock);
+	}
+	xa_unlock(&root->inodes);
+
+	return inode;
+}
+
 static long btrfs_scan_root(struct btrfs_root *root, struct btrfs_em_shrink_ctx *ctx)
 {
 	struct btrfs_fs_info *fs_info = root->fs_info;
@@ -1214,9 +1248,10 @@ static long btrfs_scan_root(struct btrfs_root *root, struct btrfs_em_shrink_ctx
 	long nr_dropped = 0;
 	u64 min_ino = fs_info->em_shrinker_last_ino + 1;
 
-	inode = btrfs_find_first_inode(root, min_ino);
+	inode = find_first_inode(root, min_ino);
 	while (inode) {
 		nr_dropped += btrfs_scan_inode(inode, ctx);
+		write_unlock(&inode->extent_tree.lock);
 
 		min_ino = btrfs_ino(inode) + 1;
 		fs_info->em_shrinker_last_ino = btrfs_ino(inode);
@@ -1227,7 +1262,7 @@ static long btrfs_scan_root(struct btrfs_root *root, struct btrfs_em_shrink_ctx
 
 		cond_resched();
 
-		inode = btrfs_find_first_inode(root, min_ino);
+		inode = find_first_inode(root, min_ino);
 	}
 
 	if (inode) {
-- 
2.45.2


