Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2D5E6CB5E8
	for <lists+linux-btrfs@lfdr.de>; Tue, 28 Mar 2023 07:20:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231979AbjC1FU3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 28 Mar 2023 01:20:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231487AbjC1FU1 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 28 Mar 2023 01:20:27 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA679268C
        for <linux-btrfs@vger.kernel.org>; Mon, 27 Mar 2023 22:20:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=lN1Xtm8AJJ7+DMvDv8GI9eSh0AEDbPfOEjtYakm2azM=; b=4V49kfFVc3InjPdUSXxjl6d6XJ
        N/SGdlXE1OK7H4WTSu/gcX0LKQpVs8NRBWQyyb3TV/kfVNObCgD0J8liJUNT/bTJMfcc6LlQqL1TD
        TCkrC0GGn5YQfzmMBgwTkdGFPlIMslid6OZJPQMezPlcAjzPePHtvDvFBVIk3qS9lmOjmVWCgm0r9
        nbKTpawdamNNu89Q/STFC6yTeK3RuABEDZNe73yT7zzmyzCaEYC3dgG6pp9AsxHKNzEY+sSM5uioI
        IdOtSkj0Y+jkr0lf2a61ynqTK5fppLzSgsxkRHT4V01bg8mk+IAg4G2ORIoXdGuuM2rCo5zuf2eVI
        KWvHazHA==;
Received: from [182.171.77.115] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1ph1ks-00DAYY-1r;
        Tue, 28 Mar 2023 05:20:22 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Boris Burkov <boris@bur.io>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>,
        linux-btrfs@vger.kernel.org,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH 09/11] btrfs: pass an ordered_extent to btrfs_extract_ordered_extent
Date:   Tue, 28 Mar 2023 14:19:55 +0900
Message-Id: <20230328051957.1161316-10-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230328051957.1161316-1-hch@lst.de>
References: <20230328051957.1161316-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

To prepare for a new caller that already has the ordered_extent
available, change btrfs_extract_ordered_extent to take an argument
for it.  Add a wrapper for the bio case that still has to do the
lookup (for now).

Signed-off-by: Christoph Hellwig <hch@lst.de>
Tested-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/bio.c         | 16 +++++++++++++++-
 fs/btrfs/btrfs_inode.h |  3 ++-
 fs/btrfs/inode.c       | 26 ++++++++------------------
 3 files changed, 25 insertions(+), 20 deletions(-)

diff --git a/fs/btrfs/bio.c b/fs/btrfs/bio.c
index cf09c6271edbee..1bb6a45edc2354 100644
--- a/fs/btrfs/bio.c
+++ b/fs/btrfs/bio.c
@@ -61,6 +61,20 @@ struct btrfs_bio *btrfs_bio_alloc(unsigned int nr_vecs, blk_opf_t opf,
 	return bbio;
 }
 
+static blk_status_t btrfs_bio_extract_ordered_extent(struct btrfs_bio *bbio)
+{
+	struct btrfs_ordered_extent *ordered;
+	int ret;
+
+	ordered = btrfs_lookup_ordered_extent(bbio->inode, bbio->file_offset);
+	if (WARN_ON_ONCE(!ordered))
+		return BLK_STS_IOERR;
+	ret = btrfs_extract_ordered_extent(bbio, ordered);
+	btrfs_put_ordered_extent(ordered);
+
+	return errno_to_blk_status(ret);
+}
+
 static struct btrfs_bio *btrfs_split_bio(struct btrfs_fs_info *fs_info,
 					 struct btrfs_bio *orig_bbio,
 					 u64 map_length, bool use_append)
@@ -653,7 +667,7 @@ static bool btrfs_submit_chunk(struct btrfs_bio *bbio, int mirror_num)
 		if (use_append) {
 			bio->bi_opf &= ~REQ_OP_WRITE;
 			bio->bi_opf |= REQ_OP_ZONE_APPEND;
-			ret = btrfs_extract_ordered_extent(bbio);
+			ret = btrfs_bio_extract_ordered_extent(bbio);
 			if (ret)
 				goto fail_put_bio;
 		}
diff --git a/fs/btrfs/btrfs_inode.h b/fs/btrfs/btrfs_inode.h
index 9dc21622806ef4..bb498448066981 100644
--- a/fs/btrfs/btrfs_inode.h
+++ b/fs/btrfs/btrfs_inode.h
@@ -407,7 +407,8 @@ static inline void btrfs_inode_split_flags(u64 inode_item_flags,
 
 int btrfs_check_sector_csum(struct btrfs_fs_info *fs_info, struct page *page,
 			    u32 pgoff, u8 *csum, const u8 * const csum_expected);
-blk_status_t btrfs_extract_ordered_extent(struct btrfs_bio *bbio);
+int btrfs_extract_ordered_extent(struct btrfs_bio *bbio,
+				 struct btrfs_ordered_extent *ordered);
 bool btrfs_data_csum_ok(struct btrfs_bio *bbio, struct btrfs_device *dev,
 			u32 bio_offset, struct bio_vec *bv);
 noinline int can_nocow_extent(struct inode *inode, u64 offset, u64 *len,
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index f7110a314a5fab..042018271baa37 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -2602,37 +2602,27 @@ static int split_extent_map(struct btrfs_inode *inode, u64 start, u64 len,
 	return ret;
 }
 
-blk_status_t btrfs_extract_ordered_extent(struct btrfs_bio *bbio)
+int btrfs_extract_ordered_extent(struct btrfs_bio *bbio,
+				 struct btrfs_ordered_extent *ordered)
 {
 	u64 start = (u64)bbio->bio.bi_iter.bi_sector << SECTOR_SHIFT;
 	u64 len = bbio->bio.bi_iter.bi_size;
 	struct btrfs_inode *inode = bbio->inode;
-	struct btrfs_ordered_extent *ordered;
-	u64 ordered_len;
+	u64 ordered_len = ordered->num_bytes;
 	int ret = 0;
 
-	ordered = btrfs_lookup_ordered_extent(inode, bbio->file_offset);
-	if (WARN_ON_ONCE(!ordered))
-		return BLK_STS_IOERR;
-	ordered_len = ordered->num_bytes;
-
 	/* Must always be called for the beginning of an ordered extent. */
-	if (WARN_ON_ONCE(start != ordered->disk_bytenr)) {
-		ret = -EINVAL;
-		goto out;
-	}
+	if (WARN_ON_ONCE(start != ordered->disk_bytenr))
+		return -EINVAL;
 
 	/* No need to split if the ordered extent covers the entire bio */
 	if (ordered->disk_num_bytes == len)
-		goto out;
+		return 0;
 
 	ret = btrfs_split_ordered_extent(ordered, len);
 	if (ret)
-		goto out;
-	ret = split_extent_map(inode, bbio->file_offset, ordered_len, len);
-out:
-	btrfs_put_ordered_extent(ordered);
-	return errno_to_blk_status(ret);
+		return ret;
+	return split_extent_map(inode, bbio->file_offset, ordered_len, len);
 }
 
 /*
-- 
2.39.2

