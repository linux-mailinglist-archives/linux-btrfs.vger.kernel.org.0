Return-Path: <linux-btrfs+bounces-19795-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DDCDCC4507
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Dec 2025 17:33:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D895A300A568
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Dec 2025 16:33:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F75F26299;
	Tue, 16 Dec 2025 16:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O+lR5Y7Z"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F89623D7D4
	for <linux-btrfs@vger.kernel.org>; Tue, 16 Dec 2025 16:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765902803; cv=none; b=LetrbA6bjL4qXAjPG51IfEoZo7H6jKudhKJA+cLnlIMqpPyq1Y5d+MZJAuAzako5BehL/U8yL97/3yLAqS22b3YIVRtpAwC7CU4ZqQ+3OKQ6/iPPXEZTzobHTFyQACBD6IBWi50VZg3+K41lj63yNslstk4+QLuDmHUSEmW35i4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765902803; c=relaxed/simple;
	bh=yDYOvxHCynZMnl2Kmv5loXUjeBJ2+m9O0xuFh8Oc9eo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ArCJoLQB+BrbtYhIFil2tZ4yNfXjkU55NMvfXwGdPtVVfxr/qn8Yfi3iz9C73N0FMWokJGvjASBv3tQDljz8LqUuCNwSVFY8M5ddWNEnL2tF29C+2ICINpPK165pFmIWV8e4nOV63O4e3gcLwbgKuXfjDuKA8vWDo1GJfhqHM9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O+lR5Y7Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A202C16AAE
	for <linux-btrfs@vger.kernel.org>; Tue, 16 Dec 2025 16:33:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765902803;
	bh=yDYOvxHCynZMnl2Kmv5loXUjeBJ2+m9O0xuFh8Oc9eo=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=O+lR5Y7ZWanTtM9Gwd9Cb6HathooTii8gWT3Mpgu19Z3zfcZFyR/Z8YpXV5VAoXWx
	 cRZIXchpYihRL5AP5boYSBjEMHwlFjuUUFS855B6PMmDP91PYNOiqgsZehTh2c4Ojh
	 Fs3DNbhLL8j4NeueSDNDUD5zq/9OewriNgYuFiCJ3a92N/XB9oQn/4WOtb9iLuhV1I
	 L254hsO3kJ2AvqURlknnUQS9TLAGykybFoAwFkC5DWoss9ZI/J5lHO5TkrYFh9+Ubl
	 xtvdYYvQeqCp/6FzjZkiiK1gg64OADpeiL7cF9Quui8KB7RUP5Vhj36dmKttavsKzM
	 Bnkl2VQU2qHnA==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 1/4] btrfs: use single return variable in btrfs_find_orphan_roots()
Date: Tue, 16 Dec 2025 16:33:16 +0000
Message-ID: <d95588f0ae2023c3b12817f868b26929eceb63b5.1765899509.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <cover.1765899509.git.fdmanana@suse.com>
References: <cover.1765899509.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

We use both 'ret' and 'err' which is a pattern that generates confusion
and resulted in subtle bugs in the past. Remove 'err' and use only 'ret'.
Also move simplify the error flow by directy returning from the function
instead of breaking of the loop, since there are no resources to cleanup
after the loop.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/root-tree.c | 40 ++++++++++++++++++----------------------
 1 file changed, 18 insertions(+), 22 deletions(-)

diff --git a/fs/btrfs/root-tree.c b/fs/btrfs/root-tree.c
index 6a7e297ab0a7..a7171112d638 100644
--- a/fs/btrfs/root-tree.c
+++ b/fs/btrfs/root-tree.c
@@ -217,8 +217,6 @@ int btrfs_find_orphan_roots(struct btrfs_fs_info *fs_info)
 	BTRFS_PATH_AUTO_FREE(path);
 	struct btrfs_key key;
 	struct btrfs_root *root;
-	int err = 0;
-	int ret;
 
 	path = btrfs_alloc_path();
 	if (!path)
@@ -230,20 +228,19 @@ int btrfs_find_orphan_roots(struct btrfs_fs_info *fs_info)
 
 	while (1) {
 		u64 root_objectid;
+		int ret;
 
 		ret = btrfs_search_slot(NULL, tree_root, &key, path, 0, 0);
-		if (ret < 0) {
-			err = ret;
-			break;
-		}
+		if (ret < 0)
+			return ret;
 
 		leaf = path->nodes[0];
 		if (path->slots[0] >= btrfs_header_nritems(leaf)) {
 			ret = btrfs_next_leaf(tree_root, path);
 			if (ret < 0)
-				err = ret;
-			if (ret != 0)
-				break;
+				return ret;
+			else if (ret > 0)
+				return 0;
 			leaf = path->nodes[0];
 		}
 
@@ -252,34 +249,33 @@ int btrfs_find_orphan_roots(struct btrfs_fs_info *fs_info)
 
 		if (key.objectid != BTRFS_ORPHAN_OBJECTID ||
 		    key.type != BTRFS_ORPHAN_ITEM_KEY)
-			break;
+			return 0;
 
 		root_objectid = key.offset;
 		key.offset++;
 
 		root = btrfs_get_fs_root(fs_info, root_objectid, false);
-		err = PTR_ERR_OR_ZERO(root);
-		if (err && err != -ENOENT) {
+		ret = PTR_ERR_OR_ZERO(root);
+		if (ret && ret != -ENOENT) {
 			break;
-		} else if (err == -ENOENT) {
+		} else if (ret == -ENOENT) {
 			struct btrfs_trans_handle *trans;
 
 			btrfs_release_path(path);
 
 			trans = btrfs_join_transaction(tree_root);
 			if (IS_ERR(trans)) {
-				err = PTR_ERR(trans);
-				btrfs_handle_fs_error(fs_info, err,
+				ret = PTR_ERR(trans);
+				btrfs_handle_fs_error(fs_info, ret,
 					    "Failed to start trans to delete orphan item");
-				break;
+				return ret;
 			}
-			err = btrfs_del_orphan_item(trans, tree_root,
-						    root_objectid);
+			ret = btrfs_del_orphan_item(trans, tree_root, root_objectid);
 			btrfs_end_transaction(trans);
-			if (err) {
-				btrfs_handle_fs_error(fs_info, err,
+			if (ret) {
+				btrfs_handle_fs_error(fs_info, ret,
 					    "Failed to delete root orphan item");
-				break;
+				return ret;
 			}
 			continue;
 		}
@@ -307,7 +303,7 @@ int btrfs_find_orphan_roots(struct btrfs_fs_info *fs_info)
 		btrfs_put_root(root);
 	}
 
-	return err;
+	return 0;
 }
 
 /* drop the root item for 'key' from the tree root */
-- 
2.47.2


