Return-Path: <linux-btrfs+bounces-7041-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 830EF94B5CE
	for <lists+linux-btrfs@lfdr.de>; Thu,  8 Aug 2024 06:14:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7ED7E1F22DFA
	for <lists+linux-btrfs@lfdr.de>; Thu,  8 Aug 2024 04:14:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D43A84047;
	Thu,  8 Aug 2024 04:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="KVKfW+D1";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="GnM1Qe6j"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFD4E80C13
	for <linux-btrfs@vger.kernel.org>; Thu,  8 Aug 2024 04:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723090476; cv=none; b=n0iuRmj8Y7u/9SllKg6sOp76GHur/banV91BVC+UIKlRkAsbXhm7E2+K4vgsUn/xegMXjh1fw9U5AFnXYS63HuVMUHD8s69GA9VEXU2DSTGxqkJj7+WXJiJ9RWjvuvp0PHDkS2hecuVdRep5+EFeOOGCTHaFhc1hu2faRpWRqDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723090476; c=relaxed/simple;
	bh=mRJ9lzDWNQ8ZKZEHN1/BhgSSBvPWmCKl7csDw7Nm6RI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YdZZH8+i4q6p3TqrvKs805oMqirntLYdT3YGwcvt4StZstC/gzx7Wqpi84xr3WQRLEbwV8HxSoxmh+zIifvZK/nVlULXjC/YxeLWsmyPuPCatQRK1qhKmjq0sH8tQLXwLyqgOZVPBpJw27YXCb3a3p8Fcw17AWKl0392zeN4v28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=KVKfW+D1; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=GnM1Qe6j; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id EFA0C21D1D;
	Thu,  8 Aug 2024 04:14:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1723090472; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=x2XhKHkvLAuMgBorF+x8NvC4+J5ptm3JJkgSPoDPuwA=;
	b=KVKfW+D1a2jLEmrGNfUTx/0eLKHXx770fCb69ESotv2gM12mmsf3+/tZ2EU8FaSacYHoxe
	zcHjGoE5k5PcDdFX+E9xyQjzku7WPtqAhjLqj7uZKbCU4wJLpG+ulNX34j11SEPBOb70vo
	YKagsN6hqN+WOJL5SwQshORBsOp8wNs=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=GnM1Qe6j
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1723090471; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=x2XhKHkvLAuMgBorF+x8NvC4+J5ptm3JJkgSPoDPuwA=;
	b=GnM1Qe6jM9EveHD3KbHhXo0s1MvSZdgPXbPYAE4lmEIS/aKncfWXZnjT2qmFeHZtq8ebVn
	oz1WWH0bIu8TlKmYF7ADjwqRd8Q2bqfkToXJsRTUNGQP3GUrTN82DCFD/F0Q5NYo/HYWWQ
	OQAXxY9sc0FYIFC/82GLHVARfPlri3U=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C58B513B06;
	Thu,  8 Aug 2024 04:14:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 9ZXTHyZGtGbMSgAAD6G6ig
	(envelope-from <wqu@suse.com>); Thu, 08 Aug 2024 04:14:30 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH v2] btrfs: refactor __extent_writepage_io() to do sector-by-sector submission
Date: Thu,  8 Aug 2024 13:44:08 +0930
Message-ID: <801c173b280b041adb31a8f4cab498cedd88ef79.1723090436.git.wqu@suse.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-0.01 / 50.00];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RCPT_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DWL_DNSWL_BLOCKED(0.00)[suse.com:dkim];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:dkim]
X-Spamd-Bar: /
X-Rspamd-Queue-Id: EFA0C21D1D
X-Spam-Level: 
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -0.01

Unlike the bitmap usage inside raid56, for __extent_writepage_io() we
handle the subpage submission not sector-by-sector, but for each dirty
range we found.

This is not a big deal normally, as the subpage complex code is already
mostly optimized out by the compiler for x86_64.

However for the sake of consistency and for the future of subpage
sector-perfect compression support, this patch does:

- Extract the sector submission code into submit_one_sector()

- Add the needed code to extract the dirty bitmap for subpage case
  There is a small pitfall for non-subpage case, as we cleared page
  dirty before starting writeback, so we have to manually set
  the default dirty_bitmap to 1 for such case.

- Use bitmap_and() to calculate the target sectors we need to submit
  This is done for both subpage and non-subpage cases, and will later
  be expanded to skip inline/compression ranges.

For x86_64, the dirty bitmap will be fixed to 1, with the length of 1,
so we're still doing the same workload per sector.

For larger page sizes, the overhead will be a little larger, as previous
we only need to do one extent_map lookup per-dirty-range, but now it
will be one extent_map lookup per-sector.

But that is the same frequency as x86_64, so we're just aligning the
behavior to x86_64.

Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
Changelog:
v2:
- Fix a bug for RST case
  The range_bitmap is incorrectly calculated if @start of
  __extent_writepage_io() is not page aligned.
  Thankfully this only happens for RST writes.

- Constify the @sectorsize and use local @sectorsize

- Change a local error detection into ASSERT()

- Add a comment on the default dirty_bitmap value for non-subpage case
  This is mostly caused by the early page dirty clearing, thus we can
  not use PageDirty() to build our bitmap for non-subpage case.

- Update the commit message for the bitmap_and() usage
---
 fs/btrfs/extent_io.c | 203 +++++++++++++++++++------------------------
 fs/btrfs/subpage.c   |  17 ++++
 fs/btrfs/subpage.h   |   3 +
 3 files changed, 109 insertions(+), 114 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 040c92541bc9..822e2bf8bc99 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -1333,56 +1333,68 @@ static noinline_for_stack int writepage_delalloc(struct btrfs_inode *inode,
 }
 
 /*
- * Find the first byte we need to write.
+ * Return 0 if we have submitted or queued the sector for submission.
+ * Return <0 for critical errors.
  *
- * For subpage, one page can contain several sectors, and
- * __extent_writepage_io() will just grab all extent maps in the page
- * range and try to submit all non-inline/non-compressed extents.
- *
- * This is a big problem for subpage, we shouldn't re-submit already written
- * data at all.
- * This function will lookup subpage dirty bit to find which range we really
- * need to submit.
- *
- * Return the next dirty range in [@start, @end).
- * If no dirty range is found, @start will be page_offset(page) + PAGE_SIZE.
+ * Caller should make sure filepos < i_size and handle filepos >= i_size case.
  */
-static void find_next_dirty_byte(const struct btrfs_fs_info *fs_info,
-				 struct folio *folio, u64 *start, u64 *end)
+static int submit_one_sector(struct btrfs_inode *inode,
+			     struct folio *folio,
+			     u64 filepos, struct btrfs_bio_ctrl *bio_ctrl,
+			     loff_t i_size)
 {
-	struct btrfs_subpage *subpage = folio_get_private(folio);
-	struct btrfs_subpage_info *spi = fs_info->subpage_info;
-	u64 orig_start = *start;
-	/* Declare as unsigned long so we can use bitmap ops */
-	unsigned long flags;
-	int range_start_bit;
-	int range_end_bit;
+	struct btrfs_fs_info *fs_info = inode->root->fs_info;
+	struct extent_map *em;
+	u64 block_start;
+	u64 disk_bytenr;
+	u64 extent_offset;
+	u64 em_end;
+	const u32 sectorsize = fs_info->sectorsize;
+
+	ASSERT(IS_ALIGNED(filepos, sectorsize));
+
+	/* @filepos >= i_size case should be handled by the caller. */
+	ASSERT(filepos < i_size);
+
+	em = btrfs_get_extent(inode, NULL, filepos, sectorsize);
+	if (IS_ERR(em))
+		return PTR_ERR_OR_ZERO(em);
+
+	extent_offset = filepos - em->start;
+	em_end = extent_map_end(em);
+	ASSERT(filepos <= em_end);
+	ASSERT(IS_ALIGNED(em->start, sectorsize));
+	ASSERT(IS_ALIGNED(em->len, sectorsize));
+
+	block_start = extent_map_block_start(em);
+	disk_bytenr = extent_map_block_start(em) + extent_offset;
+
+	ASSERT(!extent_map_is_compressed(em));
+	ASSERT(block_start != EXTENT_MAP_HOLE);
+	ASSERT(block_start != EXTENT_MAP_INLINE);
+
+	free_extent_map(em);
+	em = NULL;
+
+	btrfs_set_range_writeback(inode, filepos, filepos + sectorsize - 1);
+	/*
+	 * Above call should set the whole folio with writeback flag, even
+	 * just for a single subpage sector.
+	 * As long as the folio is properly locked and the range is correct,
+	 * we should always get the folio with writeback flag.
+	 */
+	ASSERT(folio_test_writeback(folio));
 
 	/*
-	 * For regular sector size == page size case, since one page only
-	 * contains one sector, we return the page offset directly.
+	 * Although the PageDirty bit is cleared before entering this
+	 * function, subpage dirty bit is not cleared.
+	 * So clear subpage dirty bit here so next time we won't submit
+	 * folio for range already written to disk.
 	 */
-	if (!btrfs_is_subpage(fs_info, folio->mapping)) {
-		*start = folio_pos(folio);
-		*end = folio_pos(folio) + folio_size(folio);
-		return;
-	}
-
-	range_start_bit = spi->dirty_offset +
-			  (offset_in_folio(folio, orig_start) >>
-			   fs_info->sectorsize_bits);
-
-	/* We should have the page locked, but just in case */
-	spin_lock_irqsave(&subpage->lock, flags);
-	bitmap_next_set_region(subpage->bitmaps, &range_start_bit, &range_end_bit,
-			       spi->dirty_offset + spi->bitmap_nr_bits);
-	spin_unlock_irqrestore(&subpage->lock, flags);
-
-	range_start_bit -= spi->dirty_offset;
-	range_end_bit -= spi->dirty_offset;
-
-	*start = folio_pos(folio) + range_start_bit * fs_info->sectorsize;
-	*end = folio_pos(folio) + range_end_bit * fs_info->sectorsize;
+	btrfs_folio_clear_dirty(fs_info, folio, filepos, sectorsize);
+	submit_extent_folio(bio_ctrl, disk_bytenr, folio,
+			    sectorsize, filepos - folio_pos(folio));
+	return 0;
 }
 
 /*
@@ -1400,16 +1412,24 @@ static noinline_for_stack int __extent_writepage_io(struct btrfs_inode *inode,
 						    loff_t i_size, int *nr_ret)
 {
 	struct btrfs_fs_info *fs_info = inode->root->fs_info;
-	u64 cur = start;
-	u64 end = start + len - 1;
-	u64 extent_offset;
-	u64 block_start;
-	struct extent_map *em;
+	unsigned long range_bitmap = 0;
+	/*
+	 * This is the default value for sectorsize == PAGE_SIZE case.
+	 * We known we need to write the dirty sector (aka the page),
+	 * even if the page is not dirty (we cleared it before entering).
+	 *
+	 * For subpage cases we will get the correct bitmap later.
+	 */
+	unsigned long dirty_bitmap = 1;
+	unsigned int bitmap_size = 1;
+	const u64 folio_start = folio_pos(folio);
+	u64 cur;
+	int bit;
 	int ret = 0;
 	int nr = 0;
 
-	ASSERT(start >= folio_pos(folio) &&
-	       start + len <= folio_pos(folio) + folio_size(folio));
+	ASSERT(start >= folio_start &&
+	       start + len <= folio_start + folio_size(folio));
 
 	ret = btrfs_writepage_cow_fixup(folio);
 	if (ret) {
@@ -1419,18 +1439,23 @@ static noinline_for_stack int __extent_writepage_io(struct btrfs_inode *inode,
 		return 1;
 	}
 
+	if (btrfs_is_subpage(fs_info, inode->vfs_inode.i_mapping)) {
+		ASSERT(fs_info->subpage_info);
+		btrfs_get_subpage_dirty_bitmap(fs_info, folio, &dirty_bitmap);
+		bitmap_size = fs_info->subpage_info->bitmap_nr_bits;
+	}
+	for (cur = start; cur < start + len; cur += fs_info->sectorsize)
+		set_bit((cur - folio_start) >> fs_info->sectorsize_bits, &range_bitmap);
+	bitmap_and(&dirty_bitmap, &dirty_bitmap, &range_bitmap, bitmap_size);
+
 	bio_ctrl->end_io_func = end_bbio_data_write;
-	while (cur <= end) {
-		u32 len = end - cur + 1;
-		u64 disk_bytenr;
-		u64 em_end;
-		u64 dirty_range_start = cur;
-		u64 dirty_range_end;
-		u32 iosize;
+
+	for_each_set_bit(bit, &dirty_bitmap, bitmap_size) {
+		cur = folio_pos(folio) + (bit << fs_info->sectorsize_bits);
 
 		if (cur >= i_size) {
-			btrfs_mark_ordered_io_finished(inode, folio, cur, len,
-						       true);
+			btrfs_mark_ordered_io_finished(inode, folio, cur,
+						       start + len - cur, true);
 			/*
 			 * This range is beyond i_size, thus we don't need to
 			 * bother writing back.
@@ -1439,63 +1464,13 @@ static noinline_for_stack int __extent_writepage_io(struct btrfs_inode *inode,
 			 * writeback the sectors with subpage dirty bits,
 			 * causing writeback without ordered extent.
 			 */
-			btrfs_folio_clear_dirty(fs_info, folio, cur, len);
+			btrfs_folio_clear_dirty(fs_info, folio, cur,
+						start + len - cur);
 			break;
 		}
-
-		find_next_dirty_byte(fs_info, folio, &dirty_range_start,
-				     &dirty_range_end);
-		if (cur < dirty_range_start) {
-			cur = dirty_range_start;
-			continue;
-		}
-
-		em = btrfs_get_extent(inode, NULL, cur, len);
-		if (IS_ERR(em)) {
-			ret = PTR_ERR_OR_ZERO(em);
+		ret = submit_one_sector(inode, folio, cur, bio_ctrl, i_size);
+		if (ret < 0)
 			goto out_error;
-		}
-
-		extent_offset = cur - em->start;
-		em_end = extent_map_end(em);
-		ASSERT(cur <= em_end);
-		ASSERT(cur < end);
-		ASSERT(IS_ALIGNED(em->start, fs_info->sectorsize));
-		ASSERT(IS_ALIGNED(em->len, fs_info->sectorsize));
-
-		block_start = extent_map_block_start(em);
-		disk_bytenr = extent_map_block_start(em) + extent_offset;
-
-		ASSERT(!extent_map_is_compressed(em));
-		ASSERT(block_start != EXTENT_MAP_HOLE);
-		ASSERT(block_start != EXTENT_MAP_INLINE);
-
-		/*
-		 * Note that em_end from extent_map_end() and dirty_range_end from
-		 * find_next_dirty_byte() are all exclusive
-		 */
-		iosize = min(min(em_end, end + 1), dirty_range_end) - cur;
-		free_extent_map(em);
-		em = NULL;
-
-		btrfs_set_range_writeback(inode, cur, cur + iosize - 1);
-		if (!folio_test_writeback(folio)) {
-			btrfs_err(inode->root->fs_info,
-				   "folio %lu not writeback, cur %llu end %llu",
-			       folio->index, cur, end);
-		}
-
-		/*
-		 * Although the PageDirty bit is cleared before entering this
-		 * function, subpage dirty bit is not cleared.
-		 * So clear subpage dirty bit here so next time we won't submit
-		 * folio for range already written to disk.
-		 */
-		btrfs_folio_clear_dirty(fs_info, folio, cur, iosize);
-
-		submit_extent_folio(bio_ctrl, disk_bytenr, folio,
-				    iosize, cur - folio_pos(folio));
-		cur += iosize;
 		nr++;
 	}
 
diff --git a/fs/btrfs/subpage.c b/fs/btrfs/subpage.c
index 631d96f1e905..eea3b2c6bbc4 100644
--- a/fs/btrfs/subpage.c
+++ b/fs/btrfs/subpage.c
@@ -940,3 +940,20 @@ void __cold btrfs_subpage_dump_bitmap(const struct btrfs_fs_info *fs_info,
 		    subpage_info->bitmap_nr_bits, &ordered_bitmap,
 		    subpage_info->bitmap_nr_bits, &checked_bitmap);
 }
+
+void btrfs_get_subpage_dirty_bitmap(struct btrfs_fs_info *fs_info,
+				    struct folio *folio,
+				    unsigned long *ret_bitmap)
+{
+	struct btrfs_subpage_info *subpage_info = fs_info->subpage_info;
+	struct btrfs_subpage *subpage;
+	unsigned long flags;
+
+	ASSERT(folio_test_private(folio) && folio_get_private(folio));
+	ASSERT(subpage_info);
+	subpage = folio_get_private(folio);
+
+	spin_lock_irqsave(&subpage->lock, flags);
+	GET_SUBPAGE_BITMAP(subpage, subpage_info, dirty, ret_bitmap);
+	spin_unlock_irqrestore(&subpage->lock, flags);
+}
diff --git a/fs/btrfs/subpage.h b/fs/btrfs/subpage.h
index 5532cc4fac50..eee55e5a3952 100644
--- a/fs/btrfs/subpage.h
+++ b/fs/btrfs/subpage.h
@@ -175,6 +175,9 @@ void btrfs_folio_assert_not_dirty(const struct btrfs_fs_info *fs_info,
 				  struct folio *folio, u64 start, u32 len);
 void btrfs_folio_unlock_writer(struct btrfs_fs_info *fs_info,
 			       struct folio *folio, u64 start, u32 len);
+void btrfs_get_subpage_dirty_bitmap(struct btrfs_fs_info *fs_info,
+				    struct folio *folio,
+				    unsigned long *ret_bitmap);
 void __cold btrfs_subpage_dump_bitmap(const struct btrfs_fs_info *fs_info,
 				      struct folio *folio, u64 start, u32 len);
 
-- 
2.45.2


