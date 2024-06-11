Return-Path: <linux-btrfs+bounces-5631-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D3223903117
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Jun 2024 07:30:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 40FB9B25E38
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Jun 2024 05:30:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FCD1171062;
	Tue, 11 Jun 2024 05:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="WvRzJiNm";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="fT89MrRf"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0F08172784
	for <linux-btrfs@vger.kernel.org>; Tue, 11 Jun 2024 05:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718083332; cv=none; b=ggeKbu33qHwzwQrrOOAwvNduEzksk+JNH/x+UiYUiDicIe+BbSuaIcBRhlDglAeQJZBKyGg+WrJF0ycg+NQS1+5rS+pmlPHTWOnN78eGibJfFUP84ICpDThml9+eA60M2t+cRWdpzq9Dzqa4dY4TZyiTGnI2vcB/mkWCAc2gHto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718083332; c=relaxed/simple;
	bh=AJbJ9AJfuH7uWnjyXtaZHXzfX/yx4CYLW+TUtmxBKWg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pli7a47IkdYC6RlwxTRKQ+SDbHP9WL70NbcIjGfcM7zRjp4IcTud5afqoHiFJI7QQaHyMd6o9xyQoUKs72dHQCELAgOZiqyuwFvprBgn6SqQqwcYtB2vpEE8wGAo55rRMa3wvVqUJJcw/D8X6fwa7+ENMStnuqd+2vTcpoH7hME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=WvRzJiNm; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=fT89MrRf; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id F25A822B3F
	for <linux-btrfs@vger.kernel.org>; Tue, 11 Jun 2024 05:22:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1718083328; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gAS28ptlIA2VEqbjYmx0kfI2j0ksCbfYRxl3W4kDaYA=;
	b=WvRzJiNmVGInkZmHFbCThryHlPYLRuRAO/XBPjpI5V9NnSfjI/LIoGzpK6IERy5yZFYxYZ
	//QDrS8qlA+rDq15xXN0UAvyNHpS5ZjrBnoC7wQAM6BZrfbg3Qcol4bk0gOMMl3V6qQhwh
	79dtULfaUatW22ulP1zdd31s9GKZkqg=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1718083327; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gAS28ptlIA2VEqbjYmx0kfI2j0ksCbfYRxl3W4kDaYA=;
	b=fT89MrRfyQRePKKsSkKumk2vAvVfFDW4uARvARBIiMuugeka7z2wjxHAQWgTLJNnPii4+A
	iTgiUbk8bkeIzPGPHwV5J2RVsqKygBqcTE457KyuRHEIOharg/s+jJtvGPlbS24ga+3hKd
	beSAD7jy8uYmTRXoWBuPSPvkNZ75yeU=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 00E0413A51
	for <linux-btrfs@vger.kernel.org>; Tue, 11 Jun 2024 05:22:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id iE93Kf7eZ2Y6KAAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Tue, 11 Jun 2024 05:22:06 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 4/4] btrfs: introduce new "rescue=ignoresuperflags" mount option
Date: Tue, 11 Jun 2024 14:51:38 +0930
Message-ID: <f76f3c993b70aead20d19390f430a1a03a0370c2.1718082585.git.wqu@suse.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1718082585.git.wqu@suse.com>
References: <cover.1718082585.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -2.80
X-Spam-Level: 
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	RCVD_TLS_ALL(0.00)[]

This new mount option would allow the kernel to skip the super flags
check, it's mostly to allow the kernel to do a rescue mount of an
interrupted checksum conversion.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/disk-io.c |  4 +++-
 fs/btrfs/fs.h      |  1 +
 fs/btrfs/super.c   | 13 ++++++++++++-
 3 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 74ee9f335dbc..0df747646c2f 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -2349,12 +2349,14 @@ int btrfs_validate_super(const struct btrfs_fs_info *fs_info,
 	u64 nodesize = btrfs_super_nodesize(sb);
 	u64 sectorsize = btrfs_super_sectorsize(sb);
 	int ret = 0;
+	bool ignore_flags = btrfs_raw_test_opt(fs_info->mount_opt,
+						IGNORESUPERFLAGS);
 
 	if (btrfs_super_magic(sb) != BTRFS_MAGIC) {
 		btrfs_err(fs_info, "no valid FS found");
 		ret = -EINVAL;
 	}
-	if (btrfs_super_flags(sb) & ~BTRFS_SUPER_FLAG_SUPP) {
+	if (!ignore_flags && (btrfs_super_flags(sb) & ~BTRFS_SUPER_FLAG_SUPP)) {
 		btrfs_err(fs_info, "unrecognized or unsupported super flag: 0x%llx",
 				btrfs_super_flags(sb) & ~BTRFS_SUPER_FLAG_SUPP);
 		ret = -EINVAL;
diff --git a/fs/btrfs/fs.h b/fs/btrfs/fs.h
index fcef7b81f9fd..8b14df6ff96c 100644
--- a/fs/btrfs/fs.h
+++ b/fs/btrfs/fs.h
@@ -225,6 +225,7 @@ enum {
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
-- 
2.45.2


