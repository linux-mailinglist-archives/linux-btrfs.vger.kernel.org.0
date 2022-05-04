Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C775519F3C
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 May 2022 14:25:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349435AbiEDM3K (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 4 May 2022 08:29:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349414AbiEDM3J (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 4 May 2022 08:29:09 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A2B22662
        for <linux-btrfs@vger.kernel.org>; Wed,  4 May 2022 05:25:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=dLkxgj6Y5ckPF4wYE2PfhCEVEjX2zg8PZnP0AVCTg78=; b=nD1HiR0WShyF+AH+5tUpY02Vlj
        e09sa9soGRC4a0sxNK+tRvvOkY96ztKouEKPPqcdvuOD6n4STXab0AR7l3PDsR5s7mENjaPUivHPu
        apCFE7BDVDz7Z4R0u0BwG3ZV4FRP8VZIShq30Sa/h3gbF9rUuJiukIctz5CEW+JywG77gs1Mg6Yf8
        kQ0hEn+KJWnYpXA8NELmhUF/fa1FA3cU5V5posMGlPoDLYf3bmiJd2tDoM8274rfSF9P9EHunsgKW
        WoUk6/SzMHgzqof0LbwYGJGksVIOM6kU/9df//53n5dJTFkQnnH+sx5s64KqXjkviu09NwvcgQLjT
        gq5aCaEg==;
Received: from [8.34.116.185] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nmE4P-00Ahml-DB; Wed, 04 May 2022 12:25:29 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     David Sterba <dsterba@suse.com>,
        Josef Bacik <josef@toxicpanda.com>, Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: [PATCH 04/10] btrfs: split btrfs_submit_data_bio
Date:   Wed,  4 May 2022 05:25:18 -0700
Message-Id: <20220504122524.558088-5-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220504122524.558088-1-hch@lst.de>
References: <20220504122524.558088-1-hch@lst.de>
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

Split btrfs_submit_data_bio into one helper for reads and one for writes.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/ctree.h     |   6 +-
 fs/btrfs/extent_io.c |  14 +++--
 fs/btrfs/inode.c     | 134 ++++++++++++++++++++-----------------------
 3 files changed, 76 insertions(+), 78 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 6e939bf01dcc3..6f539ddf7467a 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -3251,8 +3251,10 @@ void btrfs_inode_safe_disk_i_size_write(struct btrfs_inode *inode, u64 new_i_siz
 u64 btrfs_file_extent_end(const struct btrfs_path *path);
 
 /* inode.c */
-void btrfs_submit_data_bio(struct inode *inode, struct bio *bio,
-			   int mirror_num, enum btrfs_compression_type compress_type);
+void btrfs_submit_data_write_bio(struct inode *inode, struct bio *bio,
+		int mirror_num);
+void btrfs_submit_data_read_bio(struct inode *inode, struct bio *bio,
+		int mirror_num, enum btrfs_compression_type compress_type);
 unsigned int btrfs_verify_data_csum(struct btrfs_bio *bbio,
 				    u32 bio_offset, struct page *page,
 				    u64 start, u64 end);
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 1b1baeb0d76bc..1394a6f80d285 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -182,17 +182,21 @@ static void submit_one_bio(struct bio *bio, int mirror_num,
 			   enum btrfs_compression_type compress_type)
 {
 	struct extent_io_tree *tree = bio->bi_private;
+	struct inode *inode = tree->private_data;
 
 	bio->bi_private = NULL;
 
 	/* Caller should ensure the bio has at least some range added */
 	ASSERT(bio->bi_iter.bi_size);
 
-	if (is_data_inode(tree->private_data))
-		btrfs_submit_data_bio(tree->private_data, bio, mirror_num,
-					    compress_type);
+	if (!is_data_inode(tree->private_data))
+		btrfs_submit_metadata_bio(inode, bio, mirror_num);
+	else if (btrfs_op(bio) == BTRFS_MAP_WRITE)
+		btrfs_submit_data_write_bio(inode, bio, mirror_num);
 	else
-		btrfs_submit_metadata_bio(tree->private_data, bio, mirror_num);
+		btrfs_submit_data_read_bio(inode, bio, mirror_num,
+					   compress_type);
+
 	/*
 	 * Above submission hooks will handle the error by ending the bio,
 	 * which will do the cleanup properly.  So here we should not return
@@ -2774,7 +2778,7 @@ static blk_status_t submit_data_read_repair(struct inode *inode,
 		ret = btrfs_repair_one_sector(inode, failed_bio,
 				bio_offset + offset,
 				page, pgoff + offset, start + offset,
-				failed_mirror, btrfs_submit_data_bio);
+				failed_mirror, btrfs_submit_data_read_bio);
 		if (!ret) {
 			/*
 			 * We have submitted the read repair, the page release
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index b98f5291e941c..5499b39cab61b 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -2554,90 +2554,82 @@ static blk_status_t extract_ordered_extent(struct btrfs_inode *inode,
 	return errno_to_blk_status(ret);
 }
 
-/*
- * extent_io.c submission hook. This does the right thing for csum calculation
- * on write, or reading the csums from the tree before a read.
- *
- * Rules about async/sync submit,
- * a) read:				sync submit
- *
- * b) write without checksum:		sync submit
- *
- * c) write with checksum:
- *    c-1) if bio is issued by fsync:	sync submit
- *         (sync_writers != 0)
- *
- *    c-2) if root is reloc root:	sync submit
- *         (only in case of buffered IO)
- *
- *    c-3) otherwise:			async submit
- */
-void btrfs_submit_data_bio(struct inode *inode, struct bio *bio,
-			   int mirror_num, enum btrfs_compression_type compress_type)
+void btrfs_submit_data_write_bio(struct inode *inode, struct bio *bio,
+		int mirror_num)
 {
 	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
-	struct btrfs_root *root = BTRFS_I(inode)->root;
-	enum btrfs_wq_endio_type metadata = BTRFS_WQ_ENDIO_DATA;
-	blk_status_t ret = 0;
-	int skip_sum;
-	int async = !atomic_read(&BTRFS_I(inode)->sync_writers);
-
-	skip_sum = (BTRFS_I(inode)->flags & BTRFS_INODE_NODATASUM) ||
-		test_bit(BTRFS_FS_STATE_NO_CSUMS, &fs_info->fs_state);
-
-	if (btrfs_is_free_space_inode(BTRFS_I(inode)))
-		metadata = BTRFS_WQ_ENDIO_FREE_SPACE;
+	struct btrfs_inode *bi = BTRFS_I(inode);
+	blk_status_t ret;
 
 	if (bio_op(bio) == REQ_OP_ZONE_APPEND) {
-		struct page *page = bio_first_bvec_all(bio)->bv_page;
-		loff_t file_offset = page_offset(page);
-
-		ret = extract_ordered_extent(BTRFS_I(inode), bio, file_offset);
+		ret = extract_ordered_extent(bi, bio,
+				page_offset(bio_first_bvec_all(bio)->bv_page));
 		if (ret)
 			goto out;
 	}
 
-	if (btrfs_op(bio) != BTRFS_MAP_WRITE) {
-		if (compress_type != BTRFS_COMPRESS_NONE) {
-			/*
-			 * btrfs_submit_compressed_read will handle completing
-			 * the bio if there were any errors, so just return
-			 * here.
-			 */
-			btrfs_submit_compressed_read(inode, bio, mirror_num);
-			return;
-		} else {
-			ret = btrfs_bio_wq_end_io(fs_info, bio, metadata);
-			if (ret)
-				goto out;
-
-			/*
-			 * Lookup bio sums does extra checks around whether we
-			 * need to csum or not, which is why we ignore skip_sum
-			 * here.
-			 */
-			ret = btrfs_lookup_bio_sums(inode, bio, NULL);
+	/*
+	 * Rules for async/sync submit:
+	 *   a) write without checksum:			sync submit
+	 *   b) write with checksum:
+	 *      b-1) if bio is issued by fsync:		sync submit
+	 *           (sync_writers != 0)
+	 *      b-2) if root is reloc root:		sync submit
+	 *           (only in case of buffered IO)
+	 *      b-3) otherwise:				async submit
+	 */
+	if (!(bi->flags & BTRFS_INODE_NODATASUM) &&
+	    !test_bit(BTRFS_FS_STATE_NO_CSUMS, &fs_info->fs_state)) {
+		if (atomic_read(&bi->sync_writers)) {
+			ret = btrfs_csum_one_bio(bi, bio, (u64)-1, false);
 			if (ret)
 				goto out;
-		}
-		goto mapit;
-	} else if (async && !skip_sum) {
-		/* csum items have already been cloned */
-		if (btrfs_is_data_reloc_root(root))
-			goto mapit;
-		/* we're doing a write, do the async checksumming */
-		ret = btrfs_wq_submit_bio(inode, bio, mirror_num,
-					  0, btrfs_submit_bio_start);
-		goto out;
-	} else if (!skip_sum) {
-		ret = btrfs_csum_one_bio(BTRFS_I(inode), bio, (u64)-1, false);
-		if (ret)
+		} else if (btrfs_is_data_reloc_root(bi->root)) {
+			; /* csum items have already been cloned */
+		} else {
+			ret = btrfs_wq_submit_bio(inode, bio,
+					mirror_num, 0,
+					btrfs_submit_bio_start);
 			goto out;
+		}
 	}
-
-mapit:
 	ret = btrfs_map_bio(fs_info, bio, mirror_num);
+out:
+	if (ret) {
+		bio->bi_status = ret;
+		bio_endio(bio);
+	}
+}
 
+void btrfs_submit_data_read_bio(struct inode *inode, struct bio *bio,
+		int mirror_num, enum btrfs_compression_type compress_type)
+{
+	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
+	blk_status_t ret;
+
+	if (compress_type != BTRFS_COMPRESS_NONE) {
+		/*
+		 * btrfs_submit_compressed_read will handle completing the bio
+		 * if there were any errors, so just return here.
+		 */
+		btrfs_submit_compressed_read(inode, bio, mirror_num);
+		return;
+	}
+
+	ret = btrfs_bio_wq_end_io(fs_info, bio,
+			btrfs_is_free_space_inode(BTRFS_I(inode)) ?
+			BTRFS_WQ_ENDIO_FREE_SPACE : BTRFS_WQ_ENDIO_DATA);
+	if (ret)
+		goto out;
+
+	/*
+	 * Lookup bio sums does extra checks around whether we need to csum or
+	 * not, which is why we ignore skip_sum here.
+	 */
+	ret = btrfs_lookup_bio_sums(inode, bio, NULL);
+	if (ret)
+		goto out;
+	ret = btrfs_map_bio(fs_info, bio, mirror_num);
 out:
 	if (ret) {
 		bio->bi_status = ret;
@@ -7958,7 +7950,7 @@ static inline blk_status_t btrfs_submit_dio_bio(struct bio *bio,
 		goto map;
 
 	if (write) {
-		/* check btrfs_submit_data_bio() for async submit rules */
+		/* check btrfs_submit_data_write_bio() for async submit rules */
 		if (async_submit && !atomic_read(&BTRFS_I(inode)->sync_writers))
 			return btrfs_wq_submit_bio(inode, bio, 0, file_offset,
 					btrfs_submit_bio_start_direct_io);
-- 
2.30.2

