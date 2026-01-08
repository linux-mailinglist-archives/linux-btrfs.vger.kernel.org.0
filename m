Return-Path: <linux-btrfs+bounces-20226-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A0244D0220F
	for <lists+linux-btrfs@lfdr.de>; Thu, 08 Jan 2026 11:32:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 98B603372F96
	for <lists+linux-btrfs@lfdr.de>; Thu,  8 Jan 2026 09:50:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB7B5350A02;
	Thu,  8 Jan 2026 08:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Zykgg9o6";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Zykgg9o6"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9928E3ACF05
	for <linux-btrfs@vger.kernel.org>; Thu,  8 Jan 2026 08:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767862589; cv=none; b=XH2MqydrhzWNM1P2lsGqk5pXWgvWSTq73SudHq0uvwq5PacFIK4xLp8s2sIqHke4l9UOruTVZZTtvnNRLipoBdPXiR/xA4tQjx35PmxKP6ba6o4cj0vlFuWD/ScdOiVtaxCPj0xN0lKRR+ZcYDNV4jcmk8mJBpuqV89WLhpx/ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767862589; c=relaxed/simple;
	bh=OoGQgs8c9LjgSaR0oQkIqEyjGZ0uAwRqVmqkliY0e+I=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=kf0G6H0up3qQlZqLwd+neAgqAC+GyFiFuATPikUjyZlqxyF5tIIhyis72faYBqPDwXjEFNHmL+x+hfLZAXrXqdqU8C4Z2CYqgdzY5RFRFrDnNO/fIBeD2M2OFqDsfRQ8brSjRpE3VfW22VQuJDeE2thfP5i1asmMGVJSoUN6s6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Zykgg9o6; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Zykgg9o6; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 234DB33AE6
	for <linux-btrfs@vger.kernel.org>; Thu,  8 Jan 2026 08:56:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1767862579; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=Be5pYCGH87g0qum12Tk59t2spvIIjmf9JD6C0TPwpwM=;
	b=Zykgg9o66rt3QGz3FNd70qpjOkxU+y0a6FXtaxqXaQl11gVppo1Dmul7F6Jz+tnCUdXauM
	Ab/c8o/YV/Ti4+QanmGlcFeGiWODIVugHTcbpuHQox98DW370x0MQ3c1QbIaAlaXhHmFjB
	qOdTrp8vxMZRm7CMGT2qW7BiHg4g09s=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1767862579; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=Be5pYCGH87g0qum12Tk59t2spvIIjmf9JD6C0TPwpwM=;
	b=Zykgg9o66rt3QGz3FNd70qpjOkxU+y0a6FXtaxqXaQl11gVppo1Dmul7F6Jz+tnCUdXauM
	Ab/c8o/YV/Ti4+QanmGlcFeGiWODIVugHTcbpuHQox98DW370x0MQ3c1QbIaAlaXhHmFjB
	qOdTrp8vxMZRm7CMGT2qW7BiHg4g09s=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6011E3EA63
	for <linux-btrfs@vger.kernel.org>; Thu,  8 Jan 2026 08:56:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id E+PxCDJxX2lRewAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Thu, 08 Jan 2026 08:56:18 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: automatically cleanup aborted transaction on fs close
Date: Thu,  8 Jan 2026 19:26:00 +1030
Message-ID: <f52130e6f1c9f5bdd90902a88aa448316191c77b.1767862489.git.wqu@suse.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.77 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.17)[-0.827];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:mid,suse.com:email];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -2.77

[BUG]
Inspired by a recent bug report that due to an incorrect use case
(using mkfs.btrfs --reflink option with NODATACOW files), that a failed
mkfs.btrfs will lead to the following leaked extent buffer:

  btrfs-progs v6.17.1
  See https://btrfs.readthedocs.io for more information.

  Rootdir from:       /var/tmp/.#repartc2f366b20457a16d
    Compress:         no
  ERROR: cannot clone range: Invalid argument
  ERROR: failed to write /var/tmp/.#repartc2f366b20457a16d/var/lib/systemd/catalog/database
  ERROR: failed to add file extents for inode 265 ('/var/tmp/.#repartc2f366b20457a16d/var/lib/systemd/catalog/database'): Invalid argument
  ERROR: unable to traverse directory /var/tmp/.#repartc2f366b20457a16d: -22
  ERROR: error while filling filesystem: Invalid argument
  WARNING: reserved space leaked, flag=0x4 bytes_reserved=16384
  extent buffer leak: start 30408704 len 16384
  WARNING: dirty eb leak (aborted trans): start 30408704 len 16384

[CAUSE]
The error path of btrfs_mkfs_fill_dir() has properly called
btrfs_abort_transaction().

But btrfs_abort_transaction() itself only marks the fs error but do
nothing to cleanup any dirtied extent buffer or whatever.

The reason is we can not easily do the full transaction abort cleanup
including freeing the trans handle pointer, thus we need to call
btrfs_commit_transaction() to do the proper cleanup.

[FIX]
I considered calling btrfs_commit_transaction() for every
btrfs_abort_transaction() call, but it is a lot of work and never looks
good to me.

So instead I add the proper cleanup into close_ctree_fs_info(), that if
we detected an aborted transaction that is not yet commited, do the
proper cleanup so we won't have leaked dirty extent buffers:

Issue: #1073
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 kernel-shared/disk-io.c     |  5 +++++
 kernel-shared/transaction.c | 20 ++++++++++++++++----
 kernel-shared/transaction.h |  1 +
 3 files changed, 22 insertions(+), 4 deletions(-)

diff --git a/kernel-shared/disk-io.c b/kernel-shared/disk-io.c
index dff800f55a74..1a1707f37480 100644
--- a/kernel-shared/disk-io.c
+++ b/kernel-shared/disk-io.c
@@ -2270,6 +2270,11 @@ int close_ctree_fs_info(struct btrfs_fs_info *fs_info)
 	struct btrfs_trans_handle *trans;
 	struct btrfs_root *root = fs_info->tree_root;
 
+	if (fs_info->transaction_aborted && fs_info->running_transaction) {
+		btrfs_cleanup_aborted_transaction(fs_info);
+		goto skip_commit;
+	}
+
 	if (fs_info->last_trans_committed !=
 	    fs_info->generation) {
 		BUG_ON(!root);
diff --git a/kernel-shared/transaction.c b/kernel-shared/transaction.c
index 4f5155e46542..3e271cb6af34 100644
--- a/kernel-shared/transaction.c
+++ b/kernel-shared/transaction.c
@@ -332,6 +332,21 @@ cleanup:
 	return ret;
 }
 
+void btrfs_cleanup_aborted_transaction(struct btrfs_fs_info *fs_info)
+{
+	struct btrfs_trans_handle *trans = fs_info->running_transaction;
+	int error = fs_info->transaction_aborted;
+
+	if (!error || !trans)
+		return;
+
+	btrfs_abort_transaction(trans, error);
+	clean_dirty_buffers(trans);
+	btrfs_destroy_delayed_refs(trans);
+	kfree(trans);
+	fs_info->running_transaction = NULL;
+}
+
 int btrfs_commit_transaction(struct btrfs_trans_handle *trans,
 			     struct btrfs_root *root)
 {
@@ -417,10 +432,7 @@ commit_tree:
 	}
 	return ret;
 error:
-	btrfs_abort_transaction(trans, ret);
-	clean_dirty_buffers(trans);
-	btrfs_destroy_delayed_refs(trans);
-	kfree(trans);
+	btrfs_cleanup_aborted_transaction(fs_info);
 	return ret;
 }
 
diff --git a/kernel-shared/transaction.h b/kernel-shared/transaction.h
index b1739be4283e..9d479a8aece2 100644
--- a/kernel-shared/transaction.h
+++ b/kernel-shared/transaction.h
@@ -173,6 +173,7 @@ struct btrfs_pending_snapshot {
 
 bool __cold abort_should_print_stack(int error);
 
+void btrfs_cleanup_aborted_transaction(struct btrfs_fs_info *fs_info);
 void btrfs_abort_transaction(struct btrfs_trans_handle *trans, int error);
 int btrfs_end_transaction(struct btrfs_trans_handle *trans);
 struct btrfs_trans_handle *btrfs_start_transaction(struct btrfs_root *root,
-- 
2.52.0


