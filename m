Return-Path: <linux-btrfs+bounces-16706-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 32936B48920
	for <lists+linux-btrfs@lfdr.de>; Mon,  8 Sep 2025 11:54:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3AC031898A45
	for <lists+linux-btrfs@lfdr.de>; Mon,  8 Sep 2025 09:54:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E727C2F83AF;
	Mon,  8 Sep 2025 09:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JxentyJA"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 387822F7ADF
	for <linux-btrfs@vger.kernel.org>; Mon,  8 Sep 2025 09:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757325221; cv=none; b=VsWs71bfh/zLZXheezq9Fz1iVTZEm46Cz/s/asWxhSTo8vb5IQwoki1tcS/Tugsv5r0OkoLwMirjJrqWatRhtkBUmz1swQgQQiPqxPk2Yxs8wy840JgtIEczCWiCqDdrsIYx+WDhWbQiZ1GL7Rknzs8faMQWdYpuNVC09d0ga7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757325221; c=relaxed/simple;
	bh=tgCFvxOs5sIyKlTzcgGElZUS2Aw7xRhSgRBvFabc47c=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Cq2Ldn7v6yjH34DpH0eDbUvzKa5cFOvSZK9Im5n5o6iZ8BS26kkajapEEBbE2YOgyUWf3pMD+frr5WzNIP2bNwdHo5YylALUUopdWCyBr4rMsrh345CZTA4q/8WZgiOhapYTqekt7OYgjEdixB7m/fXiYxKEO2fmwRzzo8PKykg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JxentyJA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90B69C4CEF1
	for <linux-btrfs@vger.kernel.org>; Mon,  8 Sep 2025 09:53:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757325221;
	bh=tgCFvxOs5sIyKlTzcgGElZUS2Aw7xRhSgRBvFabc47c=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=JxentyJAHspOA+EdAhqO9MK06Bc5hY2CWk9ZDI9Yjy3lavkt1AcGB3ihSesabWrCk
	 4YwCvz6lQdyi4Yr2pMQxvrgGlOJIeFonKV/nlA019/GbQae2GEPq5r03Gl3zDtsI5s
	 z9qqhakwuJk84OR90TV9JixU5KFvdWgL4XA77VrOsRpNVFP1nYRxSLIMjtezWOCXL2
	 otrWFySDEi6gbrznFA7sjlV00dZfkwMVxpLdL3vajohiN4ve3OW7yiXpby4GAw55lQ
	 mX79qgssjZSzJk1vCtFlUqmH3FeJJi6pBu+/gpnZF+UxIs9WickcP8A8GCIoDFVrWf
	 1+vZneHk4yJ5w==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2 11/33] btrfs: move up the definition of struct walk_control
Date: Mon,  8 Sep 2025 10:53:05 +0100
Message-ID: <75dec121d5822b09463959682142b4f720416b6b.1757271913.git.fdmanana@suse.com>
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

In upcoming changes we need to pass struct walk_control as an argument to
replay_dir_deletes() and link_to_fixup_dir() so we need to move its
definition above the prototypes of those functions. So move it up right
below the enum that defines log replay stages and before any functions and
function prototypes are declared. Also fixup the comments while moving it
so that they comply with the preferred code style (capitalize the first
word in a sentence, end sentences with punctuation, makes lines wider and
closer to the 80 characters limit).

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/tree-log.c | 103 ++++++++++++++++++++++----------------------
 1 file changed, 51 insertions(+), 52 deletions(-)

diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index cd4c5ae3e0a3..2780f0e1db01 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -101,6 +101,57 @@ enum {
 	LOG_WALK_REPLAY_ALL,
 };
 
+/*
+ * The walk control struct is used to pass state down the chain when processing
+ * the log tree. The stage field tells us which part of the log tree processing
+ * we are currently doing.
+ */
+struct walk_control {
+	/*
+	 * Signal that we are freeing the metadata extents of a log tree.
+	 * This is used at transaction commit time while freeing a log tree.
+	 */
+	bool free;
+
+	/*
+	 * Signal that we are pinning the metadata extents of a log tree and the
+	 * data extents its leaves point to (if using mixed block groups).
+	 * This happens in the first stage of log replay to ensure that during
+	 * replay, while we are modifying subvolume trees, we don't overwrite
+	 * the metadata extents of log trees.
+	 */
+	bool pin;
+
+	/* What stage of the replay code we're currently in. */
+	int stage;
+
+	/*
+	 * Ignore any items from the inode currently being processed. Needs
+	 * to be set every time we find a BTRFS_INODE_ITEM_KEY.
+	 */
+	bool ignore_cur_inode;
+
+	/*
+	 * The root we are currently replaying to. This is NULL for the replay
+	 * stage LOG_WALK_PIN_ONLY.
+	 */
+	struct btrfs_root *root;
+
+	/* The log tree we are currently processing (not NULL for any stage). */
+	struct btrfs_root *log;
+
+	/* The transaction handle used for replaying all log trees. */
+	struct btrfs_trans_handle *trans;
+
+	/*
+	 * The function that gets used to process blocks we find in the tree.
+	 * Note the extent_buffer might not be up to date when it is passed in,
+	 * and it must be checked or read if you need the data inside it.
+	 */
+	int (*process_func)(struct extent_buffer *eb,
+			    struct walk_control *wc, u64 gen, int level);
+};
+
 static int btrfs_log_inode(struct btrfs_trans_handle *trans,
 			   struct btrfs_inode *inode,
 			   int inode_only,
@@ -299,58 +350,6 @@ void btrfs_end_log_trans(struct btrfs_root *root)
 	}
 }
 
-/*
- * the walk control struct is used to pass state down the chain when
- * processing the log tree.  The stage field tells us which part
- * of the log tree processing we are currently doing.  The others
- * are state fields used for that specific part
- */
-struct walk_control {
-	/*
-	 * Signal that we are freeing the metadata extents of a log tree.
-	 * This is used at transaction commit time while freeing a log tree.
-	 */
-	bool free;
-
-	/*
-	 * Signal that we are pinning the metadata extents of a log tree and the
-	 * data extents its leaves point to (if using mixed block groups).
-	 * This happens in the first stage of log replay to ensure that during
-	 * replay, while we are modifying subvolume trees, we don't overwrite
-	 * the metadata extents of log trees.
-	 */
-	bool pin;
-
-	/* what stage of the replay code we're currently in */
-	int stage;
-
-	/*
-	 * Ignore any items from the inode currently being processed. Needs
-	 * to be set every time we find a BTRFS_INODE_ITEM_KEY.
-	 */
-	bool ignore_cur_inode;
-
-	/*
-	 * The root we are currently replaying to. This is NULL for the replay
-	 * stage LOG_WALK_PIN_ONLY.
-	 */
-	struct btrfs_root *root;
-
-	/* The log tree we are currently processing (not NULL for any stage). */
-	struct btrfs_root *log;
-
-	/* the trans handle for the current replay */
-	struct btrfs_trans_handle *trans;
-
-	/* the function that gets used to process blocks we find in the
-	 * tree.  Note the extent_buffer might not be up to date when it is
-	 * passed in, and it must be checked or read if you need the data
-	 * inside it
-	 */
-	int (*process_func)(struct extent_buffer *eb,
-			    struct walk_control *wc, u64 gen, int level);
-};
-
 /*
  * process_func used to pin down extents, write them or wait on them
  */
-- 
2.47.2


