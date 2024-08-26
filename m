Return-Path: <linux-btrfs+bounces-7486-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A3C495E92F
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Aug 2024 08:41:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A992D1C20EB0
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Aug 2024 06:41:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02F2980BEC;
	Mon, 26 Aug 2024 06:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="t4VpNRRo";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="t4VpNRRo"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCF2563D
	for <linux-btrfs@vger.kernel.org>; Mon, 26 Aug 2024 06:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724654479; cv=none; b=cpnPwRuiHg4iPqqPqOlu/EUIC9stxd9ua6XqI8J1Sez1RTCKLlOAlnQIu+D/OywNpmF/tzHlnL232rL11PZoqcJ9asRBOdS5KXgGVhMKmLelyOJR5iO7VdxsJ/ajdWsrN8vWk3XPJRzCZBYVcZC8MBay7muaj/6urClsLdwwQ7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724654479; c=relaxed/simple;
	bh=6qCiT3875UAHy+c1xrH3/gXs1Jyo4vD0IB5MC9cv31Q=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=P5RDpbPjT4vcfWfDi1GFgpL6KiRIWoeg1+rig3B94Beey/Kzv/kyN6/Bfl3F3gWsttikJbXJ7NcAP6Jp5+C0RlgOHmz2H2doOamvidLl+ElnD+vYj5Z0CxXaQxrCTQeX9OQfH6/v2VakZRySw48kmMQtuhvgw9qm/lD3Wy/q3R8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=t4VpNRRo; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=t4VpNRRo; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 1EFFC1F83B
	for <linux-btrfs@vger.kernel.org>; Mon, 26 Aug 2024 06:41:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1724654475; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=NgpMLXVll93ACiPduC9YquXS5+nwuF7dPreF5wbExoQ=;
	b=t4VpNRRo07PfGZ2cAcotNyZU5QzVoDCv5/c1xDcOZn6imFI1TbGkFbm9XaIUN5WMHd3WlY
	yTIQcXWe0zWOgnHeph93j7HoMLvSh2ArIyu5xnP/oekgvWXnKI8H11FdsvfaSPQHywe03V
	+H0j6VrCqJrcu8nKNcfaAIZeDO9CC8Q=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1724654475; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=NgpMLXVll93ACiPduC9YquXS5+nwuF7dPreF5wbExoQ=;
	b=t4VpNRRo07PfGZ2cAcotNyZU5QzVoDCv5/c1xDcOZn6imFI1TbGkFbm9XaIUN5WMHd3WlY
	yTIQcXWe0zWOgnHeph93j7HoMLvSh2ArIyu5xnP/oekgvWXnKI8H11FdsvfaSPQHywe03V
	+H0j6VrCqJrcu8nKNcfaAIZeDO9CC8Q=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5DF1913724
	for <linux-btrfs@vger.kernel.org>; Mon, 26 Aug 2024 06:41:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id n+meCIojzGZROQAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Mon, 26 Aug 2024 06:41:14 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: subpage: remove btrfs_fs_info::subpage_info member
Date: Mon, 26 Aug 2024 16:11:11 +0930
Message-ID: <8512554a857739211a80e7f52cc8269c8a9fb791.1724654447.git.wqu@suse.com>
X-Mailer: git-send-email 2.46.0
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
	TO_DN_NONE(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	ARC_NA(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:mid,suse.com:email]
X-Spam-Flag: NO
X-Spam-Level: 

The member btrfs_fs_info::subpage_info is to store the cached bitmap
start position inside the merged bitmap.

However in reality there is only one thing depending on the sectorsize,
bitmap_nr_bits, which records the number of sectors that fit inside a
page.

The sequence of sub-bitmaps have fixed order, thus it's just a quick
multiple to calculate the start position of each sub-bitmaps.

This will slightly increase the text section size due to the extra
needed calculation.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/disk-io.c   | 14 +------
 fs/btrfs/extent_io.c |  9 +++--
 fs/btrfs/fs.h        |  2 +-
 fs/btrfs/subpage.c   | 88 +++++++++++++++-----------------------------
 fs/btrfs/subpage.h   | 43 +++++++---------------
 5 files changed, 50 insertions(+), 106 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index a6f5441e62d1..ac289d927c46 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -1285,7 +1285,6 @@ void btrfs_free_fs_info(struct btrfs_fs_info *fs_info)
 	btrfs_extent_buffer_leak_debug_check(fs_info);
 	kfree(fs_info->super_copy);
 	kfree(fs_info->super_for_commit);
-	kfree(fs_info->subpage_info);
 	kvfree(fs_info);
 }
 
@@ -3322,6 +3321,7 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
 	fs_info->nodesize = nodesize;
 	fs_info->sectorsize = sectorsize;
 	fs_info->sectorsize_bits = ilog2(sectorsize);
+	fs_info->sectors_per_page = PAGE_SIZE >> fs_info->sectorsize_bits;
 	fs_info->csums_per_leaf = BTRFS_MAX_ITEM_SIZE(fs_info) / fs_info->csum_size;
 	fs_info->stripesize = stripesize;
 
@@ -3346,20 +3346,10 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
 	 */
 	fs_info->max_inline = min_t(u64, fs_info->max_inline, fs_info->sectorsize);
 
-	if (sectorsize < PAGE_SIZE) {
-		struct btrfs_subpage_info *subpage_info;
-
+	if (sectorsize < PAGE_SIZE)
 		btrfs_warn(fs_info,
 		"read-write for sector size %u with page size %lu is experimental",
 			   sectorsize, PAGE_SIZE);
-		subpage_info = kzalloc(sizeof(*subpage_info), GFP_KERNEL);
-		if (!subpage_info) {
-			ret = -ENOMEM;
-			goto fail_alloc;
-		}
-		btrfs_init_subpage_info(subpage_info, sectorsize);
-		fs_info->subpage_info = subpage_info;
-	}
 
 	ret = btrfs_init_workqueues(fs_info);
 	if (ret)
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 6083bed89df2..5ab7c5a67ad2 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -1440,9 +1440,9 @@ static noinline_for_stack int __extent_writepage_io(struct btrfs_inode *inode,
 	}
 
 	if (btrfs_is_subpage(fs_info, inode->vfs_inode.i_mapping)) {
-		ASSERT(fs_info->subpage_info);
+		ASSERT(fs_info->sectors_per_page > 1);
 		btrfs_get_subpage_dirty_bitmap(fs_info, folio, &dirty_bitmap);
-		bitmap_size = fs_info->subpage_info->bitmap_nr_bits;
+		bitmap_size = fs_info->sectors_per_page;
 	}
 	for (cur = start; cur < start + len; cur += fs_info->sectorsize)
 		set_bit((cur - folio_start) >> fs_info->sectorsize_bits, &range_bitmap);
@@ -1827,7 +1827,7 @@ static int submit_eb_subpage(struct page *page, struct writeback_control *wbc)
 	int sectors_per_node = fs_info->nodesize >> fs_info->sectorsize_bits;
 
 	/* Lock and write each dirty extent buffers in the range */
-	while (bit_start < fs_info->subpage_info->bitmap_nr_bits) {
+	while (bit_start < fs_info->sectors_per_page) {
 		struct btrfs_subpage *subpage = folio_get_private(folio);
 		struct extent_buffer *eb;
 		unsigned long flags;
@@ -1843,7 +1843,8 @@ static int submit_eb_subpage(struct page *page, struct writeback_control *wbc)
 			break;
 		}
 		spin_lock_irqsave(&subpage->lock, flags);
-		if (!test_bit(bit_start + fs_info->subpage_info->dirty_offset,
+		if (!test_bit(bit_start +
+			      btrfs_bitmap_nr_dirty * fs_info->sectors_per_page,
 			      subpage->bitmaps)) {
 			spin_unlock_irqrestore(&subpage->lock, flags);
 			spin_unlock(&page->mapping->i_private_lock);
diff --git a/fs/btrfs/fs.h b/fs/btrfs/fs.h
index 3d6d4b503220..79f64e383edd 100644
--- a/fs/btrfs/fs.h
+++ b/fs/btrfs/fs.h
@@ -703,8 +703,8 @@ struct btrfs_fs_info {
 	 * running.
 	 */
 	refcount_t scrub_workers_refcnt;
+	u32 sectors_per_page;
 	struct workqueue_struct *scrub_workers;
-	struct btrfs_subpage_info *subpage_info;
 
 	struct btrfs_discard_ctl discard_ctl;
 
diff --git a/fs/btrfs/subpage.c b/fs/btrfs/subpage.c
index eea3b2c6bbc4..94f97ec44476 100644
--- a/fs/btrfs/subpage.c
+++ b/fs/btrfs/subpage.c
@@ -88,37 +88,6 @@ bool btrfs_is_subpage(const struct btrfs_fs_info *fs_info, struct address_space
 }
 #endif
 
-void btrfs_init_subpage_info(struct btrfs_subpage_info *subpage_info, u32 sectorsize)
-{
-	unsigned int cur = 0;
-	unsigned int nr_bits;
-
-	ASSERT(IS_ALIGNED(PAGE_SIZE, sectorsize));
-
-	nr_bits = PAGE_SIZE / sectorsize;
-	subpage_info->bitmap_nr_bits = nr_bits;
-
-	subpage_info->uptodate_offset = cur;
-	cur += nr_bits;
-
-	subpage_info->dirty_offset = cur;
-	cur += nr_bits;
-
-	subpage_info->writeback_offset = cur;
-	cur += nr_bits;
-
-	subpage_info->ordered_offset = cur;
-	cur += nr_bits;
-
-	subpage_info->checked_offset = cur;
-	cur += nr_bits;
-
-	subpage_info->locked_offset = cur;
-	cur += nr_bits;
-
-	subpage_info->total_nr_bits = cur;
-}
-
 int btrfs_attach_subpage(const struct btrfs_fs_info *fs_info,
 			 struct folio *folio, enum btrfs_subpage_type type)
 {
@@ -165,7 +134,7 @@ struct btrfs_subpage *btrfs_alloc_subpage(const struct btrfs_fs_info *fs_info,
 	ASSERT(fs_info->sectorsize < PAGE_SIZE);
 
 	real_size = struct_size(ret, bitmaps,
-			BITS_TO_LONGS(fs_info->subpage_info->total_nr_bits));
+			BITS_TO_LONGS(btrfs_bitmap_nr_max * fs_info->sectors_per_page));
 	ret = kzalloc(real_size, GFP_NOFS);
 	if (!ret)
 		return ERR_PTR(-ENOMEM);
@@ -248,7 +217,7 @@ static void btrfs_subpage_assert(const struct btrfs_fs_info *fs_info,
 									\
 	btrfs_subpage_assert(fs_info, folio, start, len);		\
 	__start_bit = offset_in_page(start) >> fs_info->sectorsize_bits; \
-	__start_bit += fs_info->subpage_info->name##_offset;		\
+	__start_bit += fs_info->sectors_per_page * btrfs_bitmap_nr_##name; \
 	__start_bit;							\
 })
 
@@ -420,13 +389,13 @@ void btrfs_folio_end_writer_lock(const struct btrfs_fs_info *fs_info,
 
 #define subpage_test_bitmap_all_set(fs_info, subpage, name)		\
 	bitmap_test_range_all_set(subpage->bitmaps,			\
-			fs_info->subpage_info->name##_offset,		\
-			fs_info->subpage_info->bitmap_nr_bits)
+			fs_info->sectors_per_page * btrfs_bitmap_nr_##name, \
+			fs_info->sectors_per_page)
 
 #define subpage_test_bitmap_all_zero(fs_info, subpage, name)		\
 	bitmap_test_range_all_zero(subpage->bitmaps,			\
-			fs_info->subpage_info->name##_offset,		\
-			fs_info->subpage_info->bitmap_nr_bits)
+			fs_info->sectors_per_page * btrfs_bitmap_nr_##name, \
+			fs_info->sectors_per_page)
 
 void btrfs_subpage_set_uptodate(const struct btrfs_fs_info *fs_info,
 				struct folio *folio, u64 start, u32 len)
@@ -805,7 +774,7 @@ void btrfs_folio_set_writer_lock(const struct btrfs_fs_info *fs_info,
 	ASSERT(bitmap_test_range_all_zero(subpage->bitmaps, start_bit, nbits));
 	bitmap_set(subpage->bitmaps, start_bit, nbits);
 	ret = atomic_add_return(nbits, &subpage->writers);
-	ASSERT(ret <= fs_info->subpage_info->bitmap_nr_bits);
+	ASSERT(ret <= fs_info->sectors_per_page);
 	spin_unlock_irqrestore(&subpage->lock, flags);
 }
 
@@ -821,14 +790,15 @@ bool btrfs_subpage_find_writer_locked(const struct btrfs_fs_info *fs_info,
 				      struct folio *folio, u64 search_start,
 				      u64 *found_start_ret, u32 *found_len_ret)
 {
-	struct btrfs_subpage_info *subpage_info = fs_info->subpage_info;
 	struct btrfs_subpage *subpage = folio_get_private(folio);
+	const u32 sectors_per_page = fs_info->sectors_per_page;
 	const unsigned int len = PAGE_SIZE - offset_in_page(search_start);
 	const unsigned int start_bit = subpage_calc_start_bit(fs_info, folio,
 						locked, search_start, len);
-	const unsigned int locked_bitmap_start = subpage_info->locked_offset;
+	const unsigned int locked_bitmap_start = sectors_per_page *
+						 btrfs_bitmap_nr_locked;
 	const unsigned int locked_bitmap_end = locked_bitmap_start +
-					       subpage_info->bitmap_nr_bits;
+					       sectors_per_page;
 	unsigned long flags;
 	int first_zero;
 	int first_set;
@@ -901,15 +871,16 @@ void btrfs_folio_end_all_writers(const struct btrfs_fs_info *fs_info, struct fol
 	}
 }
 
-#define GET_SUBPAGE_BITMAP(subpage, subpage_info, name, dst)		\
+#define GET_SUBPAGE_BITMAP(subpage, fs_info, name, dst)			\
 	bitmap_cut(dst, subpage->bitmaps, 0,				\
-		   subpage_info->name##_offset, subpage_info->bitmap_nr_bits)
+		   fs_info->sectors_per_page * btrfs_bitmap_nr_##name,	\
+		   fs_info->sectors_per_page)
 
 void __cold btrfs_subpage_dump_bitmap(const struct btrfs_fs_info *fs_info,
 				      struct folio *folio, u64 start, u32 len)
 {
-	struct btrfs_subpage_info *subpage_info = fs_info->subpage_info;
 	struct btrfs_subpage *subpage;
+	const u32 sectors_per_page = fs_info->sectors_per_page;
 	unsigned long uptodate_bitmap;
 	unsigned long dirty_bitmap;
 	unsigned long writeback_bitmap;
@@ -918,42 +889,41 @@ void __cold btrfs_subpage_dump_bitmap(const struct btrfs_fs_info *fs_info,
 	unsigned long flags;
 
 	ASSERT(folio_test_private(folio) && folio_get_private(folio));
-	ASSERT(subpage_info);
+	ASSERT(sectors_per_page > 1);
 	subpage = folio_get_private(folio);
 
 	spin_lock_irqsave(&subpage->lock, flags);
-	GET_SUBPAGE_BITMAP(subpage, subpage_info, uptodate, &uptodate_bitmap);
-	GET_SUBPAGE_BITMAP(subpage, subpage_info, dirty, &dirty_bitmap);
-	GET_SUBPAGE_BITMAP(subpage, subpage_info, writeback, &writeback_bitmap);
-	GET_SUBPAGE_BITMAP(subpage, subpage_info, ordered, &ordered_bitmap);
-	GET_SUBPAGE_BITMAP(subpage, subpage_info, checked, &checked_bitmap);
-	GET_SUBPAGE_BITMAP(subpage, subpage_info, locked, &checked_bitmap);
+	GET_SUBPAGE_BITMAP(subpage, fs_info, uptodate, &uptodate_bitmap);
+	GET_SUBPAGE_BITMAP(subpage, fs_info, dirty, &dirty_bitmap);
+	GET_SUBPAGE_BITMAP(subpage, fs_info, writeback, &writeback_bitmap);
+	GET_SUBPAGE_BITMAP(subpage, fs_info, ordered, &ordered_bitmap);
+	GET_SUBPAGE_BITMAP(subpage, fs_info, checked, &checked_bitmap);
+	GET_SUBPAGE_BITMAP(subpage, fs_info, locked, &checked_bitmap);
 	spin_unlock_irqrestore(&subpage->lock, flags);
 
 	dump_page(folio_page(folio, 0), "btrfs subpage dump");
 	btrfs_warn(fs_info,
 "start=%llu len=%u page=%llu, bitmaps uptodate=%*pbl dirty=%*pbl writeback=%*pbl ordered=%*pbl checked=%*pbl",
 		    start, len, folio_pos(folio),
-		    subpage_info->bitmap_nr_bits, &uptodate_bitmap,
-		    subpage_info->bitmap_nr_bits, &dirty_bitmap,
-		    subpage_info->bitmap_nr_bits, &writeback_bitmap,
-		    subpage_info->bitmap_nr_bits, &ordered_bitmap,
-		    subpage_info->bitmap_nr_bits, &checked_bitmap);
+		    sectors_per_page, &uptodate_bitmap,
+		    sectors_per_page, &dirty_bitmap,
+		    sectors_per_page, &writeback_bitmap,
+		    sectors_per_page, &ordered_bitmap,
+		    sectors_per_page, &checked_bitmap);
 }
 
 void btrfs_get_subpage_dirty_bitmap(struct btrfs_fs_info *fs_info,
 				    struct folio *folio,
 				    unsigned long *ret_bitmap)
 {
-	struct btrfs_subpage_info *subpage_info = fs_info->subpage_info;
 	struct btrfs_subpage *subpage;
 	unsigned long flags;
 
 	ASSERT(folio_test_private(folio) && folio_get_private(folio));
-	ASSERT(subpage_info);
+	ASSERT(fs_info->sectors_per_page > 1);
 	subpage = folio_get_private(folio);
 
 	spin_lock_irqsave(&subpage->lock, flags);
-	GET_SUBPAGE_BITMAP(subpage, subpage_info, dirty, ret_bitmap);
+	GET_SUBPAGE_BITMAP(subpage, fs_info, dirty, ret_bitmap);
 	spin_unlock_irqrestore(&subpage->lock, flags);
 }
diff --git a/fs/btrfs/subpage.h b/fs/btrfs/subpage.h
index eee55e5a3952..48d62bfb580d 100644
--- a/fs/btrfs/subpage.h
+++ b/fs/btrfs/subpage.h
@@ -19,39 +19,23 @@ struct btrfs_fs_info;
  *
  * This structure records how they are organized in the bitmap:
  *
- * /- uptodate_offset	/- dirty_offset	/- ordered_offset
+ * /- uptodate          /- dirty        /- ordered
  * |			|		|
  * v			v		v
  * |u|u|u|u|........|u|u|d|d|.......|d|d|o|o|.......|o|o|
- * |<- bitmap_nr_bits ->|
- * |<----------------- total_nr_bits ------------------>|
+ * |< sectors_per_page >|
+ *
+ * Unlike regular macro-like enums, here we do not go upper-case names, as
+ * these names will be utilized in various macros to define function names.
  */
-struct btrfs_subpage_info {
-	/* Number of bits for each bitmap */
-	unsigned int bitmap_nr_bits;
-
-	/* Total number of bits for the whole bitmap */
-	unsigned int total_nr_bits;
-
-	/*
-	 * *_offset indicates where the bitmap starts, the length is always
-	 * @bitmap_size, which is calculated from PAGE_SIZE / sectorsize.
-	 */
-	unsigned int uptodate_offset;
-	unsigned int dirty_offset;
-	unsigned int writeback_offset;
-	unsigned int ordered_offset;
-	unsigned int checked_offset;
-
-	/*
-	 * For locked bitmaps, normally it's subpage representation for folio
-	 * Locked flag, but metadata is different:
-	 *
-	 * - Metadata doesn't really lock the folio
-	 *   It's just to prevent page::private get cleared before the last
-	 *   end_page_read().
-	 */
-	unsigned int locked_offset;
+enum {
+	btrfs_bitmap_nr_uptodate = 0,
+	btrfs_bitmap_nr_dirty,
+	btrfs_bitmap_nr_writeback,
+	btrfs_bitmap_nr_ordered,
+	btrfs_bitmap_nr_checked,
+	btrfs_bitmap_nr_locked,
+	btrfs_bitmap_nr_max,
 };
 
 /*
@@ -99,7 +83,6 @@ static inline bool btrfs_is_subpage(const struct btrfs_fs_info *fs_info,
 }
 #endif
 
-void btrfs_init_subpage_info(struct btrfs_subpage_info *subpage_info, u32 sectorsize);
 int btrfs_attach_subpage(const struct btrfs_fs_info *fs_info,
 			 struct folio *folio, enum btrfs_subpage_type type);
 void btrfs_detach_subpage(const struct btrfs_fs_info *fs_info, struct folio *folio);
-- 
2.46.0


