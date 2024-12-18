Return-Path: <linux-btrfs+bounces-10537-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 494729F61FD
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Dec 2024 10:43:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C901162986
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Dec 2024 09:42:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81856199FC9;
	Wed, 18 Dec 2024 09:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="iwf2NtM1";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="iwf2NtM1"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A4B21925A2
	for <linux-btrfs@vger.kernel.org>; Wed, 18 Dec 2024 09:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734514930; cv=none; b=RKGamwmAFqWSZoKKsO1HELmIZxZaqaZ1DRmCrCYTNBavfOD8x+Srt9f9HlOMbd7C1c1ZjVWGFjM90a/yrdDi3aPgOg8yDwPsLgc8z5onP96OwEiIt/tJxeo81t6w+YJF6J+YuX5nxdvwl3tnh6STtnupq8W1fZhELqsv0CA9TqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734514930; c=relaxed/simple;
	bh=iNgfqr7ro+drTgJewlDUo+hH+I//FOQM2NiYOVPCA0U=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q+nXamKUPck6m3L9paaFrB3swXnjE+f36FuSXCkP5HCTDnzIZj8P4SIz6sPN4pCWxTk7YloY2vNf8I2Qjt8JP/tvZ6XPntCOkeET5+kFnFJVj1nbpcWKbdh82wVSsCrpp7S9sCRJhZ7vWzXsCoiTw72oPjyPrqQV1ZS82CVO1WM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=iwf2NtM1; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=iwf2NtM1; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 6FEAD1F449
	for <linux-btrfs@vger.kernel.org>; Wed, 18 Dec 2024 09:42:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1734514925; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=E4rr3T75bgddpcPovBin2auT0frDieMuwHYA3BprM9Q=;
	b=iwf2NtM1zBEu9DvEj/hHr2MnAkpHuK73StN/ujtbArvaec2mvTbwjBtwtuyES4Qnr0bJ9u
	zaaipwr2MbIKdhe6dHxLvyyRyXq3OZBmW8XePp84AUz5NLSodoZsPM/qhYP83QGsZ1h6/g
	+yMk92n54PEJfwdVQqOfUIrwu3qsNmU=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1734514925; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=E4rr3T75bgddpcPovBin2auT0frDieMuwHYA3BprM9Q=;
	b=iwf2NtM1zBEu9DvEj/hHr2MnAkpHuK73StN/ujtbArvaec2mvTbwjBtwtuyES4Qnr0bJ9u
	zaaipwr2MbIKdhe6dHxLvyyRyXq3OZBmW8XePp84AUz5NLSodoZsPM/qhYP83QGsZ1h6/g
	+yMk92n54PEJfwdVQqOfUIrwu3qsNmU=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9BB4E132EA
	for <linux-btrfs@vger.kernel.org>; Wed, 18 Dec 2024 09:42:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 2M05FuyYYmdmSwAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Wed, 18 Dec 2024 09:42:04 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 09/18] btrfs: migrate file.c to use block size terminology
Date: Wed, 18 Dec 2024 20:11:25 +1030
Message-ID: <24adf3d2c52a53370f628ce8b1c7440f4fb77d4e.1734514696.git.wqu@suse.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <cover.1734514696.git.wqu@suse.com>
References: <cover.1734514696.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -2.80
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:email,imap1.dmz-prg2.suse.org:helo];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 

Straightforward rename from "sector" to "block".

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/file.c | 138 ++++++++++++++++++++++++------------------------
 1 file changed, 69 insertions(+), 69 deletions(-)

diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 4775a17c4ee1..f34f6d99d039 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -44,8 +44,8 @@
 static void btrfs_drop_folio(struct btrfs_fs_info *fs_info, struct folio *folio,
 			     u64 pos, u64 copied)
 {
-	u64 block_start = round_down(pos, fs_info->sectorsize);
-	u64 block_len = round_up(pos + copied, fs_info->sectorsize) - block_start;
+	u64 block_start = round_down(pos, fs_info->blocksize);
+	u64 block_len = round_up(pos + copied, fs_info->blocksize) - block_start;
 
 	ASSERT(block_len <= U32_MAX);
 	/*
@@ -85,9 +85,9 @@ int btrfs_dirty_folio(struct btrfs_inode *inode, struct folio *folio, loff_t pos
 	if (noreserve)
 		extra_bits |= EXTENT_NORESERVE;
 
-	start_pos = round_down(pos, fs_info->sectorsize);
+	start_pos = round_down(pos, fs_info->blocksize);
 	num_bytes = round_up(write_bytes + pos - start_pos,
-			     fs_info->sectorsize);
+			     fs_info->blocksize);
 	ASSERT(num_bytes <= U32_MAX);
 	ASSERT(folio_pos(folio) <= pos &&
 	       folio_pos(folio) + folio_size(folio) >= pos + write_bytes);
@@ -416,7 +416,7 @@ int btrfs_drop_extents(struct btrfs_trans_handle *trans,
 			    extent_type == BTRFS_FILE_EXTENT_INLINE) {
 				args->bytes_found += extent_end - key.offset;
 				extent_end = ALIGN(extent_end,
-						   fs_info->sectorsize);
+						   fs_info->blocksize);
 			} else if (update_refs && disk_bytenr > 0) {
 				struct btrfs_ref ref = {
 					.action = BTRFS_DROP_DELAYED_REF,
@@ -925,8 +925,8 @@ lock_and_cleanup_extent_if_need(struct btrfs_inode *inode, struct folio *folio,
 	u64 last_pos;
 	int ret = 0;
 
-	start_pos = round_down(pos, fs_info->sectorsize);
-	last_pos = round_up(pos + write_bytes, fs_info->sectorsize) - 1;
+	start_pos = round_down(pos, fs_info->blocksize);
+	last_pos = round_up(pos + write_bytes, fs_info->blocksize) - 1;
 
 	if (start_pos < inode->vfs_inode.i_size) {
 		struct btrfs_ordered_extent *ordered;
@@ -1007,9 +1007,9 @@ int btrfs_check_nocow_lock(struct btrfs_inode *inode, loff_t pos,
 	if (!btrfs_drew_try_write_lock(&root->snapshot_lock))
 		return -EAGAIN;
 
-	lockstart = round_down(pos, fs_info->sectorsize);
+	lockstart = round_down(pos, fs_info->blocksize);
 	lockend = round_up(pos + *write_bytes,
-			   fs_info->sectorsize) - 1;
+			   fs_info->blocksize) - 1;
 	num_bytes = lockend - lockstart + 1;
 
 	if (nowait) {
@@ -1074,11 +1074,11 @@ int btrfs_write_check(struct kiocb *iocb, size_t count)
 		inode_inc_iversion(inode);
 	}
 
-	start_pos = round_down(pos, fs_info->sectorsize);
+	start_pos = round_down(pos, fs_info->blocksize);
 	oldsize = i_size_read(inode);
 	if (start_pos > oldsize) {
 		/* Expand hole size to cover write data, preventing empty gap */
-		loff_t end_pos = round_up(pos + count, fs_info->sectorsize);
+		loff_t end_pos = round_up(pos + count, fs_info->blocksize);
 
 		ret = btrfs_cont_expand(BTRFS_I(inode), oldsize, end_pos);
 		if (ret)
@@ -1125,12 +1125,12 @@ ssize_t btrfs_buffered_write(struct kiocb *iocb, struct iov_iter *i)
 	while (iov_iter_count(i) > 0) {
 		struct extent_state *cached_state = NULL;
 		size_t offset = offset_in_page(pos);
-		size_t sector_offset;
+		size_t block_offset;
 		size_t write_bytes = min(iov_iter_count(i), PAGE_SIZE - offset);
 		size_t reserve_bytes;
 		size_t copied;
-		size_t dirty_sectors;
-		size_t num_sectors;
+		size_t dirty_blocks;
+		size_t num_blocks;
 		struct folio *folio = NULL;
 		int extents_locked;
 		bool force_page_uptodate = false;
@@ -1145,7 +1145,7 @@ ssize_t btrfs_buffered_write(struct kiocb *iocb, struct iov_iter *i)
 		}
 
 		only_release_metadata = false;
-		sector_offset = pos & (fs_info->sectorsize - 1);
+		block_offset = pos & (fs_info->blocksize - 1);
 
 		extent_changeset_release(data_reserved);
 		ret = btrfs_check_data_free_space(BTRFS_I(inode),
@@ -1175,8 +1175,8 @@ ssize_t btrfs_buffered_write(struct kiocb *iocb, struct iov_iter *i)
 			only_release_metadata = true;
 		}
 
-		reserve_bytes = round_up(write_bytes + sector_offset,
-					 fs_info->sectorsize);
+		reserve_bytes = round_up(write_bytes + block_offset,
+					 fs_info->blocksize);
 		WARN_ON(reserve_bytes == 0);
 		ret = btrfs_delalloc_reserve_metadata(BTRFS_I(inode),
 						      reserve_bytes,
@@ -1229,8 +1229,8 @@ ssize_t btrfs_buffered_write(struct kiocb *iocb, struct iov_iter *i)
 
 		/*
 		 * If we get a partial write, we can end up with partially
-		 * uptodate page. Although if sector size < page size we can
-		 * handle it, but if it's not sector aligned it can cause
+		 * uptodate page. Although if block size < page size we can
+		 * handle it, but if it's not block aligned it can cause
 		 * a lot of complexity, so make sure they don't happen by
 		 * forcing retry this copy.
 		 */
@@ -1241,35 +1241,35 @@ ssize_t btrfs_buffered_write(struct kiocb *iocb, struct iov_iter *i)
 			}
 		}
 
-		num_sectors = BTRFS_BYTES_TO_BLKS(fs_info, reserve_bytes);
-		dirty_sectors = round_up(copied + sector_offset,
-					fs_info->sectorsize);
-		dirty_sectors = BTRFS_BYTES_TO_BLKS(fs_info, dirty_sectors);
+		num_blocks = BTRFS_BYTES_TO_BLKS(fs_info, reserve_bytes);
+		dirty_blocks = round_up(copied + block_offset,
+					fs_info->blocksize);
+		dirty_blocks = BTRFS_BYTES_TO_BLKS(fs_info, dirty_blocks);
 
 		if (copied == 0) {
 			force_page_uptodate = true;
-			dirty_sectors = 0;
+			dirty_blocks = 0;
 		} else {
 			force_page_uptodate = false;
 		}
 
-		if (num_sectors > dirty_sectors) {
-			/* release everything except the sectors we dirtied */
-			release_bytes -= dirty_sectors << fs_info->sectorsize_bits;
+		if (num_blocks > dirty_blocks) {
+			/* release everything except the blocks we dirtied */
+			release_bytes -= dirty_blocks << fs_info->blocksize_bits;
 			if (only_release_metadata) {
 				btrfs_delalloc_release_metadata(BTRFS_I(inode),
 							release_bytes, true);
 			} else {
 				u64 release_start = round_up(pos + copied,
-							     fs_info->sectorsize);
+							     fs_info->blocksize);
 				btrfs_delalloc_release_space(BTRFS_I(inode),
 						data_reserved, release_start,
 						release_bytes, true);
 			}
 		}
 
-		release_bytes = round_up(copied + sector_offset,
-					fs_info->sectorsize);
+		release_bytes = round_up(copied + block_offset,
+					fs_info->blocksize);
 
 		ret = btrfs_dirty_folio(BTRFS_I(inode), folio, pos, copied,
 					&cached_state, only_release_metadata);
@@ -1313,7 +1313,7 @@ ssize_t btrfs_buffered_write(struct kiocb *iocb, struct iov_iter *i)
 		} else {
 			btrfs_delalloc_release_space(BTRFS_I(inode),
 					data_reserved,
-					round_down(pos, fs_info->sectorsize),
+					round_down(pos, fs_info->blocksize),
 					release_bytes, true);
 		}
 	}
@@ -1861,7 +1861,7 @@ static vm_fault_t btrfs_page_mkwrite(struct vm_fault *vmf)
 	}
 
 	if (folio->index == ((size - 1) >> PAGE_SHIFT)) {
-		reserved_space = round_up(size - page_start, fs_info->sectorsize);
+		reserved_space = round_up(size - page_start, fs_info->blocksize);
 		if (reserved_space < PAGE_SIZE) {
 			end = page_start + reserved_space - 1;
 			btrfs_delalloc_release_space(BTRFS_I(inode),
@@ -2081,8 +2081,8 @@ static int find_first_non_hole(struct btrfs_inode *inode, u64 *start, u64 *len)
 	int ret = 0;
 
 	em = btrfs_get_extent(inode, NULL,
-			      round_down(*start, fs_info->sectorsize),
-			      round_up(*len, fs_info->sectorsize));
+			      round_down(*start, fs_info->blocksize),
+			      round_up(*len, fs_info->blocksize));
 	if (IS_ERR(em))
 		return PTR_ERR(em);
 
@@ -2245,7 +2245,7 @@ int btrfs_replace_file_extents(struct btrfs_inode *inode,
 	struct btrfs_root *root = inode->root;
 	struct btrfs_fs_info *fs_info = root->fs_info;
 	u64 min_size = btrfs_calc_insert_metadata_size(fs_info, 1);
-	u64 ino_size = round_up(inode->vfs_inode.i_size, fs_info->sectorsize);
+	u64 ino_size = round_up(inode->vfs_inode.i_size, fs_info->blocksize);
 	struct btrfs_trans_handle *trans = NULL;
 	struct btrfs_block_rsv *rsv;
 	unsigned int rsv_count;
@@ -2520,7 +2520,7 @@ static int btrfs_punch_hole(struct file *file, loff_t offset, loff_t len)
 	if (ret)
 		goto out_only_mutex;
 
-	ino_size = round_up(inode->i_size, fs_info->sectorsize);
+	ino_size = round_up(inode->i_size, fs_info->blocksize);
 	ret = find_first_non_hole(BTRFS_I(inode), &offset, &len);
 	if (ret < 0)
 		goto out_only_mutex;
@@ -2534,8 +2534,8 @@ static int btrfs_punch_hole(struct file *file, loff_t offset, loff_t len)
 	if (ret)
 		goto out_only_mutex;
 
-	lockstart = round_up(offset, fs_info->sectorsize);
-	lockend = round_down(offset + len, fs_info->sectorsize) - 1;
+	lockstart = round_up(offset, fs_info->blocksize);
+	lockend = round_down(offset + len, fs_info->blocksize) - 1;
 	same_block = (BTRFS_BYTES_TO_BLKS(fs_info, offset))
 		== (BTRFS_BYTES_TO_BLKS(fs_info, offset + len - 1));
 	/*
@@ -2546,7 +2546,7 @@ static int btrfs_punch_hole(struct file *file, loff_t offset, loff_t len)
 	 * Only do this if we are in the same block and we aren't doing the
 	 * entire block.
 	 */
-	if (same_block && len < fs_info->sectorsize) {
+	if (same_block && len < fs_info->blocksize) {
 		if (offset < ino_size) {
 			truncated_block = true;
 			ret = btrfs_truncate_block(BTRFS_I(inode), offset, len,
@@ -2735,12 +2735,12 @@ enum {
 static int btrfs_zero_range_check_range_boundary(struct btrfs_inode *inode,
 						 u64 offset)
 {
-	const u64 sectorsize = inode->root->fs_info->sectorsize;
+	const u64 blocksize = inode->root->fs_info->blocksize;
 	struct extent_map *em;
 	int ret;
 
-	offset = round_down(offset, sectorsize);
-	em = btrfs_get_extent(inode, NULL, offset, sectorsize);
+	offset = round_down(offset, blocksize);
+	em = btrfs_get_extent(inode, NULL, offset, blocksize);
 	if (IS_ERR(em))
 		return PTR_ERR(em);
 
@@ -2765,9 +2765,9 @@ static int btrfs_zero_range(struct inode *inode,
 	struct extent_changeset *data_reserved = NULL;
 	int ret;
 	u64 alloc_hint = 0;
-	const u64 sectorsize = fs_info->sectorsize;
-	u64 alloc_start = round_down(offset, sectorsize);
-	u64 alloc_end = round_up(offset + len, sectorsize);
+	const u64 blocksize = fs_info->blocksize;
+	u64 alloc_start = round_down(offset, blocksize);
+	u64 alloc_end = round_up(offset + len, blocksize);
 	u64 bytes_to_reserve = 0;
 	bool space_reserved = false;
 
@@ -2805,7 +2805,7 @@ static int btrfs_zero_range(struct inode *inode,
 		 * only on the remaining part of the range.
 		 */
 		alloc_start = em_end;
-		ASSERT(IS_ALIGNED(alloc_start, sectorsize));
+		ASSERT(IS_ALIGNED(alloc_start, blocksize));
 		len = offset + len - alloc_start;
 		offset = alloc_start;
 		alloc_hint = extent_map_block_start(em) + em->len;
@@ -2814,7 +2814,7 @@ static int btrfs_zero_range(struct inode *inode,
 
 	if (BTRFS_BYTES_TO_BLKS(fs_info, offset) ==
 	    BTRFS_BYTES_TO_BLKS(fs_info, offset + len - 1)) {
-		em = btrfs_get_extent(BTRFS_I(inode), NULL, alloc_start, sectorsize);
+		em = btrfs_get_extent(BTRFS_I(inode), NULL, alloc_start, blocksize);
 		if (IS_ERR(em)) {
 			ret = PTR_ERR(em);
 			goto out;
@@ -2826,7 +2826,7 @@ static int btrfs_zero_range(struct inode *inode,
 							   mode);
 			goto out;
 		}
-		if (len < sectorsize && em->disk_bytenr != EXTENT_MAP_HOLE) {
+		if (len < blocksize && em->disk_bytenr != EXTENT_MAP_HOLE) {
 			free_extent_map(em);
 			ret = btrfs_truncate_block(BTRFS_I(inode), offset, len,
 						   0);
@@ -2837,13 +2837,13 @@ static int btrfs_zero_range(struct inode *inode,
 			return ret;
 		}
 		free_extent_map(em);
-		alloc_start = round_down(offset, sectorsize);
-		alloc_end = alloc_start + sectorsize;
+		alloc_start = round_down(offset, blocksize);
+		alloc_end = alloc_start + blocksize;
 		goto reserve_space;
 	}
 
-	alloc_start = round_up(offset, sectorsize);
-	alloc_end = round_down(offset + len, sectorsize);
+	alloc_start = round_up(offset, blocksize);
+	alloc_end = round_down(offset + len, blocksize);
 
 	/*
 	 * For unaligned ranges, check the pages at the boundaries, they might
@@ -2851,13 +2851,13 @@ static int btrfs_zero_range(struct inode *inode,
 	 * they might map to a hole, in which case we need our allocation range
 	 * to cover them.
 	 */
-	if (!IS_ALIGNED(offset, sectorsize)) {
+	if (!IS_ALIGNED(offset, blocksize)) {
 		ret = btrfs_zero_range_check_range_boundary(BTRFS_I(inode),
 							    offset);
 		if (ret < 0)
 			goto out;
 		if (ret == RANGE_BOUNDARY_HOLE) {
-			alloc_start = round_down(offset, sectorsize);
+			alloc_start = round_down(offset, blocksize);
 			ret = 0;
 		} else if (ret == RANGE_BOUNDARY_WRITTEN_EXTENT) {
 			ret = btrfs_truncate_block(BTRFS_I(inode), offset, 0, 0);
@@ -2868,13 +2868,13 @@ static int btrfs_zero_range(struct inode *inode,
 		}
 	}
 
-	if (!IS_ALIGNED(offset + len, sectorsize)) {
+	if (!IS_ALIGNED(offset + len, blocksize)) {
 		ret = btrfs_zero_range_check_range_boundary(BTRFS_I(inode),
 							    offset + len);
 		if (ret < 0)
 			goto out;
 		if (ret == RANGE_BOUNDARY_HOLE) {
-			alloc_end = round_up(offset + len, sectorsize);
+			alloc_end = round_up(offset + len, blocksize);
 			ret = 0;
 		} else if (ret == RANGE_BOUNDARY_WRITTEN_EXTENT) {
 			ret = btrfs_truncate_block(BTRFS_I(inode), offset + len,
@@ -2909,7 +2909,7 @@ static int btrfs_zero_range(struct inode *inode,
 		}
 		ret = btrfs_prealloc_file_range(inode, mode, alloc_start,
 						alloc_end - alloc_start,
-						fs_info->sectorsize,
+						fs_info->blocksize,
 						offset + len, &alloc_hint);
 		unlock_extent(&BTRFS_I(inode)->io_tree, lockstart, lockend,
 			      &cached_state);
@@ -2949,7 +2949,7 @@ static long btrfs_fallocate(struct file *file, int mode,
 	u64 data_space_reserved = 0;
 	u64 qgroup_reserved = 0;
 	struct extent_map *em;
-	int blocksize = BTRFS_I(inode)->root->fs_info->sectorsize;
+	int blocksize = BTRFS_I(inode)->root->fs_info->blocksize;
 	int ret;
 
 	/* Do not allow fallocate in ZONED mode */
@@ -3158,7 +3158,7 @@ static bool find_delalloc_subrange(struct btrfs_inode *inode, u64 start, u64 end
 
 	if (delalloc_len > 0) {
 		/*
-		 * If delalloc was found then *delalloc_start_ret has a sector size
+		 * If delalloc was found then *delalloc_start_ret has a block size
 		 * aligned value (rounded down).
 		 */
 		*delalloc_end_ret = *delalloc_start_ret + delalloc_len - 1;
@@ -3235,13 +3235,13 @@ static bool find_delalloc_subrange(struct btrfs_inode *inode, u64 start, u64 end
  *
  * @inode:               The inode.
  * @start:               The start offset of the range. It does not need to be
- *                       sector size aligned.
+ *                       block size aligned.
  * @end:                 The end offset (inclusive value) of the search range.
- *                       It does not need to be sector size aligned.
+ *                       It does not need to be block size aligned.
  * @cached_state:        Extent state record used for speeding up delalloc
  *                       searches in the inode's io_tree. Can be NULL.
  * @delalloc_start_ret:  Output argument, set to the start offset of the
- *                       subrange found with delalloc (may not be sector size
+ *                       subrange found with delalloc (may not be block size
  *                       aligned).
  * @delalloc_end_ret:    Output argument, set to he end offset (inclusive value)
  *                       of the subrange found with delalloc.
@@ -3254,7 +3254,7 @@ bool btrfs_find_delalloc_in_range(struct btrfs_inode *inode, u64 start, u64 end,
 				  struct extent_state **cached_state,
 				  u64 *delalloc_start_ret, u64 *delalloc_end_ret)
 {
-	u64 cur_offset = round_down(start, inode->root->fs_info->sectorsize);
+	u64 cur_offset = round_down(start, inode->root->fs_info->blocksize);
 	u64 prev_delalloc_end = 0;
 	bool search_io_tree = true;
 	bool ret = false;
@@ -3298,14 +3298,14 @@ bool btrfs_find_delalloc_in_range(struct btrfs_inode *inode, u64 start, u64 end,
  *
  * @inode:      The inode.
  * @whence:     Seek mode (SEEK_DATA or SEEK_HOLE).
- * @start:      Start offset of the hole region. It does not need to be sector
+ * @start:      Start offset of the hole region. It does not need to be block
  *              size aligned.
  * @end:        End offset (inclusive value) of the hole region. It does not
- *              need to be sector size aligned.
+ *              need to be block size aligned.
  * @start_ret:  Return parameter, used to set the start of the subrange in the
  *              hole that matches the search criteria (seek mode), if such
  *              subrange is found (return value of the function is true).
- *              The value returned here may not be sector size aligned.
+ *              The value returned here may not be block size aligned.
  *
  * Returns true if a subrange matching the given seek mode is found, and if one
  * is found, it updates @start_ret with the start of the subrange.
@@ -3442,10 +3442,10 @@ static loff_t find_desired_extent(struct file *file, loff_t offset, int whence)
 	 */
 	start = max_t(loff_t, 0, offset);
 
-	lockstart = round_down(start, fs_info->sectorsize);
-	lockend = round_up(i_size, fs_info->sectorsize);
+	lockstart = round_down(start, fs_info->blocksize);
+	lockend = round_up(i_size, fs_info->blocksize);
 	if (lockend <= lockstart)
-		lockend = lockstart + fs_info->sectorsize;
+		lockend = lockstart + fs_info->blocksize;
 	lockend--;
 
 	path = btrfs_alloc_path();
-- 
2.47.1


