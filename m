Return-Path: <linux-btrfs+bounces-5735-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EC7999082E9
	for <lists+linux-btrfs@lfdr.de>; Fri, 14 Jun 2024 06:23:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7761D1F23DF8
	for <lists+linux-btrfs@lfdr.de>; Fri, 14 Jun 2024 04:23:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 858C01474AE;
	Fri, 14 Jun 2024 04:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="MYkAZp79";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="MYkAZp79"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F07151459E0
	for <linux-btrfs@vger.kernel.org>; Fri, 14 Jun 2024 04:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718338970; cv=none; b=E2Ko0t2Ymv2exC+rJbOasyuz+PgwBos+Guv6lnZi63R6f7ZgQWBif1Rf56nZLqyWgzDyMcS7lD5bToeEDTwZiwMO4TVhNQgR5hGG+AT+zH8YasCvVOR1I0s863o/78JRmL7fTBOJvUkpBlmM1bOC5WBI2aJK2SjxhGsVfUogvL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718338970; c=relaxed/simple;
	bh=CqWak9Xu2UIXUmF5E+VhSxF2PHskYMEc8DkdaLZVZAs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tfl72lZeJ4PAS1UB1mq1G7GOHBkRBPnBYjW77rIc5PBim1qSnd0leCESbz50Hay56heGUbYC6wpL5M9NiIav2J+20VJwVSZt7k0C/bf4xKg9nJli3RxBXDOjOoRYhxbut4pRE3ZM6g/6A9CglXziIy/OIC3gseOHAoedU6rLcTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=MYkAZp79; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=MYkAZp79; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 0DDF3227FA;
	Fri, 14 Jun 2024 04:22:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1718338967; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EJlZZOA+93m3aJ9mdxzMcfNHO56jtswAc0RHYbEfJq0=;
	b=MYkAZp79CFPYzDViUZhc4XsQd/K0hikdMmmgD2jSiuxgkVOrtgdBrKWcNk+lHJ6FxIUnl4
	KO2uzle8RTH/6CWM59kNdk0UH0m+RJ+DqtQcbhGVDmKtloxZ3JnsP+qcVR5OGhicj9J4Z1
	oGv9xQ7ehumV8BieqvKdL+Q3USsVSd0=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1718338967; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EJlZZOA+93m3aJ9mdxzMcfNHO56jtswAc0RHYbEfJq0=;
	b=MYkAZp79CFPYzDViUZhc4XsQd/K0hikdMmmgD2jSiuxgkVOrtgdBrKWcNk+lHJ6FxIUnl4
	KO2uzle8RTH/6CWM59kNdk0UH0m+RJ+DqtQcbhGVDmKtloxZ3JnsP+qcVR5OGhicj9J4Z1
	oGv9xQ7ehumV8BieqvKdL+Q3USsVSd0=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C899F13AAD;
	Fri, 14 Jun 2024 04:22:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id MNeDH5XFa2YBJQAAD6G6ig
	(envelope-from <wqu@suse.com>); Fri, 14 Jun 2024 04:22:45 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH v2 4/4] btrfs: introduce new "rescue=ignoresuperflags" mount option
Date: Fri, 14 Jun 2024 13:52:31 +0930
Message-ID: <6e7b92ebb72f7e6e213f9cb601a3e5d246fdb594.1718338860.git.wqu@suse.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1718338860.git.wqu@suse.com>
References: <cover.1718338860.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Score: -2.80
X-Spam-Level: 

This new mount option would allow the kernel to skip the super flags
check, it's mostly to allow the kernel to do a rescue mount of an
interrupted checksum conversion.

Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/disk-io.c | 16 ++++++++++++----
 fs/btrfs/fs.h      |  1 +
 fs/btrfs/super.c   | 13 ++++++++++++-
 fs/btrfs/sysfs.c   |  1 +
 4 files changed, 26 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index e4e8e2a56cec..723ea765a05c 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -2346,15 +2346,23 @@ int btrfs_validate_super(const struct btrfs_fs_info *fs_info,
 	u64 nodesize = btrfs_super_nodesize(sb);
 	u64 sectorsize = btrfs_super_sectorsize(sb);
 	int ret = 0;
+	const bool ignore_flags = btrfs_test_opt(fs_info, IGNORESUPERFLAGS);
 
 	if (btrfs_super_magic(sb) != BTRFS_MAGIC) {
 		btrfs_err(fs_info, "no valid FS found");
 		ret = -EINVAL;
 	}
-	if (btrfs_super_flags(sb) & ~BTRFS_SUPER_FLAG_SUPP) {
-		btrfs_err(fs_info, "unrecognized or unsupported super flag: 0x%llx",
-				btrfs_super_flags(sb) & ~BTRFS_SUPER_FLAG_SUPP);
-		ret = -EINVAL;
+	if ((btrfs_super_flags(sb) & ~BTRFS_SUPER_FLAG_SUPP)) {
+		if (!ignore_flags) {
+			btrfs_err(fs_info,
+			"unrecognized or unsupported super flag: 0x%llx",
+				  btrfs_super_flags(sb) & ~BTRFS_SUPER_FLAG_SUPP);
+			ret = -EINVAL;
+		} else {
+			btrfs_info(fs_info,
+			"unrecognized or unsupported super flags: 0x%llx, ignoring",
+				   btrfs_super_flags(sb) & ~BTRFS_SUPER_FLAG_SUPP);
+		}
 	}
 	if (btrfs_super_root_level(sb) >= BTRFS_MAX_LEVEL) {
 		btrfs_err(fs_info, "tree_root level too big: %d >= %d",
diff --git a/fs/btrfs/fs.h b/fs/btrfs/fs.h
index 94faf83eb8d0..5939821dd743 100644
--- a/fs/btrfs/fs.h
+++ b/fs/btrfs/fs.h
@@ -226,6 +226,7 @@ enum {
 	BTRFS_MOUNT_NODISCARD			= (1UL << 29),
 	BTRFS_MOUNT_NOSPACECACHE		= (1UL << 30),
 	BTRFS_MOUNT_IGNOREMETACSUMS		= (1UL << 31),
+	BTRFS_MOUNT_IGNORESUPERFLAGS		= (1UL << 32),
 };
 
 /*
diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 386500b9b440..a66b5c901510 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -176,6 +176,7 @@ enum {
 	Opt_rescue_ignorebadroots,
 	Opt_rescue_ignoredatacsums,
 	Opt_rescue_ignoremetacsums,
+	Opt_rescue_ignoresuperflags,
 	Opt_rescue_parameter_all,
 };
 
@@ -186,8 +187,10 @@ static const struct constant_table btrfs_parameter_rescue[] = {
 	{ "ibadroots", Opt_rescue_ignorebadroots },
 	{ "ignoredatacsums", Opt_rescue_ignoredatacsums },
 	{ "ignoremetacsums", Opt_rescue_ignoremetacsums},
+	{ "ignoresuperflags", Opt_rescue_ignoresuperflags},
 	{ "idatacsums", Opt_rescue_ignoredatacsums },
 	{ "imetacsums", Opt_rescue_ignoremetacsums},
+	{ "isuperflags", Opt_rescue_ignoresuperflags},
 	{ "all", Opt_rescue_parameter_all },
 	{}
 };
@@ -576,9 +579,13 @@ static int btrfs_parse_param(struct fs_context *fc, struct fs_parameter *param)
 		case Opt_rescue_ignoremetacsums:
 			btrfs_set_opt(ctx->mount_opt, IGNOREMETACSUMS);
 			break;
+		case Opt_rescue_ignoresuperflags:
+			btrfs_set_opt(ctx->mount_opt, IGNORESUPERFLAGS);
+			break;
 		case Opt_rescue_parameter_all:
 			btrfs_set_opt(ctx->mount_opt, IGNOREDATACSUMS);
 			btrfs_set_opt(ctx->mount_opt, IGNOREMETACSUMS);
+			btrfs_set_opt(ctx->mount_opt, IGNORESUPERFLAGS);
 			btrfs_set_opt(ctx->mount_opt, IGNOREBADROOTS);
 			btrfs_set_opt(ctx->mount_opt, NOLOGREPLAY);
 			break;
@@ -654,7 +661,8 @@ bool btrfs_check_options(const struct btrfs_fs_info *info, unsigned long *mount_
 	    (check_ro_option(info, *mount_opt, BTRFS_MOUNT_NOLOGREPLAY, "nologreplay") ||
 	     check_ro_option(info, *mount_opt, BTRFS_MOUNT_IGNOREBADROOTS, "ignorebadroots") ||
 	     check_ro_option(info, *mount_opt, BTRFS_MOUNT_IGNOREDATACSUMS, "ignoredatacsums") ||
-	     check_ro_option(info, *mount_opt, BTRFS_MOUNT_IGNOREMETACSUMS, "ignoremetacsums")))
+	     check_ro_option(info, *mount_opt, BTRFS_MOUNT_IGNOREMETACSUMS, "ignoremetacsums") ||
+	     check_ro_option(info, *mount_opt, BTRFS_MOUNT_IGNORESUPERFLAGS, "ignoresuperflags")))
 		ret = false;
 
 	if (btrfs_fs_compat_ro(info, FREE_SPACE_TREE) &&
@@ -1072,6 +1080,8 @@ static int btrfs_show_options(struct seq_file *seq, struct dentry *dentry)
 		print_rescue_option(seq, "ignoredatacsums", &printed);
 	if (btrfs_test_opt(info, IGNOREMETACSUMS))
 		print_rescue_option(seq, "ignoremetacsums", &printed);
+	if (btrfs_test_opt(info, IGNORESUPERFLAGS))
+		print_rescue_option(seq, "ignoresuperflags", &printed);
 	if (btrfs_test_opt(info, FLUSHONCOMMIT))
 		seq_puts(seq, ",flushoncommit");
 	if (btrfs_test_opt(info, DISCARD_SYNC))
@@ -1430,6 +1440,7 @@ static void btrfs_emit_options(struct btrfs_fs_info *info,
 	btrfs_info_if_set(info, old, IGNOREBADROOTS, "ignoring bad roots");
 	btrfs_info_if_set(info, old, IGNOREDATACSUMS, "ignoring data csums");
 	btrfs_info_if_set(info, old, IGNOREMETACSUMS, "ignoring meta csums");
+	btrfs_info_if_set(info, old, IGNORESUPERFLAGS, "ignoring unknown super flags");
 
 	btrfs_info_if_unset(info, old, NODATACOW, "setting datacow");
 	btrfs_info_if_unset(info, old, SSD, "not using ssd optimizations");
diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index 91e47a3fbedb..94bff7f0f0c4 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -386,6 +386,7 @@ static const char *rescue_opts[] = {
 	"ignorebadroots",
 	"ignoredatacsums",
 	"ignoremetacsums",
+	"ignoresuperflags",
 	"all",
 };
 
-- 
2.45.2


