Return-Path: <linux-btrfs+bounces-9907-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4651D9D91C7
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Nov 2024 07:30:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BFB4FB20F72
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Nov 2024 06:30:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C107817C208;
	Tue, 26 Nov 2024 06:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="k/pnDnc3";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="k/pnDnc3"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75AAC3208;
	Tue, 26 Nov 2024 06:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732602603; cv=none; b=YoO10YiZs0aI85SF9XE6nCrIeQvsOqJ1blmpzUFoV7PCh1kSB0GOJXJbYkA/qBz1yH7F4y493bubRYQdOsNeds1RCv6FslBqhgRuL4XXjrW4O8cU3WSpr6zfMzth7D2YEeDBxnzKtQaGrHUUfjzdw3oi6iLDtsVIGQZm0yzi8JI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732602603; c=relaxed/simple;
	bh=PGVIabG8i4G54Xa+u6HsKZwViPWlu+jiGWi5wqziZo8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IIn1/+uXN3hUSAahZTuBnJfBecZqZcsa5XMeFYZm24jucVWeK7q4rWdbQZEhv09WKWCp9ykmu7Ny7zFbO/jUUI0uI8TCNQpKu489hiYyE3KhRbmANMzcMhK9rAJNuL+P4x/Warn2ZCjS8U9/0Pe28/UVMQ77qR7Y5CcA3E5qdiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=k/pnDnc3; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=k/pnDnc3; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 5C18F21153;
	Tue, 26 Nov 2024 06:29:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1732602593; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gnrUl362Xiw2/ygz3JhH81Z9lOpoWU3jOtJSx7S/a5E=;
	b=k/pnDnc3KKNVu7BnJgajZWsfdurgnLw2mkPVDxKAkEV0PoM5UYLHwvnu/CcHzFhcbyVRod
	q64uZ1WpB3R/0A7771jmjB/j1Pp8ph4R3X5/faeLiZ64rI3CMYLorTXCGUyumTfm8Ehcl0
	OtNNPj9nrPi6TPy86i/VsWBdtKMnIt8=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b="k/pnDnc3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1732602593; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gnrUl362Xiw2/ygz3JhH81Z9lOpoWU3jOtJSx7S/a5E=;
	b=k/pnDnc3KKNVu7BnJgajZWsfdurgnLw2mkPVDxKAkEV0PoM5UYLHwvnu/CcHzFhcbyVRod
	q64uZ1WpB3R/0A7771jmjB/j1Pp8ph4R3X5/faeLiZ64rI3CMYLorTXCGUyumTfm8Ehcl0
	OtNNPj9nrPi6TPy86i/VsWBdtKMnIt8=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3B9EB139AA;
	Tue, 26 Nov 2024 06:29:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id OOACOt9qRWeZUQAAD6G6ig
	(envelope-from <wqu@suse.com>); Tue, 26 Nov 2024 06:29:51 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH 1/2] btrfs: handle btrfs_run_delalloc_range() errors correctly
Date: Tue, 26 Nov 2024 16:59:23 +1030
Message-ID: <3d7d7a1151b3f3cc64dbf3a06d46dd08c5c86a8f.1732596971.git.wqu@suse.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1732596971.git.wqu@suse.com>
References: <cover.1732596971.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 5C18F21153
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
	FROM_HAS_DN(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_TRACE(0.00)[suse.com:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

[BUG]
There are several crash or hang during fstests runs with sectorsize < page
size setup.

It turns out that most of those hang happens after a
btrfs_run_delalloc_range() failure (caused by -ENOSPC).

The most common one is generic/750.

The symptom are all related to ordered extent finishing, where we double
account the target ordered extent.

[CAUSE]
Inside writepage_delalloc() if we hit an error from
btrfs_run_delalloc_range(), we still need to unlock all the locked
range, but that's the only error handling.

If we have the following page layout with a 64K page size and 4K sector
size:

    0    4K                 32K  40K          60K   64K
    |////|                  |////|            |/////|

Where |//| is the dirtied blocks inside the folio.

Then we hit the following sequence:

- Enter writepage_delalloc() for folio 0

- btrfs_run_delalloc_range() returned 0 for [0, 4K)
  And created regular COW ordered extent for range [0, 4K)

- btrfs_run_delalloc_range() returned 0 for [32K, 40K)
  And created async extent for range [32K, 40K).

  This means the error handling will be done in another thread, we
  should not touch the range anymore.

- btrfs_run_delalloc_range() failed with -ENOSPC for range [60K, 64K)
  In theory we should not fail since we should have reserved enough
  space at buffered write time, but let's ignore that rabbit hole and
  focus on the error handling.

- Error handling in extent_writepage()
  Now we go to the done: tag, calling btrfs_mark_ordered_io_finished()
  for the whole folio range.

  This will find ranges [0, 4K) and [32K, 40K) to cleanup, for [0, 4K)
  it should be cleaned up, but for range [32K, 40K) it's asynchronously
  handled, the OE may have already been submitted.

  This will lead to the double account for range [32K, 40K) and crash
  the kernel.

Unfortunately this bad error handling is from the very beginning of
sector size < page size support.

[FIX]
Instead of relying on the btrfs_mark_ordered_io_finished() call to
cleanup the whole folio range, record the last successfully ran delalloc
range.

And combined with bio_ctrl->submit_bitmap to properly clean up any newly
created ordered extents.

Since we have cleaned up the ordered extents in range, we should not
rely on the btrfs_mark_ordered_io_finished() inside extent_writepage()
anymore.

By this, we should avoid double accounting during error handling.

Cc: stable@vger.kernel.org # 5.15+
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/extent_io.c | 45 ++++++++++++++++++++++++++++++++++++--------
 1 file changed, 37 insertions(+), 8 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 438974d4def4..0132c2b84d99 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -1145,11 +1145,13 @@ static bool find_next_delalloc_bitmap(struct folio *folio,
  * helper for extent_writepage(), doing all of the delayed allocation setup.
  *
  * This returns 1 if btrfs_run_delalloc_range function did all the work required
- * to write the page (copy into inline extent).  In this case the IO has
- * been started and the page is already unlocked.
+ * to write the page (copy into inline extent or compression).  In this case
+ * the IO has been started and we should no longer touch the page (may have
+ * already been unlocked).
  *
  * This returns 0 if all went well (page still locked)
- * This returns < 0 if there were errors (page still locked)
+ * This returns < 0 if there were errors (page still locked), in this case any
+ * newly created delalloc range will be marked as error and finished.
  */
 static noinline_for_stack int writepage_delalloc(struct btrfs_inode *inode,
 						 struct folio *folio,
@@ -1167,6 +1169,12 @@ static noinline_for_stack int writepage_delalloc(struct btrfs_inode *inode,
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
@@ -1235,11 +1243,19 @@ static noinline_for_stack int writepage_delalloc(struct btrfs_inode *inode,
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
@@ -1274,8 +1290,21 @@ static noinline_for_stack int writepage_delalloc(struct btrfs_inode *inode,
 
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
@@ -1509,13 +1538,13 @@ static int extent_writepage(struct folio *folio, struct btrfs_bio_ctrl *bio_ctrl
 
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
2.47.0


