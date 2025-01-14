Return-Path: <linux-btrfs+bounces-10964-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 41662A10355
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 Jan 2025 10:53:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4FF9B1612E7
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 Jan 2025 09:53:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2438228EC65;
	Tue, 14 Jan 2025 09:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="tgKFFULX";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="tgKFFULX"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38190224D6
	for <linux-btrfs@vger.kernel.org>; Tue, 14 Jan 2025 09:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736848381; cv=none; b=jXpwp8e+hGoS2fQq5Hl30wLWniE4YmyR1gxPGiEBb7mp3ou4bzQbwFHmL3uGmKdeYMJP6bJosjN/sEJceg+j9I/P9THh06t4q7DsktXmMyFJWjHuwMWFbo+4YvQFzgCUdVx2sayV3IEgeMYcrUOwKyGRu2yRrRUJToh7a2nWOtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736848381; c=relaxed/simple;
	bh=7Nb+Ao2oDvKntOz6A5Ga7VHLW3SX79qs2DWunyLejTg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jePUKCQu9/4p2QOY2zTEvOTX9bpKvr9vHbMDhEJC/HBAZRv5jFNmPLU2HwbYjVg3hPl9xph1KCqtJtJANrTRdkHE5ffwmCoo9H5xdGltSxPx5FZcuU1SjNCfYJR52+Da1yMnaSc9Iha6KRH5TSP8sHp0516EQWTo8qBhWspssuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=tgKFFULX; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=tgKFFULX; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 68FF11F395
	for <linux-btrfs@vger.kernel.org>; Tue, 14 Jan 2025 09:52:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1736848377; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gQN/IBPgHadskV+ZeImPg/Z97hLJeXczdMfoq/88Qu4=;
	b=tgKFFULXzAMewOtcVjpz4J/SXOYYVZ3eEHjSlKwo5Q20dPmBDbaMKxegN5axbLCuAO2IGi
	eAmcd/g+/XkD3cgLbAYg4TSlcRWOPktioOkDhkLALCkGCd/+mez7DXRrTI10oBqDiZ+TXS
	nBRxSGoEu+9f9b7qFY7xjih2DPacC4c=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1736848377; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gQN/IBPgHadskV+ZeImPg/Z97hLJeXczdMfoq/88Qu4=;
	b=tgKFFULXzAMewOtcVjpz4J/SXOYYVZ3eEHjSlKwo5Q20dPmBDbaMKxegN5axbLCuAO2IGi
	eAmcd/g+/XkD3cgLbAYg4TSlcRWOPktioOkDhkLALCkGCd/+mez7DXRrTI10oBqDiZ+TXS
	nBRxSGoEu+9f9b7qFY7xjih2DPacC4c=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A408B139CB
	for <linux-btrfs@vger.kernel.org>; Tue, 14 Jan 2025 09:52:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id cBB6GfgzhmeMAQAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Tue, 14 Jan 2025 09:52:56 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 1/3] btrfs: make btrfs_do_readpage() to do block-by-block read
Date: Tue, 14 Jan 2025 20:22:27 +1030
Message-ID: <d596b8e3d634ff296341585adc7bdcb02e8b0275.1736848277.git.wqu@suse.com>
X-Mailer: git-send-email 2.48.0
In-Reply-To: <cover.1736848277.git.wqu@suse.com>
References: <cover.1736848277.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:mid];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Score: -2.80
X-Spam-Flag: NO

Currently if a btrfs has block size (the older sector size) < page size,
btrfs_do_readpage() will handle the range extent by extent, this is good
for performance as it doesn't need to re-lookup the same extent map again
and again.
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

This will slightly reduce the read performance for
block size < page size cases, but for the future where we can skip a
full page read for a lot of cases, it should still be worthy.

For block size == page size, this brings no performance change.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/extent_io.c | 37 ++++++++++++-------------------------
 1 file changed, 12 insertions(+), 25 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 72342663341c..da7e8734ee57 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -946,9 +946,7 @@ static int btrfs_do_readpage(struct folio *folio, struct extent_map **em_cached,
 	u64 block_start;
 	struct extent_map *em;
 	int ret = 0;
-	size_t pg_offset = 0;
-	size_t iosize;
-	size_t blocksize = fs_info->sectorsize;
+	const size_t blocksize = fs_info->sectorsize;
 
 	ret = set_folio_extent_mapped(folio);
 	if (ret < 0) {
@@ -959,23 +957,22 @@ static int btrfs_do_readpage(struct folio *folio, struct extent_map **em_cached,
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
 		em = get_extent_map(BTRFS_I(inode), folio, cur, end - cur + 1, em_cached);
@@ -989,8 +986,6 @@ static int btrfs_do_readpage(struct folio *folio, struct extent_map **em_cached,
 
 		compress_type = extent_map_compression(em);
 
-		iosize = min(extent_map_end(em) - cur, end - cur + 1);
-		iosize = ALIGN(iosize, blocksize);
 		if (compress_type != BTRFS_COMPRESS_NONE)
 			disk_bytenr = em->disk_bytenr;
 		else
@@ -1046,18 +1041,13 @@ static int btrfs_do_readpage(struct folio *folio, struct extent_map **em_cached,
 
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
 
@@ -1068,12 +1058,9 @@ static int btrfs_do_readpage(struct folio *folio, struct extent_map **em_cached,
 
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
2.48.0


