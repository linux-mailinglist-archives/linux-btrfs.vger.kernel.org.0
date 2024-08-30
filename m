Return-Path: <linux-btrfs+bounces-7687-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B231796583F
	for <lists+linux-btrfs@lfdr.de>; Fri, 30 Aug 2024 09:18:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B2B028136A
	for <lists+linux-btrfs@lfdr.de>; Fri, 30 Aug 2024 07:18:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DA9B1531FE;
	Fri, 30 Aug 2024 07:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="egscyZ13";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="egscyZ13"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E931614B96F
	for <linux-btrfs@vger.kernel.org>; Fri, 30 Aug 2024 07:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725002323; cv=none; b=U7yPWu1HUq7eKVSj6CcaXSwv0vydbflTJW9nCVk20mUBVoWVh54nS9LsRxkd/zO12z7doLHpmSUsyAz0pjtSdEnCQhzwzoxCmAcoFnbGs93m6zKuQZ3dyo/2GlO3de5UaN6O7JYAcv1nBSQ30gpEnrfpplVl9PcQfyhxJsbOJ9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725002323; c=relaxed/simple;
	bh=pym+uxxV4j8z7tzN3E5t43V8ZF3pp3bMZwqAktNVvKc=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=BOBO9hfJbwgtiiGt9d9H3acsUZyS+9WPwqO2SwpuArZ3AQEpmmTKFV6rPpF8JW6q2HVnDuOaUXDY4UnYyied+xO80ojV8mNhgUJTaOMz2KyV+y1b7Liu6tNcSoEZqLsWgwpflBy8L1f8FwgqL8Dn/Zzx5qajrRQwZbZdopkiE/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=egscyZ13; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=egscyZ13; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 1707D21A16
	for <linux-btrfs@vger.kernel.org>; Fri, 30 Aug 2024 07:18:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1725002319; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=w9tn+RgoF1+Zfd4l2GP1kwX6WOLfvEZvltqnSguegLA=;
	b=egscyZ1323kEAhTVLeOw8z4zVpgrbfjmkssOJtJyVEPygb4x0C9rw2ZByw0bQN1/y1sMST
	dTJrwltjuiXsF1N+Nf+ZMH0xAc6dBJNfmiBKQq2jPMRMs9u1eixGh+P4ebIvz7mvDscMjh
	xhWO3ylMR/vJHtCVONck/zpM8mVkkBs=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=egscyZ13
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1725002319; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=w9tn+RgoF1+Zfd4l2GP1kwX6WOLfvEZvltqnSguegLA=;
	b=egscyZ1323kEAhTVLeOw8z4zVpgrbfjmkssOJtJyVEPygb4x0C9rw2ZByw0bQN1/y1sMST
	dTJrwltjuiXsF1N+Nf+ZMH0xAc6dBJNfmiBKQq2jPMRMs9u1eixGh+P4ebIvz7mvDscMjh
	xhWO3ylMR/vJHtCVONck/zpM8mVkkBs=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 535C013A44
	for <linux-btrfs@vger.kernel.org>; Fri, 30 Aug 2024 07:18:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id EhvQBU5y0Wa9XwAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Fri, 30 Aug 2024 07:18:38 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: remove btrfs_folio_end_all_writers()
Date: Fri, 30 Aug 2024 16:48:20 +0930
Message-ID: <60a56967e6ebbeb47726c31883a6d453abc561c8.1725002293.git.wqu@suse.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 1707D21A16
X-Spam-Level: 
X-Spamd-Result: default: False [-5.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	DWL_DNSWL_MED(-2.00)[suse.com:dkim];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	FROM_EQ_ENVFROM(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:dkim,suse.com:mid];
	RCVD_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[suse.com:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -5.01
X-Spam-Flag: NO

The function btrfs_folio_end_all_writers() is only utilized in
extent_writepage() as a way to unlock all subpage range (for both
successful submission and error handling).

Meanwhile we have a similar function, btrfs_folio_end_writer_lock().

The difference is, btrfs_folio_end_writer_lock() expects a range that is
a subset of the already locked range.

This limit on btrfs_folio_end_writer_lock() is a little overkilled,
preventing it from being utilized for error paths.

So here we enhance btrfs_folio_end_writer_lock() to accept a superset of
the locked range, and only end the locked subset.
This means we can replace btrfs_folio_end_all_writers() with
btrfs_folio_end_writer_lock() instead.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/extent_io.c |  3 ++-
 fs/btrfs/subpage.c   | 57 +++++++-------------------------------------
 fs/btrfs/subpage.h   |  1 -
 3 files changed, 10 insertions(+), 51 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index bd1a7b2fc71a..fbb9fadaf0a0 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -1467,7 +1467,8 @@ static int extent_writepage(struct folio *folio, struct btrfs_bio_ctrl *bio_ctrl
 		mapping_set_error(folio->mapping, ret);
 	}
 
-	btrfs_folio_end_all_writers(inode_to_fs_info(inode), folio);
+	btrfs_folio_end_writer_lock(inode_to_fs_info(inode), folio,
+				    page_start, PAGE_SIZE);
 	ASSERT(ret <= 0);
 	return ret;
 }
diff --git a/fs/btrfs/subpage.c b/fs/btrfs/subpage.c
index ca7d2aedfa8d..7fe58c4d9923 100644
--- a/fs/btrfs/subpage.c
+++ b/fs/btrfs/subpage.c
@@ -322,6 +322,8 @@ static bool btrfs_subpage_end_and_test_writer(const struct btrfs_fs_info *fs_inf
 	const int start_bit = subpage_calc_start_bit(fs_info, folio, locked, start, len);
 	const int nbits = (len >> fs_info->sectorsize_bits);
 	unsigned long flags;
+	unsigned int cleared = 0;
+	int bit = start_bit;
 	bool last;
 
 	btrfs_subpage_assert(fs_info, folio, start, len);
@@ -339,11 +341,12 @@ static bool btrfs_subpage_end_and_test_writer(const struct btrfs_fs_info *fs_inf
 		return true;
 	}
 
-	ASSERT(atomic_read(&subpage->writers) >= nbits);
-	/* The target range should have been locked. */
-	ASSERT(bitmap_test_range_all_set(subpage->bitmaps, start_bit, nbits));
-	bitmap_clear(subpage->bitmaps, start_bit, nbits);
-	last = atomic_sub_and_test(nbits, &subpage->writers);
+	for_each_set_bit_from(bit, subpage->bitmaps, start_bit + nbits) {
+		clear_bit(bit, subpage->bitmaps);
+		cleared++;
+	}
+	ASSERT(atomic_read(&subpage->writers) >= cleared);
+	last = atomic_sub_and_test(cleared, &subpage->writers);
 	spin_unlock_irqrestore(&subpage->lock, flags);
 	return last;
 }
@@ -825,50 +828,6 @@ bool btrfs_subpage_find_writer_locked(const struct btrfs_fs_info *fs_info,
 	return found;
 }
 
-/*
- * Unlike btrfs_folio_end_writer_lock() which unlocks a specified subpage range,
- * this ends all writer locked ranges of a page.
- *
- * This is for the locked page of extent_writepage(), as the locked page
- * can contain several locked subpage ranges.
- */
-void btrfs_folio_end_all_writers(const struct btrfs_fs_info *fs_info, struct folio *folio)
-{
-	struct btrfs_subpage *subpage = folio_get_private(folio);
-	u64 folio_start = folio_pos(folio);
-	u64 cur = folio_start;
-
-	ASSERT(folio_test_locked(folio));
-	if (!btrfs_is_subpage(fs_info, folio->mapping)) {
-		folio_unlock(folio);
-		return;
-	}
-
-	/* The page has no new delalloc range locked on it. Just plain unlock. */
-	if (atomic_read(&subpage->writers) == 0) {
-		folio_unlock(folio);
-		return;
-	}
-	while (cur < folio_start + PAGE_SIZE) {
-		u64 found_start;
-		u32 found_len;
-		bool found;
-		bool last;
-
-		found = btrfs_subpage_find_writer_locked(fs_info, folio, cur,
-							 &found_start, &found_len);
-		if (!found)
-			break;
-		last = btrfs_subpage_end_and_test_writer(fs_info, folio,
-							 found_start, found_len);
-		if (last) {
-			folio_unlock(folio);
-			break;
-		}
-		cur = found_start + found_len;
-	}
-}
-
 #define GET_SUBPAGE_BITMAP(subpage, fs_info, name, dst)			\
 {									\
 	const int sectors_per_page = fs_info->sectors_per_page;		\
diff --git a/fs/btrfs/subpage.h b/fs/btrfs/subpage.h
index b67cd5f6539d..f90e0c4f4cab 100644
--- a/fs/btrfs/subpage.h
+++ b/fs/btrfs/subpage.h
@@ -109,7 +109,6 @@ void btrfs_folio_set_writer_lock(const struct btrfs_fs_info *fs_info,
 bool btrfs_subpage_find_writer_locked(const struct btrfs_fs_info *fs_info,
 				      struct folio *folio, u64 search_start,
 				      u64 *found_start_ret, u32 *found_len_ret);
-void btrfs_folio_end_all_writers(const struct btrfs_fs_info *fs_info, struct folio *folio);
 
 /*
  * Template for subpage related operations.
-- 
2.46.0


