Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 058456FB4C0
	for <lists+linux-btrfs@lfdr.de>; Mon,  8 May 2023 18:09:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233552AbjEHQI6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 8 May 2023 12:08:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232674AbjEHQIu (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 8 May 2023 12:08:50 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD3F5658E
        for <linux-btrfs@vger.kernel.org>; Mon,  8 May 2023 09:08:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=3LltamFF6CYYgS49airF0OBv578DCg5OoWjSlYcrg+M=; b=tUaF/26fbL9wtTwVPA9nhlDBdy
        4LF4WG3TjWjxfGiBau5Xcafc0eDSttFeEGoC2GvLMG7JYhjpvj/ZQC3JFlxkJeIdPXHwb3lxLoxyW
        B7BeVSdcCGbJq41y1RcRBIZ8NDSQ4otEzO/mIxrjC/7VYkgaahcl8CuwP+cN46DMsUGinPwd1XiL9
        nSqMFcinZbP8InGEtG8Aik1ZG1DsKVeoVg7bCJ/dh7GmakgxrAdhVcjeXv0DAoGnYfqf7UwfdkGnB
        gvA3agzspabBB8IH4ihbANMe0YoCA8t9hunkEXoU5ksVTBxNeQc2Hws/CmmfYThN1oeVfcIIZhp/a
        +lLLnYfw==;
Received: from [208.98.210.70] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pw3Pr-000w0W-2D;
        Mon, 08 May 2023 16:08:47 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: [PATCH 06/21] btrfs: pass an ordered_extent to btrfs_submit_compressed_write
Date:   Mon,  8 May 2023 09:08:28 -0700
Message-Id: <20230508160843.133013-7-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230508160843.133013-1-hch@lst.de>
References: <20230508160843.133013-1-hch@lst.de>
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

btrfs_submit_compressed_write alwas operates on a single ordered_extent.
Make that explicit by using btrfs_alloc_ordered_extent in the callers
and passing the ordered_exten to btrfs_submit_compressed_write.  This
will help with storing and ordered_extent pointer in the btrfs_bio in
subsequent patches.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/compression.c | 29 +++++++++++++++--------------
 fs/btrfs/compression.h |  5 ++---
 fs/btrfs/inode.c       | 21 ++++++++++-----------
 3 files changed, 27 insertions(+), 28 deletions(-)

diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index 4f85113cbf9f0c..a8791781a5d7d2 100644
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
index 19ab2abeddc088..733987339c03e8 100644
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
index 0bb47782267a2a..8b6d824a46bc1f 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -1167,6 +1167,7 @@ static int submit_one_async_extent(struct btrfs_inode *inode,
 	struct extent_io_tree *io_tree = &inode->io_tree;
 	struct btrfs_root *root = inode->root;
 	struct btrfs_fs_info *fs_info = root->fs_info;
+	struct btrfs_ordered_extent *ordered;
 	struct btrfs_key ins;
 	struct page *locked_page = NULL;
 	struct extent_map *em;
@@ -1228,7 +1229,7 @@ static int submit_one_async_extent(struct btrfs_inode *inode,
 	}
 	free_extent_map(em);
 
-	ret = btrfs_add_ordered_extent(inode, start,		/* file_offset */
+	ordered = btrfs_alloc_ordered_extent(inode, start,	/* file_offset */
 				       async_extent->ram_size,	/* num_bytes */
 				       async_extent->ram_size,	/* ram_bytes */
 				       ins.objectid,		/* disk_bytenr */
@@ -1236,8 +1237,9 @@ static int submit_one_async_extent(struct btrfs_inode *inode,
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
@@ -1246,11 +1248,7 @@ static int submit_one_async_extent(struct btrfs_inode *inode,
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
@@ -10351,6 +10349,7 @@ ssize_t btrfs_do_encoded_write(struct kiocb *iocb, struct iov_iter *from,
 	struct extent_io_tree *io_tree = &inode->io_tree;
 	struct extent_changeset *data_reserved = NULL;
 	struct extent_state *cached_state = NULL;
+	struct btrfs_ordered_extent *ordered;
 	int compression;
 	size_t orig_count;
 	u64 start, end;
@@ -10527,14 +10526,15 @@ ssize_t btrfs_do_encoded_write(struct kiocb *iocb, struct iov_iter *from,
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
@@ -10546,8 +10546,7 @@ ssize_t btrfs_do_encoded_write(struct kiocb *iocb, struct iov_iter *from,
 
 	btrfs_delalloc_release_extents(inode, num_bytes);
 
-	btrfs_submit_compressed_write(inode, start, num_bytes, ins.objectid,
-					  ins.offset, pages, nr_pages, 0, false);
+	btrfs_submit_compressed_write(ordered, pages, nr_pages, 0, false);
 	ret = orig_count;
 	goto out;
 
-- 
2.39.2

