Return-Path: <linux-btrfs+bounces-8962-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D6A29A0C78
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Oct 2024 16:20:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E5F81C21B90
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Oct 2024 14:20:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70E4320C021;
	Wed, 16 Oct 2024 14:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H5Wb6s8w"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E69120C01B
	for <linux-btrfs@vger.kernel.org>; Wed, 16 Oct 2024 14:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729088431; cv=none; b=JZNewWq2aDBJ697My5I/Dg81JhceC2oixhngHZTKNwRSvzCDSWi/NTKoMFBDo23oX03TMvDstBlqZ8FQ41yb5TEG1tZbZrSkKL3H7D9IBh4a9Ftq3IYi3lp0ZFwgJX4SodNqM6Ulg/646knPqN48RVde3uJSjrNdgI/zF7mGrjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729088431; c=relaxed/simple;
	bh=5GvpSF95Bj0JzBD8AbxRz0xrzWvSJbEAhMa9lrdsiOg=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uZ91Ht3vLgL9G6t9u2nh8olcNNW2dQSuBbz35+6qaos5pfv/iDRnzXJ/bfreRIMpbITLvntRyhmhX9PChHEuLbi64hujbIJDNeSC1O0IctcinMl+/D992SdNLAkpvGO//Gectk/9WaGciqiDBsV5IAgSbWU3Q8zoWEwJgh/Dx3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H5Wb6s8w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A02C9C4CEC7
	for <linux-btrfs@vger.kernel.org>; Wed, 16 Oct 2024 14:20:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729088431;
	bh=5GvpSF95Bj0JzBD8AbxRz0xrzWvSJbEAhMa9lrdsiOg=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=H5Wb6s8wM8klx5Y28UvBvU47BbbKAOW7AsyAj0CX5ivRRT3RFNnuth14EdNu+1hKZ
	 qJrKv3G202drZd/olz3j2gAajV/bNg0cyGrbUmyWi76LZ5RHaf+tpCWhpFuF/hYNFo
	 gaa4YhVfE36I7JUP6VjkiUo/j6J8ug4xmGm6Oh/T6fJoP1VNhHC4bZPbreg7/6/DRU
	 EK+H/jOdyMBf2/XeXgusFCcJ88IaeyLoG84qr+jD+JqhRjNlUNaQTodZjkpNupSZRF
	 PmbqSemacMpToDwHt/i7w406Pg4hSh0eYrbvArWkqk5Qq3ozGfGh0rMvwBOBoPN9Nf
	 Sx+WygOjJjSwg==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 4/4] btrfs: remove local generation variable from read_block_for_search()
Date: Wed, 16 Oct 2024 15:20:23 +0100
Message-Id: <bd8da12c3c0fb1c68e24106b820d91dd46c292f0.1729075703.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1729075703.git.fdmanana@suse.com>
References: <cover.1729075703.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

It's reduntant to have the 'gen' variable since we already have the same
value in the local btrfs_tree_parent_check structure. So remove it and
instead use the structure's field.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/ctree.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index f68a9b586079..148648ea1c8b 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -1514,7 +1514,6 @@ read_block_for_search(struct btrfs_root *root, struct btrfs_path *p,
 	struct btrfs_fs_info *fs_info = root->fs_info;
 	struct btrfs_tree_parent_check check = { 0 };
 	u64 blocknr;
-	u64 gen;
 	struct extent_buffer *tmp = NULL;
 	int ret = 0;
 	int parent_level;
@@ -1524,12 +1523,11 @@ read_block_for_search(struct btrfs_root *root, struct btrfs_path *p,
 	bool path_released = false;
 
 	blocknr = btrfs_node_blockptr(*eb_ret, slot);
-	gen = btrfs_node_ptr_generation(*eb_ret, slot);
 	parent_level = btrfs_header_level(*eb_ret);
 	btrfs_node_key_to_cpu(*eb_ret, &check.first_key, slot);
 	check.has_first_key = true;
 	check.level = parent_level - 1;
-	check.transid = gen;
+	check.transid = btrfs_node_ptr_generation(*eb_ret, slot);
 	check.owner_root = btrfs_root_id(root);
 
 	/*
@@ -1545,7 +1543,7 @@ read_block_for_search(struct btrfs_root *root, struct btrfs_path *p,
 			reada_for_search(fs_info, p, parent_level, slot, key->objectid);
 
 		/* first we do an atomic uptodate check */
-		if (btrfs_buffer_uptodate(tmp, gen, 1) > 0) {
+		if (btrfs_buffer_uptodate(tmp, check.transid, 1) > 0) {
 			/*
 			 * Do extra check for first_key, eb can be stale due to
 			 * being cached, read from scrub, or have multiple
-- 
2.43.0


