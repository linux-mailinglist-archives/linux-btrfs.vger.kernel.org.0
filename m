Return-Path: <linux-btrfs+bounces-10567-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AF649F6BF2
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Dec 2024 18:08:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A75518905C1
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Dec 2024 17:07:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7FCC1FAC30;
	Wed, 18 Dec 2024 17:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F3VNyukZ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4A701FA8F9
	for <linux-btrfs@vger.kernel.org>; Wed, 18 Dec 2024 17:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734541623; cv=none; b=l4PkS01csoaI8AxUt82gNZ4IZB3twRgA1AlYKrrMHldO2MXml/wJoD8mWkxhXyBFWe/nnwjuvXKX0b9J/BLBR/bcX1fySeikdBxzZIhNvNiGwG46tGDLDHnuXA65h8keyFJG0alJmqawgb2bYXbG1crJ13XOJezlL5eGZkU6t5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734541623; c=relaxed/simple;
	bh=7geP1RmZK0P6k/1W9BT/0jpieO5k9sruie7dVTuCf6A=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LGmuPFfvuD/dCioSzefdRq9z/FXIFVCvIWs1GJM9G6TvUKDiyUWiOmejmKu/Baiae8w2nV6qvP7eHVdZuXmylpoFHflMMUeeXr0eWLtHrS5F7ucAmtA5VG5TF5jdJ8QGsxOjIOB7IhWh7ER4xw/FxlXtqV5B+t04rhOFwEUdbuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F3VNyukZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DC0DC4CECD
	for <linux-btrfs@vger.kernel.org>; Wed, 18 Dec 2024 17:07:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734541622;
	bh=7geP1RmZK0P6k/1W9BT/0jpieO5k9sruie7dVTuCf6A=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=F3VNyukZLGecGER1D1Tkq5BxmMtbIPIPRpIyS/xoeQnPCuFcsUpfhCNnxJ83fdAFf
	 R8qvhmHRgwPOoAcYpIto+V659Zb8m4bKDC4Cy7Sl1Yl4z/liFZ4hgqlc+8eaznH6Ts
	 truZZCmYUkZbj0d1p3NrNvriXeQjVYxlddJU2Vnw9Yb9R0r/b8P8PK4MlAo47D8DVY
	 vnGmjoR4LNooYM1+SQLjdJuDHcwfg1HTzNk/uobXXirUcFU538PQQGT7suNVc/kgjW
	 YG/0MiaVW02DYEbJbQSC/mzhVGLrfBNRZoHhBXAWi3ljyi9nsp7Maay6ofwkHckNfy
	 JY66jLxIttGSg==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 11/20] btrfs: inode: remove unnecessary calls to btrfs_mark_buffer_dirty()
Date: Wed, 18 Dec 2024 17:06:38 +0000
Message-Id: <a701b8d6054f5439414fdc61e0ecf9d3dd9514ae.1734527445.git.fdmanana@suse.com>
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
 fs/btrfs/inode.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 8a173a24ac05..052ed957f65a 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -564,7 +564,6 @@ static int insert_inline_extent(struct btrfs_trans_handle *trans,
 		kunmap_local(kaddr);
 		folio_put(folio);
 	}
-	btrfs_mark_buffer_dirty(trans, leaf);
 	btrfs_release_path(path);
 
 	/*
@@ -2918,7 +2917,6 @@ static int insert_reserved_file_extent(struct btrfs_trans_handle *trans,
 			btrfs_item_ptr_offset(leaf, path->slots[0]),
 			sizeof(struct btrfs_file_extent_item));
 
-	btrfs_mark_buffer_dirty(trans, leaf);
 	btrfs_release_path(path);
 
 	/*
@@ -4082,7 +4080,6 @@ static noinline int btrfs_update_inode_item(struct btrfs_trans_handle *trans,
 				    struct btrfs_inode_item);
 
 	fill_inode_item(trans, leaf, inode_item, &inode->vfs_inode);
-	btrfs_mark_buffer_dirty(trans, leaf);
 	btrfs_set_inode_last_trans(trans, inode);
 	ret = 0;
 failed:
@@ -6377,7 +6374,6 @@ int btrfs_create_new_inode(struct btrfs_trans_handle *trans,
 		}
 	}
 
-	btrfs_mark_buffer_dirty(trans, path->nodes[0]);
 	/*
 	 * We don't need the path anymore, plus inheriting properties, adding
 	 * ACLs, security xattrs, orphan item or adding the link, will result in
@@ -8649,7 +8645,6 @@ static int btrfs_symlink(struct mnt_idmap *idmap, struct inode *dir,
 
 	ptr = btrfs_file_extent_inline_start(ei);
 	write_extent_buffer(leaf, symname, ptr, name_len);
-	btrfs_mark_buffer_dirty(trans, leaf);
 	btrfs_free_path(path);
 
 	d_instantiate_new(dentry, inode);
-- 
2.45.2


