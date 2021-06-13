Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CAD63A58D3
	for <lists+linux-btrfs@lfdr.de>; Sun, 13 Jun 2021 15:41:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231890AbhFMNnI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 13 Jun 2021 09:43:08 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:55458 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231888AbhFMNnH (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 13 Jun 2021 09:43:07 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 016641FD2D;
        Sun, 13 Jun 2021 13:41:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1623591666; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=woGRyD6YcRWiTazf5LzYH7OlMQ3bppkqFLYFo8OVpZY=;
        b=gKp+qI7Cnzc6dEH/NsQdawjtKbl6yeFo0gKA1pkwhdIq0245twIg5/CzuMn/5tnsYGrEZA
        ogwr7ALii/vEHCtgfsLLnRHG4aVXqmtNMonX7cJbJZoNv5KGoidK9tfRqbpigQoug5JCBM
        iBSnoxXdpiOv7ft2SvtzTOcxVRmTyWY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1623591666;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=woGRyD6YcRWiTazf5LzYH7OlMQ3bppkqFLYFo8OVpZY=;
        b=dJ3+2Y/08JboD825YQns5ClcTKwF0Bvkrm1ihL4p6kuB2x0RvvfFFNk+6pHnSqF74LUeWy
        CJsaEXKcvBchLmDg==
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by imap.suse.de (Postfix) with ESMTP id 50319118DD;
        Sun, 13 Jun 2021 13:41:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1623591665; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=woGRyD6YcRWiTazf5LzYH7OlMQ3bppkqFLYFo8OVpZY=;
        b=KhFOPUfPmFagBzCPtA1pemsyqM4AgvXdyZH87tqcP9yNxOxkL1akFc0NUZvG39W1x8pcN0
        8DSZHt8oGPUqH31MzarkpDXKJ/8VCdY+gKBIkeRsUKggrbiP1Ydth6yz1rb9sjFVqU4ZiG
        YrkgpSS9SbbPInTnQhx9BIeQmPvnMDM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1623591665;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=woGRyD6YcRWiTazf5LzYH7OlMQ3bppkqFLYFo8OVpZY=;
        b=NCGAhcgDBlI6c15cyFuofpJ1Cn1wnY3ltJ5FkYW2kABShpTiGbeHPB8XFgCD4MfKQdmdz1
        1NNKzRPg0k1hUnBA==
Received: from director2.suse.de ([192.168.254.72])
        by imap3-int with ESMTPSA
        id wjFAB/EKxmCWJAAALh3uQQ
        (envelope-from <rgoldwyn@suse.de>); Sun, 13 Jun 2021 13:41:05 +0000
From:   Goldwyn Rodrigues <rgoldwyn@suse.de>
To:     linux-btrfs@vger.kernel.org
Cc:     Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: [RFC PATCH 24/31] btrfs: Switch to iomap_file_buffered_write()
Date:   Sun, 13 Jun 2021 08:39:52 -0500
Message-Id: <5f7bdc2dd24fd6a2e5b3b73b43c867463a5277a7.1623567940.git.rgoldwyn@suse.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1623567940.git.rgoldwyn@suse.com>
References: <cover.1623567940.git.rgoldwyn@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Goldwyn Rodrigues <rgoldwyn@suse.com>

Move allocation of btrfs_iomap into iomap_begin().
Change begin()/end() functions to fill iomap data structure.

Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
---
 fs/btrfs/file.c | 157 +++++++++---------------------------------------
 1 file changed, 27 insertions(+), 130 deletions(-)

diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index fe6d24c6f7bf..6c6e3343bf37 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -1639,12 +1639,18 @@ static void btrfs_iomap_release(struct inode *inode,
 }
 
 static int btrfs_buffered_iomap_begin(struct inode *inode, loff_t pos,
-		size_t length, struct btrfs_iomap *bi)
+		loff_t length, unsigned int flags, struct iomap *iomap,
+		struct iomap *srcmap)
 {
 	int ret;
 	size_t write_bytes = length;
 	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
 	size_t sector_offset = pos & (fs_info->sectorsize - 1);
+	struct btrfs_iomap *bi;
+
+	bi = kzalloc(sizeof(struct btrfs_iomap), GFP_NOFS);
+	if (!bi)
+		return -ENOMEM;
 
 	ret = btrfs_check_data_free_space(BTRFS_I(inode),
 			&bi->data_reserved, pos, write_bytes);
@@ -1685,14 +1691,25 @@ static int btrfs_buffered_iomap_begin(struct inode *inode, loff_t pos,
 		bi->extents_locked = true;
 	}
 
+	iomap->private = bi;
+	iomap->length = round_up(write_bytes + sector_offset,
+				 fs_info->sectorsize);
+	iomap->offset = round_down(pos, fs_info->sectorsize);
+	iomap->addr = IOMAP_NULL_ADDR;
+	iomap->type = IOMAP_DELALLOC;
+	iomap->bdev = fs_info->fs_devices->latest_bdev;
+	iomap->page_ops = &btrfs_iomap_page_ops;
+
 	return 0;
 
 }
 
 static int btrfs_buffered_iomap_end(struct inode *inode, loff_t pos,
-		loff_t length, ssize_t written, struct btrfs_iomap *bi)
+		loff_t length, ssize_t written, unsigned flags,
+		struct iomap *iomap)
 {
 	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
+	struct btrfs_iomap *bi = iomap->private;
 	int ret = 0;
 	size_t release_bytes = 0;
 	u64 start = round_down(pos, fs_info->sectorsize);
@@ -1742,21 +1759,19 @@ static int btrfs_buffered_iomap_end(struct inode *inode, loff_t pos,
 	return 0;
 }
 
+const struct iomap_ops btrfs_buffered_iomap_ops = {
+	.iomap_begin = btrfs_buffered_iomap_begin,
+	.iomap_end = btrfs_buffered_iomap_end,
+};
+
 static noinline ssize_t btrfs_buffered_write(struct kiocb *iocb,
 					       struct iov_iter *i)
 {
 	struct file *file = iocb->ki_filp;
-	loff_t pos;
 	struct inode *inode = file_inode(file);
-	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
-	struct page **pages = NULL;
-	u64 release_bytes = 0;
 	size_t num_written = 0;
-	int nrptrs;
 	int ret;
-	loff_t old_isize = i_size_read(inode);
 	unsigned int ilock_flags = 0;
-	struct btrfs_iomap *bi = NULL;
 
 	if (iocb->ki_flags & IOCB_NOWAIT)
 		ilock_flags |= BTRFS_ILOCK_TRY;
@@ -1773,130 +1788,12 @@ static noinline ssize_t btrfs_buffered_write(struct kiocb *iocb,
 	if (ret < 0)
 		goto out;
 
-	pos = iocb->ki_pos;
-	nrptrs = min(DIV_ROUND_UP(iov_iter_count(i), PAGE_SIZE),
-			PAGE_SIZE / (sizeof(struct page *)));
-	nrptrs = min(nrptrs, current->nr_dirtied_pause - current->nr_dirtied);
-	nrptrs = max(nrptrs, 8);
-	pages = kmalloc_array(nrptrs, sizeof(struct page *), GFP_KERNEL);
-	if (!pages) {
-		ret = -ENOMEM;
-		goto out;
-	}
+	num_written = iomap_file_buffered_write(iocb, i,
+						&btrfs_buffered_iomap_ops);
 
-	bi = kzalloc(sizeof(struct btrfs_iomap), GFP_NOFS);
-	if (!bi) {
-		ret = -ENOMEM;
-		goto out;
-	}
-
-	while (iov_iter_count(i) > 0) {
-		size_t offset = offset_in_page(pos);
-		size_t sector_offset;
-		size_t write_bytes = min(iov_iter_count(i),
-					 nrptrs * (size_t)PAGE_SIZE -
-					 offset);
-		size_t num_pages;
-		size_t dirty_pages;
-		size_t copied;
-		size_t dirty_sectors;
-
-		/*
-		 * Fault pages before locking them in prepare_pages
-		 * to avoid recursive lock
-		 */
-		if (unlikely(iov_iter_fault_in_readable(i, write_bytes))) {
-			ret = -EFAULT;
-			break;
-		}
-
-		bi->extents_locked = false;
-		bi->metadata_only = false;
-		sector_offset = pos & (fs_info->sectorsize - 1);
-
-		extent_changeset_release(bi->data_reserved);
-
-		ret = btrfs_buffered_iomap_begin(inode, pos, write_bytes,
-				bi);
-
-		if (ret < 0)
-			goto out;
-
-		num_pages = DIV_ROUND_UP(write_bytes + offset, PAGE_SIZE);
-		WARN_ON(num_pages > nrptrs);
-		/*
-		 * This is going to setup the pages array with the number of
-		 * pages we want, so we don't really need to worry about the
-		 * contents of pages from loop to loop
-		 */
-		ret = prepare_pages(inode, pages, num_pages,
-				    pos, write_bytes);
-		if (ret) {
-			btrfs_delalloc_release_extents(BTRFS_I(inode),
-						       bi->reserved_bytes);
-			break;
-		}
-
-		copied = btrfs_copy_from_user(pos, write_bytes, pages, i);
-
-		dirty_sectors = round_up(copied + sector_offset,
-					fs_info->sectorsize);
-		dirty_sectors = BTRFS_BYTES_TO_BLKS(fs_info, dirty_sectors);
-
-		/*
-		 * if we have trouble faulting in the pages, fall
-		 * back to one page at a time
-		 */
-		if (copied < write_bytes)
-			nrptrs = 1;
-
-		if (copied == 0) {
-			dirty_sectors = 0;
-			dirty_pages = 0;
-		} else {
-			dirty_pages = DIV_ROUND_UP(copied + offset,
-						   PAGE_SIZE);
-		}
-
-		release_bytes = round_up(copied + sector_offset,
-					fs_info->sectorsize);
-
-		ret = btrfs_dirty_pages(BTRFS_I(inode), pages,
-					dirty_pages, pos, copied,
-					&bi->cached_state,
-					bi->metadata_only);
-
-		if (ret) {
-			btrfs_drop_pages(pages, num_pages);
-			break;
-		}
-
-		btrfs_buffered_iomap_end(inode, pos, write_bytes, copied, bi);
-
-		release_bytes = 0;
-		if (bi->metadata_only)
-			btrfs_check_nocow_unlock(BTRFS_I(inode));
-
-		btrfs_drop_pages(pages, num_pages);
-
-		cond_resched();
-
-		balance_dirty_pages_ratelimited(inode->i_mapping);
-
-		pos += copied;
-		num_written += copied;
-	}
-
-	kfree(pages);
-
-	if (num_written > 0) {
-		pagecache_isize_extended(inode, old_isize, iocb->ki_pos);
+	if (num_written > 0)
 		iocb->ki_pos += num_written;
-	}
 
-	if (release_bytes && bi->metadata_only)
-		btrfs_check_nocow_unlock(BTRFS_I(inode));
-	btrfs_iomap_release(inode, pos, release_bytes, bi);
 out:
 	btrfs_inode_unlock(inode, ilock_flags);
 	return num_written ? num_written : ret;
-- 
2.31.1

