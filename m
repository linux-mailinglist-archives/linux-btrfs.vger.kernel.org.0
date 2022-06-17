Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F18154F4CE
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Jun 2022 12:04:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381503AbiFQKEo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 17 Jun 2022 06:04:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380451AbiFQKEn (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 17 Jun 2022 06:04:43 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E274C69723
        for <linux-btrfs@vger.kernel.org>; Fri, 17 Jun 2022 03:04:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=AMxF7CSR3s8j5b9h6/BpVrXvkY+jFg2ESa7MUhy4IMc=; b=gh1PG8Zxbzw2S3JHbcjhJDPPeM
        xid751/3AjEZsmt1b0W/bsWapeKBxKGtc6/OLuWpAcm4cdiKz2pTXOzl7mJLLihMrgxEg/TpVAli0
        QJfAt2q+Q5QO2hT8TpBa2tfRVfvP2ihpKSmQRN20LgE2nlzRHbd+CClFnp69hbgnQdI/X8PG6gZmw
        Ehcr2EGB2DeHesBMY8okwPojIaPH7fUnCWjf/57Nv4f5R1q7TJLaRiXmamlnqmaY17FP6ejNud7qK
        LMiUIMofOR9rJ5SIW4EmZCMtR2SOFkeWE6ikJijJJ0qYMWjdLSmYFZCA7IZToR/8kC8MexWeL94+1
        qNkJbFog==;
Received: from [2001:4bb8:180:36f6:9c91:42c8:8d10:d7ed] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o28qH-006sme-EU; Fri, 17 Jun 2022 10:04:41 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     David Sterba <dsterba@suse.com>,
        Josef Bacik <josef@toxicpanda.com>, Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: [PATCH 08/10] btrfs: handle allocation failure in btrfs_wq_submit_bio gracefully
Date:   Fri, 17 Jun 2022 12:04:12 +0200
Message-Id: <20220617100414.1159680-9-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220617100414.1159680-1-hch@lst.de>
References: <20220617100414.1159680-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

btrfs_wq_submit_bio is used for writeback under memory pressure.  Instead
of failing the I/O when we can't allocate the async_submit_bio, just
punt back to the synchronous submission path.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/disk-io.c | 37 ++++++++++++++++++-------------------
 fs/btrfs/disk-io.h |  6 +++---
 fs/btrfs/inode.c   | 17 +++++++++--------
 3 files changed, 30 insertions(+), 30 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 5df6865428a5c..eaa643f38783c 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -756,16 +756,16 @@ static void run_one_async_free(struct btrfs_work *work)
 	kfree(async);
 }
 
-blk_status_t btrfs_wq_submit_bio(struct inode *inode, struct bio *bio,
-				 int mirror_num, u64 dio_file_offset,
-				 extent_submit_bio_start_t *submit_bio_start)
+bool btrfs_wq_submit_bio(struct inode *inode, struct bio *bio, int mirror_num,
+			 u64 dio_file_offset,
+			 extent_submit_bio_start_t *submit_bio_start)
 {
 	struct btrfs_fs_info *fs_info = BTRFS_I(inode)->root->fs_info;
 	struct async_submit_bio *async;
 
 	async = kmalloc(sizeof(*async), GFP_NOFS);
 	if (!async)
-		return BLK_STS_RESOURCE;
+		return false;
 
 	async->inode = inode;
 	async->bio = bio;
@@ -783,7 +783,7 @@ blk_status_t btrfs_wq_submit_bio(struct inode *inode, struct bio *bio,
 		btrfs_queue_work(fs_info->hipri_workers, &async->work);
 	else
 		btrfs_queue_work(fs_info->workers, &async->work);
-	return 0;
+	return true;
 }
 
 static blk_status_t btree_csum_one_bio(struct bio *bio)
@@ -837,25 +837,24 @@ void btrfs_submit_metadata_bio(struct inode *inode, struct bio *bio, int mirror_
 		btrfs_submit_bio(fs_info, bio, mirror_num);
 		return;
 	}
-	if (!should_async_write(fs_info, BTRFS_I(inode))) {
-		ret = btree_csum_one_bio(bio);
-		if (!ret) {
-			btrfs_submit_bio(fs_info, bio, mirror_num);
-			return;
-		}
-	} else {
-		/*
-		 * kthread helpers are used to submit writes so that
-		 * checksumming can happen in parallel across all CPUs
-		 */
-		ret = btrfs_wq_submit_bio(inode, bio, mirror_num, 0,
-					  btree_submit_bio_start);
-	}
 
+	/*
+	 * Kthread helpers are used to submit writes so that checksumming can
+	 * happen in parallel across all CPUs
+	 */
+	if (should_async_write(fs_info, BTRFS_I(inode)) &&
+	    btrfs_wq_submit_bio(inode, bio, mirror_num, 0,
+				btree_submit_bio_start))
+		return;
+
+	ret = btree_csum_one_bio(bio);
 	if (ret) {
 		bio->bi_status = ret;
 		bio_endio(bio);
+		return;
 	}
+
+	btrfs_submit_bio(fs_info, bio, mirror_num);
 }
 
 #ifdef CONFIG_MIGRATION
diff --git a/fs/btrfs/disk-io.h b/fs/btrfs/disk-io.h
index 05e779a41a997..8993b428e09ce 100644
--- a/fs/btrfs/disk-io.h
+++ b/fs/btrfs/disk-io.h
@@ -114,9 +114,9 @@ int btrfs_buffer_uptodate(struct extent_buffer *buf, u64 parent_transid,
 			  int atomic);
 int btrfs_read_extent_buffer(struct extent_buffer *buf, u64 parent_transid,
 			     int level, struct btrfs_key *first_key);
-blk_status_t btrfs_wq_submit_bio(struct inode *inode, struct bio *bio,
-				 int mirror_num, u64 dio_file_offset,
-				 extent_submit_bio_start_t *submit_bio_start);
+bool btrfs_wq_submit_bio(struct inode *inode, struct bio *bio, int mirror_num,
+			 u64 dio_file_offset,
+			 extent_submit_bio_start_t *submit_bio_start);
 blk_status_t btrfs_submit_bio_done(void *private_data, struct bio *bio,
 			  int mirror_num);
 int btrfs_alloc_log_tree_node(struct btrfs_trans_handle *trans,
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 5a90fc129aea9..38af980d1cf1f 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -2604,11 +2604,10 @@ void btrfs_submit_data_write_bio(struct inode *inode, struct bio *bio, int mirro
 	if (!(bi->flags & BTRFS_INODE_NODATASUM) &&
 	    !test_bit(BTRFS_FS_STATE_NO_CSUMS, &fs_info->fs_state) &&
 	    !btrfs_is_data_reloc_root(bi->root)) {
-		if (!atomic_read(&bi->sync_writers)) {
-			ret = btrfs_wq_submit_bio(inode, bio, mirror_num, 0,
-						  btrfs_submit_bio_start);
-			goto out;
-		}
+		if (!atomic_read(&bi->sync_writers) &&
+		    btrfs_wq_submit_bio(inode, bio, mirror_num, 0,
+					btrfs_submit_bio_start))
+			return;
 
 		ret = btrfs_csum_one_bio(bi, bio, (u64)-1, false);
 		if (ret)
@@ -7953,9 +7952,11 @@ static inline blk_status_t btrfs_submit_dio_bio(struct bio *bio,
 
 	if (btrfs_op(bio) == BTRFS_MAP_WRITE) {
 		/* Check btrfs_submit_data_write_bio() for async submit rules */
-		if (async_submit && !atomic_read(&BTRFS_I(inode)->sync_writers))
-			return btrfs_wq_submit_bio(inode, bio, 0, file_offset,
-					btrfs_submit_bio_start_direct_io);
+		if (async_submit && !atomic_read(&BTRFS_I(inode)->sync_writers) &&
+		    btrfs_wq_submit_bio(inode, bio, 0, file_offset,
+					btrfs_submit_bio_start_direct_io))
+			return BLK_STS_OK;
+
 		/*
 		 * If we aren't doing async submit, calculate the csum of the
 		 * bio now.
-- 
2.30.2

