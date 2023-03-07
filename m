Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1EEF6AE6FB
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 Mar 2023 17:43:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229890AbjCGQny (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 7 Mar 2023 11:43:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230326AbjCGQnY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 7 Mar 2023 11:43:24 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BDF72A6E6
        for <linux-btrfs@vger.kernel.org>; Tue,  7 Mar 2023 08:40:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=4O9IenRyuraVOyy5mWNjvhjZVusuywbp9CQWoD1XsW0=; b=DwGwNdIav1ewzGFjxJEDsYY3w0
        3PZK/DeMhZ+CLipjdzJGpEwX8EUMOAinH2BsIlyNytQezPltOiR5Es9fz2HdVeZOJi2A5VdoSG4An
        5Cavaf53Jcm2S7By1LLoDCUbQ/MWOsvrTyHC0BV3VlRKwX43gk4RZI8drIfPHVk3VBdlzLHtiNCRN
        Xbv2TP6bK3MDWqoCitsGFzk1w7APPGQrO4X+qjihFkMlc0Qf8Izd0nvuC5zfBDLP2PrVDQ1XNXvAV
        YtiAK7Q/t8FkaG9v3p1UctOAS+JB5j4j5zs13AWpaswnxlecFNtcqe6u6+IzxTttx8UJ2HjefvcWu
        Tv5YSW9w==;
Received: from [213.208.157.31] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pZaMk-001bcJ-75; Tue, 07 Mar 2023 16:40:42 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org, Anand Jain <anand.jain@oracle.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Qu Wenruo <wqu@suse.com>
Subject: [PATCH 05/10] btrfs: pass a btrfs_bio to btrfs_submit_compressed_read
Date:   Tue,  7 Mar 2023 17:39:40 +0100
Message-Id: <20230307163945.31770-6-hch@lst.de>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230307163945.31770-1-hch@lst.de>
References: <20230307163945.31770-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

btrfs_submit_compressed_read expects the bio passed to it to be embedded
into a btrfs_bio structure.  Pass the btrfs_bio directly to increase type
safety and make the code self-documenting.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Anand Jain <anand.jain@oracle.com>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Reviewed-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/compression.c | 16 ++++++++--------
 fs/btrfs/compression.h |  2 +-
 fs/btrfs/extent_io.c   |  2 +-
 3 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index 27bea05cab1a1b..c12e317e133624 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -498,15 +498,15 @@ static noinline int add_ra_bio_pages(struct inode *inode,
  * After the compressed pages are read, we copy the bytes into the
  * bio we were passed and then call the bio end_io calls
  */
-void btrfs_submit_compressed_read(struct bio *bio, int mirror_num)
+void btrfs_submit_compressed_read(struct btrfs_bio *bbio, int mirror_num)
 {
-	struct btrfs_inode *inode = btrfs_bio(bio)->inode;
+	struct btrfs_inode *inode = bbio->inode;
 	struct btrfs_fs_info *fs_info = inode->root->fs_info;
 	struct extent_map_tree *em_tree = &inode->extent_tree;
 	struct compressed_bio *cb;
 	unsigned int compressed_len;
-	const u64 disk_bytenr = bio->bi_iter.bi_sector << SECTOR_SHIFT;
-	u64 file_offset = btrfs_bio(bio)->file_offset;
+	const u64 disk_bytenr = bbio->bio.bi_iter.bi_sector << SECTOR_SHIFT;
+	u64 file_offset = bbio->file_offset;
 	u64 em_len;
 	u64 em_start;
 	struct extent_map *em;
@@ -534,10 +534,10 @@ void btrfs_submit_compressed_read(struct bio *bio, int mirror_num)
 	em_len = em->len;
 	em_start = em->start;
 
-	cb->len = bio->bi_iter.bi_size;
+	cb->len = bbio->bio.bi_iter.bi_size;
 	cb->compressed_len = compressed_len;
 	cb->compress_type = em->compress_type;
-	cb->orig_bio = bio;
+	cb->orig_bio = &bbio->bio;
 
 	free_extent_map(em);
 
@@ -558,7 +558,7 @@ void btrfs_submit_compressed_read(struct bio *bio, int mirror_num)
 			 &pflags);
 
 	/* include any pages we added in add_ra-bio_pages */
-	cb->len = bio->bi_iter.bi_size;
+	cb->len = bbio->bio.bi_iter.bi_size;
 
 	btrfs_add_compressed_bio_pages(cb, disk_bytenr);
 
@@ -573,7 +573,7 @@ void btrfs_submit_compressed_read(struct bio *bio, int mirror_num)
 out_free_bio:
 	bio_put(&cb->bbio.bio);
 out:
-	btrfs_bio_end_io(btrfs_bio(bio), ret);
+	btrfs_bio_end_io(bbio, ret);
 }
 
 /*
diff --git a/fs/btrfs/compression.h b/fs/btrfs/compression.h
index 95d2e85c6e4eea..692bafa1050e8e 100644
--- a/fs/btrfs/compression.h
+++ b/fs/btrfs/compression.h
@@ -94,7 +94,7 @@ void btrfs_submit_compressed_write(struct btrfs_inode *inode, u64 start,
 				  blk_opf_t write_flags,
 				  struct cgroup_subsys_state *blkcg_css,
 				  bool writeback);
-void btrfs_submit_compressed_read(struct bio *bio, int mirror_num);
+void btrfs_submit_compressed_read(struct btrfs_bio *bbio, int mirror_num);
 
 unsigned int btrfs_compress_str2level(unsigned int type, const char *str);
 
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 2e594252af0178..2b9e24782b36f5 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -155,7 +155,7 @@ static void submit_one_bio(struct btrfs_bio_ctrl *bio_ctrl)
 
 	if (btrfs_op(bio) == BTRFS_MAP_READ &&
 	    bio_ctrl->compress_type != BTRFS_COMPRESS_NONE)
-		btrfs_submit_compressed_read(bio, mirror_num);
+		btrfs_submit_compressed_read(btrfs_bio(bio), mirror_num);
 	else
 		btrfs_submit_bio(btrfs_bio(bio), mirror_num);
 
-- 
2.39.1

