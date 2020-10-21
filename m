Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 928C5294852
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Oct 2020 08:28:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440848AbgJUG2F (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 21 Oct 2020 02:28:05 -0400
Received: from mx2.suse.de ([195.135.220.15]:44634 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2408802AbgJUG2E (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 21 Oct 2020 02:28:04 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1603261683;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jVZud4cj5zrtV0B8485SsIbYPaDs9+bZZ+IwDCUFdMY=;
        b=GfzUBEAV948niymGwjycOkLqayShf/FCI1DzIA0bJBZ4K6/qsumwu++IWsxfZSj/59/BRu
        6hXqUlvxeQ5jVxOAYbe4O/hCSyjihGWsZgkieZKO3XkKk1grjuB7ohU+J5/ZfS8kegN8Sx
        T+3Dby7NYzFHrtUbq6Fnw4oQvEQEO2Q=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 319B7AC12
        for <linux-btrfs@vger.kernel.org>; Wed, 21 Oct 2020 06:28:03 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v4 54/68] btrfs: file: calculate reserve space based on PAGE_SIZE for buffered write
Date:   Wed, 21 Oct 2020 14:25:40 +0800
Message-Id: <20201021062554.68132-55-wqu@suse.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201021062554.68132-1-wqu@suse.com>
References: <20201021062554.68132-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

In theory btrfs_buffered_write() should reserve space using sector size.
But for now let's base all reserve on PAGE_SIZE, this would make later
subpage support to always submit full page write.

This would cause more data space usage, but greatly simplify the subpage
data write support.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/file.c | 38 +++++++++++---------------------------
 1 file changed, 11 insertions(+), 27 deletions(-)

diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index a2009127ef96..564784a5c0c0 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -1650,7 +1650,6 @@ static noinline ssize_t btrfs_buffered_write(struct kiocb *iocb,
 	while (iov_iter_count(i) > 0) {
 		struct extent_state *cached_state = NULL;
 		size_t offset = offset_in_page(pos);
-		size_t sector_offset;
 		size_t write_bytes = min(iov_iter_count(i),
 					 nrptrs * (size_t)PAGE_SIZE -
 					 offset);
@@ -1659,7 +1658,6 @@ static noinline ssize_t btrfs_buffered_write(struct kiocb *iocb,
 		size_t reserve_bytes;
 		size_t dirty_pages;
 		size_t copied;
-		size_t dirty_sectors;
 		size_t num_sectors;
 		int extents_locked;
 
@@ -1675,9 +1673,7 @@ static noinline ssize_t btrfs_buffered_write(struct kiocb *iocb,
 		}
 
 		only_release_metadata = false;
-		sector_offset = pos & (fs_info->sectorsize - 1);
-		reserve_bytes = round_up(write_bytes + sector_offset,
-				fs_info->sectorsize);
+		reserve_bytes = round_up(write_bytes + offset, PAGE_SIZE);
 
 		extent_changeset_release(data_reserved);
 		ret = btrfs_check_data_free_space(BTRFS_I(inode),
@@ -1697,9 +1693,8 @@ static noinline ssize_t btrfs_buffered_write(struct kiocb *iocb,
 				 */
 				num_pages = DIV_ROUND_UP(write_bytes + offset,
 							 PAGE_SIZE);
-				reserve_bytes = round_up(write_bytes +
-							 sector_offset,
-							 fs_info->sectorsize);
+				reserve_bytes = round_up(write_bytes + offset,
+							 PAGE_SIZE);
 			} else {
 				break;
 			}
@@ -1750,9 +1745,6 @@ static noinline ssize_t btrfs_buffered_write(struct kiocb *iocb,
 		copied = btrfs_copy_from_user(pos, write_bytes, pages, i);
 
 		num_sectors = BTRFS_BYTES_TO_BLKS(fs_info, reserve_bytes);
-		dirty_sectors = round_up(copied + sector_offset,
-					fs_info->sectorsize);
-		dirty_sectors = BTRFS_BYTES_TO_BLKS(fs_info, dirty_sectors);
 
 		/*
 		 * if we have trouble faulting in the pages, fall
@@ -1763,35 +1755,29 @@ static noinline ssize_t btrfs_buffered_write(struct kiocb *iocb,
 
 		if (copied == 0) {
 			force_page_uptodate = true;
-			dirty_sectors = 0;
 			dirty_pages = 0;
 		} else {
 			force_page_uptodate = false;
-			dirty_pages = DIV_ROUND_UP(copied + offset,
-						   PAGE_SIZE);
+			dirty_pages = DIV_ROUND_UP(copied + offset, PAGE_SIZE);
 		}
 
-		if (num_sectors > dirty_sectors) {
+		if (num_pages > dirty_pages) {
 			/* release everything except the sectors we dirtied */
-			release_bytes -= dirty_sectors <<
-						fs_info->sb->s_blocksize_bits;
+			release_bytes -= dirty_pages << PAGE_SHIFT;
 			if (only_release_metadata) {
 				btrfs_delalloc_release_metadata(BTRFS_I(inode),
 							release_bytes, true);
 			} else {
 				u64 __pos;
 
-				__pos = round_down(pos,
-						   fs_info->sectorsize) +
+				__pos = round_down(pos, PAGE_SIZE) +
 					(dirty_pages << PAGE_SHIFT);
 				btrfs_delalloc_release_space(BTRFS_I(inode),
 						data_reserved, __pos,
 						release_bytes, true);
 			}
 		}
-
-		release_bytes = round_up(copied + sector_offset,
-					fs_info->sectorsize);
+		release_bytes = round_up(copied + offset, PAGE_SIZE);
 
 		if (copied > 0)
 			ret = btrfs_dirty_pages(BTRFS_I(inode), pages,
@@ -1822,10 +1808,8 @@ static noinline ssize_t btrfs_buffered_write(struct kiocb *iocb,
 			btrfs_check_nocow_unlock(BTRFS_I(inode));
 
 		if (only_release_metadata && copied > 0) {
-			lockstart = round_down(pos,
-					       fs_info->sectorsize);
-			lockend = round_up(pos + copied,
-					   fs_info->sectorsize) - 1;
+			lockstart = round_down(pos, PAGE_SIZE);
+			lockend = round_up(pos + copied, PAGE_SIZE) - 1;
 
 			set_extent_bit(&BTRFS_I(inode)->io_tree, lockstart,
 				       lockend, EXTENT_NORESERVE, NULL,
@@ -1852,7 +1836,7 @@ static noinline ssize_t btrfs_buffered_write(struct kiocb *iocb,
 		} else {
 			btrfs_delalloc_release_space(BTRFS_I(inode),
 					data_reserved,
-					round_down(pos, fs_info->sectorsize),
+					round_down(pos, PAGE_SIZE),
 					release_bytes, true);
 		}
 	}
-- 
2.28.0

