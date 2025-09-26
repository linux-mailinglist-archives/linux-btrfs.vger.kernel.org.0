Return-Path: <linux-btrfs+bounces-17215-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C406BA33AA
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Sep 2025 11:48:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C895362372D
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Sep 2025 09:48:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69D1E2BCF4C;
	Fri, 26 Sep 2025 09:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="e9tArgex";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="e9tArgex"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6436829D28B
	for <linux-btrfs@vger.kernel.org>; Fri, 26 Sep 2025 09:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758880061; cv=none; b=td8aEDlk99vK61bS5CpTnuI8fKCLI26piu7nrKkG9387zEJEuZ7PIsWAEAXHeQgYlg6/mIbqypfszysSvb6yUMCJjgqBbErrz1oiC/WA8LfqJkSrzaY+uve4eP67iaTGr7pL36jPf9k/bmArCsCG/neA/gKEEZTROGv6h9Svj64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758880061; c=relaxed/simple;
	bh=VwM1e67/hHFNOmJth7ko+5CCE256XvjfhXrLRVAHWz8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sqWRkF7aRFmvhgdvyWpWaLXgWoLz6RF6j2YcrXdOZByZxLWABqSfAg4kPTxJfpMSrbUbSaGkSqotxzV5zSAqmPMXSU3HPJ4qFEst9COM0+uie97Tlk7l6SPlkfVV6mQXGWhsGlggjKOcQdcz85KCvTXR9sgjolpqEeX3u9+0hVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=e9tArgex; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=e9tArgex; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 9B7F36B0FD;
	Fri, 26 Sep 2025 09:47:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1758880051; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=Fl3lCTfdOpDriccZ8YANrmrDoa3N7fGM3MaZK+KBq4g=;
	b=e9tArgexXoKSZMbwORsmKHXd9K19ba8xuGtBNxSQp8Q/6d2B04C89mAwzr4Zseqis5GuXe
	kze3l402eswRUFcKBi+8i7pgMDmvgo+ZOk0/jlTsTIBawDRKgdr+d8d4ATqKgUrcOrtLzK
	txZh4NixYhiBFLNj2tUkEX8XZqswgRU=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1758880051; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=Fl3lCTfdOpDriccZ8YANrmrDoa3N7fGM3MaZK+KBq4g=;
	b=e9tArgexXoKSZMbwORsmKHXd9K19ba8xuGtBNxSQp8Q/6d2B04C89mAwzr4Zseqis5GuXe
	kze3l402eswRUFcKBi+8i7pgMDmvgo+ZOk0/jlTsTIBawDRKgdr+d8d4ATqKgUrcOrtLzK
	txZh4NixYhiBFLNj2tUkEX8XZqswgRU=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 92BD51373E;
	Fri, 26 Sep 2025 09:47:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id c5/KIzNh1mgxEQAAD6G6ig
	(envelope-from <dsterba@suse.com>); Fri, 26 Sep 2025 09:47:31 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH] btrfs: fix trivial -Wshadow warnings
Date: Fri, 26 Sep 2025 11:47:30 +0200
Message-ID: <20250926094730.3598980-1-dsterba@suse.com>
X-Mailer: git-send-email 2.51.0
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

When compiling with -Wshadow (also in 'make W=2' build) there are
several reports of shadowed variables that seem to be harmless:

- btrfs_do_encoded_write() - we can reuse 'ordered', there's no previous
			     value that would need to be preserved

- scrub_write_endio() - we need a standalone 'i' for bio iteration

- scrub_stripe() - duplicate ret2 for errors that must not overwrite 'ret'

- btrfs_subpage_set_writeback() - 'flags' is used for another irqsave lock
                                  but is not overwritten when reused for xarray
				  due to scoping, but for clarity let's rename it

- process_dir_items_leaf() - duplicate 'ret', used only for immediate checks

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/inode.c    | 2 --
 fs/btrfs/scrub.c    | 4 +---
 fs/btrfs/subpage.c  | 6 +++---
 fs/btrfs/tree-log.c | 3 ---
 4 files changed, 4 insertions(+), 11 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 02cb081697fea4..ac2fd589697da4 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -9822,8 +9822,6 @@ ssize_t btrfs_do_encoded_write(struct kiocb *iocb, struct iov_iter *from,
 	}
 
 	for (;;) {
-		struct btrfs_ordered_extent *ordered;
-
 		ret = btrfs_wait_ordered_range(inode, start, num_bytes);
 		if (ret)
 			goto out_folios;
diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index 4691d0bdb2e86c..d450ccd3fc7c85 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -1284,7 +1284,7 @@ static void scrub_write_endio(struct btrfs_bio *bbio)
 		bitmap_set(&stripe->write_error_bitmap, sector_nr,
 			   bio_size >> fs_info->sectorsize_bits);
 		spin_unlock_irqrestore(&stripe->write_error_lock, flags);
-		for (int i = 0; i < (bio_size >> fs_info->sectorsize_bits); i++)
+		for (i = 0; i < (bio_size >> fs_info->sectorsize_bits); i++)
 			btrfs_dev_stat_inc_and_print(stripe->dev,
 						     BTRFS_DEV_STAT_WRITE_ERRS);
 	}
@@ -2527,8 +2527,6 @@ static noinline_for_stack int scrub_stripe(struct scrub_ctx *sctx,
 	}
 
 	if (sctx->is_dev_replace && ret >= 0) {
-		int ret2;
-
 		ret2 = sync_write_pointer_for_zoned(sctx,
 				chunk_logical + offset,
 				map->stripes[stripe_index].physical,
diff --git a/fs/btrfs/subpage.c b/fs/btrfs/subpage.c
index 5ca8d4db67220c..01bf58fa92aa2e 100644
--- a/fs/btrfs/subpage.c
+++ b/fs/btrfs/subpage.c
@@ -460,12 +460,12 @@ void btrfs_subpage_set_writeback(const struct btrfs_fs_info *fs_info,
 	if (!folio_test_dirty(folio)) {
 		struct address_space *mapping = folio_mapping(folio);
 		XA_STATE(xas, &mapping->i_pages, folio->index);
-		unsigned long flags;
+		unsigned long xa_flags;
 
-		xas_lock_irqsave(&xas, flags);
+		xas_lock_irqsave(&xas, xa_flags);
 		xas_load(&xas);
 		xas_clear_mark(&xas, PAGECACHE_TAG_TOWRITE);
-		xas_unlock_irqrestore(&xas, flags);
+		xas_unlock_irqrestore(&xas, xa_flags);
 	}
 	spin_unlock_irqrestore(&bfs->lock, flags);
 }
diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 6aad6b65522b21..08d72506a3d2fb 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -4154,7 +4154,6 @@ static int process_dir_items_leaf(struct btrfs_trans_handle *trans,
 	for (int i = path->slots[0]; i < nritems; i++) {
 		struct btrfs_dir_item *di;
 		struct btrfs_key key;
-		int ret;
 
 		btrfs_item_key_to_cpu(src, &key, i);
 
@@ -4224,8 +4223,6 @@ static int process_dir_items_leaf(struct btrfs_trans_handle *trans,
 	}
 
 	if (batch_size > 0) {
-		int ret;
-
 		ret = flush_dir_items_batch(trans, inode, src, dst_path,
 					    batch_start, batch_size);
 		if (ret < 0)
-- 
2.51.0


