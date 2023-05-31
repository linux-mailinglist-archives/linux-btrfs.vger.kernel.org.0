Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67B8A717923
	for <lists+linux-btrfs@lfdr.de>; Wed, 31 May 2023 09:56:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234948AbjEaH4P (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 31 May 2023 03:56:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234991AbjEaHzs (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 31 May 2023 03:55:48 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4983E1BC6
        for <linux-btrfs@vger.kernel.org>; Wed, 31 May 2023 00:54:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=A12LOV4dJhYw6aiE8o1jsFW3fniMBqI+1KCsWyP+EDs=; b=emuXdV0Po7d0j1UrcfGd7AzlLu
        xJnreR72IV2xaGYYGXBO/Qs5tP41AiAFwagv1EdLictqk/TPNG/3xCF2m79BT69xThIjlS9u7J095
        4bSKxMAUw6Iw27ElL472bBGmpvDXG3m21oe9C4NjlUJwXvsyTlx+4te8rk09l534sDmolwTbuZfkd
        Peud128WITo61Av9NYLreotoa97te2fF5OwEcx/0PRAvfUV/AWbiUQOeJSSa5P6qZsEgohZeQDQ+T
        9SyYXX8MchyLskfkiLGpURg/3+VH6Vpz4+o1vWstssemzvAvynIGY1YCiqcvwSJgWCzi7JVEVqHqi
        sInyC8OQ==;
Received: from [2001:4bb8:182:6d06:f5c3:53d7:b5aa:b6a7] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1q4Gf7-00GWsA-1M;
        Wed, 31 May 2023 07:54:30 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH 05/17] btrfs: pass an ordered_extent to btrfs_submit_compressed_write
Date:   Wed, 31 May 2023 09:53:58 +0200
Message-Id: <20230531075410.480499-6-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230531075410.480499-1-hch@lst.de>
References: <20230531075410.480499-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

btrfs_submit_compressed_write alwas operates on a single ordered_extent.
Make that explicit by using btrfs_alloc_ordered_extent in the callers
and passing the ordered_exten to btrfs_submit_compressed_write.  This
will help with storing and ordered_extent pointer in the btrfs_bio in
subsequent patches.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/compression.c | 29 +++++++++++++++--------------
 fs/btrfs/compression.h |  5 ++---
 fs/btrfs/inode.c       | 21 ++++++++++-----------
 3 files changed, 27 insertions(+), 28 deletions(-)

diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index fcba772cdc736f..e187ff417370c7 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -281,33 +281,34 @@ static void btrfs_add_compressed_bio_pages(struct compressed_bio *cb)
  * This also checksums the file bytes and gets things ready for
  * the end io hooks.
  */
-void btrfs_submit_compressed_write(struct btrfs_inode *inode, u64 start,
-				 unsigned int len, u64 disk_start,
-				 unsigned int compressed_len,
-				 struct page **compressed_pages,
-				 unsigned int nr_pages,
-				 blk_opf_t write_flags,
-				 bool writeback)
+void btrfs_submit_compressed_write(struct btrfs_ordered_extent *ordered,
+				   struct page **compressed_pages,
+				   unsigned int nr_pages,
+				   blk_opf_t write_flags,
+				   bool writeback)
 {
+	struct btrfs_inode *inode = BTRFS_I(ordered->inode);
 	struct btrfs_fs_info *fs_info = inode->root->fs_info;
 	struct compressed_bio *cb;
 
-	ASSERT(IS_ALIGNED(start, fs_info->sectorsize) &&
-	       IS_ALIGNED(len, fs_info->sectorsize));
+	ASSERT(IS_ALIGNED(ordered->file_offset, fs_info->sectorsize));
+	ASSERT(IS_ALIGNED(ordered->num_bytes, fs_info->sectorsize));
 
-	cb = alloc_compressed_bio(inode, start, REQ_OP_WRITE | write_flags,
+	cb = alloc_compressed_bio(inode, ordered->file_offset,
+				  REQ_OP_WRITE | write_flags,
 				  end_compressed_bio_write);
-	cb->start = start;
-	cb->len = len;
+	cb->start = ordered->file_offset;
+	cb->len = ordered->num_bytes;
 	cb->compressed_pages = compressed_pages;
-	cb->compressed_len = compressed_len;
+	cb->compressed_len = ordered->disk_num_bytes;
 	cb->writeback = writeback;
 	INIT_WORK(&cb->write_end_work, btrfs_finish_compressed_write_work);
 	cb->nr_pages = nr_pages;
-	cb->bbio.bio.bi_iter.bi_sector = disk_start >> SECTOR_SHIFT;
+	cb->bbio.bio.bi_iter.bi_sector = ordered->disk_bytenr >> SECTOR_SHIFT;
 	btrfs_add_compressed_bio_pages(cb);
 
 	btrfs_submit_bio(&cb->bbio, 0);
+	btrfs_put_ordered_extent(ordered);
 }
 
 /*
diff --git a/fs/btrfs/compression.h b/fs/btrfs/compression.h
index b462ab106f4308..03bb9d143fa75d 100644
--- a/fs/btrfs/compression.h
+++ b/fs/btrfs/compression.h
@@ -10,6 +10,7 @@
 #include "bio.h"
 
 struct btrfs_inode;
+struct btrfs_ordered_extent;
 
 /*
  * We want to make sure that amount of RAM required to uncompress an extent is
@@ -86,9 +87,7 @@ int btrfs_decompress(int type, const u8 *data_in, struct page *dest_page,
 int btrfs_decompress_buf2page(const char *buf, u32 buf_len,
 			      struct compressed_bio *cb, u32 decompressed);
 
-void btrfs_submit_compressed_write(struct btrfs_inode *inode, u64 start,
-				  unsigned int len, u64 disk_start,
-				  unsigned int compressed_len,
+void btrfs_submit_compressed_write(struct btrfs_ordered_extent *ordered,
 				  struct page **compressed_pages,
 				  unsigned int nr_pages,
 				  blk_opf_t write_flags,
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 1d2eef14f193cf..e3f74c90280767 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -1175,6 +1175,7 @@ static int submit_one_async_extent(struct btrfs_inode *inode,
 	struct extent_io_tree *io_tree = &inode->io_tree;
 	struct btrfs_root *root = inode->root;
 	struct btrfs_fs_info *fs_info = root->fs_info;
+	struct btrfs_ordered_extent *ordered;
 	struct btrfs_key ins;
 	struct page *locked_page = NULL;
 	struct extent_map *em;
@@ -1236,7 +1237,7 @@ static int submit_one_async_extent(struct btrfs_inode *inode,
 	}
 	free_extent_map(em);
 
-	ret = btrfs_add_ordered_extent(inode, start,		/* file_offset */
+	ordered = btrfs_alloc_ordered_extent(inode, start,	/* file_offset */
 				       async_extent->ram_size,	/* num_bytes */
 				       async_extent->ram_size,	/* ram_bytes */
 				       ins.objectid,		/* disk_bytenr */
@@ -1244,8 +1245,9 @@ static int submit_one_async_extent(struct btrfs_inode *inode,
 				       0,			/* offset */
 				       1 << BTRFS_ORDERED_COMPRESSED,
 				       async_extent->compress_type);
-	if (ret) {
+	if (IS_ERR(ordered)) {
 		btrfs_drop_extent_map_range(inode, start, end, false);
+		ret = PTR_ERR(ordered);
 		goto out_free_reserve;
 	}
 	btrfs_dec_block_group_reservations(fs_info, ins.objectid);
@@ -1254,11 +1256,7 @@ static int submit_one_async_extent(struct btrfs_inode *inode,
 	extent_clear_unlock_delalloc(inode, start, end,
 			NULL, EXTENT_LOCKED | EXTENT_DELALLOC,
 			PAGE_UNLOCK | PAGE_START_WRITEBACK);
-
-	btrfs_submit_compressed_write(inode, start,	/* file_offset */
-			    async_extent->ram_size,	/* num_bytes */
-			    ins.objectid,		/* disk_bytenr */
-			    ins.offset,			/* compressed_len */
+	btrfs_submit_compressed_write(ordered,
 			    async_extent->pages,	/* compressed_pages */
 			    async_extent->nr_pages,
 			    async_chunk->write_flags, true);
@@ -10256,6 +10254,7 @@ ssize_t btrfs_do_encoded_write(struct kiocb *iocb, struct iov_iter *from,
 	struct extent_io_tree *io_tree = &inode->io_tree;
 	struct extent_changeset *data_reserved = NULL;
 	struct extent_state *cached_state = NULL;
+	struct btrfs_ordered_extent *ordered;
 	int compression;
 	size_t orig_count;
 	u64 start, end;
@@ -10432,14 +10431,15 @@ ssize_t btrfs_do_encoded_write(struct kiocb *iocb, struct iov_iter *from,
 	}
 	free_extent_map(em);
 
-	ret = btrfs_add_ordered_extent(inode, start, num_bytes, ram_bytes,
+	ordered = btrfs_alloc_ordered_extent(inode, start, num_bytes, ram_bytes,
 				       ins.objectid, ins.offset,
 				       encoded->unencoded_offset,
 				       (1 << BTRFS_ORDERED_ENCODED) |
 				       (1 << BTRFS_ORDERED_COMPRESSED),
 				       compression);
-	if (ret) {
+	if (IS_ERR(ordered)) {
 		btrfs_drop_extent_map_range(inode, start, end, false);
+		ret = PTR_ERR(ordered);
 		goto out_free_reserved;
 	}
 	btrfs_dec_block_group_reservations(fs_info, ins.objectid);
@@ -10451,8 +10451,7 @@ ssize_t btrfs_do_encoded_write(struct kiocb *iocb, struct iov_iter *from,
 
 	btrfs_delalloc_release_extents(inode, num_bytes);
 
-	btrfs_submit_compressed_write(inode, start, num_bytes, ins.objectid,
-					  ins.offset, pages, nr_pages, 0, false);
+	btrfs_submit_compressed_write(ordered, pages, nr_pages, 0, false);
 	ret = orig_count;
 	goto out;
 
-- 
2.39.2

