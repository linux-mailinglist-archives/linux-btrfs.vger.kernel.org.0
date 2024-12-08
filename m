Return-Path: <linux-btrfs+bounces-10121-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CC8A29E833C
	for <lists+linux-btrfs@lfdr.de>; Sun,  8 Dec 2024 03:52:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 90B0C1884738
	for <lists+linux-btrfs@lfdr.de>; Sun,  8 Dec 2024 02:52:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CFDE78276;
	Sun,  8 Dec 2024 02:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="qqWDYMgK";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="qqWDYMgK"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 712D25B1FB
	for <linux-btrfs@vger.kernel.org>; Sun,  8 Dec 2024 02:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733626297; cv=none; b=hOP3hdgZ+lX08uaZBhR1FQu2/RuFDKg5oTWUuG/uyf4LC8/4oDvTZwyGVmGL2AJYHgEMZo86pYanPy51+TkcNb6d5F7gYbV1HxEh6TKswSS97cCiDUt5DyhFAEvxsDEop8BxTBN1pvpTsTbWsbuN6aYQ4e9cBtAApWzO22fPqhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733626297; c=relaxed/simple;
	bh=hP3vj1euKEibyALCglERp51BEdi5Q2zDXUM25DsqdmA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c3lZIfAIiyY9W3/H0BqjNbPtSUlEtTZteqBBogR5r7N7Iv42xYZQrnOX38WvWsCghZXvfDvlf5SeheI1rCXzczFVu86DenRYPYOpynNO8/Qa5jWxvqa8fjmbz47tnjuqN1VPNFlUn4WhyWtGhg5xaCKpc46THpkqnYX6dTNmLz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=qqWDYMgK; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=qqWDYMgK; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id AC7692117F
	for <linux-btrfs@vger.kernel.org>; Sun,  8 Dec 2024 02:51:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1733626293; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8XILA8AcWe1lqq7wAthDGyFjPzPZ10C7tdJvxowfsa4=;
	b=qqWDYMgK5t/MU2pkHyUDn16uTfgBeoX/Cpg1RPvgmhTdFInwq29lN/gmk+q+QdY1GdLSQX
	3TS9yB4zzoG//btnS696VUnxVGtRI8kYjFxdan2q28aj2q9ox9uAWUKOv6BbfqlrfWhndq
	WvCt4S2SDhhEQoX9U6Kxla4kbni8Xec=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1733626293; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8XILA8AcWe1lqq7wAthDGyFjPzPZ10C7tdJvxowfsa4=;
	b=qqWDYMgK5t/MU2pkHyUDn16uTfgBeoX/Cpg1RPvgmhTdFInwq29lN/gmk+q+QdY1GdLSQX
	3TS9yB4zzoG//btnS696VUnxVGtRI8kYjFxdan2q28aj2q9ox9uAWUKOv6BbfqlrfWhndq
	WvCt4S2SDhhEQoX9U6Kxla4kbni8Xec=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DC944133D1
	for <linux-btrfs@vger.kernel.org>; Sun,  8 Dec 2024 02:51:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id aEpiJ7QJVWcXcQAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Sun, 08 Dec 2024 02:51:32 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 7/8] btrfs: subpage: dump the involved bitmap when ASSERT() failed
Date: Sun,  8 Dec 2024 13:21:04 +1030
Message-ID: <c738844dad5f94f1d511f39c60c14bf3a840e8c0.1733624454.git.wqu@suse.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <cover.1733624454.git.wqu@suse.com>
References: <cover.1733624454.git.wqu@suse.com>
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
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:email];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 

For btrfs_folio_assert_not_dirty() and btrfs_folio_set_lock(), we call
bitmap_test_range_all_zero() to ensure the involved range has not bit
set.

However with my recent enhanced delalloc range error handling, I'm
hitting the ASSERT() inside btrfs_folio_set_lock(), and is wondering if
it's some error handling not properly cleanup the locked bitmap but
directly unlock the page.

So add some extra dumpping for the ASSERTs to dump the involved bitmap
to help debug.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/subpage.c | 41 ++++++++++++++++++++++++++++++-----------
 1 file changed, 30 insertions(+), 11 deletions(-)

diff --git a/fs/btrfs/subpage.c b/fs/btrfs/subpage.c
index 03d7bfc042e2..d692bc34a3af 100644
--- a/fs/btrfs/subpage.c
+++ b/fs/btrfs/subpage.c
@@ -635,6 +635,28 @@ IMPLEMENT_BTRFS_PAGE_OPS(ordered, folio_set_ordered, folio_clear_ordered,
 IMPLEMENT_BTRFS_PAGE_OPS(checked, folio_set_checked, folio_clear_checked,
 			 folio_test_checked);
 
+#define GET_SUBPAGE_BITMAP(subpage, fs_info, name, dst)			\
+{									\
+	const int sectors_per_page = fs_info->sectors_per_page;		\
+									\
+	ASSERT(sectors_per_page < BITS_PER_LONG);			\
+	*dst = bitmap_read(subpage->bitmaps,				\
+			   sectors_per_page * btrfs_bitmap_nr_##name,	\
+			   sectors_per_page);				\
+}
+
+#define subpage_dump_bitmap(fs_info, folio, name, start, len)		\
+{									\
+	struct btrfs_subpage *subpage = folio_get_private(folio);	\
+	unsigned long bitmap;						\
+									\
+	GET_SUBPAGE_BITMAP(subpage, fs_info, name, &bitmap);		\
+	btrfs_warn(fs_info,						\
+	"dumpping bitmap start=%llu len=%u folio=%llu" #name "_bitmap=%*pbl", \
+		   start, len, folio_pos(folio),			\
+		   fs_info->sectors_per_page, &bitmap);			\
+}
+
 /*
  * Make sure not only the page dirty bit is cleared, but also subpage dirty bit
  * is cleared.
@@ -660,6 +682,10 @@ void btrfs_folio_assert_not_dirty(const struct btrfs_fs_info *fs_info,
 	subpage = folio_get_private(folio);
 	ASSERT(subpage);
 	spin_lock_irqsave(&subpage->lock, flags);
+	if (unlikely(!bitmap_test_range_all_zero(subpage->bitmaps, start_bit, nbits))) {
+		subpage_dump_bitmap(fs_info, folio, dirty, start, len);
+		ASSERT(bitmap_test_range_all_zero(subpage->bitmaps, start_bit, nbits));
+	}
 	ASSERT(bitmap_test_range_all_zero(subpage->bitmaps, start_bit, nbits));
 	spin_unlock_irqrestore(&subpage->lock, flags);
 }
@@ -689,23 +715,16 @@ void btrfs_folio_set_lock(const struct btrfs_fs_info *fs_info,
 	nbits = len >> fs_info->sectorsize_bits;
 	spin_lock_irqsave(&subpage->lock, flags);
 	/* Target range should not yet be locked. */
-	ASSERT(bitmap_test_range_all_zero(subpage->bitmaps, start_bit, nbits));
+	if (unlikely(!bitmap_test_range_all_zero(subpage->bitmaps, start_bit, nbits))) {
+		subpage_dump_bitmap(fs_info, folio, locked, start, len);
+		ASSERT(bitmap_test_range_all_zero(subpage->bitmaps, start_bit, nbits));
+	}
 	bitmap_set(subpage->bitmaps, start_bit, nbits);
 	ret = atomic_add_return(nbits, &subpage->nr_locked);
 	ASSERT(ret <= fs_info->sectors_per_page);
 	spin_unlock_irqrestore(&subpage->lock, flags);
 }
 
-#define GET_SUBPAGE_BITMAP(subpage, fs_info, name, dst)			\
-{									\
-	const int sectors_per_page = fs_info->sectors_per_page;		\
-									\
-	ASSERT(sectors_per_page < BITS_PER_LONG);			\
-	*dst = bitmap_read(subpage->bitmaps,				\
-			   sectors_per_page * btrfs_bitmap_nr_##name,	\
-			   sectors_per_page);				\
-}
-
 void __cold btrfs_subpage_dump_bitmap(const struct btrfs_fs_info *fs_info,
 				      struct folio *folio, u64 start, u32 len)
 {
-- 
2.47.1


