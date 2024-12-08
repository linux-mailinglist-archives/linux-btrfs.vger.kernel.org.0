Return-Path: <linux-btrfs+bounces-10115-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 22F759E8334
	for <lists+linux-btrfs@lfdr.de>; Sun,  8 Dec 2024 03:51:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2A92281CE8
	for <lists+linux-btrfs@lfdr.de>; Sun,  8 Dec 2024 02:51:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F367381BA;
	Sun,  8 Dec 2024 02:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="QxH4piZW";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="QxH4piZW"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81D681B95B;
	Sun,  8 Dec 2024 02:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733626290; cv=none; b=RrxjRW2QALIEBzmU/ztPTbyulS0G5cxyjp/W96TM4cX3mgHwSrn9tY6Wy3VEQoSSb3JJp0DkIBgfZlXQC+o/9N1ZR1Pw6ho+CgwYdnF02ZZbm1EBPFb0NvBK0xS/mak4N0gFxlOROeGrsNc2nbeIwtgxNWG4jAfA5SiOmkKQKDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733626290; c=relaxed/simple;
	bh=AwN3Aaa5CQt1KQnJX+FjCyxAkHDp+VZgPstT6Uw6g6w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ol6n6pEADf3UtzIyMX8Bd5jWqfy2dLVuNOc6Ps511GaDB5ukFWwgn5LQHN7yM9sLtJd83j+fVoiuqIXbYTwnZRsa6e9J2PnFOpV5vO81aZgRb0V5TxOzrnii5mX0u5/5Vb1Djuz6w+/79d2C9yFFY85WOMuMvXQv0y+EgGE6XJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=QxH4piZW; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=QxH4piZW; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 9BB161F381;
	Sun,  8 Dec 2024 02:51:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1733626285; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cS2HyLCi4s8/hAjytAZT+knu4pqOoOKuA3DhFnmQ5tw=;
	b=QxH4piZWt34hB0npEkC6pciNM+JnXU7osa71etbkNqf885zSe6GXzBN0Z/Xky+NOG/h6q7
	VQU4EAbJzxutwNz5AB+zw7D5C5w2xp/+UmGHDlIpPlTogdURFDoVaStrlj0xRqtHaeUWa7
	HVAU3F2DcbZ42qzhxj7LIC3u52Ah8mg=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=QxH4piZW
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1733626285; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cS2HyLCi4s8/hAjytAZT+knu4pqOoOKuA3DhFnmQ5tw=;
	b=QxH4piZWt34hB0npEkC6pciNM+JnXU7osa71etbkNqf885zSe6GXzBN0Z/Xky+NOG/h6q7
	VQU4EAbJzxutwNz5AB+zw7D5C5w2xp/+UmGHDlIpPlTogdURFDoVaStrlj0xRqtHaeUWa7
	HVAU3F2DcbZ42qzhxj7LIC3u52Ah8mg=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9CCD5133D1;
	Sun,  8 Dec 2024 02:51:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id CAvkF6wJVWcXcQAAD6G6ig
	(envelope-from <wqu@suse.com>); Sun, 08 Dec 2024 02:51:24 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH 1/8] btrfs: fix double accounting race when btrfs_run_delalloc_range() failed
Date: Sun,  8 Dec 2024 13:20:58 +1030
Message-ID: <5dbaa2ecb29e4f2d6deb8a502d178706d09d48ee.1733624454.git.wqu@suse.com>
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
X-Rspamd-Queue-Id: 9BB161F381
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
	ARC_NA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:mid,suse.com:email];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

[BUG]
There are several double accounting case, where the WARN_ON_ONCE() is
triggered inside can_finish_ordered_extent().

And all such cases points back to the btrfs_mark_ordered_io_finished()
call inside extent_writepage() when it hits some error.

[CAUSE]
With extra debug patches to show where the error is from, it turns out
to be btrfs_run_delalloc_range() can fail with -ENOSPC.

Such failure itself is already a symptom of some bad data/metadata space
reservation, but here we need to focus on the error handling part.

For example, we have the following dirty page layout (4K sector size and
4K page size):

    0                       16K                     32K
    |/////|/////|/////|/////|/////|/////|/////|/////|

Where the range [0, 32K) is dirty and we need to write all the 8 pages
back.

When handling the first page 0, we go the following sequence:

- btrfs_run_delalloc_range() for range [0, 32k)
  We enter cow_file_range() for [0, 32K)

- btrfs_reserve_extent() only returned a 16K data extent.
  This can be caused by fragmentation, and it's already an indication
  we're almost running of space.

  Now we have the following layout:

    0                       16K                     32K
    |<----- Reserved ------>|/////|/////|/////|/////|

  The range [0, 16K) has ordered extent allocated.

- btrfs_reserve_extent() returned -ENOSPC
  We really run out of space. But since we have reserved space
  for range [0, 16K) we need to clean them up.

  But that cleanup for ordered extent only happens inside
  btrfs_run_delalloc_range().

- btrfs_run_delalloc_range() cleanup the reserved ordered extent
  By calling btrfs_mark_ordered_io_finished() for range [0, 32K).

  It will locate the ordered extent [0, 16K) and mark it as IOERR.
  Also since the ordered extent is only 16K, we're finishing the whole
  ordered extent.

  Thus we call btrfs_queue_ordered_fn() to queue to finish the ordered
  extent.
  But still, the ordered extent [0, 16K) is still in the
  btrfs_inode::ordered_tree.

- extent_writepage() cleanup the ordered extent inside the folio
  We call btrfs_mark_ordered_io_finished() for range [0, 4K).

  Since the finished ordered extent [0, 16K) is not yet removed (racy,
  depends on when btrfs_finish_one_ordered() is called), if
  btrfs_mark_ordered_io_finished() is called before
  btrfs_finish_one_ordered(), we will double account and trigger the
  warning inside can_finish_ordered_extent().

So the root cause is, we're relying on btrfs_mark_ordered_io_finished()
to handle ranges which is already cleaned up.

Unfortunately the bug dates back to the early days when
btrfs_mark_ordered_io_finished() is introduced as a no-brain choice for
error paths, but such no-brain solution just hides all the race and make
us less cautious when handling errors.

[FIX]
Instead of relying on the btrfs_mark_ordered_io_finished() call to
cleanup the whole folio range, record the last successfully ran delalloc
range.

And combined with bio_ctrl->submit_bitmap to properly clean up any newly
created ordered extents.

Since we have cleaned up the ordered extents in range, we should not
rely on the btrfs_mark_ordered_io_finished() inside extent_writepage()
anymore.

By this, we ensure btrfs_mark_ordered_io_finished() is only called once
when writepage_delalloc() failed.

Cc: stable@vger.kernel.org # 5.15+
Fixes: e65f152e4348 ("btrfs: refactor how we finish ordered extent io for endio functions")
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/extent_io.c | 37 ++++++++++++++++++++++++++++++++-----
 1 file changed, 32 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 9725ff7f274d..417c710c55ca 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -1167,6 +1167,12 @@ static noinline_for_stack int writepage_delalloc(struct btrfs_inode *inode,
 	 * last delalloc end.
 	 */
 	u64 last_delalloc_end = 0;
+	/*
+	 * Save the last successfully ran delalloc range end (exclusive).
+	 * This is for error handling to avoid ranges with ordered extent created
+	 * but no IO will be submitted due to error.
+	 */
+	u64 last_finished = page_start;
 	u64 delalloc_start = page_start;
 	u64 delalloc_end = page_end;
 	u64 delalloc_to_write = 0;
@@ -1235,11 +1241,19 @@ static noinline_for_stack int writepage_delalloc(struct btrfs_inode *inode,
 			found_len = last_delalloc_end + 1 - found_start;
 
 		if (ret >= 0) {
+			/*
+			 * Some delalloc range may be created by previous folios.
+			 * Thus we still need to clean those range up during error
+			 * handling.
+			 */
+			last_finished = found_start;
 			/* No errors hit so far, run the current delalloc range. */
 			ret = btrfs_run_delalloc_range(inode, folio,
 						       found_start,
 						       found_start + found_len - 1,
 						       wbc);
+			if (ret >= 0)
+				last_finished = found_start + found_len;
 		} else {
 			/*
 			 * We've hit an error during previous delalloc range,
@@ -1274,8 +1288,21 @@ static noinline_for_stack int writepage_delalloc(struct btrfs_inode *inode,
 
 		delalloc_start = found_start + found_len;
 	}
-	if (ret < 0)
+	/*
+	 * It's possible we have some ordered extents created before we hit
+	 * an error, cleanup non-async successfully created delalloc ranges.
+	 */
+	if (unlikely(ret < 0)) {
+		unsigned int bitmap_size = min(
+			(last_finished - page_start) >> fs_info->sectorsize_bits,
+			fs_info->sectors_per_page);
+
+		for_each_set_bit(bit, &bio_ctrl->submit_bitmap, bitmap_size)
+			btrfs_mark_ordered_io_finished(inode, folio,
+				page_start + (bit << fs_info->sectorsize_bits),
+				fs_info->sectorsize, false);
 		return ret;
+	}
 out:
 	if (last_delalloc_end)
 		delalloc_end = last_delalloc_end;
@@ -1509,13 +1536,13 @@ static int extent_writepage(struct folio *folio, struct btrfs_bio_ctrl *bio_ctrl
 
 	bio_ctrl->wbc->nr_to_write--;
 
-done:
-	if (ret) {
+	if (ret)
 		btrfs_mark_ordered_io_finished(BTRFS_I(inode), folio,
 					       page_start, PAGE_SIZE, !ret);
-		mapping_set_error(folio->mapping, ret);
-	}
 
+done:
+	if (ret < 0)
+		mapping_set_error(folio->mapping, ret);
 	/*
 	 * Only unlock ranges that are submitted. As there can be some async
 	 * submitted ranges inside the folio.
-- 
2.47.1


