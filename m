Return-Path: <linux-btrfs+bounces-2482-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 79BDA859BDC
	for <lists+linux-btrfs@lfdr.de>; Mon, 19 Feb 2024 07:08:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 317E92812EB
	for <lists+linux-btrfs@lfdr.de>; Mon, 19 Feb 2024 06:08:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 612AA200C7;
	Mon, 19 Feb 2024 06:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="OhQp0Vnn";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="OhQp0Vnn"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71C871CD38
	for <linux-btrfs@vger.kernel.org>; Mon, 19 Feb 2024 06:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708322927; cv=none; b=pn+00KEThlpXZLY+I8iPAJCm28q1Y2jvlPqhT25eenWD9uGKJdCn8H8tdYRVvz9H5JjmRr7H/62aqKfUmG8v6o1qmg+Zb7p6h3TpQM6FX2rDLln9jBt600rPUrMuvmaZPJ9WK7MmFjTY/a1dd+WSzI46StKThSKnmdbufvlGMjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708322927; c=relaxed/simple;
	bh=/wT1A6V53b2MIYvmrLWLpyiswDyTl9uZmkksJQNa8zw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ddxkODhvikVJPML1HLrjwMTHGBYimeycF1cFazeXQiUOZsJ7O5rc+t6aYD0y8moML2PUJE1zaupEx05CLunBo9r+MDUZonyKSCpZUMOeLAlEtwI7cTo8wHbZ0bvNU4NmANMea2IWjRzCrTpsD37dCfICFEhmdHPQPvGAVCto2UA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=OhQp0Vnn; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=OhQp0Vnn; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 9B1351FD06
	for <linux-btrfs@vger.kernel.org>; Mon, 19 Feb 2024 06:08:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1708322923; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SFR5NlIIyJP/Cr9r0FcoVZwTcXLlYfYE1hd7mUaPC6Q=;
	b=OhQp0VnnFNNXGWdOH/t8MQ9pMQXddYKgSpRJNLqqoLvim+94ccQndk1m+UUv2Z3T7/xh3F
	sjLDVmatv92NufzJLXTPDh7wobSe8iVOT10xYkr1yPJkxsyelnR3KIUsr3pN8GvH9iHvak
	L68wB0+wot6sSIUnjT743qdzV4NNbwM=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1708322923; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SFR5NlIIyJP/Cr9r0FcoVZwTcXLlYfYE1hd7mUaPC6Q=;
	b=OhQp0VnnFNNXGWdOH/t8MQ9pMQXddYKgSpRJNLqqoLvim+94ccQndk1m+UUv2Z3T7/xh3F
	sjLDVmatv92NufzJLXTPDh7wobSe8iVOT10xYkr1yPJkxsyelnR3KIUsr3pN8GvH9iHvak
	L68wB0+wot6sSIUnjT743qdzV4NNbwM=
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id A8F3A13585
	for <linux-btrfs@vger.kernel.org>; Mon, 19 Feb 2024 06:08:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id OAL/Fmrw0mXcJQAAn2gu4w
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Mon, 19 Feb 2024 06:08:42 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 1/4] btrfs: make __extent_writepage_io() to write specified range only
Date: Mon, 19 Feb 2024 16:38:34 +1030
Message-ID: <b465aa249051dba5bc273a9c03fafe8351410604.1708322044.git.wqu@suse.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <cover.1708322044.git.wqu@suse.com>
References: <cover.1708322044.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=OhQp0Vnn
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-1.51 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	 R_MISSING_CHARSET(2.50)[];
	 TO_DN_NONE(0.00)[];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_TRACE(0.00)[suse.com:+];
	 MX_GOOD(-0.01)[];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 BAYES_HAM(-3.00)[100.00%];
	 ARC_NA(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	 FROM_HAS_DN(0.00)[];
	 DWL_DNSWL_MED(-2.00)[suse.com:dkim];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	 RCPT_COUNT_ONE(0.00)[1];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 RCVD_TLS_ALL(0.00)[]
X-Spam-Score: -1.51
X-Rspamd-Queue-Id: 9B1351FD06
X-Spam-Flag: NO

Function __extent_writepage_io() is designed to find all dirty range of
a page, and add that dirty range into the bio_ctrl for submission.
It requires all the dirtied range to be covered by a delalloc range.

It get called in two locations, but one call site is not subpage aware:

- __extent_writepage()
  It get called when writepage_delalloc() returned 0, which means
  writepage_delalloc() has handled dellalloc for all subpage sectors
  inside the page.

  So this call site is fine.

- extent_write_locked_range()
  This call site is utilized by zoned support, and in this case, we may
  only run delalloc range for a subset of the page.

  In that case, __extent_writepage_io() can hit range which is not yet
  covered by delalloc range, and hit various ASSERT()s.

Fix this problem by:

- Introducing range parameters (@start and @len) to specify the range
  where __extent_writepage_io() should write check for.

  For the first call site, we just pass the whole page, and the behavior
  is not touched.

  For the second call site, we would avoid touching anything beyond the
  range, thus avoid the dirty range which is not yet covered by any
  delalloc range.

- Making btrfs_folio_assert_not_dirty() subpage aware
  The only caller is inside __extent_writepage_io(), and since that
  caller now accepts a subpage range, we should also check the subpage
  range other than the whole page.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/extent_io.c | 18 +++++++++++-------
 fs/btrfs/subpage.c   | 22 ++++++++++++++++------
 fs/btrfs/subpage.h   |  3 ++-
 3 files changed, 29 insertions(+), 14 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 197b9f50e75c..556ec44fdf8e 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -1311,20 +1311,23 @@ static void find_next_dirty_byte(struct btrfs_fs_info *fs_info,
  * < 0 if there were errors (page still locked)
  */
 static noinline_for_stack int __extent_writepage_io(struct btrfs_inode *inode,
-				 struct page *page,
+				 struct page *page, u64 start, u32 len,
 				 struct btrfs_bio_ctrl *bio_ctrl,
 				 loff_t i_size,
 				 int *nr_ret)
 {
 	struct btrfs_fs_info *fs_info = inode->root->fs_info;
-	u64 cur = page_offset(page);
-	u64 end = cur + PAGE_SIZE - 1;
+	u64 cur = start;
+	u64 end = start + len - 1;
 	u64 extent_offset;
 	u64 block_start;
 	struct extent_map *em;
 	int ret = 0;
 	int nr = 0;
 
+	ASSERT(start >= page_offset(page) &&
+	       start + len <= page_offset(page) + PAGE_SIZE);
+
 	ret = btrfs_writepage_cow_fixup(page);
 	if (ret) {
 		/* Fixup worker will requeue */
@@ -1413,7 +1416,7 @@ static noinline_for_stack int __extent_writepage_io(struct btrfs_inode *inode,
 		nr++;
 	}
 
-	btrfs_folio_assert_not_dirty(fs_info, page_folio(page));
+	btrfs_folio_assert_not_dirty(fs_info, page_folio(page), start, len);
 	*nr_ret = nr;
 	return 0;
 
@@ -1471,7 +1474,8 @@ static int __extent_writepage(struct page *page, struct btrfs_bio_ctrl *bio_ctrl
 	if (ret)
 		goto done;
 
-	ret = __extent_writepage_io(BTRFS_I(inode), page, bio_ctrl, i_size, &nr);
+	ret = __extent_writepage_io(BTRFS_I(inode), page, page_offset(page),
+				    PAGE_SIZE, bio_ctrl, i_size, &nr);
 	if (ret == 1)
 		return 0;
 
@@ -2223,8 +2227,8 @@ void extent_write_locked_range(struct inode *inode, struct page *locked_page,
 			clear_page_dirty_for_io(page);
 		}
 
-		ret = __extent_writepage_io(BTRFS_I(inode), page, &bio_ctrl,
-					    i_size, &nr);
+		ret = __extent_writepage_io(BTRFS_I(inode), page, cur, cur_len,
+					    &bio_ctrl, i_size, &nr);
 		if (ret == 1)
 			goto next_page;
 
diff --git a/fs/btrfs/subpage.c b/fs/btrfs/subpage.c
index 3b3ef8bffe05..b33e43de7f93 100644
--- a/fs/btrfs/subpage.c
+++ b/fs/btrfs/subpage.c
@@ -706,19 +706,29 @@ IMPLEMENT_BTRFS_PAGE_OPS(checked, folio_set_checked, folio_clear_checked,
  * Make sure not only the page dirty bit is cleared, but also subpage dirty bit
  * is cleared.
  */
-void btrfs_folio_assert_not_dirty(const struct btrfs_fs_info *fs_info, struct folio *folio)
+void btrfs_folio_assert_not_dirty(const struct btrfs_fs_info *fs_info,
+				  struct folio *folio, u64 start, u32 len)
 {
-	struct btrfs_subpage *subpage = folio_get_private(folio);
+	struct btrfs_subpage *subpage;
+	int start_bit;
+	int nbits;
+	unsigned long flags;
 
 	if (!IS_ENABLED(CONFIG_BTRFS_ASSERT))
 		return;
 
-	ASSERT(!folio_test_dirty(folio));
-	if (!btrfs_is_subpage(fs_info, folio->mapping))
+	if (!btrfs_is_subpage(fs_info, folio->mapping)) {
+		ASSERT(!folio_test_dirty(folio));
 		return;
+	}
 
-	ASSERT(folio_test_private(folio) && folio_get_private(folio));
-	ASSERT(subpage_test_bitmap_all_zero(fs_info, subpage, dirty));
+	start_bit = subpage_calc_start_bit(fs_info, folio, dirty, start, len);
+	nbits = len >> fs_info->sectorsize_bits;
+	subpage = folio_get_private(folio);
+	ASSERT(subpage);
+	spin_lock_irqsave(&subpage->lock, flags);
+	ASSERT(bitmap_test_range_all_zero(subpage->bitmaps, start_bit, nbits));
+	spin_unlock_irqrestore(&subpage->lock, flags);
 }
 
 /*
diff --git a/fs/btrfs/subpage.h b/fs/btrfs/subpage.h
index b6dc013b0fdc..4b363d9453af 100644
--- a/fs/btrfs/subpage.h
+++ b/fs/btrfs/subpage.h
@@ -156,7 +156,8 @@ DECLARE_BTRFS_SUBPAGE_OPS(checked);
 bool btrfs_subpage_clear_and_test_dirty(const struct btrfs_fs_info *fs_info,
 					struct folio *folio, u64 start, u32 len);
 
-void btrfs_folio_assert_not_dirty(const struct btrfs_fs_info *fs_info, struct folio *folio);
+void btrfs_folio_assert_not_dirty(const struct btrfs_fs_info *fs_info,
+				  struct folio *folio, u64 start, u32 len);
 void btrfs_folio_unlock_writer(struct btrfs_fs_info *fs_info,
 			       struct folio *folio, u64 start, u32 len);
 void __cold btrfs_subpage_dump_bitmap(const struct btrfs_fs_info *fs_info,
-- 
2.43.2


