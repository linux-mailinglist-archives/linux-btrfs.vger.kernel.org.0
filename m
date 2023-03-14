Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB32D6B9C23
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 Mar 2023 17:51:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230086AbjCNQv0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 14 Mar 2023 12:51:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229847AbjCNQvZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 14 Mar 2023 12:51:25 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75FBDAB0A0
        for <linux-btrfs@vger.kernel.org>; Tue, 14 Mar 2023 09:51:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=9G9S4wtdVy41xRUmMPQeV/DxeAjubL9dGowZ62xBEfM=; b=0OGemWlZDnVU+tZrbbW02Z73XJ
        Vz8hOcI+6t1bLI0kmfmPMWDyiFL0xcS7IY/g9smUraK+7c/FkT6Zptd0vQLmkLt6CeA2DL4+aE+7a
        gxUhRyAvyoJk/U2EwGQU/QbNnXuLgTyYFHpXpipU2Sxl/fHlLLkd9nSB4MZWZkFZ8bgkZFt9pA1H4
        rd3TQt8Uke88/GMItt7g/PBIv/T9mxLxM0ZbXlgkVtp1RlhSBPHc0f6uCHpYIYARHah7DFoyPeevL
        8ULg+tLbnpoYQj8k7ynx4YHaxlU8FxPY80l2gRe61gq5IJHSJ/OCfLF68KgKJ2k24V78qSlxzDaSQ
        L1r5HmgA==;
Received: from [2001:4bb8:182:2e36:91ea:d0e2:233a:8356] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pc7rt-00AumV-1W;
        Tue, 14 Mar 2023 16:51:22 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: [PATCH 1/2] btrfs: move the bi_sector assingment out of btrfs_add_compressed_bio_pages
Date:   Tue, 14 Mar 2023 17:51:09 +0100
Message-Id: <20230314165110.372858-2-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230314165110.372858-1-hch@lst.de>
References: <20230314165110.372858-1-hch@lst.de>
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

Adding pages to a bio has nothing to do with the sector.  Move the
assignment to the two callers in preparation for cleaning up
btrfs_add_compressed_bio_pages.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/compression.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index c5839d04690d67..1487c9413e6942 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -256,14 +256,13 @@ static void end_compressed_bio_write(struct btrfs_bio *bbio)
 	queue_work(fs_info->compressed_write_workers, &cb->write_end_work);
 }
 
-static void btrfs_add_compressed_bio_pages(struct compressed_bio *cb,
-					   u64 disk_bytenr)
+static void btrfs_add_compressed_bio_pages(struct compressed_bio *cb)
 {
 	struct btrfs_fs_info *fs_info = cb->bbio.inode->root->fs_info;
 	struct bio *bio = &cb->bbio.bio;
+	u64 disk_bytenr = bio->bi_iter.bi_sector << SECTOR_SHIFT;
 	u64 cur_disk_byte = disk_bytenr;
 
-	bio->bi_iter.bi_sector = disk_bytenr >> SECTOR_SHIFT;
 	while (cur_disk_byte < disk_bytenr + cb->compressed_len) {
 		u64 offset = cur_disk_byte - disk_bytenr;
 		unsigned int index = offset >> PAGE_SHIFT;
@@ -331,8 +330,9 @@ void btrfs_submit_compressed_write(struct btrfs_inode *inode, u64 start,
 	cb->writeback = writeback;
 	INIT_WORK(&cb->write_end_work, btrfs_finish_compressed_write_work);
 	cb->nr_pages = nr_pages;
+	cb->bbio.bio.bi_iter.bi_sector = disk_start >> SECTOR_SHIFT;
+	btrfs_add_compressed_bio_pages(cb);
 
-	btrfs_add_compressed_bio_pages(cb, disk_start);
 	btrfs_submit_bio(&cb->bbio, 0);
 
 	if (blkcg_css)
@@ -506,7 +506,6 @@ void btrfs_submit_compressed_read(struct btrfs_bio *bbio, int mirror_num)
 	struct extent_map_tree *em_tree = &inode->extent_tree;
 	struct compressed_bio *cb;
 	unsigned int compressed_len;
-	const u64 disk_bytenr = bbio->bio.bi_iter.bi_sector << SECTOR_SHIFT;
 	u64 file_offset = bbio->file_offset;
 	u64 em_len;
 	u64 em_start;
@@ -560,8 +559,8 @@ void btrfs_submit_compressed_read(struct btrfs_bio *bbio, int mirror_num)
 
 	/* include any pages we added in add_ra-bio_pages */
 	cb->len = bbio->bio.bi_iter.bi_size;
-
-	btrfs_add_compressed_bio_pages(cb, disk_bytenr);
+	cb->bbio.bio.bi_iter.bi_sector = bbio->bio.bi_iter.bi_sector;
+	btrfs_add_compressed_bio_pages(cb);
 
 	if (memstall)
 		psi_memstall_leave(&pflags);
-- 
2.39.2

