Return-Path: <linux-btrfs+bounces-14030-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4332AB7F8A
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 May 2025 10:01:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 866013A7663
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 May 2025 08:01:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57C44286887;
	Thu, 15 May 2025 08:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="MwGQgfBK";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="MwGQgfBK"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B01BC285409
	for <linux-btrfs@vger.kernel.org>; Thu, 15 May 2025 08:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747296060; cv=none; b=KtoCGCmbBQhWVJHeiH2C+IEoL0I9889iuaB7JsMnS0y7eDHsV7D/85cIGI2cGGn64ODOTqJypP9HCZu7u2KWfi12JENn0vGYT+fqo+xr6uJ+oZ6qzS18Uni7LN/Bse53xesHh/gTdsBLJMNJlYw5VHnAFErl3vbQDJXEvXx93z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747296060; c=relaxed/simple;
	bh=obM4l1hsjltJQS4MLTcu8JM8lc0VqVI/Hj/N1moFYRY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fJ6LspSQYwZE5OVpEaRELeOg7V78ouxST8SLszEjlAb0vwRmVNN69iqm+lQtH+fa66UIcR2SjHWCsSv37UnlVqrPLzVmdfcKbhsvudFY2BO8GKIkichbRKfKD3QRT13OQ61BqV0BhoJ9er06qRxKZ+eVWOAbKQ6RZVu8lwJk8lU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=MwGQgfBK; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=MwGQgfBK; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 150741F7BF
	for <linux-btrfs@vger.kernel.org>; Thu, 15 May 2025 08:00:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1747296046; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vIz4akfdFXzzCc8XWhT2Usx/Dw76iiqsGaAihUzXfn4=;
	b=MwGQgfBKMcOCwTRD5KIfWEDlGlcnlOvL66RT9vz5nU2SU90CCHzn9OP/tvAoOHex9dJD11
	QnIJCV2mUCZBdWW4b6HWEfmpU1lD9eom/pS9D+wV9yTEamLzqlHFNumU1M5gzNu1peICEV
	zlfZHW8s896YAC0ytW0Co1E4Qs18fSE=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1747296046; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vIz4akfdFXzzCc8XWhT2Usx/Dw76iiqsGaAihUzXfn4=;
	b=MwGQgfBKMcOCwTRD5KIfWEDlGlcnlOvL66RT9vz5nU2SU90CCHzn9OP/tvAoOHex9dJD11
	QnIJCV2mUCZBdWW4b6HWEfmpU1lD9eom/pS9D+wV9yTEamLzqlHFNumU1M5gzNu1peICEV
	zlfZHW8s896YAC0ytW0Co1E4Qs18fSE=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4FA03137E8
	for <linux-btrfs@vger.kernel.org>; Thu, 15 May 2025 08:00:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id SJDIBC2fJWi8LwAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Thu, 15 May 2025 08:00:45 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2 5/6] btrfs-progs: fix-data-checksum: update csum items to fix csum mismatch
Date: Thu, 15 May 2025 17:30:20 +0930
Message-ID: <c78f6903cbb952acad86ac026dd597645d0af31b.1747295965.git.wqu@suse.com>
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
X-Spam-Flag: NO
X-Spam-Score: -2.80
X-Spam-Level: 
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

This adds a new group of action in the interactive mode to fix a csum
mismatch.

The output looks like this:

  logical=13631488 corrtuped mirrors=1 affected files:
    (subvolume 5)/foo
    (subvolume 5)/dir/bar
  <<I>>gnore/<1>:1
  Csum item for logical 13631488 updated using data from mirror 1

In the interactive mode, the update-csum-item behavior is outputted as
all available mirror numbers.

Considering all the existing (and future) action should starts with an
alphabet, it's pretty easy to distinguish mirror number from other
actions.

The update-csum-item action itself is pretty straight-forward, just read
out the data from specified mirror, then calculate a new checksum, and
update the corresponding csum item in csum tree.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 cmds/rescue-fix-data-checksum.c | 119 +++++++++++++++++++++++++++++---
 kernel-shared/file-item.c       |   2 +-
 kernel-shared/file-item.h       |   5 ++
 3 files changed, 114 insertions(+), 12 deletions(-)

diff --git a/cmds/rescue-fix-data-checksum.c b/cmds/rescue-fix-data-checksum.c
index 9a4f3fd73aaf..86924d61823e 100644
--- a/cmds/rescue-fix-data-checksum.c
+++ b/cmds/rescue-fix-data-checksum.c
@@ -20,6 +20,8 @@
 #include "kernel-shared/ctree.h"
 #include "kernel-shared/volumes.h"
 #include "kernel-shared/backref.h"
+#include "kernel-shared/transaction.h"
+#include "kernel-shared/file-item.h"
 #include "common/messages.h"
 #include "common/open-utils.h"
 #include "cmds/rescue.h"
@@ -48,6 +50,7 @@ struct corrupted_block {
 
 enum fix_data_checksum_action_value {
 	ACTION_IGNORE,
+	ACTION_UPDATE_CSUM,
 	ACTION_LAST,
 };
 
@@ -59,6 +62,10 @@ static const struct fix_data_checksum_action {
 		.value = ACTION_IGNORE,
 		.string = "ignore",
 	},
+	[ACTION_UPDATE_CSUM] = {
+		.value = ACTION_UPDATE_CSUM,
+		.string = "update-csum",
+	},
 };
 
 static int global_repair_mode;
@@ -258,10 +265,13 @@ next:
 }
 
 #define ASK_ACTION_BUFSIZE	(32)
-static enum fix_data_checksum_action_value ask_action()
+static enum fix_data_checksum_action_value ask_action(unsigned int num_mirrors,
+						      unsigned int *mirror_ret)
 {
+	unsigned long ret;
 	char buf[ASK_ACTION_BUFSIZE] = { 0 };
 	bool printed;
+	char *endptr;
 
 again:
 	printed = false;
@@ -269,12 +279,22 @@ again:
 		if (printed)
 			printf("/");
 		/* Mark Ignore as default */
-		if (i == ACTION_IGNORE)
+		if (i == ACTION_IGNORE) {
 			printf("<<%c>>%s", toupper(actions[i].string[0]),
 			       actions[i].string + 1);
-		else
+		} else if (i == ACTION_UPDATE_CSUM) {
+			/*
+			 * For update-csum action, we need a mirror number,
+			 * so output all valid mirrors numbers instead.
+			 */
+			for (int cur_mirror = 1; cur_mirror <= num_mirrors;
+			     cur_mirror++)
+				printf("<%u>", cur_mirror);
+		} else {
 			printf("<%c>%s", toupper(actions[i].string[0]),
 			       actions[i].string + 1);
+		}
+		printed = true;
 	}
 	printf(":");
 	fflush(stdout);
@@ -285,13 +305,79 @@ again:
 		return ACTION_IGNORE;
 	/* Check exact match or matching the initial letter. */
 	for (int i = 0; i < ACTION_LAST; i++) {
-		if (strncasecmp(buf, actions[i].string, 1) == 0 ||
-		    strncasecmp(buf, actions[i].string, ASK_ACTION_BUFSIZE) == 0)
+		if ((strncasecmp(buf, actions[i].string, 1) == 0 ||
+		     strncasecmp(buf, actions[i].string, ASK_ACTION_BUFSIZE) == 0) &&
+		     actions[i].value != ACTION_UPDATE_CSUM)
 			return actions[i].value;
 	}
-	/* No valid action found, retry. */
-	warning("invalid action, please retry");
-	goto again;
+	/* No match, check if it's some numeric string. */
+	ret = strtoul(buf, &endptr, 10);
+	if (endptr == buf || ret == ULONG_MAX) {
+		/* No valid action found, retry. */
+		warning("invalid action, please retry");
+		goto again;
+	}
+	if (ret > num_mirrors || ret == 0) {
+		warning("invalid mirror number %lu, must be in range [1, %d], please retry",
+			ret, num_mirrors);
+		goto again;
+	}
+	*mirror_ret = ret;
+	return ACTION_UPDATE_CSUM;
+}
+
+static int update_csum_item(struct btrfs_fs_info *fs_info, u64 logical,
+			    unsigned int mirror)
+{
+	struct btrfs_trans_handle *trans;
+	struct btrfs_root *csum_root = btrfs_csum_root(fs_info, logical);
+	struct btrfs_path path = { 0 };
+	struct btrfs_csum_item *citem;
+	u64 read_len = fs_info->sectorsize;
+	u8 csum[BTRFS_CSUM_SIZE] = { 0 };
+	u8 *buf;
+	int ret;
+
+	buf = malloc(fs_info->sectorsize);
+	if (!buf)
+		return -ENOMEM;
+	ret = read_data_from_disk(fs_info, buf, logical, &read_len, mirror);
+	if (ret < 0) {
+		errno = -ret;
+		error("failed to read block at logical %llu mirror %u: %m",
+			logical, mirror);
+		goto out;
+	}
+	trans = btrfs_start_transaction(csum_root, 1);
+	if (IS_ERR(trans)) {
+		ret = PTR_ERR(trans);
+		errno = -ret;
+		error_msg(ERROR_MSG_START_TRANS, "%m");
+		goto out;
+	}
+	citem = btrfs_lookup_csum(trans, csum_root, &path, logical,
+				  BTRFS_EXTENT_CSUM_OBJECTID, fs_info->csum_type, 1);
+	if (IS_ERR(citem)) {
+		ret = PTR_ERR(citem);
+		errno = -ret;
+		error("failed to find csum item for logical %llu: $m", logical);
+		btrfs_abort_transaction(trans, ret);
+		goto out;
+	}
+	btrfs_csum_data(fs_info, fs_info->csum_type, buf, csum, fs_info->sectorsize);
+	write_extent_buffer(path.nodes[0], csum, (unsigned long)citem, fs_info->csum_size);
+	btrfs_release_path(&path);
+	ret = btrfs_commit_transaction(trans, csum_root);
+	if (ret < 0) {
+		errno = -ret;
+		error_msg(ERROR_MSG_COMMIT_TRANS, "%m");
+	}
+	printf("Csum item for logical %llu updated using data from mirror %u\n",
+		logical, mirror);
+out:
+	free(buf);
+	btrfs_release_path(&path);
+	return ret;
 }
 
 static void report_corrupted_blocks(struct btrfs_fs_info *fs_info,
@@ -307,6 +393,7 @@ static void report_corrupted_blocks(struct btrfs_fs_info *fs_info,
 	}
 
 	list_for_each_entry(entry, &corrupted_blocks, list) {
+		unsigned int mirror;
 		bool has_printed = false;
 		int ret;
 
@@ -334,10 +421,20 @@ static void report_corrupted_blocks(struct btrfs_fs_info *fs_info,
 		}
 		switch (mode) {
 		case BTRFS_FIX_DATA_CSUMS_INTERACTIVE:
-			action = ask_action();
-			UASSERT(action == ACTION_IGNORE);
-			fallthrough;
+			action = ask_action(entry->num_mirrors, &mirror);
+			break;
 		case BTRFS_FIX_DATA_CSUMS_READONLY:
+			action = ACTION_IGNORE;
+			break;
+		default:
+			UASSERT(0);
+		}
+
+		switch (action) {
+		case ACTION_IGNORE:
+			break;
+		case ACTION_UPDATE_CSUM:
+			ret = update_csum_item(fs_info, entry->logical, mirror);
 			break;
 		default:
 			UASSERT(0);
diff --git a/kernel-shared/file-item.c b/kernel-shared/file-item.c
index 18791c0647b7..503ad657c661 100644
--- a/kernel-shared/file-item.c
+++ b/kernel-shared/file-item.c
@@ -112,7 +112,7 @@ fail:
 	return err;
 }
 
-static struct btrfs_csum_item *
+struct btrfs_csum_item *
 btrfs_lookup_csum(struct btrfs_trans_handle *trans,
 		  struct btrfs_root *root,
 		  struct btrfs_path *path,
diff --git a/kernel-shared/file-item.h b/kernel-shared/file-item.h
index cab0bc4e9ce0..5a5d8da10266 100644
--- a/kernel-shared/file-item.h
+++ b/kernel-shared/file-item.h
@@ -89,6 +89,11 @@ int btrfs_insert_file_extent(struct btrfs_trans_handle *trans,
 			     struct btrfs_file_extent_item *stack_fi);
 int btrfs_csum_file_block(struct btrfs_trans_handle *trans, u64 logical,
 			  u64 csum_objectid, u32 csum_type, const char *data);
+struct btrfs_csum_item *
+btrfs_lookup_csum(struct btrfs_trans_handle *trans,
+		  struct btrfs_root *root,
+		  struct btrfs_path *path,
+		  u64 bytenr, u64 csum_objectid, u16 csum_type, int cow);
 int btrfs_insert_inline_extent(struct btrfs_trans_handle *trans,
 			       struct btrfs_root *root, u64 objectid,
 			       u64 offset, const char *buffer, size_t size,
-- 
2.49.0


