Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73E1A29EE3E
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Oct 2020 15:29:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727271AbgJ2O3c (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 29 Oct 2020 10:29:32 -0400
Received: from mx2.suse.de ([195.135.220.15]:48870 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727673AbgJ2O3b (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 29 Oct 2020 10:29:31 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1603981769;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jxuRLhopGZqN7DW/3JBz2jc9zBWIlV7QbIFJX3QgiTs=;
        b=qGPUkIZtFaYfT62uDlOTCw3CmGD/DEjLRkGcvO2DzeevPoP+bkgCqgYl2yBooyUkHgBly7
        4FEsJV/fz9FCQdqyMN2t9oPit9vpifL5m3LLWyFyzMSFMChZnS4FAK8OvcxjebAq9i/Io0
        410iUTLGSBZe+pM9iTdzcqx5Xg4kVC4=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 1E949AB5C;
        Thu, 29 Oct 2020 14:29:29 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 30FE4DA7CE; Thu, 29 Oct 2020 15:27:54 +0100 (CET)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 08/10] btrfs: remove unnecessary local variables for checksum size
Date:   Thu, 29 Oct 2020 15:27:54 +0100
Message-Id: <da71002084c80344ea01f56b0554ed9c88dfbe10.1603981453.git.dsterba@suse.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <cover.1603981452.git.dsterba@suse.com>
References: <cover.1603981452.git.dsterba@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Remove local variable that is then used just once and replace it with
fs_info::csum_tree.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/compression.c  | 6 ++----
 fs/btrfs/disk-io.c      | 3 +--
 fs/btrfs/file-item.c    | 3 +--
 fs/btrfs/ordered-data.h | 3 +--
 4 files changed, 5 insertions(+), 10 deletions(-)

diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index b2bb4681975e..4e022ed72d2f 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -131,9 +131,8 @@ static int btrfs_decompress_bio(struct compressed_bio *cb);
 static inline int compressed_bio_size(struct btrfs_fs_info *fs_info,
 				      unsigned long disk_size)
 {
-	const u32 csum_size = fs_info->csum_size;
 	return sizeof(struct compressed_bio) +
-		(DIV_ROUND_UP(disk_size, fs_info->sectorsize)) * csum_size;
+		(DIV_ROUND_UP(disk_size, fs_info->sectorsize)) * fs_info->csum_size;
 }
 
 static int check_compressed_csum(struct btrfs_inode *inode, struct bio *bio,
@@ -627,7 +626,6 @@ blk_status_t btrfs_submit_compressed_read(struct inode *inode, struct bio *bio,
 	struct extent_map *em;
 	blk_status_t ret = BLK_STS_RESOURCE;
 	int faili = 0;
-	const u32 csum_size = fs_info->csum_size;
 	u8 *sums;
 
 	em_tree = &BTRFS_I(inode)->extent_tree;
@@ -727,7 +725,7 @@ blk_status_t btrfs_submit_compressed_read(struct inode *inode, struct bio *bio,
 
 			nr_sectors = DIV_ROUND_UP(comp_bio->bi_iter.bi_size,
 						  fs_info->sectorsize);
-			sums += csum_size * nr_sectors;
+			sums += fs_info->csum_size * nr_sectors;
 
 			ret = btrfs_map_bio(fs_info, comp_bio, mirror_num);
 			if (ret) {
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index aa89d5c15f6e..128eb2d56862 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -452,7 +452,6 @@ static int csum_dirty_buffer(struct btrfs_fs_info *fs_info, struct page *page)
 	u64 start = page_offset(page);
 	u64 found_start;
 	u8 result[BTRFS_CSUM_SIZE];
-	const u32 csum_size = fs_info->csum_size;
 	struct extent_buffer *eb;
 	int ret;
 
@@ -489,7 +488,7 @@ static int csum_dirty_buffer(struct btrfs_fs_info *fs_info, struct page *page)
 		WARN_ON(IS_ENABLED(CONFIG_BTRFS_DEBUG));
 		return ret;
 	}
-	write_extent_buffer(eb, result, 0, csum_size);
+	write_extent_buffer(eb, result, 0, fs_info->csum_size);
 
 	return 0;
 }
diff --git a/fs/btrfs/file-item.c b/fs/btrfs/file-item.c
index d7fdfd6ea6f4..3356bd3ae0e0 100644
--- a/fs/btrfs/file-item.c
+++ b/fs/btrfs/file-item.c
@@ -541,7 +541,6 @@ blk_status_t btrfs_csum_one_bio(struct btrfs_inode *inode, struct bio *bio,
 	int i;
 	u64 offset;
 	unsigned nofs_flag;
-	const u32 csum_size = fs_info->csum_size;
 
 	nofs_flag = memalloc_nofs_save();
 	sums = kvzalloc(btrfs_ordered_sum_size(fs_info, bio->bi_iter.bi_size),
@@ -609,7 +608,7 @@ blk_status_t btrfs_csum_one_bio(struct btrfs_inode *inode, struct bio *bio,
 					    fs_info->sectorsize,
 					    sums->sums + index);
 			kunmap_atomic(data);
-			index += csum_size;
+			index += fs_info->csum_size;
 			offset += fs_info->sectorsize;
 			this_sum_bytes += fs_info->sectorsize;
 			total_bytes += fs_info->sectorsize;
diff --git a/fs/btrfs/ordered-data.h b/fs/btrfs/ordered-data.h
index e48810104e4a..367269effd6a 100644
--- a/fs/btrfs/ordered-data.h
+++ b/fs/btrfs/ordered-data.h
@@ -137,9 +137,8 @@ static inline int btrfs_ordered_sum_size(struct btrfs_fs_info *fs_info,
 					 unsigned long bytes)
 {
 	int num_sectors = (int)DIV_ROUND_UP(bytes, fs_info->sectorsize);
-	const u32 csum_size = fs_info->csum_size;
 
-	return sizeof(struct btrfs_ordered_sum) + num_sectors * csum_size;
+	return sizeof(struct btrfs_ordered_sum) + num_sectors * fs_info->csum_size;
 }
 
 static inline void
-- 
2.25.0

