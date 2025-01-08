Return-Path: <linux-btrfs+bounces-10791-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 719EAA05A3E
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 Jan 2025 12:44:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8819A1888027
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 Jan 2025 11:44:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 156AA1F8EFC;
	Wed,  8 Jan 2025 11:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="pSnmtv7L";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="uD9TDhf0"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0170A1F8AC5;
	Wed,  8 Jan 2025 11:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736336654; cv=none; b=SZnjuUtAZc10QAQYK6jQjQdwxMFi9+KvfL1dbnP8F/syJRFV+sCvbi4gsKV9SLvEnB7Fj6KmewHtAcw1ITNmPXxfd4+ZMc0ruTJN1BeGhsc5IHQn+/BaCI1VI47dkkVMrE9e+jOYI416+oCxGpdibp0OoAYof/ImuuEyNRpcP+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736336654; c=relaxed/simple;
	bh=3VyvC53OY83KdwcfiudoKAd9OZjkxYkNiHhzWIoUCSY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Jb/CazneCEAvMII79p2tLQjPnAUDc3WnV3OcUgdExvotdKgYQ1O4MhISKL748sm2B/uhfyBEZfaRB2CTjHiEyc1BrGeHCesuiZjc1UQ+g56FJuq14jMGl1cr19dfpkDgfDUTpqmYRycpTE4BwyoTCgehid1QGFqES2FYsrKiyqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=pSnmtv7L; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=uD9TDhf0; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 1BBC61F385;
	Wed,  8 Jan 2025 11:44:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1736336650; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=etyJBPmf033GrHiGwusSGAQP2F73qOmwWMukphVfgDM=;
	b=pSnmtv7LZE7vPS/Wz48cRCbiP/U1gUfLACEpJHYjVNT20Hrq3FHjg22XFeAX2Xxtcahb9Z
	A8OeXWExnR1BzoOA8mBzvyY1dy7+TUT+bnYX5hKJSMFc3D03UdcqaUEmHVCa6V5fgo80u/
	xI90xG7VHkSNS4BZ+HQe8WMzcshu7hc=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=uD9TDhf0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1736336649; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=etyJBPmf033GrHiGwusSGAQP2F73qOmwWMukphVfgDM=;
	b=uD9TDhf09KPyiZRafg3BQaPee1K0A8AxRdi5aypaDV3/PD98L8uCn4Lh6bPfqFvNWhTk3o
	4h3Css3W2A7IW83GJAa/6fOVzKfGkHm2sQfU0ido3ZGWmlDYpkQBJtSQBqSz/2mzS4pMQe
	boung+B7x7WJ2ASe07i6daw6TS9aahE=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EC865137DA;
	Wed,  8 Jan 2025 11:44:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id DY2sOAhlfmeZEgAAD6G6ig
	(envelope-from <neelx@suse.com>); Wed, 08 Jan 2025 11:44:08 +0000
From: Daniel Vacek <neelx@suse.com>
To: Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>
Cc: Daniel Vacek <neelx@suse.com>,
	linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] btrfs: keep `priv` struct on stack for sync reads in `btrfs_encoded_read_regular_fill_pages()`
Date: Wed,  8 Jan 2025 12:43:25 +0100
Message-ID: <20250108114326.1729250-1-neelx@suse.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 1BBC61F385
X-Spam-Level: 
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:email,suse.com:dkim,suse.com:mid];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DKIM_TRACE(0.00)[suse.com:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01
X-Spam-Flag: NO

Only allocate the `priv` struct from slab for asynchronous mode.

There's no need to allocate an object from slab in the synchronous mode. In
such a case stack can be happily used as it used to be before 68d3b27e05c7
("btrfs: move priv off stack in btrfs_encoded_read_regular_fill_pages()")
which was a preparation for the async mode.

While at it, fix the comment to reflect the atomic => refcount change in
d29662695ed7 ("btrfs: fix use-after-free waiting for encoded read endios").

Signed-off-by: Daniel Vacek <neelx@suse.com>
---
 fs/btrfs/inode.c | 62 +++++++++++++++++++++++++-----------------------
 1 file changed, 32 insertions(+), 30 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 27b2fe7f735d5..4d30857df4bcb 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -9078,9 +9078,9 @@ static ssize_t btrfs_encoded_read_inline(
 }
 
 struct btrfs_encoded_read_private {
-	struct completion done;
+	struct completion *sync_reads;
 	void *uring_ctx;
-	refcount_t pending_refs;
+	refcount_t pending_reads;
 	blk_status_t status;
 };
 
@@ -9090,23 +9090,22 @@ static void btrfs_encoded_read_endio(struct btrfs_bio *bbio)
 
 	if (bbio->bio.bi_status) {
 		/*
-		 * The memory barrier implied by the atomic_dec_return() here
-		 * pairs with the memory barrier implied by the
-		 * atomic_dec_return() or io_wait_event() in
-		 * btrfs_encoded_read_regular_fill_pages() to ensure that this
-		 * write is observed before the load of status in
-		 * btrfs_encoded_read_regular_fill_pages().
+		 * The memory barrier implied by the
+		 * refcount_dec_and_test() here pairs with the memory
+		 * barrier implied by the refcount_dec_and_test() in
+		 * btrfs_encoded_read_regular_fill_pages() to ensure
+		 * that this write is observed before the load of
+		 * status in btrfs_encoded_read_regular_fill_pages().
 		 */
 		WRITE_ONCE(priv->status, bbio->bio.bi_status);
 	}
-	if (refcount_dec_and_test(&priv->pending_refs)) {
-		int err = blk_status_to_errno(READ_ONCE(priv->status));
-
+	if (refcount_dec_and_test(&priv->pending_reads)) {
 		if (priv->uring_ctx) {
+			int err = blk_status_to_errno(READ_ONCE(priv->status));
 			btrfs_uring_read_extent_endio(priv->uring_ctx, err);
 			kfree(priv);
 		} else {
-			complete(&priv->done);
+			complete(priv->sync_reads);
 		}
 	}
 	bio_put(&bbio->bio);
@@ -9117,17 +9116,22 @@ int btrfs_encoded_read_regular_fill_pages(struct btrfs_inode *inode,
 					  struct page **pages, void *uring_ctx)
 {
 	struct btrfs_fs_info *fs_info = inode->root->fs_info;
-	struct btrfs_encoded_read_private *priv;
+	struct btrfs_encoded_read_private *priv, sync_priv;
+	struct completion sync_reads;
 	unsigned long i = 0;
 	struct btrfs_bio *bbio;
-	int ret;
 
-	priv = kmalloc(sizeof(struct btrfs_encoded_read_private), GFP_NOFS);
-	if (!priv)
-		return -ENOMEM;
+	if (uring_ctx) {
+		priv = kmalloc(sizeof(struct btrfs_encoded_read_private), GFP_NOFS);
+		if (!priv)
+			return -ENOMEM;
+	} else {
+		priv = &sync_priv;
+		init_completion(&sync_reads);
+		priv->sync_reads = &sync_reads;
+	}
 
-	init_completion(&priv->done);
-	refcount_set(&priv->pending_refs, 1);
+	refcount_set(&priv->pending_reads, 1);
 	priv->status = 0;
 	priv->uring_ctx = uring_ctx;
 
@@ -9140,7 +9144,7 @@ int btrfs_encoded_read_regular_fill_pages(struct btrfs_inode *inode,
 		size_t bytes = min_t(u64, disk_io_size, PAGE_SIZE);
 
 		if (bio_add_page(&bbio->bio, pages[i], bytes, 0) < bytes) {
-			refcount_inc(&priv->pending_refs);
+			refcount_inc(&priv->pending_reads);
 			btrfs_submit_bbio(bbio, 0);
 
 			bbio = btrfs_bio_alloc(BIO_MAX_VECS, REQ_OP_READ, fs_info,
@@ -9155,25 +9159,23 @@ int btrfs_encoded_read_regular_fill_pages(struct btrfs_inode *inode,
 		disk_io_size -= bytes;
 	} while (disk_io_size);
 
-	refcount_inc(&priv->pending_refs);
+	refcount_inc(&priv->pending_reads);
 	btrfs_submit_bbio(bbio, 0);
 
 	if (uring_ctx) {
-		if (refcount_dec_and_test(&priv->pending_refs)) {
-			ret = blk_status_to_errno(READ_ONCE(priv->status));
-			btrfs_uring_read_extent_endio(uring_ctx, ret);
+		if (refcount_dec_and_test(&priv->pending_reads)) {
+			int err = blk_status_to_errno(READ_ONCE(priv->status));
+			btrfs_uring_read_extent_endio(uring_ctx, err);
 			kfree(priv);
-			return ret;
+			return err;
 		}
 
 		return -EIOCBQUEUED;
 	} else {
-		if (!refcount_dec_and_test(&priv->pending_refs))
-			wait_for_completion_io(&priv->done);
+		if (!refcount_dec_and_test(&priv->pending_reads))
+			wait_for_completion_io(&sync_reads);
 		/* See btrfs_encoded_read_endio() for ordering. */
-		ret = blk_status_to_errno(READ_ONCE(priv->status));
-		kfree(priv);
-		return ret;
+		return blk_status_to_errno(READ_ONCE(priv->status));
 	}
 }
 
-- 
2.45.2


