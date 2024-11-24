Return-Path: <linux-btrfs+bounces-9879-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A77E49D7946
	for <lists+linux-btrfs@lfdr.de>; Mon, 25 Nov 2024 00:58:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68ED82832FC
	for <lists+linux-btrfs@lfdr.de>; Sun, 24 Nov 2024 23:58:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DA2218C01D;
	Sun, 24 Nov 2024 23:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="hd4QVVIv";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="hd4QVVIv"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5854D18A92C
	for <linux-btrfs@vger.kernel.org>; Sun, 24 Nov 2024 23:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732492675; cv=none; b=u6DT7eqWuScR/NKdOetDGxIvCCFEhe1JOv8ZgYvVy/Ppc7nrLd1HYlkL4737iOSMlU1fM5Dd+cilq0n+ggOuFUQ3m8kPfaX9FlucpmItG/6fa/2TOnDYzQBKClgLkhG1DI6uv4CjbmPL4wer7vO/KVA0uK/7F0jQEvqc1yR1fFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732492675; c=relaxed/simple;
	bh=WiTGH0kYBFvKnnVlCdEmJHlk3ZPtAbs31gz4b4U80z0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KeXi9mAXi6fC8MI7XWZlUaKJmGZITBf9yMLjFRipqma9xH/AfyyF4ERImxFXQsJkO7K+rkmji2Z942hG+bT006cq58tdBqvZkLWQNyimOGmruVcWVdqgjYUbyZSJLVWoCMDtVUlcSuaTRhP5PJqBdLVhnl2Cvr2Ep6Ni6dx8fIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=hd4QVVIv; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=hd4QVVIv; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 7E51C21189
	for <linux-btrfs@vger.kernel.org>; Sun, 24 Nov 2024 23:57:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1732492671; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BOmScpLJbAqXeUTSqg0hx/vWpPKaMdN9XxaJL/uxoU8=;
	b=hd4QVVIv42fl03QGB7ORSjcyBSy4OMXvSEWcvp6gdu5FKJfTuOpFWY7wdxt1LxcKysskw3
	TVtgiwjPp3F2Ay/fxjmldqE7pKU0gmxjRTnZoS6gM4bDnKsZacL9E6M9A94lt1cwIzGv+Q
	GHWMiRhNLbHHPNubOxti8foNJjs6rME=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1732492671; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BOmScpLJbAqXeUTSqg0hx/vWpPKaMdN9XxaJL/uxoU8=;
	b=hd4QVVIv42fl03QGB7ORSjcyBSy4OMXvSEWcvp6gdu5FKJfTuOpFWY7wdxt1LxcKysskw3
	TVtgiwjPp3F2Ay/fxjmldqE7pKU0gmxjRTnZoS6gM4bDnKsZacL9E6M9A94lt1cwIzGv+Q
	GHWMiRhNLbHHPNubOxti8foNJjs6rME=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9D653132CF
	for <linux-btrfs@vger.kernel.org>; Sun, 24 Nov 2024 23:57:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 6D2cFX69Q2emSQAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Sun, 24 Nov 2024 23:57:50 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2 3/7] btrfs: extract the inner loop of cow_file_range() to enhance the error handling
Date: Mon, 25 Nov 2024 10:27:23 +1030
Message-ID: <5c8ac05f4cebaec53bad10f761d62b69f961e92c.1732492421.git.wqu@suse.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1732492421.git.wqu@suse.com>
References: <cover.1732492421.git.wqu@suse.com>
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
	NEURAL_HAM_SHORT(-0.20)[-0.986];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:email];
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

[PROBLEMS]

Currently cow_file_range() has a very complex error handling, splitting
the handling into 3 different parts (with one extra hidden part)

         |-------(1)----|---(2)---|-------------(3)----------|
         `- orig_start  `- start  `- start + cur_alloc_size  `- end

Range (1) is the one we handled without any error.
Range (2) is the current range we're allocating, has data extent
reserved but failed to insert ordered extent.
Range (3) is the range we have not yet touched.

Furthermore there is a special case for range (1) that if a range is for
data reloc tree, and btrfs_reloc_clone_csums() failed, such range will
be counted as range (1), to avoid metadata space release.

Furthermore there is a very complex handling inside the while() loop.

[ENHANCEMENT]
- Extract the main part of the while() loop into run_one_cow_range()
  Which does the data extent reservation, extent map creation and
  ordered extent creation.

  With its own error handling.

  For the special case of range (1) where btrfs_reloc_clone_csums()
  failed, it will return error but still with ins->offset set, so that
  caller can skip the range for error handling.

- Shrink the error range handling to 2 types
  With the proper error handling inside run_one_cow_range(), if a range
  failed run_one_cow_range(), there will be no ordered extent or extent
  map, thus the old range (2) and range (3) can be merged into one.

- Remove some unnecessary ALIGN()
  The range [start, end] is already aligned to sector boundary.
  Just use ASSERT() to check the alignment.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/inode.c | 337 ++++++++++++++++++++++++-----------------------
 1 file changed, 173 insertions(+), 164 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 25ed18c12a68..f9b1d78eb7ff 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -1293,6 +1293,147 @@ u64 btrfs_get_extent_allocation_hint(struct btrfs_inode *inode, u64 start,
 	return alloc_hint;
 }
 
+/*
+ * Run one cow range, which includes:
+ *
+ * - Reserve the data extent
+ * - Create the io extent map
+ * - Create the ordered extent
+ *
+ * @ins will be updated if the range should be skipped for error handling, no
+ * matter the return value.
+ *
+ * Return 0 if everything is fine.
+ * Return -EAGAIN if btrfs_reserve_extent() failed for zoned fs, caller needs
+ * some extra handling.
+ * Return <0 for other errors.
+ */
+static int run_one_cow_range(struct btrfs_inode *inode,
+			     struct folio *locked_folio,
+			     struct btrfs_key *ins,
+			     u64 start,
+			     u64 end, u64 *alloc_hint, bool keep_locked)
+{
+	struct btrfs_root *root = inode->root;
+	struct btrfs_fs_info *fs_info = root->fs_info;
+	struct btrfs_ordered_extent *ordered;
+	struct btrfs_file_extent file_extent = { 0 };
+	struct extent_state *cached = NULL;
+	struct extent_map *em = NULL;
+	unsigned long page_ops;
+	const u64 len = end + 1 - start;
+	u32 min_alloc_size;
+	int ret;
+
+	ASSERT(IS_ALIGNED(start, fs_info->sectorsize));
+	ASSERT(IS_ALIGNED(end + 1, fs_info->sectorsize));
+
+	ins->offset = 0;
+	ins->objectid = 0;
+
+	/*
+	 * Relocation relies on the relocated extents to have exactly the same
+	 * size as the original extents. Normally writeback for relocation data
+	 * extents follows a NOCOW path because relocation preallocates the
+	 * extents. However, due to an operation such as scrub turning a block
+	 * group to RO mode, it may fallback to COW mode, so we must make sure
+	 * an extent allocated during COW has exactly the requested size and can
+	 * not be split into smaller extents, otherwise relocation breaks and
+	 * fails during the stage where it updates the bytenr of file extent
+	 * items.
+	 */
+	if (btrfs_is_data_reloc_root(root))
+		min_alloc_size = len;
+	else
+		min_alloc_size = fs_info->sectorsize;
+
+	ret = btrfs_reserve_extent(root, len, len, min_alloc_size, 0,
+				   *alloc_hint, ins, 1, 1);
+	if (ret < 0)
+		return ret;
+
+	file_extent.disk_bytenr = ins->objectid;
+	file_extent.disk_num_bytes = ins->offset;
+	file_extent.num_bytes = ins->offset;
+	file_extent.ram_bytes = ins->offset;
+	file_extent.offset = 0;
+	file_extent.compression = BTRFS_COMPRESS_NONE;
+
+	lock_extent(&inode->io_tree, start, start + ins->offset - 1,
+		    &cached);
+
+	em = btrfs_create_io_em(inode, start, &file_extent,
+				BTRFS_ORDERED_REGULAR);
+	if (IS_ERR(em)) {
+		unlock_extent(&inode->io_tree, start,
+			      start + ins->offset - 1, &cached);
+		ret = PTR_ERR(em);
+		goto out_free_reserved;
+	}
+	free_extent_map(em);
+
+	ordered = btrfs_alloc_ordered_extent(inode, start, &file_extent,
+					     1 << BTRFS_ORDERED_REGULAR);
+	if (IS_ERR(ordered)) {
+		unlock_extent(&inode->io_tree, start,
+			      start + ins->offset - 1, &cached);
+		ret = PTR_ERR(ordered);
+		goto out_drop_em;
+	}
+
+	if (btrfs_is_data_reloc_root(root)) {
+		ret = btrfs_reloc_clone_csums(ordered);
+
+		/*
+		 * Only drop cache here, and process as normal.
+		 *
+		 * We must not allow extent_clear_unlock_delalloc()
+		 * at error handling to free meta of this ordered
+		 * extent, as its meta should be freed by
+		 * btrfs_finish_ordered_io().
+		 *
+		 * So we must continue until @start is increased to
+		 * skip current ordered extent.
+		 */
+		if (ret < 0)
+			btrfs_drop_extent_map_range(inode, start,
+						    start + ins->offset - 1,
+						    false);
+	}
+	btrfs_put_ordered_extent(ordered);
+
+	btrfs_dec_block_group_reservations(fs_info, ins->objectid);
+
+	/*
+	 * We're not doing compressed IO, don't unlock the first page
+	 * (which the caller expects to stay locked), don't clear any
+	 * dirty bits and don't set any writeback bits
+	 *
+	 * Do set the Ordered (Private2) bit so we know this page was
+	 * properly setup for writepage.
+	 */
+	page_ops = (keep_locked ? 0 : PAGE_UNLOCK);
+	page_ops |= PAGE_SET_ORDERED;
+
+	extent_clear_unlock_delalloc(inode, start, start + ins->offset - 1,
+				     locked_folio, &cached,
+				     EXTENT_LOCKED | EXTENT_DELALLOC,
+				     page_ops);
+	*alloc_hint = ins->objectid + ins->offset;
+	return ret;
+
+out_drop_em:
+	btrfs_drop_extent_map_range(inode, start, start + ins->offset - 1, false);
+out_free_reserved:
+	btrfs_dec_block_group_reservations(fs_info, ins->objectid);
+	btrfs_free_reserved_extent(fs_info, ins->objectid, ins->offset, 1);
+	/* This is reserved for btrfs_reserve_extent() error. */
+	ASSERT(ret != -EAGAIN);
+	ins->offset = 0;
+	ins->objectid = 0;
+	return ret;
+}
+
 /*
  * when extent_io.c finds a delayed allocation range in the file,
  * the call backs end up in this code.  The basic idea is to
@@ -1328,15 +1469,10 @@ static noinline int cow_file_range(struct btrfs_inode *inode,
 {
 	struct btrfs_root *root = inode->root;
 	struct btrfs_fs_info *fs_info = root->fs_info;
-	struct extent_state *cached = NULL;
+	const u64 num_bytes = end + 1 - start;
 	u64 alloc_hint = 0;
 	u64 orig_start = start;
-	u64 num_bytes;
-	u64 cur_alloc_size = 0;
-	u64 min_alloc_size;
-	u64 blocksize = fs_info->sectorsize;
-	struct btrfs_key ins;
-	struct extent_map *em;
+	u64 cur = start;
 	unsigned clear_bits;
 	unsigned long page_ops;
 	int ret = 0;
@@ -1346,8 +1482,8 @@ static noinline int cow_file_range(struct btrfs_inode *inode,
 		goto out_unlock;
 	}
 
-	num_bytes = ALIGN(end - start + 1, blocksize);
-	num_bytes = max(blocksize,  num_bytes);
+	ASSERT(IS_ALIGNED(start, fs_info->sectorsize));
+	ASSERT(IS_ALIGNED(end + 1, fs_info->sectorsize));
 	ASSERT(num_bytes <= btrfs_super_total_bytes(fs_info->super_copy));
 
 	inode_should_defrag(inode, start, end, num_bytes, SZ_64K);
@@ -1372,29 +1508,16 @@ static noinline int cow_file_range(struct btrfs_inode *inode,
 
 	alloc_hint = btrfs_get_extent_allocation_hint(inode, start, num_bytes);
 
-	/*
-	 * Relocation relies on the relocated extents to have exactly the same
-	 * size as the original extents. Normally writeback for relocation data
-	 * extents follows a NOCOW path because relocation preallocates the
-	 * extents. However, due to an operation such as scrub turning a block
-	 * group to RO mode, it may fallback to COW mode, so we must make sure
-	 * an extent allocated during COW has exactly the requested size and can
-	 * not be split into smaller extents, otherwise relocation breaks and
-	 * fails during the stage where it updates the bytenr of file extent
-	 * items.
-	 */
-	if (btrfs_is_data_reloc_root(root))
-		min_alloc_size = num_bytes;
-	else
-		min_alloc_size = fs_info->sectorsize;
+	while (cur < end) {
+		struct btrfs_key ins = { 0 };
 
-	while (num_bytes > 0) {
-		struct btrfs_ordered_extent *ordered;
-		struct btrfs_file_extent file_extent;
-
-		ret = btrfs_reserve_extent(root, num_bytes, num_bytes,
-					   min_alloc_size, 0, alloc_hint,
-					   &ins, 1, 1);
+		ret = run_one_cow_range(inode, locked_folio, &ins,
+					cur, end, &alloc_hint, keep_locked);
+		/*
+		 * @cur must be advanced before error handling.
+		 * Special handling for possible btrfs_reloc_clone_csums() error.
+		 */
+		cur += ins.offset;
 		if (ret == -EAGAIN) {
 			/*
 			 * btrfs_reserve_extent only returns -EAGAIN for zoned
@@ -1408,145 +1531,51 @@ static noinline int cow_file_range(struct btrfs_inode *inode,
 			 * us, or return -ENOSPC if it can't handle retries.
 			 */
 			ASSERT(btrfs_is_zoned(fs_info));
-			if (start == orig_start) {
+			if (cur == orig_start) {
 				wait_on_bit_io(&inode->root->fs_info->flags,
 					       BTRFS_FS_NEED_ZONE_FINISH,
 					       TASK_UNINTERRUPTIBLE);
 				continue;
 			}
 			if (done_offset) {
-				*done_offset = start - 1;
+				*done_offset = cur - 1;
 				return 0;
 			}
 			ret = -ENOSPC;
 		}
 		if (ret < 0)
 			goto out_unlock;
-		cur_alloc_size = ins.offset;
-
-		file_extent.disk_bytenr = ins.objectid;
-		file_extent.disk_num_bytes = ins.offset;
-		file_extent.num_bytes = ins.offset;
-		file_extent.ram_bytes = ins.offset;
-		file_extent.offset = 0;
-		file_extent.compression = BTRFS_COMPRESS_NONE;
-
-		lock_extent(&inode->io_tree, start, start + cur_alloc_size - 1,
-			    &cached);
-
-		em = btrfs_create_io_em(inode, start, &file_extent,
-					BTRFS_ORDERED_REGULAR);
-		if (IS_ERR(em)) {
-			unlock_extent(&inode->io_tree, start,
-				      start + cur_alloc_size - 1, &cached);
-			ret = PTR_ERR(em);
-			goto out_reserve;
-		}
-		free_extent_map(em);
-
-		ordered = btrfs_alloc_ordered_extent(inode, start, &file_extent,
-						     1 << BTRFS_ORDERED_REGULAR);
-		if (IS_ERR(ordered)) {
-			unlock_extent(&inode->io_tree, start,
-				      start + cur_alloc_size - 1, &cached);
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
-		/*
-		 * We're not doing compressed IO, don't unlock the first page
-		 * (which the caller expects to stay locked), don't clear any
-		 * dirty bits and don't set any writeback bits
-		 *
-		 * Do set the Ordered (Private2) bit so we know this page was
-		 * properly setup for writepage.
-		 */
-		page_ops = (keep_locked ? 0 : PAGE_UNLOCK);
-		page_ops |= PAGE_SET_ORDERED;
-
-		extent_clear_unlock_delalloc(inode, start, start + cur_alloc_size - 1,
-					     locked_folio, &cached,
-					     EXTENT_LOCKED | EXTENT_DELALLOC,
-					     page_ops);
-		if (num_bytes < cur_alloc_size)
-			num_bytes = 0;
-		else
-			num_bytes -= cur_alloc_size;
-		alloc_hint = ins.objectid + ins.offset;
-		start += cur_alloc_size;
-		cur_alloc_size = 0;
-
-		/*
-		 * btrfs_reloc_clone_csums() error, since start is increased
-		 * extent_clear_unlock_delalloc() at out_unlock label won't
-		 * free metadata of current ordered extent, we're OK to exit.
-		 */
-		if (ret)
-			goto out_unlock;
 	}
 done:
 	if (done_offset)
 		*done_offset = end;
 	return ret;
 
-out_drop_extent_cache:
-	btrfs_drop_extent_map_range(inode, start, start + cur_alloc_size - 1, false);
-out_reserve:
-	btrfs_dec_block_group_reservations(fs_info, ins.objectid);
-	btrfs_free_reserved_extent(fs_info, ins.objectid, ins.offset, 1);
 out_unlock:
 	/*
-	 * Now, we have three regions to clean up:
+	 * Now we have two regions to clean up:
 	 *
-	 * |-------(1)----|---(2)---|-------------(3)----------|
-	 * `- orig_start  `- start  `- start + cur_alloc_size  `- end
+	 * |-----(1)-------|----(2)-----|
+	 * `- start        `- cur       `- end
 	 *
-	 * We process each region below.
+	 * @cur is only updated when a successful extent reservation along
+	 * with extent maps/ordered extents created.
 	 */
-
 	clear_bits = EXTENT_LOCKED | EXTENT_DELALLOC | EXTENT_DELALLOC_NEW |
 		EXTENT_DEFRAG | EXTENT_CLEAR_META_RESV;
 	page_ops = PAGE_UNLOCK | PAGE_START_WRITEBACK | PAGE_END_WRITEBACK;
 
 	/*
-	 * For the range (1). We have already instantiated the ordered extents
-	 * for this region. They are cleaned up by
-	 * btrfs_cleanup_ordered_extents() in e.g,
-	 * btrfs_run_delalloc_range(). EXTENT_LOCKED | EXTENT_DELALLOC are
-	 * already cleared in the above loop. And, EXTENT_DELALLOC_NEW |
-	 * EXTENT_DEFRAG | EXTENT_CLEAR_META_RESV are handled by the cleanup
-	 * function.
+	 * For the range (1), we have already instantiated the ordered extents
+	 * for the region. They will be cleaned up by btrfs_cleanup_ordered_extents().
 	 *
-	 * However, in case of @keep_locked, we still need to unlock the pages
-	 * (except @locked_folio) to ensure all the pages are unlocked.
+	 * Here we only need to unlock the pages, which will be done by
+	 * the extent_clear_unlock_delalloc() with PAGE_UNLOCK.
 	 */
-	if (keep_locked && orig_start < start) {
+	if (keep_locked && start < cur) {
 		if (!locked_folio)
 			mapping_set_error(inode->vfs_inode.i_mapping, ret);
-		extent_clear_unlock_delalloc(inode, orig_start, start - 1,
+		extent_clear_unlock_delalloc(inode, orig_start, cur - 1,
 					     locked_folio, NULL, 0, page_ops);
 	}
 
@@ -1555,39 +1584,19 @@ static noinline int cow_file_range(struct btrfs_inode *inode,
 	 * clearing these flags under the extent lock, so lock the rest of the
 	 * range and clear everything up.
 	 */
-	lock_extent(&inode->io_tree, start, end, NULL);
+	lock_extent(&inode->io_tree, cur, end, NULL);
 
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
-	 * For the range (3). We never touched the region. In addition to the
+	 * For the range (2). We never touched the region. In addition to the
 	 * clear_bits above, we add EXTENT_CLEAR_DATA_RESV to release the data
 	 * space_info's bytes_may_use counter, reserved in
 	 * btrfs_check_data_free_space().
 	 */
-	if (start + cur_alloc_size < end) {
+	if (cur < end) {
 		clear_bits |= EXTENT_CLEAR_DATA_RESV;
-		extent_clear_unlock_delalloc(inode, start + cur_alloc_size,
-					     end, locked_folio,
-					     &cached, clear_bits, page_ops);
-		btrfs_qgroup_free_data(inode, NULL, start + cur_alloc_size,
-				       end - start - cur_alloc_size + 1, NULL);
+		extent_clear_unlock_delalloc(inode, cur, end, locked_folio,
+					     NULL, clear_bits, page_ops);
+		btrfs_qgroup_free_data(inode, NULL, cur, end + 1 - cur, NULL);
 	}
 	return ret;
 }
-- 
2.47.0


