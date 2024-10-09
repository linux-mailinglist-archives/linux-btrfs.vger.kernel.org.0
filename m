Return-Path: <linux-btrfs+bounces-8679-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 92D0B995F42
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Oct 2024 07:51:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2093F1F2118E
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Oct 2024 05:51:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49EBB16F0E8;
	Wed,  9 Oct 2024 05:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="OJUdHdA9";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="OJUdHdA9"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A44F15380B
	for <linux-btrfs@vger.kernel.org>; Wed,  9 Oct 2024 05:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728453101; cv=none; b=Jgcj4KKsfApQYzAv79pkdIte4eib5JkP0fYsS1Muq/7s6bLjGMwj2bImIHmMQ3vmoSvR+dvfup2xSJ2GmTT25cwMJEP/QTUGl0d/3dAZElCye0Q17bBfJoo3z2OXeD2DyGhypcHWsSNYAB68Rbbu8R25ieBPaOQ5Qt1+NYRL6cM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728453101; c=relaxed/simple;
	bh=rXeXctOEBsIjdsPBC9YMtzRgDhIbH83vBpBgPH5j2/w=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r/mGbiSrHLJmnwp/PbvFqFbE6R8byqjyrguxGH9jtluXPXqLOlyShr6Jf4IHzB1aFSzeRknGIiyTEoBgjbY6hpz5zJ7hTcRM414dJ7+GZDuzvYHP6kh8jq2TfqDHJvqmz0+hdkWjujDzJeNdYxic0uriDqOhdnYE4hWTv2K52DQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=OJUdHdA9; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=OJUdHdA9; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A112D1FE57
	for <linux-btrfs@vger.kernel.org>; Wed,  9 Oct 2024 05:51:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1728453096; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oqdb3Gtzd6TuhimZrSlFNpJtOGcXj7eQjEskIaZKKuk=;
	b=OJUdHdA9IB3PU9bPX60GIQb0P5A+6LWTrw8rekubYN4mBNpcOsOmMc49SyY8bAyT9sdF5K
	iJZ8ZIPcl9uMHtBDKWE6d9Hv/z8EpfWP5wNmApPTfPlr6E5yKF3jFqcamWk8FV7qZRhcNL
	QQMEAEXyyDj1y8x3bIra3NImboE5ieo=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1728453096; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oqdb3Gtzd6TuhimZrSlFNpJtOGcXj7eQjEskIaZKKuk=;
	b=OJUdHdA9IB3PU9bPX60GIQb0P5A+6LWTrw8rekubYN4mBNpcOsOmMc49SyY8bAyT9sdF5K
	iJZ8ZIPcl9uMHtBDKWE6d9Hv/z8EpfWP5wNmApPTfPlr6E5yKF3jFqcamWk8FV7qZRhcNL
	QQMEAEXyyDj1y8x3bIra3NImboE5ieo=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E1D50132BD
	for <linux-btrfs@vger.kernel.org>; Wed,  9 Oct 2024 05:51:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id gFfrKOcZBmcFHgAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Wed, 09 Oct 2024 05:51:35 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2 2/2] btrfs: rename btrfs_folio_(set|start|end)_writer_lock()
Date: Wed,  9 Oct 2024 16:21:07 +1030
Message-ID: <824c171b5a4e95eca9b32d1a04c2e0865cad6599.1728452897.git.wqu@suse.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <cover.1728452897.git.wqu@suse.com>
References: <cover.1728452897.git.wqu@suse.com>
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
	RCPT_COUNT_ONE(0.00)[1];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 

Since there is no user of reader locks, rename the writer locks into a
more generic name, by removing the "_writer" part from the name.

And also rename btrfs_subpage::writer into btrfs_subpage::locked.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/compression.c |  2 +-
 fs/btrfs/extent_io.c   | 14 ++++++-------
 fs/btrfs/subpage.c     | 46 +++++++++++++++++++++---------------------
 fs/btrfs/subpage.h     | 20 ++++++++++--------
 4 files changed, 43 insertions(+), 39 deletions(-)

diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index 74799270eb78..dfa872cf09d5 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -545,7 +545,7 @@ static noinline int add_ra_bio_pages(struct inode *inode,
 		 * subpage::readers and to unlock the page.
 		 */
 		if (fs_info->sectorsize < PAGE_SIZE)
-			btrfs_folio_set_writer_lock(fs_info, folio, cur, add_size);
+			btrfs_folio_set_lock(fs_info, folio, cur, add_size);
 		folio_put(folio);
 		cur += add_size;
 	}
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 06d2b882bf8c..f94def65e83b 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -190,7 +190,7 @@ static void process_one_folio(struct btrfs_fs_info *fs_info,
 		btrfs_folio_clamp_clear_writeback(fs_info, folio, start, len);
 
 	if (folio != locked_folio && (page_ops & PAGE_UNLOCK))
-		btrfs_folio_end_writer_lock(fs_info, folio, start, len);
+		btrfs_folio_end_lock(fs_info, folio, start, len);
 }
 
 static void __process_folios_contig(struct address_space *mapping,
@@ -276,7 +276,7 @@ static noinline int lock_delalloc_folios(struct inode *inode,
 			range_start = max_t(u64, folio_pos(folio), start);
 			range_len = min_t(u64, folio_pos(folio) + folio_size(folio),
 					  end + 1) - range_start;
-			btrfs_folio_set_writer_lock(fs_info, folio, range_start, range_len);
+			btrfs_folio_set_lock(fs_info, folio, range_start, range_len);
 
 			processed_end = range_start + range_len - 1;
 		}
@@ -438,7 +438,7 @@ static void end_folio_read(struct folio *folio, bool uptodate, u64 start, u32 le
 	if (!btrfs_is_subpage(fs_info, folio->mapping))
 		folio_unlock(folio);
 	else
-		btrfs_folio_end_writer_lock(fs_info, folio, start, len);
+		btrfs_folio_end_lock(fs_info, folio, start, len);
 }
 
 /*
@@ -495,7 +495,7 @@ static void begin_folio_read(struct btrfs_fs_info *fs_info, struct folio *folio)
 		return;
 
 	ASSERT(folio_test_private(folio));
-	btrfs_folio_set_writer_lock(fs_info, folio, folio_pos(folio), PAGE_SIZE);
+	btrfs_folio_set_lock(fs_info, folio, folio_pos(folio), PAGE_SIZE);
 }
 
 /*
@@ -1184,7 +1184,7 @@ static noinline_for_stack int writepage_delalloc(struct btrfs_inode *inode,
 	for_each_set_bit(bit, &bio_ctrl->submit_bitmap, fs_info->sectors_per_page) {
 		u64 start = page_start + (bit << fs_info->sectorsize_bits);
 
-		btrfs_folio_set_writer_lock(fs_info, folio, start, fs_info->sectorsize);
+		btrfs_folio_set_lock(fs_info, folio, start, fs_info->sectorsize);
 	}
 
 	/* Lock all (subpage) delalloc ranges inside the folio first. */
@@ -1520,7 +1520,7 @@ static int extent_writepage(struct folio *folio, struct btrfs_bio_ctrl *bio_ctrl
 	 * Only unlock ranges that are submitted. As there can be some async
 	 * submitted ranges inside the folio.
 	 */
-	btrfs_folio_end_writer_lock_bitmap(fs_info, folio, bio_ctrl->submit_bitmap);
+	btrfs_folio_end_lock_bitmap(fs_info, folio, bio_ctrl->submit_bitmap);
 	ASSERT(ret <= 0);
 	return ret;
 }
@@ -2298,7 +2298,7 @@ void extent_write_locked_range(struct inode *inode, const struct folio *locked_f
 						       cur, cur_len, !ret);
 			mapping_set_error(mapping, ret);
 		}
-		btrfs_folio_end_writer_lock(fs_info, folio, cur, cur_len);
+		btrfs_folio_end_lock(fs_info, folio, cur, cur_len);
 		if (ret < 0)
 			found_error = true;
 next_page:
diff --git a/fs/btrfs/subpage.c b/fs/btrfs/subpage.c
index 6c3d54a45956..d4cab3c55742 100644
--- a/fs/btrfs/subpage.c
+++ b/fs/btrfs/subpage.c
@@ -143,7 +143,7 @@ struct btrfs_subpage *btrfs_alloc_subpage(const struct btrfs_fs_info *fs_info,
 	if (type == BTRFS_SUBPAGE_METADATA)
 		atomic_set(&ret->eb_refs, 0);
 	else
-		atomic_set(&ret->writers, 0);
+		atomic_set(&ret->nr_locked, 0);
 	return ret;
 }
 
@@ -237,8 +237,8 @@ static void btrfs_subpage_clamp_range(struct folio *folio, u64 *start, u32 *len)
 			     orig_start + orig_len) - *start;
 }
 
-static bool btrfs_subpage_end_and_test_writer(const struct btrfs_fs_info *fs_info,
-					      struct folio *folio, u64 start, u32 len)
+static bool btrfs_subpage_end_and_test_lock(const struct btrfs_fs_info *fs_info,
+					    struct folio *folio, u64 start, u32 len)
 {
 	struct btrfs_subpage *subpage = folio_get_private(folio);
 	const int start_bit = subpage_calc_start_bit(fs_info, folio, locked, start, len);
@@ -256,9 +256,9 @@ static bool btrfs_subpage_end_and_test_writer(const struct btrfs_fs_info *fs_inf
 	 * extent_clear_unlock_delalloc() for compression path.
 	 *
 	 * This @locked_page is locked by plain lock_page(), thus its
-	 * subpage::writers is 0.  Handle them in a special way.
+	 * subpage::locked is 0.  Handle them in a special way.
 	 */
-	if (atomic_read(&subpage->writers) == 0) {
+	if (atomic_read(&subpage->nr_locked) == 0) {
 		spin_unlock_irqrestore(&subpage->lock, flags);
 		return true;
 	}
@@ -267,8 +267,8 @@ static bool btrfs_subpage_end_and_test_writer(const struct btrfs_fs_info *fs_inf
 		clear_bit(bit, subpage->bitmaps);
 		cleared++;
 	}
-	ASSERT(atomic_read(&subpage->writers) >= cleared);
-	last = atomic_sub_and_test(cleared, &subpage->writers);
+	ASSERT(atomic_read(&subpage->nr_locked) >= cleared);
+	last = atomic_sub_and_test(cleared, &subpage->nr_locked);
 	spin_unlock_irqrestore(&subpage->lock, flags);
 	return last;
 }
@@ -289,8 +289,8 @@ static bool btrfs_subpage_end_and_test_writer(const struct btrfs_fs_info *fs_inf
  *   bitmap, reduce the writer lock number, and unlock the page if that's
  *   the last locked range.
  */
-void btrfs_folio_end_writer_lock(const struct btrfs_fs_info *fs_info,
-				 struct folio *folio, u64 start, u32 len)
+void btrfs_folio_end_lock(const struct btrfs_fs_info *fs_info,
+			  struct folio *folio, u64 start, u32 len)
 {
 	struct btrfs_subpage *subpage = folio_get_private(folio);
 
@@ -303,24 +303,24 @@ void btrfs_folio_end_writer_lock(const struct btrfs_fs_info *fs_info,
 
 	/*
 	 * For subpage case, there are two types of locked page.  With or
-	 * without writers number.
+	 * without locked number.
 	 *
-	 * Since we own the page lock, no one else could touch subpage::writers
+	 * Since we own the page lock, no one else could touch subpage::locked
 	 * and we are safe to do several atomic operations without spinlock.
 	 */
-	if (atomic_read(&subpage->writers) == 0) {
-		/* No writers, locked by plain lock_page(). */
+	if (atomic_read(&subpage->nr_locked) == 0) {
+		/* No subpage lock, locked by plain lock_page(). */
 		folio_unlock(folio);
 		return;
 	}
 
 	btrfs_subpage_clamp_range(folio, &start, &len);
-	if (btrfs_subpage_end_and_test_writer(fs_info, folio, start, len))
+	if (btrfs_subpage_end_and_test_lock(fs_info, folio, start, len))
 		folio_unlock(folio);
 }
 
-void btrfs_folio_end_writer_lock_bitmap(const struct btrfs_fs_info *fs_info,
-					struct folio *folio, unsigned long bitmap)
+void btrfs_folio_end_lock_bitmap(const struct btrfs_fs_info *fs_info,
+				 struct folio *folio, unsigned long bitmap)
 {
 	struct btrfs_subpage *subpage = folio_get_private(folio);
 	const int start_bit = fs_info->sectors_per_page * btrfs_bitmap_nr_locked;
@@ -334,8 +334,8 @@ void btrfs_folio_end_writer_lock_bitmap(const struct btrfs_fs_info *fs_info,
 		return;
 	}
 
-	if (atomic_read(&subpage->writers) == 0) {
-		/* No writers, locked by plain lock_page(). */
+	if (atomic_read(&subpage->nr_locked) == 0) {
+		/* No subpage lock, locked by plain lock_page(). */
 		folio_unlock(folio);
 		return;
 	}
@@ -345,8 +345,8 @@ void btrfs_folio_end_writer_lock_bitmap(const struct btrfs_fs_info *fs_info,
 		if (test_and_clear_bit(bit + start_bit, subpage->bitmaps))
 			cleared++;
 	}
-	ASSERT(atomic_read(&subpage->writers) >= cleared);
-	last = atomic_sub_and_test(cleared, &subpage->writers);
+	ASSERT(atomic_read(&subpage->nr_locked) >= cleared);
+	last = atomic_sub_and_test(cleared, &subpage->nr_locked);
 	spin_unlock_irqrestore(&subpage->lock, flags);
 	if (last)
 		folio_unlock(folio);
@@ -671,8 +671,8 @@ void btrfs_folio_assert_not_dirty(const struct btrfs_fs_info *fs_info,
  * This populates the involved subpage ranges so that subpage helpers can
  * properly unlock them.
  */
-void btrfs_folio_set_writer_lock(const struct btrfs_fs_info *fs_info,
-				 struct folio *folio, u64 start, u32 len)
+void btrfs_folio_set_lock(const struct btrfs_fs_info *fs_info,
+			  struct folio *folio, u64 start, u32 len)
 {
 	struct btrfs_subpage *subpage;
 	unsigned long flags;
@@ -691,7 +691,7 @@ void btrfs_folio_set_writer_lock(const struct btrfs_fs_info *fs_info,
 	/* Target range should not yet be locked. */
 	ASSERT(bitmap_test_range_all_zero(subpage->bitmaps, start_bit, nbits));
 	bitmap_set(subpage->bitmaps, start_bit, nbits);
-	ret = atomic_add_return(nbits, &subpage->writers);
+	ret = atomic_add_return(nbits, &subpage->nr_locked);
 	ASSERT(ret <= fs_info->sectors_per_page);
 	spin_unlock_irqrestore(&subpage->lock, flags);
 }
diff --git a/fs/btrfs/subpage.h b/fs/btrfs/subpage.h
index c150aba9318e..428fa9389fd4 100644
--- a/fs/btrfs/subpage.h
+++ b/fs/btrfs/subpage.h
@@ -54,8 +54,12 @@ struct btrfs_subpage {
 		 */
 		atomic_t eb_refs;
 
-		/* Structures only used by data */
-		atomic_t writers;
+		/*
+		 * Structures only used by data,
+		 *
+		 * How many sectors inside the page is locked.
+		 */
+		atomic_t nr_locked;
 	};
 	unsigned long bitmaps[];
 };
@@ -87,12 +91,12 @@ void btrfs_free_subpage(struct btrfs_subpage *subpage);
 void btrfs_folio_inc_eb_refs(const struct btrfs_fs_info *fs_info, struct folio *folio);
 void btrfs_folio_dec_eb_refs(const struct btrfs_fs_info *fs_info, struct folio *folio);
 
-void btrfs_folio_end_writer_lock(const struct btrfs_fs_info *fs_info,
-				 struct folio *folio, u64 start, u32 len);
-void btrfs_folio_set_writer_lock(const struct btrfs_fs_info *fs_info,
-				 struct folio *folio, u64 start, u32 len);
-void btrfs_folio_end_writer_lock_bitmap(const struct btrfs_fs_info *fs_info,
-					struct folio *folio, unsigned long bitmap);
+void btrfs_folio_end_lock(const struct btrfs_fs_info *fs_info,
+			  struct folio *folio, u64 start, u32 len);
+void btrfs_folio_set_lock(const struct btrfs_fs_info *fs_info,
+			  struct folio *folio, u64 start, u32 len);
+void btrfs_folio_end_lock_bitmap(const struct btrfs_fs_info *fs_info,
+				 struct folio *folio, unsigned long bitmap);
 /*
  * Template for subpage related operations.
  *
-- 
2.46.2


