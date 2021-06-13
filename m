Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F4F93A58CB
	for <lists+linux-btrfs@lfdr.de>; Sun, 13 Jun 2021 15:40:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231862AbhFMNmu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 13 Jun 2021 09:42:50 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:34564 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231846AbhFMNmt (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 13 Jun 2021 09:42:49 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 9165221972;
        Sun, 13 Jun 2021 13:40:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1623591647; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WpiHcbL4IqLdQsBTQDMj/YwHVGU/FHsxPaSfLi/SADY=;
        b=Jph8tp4nHPG/7cVDr+Zo6F0aHHNAJpJUkH3gyZF070+Y6RXg4pbArfa1mWnXCo9FEamuya
        IME7YAuqe5oXiB1/bNq2+NZeKKVRHq3Q8GhM8hvfthi2DZu78aZ4I9AnlsX/djV+v8msQc
        oee8MQYmbRfeaGv47S8DGuv5WtjCQzM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1623591647;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WpiHcbL4IqLdQsBTQDMj/YwHVGU/FHsxPaSfLi/SADY=;
        b=BmqCH3/eMLrMpRN2zvKByUoHDo6ypfduT6slJ/43HexVZCVDBAaLWFrzHt5bKKvpZYrfZR
        Ia4/0nIHpb9JVQCQ==
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by imap.suse.de (Postfix) with ESMTP id 3A733118DD;
        Sun, 13 Jun 2021 13:40:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1623591647; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WpiHcbL4IqLdQsBTQDMj/YwHVGU/FHsxPaSfLi/SADY=;
        b=Jph8tp4nHPG/7cVDr+Zo6F0aHHNAJpJUkH3gyZF070+Y6RXg4pbArfa1mWnXCo9FEamuya
        IME7YAuqe5oXiB1/bNq2+NZeKKVRHq3Q8GhM8hvfthi2DZu78aZ4I9AnlsX/djV+v8msQc
        oee8MQYmbRfeaGv47S8DGuv5WtjCQzM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1623591647;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WpiHcbL4IqLdQsBTQDMj/YwHVGU/FHsxPaSfLi/SADY=;
        b=BmqCH3/eMLrMpRN2zvKByUoHDo6ypfduT6slJ/43HexVZCVDBAaLWFrzHt5bKKvpZYrfZR
        Ia4/0nIHpb9JVQCQ==
Received: from director2.suse.de ([192.168.254.72])
        by imap3-int with ESMTPSA
        id 2jkOBt8KxmB6JAAALh3uQQ
        (envelope-from <rgoldwyn@suse.de>); Sun, 13 Jun 2021 13:40:47 +0000
From:   Goldwyn Rodrigues <rgoldwyn@suse.de>
To:     linux-btrfs@vger.kernel.org
Cc:     Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: [RFC PATCH 16/31] btrfs: remove force_page_uptodate
Date:   Sun, 13 Jun 2021 08:39:44 -0500
Message-Id: <20379b412dcebaf588f73fd5ac7411ff9781238c.1623567940.git.rgoldwyn@suse.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1623567940.git.rgoldwyn@suse.com>
References: <cover.1623567940.git.rgoldwyn@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Goldwyn Rodrigues <rgoldwyn@suse.com>

iomap handles short writes well. Removing force_page_uptodate eases out
porting.

Note, this change is not that important because these functions are
deleted down the line. This is performed to make the switch easier.

Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
---
 fs/btrfs/file.c | 19 ++++++-------------
 1 file changed, 6 insertions(+), 13 deletions(-)

diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index cb9471e7224a..a94ab3c8da1d 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -1326,13 +1326,11 @@ int btrfs_mark_extent_written(struct btrfs_trans_handle *trans,
  * on success we return a locked page and 0
  */
 static int prepare_uptodate_page(struct inode *inode,
-				 struct page *page, u64 pos,
-				 bool force_uptodate)
+				 struct page *page, u64 pos)
 {
 	int ret = 0;
 
-	if (((pos & (PAGE_SIZE - 1)) || force_uptodate) &&
-	    !PageUptodate(page)) {
+	if ((pos & (PAGE_SIZE - 1)) && !PageUptodate(page)) {
 		ret = btrfs_readpage(NULL, page);
 		if (ret)
 			return ret;
@@ -1354,7 +1352,7 @@ static int prepare_uptodate_page(struct inode *inode,
  */
 static noinline int prepare_pages(struct inode *inode, struct page **pages,
 				  size_t num_pages, loff_t pos,
-				  size_t write_bytes, bool force_uptodate)
+				  size_t write_bytes)
 {
 	int i;
 	unsigned long index = pos >> PAGE_SHIFT;
@@ -1379,11 +1377,10 @@ static noinline int prepare_pages(struct inode *inode, struct page **pages,
 		}
 
 		if (i == 0)
-			err = prepare_uptodate_page(inode, pages[i], pos,
-						    force_uptodate);
+			err = prepare_uptodate_page(inode, pages[i], pos);
 		if (!err && i == num_pages - 1)
 			err = prepare_uptodate_page(inode, pages[i],
-						    pos + write_bytes, false);
+						    pos + write_bytes);
 		if (err) {
 			put_page(pages[i]);
 			if (err == -EAGAIN) {
@@ -1608,7 +1605,6 @@ static noinline ssize_t btrfs_buffered_write(struct kiocb *iocb,
 	int nrptrs;
 	ssize_t ret;
 	bool only_release_metadata = false;
-	bool force_page_uptodate = false;
 	loff_t old_isize = i_size_read(inode);
 	unsigned int ilock_flags = 0;
 
@@ -1715,8 +1711,7 @@ static noinline ssize_t btrfs_buffered_write(struct kiocb *iocb,
 		 * contents of pages from loop to loop
 		 */
 		ret = prepare_pages(inode, pages, num_pages,
-				    pos, write_bytes,
-				    force_page_uptodate);
+				    pos, write_bytes);
 		if (ret) {
 			btrfs_delalloc_release_extents(BTRFS_I(inode),
 						       reserve_bytes);
@@ -1743,11 +1738,9 @@ static noinline ssize_t btrfs_buffered_write(struct kiocb *iocb,
 			nrptrs = 1;
 
 		if (copied == 0) {
-			force_page_uptodate = true;
 			dirty_sectors = 0;
 			dirty_pages = 0;
 		} else {
-			force_page_uptodate = false;
 			dirty_pages = DIV_ROUND_UP(copied + offset,
 						   PAGE_SIZE);
 		}
-- 
2.31.1

