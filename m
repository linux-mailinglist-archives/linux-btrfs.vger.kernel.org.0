Return-Path: <linux-btrfs+bounces-15395-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68709AFEDC2
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Jul 2025 17:29:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA8963B36FC
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Jul 2025 15:29:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C1AA2E7F07;
	Wed,  9 Jul 2025 15:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="eJ9EN49V";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="eJ9EN49V"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B541D156F4A
	for <linux-btrfs@vger.kernel.org>; Wed,  9 Jul 2025 15:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752074975; cv=none; b=O0Pv4DQrgYpNFJchtTSmyqGE0QVgxIixmLQcjCsqPSQU8nFzIk4RM4bEXm2c7XlahzxDkn2AX3JN/Ie151knTuD/wmkgsdLiczasyzM5FAQt0FUY7YMHQgOKdFM5TpVEBRO6xOQnwOD01Lkh3mKsIF+q4Q78/MgTLLqG83Wn0a0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752074975; c=relaxed/simple;
	bh=HxK6U7Gv7GbzO6U2KaVkZcRP0ddcoyVpIiFhMnXYZaE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eMekUI7N84uFHD7c1eiiei9SYkWDbj9Res9I77/6LVud6C5PoUajX6Yb8vpVtHDv7eSRm9QtnG8mW8klcUlkF/U0d7s2qWKJWEoWvCI7RojLsGRkhO7HKfuW6wILh1MJUk2O3WXTkkbFIZZ+GxIsDttgRA8quTFx1gymN045kSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=eJ9EN49V; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=eJ9EN49V; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 6AEEB1F7A5;
	Wed,  9 Jul 2025 15:29:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1752074969; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=eZzU5f6TYKN23YX81N0SWZHr8cmK5emQPipzdqhzHww=;
	b=eJ9EN49Vw6/xtj/9msTFhwzxWVllaG6lw3cmE1wv9sWGbBtPLpeehYdIeq91EoN4mg+WED
	1MshVUBuTcnjVihLiTFb67k0DNGjpCxiEKlZZxAGn3ElMUvO/aQ/52vfOJLe99rp1uaCId
	KWrHioVRcccPyPLRx9tTwIfGbw1IFb0=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1752074969; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=eZzU5f6TYKN23YX81N0SWZHr8cmK5emQPipzdqhzHww=;
	b=eJ9EN49Vw6/xtj/9msTFhwzxWVllaG6lw3cmE1wv9sWGbBtPLpeehYdIeq91EoN4mg+WED
	1MshVUBuTcnjVihLiTFb67k0DNGjpCxiEKlZZxAGn3ElMUvO/aQ/52vfOJLe99rp1uaCId
	KWrHioVRcccPyPLRx9tTwIfGbw1IFb0=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6411B136DC;
	Wed,  9 Jul 2025 15:29:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id VlRsGNmKbmijBAAAD6G6ig
	(envelope-from <dsterba@suse.com>); Wed, 09 Jul 2025 15:29:29 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH] btrfs-progs: defrag: new option --nocomp to do no-compression defrag
Date: Wed,  9 Jul 2025 17:29:28 +0200
Message-ID: <20250709152928.1055-1-dsterba@suse.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:mid];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Score: -2.80

Add new option --nocomp to set flag which will tell kernel to defragment
file extents without compression and decompress existing extents if
needed. The defrag setting will override any current compression
settings like mount options or file properties.  The option is separate
from '-c' so it's more obvious it's mutually exclusive.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 Documentation/btrfs-filesystem.rst |  2 ++
 cmds/filesystem.c                  | 19 ++++++++++++++++++-
 kernel-shared/uapi/btrfs.h         |  2 ++
 libbtrfsutil/btrfs.h               |  2 ++
 4 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/Documentation/btrfs-filesystem.rst b/Documentation/btrfs-filesystem.rst
index 5852b4e6ddb7c4..146d88b65bbdff 100644
--- a/Documentation/btrfs-filesystem.rst
+++ b/Documentation/btrfs-filesystem.rst
@@ -124,6 +124,8 @@ defragment [options] <file>|<dir> [<file>|<dir>...]
                 1..9, *lzo* does not have any levels, *zstd* the standard levels 1..15 and also the
                 realtime -1..-15.
 
+        --nocomp
+                Do not compress while defragmenting, uncompress extents if needed.
         -r
                 defragment files recursively in given directories, does not descend to
                 subvolumes or mount points
diff --git a/cmds/filesystem.c b/cmds/filesystem.c
index 54a186f023c218..40c4ee9d92581e 100644
--- a/cmds/filesystem.c
+++ b/cmds/filesystem.c
@@ -948,6 +948,7 @@ static const char * const cmd_filesystem_defrag_usage[] = {
 	OPTLINE("-r", "defragment files recursively"),
 	OPTLINE("-c[zlib,lzo,zstd]", "compress the file while defragmenting, optional parameter (no space in between)"),
 	OPTLINE("-L|--level level", "use given compression level if enabled (zlib: 1..9, zstd: -15..15, and 0 selects the default level)"),
+	OPTLINE("--nocomp", "don't compress while defragmenting (uncompress if needed)"),
 	OPTLINE("-f", "flush data to disk immediately after defragmenting"),
 	OPTLINE("-s start", "defragment only from byte onward"),
 	OPTLINE("-l len", "defragment only up to len bytes"),
@@ -1053,6 +1054,7 @@ static int cmd_filesystem_defrag(const struct cmd_struct *cmd,
 	int ret = 0;
 	int compress_type = BTRFS_COMPRESS_NONE;
 	int compress_level = 0;
+	bool opt_nocomp = false;
 
 	/*
 	 * Kernel 4.19+ supports defragmention of files open read-only,
@@ -1085,10 +1087,11 @@ static int cmd_filesystem_defrag(const struct cmd_struct *cmd,
 	defrag_global_errors = 0;
 	optind = 0;
 	while(1) {
-		enum { GETOPT_VAL_STEP = GETOPT_VAL_FIRST };
+		enum { GETOPT_VAL_STEP = GETOPT_VAL_FIRST, GETOPT_VAL_NOCOMP };
 		static const struct option long_options[] = {
 			{ "level", required_argument, NULL, 'L' },
 			{ "step", required_argument, NULL, GETOPT_VAL_STEP },
+			{ "nocomp", no_argument, NULL, GETOPT_VAL_NOCOMP },
 			{ NULL, 0, NULL, 0 }
 		};
 		int c;
@@ -1099,6 +1102,11 @@ static int cmd_filesystem_defrag(const struct cmd_struct *cmd,
 
 		switch(c) {
 		case 'c':
+			if (opt_nocomp) {
+				error("cannot use compression with --nocomp");
+				return 1;
+			}
+
 			compress_type = BTRFS_COMPRESS_ZLIB;
 			if (optarg)
 				compress_type = parse_compress_type_arg(optarg);
@@ -1142,6 +1150,13 @@ static int cmd_filesystem_defrag(const struct cmd_struct *cmd,
 		case 'r':
 			recursive = true;
 			break;
+		case GETOPT_VAL_NOCOMP:
+			if (compress_level != BTRFS_COMPRESS_NONE) {
+				error("cannot use --nocomp with compression set");
+				return 1;
+			}
+			opt_nocomp = true;
+			break;
 		case GETOPT_VAL_STEP:
 			defrag_global_step = arg_strtou64_with_suffix(optarg);
 			if (defrag_global_step < SZ_256K) {
@@ -1171,6 +1186,8 @@ static int cmd_filesystem_defrag(const struct cmd_struct *cmd,
 		} else
 			defrag_global_range.compress_type = compress_type;
 	}
+	if (opt_nocomp)
+		defrag_global_range.flags |= BTRFS_DEFRAG_RANGE_NOCOMPRESS;
 	if (flush)
 		defrag_global_range.flags |= BTRFS_DEFRAG_RANGE_START_IO;
 
diff --git a/kernel-shared/uapi/btrfs.h b/kernel-shared/uapi/btrfs.h
index 9d536cb66b0934..11ab1120c0a1c8 100644
--- a/kernel-shared/uapi/btrfs.h
+++ b/kernel-shared/uapi/btrfs.h
@@ -646,8 +646,10 @@ _static_assert(sizeof(struct btrfs_ioctl_clone_range_args) == 32);
 #define BTRFS_DEFRAG_RANGE_COMPRESS 1
 #define BTRFS_DEFRAG_RANGE_START_IO 2
 #define BTRFS_DEFRAG_RANGE_COMPRESS_LEVEL 4
+#define BTRFS_DEFRAG_RANGE_NOCOMPRESS 8
 #define BTRFS_DEFRAG_RANGE_FLAGS_SUPP	(BTRFS_DEFRAG_RANGE_COMPRESS |		\
 					 BTRFS_DEFRAG_RANGE_COMPRESS_LEVEL |	\
+					 BTRFS_DEFRAG_RANGE_NOCOMPRESS |	\
 					 BTRFS_DEFRAG_RANGE_START_IO)
 
 struct btrfs_ioctl_defrag_range_args {
diff --git a/libbtrfsutil/btrfs.h b/libbtrfsutil/btrfs.h
index 984c962fbd3d88..29320b5c0f7ae9 100644
--- a/libbtrfsutil/btrfs.h
+++ b/libbtrfsutil/btrfs.h
@@ -609,8 +609,10 @@ struct btrfs_ioctl_clone_range_args {
 #define BTRFS_DEFRAG_RANGE_COMPRESS 1
 #define BTRFS_DEFRAG_RANGE_START_IO 2
 #define BTRFS_DEFRAG_RANGE_COMPRESS_LEVEL 4
+#define BTRFS_DEFRAG_RANGE_NOCOMPRESS 8
 #define BTRFS_DEFRAG_RANGE_FLAGS_SUPP	(BTRFS_DEFRAG_RANGE_COMPRESS |		\
 					 BTRFS_DEFRAG_RANGE_COMPRESS_LEVEL |	\
+					 BTRFS_DEFRAG_RANGE_NOCOMPRESS |	\
 					 BTRFS_DEFRAG_RANGE_START_IO)
 
 struct btrfs_ioctl_defrag_range_args {
-- 
2.49.0


