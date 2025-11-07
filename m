Return-Path: <linux-btrfs+bounces-18793-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FC00C3EED0
	for <lists+linux-btrfs@lfdr.de>; Fri, 07 Nov 2025 09:18:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2BF024EBBD5
	for <lists+linux-btrfs@lfdr.de>; Fri,  7 Nov 2025 08:18:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2BEA30FC2A;
	Fri,  7 Nov 2025 08:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Ql9W3Xdh";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="GwKY1iq7"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C561317C211
	for <linux-btrfs@vger.kernel.org>; Fri,  7 Nov 2025 08:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762503446; cv=none; b=nxra31D56zIhGrU8IBIbuNIKCtCa9YyHitPDh/KKqR/2SDRPWoN3Tmy/8O+B72sNFBMsMi1/MQxEN5YTEmey/LYMqq7sSl1GDFWK3eGZ1Wlm9dBoiPA+hxpSpw/aThVoQ3pA0joYdozsTUy7K5KQ0vFavdcuPUxqSQUVkU7n+U4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762503446; c=relaxed/simple;
	bh=fBE1d9XqnsKNAhBbS2nN64krwy9WuCkS1OU6zERWz9k=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=melGo5Um4g+sYkt3Nvikt7c/PEjXoBRIE7RZQSCByavtpPtId7ifrVS3MR4sweMhFxGqHegk5yLYdPB1IG1bXEb/KVZ4bttt7rBjVLXDwyIpqtEoADTxVtoolhJeD6yHHxdhG7WdPTcp++OVlA73t+1718IFe5L0Cl+a9jjFSLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Ql9W3Xdh; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=GwKY1iq7; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E08351F78E
	for <linux-btrfs@vger.kernel.org>; Fri,  7 Nov 2025 08:17:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1762503442; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=XqzNwiVe/+ZgJ6VgBtGrGMZLrpOsX4MLEHFVRi7qRm8=;
	b=Ql9W3XdhsFr1Cu2eA2Vo0GoTlHfTyGZC1ezfep2+OVns9WOJMA/WWG39f+uJsB742PXoNF
	8M675XJw0LWNYoaCwb7rOwWAJiDQYtHAUoOXRyJEnLCnRQdKfgXCaXuBMAJ6NZGfogRUQR
	dOpIJ98Sl+i2ZsDYsEVN3cxA9mIpPuM=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=GwKY1iq7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1762503441; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=XqzNwiVe/+ZgJ6VgBtGrGMZLrpOsX4MLEHFVRi7qRm8=;
	b=GwKY1iq7NvwoH0mbqKrUFSTRVTRIbx4WjfqikhVFg6kGoArwb+CxGBVR1yW2Zj2mGMA/6W
	mmHsuGVi957HAvLF0e8U8pG1D6dc3gm/+dNqTX8aUHTqxMVGeAqL9aZ9ajcm1w7AlPRzw7
	Xsk0cMJnqH22mBRdeDU9yVotK0g29O0=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 21A221395F
	for <linux-btrfs@vger.kernel.org>; Fri,  7 Nov 2025 08:17:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id O4vDNBCrDWkcPQAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Fri, 07 Nov 2025 08:17:20 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH RFC] btrfs: use guard for btrfs_folio_state::lock
Date: Fri,  7 Nov 2025 18:47:03 +1030
Message-ID: <58baf1fc6d077aacc5db3b2bf42677fc3fbbb6a8.1762503411.git.wqu@suse.com>
X-Mailer: git-send-email 2.51.2
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: E08351F78E
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:dkim,suse.com:mid,suse.com:email];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RCPT_COUNT_ONE(0.00)[1];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	ARC_NA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DKIM_TRACE(0.00)[suse.com:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:dkim,suse.com:mid,suse.com:email]
X-Spam-Score: -3.01

Most call sites are fine for a simple guard(), some call sites need
scoped_guard().

For the scoped_guard() usage, it increase one indent for the code,
personally speaking I like the extra indent to make the critical section
more obvious, but I also understand not all call site can afford the
extra indent.

Thankfully for subpage cases, it's completely fine.

Overall this makes code much shorter, and we can return without
bothering manually unlocking, saving several temporary variables.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
Reason for RFC:
We're still not yet determined if we should brace the new auto-cleanup
scheme.

Now I'm completely on the boat of the scoped based auto-cleanup, even
for the subpage code where the lock is already super straightforward.
For more complex cases the benefit will be more obvious.

So far the only disadvantage is my old mindset, but I believe time will
get it fixed.
---
 fs/btrfs/subpage.c | 112 +++++++++++++++------------------------------
 1 file changed, 36 insertions(+), 76 deletions(-)

diff --git a/fs/btrfs/subpage.c b/fs/btrfs/subpage.c
index 80cd27d3267f..85d44a6ece87 100644
--- a/fs/btrfs/subpage.c
+++ b/fs/btrfs/subpage.c
@@ -225,14 +225,12 @@ static bool btrfs_subpage_end_and_test_lock(const struct btrfs_fs_info *fs_info,
 	struct btrfs_folio_state *bfs = folio_get_private(folio);
 	const int start_bit = subpage_calc_start_bit(fs_info, folio, locked, start, len);
 	const int nbits = (len >> fs_info->sectorsize_bits);
-	unsigned long flags;
 	unsigned int cleared = 0;
 	int bit = start_bit;
-	bool last;
 
 	btrfs_subpage_assert(fs_info, folio, start, len);
 
-	spin_lock_irqsave(&bfs->lock, flags);
+	guard(spinlock_irqsave)(&bfs->lock);
 	/*
 	 * We have call sites passing @lock_page into
 	 * extent_clear_unlock_delalloc() for compression path.
@@ -240,19 +238,15 @@ static bool btrfs_subpage_end_and_test_lock(const struct btrfs_fs_info *fs_info,
 	 * This @locked_page is locked by plain lock_page(), thus its
 	 * subpage::locked is 0.  Handle them in a special way.
 	 */
-	if (atomic_read(&bfs->nr_locked) == 0) {
-		spin_unlock_irqrestore(&bfs->lock, flags);
+	if (atomic_read(&bfs->nr_locked) == 0)
 		return true;
-	}
 
 	for_each_set_bit_from(bit, bfs->bitmaps, start_bit + nbits) {
 		clear_bit(bit, bfs->bitmaps);
 		cleared++;
 	}
 	ASSERT(atomic_read(&bfs->nr_locked) >= cleared);
-	last = atomic_sub_and_test(cleared, &bfs->nr_locked);
-	spin_unlock_irqrestore(&bfs->lock, flags);
-	return last;
+	return atomic_sub_and_test(cleared, &bfs->nr_locked);
 }
 
 /*
@@ -307,7 +301,6 @@ void btrfs_folio_end_lock_bitmap(const struct btrfs_fs_info *fs_info,
 	struct btrfs_folio_state *bfs = folio_get_private(folio);
 	const unsigned int blocks_per_folio = btrfs_blocks_per_folio(fs_info, folio);
 	const int start_bit = blocks_per_folio * btrfs_bitmap_nr_locked;
-	unsigned long flags;
 	bool last = false;
 	int cleared = 0;
 	int bit;
@@ -323,14 +316,14 @@ void btrfs_folio_end_lock_bitmap(const struct btrfs_fs_info *fs_info,
 		return;
 	}
 
-	spin_lock_irqsave(&bfs->lock, flags);
-	for_each_set_bit(bit, &bitmap, blocks_per_folio) {
-		if (test_and_clear_bit(bit + start_bit, bfs->bitmaps))
-			cleared++;
+	scoped_guard(spinlock_irqsave, &bfs->lock) {
+		for_each_set_bit(bit, &bitmap, blocks_per_folio) {
+			if (test_and_clear_bit(bit + start_bit, bfs->bitmaps))
+				cleared++;
+		}
+		ASSERT(atomic_read(&bfs->nr_locked) >= cleared);
+		last = atomic_sub_and_test(cleared, &bfs->nr_locked);
 	}
-	ASSERT(atomic_read(&bfs->nr_locked) >= cleared);
-	last = atomic_sub_and_test(cleared, &bfs->nr_locked);
-	spin_unlock_irqrestore(&bfs->lock, flags);
 	if (last)
 		folio_unlock(folio);
 }
@@ -359,13 +352,11 @@ void btrfs_subpage_set_uptodate(const struct btrfs_fs_info *fs_info,
 	struct btrfs_folio_state *bfs = folio_get_private(folio);
 	unsigned int start_bit = subpage_calc_start_bit(fs_info, folio,
 							uptodate, start, len);
-	unsigned long flags;
 
-	spin_lock_irqsave(&bfs->lock, flags);
+	guard(spinlock_irqsave)(&bfs->lock);
 	bitmap_set(bfs->bitmaps, start_bit, len >> fs_info->sectorsize_bits);
 	if (subpage_test_bitmap_all_set(fs_info, folio, uptodate))
 		folio_mark_uptodate(folio);
-	spin_unlock_irqrestore(&bfs->lock, flags);
 }
 
 void btrfs_subpage_clear_uptodate(const struct btrfs_fs_info *fs_info,
@@ -374,12 +365,10 @@ void btrfs_subpage_clear_uptodate(const struct btrfs_fs_info *fs_info,
 	struct btrfs_folio_state *bfs = folio_get_private(folio);
 	unsigned int start_bit = subpage_calc_start_bit(fs_info, folio,
 							uptodate, start, len);
-	unsigned long flags;
 
-	spin_lock_irqsave(&bfs->lock, flags);
+	guard(spinlock_irqsave)(&bfs->lock);
 	bitmap_clear(bfs->bitmaps, start_bit, len >> fs_info->sectorsize_bits);
 	folio_clear_uptodate(folio);
-	spin_unlock_irqrestore(&bfs->lock, flags);
 }
 
 void btrfs_subpage_set_dirty(const struct btrfs_fs_info *fs_info,
@@ -388,11 +377,9 @@ void btrfs_subpage_set_dirty(const struct btrfs_fs_info *fs_info,
 	struct btrfs_folio_state *bfs = folio_get_private(folio);
 	unsigned int start_bit = subpage_calc_start_bit(fs_info, folio,
 							dirty, start, len);
-	unsigned long flags;
 
-	spin_lock_irqsave(&bfs->lock, flags);
-	bitmap_set(bfs->bitmaps, start_bit, len >> fs_info->sectorsize_bits);
-	spin_unlock_irqrestore(&bfs->lock, flags);
+	scoped_guard(spinlock_irqsave, &bfs->lock)
+		bitmap_set(bfs->bitmaps, start_bit, len >> fs_info->sectorsize_bits);
 	folio_mark_dirty(folio);
 }
 
@@ -412,15 +399,12 @@ bool btrfs_subpage_clear_and_test_dirty(const struct btrfs_fs_info *fs_info,
 	struct btrfs_folio_state *bfs = folio_get_private(folio);
 	unsigned int start_bit = subpage_calc_start_bit(fs_info, folio,
 							dirty, start, len);
-	unsigned long flags;
-	bool last = false;
 
-	spin_lock_irqsave(&bfs->lock, flags);
+	guard(spinlock_irqsave)(&bfs->lock);
 	bitmap_clear(bfs->bitmaps, start_bit, len >> fs_info->sectorsize_bits);
 	if (subpage_test_bitmap_all_zero(fs_info, folio, dirty))
-		last = true;
-	spin_unlock_irqrestore(&bfs->lock, flags);
-	return last;
+		return true;
+	return false;
 }
 
 void btrfs_subpage_clear_dirty(const struct btrfs_fs_info *fs_info,
@@ -439,10 +423,9 @@ void btrfs_subpage_set_writeback(const struct btrfs_fs_info *fs_info,
 	struct btrfs_folio_state *bfs = folio_get_private(folio);
 	unsigned int start_bit = subpage_calc_start_bit(fs_info, folio,
 							writeback, start, len);
-	unsigned long flags;
 	bool keep_write;
 
-	spin_lock_irqsave(&bfs->lock, flags);
+	guard(spinlock_irqsave)(&bfs->lock);
 	bitmap_set(bfs->bitmaps, start_bit, len >> fs_info->sectorsize_bits);
 
 	/*
@@ -454,7 +437,6 @@ void btrfs_subpage_set_writeback(const struct btrfs_fs_info *fs_info,
 	keep_write = folio_test_dirty(folio);
 	if (!folio_test_writeback(folio))
 		__folio_start_writeback(folio, keep_write);
-	spin_unlock_irqrestore(&bfs->lock, flags);
 }
 
 void btrfs_subpage_clear_writeback(const struct btrfs_fs_info *fs_info,
@@ -463,15 +445,13 @@ void btrfs_subpage_clear_writeback(const struct btrfs_fs_info *fs_info,
 	struct btrfs_folio_state *bfs = folio_get_private(folio);
 	unsigned int start_bit = subpage_calc_start_bit(fs_info, folio,
 							writeback, start, len);
-	unsigned long flags;
 
-	spin_lock_irqsave(&bfs->lock, flags);
+	guard(spinlock_irqsave)(&bfs->lock);
 	bitmap_clear(bfs->bitmaps, start_bit, len >> fs_info->sectorsize_bits);
 	if (subpage_test_bitmap_all_zero(fs_info, folio, writeback)) {
 		ASSERT(folio_test_writeback(folio));
 		folio_end_writeback(folio);
 	}
-	spin_unlock_irqrestore(&bfs->lock, flags);
 }
 
 void btrfs_subpage_set_ordered(const struct btrfs_fs_info *fs_info,
@@ -480,12 +460,10 @@ void btrfs_subpage_set_ordered(const struct btrfs_fs_info *fs_info,
 	struct btrfs_folio_state *bfs = folio_get_private(folio);
 	unsigned int start_bit = subpage_calc_start_bit(fs_info, folio,
 							ordered, start, len);
-	unsigned long flags;
 
-	spin_lock_irqsave(&bfs->lock, flags);
+	guard(spinlock_irqsave)(&bfs->lock);
 	bitmap_set(bfs->bitmaps, start_bit, len >> fs_info->sectorsize_bits);
 	folio_set_ordered(folio);
-	spin_unlock_irqrestore(&bfs->lock, flags);
 }
 
 void btrfs_subpage_clear_ordered(const struct btrfs_fs_info *fs_info,
@@ -494,13 +472,11 @@ void btrfs_subpage_clear_ordered(const struct btrfs_fs_info *fs_info,
 	struct btrfs_folio_state *bfs = folio_get_private(folio);
 	unsigned int start_bit = subpage_calc_start_bit(fs_info, folio,
 							ordered, start, len);
-	unsigned long flags;
 
-	spin_lock_irqsave(&bfs->lock, flags);
+	guard(spinlock_irqsave)(&bfs->lock);
 	bitmap_clear(bfs->bitmaps, start_bit, len >> fs_info->sectorsize_bits);
 	if (subpage_test_bitmap_all_zero(fs_info, folio, ordered))
 		folio_clear_ordered(folio);
-	spin_unlock_irqrestore(&bfs->lock, flags);
 }
 
 void btrfs_subpage_set_checked(const struct btrfs_fs_info *fs_info,
@@ -509,13 +485,11 @@ void btrfs_subpage_set_checked(const struct btrfs_fs_info *fs_info,
 	struct btrfs_folio_state *bfs = folio_get_private(folio);
 	unsigned int start_bit = subpage_calc_start_bit(fs_info, folio,
 							checked, start, len);
-	unsigned long flags;
 
-	spin_lock_irqsave(&bfs->lock, flags);
+	guard(spinlock_irqsave)(&bfs->lock);
 	bitmap_set(bfs->bitmaps, start_bit, len >> fs_info->sectorsize_bits);
 	if (subpage_test_bitmap_all_set(fs_info, folio, checked))
 		folio_set_checked(folio);
-	spin_unlock_irqrestore(&bfs->lock, flags);
 }
 
 void btrfs_subpage_clear_checked(const struct btrfs_fs_info *fs_info,
@@ -524,12 +498,10 @@ void btrfs_subpage_clear_checked(const struct btrfs_fs_info *fs_info,
 	struct btrfs_folio_state *bfs = folio_get_private(folio);
 	unsigned int start_bit = subpage_calc_start_bit(fs_info, folio,
 							checked, start, len);
-	unsigned long flags;
 
-	spin_lock_irqsave(&bfs->lock, flags);
+	guard(spinlock_irqsave)(&bfs->lock);
 	bitmap_clear(bfs->bitmaps, start_bit, len >> fs_info->sectorsize_bits);
 	folio_clear_checked(folio);
-	spin_unlock_irqrestore(&bfs->lock, flags);
 }
 
 /*
@@ -543,14 +515,10 @@ bool btrfs_subpage_test_##name(const struct btrfs_fs_info *fs_info,	\
 	struct btrfs_folio_state *bfs = folio_get_private(folio);	\
 	unsigned int start_bit = subpage_calc_start_bit(fs_info, folio,	\
 						name, start, len);	\
-	unsigned long flags;						\
-	bool ret;							\
 									\
-	spin_lock_irqsave(&bfs->lock, flags);			\
-	ret = bitmap_test_range_all_set(bfs->bitmaps, start_bit,	\
+	guard(spinlock_irqsave)(&bfs->lock);				\
+	return bitmap_test_range_all_set(bfs->bitmaps, start_bit,	\
 				len >> fs_info->sectorsize_bits);	\
-	spin_unlock_irqrestore(&bfs->lock, flags);			\
-	return ret;							\
 }
 IMPLEMENT_BTRFS_SUBPAGE_TEST_OP(uptodate);
 IMPLEMENT_BTRFS_SUBPAGE_TEST_OP(dirty);
@@ -688,7 +656,6 @@ void btrfs_folio_assert_not_dirty(const struct btrfs_fs_info *fs_info,
 	struct btrfs_folio_state *bfs;
 	unsigned int start_bit;
 	unsigned int nbits;
-	unsigned long flags;
 
 	if (!IS_ENABLED(CONFIG_BTRFS_ASSERT))
 		return;
@@ -702,13 +669,12 @@ void btrfs_folio_assert_not_dirty(const struct btrfs_fs_info *fs_info,
 	nbits = len >> fs_info->sectorsize_bits;
 	bfs = folio_get_private(folio);
 	ASSERT(bfs);
-	spin_lock_irqsave(&bfs->lock, flags);
+	guard(spinlock_irqsave)(&bfs->lock);
 	if (unlikely(!bitmap_test_range_all_zero(bfs->bitmaps, start_bit, nbits))) {
 		SUBPAGE_DUMP_BITMAP(fs_info, folio, dirty, start, len);
 		ASSERT(bitmap_test_range_all_zero(bfs->bitmaps, start_bit, nbits));
 	}
 	ASSERT(bitmap_test_range_all_zero(bfs->bitmaps, start_bit, nbits));
-	spin_unlock_irqrestore(&bfs->lock, flags);
 }
 
 /*
@@ -722,7 +688,6 @@ void btrfs_folio_set_lock(const struct btrfs_fs_info *fs_info,
 			  struct folio *folio, u64 start, u32 len)
 {
 	struct btrfs_folio_state *bfs;
-	unsigned long flags;
 	unsigned int start_bit;
 	unsigned int nbits;
 	int ret;
@@ -734,7 +699,7 @@ void btrfs_folio_set_lock(const struct btrfs_fs_info *fs_info,
 	bfs = folio_get_private(folio);
 	start_bit = subpage_calc_start_bit(fs_info, folio, locked, start, len);
 	nbits = len >> fs_info->sectorsize_bits;
-	spin_lock_irqsave(&bfs->lock, flags);
+	guard(spinlock_irqsave)(&bfs->lock);
 	/* Target range should not yet be locked. */
 	if (unlikely(!bitmap_test_range_all_zero(bfs->bitmaps, start_bit, nbits))) {
 		SUBPAGE_DUMP_BITMAP(fs_info, folio, locked, start, len);
@@ -743,7 +708,6 @@ void btrfs_folio_set_lock(const struct btrfs_fs_info *fs_info,
 	bitmap_set(bfs->bitmaps, start_bit, nbits);
 	ret = atomic_add_return(nbits, &bfs->nr_locked);
 	ASSERT(ret <= btrfs_blocks_per_folio(fs_info, folio));
-	spin_unlock_irqrestore(&bfs->lock, flags);
 }
 
 /*
@@ -779,21 +743,19 @@ void __cold btrfs_subpage_dump_bitmap(const struct btrfs_fs_info *fs_info,
 	unsigned long ordered_bitmap;
 	unsigned long checked_bitmap;
 	unsigned long locked_bitmap;
-	unsigned long flags;
 
 	ASSERT(folio_test_private(folio) && folio_get_private(folio));
 	ASSERT(blocks_per_folio > 1);
 	bfs = folio_get_private(folio);
 
-	spin_lock_irqsave(&bfs->lock, flags);
-	GET_SUBPAGE_BITMAP(fs_info, folio, uptodate, &uptodate_bitmap);
-	GET_SUBPAGE_BITMAP(fs_info, folio, dirty, &dirty_bitmap);
-	GET_SUBPAGE_BITMAP(fs_info, folio, writeback, &writeback_bitmap);
-	GET_SUBPAGE_BITMAP(fs_info, folio, ordered, &ordered_bitmap);
-	GET_SUBPAGE_BITMAP(fs_info, folio, checked, &checked_bitmap);
-	GET_SUBPAGE_BITMAP(fs_info, folio, locked, &locked_bitmap);
-	spin_unlock_irqrestore(&bfs->lock, flags);
-
+	scoped_guard(spinlock_irqsave, &bfs->lock) {
+		GET_SUBPAGE_BITMAP(fs_info, folio, uptodate, &uptodate_bitmap);
+		GET_SUBPAGE_BITMAP(fs_info, folio, dirty, &dirty_bitmap);
+		GET_SUBPAGE_BITMAP(fs_info, folio, writeback, &writeback_bitmap);
+		GET_SUBPAGE_BITMAP(fs_info, folio, ordered, &ordered_bitmap);
+		GET_SUBPAGE_BITMAP(fs_info, folio, checked, &checked_bitmap);
+		GET_SUBPAGE_BITMAP(fs_info, folio, locked, &locked_bitmap);
+	}
 	dump_page(folio_page(folio, 0), "btrfs folio state dump");
 	btrfs_warn(fs_info,
 "start=%llu len=%u page=%llu, bitmaps uptodate=%*pbl dirty=%*pbl locked=%*pbl writeback=%*pbl ordered=%*pbl checked=%*pbl",
@@ -811,13 +773,11 @@ void btrfs_get_subpage_dirty_bitmap(struct btrfs_fs_info *fs_info,
 				    unsigned long *ret_bitmap)
 {
 	struct btrfs_folio_state *bfs;
-	unsigned long flags;
 
 	ASSERT(folio_test_private(folio) && folio_get_private(folio));
 	ASSERT(btrfs_blocks_per_folio(fs_info, folio) > 1);
 	bfs = folio_get_private(folio);
 
-	spin_lock_irqsave(&bfs->lock, flags);
+	guard(spinlock_irqsave)(&bfs->lock);
 	GET_SUBPAGE_BITMAP(fs_info, folio, dirty, ret_bitmap);
-	spin_unlock_irqrestore(&bfs->lock, flags);
 }
-- 
2.51.2


