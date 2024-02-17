Return-Path: <linux-btrfs+bounces-2469-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BAC97858D81
	for <lists+linux-btrfs@lfdr.de>; Sat, 17 Feb 2024 07:30:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF5151C21240
	for <lists+linux-btrfs@lfdr.de>; Sat, 17 Feb 2024 06:30:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0EB71CD2A;
	Sat, 17 Feb 2024 06:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="GkqijsjU";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="KDcKj2Gg"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3F911CAA4
	for <linux-btrfs@vger.kernel.org>; Sat, 17 Feb 2024 06:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708151401; cv=none; b=rjVYAD0D+Btrn3PPacF4LqVgDvKdIiNtJBbCpCpta4aFnLl9apqa/PUZAlez7seBrHyH9K79mywGhP//hTONl5h7eB7i3xT5cWMd2UkUyKmShwxRa56BRif+vGETYNPQzHBRm5thZDioZRxxP0OcEPreSmsBEdvdmpm+Z+JtNJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708151401; c=relaxed/simple;
	bh=mLB6V7YMqcq9/oKqOVadPjtsCCcbwMz/ox4fCWKVsrU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OmOSBgbdPy9oJNLmL+Qfbcv6N65FUEwDOqUfYsyq3aKLgOh85q7h0YT+rg/WYKCPwj6AELQZejx6yjNLs7xxHmqichyM34JRIiBqam/fPxuBlR29SWByk+3bSwsLuUNYad3pAgwaCAVJ6kA19GbilQhKwyrYEBbJGQZRyRnM2iY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=GkqijsjU; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=KDcKj2Gg; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E740421FC8
	for <linux-btrfs@vger.kernel.org>; Sat, 17 Feb 2024 06:29:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1708151397; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HzmBbR/qpvNQmIsR/kKAijt4YwV/PF0jGgYk8gp+mTM=;
	b=GkqijsjUqJPI3Jla+KDCrsqBOMpm9BOnKZs7Fr5HX78LJ6espbyjEGRGTkfxO/dc6a4Qdg
	aEStrxugeK2f030eoxDSR7NJPZlfCB0dlWuxnLfmBBndTbqZtjnrW78CVGNInVRe2qPoBY
	0Y9X3IfrW3DDkfFoPsqAj3doIV9p+IA=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1708151396; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HzmBbR/qpvNQmIsR/kKAijt4YwV/PF0jGgYk8gp+mTM=;
	b=KDcKj2GgZFwAu2/2GrdfNIUe9RMtKwSWuWHyfvZ0qN6QDU9xqWeYyA1m8sYKeM62Xwdktr
	QzA18YLSjTxYp2cz7pZzWaIIdeUPXA93iHHs5zw099thzSgbjqTosUuYv4MocbPJMEsXPJ
	Lf6yuz6pLL3gDQ4gtNpuYf9ncttbpQ4=
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 22F6A134CD
	for <linux-btrfs@vger.kernel.org>; Sat, 17 Feb 2024 06:29:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id ECDMNWNS0GUyZQAAn2gu4w
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Sat, 17 Feb 2024 06:29:55 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2 2/3] btrfs: subpage: make reader lock to utilize bitmap
Date: Sat, 17 Feb 2024 16:59:49 +1030
Message-ID: <387c0d4b448ac1c00611d58cf30cd8bb8cbec402.1708151123.git.wqu@suse.com>
X-Mailer: git-send-email 2.43.1
In-Reply-To: <cover.1708151123.git.wqu@suse.com>
References: <cover.1708151123.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: 0.70
X-Spamd-Result: default: False [0.70 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 RCPT_COUNT_ONE(0.00)[1];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 TO_DN_NONE(0.00)[];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
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
 fs/btrfs/subpage.c | 46 ++++++++++++++++++++++++++++++++++++----------
 fs/btrfs/subpage.h | 12 +++++++++++-
 2 files changed, 47 insertions(+), 11 deletions(-)

diff --git a/fs/btrfs/subpage.c b/fs/btrfs/subpage.c
index 24f8be565a61..715b6df90117 100644
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
@@ -751,6 +776,7 @@ void __cold btrfs_subpage_dump_bitmap(const struct btrfs_fs_info *fs_info,
 	GET_SUBPAGE_BITMAP(subpage, subpage_info, writeback, &writeback_bitmap);
 	GET_SUBPAGE_BITMAP(subpage, subpage_info, ordered, &ordered_bitmap);
 	GET_SUBPAGE_BITMAP(subpage, subpage_info, checked, &checked_bitmap);
+	GET_SUBPAGE_BITMAP(subpage, subpage_info, locked, &checked_bitmap);
 	spin_unlock_irqrestore(&subpage->lock, flags);
 
 	dump_page(folio_page(folio, 0), "btrfs subpage dump");
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


