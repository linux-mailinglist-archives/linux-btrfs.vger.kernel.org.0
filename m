Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75EBF52A53F
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 May 2022 16:51:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349312AbiEQOvZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 17 May 2022 10:51:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349296AbiEQOuy (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 17 May 2022 10:50:54 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79B8A639A
        for <linux-btrfs@vger.kernel.org>; Tue, 17 May 2022 07:50:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=WQ3L/s5YaYHYWa5p1q06fRK02FlpGwqOTxz4c7eotcE=; b=vzEIq8jxUg0r+lsPBtW301VaUX
        zknG9332KuFQN3GTsyhBdl/HhbOvHa/wl1aAPBW+fa3Hnq2oBwuDrmA/genlGcqjzC7inOTELnNz5
        svOtzW/duud5LhJW3SIKLlGRTU5qYy/qHh6kK3foRRJuoP3LEfgXYVl1SDlWCIILd5zUoU8spK1wS
        Wnb9h6wBNCOVUhAueOdET5T2hlFNBd0bzYj25XoS3vA6lV/I0oAeQjPYj5TCW7FHUoinTYkkN41Yn
        OBBJlgfhAtwhOJ7/ysav8eDydJBuQNECcJmr4V5ZG2TOq2PqzAMS3EdgzLmXQG9yrNXuE2EAJ2a9j
        tjCGu+bA==;
Received: from [89.144.222.138] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nqyX9-00EXA4-J6; Tue, 17 May 2022 14:50:48 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Subject: [PATCH 01/15] btrfs: introduce a pure data checksum checking helper
Date:   Tue, 17 May 2022 16:50:25 +0200
Message-Id: <20220517145039.3202184-2-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220517145039.3202184-1-hch@lst.de>
References: <20220517145039.3202184-1-hch@lst.de>
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

From: Qu Wenruo <wqu@suse.com>

Although we have several data csum verification code, we never have a
function really just to verify checksum for one sector.

Function check_data_csum() do extra work for error reporting, thus it
requires a lot of extra things like file offset, bio_offset etc.

Function btrfs_verify_data_csum() is even worse, it will utizlie page
checked flag, which means it can not be utilized for direct IO pages.

Here we introduce a new helper, btrfs_check_data_sector(), which really
only accept a sector in page, and expected checksum pointer.

We use this function to implement check_data_csum(), and export it for
incoming patch.

Signed-off-by: Qu Wenruo <wqu@suse.com>
[hch: keep passing the csum array as an arguments, as the callers want
      to print it]
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/compression.c | 13 ++++---------
 fs/btrfs/ctree.h       |  2 ++
 fs/btrfs/inode.c       | 40 ++++++++++++++++++++++++++++------------
 3 files changed, 34 insertions(+), 21 deletions(-)

diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index f4564f32f6d93..7212f63dec858 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -147,12 +147,10 @@ static int check_compressed_csum(struct btrfs_inode *inode, struct bio *bio,
 				 u64 disk_start)
 {
 	struct btrfs_fs_info *fs_info = inode->root->fs_info;
-	SHASH_DESC_ON_STACK(shash, fs_info->csum_shash);
 	const u32 csum_size = fs_info->csum_size;
 	const u32 sectorsize = fs_info->sectorsize;
 	struct page *page;
 	unsigned int i;
-	char *kaddr;
 	u8 csum[BTRFS_CSUM_SIZE];
 	struct compressed_bio *cb = bio->bi_private;
 	u8 *cb_sum = cb->sums;
@@ -161,8 +159,6 @@ static int check_compressed_csum(struct btrfs_inode *inode, struct bio *bio,
 	    test_bit(BTRFS_FS_STATE_NO_CSUMS, &fs_info->fs_state))
 		return 0;
 
-	shash->tfm = fs_info->csum_shash;
-
 	for (i = 0; i < cb->nr_pages; i++) {
 		u32 pg_offset;
 		u32 bytes_left = PAGE_SIZE;
@@ -175,12 +171,11 @@ static int check_compressed_csum(struct btrfs_inode *inode, struct bio *bio,
 		/* Hash through the page sector by sector */
 		for (pg_offset = 0; pg_offset < bytes_left;
 		     pg_offset += sectorsize) {
-			kaddr = kmap_atomic(page);
-			crypto_shash_digest(shash, kaddr + pg_offset,
-					    sectorsize, csum);
-			kunmap_atomic(kaddr);
+			int ret;
 
-			if (memcmp(&csum, cb_sum, csum_size) != 0) {
+			ret = btrfs_check_data_sector(fs_info, page, pg_offset,
+						      csum, cb_sum);
+			if (ret) {
 				btrfs_print_data_csum_error(inode, disk_start,
 						csum, cb_sum, cb->mirror_num);
 				if (btrfs_bio(bio)->device)
diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 0e49b1a0c0716..4713d59ed1105 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -3253,6 +3253,8 @@ u64 btrfs_file_extent_end(const struct btrfs_path *path);
 /* inode.c */
 void btrfs_submit_data_bio(struct inode *inode, struct bio *bio,
 			   int mirror_num, enum btrfs_compression_type compress_type);
+int btrfs_check_data_sector(struct btrfs_fs_info *fs_info, struct page *page,
+			    u32 pgoff, u8 *csum, u8 *csum_expected);
 unsigned int btrfs_verify_data_csum(struct btrfs_bio *bbio,
 				    u32 bio_offset, struct page *page,
 				    u64 start, u64 end);
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index da13bd0d10f12..76169e4e3ec36 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -3326,6 +3326,29 @@ void btrfs_writepage_endio_finish_ordered(struct btrfs_inode *inode,
 				       finish_ordered_fn, uptodate);
 }
 
+/*
+ * Verify the checksum for a single sector without any extra action that
+ * depend on the type of I/O.
+ */
+int btrfs_check_data_sector(struct btrfs_fs_info *fs_info, struct page *page,
+			    u32 pgoff, u8 *csum, u8 *csum_expected)
+{
+	SHASH_DESC_ON_STACK(shash, fs_info->csum_shash);
+	char *kaddr;
+
+	ASSERT(pgoff + fs_info->sectorsize <= PAGE_SIZE);
+
+	shash->tfm = fs_info->csum_shash;
+
+	kaddr = kmap_local_page(page) + pgoff;
+	crypto_shash_digest(shash, kaddr, fs_info->sectorsize, csum);
+	kunmap_local(kaddr);
+
+	if (memcmp(csum, csum_expected, fs_info->csum_size))
+		return -EIO;
+	return 0;
+}
+
 /*
  * check_data_csum - verify checksum of one sector of uncompressed data
  * @inode:	inode
@@ -3336,14 +3359,15 @@ void btrfs_writepage_endio_finish_ordered(struct btrfs_inode *inode,
  * @start:	logical offset in the file
  *
  * The length of such check is always one sector size.
+ *
+ * When csum mismatch detected, we will also report the error and fill the
+ * corrupted range with zero. (thus it needs the extra parameters)
  */
 static int check_data_csum(struct inode *inode, struct btrfs_bio *bbio,
 			   u32 bio_offset, struct page *page, u32 pgoff,
 			   u64 start)
 {
 	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
-	SHASH_DESC_ON_STACK(shash, fs_info->csum_shash);
-	char *kaddr;
 	u32 len = fs_info->sectorsize;
 	const u32 csum_size = fs_info->csum_size;
 	unsigned int offset_sectors;
@@ -3355,17 +3379,9 @@ static int check_data_csum(struct inode *inode, struct btrfs_bio *bbio,
 	offset_sectors = bio_offset >> fs_info->sectorsize_bits;
 	csum_expected = ((u8 *)bbio->csum) + offset_sectors * csum_size;
 
-	kaddr = kmap_atomic(page);
-	shash->tfm = fs_info->csum_shash;
-
-	crypto_shash_digest(shash, kaddr + pgoff, len, csum);
-	kunmap_atomic(kaddr);
-
-	if (memcmp(csum, csum_expected, csum_size))
-		goto zeroit;
+	if (!btrfs_check_data_sector(fs_info, page, pgoff, csum, csum_expected))
+		return 0;
 
-	return 0;
-zeroit:
 	btrfs_print_data_csum_error(BTRFS_I(inode), start, csum, csum_expected,
 				    bbio->mirror_num);
 	if (bbio->device)
-- 
2.30.2

