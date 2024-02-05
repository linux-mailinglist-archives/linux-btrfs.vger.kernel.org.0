Return-Path: <linux-btrfs+bounces-2137-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A80C84AAD3
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 Feb 2024 00:46:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4B0528A906
	for <lists+linux-btrfs@lfdr.de>; Mon,  5 Feb 2024 23:46:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B21FF4F211;
	Mon,  5 Feb 2024 23:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="n+KjyXZk";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="n+KjyXZk"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEEEB4D5BD
	for <linux-btrfs@vger.kernel.org>; Mon,  5 Feb 2024 23:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707176781; cv=none; b=q4s23Ati+pYElRCqb62nbQ8gm4LK6CEbo41IOp00dhUAaWTPok+40LIoW7AkNHUasUHaqgEWEYEsBs27Cyu/zfTgbngNtrQOmed01BM3uO5t5PCwBV/0Gs2DY+Em5T5G/D8Xc1RW93JG9mipAe4HIvh/D6G0dLsffY2itNPbk3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707176781; c=relaxed/simple;
	bh=9JOnJoVLwqOM8oHRxdJfBjGUMhIfNN7X3Whn7mcyDf0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=di2JuJap04cH2iXAWh7XLkUGpZBy/jyy+d0Un+cXHFOTRRbTK8MO4A2Wwf+39sqS8olU4tzc1K9OMxisjbjFP/fHxweV3PJunKuw45XOzx2r77jLbR/qawiOWKWJUw0gfEfblW3qpQywwdgidaZABUvF4OwWkfvDkBiTiuvCIHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=n+KjyXZk; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=n+KjyXZk; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 5F9A41FB57
	for <linux-btrfs@vger.kernel.org>; Mon,  5 Feb 2024 23:46:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1707176778; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4uhbEn3RBGmLYp6TFu5xe/hUpIS6EScbLFLbRo2awX8=;
	b=n+KjyXZkVEtA/BNiIEJF7MJpXebQFlXAx0kea+BgP4hkYGOsz+scbClhRyb4s8WUHedRKm
	dnOzmq/3w75oSVqatVhAyMtzzEQVOqka0yyPk6iUz06MBR8NwYbwz/Z6yU1soPjPD0O/nu
	6Ls/zBTDsDoptVZCdx7uXyuR1qnvjms=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1707176778; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4uhbEn3RBGmLYp6TFu5xe/hUpIS6EScbLFLbRo2awX8=;
	b=n+KjyXZkVEtA/BNiIEJF7MJpXebQFlXAx0kea+BgP4hkYGOsz+scbClhRyb4s8WUHedRKm
	dnOzmq/3w75oSVqatVhAyMtzzEQVOqka0yyPk6iUz06MBR8NwYbwz/Z6yU1soPjPD0O/nu
	6Ls/zBTDsDoptVZCdx7uXyuR1qnvjms=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9A08C136F5
	for <linux-btrfs@vger.kernel.org>; Mon,  5 Feb 2024 23:46:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 0KsrF0lzwWU0cAAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Mon, 05 Feb 2024 23:46:17 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 2/2] btrfs-progs: cmds/filesystem: fine-tune lone file extents defragging
Date: Tue,  6 Feb 2024 10:16:12 +1030
Message-ID: <7e14519358bcfddaf4e6f268e21034b06b3a57ba.1707176488.git.wqu@suse.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1707176488.git.wqu@suse.com>
References: <cover.1707176488.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=n+KjyXZk
X-Spamd-Result: default: False [1.69 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 FROM_HAS_DN(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 RCPT_COUNT_ONE(0.00)[1];
	 RCVD_COUNT_THREE(0.00)[3];
	 TO_DN_NONE(0.00)[];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 DKIM_TRACE(0.00)[suse.com:+];
	 MX_GOOD(-0.01)[];
	 MID_CONTAINS_FROM(1.00)[];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Score: 1.69
X-Rspamd-Queue-Id: 5F9A41FB57
X-Spam-Level: *
X-Spam-Flag: NO
X-Spamd-Bar: +

This allows defrag to fine-tune long file extents (which have no
adjacent file extents) with new "--lone-ratio" and "--lone-wasted-bytes"
options.

The default behavior is, defrag would go with 4096 as the ratio (1/16),
and 16M as the wasted bytes on the first try.

If the kernel doesn't support it, then retry without lone file extents
handling.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 Documentation/btrfs-filesystem.rst | 18 ++++++++++
 cmds/filesystem.c                  | 53 ++++++++++++++++++++++++++++--
 2 files changed, 68 insertions(+), 3 deletions(-)

diff --git a/Documentation/btrfs-filesystem.rst b/Documentation/btrfs-filesystem.rst
index 54069ce444f6..f5cd34e9062f 100644
--- a/Documentation/btrfs-filesystem.rst
+++ b/Documentation/btrfs-filesystem.rst
@@ -144,6 +144,24 @@ defragment [options] <file>|<dir> [<file>|<dir>...]
                 The range is default (the whole file) or given by *-s* and *-l*, split into
                 the steps or done in one go if the step is larger. Minimum range size is 256KiB.
 
+	--lone-ratio <ratio>
+		For a lone file extent (which has no adjacent file exctent), if its utilizing
+		less than (ratio / 65536) of the on-disk extent size, it would also be defraged
+		for its potential to free up the on-disk extent.
+
+		Valid values are in the range [0, 65536].
+
+	--lone-wasted-bytes <bytes>[kKmMgGgtTpPeE]
+		For a lone file extent (which has no adjacent file exctent), if defragging
+		the file extent can free up more than <bytes> (excluding the file extent
+		size), the file extent would be defragged.
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
index b7ca4c9a2257..3579e7160c96 100644
--- a/cmds/filesystem.c
+++ b/cmds/filesystem.c
@@ -915,6 +915,8 @@ static const char * const cmd_filesystem_defrag_usage[] = {
 	OPTLINE("-l len", "defragment only up to len bytes"),
 	OPTLINE("-t size", "target extent size hint (default: 32M)"),
 	OPTLINE("--step SIZE", "process the range in given steps, flush after each one"),
+	OPTLINE("--lone-ratio RATIO", "defrag lone extents with utilization ratio lower than RATIO/65536"),
+	OPTLINE("--lone-wasted-bytes SIZE", "defrag lone extents which can free up more bytes than SIZE"),
 	OPTLINE("-v", "deprecated, alias for global -v option"),
 	HELPINFO_INSERT_GLOBALS,
 	HELPINFO_INSERT_VERBOSE,
@@ -930,13 +932,32 @@ static struct btrfs_ioctl_defrag_range_args defrag_global_range;
 static int defrag_global_errors;
 static u64 defrag_global_step;
 
+static int defrag_ioctl(int fd, struct btrfs_ioctl_defrag_range_args *range)
+{
+	int ret = 0;
+
+	ret = ioctl(fd, BTRFS_IOC_DEFRAG_RANGE, range);
+	if (ret < 0 && ((errno == EOPNOTSUPP) | (errno == ENOTTY)) &&
+	    range->flags & (BTRFS_DEFRAG_RANGE_LONE_RATIO |
+			    BTRFS_DEFRAG_RANGE_LONE_WASTED_BYTES)) {
+		/*
+		 * Older kernel, no lone extent handling support.
+		 * Retry with lone extent fine-tunning disabled.
+		 */
+		range->flags &= ~(BTRFS_DEFRAG_RANGE_LONE_RATIO |
+				  BTRFS_DEFRAG_RANGE_LONE_WASTED_BYTES);
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
@@ -947,13 +968,17 @@ static int defrag_range_in_steps(int fd, const struct stat *st) {
 
 	range = defrag_global_range;
 	range.flags |= BTRFS_DEFRAG_RANGE_START_IO;
+	range.flags |= (BTRFS_DEFRAG_RANGE_LONE_RATIO |
+			BTRFS_DEFRAG_RANGE_LONE_WASTED_BYTES);
+	range.lone_ratio = defrag_global_range.lone_ratio;
+	range.lone_wasted_bytes = defrag_global_range.lone_wasted_bytes;
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
@@ -1014,6 +1039,8 @@ static int cmd_filesystem_defrag(const struct cmd_struct *cmd,
 	bool recursive = false;
 	int ret = 0;
 	int compress_type = BTRFS_COMPRESS_NONE;
+	u32 lone_ratio = SZ_64K / 16;
+	u32 lone_wasted_bytes = SZ_16M;
 	DIR *dirstream;
 
 	/*
@@ -1048,9 +1075,14 @@ static int cmd_filesystem_defrag(const struct cmd_struct *cmd,
 	defrag_global_errors = 0;
 	optind = 0;
 	while(1) {
-		enum { GETOPT_VAL_STEP = GETOPT_VAL_FIRST };
+		enum { GETOPT_VAL_STEP = GETOPT_VAL_FIRST,
+		       GETOPT_VAL_LONE_RATIO, GETOPT_VAL_LONE_WASTED_BYTES };
 		static const struct option long_options[] = {
 			{ "step", required_argument, NULL, GETOPT_VAL_STEP },
+			{ "lone-ratio", required_argument, NULL,
+				GETOPT_VAL_LONE_RATIO },
+			{ "lone-wasted-bytes", required_argument, NULL,
+				GETOPT_VAL_LONE_WASTED_BYTES },
 			{ NULL, 0, NULL, 0 }
 		};
 		int c;
@@ -1100,6 +1132,17 @@ static int cmd_filesystem_defrag(const struct cmd_struct *cmd,
 				defrag_global_step = SZ_256K;
 			}
 			break;
+		case GETOPT_VAL_LONE_RATIO:
+			lone_ratio = arg_strtou64(optarg);
+			if (lone_ratio > 65536) {
+				error("invalid ratio, has %u expect [0, 65536]",
+					lone_ratio);
+				exit(1);
+			}
+			break;
+		case GETOPT_VAL_LONE_WASTED_BYTES:
+			lone_wasted_bytes = arg_strtou64_with_suffix(optarg);
+			break;
 		default:
 			usage_unknown_option(cmd, argv);
 		}
@@ -1118,6 +1161,10 @@ static int cmd_filesystem_defrag(const struct cmd_struct *cmd,
 	}
 	if (flush)
 		defrag_global_range.flags |= BTRFS_DEFRAG_RANGE_START_IO;
+	defrag_global_range.lone_ratio = lone_ratio;
+	defrag_global_range.lone_wasted_bytes = lone_wasted_bytes;
+	defrag_global_range.flags |= (BTRFS_DEFRAG_RANGE_LONE_RATIO |
+				      BTRFS_DEFRAG_RANGE_LONE_WASTED_BYTES);
 
 	/*
 	 * Look for directory arguments and warn if the recursive mode is not
-- 
2.43.0


