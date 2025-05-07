Return-Path: <linux-btrfs+bounces-13795-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5624EAAE6A6
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 May 2025 18:29:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0AD667B62E3
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 May 2025 16:27:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8751B28C011;
	Wed,  7 May 2025 16:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="b6FripRi";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="ZCw+M7NS"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84D8E13AF2
	for <linux-btrfs@vger.kernel.org>; Wed,  7 May 2025 16:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746635294; cv=none; b=GBfkJRudp1L1RUhCyhux0G/E4F83rezpKBDR3EusqDMTKF7O06j09FHTAPcTrtXx2t6G1n+AbyjRgM8TpyqUbI6b6fJ89Gwrde9xHOuKR8iM9e/YS1KYg2ua2JuvJAs7OxbWOPWAsRSgZ5138mTuE3+59sNcLozuSbEyJ0b3T2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746635294; c=relaxed/simple;
	bh=OniKjc4fXjVqOgvehat2rcDRsJ8yIqSOtU5xP+ZvI98=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CXENsUKFTfteCTb4WvCXqElKaPjdd9eh+502p/ZsFoVaL7Jw/gSAVAOAenY5W/PHVHJZvHWl9PZh5leq6kNWufrWPR8ByTPdKvfzj04MuyumCd9VYBtlaFvFCte1unJdPw/ACghHNfzEZBib8MQ7udzXwBULpz2iJ2cgOzab+ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=b6FripRi; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=ZCw+M7NS; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A38A11F395;
	Wed,  7 May 2025 16:28:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1746635290; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=k1xov5k1C+OdAkoajK6RnlsPNS6Kwr7hL6oEZn3JCJU=;
	b=b6FripRiJ/KAUSeFut59cO/Cgoha24o/hNfbbarJxoHhGT3+uIcYpuo+eSRYpP1IdvJv4o
	rRBoeGp+VnBLVN6FGDm0ztrJZVw0zEUG5+aZNAe9cM5+JQRAVrM+wJ+XUGBpzSgEUrQS7F
	5CglKwdb8RoUg6KfvJjuAae0qowQmxo=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1746635289; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=k1xov5k1C+OdAkoajK6RnlsPNS6Kwr7hL6oEZn3JCJU=;
	b=ZCw+M7NSpPN2QPT6cYnDZwDDj81vhixJfkTZY6E86FF/n/PReH0P4qk/LMsEGbD303i3sL
	aAQcQWrCmfC+fLtCMCZYDGAWzMmZfrwEwzQ2HHIKxh+JzB/34dlfusXwlpCi7LgXSWArFr
	Uq0jZKJHypyhNY4IewXAHBrRaO/ExOk=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9C445139D9;
	Wed,  7 May 2025 16:28:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id HwoiJhmKG2gkeQAAD6G6ig
	(envelope-from <dsterba@suse.com>); Wed, 07 May 2025 16:28:09 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH v2] btrfs: send: remove btrfs_debug() calls
Date: Wed,  7 May 2025 18:28:06 +0200
Message-ID: <20250507162807.21920-1-dsterba@suse.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
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
X-Spam-Score: -2.80

There are debugging prints each emitted send commands and other related
actions. This does not seem right as the number of commands can be high
and dumping that to the system log will likely hit some rate limiting.
This should be done by trace points that are more lightweight and can
keep up with high frequency.

Signed-off-by: David Sterba <dsterba@suse.com>
---

v2:
- fix build warnins, remove unused fs_info variables

 fs/btrfs/send.c | 51 +------------------------------------------------
 1 file changed, 1 insertion(+), 50 deletions(-)

diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index 18d14231f23b..ab7326f35787 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -816,11 +816,8 @@ static int send_cmd(struct send_ctx *sctx)
 static int send_rename(struct send_ctx *sctx,
 		     struct fs_path *from, struct fs_path *to)
 {
-	struct btrfs_fs_info *fs_info = sctx->send_root->fs_info;
 	int ret;
 
-	btrfs_debug(fs_info, "send_rename %s -> %s", from->start, to->start);
-
 	ret = begin_cmd(sctx, BTRFS_SEND_C_RENAME);
 	if (ret < 0)
 		return ret;
@@ -840,11 +837,8 @@ static int send_rename(struct send_ctx *sctx,
 static int send_link(struct send_ctx *sctx,
 		     struct fs_path *path, struct fs_path *lnk)
 {
-	struct btrfs_fs_info *fs_info = sctx->send_root->fs_info;
 	int ret;
 
-	btrfs_debug(fs_info, "send_link %s -> %s", path->start, lnk->start);
-
 	ret = begin_cmd(sctx, BTRFS_SEND_C_LINK);
 	if (ret < 0)
 		return ret;
@@ -863,11 +857,8 @@ static int send_link(struct send_ctx *sctx,
  */
 static int send_unlink(struct send_ctx *sctx, struct fs_path *path)
 {
-	struct btrfs_fs_info *fs_info = sctx->send_root->fs_info;
 	int ret;
 
-	btrfs_debug(fs_info, "send_unlink %s", path->start);
-
 	ret = begin_cmd(sctx, BTRFS_SEND_C_UNLINK);
 	if (ret < 0)
 		return ret;
@@ -885,11 +876,8 @@ static int send_unlink(struct send_ctx *sctx, struct fs_path *path)
  */
 static int send_rmdir(struct send_ctx *sctx, struct fs_path *path)
 {
-	struct btrfs_fs_info *fs_info = sctx->send_root->fs_info;
 	int ret;
 
-	btrfs_debug(fs_info, "send_rmdir %s", path->start);
-
 	ret = begin_cmd(sctx, BTRFS_SEND_C_RMDIR);
 	if (ret < 0)
 		return ret;
@@ -1573,7 +1561,6 @@ static int find_extent_clone(struct send_ctx *sctx,
 	struct btrfs_fs_info *fs_info = sctx->send_root->fs_info;
 	int ret;
 	int extent_type;
-	u64 logical;
 	u64 disk_byte;
 	u64 num_bytes;
 	struct btrfs_file_extent_item *fi;
@@ -1604,7 +1591,6 @@ static int find_extent_clone(struct send_ctx *sctx,
 
 	compressed = btrfs_file_extent_compression(eb, fi);
 	num_bytes = btrfs_file_extent_num_bytes(eb, fi);
-	logical = disk_byte + btrfs_file_extent_offset(eb, fi);
 
 	/*
 	 * Setup the clone roots.
@@ -1686,14 +1672,8 @@ static int find_extent_clone(struct send_ctx *sctx,
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
@@ -2631,12 +2611,9 @@ static void free_path_for_command(const struct send_ctx *sctx, struct fs_path *p
 
 static int send_truncate(struct send_ctx *sctx, u64 ino, u64 gen, u64 size)
 {
-	struct btrfs_fs_info *fs_info = sctx->send_root->fs_info;
 	int ret = 0;
 	struct fs_path *p;
 
-	btrfs_debug(fs_info, "send_truncate %llu size=%llu", ino, size);
-
 	p = get_path_for_command(sctx, ino, gen);
 	if (IS_ERR(p))
 		return PTR_ERR(p);
@@ -2658,12 +2635,9 @@ static int send_truncate(struct send_ctx *sctx, u64 ino, u64 gen, u64 size)
 
 static int send_chmod(struct send_ctx *sctx, u64 ino, u64 gen, u64 mode)
 {
-	struct btrfs_fs_info *fs_info = sctx->send_root->fs_info;
 	int ret = 0;
 	struct fs_path *p;
 
-	btrfs_debug(fs_info, "send_chmod %llu mode=%llu", ino, mode);
-
 	p = get_path_for_command(sctx, ino, gen);
 	if (IS_ERR(p))
 		return PTR_ERR(p);
@@ -2685,15 +2659,12 @@ static int send_chmod(struct send_ctx *sctx, u64 ino, u64 gen, u64 mode)
 
 static int send_fileattr(struct send_ctx *sctx, u64 ino, u64 gen, u64 fileattr)
 {
-	struct btrfs_fs_info *fs_info = sctx->send_root->fs_info;
 	int ret = 0;
 	struct fs_path *p;
 
 	if (sctx->proto < 2)
 		return 0;
 
-	btrfs_debug(fs_info, "send_fileattr %llu fileattr=%llu", ino, fileattr);
-
 	p = get_path_for_command(sctx, ino, gen);
 	if (IS_ERR(p))
 		return PTR_ERR(p);
@@ -2715,13 +2686,9 @@ static int send_fileattr(struct send_ctx *sctx, u64 ino, u64 gen, u64 fileattr)
 
 static int send_chown(struct send_ctx *sctx, u64 ino, u64 gen, u64 uid, u64 gid)
 {
-	struct btrfs_fs_info *fs_info = sctx->send_root->fs_info;
 	int ret = 0;
 	struct fs_path *p;
 
-	btrfs_debug(fs_info, "send_chown %llu uid=%llu, gid=%llu",
-		    ino, uid, gid);
-
 	p = get_path_for_command(sctx, ino, gen);
 	if (IS_ERR(p))
 		return PTR_ERR(p);
@@ -2744,7 +2711,6 @@ static int send_chown(struct send_ctx *sctx, u64 ino, u64 gen, u64 uid, u64 gid)
 
 static int send_utimes(struct send_ctx *sctx, u64 ino, u64 gen)
 {
-	struct btrfs_fs_info *fs_info = sctx->send_root->fs_info;
 	int ret = 0;
 	struct fs_path *p = NULL;
 	struct btrfs_inode_item *ii;
@@ -2753,8 +2719,6 @@ static int send_utimes(struct send_ctx *sctx, u64 ino, u64 gen)
 	struct btrfs_key key;
 	int slot;
 
-	btrfs_debug(fs_info, "send_utimes %llu", ino);
-
 	p = get_path_for_command(sctx, ino, gen);
 	if (IS_ERR(p))
 		return PTR_ERR(p);
@@ -2861,7 +2825,6 @@ static int trim_dir_utimes_cache(struct send_ctx *sctx)
  */
 static int send_create_inode(struct send_ctx *sctx, u64 ino)
 {
-	struct btrfs_fs_info *fs_info = sctx->send_root->fs_info;
 	int ret = 0;
 	struct fs_path *p;
 	int cmd;
@@ -2870,8 +2833,6 @@ static int send_create_inode(struct send_ctx *sctx, u64 ino)
 	u64 mode;
 	u64 rdev;
 
-	btrfs_debug(fs_info, "send_create_inode %llu", ino);
-
 	p = fs_path_alloc();
 	if (!p)
 		return -ENOMEM;
@@ -4224,8 +4185,6 @@ static int process_recorded_refs(struct send_ctx *sctx, int *pending_move)
 	bool orphanized_dir = false;
 	bool orphanized_ancestor = false;
 
-	btrfs_debug(fs_info, "process_recorded_refs %llu", sctx->cur_ino);
-
 	/*
 	 * This should never happen as the root dir always has the same ref
 	 * which is always '..'
@@ -5334,12 +5293,9 @@ static int put_file_data(struct send_ctx *sctx, u64 offset, u32 len)
  */
 static int send_write(struct send_ctx *sctx, u64 offset, u32 len)
 {
-	struct btrfs_fs_info *fs_info = sctx->send_root->fs_info;
 	int ret = 0;
 	struct fs_path *p;
 
-	btrfs_debug(fs_info, "send_write offset=%llu, len=%d", offset, len);
-
 	p = get_cur_inode_path(sctx);
 	if (IS_ERR(p))
 		return PTR_ERR(p);
@@ -5372,11 +5328,6 @@ static int send_clone(struct send_ctx *sctx,
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
2.47.1


