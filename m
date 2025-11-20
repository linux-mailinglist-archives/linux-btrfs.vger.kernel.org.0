Return-Path: <linux-btrfs+bounces-19211-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 35EEDC7313A
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Nov 2025 10:17:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id 39C412BD61
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Nov 2025 09:17:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09F753009D5;
	Thu, 20 Nov 2025 09:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Pl4eTKet";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Pl4eTKet"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 598CA2C21FE
	for <linux-btrfs@vger.kernel.org>; Thu, 20 Nov 2025 09:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763630242; cv=none; b=Jmh09Xfv3P9f4fIoQgFgR1Dt+WlXt6z8KLpBfR04ShiUSm5PNjgcOMH/5ra0v8RITDAURaqst9dBM0XaTU38/LcxWyrrcnz9sE9ajCjzuUShdv+jZwRGG83XFfMv9AQ8gZoITzz44NA8XeyD5RJWB3kLeaqSIBkOET4xxlHTftI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763630242; c=relaxed/simple;
	bh=aBAh0Nupw2QbWUZ23vQOJ1BB6HnLNzRctWB/jKmcmZE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Lk5CFTUR1Wzhf//DWgkVcVrtGQ3AMWFhX8WesSel0pwKZzuVjsrCzAP9FK1RvsOEXfXZYW6vP557+wgGImkjY6b7zrOJUzW3BZ2HZvJG1df+o1dM23YterTqASdqbkFmz/f+o4bI6prR5xb/Q1HcC+3wE5sKoQiVFKuxkJV+SJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Pl4eTKet; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Pl4eTKet; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id CF5E720967
	for <linux-btrfs@vger.kernel.org>; Thu, 20 Nov 2025 09:17:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1763630232; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nwbGbv0l0fmmlKCRwmPCi2Ti4xcsWqy1vHk5+y+DH9c=;
	b=Pl4eTKetJLa1dbQxT7uh7a/ElrFCYRhEb+AxcvQkr8f3EpqiY6lIX8p2SdjDwO/BZw2xcu
	SEFYdixpLVJbcgr/8ymU+AMLWOImhN0s0pxvOZxVMzi662rsujsLwehZ72mnJp5RHjh1MY
	EVq6KaMn5DmOxzDtslJxzY//liMIdec=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1763630232; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nwbGbv0l0fmmlKCRwmPCi2Ti4xcsWqy1vHk5+y+DH9c=;
	b=Pl4eTKetJLa1dbQxT7uh7a/ElrFCYRhEb+AxcvQkr8f3EpqiY6lIX8p2SdjDwO/BZw2xcu
	SEFYdixpLVJbcgr/8ymU+AMLWOImhN0s0pxvOZxVMzi662rsujsLwehZ72mnJp5RHjh1MY
	EVq6KaMn5DmOxzDtslJxzY//liMIdec=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 139753EA61
	for <linux-btrfs@vger.kernel.org>; Thu, 20 Nov 2025 09:17:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id cESIMZfcHmn9FQAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Thu, 20 Nov 2025 09:17:11 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v3 4/4] btrfs: reduce extent map lookup during writes
Date: Thu, 20 Nov 2025 19:46:49 +1030
Message-ID: <564b37e38d875bcd4d7cd4bdebf04223bcad5893.1763629982.git.wqu@suse.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1763629982.git.wqu@suse.com>
References: <cover.1763629982.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
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
 fs/btrfs/extent_io.c | 182 +++++++++++++++++++++++--------------------
 1 file changed, 97 insertions(+), 85 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 87bf5ce17264..e61039de0edf 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -1602,91 +1602,94 @@ static noinline_for_stack int writepage_delalloc(struct btrfs_inode *inode,
 	return 0;
 }
 
+
 /*
- * Return 0 if we have submitted or queued the sector for submission.
- * Return <0 for critical errors, and the involved sector will be cleaned up.
+ * Return 0 if we have submitted or queued the range for submission.
+ * Return <0 for critical errors, and the involved blocks will be cleaned up.
  *
- * Caller should make sure filepos < i_size and handle filepos >= i_size case.
+ * Caller should make sure the range doesn't go beyond the last block of the inode.
  */
-static int submit_one_sector(struct btrfs_inode *inode,
-			     struct folio *folio,
-			     u64 filepos, struct btrfs_bio_ctrl *bio_ctrl,
-			     loff_t i_size)
+static int submit_range(struct btrfs_inode *inode, struct folio *folio,
+			u64 start, u32 len, struct btrfs_bio_ctrl *bio_ctrl)
 {
 	struct btrfs_fs_info *fs_info = inode->root->fs_info;
-	struct extent_map *em;
-	u64 block_start;
-	u64 disk_bytenr;
-	u64 extent_offset;
-	u64 em_end;
 	const u32 sectorsize = fs_info->sectorsize;
+	u64 cur = start;
 
-	ASSERT(IS_ALIGNED(filepos, sectorsize));
+	ASSERT(IS_ALIGNED(start, sectorsize));
+	ASSERT(IS_ALIGNED(len, sectorsize));
+	ASSERT(start + len <= folio_end(folio));
 
-	/* @filepos >= i_size case should be handled by the caller. */
-	ASSERT(filepos < i_size);
+	while (cur < start + len) {
+		struct extent_map *em;
+		u64 block_start;
+		u64 disk_bytenr;
+		u64 extent_offset;
+		u64 em_end;
+		u32 cur_len = start + len - cur;
 
-	em = btrfs_get_extent(inode, NULL, filepos, sectorsize);
-	if (IS_ERR(em)) {
-		/*
-		 * bio_ctrl may contain a bio crossing several folios.
-		 * Submit it immediately so that the bio has a chance
-		 * to finish normally, other than marked as error.
-		 */
-		submit_one_bio(bio_ctrl);
+		em = btrfs_get_extent(inode, NULL, cur, cur_len);
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
+			btrfs_folio_clear_dirty(fs_info, folio, cur, cur_len);
+			btrfs_folio_set_writeback(fs_info, folio, cur, cur_len);
+			btrfs_folio_clear_writeback(fs_info, folio, cur, cur_len);
+
+			/*
+			 * Since there is no bio submitted to finish the ordered
+			 * extent, we have to manually finish this range.
+			 */
+			btrfs_mark_ordered_io_finished(inode, folio, cur, cur_len, false);
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
 
 		/*
-		 * When submission failed, we should still clear the folio dirty.
-		 * Or the folio will be written back again but without any
-		 * ordered extent.
+		 * Although the PageDirty bit is cleared before entering this
+		 * function, subpage dirty bit is not cleared.
+		 * So clear subpage dirty bit here so next time we won't submit
+		 * a folio for a range already written to disk.
 		 */
-		btrfs_folio_clear_dirty(fs_info, folio, filepos, sectorsize);
-		btrfs_folio_set_writeback(fs_info, folio, filepos, sectorsize);
-		btrfs_folio_clear_writeback(fs_info, folio, filepos, sectorsize);
-
+		btrfs_folio_clear_dirty(fs_info, folio, cur, cur_len);
+		btrfs_folio_set_writeback(fs_info, folio, cur, cur_len);
 		/*
-		 * Since there is no bio submitted to finish the ordered
-		 * extent, we have to manually finish this sector.
+		 * Above call should set the whole folio with writeback flag, even
+		 * just for a single subpage block.
+		 * As long as the folio is properly locked and the range is correct,
+		 * we should always get the folio with writeback flag.
 		 */
-		btrfs_mark_ordered_io_finished(inode, folio, filepos,
-					       fs_info->sectorsize, false);
-		return PTR_ERR(em);
+		ASSERT(folio_test_writeback(folio));
+
+		submit_extent_folio(bio_ctrl, disk_bytenr, folio,
+				    cur_len, cur - folio_pos(folio), 0);
+		cur += cur_len;
 	}
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
 	return 0;
 }
 
@@ -1712,8 +1715,9 @@ static noinline_for_stack int extent_writepage_io(struct btrfs_inode *inode,
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
@@ -1741,23 +1745,31 @@ static noinline_for_stack int extent_writepage_io(struct btrfs_inode *inode,
 
 	bio_ctrl->end_io_func = end_bbio_data_write;
 
-	for_each_set_bit(bit, &bio_ctrl->submit_bitmap, blocks_per_folio) {
-		cur = folio_pos(folio) + (bit << fs_info->sectorsize_bits);
+	for_each_set_bitrange(start_bit, end_bit, &bio_ctrl->submit_bitmap, blocks_per_folio) {
+		const u64 cur_start = folio_pos(folio) + (start_bit << fs_info->sectorsize_bits);
+		u32 cur_len = (end_bit - start_bit) << fs_info->sectorsize_bits;
 
-		if (cur >= i_size) {
-			btrfs_mark_ordered_io_truncated(inode, folio, cur, end - cur);
+		if (cur_start > rounded_isize) {
 			/*
-			 * This range is beyond i_size, thus we don't need to
-			 * bother writing back.
-			 * But we still need to clear the dirty subpage bit, or
-			 * the next time the folio gets dirtied, we will try to
-			 * writeback the sectors with subpage dirty bits,
-			 * causing writeback without ordered extent.
+			 * The whole range is beyond EOF.
+			 *
+			 * Just finish the IO and skip to the next range.
 			 */
-			btrfs_folio_clear_dirty(fs_info, folio, cur, end - cur);
-			break;
+			btrfs_mark_ordered_io_truncated(inode, folio, cur_start, cur_len);
+			btrfs_folio_clear_dirty(fs_info, folio, cur_start, cur_len);
+			continue;
 		}
-		ret = submit_one_sector(inode, folio, cur, bio_ctrl, i_size);
+		if (cur_start + cur_len > rounded_isize) {
+			u32 truncate_len = cur_start + cur_len - rounded_isize;
+
+			/* The tailing part of the range is beyond EOF. */
+			btrfs_mark_ordered_io_truncated(inode, folio, rounded_isize, truncate_len);
+			btrfs_folio_clear_dirty(fs_info, folio, rounded_isize, truncate_len);
+			/* Shrink the range inside the EOF. */
+			cur_len = rounded_isize - cur_start;
+		}
+
+		ret = submit_range(inode, folio, cur_start, cur_len, bio_ctrl);
 		if (unlikely(ret < 0)) {
 			if (!found_error)
 				found_error = ret;
-- 
2.52.0


