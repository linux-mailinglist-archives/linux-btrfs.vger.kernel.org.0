Return-Path: <linux-btrfs+bounces-2283-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A75DA84FB67
	for <lists+linux-btrfs@lfdr.de>; Fri,  9 Feb 2024 19:01:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 682B928E26B
	for <lists+linux-btrfs@lfdr.de>; Fri,  9 Feb 2024 18:01:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 748168288B;
	Fri,  9 Feb 2024 18:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CE+XgMI7"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A07988287A
	for <linux-btrfs@vger.kernel.org>; Fri,  9 Feb 2024 18:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707501657; cv=none; b=KWvWX8wZVSQVG/M/GK5a5ZncCx10/PQvlWBJxpJb63JUYxW8tgXKnINYnuUlgNgwvhzmHICpBAsyuRBvcanAqEBYaNOlx9DaFh1bdbfbnq0EZWGz+rJkEnvLIuQ+HmCowW1/D2tGEVUFsZmMKN00qB3Oie2rzhRe6J6YqtS1h+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707501657; c=relaxed/simple;
	bh=UzZsENWxpdgWGpke/WxlbDL6Wcez4rfdx7sJpptjtEU=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cCri/kR7HEJZOymEmkdLdT+32qxsOo3fAixkufEKobq2DLad2T2bDiswbvUaQFYPLUBWTiUC+yiBMnbXTb420YsUaejHbC2Lk5GdTphiySvirTW/P+/TziQyXhwhxUCe3j9u06WMhbL7zTUf7UAZOtJYbHm1CPc7H+8ssRMuKag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CE+XgMI7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80294C43399
	for <linux-btrfs@vger.kernel.org>; Fri,  9 Feb 2024 18:00:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707501657;
	bh=UzZsENWxpdgWGpke/WxlbDL6Wcez4rfdx7sJpptjtEU=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=CE+XgMI7Wk3TFe+wTIVq3o4bCf1+P5OJzhLRb7M8KTYvMS6t/6HhBGjqZBBT2Ly5u
	 aKo6ENEngqlNvuaZ/0zIj9Do+PdcPG0pM4O5q5OHOGENiR3Ol7jVX2hrwbAww4SHYn
	 6CZkdUEas+PBye6BcVztJtOdR2PiZYf8GoxKHSs73+cyucC1HO2SPZ8Ys6AB2b5jGh
	 SxotCMgekJ8TZ3fON2x9rKOLvnOGmsIseux4W/TOAeOacBU94eeotGiTowlCFhRVDA
	 Z8vMdQPMdNQLD/pOWI6sQGIErEcQXFWC9sw2jvsrkPpw+P2gq39A4HMPNrcinDRWwG
	 ASxXePOke9HMA==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 2/9] btrfs: stop passing root argument to __btrfs_del_delalloc_inode()
Date: Fri,  9 Feb 2024 18:00:44 +0000
Message-Id: <ff5a4f734ea78954aa38c0c4fbb64461102cde7b.1707491248.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1707491248.git.fdmanana@suse.com>
References: <cover.1707491248.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

There's no need to pass a root argument to __btrfs_del_delalloc_inode()
and btrfs_del_delalloc_inode(), we can just pass the inode since the root
is always the root associated to that inode. Some remove the root argument
from these functions.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/btrfs_inode.h |  2 +-
 fs/btrfs/disk-io.c     |  2 +-
 fs/btrfs/inode.c       | 15 +++++++--------
 3 files changed, 9 insertions(+), 10 deletions(-)

diff --git a/fs/btrfs/btrfs_inode.h b/fs/btrfs/btrfs_inode.h
index 83d78a6f3aa2..32c59c5bd94d 100644
--- a/fs/btrfs/btrfs_inode.h
+++ b/fs/btrfs/btrfs_inode.h
@@ -428,7 +428,7 @@ noinline int can_nocow_extent(struct inode *inode, u64 offset, u64 *len,
 			      u64 *orig_start, u64 *orig_block_len,
 			      u64 *ram_bytes, bool nowait, bool strict);
 
-void __btrfs_del_delalloc_inode(struct btrfs_root *root, struct btrfs_inode *inode);
+void __btrfs_del_delalloc_inode(struct btrfs_inode *inode);
 struct inode *btrfs_lookup_dentry(struct inode *dir, struct dentry *dentry);
 int btrfs_set_inode_index(struct btrfs_inode *dir, u64 *index);
 int btrfs_unlink_inode(struct btrfs_trans_handle *trans,
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 4280f8e23461..8ab185182c30 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -4629,7 +4629,7 @@ static void btrfs_destroy_delalloc_inodes(struct btrfs_root *root)
 		struct inode *inode = NULL;
 		btrfs_inode = list_first_entry(&splice, struct btrfs_inode,
 					       delalloc_inodes);
-		__btrfs_del_delalloc_inode(root, btrfs_inode);
+		__btrfs_del_delalloc_inode(btrfs_inode);
 		spin_unlock(&root->delalloc_lock);
 
 		/*
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index e3d12d8cf088..ec8af7d0f166 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -2406,9 +2406,9 @@ static void btrfs_add_delalloc_inodes(struct btrfs_inode *inode)
 	spin_unlock(&root->delalloc_lock);
 }
 
-void __btrfs_del_delalloc_inode(struct btrfs_root *root,
-				struct btrfs_inode *inode)
+void __btrfs_del_delalloc_inode(struct btrfs_inode *inode)
 {
+	struct btrfs_root *root = inode->root;
 	struct btrfs_fs_info *fs_info = root->fs_info;
 
 	if (!list_empty(&inode->delalloc_inodes)) {
@@ -2426,12 +2426,11 @@ void __btrfs_del_delalloc_inode(struct btrfs_root *root,
 	}
 }
 
-static void btrfs_del_delalloc_inode(struct btrfs_root *root,
-				     struct btrfs_inode *inode)
+static void btrfs_del_delalloc_inode(struct btrfs_inode *inode)
 {
-	spin_lock(&root->delalloc_lock);
-	__btrfs_del_delalloc_inode(root, inode);
-	spin_unlock(&root->delalloc_lock);
+	spin_lock(&inode->root->delalloc_lock);
+	__btrfs_del_delalloc_inode(inode);
+	spin_unlock(&inode->root->delalloc_lock);
 }
 
 /*
@@ -2538,7 +2537,7 @@ void btrfs_clear_delalloc_extent(struct btrfs_inode *inode,
 		if (do_list && inode->delalloc_bytes == 0 &&
 		    test_bit(BTRFS_INODE_IN_DELALLOC_LIST,
 					&inode->runtime_flags))
-			btrfs_del_delalloc_inode(root, inode);
+			btrfs_del_delalloc_inode(inode);
 		spin_unlock(&inode->lock);
 	}
 
-- 
2.40.1


