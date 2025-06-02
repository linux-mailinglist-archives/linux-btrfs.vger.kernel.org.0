Return-Path: <linux-btrfs+bounces-14382-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 78DD1ACB924
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Jun 2025 17:59:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 629763B84A4
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Jun 2025 15:53:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 595EE223715;
	Mon,  2 Jun 2025 15:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="PrUGxjSS";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="PrUGxjSS"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8CBC221727
	for <linux-btrfs@vger.kernel.org>; Mon,  2 Jun 2025 15:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748879612; cv=none; b=aWVr7oYUpzCvr39NpZ7yMyFdZLe6JzlHMpe6CYC/Y0HQ4XPy5Rqx6Q3qAUs0VfMAerJ3/yqNlEbvPhfigc1PdrdYMH3zLbqAOrWlleQuOA1xqmPQsgXRKnNn/nI7kKPIJySZs2pwm9b+K3iPX/3lCcx18iEh87MNMSqWMKxWhDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748879612; c=relaxed/simple;
	bh=SZ8DWS3QDMg8FLMxfjBixbAuwkv6b7i5A/YU2QXRU2g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K14QFK2/LfMiYm2RaL5EvOzXW24MqzSCacgsz/dCho9/upTi+NH5aQejlos+wFnhjxzfaOE65uncPsBTzzFLXCNsoYGVdnTsxK7tAlS0JdhprBb8E3lJCKW+PJVJfxmGdDWkE8wczGXgEU4JSTiU3S6KXdcjMLwmA2PISB6u6a0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=PrUGxjSS; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=PrUGxjSS; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D46E12120C;
	Mon,  2 Jun 2025 15:53:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1748879602; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6nyjPt297duvLpbWem1nV6wBQV97SYHuvo6JAt3GfO8=;
	b=PrUGxjSSfPNWIMRfrNrO3aFJskmZIlLUvT5T3dMz7FRSFfJ87kN8QJ2kPuaCPpv3xI7xVo
	WnU5Uq3wG+vEd7Yr3HJvlaubbb91qaqaQOj37z1gdM7JiTRpwaRdLAQhu3T5bpH/+bD4iU
	i2NW1tcAGxqEOA5TqpYfFFVJ9l8S1cM=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1748879602; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6nyjPt297duvLpbWem1nV6wBQV97SYHuvo6JAt3GfO8=;
	b=PrUGxjSSfPNWIMRfrNrO3aFJskmZIlLUvT5T3dMz7FRSFfJ87kN8QJ2kPuaCPpv3xI7xVo
	WnU5Uq3wG+vEd7Yr3HJvlaubbb91qaqaQOj37z1gdM7JiTRpwaRdLAQhu3T5bpH/+bD4iU
	i2NW1tcAGxqEOA5TqpYfFFVJ9l8S1cM=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B9DC113A63;
	Mon,  2 Jun 2025 15:53:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id MAOCLPLIPWhIBQAAD6G6ig
	(envelope-from <neelx@suse.com>); Mon, 02 Jun 2025 15:53:22 +0000
From: Daniel Vacek <neelx@suse.com>
To: Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>,
	Nick Terrell <terrelln@fb.com>
Cc: linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Daniel Vacek <neelx@suse.com>
Subject: [PATCH v3 1/2] btrfs: factor out compress mount options parsing
Date: Mon,  2 Jun 2025 17:53:18 +0200
Message-ID: <20250602155320.1854888-2-neelx@suse.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250602155320.1854888-1-neelx@suse.com>
References: <20250602155320.1854888-1-neelx@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -6.80
X-Spamd-Result: default: False [-6.80 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Level: 

There are many options making the parsing a bit lenghty.
Factor the compress options out into a helper function.
The next patch is going to harden this function.

Signed-off-by: Daniel Vacek <neelx@suse.com>
---
v3 changes: Split into two patches to ease backporting,
            no functional changes.

 fs/btrfs/super.c | 100 +++++++++++++++++++++++++----------------------
 1 file changed, 54 insertions(+), 46 deletions(-)

diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 40709e2a44fce..6291ab45ab2a5 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -270,6 +270,59 @@ static inline blk_mode_t btrfs_open_mode(struct fs_context *fc)
 	return sb_open_mode(fc->sb_flags) & ~BLK_OPEN_RESTRICT_WRITES;
 }
 
+static int btrfs_parse_compress(struct btrfs_fs_context *ctx,
+				struct fs_parameter *param, int opt)
+{
+	/*
+	 * Provide the same semantics as older kernels that don't use fs
+	 * context, specifying the "compress" option clears
+	 * "force-compress" without the need to pass
+	 * "compress-force=[no|none]" before specifying "compress".
+	 */
+	if (opt != Opt_compress_force && opt != Opt_compress_force_type)
+		btrfs_clear_opt(ctx->mount_opt, FORCE_COMPRESS);
+
+	if (opt == Opt_compress || opt == Opt_compress_force) {
+		ctx->compress_type = BTRFS_COMPRESS_ZLIB;
+		ctx->compress_level = BTRFS_ZLIB_DEFAULT_LEVEL;
+		btrfs_set_opt(ctx->mount_opt, COMPRESS);
+		btrfs_clear_opt(ctx->mount_opt, NODATACOW);
+		btrfs_clear_opt(ctx->mount_opt, NODATASUM);
+	} else if (strncmp(param->string, "zlib", 4) == 0) {
+		ctx->compress_type = BTRFS_COMPRESS_ZLIB;
+		ctx->compress_level =
+			btrfs_compress_str2level(BTRFS_COMPRESS_ZLIB,
+						 param->string + 4);
+		btrfs_set_opt(ctx->mount_opt, COMPRESS);
+		btrfs_clear_opt(ctx->mount_opt, NODATACOW);
+		btrfs_clear_opt(ctx->mount_opt, NODATASUM);
+	} else if (strncmp(param->string, "lzo", 3) == 0) {
+		ctx->compress_type = BTRFS_COMPRESS_LZO;
+		ctx->compress_level = 0;
+		btrfs_set_opt(ctx->mount_opt, COMPRESS);
+		btrfs_clear_opt(ctx->mount_opt, NODATACOW);
+		btrfs_clear_opt(ctx->mount_opt, NODATASUM);
+	} else if (strncmp(param->string, "zstd", 4) == 0) {
+		ctx->compress_type = BTRFS_COMPRESS_ZSTD;
+		ctx->compress_level =
+			btrfs_compress_str2level(BTRFS_COMPRESS_ZSTD,
+						 param->string + 4);
+		btrfs_set_opt(ctx->mount_opt, COMPRESS);
+		btrfs_clear_opt(ctx->mount_opt, NODATACOW);
+		btrfs_clear_opt(ctx->mount_opt, NODATASUM);
+	} else if (strncmp(param->string, "no", 2) == 0) {
+		ctx->compress_level = 0;
+		ctx->compress_type = 0;
+		btrfs_clear_opt(ctx->mount_opt, COMPRESS);
+		btrfs_clear_opt(ctx->mount_opt, FORCE_COMPRESS);
+	} else {
+		btrfs_err(NULL, "unrecognized compression value %s",
+			  param->string);
+		return -EINVAL;
+	}
+	return 0;
+}
+
 static int btrfs_parse_param(struct fs_context *fc, struct fs_parameter *param)
 {
 	struct btrfs_fs_context *ctx = fc->fs_private;
@@ -339,53 +392,8 @@ static int btrfs_parse_param(struct fs_context *fc, struct fs_parameter *param)
 		fallthrough;
 	case Opt_compress:
 	case Opt_compress_type:
-		/*
-		 * Provide the same semantics as older kernels that don't use fs
-		 * context, specifying the "compress" option clears
-		 * "force-compress" without the need to pass
-		 * "compress-force=[no|none]" before specifying "compress".
-		 */
-		if (opt != Opt_compress_force && opt != Opt_compress_force_type)
-			btrfs_clear_opt(ctx->mount_opt, FORCE_COMPRESS);
-
-		if (opt == Opt_compress || opt == Opt_compress_force) {
-			ctx->compress_type = BTRFS_COMPRESS_ZLIB;
-			ctx->compress_level = BTRFS_ZLIB_DEFAULT_LEVEL;
-			btrfs_set_opt(ctx->mount_opt, COMPRESS);
-			btrfs_clear_opt(ctx->mount_opt, NODATACOW);
-			btrfs_clear_opt(ctx->mount_opt, NODATASUM);
-		} else if (strncmp(param->string, "zlib", 4) == 0) {
-			ctx->compress_type = BTRFS_COMPRESS_ZLIB;
-			ctx->compress_level =
-				btrfs_compress_str2level(BTRFS_COMPRESS_ZLIB,
-							 param->string + 4);
-			btrfs_set_opt(ctx->mount_opt, COMPRESS);
-			btrfs_clear_opt(ctx->mount_opt, NODATACOW);
-			btrfs_clear_opt(ctx->mount_opt, NODATASUM);
-		} else if (strncmp(param->string, "lzo", 3) == 0) {
-			ctx->compress_type = BTRFS_COMPRESS_LZO;
-			ctx->compress_level = 0;
-			btrfs_set_opt(ctx->mount_opt, COMPRESS);
-			btrfs_clear_opt(ctx->mount_opt, NODATACOW);
-			btrfs_clear_opt(ctx->mount_opt, NODATASUM);
-		} else if (strncmp(param->string, "zstd", 4) == 0) {
-			ctx->compress_type = BTRFS_COMPRESS_ZSTD;
-			ctx->compress_level =
-				btrfs_compress_str2level(BTRFS_COMPRESS_ZSTD,
-							 param->string + 4);
-			btrfs_set_opt(ctx->mount_opt, COMPRESS);
-			btrfs_clear_opt(ctx->mount_opt, NODATACOW);
-			btrfs_clear_opt(ctx->mount_opt, NODATASUM);
-		} else if (strncmp(param->string, "no", 2) == 0) {
-			ctx->compress_level = 0;
-			ctx->compress_type = 0;
-			btrfs_clear_opt(ctx->mount_opt, COMPRESS);
-			btrfs_clear_opt(ctx->mount_opt, FORCE_COMPRESS);
-		} else {
-			btrfs_err(NULL, "unrecognized compression value %s",
-				  param->string);
+		if (btrfs_parse_compress(ctx, param, opt))
 			return -EINVAL;
-		}
 		break;
 	case Opt_ssd:
 		if (result.negated) {
-- 
2.47.2


