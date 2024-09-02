Return-Path: <linux-btrfs+bounces-7716-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3508B967EA3
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Sep 2024 06:59:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F1921C216F9
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Sep 2024 04:59:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E85F514A636;
	Mon,  2 Sep 2024 04:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="vV9tRb+K";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="vV9tRb+K"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B93C728F5
	for <linux-btrfs@vger.kernel.org>; Mon,  2 Sep 2024 04:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725253169; cv=none; b=FsV9dgDflVL6IdIIjjZtVl/xjXQDWc2DXpDyQaG0aCBbazw/N6P0gIRZjmVn6pEo7ZosAUf1IChQ18jJGuSsIu0MG7U9vsgpiNFxCP7tZEUJnTS4XNyR3FsLIKcls29zWEwkVBLkqReZbjlgBtgqgkCsje9xdYX2qftYgf7dkDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725253169; c=relaxed/simple;
	bh=A/VoGTo8bY3ZXS+INSsd/3/DatLMxKWf5LsQFjXdDbY=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=RnTdnI1cRRXF2Dj05gO3HdycWmCVq3bBL1FzuUfUTjt8dylFMomcBklO6qpCYgqkoUfvrCaEBaCAaoKUsiK/KEm4ObKBSXlTqTGWzGzx9GQHk+ries4fRYuRBisJ2ZDmiQTdXyyW+wYD7IEMXOgN9OsIW7LlMJ3PO9iEMTnY8TE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=vV9tRb+K; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=vV9tRb+K; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C031E219D7
	for <linux-btrfs@vger.kernel.org>; Mon,  2 Sep 2024 04:59:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1725253164; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=aIj97RrguisPToS7qqu0dXOR1vPq6TTygyZZoZ2+WPs=;
	b=vV9tRb+Kcabt9NUAimaXmAWJnVqNRPxIQtaFGulDC3np3mCMcPrnm48/L1FHTWOWUQt5Tx
	jPj5tE/+O7+gvkp2KWrgyoWMD6wHqnB0YZfqtnD00K59bVC/wMS4edveiQ3EZTCu1ZQQi3
	QgWEtm5Uj9wycMYWFWwQu6wS7d8ocCM=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=vV9tRb+K
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1725253164; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=aIj97RrguisPToS7qqu0dXOR1vPq6TTygyZZoZ2+WPs=;
	b=vV9tRb+Kcabt9NUAimaXmAWJnVqNRPxIQtaFGulDC3np3mCMcPrnm48/L1FHTWOWUQt5Tx
	jPj5tE/+O7+gvkp2KWrgyoWMD6wHqnB0YZfqtnD00K59bVC/wMS4edveiQ3EZTCu1ZQQi3
	QgWEtm5Uj9wycMYWFWwQu6wS7d8ocCM=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 020F813A7C
	for <linux-btrfs@vger.kernel.org>; Mon,  2 Sep 2024 04:59:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id eVn3LCtG1Wa+AwAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Mon, 02 Sep 2024 04:59:23 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: only unlock the to-be-submitted ranges inside a folio
Date: Mon,  2 Sep 2024 14:29:06 +0930
Message-ID: <73395cf297579616ecc84611eb06a2cc190e8ee8.1725253141.git.wqu@suse.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: C031E219D7
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
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:dkim,suse.com:mid,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[suse.com:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01
X-Spam-Flag: NO

[SUBPAGE COMPRESSION LIMITS]
Currently inside writepage_delalloc(), if a delalloc range is going to
be submitted asynchronously (inline or compression, the page
dirty/writeback/unlock are all handled in a different timing, not at the
submission time), then we return 1 and extent_writepage() will skip the
submission.

This is fine if every sector matches page size, but if a sector is
smaller than page size (aka, subpage case), then it can be very
problematic, for example for the following 64K page:

     0     16K     32K    48K     64K
     |/|   |///////|      |/|
       |                    |
       4K                   52K

Where |/| is the dirty range we need to submit.

In above case, we need the following different handling for the 3
ranges:

- [0, 4K) needs to be submitted for regular write
  A single sector can not be compressed.

- [16K, 32K) needs to be submitted for compressed write

- [48K, 52K) needs to be submitted for regular write.

In above case, if we try to submit [16K, 32K) for compressed write, we
will return 1 and immediately, and without submitting the remaining
[48K, 52K) range.

Furthermore, since extent_writepage() will exit without unlocking any
sectors, the submitted range [0, 4K) will not have sector unlocked.

That's the reason why for now subpage is only allowed for full page
range.

[ENHANCEMENT]
- Introduce a submission bitmap at btrfs_bio_ctrl::submit_bitmap
  This records which sectors will be submitted by extent_writepage_io().
  This allows us to track which sectors needs to be submitted thus later
  to be properly unlocked.

  For asynchronously submitted range (inline/compression), the
  corresponding bits will be cleared from that bitmap.

- Only return 1 if no sector needs to be submitted in
  writepage_delalloc()

- Only submit sectors marked by submission bitmap inside
  extent_writepage_io()
  So we won't touch the asynchronously submitted part.

- Introduce btrfs_folio_end_writer_lock_bitmap() helper
  This will only unlock the involved sectors specified by @bitmap
  parameter, to avoid touching the range asynchronously submitted.

Please note that, since subpage compression is still limited to page
aligned range, this change is only a preparation for future sector
perfect compression support for subpage.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/extent_io.c | 90 +++++++++++++++++++++++++-------------------
 fs/btrfs/subpage.c   | 33 ++++++++++++++++
 fs/btrfs/subpage.h   |  2 +
 3 files changed, 87 insertions(+), 38 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 70be1150c34e..385e88b7fcf5 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -101,6 +101,13 @@ struct btrfs_bio_ctrl {
 	blk_opf_t opf;
 	btrfs_bio_end_io_t end_io_func;
 	struct writeback_control *wbc;
+
+	/*
+	 * The sectors of the page which are going to be submitted by
+	 * extent_writepage_io().
+	 * This is to avoid touching ranges covered by compression/inline.
+	 */
+	unsigned long submit_bitmap;
 };
 
 static void submit_one_bio(struct btrfs_bio_ctrl *bio_ctrl)
@@ -1106,9 +1113,10 @@ int btrfs_read_folio(struct file *file, struct folio *folio)
  */
 static noinline_for_stack int writepage_delalloc(struct btrfs_inode *inode,
 						 struct folio *folio,
-						 struct writeback_control *wbc)
+						 struct btrfs_bio_ctrl *bio_ctrl)
 {
 	struct btrfs_fs_info *fs_info = inode_to_fs_info(&inode->vfs_inode);
+	struct writeback_control *wbc = bio_ctrl->wbc;
 	const bool is_subpage = btrfs_is_subpage(fs_info, folio->mapping);
 	const u64 page_start = folio_pos(folio);
 	const u64 page_end = page_start + folio_size(folio) - 1;
@@ -1123,6 +1131,14 @@ static noinline_for_stack int writepage_delalloc(struct btrfs_inode *inode,
 	u64 delalloc_to_write = 0;
 	int ret = 0;
 
+	/* Save the dirty bitmap as our submission bitmap will be a subset of it. */
+	if (btrfs_is_subpage(fs_info, inode->vfs_inode.i_mapping)) {
+		ASSERT(fs_info->sectors_per_page > 1);
+		btrfs_get_subpage_dirty_bitmap(fs_info, folio, &bio_ctrl->submit_bitmap);
+	} else {
+		bio_ctrl->submit_bitmap = 1;
+	}
+
 	/* Lock all (subpage) delalloc ranges inside the folio first. */
 	while (delalloc_start < page_end) {
 		delalloc_end = page_end;
@@ -1190,22 +1206,19 @@ static noinline_for_stack int writepage_delalloc(struct btrfs_inode *inode,
 		}
 
 		/*
-		 * We can hit btrfs_run_delalloc_range() with >0 return value.
-		 *
-		 * This happens when either the IO is already done and folio
-		 * unlocked (inline) or the IO submission and folio unlock would
-		 * be handled as async (compression).
-		 *
-		 * Inline is only possible for regular sectorsize for now.
-		 *
-		 * Compression is possible for both subpage and regular cases,
-		 * but even for subpage compression only happens for page aligned
-		 * range, thus the found delalloc range must go beyond current
-		 * folio.
+		 * We have some ranges that's going to be submitted async
+		 * (compression or inline).
+		 * Those range has their own control on when to unlock the pages.
+		 * We should not touch them anymore, so clear the range from the
+		 * submission bitmap.
 		 */
-		if (ret > 0)
-			ASSERT(!is_subpage || found_start + found_len >= page_end);
-
+		if (ret > 0) {
+			unsigned int start_bit = (found_start - page_start) >>
+						 fs_info->sectorsize_bits;
+			unsigned int end_bit = (min(page_end + 1, found_start + found_len) -
+						page_start) >> fs_info->sectorsize_bits;
+			bitmap_clear(&bio_ctrl->submit_bitmap, start_bit, end_bit - start_bit);
+		}
 		/*
 		 * Above btrfs_run_delalloc_range() may have unlocked the folio,
 		 * thus for the last range, we cannot touch the folio anymore.
@@ -1230,10 +1243,10 @@ static noinline_for_stack int writepage_delalloc(struct btrfs_inode *inode,
 		DIV_ROUND_UP(delalloc_end + 1 - page_start, PAGE_SIZE);
 
 	/*
-	 * If btrfs_run_dealloc_range() already started I/O and unlocked
-	 * the folios, we just need to account for them here.
+	 * If all ranges are submitted asynchronously, we just need to account
+	 * for them here.
 	 */
-	if (ret == 1) {
+	if (bitmap_empty(&bio_ctrl->submit_bitmap, fs_info->sectors_per_page)) {
 		wbc->nr_to_write -= delalloc_to_write;
 		return 1;
 	}
@@ -1331,15 +1344,6 @@ static noinline_for_stack int extent_writepage_io(struct btrfs_inode *inode,
 {
 	struct btrfs_fs_info *fs_info = inode->root->fs_info;
 	unsigned long range_bitmap = 0;
-	/*
-	 * This is the default value for sectorsize == PAGE_SIZE case.
-	 * We known we need to write the dirty sector (aka the page),
-	 * even if the page is not dirty (we cleared it before entering).
-	 *
-	 * For subpage cases we will get the correct bitmap later.
-	 */
-	unsigned long dirty_bitmap = 1;
-	unsigned int bitmap_size = 1;
 	bool submitted_io = false;
 	const u64 folio_start = folio_pos(folio);
 	u64 cur;
@@ -1357,18 +1361,14 @@ static noinline_for_stack int extent_writepage_io(struct btrfs_inode *inode,
 		return 1;
 	}
 
-	if (btrfs_is_subpage(fs_info, inode->vfs_inode.i_mapping)) {
-		ASSERT(fs_info->sectors_per_page > 1);
-		btrfs_get_subpage_dirty_bitmap(fs_info, folio, &dirty_bitmap);
-		bitmap_size = fs_info->sectors_per_page;
-	}
 	for (cur = start; cur < start + len; cur += fs_info->sectorsize)
 		set_bit((cur - folio_start) >> fs_info->sectorsize_bits, &range_bitmap);
-	bitmap_and(&dirty_bitmap, &dirty_bitmap, &range_bitmap, bitmap_size);
+	bitmap_and(&bio_ctrl->submit_bitmap, &bio_ctrl->submit_bitmap, &range_bitmap,
+		   fs_info->sectors_per_page);
 
 	bio_ctrl->end_io_func = end_bbio_data_write;
 
-	for_each_set_bit(bit, &dirty_bitmap, bitmap_size) {
+	for_each_set_bit(bit, &bio_ctrl->submit_bitmap, fs_info->sectors_per_page) {
 		cur = folio_pos(folio) + (bit << fs_info->sectorsize_bits);
 
 		if (cur >= i_size) {
@@ -1421,6 +1421,7 @@ static noinline_for_stack int extent_writepage_io(struct btrfs_inode *inode,
 static int extent_writepage(struct folio *folio, struct btrfs_bio_ctrl *bio_ctrl)
 {
 	struct inode *inode = folio->mapping->host;
+	struct btrfs_fs_info *fs_info = inode_to_fs_info(inode);
 	const u64 page_start = folio_pos(folio);
 	int ret;
 	size_t pg_offset;
@@ -1442,11 +1443,16 @@ static int extent_writepage(struct folio *folio, struct btrfs_bio_ctrl *bio_ctrl
 	if (folio->index == end_index)
 		folio_zero_range(folio, pg_offset, folio_size(folio) - pg_offset);
 
+	/*
+	 * Default to unlock the whole folio.
+	 * The proper bitmap can only be initialized until writepage_delalloc().
+	 */
+	bio_ctrl->submit_bitmap = (unsigned long)-1;
 	ret = set_folio_extent_mapped(folio);
 	if (ret < 0)
 		goto done;
 
-	ret = writepage_delalloc(BTRFS_I(inode), folio, bio_ctrl->wbc);
+	ret = writepage_delalloc(BTRFS_I(inode), folio, bio_ctrl);
 	if (ret == 1)
 		return 0;
 	if (ret)
@@ -1466,8 +1472,11 @@ static int extent_writepage(struct folio *folio, struct btrfs_bio_ctrl *bio_ctrl
 		mapping_set_error(folio->mapping, ret);
 	}
 
-	btrfs_folio_end_writer_lock(inode_to_fs_info(inode), folio,
-				    page_start, PAGE_SIZE);
+	/*
+	 * Only unlock ranges that is submitted. As there can be some async
+	 * submitted range inside the folio.
+	 */
+	btrfs_folio_end_writer_lock_bitmap(fs_info, folio, bio_ctrl->submit_bitmap);
 	ASSERT(ret <= 0);
 	return ret;
 }
@@ -2210,6 +2219,11 @@ void extent_write_locked_range(struct inode *inode, const struct folio *locked_f
 		if (pages_dirty && folio != locked_folio)
 			ASSERT(folio_test_dirty(folio));
 
+		/*
+		 * Set the submission bitmap to submit all sectors.
+		 * extent_writepage_io() will do the truncation correctly.
+		 */
+		bio_ctrl.submit_bitmap = (unsigned long)-1;
 		ret = extent_writepage_io(BTRFS_I(inode), folio, cur, cur_len,
 					  &bio_ctrl, i_size);
 		if (ret == 1)
diff --git a/fs/btrfs/subpage.c b/fs/btrfs/subpage.c
index 2f071f4b8b8d..8a8724c4a0a1 100644
--- a/fs/btrfs/subpage.c
+++ b/fs/btrfs/subpage.c
@@ -424,6 +424,39 @@ void btrfs_folio_end_writer_lock(const struct btrfs_fs_info *fs_info,
 		folio_unlock(folio);
 }
 
+void btrfs_folio_end_writer_lock_bitmap(const struct btrfs_fs_info *fs_info,
+					struct folio *folio, unsigned long bitmap)
+{
+	struct btrfs_subpage *subpage = folio_get_private(folio);
+	const int start_bit = fs_info->sectors_per_page * btrfs_bitmap_nr_locked;
+	unsigned long flags;
+	bool last = false;
+	int cleared = 0;
+	int bit;
+
+	if (unlikely(!fs_info) || !btrfs_is_subpage(fs_info, folio->mapping)) {
+		folio_unlock(folio);
+		return;
+	}
+
+	if (atomic_read(&subpage->writers) == 0) {
+		/* No writers, locked by plain lock_page() */
+		folio_unlock(folio);
+		return;
+	}
+
+	spin_lock_irqsave(&subpage->lock, flags);
+	for_each_set_bit(bit, &bitmap, fs_info->sectors_per_page) {
+		if (test_and_clear_bit(bit + start_bit, subpage->bitmaps))
+			cleared++;
+	}
+	ASSERT(atomic_read(&subpage->writers) >= cleared);
+	last = atomic_sub_and_test(cleared, &subpage->writers);
+	spin_unlock_irqrestore(&subpage->lock, flags);
+	if (last)
+		folio_unlock(folio);
+}
+
 #define subpage_test_bitmap_all_set(fs_info, subpage, name)		\
 	bitmap_test_range_all_set(subpage->bitmaps,			\
 			fs_info->sectors_per_page * btrfs_bitmap_nr_##name, \
diff --git a/fs/btrfs/subpage.h b/fs/btrfs/subpage.h
index f805261e0999..4b85d91d0e18 100644
--- a/fs/btrfs/subpage.h
+++ b/fs/btrfs/subpage.h
@@ -106,6 +106,8 @@ void btrfs_folio_end_writer_lock(const struct btrfs_fs_info *fs_info,
 				 struct folio *folio, u64 start, u32 len);
 void btrfs_folio_set_writer_lock(const struct btrfs_fs_info *fs_info,
 				 struct folio *folio, u64 start, u32 len);
+void btrfs_folio_end_writer_lock_bitmap(const struct btrfs_fs_info *fs_info,
+					struct folio *folio, unsigned long bitmap);
 bool btrfs_subpage_find_writer_locked(const struct btrfs_fs_info *fs_info,
 				      struct folio *folio, u64 search_start,
 				      u64 *found_start_ret, u32 *found_len_ret);
-- 
2.46.0


