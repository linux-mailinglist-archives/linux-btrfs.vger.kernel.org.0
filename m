Return-Path: <linux-btrfs+bounces-16077-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DAB2B25AD4
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 Aug 2025 07:34:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 738472A7BEB
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 Aug 2025 05:34:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06AE4223DD0;
	Thu, 14 Aug 2025 05:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="gyNXUi/w";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="gyNXUi/w"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59835223339
	for <linux-btrfs@vger.kernel.org>; Thu, 14 Aug 2025 05:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755149646; cv=none; b=KKcrGGfd9Wr87N2qgeUsq1w/TFQhsRQhP6CG1YpB9f7qsJJQ68mRP8xK24oQ5QTqh/jRwYSzBTm308hO6hJhZgkUFIoliyxaq8FnZqJTtYQAbC5xhp7rj7XwxiMp4krbQON0Tlf9Axl7lvhV5XDhgJ0++Ryfy96xxN/MOLG7nS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755149646; c=relaxed/simple;
	bh=uURMgh6JpN9vdwjA8ofv4MYH6lf79jdZTmsKa7kfmN8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n/ESlAnuew6EkwV9Z5uh7XZTz7eZVrCViRrUv81af9ueorzq0d+9ohk3Vd75ZoHTjb/sGuUvEON0XlRdbitMyhz8wi8TGkY4tK4cobJIT7mMBBvDD0fQ8e5YzinsrTc3fhPO0fZna2ib4E/SVag8DKNpAlmqMerj5Onyo48gbMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=gyNXUi/w; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=gyNXUi/w; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id AE3DE1F7CD
	for <linux-btrfs@vger.kernel.org>; Thu, 14 Aug 2025 05:33:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1755149633; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GbMwBIwzV6p5MSn41PnXPoNqOxq/93eQO+VH6Ud8NBE=;
	b=gyNXUi/wquguuQs4CaTVXaPU3MmysqO8ReE4xnHKAT/OGQiVtZwGyTuyqP5nTOQdpj3sel
	pfS+2OlIpV/EqPw2x0cXKuqfY2Dk6kigtyOvZm5ULlolT7ZwFkWGpoAlvke7BLW31+R6yf
	L3kTT8mpAuUkuMze67syHwi0ZQ+XyOI=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b="gyNXUi/w"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1755149633; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GbMwBIwzV6p5MSn41PnXPoNqOxq/93eQO+VH6Ud8NBE=;
	b=gyNXUi/wquguuQs4CaTVXaPU3MmysqO8ReE4xnHKAT/OGQiVtZwGyTuyqP5nTOQdpj3sel
	pfS+2OlIpV/EqPw2x0cXKuqfY2Dk6kigtyOvZm5ULlolT7ZwFkWGpoAlvke7BLW31+R6yf
	L3kTT8mpAuUkuMze67syHwi0ZQ+XyOI=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D01AA13479
	for <linux-btrfs@vger.kernel.org>; Thu, 14 Aug 2025 05:33:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 8CcMIkB1nWjYXQAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Thu, 14 Aug 2025 05:33:52 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 6/7] btrfs: rename btrfs_compress_op to btrfs_compress_levels
Date: Thu, 14 Aug 2025 15:03:25 +0930
Message-ID: <d5482f6331c39e85d742bcc1cef28c8e705af1bc.1755148754.git.wqu@suse.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1755148754.git.wqu@suse.com>
References: <cover.1755148754.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	FROM_EQ_ENVFROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:dkim,suse.com:email];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[suse.com:+]
X-Spam-Flag: NO
X-Spam-Level: 
X-Rspamd-Queue-Id: AE3DE1F7CD
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01

Since all workspace managers are per-fs, there is no need nor no way to
store them inside btrfs_compress_op::wsm anymore.

With that said, we can do the following modifications:

- Remove zstd_workspace_mananger::ops
  Zstd always grab the global btrfs_compress_op[].
- Remove btrfs_compress_op::wsm member
- Rename btrfs_compress_op to btrfs_compress_levels

This should make it more clear that btrfs_*_compress structures are only
to indicate the levels of each compress algorithm.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/compression.c | 14 +++++++-------
 fs/btrfs/compression.h | 11 +++++------
 fs/btrfs/lzo.c         |  2 +-
 fs/btrfs/zlib.c        |  2 +-
 fs/btrfs/zstd.c        |  4 +---
 5 files changed, 15 insertions(+), 18 deletions(-)

diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index 12b851218598..d515c4d8b8ea 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -727,9 +727,9 @@ static struct list_head *alloc_heuristic_ws(struct btrfs_fs_info *fs_info)
 	return ERR_PTR(-ENOMEM);
 }
 
-const struct btrfs_compress_op btrfs_heuristic_compress = { 0 };
+const struct btrfs_compress_levels btrfs_heuristic_compress = { 0 };
 
-static const struct btrfs_compress_op * const btrfs_compress_op[] = {
+static const struct btrfs_compress_levels * const btrfs_compress_levels[] = {
 	/* The heuristic is represented as compression type 0 */
 	&btrfs_heuristic_compress,
 	&btrfs_zlib_compress,
@@ -981,12 +981,12 @@ static void put_workspace(struct btrfs_fs_info *fs_info, int type, struct list_h
  */
 static int btrfs_compress_set_level(unsigned int type, int level)
 {
-	const struct btrfs_compress_op *ops = btrfs_compress_op[type];
+	const struct btrfs_compress_levels *levels = btrfs_compress_levels[type];
 
 	if (level == 0)
-		level = ops->default_level;
+		level = levels->default_level;
 	else
-		level = clamp(level, ops->min_level, ops->max_level);
+		level = clamp(level, levels->min_level, levels->max_level);
 
 	return level;
 }
@@ -996,9 +996,9 @@ static int btrfs_compress_set_level(unsigned int type, int level)
  */
 bool btrfs_compress_level_valid(unsigned int type, int level)
 {
-	const struct btrfs_compress_op *ops = btrfs_compress_op[type];
+	const struct btrfs_compress_levels *levels = btrfs_compress_levels[type];
 
-	return ops->min_level <= level && level <= ops->max_level;
+	return levels->min_level <= level && level <= levels->max_level;
 }
 
 /* Wrapper around find_get_page(), with extra error message. */
diff --git a/fs/btrfs/compression.h b/fs/btrfs/compression.h
index e9f5f821cf53..760d4aac74e6 100644
--- a/fs/btrfs/compression.h
+++ b/fs/btrfs/compression.h
@@ -129,8 +129,7 @@ struct workspace_manager {
 struct list_head *btrfs_get_workspace(struct btrfs_fs_info *fs_info, int type, int level);
 void btrfs_put_workspace(struct btrfs_fs_info *fs_info, int type, struct list_head *ws);
 
-struct btrfs_compress_op {
-	struct workspace_manager *workspace_manager;
+struct btrfs_compress_levels {
 	/* Maximum level supported by the compression algorithm */
 	int min_level;
 	int max_level;
@@ -140,10 +139,10 @@ struct btrfs_compress_op {
 /* The heuristic workspaces are managed via the 0th workspace manager */
 #define BTRFS_NR_WORKSPACE_MANAGERS	BTRFS_NR_COMPRESS_TYPES
 
-extern const struct btrfs_compress_op btrfs_heuristic_compress;
-extern const struct btrfs_compress_op btrfs_zlib_compress;
-extern const struct btrfs_compress_op btrfs_lzo_compress;
-extern const struct btrfs_compress_op btrfs_zstd_compress;
+extern const struct btrfs_compress_levels btrfs_heuristic_compress;
+extern const struct btrfs_compress_levels btrfs_zlib_compress;
+extern const struct btrfs_compress_levels btrfs_lzo_compress;
+extern const struct btrfs_compress_levels btrfs_zstd_compress;
 
 const char* btrfs_compress_type2str(enum btrfs_compression_type type);
 bool btrfs_compress_is_valid_type(const char *str, size_t len);
diff --git a/fs/btrfs/lzo.c b/fs/btrfs/lzo.c
index 3456a1dcd420..2983214643da 100644
--- a/fs/btrfs/lzo.c
+++ b/fs/btrfs/lzo.c
@@ -486,7 +486,7 @@ int lzo_decompress(struct list_head *ws, const u8 *data_in,
 	return ret;
 }
 
-const struct btrfs_compress_op btrfs_lzo_compress = {
+const struct btrfs_compress_levels  btrfs_lzo_compress = {
 	.max_level		= 1,
 	.default_level		= 1,
 };
diff --git a/fs/btrfs/zlib.c b/fs/btrfs/zlib.c
index aecc58054045..8e0bf34e0998 100644
--- a/fs/btrfs/zlib.c
+++ b/fs/btrfs/zlib.c
@@ -480,7 +480,7 @@ int zlib_decompress(struct list_head *ws, const u8 *data_in,
 	return ret;
 }
 
-const struct btrfs_compress_op btrfs_zlib_compress = {
+const struct btrfs_compress_levels btrfs_zlib_compress = {
 	.min_level		= 1,
 	.max_level		= 9,
 	.default_level		= BTRFS_ZLIB_DEFAULT_LEVEL,
diff --git a/fs/btrfs/zstd.c b/fs/btrfs/zstd.c
index d514a73a4015..63faeb3ed9ac 100644
--- a/fs/btrfs/zstd.c
+++ b/fs/btrfs/zstd.c
@@ -77,7 +77,6 @@ struct workspace {
  */
 
 struct zstd_workspace_manager {
-	const struct btrfs_compress_op *ops;
 	spinlock_t lock;
 	struct list_head lru_list;
 	struct list_head idle_ws[ZSTD_BTRFS_MAX_LEVEL];
@@ -190,7 +189,6 @@ int zstd_alloc_workspace_manager(struct btrfs_fs_info *fs_info)
 	if (!zwsm)
 		return -ENOMEM;
 	zstd_calc_ws_mem_sizes();
-	zwsm->ops = &btrfs_zstd_compress;
 	spin_lock_init(&zwsm->lock);
 	init_waitqueue_head(&zwsm->wait);
 	timer_setup(&zwsm->timer, zstd_reclaim_timer_fn, 0);
@@ -727,7 +725,7 @@ int zstd_decompress(struct list_head *ws, const u8 *data_in,
 	return ret;
 }
 
-const struct btrfs_compress_op btrfs_zstd_compress = {
+const struct btrfs_compress_levels btrfs_zstd_compress = {
 	.min_level	= ZSTD_BTRFS_MIN_LEVEL,
 	.max_level	= ZSTD_BTRFS_MAX_LEVEL,
 	.default_level	= ZSTD_BTRFS_DEFAULT_LEVEL,
-- 
2.50.1


