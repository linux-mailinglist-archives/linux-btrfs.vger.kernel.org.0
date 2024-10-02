Return-Path: <linux-btrfs+bounces-8409-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DA36898CAFB
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Oct 2024 03:53:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A0201F23A4D
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Oct 2024 01:53:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B341C23C9;
	Wed,  2 Oct 2024 01:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Zhq92omw";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Zhq92omw"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C56A11373
	for <linux-btrfs@vger.kernel.org>; Wed,  2 Oct 2024 01:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727833978; cv=none; b=CxHNqBo0HEOaejVjdRvOLIkt/mfVN8aejurKChNBj9r6l//nDVvO7+NK+XsHre33E4N23yhuLbeUfGEeJ7rzBL/r2eXZkVNECqppeCaoQDSC8Qs50jgSm/cbulkw99ExKevwXTm6i2BI0Sv85hMiIHsxcvzLG+M83+F+3t2gJkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727833978; c=relaxed/simple;
	bh=rw/rPbGVUjmnR3behLlBMZgUrmGJExQvFnDPeE3soHs=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Jp6NZ7f5nz+ws0TFSylD4Y2xl7SZtgWhRETnaRdWJXjR9Ps/y564POi7qtwGfoWhDED+LK/tzFHoahtB/PefN43BMSwxhDl3POnwDH3774Y6VTW+n8PV0LPiechj39l1bAtqTiDPnJzw2FClmmp88aZxWWE98L3AAHMB/JjmVfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Zhq92omw; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Zhq92omw; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id F39B01FD05
	for <linux-btrfs@vger.kernel.org>; Wed,  2 Oct 2024 01:52:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1727833975; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GIBPvjsUqXb7rs+vnYdvG48etmS64LTQ2O/GxqDcC4E=;
	b=Zhq92omw9co0r0GlnOrglLWx4uI4nVAUxCpFyYV/BEV0dRFYCw/N71PFdnp/O2mZAu/0tp
	AV0/ESmidEVIbtS+sF3uWQGx3pz09Y2qhN+6h7PGlUZscmOgd3lIXrD4mNEug3rMFFBmh6
	z2YNEWtOLfZcNFlktVBc8Y2lOP4Aom0=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=Zhq92omw
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1727833975; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GIBPvjsUqXb7rs+vnYdvG48etmS64LTQ2O/GxqDcC4E=;
	b=Zhq92omw9co0r0GlnOrglLWx4uI4nVAUxCpFyYV/BEV0dRFYCw/N71PFdnp/O2mZAu/0tp
	AV0/ESmidEVIbtS+sF3uWQGx3pz09Y2qhN+6h7PGlUZscmOgd3lIXrD4mNEug3rMFFBmh6
	z2YNEWtOLfZcNFlktVBc8Y2lOP4Aom0=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 24D4713A71
	for <linux-btrfs@vger.kernel.org>; Wed,  2 Oct 2024 01:52:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 4NAeNXWn/GaHVAAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Wed, 02 Oct 2024 01:52:53 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 1/2] btrfs: make btrfs_do_readpage() to do block-by-block read
Date: Wed,  2 Oct 2024 11:22:33 +0930
Message-ID: <77c88d49594d2d2c87a205b0bfd4fce1947f43f9.1727833878.git.wqu@suse.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <cover.1727833878.git.wqu@suse.com>
References: <cover.1727833878.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: F39B01FD05
X-Spam-Score: -3.01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:mid,suse.com:email];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[suse.com:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

Currently if a btrfs has sector size < page size, btrfs_do_readpage()
will handle the range extent by extent, this is good for performance as
it doesn't need to re-lookup the same extent map again and again
(although __get_extent_map() already does extra cached em check).

This is totally fine and is a valid optimization, but it has an
assumption that, there is no partial uptodate range in the page.

Meanwhile there is an incoming feature, requiring btrfs to skip the full
page read if a buffered write range covers a full sector but not a full
page.

In that case, we can have a page that is partially uptodate, and the
current per-extent lookup can not handle such case.

So here we change btrfs_do_readpage() to do block-by-block read, this
simplifies the following things:

- Remove the need for @iosize variable
  Because we just use sectorsize as our increment.

- Remove @pg_offset, and calculate it inside the loop when needed
  It's just offset_in_folio().

- Use a for() loop instead of a while() loop

This will slightly reduce the read performance for
sector size < page size cases, but for the future where we can skip a
full page read for a lot of cases, it should still be worthy.

For sector size == page size, this brings no performance change.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/extent_io.c | 37 ++++++++++++-------------------------
 1 file changed, 12 insertions(+), 25 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 9302fde9c464..09eb8a204375 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -952,9 +952,7 @@ static int btrfs_do_readpage(struct folio *folio, struct extent_map **em_cached,
 	u64 block_start;
 	struct extent_map *em;
 	int ret = 0;
-	size_t pg_offset = 0;
-	size_t iosize;
-	size_t blocksize = fs_info->sectorsize;
+	const size_t blocksize = fs_info->sectorsize;
 
 	ret = set_folio_extent_mapped(folio);
 	if (ret < 0) {
@@ -965,23 +963,22 @@ static int btrfs_do_readpage(struct folio *folio, struct extent_map **em_cached,
 	if (folio->index == last_byte >> folio_shift(folio)) {
 		size_t zero_offset = offset_in_folio(folio, last_byte);
 
-		if (zero_offset) {
-			iosize = folio_size(folio) - zero_offset;
-			folio_zero_range(folio, zero_offset, iosize);
-		}
+		if (zero_offset)
+			folio_zero_range(folio, zero_offset,
+					 folio_size(folio) - zero_offset);
 	}
 	bio_ctrl->end_io_func = end_bbio_data_read;
 	begin_folio_read(fs_info, folio);
-	while (cur <= end) {
+	for (cur = start; cur <= end; cur += blocksize) {
 		enum btrfs_compression_type compress_type = BTRFS_COMPRESS_NONE;
+		unsigned long pg_offset = offset_in_folio(folio, cur);
 		bool force_bio_submit = false;
 		u64 disk_bytenr;
 
 		ASSERT(IS_ALIGNED(cur, fs_info->sectorsize));
 		if (cur >= last_byte) {
-			iosize = folio_size(folio) - pg_offset;
-			folio_zero_range(folio, pg_offset, iosize);
-			end_folio_read(folio, true, cur, iosize);
+			folio_zero_range(folio, pg_offset, end - cur + 1);
+			end_folio_read(folio, true, cur, end - cur + 1);
 			break;
 		}
 		em = __get_extent_map(inode, folio, cur, end - cur + 1,
@@ -996,8 +993,6 @@ static int btrfs_do_readpage(struct folio *folio, struct extent_map **em_cached,
 
 		compress_type = extent_map_compression(em);
 
-		iosize = min(extent_map_end(em) - cur, end - cur + 1);
-		iosize = ALIGN(iosize, blocksize);
 		if (compress_type != BTRFS_COMPRESS_NONE)
 			disk_bytenr = em->disk_bytenr;
 		else
@@ -1053,18 +1048,13 @@ static int btrfs_do_readpage(struct folio *folio, struct extent_map **em_cached,
 
 		/* we've found a hole, just zero and go on */
 		if (block_start == EXTENT_MAP_HOLE) {
-			folio_zero_range(folio, pg_offset, iosize);
-
-			end_folio_read(folio, true, cur, iosize);
-			cur = cur + iosize;
-			pg_offset += iosize;
+			folio_zero_range(folio, pg_offset, blocksize);
+			end_folio_read(folio, true, cur, blocksize);
 			continue;
 		}
 		/* the get_extent function already copied into the folio */
 		if (block_start == EXTENT_MAP_INLINE) {
-			end_folio_read(folio, true, cur, iosize);
-			cur = cur + iosize;
-			pg_offset += iosize;
+			end_folio_read(folio, true, cur, blocksize);
 			continue;
 		}
 
@@ -1075,12 +1065,9 @@ static int btrfs_do_readpage(struct folio *folio, struct extent_map **em_cached,
 
 		if (force_bio_submit)
 			submit_one_bio(bio_ctrl);
-		submit_extent_folio(bio_ctrl, disk_bytenr, folio, iosize,
+		submit_extent_folio(bio_ctrl, disk_bytenr, folio, blocksize,
 				    pg_offset);
-		cur = cur + iosize;
-		pg_offset += iosize;
 	}
-
 	return 0;
 }
 
-- 
2.46.2


