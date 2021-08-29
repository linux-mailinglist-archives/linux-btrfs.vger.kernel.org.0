Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 848AA3FA957
	for <lists+linux-btrfs@lfdr.de>; Sun, 29 Aug 2021 07:25:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234551AbhH2F01 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 29 Aug 2021 01:26:27 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:59424 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234789AbhH2F0Z (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 29 Aug 2021 01:26:25 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 75AE021D6A
        for <linux-btrfs@vger.kernel.org>; Sun, 29 Aug 2021 05:25:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1630214733; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FF/VedHCH9UHqBHtPk+5tw1ePogOIgLOfLJFcDgaZu4=;
        b=XdI3uQx6YcOUSsu1YHQuwM9bS7Rjd8R5xfZuQTJ4QBRCUtfb+XrfbJhNqm4/TcSDyHfY2o
        x0/NRqEfchD392zlUv8vTNz1hUzr2q4DlzJyfAlwMjvZY3raoSdYJHJqQQRyrnAF9HWFZo
        aeemnj3ndrqSGvjRQG2WbvBvRExuhoI=
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id B20D613964
        for <linux-btrfs@vger.kernel.org>; Sun, 29 Aug 2021 05:25:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id II0DHUwaK2HnPAAAGKfGzw
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Sun, 29 Aug 2021 05:25:32 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 26/26] btrfs: only allow subpage compression if the range is fully page aligned
Date:   Sun, 29 Aug 2021 13:24:58 +0800
Message-Id: <20210829052458.15454-27-wqu@suse.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210829052458.15454-1-wqu@suse.com>
References: <20210829052458.15454-1-wqu@suse.com>
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
 fs/btrfs/inode.c | 44 +++++++++++++++++++++++++++++++++++++-------
 1 file changed, 37 insertions(+), 7 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 241081e2cd5a..64e35224175d 100644
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
@@ -614,11 +643,12 @@ static noinline int compress_file_range(struct async_chunk *async_chunk)
 	total_compressed = actual_end - start;
 
 	/*
-	 * skip compression for a small file range(<=blocksize) that
-	 * isn't an inline extent, since it doesn't save disk space at all.
+	 * For subpage case, we require full page alignment for the sector
+	 * aligned range.
+	 * Thus we must also check against @actual_end, not just @end.
 	 */
-	if (total_compressed <= blocksize &&
-	   (start > 0 || end + 1 < BTRFS_I(inode)->disk_i_size))
+	if (blocksize < PAGE_SIZE &&
+	    !IS_ALIGNED(round_up(actual_end, blocksize), PAGE_SIZE))
 		goto cleanup_and_bail_uncompressed;
 
 	total_compressed = min_t(unsigned long, total_compressed,
-- 
2.32.0

