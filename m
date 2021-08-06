Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A4F23E24D3
	for <lists+linux-btrfs@lfdr.de>; Fri,  6 Aug 2021 10:13:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243439AbhHFINQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 6 Aug 2021 04:13:16 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:50118 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243442AbhHFINO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 6 Aug 2021 04:13:14 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id E246F22317
        for <linux-btrfs@vger.kernel.org>; Fri,  6 Aug 2021 08:12:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1628237577; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WgLkKMaFVgnOwk/X8T5lcZ63cyXjfIA2bC1YxlCLq5w=;
        b=UT5zPmFdYoos/EQc32psvQ1e+x8IuaUoJBwOkRwrlbxQOX5eo1b6Lng/zZMlsJtmjzr6qo
        tgZ5n5DGQ00A1H9ztDW17hEyw8mgYBUcjS3x8R83M6GuimFdr+JysQEocaBHbA37FqLwvr
        pgKFF0wyMKNjs2OqloOCHta9x+wkldk=
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 250551399D
        for <linux-btrfs@vger.kernel.org>; Fri,  6 Aug 2021 08:12:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id MJQfNQjvDGF6IQAAGKfGzw
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Fri, 06 Aug 2021 08:12:56 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v5 09/11] btrfs: defrag: use defrag_one_cluster() to implement btrfs_defrag_file()
Date:   Fri,  6 Aug 2021 16:12:40 +0800
Message-Id: <20210806081242.257996-10-wqu@suse.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210806081242.257996-1-wqu@suse.com>
References: <20210806081242.257996-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The function defrag_one_cluster() is able to defrag one range well
enough, we only need to do prepration for it, including:

- Clamp and align the defrag range
- Exclude invalid cases
- Proper inode locking

The old infrastructures will not be removed in this patch, as it would
be too noisy to review.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/ioctl.c | 204 +++++++++++++----------------------------------
 1 file changed, 55 insertions(+), 149 deletions(-)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 74346fde06f6..b3ba89d6402e 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -1759,25 +1759,15 @@ int btrfs_defrag_file(struct inode *inode, struct file_ra_state *ra,
 		      u64 newer_than, unsigned long max_to_defrag)
 {
 	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
-	struct btrfs_root *root = BTRFS_I(inode)->root;
-	unsigned long last_index;
+	unsigned long sectors_defragged = 0;
 	u64 isize = i_size_read(inode);
-	u64 last_len = 0;
-	u64 skip = 0;
-	u64 defrag_end = 0;
-	u64 newer_off = range->start;
-	unsigned long i;
-	unsigned long ra_index = 0;
-	int ret;
-	int defrag_count = 0;
-	int compress_type = BTRFS_COMPRESS_ZLIB;
-	u32 extent_thresh = range->extent_thresh;
-	unsigned long max_cluster = SZ_256K >> PAGE_SHIFT;
-	unsigned long cluster = max_cluster;
-	u64 new_align = ~((u64)SZ_128K - 1);
-	struct page **pages = NULL;
+	u64 cur;
+	u64 last_byte;
 	bool do_compress = range->flags & BTRFS_DEFRAG_RANGE_COMPRESS;
 	bool ra_allocated = false;
+	int compress_type = BTRFS_COMPRESS_ZLIB;
+	int ret;
+	u32 extent_thresh = range->extent_thresh;
 
 	if (isize == 0)
 		return 0;
@@ -1795,6 +1785,14 @@ int btrfs_defrag_file(struct inode *inode, struct file_ra_state *ra,
 	if (extent_thresh == 0)
 		extent_thresh = SZ_256K;
 
+	if (range->start + range->len > range->start) {
+		/* Got a specific range */
+		last_byte = min(isize, range->start + range->len) - 1;
+	} else {
+		/* Defrag until file end */
+		last_byte = isize - 1;
+	}
+
 	/*
 	 * If we were not given a ra, allocate a readahead context. As
 	 * readahead is just an optimization, defrag will work without it so
@@ -1807,159 +1805,67 @@ int btrfs_defrag_file(struct inode *inode, struct file_ra_state *ra,
 			file_ra_state_init(ra, inode->i_mapping);
 	}
 
-	pages = kmalloc_array(max_cluster, sizeof(struct page *), GFP_KERNEL);
-	if (!pages) {
-		ret = -ENOMEM;
-		goto out_ra;
-	}
+	/* Align the range */
+	cur = round_down(range->start, fs_info->sectorsize);
+	last_byte = round_up(last_byte, fs_info->sectorsize) - 1;
 
-	/* find the last page to defrag */
-	if (range->start + range->len > range->start) {
-		last_index = min_t(u64, isize - 1,
-			 range->start + range->len - 1) >> PAGE_SHIFT;
-	} else {
-		last_index = (isize - 1) >> PAGE_SHIFT;
-	}
-
-	if (newer_than) {
-		ret = find_new_extents(root, inode, newer_than,
-				       &newer_off, SZ_64K);
-		if (!ret) {
-			range->start = newer_off;
-			/*
-			 * we always align our defrag to help keep
-			 * the extents in the file evenly spaced
-			 */
-			i = (newer_off & new_align) >> PAGE_SHIFT;
-		} else
-			goto out_ra;
-	} else {
-		i = range->start >> PAGE_SHIFT;
-	}
-	if (!max_to_defrag)
-		max_to_defrag = last_index - i + 1;
-
-	/*
-	 * make writeback starts from i, so the defrag range can be
-	 * written sequentially.
-	 */
-	if (i < inode->i_mapping->writeback_index)
-		inode->i_mapping->writeback_index = i;
-
-	while (i <= last_index && defrag_count < max_to_defrag &&
-	       (i < DIV_ROUND_UP(i_size_read(inode), PAGE_SIZE))) {
-		/*
-		 * make sure we stop running if someone unmounts
-		 * the FS
-		 */
-		if (!(inode->i_sb->s_flags & SB_ACTIVE))
-			break;
-
-		if (btrfs_defrag_cancelled(fs_info)) {
-			btrfs_debug(fs_info, "defrag_file cancelled");
-			ret = -EAGAIN;
-			goto error;
-		}
-
-		if (!should_defrag_range(inode, (u64)i << PAGE_SHIFT,
-					 extent_thresh, &last_len, &skip,
-					 &defrag_end, do_compress)){
-			unsigned long next;
-			/*
-			 * the should_defrag function tells us how much to skip
-			 * bump our counter by the suggested amount
-			 */
-			next = DIV_ROUND_UP(skip, PAGE_SIZE);
-			i = max(i + 1, next);
-			continue;
-		}
+	while (cur < last_byte) {
+		u64 cluster_end;
 
-		if (!newer_than) {
-			cluster = (PAGE_ALIGN(defrag_end) >>
-				   PAGE_SHIFT) - i;
-			cluster = min(cluster, max_cluster);
-		} else {
-			cluster = max_cluster;
-		}
+		/* The cluster size 256K should always be page aligned */
+		BUILD_BUG_ON(!IS_ALIGNED(CLUSTER_SIZE, PAGE_SIZE));
 
-		if (i + cluster > ra_index) {
-			ra_index = max(i, ra_index);
-			if (ra)
-				page_cache_sync_readahead(inode->i_mapping, ra,
-						NULL, ra_index, cluster);
-			ra_index += cluster;
-		}
+		/* We want the cluster ends at page boundary when possible */
+		cluster_end = (((cur >> PAGE_SHIFT) +
+			       (SZ_256K >> PAGE_SHIFT)) << PAGE_SHIFT) - 1;
+		cluster_end = min(cluster_end, last_byte);
 
 		btrfs_inode_lock(inode, 0);
 		if (IS_SWAPFILE(inode)) {
 			ret = -ETXTBSY;
-		} else {
-			if (do_compress)
-				BTRFS_I(inode)->defrag_compress = compress_type;
-			ret = cluster_pages_for_defrag(inode, pages, i, cluster);
+			btrfs_inode_unlock(inode, 0);
+			break;
 		}
-		if (ret < 0) {
+		if (!(inode->i_sb->s_flags & SB_ACTIVE)) {
 			btrfs_inode_unlock(inode, 0);
-			goto out_ra;
+			break;
 		}
-
-		defrag_count += ret;
-		balance_dirty_pages_ratelimited(inode->i_mapping);
+		if (do_compress)
+			BTRFS_I(inode)->defrag_compress = compress_type;
+		ret = defrag_one_cluster(BTRFS_I(inode), ra, cur,
+				cluster_end + 1 - cur, extent_thresh,
+				newer_than, do_compress,
+				&sectors_defragged, max_to_defrag);
 		btrfs_inode_unlock(inode, 0);
-
-		if (newer_than) {
-			if (newer_off == (u64)-1)
-				break;
-
-			if (ret > 0)
-				i += ret;
-
-			newer_off = max(newer_off + 1,
-					(u64)i << PAGE_SHIFT);
-
-			ret = find_new_extents(root, inode, newer_than,
-					       &newer_off, SZ_64K);
-			if (!ret) {
-				range->start = newer_off;
-				i = (newer_off & new_align) >> PAGE_SHIFT;
-			} else {
-				break;
-			}
-		} else {
-			if (ret > 0) {
-				i += ret;
-				last_len += ret << PAGE_SHIFT;
-			} else {
-				i++;
-				last_len = 0;
-			}
-		}
+		if (ret < 0)
+			break;
+		cur = cluster_end + 1;
 	}
 
-	ret = defrag_count;
-error:
-	if ((range->flags & BTRFS_DEFRAG_RANGE_START_IO)) {
-		filemap_flush(inode->i_mapping);
-		if (test_bit(BTRFS_INODE_HAS_ASYNC_EXTENT,
-			     &BTRFS_I(inode)->runtime_flags))
+	if (ra_allocated)
+		kfree(ra);
+	if (sectors_defragged) {
+		/*
+		 * We have defragged some sectors, for compression case
+		 * they need to be written back immediately.
+		 */
+		if (range->flags & BTRFS_DEFRAG_RANGE_START_IO) {
 			filemap_flush(inode->i_mapping);
+			if (test_bit(BTRFS_INODE_HAS_ASYNC_EXTENT,
+				     &BTRFS_I(inode)->runtime_flags))
+				filemap_flush(inode->i_mapping);
+		}
+		if (range->compress_type == BTRFS_COMPRESS_LZO)
+			btrfs_set_fs_incompat(fs_info, COMPRESS_LZO);
+		else if (range->compress_type == BTRFS_COMPRESS_ZSTD)
+			btrfs_set_fs_incompat(fs_info, COMPRESS_ZSTD);
+		ret = sectors_defragged;
 	}
-
-	if (range->compress_type == BTRFS_COMPRESS_LZO) {
-		btrfs_set_fs_incompat(fs_info, COMPRESS_LZO);
-	} else if (range->compress_type == BTRFS_COMPRESS_ZSTD) {
-		btrfs_set_fs_incompat(fs_info, COMPRESS_ZSTD);
-	}
-
-out_ra:
 	if (do_compress) {
 		btrfs_inode_lock(inode, 0);
 		BTRFS_I(inode)->defrag_compress = BTRFS_COMPRESS_NONE;
 		btrfs_inode_unlock(inode, 0);
 	}
-	if (ra_allocated)
-		kfree(ra);
-	kfree(pages);
 	return ret;
 }
 
-- 
2.32.0

