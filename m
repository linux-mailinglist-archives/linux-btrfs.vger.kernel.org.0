Return-Path: <linux-btrfs+bounces-8576-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ECEBA99223F
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Oct 2024 01:22:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 81ADE1F214F1
	for <lists+linux-btrfs@lfdr.de>; Sun,  6 Oct 2024 23:22:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0272018BC1C;
	Sun,  6 Oct 2024 23:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="nzAsMR1k";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="nzAsMR1k"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A56F136E3F
	for <linux-btrfs@vger.kernel.org>; Sun,  6 Oct 2024 23:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728256926; cv=none; b=LD44CcrFgORvGK5h6DuGDFHFb5ZFwiT/BsEbR5NmTgVBZwpU2OLvs1Kwp9kO1gqm+TO7M7vUgUKit68go0QDJHhzlHxgKlL/ASoa74h06J4x0qtBZgN+WMFQcyV0DYAUieSjrrb1zFMUZREkgUZqVCh1Iawbb7SdYY/nCbWAQ+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728256926; c=relaxed/simple;
	bh=H8+7UvTW19sDK6rcNKq+9dpuMEqS1SSUB1QVKpoMmy8=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=YOXMzJql2k0vowftr8qBSYtpwgGOF7i6etwKTNHxlBHjobmLrWFaeLjO8z4jzLeoLPnm44dMRaHZ09xxP+VXIzWR42kgzQD5SRZjJDRXijXcjVY4c3PLcGSmvk3DpAv5vHwed9PRvHYpUdT4HbUUMTScX+U7xLGapn1Kwq5fCuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=nzAsMR1k; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=nzAsMR1k; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 75CDC1FCFD
	for <linux-btrfs@vger.kernel.org>; Sun,  6 Oct 2024 23:21:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1728256918; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=ZvTE9DQV5W0pUcCliw27yVubDIxK0xcmbOOy5bzNp2k=;
	b=nzAsMR1kgiTBpz2xohhm6jOQrgwcUIA3+DRjDZ7m+Ca5syMssFtiCM0+Te0xgZ1HUcCs5J
	+9ZBMSF9Kw422O9TC2tuaTyrVvBxJcbNhhki3M6caP9ictisPjr9OIn/FjLixpkpA8nZP1
	2z+m6MfMqNr3y9MYG9PhXI3eLplcRow=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=nzAsMR1k
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1728256918; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=ZvTE9DQV5W0pUcCliw27yVubDIxK0xcmbOOy5bzNp2k=;
	b=nzAsMR1kgiTBpz2xohhm6jOQrgwcUIA3+DRjDZ7m+Ca5syMssFtiCM0+Te0xgZ1HUcCs5J
	+9ZBMSF9Kw422O9TC2tuaTyrVvBxJcbNhhki3M6caP9ictisPjr9OIn/FjLixpkpA8nZP1
	2z+m6MfMqNr3y9MYG9PhXI3eLplcRow=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B4CF213793
	for <linux-btrfs@vger.kernel.org>; Sun,  6 Oct 2024 23:21:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id XmbqHZUbA2cMZAAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Sun, 06 Oct 2024 23:21:57 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2] btrfs: fix the delalloc range locking if sector size < page size
Date: Mon,  7 Oct 2024 09:51:40 +1030
Message-ID: <305e53f3931e164c8ab3b09c059ea68bd792a4b2.1728256845.git.wqu@suse.com>
X-Mailer: git-send-email 2.46.2
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 75CDC1FCFD
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
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_DN_NONE(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:dkim,suse.com:mid];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[suse.com:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01
X-Spam-Flag: NO

Inside lock_delalloc_folios(), there are several problems related to
sector size < page size handling:

- Set the writer locks without checking if the folio is still valid
  We call btrfs_folio_start_writer_lock() just like it's folio_lock().
  But since the folio may not even be the folio of the current mapping,
  we can easily screw up the folio->private.

- The range is not clampped inside the page
  This means we can over write other bitmaps if the start/len is not
  properly handled, and trigger the btrfs_subpage_assert().

- @processed_end is always rounded up to page end
  If the delalloc range is not page aligned, and we need to retry
  (returning -EAGAIN), then we will unlock to the page end.

  Thankfully this is not a huge problem, as now
  btrfs_folio_end_writer_lock() can handle range larger than the locked
  range, and only unlock what is already locked.

Fix all these problems by:

- Lock and check the folio first, then call
  btrfs_folio_set_writer_lock()
  So that if we got a folio not belonging to the inode, we won't
  touch folio->private.

- Properly truncate the range inside the page

- Update @processed_end to the locked range end

- Remove btrfs_folio_start_writer_lock()
  Since all callsites only utilize btrfs_folio_set_writer_lock() now,
  remove the unnecessary btrfs_folio_start_writer_lock().

Fixes: 1e1de38792e0 ("btrfs: make process_one_page() to handle subpage locking")
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
Changelog:
v2:
- Remove the unused btrfs_folio_start_writer_lock() function
---
 fs/btrfs/extent_io.c | 15 +++++++-------
 fs/btrfs/subpage.c   | 47 --------------------------------------------
 fs/btrfs/subpage.h   |  2 --
 3 files changed, 7 insertions(+), 57 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index e0b43640849e..0448cee2b983 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -262,22 +262,21 @@ static noinline int lock_delalloc_folios(struct inode *inode,
 
 		for (i = 0; i < found_folios; i++) {
 			struct folio *folio = fbatch.folios[i];
-			u32 len = end + 1 - start;
+			u64 range_start = max_t(u64, folio_pos(folio), start);
+			u32 range_len = min_t(u64, folio_pos(folio) + folio_size(folio),
+					      end + 1) - range_start;
 
 			if (folio == locked_folio)
 				continue;
 
-			if (btrfs_folio_start_writer_lock(fs_info, folio, start,
-							  len))
-				goto out;
-
+			folio_lock(folio);
 			if (!folio_test_dirty(folio) || folio->mapping != mapping) {
-				btrfs_folio_end_writer_lock(fs_info, folio, start,
-							    len);
+				folio_unlock(folio);
 				goto out;
 			}
+			btrfs_folio_set_writer_lock(fs_info, folio, range_start, range_len);
 
-			processed_end = folio_pos(folio) + folio_size(folio) - 1;
+			processed_end = range_start + range_len - 1;
 		}
 		folio_batch_release(&fbatch);
 		cond_resched();
diff --git a/fs/btrfs/subpage.c b/fs/btrfs/subpage.c
index f98ce74b450e..3c1e34ddda74 100644
--- a/fs/btrfs/subpage.c
+++ b/fs/btrfs/subpage.c
@@ -333,26 +333,6 @@ static void btrfs_subpage_clamp_range(struct folio *folio, u64 *start, u32 *len)
 			     orig_start + orig_len) - *start;
 }
 
-static void btrfs_subpage_start_writer(const struct btrfs_fs_info *fs_info,
-				       struct folio *folio, u64 start, u32 len)
-{
-	struct btrfs_subpage *subpage = folio_get_private(folio);
-	const int start_bit = subpage_calc_start_bit(fs_info, folio, locked, start, len);
-	const int nbits = (len >> fs_info->sectorsize_bits);
-	unsigned long flags;
-	int ret;
-
-	btrfs_subpage_assert(fs_info, folio, start, len);
-
-	spin_lock_irqsave(&subpage->lock, flags);
-	ASSERT(atomic_read(&subpage->readers) == 0);
-	assert_bitmap_range_all_zero(fs_info, folio, start, len);
-	bitmap_set(subpage->bitmaps, start_bit, nbits);
-	ret = atomic_add_return(nbits, &subpage->writers);
-	ASSERT(ret == nbits);
-	spin_unlock_irqrestore(&subpage->lock, flags);
-}
-
 static bool btrfs_subpage_end_and_test_writer(const struct btrfs_fs_info *fs_info,
 					      struct folio *folio, u64 start, u32 len)
 {
@@ -389,33 +369,6 @@ static bool btrfs_subpage_end_and_test_writer(const struct btrfs_fs_info *fs_inf
 	return last;
 }
 
-/*
- * Lock a folio for delalloc page writeback.
- *
- * Return -EAGAIN if the page is not properly initialized.
- * Return 0 with the page locked, and writer counter updated.
- *
- * Even with 0 returned, the page still need extra check to make sure
- * it's really the correct page, as the caller is using
- * filemap_get_folios_contig(), which can race with page invalidating.
- */
-int btrfs_folio_start_writer_lock(const struct btrfs_fs_info *fs_info,
-				  struct folio *folio, u64 start, u32 len)
-{
-	if (unlikely(!fs_info) || !btrfs_is_subpage(fs_info, folio->mapping)) {
-		folio_lock(folio);
-		return 0;
-	}
-	folio_lock(folio);
-	if (!folio_test_private(folio) || !folio_get_private(folio)) {
-		folio_unlock(folio);
-		return -EAGAIN;
-	}
-	btrfs_subpage_clamp_range(folio, &start, &len);
-	btrfs_subpage_start_writer(fs_info, folio, start, len);
-	return 0;
-}
-
 /*
  * Handle different locked folios:
  *
diff --git a/fs/btrfs/subpage.h b/fs/btrfs/subpage.h
index 48a481b327ca..cbee866152de 100644
--- a/fs/btrfs/subpage.h
+++ b/fs/btrfs/subpage.h
@@ -100,8 +100,6 @@ void btrfs_subpage_start_reader(const struct btrfs_fs_info *fs_info,
 void btrfs_subpage_end_reader(const struct btrfs_fs_info *fs_info,
 			      struct folio *folio, u64 start, u32 len);
 
-int btrfs_folio_start_writer_lock(const struct btrfs_fs_info *fs_info,
-				  struct folio *folio, u64 start, u32 len);
 void btrfs_folio_end_writer_lock(const struct btrfs_fs_info *fs_info,
 				 struct folio *folio, u64 start, u32 len);
 void btrfs_folio_set_writer_lock(const struct btrfs_fs_info *fs_info,
-- 
2.46.2


