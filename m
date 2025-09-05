Return-Path: <linux-btrfs+bounces-16646-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DEB2EB45D84
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Sep 2025 18:11:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E773FA463B2
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Sep 2025 16:10:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8D9D302170;
	Fri,  5 Sep 2025 16:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BjfOq63+"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3E5F30214B
	for <linux-btrfs@vger.kernel.org>; Fri,  5 Sep 2025 16:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757088638; cv=none; b=o7T2i909wAeUQUYVEn6PgoN4ZsbQLLpBSmWpASN6G+6yXPGQN7JDCCVU8+BjKcqt9pqd4JtsKdw8JqD6n4TWglxode3XHFoxGwAwQGq9sIQM26t+FJ9cEWOE2MvH9aD8GTrCJaZc2ZnlHT4sdqMd9DKNLRcdPpbEh9RDHVPZj9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757088638; c=relaxed/simple;
	bh=fQ17IIOqfSCiBsodRHrAiDRFBrXvsjMfQXupfSM0mW4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y0fmZeta5sn8826meBQuXzV0amJoFtGSRoGzr/zodxCt1PTI1VFIFf8xfLb4YkWn7thYARWmp8BCl74bz8NV9w3RPT4b6/0oi+BR94+tpyDHP+zbC6rv2Ot/v1hVeVCmmGRuJXuBkkaZDeCpRWttftWdXqiGBe/FGqj/arLzjLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BjfOq63+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38AF5C4CEF9
	for <linux-btrfs@vger.kernel.org>; Fri,  5 Sep 2025 16:10:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757088637;
	bh=fQ17IIOqfSCiBsodRHrAiDRFBrXvsjMfQXupfSM0mW4=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=BjfOq63+Xgq8dTRW+mhsKwSzxK2HGvsD9TXCbSJFJ0nF+B1ytmck5O+n39yqZKqdZ
	 cVmmm0h1m1LGs+rXFCc+1dbvJj0cCslauwF4hn1bDxrPqy8kCMO9YVgWHJ0kamGaha
	 gQg8FrF0vdKGa0Y0ISHtLCD9n30CtLszmTlE/pxlzVsWn5kta0MMzkgSN7IAmqM5LH
	 YqBU/iLclggWI6flNaYiR6d9mn6WtsqMeJoNzXXrGOLy1YZnbq0HRGqooJSE++IveJ
	 nneiXLZ2KY3u5YHIEZeqhab868p51GAp7J0SC7EcHUCni6RGL4Z9+6AoiUYFX0sZ2I
	 ab5/KRB0Z12Gw==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 02/33] btrfs: use booleans in walk control structure for log replay
Date: Fri,  5 Sep 2025 17:09:50 +0100
Message-ID: <aa926d007ef4d2b46609948ad24ce7bcaa1d16c1.1757075118.git.fdmanana@suse.com>
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

The 'free' and 'pin' member of struct walk_control, used during log replay
and when freeing a log tree, are defined as integers but in practice are
used as booleans. Change their type to bool and while at it update their
comments to be more detailed and comply with the preferred comment style
(first word in a sentence is capitalized, sentences end with punctuation
and the comment opening (/*) is on a line of its own).

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/tree-log.c | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 861f96ef28cf..c5c5fc05eabb 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -306,15 +306,20 @@ void btrfs_end_log_trans(struct btrfs_root *root)
  * are state fields used for that specific part
  */
 struct walk_control {
-	/* should we free the extent on disk when done?  This is used
-	 * at transaction commit time while freeing a log tree
+	/*
+	 * Signal that we are freeing the metadata extents of a log tree.
+	 * This is used at transaction commit time while freeing a log tree.
 	 */
-	int free;
+	bool free;
 
-	/* pin only walk, we record which extents on disk belong to the
-	 * log trees
+	/*
+	 * Signal that we are pinning the metadata extents of a log tree and the
+	 * data extents its leaves point to (if using mixed block groups).
+	 * This happens in the first stage of log replay to ensure that during
+	 * replay, while we are modifying subvolume trees, we don't overwrite
+	 * the metadata extents of log trees.
 	 */
-	int pin;
+	bool pin;
 
 	/* what stage of the replay code we're currently in */
 	int stage;
@@ -3415,7 +3420,7 @@ static void free_log_tree(struct btrfs_trans_handle *trans,
 {
 	int ret;
 	struct walk_control wc = {
-		.free = 1,
+		.free = true,
 		.process_func = process_one_buffer
 	};
 
@@ -7433,7 +7438,7 @@ int btrfs_recover_log_trees(struct btrfs_root *log_root_tree)
 	}
 
 	wc.trans = trans;
-	wc.pin = 1;
+	wc.pin = true;
 
 	ret = walk_log_tree(trans, log_root_tree, &wc);
 	if (ret) {
@@ -7557,7 +7562,7 @@ int btrfs_recover_log_trees(struct btrfs_root *log_root_tree)
 
 	/* step one is to pin it all, step two is to replay just inodes */
 	if (wc.pin) {
-		wc.pin = 0;
+		wc.pin = false;
 		wc.process_func = replay_one_buffer;
 		wc.stage = LOG_WALK_REPLAY_INODES;
 		goto again;
-- 
2.47.2


