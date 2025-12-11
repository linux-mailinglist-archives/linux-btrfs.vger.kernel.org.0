Return-Path: <linux-btrfs+bounces-19640-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5582BCB4DF0
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Dec 2025 07:25:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 52782300A9E2
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Dec 2025 06:25:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24CE928850D;
	Thu, 11 Dec 2025 06:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="UGbeqsLb";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="OU/L7EQM"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1473D18C933
	for <linux-btrfs@vger.kernel.org>; Thu, 11 Dec 2025 06:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765434351; cv=none; b=S50ADn8GHrt0JSrj1/fd3B1/EgIVTe7ukyRfvz9qW75Ckv+IpXQYpTD0TsfmH2zwZ60d8GlIIokzARyEoabgMO7F+34aO72ANDxPS5g3KvDVlSeCLMaw30Nfg2eVXLYtNKsu0QHmoD5/sBhNqCv7NzJEaGXyg9vn6ZQQQOW9Qs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765434351; c=relaxed/simple;
	bh=mGmTlGY7L/r4mcNbVIrJMt0XiRwwNiF9lvGKR9qPfm4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=ClFVds60LuTLbChofYVlSCZ/L0FqwjIoBHpOZ2eUfYVUrdiohTmFBe2NslReQ/H/7MpWHPumlcLR2VKdjPpk617WH1Xc63CoNMzdo8Rajo9qVE0T1ljudmxb9m1OOgzqJ5ZdssB6LaSRm4HhSFb3M6tmO6Qx6qijG/MG6dKHmJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=UGbeqsLb; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=OU/L7EQM; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 08BB23370C
	for <linux-btrfs@vger.kernel.org>; Thu, 11 Dec 2025 06:25:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1765434347; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=r9tZXSv9IXdS7luFkJGGedbqlnA3BYeHHcvt+LduRK4=;
	b=UGbeqsLbeHrY3+5L7W+LtwLeFkNdvPfFpIF0sRFVq96cdHaEtUH6/qMvyTdLpMjeK1jWGP
	DnX2vyb42x5acif83M80y7H9lWW4O5Ol2iOsH/ZCiJBm8tU9BGnQq+rY+ZVwGxOH4wCbAJ
	IctQA5FkjgTcnuw+GNrkE60pHOMa0Ls=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1765434346; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=r9tZXSv9IXdS7luFkJGGedbqlnA3BYeHHcvt+LduRK4=;
	b=OU/L7EQMNrVK6JYjiLSfx69dLlnVT3jqYI/KQR4Y3iGtw5snYuT6oWELk2T05Taqu+u8IH
	1z+7DTxarNEwCxY6eHMXNBtDzzwtzrnVENFPOWuO536kle/x88aOn89WLQeCP4MYdvx0zd
	2LH0OF6Pp50JL8t7RAlyt7b6BcU3acc=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3EA0F3EA63
	for <linux-btrfs@vger.kernel.org>; Thu, 11 Dec 2025 06:25:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 9/1FAOljOmmuVwAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Thu, 11 Dec 2025 06:25:45 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2] btrfs: search for larger extent maps inside btrfs_do_readpage()
Date: Thu, 11 Dec 2025 16:55:23 +1030
Message-ID: <7b5888df903f412b05831ea5302e586cf38c231f.1765434313.git.wqu@suse.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -2.70
X-Spam-Level: 
X-Spamd-Result: default: False [-2.70 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	MIME_GOOD(-0.10)[text/plain];
	NEURAL_HAM_SHORT(-0.10)[-0.483];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_ONE(0.00)[1];
	ARC_NA(0.00)[];
	TO_DN_NONE(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email,suse.com:mid]

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

Such change will reduce the overhead of reading large holes a little.
For current experimental build (with larger folios) on aarch64, there
will be a tiny but consistent ~1% improvement reading a large hole file:

 Reading a 1GiB sparse file (all hole) using xfs_io, with 64K block
 size, the result is the time needed to read the whole file, reported
 from xfs_io.

 32 runs, experimental build (with large folios).

 64K page size, 4K fs block size.

 - Avg before: 0.20823 s
 - Avg after:  0.20635 s
 - Diff:   -0.9%

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
Changelog:
v2:
- Add a benchmark result for the enhancement
- Use if () to assigned @locked_end
  This drops the const prefix thought.
---
 fs/btrfs/extent_io.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index a4b74023618d..6caaf6b6fdce 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -998,11 +998,17 @@ static int btrfs_do_readpage(struct folio *folio, struct extent_map **em_cached,
 	u64 start = folio_pos(folio);
 	const u64 end = start + folio_size(folio) - 1;
 	u64 extent_offset;
+	u64 locked_end;
 	u64 last_byte = i_size_read(inode);
 	struct extent_map *em;
 	int ret = 0;
 	const size_t blocksize = fs_info->sectorsize;
 
+	if (bio_ctrl->ractl)
+		locked_end = readahead_pos(bio_ctrl->ractl) + readahead_length(bio_ctrl->ractl) - 1;
+	else
+		locked_end = end;
+
 	ret = set_folio_extent_mapped(folio);
 	if (ret < 0) {
 		folio_unlock(folio);
@@ -1036,7 +1042,14 @@ static int btrfs_do_readpage(struct folio *folio, struct extent_map **em_cached,
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


