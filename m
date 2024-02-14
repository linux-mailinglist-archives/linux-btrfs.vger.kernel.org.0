Return-Path: <linux-btrfs+bounces-2367-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 00E7B8541EA
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 Feb 2024 05:05:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC8EC2860C6
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 Feb 2024 04:05:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E694FC126;
	Wed, 14 Feb 2024 04:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="dAxH9JPx";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="dAxH9JPx"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33785BA22
	for <linux-btrfs@vger.kernel.org>; Wed, 14 Feb 2024 04:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707883486; cv=none; b=VSp9jKr/hzA9mNJMTTU4UInFZ72iRQcOcv0t4dcKSUL+aZcpys+R/7n3/34ToIPPoq2T9KwH4MG8+BGj2fUU6SiZ6/VkfMmC6BiyH7AUY7v0cX+3SHh08lCtSFpiKuAzbDkAKzGgPgnePZGmYhWyrXwHQOjC4jcO45ySkKR/e8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707883486; c=relaxed/simple;
	bh=OXDWFJVE0C/KSspx0+ob6PSEoD18VudNx4aSuaQHdtU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CqHnU6WJX2hLxz79iJOa88N9oF0ZhbZ21ey8ipDb9UwiNencEMEn+uZ3jYnNDbAAloJlpZIHyg8KoWhBK72L5V+gYuOppM1Go6uzjq5Qn4Y7Jwyi8Q1Ozm5CYJfrF1SwEq1Ws119lT9vZ8i632wraOv5BvcIfAQCfmE45ngbOjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=dAxH9JPx; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=dAxH9JPx; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 740F421B84
	for <linux-btrfs@vger.kernel.org>; Wed, 14 Feb 2024 04:04:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1707883482; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6Ms0KlLKDrqBeuC22UUxiL5JHgG6UoqhjoSTt8zq6C8=;
	b=dAxH9JPxiYfTJcf6xtzY+WF4wmnM0lbe8Lyln0oSd7CNOSsnv2KI4+ueGGLhXn3iM1N8Ra
	6zLwlhYdp5OyLxNW9REeUHo1vE6J30RiWfOBJE0YUUNMBSyA72923AFCrqCDvH8ZB/tDez
	G1ijz4a1YPhRL+4wzWL39Zbf1JkjCp8=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1707883482; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6Ms0KlLKDrqBeuC22UUxiL5JHgG6UoqhjoSTt8zq6C8=;
	b=dAxH9JPxiYfTJcf6xtzY+WF4wmnM0lbe8Lyln0oSd7CNOSsnv2KI4+ueGGLhXn3iM1N8Ra
	6zLwlhYdp5OyLxNW9REeUHo1vE6J30RiWfOBJE0YUUNMBSyA72923AFCrqCDvH8ZB/tDez
	G1ijz4a1YPhRL+4wzWL39Zbf1JkjCp8=
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id A2D001329E
	for <linux-btrfs@vger.kernel.org>; Wed, 14 Feb 2024 04:04:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id QMDhGNk7zGVDDAAAn2gu4w
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Wed, 14 Feb 2024 04:04:41 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 2/3] btrfs: subpage: make reader lock to utilize bitmap
Date: Wed, 14 Feb 2024 14:34:35 +1030
Message-ID: <a44a04e758e8b8ab6a1f0f2034a65f2a7f143412.1707883446.git.wqu@suse.com>
X-Mailer: git-send-email 2.43.1
In-Reply-To: <cover.1707883446.git.wqu@suse.com>
References: <cover.1707883446.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [1.90 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 RCPT_COUNT_ONE(0.00)[1];
	 RCVD_COUNT_THREE(0.00)[3];
	 TO_DN_NONE(0.00)[];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 MID_CONTAINS_FROM(1.00)[];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Level: *
X-Spam-Score: 1.90
X-Spam-Flag: NO

Currently btrfs_subpage utilized its atomic member @reader to manage the
reader counter.

However the reader counter is only utilized to prevent the page got
released/unlocked when we still have reads underway.

In that use case, we don't really allow multiple readers on the same
subpage sector.

So here we can introduce a new locked bitmap to represent exactly which
subpage range is locked for read.

In theory we can remove btrfs_subpage::reader as it's just the set bits
of the new locked bitmap.
But unfortunately bitmap doesn't provide such handy API yet, so we still
keep the reader counter.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/subpage.c | 45 +++++++++++++++++++++++++++++++++++----------
 fs/btrfs/subpage.h | 12 +++++++++++-
 2 files changed, 46 insertions(+), 11 deletions(-)

diff --git a/fs/btrfs/subpage.c b/fs/btrfs/subpage.c
index 24f8be565a61..bd5c4993dcb9 100644
--- a/fs/btrfs/subpage.c
+++ b/fs/btrfs/subpage.c
@@ -111,6 +111,9 @@ void btrfs_init_subpage_info(struct btrfs_subpage_info *subpage_info, u32 sector
 	subpage_info->checked_offset = cur;
 	cur += nr_bits;
 
+	subpage_info->locked_offset = cur;
+	cur += nr_bits;
+
 	subpage_info->total_nr_bits = cur;
 }
 
@@ -237,28 +240,59 @@ static void btrfs_subpage_assert(const struct btrfs_fs_info *fs_info,
 		       start + len <= folio_pos(folio) + PAGE_SIZE);
 }
 
+#define subpage_calc_start_bit(fs_info, folio, name, start, len)	\
+({									\
+	unsigned int start_bit;						\
+									\
+	btrfs_subpage_assert(fs_info, folio, start, len);		\
+	start_bit = offset_in_page(start) >> fs_info->sectorsize_bits;	\
+	start_bit += fs_info->subpage_info->name##_offset;		\
+	start_bit;							\
+})
+
 void btrfs_subpage_start_reader(const struct btrfs_fs_info *fs_info,
 				struct folio *folio, u64 start, u32 len)
 {
 	struct btrfs_subpage *subpage = folio_get_private(folio);
+	const int start_bit = subpage_calc_start_bit(fs_info, folio, locked, start, len);
 	const int nbits = len >> fs_info->sectorsize_bits;
+	unsigned long flags;
+
 
 	btrfs_subpage_assert(fs_info, folio, start, len);
 
+	spin_lock_irqsave(&subpage->lock, flags);
+	/*
+	 * Even it's just for reading the page, no one should have locked the subpage
+	 * range.
+	 */
+	ASSERT(bitmap_test_range_all_zero(subpage->bitmaps, start_bit, nbits));
+	bitmap_set(subpage->bitmaps, start_bit, nbits);
 	atomic_add(nbits, &subpage->readers);
+	spin_unlock_irqrestore(&subpage->lock, flags);
 }
 
 void btrfs_subpage_end_reader(const struct btrfs_fs_info *fs_info,
 			      struct folio *folio, u64 start, u32 len)
 {
 	struct btrfs_subpage *subpage = folio_get_private(folio);
+	const int start_bit = subpage_calc_start_bit(fs_info, folio, locked,
+						     start, len);
 	const int nbits = len >> fs_info->sectorsize_bits;
+	unsigned long flags;
 	bool is_data;
 	bool last;
 
 	btrfs_subpage_assert(fs_info, folio, start, len);
 	is_data = is_data_inode(folio->mapping->host);
+
+	spin_lock_irqsave(&subpage->lock, flags);
+
+	/* The range should have already be locked. */
+	ASSERT(bitmap_test_range_all_set(subpage->bitmaps, start_bit, nbits));
 	ASSERT(atomic_read(&subpage->readers) >= nbits);
+
+	bitmap_clear(subpage->bitmaps, start_bit, nbits);
 	last = atomic_sub_and_test(nbits, &subpage->readers);
 
 	/*
@@ -270,6 +304,7 @@ void btrfs_subpage_end_reader(const struct btrfs_fs_info *fs_info,
 	 */
 	if (is_data && last)
 		folio_unlock(folio);
+	spin_unlock_irqrestore(&subpage->lock, flags);
 }
 
 static void btrfs_subpage_clamp_range(struct folio *folio, u64 *start, u32 *len)
@@ -365,16 +400,6 @@ void btrfs_folio_end_writer_lock(const struct btrfs_fs_info *fs_info,
 		folio_unlock(folio);
 }
 
-#define subpage_calc_start_bit(fs_info, folio, name, start, len)	\
-({									\
-	unsigned int start_bit;						\
-									\
-	btrfs_subpage_assert(fs_info, folio, start, len);		\
-	start_bit = offset_in_page(start) >> fs_info->sectorsize_bits;	\
-	start_bit += fs_info->subpage_info->name##_offset;		\
-	start_bit;							\
-})
-
 #define subpage_test_bitmap_all_set(fs_info, subpage, name)		\
 	bitmap_test_range_all_set(subpage->bitmaps,			\
 			fs_info->subpage_info->name##_offset,		\
diff --git a/fs/btrfs/subpage.h b/fs/btrfs/subpage.h
index 97ba2c100b0b..b6dc013b0fdc 100644
--- a/fs/btrfs/subpage.h
+++ b/fs/btrfs/subpage.h
@@ -33,7 +33,7 @@ struct btrfs_subpage_info {
 	unsigned int total_nr_bits;
 
 	/*
-	 * *_start indicates where the bitmap starts, the length is always
+	 * *_offset indicates where the bitmap starts, the length is always
 	 * @bitmap_size, which is calculated from PAGE_SIZE / sectorsize.
 	 */
 	unsigned int uptodate_offset;
@@ -41,6 +41,16 @@ struct btrfs_subpage_info {
 	unsigned int writeback_offset;
 	unsigned int ordered_offset;
 	unsigned int checked_offset;
+
+	/*
+	 * For locked bitmaps, normally it's subpage representation for folio
+	 * Locked flag, but metadata is different:
+	 *
+	 * - Metadata doesn't really lock the folio
+	 *   It's just to prevent page::private get cleared before the last
+	 *   end_page_read().
+	 */
+	unsigned int locked_offset;
 };
 
 /*
-- 
2.43.1


