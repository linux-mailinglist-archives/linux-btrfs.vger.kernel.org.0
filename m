Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D5E869195B
	for <lists+linux-btrfs@lfdr.de>; Fri, 10 Feb 2023 08:49:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231472AbjBJHtN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 10 Feb 2023 02:49:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231220AbjBJHtL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 10 Feb 2023 02:49:11 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D740D6BAAB
        for <linux-btrfs@vger.kernel.org>; Thu,  9 Feb 2023 23:49:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=PT3HA2hEUS4JskAoouuwZK9Odw8bQWRImrdPz7A/mdI=; b=k0i9w0PH/rAPb8B6gva/IS377f
        qXKcizvRW38XGf5GWeOV3Zi7MxyXgvUfwI3yqOk2S/exAk97MIhgvS+SvYQNimfiKPW2CL9YmbZK6
        MOH2Nu71pt4egyhTjNPHuZGotGRQ+OZAS3hEzb2NhOqPMI+tP19ruFP4XzgL/gzn/kWvMj3vrtd+C
        yrg0cGWThOVySXhUzy4ow4m2h2cbc/fbidyhICGvoc02QIKeulSkWF4wJn0gCaM5dbrV5siaHXxDw
        ygLDzKSL+4+CMSuOOd47L+TeWZr9RmiosiFFUML7uB6oW3KizagGte2EZwWEVc48Sc0TygU+oWJt+
        sypwlSpg==;
Received: from 213-147-164-133.nat.highway.webapn.at ([213.147.164.133] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pQO9b-004fhQ-No; Fri, 10 Feb 2023 07:49:08 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: [PATCH 5/8] btrfs: factor out a btrfs_add_compressed_bio_pages helper
Date:   Fri, 10 Feb 2023 08:48:38 +0100
Message-Id: <20230210074841.628201-6-hch@lst.de>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230210074841.628201-1-hch@lst.de>
References: <20230210074841.628201-1-hch@lst.de>
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

Factor out a common helper to add the compressed_bio pages to the
bio that is shared by the compressed read and write path.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/compression.c | 104 ++++++++++++++++-------------------------
 1 file changed, 41 insertions(+), 63 deletions(-)

diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index 7560345d02cac8..d68b45fc340f37 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -280,6 +280,42 @@ static void end_compressed_bio_write(struct btrfs_bio *bbio)
 	queue_work(fs_info->compressed_write_workers, &cb->write_end_work);
 }
 
+static void btrfs_add_compressed_bio_pages(struct compressed_bio *cb,
+					   u64 disk_bytenr)
+{
+	struct btrfs_fs_info *fs_info = cb->bbio.inode->root->fs_info;
+	struct bio *bio = &cb->bbio.bio;
+	u64 cur_disk_byte = disk_bytenr;
+
+	bio->bi_iter.bi_sector = disk_bytenr >> SECTOR_SHIFT;
+	while (cur_disk_byte < disk_bytenr + cb->compressed_len) {
+		u64 offset = cur_disk_byte - disk_bytenr;
+		unsigned int index = offset >> PAGE_SHIFT;
+		unsigned int real_size;
+		unsigned int added;
+		struct page *page = cb->compressed_pages[index];
+
+		/*
+		 * We have various limit on the real read size:
+		 * - page boundary
+		 * - compressed length boundary
+		 */
+		real_size = min_t(u64, U32_MAX, PAGE_SIZE - offset_in_page(offset));
+		real_size = min_t(u64, real_size, cb->compressed_len - offset);
+		ASSERT(IS_ALIGNED(real_size, fs_info->sectorsize));
+
+		added = bio_add_page(bio, page, real_size, offset_in_page(offset));
+		/*
+		 * Maximum compressed extent is smaller than bio size limit,
+		 * thus bio_add_page() should always success.
+		 */
+		ASSERT(added == real_size);
+		cur_disk_byte += added;
+	}
+
+	ASSERT(bio->bi_iter.bi_size);
+}
+
 /*
  * worker function to build and submit bios for previously compressed pages.
  * The corresponding pages in the inode should be marked for writeback
@@ -299,9 +335,7 @@ void btrfs_submit_compressed_write(struct btrfs_inode *inode, u64 start,
 				 bool writeback)
 {
 	struct btrfs_fs_info *fs_info = inode->root->fs_info;
-	struct bio *bio;
 	struct compressed_bio *cb;
-	u64 cur_disk_bytenr = disk_start;
 
 	ASSERT(IS_ALIGNED(start, fs_info->sectorsize) &&
 	       IS_ALIGNED(len, fs_info->sectorsize));
@@ -322,37 +356,9 @@ void btrfs_submit_compressed_write(struct btrfs_inode *inode, u64 start,
 	INIT_WORK(&cb->write_end_work, btrfs_finish_compressed_write_work);
 	cb->nr_pages = nr_pages;
 
-	bio = &cb->bbio.bio;
-	bio->bi_iter.bi_sector = disk_start >> SECTOR_SHIFT;
-
-	while (cur_disk_bytenr < disk_start + compressed_len) {
-		u64 offset = cur_disk_bytenr - disk_start;
-		unsigned int index = offset >> PAGE_SHIFT;
-		unsigned int real_size;
-		unsigned int added;
-		struct page *page = compressed_pages[index];
-
-		/*
-		 * We have various limits on the real read size:
-		 * - page boundary
-		 * - compressed length boundary
-		 */
-		real_size = min_t(u64, U32_MAX, PAGE_SIZE - offset_in_page(offset));
-		real_size = min_t(u64, real_size, compressed_len - offset);
-		ASSERT(IS_ALIGNED(real_size, fs_info->sectorsize));
-
-		added = bio_add_page(bio, page, real_size, offset_in_page(offset));
-		/*
-		 * Maximum compressed extent is smaller than bio size limit,
-		 * thus bio_add_page() should always success.
-		 */
-		ASSERT(added == real_size);
-		cur_disk_bytenr += added;
-	}
+	btrfs_add_compressed_bio_pages(cb, disk_start);
+	btrfs_submit_bio(&cb->bbio.bio, 0);
 
-	/* Finished the range. */
-	ASSERT(bio->bi_iter.bi_size);
-	btrfs_submit_bio(bio, 0);
 	if (blkcg_css)
 		kthread_associate_blkcg(NULL);
 }
@@ -524,9 +530,7 @@ void btrfs_submit_compressed_read(struct bio *bio, int mirror_num)
 	struct extent_map_tree *em_tree = &inode->extent_tree;
 	struct compressed_bio *cb;
 	unsigned int compressed_len;
-	struct bio *comp_bio;
 	const u64 disk_bytenr = bio->bi_iter.bi_sector << SECTOR_SHIFT;
-	u64 cur_disk_byte = disk_bytenr;
 	u64 file_offset = btrfs_bio(bio)->file_offset;
 	u64 em_len;
 	u64 em_start;
@@ -550,8 +554,6 @@ void btrfs_submit_compressed_read(struct bio *bio, int mirror_num)
 
 	cb = alloc_compressed_bio(inode, file_offset, REQ_OP_READ,
 				  end_compressed_bio_read);
-	comp_bio = &cb->bbio.bio;
-	comp_bio->bi_iter.bi_sector = cur_disk_byte >> SECTOR_SHIFT;
 
 	cb->start = em->orig_start;
 	em_len = em->len;
@@ -583,42 +585,18 @@ void btrfs_submit_compressed_read(struct bio *bio, int mirror_num)
 	/* include any pages we added in add_ra-bio_pages */
 	cb->len = bio->bi_iter.bi_size;
 
-	while (cur_disk_byte < disk_bytenr + compressed_len) {
-		u64 offset = cur_disk_byte - disk_bytenr;
-		unsigned int index = offset >> PAGE_SHIFT;
-		unsigned int real_size;
-		unsigned int added;
-		struct page *page = cb->compressed_pages[index];
-
-		/*
-		 * We have various limit on the real read size:
-		 * - page boundary
-		 * - compressed length boundary
-		 */
-		real_size = min_t(u64, U32_MAX, PAGE_SIZE - offset_in_page(offset));
-		real_size = min_t(u64, real_size, compressed_len - offset);
-		ASSERT(IS_ALIGNED(real_size, fs_info->sectorsize));
-
-		added = bio_add_page(comp_bio, page, real_size, offset_in_page(offset));
-		/*
-		 * Maximum compressed extent is smaller than bio size limit,
-		 * thus bio_add_page() should always success.
-		 */
-		ASSERT(added == real_size);
-		cur_disk_byte += added;
-	}
+	btrfs_add_compressed_bio_pages(cb, disk_bytenr);
 
 	if (memstall)
 		psi_memstall_leave(&pflags);
 
-	ASSERT(comp_bio->bi_iter.bi_size);
-	btrfs_submit_bio(comp_bio, mirror_num);
+	btrfs_submit_bio(&cb->bbio.bio, mirror_num);
 	return;
 
 out_free_compressed_pages:
 	kfree(cb->compressed_pages);
 out_free_bio:
-	bio_put(comp_bio);
+	bio_put(&cb->bbio.bio);
 out:
 	btrfs_bio_end_io(btrfs_bio(bio), ret);
 }
-- 
2.39.1

