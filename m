Return-Path: <linux-btrfs+bounces-16707-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DFBCB48921
	for <lists+linux-btrfs@lfdr.de>; Mon,  8 Sep 2025 11:54:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A56C1189BBA2
	for <lists+linux-btrfs@lfdr.de>; Mon,  8 Sep 2025 09:54:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5BDE2F83C3;
	Mon,  8 Sep 2025 09:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jC5VqTMB"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24B0D2F83B7
	for <linux-btrfs@vger.kernel.org>; Mon,  8 Sep 2025 09:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757325222; cv=none; b=Mh52Znn7+kGobm3qp8C3N5CsTTLG3JqmLCZ+kc/Ed2tkzhyql3JHBJCIXzpdb8MjQQ040NEF0RIoaFZ4cNfgC/vdLuCSb/0nARm+cZTBbzUA8eufvEOcP0Ykx9PFnuDoC5M7MaquwJm2GVLMo8UqWFFkRvatZYN3Eyd4EfxYz+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757325222; c=relaxed/simple;
	bh=4xxrQWf593XOTxYj3rfQlOtkZWgy9ifieezTBvowdWM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m+55b3wfzy7Vl5Cg4Rn1J3GtxdUczYwFi5Cvkz5lFC5CmuasheYDCXC3m4c6DGvUBU/+IwdHZTDxmdwOxfGwyY4S8Gq/P3q5mq3zcu32UKJ6PDlzD7oI9oQZE12OWeXb4xjecyslIOYzJD3EQDYE6DY6sUgOwgb1lsj2dWzl410=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jC5VqTMB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84AFEC4CEF8
	for <linux-btrfs@vger.kernel.org>; Mon,  8 Sep 2025 09:53:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757325222;
	bh=4xxrQWf593XOTxYj3rfQlOtkZWgy9ifieezTBvowdWM=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=jC5VqTMBiwvFprAC8Ao83MdsWc8WcJAh3OAtnJLHNlnyeIxmMZYK13QR2NjG6XCdJ
	 EUDG3LwBBozhamk7IYe6QfkdGAE4SoVByLeTJOsLfObNgLcuE2GeISKwW+Lkh+Jwsl
	 PtR9EQ5Hp/X4PXbWhs+PxRchQ4wnz1FyvcfJ955lKc6qsxM1fkSwaz0i3Y8C5bEJFz
	 kYcyCJvw9S1DOz6/JxoQg5tinmo98zHQD2pLcgg9hH1zHsO1uUxjyPqb4kcRv0dqCv
	 VUeGiM5FD7dkXEYmqTwuU0X59oaE2tGZdHBeLtqdTKxWAfXR2GfC/ECTQwWE4sYueS
	 NGWI7ly7H71tA==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2 12/33] btrfs: pass walk_control structure to replay_dir_deletes()
Date: Mon,  8 Sep 2025 10:53:06 +0100
Message-ID: <6c85664cf3460d9c56ea48d1debca9f09cf0e5e2.1757271913.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <cover.1757271913.git.fdmanana@suse.com>
References: <cover.1757271913.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

Instead of passing the transaction, subvolume root and log tree as
arguments to replay_dir_deletes(), pass the walk_control structure as
we can grab all of those from the structure. This reduces the number of
arguments passed and it's going to be needed by an incoming change that
improves error reporting for log replay. This also requires changing
fixup_inode_link_counts() and fixup_inode_link_count() to take that
structure as an argument since fixup_inode_link_count() makes a call
to replay_dir_deletes().

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/tree-log.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 2780f0e1db01..460dc51e8c82 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -159,9 +159,7 @@ static int btrfs_log_inode(struct btrfs_trans_handle *trans,
 static int link_to_fixup_dir(struct btrfs_trans_handle *trans,
 			     struct btrfs_root *root,
 			     struct btrfs_path *path, u64 objectid);
-static noinline int replay_dir_deletes(struct btrfs_trans_handle *trans,
-				       struct btrfs_root *root,
-				       struct btrfs_root *log,
+static noinline int replay_dir_deletes(struct walk_control *wc,
 				       struct btrfs_path *path,
 				       u64 dirid, bool del_all);
 static void wait_log_commit(struct btrfs_root *root, int transid);
@@ -1727,9 +1725,10 @@ static int count_inode_refs(struct btrfs_inode *inode, struct btrfs_path *path)
  * number of back refs found.  If it goes down to zero, the iput
  * will free the inode.
  */
-static noinline int fixup_inode_link_count(struct btrfs_trans_handle *trans,
+static noinline int fixup_inode_link_count(struct walk_control *wc,
 					   struct btrfs_inode *inode)
 {
+	struct btrfs_trans_handle *trans = wc->trans;
 	struct btrfs_root *root = inode->root;
 	struct btrfs_path *path;
 	int ret;
@@ -1765,7 +1764,7 @@ static noinline int fixup_inode_link_count(struct btrfs_trans_handle *trans,
 
 	if (inode->vfs_inode.i_nlink == 0) {
 		if (S_ISDIR(inode->vfs_inode.i_mode)) {
-			ret = replay_dir_deletes(trans, root, NULL, path, ino, true);
+			ret = replay_dir_deletes(wc, path, ino, true);
 			if (ret)
 				goto out;
 		}
@@ -1779,8 +1778,7 @@ static noinline int fixup_inode_link_count(struct btrfs_trans_handle *trans,
 	return ret;
 }
 
-static noinline int fixup_inode_link_counts(struct btrfs_trans_handle *trans,
-					    struct btrfs_root *root,
+static noinline int fixup_inode_link_counts(struct walk_control *wc,
 					    struct btrfs_path *path)
 {
 	int ret;
@@ -1790,6 +1788,8 @@ static noinline int fixup_inode_link_counts(struct btrfs_trans_handle *trans,
 	key.type = BTRFS_ORPHAN_ITEM_KEY;
 	key.offset = (u64)-1;
 	while (1) {
+		struct btrfs_trans_handle *trans = wc->trans;
+		struct btrfs_root *root = wc->root;
 		struct btrfs_inode *inode;
 
 		ret = btrfs_search_slot(trans, root, &key, path, -1, 1);
@@ -1819,7 +1819,7 @@ static noinline int fixup_inode_link_counts(struct btrfs_trans_handle *trans,
 			break;
 		}
 
-		ret = fixup_inode_link_count(trans, inode);
+		ret = fixup_inode_link_count(wc, inode);
 		iput(&inode->vfs_inode);
 		if (ret)
 			break;
@@ -2455,12 +2455,13 @@ static int replay_xattr_deletes(struct walk_control *wc,
  * Anything we don't find in the log is unlinked and removed from the
  * directory.
  */
-static noinline int replay_dir_deletes(struct btrfs_trans_handle *trans,
-				       struct btrfs_root *root,
-				       struct btrfs_root *log,
+static noinline int replay_dir_deletes(struct walk_control *wc,
 				       struct btrfs_path *path,
 				       u64 dirid, bool del_all)
 {
+	struct btrfs_trans_handle *trans = wc->trans;
+	struct btrfs_root *root = wc->root;
+	struct btrfs_root *log = (del_all ? NULL : wc->log);
 	u64 range_start;
 	u64 range_end;
 	int ret = 0;
@@ -2650,8 +2651,7 @@ static int replay_one_buffer(struct extent_buffer *eb,
 				break;
 			mode = btrfs_inode_mode(eb, inode_item);
 			if (S_ISDIR(mode)) {
-				ret = replay_dir_deletes(trans, root, log, path,
-							 key.objectid, false);
+				ret = replay_dir_deletes(wc, path, key.objectid, false);
 				if (ret)
 					break;
 			}
@@ -7530,7 +7530,7 @@ int btrfs_recover_log_trees(struct btrfs_root *log_root_tree)
 		if (wc.stage == LOG_WALK_REPLAY_ALL) {
 			struct btrfs_root *root = wc.root;
 
-			ret = fixup_inode_link_counts(trans, root, path);
+			ret = fixup_inode_link_counts(&wc, path);
 			if (ret) {
 				btrfs_abort_transaction(trans, ret);
 				goto next;
-- 
2.47.2


