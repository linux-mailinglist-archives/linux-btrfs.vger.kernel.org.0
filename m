Return-Path: <linux-btrfs+bounces-1557-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90338831FDA
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Jan 2024 20:46:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3A7E4B22F06
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Jan 2024 19:46:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDDF62E633;
	Thu, 18 Jan 2024 19:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="CV42lht2";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="R6h6ZvUv";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="CV42lht2";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="R6h6ZvUv"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8683B1F60B
	for <linux-btrfs@vger.kernel.org>; Thu, 18 Jan 2024 19:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705607162; cv=none; b=LCIU0frgBYOdr7nECioThSIjHr8nCbxalYF4zlc2KR2fLWr9tTeTh6Y1DRRRPw8Sbd74++ouhYP4k7B3vLNYRc98SBMzo59N9taYQUn7KHhZMwMYpo3TBgpgGYRwXHFKmHTh+A6QYYTV0boOLn7NnfHtsIbulrO+v5ZGEGxDafU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705607162; c=relaxed/simple;
	bh=Y7W+V9Nj6SkQqmIf24Nu/6ougagE2xvegXb0+Y/4uyM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CCUCLSUSnlE1f2grVqGQSuzbpD4epxBAhZHOax6Mr15m8uu9GzgPRYmlHLhfv+qOtJBohYDaMZEpqDZtQzap52A1aTUKBDXLKFyv5mB2aa8t8l21xYLCZqyIYcUuovCUYxOMbY+lZB+gaXH+3q5je/DIdH5FFESBeIvl/v/Cy5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=CV42lht2; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=R6h6ZvUv; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=CV42lht2; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=R6h6ZvUv; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A89D521F11;
	Thu, 18 Jan 2024 19:45:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1705607158; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HtudMYi1LPxzoCq/0dlekeCdYlVJYaXuyMraM8ChY94=;
	b=CV42lht2tgVGqML7oymYToZ8Tk6e6mVTAWKx81ZqdwKjw3wwq9h89MZ3aVAXZWN20kkLkW
	a6M+f0Q+ljQ1D2/flWNSD3+x+Vl2nR/mRLTYuS6MaUPoS4Kv/z/+G4sdb1QY5hbX/O9DN0
	BQUxLOFPNpypSo+andzSVPY2aRPVo5A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1705607158;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HtudMYi1LPxzoCq/0dlekeCdYlVJYaXuyMraM8ChY94=;
	b=R6h6ZvUvImZGZ6rkYjAMURY7K0fYSk4zhoEOs0Kp/LeGhBUHu6di12eo4xZixnxO8x8gqI
	yugrcZZoAcsX5BCg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1705607158; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HtudMYi1LPxzoCq/0dlekeCdYlVJYaXuyMraM8ChY94=;
	b=CV42lht2tgVGqML7oymYToZ8Tk6e6mVTAWKx81ZqdwKjw3wwq9h89MZ3aVAXZWN20kkLkW
	a6M+f0Q+ljQ1D2/flWNSD3+x+Vl2nR/mRLTYuS6MaUPoS4Kv/z/+G4sdb1QY5hbX/O9DN0
	BQUxLOFPNpypSo+andzSVPY2aRPVo5A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1705607158;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HtudMYi1LPxzoCq/0dlekeCdYlVJYaXuyMraM8ChY94=;
	b=R6h6ZvUvImZGZ6rkYjAMURY7K0fYSk4zhoEOs0Kp/LeGhBUHu6di12eo4xZixnxO8x8gqI
	yugrcZZoAcsX5BCg==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 4D7971377F;
	Thu, 18 Jan 2024 19:45:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id lgzSA/Z/qWXEBQAAn2gu4w
	(envelope-from <rgoldwyn@suse.de>); Thu, 18 Jan 2024 19:45:58 +0000
From: Goldwyn Rodrigues <rgoldwyn@suse.de>
To: linux-btrfs@vger.kernel.org
Cc: Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: [PATCH 3/4] btrfs: convert relocate_one_page() to relocate_one_folio()
Date: Thu, 18 Jan 2024 13:46:39 -0600
Message-ID: <b723970ca03542e6863442ded58651cfcdb8fe24.1705605787.git.rgoldwyn@suse.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1705605787.git.rgoldwyn@suse.com>
References: <cover.1705605787.git.rgoldwyn@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Bar: /
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=CV42lht2;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=R6h6ZvUv
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-0.51 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 ARC_NA(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.de:+];
	 RCPT_COUNT_TWO(0.00)[2];
	 MX_GOOD(-0.01)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Score: -0.51
X-Rspamd-Queue-Id: A89D521F11
X-Spam-Flag: NO

From: Goldwyn Rodrigues <rgoldwyn@suse.com>

Convert page references to folios and call the respective folio
functions.

Since find_or_create_page() takes a mask argument, call
__filemap_get_folio() instead of filemap_grab_folio().

Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
---
 fs/btrfs/relocation.c | 87 ++++++++++++++++++++++---------------------
 1 file changed, 44 insertions(+), 43 deletions(-)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index c365bfc60652..f4fd4257adae 100644
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
@@ -2983,68 +2983,69 @@ static u64 get_cluster_boundary_end(const struct file_extent_cluster *cluster,
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
+	u64 start;
+	u64 end;
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
+				FGP_LOCK | FGP_ACCESSED | FGP_CREAT, mask);
+		if (IS_ERR(folio))
+			return PTR_ERR(folio);
 	}
 
-	if (PageReadahead(page))
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
+			goto release;
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
+		goto release;
 
-	page_start = page_offset(page);
-	page_end = page_start + PAGE_SIZE - 1;
+	start = folio_pos(folio);
+	end = start + PAGE_SIZE - 1;
 
 	/*
 	 * Start from the cluster, as for subpage case, the cluster can start
-	 * inside the page.
+	 * inside the folio.
 	 */
-	cur = max(page_start, cluster->boundary[*cluster_nr] - offset);
-	while (cur <= page_end) {
+	cur = max(start, cluster->boundary[*cluster_nr] - offset);
+	while (cur <= end) {
 		struct extent_state *cached_state = NULL;
 		u64 extent_start = cluster->boundary[*cluster_nr] - offset;
 		u64 extent_end = get_cluster_boundary_end(cluster,
 						*cluster_nr) - offset;
-		u64 clamped_start = max(page_start, extent_start);
-		u64 clamped_end = min(page_end, extent_end);
+		u64 clamped_start = max(start, extent_start);
+		u64 clamped_end = min(end, extent_end);
 		u32 clamped_len = clamped_end + 1 - clamped_start;
 
 		/* Reserve metadata for this range */
@@ -3052,7 +3053,7 @@ static int relocate_one_page(struct inode *inode, struct file_ra_state *ra,
 						      clamped_len, clamped_len,
 						      false);
 		if (ret)
-			goto release_page;
+			goto release;
 
 		/* Mark the range delalloc and dirty for later writeback */
 		lock_extent(&BTRFS_I(inode)->io_tree, clamped_start, clamped_end,
@@ -3068,20 +3069,20 @@ static int relocate_one_page(struct inode *inode, struct file_ra_state *ra,
 							clamped_len, true);
 			btrfs_delalloc_release_extents(BTRFS_I(inode),
 						       clamped_len);
-			goto release_page;
+			goto release;
 		}
-		btrfs_folio_set_dirty(fs_info, page_folio(page),
+		btrfs_folio_set_dirty(fs_info, folio,
 				      clamped_start, clamped_len);
 
 		/*
-		 * Set the boundary if it's inside the page.
+		 * Set the boundary if it's inside the folio.
 		 * Data relocation requires the destination extents to have the
 		 * same size as the source.
 		 * EXTENT_BOUNDARY bit prevents current extent from being merged
 		 * with previous extent.
 		 */
 		if (in_range(cluster->boundary[*cluster_nr] - offset,
-			     page_start, PAGE_SIZE)) {
+			     start, PAGE_SIZE)) {
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
+release:
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


