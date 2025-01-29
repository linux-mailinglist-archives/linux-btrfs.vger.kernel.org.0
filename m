Return-Path: <linux-btrfs+bounces-11126-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 358B8A2183D
	for <lists+linux-btrfs@lfdr.de>; Wed, 29 Jan 2025 08:38:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 09DD47A2F6D
	for <lists+linux-btrfs@lfdr.de>; Wed, 29 Jan 2025 07:37:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82FFC19995D;
	Wed, 29 Jan 2025 07:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="DdPwCpGa";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="DdPwCpGa"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 137B419580F
	for <linux-btrfs@vger.kernel.org>; Wed, 29 Jan 2025 07:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738136275; cv=none; b=kwLkhyNEMcWjqslRRINl9H6R0WaXWc2iOPCIMaeuVnK7bcCt6yVR9F2o6GoSOrh17mWm6kJ6xOPOOFTd47ZHrf/F1bOplUku1bNrrCs6YeHFmGGixC/6D/Y5aJKAk3CWneX2eYu/AtJNXiBLMZ3Day+rDMTUsbxydiHkYDbLmwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738136275; c=relaxed/simple;
	bh=xKmCx1/+iuA3PLqj84MaLvWTp7jzQIKLs07NTZN3mFk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h0fDZVaP6vAEY5fVqTHla8rZ8NM0yu7nb+5yxnN2cXIOuuWPBSs/dZ8UWc4wRNa9yV2uXzx+6GbG/iSMLlJYJRgErw/mfW0+BMLAiXOa5RWBV86zXeRWQRsRK7mk1HhhS6H2lx7HHRj5BznBleLr26s5mhmD6zyqEXKhfbxxidI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=DdPwCpGa; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=DdPwCpGa; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 3BC3C1F365
	for <linux-btrfs@vger.kernel.org>; Wed, 29 Jan 2025 07:37:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1738136271; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Q2t2duu8rUlpNdgcU3qAMXUx+cBHpG/ZpMxGyURzRAY=;
	b=DdPwCpGa8P5IJ9yinbzHzmFYVN3gUEDlxPxmsfr1jFHD/xWAagy4h/NrnbRd63eLMa/dZg
	Q2A+yx6wr9dcVSEEy7eSJRILHs574Tu/RtWO4TvttxqXKCAT7S0cbAOCRL+C5K530XjMKM
	hqh+SXW5k7wrkZnOpsBk5YTfkC8BCkA=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=DdPwCpGa
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1738136271; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Q2t2duu8rUlpNdgcU3qAMXUx+cBHpG/ZpMxGyURzRAY=;
	b=DdPwCpGa8P5IJ9yinbzHzmFYVN3gUEDlxPxmsfr1jFHD/xWAagy4h/NrnbRd63eLMa/dZg
	Q2A+yx6wr9dcVSEEy7eSJRILHs574Tu/RtWO4TvttxqXKCAT7S0cbAOCRL+C5K530XjMKM
	hqh+SXW5k7wrkZnOpsBk5YTfkC8BCkA=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6623D137DB
	for <linux-btrfs@vger.kernel.org>; Wed, 29 Jan 2025 07:37:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id eIoDCc7amWdBKgAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Wed, 29 Jan 2025 07:37:50 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 1/8] btrfs: remove btrfs_fs_info::sectors_per_page
Date: Wed, 29 Jan 2025 18:07:16 +1030
Message-ID: <2209f3482225f46fd48d746c34675ed109dbef76.1738127135.git.wqu@suse.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1738127135.git.wqu@suse.com>
References: <cover.1738127135.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 3BC3C1F365
X-Spam-Level: 
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RCPT_COUNT_ONE(0.00)[1];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_NONE(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:dkim,suse.com:mid,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01
X-Spam-Flag: NO

For the future larger folio support, our filemap can have folios with
different sizes, thus we can no longer rely on a fixed blocks_per_page
value.

To prepare for that future, here we do:

- Remove btrfs_fs_info::sectors_per_page

- Introduce a helper, btrfs_blocks_per_folio()
  Which uses the folio size to calculate the number of blocks for each
  folio.

- Migrate the existing btrfs_fs_info::sectors_per_page to use that
  helper
  There are some exceptions:

  * Metadata nodesize < page size support
    In the future, even if we support larger folios, we will only
    allocate a folio that matches our nodesize.
    Thus we won't have a folio covering multiple metadata unless
    nodesize < page size.

  * Existing subpage bitmap dump
    We use a single unsigned long to store the bitmap.
    That means until we change the bitmap dumpping code, our upper limit
    for folio size will only be 256K (4K block size, 64 bit unsigned
    long).

  * btrfs_is_subpage() check
    This will be migrated into a future patch.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/disk-io.c   |   1 -
 fs/btrfs/extent_io.c |  26 ++++++-----
 fs/btrfs/fs.h        |   7 ++-
 fs/btrfs/subpage.c   | 105 ++++++++++++++++++++++++++-----------------
 4 files changed, 85 insertions(+), 54 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index f09db62e61a1..d55e28282809 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -3390,7 +3390,6 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
 	fs_info->nodesize = nodesize;
 	fs_info->sectorsize = sectorsize;
 	fs_info->sectorsize_bits = ilog2(sectorsize);
-	fs_info->sectors_per_page = (PAGE_SIZE >> fs_info->sectorsize_bits);
 	fs_info->csums_per_leaf = BTRFS_MAX_ITEM_SIZE(fs_info) / fs_info->csum_size;
 	fs_info->stripesize = stripesize;
 	fs_info->fs_devices->fs_info = fs_info;
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index ee906f8d8588..1c50d6db454c 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -1107,7 +1107,7 @@ static bool find_next_delalloc_bitmap(struct folio *folio,
 {
 	struct btrfs_fs_info *fs_info = folio_to_fs_info(folio);
 	const u64 folio_start = folio_pos(folio);
-	const unsigned int bitmap_size = fs_info->sectors_per_page;
+	const unsigned int bitmap_size = btrfs_blocks_per_folio(fs_info, folio);
 	unsigned int start_bit;
 	unsigned int first_zero;
 	unsigned int first_set;
@@ -1149,6 +1149,7 @@ static noinline_for_stack int writepage_delalloc(struct btrfs_inode *inode,
 	const bool is_subpage = btrfs_is_subpage(fs_info, folio->mapping);
 	const u64 page_start = folio_pos(folio);
 	const u64 page_end = page_start + folio_size(folio) - 1;
+	const unsigned int blocks_per_folio = btrfs_blocks_per_folio(fs_info, folio);
 	unsigned long delalloc_bitmap = 0;
 	/*
 	 * Save the last found delalloc end. As the delalloc end can go beyond
@@ -1174,13 +1175,13 @@ static noinline_for_stack int writepage_delalloc(struct btrfs_inode *inode,
 
 	/* Save the dirty bitmap as our submission bitmap will be a subset of it. */
 	if (btrfs_is_subpage(fs_info, inode->vfs_inode.i_mapping)) {
-		ASSERT(fs_info->sectors_per_page > 1);
+		ASSERT(blocks_per_folio > 1);
 		btrfs_get_subpage_dirty_bitmap(fs_info, folio, &bio_ctrl->submit_bitmap);
 	} else {
 		bio_ctrl->submit_bitmap = 1;
 	}
 
-	for_each_set_bit(bit, &bio_ctrl->submit_bitmap, fs_info->sectors_per_page) {
+	for_each_set_bit(bit, &bio_ctrl->submit_bitmap, blocks_per_folio) {
 		u64 start = page_start + (bit << fs_info->sectorsize_bits);
 
 		btrfs_folio_set_lock(fs_info, folio, start, fs_info->sectorsize);
@@ -1253,7 +1254,7 @@ static noinline_for_stack int writepage_delalloc(struct btrfs_inode *inode,
 					     btrfs_root_id(inode->root),
 					     btrfs_ino(inode),
 					     folio_pos(folio),
-					     fs_info->sectors_per_page,
+					     blocks_per_folio,
 					     &bio_ctrl->submit_bitmap,
 					     found_start, found_len, ret);
 		} else {
@@ -1298,7 +1299,7 @@ static noinline_for_stack int writepage_delalloc(struct btrfs_inode *inode,
 		unsigned int bitmap_size = min(
 			(last_finished_delalloc_end - page_start) >>
 			fs_info->sectorsize_bits,
-			fs_info->sectors_per_page);
+			blocks_per_folio);
 
 		for_each_set_bit(bit, &bio_ctrl->submit_bitmap, bitmap_size)
 			btrfs_mark_ordered_io_finished(inode, folio,
@@ -1322,7 +1323,7 @@ static noinline_for_stack int writepage_delalloc(struct btrfs_inode *inode,
 	 * If all ranges are submitted asynchronously, we just need to account
 	 * for them here.
 	 */
-	if (bitmap_empty(&bio_ctrl->submit_bitmap, fs_info->sectors_per_page)) {
+	if (bitmap_empty(&bio_ctrl->submit_bitmap, blocks_per_folio)) {
 		wbc->nr_to_write -= delalloc_to_write;
 		return 1;
 	}
@@ -1423,6 +1424,7 @@ static noinline_for_stack int extent_writepage_io(struct btrfs_inode *inode,
 	bool submitted_io = false;
 	bool error = false;
 	const u64 folio_start = folio_pos(folio);
+	const unsigned int blocks_per_folio = btrfs_blocks_per_folio(fs_info, folio);
 	u64 cur;
 	int bit;
 	int ret = 0;
@@ -1441,11 +1443,11 @@ static noinline_for_stack int extent_writepage_io(struct btrfs_inode *inode,
 	for (cur = start; cur < start + len; cur += fs_info->sectorsize)
 		set_bit((cur - folio_start) >> fs_info->sectorsize_bits, &range_bitmap);
 	bitmap_and(&bio_ctrl->submit_bitmap, &bio_ctrl->submit_bitmap, &range_bitmap,
-		   fs_info->sectors_per_page);
+		   blocks_per_folio);
 
 	bio_ctrl->end_io_func = end_bbio_data_write;
 
-	for_each_set_bit(bit, &bio_ctrl->submit_bitmap, fs_info->sectors_per_page) {
+	for_each_set_bit(bit, &bio_ctrl->submit_bitmap, blocks_per_folio) {
 		cur = folio_pos(folio) + (bit << fs_info->sectorsize_bits);
 
 		if (cur >= i_size) {
@@ -1519,6 +1521,7 @@ static int extent_writepage(struct folio *folio, struct btrfs_bio_ctrl *bio_ctrl
 	size_t pg_offset;
 	loff_t i_size = i_size_read(&inode->vfs_inode);
 	unsigned long end_index = i_size >> PAGE_SHIFT;
+	const unsigned int blocks_per_folio = btrfs_blocks_per_folio(fs_info, folio);
 
 	trace_extent_writepage(folio, &inode->vfs_inode, bio_ctrl->wbc);
 
@@ -1559,7 +1562,7 @@ static int extent_writepage(struct folio *folio, struct btrfs_bio_ctrl *bio_ctrl
 "failed to submit blocks, root=%lld inode=%llu folio=%llu submit_bitmap=%*pbl: %d",
 			     btrfs_root_id(inode->root),
 			     btrfs_ino(inode),
-			     folio_pos(folio), fs_info->sectors_per_page,
+			     folio_pos(folio), blocks_per_folio,
 			     &bio_ctrl->submit_bitmap, ret);
 
 	bio_ctrl->wbc->nr_to_write--;
@@ -1839,9 +1842,10 @@ static int submit_eb_subpage(struct folio *folio, struct writeback_control *wbc)
 	u64 folio_start = folio_pos(folio);
 	int bit_start = 0;
 	int sectors_per_node = fs_info->nodesize >> fs_info->sectorsize_bits;
+	const unsigned int blocks_per_folio = btrfs_blocks_per_folio(fs_info, folio);
 
 	/* Lock and write each dirty extent buffers in the range */
-	while (bit_start < fs_info->sectors_per_page) {
+	while (bit_start < blocks_per_folio) {
 		struct btrfs_subpage *subpage = folio_get_private(folio);
 		struct extent_buffer *eb;
 		unsigned long flags;
@@ -1857,7 +1861,7 @@ static int submit_eb_subpage(struct folio *folio, struct writeback_control *wbc)
 			break;
 		}
 		spin_lock_irqsave(&subpage->lock, flags);
-		if (!test_bit(bit_start + btrfs_bitmap_nr_dirty * fs_info->sectors_per_page,
+		if (!test_bit(bit_start + btrfs_bitmap_nr_dirty * blocks_per_folio,
 			      subpage->bitmaps)) {
 			spin_unlock_irqrestore(&subpage->lock, flags);
 			spin_unlock(&folio->mapping->i_private_lock);
diff --git a/fs/btrfs/fs.h b/fs/btrfs/fs.h
index b572d6b9730b..776d1781df6a 100644
--- a/fs/btrfs/fs.h
+++ b/fs/btrfs/fs.h
@@ -709,7 +709,6 @@ struct btrfs_fs_info {
 	 * running.
 	 */
 	refcount_t scrub_workers_refcnt;
-	u32 sectors_per_page;
 	struct workqueue_struct *scrub_workers;
 
 	struct btrfs_discard_ctl discard_ctl;
@@ -981,6 +980,12 @@ static inline u32 count_max_extents(const struct btrfs_fs_info *fs_info, u64 siz
 	return div_u64(size + fs_info->max_extent_size - 1, fs_info->max_extent_size);
 }
 
+static inline unsigned int btrfs_blocks_per_folio(const struct btrfs_fs_info *fs_info,
+						  const struct folio *folio)
+{
+	return folio_size(folio) >> fs_info->sectorsize_bits;
+}
+
 bool btrfs_exclop_start(struct btrfs_fs_info *fs_info,
 			enum btrfs_exclusive_operation type);
 bool btrfs_exclop_start_try_lock(struct btrfs_fs_info *fs_info,
diff --git a/fs/btrfs/subpage.c b/fs/btrfs/subpage.c
index 5d088f7d6184..42a3410b2539 100644
--- a/fs/btrfs/subpage.c
+++ b/fs/btrfs/subpage.c
@@ -93,6 +93,9 @@ int btrfs_attach_subpage(const struct btrfs_fs_info *fs_info,
 {
 	struct btrfs_subpage *subpage;
 
+	/* For metadata we don't support larger folio yet. */
+	ASSERT(!folio_test_large(folio));
+
 	/*
 	 * We have cases like a dummy extent buffer page, which is not mapped
 	 * and doesn't need to be locked.
@@ -134,7 +137,8 @@ struct btrfs_subpage *btrfs_alloc_subpage(const struct btrfs_fs_info *fs_info,
 	ASSERT(fs_info->sectorsize < PAGE_SIZE);
 
 	real_size = struct_size(ret, bitmaps,
-			BITS_TO_LONGS(btrfs_bitmap_nr_max * fs_info->sectors_per_page));
+			BITS_TO_LONGS(btrfs_bitmap_nr_max *
+				      (PAGE_SIZE >> fs_info->sectorsize_bits)));
 	ret = kzalloc(real_size, GFP_NOFS);
 	if (!ret)
 		return ERR_PTR(-ENOMEM);
@@ -211,11 +215,13 @@ static void btrfs_subpage_assert(const struct btrfs_fs_info *fs_info,
 
 #define subpage_calc_start_bit(fs_info, folio, name, start, len)	\
 ({									\
-	unsigned int __start_bit;						\
+	unsigned int __start_bit;					\
+	const unsigned int blocks_per_folio =				\
+			   btrfs_blocks_per_folio(fs_info, folio);	\
 									\
 	btrfs_subpage_assert(fs_info, folio, start, len);		\
 	__start_bit = offset_in_page(start) >> fs_info->sectorsize_bits; \
-	__start_bit += fs_info->sectors_per_page * btrfs_bitmap_nr_##name; \
+	__start_bit += blocks_per_folio * btrfs_bitmap_nr_##name;	\
 	__start_bit;							\
 })
 
@@ -323,7 +329,8 @@ void btrfs_folio_end_lock_bitmap(const struct btrfs_fs_info *fs_info,
 				 struct folio *folio, unsigned long bitmap)
 {
 	struct btrfs_subpage *subpage = folio_get_private(folio);
-	const int start_bit = fs_info->sectors_per_page * btrfs_bitmap_nr_locked;
+	const unsigned int blocks_per_folio = btrfs_blocks_per_folio(fs_info, folio);
+	const int start_bit = blocks_per_folio * btrfs_bitmap_nr_locked;
 	unsigned long flags;
 	bool last = false;
 	int cleared = 0;
@@ -341,7 +348,7 @@ void btrfs_folio_end_lock_bitmap(const struct btrfs_fs_info *fs_info,
 	}
 
 	spin_lock_irqsave(&subpage->lock, flags);
-	for_each_set_bit(bit, &bitmap, fs_info->sectors_per_page) {
+	for_each_set_bit(bit, &bitmap, blocks_per_folio) {
 		if (test_and_clear_bit(bit + start_bit, subpage->bitmaps))
 			cleared++;
 	}
@@ -352,15 +359,27 @@ void btrfs_folio_end_lock_bitmap(const struct btrfs_fs_info *fs_info,
 		folio_unlock(folio);
 }
 
-#define subpage_test_bitmap_all_set(fs_info, subpage, name)		\
+#define subpage_test_bitmap_all_set(fs_info, folio, name)		\
+({									\
+	struct btrfs_subpage *subpage = folio_get_private(folio);	\
+	const unsigned int blocks_per_folio =				\
+				btrfs_blocks_per_folio(fs_info, folio); \
+									\
 	bitmap_test_range_all_set(subpage->bitmaps,			\
-			fs_info->sectors_per_page * btrfs_bitmap_nr_##name, \
-			fs_info->sectors_per_page)
+			blocks_per_folio * btrfs_bitmap_nr_##name,	\
+			blocks_per_folio);				\
+})
 
-#define subpage_test_bitmap_all_zero(fs_info, subpage, name)		\
+#define subpage_test_bitmap_all_zero(fs_info, folio, name)		\
+({									\
+	struct btrfs_subpage *subpage = folio_get_private(folio);	\
+	const unsigned int blocks_per_folio =				\
+				btrfs_blocks_per_folio(fs_info, folio); \
+									\
 	bitmap_test_range_all_zero(subpage->bitmaps,			\
-			fs_info->sectors_per_page * btrfs_bitmap_nr_##name, \
-			fs_info->sectors_per_page)
+			blocks_per_folio * btrfs_bitmap_nr_##name,	\
+			blocks_per_folio);				\
+})
 
 void btrfs_subpage_set_uptodate(const struct btrfs_fs_info *fs_info,
 				struct folio *folio, u64 start, u32 len)
@@ -372,7 +391,7 @@ void btrfs_subpage_set_uptodate(const struct btrfs_fs_info *fs_info,
 
 	spin_lock_irqsave(&subpage->lock, flags);
 	bitmap_set(subpage->bitmaps, start_bit, len >> fs_info->sectorsize_bits);
-	if (subpage_test_bitmap_all_set(fs_info, subpage, uptodate))
+	if (subpage_test_bitmap_all_set(fs_info, folio, uptodate))
 		folio_mark_uptodate(folio);
 	spin_unlock_irqrestore(&subpage->lock, flags);
 }
@@ -426,7 +445,7 @@ bool btrfs_subpage_clear_and_test_dirty(const struct btrfs_fs_info *fs_info,
 
 	spin_lock_irqsave(&subpage->lock, flags);
 	bitmap_clear(subpage->bitmaps, start_bit, len >> fs_info->sectorsize_bits);
-	if (subpage_test_bitmap_all_zero(fs_info, subpage, dirty))
+	if (subpage_test_bitmap_all_zero(fs_info, folio, dirty))
 		last = true;
 	spin_unlock_irqrestore(&subpage->lock, flags);
 	return last;
@@ -467,7 +486,7 @@ void btrfs_subpage_clear_writeback(const struct btrfs_fs_info *fs_info,
 
 	spin_lock_irqsave(&subpage->lock, flags);
 	bitmap_clear(subpage->bitmaps, start_bit, len >> fs_info->sectorsize_bits);
-	if (subpage_test_bitmap_all_zero(fs_info, subpage, writeback)) {
+	if (subpage_test_bitmap_all_zero(fs_info, folio, writeback)) {
 		ASSERT(folio_test_writeback(folio));
 		folio_end_writeback(folio);
 	}
@@ -498,7 +517,7 @@ void btrfs_subpage_clear_ordered(const struct btrfs_fs_info *fs_info,
 
 	spin_lock_irqsave(&subpage->lock, flags);
 	bitmap_clear(subpage->bitmaps, start_bit, len >> fs_info->sectorsize_bits);
-	if (subpage_test_bitmap_all_zero(fs_info, subpage, ordered))
+	if (subpage_test_bitmap_all_zero(fs_info, folio, ordered))
 		folio_clear_ordered(folio);
 	spin_unlock_irqrestore(&subpage->lock, flags);
 }
@@ -513,7 +532,7 @@ void btrfs_subpage_set_checked(const struct btrfs_fs_info *fs_info,
 
 	spin_lock_irqsave(&subpage->lock, flags);
 	bitmap_set(subpage->bitmaps, start_bit, len >> fs_info->sectorsize_bits);
-	if (subpage_test_bitmap_all_set(fs_info, subpage, checked))
+	if (subpage_test_bitmap_all_set(fs_info, folio, checked))
 		folio_set_checked(folio);
 	spin_unlock_irqrestore(&subpage->lock, flags);
 }
@@ -635,26 +654,29 @@ IMPLEMENT_BTRFS_PAGE_OPS(ordered, folio_set_ordered, folio_clear_ordered,
 IMPLEMENT_BTRFS_PAGE_OPS(checked, folio_set_checked, folio_clear_checked,
 			 folio_test_checked);
 
-#define GET_SUBPAGE_BITMAP(subpage, fs_info, name, dst)			\
+#define GET_SUBPAGE_BITMAP(fs_info, folio, name, dst)			\
 {									\
-	const int sectors_per_page = fs_info->sectors_per_page;		\
+	const unsigned int blocks_per_folio =				\
+				btrfs_blocks_per_folio(fs_info, folio);	\
+	const struct btrfs_subpage *subpage = folio_get_private(folio);	\
 									\
-	ASSERT(sectors_per_page < BITS_PER_LONG);			\
+	ASSERT(blocks_per_folio < BITS_PER_LONG);			\
 	*dst = bitmap_read(subpage->bitmaps,				\
-			   sectors_per_page * btrfs_bitmap_nr_##name,	\
-			   sectors_per_page);				\
+			   blocks_per_folio * btrfs_bitmap_nr_##name,	\
+			   blocks_per_folio);				\
 }
 
 #define subpage_dump_bitmap(fs_info, folio, name, start, len)		\
 {									\
-	struct btrfs_subpage *subpage = folio_get_private(folio);	\
 	unsigned long bitmap;						\
+	const unsigned int blocks_per_folio =				\
+				btrfs_blocks_per_folio(fs_info, folio);	\
 									\
-	GET_SUBPAGE_BITMAP(subpage, fs_info, name, &bitmap);		\
+	GET_SUBPAGE_BITMAP(fs_info, folio, name, &bitmap);		\
 	btrfs_warn(fs_info,						\
 	"dumpping bitmap start=%llu len=%u folio=%llu " #name "_bitmap=%*pbl", \
 		   start, len, folio_pos(folio),			\
-		   fs_info->sectors_per_page, &bitmap);			\
+		   blocks_per_folio, &bitmap);				\
 }
 
 /*
@@ -704,6 +726,7 @@ void btrfs_folio_set_lock(const struct btrfs_fs_info *fs_info,
 	unsigned long flags;
 	unsigned int start_bit;
 	unsigned int nbits;
+	const unsigned int blocks_per_folio = btrfs_blocks_per_folio(fs_info, folio);
 	int ret;
 
 	ASSERT(folio_test_locked(folio));
@@ -721,7 +744,7 @@ void btrfs_folio_set_lock(const struct btrfs_fs_info *fs_info,
 	}
 	bitmap_set(subpage->bitmaps, start_bit, nbits);
 	ret = atomic_add_return(nbits, &subpage->nr_locked);
-	ASSERT(ret <= fs_info->sectors_per_page);
+	ASSERT(ret <= blocks_per_folio);
 	spin_unlock_irqrestore(&subpage->lock, flags);
 }
 
@@ -729,7 +752,7 @@ void __cold btrfs_subpage_dump_bitmap(const struct btrfs_fs_info *fs_info,
 				      struct folio *folio, u64 start, u32 len)
 {
 	struct btrfs_subpage *subpage;
-	const u32 sectors_per_page = fs_info->sectors_per_page;
+	const unsigned int blocks_per_folio = btrfs_blocks_per_folio(fs_info, folio);
 	unsigned long uptodate_bitmap;
 	unsigned long dirty_bitmap;
 	unsigned long writeback_bitmap;
@@ -739,28 +762,28 @@ void __cold btrfs_subpage_dump_bitmap(const struct btrfs_fs_info *fs_info,
 	unsigned long flags;
 
 	ASSERT(folio_test_private(folio) && folio_get_private(folio));
-	ASSERT(sectors_per_page > 1);
+	ASSERT(blocks_per_folio > 1);
 	subpage = folio_get_private(folio);
 
 	spin_lock_irqsave(&subpage->lock, flags);
-	GET_SUBPAGE_BITMAP(subpage, fs_info, uptodate, &uptodate_bitmap);
-	GET_SUBPAGE_BITMAP(subpage, fs_info, dirty, &dirty_bitmap);
-	GET_SUBPAGE_BITMAP(subpage, fs_info, writeback, &writeback_bitmap);
-	GET_SUBPAGE_BITMAP(subpage, fs_info, ordered, &ordered_bitmap);
-	GET_SUBPAGE_BITMAP(subpage, fs_info, checked, &checked_bitmap);
-	GET_SUBPAGE_BITMAP(subpage, fs_info, locked, &locked_bitmap);
+	GET_SUBPAGE_BITMAP(fs_info, folio, uptodate, &uptodate_bitmap);
+	GET_SUBPAGE_BITMAP(fs_info, folio, dirty, &dirty_bitmap);
+	GET_SUBPAGE_BITMAP(fs_info, folio, writeback, &writeback_bitmap);
+	GET_SUBPAGE_BITMAP(fs_info, folio, ordered, &ordered_bitmap);
+	GET_SUBPAGE_BITMAP(fs_info, folio, checked, &checked_bitmap);
+	GET_SUBPAGE_BITMAP(fs_info, folio, locked, &locked_bitmap);
 	spin_unlock_irqrestore(&subpage->lock, flags);
 
 	dump_page(folio_page(folio, 0), "btrfs subpage dump");
 	btrfs_warn(fs_info,
 "start=%llu len=%u page=%llu, bitmaps uptodate=%*pbl dirty=%*pbl locked=%*pbl writeback=%*pbl ordered=%*pbl checked=%*pbl",
 		    start, len, folio_pos(folio),
-		    sectors_per_page, &uptodate_bitmap,
-		    sectors_per_page, &dirty_bitmap,
-		    sectors_per_page, &locked_bitmap,
-		    sectors_per_page, &writeback_bitmap,
-		    sectors_per_page, &ordered_bitmap,
-		    sectors_per_page, &checked_bitmap);
+		    blocks_per_folio, &uptodate_bitmap,
+		    blocks_per_folio, &dirty_bitmap,
+		    blocks_per_folio, &locked_bitmap,
+		    blocks_per_folio, &writeback_bitmap,
+		    blocks_per_folio, &ordered_bitmap,
+		    blocks_per_folio, &checked_bitmap);
 }
 
 void btrfs_get_subpage_dirty_bitmap(struct btrfs_fs_info *fs_info,
@@ -771,10 +794,10 @@ void btrfs_get_subpage_dirty_bitmap(struct btrfs_fs_info *fs_info,
 	unsigned long flags;
 
 	ASSERT(folio_test_private(folio) && folio_get_private(folio));
-	ASSERT(fs_info->sectors_per_page > 1);
+	ASSERT(btrfs_blocks_per_folio(fs_info, folio) > 1);
 	subpage = folio_get_private(folio);
 
 	spin_lock_irqsave(&subpage->lock, flags);
-	GET_SUBPAGE_BITMAP(subpage, fs_info, dirty, ret_bitmap);
+	GET_SUBPAGE_BITMAP(fs_info, folio, dirty, ret_bitmap);
 	spin_unlock_irqrestore(&subpage->lock, flags);
 }
-- 
2.48.1


