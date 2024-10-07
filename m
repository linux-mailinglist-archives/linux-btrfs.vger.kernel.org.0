Return-Path: <linux-btrfs+bounces-8596-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6B0E99399E
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Oct 2024 23:59:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69111285442
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Oct 2024 21:59:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11C0118CBF0;
	Mon,  7 Oct 2024 21:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="rBng92VH";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="rBng92VH"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E22018C920
	for <linux-btrfs@vger.kernel.org>; Mon,  7 Oct 2024 21:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728338350; cv=none; b=km1C4h04xxBYGLDC+TuF+G3K75nNTSCHFm2mHf8Z9bWTckFsPq72ZMH9Q8qJr1ZpILWGjvo0jBPVRzhBFi1lWHmWBFkyyQ+5ru27YjP4aJzR1BZosxgiaeFEGBNVt8gqhqx6Enf6yXLngw43l7tCf/NqFPf+alMvo1+FYYlfAHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728338350; c=relaxed/simple;
	bh=GVd1eVckixiTZ1BilssEf9p3VOsH25LxoxWeME9KS30=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sYkZPfYI1Q4/K3JQLx8zGlOEz+TpSUrTnkokIaXp8aklHMbi0rKx/SVxu5/y00JTyFQ4oa6/5GRz6TQ95hZhR2WujnRjuXDsgA2QXRhNR8F1qAIRCVtEpTzI88xM1x5WFrF2PVeWshtcXjbNCOMmTWzeGxl+fX2URi09pCpGhAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=rBng92VH; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=rBng92VH; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 1F9C82115C
	for <linux-btrfs@vger.kernel.org>; Mon,  7 Oct 2024 21:59:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1728338346; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=T2S4Cme1WdwpUbWhZrziJJJ/ndQky/NL+xiawd7UQlc=;
	b=rBng92VHX8/G1WnWA8l0OaJGo701F2Ndtdgqky7S97AZ+Om3pkQ86uLTV/xGAmap1V7/4A
	WfFbZzKxCqS6vBAkivtetEfmm2/pZsx68APk3m6Q7uPD52p+R2j/DwRsngRhy6vPGZ7hXk
	96XcKjdQul5lImtzXXGFgwT4OP6kJ+Y=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1728338346; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=T2S4Cme1WdwpUbWhZrziJJJ/ndQky/NL+xiawd7UQlc=;
	b=rBng92VHX8/G1WnWA8l0OaJGo701F2Ndtdgqky7S97AZ+Om3pkQ86uLTV/xGAmap1V7/4A
	WfFbZzKxCqS6vBAkivtetEfmm2/pZsx68APk3m6Q7uPD52p+R2j/DwRsngRhy6vPGZ7hXk
	96XcKjdQul5lImtzXXGFgwT4OP6kJ+Y=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5DCB113786
	for <linux-btrfs@vger.kernel.org>; Mon,  7 Oct 2024 21:59:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id EBC5CKlZBGfsfAAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Mon, 07 Oct 2024 21:59:05 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 2/2] btrfs: rename btrfs_folio_(set|start|end)_writer_lock()
Date: Tue,  8 Oct 2024 08:28:45 +1030
Message-ID: <d5f42da1109269ad9a4a88000e78eb3a66248591.1728338061.git.wqu@suse.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <cover.1728338061.git.wqu@suse.com>
References: <cover.1728338061.git.wqu@suse.com>
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:mid,suse.com:email];
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

Since there is no user of reader locks, rename the writer locks into a
more generic name, by removing the "_writer" part from the name.

And also rename btrfs_subpage::writer into btrfs_subpage::locked.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/compression.c |  2 +-
 fs/btrfs/extent_io.c   | 14 ++++++-------
 fs/btrfs/subpage.c     | 46 +++++++++++++++++++++---------------------
 fs/btrfs/subpage.h     | 14 ++++++-------
 4 files changed, 38 insertions(+), 38 deletions(-)

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
index 04b190bc047f..09c7f41555d8 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -190,7 +190,7 @@ static void process_one_folio(struct btrfs_fs_info *fs_info,
 		btrfs_folio_clamp_clear_writeback(fs_info, folio, start, len);
 
 	if (folio != locked_folio && (page_ops & PAGE_UNLOCK))
-		btrfs_folio_end_writer_lock(fs_info, folio, start, len);
+		btrfs_folio_end_lock(fs_info, folio, start, len);
 }
 
 static void __process_folios_contig(struct address_space *mapping,
@@ -274,7 +274,7 @@ static noinline int lock_delalloc_folios(struct inode *inode,
 				folio_unlock(folio);
 				goto out;
 			}
-			btrfs_folio_set_writer_lock(fs_info, folio, range_start, range_len);
+			btrfs_folio_set_lock(fs_info, folio, range_start, range_len);
 
 			processed_end = range_start + range_len - 1;
 		}
@@ -436,7 +436,7 @@ static void end_folio_read(struct folio *folio, bool uptodate, u64 start, u32 le
 	if (!btrfs_is_subpage(fs_info, folio->mapping))
 		folio_unlock(folio);
 	else
-		btrfs_folio_end_writer_lock(fs_info, folio, start, len);
+		btrfs_folio_end_lock(fs_info, folio, start, len);
 }
 
 /*
@@ -493,7 +493,7 @@ static void begin_folio_read(struct btrfs_fs_info *fs_info, struct folio *folio)
 		return;
 
 	ASSERT(folio_test_private(folio));
-	btrfs_folio_set_writer_lock(fs_info, folio, folio_pos(folio), PAGE_SIZE);
+	btrfs_folio_set_lock(fs_info, folio, folio_pos(folio), PAGE_SIZE);
 }
 
 /*
@@ -1175,7 +1175,7 @@ static noinline_for_stack int writepage_delalloc(struct btrfs_inode *inode,
 	for_each_set_bit(bit, &bio_ctrl->submit_bitmap, fs_info->sectors_per_page) {
 		u64 start = page_start + (bit << fs_info->sectorsize_bits);
 
-		btrfs_folio_set_writer_lock(fs_info, folio, start, fs_info->sectorsize);
+		btrfs_folio_set_lock(fs_info, folio, start, fs_info->sectorsize);
 	}
 
 	/* Lock all (subpage) delalloc ranges inside the folio first. */
@@ -1511,7 +1511,7 @@ static int extent_writepage(struct folio *folio, struct btrfs_bio_ctrl *bio_ctrl
 	 * Only unlock ranges that are submitted. As there can be some async
 	 * submitted ranges inside the folio.
 	 */
-	btrfs_folio_end_writer_lock_bitmap(fs_info, folio, bio_ctrl->submit_bitmap);
+	btrfs_folio_end_lock_bitmap(fs_info, folio, bio_ctrl->submit_bitmap);
 	ASSERT(ret <= 0);
 	return ret;
 }
@@ -2289,7 +2289,7 @@ void extent_write_locked_range(struct inode *inode, const struct folio *locked_f
 						       cur, cur_len, !ret);
 			mapping_set_error(mapping, ret);
 		}
-		btrfs_folio_end_writer_lock(fs_info, folio, cur, cur_len);
+		btrfs_folio_end_lock(fs_info, folio, cur, cur_len);
 		if (ret < 0)
 			found_error = true;
 next_page:
diff --git a/fs/btrfs/subpage.c b/fs/btrfs/subpage.c
index ed7f66963c0b..20ed766eaf5e 100644
--- a/fs/btrfs/subpage.c
+++ b/fs/btrfs/subpage.c
@@ -140,7 +140,7 @@ struct btrfs_subpage *btrfs_alloc_subpage(const struct btrfs_fs_info *fs_info,
 		return ERR_PTR(-ENOMEM);
 
 	spin_lock_init(&ret->lock);
-	atomic_set(&ret->writers, 0);
+	atomic_set(&ret->locked, 0);
 	if (type == BTRFS_SUBPAGE_METADATA)
 		atomic_set(&ret->eb_refs, 0);
 	return ret;
@@ -255,8 +255,8 @@ static void btrfs_subpage_clamp_range(struct folio *folio, u64 *start, u32 *len)
 			     orig_start + orig_len) - *start;
 }
 
-static bool btrfs_subpage_end_and_test_writer(const struct btrfs_fs_info *fs_info,
-					      struct folio *folio, u64 start, u32 len)
+static bool btrfs_subpage_end_and_test_lock(const struct btrfs_fs_info *fs_info,
+					    struct folio *folio, u64 start, u32 len)
 {
 	struct btrfs_subpage *subpage = folio_get_private(folio);
 	const int start_bit = subpage_calc_start_bit(fs_info, folio, locked, start, len);
@@ -274,9 +274,9 @@ static bool btrfs_subpage_end_and_test_writer(const struct btrfs_fs_info *fs_inf
 	 * extent_clear_unlock_delalloc() for compression path.
 	 *
 	 * This @locked_page is locked by plain lock_page(), thus its
-	 * subpage::writers is 0.  Handle them in a special way.
+	 * subpage::locked is 0.  Handle them in a special way.
 	 */
-	if (atomic_read(&subpage->writers) == 0) {
+	if (atomic_read(&subpage->locked) == 0) {
 		spin_unlock_irqrestore(&subpage->lock, flags);
 		return true;
 	}
@@ -285,8 +285,8 @@ static bool btrfs_subpage_end_and_test_writer(const struct btrfs_fs_info *fs_inf
 		clear_bit(bit, subpage->bitmaps);
 		cleared++;
 	}
-	ASSERT(atomic_read(&subpage->writers) >= cleared);
-	last = atomic_sub_and_test(cleared, &subpage->writers);
+	ASSERT(atomic_read(&subpage->locked) >= cleared);
+	last = atomic_sub_and_test(cleared, &subpage->locked);
 	spin_unlock_irqrestore(&subpage->lock, flags);
 	return last;
 }
@@ -307,8 +307,8 @@ static bool btrfs_subpage_end_and_test_writer(const struct btrfs_fs_info *fs_inf
  *   bitmap, reduce the writer lock number, and unlock the page if that's
  *   the last locked range.
  */
-void btrfs_folio_end_writer_lock(const struct btrfs_fs_info *fs_info,
-				 struct folio *folio, u64 start, u32 len)
+void btrfs_folio_end_lock(const struct btrfs_fs_info *fs_info,
+			  struct folio *folio, u64 start, u32 len)
 {
 	struct btrfs_subpage *subpage = folio_get_private(folio);
 
@@ -321,24 +321,24 @@ void btrfs_folio_end_writer_lock(const struct btrfs_fs_info *fs_info,
 
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
+	if (atomic_read(&subpage->locked) == 0) {
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
@@ -352,8 +352,8 @@ void btrfs_folio_end_writer_lock_bitmap(const struct btrfs_fs_info *fs_info,
 		return;
 	}
 
-	if (atomic_read(&subpage->writers) == 0) {
-		/* No writers, locked by plain lock_page(). */
+	if (atomic_read(&subpage->locked) == 0) {
+		/* No subpage lock, locked by plain lock_page(). */
 		folio_unlock(folio);
 		return;
 	}
@@ -363,8 +363,8 @@ void btrfs_folio_end_writer_lock_bitmap(const struct btrfs_fs_info *fs_info,
 		if (test_and_clear_bit(bit + start_bit, subpage->bitmaps))
 			cleared++;
 	}
-	ASSERT(atomic_read(&subpage->writers) >= cleared);
-	last = atomic_sub_and_test(cleared, &subpage->writers);
+	ASSERT(atomic_read(&subpage->locked) >= cleared);
+	last = atomic_sub_and_test(cleared, &subpage->locked);
 	spin_unlock_irqrestore(&subpage->lock, flags);
 	if (last)
 		folio_unlock(folio);
@@ -685,8 +685,8 @@ void btrfs_folio_assert_not_dirty(const struct btrfs_fs_info *fs_info,
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
@@ -705,7 +705,7 @@ void btrfs_folio_set_writer_lock(const struct btrfs_fs_info *fs_info,
 	/* Target range should not yet be locked. */
 	assert_bitmap_range_all_zero(fs_info, folio, start, len);
 	bitmap_set(subpage->bitmaps, start_bit, nbits);
-	ret = atomic_add_return(nbits, &subpage->writers);
+	ret = atomic_add_return(nbits, &subpage->locked);
 	ASSERT(ret <= fs_info->sectors_per_page);
 	spin_unlock_irqrestore(&subpage->lock, flags);
 }
diff --git a/fs/btrfs/subpage.h b/fs/btrfs/subpage.h
index b6337543f7dd..96a405a90827 100644
--- a/fs/btrfs/subpage.h
+++ b/fs/btrfs/subpage.h
@@ -59,7 +59,7 @@ struct btrfs_subpage {
 		 *
 		 * How many sectors inside the page is locked.
 		 */
-		atomic_t writers;
+		atomic_t locked;
 	};
 	unsigned long bitmaps[];
 };
@@ -91,12 +91,12 @@ void btrfs_free_subpage(struct btrfs_subpage *subpage);
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


