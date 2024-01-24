Return-Path: <linux-btrfs+bounces-1671-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 32A8483A051
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Jan 2024 04:59:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DFE2428BBE7
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Jan 2024 03:59:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D21C6C131;
	Wed, 24 Jan 2024 03:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="j2WG7RTU";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="j2WG7RTU"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 173E863A8
	for <linux-btrfs@vger.kernel.org>; Wed, 24 Jan 2024 03:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706068759; cv=none; b=e2u4+Teuh6EuB+cOVU+CdyZp5RYuM0XgVlfGUArCCEA2ssdZTgUXbHeCb2r3Esm4UDqdR5WsXq4p8JgcKUaiAVPSRA7tVx/WXR0khwMZBBIuzpOX7wI/hNhKAzkY3tPX9pNkcuM3h28K9wApudDIb4truSJ+ysukGjUfLVIelwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706068759; c=relaxed/simple;
	bh=Y4Ug+c9k7mDmzuibC7VshRQ+TP8pQ0ndVfd9NwpyxZI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mGNULClqPfxYqU0rV4StwMXlS4Yx/F9V8hB3hHkRPrIe1zkjSFoaDXePMwG/4MPfGdRwyiVCWw7YbCI4Oxelg2T8SIIZTsx8XtbnHDajXrUhAstRDul/72i4vLOdtRJI7fnsHNcajjuZ7AWgUIHuVBGDhCzO6VUup+8PVOTrT3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=j2WG7RTU; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=j2WG7RTU; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 62FBF1FCFF
	for <linux-btrfs@vger.kernel.org>; Wed, 24 Jan 2024 03:59:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1706068755; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=E+ycAZ4V64xeEvR6KwoqVuyQ4bhgDNLGHiDRlf3QE48=;
	b=j2WG7RTUC5l348mPD8BLEObBreIIbGIgTizHZwJVx4Lkd3auLHwSm8cxfIwkmN3jJQk4YU
	hFmwVwMIOuxXaeGL4p4MvssN4zOgLDuH9CrHe4p3ApqbWoM6D8KjOfgCkwLDnHXuufxyEL
	QBNH+G/8O4iPs7BScormwvEw57oW98c=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1706068755; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=E+ycAZ4V64xeEvR6KwoqVuyQ4bhgDNLGHiDRlf3QE48=;
	b=j2WG7RTUC5l348mPD8BLEObBreIIbGIgTizHZwJVx4Lkd3auLHwSm8cxfIwkmN3jJQk4YU
	hFmwVwMIOuxXaeGL4p4MvssN4zOgLDuH9CrHe4p3ApqbWoM6D8KjOfgCkwLDnHXuufxyEL
	QBNH+G/8O4iPs7BScormwvEw57oW98c=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8ABCE136F5
	for <linux-btrfs@vger.kernel.org>; Wed, 24 Jan 2024 03:59:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id GMEFEhKLsGXVLgAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Wed, 24 Jan 2024 03:59:14 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH RFC 2/2] btrfs: defrag: prepare defrag for larger data folio size
Date: Wed, 24 Jan 2024 14:29:08 +1030
Message-ID: <5708df27430cdeaf472266b5c13dc8c4315f539c.1706068026.git.wqu@suse.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1706068026.git.wqu@suse.com>
References: <cover.1706068026.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [1.90 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 RCPT_COUNT_ONE(0.00)[1];
	 RCVD_COUNT_THREE(0.00)[3];
	 TO_DN_NONE(0.00)[];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Level: *
X-Spam-Score: 1.90
X-Spam-Flag: NO

Although we have migrated defrag to use the folio interface, we can
still further enhance it for the future larger data folio size.

This patch would:

- Rename page related variables to folio's equivalent

- Change "pgoff_t index" to "u64 folio_start" for defrag_prepare_one_folio()
  For the future multi-page sectorsize support, each data folio would be
  sector sized (except for subpage cases).
  Thus we should avoid using index, as there would be two different
  shifts:
  * PAGE_SHIFT based index
    Would be utilized in filemap related interfaces

  * Folio shift based index
    Would be utilized for the remaining cases

  So here we use the "u64 folio_start" to represent one folio

- Use fs_info->folio_shift to replace PAGE_SHIFT
  Since in the future the data folios would no longer be page sized, use
  the cached fs_info->folio_shift to handle both multi-page and subpage
  cases.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/defrag.c | 69 +++++++++++++++++++++++++----------------------
 1 file changed, 37 insertions(+), 32 deletions(-)

diff --git a/fs/btrfs/defrag.c b/fs/btrfs/defrag.c
index dd1b5a060366..07df0081ac57 100644
--- a/fs/btrfs/defrag.c
+++ b/fs/btrfs/defrag.c
@@ -861,18 +861,19 @@ static bool defrag_check_next_extent(struct inode *inode, struct extent_map *em,
  * NOTE: Caller should also wait for page writeback after the cluster is
  * prepared, here we don't do writeback wait for each page.
  */
-static struct folio *defrag_prepare_one_folio(struct btrfs_inode *inode, pgoff_t index)
+static struct folio *defrag_prepare_one_folio(struct btrfs_inode *inode,
+					      u64 folio_start)
 {
+	struct btrfs_fs_info *fs_info = inode->root->fs_info;
 	struct address_space *mapping = inode->vfs_inode.i_mapping;
 	gfp_t mask = btrfs_alloc_write_mask(mapping);
-	u64 page_start = (u64)index << PAGE_SHIFT;
-	u64 page_end = page_start + PAGE_SIZE - 1;
+	u64 folio_end = folio_start + fs_info->folio_size - 1;
 	struct extent_state *cached_state = NULL;
 	struct folio *folio;
 	int ret;
 
 again:
-	folio = __filemap_get_folio(mapping, index,
+	folio = __filemap_get_folio(mapping, folio_start >> PAGE_SHIFT,
 				    FGP_LOCK | FGP_ACCESSED | FGP_CREAT, mask);
 	if (IS_ERR(folio))
 		return folio;
@@ -902,9 +903,10 @@ static struct folio *defrag_prepare_one_folio(struct btrfs_inode *inode, pgoff_t
 	while (1) {
 		struct btrfs_ordered_extent *ordered;
 
-		lock_extent(&inode->io_tree, page_start, page_end, &cached_state);
-		ordered = btrfs_lookup_ordered_range(inode, page_start, PAGE_SIZE);
-		unlock_extent(&inode->io_tree, page_start, page_end,
+		lock_extent(&inode->io_tree, folio_start, folio_end, &cached_state);
+		ordered = btrfs_lookup_ordered_range(inode, folio_start,
+						     fs_info->folio_size);
+		unlock_extent(&inode->io_tree, folio_start, folio_end,
 			      &cached_state);
 		if (!ordered)
 			break;
@@ -1163,20 +1165,20 @@ static_assert(PAGE_ALIGNED(CLUSTER_SIZE));
  */
 static int defrag_one_locked_target(struct btrfs_inode *inode,
 				    struct defrag_target_range *target,
-				    struct folio **folios, int nr_pages,
+				    struct folio **folios, int nr_folios,
 				    struct extent_state **cached_state)
 {
 	struct btrfs_fs_info *fs_info = inode->root->fs_info;
 	struct extent_changeset *data_reserved = NULL;
 	const u64 start = target->start;
 	const u64 len = target->len;
-	unsigned long last_index = (start + len - 1) >> PAGE_SHIFT;
-	unsigned long start_index = start >> PAGE_SHIFT;
+	unsigned long last_index = (start + len - 1) >> fs_info->folio_shift;
+	unsigned long start_index = start >> fs_info->folio_shift;
 	unsigned long first_index = folios[0]->index;
 	int ret = 0;
 	int i;
 
-	ASSERT(last_index - first_index + 1 <= nr_pages);
+	ASSERT(last_index - first_index + 1 <= nr_folios);
 
 	ret = btrfs_delalloc_reserve_space(inode, &data_reserved, start, len);
 	if (ret < 0)
@@ -1187,7 +1189,7 @@ static int defrag_one_locked_target(struct btrfs_inode *inode,
 	set_extent_bit(&inode->io_tree, start, start + len - 1,
 		       EXTENT_DELALLOC | EXTENT_DEFRAG, cached_state);
 
-	/* Update the page status */
+	/* Update the folio status */
 	for (i = start_index - first_index; i <= last_index - first_index; i++) {
 		folio_clear_checked(folios[i]);
 		btrfs_folio_clamp_set_dirty(fs_info, folios[i], start, len);
@@ -1202,40 +1204,42 @@ static int defrag_one_range(struct btrfs_inode *inode, u64 start, u32 len,
 			    u32 extent_thresh, u64 newer_than, bool do_compress,
 			    u64 *last_scanned_ret)
 {
+	struct btrfs_fs_info *fs_info = inode->root->fs_info;
 	struct extent_state *cached_state = NULL;
 	struct defrag_target_range *entry;
 	struct defrag_target_range *tmp;
 	LIST_HEAD(target_list);
 	struct folio **folios;
-	const u32 sectorsize = inode->root->fs_info->sectorsize;
-	u64 last_index = (start + len - 1) >> PAGE_SHIFT;
-	u64 start_index = start >> PAGE_SHIFT;
-	unsigned int nr_pages = last_index - start_index + 1;
+	const u32 sectorsize = fs_info->sectorsize;
+	u64 last_index = (start + len - 1) >> fs_info->folio_shift;
+	u64 start_index = start >> fs_info->folio_shift;
+	unsigned int nr_folios = last_index - start_index + 1;
 	int ret = 0;
 	int i;
 
-	ASSERT(nr_pages <= CLUSTER_SIZE / PAGE_SIZE);
+	ASSERT(nr_folios <= (CLUSTER_SIZE >> fs_info->folio_shift));
 	ASSERT(IS_ALIGNED(start, sectorsize) && IS_ALIGNED(len, sectorsize));
 
-	folios = kcalloc(nr_pages, sizeof(struct folio *), GFP_NOFS);
+	folios = kcalloc(nr_folios, sizeof(struct folio *), GFP_NOFS);
 	if (!folios)
 		return -ENOMEM;
 
 	/* Prepare all pages */
-	for (i = 0; i < nr_pages; i++) {
-		folios[i] = defrag_prepare_one_folio(inode, start_index + i);
+	for (i = 0; i < nr_folios ; i++) {
+		folios[i] = defrag_prepare_one_folio(inode,
+				(start_index + i) << fs_info->folio_shift);
 		if (IS_ERR(folios[i])) {
 			ret = PTR_ERR(folios[i]);
-			nr_pages = i;
+			nr_folios = i;
 			goto free_folios;
 		}
 	}
-	for (i = 0; i < nr_pages; i++)
+	for (i = 0; i < nr_folios; i++)
 		folio_wait_writeback(folios[i]);
 
 	/* Lock the pages range */
-	lock_extent(&inode->io_tree, start_index << PAGE_SHIFT,
-		    (last_index << PAGE_SHIFT) + PAGE_SIZE - 1,
+	lock_extent(&inode->io_tree, start_index << fs_info->folio_shift,
+		    (last_index << fs_info->folio_shift) + fs_info->folio_size - 1,
 		    &cached_state);
 	/*
 	 * Now we have a consistent view about the extent map, re-check
@@ -1251,7 +1255,7 @@ static int defrag_one_range(struct btrfs_inode *inode, u64 start, u32 len,
 		goto unlock_extent;
 
 	list_for_each_entry(entry, &target_list, list) {
-		ret = defrag_one_locked_target(inode, entry, folios, nr_pages,
+		ret = defrag_one_locked_target(inode, entry, folios, nr_folios,
 					       &cached_state);
 		if (ret < 0)
 			break;
@@ -1262,11 +1266,11 @@ static int defrag_one_range(struct btrfs_inode *inode, u64 start, u32 len,
 		kfree(entry);
 	}
 unlock_extent:
-	unlock_extent(&inode->io_tree, start_index << PAGE_SHIFT,
-		      (last_index << PAGE_SHIFT) + PAGE_SIZE - 1,
+	unlock_extent(&inode->io_tree, start_index << fs_info->folio_shift,
+		      (last_index << fs_info->folio_shift) + fs_info->folio_size - 1,
 		      &cached_state);
 free_folios:
-	for (i = 0; i < nr_pages; i++) {
+	for (i = 0; i < nr_folios; i++) {
 		folio_unlock(folios[i]);
 		folio_put(folios[i]);
 	}
@@ -1282,7 +1286,8 @@ static int defrag_one_cluster(struct btrfs_inode *inode,
 			      unsigned long max_sectors,
 			      u64 *last_scanned_ret)
 {
-	const u32 sectorsize = inode->root->fs_info->sectorsize;
+	struct btrfs_fs_info *fs_info = inode->root->fs_info;
+	const u32 sectorsize = fs_info->sectorsize;
 	struct defrag_target_range *entry;
 	struct defrag_target_range *tmp;
 	LIST_HEAD(target_list);
@@ -1421,7 +1426,7 @@ int btrfs_defrag_file(struct inode *inode, struct file_ra_state *ra,
 	 * Make writeback start from the beginning of the range, so that the
 	 * defrag range can be written sequentially.
 	 */
-	start_index = cur >> PAGE_SHIFT;
+	start_index = cur >> fs_info->folio_shift;
 	if (start_index < inode->i_mapping->writeback_index)
 		inode->i_mapping->writeback_index = start_index;
 
@@ -1436,8 +1441,8 @@ int btrfs_defrag_file(struct inode *inode, struct file_ra_state *ra,
 		}
 
 		/* We want the cluster end at page boundary when possible */
-		cluster_end = (((cur >> PAGE_SHIFT) +
-			       (SZ_256K >> PAGE_SHIFT)) << PAGE_SHIFT) - 1;
+		cluster_end = (((cur >> fs_info->folio_shift) +
+			(SZ_256K >> fs_info->folio_shift)) << fs_info->folio_shift) - 1;
 		cluster_end = min(cluster_end, last_byte);
 
 		btrfs_inode_lock(BTRFS_I(inode), 0);
-- 
2.43.0


