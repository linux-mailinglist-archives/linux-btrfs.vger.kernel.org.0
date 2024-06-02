Return-Path: <linux-btrfs+bounces-5389-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A2418D7383
	for <lists+linux-btrfs@lfdr.de>; Sun,  2 Jun 2024 05:46:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8EA6F1F23612
	for <lists+linux-btrfs@lfdr.de>; Sun,  2 Jun 2024 03:46:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0120F18622;
	Sun,  2 Jun 2024 03:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="qQSqAMI4";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="qQSqAMI4"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37223A94C
	for <linux-btrfs@vger.kernel.org>; Sun,  2 Jun 2024 03:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717299968; cv=none; b=NoY+DFR3BsPt7iuG7HzlyjVNm+Am9OkZDzTDBMUFYP/c8d/rIQXuBWj1iVB3FJxCDclfwRu1Gaqhk1JOKSKVaVWl/bcnRGSrnHx3nMCXp/8eV2YC39qFQDluukJGUqyf+81IdhnKjKvTomyVIcjn4i72qIoTDEpKdAz18Vl54a4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717299968; c=relaxed/simple;
	bh=5HlY4oh1qCVFW530XvISSnenRt6Glk2+VlWN4vlNHJ0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aHmlhNZjpORc67FBt8eHIfQjlxjH9Ag0Nxb7ZF+ALzQg+P2WF3B4rKuPoLzBF0TamaQKkYjKwSLCtEAjMTAZaXOwmr1a/qaMNlU/leQt5OQpk9k6jtkbFyUvM+j8TaOZ1RTbRxlYGuk0rDQOx9fr94oH4TGRE0t6UunUSgek2Yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=qQSqAMI4; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=qQSqAMI4; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 46750220DC
	for <linux-btrfs@vger.kernel.org>; Sun,  2 Jun 2024 03:45:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1717299958; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rz7QKazTArIXWRByw10UZtCyaz2fqLpjF8LAk3b4PqA=;
	b=qQSqAMI4qeckYjtj78DYjX4opVVyv7oxpY/aBdXXCXpUeEdIjvkn8cevOty43LFMBFj34n
	Ropv0atsL1v9oqELycSaNNw26bKe+CQbd0qz/z0vhI4g8CoDbY1HQlOK0wGpqmaPyLY4bD
	FjhMBAUW3AWj4W4CT+LeCLWor4YVilI=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=qQSqAMI4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1717299958; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rz7QKazTArIXWRByw10UZtCyaz2fqLpjF8LAk3b4PqA=;
	b=qQSqAMI4qeckYjtj78DYjX4opVVyv7oxpY/aBdXXCXpUeEdIjvkn8cevOty43LFMBFj34n
	Ropv0atsL1v9oqELycSaNNw26bKe+CQbd0qz/z0vhI4g8CoDbY1HQlOK0wGpqmaPyLY4bD
	FjhMBAUW3AWj4W4CT+LeCLWor4YVilI=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 531971399C
	for <linux-btrfs@vger.kernel.org>; Sun,  2 Jun 2024 03:45:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id KN5JAPXqW2bnOAAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Sun, 02 Jun 2024 03:45:57 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 1/2] btrfs-progs: print-tree: add support for dev-replace item
Date: Sun,  2 Jun 2024 13:15:32 +0930
Message-ID: <3eaa8778997bbdeca22105303586caeba4ab414c.1717299366.git.wqu@suse.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <cover.1717299366.git.wqu@suse.com>
References: <cover.1717299366.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -5.01
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 46750220DC
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
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
	ARC_NA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	MIME_TRACE(0.00)[0:+];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_ONE(0.00)[1];
	TO_DN_NONE(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	FROM_EQ_ENVFROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]

This is inspired by a recent bug that csum change doesn't detect
finished dev-replace.

At the time of that csum change patch, there is no print-tree to
show the content of btrfs_dev_replace_item thus contributes to the bug.

This patch adds the new output for btrfs_dev_replace_item, and the
example looks like this:

	item 1 key (0 DEV_REPLACE 0) itemoff 16171 itemsize 72
		src devid -1 cursor left 1179648000 cursor right 1179648000 mode ALWAYS
		state FINISHED write errors 0 uncorrectable read errors 0
		start time 1717282771 (2024-06-02 08:29:31)
		stop time 1717282771 (2024-06-02 08:29:31)

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 kernel-shared/print-tree.c | 79 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 79 insertions(+)

diff --git a/kernel-shared/print-tree.c b/kernel-shared/print-tree.c
index a4ddbb2ae9cb..a9a4abaa2456 100644
--- a/kernel-shared/print-tree.c
+++ b/kernel-shared/print-tree.c
@@ -36,6 +36,7 @@
 #include "common/defs.h"
 #include "common/internal.h"
 #include "common/messages.h"
+#include "uapi/btrfs.h"
 
 static void print_dir_item_type(struct extent_buffer *eb,
                                 struct btrfs_dir_item *di)
@@ -1389,6 +1390,81 @@ static void print_header_info(struct extent_buffer *eb, unsigned int mode)
 	fflush(stdout);
 }
 
+#define DEV_REPLACE_STRING_LEN		64
+#define DEV_REPLACE_MODE_ENTRY(dest, name)				\
+	case BTRFS_DEV_REPLACE_ITEM_CONT_READING_FROM_SRCDEV_MODE_##name: \
+		strncpy((dest), #name, DEV_REPLACE_STRING_LEN);		\
+		break;
+
+static void replace_mode_to_str(u64 flags, char *ret)
+{
+	ret[0] = '\0';
+	switch(flags) {
+	DEV_REPLACE_MODE_ENTRY(ret, ALWAYS);
+	DEV_REPLACE_MODE_ENTRY(ret, AVOID);
+	default:
+		snprintf(ret, DEV_REPLACE_STRING_LEN, "unknown value(%llu)",
+			 flags);
+	}
+}
+#undef DEV_REPLACE_MODE_ENTRY
+
+#define DEV_REPLACE_STATE_ENTRY(dest, name)				\
+	case BTRFS_IOCTL_DEV_REPLACE_STATE_##name:			\
+		strncpy((dest), #name, DEV_REPLACE_STRING_LEN);		\
+		break;
+
+static void replace_state_to_str(u64 flags, char *ret)
+{
+	ret[0] = '\0';
+	switch(flags) {
+	DEV_REPLACE_STATE_ENTRY(ret, NEVER_STARTED);
+	DEV_REPLACE_STATE_ENTRY(ret, FINISHED);
+	DEV_REPLACE_STATE_ENTRY(ret, CANCELED);
+	DEV_REPLACE_STATE_ENTRY(ret, STARTED);
+	DEV_REPLACE_STATE_ENTRY(ret, SUSPENDED);
+	default:
+		snprintf(ret, DEV_REPLACE_STRING_LEN, "unknown value(%llu)",
+			 flags);
+	}
+}
+#undef DEV_REPLACE_STATE_ENTRY
+
+static void print_u64_timespec(u64 timespec, const char *prefix)
+{
+	char time_str[256];
+	struct tm tm;
+	time_t time = timespec;
+
+	localtime_r(&time, &tm);
+	strftime(time_str, sizeof(time_str), "%Y-%m-%d %H:%M:%S", &tm);
+	printf("%s%llu (%s)\n", prefix, timespec, time_str);
+}
+
+static void print_dev_replace_item(struct extent_buffer *eb,
+				   struct btrfs_dev_replace_item *ptr)
+{
+	char mode_str[DEV_REPLACE_STRING_LEN] = { 0 };
+	char state_str[DEV_REPLACE_STRING_LEN] = { 0 };
+
+	replace_mode_to_str(
+			btrfs_dev_replace_cont_reading_from_srcdev_mode(eb, ptr),
+			mode_str);
+	replace_state_to_str(
+			btrfs_dev_replace_replace_state(eb, ptr),
+			state_str);
+	printf("\t\tsrc devid %lld cursor left %llu cursor right %llu mode %s\n",
+		btrfs_dev_replace_src_devid(eb, ptr),
+		btrfs_dev_replace_cursor_left(eb, ptr),
+		btrfs_dev_replace_cursor_right(eb, ptr),
+		mode_str);
+	printf("\t\tstate %s write errors %llu uncorrectable read errors %llu\n",
+		state_str, btrfs_dev_replace_num_write_errors(eb, ptr),
+		btrfs_dev_replace_num_uncorrectable_read_errors(eb, ptr));
+	print_u64_timespec(btrfs_dev_replace_time_started(eb, ptr), "\t\tstart time ");
+	print_u64_timespec(btrfs_dev_replace_time_started(eb, ptr), "\t\tstop time ");
+}
+
 void __btrfs_print_leaf(struct extent_buffer *eb, unsigned int mode)
 {
 	struct btrfs_disk_key disk_key;
@@ -1563,6 +1639,9 @@ void __btrfs_print_leaf(struct extent_buffer *eb, unsigned int mode)
 		case BTRFS_RAID_STRIPE_KEY:
 			print_raid_stripe_key(eb, item_size, ptr);
 			break;
+		case BTRFS_DEV_REPLACE_KEY:
+			print_dev_replace_item(eb, ptr);
+			break;
 		};
 		fflush(stdout);
 	}
-- 
2.45.1


