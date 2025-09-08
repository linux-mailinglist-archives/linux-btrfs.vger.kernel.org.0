Return-Path: <linux-btrfs+bounces-16702-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A99F8B4891A
	for <lists+linux-btrfs@lfdr.de>; Mon,  8 Sep 2025 11:54:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AAF7118995A6
	for <lists+linux-btrfs@lfdr.de>; Mon,  8 Sep 2025 09:54:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F2B62F616E;
	Mon,  8 Sep 2025 09:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hrtQddcw"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75E602F657F
	for <linux-btrfs@vger.kernel.org>; Mon,  8 Sep 2025 09:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757325217; cv=none; b=UX4c0RJEIn/SPcFSU19EmI0iGdAt2z7LcHuTKVbcyOYw/U7z8YaIYy7yjreDwq78+UF9MyHSycQfy1uelT1/FtfPm400kT/FX6ysLq+RJJJjv+1LYMRNcQ27T3Xl7Kz6jtZCiYv9uDmzmGrCHipYlHZd9TM6YPJlRjXIQcAWmW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757325217; c=relaxed/simple;
	bh=5bxVN0cnWOxPi7GRWY1yD4mxatEY5yqSD7hCIEYzpRM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YEVGQJU6aNoVuLR3QL7TV37BH7D8gWcvhT2efmJlSxI/o+d2uqHn1i/yihdGyc3pHDoUchY6s8t0pDz1kz/RKJFwGirhzFfaa/Ea9RdqdVLwtzBsHLisOSwPqtDKnHcMLnkouHBPwTUtGg/nhGIvbZNY3U0UlPFEMmwhZifPAvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hrtQddcw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1F0AC4CEF1
	for <linux-btrfs@vger.kernel.org>; Mon,  8 Sep 2025 09:53:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757325217;
	bh=5bxVN0cnWOxPi7GRWY1yD4mxatEY5yqSD7hCIEYzpRM=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=hrtQddcwLPw++4n14/2LBSLwIaUjKa7fNsAah0p3l9WyxI0I0YNUZi1Y0MwwBgEJF
	 +D+9IsCQlCU/wQltPALes/GD/K5C+nmHBxH7s1FyolGGsJfolb/o2rh2h2jhcNkPKT
	 XD16rDMoSrawaRbxLGcCIdUA+K+LJfhmydqzKfX+0DDEG7o0wmUjiM/FxnqciV1xI0
	 zbd6wb50X9GIfNlv/8Tmk23PNXUOQPb4D1JE1NHg0NnnkbDExdtaI9aSByr4StxywR
	 CGTgm1SqAGDDU0I//U4wLLQEd6kFZ8Ni6m8Qst3Hby+IyJSh8n/kXO8A0h28XlAPJ3
	 YBIRM76Os7flg==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2 07/33] btrfs: stop passing transaction parameter to log tree walk functions
Date: Mon,  8 Sep 2025 10:53:01 +0100
Message-ID: <f7bfdbfa816c3e35181596a4b23259f4b5ffb94f.1757271913.git.fdmanana@suse.com>
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

It's unncessary to pass a transaction parameter since struct walk_control
already has a member that points to the transaction, so we can make the
functions access the structure.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/tree-log.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index f039f0613a38..dee306101d8e 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -2782,10 +2782,10 @@ static int clean_log_buffer(struct btrfs_trans_handle *trans,
 	return 0;
 }
 
-static noinline int walk_down_log_tree(struct btrfs_trans_handle *trans,
-				   struct btrfs_path *path, int *level,
-				   struct walk_control *wc)
+static noinline int walk_down_log_tree(struct btrfs_path *path, int *level,
+				       struct walk_control *wc)
 {
+	struct btrfs_trans_handle *trans = wc->trans;
 	struct btrfs_fs_info *fs_info = wc->log->fs_info;
 	u64 bytenr;
 	u64 ptr_gen;
@@ -2874,9 +2874,8 @@ static noinline int walk_down_log_tree(struct btrfs_trans_handle *trans,
 	return 0;
 }
 
-static noinline int walk_up_log_tree(struct btrfs_trans_handle *trans,
-				 struct btrfs_path *path, int *level,
-				 struct walk_control *wc)
+static noinline int walk_up_log_tree(struct btrfs_path *path, int *level,
+				     struct walk_control *wc)
 {
 	int i;
 	int slot;
@@ -2897,7 +2896,7 @@ static noinline int walk_up_log_tree(struct btrfs_trans_handle *trans,
 				return ret;
 
 			if (wc->free) {
-				ret = clean_log_buffer(trans, path->nodes[*level]);
+				ret = clean_log_buffer(wc->trans, path->nodes[*level]);
 				if (ret)
 					return ret;
 			}
@@ -2914,7 +2913,7 @@ static noinline int walk_up_log_tree(struct btrfs_trans_handle *trans,
  * the tree freeing any blocks that have a ref count of zero after being
  * decremented.
  */
-static int walk_log_tree(struct btrfs_trans_handle *trans, struct walk_control *wc)
+static int walk_log_tree(struct walk_control *wc)
 {
 	struct btrfs_root *log = wc->log;
 	int ret = 0;
@@ -2934,7 +2933,7 @@ static int walk_log_tree(struct btrfs_trans_handle *trans, struct walk_control *
 	path->slots[level] = 0;
 
 	while (1) {
-		wret = walk_down_log_tree(trans, path, &level, wc);
+		wret = walk_down_log_tree(path, &level, wc);
 		if (wret > 0)
 			break;
 		if (wret < 0) {
@@ -2942,7 +2941,7 @@ static int walk_log_tree(struct btrfs_trans_handle *trans, struct walk_control *
 			goto out;
 		}
 
-		wret = walk_up_log_tree(trans, path, &level, wc);
+		wret = walk_up_log_tree(path, &level, wc);
 		if (wret > 0)
 			break;
 		if (wret < 0) {
@@ -2959,7 +2958,7 @@ static int walk_log_tree(struct btrfs_trans_handle *trans, struct walk_control *
 		if (ret)
 			goto out;
 		if (wc->free)
-			ret = clean_log_buffer(trans, path->nodes[orig_level]);
+			ret = clean_log_buffer(wc->trans, path->nodes[orig_level]);
 	}
 
 out:
@@ -3427,10 +3426,11 @@ static void free_log_tree(struct btrfs_trans_handle *trans,
 		.free = true,
 		.process_func = process_one_buffer,
 		.log = log,
+		.trans = trans,
 	};
 
 	if (log->node) {
-		ret = walk_log_tree(trans, &wc);
+		ret = walk_log_tree(&wc);
 		if (ret) {
 			/*
 			 * We weren't able to traverse the entire log tree, the
@@ -7446,7 +7446,7 @@ int btrfs_recover_log_trees(struct btrfs_root *log_root_tree)
 	wc.pin = true;
 	wc.log = log_root_tree;
 
-	ret = walk_log_tree(trans, &wc);
+	ret = walk_log_tree(&wc);
 	wc.log = NULL;
 	if (ret) {
 		btrfs_abort_transaction(trans, ret);
@@ -7521,7 +7521,7 @@ int btrfs_recover_log_trees(struct btrfs_root *log_root_tree)
 			goto next;
 		}
 
-		ret = walk_log_tree(trans, &wc);
+		ret = walk_log_tree(&wc);
 		if (ret) {
 			btrfs_abort_transaction(trans, ret);
 			goto next;
-- 
2.47.2


