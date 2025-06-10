Return-Path: <linux-btrfs+bounces-14591-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 93B73AD3EF4
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Jun 2025 18:30:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0820C17A004
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Jun 2025 16:30:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1A52241131;
	Tue, 10 Jun 2025 16:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="bPvBFdcV";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="bPvBFdcV"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85D44221FB2
	for <linux-btrfs@vger.kernel.org>; Tue, 10 Jun 2025 16:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749573016; cv=none; b=tpmEEPiE+vZmmG2c6k42oI5OITGZkyb7UrJVemoC905NV3Jf7Ge4tXGgZA5dAQsMJAKAYQIB1D2+Ac7h9FiAphR1bF6AGKXSYyqOWnoFcM57U/jjLj3hWQxqPgbJ+l4J7NDsBmWtDLt3DBmz2qTRFS72OUyzaBux+FUxY8UDQcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749573016; c=relaxed/simple;
	bh=tB+wTUiLSk5AhhctoEsIQ0G5IUZX/2UG5lRo/TEnMwo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=D9RrV41IS2WB8qJ3KyOmUeiMZ6adSXpV1EGYZm0Vr6RZUphgpUVTeOvz3MiCJFxfatLByfDAgqefiVVHcjoKJkikALXji/cbynnNGklGOJ8AZ6JuM3nyt2v7cwsNBkP/UMt9WWInhKzuxFV+ZXfyaTEV4B9/xe99agTTuTQWV0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=bPvBFdcV; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=bPvBFdcV; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 8C99E21981;
	Tue, 10 Jun 2025 16:30:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1749573012; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=lHqWVYQTRYLYPIfBhjrkPHx6VCnryGaDQTsyJW50V1s=;
	b=bPvBFdcVJ6SIX8N7pWWJK8wlIWCIRq2+ucMu1SnikY+O7XA6KwMCfKWiSE1oHx9j6TuBy3
	JW7VjF7RKkGRKgP7qsKkzjyK3W95ihOB5cfyV0BJkQVdulXoSUkG+Rl2zGGxyCLqh4UUXc
	hwOL3vmCvw5arQCoyj93uQGPS3gm9dY=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=bPvBFdcV
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1749573012; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=lHqWVYQTRYLYPIfBhjrkPHx6VCnryGaDQTsyJW50V1s=;
	b=bPvBFdcVJ6SIX8N7pWWJK8wlIWCIRq2+ucMu1SnikY+O7XA6KwMCfKWiSE1oHx9j6TuBy3
	JW7VjF7RKkGRKgP7qsKkzjyK3W95ihOB5cfyV0BJkQVdulXoSUkG+Rl2zGGxyCLqh4UUXc
	hwOL3vmCvw5arQCoyj93uQGPS3gm9dY=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 83C23139E2;
	Tue, 10 Jun 2025 16:30:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id lKZ2H5RdSGh+YwAAD6G6ig
	(envelope-from <dsterba@suse.com>); Tue, 10 Jun 2025 16:30:12 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH] btrfs: tree-log: add and rename extent bits for dirty_log_pages tree
Date: Tue, 10 Jun 2025 18:30:09 +0200
Message-ID: <20250610163009.26520-1-dsterba@suse.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 8C99E21981
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:mid,suse.com:dkim,suse.com:email];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+]
X-Spam-Score: -3.01
X-Spam-Level: 

The dirty_log_pages tree is used for tree logging and marks extents
based on log_transid. The bits could be renamed to resemble the
LOG1/LOG2 naming used for the BTRFS_FS_LOG1_ERR bits.

The DIRTY bit is renamed to LOG1 and NEW to LOG2.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/extent-io-tree.h        |  3 ++-
 fs/btrfs/extent-tree.c           |  4 ++--
 fs/btrfs/tests/extent-io-tests.c |  3 ++-
 fs/btrfs/transaction.c           |  4 ++--
 fs/btrfs/tree-log.c              | 12 ++++++------
 include/trace/events/btrfs.h     |  3 ++-
 6 files changed, 16 insertions(+), 13 deletions(-)

diff --git a/fs/btrfs/extent-io-tree.h b/fs/btrfs/extent-io-tree.h
index 0a18ca9c59c3..819da07bff09 100644
--- a/fs/btrfs/extent-io-tree.h
+++ b/fs/btrfs/extent-io-tree.h
@@ -19,7 +19,8 @@ enum {
 	ENUM_BIT(EXTENT_DIRTY),
 	ENUM_BIT(EXTENT_LOCKED),
 	ENUM_BIT(EXTENT_DIO_LOCKED),
-	ENUM_BIT(EXTENT_NEW),
+	ENUM_BIT(EXTENT_DIRTY_LOG1),
+	ENUM_BIT(EXTENT_DIRTY_LOG2),
 	ENUM_BIT(EXTENT_DELALLOC),
 	ENUM_BIT(EXTENT_DEFRAG),
 	ENUM_BIT(EXTENT_BOUNDARY),
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 1c3bfb9ff025..1244729dd8ba 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -5142,11 +5142,11 @@ btrfs_init_new_buffer(struct btrfs_trans_handle *trans, struct btrfs_root *root,
 		if (buf->log_index == 0)
 			btrfs_set_extent_bit(&root->dirty_log_pages, buf->start,
 					     buf->start + buf->len - 1,
-					     EXTENT_DIRTY, NULL);
+					     EXTENT_DIRTY_LOG1, NULL);
 		else
 			btrfs_set_extent_bit(&root->dirty_log_pages, buf->start,
 					     buf->start + buf->len - 1,
-					     EXTENT_NEW, NULL);
+					     EXTENT_DIRTY_LOG2, NULL);
 	} else {
 		buf->log_index = -1;
 		btrfs_set_extent_bit(&trans->transaction->dirty_pages, buf->start,
diff --git a/fs/btrfs/tests/extent-io-tests.c b/fs/btrfs/tests/extent-io-tests.c
index 00da54f0164c..557d05220de1 100644
--- a/fs/btrfs/tests/extent-io-tests.c
+++ b/fs/btrfs/tests/extent-io-tests.c
@@ -75,7 +75,8 @@ static void extent_flag_to_str(const struct extent_state *state, char *dest)
 	dest[0] = 0;
 	PRINT_ONE_FLAG(state, dest, cur, DIRTY);
 	PRINT_ONE_FLAG(state, dest, cur, LOCKED);
-	PRINT_ONE_FLAG(state, dest, cur, NEW);
+	PRINT_ONE_FLAG(state, dest, cur, DIRTY_LOG1);
+	PRINT_ONE_FLAG(state, dest, cur, DIRTY_LOG2);
 	PRINT_ONE_FLAG(state, dest, cur, DELALLOC);
 	PRINT_ONE_FLAG(state, dest, cur, DEFRAG);
 	PRINT_ONE_FLAG(state, dest, cur, BOUNDARY);
diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index 825d135ef6c7..2e07c90be5cd 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -1232,11 +1232,11 @@ int btrfs_wait_tree_log_extents(struct btrfs_root *log_root, int mark)
 	ASSERT(btrfs_root_id(log_root) == BTRFS_TREE_LOG_OBJECTID);
 
 	ret = __btrfs_wait_marked_extents(fs_info, dirty_pages);
-	if ((mark & EXTENT_DIRTY) &&
+	if ((mark & EXTENT_DIRTY_LOG1) &&
 	    test_and_clear_bit(BTRFS_FS_LOG1_ERR, &fs_info->flags))
 		errors = true;
 
-	if ((mark & EXTENT_NEW) &&
+	if ((mark & EXTENT_DIRTY_LOG2) &&
 	    test_and_clear_bit(BTRFS_FS_LOG2_ERR, &fs_info->flags))
 		errors = true;
 
diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 3f5593fe1215..768f872b08bd 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -2961,9 +2961,9 @@ int btrfs_sync_log(struct btrfs_trans_handle *trans,
 	}
 
 	if (log_transid % 2 == 0)
-		mark = EXTENT_DIRTY;
+		mark = EXTENT_DIRTY_LOG1;
 	else
-		mark = EXTENT_NEW;
+		mark = EXTENT_DIRTY_LOG2;
 
 	/* we start IO on  all the marked extents here, but we don't actually
 	 * wait for them until later.
@@ -3094,7 +3094,7 @@ int btrfs_sync_log(struct btrfs_trans_handle *trans,
 
 	ret = btrfs_write_marked_extents(fs_info,
 					 &log_root_tree->dirty_log_pages,
-					 EXTENT_DIRTY | EXTENT_NEW);
+					 EXTENT_DIRTY_LOG1 | EXTENT_DIRTY_LOG2);
 	blk_finish_plug(&plug);
 	/*
 	 * As described above, -EAGAIN indicates a hole in the extents. We
@@ -3114,7 +3114,7 @@ int btrfs_sync_log(struct btrfs_trans_handle *trans,
 	ret = btrfs_wait_tree_log_extents(log, mark);
 	if (!ret)
 		ret = btrfs_wait_tree_log_extents(log_root_tree,
-						  EXTENT_NEW | EXTENT_DIRTY);
+						  EXTENT_DIRTY_LOG1 | EXTENT_DIRTY_LOG2);
 	if (ret) {
 		btrfs_set_log_full_commit(trans);
 		mutex_unlock(&log_root_tree->log_mutex);
@@ -3240,9 +3240,9 @@ static void free_log_tree(struct btrfs_trans_handle *trans,
 			 */
 			btrfs_write_marked_extents(log->fs_info,
 						   &log->dirty_log_pages,
-						   EXTENT_DIRTY | EXTENT_NEW);
+						   EXTENT_DIRTY_LOG1 | EXTENT_DIRTY_LOG2);
 			btrfs_wait_tree_log_extents(log,
-						    EXTENT_DIRTY | EXTENT_NEW);
+						    EXTENT_DIRTY_LOG1 | EXTENT_DIRTY_LOG2);
 
 			if (trans)
 				btrfs_abort_transaction(trans, ret);
diff --git a/include/trace/events/btrfs.h b/include/trace/events/btrfs.h
index a32305044371..d54fe354b390 100644
--- a/include/trace/events/btrfs.h
+++ b/include/trace/events/btrfs.h
@@ -144,7 +144,8 @@ FLUSH_STATES
 #define EXTENT_FLAGS						\
 	{ EXTENT_DIRTY,			"DIRTY"},		\
 	{ EXTENT_LOCKED,		"LOCKED"},		\
-	{ EXTENT_NEW,			"NEW"},			\
+	{ EXTENT_DIRTY_LOG1,		"DIRTY_LOG1"},		\
+	{ EXTENT_DIRTY_LOG2,		"DIRTY_LOG2"},		\
 	{ EXTENT_DELALLOC,		"DELALLOC"},		\
 	{ EXTENT_DEFRAG,		"DEFRAG"},		\
 	{ EXTENT_BOUNDARY,		"BOUNDARY"},		\
-- 
2.47.1


