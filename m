Return-Path: <linux-btrfs+bounces-16655-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1061BB45D95
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Sep 2025 18:12:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9FF4F16630D
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Sep 2025 16:11:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9CE730B507;
	Fri,  5 Sep 2025 16:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IFoRhHUS"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF03A302145
	for <linux-btrfs@vger.kernel.org>; Fri,  5 Sep 2025 16:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757088648; cv=none; b=sQ63IF8dqwpDkNda9qmY0oUvq1oLkK8vgo7sRGxjo/afrLQxjhtW9xn7M2qXSjvAf85w+0IEXZLzefx4e/9mTyUEWY1ZXvzkRDvousAL5hsUlPcfWL5WpbiEO6qmD8IEj2JJJUH7PgxaCf97yZdnaEtl/eBhnu7LYhUZTgqr3O0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757088648; c=relaxed/simple;
	bh=tgCFvxOs5sIyKlTzcgGElZUS2Aw7xRhSgRBvFabc47c=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u1Rn6myoCAgok/XNJxK6AHMT1c1QUT22Vzcwjnjo2XFAYdPLMqd91Jx2elUI61SZVl+2vk3BedQsH9NNL07nJCDt4mN+QfV0sq9AODRzoWz119VX9NyImHRLGCc6Yl+iiqlCiIPD3PqmVSMCSQjt26stWBxXelIubTw1i9VMRUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IFoRhHUS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFCD7C4CEF4
	for <linux-btrfs@vger.kernel.org>; Fri,  5 Sep 2025 16:10:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757088647;
	bh=tgCFvxOs5sIyKlTzcgGElZUS2Aw7xRhSgRBvFabc47c=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=IFoRhHUS3zVtPkTYgVlT0GQxgqimnf4MAcWwJcV0GP3t80ztx5GuGUFLYQycmEmUf
	 ubZ7DXi04zeI5jub/EICrTrFC3lSSSMbgOPz064Q4BblIzfzQ85tbbeG2dDZX/YbfI
	 ffhG+SgnADnEJwaNi3K1qaMXvoppzN9gl8S/topJFTvuPt0oQ2kMj/keysE3BR/C2z
	 PvSqlVnUqevTb4kXu9S6do7HfRrIgOHcM/o7BvrfSOGwoXTf4Y1Y44A8RbdascEEL1
	 7GEk2BOGrihv/Om6azdXTa4Pf2MGWWNlSfpakeXSbs1B4GqnH/6m2vvsG+8b09Ei79
	 8LeqlF+Wi7I1g==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 11/33] btrfs: move up the definition of struct walk_control
Date: Fri,  5 Sep 2025 17:09:59 +0100
Message-ID: <75dec121d5822b09463959682142b4f720416b6b.1757075118.git.fdmanana@suse.com>
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


