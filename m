Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD7A6514CFA
	for <lists+linux-btrfs@lfdr.de>; Fri, 29 Apr 2022 16:31:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355592AbiD2OeM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 29 Apr 2022 10:34:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377353AbiD2OeG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 29 Apr 2022 10:34:06 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63A56F7A
        for <linux-btrfs@vger.kernel.org>; Fri, 29 Apr 2022 07:30:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=Buu2O8vHrEVJRaffPzjjUkSASTcLKCEYxyQBA40rxes=; b=PQSuQF4uYBYBlYDLz3HLWGagp4
        V7bPGnV70Cs9k9Zjo6syPMm2hsWNxo+te5YV0hIRMRd7NTtZEgDWGmrk6aS+aQ+agOiTD9/dngTuJ
        PJCfPk1E54NMBCG/QxFdGH5g7JL/ug9muSCvr8cepVDl29v7RRNmRyMYQqoAb4qrOkYjn8gC/JXqU
        hFDhIeD4AnCywvBXNDoGx4Dmyi/y/c8Y7NSywhUmHF4cPErRDKqsql1lkzgSwGcdxUInrmXQoAUbM
        QkTVQl4nxUKP/PPj9ORaOcysgreFtPajGDD8Z5L9rMqXA59vloimK3tjBZNjM2eX1o71/4NZlCu2E
        vJC6nAZg==;
Received: from [2607:fb90:27d7:71af:6ca1:91e8:bf19:edd2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nkRds-00BajS-IR; Fri, 29 Apr 2022 14:30:44 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     David Sterba <dsterba@suse.com>,
        Josef Bacik <josef@toxicpanda.com>, Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: [PATCH 03/10] btrfs: split btrfs_submit_data_bio
Date:   Fri, 29 Apr 2022 07:30:33 -0700
Message-Id: <20220429143040.106889-4-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220429143040.106889-1-hch@lst.de>
References: <20220429143040.106889-1-hch@lst.de>
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
 fs/btrfs/inode.c     | 130 ++++++++++++++++++++-----------------------
 3 files changed, 73 insertions(+), 75 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 371f3f6c4ea47..40a6f61559348 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -3252,8 +3252,10 @@ void btrfs_inode_safe_disk_i_size_write(struct btrfs_inode *inode, u64 new_i_siz
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
index 3be52ed6ed196..6476a5d9c09e9 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -2552,90 +2552,82 @@ static blk_status_t extract_ordered_extent(struct btrfs_inode *inode,
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
-			btrfs_submit_compressed_read(inode, bio, mirror_num);
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
+		btrfs_submit_compressed_read(inode, bio, mirror_num);
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
@@ -7909,7 +7901,7 @@ static inline blk_status_t btrfs_submit_dio_bio(struct bio *bio,
 		goto map;
 
 	if (write) {
-		/* check btrfs_submit_data_bio() for async submit rules */
+		/* check btrfs_submit_data_write_bio() for async submit rules */
 		if (async_submit && !atomic_read(&BTRFS_I(inode)->sync_writers))
 			return btrfs_wq_submit_bio(inode, bio, 0, 0,
 					file_offset,
-- 
2.30.2

