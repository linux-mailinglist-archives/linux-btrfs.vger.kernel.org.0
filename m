Return-Path: <linux-btrfs+bounces-13279-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 090DCA98120
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Apr 2025 09:35:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0782C3AF3EC
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Apr 2025 07:35:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B57A926A0F5;
	Wed, 23 Apr 2025 07:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="q/ICmLTV";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="rCZbeK0J"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3394626A0E0
	for <linux-btrfs@vger.kernel.org>; Wed, 23 Apr 2025 07:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745393627; cv=none; b=EzVE4avrNW/HeFQsjkBLG8lbBXHWSn1VbmwA0P3/E9K0koNYnqRJJthvK4oQnmjKZWWZ0KV+xWDzKDDgkAUuUeK/Sj02mzBA4aVR0mj5VbIJvZcB8zCqjf+TH3yeUxeoX0h0zvBY7jko4PPQxO3xBgEOWWqGzP/z4brXKHB6yZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745393627; c=relaxed/simple;
	bh=Augew+xurSegCFml6VSK21zefqwYHpB7BhwgmBRz01Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qXclFoSMgCYd3vz53BrLfpciFLoTwJMQdS/lPkIPnma/35Sa4IFedfRbQiq8gA9iFiLAMRykgLZ9oekSszEo9cMzwzdbaSGLi8PighnuB7PX2vYPMxMPqbB9+Bg+OCGqaqxN65niJYlJvNFqQ+I0DfXoRGa7htGDCNZG/ur56Ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=q/ICmLTV; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=rCZbeK0J; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 6028C2119D;
	Wed, 23 Apr 2025 07:33:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1745393623; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=nQh3sVk6hHuf+1A7cSdshesABfGZol2XdId2OmOhvfI=;
	b=q/ICmLTVwesUnmdUyrVzK7lT8csXzlyQgpK5V7YT3ZGiny+CHIcycD2g/hKUYgZuAKAMiK
	MPOGiZ0yFE6rSnSu0Oux//gfSNCncj/m7WytZOFMClAC+hUnSO69Hj7en43EbVt2pyALAX
	jlHRQtfgJlaTok+n6PWH73oBrj5QWL0=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=rCZbeK0J
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1745393622; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=nQh3sVk6hHuf+1A7cSdshesABfGZol2XdId2OmOhvfI=;
	b=rCZbeK0JDHFdKPxnBI38Y7a0LZYweshOm9r+fqg4s3qli7FvW77R9VhuUOaqgYdR1d3+pe
	i+g7wH50d114Rb7cc2dbrsjxHDcPZ/PjLVMhLlHNH98LYPygyqZANpXLfVYFoDcoOZGbFS
	4/F1Kz3BiuOHtmjEBC0vJdt/72oxlBs=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 44F4E13A3D;
	Wed, 23 Apr 2025 07:33:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id nLg9ENaXCGhfZwAAD6G6ig
	(envelope-from <neelx@suse.com>); Wed, 23 Apr 2025 07:33:42 +0000
From: Daniel Vacek <neelx@suse.com>
To: Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>,
	Nick Terrell <terrelln@fb.com>
Cc: Daniel Vacek <neelx@suse.com>,
	linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] btrfs: harden parsing of compress mount option
Date: Wed, 23 Apr 2025 09:33:28 +0200
Message-ID: <20250423073329.4021878-1-neelx@suse.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 6028C2119D
X-Spam-Score: -3.01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCPT_COUNT_SEVEN(0.00)[7];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:mid,suse.com:email]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

Btrfs happily but incorrectly accepts the `-o compress=zlib+foo` and similar
options with any random suffix. Let's handle that correctly.

Signed-off-by: Daniel Vacek <neelx@suse.com>
---
 fs/btrfs/super.c | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 40709e2a44fce..f7e064b8c6d88 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -354,7 +354,10 @@ static int btrfs_parse_param(struct fs_context *fc, struct fs_parameter *param)
 			btrfs_set_opt(ctx->mount_opt, COMPRESS);
 			btrfs_clear_opt(ctx->mount_opt, NODATACOW);
 			btrfs_clear_opt(ctx->mount_opt, NODATASUM);
-		} else if (strncmp(param->string, "zlib", 4) == 0) {
+		} else if (strncmp(param->string, "zlib", 4) == 0 &&
+				(param->string[4] == ':' ||
+				 param->string[4] == ',' ||
+				 param->string[4] == '\0')) {
 			ctx->compress_type = BTRFS_COMPRESS_ZLIB;
 			ctx->compress_level =
 				btrfs_compress_str2level(BTRFS_COMPRESS_ZLIB,
@@ -362,13 +365,18 @@ static int btrfs_parse_param(struct fs_context *fc, struct fs_parameter *param)
 			btrfs_set_opt(ctx->mount_opt, COMPRESS);
 			btrfs_clear_opt(ctx->mount_opt, NODATACOW);
 			btrfs_clear_opt(ctx->mount_opt, NODATASUM);
-		} else if (strncmp(param->string, "lzo", 3) == 0) {
+		} else if (strncmp(param->string, "lzo", 3) == 0 &&
+				(param->string[3] == ',' ||
+				 param->string[3] == '\0')) {
 			ctx->compress_type = BTRFS_COMPRESS_LZO;
 			ctx->compress_level = 0;
 			btrfs_set_opt(ctx->mount_opt, COMPRESS);
 			btrfs_clear_opt(ctx->mount_opt, NODATACOW);
 			btrfs_clear_opt(ctx->mount_opt, NODATASUM);
-		} else if (strncmp(param->string, "zstd", 4) == 0) {
+		} else if (strncmp(param->string, "zstd", 4) == 0 &&
+				(param->string[4] == ':' ||
+				 param->string[4] == ',' ||
+				 param->string[4] == '\0')) {
 			ctx->compress_type = BTRFS_COMPRESS_ZSTD;
 			ctx->compress_level =
 				btrfs_compress_str2level(BTRFS_COMPRESS_ZSTD,
@@ -376,7 +384,12 @@ static int btrfs_parse_param(struct fs_context *fc, struct fs_parameter *param)
 			btrfs_set_opt(ctx->mount_opt, COMPRESS);
 			btrfs_clear_opt(ctx->mount_opt, NODATACOW);
 			btrfs_clear_opt(ctx->mount_opt, NODATASUM);
-		} else if (strncmp(param->string, "no", 2) == 0) {
+		} else if ((strncmp(param->string, "no", 2) == 0 &&
+				(param->string[2] == ',' ||
+				 param->string[2] == '\0')) ||
+			   (strncmp(param->string, "none", 4) == 0 &&
+				(param->string[4] == ',' ||
+				 param->string[4] == '\0'))) {
 			ctx->compress_level = 0;
 			ctx->compress_type = 0;
 			btrfs_clear_opt(ctx->mount_opt, COMPRESS);
-- 
2.47.2


