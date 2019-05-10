Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E677619C50
	for <lists+linux-btrfs@lfdr.de>; Fri, 10 May 2019 13:16:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727357AbfEJLP7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 10 May 2019 07:15:59 -0400
Received: from mx2.suse.de ([195.135.220.15]:50586 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727067AbfEJLP5 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 10 May 2019 07:15:57 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 62A9BAF9A
        for <linux-btrfs@vger.kernel.org>; Fri, 10 May 2019 11:15:52 +0000 (UTC)
From:   Johannes Thumshirn <jthumshirn@suse.de>
To:     David Sterba <dsterba@suse.com>
Cc:     Linux BTRFS Mailinglist <linux-btrfs@vger.kernel.org>,
        Johannes Thumshirn <jthumshirn@suse.de>
Subject: [PATCH 13/17] btrfs: pass in an fs_info to btrfs_csum_{data,final}()
Date:   Fri, 10 May 2019 13:15:43 +0200
Message-Id: <20190510111547.15310-14-jthumshirn@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20190510111547.15310-1-jthumshirn@suse.de>
References: <20190510111547.15310-1-jthumshirn@suse.de>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Later patches will need the fs_info to get the checksum function in
btrfs_csum_data() and btrfs_csum_final().

Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>
---
 fs/btrfs/check-integrity.c |  4 ++--
 fs/btrfs/compression.c     |  4 ++--
 fs/btrfs/disk-io.c         | 18 ++++++++++--------
 fs/btrfs/disk-io.h         |  5 +++--
 fs/btrfs/file-item.c       |  4 ++--
 fs/btrfs/inode.c           |  5 +++--
 fs/btrfs/scrub.c           | 12 ++++++------
 7 files changed, 28 insertions(+), 24 deletions(-)

diff --git a/fs/btrfs/check-integrity.c b/fs/btrfs/check-integrity.c
index 85774e2fa3e5..6aad0c3d197f 100644
--- a/fs/btrfs/check-integrity.c
+++ b/fs/btrfs/check-integrity.c
@@ -1728,9 +1728,9 @@ static int btrfsic_test_for_metadata(struct btrfsic_state *state,
 		size_t sublen = i ? PAGE_SIZE :
 				    (PAGE_SIZE - BTRFS_CSUM_SIZE);
 
-		crc = btrfs_csum_data(data, crc, sublen);
+		crc = btrfs_csum_data(fs_info, data, crc, sublen);
 	}
-	btrfs_csum_final(crc, csum);
+	btrfs_csum_final(fs_info, crc, csum);
 	if (memcmp(csum, h->csum, state->csum_size))
 		return 1;
 
diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index d5642f3b5c44..e63bd29e5a27 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -74,8 +74,8 @@ static int check_compressed_csum(struct btrfs_inode *inode,
 		csum = ~(u32)0;
 
 		kaddr = kmap_atomic(page);
-		csum = btrfs_csum_data(kaddr, csum, PAGE_SIZE);
-		btrfs_csum_final(csum, (u8 *)&csum);
+		csum = btrfs_csum_data(fs_info, kaddr, csum, PAGE_SIZE);
+		btrfs_csum_final(fs_info, csum, (u8 *)&csum);
 		kunmap_atomic(kaddr);
 
 		if (memcmp(&csum, cb_sum, csum_size)) {
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index d57adf3eaa85..fb0b06b7b9f6 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -250,12 +250,13 @@ struct extent_map *btree_get_extent(struct btrfs_inode *inode,
 	return em;
 }
 
-u32 btrfs_csum_data(const char *data, u32 seed, size_t len)
+u32 btrfs_csum_data(struct btrfs_fs_info *fs_info, const char *data,
+		    u32 seed, size_t len)
 {
 	return crc32c(seed, data, len);
 }
 
-void btrfs_csum_final(u32 crc, u8 *result)
+void btrfs_csum_final(struct btrfs_fs_info *fs_info, u32 crc, u8 *result)
 {
 	put_unaligned_le32(~crc, result);
 }
@@ -289,14 +290,14 @@ static int csum_tree_block(struct extent_buffer *buf, u8 *result)
 		if (WARN_ON(err))
 			return err;
 		cur_len = min(len, map_len - (offset - map_start));
-		crc = btrfs_csum_data(kaddr + offset - map_start,
+		crc = btrfs_csum_data(buf->fs_info, kaddr + offset - map_start,
 				      crc, cur_len);
 		len -= cur_len;
 		offset += cur_len;
 	}
 	memset(result, 0, BTRFS_CSUM_SIZE);
 
-	btrfs_csum_final(crc, result);
+	btrfs_csum_final(buf->fs_info, crc, result);
 
 	return 0;
 }
@@ -384,9 +385,9 @@ static int btrfs_check_super_csum(struct btrfs_fs_info *fs_info,
 	 * BTRFS_SUPER_INFO_SIZE range, we expect that the unused space
 	 * is filled with zeros and is included in the checksum.
 	 */
-	crc = btrfs_csum_data(raw_disk_sb + BTRFS_CSUM_SIZE,
+	crc = btrfs_csum_data(fs_info, raw_disk_sb + BTRFS_CSUM_SIZE,
 			      crc, BTRFS_SUPER_INFO_SIZE - BTRFS_CSUM_SIZE);
-	btrfs_csum_final(crc, result);
+	btrfs_csum_final(fs_info, crc, result);
 
 	if (memcmp(raw_disk_sb, result, btrfs_super_csum_size(disk_sb)))
 		return 1;
@@ -3534,9 +3535,10 @@ static int write_dev_supers(struct btrfs_device *device,
 		btrfs_set_super_bytenr(sb, bytenr);
 
 		crc = ~(u32)0;
-		crc = btrfs_csum_data((const char *)sb + BTRFS_CSUM_SIZE, crc,
+		crc = btrfs_csum_data(device->fs_info,
+				      (const char *)sb + BTRFS_CSUM_SIZE, crc,
 				      BTRFS_SUPER_INFO_SIZE - BTRFS_CSUM_SIZE);
-		btrfs_csum_final(crc, sb->csum);
+		btrfs_csum_final(device->fs_info, crc, sb->csum);
 
 		/* One reference for us, and we leave it for the caller */
 		bh = __getblk(device->bdev, bytenr / BTRFS_BDEV_BLOCKSIZE,
diff --git a/fs/btrfs/disk-io.h b/fs/btrfs/disk-io.h
index a0161aa1ea0b..434c4d402326 100644
--- a/fs/btrfs/disk-io.h
+++ b/fs/btrfs/disk-io.h
@@ -115,8 +115,9 @@ int btrfs_buffer_uptodate(struct extent_buffer *buf, u64 parent_transid,
 			  int atomic);
 int btrfs_read_buffer(struct extent_buffer *buf, u64 parent_transid, int level,
 		      struct btrfs_key *first_key);
-u32 btrfs_csum_data(const char *data, u32 seed, size_t len);
-void btrfs_csum_final(u32 crc, u8 *result);
+u32 btrfs_csum_data(struct btrfs_fs_info *fs_info, const char *data,
+		    u32 seed, size_t len);
+void btrfs_csum_final(struct btrfs_fs_info *fs_info, u32 crc, u8 *result);
 blk_status_t btrfs_bio_wq_end_io(struct btrfs_fs_info *info, struct bio *bio,
 			enum btrfs_wq_endio_type metadata);
 blk_status_t btrfs_wq_submit_bio(struct btrfs_fs_info *fs_info, struct bio *bio,
diff --git a/fs/btrfs/file-item.c b/fs/btrfs/file-item.c
index c551479afa63..8ff939ebb118 100644
--- a/fs/btrfs/file-item.c
+++ b/fs/btrfs/file-item.c
@@ -503,12 +503,12 @@ blk_status_t btrfs_csum_one_bio(struct inode *inode, struct bio *bio,
 
 			memset(&sums->sums[index], 0xff, csum_size);
 			data = kmap_atomic(bvec.bv_page);
-			tmp = btrfs_csum_data(data + bvec.bv_offset
+			tmp = btrfs_csum_data(fs_info, data + bvec.bv_offset
 						+ (i * fs_info->sectorsize),
 						*(u32 *)&sums->sums[index],
 						fs_info->sectorsize);
 			kunmap_atomic(data);
-			btrfs_csum_final(tmp,
+			btrfs_csum_final(fs_info, tmp,
 					(char *)(sums->sums + index));
 			index += csum_size;
 			offset += fs_info->sectorsize;
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index db19f113d514..578d1d696889 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -3203,6 +3203,7 @@ static int __readpage_endio_check(struct inode *inode,
 				  int icsum, struct page *page,
 				  int pgoff, u64 start, size_t len)
 {
+	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
 	char *kaddr;
 	u32 csum_expected;
 	u32 csum = ~(u32)0;
@@ -3210,8 +3211,8 @@ static int __readpage_endio_check(struct inode *inode,
 	csum_expected = *(((u32 *)io_bio->csum) + icsum);
 
 	kaddr = kmap_atomic(page);
-	csum = btrfs_csum_data(kaddr + pgoff, csum,  len);
-	btrfs_csum_final(csum, (u8 *)&csum);
+	csum = btrfs_csum_data(fs_info, kaddr + pgoff, csum,  len);
+	btrfs_csum_final(fs_info, csum, (u8 *)&csum);
 	if (csum != csum_expected)
 		goto zeroit;
 
diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index 2cf3cf9e9c9b..b8fd4edeee53 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -1808,7 +1808,7 @@ static int scrub_checksum_data(struct scrub_block *sblock)
 	for (;;) {
 		u64 l = min_t(u64, len, PAGE_SIZE);
 
-		crc = btrfs_csum_data(buffer, crc, l);
+		crc = btrfs_csum_data(sctx->fs_info, buffer, crc, l);
 		kunmap_atomic(buffer);
 		len -= l;
 		if (len == 0)
@@ -1820,7 +1820,7 @@ static int scrub_checksum_data(struct scrub_block *sblock)
 		buffer = kmap_atomic(page);
 	}
 
-	btrfs_csum_final(crc, csum);
+	btrfs_csum_final(sctx->fs_info, crc, csum);
 	if (memcmp(csum, on_disk_csum, sctx->csum_size))
 		sblock->checksum_error = 1;
 
@@ -1875,7 +1875,7 @@ static int scrub_checksum_tree_block(struct scrub_block *sblock)
 	for (;;) {
 		u64 l = min_t(u64, len, mapped_size);
 
-		crc = btrfs_csum_data(p, crc, l);
+		crc = btrfs_csum_data(fs_info, p, crc, l);
 		kunmap_atomic(mapped_buffer);
 		len -= l;
 		if (len == 0)
@@ -1889,7 +1889,7 @@ static int scrub_checksum_tree_block(struct scrub_block *sblock)
 		p = mapped_buffer;
 	}
 
-	btrfs_csum_final(crc, calculated_csum);
+	btrfs_csum_final(fs_info, crc, calculated_csum);
 	if (memcmp(calculated_csum, on_disk_csum, sctx->csum_size))
 		sblock->checksum_error = 1;
 
@@ -1934,7 +1934,7 @@ static int scrub_checksum_super(struct scrub_block *sblock)
 	for (;;) {
 		u64 l = min_t(u64, len, mapped_size);
 
-		crc = btrfs_csum_data(p, crc, l);
+		crc = btrfs_csum_data(sctx->fs_info, p, crc, l);
 		kunmap_atomic(mapped_buffer);
 		len -= l;
 		if (len == 0)
@@ -1948,7 +1948,7 @@ static int scrub_checksum_super(struct scrub_block *sblock)
 		p = mapped_buffer;
 	}
 
-	btrfs_csum_final(crc, calculated_csum);
+	btrfs_csum_final(sctx->fs_info, crc, calculated_csum);
 	if (memcmp(calculated_csum, on_disk_csum, sctx->csum_size))
 		++fail_cor;
 
-- 
2.16.4

