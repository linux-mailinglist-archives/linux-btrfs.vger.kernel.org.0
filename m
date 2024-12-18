Return-Path: <linux-btrfs+bounces-10566-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C8E9E9F6BF0
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Dec 2024 18:08:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A9405188A074
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Dec 2024 17:07:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFC28148850;
	Wed, 18 Dec 2024 17:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ntf5hoSJ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB9591FA8E9
	for <linux-btrfs@vger.kernel.org>; Wed, 18 Dec 2024 17:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734541622; cv=none; b=sxJxFki/egazcqsQ8zh34wcUwk+tCOc0QVaO5AkyDgUMnjl6p6nFXIn4bXf2zBc57ILX6/3+Hvkd3i4MTJXSAIj7F1zaaJuMI2Kk4qnO4yzGHbs3weyj706dO432YczDB3G9y9d7XeulXgficQDACkqGzbdlK9rxyvETjg0SEJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734541622; c=relaxed/simple;
	bh=B1mEI4d9psrXdXGp8ojuBIO56aqevJE/gb4atkoF/rU=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SNQL6J9GMOEsFPXnFJad8VOCnopmGPy5ivj+JJ1Of7o4xI5mvO/Lyhoj0tIqS5wnOWD9D8Z7yWLgSR4Nj2fj7q4COEDEGso+3ueqClaVdUm2++uJIfsPa9r70Ecl4bYiSFhP5gDymngGel9bCPp+GQyHSbrX9MjmL/u28CN1CLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ntf5hoSJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39DABC4CECD
	for <linux-btrfs@vger.kernel.org>; Wed, 18 Dec 2024 17:07:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734541621;
	bh=B1mEI4d9psrXdXGp8ojuBIO56aqevJE/gb4atkoF/rU=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=ntf5hoSJxxX1kLOQScBwew6l3ot0/wuWI4fZ2fCUD8F/gSghnZFRO3ROS8SJGO/ej
	 G0H50lRVi+BpMqDBb5ZwAx4B/sN91BLMR2vj6w8DmPCdgtM/z7ljO1LOomr8mSUphg
	 xa/s0q+nqBFwvLsQKcc6o0dLA5Gp0b5QknVgVSPNdjATU69Iv+5BMP25Ush5hGvPmY
	 4JWR+WVrAPeMIrDTgP6Dz9k9zCO7dINafae5YsRITsFf5zXrz249OqZSXlvsmnMUu1
	 33GOb8oVx8ermWeKfK7WQQ4UdFQcBDGoGpW5k+TBmd+8+kuGjw1YxH+Bt6Iwwm130k
	 Vaz+lcCJmSgDg==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 10/20] btrfs: free-space-cache: remove unnecessary calls to btrfs_mark_buffer_dirty()
Date: Wed, 18 Dec 2024 17:06:37 +0000
Message-Id: <de6608f28102b0cebc069822bac6e6c89f08947b.1734527445.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1734527445.git.fdmanana@suse.com>
References: <cover.1734527445.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

We have several places explicitly calling btrfs_mark_buffer_dirty() but
that is not necessarily since the target leaf came from a path that was
obtained for a btree search function that modifies the btree, something
like btrfs_insert_empty_item() or anything else that ends up calling
btrfs_search_slot() with a value of 1 for its 'cow' argument.

These just make the code more verbose, confusing and add a little extra
overhead and well as increase the module's text size, so remove them.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/free-space-cache.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
index 17707c898eae..3048cb38dc80 100644
--- a/fs/btrfs/free-space-cache.c
+++ b/fs/btrfs/free-space-cache.c
@@ -198,7 +198,6 @@ static int __create_free_space_inode(struct btrfs_root *root,
 	btrfs_set_inode_nlink(leaf, inode_item, 1);
 	btrfs_set_inode_transid(leaf, inode_item, trans->transid);
 	btrfs_set_inode_block_group(leaf, inode_item, offset);
-	btrfs_mark_buffer_dirty(trans, leaf);
 	btrfs_release_path(path);
 
 	key.objectid = BTRFS_FREE_SPACE_OBJECTID;
@@ -216,7 +215,6 @@ static int __create_free_space_inode(struct btrfs_root *root,
 				struct btrfs_free_space_header);
 	memzero_extent_buffer(leaf, (unsigned long)header, sizeof(*header));
 	btrfs_set_free_space_key(leaf, header, &disk_key);
-	btrfs_mark_buffer_dirty(trans, leaf);
 	btrfs_release_path(path);
 
 	return 0;
@@ -1189,7 +1187,6 @@ update_cache_item(struct btrfs_trans_handle *trans,
 	btrfs_set_free_space_entries(leaf, header, entries);
 	btrfs_set_free_space_bitmaps(leaf, header, bitmaps);
 	btrfs_set_free_space_generation(leaf, header, trans->transid);
-	btrfs_mark_buffer_dirty(trans, leaf);
 	btrfs_release_path(path);
 
 	return 0;
-- 
2.45.2


