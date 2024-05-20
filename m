Return-Path: <linux-btrfs+bounces-5104-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B8D2A8C9AA8
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 May 2024 11:47:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5BA6F1F21FDE
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 May 2024 09:47:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DDD44D9EA;
	Mon, 20 May 2024 09:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h8gitZcU"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BB114CE04
	for <linux-btrfs@vger.kernel.org>; Mon, 20 May 2024 09:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716198418; cv=none; b=V4ansy0t7thaYsj8h/yuZ65Br/yllsNPGaXQnmplHsOezdWzw3uXR6pQWHPmOZnamfxsMbJKr1DTFPj+nZlGUAEYfZe19BgV46WLX3dmDOXORvKrHAe92hLzFIphM25aIiIDrP7EstL66p9jDgJqSvRWqXHVpoKJDiVJjZgKE9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716198418; c=relaxed/simple;
	bh=mgky5zTtotect6ZZDoVAkRWFzTUGpvE2sHz+d2SH7Xw=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fmX2ILAceEdpVchFcDFncwuWf/AzIUlu3saPI3DigMMS2j6VfbQ6bTneWLSAm+S/x291A2k2nwsN5c1gd0FAt8NjCapYlG6lRFHa9m6p8WZhTsWFmmbX7Yhu8QXiKkqsvpUgFDu4cUY6A82/6R9LOyKas5LjB3AJDGsiUGGimRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h8gitZcU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A695C4AF08
	for <linux-btrfs@vger.kernel.org>; Mon, 20 May 2024 09:46:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716198417;
	bh=mgky5zTtotect6ZZDoVAkRWFzTUGpvE2sHz+d2SH7Xw=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=h8gitZcUPYGcoHEXQo0vatkMoBlmHkxyRY2aL9cIUPv6FmNAe3vK9D80JOCrOQE5r
	 VwjHTW/HhbRR/+zWNEh8FrE53H4452nyggk+IQDB0xuw4Zy0C4VXZDu4e7WkhpJc5E
	 VBiO4suZI9XZOka8goHF4MtIr3Y1qFwDIi0BdE+FRIpb3bioQS3kdnGo1YWk1DjzjB
	 ijyue4DTSSCZPjgMM3q9PRe4zN6+HbOfo6SVsBdOepRtwyT+07dCayxTDGy/xwwfnT
	 JoCuuuGAlvfXk0oONUvDN5yveJf4sEbddpeP7wBEQvmuhPTDVS9tqbADRojhpS0YfQ
	 1x5bQOb/fqqMQ==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v4 3/6] btrfs: use a btrfs_inode in the log context (struct btrfs_log_ctx)
Date: Mon, 20 May 2024 10:46:48 +0100
Message-Id: <a59a51642e36e70a7d05aeaf7f2ee15d51d2077b.1716053516.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1716053516.git.fdmanana@suse.com>
References: <cover.1716053516.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

Instead of using a inode pointer, use a btrfs_inode pointer in the log
context structure, as this is generally what we need and allows for some
internal APIs to take a btrfs_inode instead, making them more consistent
with most of the code base. This will later allow to help to remove a lot
of BTRFS_I() calls in btrfs_sync_file().

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/file.c     |  4 ++--
 fs/btrfs/tree-log.c | 10 +++++-----
 fs/btrfs/tree-log.h |  4 ++--
 3 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 00670596bf06..506eabcd809d 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -1758,7 +1758,7 @@ static int start_ordered_ops(struct inode *inode, loff_t start, loff_t end)
 
 static inline bool skip_inode_logging(const struct btrfs_log_ctx *ctx)
 {
-	struct btrfs_inode *inode = BTRFS_I(ctx->inode);
+	struct btrfs_inode *inode = ctx->inode;
 	struct btrfs_fs_info *fs_info = inode->root->fs_info;
 
 	if (btrfs_inode_in_log(inode, btrfs_get_fs_generation(fs_info)) &&
@@ -1805,7 +1805,7 @@ int btrfs_sync_file(struct file *file, loff_t start, loff_t end, int datasync)
 
 	trace_btrfs_sync_file(file, datasync);
 
-	btrfs_init_log_ctx(&ctx, inode);
+	btrfs_init_log_ctx(&ctx, BTRFS_I(inode));
 
 	/*
 	 * Always set the range to a full range, otherwise we can get into
diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 2e762b89d4a2..51a167559ae8 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -2821,7 +2821,7 @@ static void wait_for_writer(struct btrfs_root *root)
 	finish_wait(&root->log_writer_wait, &wait);
 }
 
-void btrfs_init_log_ctx(struct btrfs_log_ctx *ctx, struct inode *inode)
+void btrfs_init_log_ctx(struct btrfs_log_ctx *ctx, struct btrfs_inode *inode)
 {
 	ctx->log_ret = 0;
 	ctx->log_transid = 0;
@@ -2840,7 +2840,7 @@ void btrfs_init_log_ctx(struct btrfs_log_ctx *ctx, struct inode *inode)
 
 void btrfs_init_log_ctx_scratch_eb(struct btrfs_log_ctx *ctx)
 {
-	struct btrfs_inode *inode = BTRFS_I(ctx->inode);
+	struct btrfs_inode *inode = ctx->inode;
 
 	if (!test_bit(BTRFS_INODE_NEEDS_FULL_SYNC, &inode->runtime_flags) &&
 	    !test_bit(BTRFS_INODE_COPY_EVERYTHING, &inode->runtime_flags))
@@ -2858,7 +2858,7 @@ void btrfs_release_log_ctx_extents(struct btrfs_log_ctx *ctx)
 	struct btrfs_ordered_extent *ordered;
 	struct btrfs_ordered_extent *tmp;
 
-	ASSERT(inode_is_locked(ctx->inode));
+	ASSERT(inode_is_locked(&ctx->inode->vfs_inode));
 
 	list_for_each_entry_safe(ordered, tmp, &ctx->ordered_extents, log_list) {
 		list_del_init(&ordered->log_list);
@@ -5908,7 +5908,7 @@ static int copy_inode_items_to_log(struct btrfs_trans_handle *trans,
 			if (ret < 0) {
 				return ret;
 			} else if (ret > 0 &&
-				   other_ino != btrfs_ino(BTRFS_I(ctx->inode))) {
+				   other_ino != btrfs_ino(ctx->inode)) {
 				if (ins_nr > 0) {
 					ins_nr++;
 				} else {
@@ -7570,7 +7570,7 @@ void btrfs_log_new_name(struct btrfs_trans_handle *trans,
 			goto out;
 	}
 
-	btrfs_init_log_ctx(&ctx, &inode->vfs_inode);
+	btrfs_init_log_ctx(&ctx, inode);
 	ctx.logging_new_name = true;
 	btrfs_init_log_ctx_scratch_eb(&ctx);
 	/*
diff --git a/fs/btrfs/tree-log.h b/fs/btrfs/tree-log.h
index 22e9cbc81577..fa0a689259b1 100644
--- a/fs/btrfs/tree-log.h
+++ b/fs/btrfs/tree-log.h
@@ -37,7 +37,7 @@ struct btrfs_log_ctx {
 	bool logging_new_delayed_dentries;
 	/* Indicate if the inode being logged was logged before. */
 	bool logged_before;
-	struct inode *inode;
+	struct btrfs_inode *inode;
 	struct list_head list;
 	/* Only used for fast fsyncs. */
 	struct list_head ordered_extents;
@@ -55,7 +55,7 @@ struct btrfs_log_ctx {
 	struct extent_buffer *scratch_eb;
 };
 
-void btrfs_init_log_ctx(struct btrfs_log_ctx *ctx, struct inode *inode);
+void btrfs_init_log_ctx(struct btrfs_log_ctx *ctx, struct btrfs_inode *inode);
 void btrfs_init_log_ctx_scratch_eb(struct btrfs_log_ctx *ctx);
 void btrfs_release_log_ctx_extents(struct btrfs_log_ctx *ctx);
 
-- 
2.43.0


