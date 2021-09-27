Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD0B8418FE8
	for <lists+linux-btrfs@lfdr.de>; Mon, 27 Sep 2021 09:23:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233314AbhI0HYf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 27 Sep 2021 03:24:35 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:45014 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233215AbhI0HYb (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 27 Sep 2021 03:24:31 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id B001B220C2
        for <linux-btrfs@vger.kernel.org>; Mon, 27 Sep 2021 07:22:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1632727373; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wk63rqwdWST42zg7mLWkzpDgTrJd8+bFd/qXqp+qPZo=;
        b=i7Q6yHwS6ejlUHfCoKHoOv/2mSiMr4jyaJHB9fT1wdjJWPTZJ435XYUgp6bP7NFE3IBNwn
        90JwJfXXbvR8iItpFYCZIJEB/iUt/Mf/7LmWWh7RIAcFEchgGA1ioxmslYOyTUB6/OxP7e
        y6bViJP3rR6BSeYdF0ebMVuK8WjXYxo=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 06F2C13A1E
        for <linux-btrfs@vger.kernel.org>; Mon, 27 Sep 2021 07:22:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id AJIPMUxxUWEVLAAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Mon, 27 Sep 2021 07:22:52 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v3 26/26] btrfs: only allow subpage compression if the range is fully page aligned
Date:   Mon, 27 Sep 2021 15:22:08 +0800
Message-Id: <20210927072208.21634-27-wqu@suse.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210927072208.21634-1-wqu@suse.com>
References: <20210927072208.21634-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

For btrfs compressed write, we use a mechanism called async cow, which
unlike regular run_delalloc_cow() or cow_file_range(), it will also
unlock the first page.

This mechanism allows btrfs to continue handling next ranges, without
waiting for the time consuming compression.

But this has a problem for subpage case, as we could have the following
delalloc range for a page:

0		32K		64K
|	|///////|	|///////|
		\- A		\- B

In above case, if we pass both range to cow_file_range_async(), both
range A and range B will try to unlock the full page [0, 64K).

And which finishes later than the other range will try to do other page
operations like end_page_writeback() on a unlocked page, triggering VM
layer BUG_ON().

To make subpage compression work at least partially, here we add another
restriction for it, only allow compression if the delalloc range is
fully page aligned.

By that, async extent is always ensured to unlock the first page
exclusively, just like it used to be for regular sectorsize.

In theory, we only need to make sure the delalloc range fully covers its
first page, but the tailing page will be locked anyway, blocking later
writeback until the compression finishes.

Thus here we choose to make sure the range is fully page aligned before
doing the compression.

In the future, we could optimize the situation by properly increase
subpage::writers number for the locked page, but that also means we need
to change how we run delalloc range of page.
(Instead of running each delalloc range we hit, we need to find and lock
all delalloc range covers the page, then run each of them).

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/inode.c | 48 ++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 44 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 088a3a44d273..adfe386ad03e 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -489,9 +489,6 @@ static noinline int add_async_extent(struct async_chunk *cow,
  */
 static inline bool inode_can_compress(struct btrfs_inode *inode)
 {
-	/* Subpage doesn't support compression yet */
-	if (inode->root->fs_info->sectorsize < PAGE_SIZE)
-		return false;
 	if (inode->flags & BTRFS_INODE_NODATACOW ||
 	    inode->flags & BTRFS_INODE_NODATASUM)
 		return false;
@@ -513,6 +510,38 @@ static inline int inode_need_compress(struct btrfs_inode *inode, u64 start,
 			btrfs_ino(inode));
 		return 0;
 	}
+	/*
+	 * Special check for subpage.
+	 *
+	 * We lock the full page then run each delalloc range in the page, thus
+	 * for the following case, we will hit some subpage specific corner case:
+	 *
+	 * 0		32K		64K
+	 * |	|///////|	|///////|
+	 *		\- A		\- B
+	 *
+	 * In above case, both range A and range B will try to unlock the full
+	 * page [0, 64K), causing the one finished later will have page
+	 * unlocked already, triggering various page lock requirement BUG_ON()s.
+	 *
+	 * So here we add an artificial limit that subpage compression can only
+	 * if the range is fully page aligned.
+	 *
+	 * In theory we only need to ensure the first page is fully covered, but
+	 * the tailing partial page will be locked until the full compression
+	 * finishes, delaying the write of other range.
+	 *
+	 * TODO: Make btrfs_run_delalloc_range() to lock all delalloc range
+	 * first to prevent any submitted async extent to unlock the full page.
+	 * By this, we can ensure for subpage case that only the last async_cow
+	 * will unlock the full page.
+	 */
+	if (fs_info->sectorsize < PAGE_SIZE) {
+		if (!IS_ALIGNED(start, PAGE_SIZE) ||
+		    !IS_ALIGNED(end + 1, PAGE_SIZE))
+			return 0;
+	}
+
 	/* force compress */
 	if (btrfs_test_opt(fs_info, FORCE_COMPRESS))
 		return 1;
@@ -614,13 +643,24 @@ static noinline int compress_file_range(struct async_chunk *async_chunk)
 	total_compressed = actual_end - start;
 
 	/*
-	 * skip compression for a small file range(<=blocksize) that
+	 * Skip compression for a small file range(<=blocksize) that
 	 * isn't an inline extent, since it doesn't save disk space at all.
 	 */
 	if (total_compressed <= blocksize &&
 	   (start > 0 || end + 1 < BTRFS_I(inode)->disk_i_size))
 		goto cleanup_and_bail_uncompressed;
 
+	/*
+	 * For subpage case, we require full page alignment for the sector
+	 * aligned range.
+	 * Thus we must also check against @actual_end, not just @end.
+	 */
+	if (blocksize < PAGE_SIZE) {
+		if (!IS_ALIGNED(start, PAGE_SIZE) ||
+		    !IS_ALIGNED(round_up(actual_end, blocksize), PAGE_SIZE))
+			goto cleanup_and_bail_uncompressed;
+	}
+
 	total_compressed = min_t(unsigned long, total_compressed,
 			BTRFS_MAX_UNCOMPRESSED);
 	total_in = 0;
-- 
2.33.0

