Return-Path: <linux-btrfs+bounces-10892-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBA2DA08603
	for <lists+linux-btrfs@lfdr.de>; Fri, 10 Jan 2025 04:32:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5AFB916A366
	for <lists+linux-btrfs@lfdr.de>; Fri, 10 Jan 2025 03:32:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFE162063F5;
	Fri, 10 Jan 2025 03:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="HPqBgvCx";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="HPqBgvCx"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E7EE2063E2
	for <linux-btrfs@vger.kernel.org>; Fri, 10 Jan 2025 03:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736479939; cv=none; b=bLqCm2J3amqEN0COnvtS3TDQR5Fx6WyLDa/Jpa7WnVFUMyAR4altpM8mLnHUcbS/Y8pNZNgzVbHyFjbX/+vlx5Ll6qQN9mcS/VJ6v6DK2J5NsqN7PdP1LFQDdAFgtTq5hTaqJZt5Hj91mMTkKmVH7tG1+/eXHKJEnbWe20JkCTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736479939; c=relaxed/simple;
	bh=nNL73RvPLgZqfvfh7Wl7DFlkeey8tNc76PhHXsoCabc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HoDGkWaAJS9UwfHafyW+0PBqsWRkWRIuQgAY5XaVIvzQzzPtnY7wgQveBKikM+j+C1VzkSWW5UZ21NhbaUUWoWLZLWFlgB+QZmNkb3G+n509w4/q3DIdFjos3unhxFv9zfuxbRLTlsC1RqxSihg9ShFlITJlm9eMxpprX4AHIoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=HPqBgvCx; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=HPqBgvCx; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 4EED51F396;
	Fri, 10 Jan 2025 03:32:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1736479935; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XCjDtq98fq3S1nuCp8MG3idm2cDvCL/0nnR7So17xQg=;
	b=HPqBgvCxYzoC1JWb19wkgU1fpyX1kgbjxJvF9+wufgY8CCs8Jfl6uwHnFyvQgAEjEJONZ7
	wgfFMIDl4Rvmc9M+cfWvwhFURcZuzMWYTaLlcWdyCA5wcrP8ARBWJViad44eG9p35Ej/zO
	ONZjlK8k0IrbH8R5ZVfbqIqvCoorl38=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=HPqBgvCx
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1736479935; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XCjDtq98fq3S1nuCp8MG3idm2cDvCL/0nnR7So17xQg=;
	b=HPqBgvCxYzoC1JWb19wkgU1fpyX1kgbjxJvF9+wufgY8CCs8Jfl6uwHnFyvQgAEjEJONZ7
	wgfFMIDl4Rvmc9M+cfWvwhFURcZuzMWYTaLlcWdyCA5wcrP8ARBWJViad44eG9p35Ej/zO
	ONZjlK8k0IrbH8R5ZVfbqIqvCoorl38=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4DF291397D;
	Fri, 10 Jan 2025 03:32:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id OCt/BL6UgGe0NQAAD6G6ig
	(envelope-from <wqu@suse.com>); Fri, 10 Jan 2025 03:32:14 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: Boris Burkov <boris@bur.io>
Subject: [PATCH v3 07/10] btrfs: subpage: dump the involved bitmap when ASSERT() failed
Date: Fri, 10 Jan 2025 14:01:38 +1030
Message-ID: <46310abfaa8eb389355cf1c0b1eb79a22a1ba684.1736479224.git.wqu@suse.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <cover.1736479224.git.wqu@suse.com>
References: <cover.1736479224.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4EED51F396
X-Spam-Score: -3.01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:mid,suse.com:email];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
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

Reviewed-by: Boris Burkov <boris@bur.io>
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


