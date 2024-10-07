Return-Path: <linux-btrfs+bounces-8595-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F7F999399D
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Oct 2024 23:59:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 49BF61C231CF
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Oct 2024 21:59:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3BC018C93B;
	Mon,  7 Oct 2024 21:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="ng/cLoGw";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="btax4eEp"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9183185952
	for <linux-btrfs@vger.kernel.org>; Mon,  7 Oct 2024 21:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728338348; cv=none; b=K0YLw4qut3XsI7Raz9sfJ32UYKZI14DP5exXQ6MvXe2fJZLVIoAw58OBgQClVXye1VHPMkA0EVi1ETxdzG6DSLccEMOgu9SRRLBwz9el0o+37MQ/rhsrb7saAG3fvACy8Xt1rXcTKkEo7ljRQ5bokysXRAKNyWTX3On7EiPZ2EU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728338348; c=relaxed/simple;
	bh=HBwYgZxZDtAulgEfDauk3wU6TH9QnRMH/fKnlVAEjH4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Vo3Tcn9WC3bfLKbawQauZanLYgJWiA1Tp/g3JhOJGgnZsduwIzknfkBChYpiY5TmpffYEGEU93+w8Vn5LRcAL/usX+SqJle4Wc1SB8WU34H9dmGS3nfJaeBBTu7rb2IyEvR7qCzy+hCu2ylcBKFa+1L63uA4X7ZJuB77Wdk1EBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=ng/cLoGw; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=btax4eEp; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E270A1FF2E
	for <linux-btrfs@vger.kernel.org>; Mon,  7 Oct 2024 21:59:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1728338345; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pGsU7xrBXySpPg0ZkbFDPdbt4SQKwNvSfOeDkEw0KXM=;
	b=ng/cLoGwuEzKYl5q97rCcEz060ROZ4pXEhUi+MHottNYj5JEg8YI3Xl4UycDLV73AfMTao
	PEof0DOVQy3A9rntXWeLLuvVPzSFJ+yZqtSnrm7BNSgsALCXolOqFsVyZFPmMZmN+MekZX
	N5W+6fMWflHgFz4Gq1zvchLbTN4COnc=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=btax4eEp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1728338344; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pGsU7xrBXySpPg0ZkbFDPdbt4SQKwNvSfOeDkEw0KXM=;
	b=btax4eEpLqvCI6OkXhx0FqMS+Yt/ZkrA9HqUmWYZwT+9/E7Igp7tNMTn8YKpSmmS3IGxjO
	T3Yda0GACwO61DFWLILnzvKU5RqMtzyk7wXZUOKJaNY9Lqc5EzhumkPoczfge2yrwev1iN
	frCgUEZXy30qFlcnfubGc0tQqq07if8=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2E2FC13786
	for <linux-btrfs@vger.kernel.org>; Mon,  7 Oct 2024 21:59:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id WA67OKdZBGfsfAAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Mon, 07 Oct 2024 21:59:03 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 1/2] btrfs: unify to use writer locks for subpage locking
Date: Tue,  8 Oct 2024 08:28:44 +1030
Message-ID: <920be98203b75b89cad9ee617b1568e9dd45b305.1728338061.git.wqu@suse.com>
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
X-Rspamd-Queue-Id: E270A1FF2E
X-Spam-Level: 
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RCPT_COUNT_ONE(0.00)[1];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_NONE(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:email,suse.com:dkim,suse.com:mid]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01
X-Spam-Flag: NO

Since commit d7172f52e993 ("btrfs: use per-buffer locking for
extent_buffer reading"), metadata read no longer relies on the subpage
reader locking.

This means we do not need to maintain a different metadata/data split
for locking, so we can convert the existing reader lock users by:

- add_ra_bio_pages()
  Convert to btrfs_folio_set_writer_lock()

- end_folio_read()
  Convert to btrfs_folio_end_writer_lock()

- begin_folio_read()
  Convert to btrfs_folio_set_writer_lock()

- folio_range_has_eb()
  Remove the subpage->readers checks, since it is always 0.

- Remove btrfs_subpage_start_reader() and btrfs_subpage_end_reader()

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/compression.c |  3 +-
 fs/btrfs/extent_io.c   | 10 ++----
 fs/btrfs/subpage.c     | 82 ++----------------------------------------
 fs/btrfs/subpage.h     | 19 +++-------
 4 files changed, 10 insertions(+), 104 deletions(-)

diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index 6e9c4a5e0d51..74799270eb78 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -545,8 +545,7 @@ static noinline int add_ra_bio_pages(struct inode *inode,
 		 * subpage::readers and to unlock the page.
 		 */
 		if (fs_info->sectorsize < PAGE_SIZE)
-			btrfs_subpage_start_reader(fs_info, folio, cur,
-						   add_size);
+			btrfs_folio_set_writer_lock(fs_info, folio, cur, add_size);
 		folio_put(folio);
 		cur += add_size;
 	}
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 0448cee2b983..04b190bc047f 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -436,7 +436,7 @@ static void end_folio_read(struct folio *folio, bool uptodate, u64 start, u32 le
 	if (!btrfs_is_subpage(fs_info, folio->mapping))
 		folio_unlock(folio);
 	else
-		btrfs_subpage_end_reader(fs_info, folio, start, len);
+		btrfs_folio_end_writer_lock(fs_info, folio, start, len);
 }
 
 /*
@@ -493,7 +493,7 @@ static void begin_folio_read(struct btrfs_fs_info *fs_info, struct folio *folio)
 		return;
 
 	ASSERT(folio_test_private(folio));
-	btrfs_subpage_start_reader(fs_info, folio, folio_pos(folio), PAGE_SIZE);
+	btrfs_folio_set_writer_lock(fs_info, folio, folio_pos(folio), PAGE_SIZE);
 }
 
 /*
@@ -2508,12 +2508,6 @@ static bool folio_range_has_eb(struct btrfs_fs_info *fs_info, struct folio *foli
 		subpage = folio_get_private(folio);
 		if (atomic_read(&subpage->eb_refs))
 			return true;
-		/*
-		 * Even there is no eb refs here, we may still have
-		 * end_folio_read() call relying on page::private.
-		 */
-		if (atomic_read(&subpage->readers))
-			return true;
 	}
 	return false;
 }
diff --git a/fs/btrfs/subpage.c b/fs/btrfs/subpage.c
index 3c1e34ddda74..ed7f66963c0b 100644
--- a/fs/btrfs/subpage.c
+++ b/fs/btrfs/subpage.c
@@ -140,12 +140,9 @@ struct btrfs_subpage *btrfs_alloc_subpage(const struct btrfs_fs_info *fs_info,
 		return ERR_PTR(-ENOMEM);
 
 	spin_lock_init(&ret->lock);
-	if (type == BTRFS_SUBPAGE_METADATA) {
+	atomic_set(&ret->writers, 0);
+	if (type == BTRFS_SUBPAGE_METADATA)
 		atomic_set(&ret->eb_refs, 0);
-	} else {
-		atomic_set(&ret->readers, 0);
-		atomic_set(&ret->writers, 0);
-	}
 	return ret;
 }
 
@@ -240,81 +237,6 @@ static void assert_bitmap_range_all_zero(const struct btrfs_fs_info *fs_info,
 	}
 }
 
-static void assert_bitmap_range_all_set(const struct btrfs_fs_info *fs_info,
-					 struct folio *folio, u64 start, u32 len)
-{
-	struct btrfs_subpage *subpage = folio_get_private(folio);
-	const int start_bit = subpage_calc_start_bit(fs_info, folio, locked, start, len);
-	const int nbits = len >> fs_info->sectorsize_bits;
-	int all_set;
-
-	lockdep_assert_held(&subpage->lock);
-	if (!IS_ENABLED(CONFIG_BTRFS_ASSERT))
-		return;
-
-	all_set = bitmap_test_range_all_set(subpage->bitmaps, start_bit, nbits);
-	if (unlikely(!all_set)) {
-		btrfs_subpage_dump_bitmap(fs_info, folio, start, len, true);
-		ASSERT(all_set);
-	}
-}
-
-void btrfs_subpage_start_reader(const struct btrfs_fs_info *fs_info,
-				struct folio *folio, u64 start, u32 len)
-{
-	struct btrfs_subpage *subpage = folio_get_private(folio);
-	const int start_bit = subpage_calc_start_bit(fs_info, folio, locked, start, len);
-	const int nbits = len >> fs_info->sectorsize_bits;
-	unsigned long flags;
-
-
-	btrfs_subpage_assert(fs_info, folio, start, len);
-
-	spin_lock_irqsave(&subpage->lock, flags);
-	/*
-	 * Even though it's just for reading the page, no one should have
-	 * locked the subpage range.
-	 */
-	assert_bitmap_range_all_zero(fs_info, folio, start, len);
-	bitmap_set(subpage->bitmaps, start_bit, nbits);
-	atomic_add(nbits, &subpage->readers);
-	spin_unlock_irqrestore(&subpage->lock, flags);
-}
-
-void btrfs_subpage_end_reader(const struct btrfs_fs_info *fs_info,
-			      struct folio *folio, u64 start, u32 len)
-{
-	struct btrfs_subpage *subpage = folio_get_private(folio);
-	const int start_bit = subpage_calc_start_bit(fs_info, folio, locked, start, len);
-	const int nbits = len >> fs_info->sectorsize_bits;
-	unsigned long flags;
-	bool is_data;
-	bool last;
-
-	btrfs_subpage_assert(fs_info, folio, start, len);
-	is_data = is_data_inode(BTRFS_I(folio->mapping->host));
-
-	spin_lock_irqsave(&subpage->lock, flags);
-
-	/* The range should have already been locked. */
-	assert_bitmap_range_all_set(fs_info, folio, start, len);
-	ASSERT(atomic_read(&subpage->readers) >= nbits);
-
-	bitmap_clear(subpage->bitmaps, start_bit, nbits);
-	last = atomic_sub_and_test(nbits, &subpage->readers);
-
-	/*
-	 * For data we need to unlock the page if the last read has finished.
-	 *
-	 * And please don't replace @last with atomic_sub_and_test() call
-	 * inside if () condition.
-	 * As we want the atomic_sub_and_test() to be always executed.
-	 */
-	if (is_data && last)
-		folio_unlock(folio);
-	spin_unlock_irqrestore(&subpage->lock, flags);
-}
-
 static void btrfs_subpage_clamp_range(struct folio *folio, u64 *start, u32 *len)
 {
 	u64 orig_start = *start;
diff --git a/fs/btrfs/subpage.h b/fs/btrfs/subpage.h
index cbee866152de..b6337543f7dd 100644
--- a/fs/btrfs/subpage.h
+++ b/fs/btrfs/subpage.h
@@ -45,14 +45,6 @@ enum {
 struct btrfs_subpage {
 	/* Common members for both data and metadata pages */
 	spinlock_t lock;
-	/*
-	 * Both data and metadata needs to track how many readers are for the
-	 * page.
-	 * Data relies on @readers to unlock the page when last reader finished.
-	 * While metadata doesn't need page unlock, it needs to prevent
-	 * page::private get cleared before the last end_page_read().
-	 */
-	atomic_t readers;
 	union {
 		/*
 		 * Structures only used by metadata
@@ -62,7 +54,11 @@ struct btrfs_subpage {
 		 */
 		atomic_t eb_refs;
 
-		/* Structures only used by data */
+		/*
+		 * Structures only used by data,
+		 *
+		 * How many sectors inside the page is locked.
+		 */
 		atomic_t writers;
 	};
 	unsigned long bitmaps[];
@@ -95,11 +91,6 @@ void btrfs_free_subpage(struct btrfs_subpage *subpage);
 void btrfs_folio_inc_eb_refs(const struct btrfs_fs_info *fs_info, struct folio *folio);
 void btrfs_folio_dec_eb_refs(const struct btrfs_fs_info *fs_info, struct folio *folio);
 
-void btrfs_subpage_start_reader(const struct btrfs_fs_info *fs_info,
-				struct folio *folio, u64 start, u32 len);
-void btrfs_subpage_end_reader(const struct btrfs_fs_info *fs_info,
-			      struct folio *folio, u64 start, u32 len);
-
 void btrfs_folio_end_writer_lock(const struct btrfs_fs_info *fs_info,
 				 struct folio *folio, u64 start, u32 len);
 void btrfs_folio_set_writer_lock(const struct btrfs_fs_info *fs_info,
-- 
2.46.2


