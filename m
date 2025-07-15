Return-Path: <linux-btrfs+bounces-15501-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE67EB0502F
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Jul 2025 06:17:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E57C93B25CF
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Jul 2025 04:17:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44D97258CF1;
	Tue, 15 Jul 2025 04:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="n+TsnSQZ";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="n+TsnSQZ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C97C62566
	for <linux-btrfs@vger.kernel.org>; Tue, 15 Jul 2025 04:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752553072; cv=none; b=QpnIjJJ4kS9yRh8w463xPngsfTq4tox/OmSiGg9UqWbNgzcpx9CqFTwb+nWA34e0c/3gLaufCBxtG8ZKJtj17XWLCie2LxwhV9UF8dHeBg/wKZiBS5NKH1hVOqe6QxXHOWeVmbSzX/qVsSTErgyS03wdlrbsALULfOhVxbfy0gU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752553072; c=relaxed/simple;
	bh=DDmjuXiovzl6i2lE+RJ1JaCzos2czKrXggEyYv59KOI=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=PRwwLVE+hXdZYovLsYICQ0IYy3VCRg2PxAQJ4HaFmwDgM2uxuWAJd63SzjR9bFxhvh6s9eW15ztERWDSf1+VmGjJfLMaIebm6Df8hr14Yrs6uk9UVoIhQt9XiM65pDwRgNnNT6DH4sDmFQ+khx4XlTzejzNP12eEECN8O+llzaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=n+TsnSQZ; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=n+TsnSQZ; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D15302123C
	for <linux-btrfs@vger.kernel.org>; Tue, 15 Jul 2025 04:17:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1752553067; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=gjVEPH0sni9BzUUjgc7J8sO/iaJX6arnHG3DK8n/SpU=;
	b=n+TsnSQZ5e5x2Ugq7w2SYb354BReaPNcjNo9IIGDnZpT3XGEvJA5QZpvduiCXrhMOkUJ0W
	GhsuYjeoKb6WRlqwrk2iPmpRcxw8DoyC5wkItMkGw1lx8JnLHzoDrPgs1HWtr6aMOG2rJq
	IeCuDVgTBh3masRRr1USxaLiN0z1wTk=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1752553067; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=gjVEPH0sni9BzUUjgc7J8sO/iaJX6arnHG3DK8n/SpU=;
	b=n+TsnSQZ5e5x2Ugq7w2SYb354BReaPNcjNo9IIGDnZpT3XGEvJA5QZpvduiCXrhMOkUJ0W
	GhsuYjeoKb6WRlqwrk2iPmpRcxw8DoyC5wkItMkGw1lx8JnLHzoDrPgs1HWtr6aMOG2rJq
	IeCuDVgTBh3masRRr1USxaLiN0z1wTk=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0085813306
	for <linux-btrfs@vger.kernel.org>; Tue, 15 Jul 2025 04:17:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 16IMK2rWdWhaCgAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Tue, 15 Jul 2025 04:17:46 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: reloc: unconditionally invalidate the page cache for each cluster
Date: Tue, 15 Jul 2025 13:47:43 +0930
Message-ID: <82c8337542eee11ad3c8b05b5278f88599ce4496.1752553049.git.wqu@suse.com>
X-Mailer: git-send-email 2.50.0
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
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email,suse.com:mid];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Score: -2.80

Commit 9d9ea1e68a05 ("btrfs: subpage: fix relocation potentially
overwriting last page data") fixed a bug when relocating data block
groups for subpage cases.

However for the incoming large folios for data reloc inode, we can hit
the same situation where block size is the same as page size, but the
folio we got is still larger than a block.

In that case, the old subpage specific check is no longer reliable.

Here we have to enhance the handling by:

- Unconditionally invalidate the page cache for the current cluster
  We set the @flush to true so that any dirty folios are properly
  written back first.

  And this time instead of dropping the whole page cache, just drop the
  range covered by the current cluster.

  This will bring some minor performance drop, as for a large folio, the
  heading half will be read twice (read by previous cluster, then
  invalidated, then read again by the current cluster).

  However that is required to support large folios, and this gets rid of
  the kinda tricky manual uptodate flag clearing for each block.

- Remove the special handling of writing back the whole page cache
  filemap_invalidate_inode() handles the write back already, and since
  we're invalidating all pages in the range, we no longer need to
  manually clear the uptodate flags for involved blocks.

  Thus there is no need to manually write back the whole page cache.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/relocation.c | 58 ++++++-------------------------------------
 1 file changed, 8 insertions(+), 50 deletions(-)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 8a71cffb4dfb..fa93ba40278d 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -2666,66 +2666,24 @@ static noinline_for_stack int prealloc_file_extent_cluster(struct reloc_control
 	u64 num_bytes;
 	int nr;
 	int ret = 0;
-	u64 i_size = i_size_read(&inode->vfs_inode);
 	u64 prealloc_start = cluster->start - offset;
 	u64 prealloc_end = cluster->end - offset;
 	u64 cur_offset = prealloc_start;
 
 	/*
-	 * For subpage case, previous i_size may not be aligned to PAGE_SIZE.
-	 * This means the range [i_size, PAGE_END + 1) is filled with zeros by
-	 * btrfs_do_readpage() call of previously relocated file cluster.
+	 * For blocksize < folio size case (either bs < page size or large folios),
+	 * beyond i_size, all blocks are filled with zero.
 	 *
-	 * If the current cluster starts in the above range, btrfs_do_readpage()
+	 * If the current cluster covers above range, btrfs_do_readpage()
 	 * will skip the read, and relocate_one_folio() will later writeback
 	 * the padding zeros as new data, causing data corruption.
 	 *
-	 * Here we have to manually invalidate the range (i_size, PAGE_END + 1).
+	 * Here we have to invalidate the cache covering our cluster.
 	 */
-	if (!PAGE_ALIGNED(i_size)) {
-		struct address_space *mapping = inode->vfs_inode.i_mapping;
-		struct btrfs_fs_info *fs_info = inode->root->fs_info;
-		const u32 sectorsize = fs_info->sectorsize;
-		struct folio *folio;
-
-		ASSERT(sectorsize < PAGE_SIZE);
-		ASSERT(IS_ALIGNED(i_size, sectorsize));
-
-		/*
-		 * Subpage can't handle page with DIRTY but without UPTODATE
-		 * bit as it can lead to the following deadlock:
-		 *
-		 * btrfs_read_folio()
-		 * | Page already *locked*
-		 * |- btrfs_lock_and_flush_ordered_range()
-		 *    |- btrfs_start_ordered_extent()
-		 *       |- extent_write_cache_pages()
-		 *          |- lock_page()
-		 *             We try to lock the page we already hold.
-		 *
-		 * Here we just writeback the whole data reloc inode, so that
-		 * we will be ensured to have no dirty range in the page, and
-		 * are safe to clear the uptodate bits.
-		 *
-		 * This shouldn't cause too much overhead, as we need to write
-		 * the data back anyway.
-		 */
-		ret = filemap_write_and_wait(mapping);
-		if (ret < 0)
-			return ret;
-
-		folio = filemap_lock_folio(mapping, i_size >> PAGE_SHIFT);
-		/*
-		 * If page is freed we don't need to do anything then, as we
-		 * will re-read the whole page anyway.
-		 */
-		if (!IS_ERR(folio)) {
-			btrfs_subpage_clear_uptodate(fs_info, folio, i_size,
-					round_up(i_size, PAGE_SIZE) - i_size);
-			folio_unlock(folio);
-			folio_put(folio);
-		}
-	}
+	ret = filemap_invalidate_inode(&inode->vfs_inode, true, prealloc_start,
+				       prealloc_end);
+	if (ret < 0)
+		return ret;
 
 	BUG_ON(cluster->start != cluster->boundary[0]);
 	ret = btrfs_alloc_data_chunk_ondemand(inode,
-- 
2.50.0


