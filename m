Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEE6E3DD0D3
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Aug 2021 08:54:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232384AbhHBGzC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 2 Aug 2021 02:55:02 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:50012 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231410AbhHBGzB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 2 Aug 2021 02:55:01 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 1340C21FC1
        for <linux-btrfs@vger.kernel.org>; Mon,  2 Aug 2021 06:54:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1627887292; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rdVCkzE0+C+RsCL1j955ktF9woLX4lv0dnOdt5/8VEw=;
        b=f70F68iwc9nfN0QSZ7rKqeAzPNL1aqkoeafcyHepVfV5Y7LGlwanTpdvUAIvTJ6do+PBwr
        +ATNbUZKnK7nR0bj2KxgjSegZ2s8ULHuT7dmZakLN4QQ721lS6N6rqA0rcq61cJrplcnMa
        dluFoTWCv1yFglhtn5UGwXqY6I6h+Ss=
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 4B1471371C
        for <linux-btrfs@vger.kernel.org>; Mon,  2 Aug 2021 06:54:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id uNVzA7uWB2FtawAAGKfGzw
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Mon, 02 Aug 2021 06:54:51 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 1/2] btrfs: don't try to flush data write bio if we hit error preparing it
Date:   Mon,  2 Aug 2021 14:54:46 +0800
Message-Id: <20210802065447.178726-2-wqu@suse.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210802065447.178726-1-wqu@suse.com>
References: <20210802065447.178726-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

[BUG]
When running with 64K page size and 4K sectorsize (aka, subpage), there
is a chance that generic/475 would crash with the following BUG_ON() in
btrfs_csum_one_bio() triggered:

		if (!ordered) {
			ordered = btrfs_lookup_ordered_extent(inode, offset);
			BUG_ON(!ordered); /* Logic error */
		}

[CAUSE]
Test case generic/475 is doing dm-error testing, while for subpage case
we could hit error caused by dm-errors.

In that case, we will proper call end_extent_writepage() with @err = 1
to do the cleanup, including finishing the ordered extent.

In that case, the assembled bio still needs to be finished, by
end_write_bio() function.

But there are call sites that doesn't properly call end_write_bio(), but
go flush_write_bio() to submit the assembled bio.

In that case, we will call btrfs_csum_one_bio() even the ordered extent
is already cleaned up, and trigger the BUG_ON().

[FIX]
There are two call sites where we still try to call flush_write_bio()
even if we hit error:

- extent_write_cache_pages()
- extent_write_locked_range()

Fix both of them by calling end_write_bio() if we hit error.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/extent_io.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index e82328bcb281..49f7dbbb2d73 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -5035,9 +5035,13 @@ static int extent_write_cache_pages(struct address_space *mapping,
 		 * page in our current bio, and thus deadlock, so flush the
 		 * write bio here.
 		 */
-		ret = flush_write_bio(epd);
-		if (!ret)
-			goto retry;
+		if (ret < 0) {
+			end_write_bio(epd, ret);
+		} else {
+			ret = flush_write_bio(epd);
+			if (!ret)
+				goto retry;
+		}
 	}
 
 	if (wbc->range_cyclic || (wbc->nr_to_write > 0 && range_whole))
@@ -5095,9 +5099,11 @@ int extent_write_locked_range(struct inode *inode, u64 start, u64 end,
 	wbc_attach_fdatawrite_inode(&wbc_writepages, inode);
 	while (start <= end) {
 		page = find_get_page(mapping, start >> PAGE_SHIFT);
-		if (clear_page_dirty_for_io(page))
+		if (clear_page_dirty_for_io(page)) {
 			ret = __extent_writepage(page, &wbc_writepages, &epd);
-		else {
+			if (ret < 0)
+				goto out;
+		} else {
 			btrfs_writepage_endio_finish_ordered(BTRFS_I(inode),
 					page, start, start + PAGE_SIZE - 1, true);
 			unlock_page(page);
@@ -5106,6 +5112,7 @@ int extent_write_locked_range(struct inode *inode, u64 start, u64 end,
 		start += PAGE_SIZE;
 	}
 
+out:
 	ASSERT(ret <= 0);
 	if (ret == 0)
 		ret = flush_write_bio(&epd);
-- 
2.32.0

