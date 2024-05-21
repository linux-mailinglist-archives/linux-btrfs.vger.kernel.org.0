Return-Path: <linux-btrfs+bounces-5150-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 99F548CAB55
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 May 2024 11:57:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD4AC1C218A3
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 May 2024 09:57:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E55A16BB54;
	Tue, 21 May 2024 09:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="rUU7PaPC";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="rUU7PaPC"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3814561664;
	Tue, 21 May 2024 09:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716285461; cv=none; b=pUyrBfk5EKlBv63RMQLoEHJAtq9mNT3W5xKS6qQ95fOZx1J7BW0R5S4l4Kifwm3GLjr6yRasFMSMoWWH1428JJ9++QzZP8ACsuZOMHSsGFzRlfaGz3hf7auOcbJRo+DNdjV4xS2Ru+kgmV5/6osPshnoXKM5fOH62cWb8yP4bDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716285461; c=relaxed/simple;
	bh=Bas5WRjn0dclZkkBNUogHr028J1KhD4M8KnWvB9UP14=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=siqbsyta1J2xy6HCo40+YwA+i7VEVkTFVMYDJFhcMBJRlwOuWGSmgAGM1CYYFITV7WD8lYM0fkRbnXS8z+Yvi4XSwUWgGouqcqipBZy/lPEc3aCIstq7BvWn2nmLP3RrdlkZoWYXu0hB6KrRIDVa2vDrUkFmsqgYBPKx4bBBXg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=rUU7PaPC; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=rUU7PaPC; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 461E45C01F;
	Tue, 21 May 2024 09:57:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1716285457; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=nuLERO3cjCptDjETD65Hh/zsf1Qdit+nFyKeEqzY0YQ=;
	b=rUU7PaPCtVT6pruL/exnhNmJGYpHjApziGeOugdGqJ4oZJ1ALW5JTV5zrf7AAI95le9rF6
	k+hUYvK/3zGnhXIR4muMoi9+F0ZOYVcLFBPxmAJPWhxTnP2wEkxEQukyGdax06yKkJSemp
	iE9vc3ab6dL9T0kzQDYqlY5aFSOMIzU=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1716285457; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=nuLERO3cjCptDjETD65Hh/zsf1Qdit+nFyKeEqzY0YQ=;
	b=rUU7PaPCtVT6pruL/exnhNmJGYpHjApziGeOugdGqJ4oZJ1ALW5JTV5zrf7AAI95le9rF6
	k+hUYvK/3zGnhXIR4muMoi9+F0ZOYVcLFBPxmAJPWhxTnP2wEkxEQukyGdax06yKkJSemp
	iE9vc3ab6dL9T0kzQDYqlY5aFSOMIzU=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 66BD513A21;
	Tue, 21 May 2024 09:57:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id XF/wBg9wTGYiEgAAD6G6ig
	(envelope-from <wqu@suse.com>); Tue, 21 May 2024 09:57:35 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: Lennart Poettering <lennart@poettering.net>,
	Jiri Slaby <jslaby@suse.com>,
	stable@vger.kernel.org
Subject: [PATCH] btrfs: re-introduce 'norecovery' mount option
Date: Tue, 21 May 2024 19:27:31 +0930
Message-ID: <44c367eab0f3fbac9567f40da7b274f2125346f3.1716285322.git.wqu@suse.com>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -0.58
X-Spam-Level: 
X-Spamd-Result: default: False [-0.58 / 50.00];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	BAYES_HAM(-0.78)[84.53%];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:url,suse.com:email];
	RCVD_TLS_ALL(0.00)[]

Although 'norecovery' mount option is marked deprecated for a long time
and a warning message is introduced during the deprecation window, it's
still actively utilized by several projects that need a safely way to
mount a btrfs without any writes.

Furthermore this 'norecovery' mount option is supported by most major
filesystems, which makes it harder to validate our motivation.

This patch would re-introduce the 'norecovery' mount option, and output
a message to recommend 'rescue=nologreplay' option.

Link: https://lore.kernel.org/linux-btrfs/ZkxZT0J-z0GYvfy8@gardel-login/#t
Link: https://github.com/systemd/systemd/pull/32892
Link: https://bugzilla.suse.com/show_bug.cgi?id=1222429
Reported-by: Lennart Poettering <lennart@poettering.net>
Reported-by: Jiri Slaby <jslaby@suse.com>
Fixes: a1912f712188 ("btrfs: remove code for inode_cache and recovery mount options")
Cc: stable@vger.kernel.org # 6.8+
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/super.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 2dbc930a20f7..f05cce7c8b8d 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -119,6 +119,7 @@ enum {
 	Opt_thread_pool,
 	Opt_treelog,
 	Opt_user_subvol_rm_allowed,
+	Opt_norecovery,
 
 	/* Rescue options */
 	Opt_rescue,
@@ -245,6 +246,8 @@ static const struct fs_parameter_spec btrfs_fs_parameters[] = {
 	__fsparam(NULL, "nologreplay", Opt_nologreplay, fs_param_deprecated, NULL),
 	/* Deprecated, with alias rescue=usebackuproot */
 	__fsparam(NULL, "usebackuproot", Opt_usebackuproot, fs_param_deprecated, NULL),
+	/* For compatibility only, alias for "rescue=nologreplay". */
+	fsparam_flag("norecovery", Opt_norecovery),
 
 	/* Debugging options. */
 	fsparam_flag_no("enospc_debug", Opt_enospc_debug),
@@ -438,6 +441,11 @@ static int btrfs_parse_param(struct fs_context *fc, struct fs_parameter *param)
 		"'nologreplay' is deprecated, use 'rescue=nologreplay' instead");
 		btrfs_set_opt(ctx->mount_opt, NOLOGREPLAY);
 		break;
+	case Opt_norecovery:
+		btrfs_info(NULL,
+"'norecovery' is for compatibility only, recommended to use 'rescue=nologreplay'");
+		btrfs_set_opt(ctx->mount_opt, NOLOGREPLAY);
+		break;
 	case Opt_flushoncommit:
 		if (result.negated)
 			btrfs_clear_opt(ctx->mount_opt, FLUSHONCOMMIT);
-- 
2.45.1


