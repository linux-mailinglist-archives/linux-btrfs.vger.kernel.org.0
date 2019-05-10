Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7EF4A19C4B
	for <lists+linux-btrfs@lfdr.de>; Fri, 10 May 2019 13:16:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727333AbfEJLP4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 10 May 2019 07:15:56 -0400
Received: from mx2.suse.de ([195.135.220.15]:50564 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727321AbfEJLPz (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 10 May 2019 07:15:55 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 79CECAFA4
        for <linux-btrfs@vger.kernel.org>; Fri, 10 May 2019 11:15:52 +0000 (UTC)
From:   Johannes Thumshirn <jthumshirn@suse.de>
To:     David Sterba <dsterba@suse.com>
Cc:     Linux BTRFS Mailinglist <linux-btrfs@vger.kernel.org>,
        Johannes Thumshirn <jthumshirn@suse.de>
Subject: [PATCH 15/17] btrfs: remove assumption about csum type form btrfs_csum_{data,final}()
Date:   Fri, 10 May 2019 13:15:45 +0200
Message-Id: <20190510111547.15310-16-jthumshirn@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20190510111547.15310-1-jthumshirn@suse.de>
References: <20190510111547.15310-1-jthumshirn@suse.de>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

btrfs_csum_data() and btrfs_csum_final() still have assumptions on the
checksums' type and size. Remove it so we can plumb in more types.

Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>
---
 fs/btrfs/check-integrity.c |  6 ++---
 fs/btrfs/compression.c     | 13 ++++++-----
 fs/btrfs/disk-io.c         | 58 +++++++++++++++++++++++++---------------------
 fs/btrfs/disk-io.h         |  6 ++---
 fs/btrfs/file-item.c       | 13 +++++------
 fs/btrfs/inode.c           | 18 +++++++-------
 fs/btrfs/scrub.c           | 20 +++++++++-------
 7 files changed, 72 insertions(+), 62 deletions(-)

diff --git a/fs/btrfs/check-integrity.c b/fs/btrfs/check-integrity.c
index 6aad0c3d197f..54c8a549b505 100644
--- a/fs/btrfs/check-integrity.c
+++ b/fs/btrfs/check-integrity.c
@@ -1712,7 +1712,6 @@ static int btrfsic_test_for_metadata(struct btrfsic_state *state,
 	struct btrfs_fs_info *fs_info = state->fs_info;
 	struct btrfs_header *h;
 	u8 csum[BTRFS_CSUM_SIZE];
-	u32 crc = ~(u32)0;
 	unsigned int i;
 
 	if (num_pages * PAGE_SIZE < state->metablock_size)
@@ -1723,14 +1722,15 @@ static int btrfsic_test_for_metadata(struct btrfsic_state *state,
 	if (memcmp(h->fsid, fs_info->fs_devices->fsid, BTRFS_FSID_SIZE))
 		return 1;
 
+	memset(csum, 0xff, btrfs_super_csum_size(fs_info->super_copy));
 	for (i = 0; i < num_pages; i++) {
 		u8 *data = i ? datav[i] : (datav[i] + BTRFS_CSUM_SIZE);
 		size_t sublen = i ? PAGE_SIZE :
 				    (PAGE_SIZE - BTRFS_CSUM_SIZE);
 
-		crc = btrfs_csum_data(fs_info, data, crc, sublen);
+		btrfs_csum_data(fs_info, data, csum, sublen);
 	}
-	btrfs_csum_final(fs_info, crc, csum);
+	btrfs_csum_final(fs_info, csum, csum);
 	if (memcmp(csum, h->csum, state->csum_size))
 		return 1;
 
diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index e63bd29e5a27..bf36cdb641ef 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -63,7 +63,7 @@ static int check_compressed_csum(struct btrfs_inode *inode,
 	struct page *page;
 	unsigned long i;
 	char *kaddr;
-	u32 csum;
+	u8 csum[BTRFS_CSUM_SIZE];
 	u8 *cb_sum = cb->sums;
 
 	if (inode->flags & BTRFS_INODE_NODATASUM)
@@ -71,16 +71,17 @@ static int check_compressed_csum(struct btrfs_inode *inode,
 
 	for (i = 0; i < cb->nr_pages; i++) {
 		page = cb->compressed_pages[i];
-		csum = ~(u32)0;
+		memset(csum, 0xff, csum_size);
 
 		kaddr = kmap_atomic(page);
-		csum = btrfs_csum_data(fs_info, kaddr, csum, PAGE_SIZE);
-		btrfs_csum_final(fs_info, csum, (u8 *)&csum);
+		btrfs_csum_data(fs_info, kaddr, csum, PAGE_SIZE);
+		btrfs_csum_final(fs_info, csum, csum);
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
index 0c9ac7b45ce8..2be8f05be1e6 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -250,36 +250,35 @@ struct extent_map *btree_get_extent(struct btrfs_inode *inode,
 	return em;
 }
 
-u32 btrfs_csum_data(struct btrfs_fs_info *fs_info, const char *data,
-		    u32 seed, size_t len)
+void btrfs_csum_data(struct btrfs_fs_info *fs_info, const char *data,
+		    u8 *seed, size_t len)
 {
 	SHASH_DESC_ON_STACK(shash, fs_info->csum_shash);
-	u32 *ctx = (u32 *)shash_desc_ctx(shash);
-	u32 retval;
+	u8 *ctx = shash_desc_ctx(shash);
+	u16 csum_size = btrfs_super_csum_size(fs_info->super_copy);
 	int err;
 
 	shash->tfm = fs_info->csum_shash;
 	shash->flags = 0;
-	*ctx = seed;
+	memcpy(ctx, seed, csum_size);
 
 	err = crypto_shash_update(shash, data, len);
 	ASSERT(err);
 
-	retval = *ctx;
 	barrier_data(ctx);
-
-	return retval;
+	memcpy(seed, ctx, csum_size);
 }
 
-void btrfs_csum_final(struct btrfs_fs_info *fs_info, u32 crc, u8 *result)
+void btrfs_csum_final(struct btrfs_fs_info *fs_info, u8 *seed, u8 *result)
 {
 	SHASH_DESC_ON_STACK(shash, fs_info->csum_shash);
-	u32 *ctx = (u32 *)shash_desc_ctx(shash);
+	u8 *ctx = shash_desc_ctx(shash);
+	u16 csum_size = btrfs_super_csum_size(fs_info->super_copy);
 	int err;
 
 	shash->tfm = fs_info->csum_shash;
 	shash->flags = 0;
-	*ctx = crc;
+	memcpy(ctx, seed, csum_size);
 
 	err = crypto_shash_final(shash, result);
 	ASSERT(err);
@@ -292,6 +291,7 @@ void btrfs_csum_final(struct btrfs_fs_info *fs_info, u32 crc, u8 *result)
  */
 static int csum_tree_block(struct extent_buffer *buf, u8 *result)
 {
+	struct btrfs_fs_info *fs_info = buf->fs_info;
 	unsigned long len;
 	unsigned long cur_len;
 	unsigned long offset = BTRFS_CSUM_SIZE;
@@ -299,9 +299,12 @@ static int csum_tree_block(struct extent_buffer *buf, u8 *result)
 	unsigned long map_start;
 	unsigned long map_len;
 	int err;
-	u32 crc = ~(u32)0;
+	u8 csum[BTRFS_CSUM_SIZE];
 
 	len = buf->len - offset;
+
+	memset(csum, 0xff, btrfs_super_csum_size(fs_info->super_copy));
+
 	while (len > 0) {
 		/*
 		 * Note: we don't need to check for the err == 1 case here, as
@@ -314,14 +317,14 @@ static int csum_tree_block(struct extent_buffer *buf, u8 *result)
 		if (WARN_ON(err))
 			return err;
 		cur_len = min(len, map_len - (offset - map_start));
-		crc = btrfs_csum_data(buf->fs_info, kaddr + offset - map_start,
-				      crc, cur_len);
+		btrfs_csum_data(fs_info, kaddr + offset - map_start, csum,
+				cur_len);
 		len -= cur_len;
 		offset += cur_len;
 	}
 	memset(result, 0, BTRFS_CSUM_SIZE);
 
-	btrfs_csum_final(buf->fs_info, crc, result);
+	btrfs_csum_final(fs_info, csum, result);
 
 	return 0;
 }
@@ -401,19 +404,22 @@ static int btrfs_check_super_csum(struct btrfs_fs_info *fs_info,
 {
 	struct btrfs_super_block *disk_sb =
 		(struct btrfs_super_block *)raw_disk_sb;
-	u32 crc = ~(u32)0;
+	u8 csum[BTRFS_CSUM_SIZE];
 	char result[BTRFS_CSUM_SIZE];
+	u16 csum_size = btrfs_super_csum_size(disk_sb);
+
+	memset(csum, 0xff, csum_size);
 
 	/*
 	 * The super_block structure does not span the whole
 	 * BTRFS_SUPER_INFO_SIZE range, we expect that the unused space
 	 * is filled with zeros and is included in the checksum.
 	 */
-	crc = btrfs_csum_data(fs_info, raw_disk_sb + BTRFS_CSUM_SIZE,
-			      crc, BTRFS_SUPER_INFO_SIZE - BTRFS_CSUM_SIZE);
-	btrfs_csum_final(fs_info, crc, result);
+	btrfs_csum_data(fs_info, raw_disk_sb + BTRFS_CSUM_SIZE, csum,
+			BTRFS_SUPER_INFO_SIZE - BTRFS_CSUM_SIZE);
+	btrfs_csum_final(fs_info, csum, result);
 
-	if (memcmp(raw_disk_sb, result, btrfs_super_csum_size(disk_sb)))
+	if (memcmp(raw_disk_sb, result, csum_size))
 		return 1;
 
 	return 0;
@@ -3539,11 +3545,12 @@ struct buffer_head *btrfs_read_dev_super(struct block_device *bdev)
 static int write_dev_supers(struct btrfs_device *device,
 			    struct btrfs_super_block *sb, int max_mirrors)
 {
+	struct btrfs_fs_info *fs_info = device->fs_info;
 	struct buffer_head *bh;
 	int i;
 	int ret;
 	int errors = 0;
-	u32 crc;
+	u8 csum[BTRFS_CSUM_SIZE];
 	u64 bytenr;
 	int op_flags;
 
@@ -3558,11 +3565,10 @@ static int write_dev_supers(struct btrfs_device *device,
 
 		btrfs_set_super_bytenr(sb, bytenr);
 
-		crc = ~(u32)0;
-		crc = btrfs_csum_data(device->fs_info,
-				      (const char *)sb + BTRFS_CSUM_SIZE, crc,
-				      BTRFS_SUPER_INFO_SIZE - BTRFS_CSUM_SIZE);
-		btrfs_csum_final(device->fs_info, crc, sb->csum);
+		memset(csum, 0xff, btrfs_super_csum_size(fs_info->super_copy));
+		btrfs_csum_data(fs_info, (const char *)sb + BTRFS_CSUM_SIZE,
+				csum, BTRFS_SUPER_INFO_SIZE - BTRFS_CSUM_SIZE);
+		btrfs_csum_final(fs_info, csum, sb->csum);
 
 		/* One reference for us, and we leave it for the caller */
 		bh = __getblk(device->bdev, bytenr / BTRFS_BDEV_BLOCKSIZE,
diff --git a/fs/btrfs/disk-io.h b/fs/btrfs/disk-io.h
index 434c4d402326..6eeb267faa11 100644
--- a/fs/btrfs/disk-io.h
+++ b/fs/btrfs/disk-io.h
@@ -115,9 +115,9 @@ int btrfs_buffer_uptodate(struct extent_buffer *buf, u64 parent_transid,
 			  int atomic);
 int btrfs_read_buffer(struct extent_buffer *buf, u64 parent_transid, int level,
 		      struct btrfs_key *first_key);
-u32 btrfs_csum_data(struct btrfs_fs_info *fs_info, const char *data,
-		    u32 seed, size_t len);
-void btrfs_csum_final(struct btrfs_fs_info *fs_info, u32 crc, u8 *result);
+void btrfs_csum_data(struct btrfs_fs_info *fs_info, const char *data,
+		     u8 *seed, size_t len);
+void btrfs_csum_final(struct btrfs_fs_info *fs_info, u8 *csum, u8 *result);
 blk_status_t btrfs_bio_wq_end_io(struct btrfs_fs_info *info, struct bio *bio,
 			enum btrfs_wq_endio_type metadata);
 blk_status_t btrfs_wq_submit_bio(struct btrfs_fs_info *fs_info, struct bio *bio,
diff --git a/fs/btrfs/file-item.c b/fs/btrfs/file-item.c
index 8ff939ebb118..11b7ffa589b3 100644
--- a/fs/btrfs/file-item.c
+++ b/fs/btrfs/file-item.c
@@ -475,7 +475,6 @@ blk_status_t btrfs_csum_one_bio(struct inode *inode, struct bio *bio,
 						 - 1);
 
 		for (i = 0; i < nr_sectors; i++) {
-			u32 tmp;
 			if (offset >= ordered->file_offset + ordered->len ||
 				offset < ordered->file_offset) {
 				unsigned long bytes_left;
@@ -503,13 +502,13 @@ blk_status_t btrfs_csum_one_bio(struct inode *inode, struct bio *bio,
 
 			memset(&sums->sums[index], 0xff, csum_size);
 			data = kmap_atomic(bvec.bv_page);
-			tmp = btrfs_csum_data(fs_info, data + bvec.bv_offset
-						+ (i * fs_info->sectorsize),
-						*(u32 *)&sums->sums[index],
-						fs_info->sectorsize);
+			btrfs_csum_data(fs_info, data + bvec.bv_offset
+					+ (i * fs_info->sectorsize),
+					&sums->sums[index],
+					fs_info->sectorsize);
 			kunmap_atomic(data);
-			btrfs_csum_final(fs_info, tmp,
-					(char *)(sums->sums + index));
+			btrfs_csum_final(fs_info, &sums->sums[index],
+					 &sums->sums[index]);
 			index += csum_size;
 			offset += fs_info->sectorsize;
 			this_sum_bytes += fs_info->sectorsize;
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 578d1d696889..5dda8796ab4c 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -3205,22 +3205,24 @@ static int __readpage_endio_check(struct inode *inode,
 {
 	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
 	char *kaddr;
-	u32 csum_expected;
-	u32 csum = ~(u32)0;
+	u16 csum_size = btrfs_super_csum_size(fs_info->super_copy);
+	u8 *csum_expected;
+	u8 csum[BTRFS_CSUM_SIZE];
 
-	csum_expected = *(((u32 *)io_bio->csum) + icsum);
+	csum_expected = ((u8 *)io_bio->csum) + icsum * csum_size;
 
+	memset(csum, 0xff, csum_size);
 	kaddr = kmap_atomic(page);
-	csum = btrfs_csum_data(fs_info, kaddr + pgoff, csum,  len);
-	btrfs_csum_final(fs_info, csum, (u8 *)&csum);
-	if (csum != csum_expected)
+	btrfs_csum_data(fs_info, kaddr + pgoff, csum,  len);
+	btrfs_csum_final(fs_info, csum, csum);
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
index b8fd4edeee53..f218682940e7 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -1791,7 +1791,6 @@ static int scrub_checksum_data(struct scrub_block *sblock)
 	u8 *on_disk_csum;
 	struct page *page;
 	void *buffer;
-	u32 crc = ~(u32)0;
 	u64 len;
 	int index;
 
@@ -1803,12 +1802,13 @@ static int scrub_checksum_data(struct scrub_block *sblock)
 	page = sblock->pagev[0]->page;
 	buffer = kmap_atomic(page);
 
+	memset(csum, 0xff, btrfs_super_csum_size(sctx->fs_info->super_copy));
 	len = sctx->fs_info->sectorsize;
 	index = 0;
 	for (;;) {
 		u64 l = min_t(u64, len, PAGE_SIZE);
 
-		crc = btrfs_csum_data(sctx->fs_info, buffer, crc, l);
+		btrfs_csum_data(sctx->fs_info, buffer, csum, l);
 		kunmap_atomic(buffer);
 		len -= l;
 		if (len == 0)
@@ -1820,7 +1820,7 @@ static int scrub_checksum_data(struct scrub_block *sblock)
 		buffer = kmap_atomic(page);
 	}
 
-	btrfs_csum_final(sctx->fs_info, crc, csum);
+	btrfs_csum_final(sctx->fs_info, csum, csum);
 	if (memcmp(csum, on_disk_csum, sctx->csum_size))
 		sblock->checksum_error = 1;
 
@@ -1838,7 +1838,7 @@ static int scrub_checksum_tree_block(struct scrub_block *sblock)
 	void *mapped_buffer;
 	u64 mapped_size;
 	void *p;
-	u32 crc = ~(u32)0;
+	u8 csum[BTRFS_CSUM_SIZE];
 	u64 len;
 	int index;
 
@@ -1872,10 +1872,11 @@ static int scrub_checksum_tree_block(struct scrub_block *sblock)
 	mapped_size = PAGE_SIZE - BTRFS_CSUM_SIZE;
 	p = ((u8 *)mapped_buffer) + BTRFS_CSUM_SIZE;
 	index = 0;
+	memset(csum, 0xff, btrfs_super_csum_size(fs_info->super_copy));
 	for (;;) {
 		u64 l = min_t(u64, len, mapped_size);
 
-		crc = btrfs_csum_data(fs_info, p, crc, l);
+		btrfs_csum_data(fs_info, p, csum, l);
 		kunmap_atomic(mapped_buffer);
 		len -= l;
 		if (len == 0)
@@ -1889,7 +1890,7 @@ static int scrub_checksum_tree_block(struct scrub_block *sblock)
 		p = mapped_buffer;
 	}
 
-	btrfs_csum_final(fs_info, crc, calculated_csum);
+	btrfs_csum_final(fs_info, csum, calculated_csum);
 	if (memcmp(calculated_csum, on_disk_csum, sctx->csum_size))
 		sblock->checksum_error = 1;
 
@@ -1906,7 +1907,7 @@ static int scrub_checksum_super(struct scrub_block *sblock)
 	void *mapped_buffer;
 	u64 mapped_size;
 	void *p;
-	u32 crc = ~(u32)0;
+	u8 csum[BTRFS_CSUM_SIZE];
 	int fail_gen = 0;
 	int fail_cor = 0;
 	u64 len;
@@ -1931,10 +1932,11 @@ static int scrub_checksum_super(struct scrub_block *sblock)
 	mapped_size = PAGE_SIZE - BTRFS_CSUM_SIZE;
 	p = ((u8 *)mapped_buffer) + BTRFS_CSUM_SIZE;
 	index = 0;
+	memset(csum, 0xff, btrfs_super_csum_size(s));
 	for (;;) {
 		u64 l = min_t(u64, len, mapped_size);
 
-		crc = btrfs_csum_data(sctx->fs_info, p, crc, l);
+		btrfs_csum_data(sctx->fs_info, p, csum, l);
 		kunmap_atomic(mapped_buffer);
 		len -= l;
 		if (len == 0)
@@ -1948,7 +1950,7 @@ static int scrub_checksum_super(struct scrub_block *sblock)
 		p = mapped_buffer;
 	}
 
-	btrfs_csum_final(sctx->fs_info, crc, calculated_csum);
+	btrfs_csum_final(sctx->fs_info, csum, calculated_csum);
 	if (memcmp(calculated_csum, on_disk_csum, sctx->csum_size))
 		++fail_cor;
 
-- 
2.16.4

