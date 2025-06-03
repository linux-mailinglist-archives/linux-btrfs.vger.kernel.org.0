Return-Path: <linux-btrfs+bounces-14433-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80827ACCEDD
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Jun 2025 23:20:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8DB447A3CCB
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Jun 2025 21:19:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D138254918;
	Tue,  3 Jun 2025 21:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JO63nRZO"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E9DE224AF2
	for <linux-btrfs@vger.kernel.org>; Tue,  3 Jun 2025 21:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748985609; cv=none; b=Qpr+8VnWpR12wDLbEiXP+zLnd7kyU+L/9eY9VgiGUTQKbrsk1jiNc5iGAOEhR2FC+i7D02+4GxVVSGQjCJs1CZAAd6WA1bvDHoibnpMOq/fjpPXtAK2sqFDjriBPvg2JRzJfi0phI+Y7mZe9z5LG/0ilfCPFQEACiqVgxhFy/Yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748985609; c=relaxed/simple;
	bh=vKzYWb+pfCFUBAu1slroroCq0uPaoFb6GLK2TjNnJ3A=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qLsGrtitKXOTsuj08tMoUist2qlfTIOeQRYH1uHS5uWgek9lLkxRy57R2f1g3vgi2nVu+wp+dxwoh35XCCb9TqolLxYpTT4NN0sDdEg+KXEnLykjJByub/38KMLaE+k0/oZQFx2xzmrSD69qF1jBJSA8UBM24m8jzcljSl96Njw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JO63nRZO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 732AAC4CEEF
	for <linux-btrfs@vger.kernel.org>; Tue,  3 Jun 2025 21:20:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748985609;
	bh=vKzYWb+pfCFUBAu1slroroCq0uPaoFb6GLK2TjNnJ3A=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=JO63nRZOwITafs++t0cTy+6lK/31y6OTwgKru3Hlb8U1bjaSp2Ke7DdFnQBCoKfBI
	 9ORbl95T7ReGaTgtGyR21RuwffJBbJh8H3/ujCaklJ9yroEZ4ID6H5hMyKj7ppJz7O
	 qGYVvUshHah4mvnVuWa0jyyoC+Hraj38vHgn+wSyNDiRT2qKbf7fLlETdatS1QJRhO
	 Mdu1PDOisd20173JtFyHtZJYn5JNLbbnqAZeJAROiHa9Ez1/GER3Drjmzlj8L6ubUs
	 ovSjUOUUMcfPCNKxLwebK7C+A1JwRwMgQrzL5HSWBAmacUC4jhP5193fcS7bxsgv9t
	 +sExYHJJd53kQ==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2 1/2] btrfs: fix invalid inode pointer dereferences during log replay
Date: Tue,  3 Jun 2025 22:19:57 +0100
Message-ID: <dafe2575864ec8efbaf534bcef64e28d4adadbc5.1748985387.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <cover.1748985387.git.fdmanana@suse.com>
References: <cover.1748985387.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

In a few places where we call read_one_inode(), if we get a NULL pointer
we end up jumping into an error path, or fallthrough in case of
__add_inode_ref(), where we then do something like this:

   iput(&inode->vfs_inode);

which results in an invalid inode pointer that triggers an invalid memory
access, resulting in a crash.

Fix this by making sure we don't do such dereferences.

Fixes: b4c50cbb01a1 ("btrfs: return a btrfs_inode from read_one_inode()")
CC: stable@vger.kernel.org # 6.15+
Signed-off-by: Filipe Manana <fdmanana@suse.com>
Reviewed-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/tree-log.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 34ed9b2b1b83..c8dcc7d3f4b0 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -668,15 +668,12 @@ static noinline int replay_one_extent(struct btrfs_trans_handle *trans,
 		extent_end = ALIGN(start + size,
 				   fs_info->sectorsize);
 	} else {
-		ret = 0;
-		goto out;
+		return 0;
 	}
 
 	inode = read_one_inode(root, key->objectid);
-	if (!inode) {
-		ret = -EIO;
-		goto out;
-	}
+	if (!inode)
+		return -EIO;
 
 	/*
 	 * first check to see if we already have this extent in the
@@ -961,7 +958,8 @@ static noinline int drop_one_dir_item(struct btrfs_trans_handle *trans,
 	ret = unlink_inode_for_log_replay(trans, dir, inode, &name);
 out:
 	kfree(name.name);
-	iput(&inode->vfs_inode);
+	if (inode)
+		iput(&inode->vfs_inode);
 	return ret;
 }
 
@@ -1176,8 +1174,8 @@ static inline int __add_inode_ref(struct btrfs_trans_handle *trans,
 					ret = unlink_inode_for_log_replay(trans,
 							victim_parent,
 							inode, &victim_name);
+					iput(&victim_parent->vfs_inode);
 				}
-				iput(&victim_parent->vfs_inode);
 				kfree(victim_name.name);
 				if (ret)
 					return ret;
-- 
2.47.2


