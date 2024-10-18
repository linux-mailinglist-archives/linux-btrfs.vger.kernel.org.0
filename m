Return-Path: <linux-btrfs+bounces-8995-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 269CC9A33BD
	for <lists+linux-btrfs@lfdr.de>; Fri, 18 Oct 2024 06:23:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9DDA285DB2
	for <lists+linux-btrfs@lfdr.de>; Fri, 18 Oct 2024 04:23:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38B3917109B;
	Fri, 18 Oct 2024 04:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="iH53YjpF";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="iH53YjpF"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F33513BC26
	for <linux-btrfs@vger.kernel.org>; Fri, 18 Oct 2024 04:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729225414; cv=none; b=G+GIz79TeSX4gViUYvFK0y0mqM4phYiZHa0R39cCJl0NrTNSprvxu0YGEFFxuzk0Aja3al0+yM1JciutHPqjL2Z/rf/eK0z1tTy0g62IRU0HNp7OGRB1b6IIYNPTE3sLWzB1FyINKwTfSfo1wcWqi/LrL72HjRd8QKb+bt1yQAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729225414; c=relaxed/simple;
	bh=ZGHBR8IJ0pnzkLALXG5yttE7GxW+NY4uW9zwRigQ3Zs=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=R1cv36mq1+ZK1BkV5rsf2ac0HPQ+M8yWmjNypN+QEalAP3/wTnEdYuZjXVhn4ODau8p4bysSa6pr3aPgkPZQzOWEIQJWJU/bZxlcS0MDTAy7Jc8XXDO9ufLdLkndRZCN3VkT2+QdBacjfHDBu/ozCoYnr+PDMgutbpgfGZyWV4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=iH53YjpF; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=iH53YjpF; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 97CF01F852
	for <linux-btrfs@vger.kernel.org>; Fri, 18 Oct 2024 04:23:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1729225409; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=Y3BFMpzqw6kM9iHb1+L8/mSHD40DQAd6cH6BGXiwv50=;
	b=iH53YjpFz1EutUgajDtu8Nd38MW1c1jUTa3M3xrQMMseJDrTShBOaLEhR+gnonai1vCiVk
	EeCahYq82mdhPMEZpY3I8umd8ZbEAR+zprngZhpfSkDaMCds+IQDc9oSEQ6Dh++UO+5dx9
	mYZtNzmywrdMniTdbaELyx2ZHLDD0j4=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1729225409; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=Y3BFMpzqw6kM9iHb1+L8/mSHD40DQAd6cH6BGXiwv50=;
	b=iH53YjpFz1EutUgajDtu8Nd38MW1c1jUTa3M3xrQMMseJDrTShBOaLEhR+gnonai1vCiVk
	EeCahYq82mdhPMEZpY3I8umd8ZbEAR+zprngZhpfSkDaMCds+IQDc9oSEQ6Dh++UO+5dx9
	mYZtNzmywrdMniTdbaELyx2ZHLDD0j4=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D8F9213433
	for <linux-btrfs@vger.kernel.org>; Fri, 18 Oct 2024 04:23:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 3QTVJsDiEWerAwAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Fri, 18 Oct 2024 04:23:28 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH RFC] btrfs: do not release the folio if it still has pinned extent maps
Date: Fri, 18 Oct 2024 14:53:11 +1030
Message-ID: <6c0e832ac115699d2e6737a0b248c7020cffa834.1729225331.git.wqu@suse.com>
X-Mailer: git-send-email 2.47.0
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

[BUG]
If the sector size is smaller than page size, and we allow btrfs to
avoid reading the full page as long as the buffered write range is
sector aligned, we can hit a hang with generic/095 runs:

  __switch_to+0xf8/0x168
  __schedule+0x328/0x8a8
  schedule+0x54/0x140
  io_schedule+0x44/0x68
  folio_wait_bit_common+0x198/0x3f8
  __folio_lock+0x24/0x40
  extent_write_cache_pages+0x2e0/0x4c0 [btrfs]
  btrfs_writepages+0x94/0x158 [btrfs]
  do_writepages+0x74/0x190
  filemap_fdatawrite_wbc+0x88/0xc8
  __filemap_fdatawrite_range+0x6c/0xa8
  filemap_fdatawrite_range+0x1c/0x30
  btrfs_start_ordered_extent+0x264/0x2e0 [btrfs]
  btrfs_lock_and_flush_ordered_range+0x8c/0x160 [btrfs]
  __get_extent_map+0xa0/0x220 [btrfs]
  btrfs_do_readpage+0x1bc/0x5d8 [btrfs]
  btrfs_read_folio+0x50/0xa0 [btrfs]
  filemap_read_folio+0x54/0x110
  filemap_update_page+0x2e0/0x3b8
  filemap_get_pages+0x228/0x4d8
  filemap_read+0x11c/0x3b8
  btrfs_file_read_iter+0x74/0x90 [btrfs]
  new_sync_read+0xd0/0x1d0
  vfs_read+0x1a0/0x1f0

[CAUSE]
The above call trace shows that, during the folio read a writeback is
triggered on the same folio.
And since during btrfs_do_readpage(), the folio is locked, the writeback
will never be able to get the folio, thus it is waiting on itself thus
causing the deadlock.

The root cause is a little complex, the system is 64K page sized, with
4K sector size:

1) The folio has its range [48K, 64K) marked dirty by buffered write

   0          16K         32K          48K         64K
   |                                   |///////////|
                                             \- sector Uptodate|Dirty

2) Writeback finished for [48K, 64K), but ordered extent not yet finished

   0          16K         32K          48K         64K
   |                                   |///////////|
                                             \- sector Uptodate
					        extent map PINNED
						OE still here

3) Direct IO tries to drop the folio
   Since there is no locked extent map, btrfs allows the folio to be
   released. Now no sector in the folio has uptodate flag.
   But extent map and OE are still here.

   0          16K         32K          48K         64K
   |                                   |///////////|
                                             \- extent map PINNED
						OE still here

4) Buffered write dirtied range [0, 16K)
   Since it's sector aligned, btrfs didn't read the full folio from disk.

   0          16K         32K          48K         64K
   |//////////|                        |///////////|
       \- sector Uptodate|Dirty              \- extent map PINNED
						OE still here

5) Read on the folio is triggered
   For the range [0, 16), since it's already uptodate, btrfs skip this
   range.
   For the range [16K, 48K), btrfs submit the read from disk.

   The problem comes to the range [48K, 64K), the following call chain
   happens:

   btrfs_do_readpage()
   \- __get_extent_map()
    \- btrfs_lock_and_flush_ordered_range()
     \- btrfs_start_ordered_extent()
      \- filemap_fdatawrite_range()

   Since the folio indeed has dirty sectors in range [0, 16K), the range
   will be written back.

   But the folio is already locked by the folio read, the writeback
   will never be able to lock the folio, thus lead to the deadlock.

This sequence can only happen if all the following conditions are met:

- The sector size is smaller than page size
  Or we won't have mixed dirty blocks in the same folio we're reading.

- We allow the buffered write to skip the folio read if it's sector
  aligned
  This is the incoming new optimization for sector size < page size to
  pass generic/563.

  Or the folio will be fully read from the disk, before marking it
  dirty.
  Thus will not trigger the deadlock.

[FIX]
- Only lookup for the extent map of the next sector to read
  To avoid touching ranges that can be skipped by per-sector uptodate
  flag.

- Break the step 3) of the above case
  If the folio is not released, then the range [48K, 64K) will be kept
  uptodate, so that step 5) can skip the OE flush on range [48K, 64),
  thus avoid the deadlock.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
Reason for RFC:

I'm not sure if it's the best way to avoid the deadlock, in theory I can
enhance btrfs_start_ordered_extent() to avoid filemap_fdatawrite_range()
is the subpage range is not dirty.

I have some alternatives but neither are small nor less impacting:

- Make sure folio writeback is only cleared then the OE finishes
  This will enlarge the lifespan of writeback flag.
  This will be a huge change.

  But now we can just rely on the writeback flag to do most checks, and
  no extra need to check for OEs.

- Make btrfs_start_ordered_extent() to skip the writeback as long as
  the range is not dirty

  This requires all callers to pass a locked folio parameter, and do the
  subpage checks there.
  This looks less impacting, but still more impacting than the current
  solution.
---
 fs/btrfs/extent_io.c | 37 ++++++++++++++++++++++++++++++++++---
 1 file changed, 34 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 7680dd94fddf..c9d9752e4ff4 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -986,8 +986,7 @@ static int btrfs_do_readpage(struct folio *folio, struct extent_map **em_cached,
 			end_folio_read(folio, true, cur, blocksize);
 			continue;
 		}
-		em = __get_extent_map(inode, folio, cur, end - cur + 1,
-				      em_cached);
+		em = __get_extent_map(inode, folio, cur, blocksize, em_cached);
 		if (IS_ERR(em)) {
 			end_folio_read(folio, false, cur, end + 1 - cur);
 			return PTR_ERR(em);
@@ -2430,10 +2429,42 @@ bool try_release_extent_mapping(struct folio *folio, gfp_t mask)
 			write_unlock(&extent_tree->lock);
 			break;
 		}
+		/*
+		 * If the em is pinned (aka, will only be unpinned when
+		 * the current transaction committed), and we release the folio,
+		 * it can lead to a situation where a read can lead to a deadlock
+		 * which requires writeback of the same folio, when sector size is
+		 * smaller than page size:
+		 *
+		 * - Writeback for the em range is finished, but file extents
+		 *   not yet inserted.
+		 *
+		 * - Direct IO request the folio to be released.
+		 *
+		 * - Since there is only pinned em, the folio is released
+		 *
+		 * - Some sectors of the page is dirtied
+		 *   But we allow the buffered write to only dirty the involved
+		 *   sectors, no need to read the full folio
+		 *
+		 * - A read on the full folio triggered
+		 *   * __get_extent_map() calls btrfs_lock_and_flush_ordered_range()
+		 *     on the range we still have pinned extent maps.
+		 *   * btrfs_start_ordered_extent() called on the ordered extent
+		 *   * filemap_fdatawait_range() called on the same folio
+		 *     ^^^ Deadlock, because the folio is already locked by
+		 *         the folio read.
+		 *
+		 * Here we break the above possible deadlock chain by not releasing
+		 * the folio until there is no locked nor pinned extent map.
+		 *
+		 * In that case, the pinned range will have uptodate sectors, so
+		 * the folio read will not try to do any ordered extent waiting.
+		 */
 		if ((em->flags & EXTENT_FLAG_PINNED) || em->start != start) {
 			write_unlock(&extent_tree->lock);
 			free_extent_map(em);
-			break;
+			return false;
 		}
 		if (test_range_bit_exists(io_tree, em->start,
 					  extent_map_end(em) - 1, EXTENT_LOCKED))
-- 
2.47.0


