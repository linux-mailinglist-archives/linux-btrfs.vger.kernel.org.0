Return-Path: <linux-btrfs+bounces-12091-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F169A5693C
	for <lists+linux-btrfs@lfdr.de>; Fri,  7 Mar 2025 14:45:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 12817175C0F
	for <lists+linux-btrfs@lfdr.de>; Fri,  7 Mar 2025 13:44:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C659E21ADD6;
	Fri,  7 Mar 2025 13:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hcmFR3vf"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1640121ADCE
	for <linux-btrfs@vger.kernel.org>; Fri,  7 Mar 2025 13:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741355074; cv=none; b=mNEgCX4qlNqHhU9E4q5jr8a7do9GdrwN9a1csr3ajLKApqe2Ghw07FzcqRYxDHh0FuAF/RQPzQE/NqOWFlAS4WTZUKxMyxrVt5CPXjYfb/Iucsf96lsz1WQdGaFx3p30p/neEcc7wdOh5tc6CZek8pK6khYXN7z1hm/S8ntykjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741355074; c=relaxed/simple;
	bh=+wBeFK7JxenN+cIdyjqxNtv+41UeCTThUJYjfWE1F8g=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rwI01tkoIIPNtKPVzM8KMPaonhpwbAV66lrskXbzsSaUSqbXgny9maBXVDVG7Owg6EncO6lOIgaWGX08vyMIgcDOPjplKBfaJYc2taIkmCo/jai5CRfirJVY5XxBKHlx3F+nSOmgCJDwWPx7LoqBW4PNKckapzmdnzOPPoHZjPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hcmFR3vf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6825AC4CED1
	for <linux-btrfs@vger.kernel.org>; Fri,  7 Mar 2025 13:44:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741355074;
	bh=+wBeFK7JxenN+cIdyjqxNtv+41UeCTThUJYjfWE1F8g=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=hcmFR3vfQOxfE6o51zJz7U7p1w9BR5eigMfSDdzx5oYqpKjIIt2rThRXCdh647BY6
	 G4rRXcHxyP5y87HN+fIwB6EQF0uvIn2yom45hzzITSqSL4zwP50kJYtul/uSeDQdCI
	 /zhfzu9CzHS8T5NJW6fHLn9ywfDDAlxJHCMR8SLlNezTrzTBNoXeiUDcT9K8KQfD3p
	 RPKZwqtBicjmnuXcN6IGEMtxD5pPAmwUFzSDG1flHJXDNT7gYct9AkI09q0GsXjcXr
	 kT+R67lu+SxW3TGCFsiRdbtq05IxdaWlC86Z6hZQWJY4ThEi8XDL08nTxUE58eESgQ
	 0p5hP/fJF9vCA==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 5/8] btrfs: make btrfs_iget_path() return a btrfs inode instead
Date: Fri,  7 Mar 2025 13:44:22 +0000
Message-Id: <5fc438e93edf2f715dec6371d2e23facf312714a.1741354479.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1741354476.git.fdmanana@suse.com>
References: <cover.1741354476.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

It's an internal function and btrfs_iget() is now returning a btrfs inode,
so change btrfs_iget_path() to also return a btrfs inode instead of a VFS
inode.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/btrfs_inode.h      |  4 ++--
 fs/btrfs/free-space-cache.c | 10 +++++-----
 fs/btrfs/inode.c            |  8 ++++----
 3 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/fs/btrfs/btrfs_inode.h b/fs/btrfs/btrfs_inode.h
index d81bfc760f9b..a2925562b4e9 100644
--- a/fs/btrfs/btrfs_inode.h
+++ b/fs/btrfs/btrfs_inode.h
@@ -592,8 +592,8 @@ void btrfs_free_inode(struct inode *inode);
 int btrfs_drop_inode(struct inode *inode);
 int __init btrfs_init_cachep(void);
 void __cold btrfs_destroy_cachep(void);
-struct inode *btrfs_iget_path(u64 ino, struct btrfs_root *root,
-			      struct btrfs_path *path);
+struct btrfs_inode *btrfs_iget_path(u64 ino, struct btrfs_root *root,
+				    struct btrfs_path *path);
 struct btrfs_inode *btrfs_iget(u64 ino, struct btrfs_root *root);
 struct extent_map *btrfs_get_extent(struct btrfs_inode *inode,
 				    struct folio *folio, u64 start, u64 len);
diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
index 3095cce904b5..05e173311c1a 100644
--- a/fs/btrfs/free-space-cache.c
+++ b/fs/btrfs/free-space-cache.c
@@ -88,7 +88,7 @@ static struct inode *__lookup_free_space_inode(struct btrfs_root *root,
 	struct btrfs_disk_key disk_key;
 	struct btrfs_free_space_header *header;
 	struct extent_buffer *leaf;
-	struct inode *inode = NULL;
+	struct btrfs_inode *inode;
 	unsigned nofs_flag;
 	int ret;
 
@@ -120,13 +120,13 @@ static struct inode *__lookup_free_space_inode(struct btrfs_root *root,
 	btrfs_release_path(path);
 	memalloc_nofs_restore(nofs_flag);
 	if (IS_ERR(inode))
-		return inode;
+		return ERR_CAST(inode);
 
-	mapping_set_gfp_mask(inode->i_mapping,
-			mapping_gfp_constraint(inode->i_mapping,
+	mapping_set_gfp_mask(inode->vfs_inode.i_mapping,
+			mapping_gfp_constraint(inode->vfs_inode.i_mapping,
 			~(__GFP_FS | __GFP_HIGHMEM)));
 
-	return inode;
+	return &inode->vfs_inode;
 }
 
 struct inode *lookup_free_space_inode(struct btrfs_block_group *block_group,
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 072e7a47f162..d2cafd2f46b0 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -5650,8 +5650,8 @@ static struct btrfs_inode *btrfs_iget_locked(u64 ino, struct btrfs_root *root)
  * Get an inode object given its inode number and corresponding root.  Path is
  * preallocated to prevent recursing back to iget through allocator.
  */
-struct inode *btrfs_iget_path(u64 ino, struct btrfs_root *root,
-			      struct btrfs_path *path)
+struct btrfs_inode *btrfs_iget_path(u64 ino, struct btrfs_root *root,
+				    struct btrfs_path *path)
 {
 	struct btrfs_inode *inode;
 	int ret;
@@ -5661,14 +5661,14 @@ struct inode *btrfs_iget_path(u64 ino, struct btrfs_root *root,
 		return ERR_PTR(-ENOMEM);
 
 	if (!(inode->vfs_inode.i_state & I_NEW))
-		return &inode->vfs_inode;
+		return inode;
 
 	ret = btrfs_read_locked_inode(inode, path);
 	if (ret)
 		return ERR_PTR(ret);
 
 	unlock_new_inode(&inode->vfs_inode);
-	return &inode->vfs_inode;
+	return inode;
 }
 
 /*
-- 
2.45.2


