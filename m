Return-Path: <linux-btrfs+bounces-16332-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AE706B33CD6
	for <lists+linux-btrfs@lfdr.de>; Mon, 25 Aug 2025 12:32:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 20EE11890514
	for <lists+linux-btrfs@lfdr.de>; Mon, 25 Aug 2025 10:31:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D70B72D8363;
	Mon, 25 Aug 2025 10:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="VAsliFca";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="VAsliFca"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AEBE2D46D1
	for <linux-btrfs@vger.kernel.org>; Mon, 25 Aug 2025 10:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756117610; cv=none; b=qhXf8AsJ9VZl4nfmpGV8Eho8XGxAqAOqi7SrEHz5zyV69kFwgNO/qO2dEqMEr5A+wdJFxzGrkuLl2bAdBNERa0CA7R4IcMO5Fshq0fn05T0VUdtGUk0rAyG7a5DCL2nQ2uPxf/WG5acvU7AkqXOaR2h9g9lK/yqwH4ksgVbDWT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756117610; c=relaxed/simple;
	bh=tvDjHk+TW17nBIIh36jgoEBmZdIFzXEYROspmr3V1A4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=TqZpwKHtAxenB6rcli/YsIrZwGaTzoRjNGMwliQKAWjcUhxcjpPl1lXQd+pMhFZ5aXPKIas5+SNpmWHTkD3uziZbeFWi65pZ8j10VeDzwM4JlbAt6QMlZvjXOp+UMRcUUCIo/cHP3hHTHkwleX8rwubsnK800SvSjE4mRo3row0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=VAsliFca; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=VAsliFca; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 720E71F794
	for <linux-btrfs@vger.kernel.org>; Mon, 25 Aug 2025 10:26:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1756117605; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=Jzn6UuQxA25nylDQWEMu0UNoOEdK15WrGBAcJeL/gpY=;
	b=VAsliFcaU+XtuGNbJ1cCedCGZofr4ZRzJHXJfD07awek/Zgn41mWn6Zn+5TTzvNlAldg3P
	ekCkXuD/F17H6qmdkx3sB90KhqusvOZ2TKZVOmQp5BrvjCc3IYyBdJAKZiQDgckNaP0d9q
	pDP2KajqF0BNVBOI1Zg+FOt8tR4rwFo=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=VAsliFca
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1756117605; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=Jzn6UuQxA25nylDQWEMu0UNoOEdK15WrGBAcJeL/gpY=;
	b=VAsliFcaU+XtuGNbJ1cCedCGZofr4ZRzJHXJfD07awek/Zgn41mWn6Zn+5TTzvNlAldg3P
	ekCkXuD/F17H6qmdkx3sB90KhqusvOZ2TKZVOmQp5BrvjCc3IYyBdJAKZiQDgckNaP0d9q
	pDP2KajqF0BNVBOI1Zg+FOt8tR4rwFo=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AF3E913A7B
	for <linux-btrfs@vger.kernel.org>; Mon, 25 Aug 2025 10:26:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id aEdjHGQ6rGivbwAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Mon, 25 Aug 2025 10:26:44 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: reject invalid compression level
Date: Mon, 25 Aug 2025 19:56:26 +0930
Message-ID: <3aa4ab3069efeb71fa0197430e91df74139ebfa3.1756117561.git.wqu@suse.com>
X-Mailer: git-send-email 2.50.1
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:mid,suse.com:dkim,suse.com:email];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[suse.com:+]
X-Spam-Flag: NO
X-Spam-Level: 
X-Rspamd-Queue-Id: 720E71F794
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01

Inspired by recent changes to compression level parsing by Calvin Owens,
it turns out that we do not do any extra validation for compression
level, thus allowing things like "compress=lzo:invalid" to be accepted
without extra warning or whatever.

Although we accept levels that are beyond the supported algorithm
ranges, accepting completely invalid levels are beyond sanity.

Fix the too loose checks for compression level, by doing proper error
handling of kstrtoint(), so that we will reject not only too large
values (beyond int range) but also completely insane levels like
"lzo:invalid".

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/compression.c | 21 +++++++++++++--------
 fs/btrfs/compression.h |  2 +-
 fs/btrfs/super.c       | 27 +++++++++++++++++++--------
 3 files changed, 33 insertions(+), 17 deletions(-)

diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index 068339e86123..d13a66f7b4ac 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -1652,24 +1652,29 @@ int btrfs_compress_heuristic(struct btrfs_inode *inode, u64 start, u64 end)
 
 /*
  * Convert the compression suffix (eg. after "zlib" starting with ":") to
- * level, unrecognized string will set the default level. Negative level
- * numbers are allowed.
+ * level.
+ *
+ * If the resulted level exceed the algo's supported levels, it will be clamped.
+ *
+ * Return <0 if no valid string can be found.
+ * Return 0 if everything is fine.
  */
-int btrfs_compress_str2level(unsigned int type, const char *str)
+int btrfs_compress_str2level(unsigned int type, const char *str, int *level_ret)
 {
 	int level = 0;
 	int ret;
 
-	if (!type)
+	if (!type) {
+		*level_ret = btrfs_compress_set_level(type, level);
 		return 0;
+	}
 
 	if (str[0] == ':') {
 		ret = kstrtoint(str + 1, 10, &level);
 		if (ret)
-			level = 0;
+			return ret;
 	}
 
-	level = btrfs_compress_set_level(type, level);
-
-	return level;
+	*level_ret = btrfs_compress_set_level(type, level);
+	return 0;
 }
diff --git a/fs/btrfs/compression.h b/fs/btrfs/compression.h
index 760d4aac74e6..243771ae7d64 100644
--- a/fs/btrfs/compression.h
+++ b/fs/btrfs/compression.h
@@ -110,7 +110,7 @@ void btrfs_submit_compressed_write(struct btrfs_ordered_extent *ordered,
 				   bool writeback);
 void btrfs_submit_compressed_read(struct btrfs_bio *bbio);
 
-int btrfs_compress_str2level(unsigned int type, const char *str);
+int btrfs_compress_str2level(unsigned int type, const char *str, int *level_ret);
 
 struct folio *btrfs_alloc_compr_folio(void);
 void btrfs_free_compr_folio(struct folio *folio);
diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index b607c606fcfe..fb1e449ef26a 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -274,6 +274,7 @@ static int btrfs_parse_compress(struct btrfs_fs_context *ctx,
 				const struct fs_parameter *param, int opt)
 {
 	const char *string = param->string;
+	int ret;
 
 	/*
 	 * Provide the same semantics as older kernels that don't use fs
@@ -292,15 +293,19 @@ static int btrfs_parse_compress(struct btrfs_fs_context *ctx,
 		btrfs_clear_opt(ctx->mount_opt, NODATASUM);
 	} else if (btrfs_match_compress_type(string, "zlib", true)) {
 		ctx->compress_type = BTRFS_COMPRESS_ZLIB;
-		ctx->compress_level = btrfs_compress_str2level(BTRFS_COMPRESS_ZLIB,
-							       string + 4);
+		ret = btrfs_compress_str2level(BTRFS_COMPRESS_ZLIB, string + 4,
+					       &ctx->compress_level);
+		if (ret < 0)
+			goto error;
 		btrfs_set_opt(ctx->mount_opt, COMPRESS);
 		btrfs_clear_opt(ctx->mount_opt, NODATACOW);
 		btrfs_clear_opt(ctx->mount_opt, NODATASUM);
 	} else if (btrfs_match_compress_type(string, "lzo", true)) {
 		ctx->compress_type = BTRFS_COMPRESS_LZO;
-		ctx->compress_level = btrfs_compress_str2level(BTRFS_COMPRESS_LZO,
-							       string + 3);
+		ret = btrfs_compress_str2level(BTRFS_COMPRESS_LZO, string + 3,
+					       &ctx->compress_level);
+		if (ret < 0)
+			goto error;
 		if (string[3] == ':' && string[4])
 			btrfs_warn(NULL, "Compression level ignored for LZO");
 		btrfs_set_opt(ctx->mount_opt, COMPRESS);
@@ -308,8 +313,10 @@ static int btrfs_parse_compress(struct btrfs_fs_context *ctx,
 		btrfs_clear_opt(ctx->mount_opt, NODATASUM);
 	} else if (btrfs_match_compress_type(string, "zstd", true)) {
 		ctx->compress_type = BTRFS_COMPRESS_ZSTD;
-		ctx->compress_level = btrfs_compress_str2level(BTRFS_COMPRESS_ZSTD,
-							       string + 4);
+		ret = btrfs_compress_str2level(BTRFS_COMPRESS_ZSTD, string + 4,
+					       &ctx->compress_level);
+		if (ret < 0)
+			goto error;
 		btrfs_set_opt(ctx->mount_opt, COMPRESS);
 		btrfs_clear_opt(ctx->mount_opt, NODATACOW);
 		btrfs_clear_opt(ctx->mount_opt, NODATASUM);
@@ -320,10 +327,14 @@ static int btrfs_parse_compress(struct btrfs_fs_context *ctx,
 		btrfs_clear_opt(ctx->mount_opt, COMPRESS);
 		btrfs_clear_opt(ctx->mount_opt, FORCE_COMPRESS);
 	} else {
-		btrfs_err(NULL, "unrecognized compression value %s", string);
-		return -EINVAL;
+		ret = -EINVAL;
+		goto error;
 	}
 	return 0;
+error:
+	btrfs_err(NULL, "failed to parse compression option '%s': %d", string, ret);
+	return ret;
+
 }
 
 static int btrfs_parse_param(struct fs_context *fc, struct fs_parameter *param)
-- 
2.50.1


