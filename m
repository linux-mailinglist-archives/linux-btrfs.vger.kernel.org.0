Return-Path: <linux-btrfs+bounces-14364-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7933ACAC83
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Jun 2025 12:33:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ECADE400E6E
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Jun 2025 10:33:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88B4E20103A;
	Mon,  2 Jun 2025 10:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i6wTjXVM"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C329A1FF1A6
	for <linux-btrfs@vger.kernel.org>; Mon,  2 Jun 2025 10:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748860397; cv=none; b=qRwcnoytn6sI78YTNg9ghiqRWcCeDn83+aVhTB2auoqgNnRF0/BywvRy+PxRorNJsHELhyr1VrVvVDswzRFg7KLhR2aMEv0f/cM34y875kpYuX4SjzUeuu/ZlPgG5VZZGh1cJCrKjljCrYSF+yUgRVWc77KmsbPQxK1ywX2bPs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748860397; c=relaxed/simple;
	bh=7z2KpiUQzfwrpcii1F9eJuA58nhyrhJCE7IMzIexhZw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bErjcyf0huGp+rra1zFSMl4edhgVKujMoGy6aSBpRl7elpi2BVfTyboz50FxexsWd1I0vbDJj3y78z2W+8LBlgLYURvxoTBrBh/McN5TdWtQ1u6oqIdC1ssxSI6ovPMKYjKzfvCtz5jxRque4zwHXvtEIrhNLR+AFmyUzjLyed4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i6wTjXVM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28191C4CEF1
	for <linux-btrfs@vger.kernel.org>; Mon,  2 Jun 2025 10:33:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748860397;
	bh=7z2KpiUQzfwrpcii1F9eJuA58nhyrhJCE7IMzIexhZw=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=i6wTjXVMZB4EohHiAPTztDkhPigiCwkfWb/yohhLbsHKv9c7b2SR4KWRpzIVdFh4U
	 50ctasDi3bkBN7+UPWDVfBWqrzpP0IoKQ4G39GiaI7ggyYWcNPzvDxCczQQt3NSlLw
	 McSVE396eevYhWACFJMrHhvMJDTwhHVKkKHSi3cwqB4waqaPhOfSVHDjJltSlZg+sN
	 go6DibzXH/jqM3wWtZnkEd+v9WrqH73kga8SaEzdAa9QjliWgOYuMGRRzcQurWSfqa
	 CgNqb4OHksXtKMGGatK4Tju+lOBagAy54krPLfY2mggSiaInOMBJKuYSIGNN+byUrO
	 3Leh7k5QwNpow==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 03/14] btrfs: free path sooner at __btrfs_unlink_inode()
Date: Mon,  2 Jun 2025 11:32:56 +0100
Message-ID: <14d1a4a5621f5059dae764a8bfc9b114b6df029c.1748789125.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <cover.1748789125.git.fdmanana@suse.com>
References: <cover.1748789125.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

After calling btrfs_delete_one_dir_name() there's no need for the path
anymore so we can free it immediately after. After that point we do
some btree operations that take time and in those call chains we end up
allocating paths for these operations, so we're unnecessarily holding on
to the path we allocated early at __btrfs_unlink_inode().

So free the path as soon as we don't need it and add a comment. This
also allows to simplify the error path, removing two exit labels and
returning directly when an error happens.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/inode.c | 31 ++++++++++++++-----------------
 1 file changed, 14 insertions(+), 17 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 7bad21ec41f8..a9a37553bc45 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -4215,20 +4215,22 @@ static int __btrfs_unlink_inode(struct btrfs_trans_handle *trans,
 	u64 dir_ino = btrfs_ino(dir);
 
 	path = btrfs_alloc_path();
-	if (!path) {
-		ret = -ENOMEM;
-		goto out;
-	}
+	if (!path)
+		return -ENOMEM;
 
 	di = btrfs_lookup_dir_item(trans, root, path, dir_ino, name, -1);
 	if (IS_ERR_OR_NULL(di)) {
-		ret = di ? PTR_ERR(di) : -ENOENT;
-		goto err;
+		btrfs_free_path(path);
+		return di ? PTR_ERR(di) : -ENOENT;
 	}
 	ret = btrfs_delete_one_dir_name(trans, root, path, di);
+	/*
+	 * Down the call chains below we'll also need to allocate a path, so no
+	 * need to hold on to this one for longer than necessary.
+	 */
+	btrfs_free_path(path);
 	if (ret)
-		goto err;
-	btrfs_release_path(path);
+		return ret;
 
 	/*
 	 * If we don't have dir index, we have to get it by looking up
@@ -4254,7 +4256,7 @@ static int __btrfs_unlink_inode(struct btrfs_trans_handle *trans,
 	   "failed to delete reference to %.*s, root %llu inode %llu parent %llu",
 			   name->len, name->name, btrfs_root_id(root), ino, dir_ino);
 		btrfs_abort_transaction(trans, ret);
-		goto err;
+		return ret;
 	}
 skip_backref:
 	if (rename_ctx)
@@ -4263,7 +4265,7 @@ static int __btrfs_unlink_inode(struct btrfs_trans_handle *trans,
 	ret = btrfs_delete_delayed_dir_index(trans, dir, index);
 	if (ret) {
 		btrfs_abort_transaction(trans, ret);
-		goto err;
+		return ret;
 	}
 
 	/*
@@ -4287,19 +4289,14 @@ static int __btrfs_unlink_inode(struct btrfs_trans_handle *trans,
 	 * holding.
 	 */
 	btrfs_run_delayed_iput(fs_info, inode);
-err:
-	btrfs_free_path(path);
-	if (ret)
-		goto out;
 
 	btrfs_i_size_write(dir, dir->vfs_inode.i_size - name->len * 2);
 	inode_inc_iversion(&inode->vfs_inode);
 	inode_set_ctime_current(&inode->vfs_inode);
 	inode_inc_iversion(&dir->vfs_inode);
  	inode_set_mtime_to_ts(&dir->vfs_inode, inode_set_ctime_current(&dir->vfs_inode));
-	ret = btrfs_update_inode(trans, dir);
-out:
-	return ret;
+
+	return btrfs_update_inode(trans, dir);
 }
 
 int btrfs_unlink_inode(struct btrfs_trans_handle *trans,
-- 
2.47.2


