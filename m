Return-Path: <linux-btrfs+bounces-12833-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E4CF6A7D3D4
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Apr 2025 08:10:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 451051695EC
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Apr 2025 06:10:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36E62224AFE;
	Mon,  7 Apr 2025 06:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="lxUS6q9L";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="lxUS6q9L"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A47FA55
	for <linux-btrfs@vger.kernel.org>; Mon,  7 Apr 2025 06:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744006192; cv=none; b=e+OHQpg0cYOllTZdUOn9bmD6lSoHE65kouXbiOQaFUvZUgMbjKF2nuGGjfh1VsXfH7iFI4fM2dSJzwYL51AhX9w6f89dltlXPme1wnTIAH5Heieg1LDnBbbzBSovo6ezs4R4zaS5r+0R5yggnt1V4Iyul+wfR0wXEdDmrpXvmps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744006192; c=relaxed/simple;
	bh=dVX5+S5X9Kws7fokaWGxMEXU0FBTA8uvKw6nDwe3E74=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eFRr3PNIOcjgNmm9sV/tDT8LxBWP5VvumKjHGBytSLBTb4gv34EJZUCCUOaSsAz2yYjvA9etl6jTdNtgCFni0XGotK8THDf3XJm4c4PWfQ3ls6cCgqwxEOvxuxyblkisOYb8XLzA9ZP++v81YnJUX60Ktn+nZNycZ2OdSSyUgaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=lxUS6q9L; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=lxUS6q9L; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B8D7421191
	for <linux-btrfs@vger.kernel.org>; Mon,  7 Apr 2025 06:09:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1744006182; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=H4pA3ka5Bjb9MircUWtTtekXXfJGAA8OjCSLEGYN1fU=;
	b=lxUS6q9L+InMkgXzkDsMqBbfj+YJ5UwfgF/gu+xOQUZz/Y/0r2D4ghYO/QPMo940a13Du2
	QEVDH5ZDu67XAklfw2XXGsqXN2fO6hJfWN5Z2RRVp7UYHlDxIkPYbLP2dsb4NWnBqWW3iI
	4KvTiuktZMDkf9BFYq+CgZLd/7g674U=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=lxUS6q9L
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1744006182; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=H4pA3ka5Bjb9MircUWtTtekXXfJGAA8OjCSLEGYN1fU=;
	b=lxUS6q9L+InMkgXzkDsMqBbfj+YJ5UwfgF/gu+xOQUZz/Y/0r2D4ghYO/QPMo940a13Du2
	QEVDH5ZDu67XAklfw2XXGsqXN2fO6hJfWN5Z2RRVp7UYHlDxIkPYbLP2dsb4NWnBqWW3iI
	4KvTiuktZMDkf9BFYq+CgZLd/7g674U=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F3BD213691
	for <linux-btrfs@vger.kernel.org>; Mon,  7 Apr 2025 06:09:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id SDDiLCVs82eIfwAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Mon, 07 Apr 2025 06:09:41 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 2/2] btrfs: enable larger data folios support for defrag
Date: Mon,  7 Apr 2025 15:39:21 +0930
Message-ID: <57244fa5fbd1e35dfecb3ecc172ca75b9df67e91.1744005845.git.wqu@suse.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1744005845.git.wqu@suse.com>
References: <cover.1744005845.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: B8D7421191
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
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:mid,suse.com:email];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[suse.com:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

Currently we rejects larger folios for defrag gracefully, but the
implementation itself is already mostly larger folios compatible.

There are several parts of defrag in btrfs:

- Extent map checking
  Aka, defrag_collect_targets(), which prepares a list of target ranges
  that should be defragged.

  This part is completely folio unrelated, thus it doesn't care about
  the folio size.

- Target folio preparation
  Aka, defrag_prepare_one_folio(), which lock and read (if needed) the
  target folio.

  Since folio read and lock are already supporting larger folios, this
  part needs only minor changes.

- Redirty the target range of the folio
  This is already done in a way supporting larger folios.

So it's pretty straightforward to enable larger folios for defrag:

- Do not reject larger folios for experimental builds
  This affects the larger folio check inside defrag_prepare_one_folio().

- Wait for ordered extents of the whole folio in
  defrag_prepare_one_folio()

- Lock the whole extent range for all involved folios in
  defrag_one_range()

- Allow the folios[] array to be partially empty
  Since we can have larger folios, folios[] will not always be full.

  This affects:
  * How to allocate folios in defrag_one_range()
    Now we can not use page index, but use the end position of the folio
    as an iterator.

  * How to free the folios[] array
    If we hit an empty slot, it means we have larger folios and already
    hit the end of the array.

  * How to mark the range dirty
    Instead of use page index directly, we have to go through each
    folio.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/defrag.c | 72 +++++++++++++++++++++++++++--------------------
 1 file changed, 42 insertions(+), 30 deletions(-)

diff --git a/fs/btrfs/defrag.c b/fs/btrfs/defrag.c
index d4310d93f532..f2fa8b5c64b5 100644
--- a/fs/btrfs/defrag.c
+++ b/fs/btrfs/defrag.c
@@ -857,13 +857,14 @@ static struct folio *defrag_prepare_one_folio(struct btrfs_inode *inode, pgoff_t
 {
 	struct address_space *mapping = inode->vfs_inode.i_mapping;
 	gfp_t mask = btrfs_alloc_write_mask(mapping);
-	u64 page_start = (u64)index << PAGE_SHIFT;
-	u64 page_end = page_start + PAGE_SIZE - 1;
+	u64 folio_start;
+	u64 folio_end;
 	struct extent_state *cached_state = NULL;
 	struct folio *folio;
 	int ret;
 
 again:
+	/* TODO: Add order fgp order flags when larger folios are fully enabled. */
 	folio = __filemap_get_folio(mapping, index,
 				    FGP_LOCK | FGP_ACCESSED | FGP_CREAT, mask);
 	if (IS_ERR(folio))
@@ -871,13 +872,16 @@ static struct folio *defrag_prepare_one_folio(struct btrfs_inode *inode, pgoff_t
 
 	/*
 	 * Since we can defragment files opened read-only, we can encounter
-	 * transparent huge pages here (see CONFIG_READ_ONLY_THP_FOR_FS). We
-	 * can't do I/O using huge pages yet, so return an error for now.
+	 * transparent huge pages here (see CONFIG_READ_ONLY_THP_FOR_FS).
+	 *
+	 * The IO for such larger folios are not fully tested, thus return
+	 * an error to reject such folios unless it's an experimental build.
+	 *
 	 * Filesystem transparent huge pages are typically only used for
 	 * executables that explicitly enable them, so this isn't very
 	 * restrictive.
 	 */
-	if (folio_test_large(folio)) {
+	if (!IS_ENABLED(CONFIG_BTRFS_EXPERIMENTAL) && folio_test_large(folio)) {
 		folio_unlock(folio);
 		folio_put(folio);
 		return ERR_PTR(-ETXTBSY);
@@ -890,13 +894,15 @@ static struct folio *defrag_prepare_one_folio(struct btrfs_inode *inode, pgoff_t
 		return ERR_PTR(ret);
 	}
 
+	folio_start = folio_pos(folio);
+	folio_end = folio_pos(folio) + folio_size(folio) - 1;
 	/* Wait for any existing ordered extent in the range */
 	while (1) {
 		struct btrfs_ordered_extent *ordered;
 
-		lock_extent(&inode->io_tree, page_start, page_end, &cached_state);
-		ordered = btrfs_lookup_ordered_range(inode, page_start, PAGE_SIZE);
-		unlock_extent(&inode->io_tree, page_start, page_end,
+		lock_extent(&inode->io_tree, folio_start, folio_end, &cached_state);
+		ordered = btrfs_lookup_ordered_range(inode, folio_start, folio_size(folio));
+		unlock_extent(&inode->io_tree, folio_start, folio_end,
 			      &cached_state);
 		if (!ordered)
 			break;
@@ -1162,13 +1168,7 @@ static int defrag_one_locked_target(struct btrfs_inode *inode,
 	struct extent_changeset *data_reserved = NULL;
 	const u64 start = target->start;
 	const u64 len = target->len;
-	unsigned long last_index = (start + len - 1) >> PAGE_SHIFT;
-	unsigned long start_index = start >> PAGE_SHIFT;
-	unsigned long first_index = folios[0]->index;
 	int ret = 0;
-	int i;
-
-	ASSERT(last_index - first_index + 1 <= nr_pages);
 
 	ret = btrfs_delalloc_reserve_space(inode, &data_reserved, start, len);
 	if (ret < 0)
@@ -1179,10 +1179,17 @@ static int defrag_one_locked_target(struct btrfs_inode *inode,
 	set_extent_bit(&inode->io_tree, start, start + len - 1,
 		       EXTENT_DELALLOC | EXTENT_DEFRAG, cached_state);
 
-	/* Update the page status */
-	for (i = start_index - first_index; i <= last_index - first_index; i++) {
-		folio_clear_checked(folios[i]);
-		btrfs_folio_clamp_set_dirty(fs_info, folios[i], start, len);
+	/*
+	 * Update the page status.
+	 * Due to possible larger folios, we have to check all folios one by one.
+	 * And the btrfs_folio_clamp_*() helpers can handle ranges out of the
+	 * folio cases well.
+	 */
+	for (int i = 0; i < nr_pages && folios[i]; i++) {
+		struct folio *folio = folios[i];
+
+		btrfs_folio_clamp_clear_checked(fs_info, folio, start, len);
+		btrfs_folio_clamp_set_dirty(fs_info, folio, start, len);
 	}
 	btrfs_delalloc_release_extents(inode, len);
 	extent_changeset_free(data_reserved);
@@ -1200,9 +1207,9 @@ static int defrag_one_range(struct btrfs_inode *inode, u64 start, u32 len,
 	LIST_HEAD(target_list);
 	struct folio **folios;
 	const u32 sectorsize = inode->root->fs_info->sectorsize;
-	u64 last_index = (start + len - 1) >> PAGE_SHIFT;
-	u64 start_index = start >> PAGE_SHIFT;
-	unsigned int nr_pages = last_index - start_index + 1;
+	u64 cur = start;
+	const unsigned int nr_pages = ((start + len - 1) >> PAGE_SHIFT) -
+				      (start >> PAGE_SHIFT) + 1;
 	int ret = 0;
 	int i;
 
@@ -1214,21 +1221,25 @@ static int defrag_one_range(struct btrfs_inode *inode, u64 start, u32 len,
 		return -ENOMEM;
 
 	/* Prepare all pages */
-	for (i = 0; i < nr_pages; i++) {
-		folios[i] = defrag_prepare_one_folio(inode, start_index + i);
+	for (i = 0; cur < start + len && i < nr_pages; i++) {
+		folios[i] = defrag_prepare_one_folio(inode, cur >> PAGE_SHIFT);
 		if (IS_ERR(folios[i])) {
 			ret = PTR_ERR(folios[i]);
-			nr_pages = i;
+			folios[i] = NULL;
 			goto free_folios;
 		}
+		cur = folio_pos(folios[i]) + folio_size(folios[i]);
 	}
-	for (i = 0; i < nr_pages; i++)
+	for (i = 0; i < nr_pages; i++) {
+		if (!folios[i])
+			break;
 		folio_wait_writeback(folios[i]);
+	}
 
-	/* Lock the pages range */
-	lock_extent(&inode->io_tree, start_index << PAGE_SHIFT,
-		    (last_index << PAGE_SHIFT) + PAGE_SIZE - 1,
+	/* Lock the folios[] range */
+	lock_extent(&inode->io_tree, folio_pos(folios[0]), cur - 1,
 		    &cached_state);
+
 	/*
 	 * Now we have a consistent view about the extent map, re-check
 	 * which range really needs to be defragged.
@@ -1254,11 +1265,12 @@ static int defrag_one_range(struct btrfs_inode *inode, u64 start, u32 len,
 		kfree(entry);
 	}
 unlock_extent:
-	unlock_extent(&inode->io_tree, start_index << PAGE_SHIFT,
-		      (last_index << PAGE_SHIFT) + PAGE_SIZE - 1,
+	unlock_extent(&inode->io_tree, folio_pos(folios[0]), cur - 1,
 		      &cached_state);
 free_folios:
 	for (i = 0; i < nr_pages; i++) {
+		if (!folios[i])
+			break;
 		folio_unlock(folios[i]);
 		folio_put(folios[i]);
 	}
-- 
2.49.0


