Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 454CE332EE
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Jun 2019 16:59:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729349AbfFCO7K (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 3 Jun 2019 10:59:10 -0400
Received: from mx2.suse.de ([195.135.220.15]:32776 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729363AbfFCO7F (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 3 Jun 2019 10:59:05 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id DDE94AFD4;
        Mon,  3 Jun 2019 14:59:02 +0000 (UTC)
From:   Johannes Thumshirn <jthumshirn@suse.de>
To:     David Sterba <dsterba@suse.com>
Cc:     Linux BTRFS Mailinglist <linux-btrfs@vger.kernel.org>,
        Chris Mason <clm@fb.com>, Richard Weinberger <richard@nod.at>,
        David Gstir <david@sigma-star.at>,
        Nikolay Borisov <nborisov@suse.com>,
        Johannes Thumshirn <jthumshirn@suse.de>
Subject: [PATCH v4 11/13] btrfs: directly call into crypto framework for checsumming
Date:   Mon,  3 Jun 2019 16:58:57 +0200
Message-Id: <20190603145859.7176-12-jthumshirn@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20190603145859.7176-1-jthumshirn@suse.de>
References: <20190603145859.7176-1-jthumshirn@suse.de>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Currently btrfs_csum_data() relied on the crc32c() wrapper around the crypto
framework for calculating the CRCs.

As we have our own crypto_shash structure in the fs_info now, we can
directly call into the crypto framework without going trough the wrapper.

This way we can even remove the btrfs_csum_data() and btrfs_csum_final()
wrappers.

Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>

---
Changes to v2:
- Also select CRYPTO in Kconfig
- Add pre dependency on crc32c
Changes to v1:
- merge with 'btrfs: pass in an fs_info to btrfs_csum_{data,final}()'
- Remove btrfs_csum_data() and btrfs_csum_final() alltogether
- don't use LIBCRC32C but CRYPTO_CRC32C in KConfig
---
 fs/btrfs/Kconfig           |  3 ++-
 fs/btrfs/check-integrity.c | 12 +++++++----
 fs/btrfs/compression.c     | 19 +++++++++++------
 fs/btrfs/disk-io.c         | 51 +++++++++++++++++++++++++---------------------
 fs/btrfs/disk-io.h         |  2 --
 fs/btrfs/file-item.c       | 18 ++++++++--------
 fs/btrfs/inode.c           | 24 ++++++++++++++--------
 fs/btrfs/scrub.c           | 36 ++++++++++++++++++++++++--------
 fs/btrfs/super.c           |  1 +
 9 files changed, 105 insertions(+), 61 deletions(-)

diff --git a/fs/btrfs/Kconfig b/fs/btrfs/Kconfig
index 23537bc8c827..212b4a854f2c 100644
--- a/fs/btrfs/Kconfig
+++ b/fs/btrfs/Kconfig
@@ -2,7 +2,8 @@
 
 config BTRFS_FS
 	tristate "Btrfs filesystem support"
-	select LIBCRC32C
+	select CRYPTO
+	select CRYPTO_CRC32C
 	select ZLIB_INFLATE
 	select ZLIB_DEFLATE
 	select LZO_COMPRESS
diff --git a/fs/btrfs/check-integrity.c b/fs/btrfs/check-integrity.c
index 85774e2fa3e5..6adee8fe82e2 100644
--- a/fs/btrfs/check-integrity.c
+++ b/fs/btrfs/check-integrity.c
@@ -83,7 +83,7 @@
 #include <linux/blkdev.h>
 #include <linux/mm.h>
 #include <linux/string.h>
-#include <linux/crc32c.h>
+#include <crypto/hash.h>
 #include "ctree.h"
 #include "disk-io.h"
 #include "transaction.h"
@@ -1710,9 +1710,9 @@ static int btrfsic_test_for_metadata(struct btrfsic_state *state,
 				     char **datav, unsigned int num_pages)
 {
 	struct btrfs_fs_info *fs_info = state->fs_info;
+	SHASH_DESC_ON_STACK(shash, fs_info->csum_shash);
 	struct btrfs_header *h;
 	u8 csum[BTRFS_CSUM_SIZE];
-	u32 crc = ~(u32)0;
 	unsigned int i;
 
 	if (num_pages * PAGE_SIZE < state->metablock_size)
@@ -1723,14 +1723,18 @@ static int btrfsic_test_for_metadata(struct btrfsic_state *state,
 	if (memcmp(h->fsid, fs_info->fs_devices->fsid, BTRFS_FSID_SIZE))
 		return 1;
 
+	shash->tfm = fs_info->csum_shash;
+	shash->flags = 0;
+	crypto_shash_init(shash);
+
 	for (i = 0; i < num_pages; i++) {
 		u8 *data = i ? datav[i] : (datav[i] + BTRFS_CSUM_SIZE);
 		size_t sublen = i ? PAGE_SIZE :
 				    (PAGE_SIZE - BTRFS_CSUM_SIZE);
 
-		crc = btrfs_csum_data(data, crc, sublen);
+		crypto_shash_update(shash, data, sublen);
 	}
-	btrfs_csum_final(crc, csum);
+	crypto_shash_final(shash, csum);
 	if (memcmp(csum, h->csum, state->csum_size))
 		return 1;
 
diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index d5642f3b5c44..e027e58358be 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -17,6 +17,7 @@
 #include <linux/slab.h>
 #include <linux/sched/mm.h>
 #include <linux/log2.h>
+#include <crypto/hash.h>
 #include "ctree.h"
 #include "disk-io.h"
 #include "transaction.h"
@@ -58,29 +59,35 @@ static int check_compressed_csum(struct btrfs_inode *inode,
 				 u64 disk_start)
 {
 	struct btrfs_fs_info *fs_info = inode->root->fs_info;
+	SHASH_DESC_ON_STACK(shash, fs_info->csum_shash);
 	u16 csum_size = btrfs_super_csum_size(fs_info->super_copy);
 	int ret;
 	struct page *page;
 	unsigned long i;
 	char *kaddr;
-	u32 csum;
+	u8 csum[BTRFS_CSUM_SIZE];
 	u8 *cb_sum = cb->sums;
 
 	if (inode->flags & BTRFS_INODE_NODATASUM)
 		return 0;
 
+	shash->tfm = fs_info->csum_shash;
+	shash->flags = 0;
+
 	for (i = 0; i < cb->nr_pages; i++) {
 		page = cb->compressed_pages[i];
-		csum = ~(u32)0;
+
+		crypto_shash_init(shash);
 
 		kaddr = kmap_atomic(page);
-		csum = btrfs_csum_data(kaddr, csum, PAGE_SIZE);
-		btrfs_csum_final(csum, (u8 *)&csum);
+		crypto_shash_update(shash, kaddr, PAGE_SIZE);
+		crypto_shash_final(shash, (u8 *)&csum);
 		kunmap_atomic(kaddr);
 
 		if (memcmp(&csum, cb_sum, csum_size)) {
-			btrfs_print_data_csum_error(inode, disk_start, csum,
-					*(u32 *)cb_sum, cb->mirror_num);
+			btrfs_print_data_csum_error(inode, disk_start,
+						    *(u32 *)csum, *(u32 *)cb_sum,
+						    cb->mirror_num);
 			ret = -EIO;
 			goto fail;
 		}
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 0a69cd133d8f..fc47a682f862 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -250,16 +250,6 @@ struct extent_map *btree_get_extent(struct btrfs_inode *inode,
 	return em;
 }
 
-u32 btrfs_csum_data(const char *data, u32 seed, size_t len)
-{
-	return crc32c(seed, data, len);
-}
-
-void btrfs_csum_final(u32 crc, u8 *result)
-{
-	put_unaligned_le32(~crc, result);
-}
-
 /*
  * Compute the csum of a btree block and store the result to provided buffer.
  *
@@ -267,6 +257,8 @@ void btrfs_csum_final(u32 crc, u8 *result)
  */
 static int csum_tree_block(struct extent_buffer *buf, u8 *result)
 {
+	struct btrfs_fs_info *fs_info = buf->fs_info;
+	SHASH_DESC_ON_STACK(shash, fs_info->csum_shash);
 	unsigned long len;
 	unsigned long cur_len;
 	unsigned long offset = BTRFS_CSUM_SIZE;
@@ -274,9 +266,14 @@ static int csum_tree_block(struct extent_buffer *buf, u8 *result)
 	unsigned long map_start;
 	unsigned long map_len;
 	int err;
-	u32 crc = ~(u32)0;
+
+	shash->tfm = fs_info->csum_shash;
+	shash->flags = 0;
+
+	crypto_shash_init(shash);
 
 	len = buf->len - offset;
+
 	while (len > 0) {
 		/*
 		 * Note: we don't need to check for the err == 1 case here, as
@@ -289,14 +286,13 @@ static int csum_tree_block(struct extent_buffer *buf, u8 *result)
 		if (WARN_ON(err))
 			return err;
 		cur_len = min(len, map_len - (offset - map_start));
-		crc = btrfs_csum_data(kaddr + offset - map_start,
-				      crc, cur_len);
+		crypto_shash_update(shash, kaddr + offset - map_start, cur_len);
 		len -= cur_len;
 		offset += cur_len;
 	}
 	memset(result, 0, BTRFS_CSUM_SIZE);
 
-	btrfs_csum_final(crc, result);
+	crypto_shash_final(shash, result);
 
 	return 0;
 }
@@ -376,17 +372,22 @@ static int btrfs_check_super_csum(struct btrfs_fs_info *fs_info,
 {
 	struct btrfs_super_block *disk_sb =
 		(struct btrfs_super_block *)raw_disk_sb;
-	u32 crc = ~(u32)0;
 	char result[BTRFS_CSUM_SIZE];
+	SHASH_DESC_ON_STACK(shash, fs_info->csum_shash);
+
+	shash->tfm = fs_info->csum_shash;
+	shash->flags = 0;
+
+	crypto_shash_init(shash);
 
 	/*
 	 * The super_block structure does not span the whole
 	 * BTRFS_SUPER_INFO_SIZE range, we expect that the unused space
 	 * is filled with zeros and is included in the checksum.
 	 */
-	crc = btrfs_csum_data(raw_disk_sb + BTRFS_CSUM_SIZE,
-			      crc, BTRFS_SUPER_INFO_SIZE - BTRFS_CSUM_SIZE);
-	btrfs_csum_final(crc, result);
+	crypto_shash_update(shash, raw_disk_sb + BTRFS_CSUM_SIZE,
+			    BTRFS_SUPER_INFO_SIZE - BTRFS_CSUM_SIZE);
+	crypto_shash_final(shash, result);
 
 	if (memcmp(disk_sb->csum, result, btrfs_super_csum_size(disk_sb)))
 		return 1;
@@ -3514,17 +3515,21 @@ struct buffer_head *btrfs_read_dev_super(struct block_device *bdev)
 static int write_dev_supers(struct btrfs_device *device,
 			    struct btrfs_super_block *sb, int max_mirrors)
 {
+	struct btrfs_fs_info *fs_info = device->fs_info;
+	SHASH_DESC_ON_STACK(shash, fs_info->csum_shash);
 	struct buffer_head *bh;
 	int i;
 	int ret;
 	int errors = 0;
-	u32 crc;
 	u64 bytenr;
 	int op_flags;
 
 	if (max_mirrors == 0)
 		max_mirrors = BTRFS_SUPER_MIRROR_MAX;
 
+	shash->tfm = fs_info->csum_shash;
+	shash->flags = 0;
+
 	for (i = 0; i < max_mirrors; i++) {
 		bytenr = btrfs_sb_offset(i);
 		if (bytenr + BTRFS_SUPER_INFO_SIZE >=
@@ -3533,10 +3538,10 @@ static int write_dev_supers(struct btrfs_device *device,
 
 		btrfs_set_super_bytenr(sb, bytenr);
 
-		crc = ~(u32)0;
-		crc = btrfs_csum_data((const char *)sb + BTRFS_CSUM_SIZE, crc,
-				      BTRFS_SUPER_INFO_SIZE - BTRFS_CSUM_SIZE);
-		btrfs_csum_final(crc, sb->csum);
+		crypto_shash_init(shash);
+		crypto_shash_update(shash, (const char *)sb + BTRFS_CSUM_SIZE,
+				    BTRFS_SUPER_INFO_SIZE - BTRFS_CSUM_SIZE);
+		crypto_shash_final(shash, sb->csum);
 
 		/* One reference for us, and we leave it for the caller */
 		bh = __getblk(device->bdev, bytenr / BTRFS_BDEV_BLOCKSIZE,
diff --git a/fs/btrfs/disk-io.h b/fs/btrfs/disk-io.h
index a0161aa1ea0b..e80f7c45a307 100644
--- a/fs/btrfs/disk-io.h
+++ b/fs/btrfs/disk-io.h
@@ -115,8 +115,6 @@ int btrfs_buffer_uptodate(struct extent_buffer *buf, u64 parent_transid,
 			  int atomic);
 int btrfs_read_buffer(struct extent_buffer *buf, u64 parent_transid, int level,
 		      struct btrfs_key *first_key);
-u32 btrfs_csum_data(const char *data, u32 seed, size_t len);
-void btrfs_csum_final(u32 crc, u8 *result);
 blk_status_t btrfs_bio_wq_end_io(struct btrfs_fs_info *info, struct bio *bio,
 			enum btrfs_wq_endio_type metadata);
 blk_status_t btrfs_wq_submit_bio(struct btrfs_fs_info *fs_info, struct bio *bio,
diff --git a/fs/btrfs/file-item.c b/fs/btrfs/file-item.c
index 0bb77392ec08..ba2405b4931b 100644
--- a/fs/btrfs/file-item.c
+++ b/fs/btrfs/file-item.c
@@ -8,6 +8,7 @@
 #include <linux/pagemap.h>
 #include <linux/highmem.h>
 #include <linux/sched/mm.h>
+#include <crypto/hash.h>
 #include "ctree.h"
 #include "disk-io.h"
 #include "transaction.h"
@@ -432,6 +433,7 @@ blk_status_t btrfs_csum_one_bio(struct inode *inode, struct bio *bio,
 		       u64 file_start, int contig)
 {
 	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
+	SHASH_DESC_ON_STACK(shash, fs_info->csum_shash);
 	struct btrfs_ordered_sum *sums;
 	struct btrfs_ordered_extent *ordered = NULL;
 	char *data;
@@ -465,6 +467,9 @@ blk_status_t btrfs_csum_one_bio(struct inode *inode, struct bio *bio,
 	sums->bytenr = (u64)bio->bi_iter.bi_sector << 9;
 	index = 0;
 
+	shash->tfm = fs_info->csum_shash;
+	shash->flags = 0;
+
 	bio_for_each_segment(bvec, bio, iter) {
 		if (!contig)
 			offset = page_offset(bvec.bv_page) + bvec.bv_offset;
@@ -479,7 +484,6 @@ blk_status_t btrfs_csum_one_bio(struct inode *inode, struct bio *bio,
 						 - 1);
 
 		for (i = 0; i < nr_sectors; i++) {
-			u32 tmp;
 			if (offset >= ordered->file_offset + ordered->len ||
 				offset < ordered->file_offset) {
 				unsigned long bytes_left;
@@ -505,15 +509,13 @@ blk_status_t btrfs_csum_one_bio(struct inode *inode, struct bio *bio,
 				index = 0;
 			}
 
-			memset(&sums->sums[index], 0xff, csum_size);
+			crypto_shash_init(shash);
 			data = kmap_atomic(bvec.bv_page);
-			tmp = btrfs_csum_data(data + bvec.bv_offset
-						+ (i * fs_info->sectorsize),
-						*(u32 *)&sums->sums[index],
-						fs_info->sectorsize);
+			crypto_shash_update(shash, data + bvec.bv_offset
+					    + (i * fs_info->sectorsize),
+					    fs_info->sectorsize);
 			kunmap_atomic(data);
-			btrfs_csum_final(tmp,
-					(char *)(sums->sums + index));
+			crypto_shash_final(shash, (char *)(sums->sums + index));
 			index += csum_size;
 			offset += fs_info->sectorsize;
 			this_sum_bytes += fs_info->sectorsize;
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index b6d549c993f6..402c9ea8239d 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -3203,23 +3203,31 @@ static int __readpage_endio_check(struct inode *inode,
 				  int icsum, struct page *page,
 				  int pgoff, u64 start, size_t len)
 {
+	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
+	SHASH_DESC_ON_STACK(shash, fs_info->csum_shash);
 	char *kaddr;
-	u32 csum_expected;
-	u32 csum = ~(u32)0;
+	u16 csum_size = btrfs_super_csum_size(fs_info->super_copy);
+	u8 *csum_expected;
+	u8 csum[BTRFS_CSUM_SIZE];
 
-	csum_expected = *(((u32 *)io_bio->csum) + icsum);
+	csum_expected = ((u8 *)io_bio->csum) + icsum * csum_size;
 
 	kaddr = kmap_atomic(page);
-	csum = btrfs_csum_data(kaddr + pgoff, csum,  len);
-	btrfs_csum_final(csum, (u8 *)&csum);
-	if (csum != csum_expected)
+	shash->tfm = fs_info->csum_shash;
+	shash->flags = 0;
+
+	crypto_shash_init(shash);
+	crypto_shash_update(shash, kaddr + pgoff, len);
+	crypto_shash_final(shash, csum);
+
+	if (memcmp(csum, csum_expected, csum_size))
 		goto zeroit;
 
 	kunmap_atomic(kaddr);
 	return 0;
 zeroit:
-	btrfs_print_data_csum_error(BTRFS_I(inode), start, csum, csum_expected,
-				    io_bio->mirror_num);
+	btrfs_print_data_csum_error(BTRFS_I(inode), start, *(u32 *)csum,
+				    *(u32 *)csum_expected, io_bio->mirror_num);
 	memset(kaddr + pgoff, 1, len);
 	flush_dcache_page(page);
 	kunmap_atomic(kaddr);
diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index 2cf3cf9e9c9b..d97039338952 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -6,6 +6,7 @@
 #include <linux/blkdev.h>
 #include <linux/ratelimit.h>
 #include <linux/sched/mm.h>
+#include <crypto/hash.h>
 #include "ctree.h"
 #include "volumes.h"
 #include "disk-io.h"
@@ -1787,11 +1788,12 @@ static int scrub_checksum(struct scrub_block *sblock)
 static int scrub_checksum_data(struct scrub_block *sblock)
 {
 	struct scrub_ctx *sctx = sblock->sctx;
+	struct btrfs_fs_info *fs_info = sctx->fs_info;
+	SHASH_DESC_ON_STACK(shash, fs_info->csum_shash);
 	u8 csum[BTRFS_CSUM_SIZE];
 	u8 *on_disk_csum;
 	struct page *page;
 	void *buffer;
-	u32 crc = ~(u32)0;
 	u64 len;
 	int index;
 
@@ -1799,6 +1801,11 @@ static int scrub_checksum_data(struct scrub_block *sblock)
 	if (!sblock->pagev[0]->have_csum)
 		return 0;
 
+	shash->tfm = fs_info->csum_shash;
+	shash->flags = 0;
+
+	crypto_shash_init(shash);
+
 	on_disk_csum = sblock->pagev[0]->csum;
 	page = sblock->pagev[0]->page;
 	buffer = kmap_atomic(page);
@@ -1808,7 +1815,7 @@ static int scrub_checksum_data(struct scrub_block *sblock)
 	for (;;) {
 		u64 l = min_t(u64, len, PAGE_SIZE);
 
-		crc = btrfs_csum_data(buffer, crc, l);
+		crypto_shash_update(shash, buffer, l);
 		kunmap_atomic(buffer);
 		len -= l;
 		if (len == 0)
@@ -1820,7 +1827,7 @@ static int scrub_checksum_data(struct scrub_block *sblock)
 		buffer = kmap_atomic(page);
 	}
 
-	btrfs_csum_final(crc, csum);
+	crypto_shash_final(shash, csum);
 	if (memcmp(csum, on_disk_csum, sctx->csum_size))
 		sblock->checksum_error = 1;
 
@@ -1832,16 +1839,21 @@ static int scrub_checksum_tree_block(struct scrub_block *sblock)
 	struct scrub_ctx *sctx = sblock->sctx;
 	struct btrfs_header *h;
 	struct btrfs_fs_info *fs_info = sctx->fs_info;
+	SHASH_DESC_ON_STACK(shash, fs_info->csum_shash);
 	u8 calculated_csum[BTRFS_CSUM_SIZE];
 	u8 on_disk_csum[BTRFS_CSUM_SIZE];
 	struct page *page;
 	void *mapped_buffer;
 	u64 mapped_size;
 	void *p;
-	u32 crc = ~(u32)0;
 	u64 len;
 	int index;
 
+	shash->tfm = fs_info->csum_shash;
+	shash->flags = 0;
+
+	crypto_shash_init(shash);
+
 	BUG_ON(sblock->page_count < 1);
 	page = sblock->pagev[0]->page;
 	mapped_buffer = kmap_atomic(page);
@@ -1875,7 +1887,7 @@ static int scrub_checksum_tree_block(struct scrub_block *sblock)
 	for (;;) {
 		u64 l = min_t(u64, len, mapped_size);
 
-		crc = btrfs_csum_data(p, crc, l);
+		crypto_shash_update(shash, p, l);
 		kunmap_atomic(mapped_buffer);
 		len -= l;
 		if (len == 0)
@@ -1889,7 +1901,7 @@ static int scrub_checksum_tree_block(struct scrub_block *sblock)
 		p = mapped_buffer;
 	}
 
-	btrfs_csum_final(crc, calculated_csum);
+	crypto_shash_final(shash, calculated_csum);
 	if (memcmp(calculated_csum, on_disk_csum, sctx->csum_size))
 		sblock->checksum_error = 1;
 
@@ -1900,18 +1912,24 @@ static int scrub_checksum_super(struct scrub_block *sblock)
 {
 	struct btrfs_super_block *s;
 	struct scrub_ctx *sctx = sblock->sctx;
+	struct btrfs_fs_info *fs_info = sctx->fs_info;
+	SHASH_DESC_ON_STACK(shash, fs_info->csum_shash);
 	u8 calculated_csum[BTRFS_CSUM_SIZE];
 	u8 on_disk_csum[BTRFS_CSUM_SIZE];
 	struct page *page;
 	void *mapped_buffer;
 	u64 mapped_size;
 	void *p;
-	u32 crc = ~(u32)0;
 	int fail_gen = 0;
 	int fail_cor = 0;
 	u64 len;
 	int index;
 
+	shash->tfm = fs_info->csum_shash;
+	shash->flags = 0;
+
+	crypto_shash_init(shash);
+
 	BUG_ON(sblock->page_count < 1);
 	page = sblock->pagev[0]->page;
 	mapped_buffer = kmap_atomic(page);
@@ -1934,7 +1952,7 @@ static int scrub_checksum_super(struct scrub_block *sblock)
 	for (;;) {
 		u64 l = min_t(u64, len, mapped_size);
 
-		crc = btrfs_csum_data(p, crc, l);
+		crypto_shash_update(shash, p, l);
 		kunmap_atomic(mapped_buffer);
 		len -= l;
 		if (len == 0)
@@ -1948,7 +1966,7 @@ static int scrub_checksum_super(struct scrub_block *sblock)
 		p = mapped_buffer;
 	}
 
-	btrfs_csum_final(crc, calculated_csum);
+	crypto_shash_final(shash, calculated_csum);
 	if (memcmp(calculated_csum, on_disk_csum, sctx->csum_size))
 		++fail_cor;
 
diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 2c66d9ea6a3b..f40516ca5963 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -2465,3 +2465,4 @@ late_initcall(init_btrfs_fs);
 module_exit(exit_btrfs_fs)
 
 MODULE_LICENSE("GPL");
+MODULE_SOFTDEP("pre: crc32c");
-- 
2.16.4

