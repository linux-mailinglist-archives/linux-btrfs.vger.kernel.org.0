Return-Path: <linux-btrfs+bounces-10236-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C5309ECF14
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Dec 2024 15:54:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0095284BBE
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Dec 2024 14:54:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C2911D8E1A;
	Wed, 11 Dec 2024 14:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZdqnIQ0k"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 020D51D6DBB
	for <linux-btrfs@vger.kernel.org>; Wed, 11 Dec 2024 14:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733928821; cv=none; b=rgEDmIcjioafBPvOjapicsWPP5K8YprgB3JOVoM3lFsBSOPFKLtXj8sFNRWa2IScGxqFNdRNh9v+GvLzNp7LPvt6mLoMZ6GjKW5ObRbvdmxZ80BQdmL7Gs/mPuXKlZyMBR+DLPpxnx8dHMeeqkEcZdtMx0Qi/i22RBjcKTtqUCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733928821; c=relaxed/simple;
	bh=Vc2HYuXc5jCwXidfHBZdaXlbz2uKzzjm7GSQzu3eYA4=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=S3S3i9ZHOd56gTyC6yNB33fu7S1J9p25PlijR/ON/efCaP4oCrZP3neDC/l+V9CHcLFiV3fXBCJCVQyjZCgsMtGByZw3s2SAgrlq+LU1z59NdkpuvZ/In73D7MjXP7vSPxf2cFn1Oj2XdWr2t6/v5zo3+9ZQ+HoYmfFWLwSnHCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZdqnIQ0k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45B69C4CED4
	for <linux-btrfs@vger.kernel.org>; Wed, 11 Dec 2024 14:53:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733928820;
	bh=Vc2HYuXc5jCwXidfHBZdaXlbz2uKzzjm7GSQzu3eYA4=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=ZdqnIQ0kh9Cb9R5k6FDMfmOEvnQxa3TgFLYVVInuN8HYCgVIVt49qcf/YBKFn8SFG
	 f1O+kOOI5sbBnkGgeSSlU4y5joaEiegYWrzofohEm6J6pyWMxlyP+skSP/kJnVTlBs
	 wHgOk05+YYiMg2p4z9/tKrFuwZDuMJAMJaRLR02Yogellwej+6p2y3kPmFO0esHd4x
	 pNWApyhrnyAk1yEFyYbRky4w/BukfWwtRo13CClVBbVZ2n21RmgWpGnOQ/1qorENoh
	 Vq6iofdh4mN6xgupt/M/8JAcUme5M2fzifnJMd3HMWVDeNdSYfuxwL78p3OWN+4rke
	 1dv9YAf/akNXA==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 09/11] btrfs: simplify arguments for btrfs_cross_ref_exist()
Date: Wed, 11 Dec 2024 14:53:26 +0000
Message-Id: <9e374da66e73917c33b27bff49ba1627c0fda3e0.1733832118.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1733832118.git.fdmanana@suse.com>
References: <cover.1733832118.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

Instead of passing a root and an objectid which matches an inode number,
pass the inode instead, since the root is always the root associated to
the inode and the objectid is the number of that inode.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/extent-tree.c | 22 ++++++++++++----------
 fs/btrfs/extent-tree.h |  3 +--
 fs/btrfs/inode.c       |  3 +--
 3 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 51c49b2f4991..af3893ad784b 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -2206,10 +2206,11 @@ int btrfs_set_disk_extent_flags(struct btrfs_trans_handle *trans,
 	return ret;
 }
 
-static noinline int check_delayed_ref(struct btrfs_root *root,
+static noinline int check_delayed_ref(struct btrfs_inode *inode,
 				      struct btrfs_path *path,
-				      u64 objectid, u64 offset, u64 bytenr)
+				      u64 offset, u64 bytenr)
 {
+	struct btrfs_root *root = inode->root;
 	struct btrfs_delayed_ref_head *head;
 	struct btrfs_delayed_ref_node *ref;
 	struct btrfs_delayed_ref_root *delayed_refs;
@@ -2283,7 +2284,7 @@ static noinline int check_delayed_ref(struct btrfs_root *root,
 		 * then we have a cross reference.
 		 */
 		if (ref->ref_root != btrfs_root_id(root) ||
-		    ref_owner != objectid || ref_offset != offset) {
+		    ref_owner != btrfs_ino(inode) || ref_offset != offset) {
 			ret = 1;
 			break;
 		}
@@ -2294,10 +2295,11 @@ static noinline int check_delayed_ref(struct btrfs_root *root,
 	return ret;
 }
 
-static noinline int check_committed_ref(struct btrfs_root *root,
+static noinline int check_committed_ref(struct btrfs_inode *inode,
 					struct btrfs_path *path,
-					u64 objectid, u64 offset, u64 bytenr)
+					u64 offset, u64 bytenr)
 {
+	struct btrfs_root *root = inode->root;
 	struct btrfs_fs_info *fs_info = root->fs_info;
 	struct btrfs_root *extent_root = btrfs_extent_root(fs_info, bytenr);
 	struct extent_buffer *leaf;
@@ -2364,29 +2366,29 @@ static noinline int check_committed_ref(struct btrfs_root *root,
 	if (btrfs_extent_refs(leaf, ei) !=
 	    btrfs_extent_data_ref_count(leaf, ref) ||
 	    btrfs_extent_data_ref_root(leaf, ref) != btrfs_root_id(root) ||
-	    btrfs_extent_data_ref_objectid(leaf, ref) != objectid ||
+	    btrfs_extent_data_ref_objectid(leaf, ref) != btrfs_ino(inode) ||
 	    btrfs_extent_data_ref_offset(leaf, ref) != offset)
 		return 1;
 
 	return 0;
 }
 
-int btrfs_cross_ref_exist(struct btrfs_root *root, u64 objectid, u64 offset,
+int btrfs_cross_ref_exist(struct btrfs_inode *inode, u64 offset,
 			  u64 bytenr, struct btrfs_path *path)
 {
 	int ret;
 
 	do {
-		ret = check_committed_ref(root, path, objectid, offset, bytenr);
+		ret = check_committed_ref(inode, path, offset, bytenr);
 		if (ret && ret != -ENOENT)
 			goto out;
 
-		ret = check_delayed_ref(root, path, objectid, offset, bytenr);
+		ret = check_delayed_ref(inode, path, offset, bytenr);
 	} while (ret == -EAGAIN && !path->nowait);
 
 out:
 	btrfs_release_path(path);
-	if (btrfs_is_data_reloc_root(root))
+	if (btrfs_is_data_reloc_root(inode->root))
 		WARN_ON(ret > 0);
 	return ret;
 }
diff --git a/fs/btrfs/extent-tree.h b/fs/btrfs/extent-tree.h
index ee62035c4a71..46b8e19022df 100644
--- a/fs/btrfs/extent-tree.h
+++ b/fs/btrfs/extent-tree.h
@@ -116,8 +116,7 @@ int btrfs_pin_extent(struct btrfs_trans_handle *trans, u64 bytenr, u64 num,
 int btrfs_pin_extent_for_log_replay(struct btrfs_trans_handle *trans,
 				    const struct extent_buffer *eb);
 int btrfs_exclude_logged_extents(struct extent_buffer *eb);
-int btrfs_cross_ref_exist(struct btrfs_root *root,
-			  u64 objectid, u64 offset, u64 bytenr,
+int btrfs_cross_ref_exist(struct btrfs_inode *inode, u64 offset, u64 bytenr,
 			  struct btrfs_path *path);
 struct extent_buffer *btrfs_alloc_tree_block(struct btrfs_trans_handle *trans,
 					     struct btrfs_root *root,
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 0965a29cf4f7..8a173a24ac05 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -1920,8 +1920,7 @@ static int can_nocow_file_extent(struct btrfs_path *path,
 	 */
 	btrfs_release_path(path);
 
-	ret = btrfs_cross_ref_exist(root, btrfs_ino(inode),
-				    key->offset - args->file_extent.offset,
+	ret = btrfs_cross_ref_exist(inode, key->offset - args->file_extent.offset,
 				    args->file_extent.disk_bytenr, path);
 	WARN_ON_ONCE(ret > 0 && is_freespace_inode);
 	if (ret != 0)
-- 
2.45.2


