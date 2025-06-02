Return-Path: <linux-btrfs+bounces-14383-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1C43ACB906
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Jun 2025 17:54:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AE4867A55B4
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Jun 2025 15:52:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E709223DF6;
	Mon,  2 Jun 2025 15:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="qfVgSCGj";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="qfVgSCGj"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 025F3223DD1
	for <linux-btrfs@vger.kernel.org>; Mon,  2 Jun 2025 15:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748879618; cv=none; b=VrspOCemXt0PLxesKK/WJOF078B2ii0REVOHLx5ghx+5qIfyKDAVRupAp8xHnTv5N7wsLUlJflnHZRSe+8zknVv98Zq/Mn4W+dGAwlmkPgw5a2Vu1HexIMNe230ClcOKlxz98X/lz9oqeBHkpZgvxblYdtLNeGNd1ebEEfcj/cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748879618; c=relaxed/simple;
	bh=go1PPFz+AMC/M5zXK7Is9Mi6bbDhxdFN6LXeNEBwDLs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X/1JlaTMbcIqLowMug2nkyagAvw1JzjySE5TSvDW9gfuIp86qi3TFsuErr2nvGJQISkdROMqv0BR65o92F1q30uUXjRnEN2q7H4XZHewKABSfGD4dOxSxBxAbDX9X3IUqpBpgf5+cBkHDemK/QsRZ9weEcIQUsZsC3gCVYyjRpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=qfVgSCGj; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=qfVgSCGj; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 494D22120E;
	Mon,  2 Jun 2025 15:53:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1748879603; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QWkGADfqpetKnnKrUkvD8J/JBZ9PJNS7K0KKvu/tSqU=;
	b=qfVgSCGjjop2VBVuGiaPUPGkJ6lG5Z22jYedW+2/NljDiwUvWWCIk9wvnOGvex5LWmAixP
	0Hf34TDX71FO+JxkOxmi+3h0efZwl4DTSUYT9+oXhbbmZjxKCcHqh2Q1KvtpkGUzsm4R7M
	9eSx05DvlzSGVdptBRnhQxyF0tM4MOE=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1748879603; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QWkGADfqpetKnnKrUkvD8J/JBZ9PJNS7K0KKvu/tSqU=;
	b=qfVgSCGjjop2VBVuGiaPUPGkJ6lG5Z22jYedW+2/NljDiwUvWWCIk9wvnOGvex5LWmAixP
	0Hf34TDX71FO+JxkOxmi+3h0efZwl4DTSUYT9+oXhbbmZjxKCcHqh2Q1KvtpkGUzsm4R7M
	9eSx05DvlzSGVdptBRnhQxyF0tM4MOE=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2E98113A63;
	Mon,  2 Jun 2025 15:53:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id IB7GCvPIPWhIBQAAD6G6ig
	(envelope-from <neelx@suse.com>); Mon, 02 Jun 2025 15:53:23 +0000
From: Daniel Vacek <neelx@suse.com>
To: Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>,
	Nick Terrell <terrelln@fb.com>
Cc: linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Daniel Vacek <neelx@suse.com>
Subject: [PATCH v3 2/2] btrfs: harden parsing of compress mount options
Date: Mon,  2 Jun 2025 17:53:19 +0200
Message-ID: <20250602155320.1854888-3-neelx@suse.com>
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
X-Spam-Flag: NO
X-Spam-Score: -6.80

Btrfs happily but incorrectly accepts the `-o compress=zlib+foo` and similar
options with any random suffix.

Fix that by explicitly checking the end of the strings.

Signed-off-by: Daniel Vacek <neelx@suse.com>
---
v3 changes: Split into two patches to ease backporting,
            no functional changes.

 fs/btrfs/super.c | 26 +++++++++++++++++++-------
 1 file changed, 19 insertions(+), 7 deletions(-)

diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 6291ab45ab2a5..4510c5f7a785e 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -270,9 +270,20 @@ static inline blk_mode_t btrfs_open_mode(struct fs_context *fc)
 	return sb_open_mode(fc->sb_flags) & ~BLK_OPEN_RESTRICT_WRITES;
 }
 
+static bool btrfs_match_compress_type(char *string, char *type, bool may_have_level)
+{
+	int len = strlen(type);
+
+	return strncmp(string, type, len) == 0 &&
+		((may_have_level && string[len] == ':') ||
+				    string[len] == '\0');
+}
+
 static int btrfs_parse_compress(struct btrfs_fs_context *ctx,
 				struct fs_parameter *param, int opt)
 {
+	char *string = param->string;
+
 	/*
 	 * Provide the same semantics as older kernels that don't use fs
 	 * context, specifying the "compress" option clears
@@ -288,36 +299,37 @@ static int btrfs_parse_compress(struct btrfs_fs_context *ctx,
 		btrfs_set_opt(ctx->mount_opt, COMPRESS);
 		btrfs_clear_opt(ctx->mount_opt, NODATACOW);
 		btrfs_clear_opt(ctx->mount_opt, NODATASUM);
-	} else if (strncmp(param->string, "zlib", 4) == 0) {
+	} else if (btrfs_match_compress_type(string, "zlib", true)) {
 		ctx->compress_type = BTRFS_COMPRESS_ZLIB;
 		ctx->compress_level =
 			btrfs_compress_str2level(BTRFS_COMPRESS_ZLIB,
-						 param->string + 4);
+						 string + 4);
 		btrfs_set_opt(ctx->mount_opt, COMPRESS);
 		btrfs_clear_opt(ctx->mount_opt, NODATACOW);
 		btrfs_clear_opt(ctx->mount_opt, NODATASUM);
-	} else if (strncmp(param->string, "lzo", 3) == 0) {
+	} else if (btrfs_match_compress_type(string, "lzo", false)) {
 		ctx->compress_type = BTRFS_COMPRESS_LZO;
 		ctx->compress_level = 0;
 		btrfs_set_opt(ctx->mount_opt, COMPRESS);
 		btrfs_clear_opt(ctx->mount_opt, NODATACOW);
 		btrfs_clear_opt(ctx->mount_opt, NODATASUM);
-	} else if (strncmp(param->string, "zstd", 4) == 0) {
+	} else if (btrfs_match_compress_type(string, "zstd", true)) {
 		ctx->compress_type = BTRFS_COMPRESS_ZSTD;
 		ctx->compress_level =
 			btrfs_compress_str2level(BTRFS_COMPRESS_ZSTD,
-						 param->string + 4);
+						 string + 4);
 		btrfs_set_opt(ctx->mount_opt, COMPRESS);
 		btrfs_clear_opt(ctx->mount_opt, NODATACOW);
 		btrfs_clear_opt(ctx->mount_opt, NODATASUM);
-	} else if (strncmp(param->string, "no", 2) == 0) {
+	} else if (btrfs_match_compress_type(string, "no", false) ||
+		   btrfs_match_compress_type(string, "none", false)) {
 		ctx->compress_level = 0;
 		ctx->compress_type = 0;
 		btrfs_clear_opt(ctx->mount_opt, COMPRESS);
 		btrfs_clear_opt(ctx->mount_opt, FORCE_COMPRESS);
 	} else {
 		btrfs_err(NULL, "unrecognized compression value %s",
-			  param->string);
+			  string);
 		return -EINVAL;
 	}
 	return 0;
-- 
2.47.2


