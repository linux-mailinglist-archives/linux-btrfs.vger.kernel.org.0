Return-Path: <linux-btrfs+bounces-4155-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 318718A1CB5
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Apr 2024 19:54:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 204B6B2EA5A
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Apr 2024 17:46:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 216C4181BAD;
	Thu, 11 Apr 2024 16:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mzRIclpW"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A6BE190663
	for <linux-btrfs@vger.kernel.org>; Thu, 11 Apr 2024 16:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712852369; cv=none; b=Y4XRrhb8Koaj7WgMnCAXR8JqttSmSejsUEdbzT+bdPbceHXPyC07JcU+RGW9q7IGeHGboF0iX3AY6HehCCp0JgoIjVFrLL6gsix/3z+Bn2Qotp9rEpzXfpw6LbPrn/qvHF2YntJG1hw85oQSxMxk+adxONobHvYuVGQolO5ZgSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712852369; c=relaxed/simple;
	bh=NemHQ9dJLema+Q1gJaRd1Fr6pp32bOpl6bIlFbNkJNE=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ogeClzCYHYRqxyflS5NR+NoU1Nycz4lk85LCoTfWg1urtgsWd4HhnXMb5GPaxFyzw3zkzY/EWt3Ke6oGfuUdI8Fl7sE6egqjkyKugYB/uoF2ZJ8kzSOGkSoB1f67R3zGUqzPilZSpv5rZyYYOS3F1KbNSaegX00xwkJUaCIUUFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mzRIclpW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15445C072AA
	for <linux-btrfs@vger.kernel.org>; Thu, 11 Apr 2024 16:19:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712852368;
	bh=NemHQ9dJLema+Q1gJaRd1Fr6pp32bOpl6bIlFbNkJNE=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=mzRIclpWGNIK0GqMKftqr/Qo04yDmM5tr1jWBIt3mde9obvoQssNZMMWs6CY3yvUl
	 5c0k3tewrGz6aVw913XUTVHqC/ndt27/s8lzJoVHFR9YfnwpmQbvwEsJw2tcBvLLHO
	 +7bY6YX8qSXefbsa5YFmCaM7mzULaF04qWIZFhdOD7uxrjSF6be2FUKvXyi+59aLL5
	 yJhJqbclhN2kbnVnL5ee7d+1dXOWHlynKyQGbrh/xEhT1ivMPsLcO6awF1Zj1D+FFz
	 8foAMleDdf+7hgLeD1C14Ip6VDJJCaEAUy3i/ioR8pe4Cp5PU44ZC7zH33ftLKf5Tl
	 X8QaQ6TslLqtA==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2 12/15] btrfs: use btrfs_find_first_inode() at btrfs_prune_dentries()
Date: Thu, 11 Apr 2024 17:19:06 +0100
Message-Id: <787204cda3fa8259bb7763c558a910cf7a2e609b.1712837044.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1712837044.git.fdmanana@suse.com>
References: <cover.1712837044.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

Currently btrfs_prune_dentries() has open code to find the first inode in
a root with a minimum inode number. Remove that code and make it use the
helper btrfs_find_first_inode() for that task.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/inode.c | 66 ++++++++++--------------------------------------
 1 file changed, 14 insertions(+), 52 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 9dc41334c3a3..2dae4e975e80 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -4436,64 +4436,26 @@ static noinline int may_destroy_subvol(struct btrfs_root *root)
 static void btrfs_prune_dentries(struct btrfs_root *root)
 {
 	struct btrfs_fs_info *fs_info = root->fs_info;
-	struct rb_node *node;
-	struct rb_node *prev;
-	struct btrfs_inode *entry;
-	struct inode *inode;
-	u64 objectid = 0;
+	struct btrfs_inode *inode;
+	u64 min_ino = 0;
 
 	if (!BTRFS_FS_ERROR(fs_info))
 		WARN_ON(btrfs_root_refs(&root->root_item) != 0);
 
-	spin_lock(&root->inode_lock);
-again:
-	node = root->inode_tree.rb_node;
-	prev = NULL;
-	while (node) {
-		prev = node;
-		entry = rb_entry(node, struct btrfs_inode, rb_node);
-
-		if (objectid < btrfs_ino(entry))
-			node = node->rb_left;
-		else if (objectid > btrfs_ino(entry))
-			node = node->rb_right;
-		else
-			break;
-	}
-	if (!node) {
-		while (prev) {
-			entry = rb_entry(prev, struct btrfs_inode, rb_node);
-			if (objectid <= btrfs_ino(entry)) {
-				node = prev;
-				break;
-			}
-			prev = rb_next(prev);
-		}
-	}
-	while (node) {
-		entry = rb_entry(node, struct btrfs_inode, rb_node);
-		objectid = btrfs_ino(entry) + 1;
-		inode = igrab(&entry->vfs_inode);
-		if (inode) {
-			spin_unlock(&root->inode_lock);
-			if (atomic_read(&inode->i_count) > 1)
-				d_prune_aliases(inode);
-			/*
-			 * btrfs_drop_inode will have it removed from the inode
-			 * cache when its usage count hits zero.
-			 */
-			iput(inode);
-			cond_resched();
-			spin_lock(&root->inode_lock);
-			goto again;
-		}
-
-		if (cond_resched_lock(&root->inode_lock))
-			goto again;
+	inode = btrfs_find_first_inode(root, min_ino);
+	while (inode) {
+		if (atomic_read(&inode->vfs_inode.i_count) > 1)
+			d_prune_aliases(&inode->vfs_inode);
 
-		node = rb_next(node);
+		min_ino = btrfs_ino(inode) + 1;
+		/*
+		 * btrfs_drop_inode() will have it removed from the inode
+		 * cache when its usage count hits zero.
+		 */
+		iput(&inode->vfs_inode);
+		cond_resched();
+		inode = btrfs_find_first_inode(root, min_ino);
 	}
-	spin_unlock(&root->inode_lock);
 }
 
 int btrfs_delete_subvolume(struct btrfs_inode *dir, struct dentry *dentry)
-- 
2.43.0


