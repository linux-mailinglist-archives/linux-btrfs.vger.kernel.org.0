Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BBB558B46D
	for <lists+linux-btrfs@lfdr.de>; Sat,  6 Aug 2022 10:04:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229713AbiHFIDp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 6 Aug 2022 04:03:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbiHFIDo (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sat, 6 Aug 2022 04:03:44 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 049F713DEA
        for <linux-btrfs@vger.kernel.org>; Sat,  6 Aug 2022 01:03:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=GmvDHnaatPS/DZ20P63fpZdmzbRfa32AwIRvEpBz/R4=; b=lMS7lMdZbdL/w5387foxkI5T+i
        mjpFvPAWu8IkPEgsxzeHoCVI3blZo9R3VtJI/oCdmbF6mAEcw0QbA4o1FpCO2j1WHWALfn2VkZ8Fy
        SW+ocJEGmTPaiNMSgLfywhTzoEgkqmv4PN80AIFqAjFtirKTcfIoxWwFH/iVW0rHq/yrXT1294xjX
        h/aWdR601utprOvvZwN/3j54aI349KloDzy/GaOw7kBqla0UCnitcnG4PVsGYG/j/TS+ucKJD+EpV
        +g18N67yPlAKaeT+EkyWbO0Jl82vTyD0/wbSpS/BxQP91vnLSP8waqb9A5u4uJ95XdZ7fVRI1gNb6
        0VVG1Q1Q==;
Received: from [2001:4bb8:192:6d54:4997:d9fe:27ec:4c3c] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oKEma-006LnP-G8; Sat, 06 Aug 2022 08:03:40 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Nikolay Borisov <nborisov@suse.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        linux-btrfs@vger.kernel.org
Subject: [PATCH 03/11] btrfs: pass the operation to btrfs_bio_alloc
Date:   Sat,  6 Aug 2022 10:03:22 +0200
Message-Id: <20220806080330.3823644-4-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220806080330.3823644-1-hch@lst.de>
References: <20220806080330.3823644-1-hch@lst.de>
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
index f3df9b9b43816..e124096eacddd 100644
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
index 068208244d925..fae8c1899226b 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -2626,10 +2626,9 @@ int btrfs_repair_one_sector(struct inode *inode, struct btrfs_bio *failed_bbio,
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
@@ -3266,7 +3265,7 @@ static int alloc_new_bio(struct btrfs_inode *inode,
 	struct bio *bio;
 	int ret;
 
-	bio = btrfs_bio_alloc(BIO_MAX_VECS);
+	bio = btrfs_bio_alloc(BIO_MAX_VECS, opf);
 	/*
 	 * For compressed page range, its disk_bytenr is always @disk_bytenr
 	 * passed in, no matter if we have added any range into previous bio.
@@ -3278,7 +3277,6 @@ static int alloc_new_bio(struct btrfs_inode *inode,
 	bio_ctrl->bio = bio;
 	bio_ctrl->compress_type = compress_type;
 	bio->bi_end_io = end_io_func;
-	bio->bi_opf = opf;
 	ret = calc_bio_boundaries(bio_ctrl, inode, file_offset);
 	if (ret < 0)
 		goto error;
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 8cdb173331c7c..dc2cf58095c2e 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -10489,12 +10489,11 @@ int btrfs_encoded_read_regular_fill_pages(struct btrfs_inode *inode,
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
index bb614bb890709..a73bac7f42624 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -6624,11 +6624,11 @@ static inline void btrfs_bio_init(struct btrfs_bio *bbio)
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

