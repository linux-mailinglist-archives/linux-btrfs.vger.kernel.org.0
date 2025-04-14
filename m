Return-Path: <linux-btrfs+bounces-13014-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C070CA89029
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Apr 2025 01:27:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69D953ACF8F
	for <lists+linux-btrfs@lfdr.de>; Mon, 14 Apr 2025 23:26:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6F711FDA89;
	Mon, 14 Apr 2025 23:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="prGhA5Nb";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="prGhA5Nb"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AB541DE3BB
	for <linux-btrfs@vger.kernel.org>; Mon, 14 Apr 2025 23:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744673215; cv=none; b=XNbT3idcjPv/zv1D1V3b7pthgLobYaqPoKfm752vdeUsmkPZygsHjPLnTOnL8KGhd/7pRUS7azlXvyEPWkm9FL9KGfx1HufqvzrMXKHtWpPufZezBSTl3gOPgcQQ4cczFcoCR3eE/gtbtMpv8nOqDc0v1L7mro3rxIWMMPnHOVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744673215; c=relaxed/simple;
	bh=9Qsqa7f0ijHMpJNCnzVrD10k+9URmLLklIMiifmlMRE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=G8TlqwftIOOL5Cvsr1STWdyDvPw/KRwan1J6QT+xGx2Si4MYXuvDE/9nNSdma1kkpacauIyd2xUXfAumcf0Yq8ijUUJ+WAyt73tTH8xr+npcYV1dEjbeHwjVC66J6VZaneHHXcKX1n8NiYvHPnredHQtx5lspo6ScUDdPr40VNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=prGhA5Nb; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=prGhA5Nb; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 859B721181;
	Mon, 14 Apr 2025 23:26:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1744673210; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=gp+OGA7rIsd0a+kQDzco/nbk8Otn8qlJESVF8FlBvkA=;
	b=prGhA5NbOjARiKGWSDgDgi6MwSIFQ5GjoomKOkeXFkRWEBveyf0OWNns/HFmV8QfGmMLE0
	XOdh01WbdgwYV8yaYI55S9z5XLZ3f9RImr+2xq42feThRFToEPMBPriRU1NyOK70Jr6RHG
	VtnZ8lorfviyyYqWJLHPlczOHzuI6HA=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1744673210; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=gp+OGA7rIsd0a+kQDzco/nbk8Otn8qlJESVF8FlBvkA=;
	b=prGhA5NbOjARiKGWSDgDgi6MwSIFQ5GjoomKOkeXFkRWEBveyf0OWNns/HFmV8QfGmMLE0
	XOdh01WbdgwYV8yaYI55S9z5XLZ3f9RImr+2xq42feThRFToEPMBPriRU1NyOK70Jr6RHG
	VtnZ8lorfviyyYqWJLHPlczOHzuI6HA=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 88298136A7;
	Mon, 14 Apr 2025 23:26:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id pPmcErmZ/WcHKgAAD6G6ig
	(envelope-from <wqu@suse.com>); Mon, 14 Apr 2025 23:26:49 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: Filipe Manana <fdmanana@suse.com>
Subject: [PATCH v2] btrfs: enable large data folios support for defrag
Date: Tue, 15 Apr 2025 08:56:27 +0930
Message-ID: <07782555babf6ff62d3e12eac3b24c930e3fd224.1744673127.git.wqu@suse.com>
X-Mailer: git-send-email 2.49.0
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
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:mid,imap1.dmz-prg2.suse.org:helo];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Score: -2.80
X-Spam-Flag: NO

Currently we reject large folios for defrag gracefully, but the
implementation itself is already mostly large folios compatible.

There are several parts of defrag in btrfs:

- Extent map checking
  Aka, defrag_collect_targets(), which prepares a list of target ranges
  that should be defragged.

  This part is completely folio unrelated, thus it doesn't care about
  the folio size.

- Target folio preparation
  Aka, defrag_prepare_one_folio(), which lock and read (if needed) the
  target folio.

  Since folio read and lock are already supporting large folios, this
  part needs only minor changes.

- Redirty the target range of the folio
  This is already done in a way supporting large folios.

So it's pretty straightforward to enable large folios for defrag:

- Do not reject large folios for experimental builds
  This affects the large folio check inside defrag_prepare_one_folio().

- Wait for ordered extents of the whole folio in
  defrag_prepare_one_folio()

- Lock the whole extent range for all involved folios in
  defrag_one_range()

- Allow the folios[] array to be partially empty
  Since we can have large folios, folios[] will not always be full.

  This affects:
  * How to allocate folios in defrag_one_range()
    Now we can not use page index, but use the end position of the folio
    as an iterator.

  * How to free the folios[] array
    If we hit an empty slot, it means we have large folios and already
    hit the end of the array.

  * How to mark the range dirty
    Instead of use page index directly, we have to go through each
    folio, and check if the folio covers the defrag target inside
    defrag_one_locked_target().

Reviewed-by: Filipe Manana <fdmanana@suse.com>
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
Changelog:
v2:
- Rebased to the latest for-next
  Some minor renames around the io tree locking.
- Fix various grammar and newline problems
- Declare local variable @i inside the for loop
- Do proper range checks inside defrag_one_locked_target()
  As btrfs_folio_clamp_*() helpers can not handle case where the range
  is beyond the folio.
  The helpers can only handle cases there the range is before the folio.
---
 fs/btrfs/defrag.c | 79 ++++++++++++++++++++++++++++-------------------
 1 file changed, 48 insertions(+), 31 deletions(-)

diff --git a/fs/btrfs/defrag.c b/fs/btrfs/defrag.c
index 9dfdf29f54a0..fb59cb8f51e9 100644
--- a/fs/btrfs/defrag.c
+++ b/fs/btrfs/defrag.c
@@ -854,13 +854,14 @@ static struct folio *defrag_prepare_one_folio(struct btrfs_inode *inode, pgoff_t
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
+	/* TODO: Add order fgp order flags when large folios are fully enabled. */
 	folio = __filemap_get_folio(mapping, index,
 				    FGP_LOCK | FGP_ACCESSED | FGP_CREAT, mask);
 	if (IS_ERR(folio))
@@ -868,13 +869,16 @@ static struct folio *defrag_prepare_one_folio(struct btrfs_inode *inode, pgoff_t
 
 	/*
 	 * Since we can defragment files opened read-only, we can encounter
-	 * transparent huge pages here (see CONFIG_READ_ONLY_THP_FOR_FS). We
-	 * can't do I/O using huge pages yet, so return an error for now.
+	 * transparent huge pages here (see CONFIG_READ_ONLY_THP_FOR_FS).
+	 *
+	 * The IO for such large folios is not fully tested, thus return
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
@@ -887,13 +891,17 @@ static struct folio *defrag_prepare_one_folio(struct btrfs_inode *inode, pgoff_t
 		return ERR_PTR(ret);
 	}
 
+	folio_start = folio_pos(folio);
+	folio_end = folio_pos(folio) + folio_size(folio) - 1;
 	/* Wait for any existing ordered extent in the range */
 	while (1) {
 		struct btrfs_ordered_extent *ordered;
 
-		btrfs_lock_extent(&inode->io_tree, page_start, page_end, &cached_state);
-		ordered = btrfs_lookup_ordered_range(inode, page_start, PAGE_SIZE);
-		btrfs_unlock_extent(&inode->io_tree, page_start, page_end,
+		btrfs_lock_extent(&inode->io_tree, folio_start, folio_end,
+				  &cached_state);
+		ordered = btrfs_lookup_ordered_range(inode, folio_start,
+						     folio_size(folio));
+		btrfs_unlock_extent(&inode->io_tree, folio_start, folio_end,
 				    &cached_state);
 		if (!ordered)
 			break;
@@ -1159,13 +1167,7 @@ static int defrag_one_locked_target(struct btrfs_inode *inode,
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
@@ -1176,10 +1178,20 @@ static int defrag_one_locked_target(struct btrfs_inode *inode,
 	btrfs_set_extent_bit(&inode->io_tree, start, start + len - 1,
 			     EXTENT_DELALLOC | EXTENT_DEFRAG, cached_state);
 
-	/* Update the page status */
-	for (i = start_index - first_index; i <= last_index - first_index; i++) {
-		folio_clear_checked(folios[i]);
-		btrfs_folio_clamp_set_dirty(fs_info, folios[i], start, len);
+	/*
+	 * Update the page status.
+	 * Due to possible larger folios, we have to check all folios one by one.
+	 */
+	for (int i = 0; i < nr_pages && folios[i]; i++) {
+		struct folio *folio = folios[i];
+
+		if (!folio)
+			break;
+		if (start >= folio_pos(folio) + folio_size(folio) ||
+		    start + len <= folio_pos(folio))
+			continue;
+		btrfs_folio_clamp_clear_checked(fs_info, folio, start, len);
+		btrfs_folio_clamp_set_dirty(fs_info, folio, start, len);
 	}
 	btrfs_delalloc_release_extents(inode, len);
 	extent_changeset_free(data_reserved);
@@ -1197,11 +1209,10 @@ static int defrag_one_range(struct btrfs_inode *inode, u64 start, u32 len,
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
-	int i;
 
 	ASSERT(nr_pages <= CLUSTER_SIZE / PAGE_SIZE);
 	ASSERT(IS_ALIGNED(start, sectorsize) && IS_ALIGNED(len, sectorsize));
@@ -1211,20 +1222,25 @@ static int defrag_one_range(struct btrfs_inode *inode, u64 start, u32 len,
 		return -ENOMEM;
 
 	/* Prepare all pages */
-	for (i = 0; i < nr_pages; i++) {
-		folios[i] = defrag_prepare_one_folio(inode, start_index + i);
+	for (int i = 0; cur < start + len && i < nr_pages; i++) {
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
+	for (int i = 0; i < nr_pages; i++) {
+		if (!folios[i])
+			break;
 		folio_wait_writeback(folios[i]);
+	}
 
+	/* We should got at least one folio. */
+	ASSERT(folios[0]);
 	/* Lock the pages range */
-	btrfs_lock_extent(&inode->io_tree, start_index << PAGE_SHIFT,
-			  (last_index << PAGE_SHIFT) + PAGE_SIZE - 1,
+	btrfs_lock_extent(&inode->io_tree, folio_pos(folios[0]), cur - 1,
 			  &cached_state);
 	/*
 	 * Now we have a consistent view about the extent map, re-check
@@ -1251,11 +1267,12 @@ static int defrag_one_range(struct btrfs_inode *inode, u64 start, u32 len,
 		kfree(entry);
 	}
 unlock_extent:
-	btrfs_unlock_extent(&inode->io_tree, start_index << PAGE_SHIFT,
-			    (last_index << PAGE_SHIFT) + PAGE_SIZE - 1,
+	btrfs_unlock_extent(&inode->io_tree, folio_pos(folios[0]), cur - 1,
 			    &cached_state);
 free_folios:
-	for (i = 0; i < nr_pages; i++) {
+	for (int i = 0; i < nr_pages; i++) {
+		if (!folios[i])
+			break;
 		folio_unlock(folios[i]);
 		folio_put(folios[i]);
 	}
-- 
2.49.0


