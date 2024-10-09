Return-Path: <linux-btrfs+bounces-8678-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AFEAC995F41
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Oct 2024 07:51:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1E05AB21D8B
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Oct 2024 05:51:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C3A5169397;
	Wed,  9 Oct 2024 05:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="nKxufT6S";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="nKxufT6S"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CB621531E8
	for <linux-btrfs@vger.kernel.org>; Wed,  9 Oct 2024 05:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728453099; cv=none; b=Pi9oKqpnlB+VbNuqdzbeMMq4DuAOYQyxos+DZntblqCgGRk1tJDJpk19C+FZo47lD1c1e6NKCAxkrAbDnGzbKb1k+AOPDrWMcJst+kJm9Uo5mOh26Agkr/l+Yh3IFHn4NAZ+mQV9PiERtMeWBqRRYHE1KeDw7o6lEcpQQ1BQET0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728453099; c=relaxed/simple;
	bh=VGmf3lHcgMcAbH/PQoKPMpacmYNIHao4U9Gpqa0mgcQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DzCjNj2xYnZIRY/vj90Oyu6SbXncXDfjJ4gvWFGGTWeWqhu9fiYOanOzLJPcwZHWw552Qm2eRhifMwHaGZAtmpIhYLt6RAh6geuTDHuefzAE8F8di5Ps4zKPx4LDh2Xkb6JQNpRcp79MuWAHVDtJuhfvBAd/n/aiSaujpD8yBj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=nKxufT6S; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=nKxufT6S; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 71E6B21AD7
	for <linux-btrfs@vger.kernel.org>; Wed,  9 Oct 2024 05:51:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1728453095; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=r5v3WcVtRb0w7TZOsjT8G74VfsnZI3ctc3+vIYWGD+k=;
	b=nKxufT6SAFxJ45+1zLlRiiwscpL3CaDkhBbB+jB36U99ToqfEOEfJpNASW8yW+QcDqE/Zh
	5NBwD6QDUSYNYEj8VJXnH0q7Quh8pZfdUosH6n/0AFJU7py55nhv6lCmhKflT0c5AaVW/b
	g0sh/zthQPRk8loJp01qGQPodYiAuCI=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1728453095; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=r5v3WcVtRb0w7TZOsjT8G74VfsnZI3ctc3+vIYWGD+k=;
	b=nKxufT6SAFxJ45+1zLlRiiwscpL3CaDkhBbB+jB36U99ToqfEOEfJpNASW8yW+QcDqE/Zh
	5NBwD6QDUSYNYEj8VJXnH0q7Quh8pZfdUosH6n/0AFJU7py55nhv6lCmhKflT0c5AaVW/b
	g0sh/zthQPRk8loJp01qGQPodYiAuCI=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B266B132BD
	for <linux-btrfs@vger.kernel.org>; Wed,  9 Oct 2024 05:51:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 2EZkHeYZBmcFHgAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Wed, 09 Oct 2024 05:51:34 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2 1/2] btrfs: unify to use writer locks for subpage locking
Date: Wed,  9 Oct 2024 16:21:06 +1030
Message-ID: <3dc776ff06055f23a4dadb54c1ccc137c420b626.1728452897.git.wqu@suse.com>
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
X-Spam-Level: 
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
X-Spam-Score: -2.80
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
 fs/btrfs/extent_io.c   | 10 ++-----
 fs/btrfs/subpage.c     | 62 ++----------------------------------------
 fs/btrfs/subpage.h     | 13 ---------
 4 files changed, 5 insertions(+), 83 deletions(-)

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
index bfa745258e9b..06d2b882bf8c 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -438,7 +438,7 @@ static void end_folio_read(struct folio *folio, bool uptodate, u64 start, u32 le
 	if (!btrfs_is_subpage(fs_info, folio->mapping))
 		folio_unlock(folio);
 	else
-		btrfs_subpage_end_reader(fs_info, folio, start, len);
+		btrfs_folio_end_writer_lock(fs_info, folio, start, len);
 }
 
 /*
@@ -495,7 +495,7 @@ static void begin_folio_read(struct btrfs_fs_info *fs_info, struct folio *folio)
 		return;
 
 	ASSERT(folio_test_private(folio));
-	btrfs_subpage_start_reader(fs_info, folio, folio_pos(folio), PAGE_SIZE);
+	btrfs_folio_set_writer_lock(fs_info, folio, folio_pos(folio), PAGE_SIZE);
 }
 
 /*
@@ -2517,12 +2517,6 @@ static bool folio_range_has_eb(struct btrfs_fs_info *fs_info, struct folio *foli
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
index 26d4d05dd165..6c3d54a45956 100644
--- a/fs/btrfs/subpage.c
+++ b/fs/btrfs/subpage.c
@@ -140,12 +140,10 @@ struct btrfs_subpage *btrfs_alloc_subpage(const struct btrfs_fs_info *fs_info,
 		return ERR_PTR(-ENOMEM);
 
 	spin_lock_init(&ret->lock);
-	if (type == BTRFS_SUBPAGE_METADATA) {
+	if (type == BTRFS_SUBPAGE_METADATA)
 		atomic_set(&ret->eb_refs, 0);
-	} else {
-		atomic_set(&ret->readers, 0);
+	else
 		atomic_set(&ret->writers, 0);
-	}
 	return ret;
 }
 
@@ -221,62 +219,6 @@ static void btrfs_subpage_assert(const struct btrfs_fs_info *fs_info,
 	__start_bit;							\
 })
 
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
-	ASSERT(bitmap_test_range_all_zero(subpage->bitmaps, start_bit, nbits));
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
-	ASSERT(bitmap_test_range_all_set(subpage->bitmaps, start_bit, nbits));
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
index e4076c5b06bc..c150aba9318e 100644
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
@@ -95,11 +87,6 @@ void btrfs_free_subpage(struct btrfs_subpage *subpage);
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


