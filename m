Return-Path: <linux-btrfs+bounces-9881-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E5C699D7948
	for <lists+linux-btrfs@lfdr.de>; Mon, 25 Nov 2024 00:58:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BBA7616304D
	for <lists+linux-btrfs@lfdr.de>; Sun, 24 Nov 2024 23:58:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C221818C337;
	Sun, 24 Nov 2024 23:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="L04u2Cvq";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="L04u2Cvq"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29A30185924
	for <linux-btrfs@vger.kernel.org>; Sun, 24 Nov 2024 23:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732492678; cv=none; b=TTE3ENZbKHEiDACqUAREK0bHqr3rBwZxwHnybo1AfOB0PjqBXFQzKR5AEqKE9+18WnBxjYw1S8MPHZez/Fpd6MtgxPeQfkh5TcEcAJfjFPAyJ/8SJX9Ew3NHtyZEEuAWgszqDbqYD70+aij340AmgQhNc0V0gUiZTzfqYHs6xB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732492678; c=relaxed/simple;
	bh=bpotUu4X/Un0NASejgVQv/8UT9cctHerHKQgUqVkufk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n3lQxIIoofgjCxGOD5bx58lznySB/jjxgNYLqbEsB4+fW1ZWFPV3LXGlrBFPhLxyQmlHrHLUGG8vmDqoyjMTQHadYLy+gkx/ZBUXmMvWun2VDjCq72QukS32+fCJp7Q//44AM2/56WpCsWfVejzrFgBkjGAmehkWKNNgZ/1TAfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=L04u2Cvq; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=L04u2Cvq; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 5B2112118D
	for <linux-btrfs@vger.kernel.org>; Sun, 24 Nov 2024 23:57:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1732492674; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MYwCwOJdld1rVPWkcWsrmneXKsud0MRuW/B1j/pfa9U=;
	b=L04u2CvqJGgbXcBZ9omrMabtW1/6AtEWXubz913yAwFTfsybSvRSLpYKPlwuoiol+t7HzS
	5BLUtv3cWeMVQmeV5f2FIKf1hGZ4YnNmfc3gYxdA2JcdPnb9jbjc2Pd6fG4YHkQUdM52JK
	zRpWAkz66Lk64Qj27Q58YnxsrCEI6/M=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=L04u2Cvq
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1732492674; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MYwCwOJdld1rVPWkcWsrmneXKsud0MRuW/B1j/pfa9U=;
	b=L04u2CvqJGgbXcBZ9omrMabtW1/6AtEWXubz913yAwFTfsybSvRSLpYKPlwuoiol+t7HzS
	5BLUtv3cWeMVQmeV5f2FIKf1hGZ4YnNmfc3gYxdA2JcdPnb9jbjc2Pd6fG4YHkQUdM52JK
	zRpWAkz66Lk64Qj27Q58YnxsrCEI6/M=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7173C132CF
	for <linux-btrfs@vger.kernel.org>; Sun, 24 Nov 2024 23:57:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id YAzjCoG9Q2emSQAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Sun, 24 Nov 2024 23:57:53 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2 5/7] btrfs: make btrfs_do_readpage() to do block-by-block read
Date: Mon, 25 Nov 2024 10:27:25 +1030
Message-ID: <805cd02d604d20b11fc3daedac4774171e0de068.1732492421.git.wqu@suse.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1732492421.git.wqu@suse.com>
References: <cover.1732492421.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 5B2112118D
X-Spam-Level: 
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:dkim,suse.com:mid];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[suse.com:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01
X-Spam-Flag: NO

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
index 1c2246d36672..5fa200632472 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -961,9 +961,7 @@ static int btrfs_do_readpage(struct folio *folio, struct extent_map **em_cached,
 	u64 block_start;
 	struct extent_map *em;
 	int ret = 0;
-	size_t pg_offset = 0;
-	size_t iosize;
-	size_t blocksize = fs_info->sectorsize;
+	const size_t blocksize = fs_info->sectorsize;
 
 	ret = set_folio_extent_mapped(folio);
 	if (ret < 0) {
@@ -974,23 +972,22 @@ static int btrfs_do_readpage(struct folio *folio, struct extent_map **em_cached,
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
@@ -1005,8 +1002,6 @@ static int btrfs_do_readpage(struct folio *folio, struct extent_map **em_cached,
 
 		compress_type = extent_map_compression(em);
 
-		iosize = min(extent_map_end(em) - cur, end - cur + 1);
-		iosize = ALIGN(iosize, blocksize);
 		if (compress_type != BTRFS_COMPRESS_NONE)
 			disk_bytenr = em->disk_bytenr;
 		else
@@ -1062,18 +1057,13 @@ static int btrfs_do_readpage(struct folio *folio, struct extent_map **em_cached,
 
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
 
@@ -1084,12 +1074,9 @@ static int btrfs_do_readpage(struct folio *folio, struct extent_map **em_cached,
 
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
2.47.0


