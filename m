Return-Path: <linux-btrfs+bounces-2470-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DC00858D82
	for <lists+linux-btrfs@lfdr.de>; Sat, 17 Feb 2024 07:30:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35839282B9D
	for <lists+linux-btrfs@lfdr.de>; Sat, 17 Feb 2024 06:30:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCB611CD2D;
	Sat, 17 Feb 2024 06:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="UTk+xrbL";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="UTk+xrbL"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 278011CABC
	for <linux-btrfs@vger.kernel.org>; Sat, 17 Feb 2024 06:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708151402; cv=none; b=WZx3yt//kPrA4pNaiwCaZHFW+EF3O4i01zfK1O0rNU17+/TGQwI1eovC0kY51k6lK3qg18cGJv+zYqZv/inFCVfGlrP0dp2Vz7COxwWa4ahHK5BDle/we2jxoVynChKHjwkpl4VHFznTfbJIS6nZNnSHnfPUPt9JR0EK4dtmnBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708151402; c=relaxed/simple;
	bh=npZ8ajFlOqmRkByx3AmS3urq5ZkPbPVBa9TERQXJnK4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pvDKF3R9zvH7s1ztya3gC7oHvy/It339ARpd/CAPCXjnxD2BPqXGwBN04egd76jO3S77cat0xGPMApk/6JEBvO/gstpfIUaRwqcMJF/u+JhU2Nh8eH8ZI9dmd7C4cCGfLuKhfqxclnEpyqMnfi5Po/v0xWfdxeCD6GFz+6lRvFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=UTk+xrbL; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=UTk+xrbL; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 4D6531FBA1
	for <linux-btrfs@vger.kernel.org>; Sat, 17 Feb 2024 06:29:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1708151398; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PEf9V6WG0iqeh6SG0OUpqyJBExKbmXTO7RAAFM7axps=;
	b=UTk+xrbL1eFYKddfr7f4aVAi9j3yp7+OrxjVu4XRzaUl1sZFlK3oeyxli4d0yVF564ZD/E
	TxMs/e33DbG6QYLSv1dhZ5DFeFGvAGUOJ3oMqgkDinAEgiruePIvm9569LmsMHOQQ3v7SO
	lAughvlEtkNvHjxa2WoLIWoA9SpHVNM=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1708151398; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PEf9V6WG0iqeh6SG0OUpqyJBExKbmXTO7RAAFM7axps=;
	b=UTk+xrbL1eFYKddfr7f4aVAi9j3yp7+OrxjVu4XRzaUl1sZFlK3oeyxli4d0yVF564ZD/E
	TxMs/e33DbG6QYLSv1dhZ5DFeFGvAGUOJ3oMqgkDinAEgiruePIvm9569LmsMHOQQ3v7SO
	lAughvlEtkNvHjxa2WoLIWoA9SpHVNM=
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 7412E134CD
	for <linux-btrfs@vger.kernel.org>; Sat, 17 Feb 2024 06:29:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id 0GPwDWVS0GUyZQAAn2gu4w
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Sat, 17 Feb 2024 06:29:57 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2 3/3] btrfs: subpage: make writer lock to utilize bitmap
Date: Sat, 17 Feb 2024 16:59:50 +1030
Message-ID: <8a448604ea5d11531c637926183733491ad4e0b6.1708151123.git.wqu@suse.com>
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
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=UTk+xrbL
X-Spamd-Result: default: False [0.69 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	 FROM_HAS_DN(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 RCPT_COUNT_ONE(0.00)[1];
	 DWL_DNSWL_LOW(-1.00)[suse.com:dkim];
	 RCVD_COUNT_THREE(0.00)[3];
	 TO_DN_NONE(0.00)[];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 DKIM_TRACE(0.00)[suse.com:+];
	 MX_GOOD(-0.01)[];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Score: 0.69
X-Rspamd-Queue-Id: 4D6531FBA1
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Bar: /

For the writer counter, it's pretty much the same as the reader counter,
and they are exclusive.

So it's pretty reasonable to move them to the new locked bitmap.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/subpage.c | 23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/subpage.c b/fs/btrfs/subpage.c
index 715b6df90117..3b3ef8bffe05 100644
--- a/fs/btrfs/subpage.c
+++ b/fs/btrfs/subpage.c
@@ -329,24 +329,36 @@ static void btrfs_subpage_start_writer(const struct btrfs_fs_info *fs_info,
 				       struct folio *folio, u64 start, u32 len)
 {
 	struct btrfs_subpage *subpage = folio_get_private(folio);
+	const int start_bit = subpage_calc_start_bit(fs_info, folio, locked,
+						     start, len);
 	const int nbits = (len >> fs_info->sectorsize_bits);
+	unsigned long flags;
 	int ret;
 
 	btrfs_subpage_assert(fs_info, folio, start, len);
 
+	spin_lock_irqsave(&subpage->lock, flags);
 	ASSERT(atomic_read(&subpage->readers) == 0);
+	ASSERT(bitmap_test_range_all_zero(subpage->bitmaps, start_bit, nbits));
+	bitmap_set(subpage->bitmaps, start_bit, nbits);
 	ret = atomic_add_return(nbits, &subpage->writers);
 	ASSERT(ret == nbits);
+	spin_unlock_irqrestore(&subpage->lock, flags);
 }
 
 static bool btrfs_subpage_end_and_test_writer(const struct btrfs_fs_info *fs_info,
 					      struct folio *folio, u64 start, u32 len)
 {
 	struct btrfs_subpage *subpage = folio_get_private(folio);
+	const int start_bit = subpage_calc_start_bit(fs_info, folio, locked,
+						     start, len);
 	const int nbits = (len >> fs_info->sectorsize_bits);
+	unsigned long flags;
+	bool last;
 
 	btrfs_subpage_assert(fs_info, folio, start, len);
 
+	spin_lock_irqsave(&subpage->lock, flags);
 	/*
 	 * We have call sites passing @lock_page into
 	 * extent_clear_unlock_delalloc() for compression path.
@@ -354,11 +366,18 @@ static bool btrfs_subpage_end_and_test_writer(const struct btrfs_fs_info *fs_inf
 	 * This @locked_page is locked by plain lock_page(), thus its
 	 * subpage::writers is 0.  Handle them in a special way.
 	 */
-	if (atomic_read(&subpage->writers) == 0)
+	if (atomic_read(&subpage->writers) == 0) {
+		spin_unlock_irqrestore(&subpage->lock, flags);
 		return true;
+	}
 
 	ASSERT(atomic_read(&subpage->writers) >= nbits);
-	return atomic_sub_and_test(nbits, &subpage->writers);
+	/* The target range should have been locked. */
+	ASSERT(bitmap_test_range_all_set(subpage->bitmaps, start_bit, nbits));
+	bitmap_clear(subpage->bitmaps, start_bit, nbits);
+	last = atomic_sub_and_test(nbits, &subpage->writers);
+	spin_unlock_irqrestore(&subpage->lock, flags);
+	return last;
 }
 
 /*
-- 
2.43.1


