Return-Path: <linux-btrfs+bounces-12093-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B9C6A5693E
	for <lists+linux-btrfs@lfdr.de>; Fri,  7 Mar 2025 14:45:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE36D175DF9
	for <lists+linux-btrfs@lfdr.de>; Fri,  7 Mar 2025 13:45:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D47C21B181;
	Fri,  7 Mar 2025 13:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F6v/TvLX"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CA41219A67
	for <linux-btrfs@vger.kernel.org>; Fri,  7 Mar 2025 13:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741355076; cv=none; b=VtLoFi+gxeCJUcV5ZQmb4d5SdGuxxreu8zBuN6oJUPfsbExGr+vdrUTtwCnGSm7lUAue+b7UTOQgNMSd6s2MaQ1tbjKdhg/icU3gPPr80V7vfA/VpZSOKGyxM2aDYzET0PPVSI3nNvdv5pKhYpZzrn+7UlzPg35d8UXpIYq2Fx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741355076; c=relaxed/simple;
	bh=DciSq+52MVf5oVMqL406ZFfUSr69GL3CPVCC7Yxy/88=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WmMLNSn8P4gT3i3IWbihfWQTx4S2af42IkNXgyix6X72MdKgfuVrEnJNdboHWESL4F2FYlGAHZEWCXPXJfdxy97Sovtq/G44FRyEXBBxo6jl9LEjwx92bnWPS0kFcfEiCT8Au1Q1QIHzAKGbyTQ0ZZg/ab0E7pxJcyYPb2UENZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F6v/TvLX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74F8DC4CED1
	for <linux-btrfs@vger.kernel.org>; Fri,  7 Mar 2025 13:44:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741355076;
	bh=DciSq+52MVf5oVMqL406ZFfUSr69GL3CPVCC7Yxy/88=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=F6v/TvLXqeBrf/JbYXFsH1AaTn0DaEtn0nu5DUiTlGom6S84Fc1TKjjryNctOc736
	 I4kq38Kd31isodE9E/U/MlFelO93ZYV5zffqiP/NLRf47XgG5L3uHGL/hZSlVUFUah
	 yM6OpO6ajESHgAHCOZj58iorUVSCsXrNbj2znoqV0yAZe+XZ6YcOV7g5vyCpVQuOZH
	 Y5P+zpiSNgdvNWF1LV1v9FUdzAkMJARrL3SMgeMxUno/16LlsKoKPWC4+hxQTB6xnO
	 2Bgw2g6R5nSa7lSP09pzBc8uehSV992fnQY/Jik6fGqHmblSIQboBB/bp2t2zZiial
	 YdgMxkD0bULeQ==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 7/8] btrfs: remove unnecessary fs_info argument from delete_block_group_cache()
Date: Fri,  7 Mar 2025 13:44:24 +0000
Message-Id: <27c0ae100c9365c520593e67681d3a69ae5a364f.1741354480.git.fdmanana@suse.com>
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

The fs_info can be taken from the given block group, so there is no need
to pass it as an argument.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/relocation.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 33d3b5ca7ee0..f948f4f6431c 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -3239,11 +3239,11 @@ static int __add_tree_block(struct reloc_control *rc,
 	return ret;
 }
 
-static int delete_block_group_cache(struct btrfs_fs_info *fs_info,
-				    struct btrfs_block_group *block_group,
+static int delete_block_group_cache(struct btrfs_block_group *block_group,
 				    struct inode *inode,
 				    u64 ino)
 {
+	struct btrfs_fs_info *fs_info = block_group->fs_info;
 	struct btrfs_root *root = fs_info->tree_root;
 	struct btrfs_trans_handle *trans;
 	struct btrfs_inode *btrfs_inode;
@@ -3315,8 +3315,7 @@ static int delete_v1_space_cache(struct extent_buffer *leaf,
 	}
 	if (!found)
 		return -ENOENT;
-	ret = delete_block_group_cache(leaf->fs_info, block_group, NULL,
-					space_cache_ino);
+	ret = delete_block_group_cache(block_group, NULL, space_cache_ino);
 	return ret;
 }
 
@@ -3980,7 +3979,7 @@ int btrfs_relocate_block_group(struct btrfs_fs_info *fs_info, u64 group_start)
 	btrfs_free_path(path);
 
 	if (!IS_ERR(inode))
-		ret = delete_block_group_cache(fs_info, rc->block_group, inode, 0);
+		ret = delete_block_group_cache(rc->block_group, inode, 0);
 	else
 		ret = PTR_ERR(inode);
 
-- 
2.45.2


