Return-Path: <linux-btrfs+bounces-5239-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 979438CCCB5
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 May 2024 09:06:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B5531F21BAC
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 May 2024 07:06:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F9C413C9CD;
	Thu, 23 May 2024 07:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Hx2mUts3";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Hx2mUts3"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8973D13C9AC
	for <linux-btrfs@vger.kernel.org>; Thu, 23 May 2024 07:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716447981; cv=none; b=MO1u8BLgtxBVIDisSsqiRT3n+counsgoQcekJcleOSsMp2puEvIynoxO/nHcYJS3hiXw7jihwSw79gc6943LIpSg7Q2IBCpGr1I4YI9tB5RsAThPZdXU8rXM8ZVu+hlUMpmluaclwcqFi7pghmaGiFGKTfLqPgWUyySTW5IFAtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716447981; c=relaxed/simple;
	bh=MF+S98NEFj1HdG3XCS+AZNJUqwLO+F5Mu8SVZxVoMQE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IhGv3zkUQtwl6awDsYJXLw6IZK6ZGuvGyyYl30c6S3298O8Dq8pSnfGg+a2PKtzTKQhMCfn3t5k+XchDtBFtjkGFAl87FJ9P++g/oBqGzpAjGp5C5xmPhZNP7cgtznvR/quoMrmGNN06RAhCJN2ceZeWWXLhwdaX3+HdQyRh+9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Hx2mUts3; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Hx2mUts3; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 6387D1FF79;
	Thu, 23 May 2024 07:06:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1716447972; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sJI3UxIe8tgZBONHkvn/BRLvIDH5nF2YtnCnbamXDm8=;
	b=Hx2mUts3MQgdaOxYeaxRgtAxmmW/+6tHWCzgIVZ7WeM+F9xfZLOZt0RLlwujcYNIwGT0Pg
	vRPh2zzk2IomzKjnUxtB0KvMq9tHInrJz1VWmm6G5DeKNCmGR5+oOc6Vg8ZV+sfFDfY0Ke
	TtF7XTegV4ZRJSuI6Pprv5+MnWF8bLI=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=Hx2mUts3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1716447972; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sJI3UxIe8tgZBONHkvn/BRLvIDH5nF2YtnCnbamXDm8=;
	b=Hx2mUts3MQgdaOxYeaxRgtAxmmW/+6tHWCzgIVZ7WeM+F9xfZLOZt0RLlwujcYNIwGT0Pg
	vRPh2zzk2IomzKjnUxtB0KvMq9tHInrJz1VWmm6G5DeKNCmGR5+oOc6Vg8ZV+sfFDfY0Ke
	TtF7XTegV4ZRJSuI6Pprv5+MnWF8bLI=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D5E5713A7D;
	Thu, 23 May 2024 07:06:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id WNUPIuLqTmb0bwAAD6G6ig
	(envelope-from <wqu@suse.com>); Thu, 23 May 2024 07:06:10 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v6 1/5] btrfs: make __extent_writepage_io() to write specified range only
Date: Thu, 23 May 2024 16:35:42 +0930
Message-ID: <4a50f491c71005015b13be437dd17bbbffc59fe1.1716445070.git.wqu@suse.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <cover.1716445070.git.wqu@suse.com>
References: <cover.1716445070.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -3.01
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 6387D1FF79
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DWL_DNSWL_BLOCKED(0.00)[suse.com:dkim];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:dkim,suse.com:email];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+]

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
Reviewed-by: Naohiro Aota <naohiro.aota@wdc.com>
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/extent_io.c | 18 +++++++++++-------
 fs/btrfs/subpage.c   | 22 ++++++++++++++++------
 fs/btrfs/subpage.h   |  3 ++-
 3 files changed, 29 insertions(+), 14 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index bf50301ee528..938061e0ce01 100644
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
index 9127704236ab..2697e528eab2 100644
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
+	unsigned int start_bit;
+	unsigned int nbits;
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
2.45.1


