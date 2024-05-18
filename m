Return-Path: <linux-btrfs+bounces-5086-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CC6D68C8FA7
	for <lists+linux-btrfs@lfdr.de>; Sat, 18 May 2024 07:08:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82558281C98
	for <lists+linux-btrfs@lfdr.de>; Sat, 18 May 2024 05:08:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E719C153;
	Sat, 18 May 2024 05:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Ug+ZkDK6";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="sia4YXTx"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE893BA33
	for <linux-btrfs@vger.kernel.org>; Sat, 18 May 2024 05:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716008890; cv=none; b=rxs59on2nB1H9xRZk9AZ5o0KYDnZRFWXhNKD7mw2I8zWqncK8L3uRZzEiJYFmBk0+3XuIn1iORCw518oFk2EzgjSsR3QWkz8zu/Ovqb5O3h7DiAR1d6vhnWGL5q7zDDCD7dELjIABrazQ8Yqal8Bbfvr+EEFoJzctm5oDiqjB2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716008890; c=relaxed/simple;
	bh=1kRcE8Ux3isMtpZQf7yPE9Tvc+VCmwkBfeRaypFfktM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LSWk3W2X1ZWNKER3sNXhv+uX7uQXexsY/h0QWkG9GQ8c6hUtj2x+nxUz8uZcbv/0OSYM60yO7CHNrAFmExeG3Q+kNSco3RlxyiPb8hIKx5oK/oKTZ/cSuprTqFP7mXlEWlsm79a8WJ+EvbGXWDRPI4XXK/q2ASW8EVeN4LF+msI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Ug+ZkDK6; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=sia4YXTx; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 5AB0F5F82B;
	Sat, 18 May 2024 05:08:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1716008886; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JftGlIBjJaoAFkuzb5IcyHjnigg5L5+FLpl41Wgqk/U=;
	b=Ug+ZkDK6pSnOm/QemQ8CpDTDaYwr+nUfLtx5SZe3DCrAgCZKIc8u8spx4Mkoc8NN6nekmN
	tlyhsMQC4cUSfWKzx3c71Lr37Z/XLVZpvSu5+Yov9tuxNCWwPKQtSgKWYArh0Pevqnu5vZ
	s6d4yAWWqNbyzETNGFZYJ4PZw9x+S9U=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1716008885; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JftGlIBjJaoAFkuzb5IcyHjnigg5L5+FLpl41Wgqk/U=;
	b=sia4YXTxG96DZCD9LxCFsK+65p6DmCkizIzOTBS77hYgloyCjQ9rvEOUFv7EjMvoso8s9D
	FKtom32OODEqZ8BIsn36M3na/RlPjEK+497oBMlNWrpQlODyvsQtcqIv4jdfojDNwCJOkD
	2DqkzqhWAjIG6EgRlly2Q7SHkHyPemo=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 71EA713942;
	Sat, 18 May 2024 05:08:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id aBOrC7M3SGbnXgAAD6G6ig
	(envelope-from <wqu@suse.com>); Sat, 18 May 2024 05:08:03 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: Johannes.Thumshirn@wdc.com,
	josef@toxicpanda.com,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v5 1/5] btrfs: make __extent_writepage_io() to write specified range only
Date: Sat, 18 May 2024 14:37:39 +0930
Message-ID: <3505552899f398a1d8959baa8245efac7a2070b6.1716008374.git.wqu@suse.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <cover.1716008374.git.wqu@suse.com>
References: <cover.1716008374.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -2.80
X-Spam-Level: 
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[wdc.com:email,suse.com:email];
	RCVD_TLS_ALL(0.00)[]

Function __extent_writepage_io() is designed to find all dirty range of
a page, and add that dirty range into the bio_ctrl for submission.
It requires all the dirtied range to be covered by an ordered extent.

It get called in two locations, but one call site is not subpage aware:

- __extent_writepage()
  It get called when writepage_delalloc() returned 0, which means
  writepage_delalloc() has handled dellalloc for all subpage sectors
  inside the page.

  So this call site is OK.

- extent_write_locked_range()
  This call site is utilized by zoned support, and in this case, we may
  only run delalloc range for a subset of the page, like this: (64K page
  size)

  0     16K     32K     48K     64K
  |/////|       |///////|       |

  In above case, if extent_write_locked_range() is only triggered for
  range [0, 16K), __extent_writepage_io() would still try to submit
  the dirty range of [32K, 48K), then it would not find any ordered
  extent for it and trigger various ASSERT()s.

Fix this problem by:

- Introducing @start and @len parameters to specify the range

  For the first call site, we just pass the whole page, and the behavior
  is not touched, since run_delalloc_range() for the page should have
  created all ordered extents for the page.

  For the second call site, we would avoid touching anything beyond the
  range, thus avoid the dirty range which is not yet covered by any
  delalloc range.

- Making btrfs_folio_assert_not_dirty() subpage aware
  The only caller is inside __extent_writepage_io(), and since that
  caller now accepts a subpage range, we should also check the subpage
  range other than the whole page.

Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/extent_io.c | 18 +++++++++++-------
 fs/btrfs/subpage.c   | 22 ++++++++++++++++------
 fs/btrfs/subpage.h   |  3 ++-
 3 files changed, 29 insertions(+), 14 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 597387e9f040..8a4a7d00795f 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -1339,20 +1339,23 @@ static void find_next_dirty_byte(struct btrfs_fs_info *fs_info,
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
@@ -1441,7 +1444,7 @@ static noinline_for_stack int __extent_writepage_io(struct btrfs_inode *inode,
 		nr++;
 	}
 
-	btrfs_folio_assert_not_dirty(fs_info, page_folio(page));
+	btrfs_folio_assert_not_dirty(fs_info, page_folio(page), start, len);
 	*nr_ret = nr;
 	return 0;
 
@@ -1499,7 +1502,8 @@ static int __extent_writepage(struct page *page, struct btrfs_bio_ctrl *bio_ctrl
 	if (ret)
 		goto done;
 
-	ret = __extent_writepage_io(BTRFS_I(inode), page, bio_ctrl, i_size, &nr);
+	ret = __extent_writepage_io(BTRFS_I(inode), page, page_offset(page),
+				    PAGE_SIZE, bio_ctrl, i_size, &nr);
 	if (ret == 1)
 		return 0;
 
@@ -2251,8 +2255,8 @@ void extent_write_locked_range(struct inode *inode, struct page *locked_page,
 			clear_page_dirty_for_io(page);
 		}
 
-		ret = __extent_writepage_io(BTRFS_I(inode), page, &bio_ctrl,
-					    i_size, &nr);
+		ret = __extent_writepage_io(BTRFS_I(inode), page, cur, cur_len,
+					    &bio_ctrl, i_size, &nr);
 		if (ret == 1)
 			goto next_page;
 
diff --git a/fs/btrfs/subpage.c b/fs/btrfs/subpage.c
index 54736f6238e6..183b32f51f51 100644
--- a/fs/btrfs/subpage.c
+++ b/fs/btrfs/subpage.c
@@ -703,19 +703,29 @@ IMPLEMENT_BTRFS_PAGE_OPS(checked, folio_set_checked, folio_clear_checked,
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
2.45.0


