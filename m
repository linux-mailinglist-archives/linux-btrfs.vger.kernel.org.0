Return-Path: <linux-btrfs+bounces-3217-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AC355878DB1
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Mar 2024 04:58:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2EA061F21231
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Mar 2024 03:58:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7738FBE6D;
	Tue, 12 Mar 2024 03:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="DzxzV3nt";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="DzxzV3nt"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1957B67F
	for <linux-btrfs@vger.kernel.org>; Tue, 12 Mar 2024 03:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710215876; cv=none; b=CA34F1M+ylVYA+X4T0g7y6Y1A2OFZkd7yXIXGWrK61l1MxjsaYx6Ftao7UkLXAzE0dSV2TWkPRFn7qe02CQyWB4h75tRB14JiOtE/EW9uTfl7WnE5ncU+nnq0t1yf+5M/Gt5G0wPwF4x1MtBocHh8Mko9syixE1gWplR8PY2uQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710215876; c=relaxed/simple;
	bh=FNdT0246QceyiKr8e+Ai85wz/A7YeWU1MhAYZdxC0rY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gq/wnJli7ZosHU4+LlC6ucdqN5sv77OZIe75opfw+fGh187GVuCi1Be2reGBkHuo6NvV9aMvkbA485f9ehFmu/htqvy3mWhsjjxh0XtbtVV2tiyIH1cfVFt5aAITt4ZAwF98V45QXVRTMJUYoiSNt/87ZKwR6ZXGy9m42bHpg5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=DzxzV3nt; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=DzxzV3nt; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C0D075CF9B
	for <linux-btrfs@vger.kernel.org>; Tue, 12 Mar 2024 03:57:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1710215872; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5nIq1BYGfMlJWMfkRR4UaxYdFat3lu6nsqt5OkxigmY=;
	b=DzxzV3ntsSJU6MjXXIqP0IGgd7jX9DcG4AEogJIy8wYsLAGfbKOmkhVowBLfs7ZTJKdurW
	dGKqlRwu8gI0LacVZsETx1sAj98VyYfALd9FTt5YsorZ63Opf3j4ll9lTUvYufLbcmY6BW
	sqZRQApOfXX4fNISSabDYuORKSTH2N4=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1710215872; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5nIq1BYGfMlJWMfkRR4UaxYdFat3lu6nsqt5OkxigmY=;
	b=DzxzV3ntsSJU6MjXXIqP0IGgd7jX9DcG4AEogJIy8wYsLAGfbKOmkhVowBLfs7ZTJKdurW
	dGKqlRwu8gI0LacVZsETx1sAj98VyYfALd9FTt5YsorZ63Opf3j4ll9lTUvYufLbcmY6BW
	sqZRQApOfXX4fNISSabDYuORKSTH2N4=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DA7DA13879
	for <linux-btrfs@vger.kernel.org>; Tue, 12 Mar 2024 03:57:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id mFIkI7/S72VNVgAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Tue, 12 Mar 2024 03:57:51 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2 2/2] btrfs-progs: cmds/filesystem: add --usage-ratio and --wasted-bytes for defrag
Date: Tue, 12 Mar 2024 14:27:31 +1030
Message-ID: <90994d9b0f0453baf45256e2c2d3290041537fc7.1710214834.git.wqu@suse.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1710214834.git.wqu@suse.com>
References: <cover.1710214834.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=DzxzV3nt
X-Spamd-Result: default: False [-1.81 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	 FROM_HAS_DN(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 DWL_DNSWL_HI(-3.50)[suse.com:dkim];
	 RCPT_COUNT_ONE(0.00)[1];
	 RCVD_COUNT_THREE(0.00)[3];
	 TO_DN_NONE(0.00)[];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 DKIM_TRACE(0.00)[suse.com:+];
	 MX_GOOD(-0.01)[];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:dkim];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%];
	 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]
X-Spam-Score: -1.81
X-Rspamd-Queue-Id: C0D075CF9B
X-Spam-Flag: NO
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org

This allows defrag subcommand to accept new "--usage-ratio" and
"--wasted-bytes" options.

These two options allows defrag to handle extents which have no adjacent
mergable extents but has low usage ratio or high wasted bytes against
its on-disk extent.

The default behavior is, defrag would go with 5% as the usage_ratio
and 16M as the wasted bytes on the first try.

If the kernel doesn't support it, then retry without the fine tunning
flags.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 Documentation/btrfs-filesystem.rst | 21 ++++++++++++
 cmds/filesystem.c                  | 53 ++++++++++++++++++++++++++++--
 2 files changed, 71 insertions(+), 3 deletions(-)

diff --git a/Documentation/btrfs-filesystem.rst b/Documentation/btrfs-filesystem.rst
index 83207a5a263e..213be6ff4a14 100644
--- a/Documentation/btrfs-filesystem.rst
+++ b/Documentation/btrfs-filesystem.rst
@@ -144,6 +144,27 @@ defragment [options] <file>|<dir> [<file>|<dir>...]
                 The range is default (the whole file) or given by *-s* and *-l*, split into
                 the steps or done in one go if the step is larger. Minimum range size is 256KiB.
 
+	--usage-ratio <ratio>
+		If a file extent which is not a defrag target (e.g. no mergeable
+		adjacent extent), but has a usage ratio lower than (ratio / 100)
+		of the on-disk extent size, it would also be defraged
+		for its potential to free up the on-disk extent.
+
+		Valid values are in the range [0, 100].
+
+	--wasted-bytes <bytes>[kKmMgGgtTpPeE]
+		If a file extent which is not a defrag target (e.g. no mergeable
+		adjacent extent), but has more "wasted" bytes (the difference
+		between the file extent and the on-disk extent size) than this
+		value, it would also be defragged for its potential to free up
+		on-disk extent.
+
+		Valid values are in the range [0, U32_MAX], but any value larger than 128K
+		would make no sense for compressed file extents, and any value larger than
+		128M would make no sense for regular file extents.
+		As the largest file extent supported is 128K for compressed extent and 128M
+		otherwise, thus it's impossible to free up more bytes than those limits.
+
         -v
                 (deprecated) alias for global *-v* option
 
diff --git a/cmds/filesystem.c b/cmds/filesystem.c
index c9930a02d879..9cc224454e4c 100644
--- a/cmds/filesystem.c
+++ b/cmds/filesystem.c
@@ -914,6 +914,8 @@ static const char * const cmd_filesystem_defrag_usage[] = {
 	OPTLINE("-l len", "defragment only up to len bytes"),
 	OPTLINE("-t size", "target extent size hint (default: 32M)"),
 	OPTLINE("--step SIZE", "process the range in given steps, flush after each one"),
+	OPTLINE("--usage-ratio RATIO", "defrag extents with utilization ratio lower than RATIO%"),
+	OPTLINE("--wasted-bytes SIZE", "defrag extents which can free up more bytes than SIZE"),
 	OPTLINE("-v", "deprecated, alias for global -v option"),
 	HELPINFO_INSERT_GLOBALS,
 	HELPINFO_INSERT_VERBOSE,
@@ -929,13 +931,32 @@ static struct btrfs_ioctl_defrag_range_args defrag_global_range;
 static int defrag_global_errors;
 static u64 defrag_global_step;
 
+static int defrag_ioctl(int fd, struct btrfs_ioctl_defrag_range_args *range)
+{
+	int ret = 0;
+
+	ret = ioctl(fd, BTRFS_IOC_DEFRAG_RANGE, range);
+	if (ret < 0 && ((errno == EOPNOTSUPP) | (errno == ENOTTY)) &&
+	    range->flags & (BTRFS_DEFRAG_RANGE_USAGE_RATIO |
+			    BTRFS_DEFRAG_RANGE_WASTED_BYTES)) {
+		/*
+		 * Older kernel, no ratio/wasted bytes fine-tunning support.
+		 * Retry with ratio/wasted bytes fine-tunning disabled.
+		 */
+		range->flags &= ~(BTRFS_DEFRAG_RANGE_USAGE_RATIO |
+				  BTRFS_DEFRAG_RANGE_WASTED_BYTES);
+		ret = ioctl(fd, BTRFS_IOC_DEFRAG_RANGE, range);
+	}
+	return ret;
+}
+
 static int defrag_range_in_steps(int fd, const struct stat *st) {
 	int ret = 0;
 	u64 end;
 	struct btrfs_ioctl_defrag_range_args range;
 
 	if (defrag_global_step == 0)
-		return ioctl(fd, BTRFS_IOC_DEFRAG_RANGE, &defrag_global_range);
+		return defrag_ioctl(fd, &defrag_global_range);
 
 	/*
 	 * If start is set but length is not within or beyond the u64 range,
@@ -946,13 +967,17 @@ static int defrag_range_in_steps(int fd, const struct stat *st) {
 
 	range = defrag_global_range;
 	range.flags |= BTRFS_DEFRAG_RANGE_START_IO;
+	range.flags |= (BTRFS_DEFRAG_RANGE_USAGE_RATIO |
+			BTRFS_DEFRAG_RANGE_WASTED_BYTES);
+	range.usage_ratio = defrag_global_range.usage_ratio;
+	range.wasted_bytes = defrag_global_range.wasted_bytes;
 	while (range.start < end) {
 		u64 start;
 
 		range.len = defrag_global_step;
 		pr_verbose(LOG_VERBOSE, "defrag range step: start=%llu len=%llu step=%llu\n",
 			   range.start, range.len, defrag_global_step);
-		ret = ioctl(fd, BTRFS_IOC_DEFRAG_RANGE, &range);
+		ret = defrag_ioctl(fd, &range);
 		if (ret < 0)
 			return ret;
 		if (check_add_overflow(range.start, defrag_global_step, &start))
@@ -1013,6 +1038,8 @@ static int cmd_filesystem_defrag(const struct cmd_struct *cmd,
 	bool recursive = false;
 	int ret = 0;
 	int compress_type = BTRFS_COMPRESS_NONE;
+	u32 usage_ratio = 5;
+	u32 wasted_bytes = SZ_16M;
 
 	/*
 	 * Kernel 4.19+ supports defragmention of files open read-only,
@@ -1046,9 +1073,14 @@ static int cmd_filesystem_defrag(const struct cmd_struct *cmd,
 	defrag_global_errors = 0;
 	optind = 0;
 	while(1) {
-		enum { GETOPT_VAL_STEP = GETOPT_VAL_FIRST };
+		enum { GETOPT_VAL_STEP = GETOPT_VAL_FIRST,
+		       GETOPT_VAL_USAGE_RATIO, GETOPT_VAL_WASTED_BYTES };
 		static const struct option long_options[] = {
 			{ "step", required_argument, NULL, GETOPT_VAL_STEP },
+			{ "usage-ratio", required_argument, NULL,
+				GETOPT_VAL_USAGE_RATIO },
+			{ "wasted-bytes", required_argument, NULL,
+				GETOPT_VAL_WASTED_BYTES },
 			{ NULL, 0, NULL, 0 }
 		};
 		int c;
@@ -1098,6 +1130,17 @@ static int cmd_filesystem_defrag(const struct cmd_struct *cmd,
 				defrag_global_step = SZ_256K;
 			}
 			break;
+		case GETOPT_VAL_USAGE_RATIO:
+			usage_ratio = arg_strtou64(optarg);
+			if (usage_ratio > 100) {
+				error("invalid ratio, has %u expect [0, 100]",
+					usage_ratio);
+				exit(1);
+			}
+			break;
+		case GETOPT_VAL_WASTED_BYTES:
+			wasted_bytes = arg_strtou64_with_suffix(optarg);
+			break;
 		default:
 			usage_unknown_option(cmd, argv);
 		}
@@ -1116,6 +1159,10 @@ static int cmd_filesystem_defrag(const struct cmd_struct *cmd,
 	}
 	if (flush)
 		defrag_global_range.flags |= BTRFS_DEFRAG_RANGE_START_IO;
+	defrag_global_range.usage_ratio = usage_ratio;
+	defrag_global_range.wasted_bytes = wasted_bytes;
+	defrag_global_range.flags |= (BTRFS_DEFRAG_RANGE_USAGE_RATIO |
+				      BTRFS_DEFRAG_RANGE_WASTED_BYTES);
 
 	/*
 	 * Look for directory arguments and warn if the recursive mode is not
-- 
2.44.0


