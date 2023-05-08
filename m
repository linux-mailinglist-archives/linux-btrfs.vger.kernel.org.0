Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 638296FB4BA
	for <lists+linux-btrfs@lfdr.de>; Mon,  8 May 2023 18:08:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232438AbjEHQIt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 8 May 2023 12:08:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbjEHQIs (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 8 May 2023 12:08:48 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 537D36580
        for <linux-btrfs@vger.kernel.org>; Mon,  8 May 2023 09:08:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=d6snkGl6NTgqQNVLnENkwoZL1bp302RcUwQDp7GRoDI=; b=WSSlqBtIWIJ3kxPfZH+nmFH7zw
        6gKaB+OzresXFCyIHbz16EZVnQQNxUJQOBIcoys/FDKFYwytdeiu8PLciabsvN974asVjo1DNnDIp
        TjZ9XJJ6JGKKqQ9ipjun32MPemGo4/0+SkIcWSfEc5l5vBCOMBHCmRbnUKqIP1bjXm+XcEfbKOmTN
        Pm728Kr11Y3RCzjcH8A49slp/AL2PD6OHLgUAyoHUourAPMKW0n4qqttxpPro82yOBG4z5S6txc3T
        8wufLET57m7lacgfylca1OKkpsjCHdPqLTenoK/yG6BxmMGAE2tXArpixrPbtOBmrj3MzNbdj5Pya
        U7Ghw1vA==;
Received: from [208.98.210.70] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pw3Pp-000vzf-2M;
        Mon, 08 May 2023 16:08:45 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: [PATCH 03/21] btrfs: limit write bios to a single ordered extent
Date:   Mon,  8 May 2023 09:08:25 -0700
Message-Id: <20230508160843.133013-4-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230508160843.133013-1-hch@lst.de>
References: <20230508160843.133013-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Currently buffered writeback bios are allowed to span multiple
ordered_extents, although that basically never actually happens since
commit 4a445b7b6178 ("btrfs: don't merge pages into bio if their page
offset is not contiguous").

Supporting bios than span ordered_extents complicates the file
checksumming code, and prevents us from adding an ordered_extent pointer
to the btrfs_bio structure.  Use the existing code to limit a bio to
single ordered_extent for zoned device writes for all writes.

This allows to remove the REQ_BTRFS_ONE_ORDERED flags, and the
handling of multiple ordered_extents in btrfs_csum_one_bio.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/bio.c         |  3 ---
 fs/btrfs/bio.h         |  3 ---
 fs/btrfs/compression.c |  2 --
 fs/btrfs/extent_io.c   |  9 ++-------
 fs/btrfs/file-item.c   | 33 ---------------------------------
 5 files changed, 2 insertions(+), 48 deletions(-)

diff --git a/fs/btrfs/bio.c b/fs/btrfs/bio.c
index ae30ef638716b0..5f418eeaac070b 100644
--- a/fs/btrfs/bio.c
+++ b/fs/btrfs/bio.c
@@ -471,9 +471,6 @@ static void btrfs_submit_mirrored_bio(struct btrfs_io_context *bioc, int dev_nr)
 static void __btrfs_submit_bio(struct bio *bio, struct btrfs_io_context *bioc,
 			       struct btrfs_io_stripe *smap, int mirror_num)
 {
-	/* Do not leak our private flag into the block layer. */
-	bio->bi_opf &= ~REQ_BTRFS_ONE_ORDERED;
-
 	if (!bioc) {
 		/* Single mirror read/write fast path. */
 		btrfs_bio(bio)->mirror_num = mirror_num;
diff --git a/fs/btrfs/bio.h b/fs/btrfs/bio.h
index a8eca3a6567320..000e807f785395 100644
--- a/fs/btrfs/bio.h
+++ b/fs/btrfs/bio.h
@@ -91,9 +91,6 @@ static inline void btrfs_bio_end_io(struct btrfs_bio *bbio, blk_status_t status)
 	bbio->end_io(bbio);
 }
 
-/* Bio only refers to one ordered extent. */
-#define REQ_BTRFS_ONE_ORDERED			REQ_DRV
-
 /* Submit using blkcg_punt_bio_submit. */
 #define REQ_BTRFS_CGROUP_PUNT			REQ_FS_PRIVATE
 
diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index 14f5f25049a0d7..4f85113cbf9f0c 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -295,8 +295,6 @@ void btrfs_submit_compressed_write(struct btrfs_inode *inode, u64 start,
 	ASSERT(IS_ALIGNED(start, fs_info->sectorsize) &&
 	       IS_ALIGNED(len, fs_info->sectorsize));
 
-	write_flags |= REQ_BTRFS_ONE_ORDERED;
-
 	cb = alloc_compressed_bio(inode, start, REQ_OP_WRITE | write_flags,
 				  end_compressed_bio_write);
 	cb->start = start;
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index a1adadd5d25ddb..92e1edfcfb9cb4 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -907,12 +907,9 @@ static void alloc_new_bio(struct btrfs_inode *inode,
 	bio_ctrl->len_to_oe_boundary = U32_MAX;
 
 	/*
-	 * Limit the extent to the ordered boundary for Zone Append.
-	 * Compressed bios aren't submitted directly, so it doesn't apply to
-	 * them.
+	 * Limit data write bios to the ordered boundary.
 	 */
-	if (bio_ctrl->compress_type == BTRFS_COMPRESS_NONE &&
-	    btrfs_use_zone_append(bbio)) {
+	if (bio_ctrl->wbc) {
 		struct btrfs_ordered_extent *ordered;
 
 		ordered = btrfs_lookup_ordered_extent(inode, file_offset);
@@ -922,9 +919,7 @@ static void alloc_new_bio(struct btrfs_inode *inode,
 					ordered->disk_num_bytes - file_offset);
 			btrfs_put_ordered_extent(ordered);
 		}
-	}
 
-	if (bio_ctrl->wbc) {
 		/*
 		 * Pick the last added device to support cgroup writeback.  For
 		 * multi-device file systems this means blk-cgroup policies have
diff --git a/fs/btrfs/file-item.c b/fs/btrfs/file-item.c
index e74b9804bcdec8..1c1cb6373f2c30 100644
--- a/fs/btrfs/file-item.c
+++ b/fs/btrfs/file-item.c
@@ -733,8 +733,6 @@ blk_status_t btrfs_csum_one_bio(struct btrfs_bio *bbio)
 	struct bio_vec bvec;
 	int index;
 	unsigned int blockcount;
-	unsigned long total_bytes = 0;
-	unsigned long this_sum_bytes = 0;
 	int i;
 	unsigned nofs_flag;
 
@@ -776,34 +774,6 @@ blk_status_t btrfs_csum_one_bio(struct btrfs_bio *bbio)
 						 - 1);
 
 		for (i = 0; i < blockcount; i++) {
-			if (!(bio->bi_opf & REQ_BTRFS_ONE_ORDERED) &&
-			    !in_range(offset, ordered->file_offset,
-				      ordered->num_bytes)) {
-				unsigned long bytes_left;
-
-				sums->len = this_sum_bytes;
-				this_sum_bytes = 0;
-				btrfs_add_ordered_sum(ordered, sums);
-				btrfs_put_ordered_extent(ordered);
-
-				bytes_left = bio->bi_iter.bi_size - total_bytes;
-
-				nofs_flag = memalloc_nofs_save();
-				sums = kvzalloc(btrfs_ordered_sum_size(fs_info,
-						      bytes_left), GFP_KERNEL);
-				memalloc_nofs_restore(nofs_flag);
-				if (!sums)
-					return BLK_STS_RESOURCE;
-
-				sums->len = bytes_left;
-				ordered = btrfs_lookup_ordered_extent(inode,
-								offset);
-				ASSERT(ordered); /* Logic error */
-				sums->bytenr = (bio->bi_iter.bi_sector << SECTOR_SHIFT)
-					+ total_bytes;
-				index = 0;
-			}
-
 			data = bvec_kmap_local(&bvec);
 			crypto_shash_digest(shash,
 					    data + (i * fs_info->sectorsize),
@@ -812,12 +782,9 @@ blk_status_t btrfs_csum_one_bio(struct btrfs_bio *bbio)
 			kunmap_local(data);
 			index += fs_info->csum_size;
 			offset += fs_info->sectorsize;
-			this_sum_bytes += fs_info->sectorsize;
-			total_bytes += fs_info->sectorsize;
 		}
 
 	}
-	this_sum_bytes = 0;
 	btrfs_add_ordered_sum(ordered, sums);
 	btrfs_put_ordered_extent(ordered);
 	return 0;
-- 
2.39.2

