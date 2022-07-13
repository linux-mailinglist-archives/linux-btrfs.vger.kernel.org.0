Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B405572E03
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Jul 2022 08:14:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234173AbiGMGOO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 13 Jul 2022 02:14:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234139AbiGMGON (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 13 Jul 2022 02:14:13 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EA59B9DAF
        for <linux-btrfs@vger.kernel.org>; Tue, 12 Jul 2022 23:14:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=rnTmlZ1orGlRz8G8Cn8ysx8qKcf8m+9YOMQjzszYmVM=; b=yyzyxNFr32TYeNnhjQtDUsslla
        VZfOXQdjM57xGDDCqB6kRNEQsp2sSEDRbQGnEBeEDO+OSzfgbADwFobbCT8UXO3nXTnEN4qG+pYpe
        zEIkcN8hgZweKc8e/l+Py2Jqt5DbavVx7QEFylIzehuVllw9I8oDSal/ADQQND7KeQZcXkTnO8lrj
        oLUudUGBrznlm+6eE73aKai+6biJtGDR+GOlnLrCx3nHHCkSWdrxN+QQUVDJ9eR2WLJceGsYy0uX/
        hV3G6mPJAqmztsFRqI0NShTkze4HqmwjInIaBi0cyTQwaGiK01wy6KAEpPhpxgs7O5EjcwviaPrGf
        RHZxdRvQ==;
Received: from ip4d15c27d.dynamic.kabel-deutschland.de ([77.21.194.125] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oBVdQ-000T1x-SI; Wed, 13 Jul 2022 06:14:09 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Nikolay Borisov <nborisov@suse.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        linux-btrfs@vger.kernel.org
Subject: [PATCH 03/11] btrfs: pass the operation to btrfs_bio_alloc
Date:   Wed, 13 Jul 2022 08:13:51 +0200
Message-Id: <20220713061359.1980118-4-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220713061359.1980118-1-hch@lst.de>
References: <20220713061359.1980118-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Pass the operation to btrfs_bio_alloc, matching what bio_alloc_bioset
set does.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Nikolay Borisov <nborisov@suse.com>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Tested-by: Nikolay Borisov <nborisov@suse.com>
Tested-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/compression.c | 3 +--
 fs/btrfs/extent_io.c   | 6 ++----
 fs/btrfs/inode.c       | 3 +--
 fs/btrfs/volumes.c     | 4 ++--
 fs/btrfs/volumes.h     | 2 +-
 5 files changed, 7 insertions(+), 11 deletions(-)

diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index b6fb8b0682bae..b2bc605ec73a9 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -344,10 +344,9 @@ static struct bio *alloc_compressed_bio(struct compressed_bio *cb, u64 disk_byte
 	struct bio *bio;
 	int ret;
 
-	bio = btrfs_bio_alloc(BIO_MAX_VECS);
+	bio = btrfs_bio_alloc(BIO_MAX_VECS, opf);
 
 	bio->bi_iter.bi_sector = disk_bytenr >> SECTOR_SHIFT;
-	bio->bi_opf = opf;
 	bio->bi_private = cb;
 	bio->bi_end_io = endio_func;
 
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index f3a7614333cb7..667b4f439a089 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -2629,10 +2629,9 @@ int btrfs_repair_one_sector(struct inode *inode, struct btrfs_bio *failed_bbio,
 		return -EIO;
 	}
 
-	repair_bio = btrfs_bio_alloc(1);
+	repair_bio = btrfs_bio_alloc(1, REQ_OP_READ);
 	repair_bbio = btrfs_bio(repair_bio);
 	repair_bbio->file_offset = start;
-	repair_bio->bi_opf = REQ_OP_READ;
 	repair_bio->bi_end_io = failed_bio->bi_end_io;
 	repair_bio->bi_iter.bi_sector = failrec->logical >> 9;
 	repair_bio->bi_private = failed_bio->bi_private;
@@ -3267,7 +3266,7 @@ static int alloc_new_bio(struct btrfs_inode *inode,
 	struct bio *bio;
 	int ret;
 
-	bio = btrfs_bio_alloc(BIO_MAX_VECS);
+	bio = btrfs_bio_alloc(BIO_MAX_VECS, opf);
 	/*
 	 * For compressed page range, its disk_bytenr is always @disk_bytenr
 	 * passed in, no matter if we have added any range into previous bio.
@@ -3279,7 +3278,6 @@ static int alloc_new_bio(struct btrfs_inode *inode,
 	bio_ctrl->bio = bio;
 	bio_ctrl->compress_type = compress_type;
 	bio->bi_end_io = end_io_func;
-	bio->bi_opf = opf;
 	ret = calc_bio_boundaries(bio_ctrl, inode, file_offset);
 	if (ret < 0)
 		goto error;
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index c91b68bcbee23..18284f6105e7c 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -10478,12 +10478,11 @@ int btrfs_encoded_read_regular_fill_pages(struct btrfs_inode *inode,
 			size_t bytes = min_t(u64, remaining, PAGE_SIZE);
 
 			if (!bio) {
-				bio = btrfs_bio_alloc(BIO_MAX_VECS);
+				bio = btrfs_bio_alloc(BIO_MAX_VECS, REQ_OP_READ);
 				bio->bi_iter.bi_sector =
 					(disk_bytenr + cur) >> SECTOR_SHIFT;
 				bio->bi_end_io = btrfs_encoded_read_endio;
 				bio->bi_private = &priv;
-				bio->bi_opf = REQ_OP_READ;
 			}
 
 			if (!bytes ||
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 6825f62364c29..ce86ab6207eab 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -6627,11 +6627,11 @@ static inline void btrfs_bio_init(struct btrfs_bio *bbio)
  * Just like the underlying bio_alloc_bioset it will no fail as it is backed by
  * a mempool.
  */
-struct bio *btrfs_bio_alloc(unsigned int nr_vecs)
+struct bio *btrfs_bio_alloc(unsigned int nr_vecs, unsigned int opf)
 {
 	struct bio *bio;
 
-	bio = bio_alloc_bioset(NULL, nr_vecs, 0, GFP_NOFS, &btrfs_bioset);
+	bio = bio_alloc_bioset(NULL, nr_vecs, opf, GFP_NOFS, &btrfs_bioset);
 	btrfs_bio_init(btrfs_bio(bio));
 	return bio;
 }
diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index fb57b50fb60b1..bd108c7ed1ac3 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -393,7 +393,7 @@ static inline struct btrfs_bio *btrfs_bio(struct bio *bio)
 	return container_of(bio, struct btrfs_bio, bio);
 }
 
-struct bio *btrfs_bio_alloc(unsigned int nr_vecs);
+struct bio *btrfs_bio_alloc(unsigned int nr_vecs, unsigned int opf);
 struct bio *btrfs_bio_clone_partial(struct bio *orig, u64 offset, u64 size);
 
 static inline void btrfs_bio_free_csum(struct btrfs_bio *bbio)
-- 
2.30.2

