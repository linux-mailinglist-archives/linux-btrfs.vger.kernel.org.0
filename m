Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 164A86A6D46
	for <lists+linux-btrfs@lfdr.de>; Wed,  1 Mar 2023 14:42:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229895AbjCANmy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 1 Mar 2023 08:42:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229888AbjCANmt (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 1 Mar 2023 08:42:49 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 563F13E09E
        for <linux-btrfs@vger.kernel.org>; Wed,  1 Mar 2023 05:42:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=K9UfKIw8AdCa+UNKIV8m9nQCParbjkc/K7mideqw42k=; b=ghmhk0KnDf2W3PlTup5G71ni6r
        p4lgpgOZhlMZBQn2reo9kKqKMxIeXa3/d7OGKxrS1DlciWUNy5MrltxFoG81MLbGCFqnax4nnwHlC
        Hs8fCF1gUWNuloLmSZ21wjBEFz1xsr4OpKfeF3zeedPSM6vHpLgrO2F4EXANqNqRIzx6xqCtqUsnP
        Ct5zg6gt2T3NcVOxgbwrAvuqkMXEMnRAgJQypXYW9xhRNlT5K6LyCkZG0//GI0+l8PVKogwyO4Cr0
        42FCa9GfIp0KIBBv2OwocNem4YXJZnvBczsOrWkvFoIDlpZWjUNEjcv2kzvgWKYdhAy5WbWQozeuh
        1w3WMytg==;
Received: from [136.36.117.140] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pXMjG-00GN8G-GR; Wed, 01 Mar 2023 13:42:46 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: [PATCH 09/10] btrfs: return a btrfs_bio from btrfs_bio_alloc
Date:   Wed,  1 Mar 2023 06:42:42 -0700
Message-Id: <20230301134244.1378533-10-hch@lst.de>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230301134244.1378533-1-hch@lst.de>
References: <20230301134244.1378533-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Return the conaining struct btrfs_bio instead of the less type safe
struct bio from btrfs_bio_alloc.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/bio.c       | 12 +++++++-----
 fs/btrfs/bio.h       |  6 +++---
 fs/btrfs/extent_io.c | 18 +++++++++---------
 fs/btrfs/inode.c     | 18 +++++++++---------
 4 files changed, 28 insertions(+), 26 deletions(-)

diff --git a/fs/btrfs/bio.c b/fs/btrfs/bio.c
index c04e103f876853..527081abca026f 100644
--- a/fs/btrfs/bio.c
+++ b/fs/btrfs/bio.c
@@ -48,15 +48,17 @@ void btrfs_bio_init(struct btrfs_bio *bbio, struct btrfs_inode *inode,
  * Just like the underlying bio_alloc_bioset it will not fail as it is backed by
  * a mempool.
  */
-struct bio *btrfs_bio_alloc(unsigned int nr_vecs, blk_opf_t opf,
-			    struct btrfs_inode *inode,
-			    btrfs_bio_end_io_t end_io, void *private)
+struct btrfs_bio *btrfs_bio_alloc(unsigned int nr_vecs, blk_opf_t opf,
+				  struct btrfs_inode *inode,
+				  btrfs_bio_end_io_t end_io, void *private)
 {
+	struct btrfs_bio *bbio;
 	struct bio *bio;
 
 	bio = bio_alloc_bioset(NULL, nr_vecs, opf, GFP_NOFS, &btrfs_bioset);
-	btrfs_bio_init(btrfs_bio(bio), inode, end_io, private);
-	return bio;
+	bbio = btrfs_bio(bio);
+	btrfs_bio_init(bbio, inode, end_io, private);
+	return bbio;
 }
 
 static struct bio *btrfs_split_bio(struct btrfs_fs_info *fs_info,
diff --git a/fs/btrfs/bio.h b/fs/btrfs/bio.h
index b4e7d5ab7d236d..dbf125f6fa336d 100644
--- a/fs/btrfs/bio.h
+++ b/fs/btrfs/bio.h
@@ -75,9 +75,9 @@ void __cold btrfs_bioset_exit(void);
 
 void btrfs_bio_init(struct btrfs_bio *bbio, struct btrfs_inode *inode,
 		    btrfs_bio_end_io_t end_io, void *private);
-struct bio *btrfs_bio_alloc(unsigned int nr_vecs, blk_opf_t opf,
-			    struct btrfs_inode *inode,
-			    btrfs_bio_end_io_t end_io, void *private);
+struct btrfs_bio *btrfs_bio_alloc(unsigned int nr_vecs, blk_opf_t opf,
+				  struct btrfs_inode *inode,
+				  btrfs_bio_end_io_t end_io, void *private);
 
 static inline void btrfs_bio_end_io(struct btrfs_bio *bbio, blk_status_t status)
 {
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index df143c5267e61b..2d5e4df3419b0f 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -896,13 +896,13 @@ static void alloc_new_bio(struct btrfs_inode *inode,
 			  u64 disk_bytenr, u64 file_offset)
 {
 	struct btrfs_fs_info *fs_info = inode->root->fs_info;
-	struct bio *bio;
+	struct btrfs_bio *bbio;
 
-	bio = btrfs_bio_alloc(BIO_MAX_VECS, bio_ctrl->opf, inode,
-			      bio_ctrl->end_io_func, NULL);
-	bio->bi_iter.bi_sector = disk_bytenr >> SECTOR_SHIFT;
-	btrfs_bio(bio)->file_offset = file_offset;
-	bio_ctrl->bbio = btrfs_bio(bio);
+	bbio = btrfs_bio_alloc(BIO_MAX_VECS, bio_ctrl->opf, inode,
+			       bio_ctrl->end_io_func, NULL);
+	bbio->bio.bi_iter.bi_sector = disk_bytenr >> SECTOR_SHIFT;
+	bbio->file_offset = file_offset;
+	bio_ctrl->bbio = bbio;
 	bio_ctrl->len_to_oe_boundary = U32_MAX;
 
 	/*
@@ -911,7 +911,7 @@ static void alloc_new_bio(struct btrfs_inode *inode,
 	 * them.
 	 */
 	if (bio_ctrl->compress_type == BTRFS_COMPRESS_NONE &&
-	    btrfs_use_zone_append(btrfs_bio(bio))) {
+	    btrfs_use_zone_append(bbio)) {
 		struct btrfs_ordered_extent *ordered;
 
 		ordered = btrfs_lookup_ordered_extent(inode, file_offset);
@@ -930,8 +930,8 @@ static void alloc_new_bio(struct btrfs_inode *inode,
 		 * to always be set on the last added/replaced device.
 		 * This is a bit odd but has been like that for a long time.
 		 */
-		bio_set_dev(bio, fs_info->fs_devices->latest_dev->bdev);
-		wbc_init_bio(bio_ctrl->wbc, bio);
+		bio_set_dev(&bbio->bio, fs_info->fs_devices->latest_dev->bdev);
+		wbc_init_bio(bio_ctrl->wbc, &bbio->bio);
 	}
 }
 
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index ed96c84f5be71d..7e691bab72dffa 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -9959,24 +9959,24 @@ int btrfs_encoded_read_regular_fill_pages(struct btrfs_inode *inode,
 		.pending = ATOMIC_INIT(1),
 	};
 	unsigned long i = 0;
-	struct bio *bio;
+	struct btrfs_bio *bbio;
 
 	init_waitqueue_head(&priv.wait);
 
-	bio = btrfs_bio_alloc(BIO_MAX_VECS, REQ_OP_READ, inode,
+	bbio = btrfs_bio_alloc(BIO_MAX_VECS, REQ_OP_READ, inode,
 			      btrfs_encoded_read_endio, &priv);
-	bio->bi_iter.bi_sector = disk_bytenr >> SECTOR_SHIFT;
+	bbio->bio.bi_iter.bi_sector = disk_bytenr >> SECTOR_SHIFT;
 
 	do {
 		size_t bytes = min_t(u64, disk_io_size, PAGE_SIZE);
 
-		if (bio_add_page(bio, pages[i], bytes, 0) < bytes) {
+		if (bio_add_page(&bbio->bio, pages[i], bytes, 0) < bytes) {
 			atomic_inc(&priv.pending);
-			btrfs_submit_bio(btrfs_bio(bio), 0);
+			btrfs_submit_bio(bbio, 0);
 
-			bio = btrfs_bio_alloc(BIO_MAX_VECS, REQ_OP_READ, inode,
-					      btrfs_encoded_read_endio, &priv);
-			bio->bi_iter.bi_sector = disk_bytenr >> SECTOR_SHIFT;
+			bbio = btrfs_bio_alloc(BIO_MAX_VECS, REQ_OP_READ, inode,
+					       btrfs_encoded_read_endio, &priv);
+			bbio->bio.bi_iter.bi_sector = disk_bytenr >> SECTOR_SHIFT;
 			continue;
 		}
 
@@ -9986,7 +9986,7 @@ int btrfs_encoded_read_regular_fill_pages(struct btrfs_inode *inode,
 	} while (disk_io_size);
 
 	atomic_inc(&priv.pending);
-	btrfs_submit_bio(btrfs_bio(bio), 0);
+	btrfs_submit_bio(bbio, 0);
 
 	if (atomic_dec_return(&priv.pending))
 		io_wait_event(priv.wait, !atomic_read(&priv.pending));
-- 
2.39.1

