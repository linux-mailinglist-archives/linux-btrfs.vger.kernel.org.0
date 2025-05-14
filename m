Return-Path: <linux-btrfs+bounces-13990-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 628C7AB614C
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 May 2025 05:41:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB4A116B2B3
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 May 2025 03:41:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCAA31E9B16;
	Wed, 14 May 2025 03:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="dVysukVz";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="OPRE4QXm"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 057CE61FF2
	for <linux-btrfs@vger.kernel.org>; Wed, 14 May 2025 03:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747194090; cv=none; b=ktEr1NjhUruMwlJIL+q3ejcQUB/S6qCcvrssfD2/Ly1dNjdARTbZ9gsOIg/ijTXnj0pT/1QorDWnpcrTUWuo+ZBACfQDZ/XSmOcrPoKLJCjujNkwqhvcCmMX12QYM3J6bhFCxsKwhe65MM5Tx/zcd/ZQfxQ4FkKYcUOsCJYmWL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747194090; c=relaxed/simple;
	bh=NSJDEe4GVHz/5lD/y8zau9DI3rHTyfGRy4Fhk6KrOYA=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=LwuTLDEqL5WrC5SyoSU1z4nTSLnotuMepQ6X5ZP0cOWRGY1NMaLnFpsLAANwUDrSJwhrvD0bUZAkPFSVMVZt6jRqsIsAqJtIAiFMvFTMI7Av3oH2uvZDI0P7gFzfGBEB0CAWqVp76HdxINR5WlA6NVv6OT0EcgJTeO8fXOh1sy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=dVysukVz; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=OPRE4QXm; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E564621221
	for <linux-btrfs@vger.kernel.org>; Wed, 14 May 2025 03:41:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1747194086; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=eg3McImrZvfBCUqx+IN8C/hxh1bEQ/0lPQd0vAC5eiQ=;
	b=dVysukVzZGD4o8QlK3TNBUiw2x8KicD+9iWq9ioYru37Bj7dw4CxkjI+pB4lJEcVh3+yRi
	xMCgruXAZ+M/hwQyMYarkG0GXTHVcUQZkBB1iEG991mWAWMlBGmzsj2c9r/oqkU7j8NuCE
	HpVPe3zjIRw5JDFNqbcDzIEESPI8q80=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=OPRE4QXm
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1747194085; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=eg3McImrZvfBCUqx+IN8C/hxh1bEQ/0lPQd0vAC5eiQ=;
	b=OPRE4QXmTs/1FYF8FATtZ/jDRMWHVP4K68qakO9RHc8AzjWzj+2cQQgbwkHyis72ulpFK3
	PLTbe86REW9AbTu0yNIak0emmJfd53+WdU1WvnJjUhzaTp2mueXsK2onitDA3x0C6lZwtQ
	2nP2q/lk2amAi/YZ24vyath1+B48lF8=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 32A2B1397F
	for <linux-btrfs@vger.kernel.org>; Wed, 14 May 2025 03:41:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 2yHVOeQQJGgfRAAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Wed, 14 May 2025 03:41:24 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: remove standalone "nologreplay" mount option
Date: Wed, 14 May 2025 13:11:03 +0930
Message-ID: <dd6b4aadc3f5ed0eb1d86795c1822d26b2eb02fc.1747194062.git.wqu@suse.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: E564621221
X-Spam-Flag: NO
X-Spam-Score: -3.01
X-Spam-Level: 
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:email,suse.com:dkim,suse.com:mid];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[suse.com:+]
X-Rspamd-Action: no action

Standalone "nologreplay" mount option is marked deprecated since commit
74ef00185eb8 ("btrfs: introduce "rescue=" mount option"), which dates
back to v5.9.

Furthermore there is no other filesystem with the same named mount
option, so this one is btrfs specific and we will not hit the same
problem when removing "norecovery" mount option.

So let's remove the standalone "nologreplay" mount option.c.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/super.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 86d640c5f75b..cfc86bcc1b2a 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -125,7 +125,6 @@ enum {
 	/* Rescue options */
 	Opt_rescue,
 	Opt_usebackuproot,
-	Opt_nologreplay,
 
 	/* Debugging options */
 	Opt_enospc_debug,
@@ -246,8 +245,6 @@ static const struct fs_parameter_spec btrfs_fs_parameters[] = {
 
 	/* Rescue options. */
 	fsparam_enum("rescue", Opt_rescue, btrfs_parameter_rescue),
-	/* Deprecated, with alias rescue=nologreplay */
-	__fsparam(NULL, "nologreplay", Opt_nologreplay, fs_param_deprecated, NULL),
 	/* Deprecated, with alias rescue=usebackuproot */
 	__fsparam(NULL, "usebackuproot", Opt_usebackuproot, fs_param_deprecated, NULL),
 	/* For compatibility only, alias for "rescue=nologreplay". */
@@ -449,11 +446,6 @@ static int btrfs_parse_param(struct fs_context *fc, struct fs_parameter *param)
 		else
 			btrfs_clear_opt(ctx->mount_opt, NOTREELOG);
 		break;
-	case Opt_nologreplay:
-		btrfs_warn(NULL,
-		"'nologreplay' is deprecated, use 'rescue=nologreplay' instead");
-		btrfs_set_opt(ctx->mount_opt, NOLOGREPLAY);
-		break;
 	case Opt_norecovery:
 		btrfs_info(NULL,
 "'norecovery' is for compatibility only, recommended to use 'rescue=nologreplay'");
-- 
2.49.0


