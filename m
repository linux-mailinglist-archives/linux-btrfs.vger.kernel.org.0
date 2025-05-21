Return-Path: <linux-btrfs+bounces-14178-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA549ABFC7C
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 May 2025 19:44:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 530A97AB095
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 May 2025 17:43:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D545D28ECCA;
	Wed, 21 May 2025 17:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ewowpMsv"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 263751E0E00
	for <linux-btrfs@vger.kernel.org>; Wed, 21 May 2025 17:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747849461; cv=none; b=C5JQEe9A1cD7+py1zyl85C/owddemy5YBWBHJ4lHj3Jp1c3+lBGnk+T2wLyLKhf1rOk0o97IHGihCBsJRVQqF35hK3+6teeF0aJD+EfLkU6Bx1P/PNnnEcPUpy5yhjdFEwDhU8qITRC9kz/+lQ2208kYwCi7T+xNuNHPmfdl124=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747849461; c=relaxed/simple;
	bh=+Xrku2H/1A2xesZFrf7Q+nsCauNGimaTzeXoCXiyouo=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WVnmCLsX84FPmP5GSNqIs9YikuxDl3RAMSX84tG2LYFoRnlqxf303dWTGuFMcjKgf378f6v9AWM9ZG0YBx5ZRr+b+Nq5BfqcvV4mOpll57ImkGPOVn5OTlsaszI7AbcMfLEoxD75WZ91hYA2YLZfyaDDdrFkB7/ymNLi9y2F4ZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ewowpMsv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 185E0C4CEE7
	for <linux-btrfs@vger.kernel.org>; Wed, 21 May 2025 17:44:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747849458;
	bh=+Xrku2H/1A2xesZFrf7Q+nsCauNGimaTzeXoCXiyouo=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=ewowpMsvN74+dg/UvRefUXve6qMcvjGwGkE25SYguZylHMDLjK8PD0f5maM2Ni2z2
	 yLTbkGZz2pQDb9DoMqvnzXt+MflvYQd/j/IBNEcj1gVM5dR25BtTCyBzFA139Vrmqa
	 MEagZVnBYgvo2GyF3nDuQxDkEKsL17lxLgYMQChIwpYdV98IUpZU7r7cUnEZn2tv3r
	 TOnedAoAqmomFoeuTMJ5Ukjw+awiTlBSxGg6d4wryPZmgfAX0W9FGPR+MBE1sLvCkR
	 zSq3MQHMWtjlb7K7ReS9stBTpj7lPzt8RbI5860LKtC3MLMav7hfintpRIrpwvbwqN
	 mPw20V3DIukxQ==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 4/4] btrfs: simplify error detection flow during log replay
Date: Wed, 21 May 2025 18:44:11 +0100
Message-Id: <38866d5521ba35134ea69b5b66e551e3f23a961b.1747848779.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1747848778.git.fdmanana@suse.com>
References: <cover.1747848778.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

We have this fuzzy logic at btrfs_recover_log_trees() where we don't
abort the transaction and exit immediately after each function call that
returned an error, and instead have if-then-else logic or check if the
previous function call returned success before calling the next function.

Make the flow more straighforward by immediately aborting the transaction
and exiting after each function call failure. This also allows to avoid
two consecutive if statements that test the same conditions:

   if (!ret && wc.stage == LOG_WALK_REPLAY_ALL) {
        (...)
   }

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/tree-log.c | 53 +++++++++++++++++++++++++--------------------
 1 file changed, 29 insertions(+), 24 deletions(-)

diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index ca2a2ee3c5f1..0d5b79402312 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -7192,8 +7192,6 @@ int btrfs_recover_log_trees(struct btrfs_root *log_root_tree)
 	struct btrfs_path *path;
 	struct btrfs_trans_handle *trans;
 	struct btrfs_key key;
-	struct btrfs_key found_key;
-	struct btrfs_root *log;
 	struct btrfs_fs_info *fs_info = log_root_tree->fs_info;
 	struct walk_control wc = {
 		.process_func = process_one_buffer,
@@ -7227,6 +7225,9 @@ int btrfs_recover_log_trees(struct btrfs_root *log_root_tree)
 	key.offset = (u64)-1;
 
 	while (1) {
+		struct btrfs_root *log;
+		struct btrfs_key found_key;
+
 		ret = btrfs_search_slot(NULL, log_root_tree, &key, path, 0, 0);
 
 		if (ret < 0) {
@@ -7255,6 +7256,7 @@ int btrfs_recover_log_trees(struct btrfs_root *log_root_tree)
 						   true);
 		if (IS_ERR(wc.replay_dest)) {
 			ret = PTR_ERR(wc.replay_dest);
+			wc.replay_dest = NULL;
 			if (ret != -ENOENT) {
 				btrfs_put_root(log);
 				btrfs_abort_transaction(trans, ret);
@@ -7273,35 +7275,35 @@ int btrfs_recover_log_trees(struct btrfs_root *log_root_tree)
 			 * each subsequent pass.
 			 */
 			ret = btrfs_pin_extent_for_log_replay(trans, log->node);
-			btrfs_put_root(log);
-
-			if (!ret)
-				goto next;
-			btrfs_abort_transaction(trans, ret);
-			goto error;
+			if (ret) {
+				btrfs_put_root(log);
+				btrfs_abort_transaction(trans, ret);
+				goto error;
+			}
+			goto next;
 		}
 
 		wc.replay_dest->log_root = log;
 		ret = btrfs_record_root_in_trans(trans, wc.replay_dest);
 		if (ret) {
-			/* The loop needs to continue due to the root refs */
 			btrfs_abort_transaction(trans, ret);
-		} else {
-			ret = walk_log_tree(trans, log, &wc);
-			if (ret)
-				btrfs_abort_transaction(trans, ret);
+			goto next;
 		}
 
-		if (!ret && wc.stage == LOG_WALK_REPLAY_ALL) {
-			ret = fixup_inode_link_counts(trans, wc.replay_dest,
-						      path);
-			if (ret)
-				btrfs_abort_transaction(trans, ret);
+		ret = walk_log_tree(trans, log, &wc);
+		if (ret) {
+			btrfs_abort_transaction(trans, ret);
+			goto next;
 		}
 
-		if (!ret && wc.stage == LOG_WALK_REPLAY_ALL) {
+		if (wc.stage == LOG_WALK_REPLAY_ALL) {
 			struct btrfs_root *root = wc.replay_dest;
 
+			ret = fixup_inode_link_counts(trans, wc.replay_dest, path);
+			if (ret) {
+				btrfs_abort_transaction(trans, ret);
+				goto next;
+			}
 			/*
 			 * We have just replayed everything, and the highest
 			 * objectid of fs roots probably has changed in case
@@ -7311,17 +7313,20 @@ int btrfs_recover_log_trees(struct btrfs_root *log_root_tree)
 			 * could only happen during mount.
 			 */
 			ret = btrfs_init_root_free_objectid(root);
-			if (ret)
+			if (ret) {
 				btrfs_abort_transaction(trans, ret);
+				goto next;
+			}
+		}
+next:
+		if (wc.replay_dest) {
+			wc.replay_dest->log_root = NULL;
+			btrfs_put_root(wc.replay_dest);
 		}
-
-		wc.replay_dest->log_root = NULL;
-		btrfs_put_root(wc.replay_dest);
 		btrfs_put_root(log);
 
 		if (ret)
 			goto error;
-next:
 		if (found_key.offset == 0)
 			break;
 		key.offset = found_key.offset - 1;
-- 
2.47.2


