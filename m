Return-Path: <linux-btrfs+bounces-19730-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BC80CBD071
	for <lists+linux-btrfs@lfdr.de>; Mon, 15 Dec 2025 09:49:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 441483013973
	for <lists+linux-btrfs@lfdr.de>; Mon, 15 Dec 2025 08:49:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4CFC3321D3;
	Mon, 15 Dec 2025 08:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="vDWXTZbr";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="gpAXw873"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C7CF331A71
	for <linux-btrfs@vger.kernel.org>; Mon, 15 Dec 2025 08:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765788549; cv=none; b=cdRxFkiafqLvqHnmmy0N36eFegb4a/Rl+6wugkiNAnjKXbb1qzrTrgjCPDZW4vti/Jy1h6vJrd/o+FyYO8K3AWrGLU/ikBY3V98etY5QjIBFfOlhkUGcidki8bkCMLeVfX+3NWgl5fitHak44i3fUl+IQXFu9VwxYxBUd3KrB6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765788549; c=relaxed/simple;
	bh=bXwWkdsEf/t8HUCvsuk5DpVVwm5aupxfBwjB/P10jIE=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=aBXDG57H5gfM9uliaar8HXElvtGJr2gLvzFRRMUnpDQWh5EdU6ft/K/VmggG4GJ6GcgNnK/B5qgfUCdbpibRAH3KFdKwkdmw9BYpfgTan2saLmccj1H7gGD6HZ1mr75ljxNRnbsPRV/B+uRir8psvrxQloZt3bd+OfHWjmZj2dI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=vDWXTZbr; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=gpAXw873; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 2A64A5BD16
	for <linux-btrfs@vger.kernel.org>; Mon, 15 Dec 2025 08:49:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1765788543; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=h8q04Br37CQ8RWU+8WBegq8yd2vDF1T0fqlL4Xa5qXc=;
	b=vDWXTZbre0hXLsZFBz4c5FSNRzlCY3/gY1LAEdzrxDglvThRiVH6xLMaA2X0/SmYKRwN5F
	534W20CMdwGn4/mxqxi2ASfimumZNG5XQWi0+IxalbE2mJsTUShIpd3MnI7bv2CRjyeGOB
	4aBUqhjA796Om4g4YVEeRklPmZYvjKA=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=gpAXw873
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1765788542; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=h8q04Br37CQ8RWU+8WBegq8yd2vDF1T0fqlL4Xa5qXc=;
	b=gpAXw8731VCBsmTZQXSdYdBKwaEd3XaA/KQxyEDPYIiPZ5MR6g9uHSC3WzIg0gksArxfZ7
	3rRsAqyGo6c/a1eFbu0VIV0ttQ/x6BRqU0D1XYNZTOyImgB6Kmj565SyjrJgsp1gRtGVgQ
	pYBKOvxWA8OiNKVm2cMjIkQLUiADD1M=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 61A083EA63
	for <linux-btrfs@vger.kernel.org>; Mon, 15 Dec 2025 08:49:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id PIXTCH3LP2lVaQAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Mon, 15 Dec 2025 08:49:01 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: refactor the main loop of cow_file_range()
Date: Mon, 15 Dec 2025 19:18:43 +1030
Message-ID: <5ff61d63a33409de2b821562613ebb3ac0da9bae.1765788497.git.wqu@suse.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -3.01
X-Rspamd-Queue-Id: 2A64A5BD16
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-0.994];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_ONE(0.00)[1];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	FROM_EQ_ENVFROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:dkim,suse.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_TRACE(0.00)[suse.com:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Level: 

Currently inside the main loop of cow_file_range(), we do the following
sequence:

- Reserve an extent
- Lock the IO tree range
- Create an IO extent map
- Create an ordered extent

Every step will need extra steps to do cleanup in the following order:

- Drop the newly created extent map
- Unlock extent range and cleanup the involved folios
- Free the reserved extent

However currently the error handling is done inconsistently:

- Extent map drop is handled in a dedicated tag
  Out of the main loop, make it much harder to track.

- The extent unlock and folios cleanup is done separately
  The extent is unlocked through btrfs_unlock_extent(), then
  extent_clear_unlock_delalloc() again in a dedicated tag.
  Meanwhile all other callsites (compression/encoded/nocow) all just
  call extent_clear_unlock_delalloc() to handle unlock and folio clean
  up in one go.

- Reserved extent freeing is handled in a dedicated tag
  Out of the main loop, make it much harder to track.

- Error handling of btrfs_reloc_clone_csums() is relying out-of-loop
  tags
  This is due to the special requirement to finish ordered extents to
  handle the metadata reserved space.

Enhance the error handling and align the behavior by:

- Introduce a dedicated cow_one_range() helper
  Which do the reserve/lock/allocation in the helper.

  And also handle the errors inside the helper.
  No more dedicated tags out of the main loop.

- Use a single extent_clear_unlock_delalloc() to unlock and cleanup
  folios

- Move the btrfs_reloc_clone_csums() error handling into the new helper
  Thankfully it's not that complex compared to other cases.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/inode.c | 247 +++++++++++++++++++++++++++--------------------
 1 file changed, 144 insertions(+), 103 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 28227d43b082..9d35b465c4cd 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -1252,6 +1252,135 @@ u64 btrfs_get_extent_allocation_hint(struct btrfs_inode *inode, u64 start,
 	return alloc_hint;
 }
 
+/*
+ * Handle COW for one range.
+ *
+ * @ins:		The key representing the allocated range.
+ * @file_offset:	The file offset of the COW range
+ * @num_bytes:		The expected length of the COW range
+ *			The actually allocated length can be smaller than it.
+ * @min_alloc_size:	The minimal extent size.
+ * @alloc_hint:		The hint for the extent allocator.
+ * @ret_alloc_size:	The COW range handles by this function.
+ *
+ * Return 0 if everything is fine and update @ret_alloc_size updated.
+ * The range is still locked, and caller should unlock the range after
+ * everything is done or for error handling.
+ *
+ * Return <0 for error and @is updated for where the extra cleanup
+ * should happen. The range [file_offset, file_offset + ret_alloc_size) will
+ * be cleaned up by this function.
+ */
+static int cow_one_range(struct btrfs_inode *inode, struct folio *locked_folio,
+			 struct btrfs_key *ins, struct extent_state **cached,
+			 u64 file_offset, u32 num_bytes, u32 min_alloc_size,
+			 u64 alloc_hint, u32 *ret_alloc_size)
+{
+	struct btrfs_root *root = inode->root;
+	struct btrfs_fs_info *fs_info = root->fs_info;
+	struct btrfs_ordered_extent *ordered;
+	struct btrfs_file_extent file_extent;
+	struct extent_map *em;
+	u32 cur_len = 0;
+	u64 cur_end;
+	int ret;
+
+	ret = btrfs_reserve_extent(root, num_bytes, num_bytes, min_alloc_size,
+				   0, alloc_hint, ins, true, true);
+	if (ret < 0) {
+		*ret_alloc_size = cur_len;
+		return ret;
+	}
+
+	cur_len = ins->offset;
+	cur_end = file_offset + cur_len - 1;
+
+	file_extent.disk_bytenr = ins->objectid;
+	file_extent.disk_num_bytes = ins->offset;
+	file_extent.num_bytes = ins->offset;
+	file_extent.ram_bytes = ins->offset;
+	file_extent.offset = 0;
+	file_extent.compression = BTRFS_COMPRESS_NONE;
+
+	/*
+	 * Locked range will be released either during error clean up (inside
+	 * this function or by the caller for previously successful ranges) or
+	 * after the whole range is finished.
+	 */
+	btrfs_lock_extent(&inode->io_tree, file_offset, cur_end, cached);
+	em = btrfs_create_io_em(inode, file_offset, &file_extent,
+				BTRFS_ORDERED_REGULAR);
+	if (IS_ERR(em)) {
+		ret = PTR_ERR(em);
+		goto free_reserved;
+	}
+	btrfs_free_extent_map(em);
+
+	ordered = btrfs_alloc_ordered_extent(inode, file_offset, &file_extent,
+					     1U << BTRFS_ORDERED_REGULAR);
+	if (IS_ERR(ordered)) {
+		btrfs_drop_extent_map_range(inode, file_offset, cur_end, false);
+		ret = PTR_ERR(ordered);
+		goto free_reserved;
+	}
+
+	if (btrfs_is_data_reloc_root(root)) {
+		ret = btrfs_reloc_clone_csums(ordered);
+
+		/*
+		 * Only drop cache here, and process as normal.
+		 *
+		 * We must not allow extent_clear_unlock_delalloc()
+		 * at free_reserved: label to free meta of this ordered
+		 * extent, as its meta should be freed by
+		 * btrfs_finish_ordered_io().
+		 *
+		 * So we must continue until @start is increased to
+		 * skip current ordered extent.
+		 */
+		if (ret)
+			btrfs_drop_extent_map_range(inode, file_offset,
+						    cur_end, false);
+	}
+	btrfs_put_ordered_extent(ordered);
+	btrfs_dec_block_group_reservations(fs_info, ins->objectid);
+	/*
+	 * Error handling for btrfs_reloc_clone_csums().
+	 *
+	 * Treat the range as finished, thus only clear EXTENT_LOCKED | EXTENT_DELALLOC.
+	 * The accounting will be done by ordered extents.
+	 */
+	if (unlikely(ret < 0)) {
+		btrfs_cleanup_ordered_extents(inode, file_offset, cur_len);
+		extent_clear_unlock_delalloc(inode, file_offset, cur_end, locked_folio, cached,
+					     EXTENT_LOCKED | EXTENT_DELALLOC,
+					     PAGE_UNLOCK | PAGE_START_WRITEBACK |
+					     PAGE_END_WRITEBACK);
+		mapping_set_error(inode->vfs_inode.i_mapping, -EIO);
+	}
+	*ret_alloc_size = cur_len;
+	return ret;
+
+free_reserved:
+	extent_clear_unlock_delalloc(inode, file_offset, cur_end, locked_folio, cached,
+				     EXTENT_LOCKED | EXTENT_DELALLOC |
+				     EXTENT_DELALLOC_NEW |
+				     EXTENT_DEFRAG | EXTENT_DO_ACCOUNTING,
+				     PAGE_UNLOCK | PAGE_START_WRITEBACK |
+				     PAGE_END_WRITEBACK);
+	btrfs_qgroup_free_data(inode, NULL, file_offset, cur_len, NULL);
+	btrfs_dec_block_group_reservations(fs_info, ins->objectid);
+	btrfs_free_reserved_extent(fs_info, ins->objectid, ins->offset, true);
+	mapping_set_error(inode->vfs_inode.i_mapping, -EIO);
+	*ret_alloc_size = cur_len;
+	/*
+	 * We should not return -EAGAIN where it's a special return code for
+	 * zoned to catch btrfs_reserved_extent().
+	 */
+	ASSERT(ret != -EAGAIN);
+	return ret;
+}
+
 /*
  * when extent_io.c finds a delayed allocation range in the file,
  * the call backs end up in this code.  The basic idea is to
@@ -1288,11 +1417,10 @@ static noinline int cow_file_range(struct btrfs_inode *inode,
 	u64 alloc_hint = 0;
 	u64 orig_start = start;
 	u64 num_bytes;
-	u64 cur_alloc_size = 0;
-	u64 min_alloc_size;
-	u64 blocksize = fs_info->sectorsize;
+	u32 min_alloc_size;
+	u32 blocksize = fs_info->sectorsize;
+	u32 cur_alloc_size = 0;
 	struct btrfs_key ins;
-	struct extent_map *em;
 	unsigned clear_bits;
 	unsigned long page_ops;
 	int ret = 0;
@@ -1361,16 +1489,14 @@ static noinline int cow_file_range(struct btrfs_inode *inode,
 		min_alloc_size = fs_info->sectorsize;
 
 	while (num_bytes > 0) {
-		struct btrfs_ordered_extent *ordered;
-		struct btrfs_file_extent file_extent;
+		ret = cow_one_range(inode, locked_folio, &ins, &cached, start,
+				    num_bytes, min_alloc_size, alloc_hint, &cur_alloc_size);
 
-		ret = btrfs_reserve_extent(root, num_bytes, num_bytes,
-					   min_alloc_size, 0, alloc_hint,
-					   &ins, true, true);
 		if (ret == -EAGAIN) {
 			/*
-			 * btrfs_reserve_extent only returns -EAGAIN for zoned
-			 * file systems, which is an indication that there are
+			 * cow_one_range() only returns -EAGAIN for zoned
+			 * file systems (from btrfs_reserve_extent()), which
+			 * is an indication that there are
 			 * no active zones to allocate from at the moment.
 			 *
 			 * If this is the first loop iteration, wait for at
@@ -1399,79 +1525,14 @@ static noinline int cow_file_range(struct btrfs_inode *inode,
 		}
 		if (ret < 0)
 			goto out_unlock;
-		cur_alloc_size = ins.offset;
 
-		file_extent.disk_bytenr = ins.objectid;
-		file_extent.disk_num_bytes = ins.offset;
-		file_extent.num_bytes = ins.offset;
-		file_extent.ram_bytes = ins.offset;
-		file_extent.offset = 0;
-		file_extent.compression = BTRFS_COMPRESS_NONE;
+		/* We should not allocate an extent larger than requested.*/
+		ASSERT(cur_alloc_size <= num_bytes);
 
-		/*
-		 * Locked range will be released either during error clean up or
-		 * after the whole range is finished.
-		 */
-		btrfs_lock_extent(&inode->io_tree, start, start + cur_alloc_size - 1,
-				  &cached);
-
-		em = btrfs_create_io_em(inode, start, &file_extent,
-					BTRFS_ORDERED_REGULAR);
-		if (IS_ERR(em)) {
-			btrfs_unlock_extent(&inode->io_tree, start,
-					    start + cur_alloc_size - 1, &cached);
-			ret = PTR_ERR(em);
-			goto out_reserve;
-		}
-		btrfs_free_extent_map(em);
-
-		ordered = btrfs_alloc_ordered_extent(inode, start, &file_extent,
-						     1U << BTRFS_ORDERED_REGULAR);
-		if (IS_ERR(ordered)) {
-			btrfs_unlock_extent(&inode->io_tree, start,
-					    start + cur_alloc_size - 1, &cached);
-			ret = PTR_ERR(ordered);
-			goto out_drop_extent_cache;
-		}
-
-		if (btrfs_is_data_reloc_root(root)) {
-			ret = btrfs_reloc_clone_csums(ordered);
-
-			/*
-			 * Only drop cache here, and process as normal.
-			 *
-			 * We must not allow extent_clear_unlock_delalloc()
-			 * at out_unlock label to free meta of this ordered
-			 * extent, as its meta should be freed by
-			 * btrfs_finish_ordered_io().
-			 *
-			 * So we must continue until @start is increased to
-			 * skip current ordered extent.
-			 */
-			if (ret)
-				btrfs_drop_extent_map_range(inode, start,
-							    start + cur_alloc_size - 1,
-							    false);
-		}
-		btrfs_put_ordered_extent(ordered);
-
-		btrfs_dec_block_group_reservations(fs_info, ins.objectid);
-
-		if (num_bytes < cur_alloc_size)
-			num_bytes = 0;
-		else
-			num_bytes -= cur_alloc_size;
+		num_bytes -= cur_alloc_size;
 		alloc_hint = ins.objectid + ins.offset;
 		start += cur_alloc_size;
 		cur_alloc_size = 0;
-
-		/*
-		 * btrfs_reloc_clone_csums() error, since start is increased
-		 * extent_clear_unlock_delalloc() at out_unlock label won't
-		 * free metadata of current ordered extent, we're OK to exit.
-		 */
-		if (ret)
-			goto out_unlock;
 	}
 	extent_clear_unlock_delalloc(inode, orig_start, end, locked_folio, &cached,
 				     EXTENT_LOCKED | EXTENT_DELALLOC, page_ops);
@@ -1480,11 +1541,6 @@ static noinline int cow_file_range(struct btrfs_inode *inode,
 		*done_offset = end;
 	return ret;
 
-out_drop_extent_cache:
-	btrfs_drop_extent_map_range(inode, start, start + cur_alloc_size - 1, false);
-out_reserve:
-	btrfs_dec_block_group_reservations(fs_info, ins.objectid);
-	btrfs_free_reserved_extent(fs_info, ins.objectid, ins.offset, true);
 out_unlock:
 	/*
 	 * Now, we have three regions to clean up:
@@ -1521,24 +1577,9 @@ static noinline int cow_file_range(struct btrfs_inode *inode,
 	page_ops = PAGE_UNLOCK | PAGE_START_WRITEBACK | PAGE_END_WRITEBACK;
 
 	/*
-	 * For the range (2). If we reserved an extent for our delalloc range
-	 * (or a subrange) and failed to create the respective ordered extent,
-	 * then it means that when we reserved the extent we decremented the
-	 * extent's size from the data space_info's bytes_may_use counter and
-	 * incremented the space_info's bytes_reserved counter by the same
-	 * amount. We must make sure extent_clear_unlock_delalloc() does not try
-	 * to decrement again the data space_info's bytes_may_use counter,
-	 * therefore we do not pass it the flag EXTENT_CLEAR_DATA_RESV.
-	 */
-	if (cur_alloc_size) {
-		extent_clear_unlock_delalloc(inode, start,
-					     start + cur_alloc_size - 1,
-					     locked_folio, &cached, clear_bits,
-					     page_ops);
-		btrfs_qgroup_free_data(inode, NULL, start, cur_alloc_size, NULL);
-	}
-
-	/*
+	 * For the range (2) the error handling is done by cow_one_range() itself.
+	 * Nothing needs to be done.
+	 *
 	 * For the range (3). We never touched the region. In addition to the
 	 * clear_bits above, we add EXTENT_CLEAR_DATA_RESV to release the data
 	 * space_info's bytes_may_use counter, reserved in
@@ -1553,7 +1594,7 @@ static noinline int cow_file_range(struct btrfs_inode *inode,
 				       end - start - cur_alloc_size + 1, NULL);
 	}
 	btrfs_err(fs_info,
-"%s failed, root=%llu inode=%llu start=%llu len=%llu cur_offset=%llu cur_alloc_size=%llu: %d",
+"%s failed, root=%llu inode=%llu start=%llu len=%llu cur_offset=%llu cur_alloc_size=%u: %d",
 		  __func__, btrfs_root_id(inode->root),
 		  btrfs_ino(inode), orig_start, end + 1 - orig_start,
 		  start, cur_alloc_size, ret);
-- 
2.52.0


