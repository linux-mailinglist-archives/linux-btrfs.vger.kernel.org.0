Return-Path: <linux-btrfs+bounces-10738-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C0331A02586
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 Jan 2025 13:31:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B0F94163D9D
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 Jan 2025 12:31:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8034C1DEFF3;
	Mon,  6 Jan 2025 12:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TQzx0btW"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B39031DDC0C
	for <linux-btrfs@vger.kernel.org>; Mon,  6 Jan 2025 12:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736166546; cv=none; b=jAhB6DiggQXqgkh8PPc9kbtboKRTQR8/jW30QmGuvMLj30NQN0JY3hCTKOyf576QiTu+fsnISvtvbxn2zjH1zX7m53Balw5nZ7FyoOLwFocJWBf9PtBz5iW6vLZCEmQ+LzJi1UK/814jJNVAK1FRuu6xdbHaTHSnaEKeoprnHPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736166546; c=relaxed/simple;
	bh=8nQFpg4srVjnVBakoD/E8LMAHzrlU8vPg8O5UU9HMkM=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=k/5WvBV/16Q8zcuJ2fwQBEw2PzjdafDTgaA0EasQJdpQX/frAIZnXDxb/3HFBzCfd1zcAttgJa5hhSSaOsQmgK/tv1vIBGHQ87R1GESIBaKYR0QIAWex+3lBr6SBkN/HfzWFgV0swTn4wRMuDUc6MprUe5ebFppBg4DaOcgofzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TQzx0btW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 957BAC4CED2
	for <linux-btrfs@vger.kernel.org>; Mon,  6 Jan 2025 12:29:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736166546;
	bh=8nQFpg4srVjnVBakoD/E8LMAHzrlU8vPg8O5UU9HMkM=;
	h=From:To:Subject:Date:From;
	b=TQzx0btWCOgXe8ilmjBleIMcGI1D/D6M2NbKLfW02k+ly/yLADuwUjIHILPubCIZP
	 KbXtsz7tTJBiJp4xiHeqr7fiImpWX59wPVqzVEsXK+8PYxzBt9MaykrUoZ+634mNBd
	 Ks/VM7dVpm1eZfOd0HYjxuDp8WW2zY966oAkPPA0X0wVxueqvmCVJGG0vd7DTGndQt
	 WZ4jQTED4uYYl5vH7PeG4F2F8IGBlp1k/qo0yCbTjTwj+fcX/L6fJXVNJUBByvMQ0O
	 dLbcP3QopuGK7Ctw7wLqVK4Cpd4k/O2gtAZABz+Jf9stiZU26xxJXvRXnT7etEXrIn
	 7rPwgAi12KgPA==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: uncollapse transaction aborts during renames
Date: Mon,  6 Jan 2025 12:28:59 +0000
Message-Id: <056d1f47ac66212fc97565d873f29213fb86d13f.1736165787.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

During renames we are grouping transaction aborts that can be due to a
failure of one of several function calls. While this makes the code less
verbose, it makes it harder to debug as we end up not knowing from which
function call we got an error.

So change this to trigger a transaction abort after each function call
failure, so that when we get a transaction abort message we know exactly
which function call failed, helping us to debug issues.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/inode.c | 74 ++++++++++++++++++++++++++++++++++--------------
 1 file changed, 52 insertions(+), 22 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 8a173a24ac05..a7a3d879f2f2 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -8021,31 +8021,45 @@ static int btrfs_rename_exchange(struct inode *old_dir,
 	/* src is a subvolume */
 	if (old_ino == BTRFS_FIRST_FREE_OBJECTID) {
 		ret = btrfs_unlink_subvol(trans, BTRFS_I(old_dir), old_dentry);
+		if (ret) {
+			btrfs_abort_transaction(trans, ret);
+			goto out_fail;
+		}
 	} else { /* src is an inode */
 		ret = __btrfs_unlink_inode(trans, BTRFS_I(old_dir),
 					   BTRFS_I(old_dentry->d_inode),
 					   old_name, &old_rename_ctx);
-		if (!ret)
-			ret = btrfs_update_inode(trans, BTRFS_I(old_inode));
-	}
-	if (ret) {
-		btrfs_abort_transaction(trans, ret);
-		goto out_fail;
+		if (ret) {
+			btrfs_abort_transaction(trans, ret);
+			goto out_fail;
+		}
+		ret = btrfs_update_inode(trans, BTRFS_I(old_inode));
+		if (ret) {
+			btrfs_abort_transaction(trans, ret);
+			goto out_fail;
+		}
 	}
 
 	/* dest is a subvolume */
 	if (new_ino == BTRFS_FIRST_FREE_OBJECTID) {
 		ret = btrfs_unlink_subvol(trans, BTRFS_I(new_dir), new_dentry);
+		if (ret) {
+			btrfs_abort_transaction(trans, ret);
+			goto out_fail;
+		}
 	} else { /* dest is an inode */
 		ret = __btrfs_unlink_inode(trans, BTRFS_I(new_dir),
 					   BTRFS_I(new_dentry->d_inode),
 					   new_name, &new_rename_ctx);
-		if (!ret)
-			ret = btrfs_update_inode(trans, BTRFS_I(new_inode));
-	}
-	if (ret) {
-		btrfs_abort_transaction(trans, ret);
-		goto out_fail;
+		if (ret) {
+			btrfs_abort_transaction(trans, ret);
+			goto out_fail;
+		}
+		ret = btrfs_update_inode(trans, BTRFS_I(new_inode));
+		if (ret) {
+			btrfs_abort_transaction(trans, ret);
+			goto out_fail;
+		}
 	}
 
 	ret = btrfs_add_link(trans, BTRFS_I(new_dir), BTRFS_I(old_inode),
@@ -8281,16 +8295,23 @@ static int btrfs_rename(struct mnt_idmap *idmap,
 
 	if (unlikely(old_ino == BTRFS_FIRST_FREE_OBJECTID)) {
 		ret = btrfs_unlink_subvol(trans, BTRFS_I(old_dir), old_dentry);
+		if (ret) {
+			btrfs_abort_transaction(trans, ret);
+			goto out_fail;
+		}
 	} else {
 		ret = __btrfs_unlink_inode(trans, BTRFS_I(old_dir),
 					   BTRFS_I(d_inode(old_dentry)),
 					   &old_fname.disk_name, &rename_ctx);
-		if (!ret)
-			ret = btrfs_update_inode(trans, BTRFS_I(old_inode));
-	}
-	if (ret) {
-		btrfs_abort_transaction(trans, ret);
-		goto out_fail;
+		if (ret) {
+			btrfs_abort_transaction(trans, ret);
+			goto out_fail;
+		}
+		ret = btrfs_update_inode(trans, BTRFS_I(old_inode));
+		if (ret) {
+			btrfs_abort_transaction(trans, ret);
+			goto out_fail;
+		}
 	}
 
 	if (new_inode) {
@@ -8298,18 +8319,27 @@ static int btrfs_rename(struct mnt_idmap *idmap,
 		if (unlikely(btrfs_ino(BTRFS_I(new_inode)) ==
 			     BTRFS_EMPTY_SUBVOL_DIR_OBJECTID)) {
 			ret = btrfs_unlink_subvol(trans, BTRFS_I(new_dir), new_dentry);
+			if (ret) {
+				btrfs_abort_transaction(trans, ret);
+				goto out_fail;
+			}
 			BUG_ON(new_inode->i_nlink == 0);
 		} else {
 			ret = btrfs_unlink_inode(trans, BTRFS_I(new_dir),
 						 BTRFS_I(d_inode(new_dentry)),
 						 &new_fname.disk_name);
+			if (ret) {
+				btrfs_abort_transaction(trans, ret);
+				goto out_fail;
+			}
 		}
-		if (!ret && new_inode->i_nlink == 0)
+		if (new_inode->i_nlink == 0) {
 			ret = btrfs_orphan_add(trans,
 					BTRFS_I(d_inode(new_dentry)));
-		if (ret) {
-			btrfs_abort_transaction(trans, ret);
-			goto out_fail;
+			if (ret) {
+				btrfs_abort_transaction(trans, ret);
+				goto out_fail;
+			}
 		}
 	}
 
-- 
2.45.2


