Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F169E3AAAB1
	for <lists+linux-btrfs@lfdr.de>; Thu, 17 Jun 2021 07:15:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229972AbhFQFRN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 17 Jun 2021 01:17:13 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:38172 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbhFQFRM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 17 Jun 2021 01:17:12 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 804AA1FDB1
        for <linux-btrfs@vger.kernel.org>; Thu, 17 Jun 2021 05:15:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1623906904; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=18Gl1Xj/1GaZ+I1nVFXsz5vDAOvW9rQvPbRVdkoJdbA=;
        b=p37LOdDO4hXoX6b+2vlUOg0P1rh1zvUBcrGpfv183tJ+l5ShRg3C6SJC2iejf+Zivm4gi5
        Zss/akzBdpuX56fRAw+Lb+TqlWw7QWOLsbpidTk+Cg7lkS6vtcxWM5s0KpLydEojmacYx1
        3b4CATgVB3/b7xK6Nu+rMWz0QGbRfNk=
Received: from adam-pc.lan (unknown [10.163.16.38])
        by relay2.suse.de (Postfix) with ESMTP id 7C987A3BBA
        for <linux-btrfs@vger.kernel.org>; Thu, 17 Jun 2021 05:15:03 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v4 5/9] btrfs: introduce submit_compressed_bio() for compression
Date:   Thu, 17 Jun 2021 13:14:46 +0800
Message-Id: <20210617051450.206704-6-wqu@suse.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210617051450.206704-1-wqu@suse.com>
References: <20210617051450.206704-1-wqu@suse.com>
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
index a88aee331022..19da5b26359b 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -416,6 +416,21 @@ static void end_compressed_bio_write(struct bio *bio)
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
@@ -511,19 +526,13 @@ blk_status_t btrfs_submit_compressed_write(struct btrfs_inode *inode, u64 start,
 
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
 
@@ -549,18 +558,13 @@ blk_status_t btrfs_submit_compressed_write(struct btrfs_inode *inode, u64 start,
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
 
@@ -829,12 +833,6 @@ blk_status_t btrfs_submit_compressed_read(struct inode *inode, struct bio *bio,
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
@@ -843,7 +841,7 @@ blk_status_t btrfs_submit_compressed_read(struct inode *inode, struct bio *bio,
 						  fs_info->sectorsize);
 			sums += fs_info->csum_size * nr_sectors;
 
-			ret = btrfs_map_bio(fs_info, comp_bio, mirror_num);
+			ret = submit_compressed_bio(fs_info, cb, comp_bio, mirror_num);
 			if (ret)
 				goto finish_cb;
 
@@ -857,16 +855,11 @@ blk_status_t btrfs_submit_compressed_read(struct inode *inode, struct bio *bio,
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

