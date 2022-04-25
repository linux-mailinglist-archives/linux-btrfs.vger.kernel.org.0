Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C70A50DAAB
	for <lists+linux-btrfs@lfdr.de>; Mon, 25 Apr 2022 09:56:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233539AbiDYH7Z (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 25 Apr 2022 03:59:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241802AbiDYH5x (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 25 Apr 2022 03:57:53 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F330CF5
        for <linux-btrfs@vger.kernel.org>; Mon, 25 Apr 2022 00:54:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=6HVudaP4Q2ajBb8sgIouhJSTk1+t3X3wBj+DgRvCPWY=; b=iXOYUaPEkzmPM8JI1XEpVdNHD2
        8Z68DWvE+3AxIBlv4X0rqDVyuC+xI6Tyq3oPFJ3r+nxwmeEZXMHVT3AHiPD/W325Dc6bimEQ+5pNX
        YiufiYKguWFl/RgEJ82gJLBtQdmvrK6CgX1hxpy90lNbrqVG8u0/gaK/+bBoKbwyV4vll6tkG/dts
        +CEx9jiPnLfr76BqRhz0kAOc3Xuo5QbRBW1zkm48fR/iH5hYWGdH5h45J67ao2xgwFcKkIWoUbcPv
        caRKoPKMMK73OR0F2dydmqNv0Zy03mmZPGQAjSR8nGlFrI7v2JpsoxMeE1mBkf/odgt0ofKzcn/Pf
        sdc94bnA==;
Received: from 80-254-69-104.dynamic.monzoon.net ([80.254.69.104] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nitYG-008ggK-J2; Mon, 25 Apr 2022 07:54:33 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, Qu Wenruo <wqu@suse.com>
Cc:     Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org
Subject: [PATCH 03/10] btrfs: split btrfs_submit_data_bio
Date:   Mon, 25 Apr 2022 09:54:11 +0200
Message-Id: <20220425075418.2192130-4-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220425075418.2192130-1-hch@lst.de>
References: <20220425075418.2192130-1-hch@lst.de>
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

Split btrfs_submit_data_bio into one helper for reads and one for writes.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/ctree.h     |   6 +-
 fs/btrfs/extent_io.c |  12 ++--
 fs/btrfs/inode.c     | 131 ++++++++++++++++++++-----------------------
 3 files changed, 73 insertions(+), 76 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index ec8487e119949..ab9a0cfed7bb0 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -3250,8 +3250,10 @@ void btrfs_inode_safe_disk_i_size_write(struct btrfs_inode *inode, u64 new_i_siz
 u64 btrfs_file_extent_end(const struct btrfs_path *path);
 
 /* inode.c */
-void btrfs_submit_data_bio(struct inode *inode, struct bio *bio,
-			   int mirror_num, unsigned long bio_flags);
+void btrfs_submit_data_write_bio(struct inode *inode, struct bio *bio,
+		int mirror_num, unsigned long bio_flags);
+void btrfs_submit_data_read_bio(struct inode *inode, struct bio *bio,
+		int mirror_num, unsigned long bio_flags);
 unsigned int btrfs_verify_data_csum(struct btrfs_bio *bbio,
 				    u32 bio_offset, struct page *page,
 				    u64 start, u64 end);
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index f9d6dd310c42b..80b4482c477c6 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -186,11 +186,15 @@ static void submit_one_bio(struct bio *bio, int mirror_num, unsigned long bio_fl
 	/* Caller should ensure the bio has at least some range added */
 	ASSERT(bio->bi_iter.bi_size);
 
-	if (is_data_inode(tree->private_data))
-		btrfs_submit_data_bio(tree->private_data, bio, mirror_num,
+	if (!is_data_inode(tree->private_data))
+		btrfs_submit_metadata_bio(tree->private_data, bio, mirror_num);
+	else if (btrfs_op(bio) == BTRFS_MAP_WRITE)
+		btrfs_submit_data_write_bio(tree->private_data, bio, mirror_num,
 					    bio_flags);
 	else
-		btrfs_submit_metadata_bio(tree->private_data, bio, mirror_num);
+		btrfs_submit_data_read_bio(tree->private_data, bio, mirror_num,
+					    bio_flags);
+
 	/*
 	 * Above submission hooks will handle the error by ending the bio,
 	 * which will do the cleanup properly.  So here we should not return
@@ -2773,7 +2777,7 @@ static blk_status_t submit_data_read_repair(struct inode *inode,
 		ret = btrfs_repair_one_sector(inode, failed_bio,
 				bio_offset + offset,
 				page, pgoff + offset, start + offset,
-				failed_mirror, btrfs_submit_data_bio);
+				failed_mirror, btrfs_submit_data_read_bio);
 		if (!ret) {
 			/*
 			 * We have submitted the read repair, the page release
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index b188f724eff2d..4429d831793d5 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -2552,91 +2552,82 @@ static blk_status_t extract_ordered_extent(struct btrfs_inode *inode,
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
+void btrfs_submit_data_write_bio(struct inode *inode, struct bio *bio,
 			   int mirror_num, unsigned long bio_flags)
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
-		ret = btrfs_bio_wq_end_io(fs_info, bio, metadata);
-		if (ret)
-			goto out;
-
-		if (bio_flags & EXTENT_BIO_COMPRESSED) {
-			/*
-			 * btrfs_submit_compressed_read will handle completing
-			 * the bio if there were any errors, so just return
-			 * here.
-			 */
-			btrfs_submit_compressed_read(inode, bio, mirror_num,
-						     bio_flags);
-			return;
-		} else {
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
+		} else if (btrfs_is_data_reloc_root(bi->root)) {
+			; /* csum items have already been cloned */
+		} else {
+			ret = btrfs_wq_submit_bio(inode, bio,
+					mirror_num, bio_flags, 0,
+					btrfs_submit_bio_start);
+			goto out;
 		}
-		goto mapit;
-	} else if (async && !skip_sum) {
-		/* csum items have already been cloned */
-		if (btrfs_is_data_reloc_root(root))
-			goto mapit;
-		/* we're doing a write, do the async checksumming */
-		ret = btrfs_wq_submit_bio(inode, bio, mirror_num, bio_flags,
-					  0, btrfs_submit_bio_start);
+	}
+	ret = btrfs_map_bio(fs_info, bio, mirror_num);
+out:
+	if (ret) {
+		bio->bi_status = ret;
+		bio_endio(bio);
+	}
+}
+
+void btrfs_submit_data_read_bio(struct inode *inode, struct bio *bio,
+			   int mirror_num, unsigned long bio_flags)
+{
+	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
+	blk_status_t ret;
+
+	ret = btrfs_bio_wq_end_io(fs_info, bio,
+			btrfs_is_free_space_inode(BTRFS_I(inode)) ?
+			BTRFS_WQ_ENDIO_FREE_SPACE : BTRFS_WQ_ENDIO_DATA);
+	if (ret)
 		goto out;
-	} else if (!skip_sum) {
-		ret = btrfs_csum_one_bio(BTRFS_I(inode), bio, (u64)-1, false);
-		if (ret)
-			goto out;
+
+	if (bio_flags & EXTENT_BIO_COMPRESSED) {
+		/*
+		 * btrfs_submit_compressed_read will handle completing the bio
+		 * if there were any errors, so just return here.
+		 */
+		btrfs_submit_compressed_read(inode, bio, mirror_num, bio_flags);
+		return;
 	}
 
-mapit:
+	/*
+	 * Lookup bio sums does extra checks around whether we need to csum or
+	 * not, which is why we ignore skip_sum here.
+	 */
+	ret = btrfs_lookup_bio_sums(inode, bio, NULL);
+	if (ret)
+		goto out;
 	ret = btrfs_map_bio(fs_info, bio, mirror_num);
-
 out:
 	if (ret) {
 		bio->bi_status = ret;
@@ -7909,7 +7900,7 @@ static inline blk_status_t btrfs_submit_dio_bio(struct bio *bio,
 		goto map;
 
 	if (write) {
-		/* check btrfs_submit_data_bio() for async submit rules */
+		/* check btrfs_submit_data_write_bio() for async submit rules */
 		if (async_submit && !atomic_read(&BTRFS_I(inode)->sync_writers))
 			return btrfs_wq_submit_bio(inode, bio, 0, 0,
 					file_offset,
-- 
2.30.2

