Return-Path: <linux-btrfs+bounces-14031-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 227ECAB7F89
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 May 2025 10:01:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D8F471BA7199
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 May 2025 08:01:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E80D283FD7;
	Thu, 15 May 2025 08:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="hFo7uh0A";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="hFo7uh0A"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D644E2820D1
	for <linux-btrfs@vger.kernel.org>; Thu, 15 May 2025 08:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747296064; cv=none; b=nvwYccdVtcBL1Tx0ksxM0YfvqEtS8jW7lrYVulI1wq6N1Mvl+R/soHMSx1HIs9HIPh4Xk0w7PPE7sJ+CstpGizMbUkCspzz/aDW/HeS6lJsksZ5XijvjeY2Zf3+xl8d5ZVfwhrPMEGADwKxApH7r6WWzXZGtBw7oi66h53qB/SY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747296064; c=relaxed/simple;
	bh=jTMtP3fKYxehcwuErvosobjLm3vh4AVWngzxsYzO5NQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nrOyuy6zQbhm2zQEB+Ovb3TIvN/TYmQ/8j8D35kAxZMgMDVsTD/5XXdGXe7r1AcnbcgcraOjNl14rTR5URb7w9UPNyx4Ym88e6XUF92FYsohOkwGVbYxoKh3xWt70PhfwTO5w8AZwJmna5yN2z+aZpnnfQf7N0SR3D81ZYr0E68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=hFo7uh0A; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=hFo7uh0A; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D036121202
	for <linux-btrfs@vger.kernel.org>; Thu, 15 May 2025 08:00:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1747296044; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ps3XT5HpyyQVIPP+Ywu8B/eXxwvxkBdfc257RIPR+EI=;
	b=hFo7uh0AlPgBHH6aWygdjPDQSPDSL5gBzuXDCFl17Ey/e2tLYRIT41bQQcEIPZ0NFZFo7N
	KrJjTkrO74igeZm7e+sf15NjjBiVaLit+UUA01PtSHyBwluFaUjn1MA7SnyBsSzLZ7w5+A
	DIBLYeTOu/Ona7YXxyh0Skp4wwDm/Io=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=hFo7uh0A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1747296044; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ps3XT5HpyyQVIPP+Ywu8B/eXxwvxkBdfc257RIPR+EI=;
	b=hFo7uh0AlPgBHH6aWygdjPDQSPDSL5gBzuXDCFl17Ey/e2tLYRIT41bQQcEIPZ0NFZFo7N
	KrJjTkrO74igeZm7e+sf15NjjBiVaLit+UUA01PtSHyBwluFaUjn1MA7SnyBsSzLZ7w5+A
	DIBLYeTOu/Ona7YXxyh0Skp4wwDm/Io=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 17062137E8
	for <linux-btrfs@vger.kernel.org>; Thu, 15 May 2025 08:00:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id YDSTMiufJWi8LwAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Thu, 15 May 2025 08:00:43 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2 4/6] btrfs-progs: fix-data-checksum: introduce interactive mode
Date: Thu, 15 May 2025 17:30:19 +0930
Message-ID: <c0f551f03f8d81e2a46e35a08339ef096b46984f.1747295965.git.wqu@suse.com>
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
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: D036121202
X-Spam-Flag: NO
X-Spam-Score: -3.01
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
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Action: no action

This mode will ask user for how to fix each block.

User input can match the first letter or the whole action name to
specify given action, the input is verified case insensitive.

If no user input is provided, the default action is to ignore the
corrupted block.

If the input matches no action, a warning is outputted and user must
retry until a valid input is provided.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 Documentation/btrfs-rescue.rst  |  3 ++
 cmds/rescue-fix-data-checksum.c | 69 ++++++++++++++++++++++++++++++++-
 cmds/rescue.c                   |  9 ++++-
 cmds/rescue.h                   |  1 +
 4 files changed, 78 insertions(+), 4 deletions(-)

diff --git a/Documentation/btrfs-rescue.rst b/Documentation/btrfs-rescue.rst
index 7a237ba8ebbb..0e6da4397f51 100644
--- a/Documentation/btrfs-rescue.rst
+++ b/Documentation/btrfs-rescue.rst
@@ -69,6 +69,9 @@ fix-data-checksum <device>
 		readonly mode, only scan and report for data checksum mismatch,
 		do no repair
 
+	-i|--interactive
+		interactive mode, ask for how to repair, ignore the error by default
+
 .. _man-rescue-clear-ino-cache:
 
 clear-ino-cache <device>
diff --git a/cmds/rescue-fix-data-checksum.c b/cmds/rescue-fix-data-checksum.c
index bf3a65b31c71..9a4f3fd73aaf 100644
--- a/cmds/rescue-fix-data-checksum.c
+++ b/cmds/rescue-fix-data-checksum.c
@@ -14,6 +14,7 @@
  * Boston, MA 021110-1307, USA.
  */
 
+#include <ctype.h>
 #include "kerncompat.h"
 #include "kernel-shared/disk-io.h"
 #include "kernel-shared/ctree.h"
@@ -45,6 +46,21 @@ struct corrupted_block {
 	unsigned long *error_mirror_bitmap;
 };
 
+enum fix_data_checksum_action_value {
+	ACTION_IGNORE,
+	ACTION_LAST,
+};
+
+static const struct fix_data_checksum_action {
+	enum fix_data_checksum_action_value value;
+	const char *string;
+} actions[] = {
+	[ACTION_IGNORE] = {
+		.value = ACTION_IGNORE,
+		.string = "ignore",
+	},
+};
+
 static int global_repair_mode;
 LIST_HEAD(corrupted_blocks);
 
@@ -241,10 +257,49 @@ next:
 	return ret;
 }
 
-static void report_corrupted_blocks(struct btrfs_fs_info *fs_info)
+#define ASK_ACTION_BUFSIZE	(32)
+static enum fix_data_checksum_action_value ask_action()
+{
+	char buf[ASK_ACTION_BUFSIZE] = { 0 };
+	bool printed;
+
+again:
+	printed = false;
+	for (int i = 0; i < ACTION_LAST; i++) {
+		if (printed)
+			printf("/");
+		/* Mark Ignore as default */
+		if (i == ACTION_IGNORE)
+			printf("<<%c>>%s", toupper(actions[i].string[0]),
+			       actions[i].string + 1);
+		else
+			printf("<%c>%s", toupper(actions[i].string[0]),
+			       actions[i].string + 1);
+	}
+	printf(":");
+	fflush(stdout);
+	/* Default to Ignore if no action provided. */
+	if (!fgets(buf, sizeof(buf) - 1, stdin))
+		return ACTION_IGNORE;
+	if (buf[0] == '\n')
+		return ACTION_IGNORE;
+	/* Check exact match or matching the initial letter. */
+	for (int i = 0; i < ACTION_LAST; i++) {
+		if (strncasecmp(buf, actions[i].string, 1) == 0 ||
+		    strncasecmp(buf, actions[i].string, ASK_ACTION_BUFSIZE) == 0)
+			return actions[i].value;
+	}
+	/* No valid action found, retry. */
+	warning("invalid action, please retry");
+	goto again;
+}
+
+static void report_corrupted_blocks(struct btrfs_fs_info *fs_info,
+				    enum btrfs_fix_data_checksum_mode mode)
 {
 	struct corrupted_block *entry;
 	struct btrfs_path path = { 0 };
+	enum fix_data_checksum_action_value action;
 
 	if (list_empty(&corrupted_blocks)) {
 		printf("No data checksum mismatch found\n");
@@ -277,6 +332,16 @@ static void report_corrupted_blocks(struct btrfs_fs_info *fs_info)
 			error("failed to iterate involved files: %m");
 			break;
 		}
+		switch (mode) {
+		case BTRFS_FIX_DATA_CSUMS_INTERACTIVE:
+			action = ask_action();
+			UASSERT(action == ACTION_IGNORE);
+			fallthrough;
+		case BTRFS_FIX_DATA_CSUMS_READONLY:
+			break;
+		default:
+			UASSERT(0);
+		}
 	}
 }
 
@@ -333,7 +398,7 @@ int btrfs_recover_fix_data_checksum(const char *path,
 		errno = -ret;
 		error("failed to iterate csum tree: %m");
 	}
-	report_corrupted_blocks(fs_info);
+	report_corrupted_blocks(fs_info, mode);
 out_close:
 	free_corrupted_blocks();
 	close_ctree_fs_info(fs_info);
diff --git a/cmds/rescue.c b/cmds/rescue.c
index 0d3f86f7e8d6..0c19de47895a 100644
--- a/cmds/rescue.c
+++ b/cmds/rescue.c
@@ -280,7 +280,8 @@ static const char * const cmd_rescue_fix_data_checksum_usage[] = {
 	"btrfs rescue fix-data-checksum <device>",
 	"Fix data checksum mismatches.",
 	"",
-	OPTLINE("-r", "readonly mode, only report errors without repair"),
+	OPTLINE("-r|--readonly", "readonly mode, only report errors without repair"),
+	OPTLINE("-i|--interactive", "interactive mode, ignore the error by default."),
 	HELPINFO_INSERT_GLOBALS,
 	HELPINFO_INSERT_VERBOSE,
 	NULL
@@ -298,15 +299,19 @@ static int cmd_rescue_fix_data_checksum(const struct cmd_struct *cmd,
 		enum { GETOPT_VAL_DRYRUN = GETOPT_VAL_FIRST, };
 		static const struct option long_options [] = {
 			{"readonly", no_argument, NULL, 'r'},
+			{"interactive", no_argument, NULL, 'i'},
 			{"NULL", 0, NULL, 0},
 		};
-		c = getopt_long(argc, argv, "r", long_options, NULL);
+		c = getopt_long(argc, argv, "ri", long_options, NULL);
 		if (c < 0)
 			break;
 		switch (c) {
 		case 'r':
 			mode = BTRFS_FIX_DATA_CSUMS_READONLY;
 			break;
+		case 'i':
+			mode = BTRFS_FIX_DATA_CSUMS_INTERACTIVE;
+			break;
 		default:
 			usage_unknown_option(cmd, argv);
 		}
diff --git a/cmds/rescue.h b/cmds/rescue.h
index 331b595f1c6f..4ae43cbb4cd4 100644
--- a/cmds/rescue.h
+++ b/cmds/rescue.h
@@ -22,6 +22,7 @@
 
 enum btrfs_fix_data_checksum_mode {
 	BTRFS_FIX_DATA_CSUMS_READONLY,
+	BTRFS_FIX_DATA_CSUMS_INTERACTIVE,
 	BTRFS_FIX_DATA_CSUMS_LAST,
 };
 
-- 
2.49.0


