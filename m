Return-Path: <linux-btrfs+bounces-16700-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AEABFB48919
	for <lists+linux-btrfs@lfdr.de>; Mon,  8 Sep 2025 11:54:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 898BA1899210
	for <lists+linux-btrfs@lfdr.de>; Mon,  8 Sep 2025 09:54:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F0AD2F616C;
	Mon,  8 Sep 2025 09:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XbQBSQ/o"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2FD52F60AD
	for <linux-btrfs@vger.kernel.org>; Mon,  8 Sep 2025 09:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757325216; cv=none; b=Jv6yu6pj80n7U6FNO8MSt4yLkTVM++7IyCHvdG9tsS1QRZr/fqEJGuM8nnLFtsOFOpg9ncqhUc07lUfYqD50i4ramdKZRNHh3F3DlfGykgdJx6nynPRgGqPFjQHzgPMZ7iCN76uE/L7+Lm7uVjlFlH9qoZm8q3wBAYMzbNH62Us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757325216; c=relaxed/simple;
	bh=f2FxpfzQ/177eyn5nuWb0mlW3/8D2m5zeociH4OgnCU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MPYYu4RdYSHLsL/Azbt+CIOnNatIbDGOMlDae5Lecyqouv0l2A1UO9Evf2i8beXpEflUQ9wQ9btBEU9yTVaFTndDx7aNaK/9P74qv4W9jOYViEtw9o4kNcVzktsFb7Ss6W6bd4lPx4vXTVaCKoXvyDjukASq8SEUuY5JFtYORCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XbQBSQ/o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0670FC4CEF8
	for <linux-btrfs@vger.kernel.org>; Mon,  8 Sep 2025 09:53:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757325215;
	bh=f2FxpfzQ/177eyn5nuWb0mlW3/8D2m5zeociH4OgnCU=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=XbQBSQ/ovEzB5cuzTHIa8SAgxC6XBPoK/DJJvFcfJL0KKTbjxKJGRrA6WB/Zz0y02
	 fen6UIUnK2OzGFF1bhzLdgZsfXnPA6L3K0MAFgK+j5BzFqQVBc2/dfWGztcTDJoqpg
	 tR40ECVwZPfUC58GDRh3T4UNqrGsFNyNIgoEWH9qlUQs36WwWNp5huBa+kVaBLkwcR
	 Jx9MvhvI2Bvp7x6OAyVqy0U0Rs5ZO4MefuinHM+BKc1571cfPembkFYHE9KJaOUms6
	 4C2BAOuNqTT40GGWDKcm+9h2+PNLugs+I1VGQG7xfpib/1PQMkKjXItiSKRyrakpF6
	 Ah2VpgBzOgdqg==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2 05/33] btrfs: add and use a log root field to struct walk_control
Date: Mon,  8 Sep 2025 10:52:59 +0100
Message-ID: <cc75f92c3b57df75853cb5915b677b442b207064.1757271913.git.fdmanana@suse.com>
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

Instead of passing an extra log root parameter for the log tree walk
functions and callbacks, add the log tree to struct walk_control and
make those functions and callbacks extract the log root from that
structure, reducing the number of parameters. This also simplifies
further upcoming changes to report log tree replay failures.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/tree-log.c | 62 +++++++++++++++++++++++++--------------------
 1 file changed, 35 insertions(+), 27 deletions(-)

diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 321ec0de0733..7d1b21df698d 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -336,6 +336,9 @@ struct walk_control {
 	 */
 	struct btrfs_root *root;
 
+	/* The log tree we are currently processing (not NULL for any stage). */
+	struct btrfs_root *log;
+
 	/* the trans handle for the current replay */
 	struct btrfs_trans_handle *trans;
 
@@ -344,17 +347,17 @@ struct walk_control {
 	 * passed in, and it must be checked or read if you need the data
 	 * inside it
 	 */
-	int (*process_func)(struct btrfs_root *log, struct extent_buffer *eb,
+	int (*process_func)(struct extent_buffer *eb,
 			    struct walk_control *wc, u64 gen, int level);
 };
 
 /*
  * process_func used to pin down extents, write them or wait on them
  */
-static int process_one_buffer(struct btrfs_root *log,
-			      struct extent_buffer *eb,
+static int process_one_buffer(struct extent_buffer *eb,
 			      struct walk_control *wc, u64 gen, int level)
 {
+	struct btrfs_root *log = wc->log;
 	struct btrfs_trans_handle *trans = wc->trans;
 	struct btrfs_fs_info *fs_info = log->fs_info;
 	int ret = 0;
@@ -2569,7 +2572,7 @@ static noinline int replay_dir_deletes(struct btrfs_trans_handle *trans,
  * only in the log (references come from either directory items or inode
  * back refs).
  */
-static int replay_one_buffer(struct btrfs_root *log, struct extent_buffer *eb,
+static int replay_one_buffer(struct extent_buffer *eb,
 			     struct walk_control *wc, u64 gen, int level)
 {
 	int nritems;
@@ -2579,6 +2582,7 @@ static int replay_one_buffer(struct btrfs_root *log, struct extent_buffer *eb,
 	};
 	struct btrfs_path *path;
 	struct btrfs_root *root = wc->root;
+	struct btrfs_root *log = wc->log;
 	struct btrfs_trans_handle *trans = wc->trans;
 	struct btrfs_key key;
 	int i;
@@ -2779,11 +2783,10 @@ static int clean_log_buffer(struct btrfs_trans_handle *trans,
 }
 
 static noinline int walk_down_log_tree(struct btrfs_trans_handle *trans,
-				   struct btrfs_root *log,
 				   struct btrfs_path *path, int *level,
 				   struct walk_control *wc)
 {
-	struct btrfs_fs_info *fs_info = log->fs_info;
+	struct btrfs_fs_info *fs_info = wc->log->fs_info;
 	u64 bytenr;
 	u64 ptr_gen;
 	struct extent_buffer *next;
@@ -2821,7 +2824,7 @@ static noinline int walk_down_log_tree(struct btrfs_trans_handle *trans,
 		}
 
 		if (*level == 1) {
-			ret = wc->process_func(log, next, wc, ptr_gen, *level - 1);
+			ret = wc->process_func(next, wc, ptr_gen, *level - 1);
 			if (ret) {
 				free_extent_buffer(next);
 				return ret;
@@ -2872,7 +2875,6 @@ static noinline int walk_down_log_tree(struct btrfs_trans_handle *trans,
 }
 
 static noinline int walk_up_log_tree(struct btrfs_trans_handle *trans,
-				 struct btrfs_root *log,
 				 struct btrfs_path *path, int *level,
 				 struct walk_control *wc)
 {
@@ -2888,7 +2890,7 @@ static noinline int walk_up_log_tree(struct btrfs_trans_handle *trans,
 			WARN_ON(*level == 0);
 			return 0;
 		} else {
-			ret = wc->process_func(log, path->nodes[*level], wc,
+			ret = wc->process_func(path->nodes[*level], wc,
 				 btrfs_header_generation(path->nodes[*level]),
 				 *level);
 			if (ret)
@@ -2912,9 +2914,9 @@ static noinline int walk_up_log_tree(struct btrfs_trans_handle *trans,
  * the tree freeing any blocks that have a ref count of zero after being
  * decremented.
  */
-static int walk_log_tree(struct btrfs_trans_handle *trans,
-			 struct btrfs_root *log, struct walk_control *wc)
+static int walk_log_tree(struct btrfs_trans_handle *trans, struct walk_control *wc)
 {
+	struct btrfs_root *log = wc->log;
 	int ret = 0;
 	int wret;
 	int level;
@@ -2932,7 +2934,7 @@ static int walk_log_tree(struct btrfs_trans_handle *trans,
 	path->slots[level] = 0;
 
 	while (1) {
-		wret = walk_down_log_tree(trans, log, path, &level, wc);
+		wret = walk_down_log_tree(trans, path, &level, wc);
 		if (wret > 0)
 			break;
 		if (wret < 0) {
@@ -2940,7 +2942,7 @@ static int walk_log_tree(struct btrfs_trans_handle *trans,
 			goto out;
 		}
 
-		wret = walk_up_log_tree(trans, log, path, &level, wc);
+		wret = walk_up_log_tree(trans, path, &level, wc);
 		if (wret > 0)
 			break;
 		if (wret < 0) {
@@ -2951,7 +2953,7 @@ static int walk_log_tree(struct btrfs_trans_handle *trans,
 
 	/* was the root node processed? if not, catch it here */
 	if (path->nodes[orig_level]) {
-		ret = wc->process_func(log, path->nodes[orig_level], wc,
+		ret = wc->process_func(path->nodes[orig_level], wc,
 			 btrfs_header_generation(path->nodes[orig_level]),
 			 orig_level);
 		if (ret)
@@ -3423,11 +3425,12 @@ static void free_log_tree(struct btrfs_trans_handle *trans,
 	int ret;
 	struct walk_control wc = {
 		.free = true,
-		.process_func = process_one_buffer
+		.process_func = process_one_buffer,
+		.log = log,
 	};
 
 	if (log->node) {
-		ret = walk_log_tree(trans, log, &wc);
+		ret = walk_log_tree(trans, &wc);
 		if (ret) {
 			/*
 			 * We weren't able to traverse the entire log tree, the
@@ -7441,8 +7444,10 @@ int btrfs_recover_log_trees(struct btrfs_root *log_root_tree)
 
 	wc.trans = trans;
 	wc.pin = true;
+	wc.log = log_root_tree;
 
-	ret = walk_log_tree(trans, log_root_tree, &wc);
+	ret = walk_log_tree(trans, &wc);
+	wc.log = NULL;
 	if (ret) {
 		btrfs_abort_transaction(trans, ret);
 		goto error;
@@ -7454,7 +7459,6 @@ int btrfs_recover_log_trees(struct btrfs_root *log_root_tree)
 	key.offset = (u64)-1;
 
 	while (1) {
-		struct btrfs_root *log;
 		struct btrfs_key found_key;
 
 		ret = btrfs_search_slot(NULL, log_root_tree, &key, path, 0, 0);
@@ -7474,9 +7478,10 @@ int btrfs_recover_log_trees(struct btrfs_root *log_root_tree)
 		if (found_key.objectid != BTRFS_TREE_LOG_OBJECTID)
 			break;
 
-		log = btrfs_read_tree_root(log_root_tree, &found_key);
-		if (IS_ERR(log)) {
-			ret = PTR_ERR(log);
+		wc.log = btrfs_read_tree_root(log_root_tree, &found_key);
+		if (IS_ERR(wc.log)) {
+			ret = PTR_ERR(wc.log);
+			wc.log = NULL;
 			btrfs_abort_transaction(trans, ret);
 			goto error;
 		}
@@ -7486,7 +7491,8 @@ int btrfs_recover_log_trees(struct btrfs_root *log_root_tree)
 			ret = PTR_ERR(wc.root);
 			wc.root = NULL;
 			if (ret != -ENOENT) {
-				btrfs_put_root(log);
+				btrfs_put_root(wc.log);
+				wc.log = NULL;
 				btrfs_abort_transaction(trans, ret);
 				goto error;
 			}
@@ -7502,23 +7508,24 @@ int btrfs_recover_log_trees(struct btrfs_root *log_root_tree)
 			 * block from being modified, and we'll just bail for
 			 * each subsequent pass.
 			 */
-			ret = btrfs_pin_extent_for_log_replay(trans, log->node);
+			ret = btrfs_pin_extent_for_log_replay(trans, wc.log->node);
 			if (ret) {
-				btrfs_put_root(log);
+				btrfs_put_root(wc.log);
+				wc.log = NULL;
 				btrfs_abort_transaction(trans, ret);
 				goto error;
 			}
 			goto next;
 		}
 
-		wc.root->log_root = log;
+		wc.root->log_root = wc.log;
 		ret = btrfs_record_root_in_trans(trans, wc.root);
 		if (ret) {
 			btrfs_abort_transaction(trans, ret);
 			goto next;
 		}
 
-		ret = walk_log_tree(trans, log, &wc);
+		ret = walk_log_tree(trans, &wc);
 		if (ret) {
 			btrfs_abort_transaction(trans, ret);
 			goto next;
@@ -7551,7 +7558,8 @@ int btrfs_recover_log_trees(struct btrfs_root *log_root_tree)
 			wc.root->log_root = NULL;
 			btrfs_put_root(wc.root);
 		}
-		btrfs_put_root(log);
+		btrfs_put_root(wc.log);
+		wc.log = NULL;
 
 		if (ret)
 			goto error;
-- 
2.47.2


