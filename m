Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 338433A7E0D
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Jun 2021 14:18:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230351AbhFOMUy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 15 Jun 2021 08:20:54 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:38472 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230344AbhFOMUy (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 15 Jun 2021 08:20:54 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 2781E219C0
        for <linux-btrfs@vger.kernel.org>; Tue, 15 Jun 2021 12:18:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1623759529; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nHXuJ3sqlQhDfzCA3CX9yK/+EeUXbnQwZxT1oqO0Ae8=;
        b=G9oHSzLpD/8ByK5lWw/DvmfStN9sciYQ8yyC0rDHb2YdRnbwFMmbTBubpLX/nYAIPk9SUG
        EJZR5y1dWnDSBkL//qr70/pcp564GDSdBFa57sCw1pj+O6VdvSMagG5OvPNkUkp5Mf+8Tp
        auxKMojE9hzxSbyb7rcnRpnfiNyHCvw=
Received: from adam-pc.lan (unknown [10.163.16.38])
        by relay2.suse.de (Postfix) with ESMTP id 2B419A3B8E
        for <linux-btrfs@vger.kernel.org>; Tue, 15 Jun 2021 12:18:47 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v3 5/9] btrfs: introduce submit_compressed_bio() for compression
Date:   Tue, 15 Jun 2021 20:18:32 +0800
Message-Id: <20210615121836.365105-6-wqu@suse.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210615121836.365105-1-wqu@suse.com>
References: <20210615121836.365105-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The new helper, submit_compressed_bio(), will aggregate the following
work:

- Increase compressed_bio::pending_bios
- Remap the endio function
- Map and submit the bio

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/compression.c | 45 ++++++++++++++++++------------------------
 1 file changed, 19 insertions(+), 26 deletions(-)

diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index 706efa2d1438..608e9325b7c8 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -425,6 +425,21 @@ static void end_compressed_bio_write(struct bio *bio)
 	bio_put(bio);
 }
 
+static blk_status_t submit_compressed_bio(struct btrfs_fs_info *fs_info,
+					  struct compressed_bio *cb,
+					  struct bio *bio, int mirror_num)
+{
+	blk_status_t ret;
+
+	ASSERT(bio->bi_iter.bi_size);
+	atomic_inc(&cb->pending_bios);
+	ret = btrfs_bio_wq_end_io(fs_info, bio, BTRFS_WQ_ENDIO_DATA);
+	if (ret)
+		return ret;
+	ret = btrfs_map_bio(fs_info, bio, mirror_num);
+	return ret;
+}
+
 /*
  * worker function to build and submit bios for previously compressed pages.
  * The corresponding pages in the inode should be marked for writeback
@@ -520,19 +535,13 @@ blk_status_t btrfs_submit_compressed_write(struct btrfs_inode *inode, u64 start,
 
 		page->mapping = NULL;
 		if (submit || len < PAGE_SIZE) {
-			atomic_inc(&cb->pending_bios);
-			ret = btrfs_bio_wq_end_io(fs_info, bio,
-						  BTRFS_WQ_ENDIO_DATA);
-			if (ret)
-				goto finish_cb;
-
 			if (!skip_sum) {
 				ret = btrfs_csum_one_bio(inode, bio, start, 1);
 				if (ret)
 					goto finish_cb;
 			}
 
-			ret = btrfs_map_bio(fs_info, bio, 0);
+			ret = submit_compressed_bio(fs_info, cb, bio, 0);
 			if (ret)
 				goto finish_cb;
 
@@ -558,18 +567,13 @@ blk_status_t btrfs_submit_compressed_write(struct btrfs_inode *inode, u64 start,
 		cond_resched();
 	}
 
-	atomic_inc(&cb->pending_bios);
-	ret = btrfs_bio_wq_end_io(fs_info, bio, BTRFS_WQ_ENDIO_DATA);
-	if (ret)
-		goto last_bio;
-
 	if (!skip_sum) {
 		ret = btrfs_csum_one_bio(inode, bio, start, 1);
 		if (ret)
 			goto last_bio;
 	}
 
-	ret = btrfs_map_bio(fs_info, bio, 0);
+	ret = submit_compressed_bio(fs_info, cb, bio, 0);
 	if (ret)
 		goto last_bio;
 
@@ -840,12 +844,6 @@ blk_status_t btrfs_submit_compressed_read(struct inode *inode, struct bio *bio,
 		if (submit || bio_add_page(comp_bio, page, pg_len, 0) < pg_len) {
 			unsigned int nr_sectors;
 
-			atomic_inc(&cb->pending_bios);
-			ret = btrfs_bio_wq_end_io(fs_info, comp_bio,
-						  BTRFS_WQ_ENDIO_DATA);
-			if (ret)
-				goto finish_cb;
-
 			ret = btrfs_lookup_bio_sums(inode, comp_bio, sums);
 			if (ret)
 				goto finish_cb;
@@ -854,7 +852,7 @@ blk_status_t btrfs_submit_compressed_read(struct inode *inode, struct bio *bio,
 						  fs_info->sectorsize);
 			sums += fs_info->csum_size * nr_sectors;
 
-			ret = btrfs_map_bio(fs_info, comp_bio, mirror_num);
+			ret = submit_compressed_bio(fs_info, cb, comp_bio, mirror_num);
 			if (ret)
 				goto finish_cb;
 
@@ -868,16 +866,11 @@ blk_status_t btrfs_submit_compressed_read(struct inode *inode, struct bio *bio,
 		cur_disk_byte += pg_len;
 	}
 
-	atomic_inc(&cb->pending_bios);
-	ret = btrfs_bio_wq_end_io(fs_info, comp_bio, BTRFS_WQ_ENDIO_DATA);
-	if (ret)
-		goto last_bio;
-
 	ret = btrfs_lookup_bio_sums(inode, comp_bio, sums);
 	if (ret)
 		goto last_bio;
 
-	ret = btrfs_map_bio(fs_info, comp_bio, mirror_num);
+	ret = submit_compressed_bio(fs_info, cb, comp_bio, mirror_num);
 	if (ret)
 		goto last_bio;
 
-- 
2.32.0

