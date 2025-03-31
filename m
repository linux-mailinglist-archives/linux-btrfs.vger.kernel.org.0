Return-Path: <linux-btrfs+bounces-12681-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C247CA761AA
	for <lists+linux-btrfs@lfdr.de>; Mon, 31 Mar 2025 10:25:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2BC8A3A7FA8
	for <lists+linux-btrfs@lfdr.de>; Mon, 31 Mar 2025 08:25:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EA3C1DC98C;
	Mon, 31 Mar 2025 08:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="YPxQlua5";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="YPxQlua5"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 954FB1D8A0A
	for <linux-btrfs@vger.kernel.org>; Mon, 31 Mar 2025 08:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743409453; cv=none; b=AmNwuOhH0l52uZzN5BkhXJD3KODqo/byFWialGIhT4JSVILlfK2PsEaLP0udRPq4EQAVm966Hiizynn9a3o2rTDohlCFT18/TX/InIYjHJlKRDNN8rXfKsDeVPwujVOBiToIla7sOxd067JGxUhz3NrSYxWtMr9x9ABiDOcYQrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743409453; c=relaxed/simple;
	bh=M7wtuTQCfxk+2Ir3eEuB3u1i9IwUiZF8u71ymhhlSn4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sLR38nJT9FmcsL/yighW9lbbAaPl+jDVnAVCKE3Y5vqINh2Xlu9Cei0SHnPIsWdoC/LExpBNQFH1SxkOu/MYIo4yTrpAryv1TUc5g7KXsLP6CxYQ+DI6+YIXFcO7Thb6oMT5XDWhC9a3xw9RRvBEW0zNZBpo+4jXJWKRWXuN91w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=YPxQlua5; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=YPxQlua5; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 970CF1F38D;
	Mon, 31 Mar 2025 08:24:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1743409449; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=of4F53MvI3MwYC0W4LgWxfmyhWpzolPUajwOpDqYLPU=;
	b=YPxQlua5FJ9y/qq2oMb95LSy2L/HX7NQFw3QYiX6i89vKsDrBaPp+RlCg0aUktg4GiGjZl
	+lP+D+8kWswhXKE95h27nOy4Xq97SO7ZZ+ydk4lFDd/qmBhmFzA0p7km1rE1Fe0R8MYPVf
	Cpww8pm3BCrIxUcCbPuKqRdzMhx6QM8=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=YPxQlua5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1743409449; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=of4F53MvI3MwYC0W4LgWxfmyhWpzolPUajwOpDqYLPU=;
	b=YPxQlua5FJ9y/qq2oMb95LSy2L/HX7NQFw3QYiX6i89vKsDrBaPp+RlCg0aUktg4GiGjZl
	+lP+D+8kWswhXKE95h27nOy4Xq97SO7ZZ+ydk4lFDd/qmBhmFzA0p7km1rE1Fe0R8MYPVf
	Cpww8pm3BCrIxUcCbPuKqRdzMhx6QM8=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7D409139A1;
	Mon, 31 Mar 2025 08:24:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id wFIMHilR6mc0OwAAD6G6ig
	(envelope-from <neelx@suse.com>); Mon, 31 Mar 2025 08:24:09 +0000
From: Daniel Vacek <neelx@suse.com>
To: Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>,
	Nick Terrell <terrelln@fb.com>
Cc: Daniel Vacek <neelx@suse.com>,
	linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] btrfs: zstd: add `zstd-fast` alias mount option for fast modes
Date: Mon, 31 Mar 2025 10:23:46 +0200
Message-ID: <20250331082347.1407151-1-neelx@suse.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 970CF1F38D
X-Spam-Score: -3.01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:mid,suse.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCPT_COUNT_SEVEN(0.00)[7];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

Now that zstd fast compression levels are allowed with `compress=zstd:-N`
mount option, allow also specifying the same using the `compress=zstd-fast:N`
alias.

Upstream zstd deprecated the negative levels in favor of the `zstd-fast`
label anyways so this is actually the preferred way now. And indeed it also
looks more human friendly.

Signed-off-by: Daniel Vacek <neelx@suse.com>
---
 fs/btrfs/super.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 40709e2a44fce..c1bc8d4db440a 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -368,6 +368,16 @@ static int btrfs_parse_param(struct fs_context *fc, struct fs_parameter *param)
 			btrfs_set_opt(ctx->mount_opt, COMPRESS);
 			btrfs_clear_opt(ctx->mount_opt, NODATACOW);
 			btrfs_clear_opt(ctx->mount_opt, NODATASUM);
+		} else if (strncmp(param->string, "zstd-fast", 9) == 0) {
+			ctx->compress_type = BTRFS_COMPRESS_ZSTD;
+			ctx->compress_level =
+				-btrfs_compress_str2level(BTRFS_COMPRESS_ZSTD,
+							  param->string + 9);
+			if (ctx->compress_level > 0)
+				ctx->compress_level = -ctx->compress_level;
+			btrfs_set_opt(ctx->mount_opt, COMPRESS);
+			btrfs_clear_opt(ctx->mount_opt, NODATACOW);
+			btrfs_clear_opt(ctx->mount_opt, NODATASUM);
 		} else if (strncmp(param->string, "zstd", 4) == 0) {
 			ctx->compress_type = BTRFS_COMPRESS_ZSTD;
 			ctx->compress_level =
-- 
2.47.2


