Return-Path: <linux-btrfs+bounces-16651-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 636AFB45D8D
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Sep 2025 18:12:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BDAFC5C4C52
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Sep 2025 16:11:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23AAB2FB0B3;
	Fri,  5 Sep 2025 16:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kdlNpoY0"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 665482FB0AB
	for <linux-btrfs@vger.kernel.org>; Fri,  5 Sep 2025 16:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757088643; cv=none; b=ER0Bxm4ur2O0rLGAQI8Yt02m7+v40SlbA5kypKU8lDUbJ9Wr7M5bRgUK4MjvSpAb9UN3/apGLoIDEdoK+gVc+zrxBZc0cMdSJ/0+y93XtUAIplQVzRnNm7mWwHMxhjkTzyAocW4ug4Gjp7/tBPZpPkq0/v36J78M5ewgoBv3efU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757088643; c=relaxed/simple;
	bh=5bxVN0cnWOxPi7GRWY1yD4mxatEY5yqSD7hCIEYzpRM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XLcUbzH1Cyt8ONVULr8wXQz6/eGXiuys6JKHrta8v+wMQS9TKTN2ek+L1Gx5FSBH3oMdJXBYADLUTF5PeGam2FkEAl5MmG73oj2lnJAd8pMOSoAn37PhWvw2E9rXuUYK6CKw2PplTqQFgTvIVhiwAcVSQs5jLubcGp191ccgQo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kdlNpoY0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23EAEC4CEF1
	for <linux-btrfs@vger.kernel.org>; Fri,  5 Sep 2025 16:10:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757088643;
	bh=5bxVN0cnWOxPi7GRWY1yD4mxatEY5yqSD7hCIEYzpRM=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=kdlNpoY0kVEjFKFF4mBkMa7bDobTJ+DYLejN2EsYHU68hBe67/v8aYNQXn81w1G4V
	 GotZwuThUdX1WeqWSXx8F38rpujyE1LaOAccb/6d6S3vjuFXUV/vF40Tr458pRzy1h
	 qH8GLebjS5g58PQFVfCUAUfOWf+snb1CZQO6lkeEfA5eVDNIuWIvuFLELcJnJgIXmz
	 0F81gbPlwZiW6LahIKFu/bxp+SBqhe7CM/4HlbjiJuVz+oG213V6Jol/29mMEXAINu
	 WDZYR31Jlz8GjsxM7nMwW/4qJJJt8iBlOrBCQa8aRphDMsi87qIXVHlFWZkc9sMgfQ
	 2mYmRRWlPCkYA==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 07/33] btrfs: stop passing transaction parameter to log tree walk functions
Date: Fri,  5 Sep 2025 17:09:55 +0100
Message-ID: <f7bfdbfa816c3e35181596a4b23259f4b5ffb94f.1757075118.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <cover.1757075118.git.fdmanana@suse.com>
References: <cover.1757075118.git.fdmanana@suse.com>
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


