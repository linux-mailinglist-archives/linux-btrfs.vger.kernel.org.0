Return-Path: <linux-btrfs+bounces-14032-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C62DAB7F8C
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 May 2025 10:02:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D03F3AF856
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 May 2025 08:01:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0724828689F;
	Thu, 15 May 2025 08:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="iZ899m8Q";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="iZ899m8Q"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C003283FD6
	for <linux-btrfs@vger.kernel.org>; Thu, 15 May 2025 08:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747296067; cv=none; b=gVDHFwX6/XZFOhtWdCNlVDPd0A/MsQkB0QFNVsVi9b+k8XW7DwvrB79cS43LIkabXGK7M2Cv0PD4H1lERBtOeD6/HUq/dj0x93NxZTtK0H7nibIR/wIT5PRIoUWJxADybGW+T7K5cCKeA4g49pblzvb6NLJVnLG2swMkpqUnqjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747296067; c=relaxed/simple;
	bh=BuvcqRqJdCkE5ddDLmmVVpTyDt2Y16NCMCIwELG2Fyg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UbWVQBLnsTifZEGZA8/jYwkyhWrcklkzBfQ1GK+Jr5nUNq47jhQ8HVKIo9CFHQHm6USsiCeOz1ss7EiqPdO8Yx91wktXcFirVn+FMdIQRSa6r5g+Q6auGTgvD5pOW/V3l6q7hNTlNNmmxNvKks3YrssZ30LzeGlVIoh4wvYPfRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=iZ899m8Q; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=iZ899m8Q; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 4DCE41F7C2
	for <linux-btrfs@vger.kernel.org>; Thu, 15 May 2025 08:00:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1747296047; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1J5V74dppnnkzliHg2HSJbhPLQqd7EzJmDiLLQZYTa8=;
	b=iZ899m8QUh1Ph65LU2f8PbKWU9GB8YEQr8fReKKILkFYyzJ7nyyw6Q+zqYNcs7MjEg6jHb
	oqnk6VMYeorfoUHOJgC7BXBfeAOoEy5TnbwwsGDEFWXvMQ+mmmnu4y/dJ/Blr2zKZL3HTl
	HSHaGQPDT8ixV+iBuoDGzXh43sOWyqI=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1747296047; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1J5V74dppnnkzliHg2HSJbhPLQqd7EzJmDiLLQZYTa8=;
	b=iZ899m8QUh1Ph65LU2f8PbKWU9GB8YEQr8fReKKILkFYyzJ7nyyw6Q+zqYNcs7MjEg6jHb
	oqnk6VMYeorfoUHOJgC7BXBfeAOoEy5TnbwwsGDEFWXvMQ+mmmnu4y/dJ/Blr2zKZL3HTl
	HSHaGQPDT8ixV+iBuoDGzXh43sOWyqI=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 88150137E8
	for <linux-btrfs@vger.kernel.org>; Thu, 15 May 2025 08:00:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 2PmdEi6fJWi8LwAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Thu, 15 May 2025 08:00:46 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2 6/6] btrfs-progs: fix-data-checksum: introduce -m|--mirror option
Date: Thu, 15 May 2025 17:30:21 +0930
Message-ID: <a6bf1b14874518bda30a6001fe716e166b51bf62.1747295965.git.wqu@suse.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1747295965.git.wqu@suse.com>
References: <cover.1747295965.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Score: -2.80

This option allows "btrfs rescue fix-data-checksum" to use the specified
mirror number to update checksum item for all corrupted mirrors.

If the specified number is larger than the max number of mirrors, the
real mirror number will be `num % (num_mirrors + 1)`.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 Documentation/btrfs-rescue.rst  |  6 ++++++
 cmds/rescue-fix-data-checksum.c | 16 ++++++++++++----
 cmds/rescue.c                   | 16 ++++++++++++++--
 cmds/rescue.h                   |  4 +++-
 4 files changed, 35 insertions(+), 7 deletions(-)

diff --git a/Documentation/btrfs-rescue.rst b/Documentation/btrfs-rescue.rst
index 0e6da4397f51..7fc2bde590d2 100644
--- a/Documentation/btrfs-rescue.rst
+++ b/Documentation/btrfs-rescue.rst
@@ -72,6 +72,12 @@ fix-data-checksum <device>
 	-i|--interactive
 		interactive mode, ask for how to repair, ignore the error by default
 
+	-m|--mirror <num>
+		use specified mirror to update the checksum item for all corrupted blocks.
+
+		The value must be >= 1, and if the corrupted block has less mirrors than
+		the value, the mirror number will be `num % (num_mirrors + 1)`.
+
 .. _man-rescue-clear-ino-cache:
 
 clear-ino-cache <device>
diff --git a/cmds/rescue-fix-data-checksum.c b/cmds/rescue-fix-data-checksum.c
index 86924d61823e..23b59fffe2f7 100644
--- a/cmds/rescue-fix-data-checksum.c
+++ b/cmds/rescue-fix-data-checksum.c
@@ -381,7 +381,8 @@ out:
 }
 
 static void report_corrupted_blocks(struct btrfs_fs_info *fs_info,
-				    enum btrfs_fix_data_checksum_mode mode)
+				    enum btrfs_fix_data_checksum_mode mode,
+				    unsigned int mirror)
 {
 	struct corrupted_block *entry;
 	struct btrfs_path path = { 0 };
@@ -393,7 +394,6 @@ static void report_corrupted_blocks(struct btrfs_fs_info *fs_info,
 	}
 
 	list_for_each_entry(entry, &corrupted_blocks, list) {
-		unsigned int mirror;
 		bool has_printed = false;
 		int ret;
 
@@ -426,6 +426,10 @@ static void report_corrupted_blocks(struct btrfs_fs_info *fs_info,
 		case BTRFS_FIX_DATA_CSUMS_READONLY:
 			action = ACTION_IGNORE;
 			break;
+		case BTRFS_FIX_DATA_CSUMS_UPDATE_CSUM_ITEM:
+			action = ACTION_UPDATE_CSUM;
+			mirror = mirror % (entry->num_mirrors + 1);
+			break;
 		default:
 			UASSERT(0);
 		}
@@ -434,6 +438,7 @@ static void report_corrupted_blocks(struct btrfs_fs_info *fs_info,
 		case ACTION_IGNORE:
 			break;
 		case ACTION_UPDATE_CSUM:
+			UASSERT(mirror > 0 && mirror <= entry->num_mirrors);
 			ret = update_csum_item(fs_info, entry->logical, mirror);
 			break;
 		default:
@@ -455,7 +460,8 @@ static void free_corrupted_blocks(void)
 }
 
 int btrfs_recover_fix_data_checksum(const char *path,
-				    enum btrfs_fix_data_checksum_mode mode)
+				    enum btrfs_fix_data_checksum_mode mode,
+				    unsigned int mirror)
 {
 	struct btrfs_fs_info *fs_info;
 	struct btrfs_root *csum_root;
@@ -465,6 +471,8 @@ int btrfs_recover_fix_data_checksum(const char *path,
 	if (mode >= BTRFS_FIX_DATA_CSUMS_LAST)
 		return -EINVAL;
 
+	if (mode == BTRFS_FIX_DATA_CSUMS_UPDATE_CSUM_ITEM)
+		UASSERT(mirror > 0);
 	ret = check_mounted(path);
 	if (ret < 0) {
 		errno = -ret;
@@ -495,7 +503,7 @@ int btrfs_recover_fix_data_checksum(const char *path,
 		errno = -ret;
 		error("failed to iterate csum tree: %m");
 	}
-	report_corrupted_blocks(fs_info, mode);
+	report_corrupted_blocks(fs_info, mode, mirror);
 out_close:
 	free_corrupted_blocks();
 	close_ctree_fs_info(fs_info);
diff --git a/cmds/rescue.c b/cmds/rescue.c
index 0c19de47895a..f575646c735a 100644
--- a/cmds/rescue.c
+++ b/cmds/rescue.c
@@ -31,6 +31,7 @@
 #include "kernel-shared/extent_io.h"
 #include "kernel-shared/accessors.h"
 #include "kernel-shared/uapi/btrfs_tree.h"
+#include "common/string-utils.h"
 #include "common/messages.h"
 #include "common/utils.h"
 #include "common/help.h"
@@ -282,6 +283,7 @@ static const char * const cmd_rescue_fix_data_checksum_usage[] = {
 	"",
 	OPTLINE("-r|--readonly", "readonly mode, only report errors without repair"),
 	OPTLINE("-i|--interactive", "interactive mode, ignore the error by default."),
+	OPTLINE("-m|--mirror <mirror>", "update csum item using specified mirror"),
 	HELPINFO_INSERT_GLOBALS,
 	HELPINFO_INSERT_VERBOSE,
 	NULL
@@ -291,6 +293,7 @@ static int cmd_rescue_fix_data_checksum(const struct cmd_struct *cmd,
 					int argc, char **argv)
 {
 	enum btrfs_fix_data_checksum_mode mode = BTRFS_FIX_DATA_CSUMS_READONLY;
+	unsigned int mirror = 0;
 	int ret;
 	optind = 0;
 
@@ -300,9 +303,10 @@ static int cmd_rescue_fix_data_checksum(const struct cmd_struct *cmd,
 		static const struct option long_options [] = {
 			{"readonly", no_argument, NULL, 'r'},
 			{"interactive", no_argument, NULL, 'i'},
+			{"mirror", required_argument, NULL, 'm'},
 			{"NULL", 0, NULL, 0},
 		};
-		c = getopt_long(argc, argv, "ri", long_options, NULL);
+		c = getopt_long(argc, argv, "rim:", long_options, NULL);
 		if (c < 0)
 			break;
 		switch (c) {
@@ -312,13 +316,21 @@ static int cmd_rescue_fix_data_checksum(const struct cmd_struct *cmd,
 		case 'i':
 			mode = BTRFS_FIX_DATA_CSUMS_INTERACTIVE;
 			break;
+		case 'm':
+			mode = BTRFS_FIX_DATA_CSUMS_UPDATE_CSUM_ITEM;
+			mirror = arg_strtou64(optarg);
+			if (mirror == 0) {
+				error("invalid mirror number %u, must be >= 1", mirror);
+				return 1;
+			}
+			break;
 		default:
 			usage_unknown_option(cmd, argv);
 		}
 	}
 	if (check_argc_min(argc - optind, 1))
 		return 1;
-	ret = btrfs_recover_fix_data_checksum(argv[optind], mode);
+	ret = btrfs_recover_fix_data_checksum(argv[optind], mode, mirror);
 	if (ret < 0) {
 		errno = -ret;
 		error("failed to fix data checksums: %m");
diff --git a/cmds/rescue.h b/cmds/rescue.h
index 4ae43cbb4cd4..f78ec436a908 100644
--- a/cmds/rescue.h
+++ b/cmds/rescue.h
@@ -23,12 +23,14 @@
 enum btrfs_fix_data_checksum_mode {
 	BTRFS_FIX_DATA_CSUMS_READONLY,
 	BTRFS_FIX_DATA_CSUMS_INTERACTIVE,
+	BTRFS_FIX_DATA_CSUMS_UPDATE_CSUM_ITEM,
 	BTRFS_FIX_DATA_CSUMS_LAST,
 };
 
 int btrfs_recover_superblocks(const char *path, int yes);
 int btrfs_recover_chunk_tree(const char *path, int yes);
 int btrfs_recover_fix_data_checksum(const char *path,
-				    enum btrfs_fix_data_checksum_mode mode);
+				    enum btrfs_fix_data_checksum_mode mode,
+				    unsigned int mirror);
 
 #endif
-- 
2.49.0


