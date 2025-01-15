Return-Path: <linux-btrfs+bounces-10974-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2070FA1275A
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Jan 2025 16:25:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 21A9C162E5F
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Jan 2025 15:25:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A245614D6FD;
	Wed, 15 Jan 2025 15:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="iw2tkBFp";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="iw2tkBFp"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B85DB24A7DF;
	Wed, 15 Jan 2025 15:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736954732; cv=none; b=MVyDsqJQLFRRDTZruFBnedKR7dEKQXBoTCFsfCRA6ZFCsjTrWKwaJiXyP8lZQv/eeiHWwKC7vjzXs+L7OW32kOKaIrjmkS4JQ67ggqJ+enHzzfQlr0nPhe9LOpNRZfpdj9bAPCoQ7zprEzkcFZEZWpApN0sz6fnCe6gVgBQEGwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736954732; c=relaxed/simple;
	bh=oZVlhdb+jcwW3yqdAOIHqIhjAjCFhUJoneJM5tOzEKI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RBvki30AzQszYLuCEg24PAZguCxq+sqCl/Pn7qHXgaSqXeemhPXulmZtSCzupvftassuBIyei3tL1z5+0mugyQmStRP6AecVUfOihRDO2lD/lIOMxGUu9oQvwwrcIK2LqyrvX0klPMBuvaoM0Y4aV3mB3J78RzjirGkNmPMBpp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=iw2tkBFp; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=iw2tkBFp; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D027B21278;
	Wed, 15 Jan 2025 15:25:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1736954728; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=4k2Mfy4dZMWo2U910P8nWAHZLU3b0JUSkCNZElL1t1s=;
	b=iw2tkBFp3nXsGxeKcSN3KmQmu6hGKMbizjV8mA5xibBPNjf8ABpBjrLP2znVdWNP6BPCKr
	MuE+YOHaTOI4j6Ob4GGSz2NW380YEA6lu7Ipp0l+HKX2KYigtH27hoVAIMNe+tG3/z6XbE
	+c6HaGzRgE4xrn8Z8WAFJDHrEjkvV8g=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=iw2tkBFp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1736954728; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=4k2Mfy4dZMWo2U910P8nWAHZLU3b0JUSkCNZElL1t1s=;
	b=iw2tkBFp3nXsGxeKcSN3KmQmu6hGKMbizjV8mA5xibBPNjf8ABpBjrLP2znVdWNP6BPCKr
	MuE+YOHaTOI4j6Ob4GGSz2NW380YEA6lu7Ipp0l+HKX2KYigtH27hoVAIMNe+tG3/z6XbE
	+c6HaGzRgE4xrn8Z8WAFJDHrEjkvV8g=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BA38F13A6F;
	Wed, 15 Jan 2025 15:25:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ZcXwLGjTh2dACAAAD6G6ig
	(envelope-from <neelx@suse.com>); Wed, 15 Jan 2025 15:25:28 +0000
From: Daniel Vacek <neelx@suse.com>
To: Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>
Cc: Daniel Vacek <neelx@suse.com>,
	linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] btrfs: keep `priv` struct on stack for sync reads in `btrfs_encoded_read_regular_fill_pages()`
Date: Wed, 15 Jan 2025 16:24:58 +0100
Message-ID: <20250115152458.3000892-1-neelx@suse.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: D027B21278
X-Spam-Score: -3.01
X-Rspamd-Action: no action
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
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DKIM_TRACE(0.00)[suse.com:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

Only allocate the `priv` struct from slab for asynchronous mode.

There's no need to allocate an object from slab in the synchronous mode. In
such a case stack can be happily used as it used to be before 68d3b27e05c7
("btrfs: move priv off stack in btrfs_encoded_read_regular_fill_pages()")
which was a preparation for the async mode.

While at it, fix the comment to reflect the atomic => refcount change in
d29662695ed7 ("btrfs: fix use-after-free waiting for encoded read endios").

Signed-off-by: Daniel Vacek <neelx@suse.com>
---
v2 reduces the patch only to functional changes as suggested by Johannes
and Dave.

 fs/btrfs/inode.c | 38 +++++++++++++++++++++-----------------
 1 file changed, 21 insertions(+), 17 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 27b2fe7f735d5..de9d454ece0c6 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -9078,7 +9078,7 @@ static ssize_t btrfs_encoded_read_inline(
 }
 
 struct btrfs_encoded_read_private {
-	struct completion done;
+	struct completion *sync_reads;
 	void *uring_ctx;
 	refcount_t pending_refs;
 	blk_status_t status;
@@ -9090,12 +9090,12 @@ static void btrfs_encoded_read_endio(struct btrfs_bio *bbio)
 
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
@@ -9106,7 +9106,7 @@ static void btrfs_encoded_read_endio(struct btrfs_bio *bbio)
 			btrfs_uring_read_extent_endio(priv->uring_ctx, err);
 			kfree(priv);
 		} else {
-			complete(&priv->done);
+			complete(priv->sync_reads);
 		}
 	}
 	bio_put(&bbio->bio);
@@ -9117,16 +9117,22 @@ int btrfs_encoded_read_regular_fill_pages(struct btrfs_inode *inode,
 					  struct page **pages, void *uring_ctx)
 {
 	struct btrfs_fs_info *fs_info = inode->root->fs_info;
-	struct btrfs_encoded_read_private *priv;
+	struct btrfs_encoded_read_private *priv, sync_priv;
+	struct completion sync_reads;
 	unsigned long i = 0;
 	struct btrfs_bio *bbio;
 	int ret;
 
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
 	refcount_set(&priv->pending_refs, 1);
 	priv->status = 0;
 	priv->uring_ctx = uring_ctx;
@@ -9169,11 +9175,9 @@ int btrfs_encoded_read_regular_fill_pages(struct btrfs_inode *inode,
 		return -EIOCBQUEUED;
 	} else {
 		if (!refcount_dec_and_test(&priv->pending_refs))
-			wait_for_completion_io(&priv->done);
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


