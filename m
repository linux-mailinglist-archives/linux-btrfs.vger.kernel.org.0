Return-Path: <linux-btrfs+bounces-10922-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ED4EBA0A2EA
	for <lists+linux-btrfs@lfdr.de>; Sat, 11 Jan 2025 11:44:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE6773AA4B5
	for <lists+linux-btrfs@lfdr.de>; Sat, 11 Jan 2025 10:44:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 444B6198A34;
	Sat, 11 Jan 2025 10:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="emWT4Qke";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="XVWH6c5O"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B991819340B
	for <linux-btrfs@vger.kernel.org>; Sat, 11 Jan 2025 10:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736592264; cv=none; b=htO5w6gYQ811tcOnh64eRK+UbsgQBNmWN8WgRW8jeYx7VstNU3+akR2tcaneC/wCYv5ijL2AWxMasGgsyuv4LSy/88tk8sJ/Wp/npuOPTtfnAHl80kHr9GEXWRBxC3f4QKh/MS6GZ7J7QnAFRHUHYs4EBoXDJZATElavNasYGWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736592264; c=relaxed/simple;
	bh=UdWI/rMCEcPMxUIgej1KT0YujFEjKLbOQ6M5fz5L0Ic=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LDuVNFXn6XCshb7tIakopKDr91+O+cwnwD/th8uDfOcEQZ6yojZauAqkz71UrHd1Tdkim3v573UpF2ycRSIRffiMLh0t8I9FBYGH/1B0ClUK3+keuusEbboRZ/4YUaPs5FyAfnqt6p3TVbjN+hTvD4yHhsG2cnKD7J1/7bgvpA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=emWT4Qke; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=XVWH6c5O; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C2FF32117D;
	Sat, 11 Jan 2025 10:44:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1736592258; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6F6nEtctdaqv085ax2s2nLEJ8frIJNHXJtS678YC8Bo=;
	b=emWT4QkeOlK/OaFzLleCW1CwvIX9Xb1byhVt1xY7ptiitqGdX2vrcwRmoVW2yq5+N1dtik
	3wHCHxzxbAPZaxNy8tJEez1OQjstlgHIoyHMvCTgwwNPBAfuv55RiM27YUBpjcc2USFHhy
	CU1HkgeviLJ3buI/VZN4/WM2nZi2C+A=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=XVWH6c5O
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1736592257; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6F6nEtctdaqv085ax2s2nLEJ8frIJNHXJtS678YC8Bo=;
	b=XVWH6c5OmpL4OmE5SbV6aQtUf0QkxkD18IPg67KGUMex4wl9WA8SSs7LuRYvy9McNL4Lcz
	uKtBDgNrUdTb45B0dBvoS9RZX5nPowBBuD5LzCtjHNDPFGTgNgwvEbnQVWG5hLGQ+ojkRC
	m6vd+rAbZzl7E3fjGezBeG8SeChKK70=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BE58713A8A;
	Sat, 11 Jan 2025 10:44:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id aEHSH4BLgmdCLgAAD6G6ig
	(envelope-from <wqu@suse.com>); Sat, 11 Jan 2025 10:44:16 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: Boris Burkov <boris@bur.io>
Subject: [PATCH v4 07/10] btrfs: subpage: dump the involved bitmap when ASSERT() failed
Date: Sat, 11 Jan 2025 21:13:41 +1030
Message-ID: <f2b80afb62f3fc2ab19e5315cc2b4277cc1f26bc.1736591758.git.wqu@suse.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <cover.1736591758.git.wqu@suse.com>
References: <cover.1736591758.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: C2FF32117D
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:dkim,suse.com:mid,suse.com:email];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

For btrfs_folio_assert_not_dirty() and btrfs_folio_set_lock(), we call
bitmap_test_range_all_zero() to ensure the involved range has no
dirty/lock bit already set.

However with my recent enhanced delalloc range error handling, I was
hitting the ASSERT() inside btrfs_folio_set_lock(), and it turns out
that some error handling path is not properly update the folio flags.

So add some extra dumpping for the ASSERTs to dump the involved bitmap
to help debug.

Reviewed-by: Boris Burkov <boris@bur.io>
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/subpage.c | 41 ++++++++++++++++++++++++++++++-----------
 1 file changed, 30 insertions(+), 11 deletions(-)

diff --git a/fs/btrfs/subpage.c b/fs/btrfs/subpage.c
index 03d7bfc042e2..5d088f7d6184 100644
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
+	"dumpping bitmap start=%llu len=%u folio=%llu " #name "_bitmap=%*pbl", \
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


