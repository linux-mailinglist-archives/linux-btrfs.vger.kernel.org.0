Return-Path: <linux-btrfs+bounces-13495-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DD174AA064E
	for <lists+linux-btrfs@lfdr.de>; Tue, 29 Apr 2025 10:54:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 981E53B77C0
	for <lists+linux-btrfs@lfdr.de>; Tue, 29 Apr 2025 08:53:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C3C829CB59;
	Tue, 29 Apr 2025 08:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Fgnw+CIj";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Fgnw+CIj"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38A2529B23E
	for <linux-btrfs@vger.kernel.org>; Tue, 29 Apr 2025 08:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745916842; cv=none; b=lyq8dtOB3c8PJsBT8XRuAzEPQ9sh+jOIHStV72fP6gyvNbLy5d6M9XRjWPGzYVdGCVkGVhwvsLYeT+ydxBiC56B2dlpl34F6Xnsrd+bF48cLg97StIHFZbUjXvM5c7ggTIYzJc2Ce2htwTB3fwXFpNO3vehk7iLaWGRSpjQrEIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745916842; c=relaxed/simple;
	bh=kvar73yUBfolrK4fU4Mnenr1V9FDILOcMxTU5qKjg7g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AI8zO+GV2gmRGUrEVYBnbfcqE/S+rdW0UP/0rUGwxjdAH7YnKjKJnLgQcXkUk4NUrqsaLXOSZ+wNGSA4DNWKjqXdZ62FC8ni5VejPMIpY2MXAA4Rkdd50olsb4mDSK4cqCHsWLfKe8z40RCQGKd7gPXOgoEP11O/3M4phWtU/9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Fgnw+CIj; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Fgnw+CIj; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 47F7A218F2;
	Tue, 29 Apr 2025 08:53:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1745916838; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=h8a6/GpX2QbATjZKYe1Pj3806oiejeUV/sKiuIE1IlA=;
	b=Fgnw+CIjyppnJmUaZbhV8y04NaSve8rznRaf9o1F4NCJvfouS058U76g101giOGJ/dRkzW
	9CllpIguTwOKMvHuO0vCheiZOcz0MQWyPR5E/LGM7t/3+t9NUGdSjgjP8BQ4KfGkMGaT3B
	Q0RuaZrQkSKLVatWd8rhi+8KLZunU8M=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1745916838; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=h8a6/GpX2QbATjZKYe1Pj3806oiejeUV/sKiuIE1IlA=;
	b=Fgnw+CIjyppnJmUaZbhV8y04NaSve8rznRaf9o1F4NCJvfouS058U76g101giOGJ/dRkzW
	9CllpIguTwOKMvHuO0vCheiZOcz0MQWyPR5E/LGM7t/3+t9NUGdSjgjP8BQ4KfGkMGaT3B
	Q0RuaZrQkSKLVatWd8rhi+8KLZunU8M=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4069313931;
	Tue, 29 Apr 2025 08:53:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id HlyvD6aTEGi+DgAAD6G6ig
	(envelope-from <dsterba@suse.com>); Tue, 29 Apr 2025 08:53:58 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH] btrfs: send: remove btrfs_debug() calls
Date: Tue, 29 Apr 2025 10:53:49 +0200
Message-ID: <20250429085349.2169622-1-dsterba@suse.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -2.80
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:mid,suse.com:email];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 

There are debugging prints each emitted send commands and other related
actions. This does not seem right as the number of commands can be high
and dumping that to the system log will likely hit some rate limiting.
This should be done by trace points that are more lightweight and can
keep up with high frequency.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/send.c | 38 +-------------------------------------
 1 file changed, 1 insertion(+), 37 deletions(-)

diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index 18d14231f23b4a..0ba4f51766d601 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -819,8 +819,6 @@ static int send_rename(struct send_ctx *sctx,
 	struct btrfs_fs_info *fs_info = sctx->send_root->fs_info;
 	int ret;
 
-	btrfs_debug(fs_info, "send_rename %s -> %s", from->start, to->start);
-
 	ret = begin_cmd(sctx, BTRFS_SEND_C_RENAME);
 	if (ret < 0)
 		return ret;
@@ -843,8 +841,6 @@ static int send_link(struct send_ctx *sctx,
 	struct btrfs_fs_info *fs_info = sctx->send_root->fs_info;
 	int ret;
 
-	btrfs_debug(fs_info, "send_link %s -> %s", path->start, lnk->start);
-
 	ret = begin_cmd(sctx, BTRFS_SEND_C_LINK);
 	if (ret < 0)
 		return ret;
@@ -866,8 +862,6 @@ static int send_unlink(struct send_ctx *sctx, struct fs_path *path)
 	struct btrfs_fs_info *fs_info = sctx->send_root->fs_info;
 	int ret;
 
-	btrfs_debug(fs_info, "send_unlink %s", path->start);
-
 	ret = begin_cmd(sctx, BTRFS_SEND_C_UNLINK);
 	if (ret < 0)
 		return ret;
@@ -888,8 +882,6 @@ static int send_rmdir(struct send_ctx *sctx, struct fs_path *path)
 	struct btrfs_fs_info *fs_info = sctx->send_root->fs_info;
 	int ret;
 
-	btrfs_debug(fs_info, "send_rmdir %s", path->start);
-
 	ret = begin_cmd(sctx, BTRFS_SEND_C_RMDIR);
 	if (ret < 0)
 		return ret;
@@ -1686,14 +1678,8 @@ static int find_extent_clone(struct send_ctx *sctx,
 	}
 	up_read(&fs_info->commit_root_sem);
 
-	btrfs_debug(fs_info,
-		    "find_extent_clone: data_offset=%llu, ino=%llu, num_bytes=%llu, logical=%llu",
-		    data_offset, ino, num_bytes, logical);
-
-	if (!backref_ctx.found) {
-		btrfs_debug(fs_info, "no clones found");
+	if (!backref_ctx.found)
 		return -ENOENT;
-	}
 
 	cur_clone_root = NULL;
 	for (i = 0; i < sctx->clone_roots_cnt; i++) {
@@ -2635,8 +2621,6 @@ static int send_truncate(struct send_ctx *sctx, u64 ino, u64 gen, u64 size)
 	int ret = 0;
 	struct fs_path *p;
 
-	btrfs_debug(fs_info, "send_truncate %llu size=%llu", ino, size);
-
 	p = get_path_for_command(sctx, ino, gen);
 	if (IS_ERR(p))
 		return PTR_ERR(p);
@@ -2662,8 +2646,6 @@ static int send_chmod(struct send_ctx *sctx, u64 ino, u64 gen, u64 mode)
 	int ret = 0;
 	struct fs_path *p;
 
-	btrfs_debug(fs_info, "send_chmod %llu mode=%llu", ino, mode);
-
 	p = get_path_for_command(sctx, ino, gen);
 	if (IS_ERR(p))
 		return PTR_ERR(p);
@@ -2692,8 +2674,6 @@ static int send_fileattr(struct send_ctx *sctx, u64 ino, u64 gen, u64 fileattr)
 	if (sctx->proto < 2)
 		return 0;
 
-	btrfs_debug(fs_info, "send_fileattr %llu fileattr=%llu", ino, fileattr);
-
 	p = get_path_for_command(sctx, ino, gen);
 	if (IS_ERR(p))
 		return PTR_ERR(p);
@@ -2719,9 +2699,6 @@ static int send_chown(struct send_ctx *sctx, u64 ino, u64 gen, u64 uid, u64 gid)
 	int ret = 0;
 	struct fs_path *p;
 
-	btrfs_debug(fs_info, "send_chown %llu uid=%llu, gid=%llu",
-		    ino, uid, gid);
-
 	p = get_path_for_command(sctx, ino, gen);
 	if (IS_ERR(p))
 		return PTR_ERR(p);
@@ -2753,8 +2730,6 @@ static int send_utimes(struct send_ctx *sctx, u64 ino, u64 gen)
 	struct btrfs_key key;
 	int slot;
 
-	btrfs_debug(fs_info, "send_utimes %llu", ino);
-
 	p = get_path_for_command(sctx, ino, gen);
 	if (IS_ERR(p))
 		return PTR_ERR(p);
@@ -2870,8 +2845,6 @@ static int send_create_inode(struct send_ctx *sctx, u64 ino)
 	u64 mode;
 	u64 rdev;
 
-	btrfs_debug(fs_info, "send_create_inode %llu", ino);
-
 	p = fs_path_alloc();
 	if (!p)
 		return -ENOMEM;
@@ -4224,8 +4197,6 @@ static int process_recorded_refs(struct send_ctx *sctx, int *pending_move)
 	bool orphanized_dir = false;
 	bool orphanized_ancestor = false;
 
-	btrfs_debug(fs_info, "process_recorded_refs %llu", sctx->cur_ino);
-
 	/*
 	 * This should never happen as the root dir always has the same ref
 	 * which is always '..'
@@ -5338,8 +5309,6 @@ static int send_write(struct send_ctx *sctx, u64 offset, u32 len)
 	int ret = 0;
 	struct fs_path *p;
 
-	btrfs_debug(fs_info, "send_write offset=%llu, len=%d", offset, len);
-
 	p = get_cur_inode_path(sctx);
 	if (IS_ERR(p))
 		return PTR_ERR(p);
@@ -5372,11 +5341,6 @@ static int send_clone(struct send_ctx *sctx,
 	struct fs_path *cur_inode_path;
 	u64 gen;
 
-	btrfs_debug(sctx->send_root->fs_info,
-		    "send_clone offset=%llu, len=%d, clone_root=%llu, clone_inode=%llu, clone_offset=%llu",
-		    offset, len, btrfs_root_id(clone_root->root),
-		    clone_root->ino, clone_root->offset);
-
 	cur_inode_path = get_cur_inode_path(sctx);
 	if (IS_ERR(cur_inode_path))
 		return PTR_ERR(cur_inode_path);
-- 
2.49.0


