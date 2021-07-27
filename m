Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CEFA3D819D
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Jul 2021 23:21:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234640AbhG0VUH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 27 Jul 2021 17:20:07 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:46004 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231339AbhG0VTZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 27 Jul 2021 17:19:25 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id F40B920181;
        Tue, 27 Jul 2021 21:18:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1627420687; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GuVIO3h4A3uvlueiXNtD+gOKe8DJdOF+LTpC6lPdeN0=;
        b=EuKCJQ5x1aIryfImdCZCKXzQJC0ZwE/5lo4eOuyv4ITyP5/7WWVCmnZPxGksfvaljlrL3U
        it1sdsmqMYHRsEMDmrAFKqZ0esYXDKXascr1WM7FowqTcJeEbx7VnhXS7ANbsNBVEFs3Jr
        c37zWMpUUmHW0bRBsyRoCAtn4NbRtlw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1627420687;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GuVIO3h4A3uvlueiXNtD+gOKe8DJdOF+LTpC6lPdeN0=;
        b=plHhhSL3RHlgtPnDW4SiJjwR6x3MZzBGUwCOKA55C8KaJf9YPzlHZtSiqu8vgr2h8w1C9w
        it0DORLeufmpOgCg==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 7064D133DE;
        Tue, 27 Jul 2021 21:18:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id sdu9Dg94AGGTdQAAGKfGzw
        (envelope-from <rgoldwyn@suse.de>); Tue, 27 Jul 2021 21:18:07 +0000
From:   Goldwyn Rodrigues <rgoldwyn@suse.de>
To:     linux-btrfs@vger.kernel.org
Cc:     Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: [PATCH 7/7] btrfs: Alloc backref_ctx on stack
Date:   Tue, 27 Jul 2021 16:17:31 -0500
Message-Id: <d1a4e43de270f291d97b1c00b7ca3b32ce699009.1627418762.git.rgoldwyn@suse.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1627418762.git.rgoldwyn@suse.com>
References: <cover.1627418762.git.rgoldwyn@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Goldwyn Rodrigues <rgoldwyn@suse.com>

Instead of using kmalloc() to allocate backref_ctx, allocate backref_ctx
on stack.

sizeof(backref_ctx) = 48

Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
---
 fs/btrfs/send.c | 29 +++++++++++------------------
 1 file changed, 11 insertions(+), 18 deletions(-)

diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index 6ac37ae6c811..e0553fa27f85 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -1307,7 +1307,7 @@ static int find_extent_clone(struct send_ctx *sctx,
 	u64 flags = 0;
 	struct btrfs_file_extent_item *fi;
 	struct extent_buffer *eb = path->nodes[0];
-	struct backref_ctx *backref_ctx = NULL;
+	struct backref_ctx backref_ctx = {0};
 	struct clone_root *cur_clone_root;
 	struct btrfs_key found_key;
 	struct btrfs_path *tmp_path;
@@ -1322,12 +1322,6 @@ static int find_extent_clone(struct send_ctx *sctx,
 	/* We only use this path under the commit sem */
 	tmp_path->need_commit_sem = 0;
 
-	backref_ctx = kmalloc(sizeof(*backref_ctx), GFP_KERNEL);
-	if (!backref_ctx) {
-		ret = -ENOMEM;
-		goto out;
-	}
-
 	if (data_offset >= ino_size) {
 		/*
 		 * There may be extents that lie behind the file's size.
@@ -1392,12 +1386,12 @@ static int find_extent_clone(struct send_ctx *sctx,
 		cur_clone_root->found_refs = 0;
 	}
 
-	backref_ctx->sctx = sctx;
-	backref_ctx->found = 0;
-	backref_ctx->cur_objectid = ino;
-	backref_ctx->cur_offset = data_offset;
-	backref_ctx->found_itself = 0;
-	backref_ctx->extent_len = num_bytes;
+	backref_ctx.sctx = sctx;
+	backref_ctx.found = 0;
+	backref_ctx.cur_objectid = ino;
+	backref_ctx.cur_offset = data_offset;
+	backref_ctx.found_itself = 0;
+	backref_ctx.extent_len = num_bytes;
 
 	/*
 	 * The last extent of a file may be too large due to page alignment.
@@ -1405,7 +1399,7 @@ static int find_extent_clone(struct send_ctx *sctx,
 	 * __iterate_backrefs work.
 	 */
 	if (data_offset + num_bytes >= ino_size)
-		backref_ctx->extent_len = ino_size - data_offset;
+		backref_ctx.extent_len = ino_size - data_offset;
 
 	/*
 	 * Now collect all backrefs.
@@ -1416,12 +1410,12 @@ static int find_extent_clone(struct send_ctx *sctx,
 		extent_item_pos = 0;
 	ret = iterate_extent_inodes(fs_info, found_key.objectid,
 				    extent_item_pos, 1, __iterate_backrefs,
-				    backref_ctx, false);
+				    &backref_ctx, false);
 
 	if (ret < 0)
 		goto out;
 
-	if (!backref_ctx->found_itself) {
+	if (!backref_ctx.found_itself) {
 		/* found a bug in backref code? */
 		ret = -EIO;
 		btrfs_err(fs_info,
@@ -1434,7 +1428,7 @@ static int find_extent_clone(struct send_ctx *sctx,
 		    "find_extent_clone: data_offset=%llu, ino=%llu, num_bytes=%llu, logical=%llu",
 		    data_offset, ino, num_bytes, logical);
 
-	if (!backref_ctx->found)
+	if (!backref_ctx.found)
 		btrfs_debug(fs_info, "no clones found");
 
 	cur_clone_root = NULL;
@@ -1458,7 +1452,6 @@ static int find_extent_clone(struct send_ctx *sctx,
 
 out:
 	btrfs_free_path(tmp_path);
-	kfree(backref_ctx);
 	return ret;
 }
 
-- 
2.32.0

