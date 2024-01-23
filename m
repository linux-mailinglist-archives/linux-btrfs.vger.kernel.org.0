Return-Path: <linux-btrfs+bounces-1653-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 09262839980
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 Jan 2024 20:28:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 78E521F23411
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 Jan 2024 19:28:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CDD885C5E;
	Tue, 23 Jan 2024 19:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="nr37F/RE";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Ig71d/x3";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="nr37F/RE";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Ig71d/x3"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9991685C44
	for <linux-btrfs@vger.kernel.org>; Tue, 23 Jan 2024 19:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706038044; cv=none; b=sbrn8wYuv/HBag6IcPqOJzqgVo35fUz5PLZ5Pk2zaV1KJ4lFGuQSFiiTlukf5EEXhvzN7oNkiewfZdHcMxmI02+Xnjf96x85ixNqaW2qxag4intP64udaCcfMfPndE/PJtx5RYwmVhvn2sG3fby7tJmkFb5IKYjkBChhXgvQrP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706038044; c=relaxed/simple;
	bh=UpDHHBVGFPRXZAR+sW75ZfTKlpNn61czivE2ox2W4BI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PlNmqtRBItn/3hSp7pBICe2LtVATHC57b219QwboVWbK3a1yJ2jPYvJb+V599Mi+Of6wjBUYfaVoKt84/osJupuBDpdRQjo0+xVmzG9dDnsrzTrn/iqkuXcgHDKTitquGdwfHzI9hoiNcxDgSay5Zcgsj6O5w4Ke8p6VN3y0fh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=nr37F/RE; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Ig71d/x3; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=nr37F/RE; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Ig71d/x3; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id DAC301F7A0;
	Tue, 23 Jan 2024 19:27:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1706038040; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=47S/w7Mnor8ODM6WKY21zB0pz1U9A84epgcZT9KJDTM=;
	b=nr37F/RE66vo3LtCMEqQvIZ48ppSSVhCLCpGPdo2uvvEImlTMTdvwQ7u9DynCuxg9TA4n0
	+nBFkgRdLST8dW7On1yWL0FXVRg5dMu8yN69rOXOweaup6SyHsTkW8dA0DNl3lz2G3gPjw
	w1PXgh6ptr7htYZx55RTBQwPW0JRl8o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1706038040;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=47S/w7Mnor8ODM6WKY21zB0pz1U9A84epgcZT9KJDTM=;
	b=Ig71d/x3rsLKbESaoexSWlkahqpV6umIsWQ89dksgqkqnFV4DvZDUWcqtGoULWy6kfJ3NW
	v0CqTV8sJrgmXmCg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1706038040; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=47S/w7Mnor8ODM6WKY21zB0pz1U9A84epgcZT9KJDTM=;
	b=nr37F/RE66vo3LtCMEqQvIZ48ppSSVhCLCpGPdo2uvvEImlTMTdvwQ7u9DynCuxg9TA4n0
	+nBFkgRdLST8dW7On1yWL0FXVRg5dMu8yN69rOXOweaup6SyHsTkW8dA0DNl3lz2G3gPjw
	w1PXgh6ptr7htYZx55RTBQwPW0JRl8o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1706038040;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=47S/w7Mnor8ODM6WKY21zB0pz1U9A84epgcZT9KJDTM=;
	b=Ig71d/x3rsLKbESaoexSWlkahqpV6umIsWQ89dksgqkqnFV4DvZDUWcqtGoULWy6kfJ3NW
	v0CqTV8sJrgmXmCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 72FE913786;
	Tue, 23 Jan 2024 19:27:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id HNIeERgTsGXVQAAAD6G6ig
	(envelope-from <rgoldwyn@suse.de>); Tue, 23 Jan 2024 19:27:20 +0000
From: Goldwyn Rodrigues <rgoldwyn@suse.de>
To: linux-btrfs@vger.kernel.org
Cc: Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: [PATCH 2/3] btrfs: convert relocate_one_page() to relocate_one_folio()
Date: Tue, 23 Jan 2024 13:28:06 -0600
Message-ID: <0ad1a3b7098c852f6e0d41770fae5daea70ea8d1.1706037337.git.rgoldwyn@suse.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1706037337.git.rgoldwyn@suse.com>
References: <cover.1706037337.git.rgoldwyn@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [0.90 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 RCPT_COUNT_TWO(0.00)[2];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: 0.90

From: Goldwyn Rodrigues <rgoldwyn@suse.com>

Convert page references to folios and call the respective folio
functions.

Since find_or_create_page() takes a mask argument, call
__filemap_get_folio() instead of filemap_grab_folio().

The patch assumes folio size is PAGE_SIZE, so added a
WARN_ON(folio_order(folio)) to warn future development
of using larger folio sizes.

Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
---
 fs/btrfs/relocation.c | 91 ++++++++++++++++++++++---------------------
 1 file changed, 46 insertions(+), 45 deletions(-)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index c365bfc60652..d9e70106c901 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -2849,7 +2849,7 @@ static noinline_for_stack int prealloc_file_extent_cluster(
 	 * btrfs_do_readpage() call of previously relocated file cluster.
 	 *
 	 * If the current cluster starts in the above range, btrfs_do_readpage()
-	 * will skip the read, and relocate_one_page() will later writeback
+	 * will skip the read, and relocate_one_folio() will later writeback
 	 * the padding zeros as new data, causing data corruption.
 	 *
 	 * Here we have to manually invalidate the range (i_size, PAGE_END + 1).
@@ -2983,68 +2983,71 @@ static u64 get_cluster_boundary_end(const struct file_extent_cluster *cluster,
 	return cluster->boundary[cluster_nr + 1] - 1;
 }
 
-static int relocate_one_page(struct inode *inode, struct file_ra_state *ra,
+static int relocate_one_folio(struct inode *inode, struct file_ra_state *ra,
 			     const struct file_extent_cluster *cluster,
-			     int *cluster_nr, unsigned long page_index)
+			     int *cluster_nr, unsigned long index)
 {
 	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
 	u64 offset = BTRFS_I(inode)->index_cnt;
 	const unsigned long last_index = (cluster->end - offset) >> PAGE_SHIFT;
 	gfp_t mask = btrfs_alloc_write_mask(inode->i_mapping);
-	struct page *page;
-	u64 page_start;
-	u64 page_end;
+	struct folio *folio;
+	u64 folio_start;
+	u64 folio_end;
 	u64 cur;
 	int ret;
 
-	ASSERT(page_index <= last_index);
-	page = find_lock_page(inode->i_mapping, page_index);
-	if (!page) {
+	ASSERT(index <= last_index);
+	folio = filemap_lock_folio(inode->i_mapping, index);
+	if (IS_ERR(folio)) {
 		page_cache_sync_readahead(inode->i_mapping, ra, NULL,
-				page_index, last_index + 1 - page_index);
-		page = find_or_create_page(inode->i_mapping, page_index, mask);
-		if (!page)
-			return -ENOMEM;
+				index, last_index + 1 - index);
+		folio = __filemap_get_folio(inode->i_mapping, index,
+					    FGP_LOCK | FGP_ACCESSED | FGP_CREAT, mask);
+		if (IS_ERR(folio))
+			return PTR_ERR(folio);
 	}
 
-	if (PageReadahead(page))
+	WARN_ON(folio_order(folio));
+
+	if (folio_test_readahead(folio))
 		page_cache_async_readahead(inode->i_mapping, ra, NULL,
-				page_folio(page), page_index,
-				last_index + 1 - page_index);
+				folio, index,
+				last_index + 1 - index);
 
-	if (!PageUptodate(page)) {
-		btrfs_read_folio(NULL, page_folio(page));
-		lock_page(page);
-		if (!PageUptodate(page)) {
+	if (!folio_test_uptodate(folio)) {
+		btrfs_read_folio(NULL, folio);
+		folio_lock(folio);
+		if (!folio_test_uptodate(folio)) {
 			ret = -EIO;
-			goto release_page;
+			goto release_folio;
 		}
 	}
 
 	/*
-	 * We could have lost page private when we dropped the lock to read the
-	 * page above, make sure we set_page_extent_mapped here so we have any
+	 * We could have lost folio private when we dropped the lock to read the
+	 * folio above, make sure we set_page_extent_mapped here so we have any
 	 * of the subpage blocksize stuff we need in place.
 	 */
-	ret = set_page_extent_mapped(page);
+	ret = set_folio_extent_mapped(folio);
 	if (ret < 0)
-		goto release_page;
+		goto release_folio;
 
-	page_start = page_offset(page);
-	page_end = page_start + PAGE_SIZE - 1;
+	folio_start = folio_pos(folio);
+	folio_end = folio_start + PAGE_SIZE - 1;
 
 	/*
 	 * Start from the cluster, as for subpage case, the cluster can start
-	 * inside the page.
+	 * inside the folio.
 	 */
-	cur = max(page_start, cluster->boundary[*cluster_nr] - offset);
-	while (cur <= page_end) {
+	cur = max(folio_start, cluster->boundary[*cluster_nr] - offset);
+	while (cur <= folio_end) {
 		struct extent_state *cached_state = NULL;
 		u64 extent_start = cluster->boundary[*cluster_nr] - offset;
 		u64 extent_end = get_cluster_boundary_end(cluster,
 						*cluster_nr) - offset;
-		u64 clamped_start = max(page_start, extent_start);
-		u64 clamped_end = min(page_end, extent_end);
+		u64 clamped_start = max(folio_start, extent_start);
+		u64 clamped_end = min(folio_end, extent_end);
 		u32 clamped_len = clamped_end + 1 - clamped_start;
 
 		/* Reserve metadata for this range */
@@ -3052,7 +3055,7 @@ static int relocate_one_page(struct inode *inode, struct file_ra_state *ra,
 						      clamped_len, clamped_len,
 						      false);
 		if (ret)
-			goto release_page;
+			goto release_folio;
 
 		/* Mark the range delalloc and dirty for later writeback */
 		lock_extent(&BTRFS_I(inode)->io_tree, clamped_start, clamped_end,
@@ -3068,20 +3071,18 @@ static int relocate_one_page(struct inode *inode, struct file_ra_state *ra,
 							clamped_len, true);
 			btrfs_delalloc_release_extents(BTRFS_I(inode),
 						       clamped_len);
-			goto release_page;
+			goto release_folio;
 		}
-		btrfs_folio_set_dirty(fs_info, page_folio(page),
-				      clamped_start, clamped_len);
+		btrfs_folio_set_dirty(fs_info, folio, clamped_start, clamped_len);
 
 		/*
-		 * Set the boundary if it's inside the page.
+		 * Set the boundary if it's inside the folio.
 		 * Data relocation requires the destination extents to have the
 		 * same size as the source.
 		 * EXTENT_BOUNDARY bit prevents current extent from being merged
 		 * with previous extent.
 		 */
-		if (in_range(cluster->boundary[*cluster_nr] - offset,
-			     page_start, PAGE_SIZE)) {
+		if (in_range(cluster->boundary[*cluster_nr] - offset, folio_start, PAGE_SIZE)) {
 			u64 boundary_start = cluster->boundary[*cluster_nr] -
 						offset;
 			u64 boundary_end = boundary_start +
@@ -3104,8 +3105,8 @@ static int relocate_one_page(struct inode *inode, struct file_ra_state *ra,
 				break;
 		}
 	}
-	unlock_page(page);
-	put_page(page);
+	folio_unlock(folio);
+	folio_put(folio);
 
 	balance_dirty_pages_ratelimited(inode->i_mapping);
 	btrfs_throttle(fs_info);
@@ -3113,9 +3114,9 @@ static int relocate_one_page(struct inode *inode, struct file_ra_state *ra,
 		ret = -ECANCELED;
 	return ret;
 
-release_page:
-	unlock_page(page);
-	put_page(page);
+release_folio:
+	folio_unlock(folio);
+	folio_put(folio);
 	return ret;
 }
 
@@ -3150,7 +3151,7 @@ static int relocate_file_extent_cluster(struct inode *inode,
 	last_index = (cluster->end - offset) >> PAGE_SHIFT;
 	for (index = (cluster->start - offset) >> PAGE_SHIFT;
 	     index <= last_index && !ret; index++)
-		ret = relocate_one_page(inode, ra, cluster, &cluster_nr, index);
+		ret = relocate_one_folio(inode, ra, cluster, &cluster_nr, index);
 	if (ret == 0)
 		WARN_ON(cluster_nr != cluster->nr);
 out:
-- 
2.43.0


