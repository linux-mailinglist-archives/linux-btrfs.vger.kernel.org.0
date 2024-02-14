Return-Path: <linux-btrfs+bounces-2368-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 800BA8541EB
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 Feb 2024 05:05:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30BFF2883CD
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 Feb 2024 04:05:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66787C8DD;
	Wed, 14 Feb 2024 04:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="b//US69y";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="b//US69y"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92456BA46
	for <linux-btrfs@vger.kernel.org>; Wed, 14 Feb 2024 04:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707883487; cv=none; b=eq+/N2cKM/zWQ5/Aavbkd2/I19C/fgYJKdjL8sxeM+T+zjLvOpaxl3l7ox7i/1K7GzyFW/O1ai4y/W3jXUqKNHmhd7HjVltz9sW62fPW4PoM2ZVqALzFpx/hU9KtRKEIXe5Tslf9NlK2yzh2pkBAJPJlehsD26ZmJYwBIz3T+IM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707883487; c=relaxed/simple;
	bh=7TxCX/MhmKLykKyiaJzqqP4hKlT2Uw0xM4GAoraGrXU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rwgUPYu6tbgx8TCQl1JcZIbkt315LrQSbx1f689W3/9lyMXdmZFSzHkRi5xyTCLtnpcjzl22otlAsDL7vJG6GJOX/JQRmP7/96D6yAO8/NBsEkT67o225hGTUJ0JHJ5Kmcz/GR976gFG2xCGFPnetmEKOdlCmq9QJjfDThHp12g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=b//US69y; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=b//US69y; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id CEB811FD0E
	for <linux-btrfs@vger.kernel.org>; Wed, 14 Feb 2024 04:04:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1707883483; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=smL9lGmkcAXuZc+p0jcgXohp4nDfudLmJ7xr5wLmOCU=;
	b=b//US69y2Xa4z/0Du2vUZ4bkUuDcouuzF7tifNey+/PlXddO5Fj3s7FjGWTkBJUfUwngJa
	6DbOTjrYIsv4JSSRx+PNDaY/OR+aWocv5YDxYxA/WsHdm3nNKJ5dnpAjulw8jWoPLklRy6
	Z8oSsxSDh/H+y35nL1BdiqbpuvOq5K4=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1707883483; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=smL9lGmkcAXuZc+p0jcgXohp4nDfudLmJ7xr5wLmOCU=;
	b=b//US69y2Xa4z/0Du2vUZ4bkUuDcouuzF7tifNey+/PlXddO5Fj3s7FjGWTkBJUfUwngJa
	6DbOTjrYIsv4JSSRx+PNDaY/OR+aWocv5YDxYxA/WsHdm3nNKJ5dnpAjulw8jWoPLklRy6
	Z8oSsxSDh/H+y35nL1BdiqbpuvOq5K4=
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 04E4A1329E
	for <linux-btrfs@vger.kernel.org>; Wed, 14 Feb 2024 04:04:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id 0G3tKdo7zGVDDAAAn2gu4w
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Wed, 14 Feb 2024 04:04:42 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 3/3] btrfs: subpage: make writer lock to utilize bitmap
Date: Wed, 14 Feb 2024 14:34:36 +1030
Message-ID: <26b53890813c61dce89cd704cad6dbdd43bdd463.1707883446.git.wqu@suse.com>
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
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [4.89 / 50.00];
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
	 BAYES_HAM(-0.01)[49.48%]
X-Spam-Level: ****
X-Spam-Score: 4.89
X-Spam-Flag: NO

For the writer counter, it's pretty much the same as the reader counter,
and they are exclusive.

So it's pretty reasonable to move them to the new locked bitmap.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/subpage.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/subpage.c b/fs/btrfs/subpage.c
index bd5c4993dcb9..5d99e8d1b5ac 100644
--- a/fs/btrfs/subpage.c
+++ b/fs/btrfs/subpage.c
@@ -329,24 +329,35 @@ static void btrfs_subpage_start_writer(const struct btrfs_fs_info *fs_info,
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
@@ -358,7 +369,11 @@ static bool btrfs_subpage_end_and_test_writer(const struct btrfs_fs_info *fs_inf
 		return true;
 
 	ASSERT(atomic_read(&subpage->writers) >= nbits);
-	return atomic_sub_and_test(nbits, &subpage->writers);
+	/* The target range should have been locked. */
+	ASSERT(bitmap_test_range_all_set(subpage->bitmaps, start_bit, nbits));
+	last = atomic_sub_and_test(nbits, &subpage->writers);
+	spin_unlock_irqrestore(&subpage->lock, flags);
+	return last;
 }
 
 /*
-- 
2.43.1


