Return-Path: <linux-btrfs+bounces-12060-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4E6CA553B2
	for <lists+linux-btrfs@lfdr.de>; Thu,  6 Mar 2025 18:56:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8AB0D178C8B
	for <lists+linux-btrfs@lfdr.de>; Thu,  6 Mar 2025 17:56:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05B3826A1DF;
	Thu,  6 Mar 2025 17:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dMtmVUfG"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C5A926A0D4
	for <linux-btrfs@vger.kernel.org>; Thu,  6 Mar 2025 17:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741283763; cv=none; b=h0fcIDbF4xhgUrAD6Tb7Bj8RqjJDlk4phu7sqpqEwZ9mqIe5p7/PG+jRzmW0pmlQKWlnaDoFvbFnG1pp68Kp+sHeVlPXBuACnJJRPZcMCP9NuxclMxzh9bdv/j5DUTMcp40D9HCjKnNGn7gYOCF4+sQKPDRA5rMoHEAv1TAKtQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741283763; c=relaxed/simple;
	bh=NKcxbm23zJKcZRmQlFkev2gDy+1DKtRpz0aW9/2yx3w=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=trXt07CjFud8eaK3xy5j69v7NC0tV6ZuhrE6Nzq/AUXXa514M0L+sE0Oay9q0K5PE9zj6K7WJ0GdNIZMsBf9TyfWKbGFwOsfwydu3Ku0w2BdZHGSKT/AFFv6vSQHbqKASrgN0fee5gFEfSy1bjI8FHms8yU583X7BWBzP2wrb54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dMtmVUfG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E402C4CEE8
	for <linux-btrfs@vger.kernel.org>; Thu,  6 Mar 2025 17:56:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741283762;
	bh=NKcxbm23zJKcZRmQlFkev2gDy+1DKtRpz0aW9/2yx3w=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=dMtmVUfG64QaRP7OPByKh2Sx+AhSOzYNujgubtijnbAdJYplor33ON5ozt+s2CJFP
	 x8Eu0K0/vVaxBGKVLe7Qs0DJSPXg9Eh/J3Q6c39kS4m+lLD3q1hakEwFpckPQelH4e
	 hwkowWPkaoGpJj/OQl2pNaDA8EQm9bjk7Iwvd508KY04g1Zb6KaN5mdCX1GSX9Q+Pn
	 Iz4/4e/UTSB8s3e1plbynk1oGK8FrHhkWMrITb+BAN/vQua/HTgSUa12u4qHAq7W+8
	 ytji2BKn+8SSXX2GvAVvxphYS58DVt5c04V8Gq/8X58hTnGh9pfPIALbLUfATsuYVi
	 ge4o4NR6GVhOA==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 1/2] btrfs: send: remove unnecessary inode lookup at send_encoded_inline_extent()
Date: Thu,  6 Mar 2025 17:55:53 +0000
Message-Id: <89867e61f94b9a9f3711f66c141e4d483a9cc6bd.1741283556.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1741283556.git.fdmanana@suse.com>
References: <cover.1741283556.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

We doing a lookup of the inode but we don't use it at all. So just remove
this pointless lookup.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/send.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index e225530d3ebb..41e913e01d49 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -5523,7 +5523,6 @@ static int send_encoded_inline_extent(struct send_ctx *sctx,
 {
 	struct btrfs_root *root = sctx->send_root;
 	struct btrfs_fs_info *fs_info = root->fs_info;
-	struct inode *inode;
 	struct fs_path *fspath;
 	struct extent_buffer *leaf = path->nodes[0];
 	struct btrfs_key key;
@@ -5532,10 +5531,6 @@ static int send_encoded_inline_extent(struct send_ctx *sctx,
 	size_t inline_size;
 	int ret;
 
-	inode = btrfs_iget(sctx->cur_ino, root);
-	if (IS_ERR(inode))
-		return PTR_ERR(inode);
-
 	fspath = get_cur_inode_path(sctx);
 	if (IS_ERR(fspath)) {
 		ret = PTR_ERR(fspath);
@@ -5574,7 +5569,6 @@ static int send_encoded_inline_extent(struct send_ctx *sctx,
 
 tlv_put_failure:
 out:
-	iput(inode);
 	return ret;
 }
 
-- 
2.45.2


