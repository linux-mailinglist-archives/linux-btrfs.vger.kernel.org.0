Return-Path: <linux-btrfs+bounces-2496-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FAF085A1B0
	for <lists+linux-btrfs@lfdr.de>; Mon, 19 Feb 2024 12:14:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D89CEB226F9
	for <lists+linux-btrfs@lfdr.de>; Mon, 19 Feb 2024 11:14:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E18D2C694;
	Mon, 19 Feb 2024 11:13:40 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 633D32C192
	for <linux-btrfs@vger.kernel.org>; Mon, 19 Feb 2024 11:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708341220; cv=none; b=Xi7+yvMtQWcHvfLn3GNh2C1NIYjbA+SQ494KEPjCFSICdR5mAkzOlTYWPcEnFOVEnvbxzYKJAR2f52ifCmYPMqSXYdrJ5YAvR5PDbOEZldlu9RP446nVf+AFnx8sl2vX5xpKrXfbYpSQpGeIkH57sRKmiEf66oNPp5CFPOeWyNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708341220; c=relaxed/simple;
	bh=zq5XQzV5FDQG3rrfDrD1thTle8erYeqO8YWqhZOSUcA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=byyN3oNvAlKAp9Z+LW+sHuXEEfDmthRb27eWo6vaRMs+Dxv4EEtGTDbxaFRbDV6+X1KJOCawH6yN4Hgvbh5tHx8oM0KR041PvZlq4yKfp/2HvVGJlnj2xIzTAJD0tVyQmmhGcH8JpjXIoNBRrPZw0cZZBA51GmYp/K+bTUKuFdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E9C4722301;
	Mon, 19 Feb 2024 11:13:36 +0000 (UTC)
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id E3654139C6;
	Mon, 19 Feb 2024 11:13:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id HjeCN+A302WfZgAAn2gu4w
	(envelope-from <dsterba@suse.com>); Mon, 19 Feb 2024 11:13:36 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 07/10] btrfs: uninline some static inline helpers from tree-log.h
Date: Mon, 19 Feb 2024 12:13:01 +0100
Message-ID: <8657859ac2592fef34919e577c84ec2a3d4b6a6e.1708339010.git.dsterba@suse.com>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <cover.1708339010.git.dsterba@suse.com>
References: <cover.1708339010.git.dsterba@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-4.00 / 50.00];
	 REPLY(-4.00)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: E9C4722301
X-Spam-Level: 
X-Spam-Score: -4.00
X-Spam-Flag: NO

The helpers are doing an initialization or release work, none of which
is performance critical that it would require a static inline, so move
them to the .c file.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/tree-log.c | 46 +++++++++++++++++++++++++++++++++++++++++++
 fs/btrfs/tree-log.h | 48 +++------------------------------------------
 2 files changed, 49 insertions(+), 45 deletions(-)

diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index d7693368f34f..472918a5bc73 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -2818,6 +2818,52 @@ static void wait_for_writer(struct btrfs_root *root)
 	finish_wait(&root->log_writer_wait, &wait);
 }
 
+void btrfs_init_log_ctx(struct btrfs_log_ctx *ctx, struct inode *inode)
+{
+	ctx->log_ret = 0;
+	ctx->log_transid = 0;
+	ctx->log_new_dentries = false;
+	ctx->logging_new_name = false;
+	ctx->logging_new_delayed_dentries = false;
+	ctx->logged_before = false;
+	ctx->inode = inode;
+	INIT_LIST_HEAD(&ctx->list);
+	INIT_LIST_HEAD(&ctx->ordered_extents);
+	INIT_LIST_HEAD(&ctx->conflict_inodes);
+	ctx->num_conflict_inodes = 0;
+	ctx->logging_conflict_inodes = false;
+	ctx->scratch_eb = NULL;
+}
+
+void btrfs_init_log_ctx_scratch_eb(struct btrfs_log_ctx *ctx)
+{
+	struct btrfs_inode *inode = BTRFS_I(ctx->inode);
+
+	if (!test_bit(BTRFS_INODE_NEEDS_FULL_SYNC, &inode->runtime_flags) &&
+	    !test_bit(BTRFS_INODE_COPY_EVERYTHING, &inode->runtime_flags))
+		return;
+
+	/*
+	 * Don't care about allocation failure. This is just for optimization,
+	 * if we fail to allocate here, we will try again later if needed.
+	 */
+	ctx->scratch_eb = alloc_dummy_extent_buffer(inode->root->fs_info, 0);
+}
+
+void btrfs_release_log_ctx_extents(struct btrfs_log_ctx *ctx)
+{
+	struct btrfs_ordered_extent *ordered;
+	struct btrfs_ordered_extent *tmp;
+
+	ASSERT(inode_is_locked(ctx->inode));
+
+	list_for_each_entry_safe(ordered, tmp, &ctx->ordered_extents, log_list) {
+		list_del_init(&ordered->log_list);
+		btrfs_put_ordered_extent(ordered);
+	}
+}
+
+
 static inline void btrfs_remove_log_ctx(struct btrfs_root *root,
 					struct btrfs_log_ctx *ctx)
 {
diff --git a/fs/btrfs/tree-log.h b/fs/btrfs/tree-log.h
index 254082a189c3..22e9cbc81577 100644
--- a/fs/btrfs/tree-log.h
+++ b/fs/btrfs/tree-log.h
@@ -55,51 +55,9 @@ struct btrfs_log_ctx {
 	struct extent_buffer *scratch_eb;
 };
 
-static inline void btrfs_init_log_ctx(struct btrfs_log_ctx *ctx,
-				      struct inode *inode)
-{
-	ctx->log_ret = 0;
-	ctx->log_transid = 0;
-	ctx->log_new_dentries = false;
-	ctx->logging_new_name = false;
-	ctx->logging_new_delayed_dentries = false;
-	ctx->logged_before = false;
-	ctx->inode = inode;
-	INIT_LIST_HEAD(&ctx->list);
-	INIT_LIST_HEAD(&ctx->ordered_extents);
-	INIT_LIST_HEAD(&ctx->conflict_inodes);
-	ctx->num_conflict_inodes = 0;
-	ctx->logging_conflict_inodes = false;
-	ctx->scratch_eb = NULL;
-}
-
-static inline void btrfs_init_log_ctx_scratch_eb(struct btrfs_log_ctx *ctx)
-{
-	struct btrfs_inode *inode = BTRFS_I(ctx->inode);
-
-	if (!test_bit(BTRFS_INODE_NEEDS_FULL_SYNC, &inode->runtime_flags) &&
-	    !test_bit(BTRFS_INODE_COPY_EVERYTHING, &inode->runtime_flags))
-		return;
-
-	/*
-	 * Don't care about allocation failure. This is just for optimization,
-	 * if we fail to allocate here, we will try again later if needed.
-	 */
-	ctx->scratch_eb = alloc_dummy_extent_buffer(inode->root->fs_info, 0);
-}
-
-static inline void btrfs_release_log_ctx_extents(struct btrfs_log_ctx *ctx)
-{
-	struct btrfs_ordered_extent *ordered;
-	struct btrfs_ordered_extent *tmp;
-
-	ASSERT(inode_is_locked(ctx->inode));
-
-	list_for_each_entry_safe(ordered, tmp, &ctx->ordered_extents, log_list) {
-		list_del_init(&ordered->log_list);
-		btrfs_put_ordered_extent(ordered);
-	}
-}
+void btrfs_init_log_ctx(struct btrfs_log_ctx *ctx, struct inode *inode);
+void btrfs_init_log_ctx_scratch_eb(struct btrfs_log_ctx *ctx);
+void btrfs_release_log_ctx_extents(struct btrfs_log_ctx *ctx);
 
 static inline void btrfs_set_log_full_commit(struct btrfs_trans_handle *trans)
 {
-- 
2.42.1


