Return-Path: <linux-btrfs+bounces-12002-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DE070A4EA08
	for <lists+linux-btrfs@lfdr.de>; Tue,  4 Mar 2025 18:54:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C76EE189ADC7
	for <lists+linux-btrfs@lfdr.de>; Tue,  4 Mar 2025 17:49:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29A0E20A5C4;
	Tue,  4 Mar 2025 17:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="pLvCtAeY";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="pLvCtAeY"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 058CB1F4276
	for <linux-btrfs@vger.kernel.org>; Tue,  4 Mar 2025 17:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741109243; cv=none; b=tRHu+Bm+MlT1DDG8w0P+sO2Vsra87KC/FmGg9G26elV0iNksXIbIZE5H9+USgE7CD4VnuTrJhv0yow/c4I+2wReXx/bFjyryWXsBe1HeyBsg0m1yuy72qm0gtcVoYbZi8fXsFHttssYhoL8KOwzsTemdFEGsq/cd5H6eXxhmr1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741109243; c=relaxed/simple;
	bh=ZTiN5JWkQP67+O1x0SlxywujvNoEUWTBNOwzO4Ecktw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iT0zdOFtMFOeHkkueRWHh0OB2i/JvBhHFQpOkguYbbhNg1Udk9Qi3IszcpK7E8RenCZ5p1w37GEjWwG2peeRw0zLDYGMtmC+kJGAobNlKSy8n8fuxPqnsGRyaCxsjr+L6MLCh/KpibdnwUTJlZow6/JayHrQpacniBDYY0B9Q6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=pLvCtAeY; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=pLvCtAeY; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 01B7521190;
	Tue,  4 Mar 2025 17:27:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1741109239; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=kuigYR/G6AD2nzQaSZCHCs1Glhcy+sWqJelUCok5mOo=;
	b=pLvCtAeYdeLVEZ7q1wJNMeLWlxT0oVAhwCII633UUD4fvEauvu6qjatHTeRj8VT1YMocM6
	fySHl6nLMaiH4/873tkQXQVuMHx4ODtvrP6UFKrUcw+OzXQvwmVlU/845xw+XB+2NTyR/p
	kWla82I58OJrGoSceYox5xUAZfsIA8Q=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=pLvCtAeY
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1741109239; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=kuigYR/G6AD2nzQaSZCHCs1Glhcy+sWqJelUCok5mOo=;
	b=pLvCtAeYdeLVEZ7q1wJNMeLWlxT0oVAhwCII633UUD4fvEauvu6qjatHTeRj8VT1YMocM6
	fySHl6nLMaiH4/873tkQXQVuMHx4ODtvrP6UFKrUcw+OzXQvwmVlU/845xw+XB+2NTyR/p
	kWla82I58OJrGoSceYox5xUAZfsIA8Q=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E849313967;
	Tue,  4 Mar 2025 17:27:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id cMMoOPY3x2dvawAAD6G6ig
	(envelope-from <neelx@suse.com>); Tue, 04 Mar 2025 17:27:18 +0000
From: Daniel Vacek <neelx@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: Daniel Vacek <neelx@suse.com>
Subject: [PATCH] btrfs-progs: fi defrag: allow passing compression levels
Date: Tue,  4 Mar 2025 18:27:12 +0100
Message-ID: <20250304172712.573328-1-neelx@suse.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 01B7521190
X-Spam-Level: 
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:dkim,suse.com:mid];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01
X-Spam-Flag: NO

zlib and zstd compression methods support using compression levels.
Enable defrag to pass them to kernel.

Signed-off-by: Daniel Vacek <neelx@suse.com>
---
 Documentation/ch-compression.rst | 10 +++---
 cmds/filesystem.c                | 55 ++++++++++++++++++++++++++++++--
 kernel-shared/uapi/btrfs.h       | 10 +++++-
 libbtrfs/ioctl.h                 |  1 +
 libbtrfsutil/btrfs.h             | 12 +++++--
 5 files changed, 77 insertions(+), 11 deletions(-)

diff --git a/Documentation/ch-compression.rst b/Documentation/ch-compression.rst
index a9ec8f1e..f7cdda86 100644
--- a/Documentation/ch-compression.rst
+++ b/Documentation/ch-compression.rst
@@ -25,8 +25,8 @@ LZO
         * good backward compatibility
 ZSTD
         * compression comparable to ZLIB with higher compression/decompression speeds and different ratio
-        * levels: 1 to 15, mapped directly (higher levels are not available)
-        * since 4.14, levels since 5.1
+        * levels: -15 to 15, mapped directly, default is 3
+        * since 4.14, levels 1 to 15 since 5.1, -15 to -1 since 6.15
 
 The differences depend on the actual data set and cannot be expressed by a
 single number or recommendation. Higher levels consume more CPU time and may
@@ -78,7 +78,7 @@ Compression levels
 
 The level support of ZLIB has been added in v4.14, LZO does not support levels
 (the kernel implementation provides only one), ZSTD level support has been added
-in v5.1.
+in v5.1 and negative levels since v6.15.
 
 There are 9 levels of ZLIB supported (1 to 9), mapping 1:1 from the mount option
 to the algorithm defined level. The default is level 3, which provides the
@@ -86,8 +86,8 @@ reasonably good compression ratio and is still reasonably fast. The difference
 in compression gain of levels 7, 8 and 9 is comparable but the higher levels
 take longer.
 
-The ZSTD support includes levels 1 to 15, a subset of full range of what ZSTD
-provides. Levels 1-3 are real-time, 4-8 slower with improved compression and
+The ZSTD support includes levels -15 to 15, a subset of full range of what ZSTD
+provides. Levels -15-3 are real-time, 4-8 slower with improved compression and
 9-15 try even harder though the resulting size may not be significantly improved.
 
 Level 0 always maps to the default. The compression level does not affect
diff --git a/cmds/filesystem.c b/cmds/filesystem.c
index d2605bda..f3f93ff7 100644
--- a/cmds/filesystem.c
+++ b/cmds/filesystem.c
@@ -962,6 +962,7 @@ static const char * const cmd_filesystem_defrag_usage[] = {
 	"",
 	OPTLINE("-r", "defragment files recursively"),
 	OPTLINE("-c[zlib,lzo,zstd]", "compress the file while defragmenting, optional parameter (no space in between)"),
+	OPTLINE("-L|--level level", "use given compression level if enabled (zlib supports levels 1-9, zstd -15-15, and 0 selects the default level)"),
 	OPTLINE("-f", "flush data to disk immediately after defragmenting"),
 	OPTLINE("-s start", "defragment only from byte onward"),
 	OPTLINE("-l len", "defragment only up to len bytes"),
@@ -1066,6 +1067,7 @@ static int cmd_filesystem_defrag(const struct cmd_struct *cmd,
 	bool recursive = false;
 	int ret = 0;
 	int compress_type = BTRFS_COMPRESS_NONE;
+	int compress_level = 0;
 
 	/*
 	 * Kernel 4.19+ supports defragmention of files open read-only,
@@ -1095,18 +1097,18 @@ static int cmd_filesystem_defrag(const struct cmd_struct *cmd,
 	if (bconf.verbose != BTRFS_BCONF_UNSET)
 		bconf.verbose++;
 
-	defrag_global_errors = 0;
 	defrag_global_errors = 0;
 	optind = 0;
 	while(1) {
 		enum { GETOPT_VAL_STEP = GETOPT_VAL_FIRST };
 		static const struct option long_options[] = {
+			{ "level", required_argument, NULL, 'L' },
 			{ "step", required_argument, NULL, GETOPT_VAL_STEP },
 			{ NULL, 0, NULL, 0 }
 		};
 		int c;
 
-		c = getopt_long(argc, argv, "vrc::fs:l:t:", long_options, NULL);
+		c = getopt_long(argc, argv, "vrc::L:fs:l:t:", long_options, NULL);
 		if (c < 0)
 			break;
 
@@ -1116,6 +1118,18 @@ static int cmd_filesystem_defrag(const struct cmd_struct *cmd,
 			if (optarg)
 				compress_type = parse_compress_type_arg(optarg);
 			break;
+		case 'L':
+			/*
+			 * Do not enforce any limits here, kernel will do itself
+			 * based on what's supported by the running version.
+			 * Just clip to the s8 type of the API.
+			 */
+			compress_level = atoi(optarg);
+			if (compress_level < -128)
+				compress_level = -128;
+			else if (compress_level > 127)
+				compress_level = 127;
+			break;
 		case 'f':
 			flush = true;
 			break;
@@ -1165,7 +1179,12 @@ static int cmd_filesystem_defrag(const struct cmd_struct *cmd,
 	defrag_global_range.extent_thresh = (u32)thresh;
 	if (compress_type) {
 		defrag_global_range.flags |= BTRFS_DEFRAG_RANGE_COMPRESS;
-		defrag_global_range.compress_type = compress_type;
+		if (compress_level) {
+			defrag_global_range.flags |= BTRFS_DEFRAG_RANGE_COMPRESS_LEVEL;
+			defrag_global_range.compress.type = compress_type;
+			defrag_global_range.compress.level= compress_level;
+		} else
+			defrag_global_range.compress_type = compress_type;
 	}
 	if (flush)
 		defrag_global_range.flags |= BTRFS_DEFRAG_RANGE_START_IO;
diff --git a/kernel-shared/uapi/btrfs.h b/kernel-shared/uapi/btrfs.h
index 6649436c..d2609777 100644
--- a/kernel-shared/uapi/btrfs.h
+++ b/kernel-shared/uapi/btrfs.h
@@ -645,7 +645,9 @@ _static_assert(sizeof(struct btrfs_ioctl_clone_range_args) == 32);
  */
 #define BTRFS_DEFRAG_RANGE_COMPRESS 1
 #define BTRFS_DEFRAG_RANGE_START_IO 2
+#define BTRFS_DEFRAG_RANGE_COMPRESS_LEVEL 4
 #define BTRFS_DEFRAG_RANGE_FLAGS_SUPP	(BTRFS_DEFRAG_RANGE_COMPRESS |		\
+					 BTRFS_DEFRAG_RANGE_COMPRESS_LEVEL |	\
 					 BTRFS_DEFRAG_RANGE_START_IO)
 
 struct btrfs_ioctl_defrag_range_args {
@@ -673,7 +675,13 @@ struct btrfs_ioctl_defrag_range_args {
 	 * for this defrag operation.  If unspecified, zlib will
 	 * be used
 	 */
-	__u32 compress_type;
+	union {
+		__u32 compress_type;
+		struct {
+			__u8 type;
+			__s8 level;
+		} compress;
+	};
 
 	/* spare for later */
 	__u32 unused[4];
diff --git a/libbtrfs/ioctl.h b/libbtrfs/ioctl.h
index 7b53a531..08681f2e 100644
--- a/libbtrfs/ioctl.h
+++ b/libbtrfs/ioctl.h
@@ -398,6 +398,7 @@ struct btrfs_ioctl_clone_range_args {
 /* flags for the defrag range ioctl */
 #define BTRFS_DEFRAG_RANGE_COMPRESS 1
 #define BTRFS_DEFRAG_RANGE_START_IO 2
+#define BTRFS_DEFRAG_RANGE_COMPRESS_LEVEL 4
 
 #define BTRFS_SAME_DATA_DIFFERS	1
 /* For extent-same ioctl */
diff --git a/libbtrfsutil/btrfs.h b/libbtrfsutil/btrfs.h
index 8e5681c7..ebc9fc2a 100644
--- a/libbtrfsutil/btrfs.h
+++ b/libbtrfsutil/btrfs.h
@@ -608,7 +608,9 @@ struct btrfs_ioctl_clone_range_args {
  */
 #define BTRFS_DEFRAG_RANGE_COMPRESS 1
 #define BTRFS_DEFRAG_RANGE_START_IO 2
+#define BTRFS_DEFRAG_RANGE_COMPRESS_LEVEL 4
 #define BTRFS_DEFRAG_RANGE_FLAGS_SUPP	(BTRFS_DEFRAG_RANGE_COMPRESS |		\
+					 BTRFS_DEFRAG_RANGE_COMPRESS_LEVEL |	\
 					 BTRFS_DEFRAG_RANGE_START_IO)
 
 struct btrfs_ioctl_defrag_range_args {
@@ -636,7 +638,13 @@ struct btrfs_ioctl_defrag_range_args {
 	 * for this defrag operation.  If unspecified, zlib will
 	 * be used
 	 */
-	__u32 compress_type;
+	union {
+		__u32 compress_type;
+		struct {
+			__u8 type;
+			__s8 level;
+		} compress;
+	};
 
 	/* spare for later */
 	__u32 unused[4];
-- 
2.43.0


