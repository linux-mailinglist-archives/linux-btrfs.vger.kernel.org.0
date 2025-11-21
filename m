Return-Path: <linux-btrfs+bounces-19251-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D633CC7AB34
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 Nov 2025 17:03:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0667E4E346D
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 Nov 2025 16:03:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BAAC2BE047;
	Fri, 21 Nov 2025 16:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qsz/GFjs"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBDE11DD543
	for <linux-btrfs@vger.kernel.org>; Fri, 21 Nov 2025 16:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763740989; cv=none; b=Mb1ps+6HdVhLoNCKgXuWzDJMTf0GKYCne2A1sa+p/1yS3mT4icdaz+nK9yuE/OjM9ykpvUOSwoM7BAJzl1h9sdfopNVeZJpsu9uVaS8+IdsIzTjR+DRtVB25ob56V9awcNLCcBVdVUTDoBY6fdnZBvZ2ZkBt6uToM5y/UI/zDgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763740989; c=relaxed/simple;
	bh=UA34p7kfIugYyvqB2rVtzHnSWMmE7vpdwL2h9u3C8dY=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=ktA5dqoqR4uXtYokz6o9rxKhlx/fqDYmmJqPuR5HcVjLFRQzqkL4QvGquOFd85SMHG70kOOY5H0F+akeKFsl7k/R2Cq8PIGUDJfqu1J1EYG/UE4WbH0w5DCScrX1FsADApGs3vq6Wqu97bHitWhpw8t0A5EKIcnlTPz9H+5tA14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qsz/GFjs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4AF2C4CEF1
	for <linux-btrfs@vger.kernel.org>; Fri, 21 Nov 2025 16:03:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763740989;
	bh=UA34p7kfIugYyvqB2rVtzHnSWMmE7vpdwL2h9u3C8dY=;
	h=From:To:Subject:Date:From;
	b=qsz/GFjs0lD1yR2yjsZnKgS1vGHFbp0YDiY4E4H5EEXLuS7nxLBKrTzwiv1TC7wXo
	 EYtLC1RMlKqrxxzJ8wRRGScYxtlXwriUtRbPesMIDeaq+WiqSYfcxRYlUjzcxSdMzP
	 2omJpEo7w9NxfVn65mKtM1Zzsl7gc0+Y8HfVwzGyfYNDW4Xl+Oi1+xZebhlLyAqimA
	 a3//ZfW8eNniNw5vVhF1GEyxwVAXkOkzLYtwSuVLwvBXgrmYI+4S+k5NzAozlA1aJh
	 VdbEA6DFCN5/SIzBkDe51nwHctdMlFeJUGE7b/lrOWD62+xKrCPtVz6Ljt+5XZROdb
	 LXW1lHrcHDQAw==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: remove redundant zero/NULL initializations in btrfs_alloc_root()
Date: Fri, 21 Nov 2025 16:02:57 +0000
Message-ID: <b35e6981136cd8066b56ba97e99e531e9621a84d.1763740870.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

We have allocated the root with kzalloc() so all the memory is already
zero initialized, therefore it's redundant to assign 0 and NULL to several
of the root members. Remove all of them except the atomic initializations
since atomic_t is an opaque type and it's not a good practice to assume
its internals.

This slightly reduces the binary size.
With gcc 14.2.0-19 from Debian on x86_64, before this change:

  $ size fs/btrfs/btrfs.ko
     text	   data	    bss	    dec	    hex	filename
  1939404	 162963	  15592	2117959	 205147	fs/btrfs/btrfs.ko

After this change:

  $ size fs/btrfs/btrfs.ko
     text	   data	    bss	    dec	    hex	filename
  1939212	 162963	  15592	2117767	 205087	fs/btrfs/btrfs.ko

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/disk-io.c | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index fe62f5a244f5..89149fac804c 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -652,20 +652,10 @@ static struct btrfs_root *btrfs_alloc_root(struct btrfs_fs_info *fs_info,
 	if (!root)
 		return NULL;
 
-	memset(&root->root_key, 0, sizeof(root->root_key));
-	memset(&root->root_item, 0, sizeof(root->root_item));
-	memset(&root->defrag_progress, 0, sizeof(root->defrag_progress));
 	root->fs_info = fs_info;
 	root->root_key.objectid = objectid;
-	root->node = NULL;
-	root->commit_root = NULL;
-	root->state = 0;
 	RB_CLEAR_NODE(&root->rb_node);
 
-	btrfs_set_root_last_trans(root, 0);
-	root->free_objectid = 0;
-	root->nr_delalloc_inodes = 0;
-	root->nr_ordered_extents = 0;
 	xa_init(&root->inodes);
 	xa_init(&root->delayed_nodes);
 
@@ -699,10 +689,7 @@ static struct btrfs_root *btrfs_alloc_root(struct btrfs_fs_info *fs_info,
 	refcount_set(&root->refs, 1);
 	atomic_set(&root->snapshot_force_cow, 0);
 	atomic_set(&root->nr_swapfiles, 0);
-	btrfs_set_root_log_transid(root, 0);
 	root->log_transid_committed = -1;
-	btrfs_set_root_last_log_commit(root, 0);
-	root->anon_dev = 0;
 	if (!btrfs_is_testing(fs_info)) {
 		btrfs_extent_io_tree_init(fs_info, &root->dirty_log_pages,
 					  IO_TREE_ROOT_DIRTY_LOG_PAGES);
-- 
2.47.2


