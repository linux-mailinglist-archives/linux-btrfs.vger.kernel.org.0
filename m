Return-Path: <linux-btrfs+bounces-10529-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E8899F61F0
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Dec 2024 10:42:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2DA601896127
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Dec 2024 09:42:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DA86198832;
	Wed, 18 Dec 2024 09:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="esSO1z5k";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="esSO1z5k"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D401A1922F1
	for <linux-btrfs@vger.kernel.org>; Wed, 18 Dec 2024 09:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734514920; cv=none; b=E+VvBX+WAb7a3OPVBiyzDO2QfjAejhkmpjGPUWwByJ1MV5uPY32w2qc6uJDUAcTRZfGbAQem8aw2EtVGhx4Xgux6bnyXlIlB4AMae3x6TZLSdf8OjuOVTF6RFuAU6DWzAtCyx3qv8QkKYFzpkZlIfNurhnjSBFzrCoHrijM1OYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734514920; c=relaxed/simple;
	bh=v8sskZONzs+YtzI11VByAgxD/BGeVeDTGdlcqdfmDo0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MDUifMepl8xpy7ZmkF6CdrsyEITZG4W1jWyOolQ058kSGmW7YRSXrTmsSR8UZYcIDKkRrwaCRm3PmTKhsbm4FOxsXuyKO+yjHMy0L3ImVi/O1AxEjW0ZeSk3Y1LInbroCFgsRW/b7+CkrXyCwHDD3B56xW47NWFnvj4Bz/sOgNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=esSO1z5k; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=esSO1z5k; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id DFF971F444
	for <linux-btrfs@vger.kernel.org>; Wed, 18 Dec 2024 09:41:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1734514915; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6BLPtNQM6XZDk1qwPXErVmJI70DlJqW8wAOPD8dMGMw=;
	b=esSO1z5kkrRanh6Z3X8Ash7hZ4N/Y8u6mtZGqghlh2sgsoPUZRR/MtGUa4BHJkpNx7G08z
	TBo8tXF+YePb7LKXVXqW/EzIhjhRdghVe/Ac5LlhL8WwtmBG/p4BObivDzisUK2U8W1klh
	BVjvHdIZc2LaRZlsNktxJ5EiQx3pSvk=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1734514915; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6BLPtNQM6XZDk1qwPXErVmJI70DlJqW8wAOPD8dMGMw=;
	b=esSO1z5kkrRanh6Z3X8Ash7hZ4N/Y8u6mtZGqghlh2sgsoPUZRR/MtGUa4BHJkpNx7G08z
	TBo8tXF+YePb7LKXVXqW/EzIhjhRdghVe/Ac5LlhL8WwtmBG/p4BObivDzisUK2U8W1klh
	BVjvHdIZc2LaRZlsNktxJ5EiQx3pSvk=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0D523132EA
	for <linux-btrfs@vger.kernel.org>; Wed, 18 Dec 2024 09:41:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id SFEPL+KYYmdmSwAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Wed, 18 Dec 2024 09:41:54 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 02/18] btrfs: migrate subpage.[ch] to use block size terminology
Date: Wed, 18 Dec 2024 20:11:18 +1030
Message-ID: <d9fb986bf7c705d766c203f58a4339a32fa8d6ea.1734514696.git.wqu@suse.com>
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
X-Spam-Level: 
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email,suse.com:mid];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Score: -2.80
X-Spam-Flag: NO

Straightforward rename from "sector" to "block".

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/subpage.c | 92 +++++++++++++++++++++++-----------------------
 fs/btrfs/subpage.h |  8 ++--
 2 files changed, 50 insertions(+), 50 deletions(-)

diff --git a/fs/btrfs/subpage.c b/fs/btrfs/subpage.c
index 8c68059ac1b0..c37e24c11e21 100644
--- a/fs/btrfs/subpage.c
+++ b/fs/btrfs/subpage.c
@@ -7,7 +7,7 @@
 #include "btrfs_inode.h"
 
 /*
- * Subpage (sectorsize < PAGE_SIZE) support overview:
+ * Subpage (blocksize < PAGE_SIZE) support overview:
  *
  * Limitations:
  *
@@ -51,7 +51,7 @@
  *
  * - Common
  *   Both metadata and data will use a new structure, btrfs_subpage, to
- *   record the status of each sector inside a page.  This provides the extra
+ *   record the status of each block inside a page.  This provides the extra
  *   granularity needed.
  *
  * - Metadata
@@ -67,13 +67,13 @@
 #if PAGE_SIZE > SZ_4K
 bool btrfs_is_subpage(const struct btrfs_fs_info *fs_info, struct address_space *mapping)
 {
-	if (fs_info->sectorsize >= PAGE_SIZE)
+	if (fs_info->blocksize >= PAGE_SIZE)
 		return false;
 
 	/*
 	 * Only data pages (either through DIO or compression) can have no
 	 * mapping. And if page->mapping->host is data inode, it's subpage.
-	 * As we have ruled our sectorsize >= PAGE_SIZE case already.
+	 * As we have ruled our blocksize >= PAGE_SIZE case already.
 	 */
 	if (!mapping || !mapping->host || is_data_inode(BTRFS_I(mapping->host)))
 		return true;
@@ -131,10 +131,10 @@ struct btrfs_subpage *btrfs_alloc_subpage(const struct btrfs_fs_info *fs_info,
 	struct btrfs_subpage *ret;
 	unsigned int real_size;
 
-	ASSERT(fs_info->sectorsize < PAGE_SIZE);
+	ASSERT(fs_info->blocksize < PAGE_SIZE);
 
 	real_size = struct_size(ret, bitmaps,
-			BITS_TO_LONGS(btrfs_bitmap_nr_max * fs_info->sectors_per_page));
+			BITS_TO_LONGS(btrfs_bitmap_nr_max * fs_info->blocks_per_page));
 	ret = kzalloc(real_size, GFP_NOFS);
 	if (!ret)
 		return ERR_PTR(-ENOMEM);
@@ -198,8 +198,8 @@ static void btrfs_subpage_assert(const struct btrfs_fs_info *fs_info,
 
 	/* Basic checks */
 	ASSERT(folio_test_private(folio) && folio_get_private(folio));
-	ASSERT(IS_ALIGNED(start, fs_info->sectorsize) &&
-	       IS_ALIGNED(len, fs_info->sectorsize));
+	ASSERT(IS_ALIGNED(start, fs_info->blocksize) &&
+	       IS_ALIGNED(len, fs_info->blocksize));
 	/*
 	 * The range check only works for mapped page, we can still have
 	 * unmapped page like dummy extent buffer pages.
@@ -214,8 +214,8 @@ static void btrfs_subpage_assert(const struct btrfs_fs_info *fs_info,
 	unsigned int __start_bit;						\
 									\
 	btrfs_subpage_assert(fs_info, folio, start, len);		\
-	__start_bit = offset_in_page(start) >> fs_info->sectorsize_bits; \
-	__start_bit += fs_info->sectors_per_page * btrfs_bitmap_nr_##name; \
+	__start_bit = offset_in_page(start) >> fs_info->blocksize_bits; \
+	__start_bit += fs_info->blocks_per_page * btrfs_bitmap_nr_##name; \
 	__start_bit;							\
 })
 
@@ -242,7 +242,7 @@ static bool btrfs_subpage_end_and_test_lock(const struct btrfs_fs_info *fs_info,
 {
 	struct btrfs_subpage *subpage = folio_get_private(folio);
 	const int start_bit = subpage_calc_start_bit(fs_info, folio, locked, start, len);
-	const int nbits = (len >> fs_info->sectorsize_bits);
+	const int nbits = (len >> fs_info->blocksize_bits);
 	unsigned long flags;
 	unsigned int cleared = 0;
 	int bit = start_bit;
@@ -285,7 +285,7 @@ static bool btrfs_subpage_end_and_test_lock(const struct btrfs_fs_info *fs_info,
  *   We can simple unlock it.
  *
  * - folio locked with subpage range locked.
- *   We go through the locked sectors inside the range and clear their locked
+ *   We go through the locked blocks inside the range and clear their locked
  *   bitmap, reduce the writer lock number, and unlock the page if that's
  *   the last locked range.
  */
@@ -323,7 +323,7 @@ void btrfs_folio_end_lock_bitmap(const struct btrfs_fs_info *fs_info,
 				 struct folio *folio, unsigned long bitmap)
 {
 	struct btrfs_subpage *subpage = folio_get_private(folio);
-	const int start_bit = fs_info->sectors_per_page * btrfs_bitmap_nr_locked;
+	const int start_bit = fs_info->blocks_per_page * btrfs_bitmap_nr_locked;
 	unsigned long flags;
 	bool last = false;
 	int cleared = 0;
@@ -341,7 +341,7 @@ void btrfs_folio_end_lock_bitmap(const struct btrfs_fs_info *fs_info,
 	}
 
 	spin_lock_irqsave(&subpage->lock, flags);
-	for_each_set_bit(bit, &bitmap, fs_info->sectors_per_page) {
+	for_each_set_bit(bit, &bitmap, fs_info->blocks_per_page) {
 		if (test_and_clear_bit(bit + start_bit, subpage->bitmaps))
 			cleared++;
 	}
@@ -354,13 +354,13 @@ void btrfs_folio_end_lock_bitmap(const struct btrfs_fs_info *fs_info,
 
 #define subpage_test_bitmap_all_set(fs_info, subpage, name)		\
 	bitmap_test_range_all_set(subpage->bitmaps,			\
-			fs_info->sectors_per_page * btrfs_bitmap_nr_##name, \
-			fs_info->sectors_per_page)
+			fs_info->blocks_per_page * btrfs_bitmap_nr_##name, \
+			fs_info->blocks_per_page)
 
 #define subpage_test_bitmap_all_zero(fs_info, subpage, name)		\
 	bitmap_test_range_all_zero(subpage->bitmaps,			\
-			fs_info->sectors_per_page * btrfs_bitmap_nr_##name, \
-			fs_info->sectors_per_page)
+			fs_info->blocks_per_page * btrfs_bitmap_nr_##name, \
+			fs_info->blocks_per_page)
 
 void btrfs_subpage_set_uptodate(const struct btrfs_fs_info *fs_info,
 				struct folio *folio, u64 start, u32 len)
@@ -371,7 +371,7 @@ void btrfs_subpage_set_uptodate(const struct btrfs_fs_info *fs_info,
 	unsigned long flags;
 
 	spin_lock_irqsave(&subpage->lock, flags);
-	bitmap_set(subpage->bitmaps, start_bit, len >> fs_info->sectorsize_bits);
+	bitmap_set(subpage->bitmaps, start_bit, len >> fs_info->blocksize_bits);
 	if (subpage_test_bitmap_all_set(fs_info, subpage, uptodate))
 		folio_mark_uptodate(folio);
 	spin_unlock_irqrestore(&subpage->lock, flags);
@@ -386,7 +386,7 @@ void btrfs_subpage_clear_uptodate(const struct btrfs_fs_info *fs_info,
 	unsigned long flags;
 
 	spin_lock_irqsave(&subpage->lock, flags);
-	bitmap_clear(subpage->bitmaps, start_bit, len >> fs_info->sectorsize_bits);
+	bitmap_clear(subpage->bitmaps, start_bit, len >> fs_info->blocksize_bits);
 	folio_clear_uptodate(folio);
 	spin_unlock_irqrestore(&subpage->lock, flags);
 }
@@ -400,7 +400,7 @@ void btrfs_subpage_set_dirty(const struct btrfs_fs_info *fs_info,
 	unsigned long flags;
 
 	spin_lock_irqsave(&subpage->lock, flags);
-	bitmap_set(subpage->bitmaps, start_bit, len >> fs_info->sectorsize_bits);
+	bitmap_set(subpage->bitmaps, start_bit, len >> fs_info->blocksize_bits);
 	spin_unlock_irqrestore(&subpage->lock, flags);
 	folio_mark_dirty(folio);
 }
@@ -425,7 +425,7 @@ bool btrfs_subpage_clear_and_test_dirty(const struct btrfs_fs_info *fs_info,
 	bool last = false;
 
 	spin_lock_irqsave(&subpage->lock, flags);
-	bitmap_clear(subpage->bitmaps, start_bit, len >> fs_info->sectorsize_bits);
+	bitmap_clear(subpage->bitmaps, start_bit, len >> fs_info->blocksize_bits);
 	if (subpage_test_bitmap_all_zero(fs_info, subpage, dirty))
 		last = true;
 	spin_unlock_irqrestore(&subpage->lock, flags);
@@ -451,7 +451,7 @@ void btrfs_subpage_set_writeback(const struct btrfs_fs_info *fs_info,
 	unsigned long flags;
 
 	spin_lock_irqsave(&subpage->lock, flags);
-	bitmap_set(subpage->bitmaps, start_bit, len >> fs_info->sectorsize_bits);
+	bitmap_set(subpage->bitmaps, start_bit, len >> fs_info->blocksize_bits);
 	if (!folio_test_writeback(folio))
 		folio_start_writeback(folio);
 	spin_unlock_irqrestore(&subpage->lock, flags);
@@ -466,7 +466,7 @@ void btrfs_subpage_clear_writeback(const struct btrfs_fs_info *fs_info,
 	unsigned long flags;
 
 	spin_lock_irqsave(&subpage->lock, flags);
-	bitmap_clear(subpage->bitmaps, start_bit, len >> fs_info->sectorsize_bits);
+	bitmap_clear(subpage->bitmaps, start_bit, len >> fs_info->blocksize_bits);
 	if (subpage_test_bitmap_all_zero(fs_info, subpage, writeback)) {
 		ASSERT(folio_test_writeback(folio));
 		folio_end_writeback(folio);
@@ -483,7 +483,7 @@ void btrfs_subpage_set_ordered(const struct btrfs_fs_info *fs_info,
 	unsigned long flags;
 
 	spin_lock_irqsave(&subpage->lock, flags);
-	bitmap_set(subpage->bitmaps, start_bit, len >> fs_info->sectorsize_bits);
+	bitmap_set(subpage->bitmaps, start_bit, len >> fs_info->blocksize_bits);
 	folio_set_ordered(folio);
 	spin_unlock_irqrestore(&subpage->lock, flags);
 }
@@ -497,7 +497,7 @@ void btrfs_subpage_clear_ordered(const struct btrfs_fs_info *fs_info,
 	unsigned long flags;
 
 	spin_lock_irqsave(&subpage->lock, flags);
-	bitmap_clear(subpage->bitmaps, start_bit, len >> fs_info->sectorsize_bits);
+	bitmap_clear(subpage->bitmaps, start_bit, len >> fs_info->blocksize_bits);
 	if (subpage_test_bitmap_all_zero(fs_info, subpage, ordered))
 		folio_clear_ordered(folio);
 	spin_unlock_irqrestore(&subpage->lock, flags);
@@ -512,7 +512,7 @@ void btrfs_subpage_set_checked(const struct btrfs_fs_info *fs_info,
 	unsigned long flags;
 
 	spin_lock_irqsave(&subpage->lock, flags);
-	bitmap_set(subpage->bitmaps, start_bit, len >> fs_info->sectorsize_bits);
+	bitmap_set(subpage->bitmaps, start_bit, len >> fs_info->blocksize_bits);
 	if (subpage_test_bitmap_all_set(fs_info, subpage, checked))
 		folio_set_checked(folio);
 	spin_unlock_irqrestore(&subpage->lock, flags);
@@ -527,7 +527,7 @@ void btrfs_subpage_clear_checked(const struct btrfs_fs_info *fs_info,
 	unsigned long flags;
 
 	spin_lock_irqsave(&subpage->lock, flags);
-	bitmap_clear(subpage->bitmaps, start_bit, len >> fs_info->sectorsize_bits);
+	bitmap_clear(subpage->bitmaps, start_bit, len >> fs_info->blocksize_bits);
 	folio_clear_checked(folio);
 	spin_unlock_irqrestore(&subpage->lock, flags);
 }
@@ -548,7 +548,7 @@ bool btrfs_subpage_test_##name(const struct btrfs_fs_info *fs_info,	\
 									\
 	spin_lock_irqsave(&subpage->lock, flags);			\
 	ret = bitmap_test_range_all_set(subpage->bitmaps, start_bit,	\
-				len >> fs_info->sectorsize_bits);	\
+				len >> fs_info->blocksize_bits);	\
 	spin_unlock_irqrestore(&subpage->lock, flags);			\
 	return ret;							\
 }
@@ -560,8 +560,8 @@ IMPLEMENT_BTRFS_SUBPAGE_TEST_OP(checked);
 
 /*
  * Note that, in selftests (extent-io-tests), we can have empty fs_info passed
- * in.  We only test sectorsize == PAGE_SIZE cases so far, thus we can fall
- * back to regular sectorsize branch.
+ * in.  We only test blocksize == PAGE_SIZE cases so far, thus we can fall
+ * back to regular blocksize branch.
  */
 #define IMPLEMENT_BTRFS_PAGE_OPS(name, folio_set_func,			\
 				 folio_clear_func, folio_test_func)	\
@@ -656,7 +656,7 @@ void btrfs_folio_assert_not_dirty(const struct btrfs_fs_info *fs_info,
 	}
 
 	start_bit = subpage_calc_start_bit(fs_info, folio, dirty, start, len);
-	nbits = len >> fs_info->sectorsize_bits;
+	nbits = len >> fs_info->blocksize_bits;
 	subpage = folio_get_private(folio);
 	ASSERT(subpage);
 	spin_lock_irqsave(&subpage->lock, flags);
@@ -686,31 +686,31 @@ void btrfs_folio_set_lock(const struct btrfs_fs_info *fs_info,
 
 	subpage = folio_get_private(folio);
 	start_bit = subpage_calc_start_bit(fs_info, folio, locked, start, len);
-	nbits = len >> fs_info->sectorsize_bits;
+	nbits = len >> fs_info->blocksize_bits;
 	spin_lock_irqsave(&subpage->lock, flags);
 	/* Target range should not yet be locked. */
 	ASSERT(bitmap_test_range_all_zero(subpage->bitmaps, start_bit, nbits));
 	bitmap_set(subpage->bitmaps, start_bit, nbits);
 	ret = atomic_add_return(nbits, &subpage->nr_locked);
-	ASSERT(ret <= fs_info->sectors_per_page);
+	ASSERT(ret <= fs_info->blocks_per_page);
 	spin_unlock_irqrestore(&subpage->lock, flags);
 }
 
 #define GET_SUBPAGE_BITMAP(subpage, fs_info, name, dst)			\
 {									\
-	const int sectors_per_page = fs_info->sectors_per_page;		\
+	const int blocks_per_page = fs_info->blocks_per_page;		\
 									\
-	ASSERT(sectors_per_page < BITS_PER_LONG);			\
+	ASSERT(blocks_per_page < BITS_PER_LONG);			\
 	*dst = bitmap_read(subpage->bitmaps,				\
-			   sectors_per_page * btrfs_bitmap_nr_##name,	\
-			   sectors_per_page);				\
+			   blocks_per_page * btrfs_bitmap_nr_##name,	\
+			   blocks_per_page);				\
 }
 
 void __cold btrfs_subpage_dump_bitmap(const struct btrfs_fs_info *fs_info,
 				      struct folio *folio, u64 start, u32 len)
 {
 	struct btrfs_subpage *subpage;
-	const u32 sectors_per_page = fs_info->sectors_per_page;
+	const u32 blocks_per_page = fs_info->blocks_per_page;
 	unsigned long uptodate_bitmap;
 	unsigned long dirty_bitmap;
 	unsigned long writeback_bitmap;
@@ -719,7 +719,7 @@ void __cold btrfs_subpage_dump_bitmap(const struct btrfs_fs_info *fs_info,
 	unsigned long flags;
 
 	ASSERT(folio_test_private(folio) && folio_get_private(folio));
-	ASSERT(sectors_per_page > 1);
+	ASSERT(blocks_per_page > 1);
 	subpage = folio_get_private(folio);
 
 	spin_lock_irqsave(&subpage->lock, flags);
@@ -735,11 +735,11 @@ void __cold btrfs_subpage_dump_bitmap(const struct btrfs_fs_info *fs_info,
 	btrfs_warn(fs_info,
 "start=%llu len=%u page=%llu, bitmaps uptodate=%*pbl dirty=%*pbl writeback=%*pbl ordered=%*pbl checked=%*pbl",
 		    start, len, folio_pos(folio),
-		    sectors_per_page, &uptodate_bitmap,
-		    sectors_per_page, &dirty_bitmap,
-		    sectors_per_page, &writeback_bitmap,
-		    sectors_per_page, &ordered_bitmap,
-		    sectors_per_page, &checked_bitmap);
+		    blocks_per_page, &uptodate_bitmap,
+		    blocks_per_page, &dirty_bitmap,
+		    blocks_per_page, &writeback_bitmap,
+		    blocks_per_page, &ordered_bitmap,
+		    blocks_per_page, &checked_bitmap);
 }
 
 void btrfs_get_subpage_dirty_bitmap(struct btrfs_fs_info *fs_info,
@@ -750,7 +750,7 @@ void btrfs_get_subpage_dirty_bitmap(struct btrfs_fs_info *fs_info,
 	unsigned long flags;
 
 	ASSERT(folio_test_private(folio) && folio_get_private(folio));
-	ASSERT(fs_info->sectors_per_page > 1);
+	ASSERT(fs_info->blocks_per_page > 1);
 	subpage = folio_get_private(folio);
 
 	spin_lock_irqsave(&subpage->lock, flags);
diff --git a/fs/btrfs/subpage.h b/fs/btrfs/subpage.h
index 428fa9389fd4..c223cdfa6056 100644
--- a/fs/btrfs/subpage.h
+++ b/fs/btrfs/subpage.h
@@ -23,7 +23,7 @@ struct btrfs_fs_info;
  * |			|		|
  * v			v		v
  * |u|u|u|u|........|u|u|d|d|.......|d|d|o|o|.......|o|o|
- * |< sectors_per_page >|
+ * |<  blocks_per_page >|
  *
  * Unlike regular macro-like enums, here we do not go upper-case names, as
  * these names will be utilized in various macros to define function names.
@@ -39,7 +39,7 @@ enum {
 };
 
 /*
- * Structure to trace status of each sector inside a page, attached to
+ * Structure to trace status of each block inside a page, attached to
  * page::private for both data and metadata inodes.
  */
 struct btrfs_subpage {
@@ -57,7 +57,7 @@ struct btrfs_subpage {
 		/*
 		 * Structures only used by data,
 		 *
-		 * How many sectors inside the page is locked.
+		 * How many blocks inside the page is locked.
 		 */
 		atomic_t nr_locked;
 	};
@@ -83,7 +83,7 @@ int btrfs_attach_subpage(const struct btrfs_fs_info *fs_info,
 			 struct folio *folio, enum btrfs_subpage_type type);
 void btrfs_detach_subpage(const struct btrfs_fs_info *fs_info, struct folio *folio);
 
-/* Allocate additional data where page represents more than one sector */
+/* Allocate additional data where page represents more than one block */
 struct btrfs_subpage *btrfs_alloc_subpage(const struct btrfs_fs_info *fs_info,
 					  enum btrfs_subpage_type type);
 void btrfs_free_subpage(struct btrfs_subpage *subpage);
-- 
2.47.1


