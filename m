Return-Path: <linux-btrfs+bounces-11779-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07496A445D4
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Feb 2025 17:19:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 07F6B16D41E
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Feb 2025 16:17:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9FD518F2D8;
	Tue, 25 Feb 2025 16:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="YJ3dQYx/";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="YJ3dQYx/"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 193ED18DB08
	for <linux-btrfs@vger.kernel.org>; Tue, 25 Feb 2025 16:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740500214; cv=none; b=QN7fvwmekhTAhsP/ZrU60aiK3vFh5BG/c9aUNG7sHvBJxKFjGWw1MAhWV3vx9cO2e3Hcd4WDwXr0im5kjV6K9JDKXyD9E9ttZDeQ9dKIo07gBcgVN0QH0E1j8a47ibgwejKcxPa3wSwzl61ltTh7k/Mlc+zHrmwnU0yZX8SQjhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740500214; c=relaxed/simple;
	bh=v/u9oBydXCQ2GVPS4tYZBJjERkPwskhZq7GOIgTGymk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HSuOK7vyRg+N24unm40COu1rvyyCe2elAfALCcrxPrLVhCpw5ngsnevqfytcihuxsgXq49JO+9WGZm0zUigYxswrFHvh4pOpT2n8wSxW2HLSbEMPj/BSpxZeBf2pDNp5WRubT563BUZ841+HetE4gkr3H0MhRexRU260koiHl5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=YJ3dQYx/; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=YJ3dQYx/; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 4DACF2118D;
	Tue, 25 Feb 2025 16:16:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1740500210; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=3EyBaTB+xdUhJYBqnzYqDK4YwEuLXADG6qTZqjxh+u4=;
	b=YJ3dQYx/y+GvjQfACVwDtiTxk9KrVxgw36sHTcjZwynyNV5PrYqnahrsZ90Dxsr/Rxl20x
	E94+dUmfOIgFXuUzW5yZp0PYrAHf+oozS2KaXN77+ToczWrmSUeiVO2kZ68vgAekfiEGcl
	6BsosrW3OihbVc/vYNvl4LHcbz0oXq8=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1740500210; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=3EyBaTB+xdUhJYBqnzYqDK4YwEuLXADG6qTZqjxh+u4=;
	b=YJ3dQYx/y+GvjQfACVwDtiTxk9KrVxgw36sHTcjZwynyNV5PrYqnahrsZ90Dxsr/Rxl20x
	E94+dUmfOIgFXuUzW5yZp0PYrAHf+oozS2KaXN77+ToczWrmSUeiVO2kZ68vgAekfiEGcl
	6BsosrW3OihbVc/vYNvl4LHcbz0oXq8=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4765113888;
	Tue, 25 Feb 2025 16:16:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id VsiMEfLsvWcCOwAAD6G6ig
	(envelope-from <dsterba@suse.com>); Tue, 25 Feb 2025 16:16:50 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH] btrfs: simplify parameters of metadata folio helpers
Date: Tue, 25 Feb 2025 17:16:48 +0100
Message-ID: <20250225161648.27512-1-dsterba@suse.com>
X-Mailer: git-send-email 2.47.1
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
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:mid];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Score: -2.80
X-Spam-Flag: NO

Unlike folio helpers for date the ones for metadata always take the
extent buffer start and length, so they can be simplified to take the
eb only.  The fs_info can be obtained from eb too so it can be dropped
as parameter.

Added in patch "btrfs: use metadata specific helpers to simplify extent
buffer helpers".

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/disk-io.c   |  3 +--
 fs/btrfs/extent_io.c | 30 ++++++++++--------------------
 fs/btrfs/subpage.c   | 28 ++++++++++++----------------
 fs/btrfs/subpage.h   | 12 ++++--------
 4 files changed, 27 insertions(+), 46 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index a799216aa264..574795f30167 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -284,8 +284,7 @@ blk_status_t btree_csum_one_bio(struct btrfs_bio *bbio)
 
 	if (WARN_ON_ONCE(found_start != eb->start))
 		return BLK_STS_IOERR;
-	if (WARN_ON(!btrfs_meta_folio_test_uptodate(fs_info, eb->folios[0],
-						    eb->start, eb->len)))
+	if (WARN_ON(!btrfs_meta_folio_test_uptodate(eb->folios[0], eb)))
 		return BLK_STS_IOERR;
 
 	ASSERT(memcmp_extent_buffer(eb, fs_info->fs_devices->metadata_uuid,
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 7b0aa332aedc..63fc8878703f 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -1736,16 +1736,13 @@ static struct extent_buffer *find_extent_buffer_nolock(
 static void end_bbio_meta_write(struct btrfs_bio *bbio)
 {
 	struct extent_buffer *eb = bbio->private;
-	struct btrfs_fs_info *fs_info = eb->fs_info;
 	struct folio_iter fi;
 
 	if (bbio->bio.bi_status != BLK_STS_OK)
 		set_btree_ioerr(eb);
 
 	bio_for_each_folio_all(fi, &bbio->bio) {
-		struct folio *folio = fi.folio;
-
-		btrfs_meta_folio_clear_writeback(fs_info, folio, eb->start, eb->len);
+		btrfs_meta_folio_clear_writeback(fi.folio, eb);
 	}
 
 	clear_bit(EXTENT_BUFFER_WRITEBACK, &eb->bflags);
@@ -1807,8 +1804,8 @@ static noinline_for_stack void write_one_eb(struct extent_buffer *eb,
 				      eb->start + eb->len) - range_start;
 
 		folio_lock(folio);
-		btrfs_meta_folio_clear_dirty(fs_info, folio, eb->start, eb->len);
-		btrfs_meta_folio_set_writeback(fs_info, folio, eb->start, eb->len);
+		btrfs_meta_folio_clear_dirty(folio, eb);
+		btrfs_meta_folio_set_writeback(folio, eb);
 		if (!folio_test_dirty(folio))
 			wbc->nr_to_write -= folio_nr_pages(folio);
 		bio_add_folio_nofail(&bbio->bio, folio, range_len,
@@ -3138,7 +3135,7 @@ struct extent_buffer *alloc_extent_buffer(struct btrfs_fs_info *fs_info,
 		 * and free the allocated page.
 		 */
 		folio = eb->folios[i];
-		WARN_ON(btrfs_meta_folio_test_dirty(fs_info, folio, eb->start, eb->len));
+		WARN_ON(btrfs_meta_folio_test_dirty(folio, eb));
 
 		/*
 		 * Check if the current page is physically contiguous with previous eb
@@ -3149,7 +3146,7 @@ struct extent_buffer *alloc_extent_buffer(struct btrfs_fs_info *fs_info,
 		if (i && folio_page(eb->folios[i - 1], 0) + 1 != folio_page(folio, 0))
 			page_contig = false;
 
-		if (!btrfs_meta_folio_test_uptodate(fs_info, folio, eb->start, eb->len))
+		if (!btrfs_meta_folio_test_uptodate(folio, eb))
 			uptodate = 0;
 
 		/*
@@ -3372,8 +3369,7 @@ void btrfs_clear_buffer_dirty(struct btrfs_trans_handle *trans,
 		if (!folio_test_dirty(folio))
 			continue;
 		folio_lock(folio);
-		last = btrfs_meta_folio_clear_and_test_dirty(fs_info, folio,
-							     eb->start, eb->len);
+		last = btrfs_meta_folio_clear_and_test_dirty(folio, eb);
 		if (last)
 			btree_clear_folio_dirty_tag(folio);
 		folio_unlock(folio);
@@ -3412,8 +3408,7 @@ void set_extent_buffer_dirty(struct extent_buffer *eb)
 		if (subpage)
 			folio_lock(eb->folios[0]);
 		for (int i = 0; i < num_folios; i++)
-			btrfs_meta_folio_set_dirty(eb->fs_info, eb->folios[i],
-						   eb->start, eb->len);
+			btrfs_meta_folio_set_dirty(eb->folios[i], eb);
 		if (subpage)
 			folio_unlock(eb->folios[0]);
 		percpu_counter_add_batch(&eb->fs_info->dirty_metadata_bytes,
@@ -3428,7 +3423,6 @@ void set_extent_buffer_dirty(struct extent_buffer *eb)
 
 void clear_extent_buffer_uptodate(struct extent_buffer *eb)
 {
-	struct btrfs_fs_info *fs_info = eb->fs_info;
 	int num_folios = num_extent_folios(eb);
 
 	clear_bit(EXTENT_BUFFER_UPTODATE, &eb->bflags);
@@ -3438,21 +3432,17 @@ void clear_extent_buffer_uptodate(struct extent_buffer *eb)
 		if (!folio)
 			continue;
 
-		btrfs_meta_folio_clear_uptodate(fs_info, folio, eb->start, eb->len);
+		btrfs_meta_folio_clear_uptodate(folio, eb);
 	}
 }
 
 void set_extent_buffer_uptodate(struct extent_buffer *eb)
 {
-	struct btrfs_fs_info *fs_info = eb->fs_info;
 	int num_folios = num_extent_folios(eb);
 
 	set_bit(EXTENT_BUFFER_UPTODATE, &eb->bflags);
-	for (int i = 0; i < num_folios; i++) {
-		struct folio *folio = eb->folios[i];
-
-		btrfs_meta_folio_set_uptodate(fs_info, folio, eb->start, eb->len);
-	}
+	for (int i = 0; i < num_folios; i++)
+		btrfs_meta_folio_set_uptodate(eb->folios[i], eb);
 }
 
 static void clear_extent_buffer_reading(struct extent_buffer *eb)
diff --git a/fs/btrfs/subpage.c b/fs/btrfs/subpage.c
index ebb40f506921..d7e70525f4fb 100644
--- a/fs/btrfs/subpage.c
+++ b/fs/btrfs/subpage.c
@@ -627,30 +627,27 @@ bool btrfs_folio_clamp_test_##name(const struct btrfs_fs_info *fs_info,	\
 	btrfs_subpage_clamp_range(folio, &start, &len);			\
 	return btrfs_subpage_test_##name(fs_info, folio, start, len);	\
 }									\
-void btrfs_meta_folio_set_##name(const struct btrfs_fs_info *fs_info,   \
-				 struct folio *folio, u64 start, u32 len) \
+void btrfs_meta_folio_set_##name(struct folio *folio, const struct extent_buffer *eb) \
 {									\
-	if (!btrfs_meta_is_subpage(fs_info)) {				\
+	if (!btrfs_meta_is_subpage(eb->fs_info)) {			\
 		folio_set_func(folio);					\
 		return;							\
 	}								\
-	btrfs_subpage_set_##name(fs_info, folio, start, len);		\
+	btrfs_subpage_set_##name(eb->fs_info, folio, eb->start, eb->len); \
 }									\
-void btrfs_meta_folio_clear_##name(const struct btrfs_fs_info *fs_info, \
-				   struct folio *folio, u64 start, u32 len) \
+void btrfs_meta_folio_clear_##name(struct folio *folio, const struct extent_buffer *eb) \
 {									\
-	if (!btrfs_meta_is_subpage(fs_info)) {				\
+	if (!btrfs_meta_is_subpage(eb->fs_info)) {			\
 		folio_clear_func(folio);				\
 		return;							\
 	}								\
-	btrfs_subpage_clear_##name(fs_info, folio, start, len);		\
+	btrfs_subpage_clear_##name(eb->fs_info, folio, eb->start, eb->len); \
 }									\
-bool btrfs_meta_folio_test_##name(const struct btrfs_fs_info *fs_info,	\
-				  struct folio *folio, u64 start, u32 len) \
+bool btrfs_meta_folio_test_##name(struct folio *folio, const struct extent_buffer *eb) \
 {									\
-	if (!btrfs_meta_is_subpage(fs_info))				\
+	if (!btrfs_meta_is_subpage(eb->fs_info))			\
 		return folio_test_func(folio);				\
-	return btrfs_subpage_test_##name(fs_info, folio, start, len);	\
+	return btrfs_subpage_test_##name(eb->fs_info, folio, eb->start, eb->len); \
 }
 IMPLEMENT_BTRFS_PAGE_OPS(uptodate, folio_mark_uptodate, folio_clear_uptodate,
 			 folio_test_uptodate);
@@ -761,17 +758,16 @@ void btrfs_folio_set_lock(const struct btrfs_fs_info *fs_info,
  *
  * If the affected folio is no longer dirty, return true. Otherwise return false.
  */
-bool btrfs_meta_folio_clear_and_test_dirty(const struct btrfs_fs_info *fs_info,
-					   struct folio *folio, u64 start, u32 len)
+bool btrfs_meta_folio_clear_and_test_dirty(struct folio *folio, const struct extent_buffer *eb)
 {
 	bool last;
 
-	if (!btrfs_meta_is_subpage(fs_info)) {
+	if (!btrfs_meta_is_subpage(eb->fs_info)) {
 		folio_clear_dirty_for_io(folio);
 		return true;
 	}
 
-	last = btrfs_subpage_clear_and_test_dirty(fs_info, folio, start, len);
+	last = btrfs_subpage_clear_and_test_dirty(eb->fs_info, folio, eb->start, eb->len);
 	if (last) {
 		folio_clear_dirty_for_io(folio);
 		return true;
diff --git a/fs/btrfs/subpage.h b/fs/btrfs/subpage.h
index e10a1d308f32..2515e380e904 100644
--- a/fs/btrfs/subpage.h
+++ b/fs/btrfs/subpage.h
@@ -164,12 +164,9 @@ void btrfs_folio_clamp_clear_##name(const struct btrfs_fs_info *fs_info,	\
 		struct folio *folio, u64 start, u32 len);			\
 bool btrfs_folio_clamp_test_##name(const struct btrfs_fs_info *fs_info,	\
 		struct folio *folio, u64 start, u32 len);		\
-void btrfs_meta_folio_set_##name(const struct btrfs_fs_info *fs_info,	\
-		struct folio *folio, u64 start, u32 len);		\
-void btrfs_meta_folio_clear_##name(const struct btrfs_fs_info *fs_info,	\
-		struct folio *folio, u64 start, u32 len);		\
-bool btrfs_meta_folio_test_##name(const struct btrfs_fs_info *fs_info,	\
-		struct folio *folio, u64 start, u32 len);		\
+void btrfs_meta_folio_set_##name(struct folio *folio, const struct extent_buffer *eb); \
+void btrfs_meta_folio_clear_##name(struct folio *folio, const struct extent_buffer *eb); \
+bool btrfs_meta_folio_test_##name(struct folio *folio, const struct extent_buffer *eb);
 
 DECLARE_BTRFS_SUBPAGE_OPS(uptodate);
 DECLARE_BTRFS_SUBPAGE_OPS(dirty);
@@ -195,8 +192,7 @@ bool btrfs_subpage_clear_and_test_dirty(const struct btrfs_fs_info *fs_info,
 
 void btrfs_folio_assert_not_dirty(const struct btrfs_fs_info *fs_info,
 				  struct folio *folio, u64 start, u32 len);
-bool btrfs_meta_folio_clear_and_test_dirty(const struct btrfs_fs_info *fs_info,
-					   struct folio *folio, u64 start, u32 len);
+bool btrfs_meta_folio_clear_and_test_dirty(struct folio *folio, const struct extent_buffer *eb);
 void btrfs_get_subpage_dirty_bitmap(struct btrfs_fs_info *fs_info,
 				    struct folio *folio,
 				    unsigned long *ret_bitmap);
-- 
2.47.1


