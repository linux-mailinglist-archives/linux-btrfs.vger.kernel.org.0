Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCB083A58D4
	for <lists+linux-btrfs@lfdr.de>; Sun, 13 Jun 2021 15:41:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231893AbhFMNnK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 13 Jun 2021 09:43:10 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:55466 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231888AbhFMNnK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 13 Jun 2021 09:43:10 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 8D2601FD2D;
        Sun, 13 Jun 2021 13:41:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1623591668; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9sHt7LK1ESoWdj42G+riEG2/YtmTweWopKxvGb9XqrI=;
        b=vNELV5+Hv6izPSdEcN9JIw3NDMXWsivXHroMabIzeXp9bHLZ1mXEDGMv7iVtqurtsCzznn
        QAdo5uF/t7MsMyLBNPpamXBqBHhl1+hxWDn3E8aPbeIO6qMD/HZYLZm4/32xECr0ON6c5+
        0kJaJMyX9Ty/8mXauiyZPThkyRxJ/y8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1623591668;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9sHt7LK1ESoWdj42G+riEG2/YtmTweWopKxvGb9XqrI=;
        b=ONluyri5V2+0iExL4uvrjsYBVJwlg7NplEM9eQBbIZQ2oSB9bbd6xHMsJgpUUaEc4b1drA
        mV4NXuMEMtsC/BAw==
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by imap.suse.de (Postfix) with ESMTP id 3083A118DD;
        Sun, 13 Jun 2021 13:41:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1623591668; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9sHt7LK1ESoWdj42G+riEG2/YtmTweWopKxvGb9XqrI=;
        b=vNELV5+Hv6izPSdEcN9JIw3NDMXWsivXHroMabIzeXp9bHLZ1mXEDGMv7iVtqurtsCzznn
        QAdo5uF/t7MsMyLBNPpamXBqBHhl1+hxWDn3E8aPbeIO6qMD/HZYLZm4/32xECr0ON6c5+
        0kJaJMyX9Ty/8mXauiyZPThkyRxJ/y8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1623591668;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9sHt7LK1ESoWdj42G+riEG2/YtmTweWopKxvGb9XqrI=;
        b=ONluyri5V2+0iExL4uvrjsYBVJwlg7NplEM9eQBbIZQ2oSB9bbd6xHMsJgpUUaEc4b1drA
        mV4NXuMEMtsC/BAw==
Received: from director2.suse.de ([192.168.254.72])
        by imap3-int with ESMTPSA
        id 2C86APQKxmCcJAAALh3uQQ
        (envelope-from <rgoldwyn@suse.de>); Sun, 13 Jun 2021 13:41:08 +0000
From:   Goldwyn Rodrigues <rgoldwyn@suse.de>
To:     linux-btrfs@vger.kernel.org
Cc:     Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: [RFC PATCH 25/31] btrfs: remove all page related functions
Date:   Sun, 13 Jun 2021 08:39:53 -0500
Message-Id: <adc05e1b047f3adcd83cb0b8defec4aabc55ae49.1623567940.git.rgoldwyn@suse.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1623567940.git.rgoldwyn@suse.com>
References: <cover.1623567940.git.rgoldwyn@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Goldwyn Rodrigues <rgoldwyn@suse.com>

Cleanup after switching to iomap writes. Remove all page handling
functions.

Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
---
 fs/btrfs/file.c | 156 ------------------------------------------------
 1 file changed, 156 deletions(-)

diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 6c6e3343bf37..b3e48bfd75df 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -394,79 +394,6 @@ int btrfs_run_defrag_inodes(struct btrfs_fs_info *fs_info)
 	return 0;
 }
 
-/* simple helper to fault in pages and copy.  This should go away
- * and be replaced with calls into generic code.
- */
-static noinline int btrfs_copy_from_user(loff_t pos, size_t write_bytes,
-					 struct page **prepared_pages,
-					 struct iov_iter *i)
-{
-	size_t copied = 0;
-	size_t total_copied = 0;
-	int pg = 0;
-	int offset = offset_in_page(pos);
-
-	while (write_bytes > 0) {
-		size_t count = min_t(size_t,
-				     PAGE_SIZE - offset, write_bytes);
-		struct page *page = prepared_pages[pg];
-		/*
-		 * Copy data from userspace to the current page
-		 */
-		copied = iov_iter_copy_from_user_atomic(page, i, offset, count);
-
-		/* Flush processor's dcache for this page */
-		flush_dcache_page(page);
-
-		/*
-		 * if we get a partial write, we can end up with
-		 * partially up to date pages.  These add
-		 * a lot of complexity, so make sure they don't
-		 * happen by forcing this copy to be retried.
-		 *
-		 * The rest of the btrfs_file_write code will fall
-		 * back to page at a time copies after we return 0.
-		 */
-		if (!PageUptodate(page) && copied < count)
-			copied = 0;
-
-		iov_iter_advance(i, copied);
-		write_bytes -= copied;
-		total_copied += copied;
-
-		/* Return to btrfs_file_write_iter to fault page */
-		if (unlikely(copied == 0))
-			break;
-
-		if (copied < PAGE_SIZE - offset) {
-			offset += copied;
-		} else {
-			pg++;
-			offset = 0;
-		}
-	}
-	return total_copied;
-}
-
-/*
- * unlocks pages after btrfs_file_write is done with them
- */
-static void btrfs_drop_pages(struct page **pages, size_t num_pages)
-{
-	size_t i;
-	for (i = 0; i < num_pages; i++) {
-		/* page checked is some magic around finding pages that
-		 * have been modified without going through btrfs_set_page_dirty
-		 * clear it here. There should be no need to mark the pages
-		 * accessed as prepare_pages should have marked them accessed
-		 * in prepare_pages via find_or_create_page()
-		 */
-		ClearPageChecked(pages[i]);
-		unlock_page(pages[i]);
-		put_page(pages[i]);
-	}
-}
-
 static void btrfs_page_done(struct inode *inode, loff_t pos,
 		unsigned int copied, struct page *page,
 		struct iomap *iomap)
@@ -1346,89 +1273,6 @@ int btrfs_mark_extent_written(struct btrfs_trans_handle *trans,
 	return ret;
 }
 
-/*
- * on error we return an unlocked page and the error value
- * on success we return a locked page and 0
- */
-static int prepare_uptodate_page(struct inode *inode,
-				 struct page *page, u64 pos)
-{
-	int ret = 0;
-
-	if ((pos & (PAGE_SIZE - 1)) && !PageUptodate(page)) {
-		ret = btrfs_readpage(NULL, page);
-		if (ret)
-			return ret;
-		lock_page(page);
-		if (!PageUptodate(page)) {
-			unlock_page(page);
-			return -EIO;
-		}
-		if (page->mapping != inode->i_mapping) {
-			unlock_page(page);
-			return -EAGAIN;
-		}
-	}
-	return 0;
-}
-
-/*
- * this just gets pages into the page cache and locks them down.
- */
-static noinline int prepare_pages(struct inode *inode, struct page **pages,
-				  size_t num_pages, loff_t pos,
-				  size_t write_bytes)
-{
-	int i;
-	unsigned long index = pos >> PAGE_SHIFT;
-	gfp_t mask = btrfs_alloc_write_mask(inode->i_mapping);
-	int err = 0;
-	int faili;
-
-	for (i = 0; i < num_pages; i++) {
-again:
-		pages[i] = find_or_create_page(inode->i_mapping, index + i,
-					       mask | __GFP_WRITE);
-		if (!pages[i]) {
-			faili = i - 1;
-			err = -ENOMEM;
-			goto fail;
-		}
-
-		err = set_page_extent_mapped(pages[i]);
-		if (err < 0) {
-			faili = i;
-			goto fail;
-		}
-
-		if (i == 0)
-			err = prepare_uptodate_page(inode, pages[i], pos);
-		if (!err && i == num_pages - 1)
-			err = prepare_uptodate_page(inode, pages[i],
-						    pos + write_bytes);
-		if (err) {
-			put_page(pages[i]);
-			if (err == -EAGAIN) {
-				err = 0;
-				goto again;
-			}
-			faili = i - 1;
-			goto fail;
-		}
-		wait_on_page_writeback(pages[i]);
-	}
-
-	return 0;
-fail:
-	while (faili >= 0) {
-		unlock_page(pages[faili]);
-		put_page(pages[faili]);
-		faili--;
-	}
-	return err;
-
-}
-
 static int check_can_nocow(struct btrfs_inode *inode, loff_t pos,
 			   size_t *write_bytes, bool nowait)
 {
-- 
2.31.1

