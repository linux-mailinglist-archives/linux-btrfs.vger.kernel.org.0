Return-Path: <linux-btrfs+bounces-13295-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CF5FFA98AE0
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Apr 2025 15:25:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EEDCA5A14E4
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Apr 2025 13:24:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9071519047C;
	Wed, 23 Apr 2025 13:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="WYz23Fj6";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="WYz23Fj6"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 847EB1ACEB7
	for <linux-btrfs@vger.kernel.org>; Wed, 23 Apr 2025 13:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745414555; cv=none; b=Q0gHxO2JWul1XwboXUSeAW26C2uzt0L5yYsX41zFRLAxxyttsBSCt4vMIvgM/8q6D64wwInPTMeJy5MvLDpFskTJmEJze3eBllRoDzBCgAfgLyB+OD1lqWnA8Z8ke1AkXbmBMEvhXmYPnL5OysGdd+maHoX9WGv//HvJFcOd9/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745414555; c=relaxed/simple;
	bh=2fSGqfGe9QF0hCkGFRwBT0+5mcM+4uAzRmVq171CGlg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M+F8BvVvXRw5tXB+ndHLxuK31mNs68Q1NAm2X/cqqDeZU9jRg+0QgwRwBcKGywcaux3Z0VQgl2n6UBE8R+ywxyBfKeuHMrZMKyjTA0JrBD/57cvvGbrc2q3VIEv7BMDZxzSsGzIVvR/PZTNCGGbnDQNP4V3j5cyMOrJY0REvRwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=WYz23Fj6; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=WYz23Fj6; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 8312E1F441;
	Wed, 23 Apr 2025 13:22:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1745414550; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sbm+i1YS9B9TwaPdJxxSVF9m6Ca6BSDgVpX6BzZzH4E=;
	b=WYz23Fj6yBwM4ukDzfxvaRNJM6mI/ZA6pFm8VFNRtmk9ff48jVvbW/iXqKJPd5DHx1EeV8
	vaafql/+9gIT5jmqwkBrf+zlQ29KXkWmafiB7WPDTryaT1w08eLEOmJ9LRnJFy8xHxlYkq
	nh4YjZeEPrtaYCZjCVim8XVmpEiKsaw=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=WYz23Fj6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1745414550; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sbm+i1YS9B9TwaPdJxxSVF9m6Ca6BSDgVpX6BzZzH4E=;
	b=WYz23Fj6yBwM4ukDzfxvaRNJM6mI/ZA6pFm8VFNRtmk9ff48jVvbW/iXqKJPd5DHx1EeV8
	vaafql/+9gIT5jmqwkBrf+zlQ29KXkWmafiB7WPDTryaT1w08eLEOmJ9LRnJFy8xHxlYkq
	nh4YjZeEPrtaYCZjCVim8XVmpEiKsaw=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 619CE13A3D;
	Wed, 23 Apr 2025 13:22:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id RO7qFpbpCGhRWAAAD6G6ig
	(envelope-from <neelx@suse.com>); Wed, 23 Apr 2025 13:22:30 +0000
From: Daniel Vacek <neelx@suse.com>
To: Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>,
	Nick Terrell <terrelln@fb.com>
Cc: Daniel Vacek <neelx@suse.com>,
	linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] btrfs: harden parsing of compress mount option
Date: Wed, 23 Apr 2025 15:22:19 +0200
Message-ID: <20250423132220.4052042-1-neelx@suse.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250423073329.4021878-1-neelx@suse.com>
References: <20250423073329.4021878-1-neelx@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 8312E1F441
X-Spam-Level: 
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_TWO(0.00)[2];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:dkim,suse.com:mid,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DKIM_TRACE(0.00)[suse.com:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01
X-Spam-Flag: NO

Btrfs happily but incorrectly accepts the `-o compress=zlib+foo` and similar
options with any random suffix. Let's handle that correctly.

Signed-off-by: Daniel Vacek <neelx@suse.com>
---
v2: Drop useless check for comma and split compress options
    into a separate helper function

 fs/btrfs/super.c | 108 +++++++++++++++++++++++++++--------------------
 1 file changed, 62 insertions(+), 46 deletions(-)

diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 40709e2a44fce..422fb82279877 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -270,6 +270,67 @@ static inline blk_mode_t btrfs_open_mode(struct fs_context *fc)
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
+	} else if (strncmp(param->string, "zlib", 4) == 0 &&
+			(param->string[4] == ':' ||
+			 param->string[4] == '\0')) {
+		ctx->compress_type = BTRFS_COMPRESS_ZLIB;
+		ctx->compress_level =
+			btrfs_compress_str2level(BTRFS_COMPRESS_ZLIB,
+						 param->string + 4);
+		btrfs_set_opt(ctx->mount_opt, COMPRESS);
+		btrfs_clear_opt(ctx->mount_opt, NODATACOW);
+		btrfs_clear_opt(ctx->mount_opt, NODATASUM);
+	} else if (strncmp(param->string, "lzo", 3) == 0 &&
+			param->string[3] == '\0') {
+		ctx->compress_type = BTRFS_COMPRESS_LZO;
+		ctx->compress_level = 0;
+		btrfs_set_opt(ctx->mount_opt, COMPRESS);
+		btrfs_clear_opt(ctx->mount_opt, NODATACOW);
+		btrfs_clear_opt(ctx->mount_opt, NODATASUM);
+	} else if (strncmp(param->string, "zstd", 4) == 0 &&
+			(param->string[4] == ':' ||
+			 param->string[4] == '\0')) {
+		ctx->compress_type = BTRFS_COMPRESS_ZSTD;
+		ctx->compress_level =
+			btrfs_compress_str2level(BTRFS_COMPRESS_ZSTD,
+						 param->string + 4);
+		btrfs_set_opt(ctx->mount_opt, COMPRESS);
+		btrfs_clear_opt(ctx->mount_opt, NODATACOW);
+		btrfs_clear_opt(ctx->mount_opt, NODATASUM);
+	} else if ((strncmp(param->string, "no", 2) == 0 &&
+			param->string[2] == '\0') ||
+		   (strncmp(param->string, "none", 4) == 0 &&
+			param->string[4] == '\0')) {
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
@@ -339,53 +400,8 @@ static int btrfs_parse_param(struct fs_context *fc, struct fs_parameter *param)
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


