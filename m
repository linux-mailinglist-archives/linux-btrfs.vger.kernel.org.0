Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC8CE3DE65C
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Aug 2021 07:53:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233749AbhHCFyE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 3 Aug 2021 01:54:04 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:52502 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230096AbhHCFyD (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 3 Aug 2021 01:54:03 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 1CB5E22068
        for <linux-btrfs@vger.kernel.org>; Tue,  3 Aug 2021 05:53:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1627970032; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=1883Ln58cHbQGBmKGb6Bmm+1Ol9Z8aNPdnn+4i/fuCw=;
        b=axTlI0eJPQb50n5HNZPbCv58vwlk5KRufXhoA1RQedNWn2fKXsSyH0/kW+x/weYmAJOqYF
        R5IrjuhPik8uXySIo+cwI2uxE7rjoaz8rxbDZhXuqFaKxfDRponzKCFAwJSd8AkRezd0Y8
        HEB/adX5pqP6+nGr/9I7Z3LVysa1DzE=
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 422F313668
        for <linux-btrfs@vger.kernel.org>; Tue,  3 Aug 2021 05:53:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id u3tHAO/ZCGH0QgAAGKfGzw
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Tue, 03 Aug 2021 05:53:50 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: don't call end_extent_writepage() in __extent_writepage() when IO failed
Date:   Tue,  3 Aug 2021 13:53:48 +0800
Message-Id: <20210803055348.170042-1-wqu@suse.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

[BUG]
When running generic/475 with 64K page size and 4K sectorsize (aka
subpage), it can trigger the following BUG_ON() inside
btrfs_csum_one_bio(), the possibility is around 1/20 ~ 1/5:

	bio_for_each_segment(bvec, bio, iter) {
		if (!contig)
			offset = page_offset(bvec.bv_page) + bvec.bv_offset;

		if (!ordered) {
			ordered = btrfs_lookup_ordered_extent(inode, offset);
			BUG_ON(!ordered); /* Logic error */ <<<<
		}

		nr_sectors = BTRFS_BYTES_TO_BLKS(fs_info,

[CAUSE]
Test case generic/475 uses dm-errors to emulate IO failure.

Here if we have a page cache which has the following delalloc range:

	0		32K		64K
	|/////|		|////|		|
	\- [0, 4K)	\- [32K, 36K)

And then __extent_writepage() can go through the following race:

	T1 (writeback)		|	T2 (endio)
--------------------------------+----------------------------------
__extent_writepage()		|
|- writepage_delalloc()		|
|  |- run_delalloc_range()	|
|  |  Add OE for [0, 4K)	|
|  |- run_delalloc_range()	|
|     Add OE for [32K, 36K)	|
|				|
|- __extent_writepage_io()	|
|  |- submit_extent_page()	|
|  |  |- Assemble the bio for	|
|  |     range [0, 4K)		|
|  |- submit_extent_page()	|
|  |  |- Submit the bio for	|
|  |  |  range [0, 4K)		|
|  |  |				| end_bio_extent_writepage()
|  |  |				| |- error = -EIO;
|  |  |				| |- end_extent_writepage( error=-EIO);
|  |  |				|    |- writepage_endio_finish_ordered()
|  |  |				|    |  Remove OE for range [0, 4K)
|  |  |				|    |- btrfs_page_set_error()
|  |- submit_extent_page()	|
|     |- Assemble the bio for	|
|        range [32K, 36K)	|
|- if (PageError(page))		|
|- end_extent_writepage()	|
   |- endio_finish_ordered()	|
      Remove OE [32K, 36K)	|
				|
Submit bio for [32K, 36K)	|
|- btrfs_csum_one_bio()		|
   |- BUG_ON(!ordered_extent)	|
      OE [32K, 36K) is already  |
      removed.			|

This can only happen for subpage case, as for regular sectorsize, we
never submit current page, thus IO error will never mark the current
page Error.

[FIX]
Just remove the end_extent_writepage() call and the if (PageError())
check.

As mentioned, the end_extent_writepage() never really get executed for
regular sectorsize, and could cause above BUG_ON() for subpage.

This also means, inside __extent_writepage() we should not bother any IO
failure, but only focus on the error hit during bio assembly and
submission.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/extent_io.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index e665779c046d..a1a6ac787faf 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -4111,8 +4111,8 @@ static int __extent_writepage(struct page *page, struct writeback_control *wbc,
 	 * Here we used to have a check for PageError() and then set @ret and
 	 * call end_extent_writepage().
 	 *
-	 * But in fact setting @ret here will cause different error paths
-	 * between subpage and regular sectorsize.
+	 * But in fact setting @ret and call end_extent_writepage() here will
+	 * cause different error paths between subpage and regular sectorsize.
 	 *
 	 * For regular page size, we never submit current page, but only add
 	 * current page to current bio.
@@ -4124,7 +4124,12 @@ static int __extent_writepage(struct page *page, struct writeback_control *wbc,
 	 * thus can get PageError() set by submitted bio of the same page,
 	 * while our @ret is still 0.
 	 *
-	 * So here we unify the behavior and don't set @ret.
+	 * The same is also for end_extent_writepage(), which can finish
+	 * ordered extent before submitting the real bio, causing
+	 * BUG_ON() in btrfs_csum_one_bio().
+	 *
+	 * So here we unify the behavior and don't set @ret nor call
+	 * end_extent_writepage().
 	 * Error can still be properly passed to higher layer as page will
 	 * be set error, here we just don't handle the IO failure.
 	 *
@@ -4138,8 +4143,7 @@ static int __extent_writepage(struct page *page, struct writeback_control *wbc,
 	 * Currently the full page based __extent_writepage_io() is not
 	 * capable of that.
 	 */
-	if (PageError(page))
-		end_extent_writepage(page, ret, start, page_end);
+
 	unlock_page(page);
 	ASSERT(ret <= 0);
 	return ret;
-- 
2.32.0

