Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A05883A429E
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Jun 2021 15:01:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231710AbhFKNCu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 11 Jun 2021 09:02:50 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:35858 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231161AbhFKNCu (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 11 Jun 2021 09:02:50 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 285C121A5C
        for <linux-btrfs@vger.kernel.org>; Fri, 11 Jun 2021 13:00:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1623416452; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=E/Vluc0NaoaoYny0jrZjGxNsAKslPGI0XzVlyVweBRs=;
        b=bLt4gGaTadrxDeGHpTDrlvNuZGBmYr7I8UN/LlqM/F/dVRFjf7pbxlezsMR8kzXwRLHdq0
        KKPaeLkTMxYX3bmATdI4w/IcV6zaxQJf5BZ/P+UO9Ut/VyLm96DkYBfI8OI8kOVdJqIjCg
        jfa0njn96I8pgvBUbBF/OSyA2bn90Ek=
Received: from adam-pc.lan (unknown [10.163.16.38])
        by relay2.suse.de (Postfix) with ESMTP id B03BFA3BC2
        for <linux-btrfs@vger.kernel.org>; Fri, 11 Jun 2021 13:00:50 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 5/9] btrfs: introduce submit_compressed_bio() for compression
Date:   Fri, 11 Jun 2021 21:00:29 +0800
Message-Id: <20210611130033.329908-6-wqu@suse.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210611130033.329908-1-wqu@suse.com>
References: <20210611130033.329908-1-wqu@suse.com>
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
 fs/btrfs/compression.c | 44 +++++++++++++++++-------------------------
 1 file changed, 18 insertions(+), 26 deletions(-)

diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index 0dcf6e1b9738..454e54b6ff5e 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -404,6 +404,20 @@ static void end_compressed_bio_write(struct bio *bio)
 	bio_put(bio);
 }
 
+static blk_status_t submit_compressed_bio(struct btrfs_fs_info *fs_info,
+					  struct compressed_bio *cb,
+					  struct bio *bio, int mirror_num)
+{
+	blk_status_t ret;
+
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
@@ -499,19 +513,13 @@ blk_status_t btrfs_submit_compressed_write(struct btrfs_inode *inode, u64 start,
 
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
 
@@ -537,18 +545,13 @@ blk_status_t btrfs_submit_compressed_write(struct btrfs_inode *inode, u64 start,
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
 
@@ -819,12 +822,6 @@ blk_status_t btrfs_submit_compressed_read(struct inode *inode, struct bio *bio,
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
@@ -833,7 +830,7 @@ blk_status_t btrfs_submit_compressed_read(struct inode *inode, struct bio *bio,
 						  fs_info->sectorsize);
 			sums += fs_info->csum_size * nr_sectors;
 
-			ret = btrfs_map_bio(fs_info, comp_bio, mirror_num);
+			ret = submit_compressed_bio(fs_info, cb, comp_bio, mirror_num);
 			if (ret)
 				goto finish_cb;
 
@@ -847,16 +844,11 @@ blk_status_t btrfs_submit_compressed_read(struct inode *inode, struct bio *bio,
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

