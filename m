Return-Path: <linux-btrfs+bounces-19172-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D370C717ED
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Nov 2025 01:05:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id EAA9534FBB7
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Nov 2025 00:05:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B37979CF;
	Thu, 20 Nov 2025 00:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="GB2wozfY";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="GB2wozfY"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0201173
	for <linux-btrfs@vger.kernel.org>; Thu, 20 Nov 2025 00:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763597111; cv=none; b=Hj3FO3EPQ/y00NfSEyjIFQIkcWnLL4XHJjePaW+Yh7CShRlatzja4x90YmCSJ4RlEeUO73ZsDYpTMtUbEtBOwJd72+e4BDRp/MkTR98czm4esS7CDPun5+jlJwP1bdjUM8XXHHxchUvsyShLkie+/772LTD0mYTLQ4e5iDRrtCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763597111; c=relaxed/simple;
	bh=clyLWEhx/dcmDmU80KpDoWre2LfBVQfW9qLTRMsE5eA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CnP6d6ICxu8/feRXwpgxmxNBp7MircQKwrOz/QB4fVnk2w/K0X3XM9SD25Q4rtYFBBKGBOO2XlVd5QdbBYJnXH+RHEmnrI7cHMiowpq1qQYGJt7Hvrgq5jTB5UFK119qnP4SPZarqwtTsQLKQHIBQIHmvLyDwjcQ5zQWmR89mwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=GB2wozfY; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=GB2wozfY; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id BC68B2198F
	for <linux-btrfs@vger.kernel.org>; Thu, 20 Nov 2025 00:04:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1763597096; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uqzG3q8TKkWgpoLIgJLHwrh4NLyEFAJ4ZTuGP4Mt+5Y=;
	b=GB2wozfYIyG1FKJQYAMiiZnPuQqhmD2moGLI7fk6FlL2UdoSwrona2lg5zRiGGXLmreMs0
	8cECBB/b5Io6yH4OeuHHGlhZc46VWPRcrL3T6Hhm/nho2jst3Xe+dTwrx1RjMMSFeu1ThK
	Cn78ZR2f4qQrP37h0hQxoPV28gy3KYU=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1763597096; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uqzG3q8TKkWgpoLIgJLHwrh4NLyEFAJ4ZTuGP4Mt+5Y=;
	b=GB2wozfYIyG1FKJQYAMiiZnPuQqhmD2moGLI7fk6FlL2UdoSwrona2lg5zRiGGXLmreMs0
	8cECBB/b5Io6yH4OeuHHGlhZc46VWPRcrL3T6Hhm/nho2jst3Xe+dTwrx1RjMMSFeu1ThK
	Cn78ZR2f4qQrP37h0hQxoPV28gy3KYU=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F21803EA61
	for <linux-btrfs@vger.kernel.org>; Thu, 20 Nov 2025 00:04:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id CCEPLCdbHmkwFgAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Thu, 20 Nov 2025 00:04:55 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 4/4] btrfs: reduce extent map lookup during writes
Date: Thu, 20 Nov 2025 10:34:33 +1030
Message-ID: <a6869c2d5f3b8cdd3360375ea64d0449c97dfd6d.1763596717.git.wqu@suse.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1763596717.git.wqu@suse.com>
References: <cover.1763596717.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.20 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_SPAM_SHORT(2.80)[0.934];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_ONE(0.00)[1];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:email,imap1.dmz-prg2.suse.org:helo];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Score: 0.20
X-Spam-Level: 

With large data folios supports, even on x86_64 we can hit a folio that
contains several fs blocks.

In that case, we still need to call btrfs_get_extent() for each block,
as our submission path is still iterating each fs block and submit them
one by one. This reduces the benefit of large folios.

Change the behavior to submit the whole range when possible, this is
done by:

- Use for_each_set_bitrange() instead of for_each_set_bit()
  Now we can get a contiguous range to submit instead of a single fs
  block.

- Handle blocks beyond EOF in one go
  This is pretty much the same as the old behavior, but for a range
  crossing i_size, we finish the range beyond i_size first, then submit
  the remaining.

- Submit the contiguous range in one go
  Although we still need to consider the extent map boundary.

- Remove submit_one_sector()
  As it's no longer utilized.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/extent_io.c | 208 +++++++++++++++++++++++--------------------
 1 file changed, 112 insertions(+), 96 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index cbee93a929f3..152eed265a3c 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -1596,94 +1596,6 @@ static noinline_for_stack int writepage_delalloc(struct btrfs_inode *inode,
 	return 0;
 }
 
-/*
- * Return 0 if we have submitted or queued the sector for submission.
- * Return <0 for critical errors, and the involved sector will be cleaned up.
- *
- * Caller should make sure filepos < i_size and handle filepos >= i_size case.
- */
-static int submit_one_sector(struct btrfs_inode *inode,
-			     struct folio *folio,
-			     u64 filepos, struct btrfs_bio_ctrl *bio_ctrl,
-			     loff_t i_size)
-{
-	struct btrfs_fs_info *fs_info = inode->root->fs_info;
-	struct extent_map *em;
-	u64 block_start;
-	u64 disk_bytenr;
-	u64 extent_offset;
-	u64 em_end;
-	const u32 sectorsize = fs_info->sectorsize;
-
-	ASSERT(IS_ALIGNED(filepos, sectorsize));
-
-	/* @filepos >= i_size case should be handled by the caller. */
-	ASSERT(filepos < i_size);
-
-	em = btrfs_get_extent(inode, NULL, filepos, sectorsize);
-	if (IS_ERR(em)) {
-		/*
-		 * bio_ctrl may contain a bio crossing several folios.
-		 * Submit it immediately so that the bio has a chance
-		 * to finish normally, other than marked as error.
-		 */
-		submit_one_bio(bio_ctrl);
-
-		/*
-		 * When submission failed, we should still clear the folio dirty.
-		 * Or the folio will be written back again but without any
-		 * ordered extent.
-		 */
-		btrfs_folio_clear_dirty(fs_info, folio, filepos, sectorsize);
-		btrfs_folio_set_writeback(fs_info, folio, filepos, sectorsize);
-		btrfs_folio_clear_writeback(fs_info, folio, filepos, sectorsize);
-
-		/*
-		 * Since there is no bio submitted to finish the ordered
-		 * extent, we have to manually finish this sector.
-		 */
-		btrfs_mark_ordered_io_finished(inode, folio, filepos,
-					       fs_info->sectorsize, false);
-		return PTR_ERR(em);
-	}
-
-	extent_offset = filepos - em->start;
-	em_end = btrfs_extent_map_end(em);
-	ASSERT(filepos <= em_end);
-	ASSERT(IS_ALIGNED(em->start, sectorsize));
-	ASSERT(IS_ALIGNED(em->len, sectorsize));
-
-	block_start = btrfs_extent_map_block_start(em);
-	disk_bytenr = btrfs_extent_map_block_start(em) + extent_offset;
-
-	ASSERT(!btrfs_extent_map_is_compressed(em));
-	ASSERT(block_start != EXTENT_MAP_HOLE);
-	ASSERT(block_start != EXTENT_MAP_INLINE);
-
-	btrfs_free_extent_map(em);
-	em = NULL;
-
-	/*
-	 * Although the PageDirty bit is cleared before entering this
-	 * function, subpage dirty bit is not cleared.
-	 * So clear subpage dirty bit here so next time we won't submit
-	 * a folio for a range already written to disk.
-	 */
-	btrfs_folio_clear_dirty(fs_info, folio, filepos, sectorsize);
-	btrfs_folio_set_writeback(fs_info, folio, filepos, sectorsize);
-	/*
-	 * Above call should set the whole folio with writeback flag, even
-	 * just for a single subpage sector.
-	 * As long as the folio is properly locked and the range is correct,
-	 * we should always get the folio with writeback flag.
-	 */
-	ASSERT(folio_test_writeback(folio));
-
-	submit_extent_folio(bio_ctrl, disk_bytenr, folio,
-			    sectorsize, filepos - folio_pos(folio), 0);
-	return 0;
-}
-
 static void finish_io_beyond_eof(struct btrfs_inode *inode, struct folio *folio,
 				 u64 start, u32 len, loff_t i_size)
 {
@@ -1718,6 +1630,96 @@ static void finish_io_beyond_eof(struct btrfs_inode *inode, struct folio *folio,
 	btrfs_folio_clear_dirty(fs_info, folio, start, len);
 }
 
+/*
+ * Return 0 if we have submitted or queued the range for submission.
+ * Return <0 for critical errors, and the involved blocks will be cleaned up.
+ *
+ * Caller should make sure the range doesn't go beyond the last block of the inode.
+ */
+static int submit_range(struct btrfs_inode *inode, struct folio *folio,
+			u64 start, u32 len, struct btrfs_bio_ctrl *bio_ctrl)
+{
+	struct btrfs_fs_info *fs_info = inode->root->fs_info;
+	const u32 sectorsize = fs_info->sectorsize;
+	u64 cur = start;
+
+	ASSERT(IS_ALIGNED(start, sectorsize));
+	ASSERT(IS_ALIGNED(len, sectorsize));
+	ASSERT(start + len <= folio_end(folio));
+
+	while (cur < start + len) {
+		struct extent_map *em;
+		u64 block_start;
+		u64 disk_bytenr;
+		u64 extent_offset;
+		u64 em_end;
+		u32 cur_len = start + len - cur;
+
+		em = btrfs_get_extent(inode, NULL, cur, sectorsize);
+		if (IS_ERR(em)) {
+			/*
+			 * bio_ctrl may contain a bio crossing several folios.
+			 * Submit it immediately so that the bio has a chance
+			 * to finish normally, other than marked as error.
+			 */
+			submit_one_bio(bio_ctrl);
+
+			/*
+			 * When submission failed, we should still clear the folio dirty.
+			 * Or the folio will be written back again but without any
+			 * ordered extent.
+			 */
+			btrfs_folio_clear_dirty(fs_info, folio, cur, len);
+			btrfs_folio_set_writeback(fs_info, folio, cur, len);
+			btrfs_folio_clear_writeback(fs_info, folio, cur, len);
+
+			/*
+			 * Since there is no bio submitted to finish the ordered
+			 * extent, we have to manually finish this sector.
+			 */
+			btrfs_mark_ordered_io_finished(inode, folio, cur, len, false);
+			return PTR_ERR(em);
+		}
+		extent_offset = cur - em->start;
+		em_end = btrfs_extent_map_end(em);
+		ASSERT(cur <= em_end);
+		ASSERT(IS_ALIGNED(em->start, sectorsize));
+		ASSERT(IS_ALIGNED(em->len, sectorsize));
+
+		block_start = btrfs_extent_map_block_start(em);
+		disk_bytenr = btrfs_extent_map_block_start(em) + extent_offset;
+
+		ASSERT(!btrfs_extent_map_is_compressed(em));
+		ASSERT(block_start != EXTENT_MAP_HOLE);
+		ASSERT(block_start != EXTENT_MAP_INLINE);
+
+		cur_len = min(cur_len, em_end - cur);
+		btrfs_free_extent_map(em);
+		em = NULL;
+
+		/*
+		 * Although the PageDirty bit is cleared before entering this
+		 * function, subpage dirty bit is not cleared.
+		 * So clear subpage dirty bit here so next time we won't submit
+		 * a folio for a range already written to disk.
+		 */
+		btrfs_folio_clear_dirty(fs_info, folio, cur, cur_len);
+		btrfs_folio_set_writeback(fs_info, folio, cur, cur_len);
+		/*
+		 * Above call should set the whole folio with writeback flag, even
+		 * just for a single subpage block.
+		 * As long as the folio is properly locked and the range is correct,
+		 * we should always get the folio with writeback flag.
+		 */
+		ASSERT(folio_test_writeback(folio));
+
+		submit_extent_folio(bio_ctrl, disk_bytenr, folio,
+				    cur_len, cur - folio_pos(folio), 0);
+		cur += cur_len;
+	}
+	return 0;
+}
+
 /*
  * Helper for extent_writepage().  This calls the writepage start hooks,
  * and does the loop to map the page into extents and bios.
@@ -1740,8 +1742,9 @@ static noinline_for_stack int extent_writepage_io(struct btrfs_inode *inode,
 	const u64 folio_start = folio_pos(folio);
 	const u64 folio_end = folio_start + folio_size(folio);
 	const unsigned int blocks_per_folio = btrfs_blocks_per_folio(fs_info, folio);
-	u64 cur;
-	int bit;
+	unsigned int start_bit;
+	unsigned int end_bit;
+	const u64 rounded_isize = round_up(i_size, fs_info->sectorsize);
 	int ret = 0;
 
 	ASSERT(start >= folio_start, "start=%llu folio_start=%llu", start, folio_start);
@@ -1769,14 +1772,27 @@ static noinline_for_stack int extent_writepage_io(struct btrfs_inode *inode,
 
 	bio_ctrl->end_io_func = end_bbio_data_write;
 
-	for_each_set_bit(bit, &bio_ctrl->submit_bitmap, blocks_per_folio) {
-		cur = folio_pos(folio) + (bit << fs_info->sectorsize_bits);
+	for_each_set_bitrange(start_bit, end_bit, &bio_ctrl->submit_bitmap, blocks_per_folio) {
+		const u64 cur_start = folio_pos(folio) + (start_bit << fs_info->sectorsize_bits);
+		u32 cur_len = (end_bit - start_bit) << fs_info->sectorsize_bits;
 
-		if (cur >= i_size) {
-			finish_io_beyond_eof(inode, folio, cur, start + len - cur, i_size);
-			break;
+		if (cur_start > rounded_isize) {
+			/*
+			 * The whole range is byoned EOF.
+			 *
+			 * Just finish the IO and skip to the next range.
+			 */
+			finish_io_beyond_eof(inode, folio, cur_start, cur_len, i_size);
+			continue;
 		}
-		ret = submit_one_sector(inode, folio, cur, bio_ctrl, i_size);
+		if (cur_start + cur_len > rounded_isize) {
+			/* The tailing part of the range is beyond EOF. */
+			finish_io_beyond_eof(inode, folio, rounded_isize,
+					     cur_start + cur_len - rounded_isize, i_size);
+			/* Shrink the range inside the EOF. */
+			cur_len = rounded_isize - cur_start;
+		}
+		ret = submit_range(inode, folio, cur_start, cur_len, bio_ctrl);
 		if (unlikely(ret < 0)) {
 			if (!found_error)
 				found_error = ret;
-- 
2.52.0


