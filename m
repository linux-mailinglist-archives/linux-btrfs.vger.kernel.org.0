Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 01E1025F44
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 May 2019 10:19:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728662AbfEVITS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 22 May 2019 04:19:18 -0400
Received: from mx2.suse.de ([195.135.220.15]:60468 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728491AbfEVITR (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 22 May 2019 04:19:17 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id B63D0AF49;
        Wed, 22 May 2019 08:19:15 +0000 (UTC)
From:   Johannes Thumshirn <jthumshirn@suse.de>
To:     David Sterba <dsterba@suse.com>
Cc:     Linux BTRFS Mailinglist <linux-btrfs@vger.kernel.org>,
        Chris Mason <clm@fb.com>, Richard Weinberger <richard@nod.at>,
        David Gstir <david@sigma-star.at>,
        Nikolay Borisov <nborisov@suse.com>,
        Johannes Thumshirn <jthumshirn@suse.de>
Subject: [PATCH v3 05/13] btrfs: dont assume compressed_bio sums to be 4 bytes
Date:   Wed, 22 May 2019 10:19:02 +0200
Message-Id: <20190522081910.7689-6-jthumshirn@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20190522081910.7689-1-jthumshirn@suse.de>
References: <20190522081910.7689-1-jthumshirn@suse.de>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

BTRFS has the implicit assumption that a checksum in compressed_bio is 4
bytes. While this is true for CRC32C, it is not for any other checksum.

Change the data type to be a byte array and adjust loop index calculation
accordingly.

Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>
---
Changes to v2:
- Remove stray hunk in btrfs_find_ordered_sum() (Nik)
---
 fs/btrfs/compression.c | 27 +++++++++++++++++----------
 fs/btrfs/compression.h |  2 +-
 fs/btrfs/file-item.c   |  2 +-
 3 files changed, 19 insertions(+), 12 deletions(-)

diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index 98d8c2ed367f..d5642f3b5c44 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -57,12 +57,14 @@ static int check_compressed_csum(struct btrfs_inode *inode,
 				 struct compressed_bio *cb,
 				 u64 disk_start)
 {
+	struct btrfs_fs_info *fs_info = inode->root->fs_info;
+	u16 csum_size = btrfs_super_csum_size(fs_info->super_copy);
 	int ret;
 	struct page *page;
 	unsigned long i;
 	char *kaddr;
 	u32 csum;
-	u32 *cb_sum = &cb->sums;
+	u8 *cb_sum = cb->sums;
 
 	if (inode->flags & BTRFS_INODE_NODATASUM)
 		return 0;
@@ -76,13 +78,13 @@ static int check_compressed_csum(struct btrfs_inode *inode,
 		btrfs_csum_final(csum, (u8 *)&csum);
 		kunmap_atomic(kaddr);
 
-		if (csum != *cb_sum) {
+		if (memcmp(&csum, cb_sum, csum_size)) {
 			btrfs_print_data_csum_error(inode, disk_start, csum,
-					*cb_sum, cb->mirror_num);
+					*(u32 *)cb_sum, cb->mirror_num);
 			ret = -EIO;
 			goto fail;
 		}
-		cb_sum++;
+		cb_sum += csum_size;
 
 	}
 	ret = 0;
@@ -537,7 +539,8 @@ blk_status_t btrfs_submit_compressed_read(struct inode *inode, struct bio *bio,
 	struct extent_map *em;
 	blk_status_t ret = BLK_STS_RESOURCE;
 	int faili = 0;
-	u32 *sums;
+	u16 csum_size = btrfs_super_csum_size(fs_info->super_copy);
+	u8 *sums;
 
 	em_tree = &BTRFS_I(inode)->extent_tree;
 
@@ -559,7 +562,7 @@ blk_status_t btrfs_submit_compressed_read(struct inode *inode, struct bio *bio,
 	cb->errors = 0;
 	cb->inode = inode;
 	cb->mirror_num = mirror_num;
-	sums = &cb->sums;
+	sums = cb->sums;
 
 	cb->start = em->orig_start;
 	em_len = em->len;
@@ -618,6 +621,8 @@ blk_status_t btrfs_submit_compressed_read(struct inode *inode, struct bio *bio,
 		page->mapping = NULL;
 		if (submit || bio_add_page(comp_bio, page, PAGE_SIZE, 0) <
 		    PAGE_SIZE) {
+			unsigned int nr_sectors;
+
 			ret = btrfs_bio_wq_end_io(fs_info, comp_bio,
 						  BTRFS_WQ_ENDIO_DATA);
 			BUG_ON(ret); /* -ENOMEM */
@@ -632,11 +637,13 @@ blk_status_t btrfs_submit_compressed_read(struct inode *inode, struct bio *bio,
 
 			if (!(BTRFS_I(inode)->flags & BTRFS_INODE_NODATASUM)) {
 				ret = btrfs_lookup_bio_sums(inode, comp_bio,
-							    (u8 *)sums);
+							    sums);
 				BUG_ON(ret); /* -ENOMEM */
 			}
-			sums += DIV_ROUND_UP(comp_bio->bi_iter.bi_size,
-					     fs_info->sectorsize);
+
+			nr_sectors = DIV_ROUND_UP(comp_bio->bi_iter.bi_size,
+						  fs_info->sectorsize);
+			sums += csum_size * nr_sectors;
 
 			ret = btrfs_map_bio(fs_info, comp_bio, mirror_num, 0);
 			if (ret) {
@@ -658,7 +665,7 @@ blk_status_t btrfs_submit_compressed_read(struct inode *inode, struct bio *bio,
 	BUG_ON(ret); /* -ENOMEM */
 
 	if (!(BTRFS_I(inode)->flags & BTRFS_INODE_NODATASUM)) {
-		ret = btrfs_lookup_bio_sums(inode, comp_bio, (u8 *) sums);
+		ret = btrfs_lookup_bio_sums(inode, comp_bio, sums);
 		BUG_ON(ret); /* -ENOMEM */
 	}
 
diff --git a/fs/btrfs/compression.h b/fs/btrfs/compression.h
index 9976fe0f7526..191e5f4e3523 100644
--- a/fs/btrfs/compression.h
+++ b/fs/btrfs/compression.h
@@ -61,7 +61,7 @@ struct compressed_bio {
 	 * the start of a variable length array of checksums only
 	 * used by reads
 	 */
-	u32 sums;
+	u8 sums[];
 };
 
 static inline unsigned int btrfs_compress_type(unsigned int type_level)
diff --git a/fs/btrfs/file-item.c b/fs/btrfs/file-item.c
index 39fc8da701fe..0bb77392ec08 100644
--- a/fs/btrfs/file-item.c
+++ b/fs/btrfs/file-item.c
@@ -186,7 +186,7 @@ static blk_status_t __btrfs_lookup_bio_sums(struct inode *inode, struct bio *bio
 		}
 		csum = btrfs_bio->csum;
 	} else {
-		csum = (u8 *)dst;
+		csum = dst;
 	}
 
 	if (bio->bi_iter.bi_size > PAGE_SIZE * 8)
-- 
2.16.4

