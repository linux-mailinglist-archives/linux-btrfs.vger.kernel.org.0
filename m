Return-Path: <linux-btrfs+bounces-11725-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 20953A41253
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Feb 2025 00:47:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 207481892CA9
	for <lists+linux-btrfs@lfdr.de>; Sun, 23 Feb 2025 23:47:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B12661FCFE6;
	Sun, 23 Feb 2025 23:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="GfVOgcnv";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="GfVOgcnv"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FEC210E4
	for <linux-btrfs@vger.kernel.org>; Sun, 23 Feb 2025 23:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740354422; cv=none; b=ZZiQptWgFeD/aIwnWRiay6nARPAXtjIctFJHRDoLydMHSN4z+/F95Tg47YZ/P97k4VtQitX7LQ+DUaeu28hejpmDV2fPxSu2YP+jn/r1WhrPXx00XadZtaND5tZslGC72xRGZrfTB8zO4TQ7txdLka4dUQFxEsfYvvnCUicxUK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740354422; c=relaxed/simple;
	bh=C3Q4LIZ5p8LgRDFY+3r4jIw7TaXtuJQo0L0jntRv5O0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R1dwjGpWJK0TQFN1lBXC6FB9jM3BVTt48EwIcgIlSShjdqafdhIUh2Adk+TdMIDRToO3T0e2dOVAv+/oaA51Dv3tklX9tnnh0iRlK7HK8lUs3D+nZNZKRbqLJ171D/RApxsjhFoVtZEmZTHhyTaA7EJ81msc7xjngXGY4dNhsMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=GfVOgcnv; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=GfVOgcnv; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 6CCEB1F38C
	for <linux-btrfs@vger.kernel.org>; Sun, 23 Feb 2025 23:46:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1740354406; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bnVOflwM3CrUfaIuDhMzsup2J16GmkpU4GQYiJNBsDo=;
	b=GfVOgcnvLoaoWjyhNMOE0ZXWu9rA9tXwwj2BZ6R92K3TNNIYV6tB23QYRm5JbYInah8jcb
	t2Td6LY72ZG/bZfbQRvWI72+NZHYacmJkQ37XQIg9LcwWppvrqHU0YSS5in38H6kP3bc/S
	51PT40fG4dI10oMYHTqmTCZwTzAAyHI=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1740354406; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bnVOflwM3CrUfaIuDhMzsup2J16GmkpU4GQYiJNBsDo=;
	b=GfVOgcnvLoaoWjyhNMOE0ZXWu9rA9tXwwj2BZ6R92K3TNNIYV6tB23QYRm5JbYInah8jcb
	t2Td6LY72ZG/bZfbQRvWI72+NZHYacmJkQ37XQIg9LcwWppvrqHU0YSS5in38H6kP3bc/S
	51PT40fG4dI10oMYHTqmTCZwTzAAyHI=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A091B13A42
	for <linux-btrfs@vger.kernel.org>; Sun, 23 Feb 2025 23:46:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id oM33F2Wzu2euTgAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Sun, 23 Feb 2025 23:46:45 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 4/7] btrfs: make btrfs_do_readpage() to do block-by-block read
Date: Mon, 24 Feb 2025 10:16:19 +1030
Message-ID: <115f1044e9d341b8507cae894a7e2dece5f41445.1740354271.git.wqu@suse.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1740354271.git.wqu@suse.com>
References: <cover.1740354271.git.wqu@suse.com>
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

Currently if a btrfs has its block size (the older sector size) smaller
than the page size, btrfs_do_readpage() will handle the range extent by
extent, this is good for performance as it doesn't need to re-lookup the
same extent map again and again.
(Although __get_extent_map() already does extra cached em check, thus
the optimization is not that obvious)

This is totally fine and is a valid optimization, but it has an
assumption that, there is no partial uptodate range in the page.

Meanwhile there is an incoming feature, requiring btrfs to skip the full
page read if a buffered write range covers a full block but not a full
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

This will slightly reduce the read performance for subpage cases, but for
the future where we need to skip already uptodate blocks, it should still
be worthy.

For block size == page size, this brings no performance change.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/extent_io.c | 37 ++++++++++++-------------------------
 1 file changed, 12 insertions(+), 25 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index a6ffee6f6fd9..b3a4a94212c9 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -947,9 +947,7 @@ static int btrfs_do_readpage(struct folio *folio, struct extent_map **em_cached,
 	u64 last_byte = i_size_read(inode);
 	struct extent_map *em;
 	int ret = 0;
-	size_t pg_offset = 0;
-	size_t iosize;
-	size_t blocksize = fs_info->sectorsize;
+	const size_t blocksize = fs_info->sectorsize;
 
 	ret = set_folio_extent_mapped(folio);
 	if (ret < 0) {
@@ -960,24 +958,23 @@ static int btrfs_do_readpage(struct folio *folio, struct extent_map **em_cached,
 	if (folio_contains(folio, last_byte >> PAGE_SHIFT)) {
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
 		u64 block_start;
 
 		ASSERT(IS_ALIGNED(cur, fs_info->sectorsize));
 		if (cur >= last_byte) {
-			iosize = folio_size(folio) - pg_offset;
-			folio_zero_range(folio, pg_offset, iosize);
-			end_folio_read(folio, true, cur, iosize);
+			folio_zero_range(folio, pg_offset, end - cur + 1);
+			end_folio_read(folio, true, cur, end - cur + 1);
 			break;
 		}
 		em = get_extent_map(BTRFS_I(inode), folio, cur, end - cur + 1, em_cached);
@@ -991,8 +988,6 @@ static int btrfs_do_readpage(struct folio *folio, struct extent_map **em_cached,
 
 		compress_type = extent_map_compression(em);
 
-		iosize = min(extent_map_end(em) - cur, end - cur + 1);
-		iosize = ALIGN(iosize, blocksize);
 		if (compress_type != BTRFS_COMPRESS_NONE)
 			disk_bytenr = em->disk_bytenr;
 		else
@@ -1050,18 +1045,13 @@ static int btrfs_do_readpage(struct folio *folio, struct extent_map **em_cached,
 
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
 
@@ -1072,12 +1062,9 @@ static int btrfs_do_readpage(struct folio *folio, struct extent_map **em_cached,
 
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
2.48.1


