Return-Path: <linux-btrfs+bounces-8671-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 66E90995B62
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Oct 2024 01:08:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5B0D284C10
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Oct 2024 23:08:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24A222178F1;
	Tue,  8 Oct 2024 23:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="qvH9K9Yf";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="qvH9K9Yf"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 818DE216446
	for <linux-btrfs@vger.kernel.org>; Tue,  8 Oct 2024 23:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728428855; cv=none; b=Xfhv4YxNOkmSZfgWyBqMF+uhzHswgrBPNVM7+WSRT8+LMEmUS/sfxDpCbdf0Adoe81k9Xla99IjqGzJNuH8ezMVo01h/eXkorZKF7Pg6PSIxI+w2yk2VvLUkKwrSDEphrSa2MwDYR7RE1imJGi+bJx4a+pNQlY+6A3pTmlwacjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728428855; c=relaxed/simple;
	bh=J62V5NpGrlyTrvdIKFTUZuV2vgI21JpTKQQBHbU4I2k=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RvIEzRF4KUeFSe/lW5L1pEH7S5hZUndqIUXsamF7DB9l2t03Tq1ahKkcROm2r57nzCn0YtdWzq34dkBU6twAs8MrWoileTLqk4VpY5QmXpB5CkATGNemdWQmGxUEK+7TRurbp0Qs4EkHQPeWOkk+70wCSt8+m125Xr5xWK5Se+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=qvH9K9Yf; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=qvH9K9Yf; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 10D981FE2B
	for <linux-btrfs@vger.kernel.org>; Tue,  8 Oct 2024 23:07:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1728428846; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lB3pMMjSx4WMuHNncgxrdvvwPl+gR559q81Dj4vWMAc=;
	b=qvH9K9YfN/t1/NhRa684k7Vu//ivox0/gEUr782jUMvqQCM7J2s/uo+/McYnaEOl+OAAiA
	fdunm+xZWuwydZ1a63mHwbdH8njZfiIeyUktg/SHbDpdx0SUgesoYP+rx3uFpxiOoNFxOT
	jVDO8PXw0Rq1AgRKpocYsHIdtCcMzFs=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1728428846; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lB3pMMjSx4WMuHNncgxrdvvwPl+gR559q81Dj4vWMAc=;
	b=qvH9K9YfN/t1/NhRa684k7Vu//ivox0/gEUr782jUMvqQCM7J2s/uo+/McYnaEOl+OAAiA
	fdunm+xZWuwydZ1a63mHwbdH8njZfiIeyUktg/SHbDpdx0SUgesoYP+rx3uFpxiOoNFxOT
	jVDO8PXw0Rq1AgRKpocYsHIdtCcMzFs=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4751F137CF
	for <linux-btrfs@vger.kernel.org>; Tue,  8 Oct 2024 23:07:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id kO5vAi27BWcVMwAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Tue, 08 Oct 2024 23:07:25 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v3 2/2] btrfs: remove unused btrfs_folio_start_writer_lock()
Date: Wed,  9 Oct 2024 09:37:04 +1030
Message-ID: <f6941f1cb19ba7d9cb1c179040c399f8eeb897b1.1728428503.git.wqu@suse.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <cover.1728428503.git.wqu@suse.com>
References: <cover.1728428503.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -2.80
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:mid,suse.com:email];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 

This function is not really suitable to lock a folio, as it lacks the
proper mapping checks, thus the locked folio may not even belong to
btrfs.

And due to the above reason, the last user inside lock_dealloc_folios()
is already removed, and we can remove this function.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/subpage.c | 47 ----------------------------------------------
 fs/btrfs/subpage.h |  2 --
 2 files changed, 49 deletions(-)

diff --git a/fs/btrfs/subpage.c b/fs/btrfs/subpage.c
index 17bc53a8df01..26d4d05dd165 100644
--- a/fs/btrfs/subpage.c
+++ b/fs/btrfs/subpage.c
@@ -295,26 +295,6 @@ static void btrfs_subpage_clamp_range(struct folio *folio, u64 *start, u32 *len)
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
-	ASSERT(bitmap_test_range_all_zero(subpage->bitmaps, start_bit, nbits));
-	bitmap_set(subpage->bitmaps, start_bit, nbits);
-	ret = atomic_add_return(nbits, &subpage->writers);
-	ASSERT(ret == nbits);
-	spin_unlock_irqrestore(&subpage->lock, flags);
-}
-
 static bool btrfs_subpage_end_and_test_writer(const struct btrfs_fs_info *fs_info,
 					      struct folio *folio, u64 start, u32 len)
 {
@@ -351,33 +331,6 @@ static bool btrfs_subpage_end_and_test_writer(const struct btrfs_fs_info *fs_inf
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
index d16fbddeda68..e4076c5b06bc 100644
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


