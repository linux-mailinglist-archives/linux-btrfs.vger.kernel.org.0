Return-Path: <linux-btrfs+bounces-5734-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B9579082E8
	for <lists+linux-btrfs@lfdr.de>; Fri, 14 Jun 2024 06:23:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C7BA2831C0
	for <lists+linux-btrfs@lfdr.de>; Fri, 14 Jun 2024 04:23:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CD6C1474A0;
	Fri, 14 Jun 2024 04:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="NHz7gJMv";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="NHz7gJMv"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C04C146D65
	for <linux-btrfs@vger.kernel.org>; Fri, 14 Jun 2024 04:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718338969; cv=none; b=Qf9VDaRdCzTCA9a2zf93HmbNtxV1k+P0HYlWptty/bZuJNfa+onkydqHYBJOV822lo5mXU/DFygWOoi2o9lPgiKShu8zXmoU7rs7gg2h84iumJsbwVv7cAX+xIpcuVtV0sQxIdQcUP+4ndVo20aNnxVXDqjUKrf5PgbM0jHBPNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718338969; c=relaxed/simple;
	bh=TM8nk875/TdzjpouTfw93RLoX+ZUT/vFEC6pqDr/U0c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mBUvdk6Vgd6/rBlVNGKQ8U7swF49la/V8zv+O/W/z+lZTXqAixy+gHRir8RnJL2RxJw8RmbHItJ/DxwJCwlbNxJhpJFrIXj7w1Lp1w5PXN9T3cNVpDEMlrIHldQS19fuNJbdDqbrvtTzf28OLf2YphIId5r8SFN5kGVr0zZCXGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=NHz7gJMv; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=NHz7gJMv; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 3E665227FB;
	Fri, 14 Jun 2024 04:22:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1718338965; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UQ0uEwQuCOgc8hkzCxCumow8aO8Tu7tJvRyAcoCP8aA=;
	b=NHz7gJMvWE7VOYKOsj9juKsDawdVqZzLt0zX+kx5C6KZRuLlmSMywWGx8YEKKHOXIhNZH1
	ynLRHVS0jwwrLwRJvBNz2gcflGb6JS27m4gQ1f6ViIzF+beqaU6iJKh1i4atO4PMDT+zEe
	IpL4a8O5/urcKnqDBLF5e2mhIJAqDAw=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=NHz7gJMv
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1718338965; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UQ0uEwQuCOgc8hkzCxCumow8aO8Tu7tJvRyAcoCP8aA=;
	b=NHz7gJMvWE7VOYKOsj9juKsDawdVqZzLt0zX+kx5C6KZRuLlmSMywWGx8YEKKHOXIhNZH1
	ynLRHVS0jwwrLwRJvBNz2gcflGb6JS27m4gQ1f6ViIzF+beqaU6iJKh1i4atO4PMDT+zEe
	IpL4a8O5/urcKnqDBLF5e2mhIJAqDAw=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0F3DB13AAD;
	Fri, 14 Jun 2024 04:22:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id OK/qLZPFa2YBJQAAD6G6ig
	(envelope-from <wqu@suse.com>); Fri, 14 Jun 2024 04:22:43 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH v2 3/4] btrfs: introduce new "rescue=ignoremetacsums" mount option
Date: Fri, 14 Jun 2024 13:52:30 +0930
Message-ID: <00b4a76ec6c1dc7e3cdf7fae0b6ee04038de9848.1718338860.git.wqu@suse.com>
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
X-Spamd-Result: default: False [-5.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	DWL_DNSWL_MED(-2.00)[suse.com:dkim];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 3E665227FB
X-Spam-Flag: NO
X-Spam-Score: -5.01
X-Spam-Level: 

This patch introduces "rescue=ignoremetacsums" to ignore metadata csums,
meanwhile all the other metadata sanity checks are still kept as is.

This new mount option is mostly to allow the kernel to mount an
interrupted checksum conversion (at the metadata csum overwrite stage).

And since the main part of metadata sanity checks is inside
tree-checker, we shouldn't lose much safety, and the new mount option is
rescue mount option it requires full read-only mount.

Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/bio.c       |  2 +-
 fs/btrfs/disk-io.c   | 19 +++++++++++++------
 fs/btrfs/file-item.c |  2 +-
 fs/btrfs/fs.h        |  4 +++-
 fs/btrfs/messages.c  |  3 ++-
 fs/btrfs/super.c     | 13 ++++++++++++-
 fs/btrfs/sysfs.c     |  1 +
 fs/btrfs/zoned.c     |  2 +-
 8 files changed, 34 insertions(+), 12 deletions(-)

diff --git a/fs/btrfs/bio.c b/fs/btrfs/bio.c
index e3a57196b0ee..1d063ab5018b 100644
--- a/fs/btrfs/bio.c
+++ b/fs/btrfs/bio.c
@@ -732,7 +732,7 @@ static bool btrfs_submit_chunk(struct btrfs_bio *bbio, int mirror_num)
 		 * point, so they are handled as part of the no-checksum case.
 		 */
 		if (inode && !(inode->flags & BTRFS_INODE_NODATASUM) &&
-		    !test_bit(BTRFS_FS_STATE_NO_CSUMS, &fs_info->fs_state) &&
+		    !test_bit(BTRFS_FS_STATE_NO_DATA_CSUMS, &fs_info->fs_state) &&
 		    !btrfs_is_data_reloc_root(inode->root)) {
 			if (should_async_write(bbio) &&
 			    btrfs_wq_submit_bio(bbio, bioc, &smap, mirror_num))
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 92661d8ebf76..e4e8e2a56cec 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -367,6 +367,7 @@ int btrfs_validate_extent_buffer(struct extent_buffer *eb,
 	u8 result[BTRFS_CSUM_SIZE];
 	const u8 *header_csum;
 	int ret = 0;
+	const bool ignore_csum = btrfs_test_opt(fs_info, IGNOREMETACSUMS);
 
 	ASSERT(check);
 
@@ -399,13 +400,17 @@ int btrfs_validate_extent_buffer(struct extent_buffer *eb,
 
 	if (memcmp(result, header_csum, csum_size) != 0) {
 		btrfs_warn_rl(fs_info,
-"checksum verify failed on logical %llu mirror %u wanted " CSUM_FMT " found " CSUM_FMT " level %d",
+		"checksum verify failed on logical %llu mirror %u wanted "
+		CSUM_FMT " found " CSUM_FMT " level %d%s",
 			      eb->start, eb->read_mirror,
 			      CSUM_FMT_VALUE(csum_size, header_csum),
 			      CSUM_FMT_VALUE(csum_size, result),
-			      btrfs_header_level(eb));
-		ret = -EUCLEAN;
-		goto out;
+			      btrfs_header_level(eb),
+			      ignore_csum ? ", ignoring" : "");
+		if (!ignore_csum) {
+			ret = -EUCLEAN;
+			goto out;
+		}
 	}
 
 	if (found_level != check->level) {
@@ -2131,7 +2136,7 @@ static int load_global_roots_objectid(struct btrfs_root *tree_root,
 	/* If we have IGNOREDATACSUMS skip loading these roots. */
 	if (objectid == BTRFS_CSUM_TREE_OBJECTID &&
 	    btrfs_test_opt(fs_info, IGNOREDATACSUMS)) {
-		set_bit(BTRFS_FS_STATE_NO_CSUMS, &fs_info->fs_state);
+		set_bit(BTRFS_FS_STATE_NO_DATA_CSUMS, &fs_info->fs_state);
 		return 0;
 	}
 
@@ -2184,7 +2189,7 @@ static int load_global_roots_objectid(struct btrfs_root *tree_root,
 
 	if (!found || ret) {
 		if (objectid == BTRFS_CSUM_TREE_OBJECTID)
-			set_bit(BTRFS_FS_STATE_NO_CSUMS, &fs_info->fs_state);
+			set_bit(BTRFS_FS_STATE_NO_DATA_CSUMS, &fs_info->fs_state);
 
 		if (!btrfs_test_opt(fs_info, IGNOREBADROOTS))
 			ret = ret ? ret : -ENOENT;
@@ -2865,6 +2870,8 @@ static int init_mount_fs_info(struct btrfs_fs_info *fs_info, struct super_block
 
 	if (sb_rdonly(sb))
 		set_bit(BTRFS_FS_STATE_RO, &fs_info->fs_state);
+	if (btrfs_test_opt(fs_info, IGNOREMETACSUMS))
+		set_bit(BTRFS_FS_STATE_SKIP_META_CSUMS, &fs_info->fs_state);
 
 	return btrfs_alloc_stripe_hash_table(fs_info);
 }
diff --git a/fs/btrfs/file-item.c b/fs/btrfs/file-item.c
index 55703c833f3d..6c7713fb9a75 100644
--- a/fs/btrfs/file-item.c
+++ b/fs/btrfs/file-item.c
@@ -353,7 +353,7 @@ blk_status_t btrfs_lookup_bio_sums(struct btrfs_bio *bbio)
 	u32 bio_offset = 0;
 
 	if ((inode->flags & BTRFS_INODE_NODATASUM) ||
-	    test_bit(BTRFS_FS_STATE_NO_CSUMS, &fs_info->fs_state))
+	    test_bit(BTRFS_FS_STATE_NO_DATA_CSUMS, &fs_info->fs_state))
 		return BLK_STS_OK;
 
 	/*
diff --git a/fs/btrfs/fs.h b/fs/btrfs/fs.h
index 18e0d3539496..94faf83eb8d0 100644
--- a/fs/btrfs/fs.h
+++ b/fs/btrfs/fs.h
@@ -98,7 +98,8 @@ enum {
 	/* The btrfs_fs_info created for self-tests */
 	BTRFS_FS_STATE_DUMMY_FS_INFO,
 
-	BTRFS_FS_STATE_NO_CSUMS,
+	BTRFS_FS_STATE_NO_DATA_CSUMS,
+	BTRFS_FS_STATE_SKIP_META_CSUMS,
 
 	/* Indicates there was an error cleaning up a log tree. */
 	BTRFS_FS_STATE_LOG_CLEANUP_ERROR,
@@ -224,6 +225,7 @@ enum {
 	BTRFS_MOUNT_IGNOREDATACSUMS		= (1UL << 28),
 	BTRFS_MOUNT_NODISCARD			= (1UL << 29),
 	BTRFS_MOUNT_NOSPACECACHE		= (1UL << 30),
+	BTRFS_MOUNT_IGNOREMETACSUMS		= (1UL << 31),
 };
 
 /*
diff --git a/fs/btrfs/messages.c b/fs/btrfs/messages.c
index 210d9c82e2ae..77752eec125d 100644
--- a/fs/btrfs/messages.c
+++ b/fs/btrfs/messages.c
@@ -20,7 +20,8 @@ static const char fs_state_chars[] = {
 	[BTRFS_FS_STATE_TRANS_ABORTED]		= 'A',
 	[BTRFS_FS_STATE_DEV_REPLACING]		= 'R',
 	[BTRFS_FS_STATE_DUMMY_FS_INFO]		= 0,
-	[BTRFS_FS_STATE_NO_CSUMS]		= 'C',
+	[BTRFS_FS_STATE_NO_DATA_CSUMS]		= 'C',
+	[BTRFS_FS_STATE_SKIP_META_CSUMS]	= 'S',
 	[BTRFS_FS_STATE_LOG_CLEANUP_ERROR]	= 'L',
 };
 
diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 902423f2839c..386500b9b440 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -175,6 +175,7 @@ enum {
 	Opt_rescue_nologreplay,
 	Opt_rescue_ignorebadroots,
 	Opt_rescue_ignoredatacsums,
+	Opt_rescue_ignoremetacsums,
 	Opt_rescue_parameter_all,
 };
 
@@ -184,7 +185,9 @@ static const struct constant_table btrfs_parameter_rescue[] = {
 	{ "ignorebadroots", Opt_rescue_ignorebadroots },
 	{ "ibadroots", Opt_rescue_ignorebadroots },
 	{ "ignoredatacsums", Opt_rescue_ignoredatacsums },
+	{ "ignoremetacsums", Opt_rescue_ignoremetacsums},
 	{ "idatacsums", Opt_rescue_ignoredatacsums },
+	{ "imetacsums", Opt_rescue_ignoremetacsums},
 	{ "all", Opt_rescue_parameter_all },
 	{}
 };
@@ -570,8 +573,12 @@ static int btrfs_parse_param(struct fs_context *fc, struct fs_parameter *param)
 		case Opt_rescue_ignoredatacsums:
 			btrfs_set_opt(ctx->mount_opt, IGNOREDATACSUMS);
 			break;
+		case Opt_rescue_ignoremetacsums:
+			btrfs_set_opt(ctx->mount_opt, IGNOREMETACSUMS);
+			break;
 		case Opt_rescue_parameter_all:
 			btrfs_set_opt(ctx->mount_opt, IGNOREDATACSUMS);
+			btrfs_set_opt(ctx->mount_opt, IGNOREMETACSUMS);
 			btrfs_set_opt(ctx->mount_opt, IGNOREBADROOTS);
 			btrfs_set_opt(ctx->mount_opt, NOLOGREPLAY);
 			break;
@@ -646,7 +653,8 @@ bool btrfs_check_options(const struct btrfs_fs_info *info, unsigned long *mount_
 	if (!(flags & SB_RDONLY) &&
 	    (check_ro_option(info, *mount_opt, BTRFS_MOUNT_NOLOGREPLAY, "nologreplay") ||
 	     check_ro_option(info, *mount_opt, BTRFS_MOUNT_IGNOREBADROOTS, "ignorebadroots") ||
-	     check_ro_option(info, *mount_opt, BTRFS_MOUNT_IGNOREDATACSUMS, "ignoredatacsums")))
+	     check_ro_option(info, *mount_opt, BTRFS_MOUNT_IGNOREDATACSUMS, "ignoredatacsums") ||
+	     check_ro_option(info, *mount_opt, BTRFS_MOUNT_IGNOREMETACSUMS, "ignoremetacsums")))
 		ret = false;
 
 	if (btrfs_fs_compat_ro(info, FREE_SPACE_TREE) &&
@@ -1062,6 +1070,8 @@ static int btrfs_show_options(struct seq_file *seq, struct dentry *dentry)
 		print_rescue_option(seq, "ignorebadroots", &printed);
 	if (btrfs_test_opt(info, IGNOREDATACSUMS))
 		print_rescue_option(seq, "ignoredatacsums", &printed);
+	if (btrfs_test_opt(info, IGNOREMETACSUMS))
+		print_rescue_option(seq, "ignoremetacsums", &printed);
 	if (btrfs_test_opt(info, FLUSHONCOMMIT))
 		seq_puts(seq, ",flushoncommit");
 	if (btrfs_test_opt(info, DISCARD_SYNC))
@@ -1419,6 +1429,7 @@ static void btrfs_emit_options(struct btrfs_fs_info *info,
 	btrfs_info_if_set(info, old, USEBACKUPROOT, "trying to use backup root at mount time");
 	btrfs_info_if_set(info, old, IGNOREBADROOTS, "ignoring bad roots");
 	btrfs_info_if_set(info, old, IGNOREDATACSUMS, "ignoring data csums");
+	btrfs_info_if_set(info, old, IGNOREMETACSUMS, "ignoring meta csums");
 
 	btrfs_info_if_unset(info, old, NODATACOW, "setting datacow");
 	btrfs_info_if_unset(info, old, SSD, "not using ssd optimizations");
diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index af545b6b1190..91e47a3fbedb 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -385,6 +385,7 @@ static const char *rescue_opts[] = {
 	"nologreplay",
 	"ignorebadroots",
 	"ignoredatacsums",
+	"ignoremetacsums",
 	"all",
 };
 
diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index 992a5b7756ca..386daea0ca0b 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -1844,7 +1844,7 @@ void btrfs_finish_ordered_zoned(struct btrfs_ordered_extent *ordered)
 	 * here so that we don't attempt to log the csums later.
 	 */
 	if ((inode->flags & BTRFS_INODE_NODATASUM) ||
-	    test_bit(BTRFS_FS_STATE_NO_CSUMS, &fs_info->fs_state)) {
+	    test_bit(BTRFS_FS_STATE_NO_DATA_CSUMS, &fs_info->fs_state)) {
 		while ((sum = list_first_entry_or_null(&ordered->list,
 						       typeof(*sum), list))) {
 			list_del(&sum->list);
-- 
2.45.2


