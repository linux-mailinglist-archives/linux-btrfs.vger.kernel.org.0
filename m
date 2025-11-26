Return-Path: <linux-btrfs+bounces-19356-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 92342C880DB
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Nov 2025 05:28:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D3C63B37AD
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Nov 2025 04:28:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 560AC30E82D;
	Wed, 26 Nov 2025 04:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="sSRlRXLB";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="ptnV4+6X"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAB302F6593
	for <linux-btrfs@vger.kernel.org>; Wed, 26 Nov 2025 04:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764131303; cv=none; b=sZU+OYTRMHW+IwUmmP9Cf+I25C+QQQE4cJfAEvxlKmFQeN2B9Z9hb6nxePa+Orx9GxZohd6qUqGfxb/H6nA8NaABGuwThUvkyz+GPTDoZ/NgImdLJ87cspOWqJm0JCSiBORL9HC6PBFxZ3xaINveK0xPzcwR1Ll8e453UxrzcVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764131303; c=relaxed/simple;
	bh=GsK28fQgnSk2M99odmtqNH/n/S4BZ5jWKaYq9rDmj0Y=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=C7HCE63z463xU8IGRGAsp29PnXaK3m5Q33DRMf6zoIUzkG1REbmchrklJX17Yp64peiP2TV8anV60An3MTsU+jjONpReCG2y12OrgWcjsdhaQwPK2SSitzM9I/pVbY4Altb4E46o+2vEInakfYoN7I/QblimUw65ydfJw4+5PgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=sSRlRXLB; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=ptnV4+6X; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D5E865BD95
	for <linux-btrfs@vger.kernel.org>; Wed, 26 Nov 2025 04:28:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1764131299; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=QUIaNhDETpDNnf45zm/FYg06secLNSyPTXGwDZePOvc=;
	b=sSRlRXLBTVyJeo7dkj0gSRTwyr4djPJEdK75FRRsvpK1Eb0R7yY5YWWdjsC9nsYqQMalNK
	CN81aktIdDS56pTe9OUbftl2+Sxko1GeQDuCmr3IM9klZ/tNF+ztFGSGYeZwex3US+L6Ls
	lXj3K3452YST0fmLCLRgeXfL6A6RLDM=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1764131298; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=QUIaNhDETpDNnf45zm/FYg06secLNSyPTXGwDZePOvc=;
	b=ptnV4+6XlC6xy7oOiE1Efibr4HUIbZGeTeyfmnWyA3s9xZFyIcZI/kCMJdrlMsorbMiaB/
	mGQYaNiK6K375yLzO98InQqlntyLMxl6WyV7+MjH9gAU4iNXy4dcxRiGmlxiTpdiP1QWxk
	TX3cp81v1t5m8UA2crYOklRD4H3nyOk=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 170E43EA63
	for <linux-btrfs@vger.kernel.org>; Wed, 26 Nov 2025 04:28:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id WNDpMuGBJml0eQAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Wed, 26 Nov 2025 04:28:17 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: search for larger extent maps inside btrfs_do_readpage()
Date: Wed, 26 Nov 2025 14:58:00 +1030
Message-ID: <2d0cc7c454a8cb80219ab4c218fa73843ff5f809.1764131228.git.wqu@suse.com>
X-Mailer: git-send-email 2.52.0
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
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email,suse.com:mid];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Score: -2.80

[CORNER CASE]
If we have the following file extents layout, btrfs_get_extent() can
return a smaller hole during read, and cause unnecessary extra tree
searches:

	item 6 key (257 EXTENT_DATA 0) itemoff 15810 itemsize 53
		generation 9 type 1 (regular)
		extent data disk byte 13631488 nr 4096
		extent data offset 0 nr 4096 ram 4096
		extent compression 0 (none)

	item 7 key (257 EXTENT_DATA 32768) itemoff 15757 itemsize 53
		generation 9 type 1 (regular)
		extent data disk byte 13635584 nr 4096
		extent data offset 0 nr 4096 ram 4096
		extent compression 0 (none)

In above case, range [0, 4K) and [32K, 36K) are regular extents, and
there is a hole in range [4K, 32K), and the fs has "no-holes" feature,
meaning the hole will not have a file extent item.

[INEFFICIENCY]
Assume the system has 4K page size, and we're doing readahead for range
[4K, 32K), no large folio yet.

 btrfs_readahead() for range [4K, 32K)
 |- btrfs_do_readpage() for folio 4K
 |  |- get_extent_map() for range [4K, 8K)
 |     |- btrfs_get_extent() for range [4K, 8K)
 |        We hit item 6, then for the next item 7.
 |        At this stage we know range [4K, 32K) is a hole.
 |        But our search range is only [4K, 8K), not reaching 32K, thus
 |        we go into not_found: tag, returning a hole em for [4K, 8K).
 |
 |- btrfs_do_readpage() for folio 8K
 |  |- get_extent_map() for range [8K, 12K)
 |     |- btrfs_get_extent() for range [8K, 12K)
 |        We hit the same item 6, and then item 7.
 |        But still we goto not_found tag, inserting a new hole em,
 |        which will be merged with previous one.
 |
 | [ Repeat the same btrfs_get_extent() calls until the end ]

So we're calling btrfs_get_extent() again and again, just for a
different part of the same hole range [4K, 32K).

[ENHANCEMENT]
Make btrfs_do_readpage() to search for a larger extent map if readahead
is involved.

For btrfs_readahead() we have bio_ctrl::ractl set, and lock extents for
the whole readahead range.

If we find bio_ctrl::ractl is set, we can use that end range as extent
map search end, this allows btrfs_get_extent() to return a much larger
hole, thus reduce the need to call btrfs_get_extent() again and again.

 btrfs_readahead() for range [4K, 32K)
 |- btrfs_do_readpage() for folio 4K
 |  |- get_extent_map() for range [4K, 32K)
 |     |- btrfs_get_extent() for range [4K, 32K)
 |        We hit item 6, then for the next item 7.
 |        At this stage we know range [4K, 32K) is a hole.
 |        So the hole em for range [4K, 32K) is returned.
 |
 |- btrfs_do_readpage() for folio 8K
 |  |- get_extent_map() for range [8K, 32K)
 |     The cached hole em range [4K, 32K) covers the range,
 |     and reuse that em.
 |
 | [ Repeat the same btrfs_get_extent() calls until the end ]

Now we only call btrfs_get_extent() once for the whole range [4K, 32K),
other than the old 8 times.

Although again I do not expect much difference for the real world
performance.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/extent_io.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 2d32dfc34ae3..c8c8d3659135 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -997,6 +997,8 @@ static int btrfs_do_readpage(struct folio *folio, struct extent_map **em_cached,
 	struct btrfs_fs_info *fs_info = inode_to_fs_info(inode);
 	u64 start = folio_pos(folio);
 	const u64 end = start + folio_size(folio) - 1;
+	const u64 locked_end = bio_ctrl->ractl ? (readahead_pos(bio_ctrl->ractl) +
+			       readahead_length(bio_ctrl->ractl) - 1) : end;
 	u64 extent_offset;
 	u64 last_byte = i_size_read(inode);
 	struct extent_map *em;
@@ -1036,7 +1038,14 @@ static int btrfs_do_readpage(struct folio *folio, struct extent_map **em_cached,
 			end_folio_read(folio, true, cur, blocksize);
 			continue;
 		}
-		em = get_extent_map(BTRFS_I(inode), folio, cur, end - cur + 1, em_cached);
+		/*
+		 * Search extent map for the whole locked range.
+		 * This will allow btrfs_get_extent() to return a larger hole
+		 * when possible.
+		 * This can reduce duplicated btrfs_get_extent() calls for large
+		 * holes.
+		 */
+		em = get_extent_map(BTRFS_I(inode), folio, cur, locked_end - cur + 1, em_cached);
 		if (IS_ERR(em)) {
 			end_folio_read(folio, false, cur, end + 1 - cur);
 			return PTR_ERR(em);
-- 
2.52.0


