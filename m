Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97F5D54CC70
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Jun 2022 17:16:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346340AbiFOPPc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 15 Jun 2022 11:15:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345078AbiFOPP3 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 15 Jun 2022 11:15:29 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD79F3C713
        for <linux-btrfs@vger.kernel.org>; Wed, 15 Jun 2022 08:15:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=3NnSAB/RPpuGhz6i2owQNCMnDkcdwKTiYbOtjgYm9yE=; b=vQ5KCZND4fV4cEIioyxC6IWujl
        KTlRoKsNJ0y51yn9vXGatiwY8jLWYLca34W7cHRTA3PlTiE037+nkVCISxvnRd65ihj8NCNdLRss+
        pyqZlLXWWDtddzG2jQ6I5sBa0FwNmzR9D7GktWu5VHKXg6MrJY+U2j3XPnKNWSi1guWXeEE8PzYLk
        GnHMBM6L6/286trrpyZQmtO556FpEKt41nvZ7EarGqo8a71N3phT01VqRTF++YtxtmCYr0ooY/ApK
        QWJOwwAZkFarudVIsEcceNDXyn8YlWRoBch2IerunZgzMKWYcc3b8LSiBJrEv7/hYWF9NqfHMy6+j
        yVXaTGEw==;
Received: from [2001:4bb8:180:36f6:5ab4:8a8:5e48:3d75] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o1Uju-00F8sO-Qn; Wed, 15 Jun 2022 15:15:27 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     David Sterba <dsterba@suse.com>,
        Josef Bacik <josef@toxicpanda.com>, Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: [PATCH 3/5] btrfs: remove the btrfs_map_bio return value
Date:   Wed, 15 Jun 2022 17:15:13 +0200
Message-Id: <20220615151515.888424-4-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220615151515.888424-1-hch@lst.de>
References: <20220615151515.888424-1-hch@lst.de>
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

Always consume the bio and call the end_io handler on error instead of
returning an error and letting the caller handle it.  This matches
what the block layer submission does and avoids any confusion on who
needs to handle errors.

As this requires touching all the callers, rename the function to
btrfs_submit_bio, which describes the functionality much better.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/compression.c |  8 ++------
 fs/btrfs/disk-io.c     | 21 ++++++++++-----------
 fs/btrfs/inode.c       | 25 ++++++++++---------------
 fs/btrfs/volumes.c     | 13 ++++++++-----
 fs/btrfs/volumes.h     |  4 ++--
 5 files changed, 32 insertions(+), 39 deletions(-)

diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index 63d542961b78a..907fc8a4c092c 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -593,9 +593,7 @@ blk_status_t btrfs_submit_compressed_write(struct btrfs_inode *inode, u64 start,
 			}
 
 			ASSERT(bio->bi_iter.bi_size);
-			ret = btrfs_map_bio(fs_info, bio, 0);
-			if (ret)
-				goto finish_cb;
+			btrfs_submit_bio(fs_info, bio, 0);
 			bio = NULL;
 		}
 		cond_resched();
@@ -931,9 +929,7 @@ void btrfs_submit_compressed_read(struct inode *inode, struct bio *bio,
 			sums += fs_info->csum_size * nr_sectors;
 
 			ASSERT(comp_bio->bi_iter.bi_size);
-			ret = btrfs_map_bio(fs_info, comp_bio, mirror_num);
-			if (ret)
-				goto finish_cb;
+			btrfs_submit_bio(fs_info, comp_bio, mirror_num);
 			comp_bio = NULL;
 		}
 	}
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 800ad3a9c68ed..5df6865428a5c 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -728,7 +728,6 @@ static void run_one_async_done(struct btrfs_work *work)
 {
 	struct async_submit_bio *async;
 	struct inode *inode;
-	blk_status_t ret;
 
 	async = container_of(work, struct  async_submit_bio, work);
 	inode = async->inode;
@@ -746,11 +745,7 @@ static void run_one_async_done(struct btrfs_work *work)
 	 * This changes nothing when cgroups aren't in use.
 	 */
 	async->bio->bi_opf |= REQ_CGROUP_PUNT;
-	ret = btrfs_map_bio(btrfs_sb(inode->i_sb), async->bio, async->mirror_num);
-	if (ret) {
-		async->bio->bi_status = ret;
-		bio_endio(async->bio);
-	}
+	btrfs_submit_bio(btrfs_sb(inode->i_sb), async->bio, async->mirror_num);
 }
 
 static void run_one_async_free(struct btrfs_work *work)
@@ -814,7 +809,7 @@ static blk_status_t btree_submit_bio_start(struct inode *inode, struct bio *bio,
 {
 	/*
 	 * when we're called for a write, we're already in the async
-	 * submission context.  Just jump into btrfs_map_bio
+	 * submission context.  Just jump into btrfs_submit_bio.
 	 */
 	return btree_csum_one_bio(bio);
 }
@@ -839,11 +834,15 @@ void btrfs_submit_metadata_bio(struct inode *inode, struct bio *bio, int mirror_
 	bio->bi_opf |= REQ_META;
 
 	if (btrfs_op(bio) != BTRFS_MAP_WRITE) {
-		ret = btrfs_map_bio(fs_info, bio, mirror_num);
-	} else if (!should_async_write(fs_info, BTRFS_I(inode))) {
+		btrfs_submit_bio(fs_info, bio, mirror_num);
+		return;
+	}
+	if (!should_async_write(fs_info, BTRFS_I(inode))) {
 		ret = btree_csum_one_bio(bio);
-		if (!ret)
-			ret = btrfs_map_bio(fs_info, bio, mirror_num);
+		if (!ret) {
+			btrfs_submit_bio(fs_info, bio, mirror_num);
+			return;
+		}
 	} else {
 		/*
 		 * kthread helpers are used to submit writes so that
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 7a54f964ff378..6f665bf59f620 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -2617,7 +2617,8 @@ void btrfs_submit_data_write_bio(struct inode *inode, struct bio *bio, int mirro
 			goto out;
 		}
 	}
-	ret = btrfs_map_bio(fs_info, bio, mirror_num);
+	btrfs_submit_bio(fs_info, bio, mirror_num);
+	return;
 out:
 	if (ret) {
 		bio->bi_status = ret;
@@ -2645,14 +2646,13 @@ void btrfs_submit_data_read_bio(struct inode *inode, struct bio *bio,
 	 * not, which is why we ignore skip_sum here.
 	 */
 	ret = btrfs_lookup_bio_sums(inode, bio, NULL);
-	if (ret)
-		goto out;
-	ret = btrfs_map_bio(fs_info, bio, mirror_num);
-out:
 	if (ret) {
 		bio->bi_status = ret;
 		bio_endio(bio);
+		return;
 	}
+
+	btrfs_submit_bio(fs_info, bio, mirror_num);
 }
 
 /*
@@ -7863,8 +7863,7 @@ static void submit_dio_repair_bio(struct inode *inode, struct bio *bio,
 	BUG_ON(bio_op(bio) == REQ_OP_WRITE);
 
 	refcount_inc(&dip->refs);
-	if (btrfs_map_bio(fs_info, bio, mirror_num))
-		refcount_dec(&dip->refs);
+	btrfs_submit_bio(fs_info, bio, mirror_num);
 }
 
 static blk_status_t btrfs_check_read_dio_bio(struct btrfs_dio_private *dip,
@@ -7972,7 +7971,8 @@ static inline blk_status_t btrfs_submit_dio_bio(struct bio *bio,
 						      file_offset - dip->file_offset);
 	}
 map:
-	return btrfs_map_bio(fs_info, bio, 0);
+	btrfs_submit_bio(fs_info, bio, 0);
+	return BLK_STS_OK;
 }
 
 static void btrfs_submit_direct(const struct iomap_iter *iter,
@@ -10277,7 +10277,6 @@ static blk_status_t submit_encoded_read_bio(struct btrfs_inode *inode,
 					    struct bio *bio, int mirror_num)
 {
 	struct btrfs_encoded_read_private *priv = bio->bi_private;
-	struct btrfs_bio *bbio = btrfs_bio(bio);
 	struct btrfs_fs_info *fs_info = inode->root->fs_info;
 	blk_status_t ret;
 
@@ -10288,12 +10287,8 @@ static blk_status_t submit_encoded_read_bio(struct btrfs_inode *inode,
 	}
 
 	atomic_inc(&priv->pending);
-	ret = btrfs_map_bio(fs_info, bio, mirror_num);
-	if (ret) {
-		atomic_dec(&priv->pending);
-		btrfs_bio_free_csum(bbio);
-	}
-	return ret;
+	btrfs_submit_bio(fs_info, bio, mirror_num);
+	return BLK_STS_OK;
 }
 
 static blk_status_t btrfs_encoded_read_verify_csum(struct btrfs_bio *bbio)
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index ff777e39d5f4a..739676944e94d 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -6724,8 +6724,8 @@ static void submit_stripe_bio(struct btrfs_io_context *bioc,
 		}
 	}
 	btrfs_debug_in_rcu(fs_info,
-	"btrfs_map_bio: rw %d 0x%x, sector=%llu, dev=%lu (%s id %llu), size=%u",
-		bio_op(bio), bio->bi_opf, bio->bi_iter.bi_sector,
+	"%s: rw %d 0x%x, sector=%llu, dev=%lu (%s id %llu), size=%u",
+		__func__, bio_op(bio), bio->bi_opf, bio->bi_iter.bi_sector,
 		(unsigned long)dev->bdev->bd_dev, rcu_str_deref(dev->name),
 		dev->devid, bio->bi_iter.bi_size);
 
@@ -6735,8 +6735,8 @@ static void submit_stripe_bio(struct btrfs_io_context *bioc,
 	submit_bio(bio);
 }
 
-blk_status_t btrfs_map_bio(struct btrfs_fs_info *fs_info, struct bio *bio,
-			   int mirror_num)
+void btrfs_submit_bio(struct btrfs_fs_info *fs_info, struct bio *bio,
+		      int mirror_num)
 {
 	u64 logical = bio->bi_iter.bi_sector << 9;
 	u64 length = bio->bi_iter.bi_size;
@@ -6781,7 +6781,10 @@ blk_status_t btrfs_map_bio(struct btrfs_fs_info *fs_info, struct bio *bio,
 	}
 out_dec:
 	btrfs_bio_counter_dec(fs_info);
-	return errno_to_blk_status(ret);
+	if (ret) {
+		bio->bi_status = errno_to_blk_status(ret);
+		bio_endio(bio);
+	}
 }
 
 static bool dev_args_match_fs_devices(const struct btrfs_dev_lookup_args *args,
diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index 588367c76c463..c0f5bbba9c6ac 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -573,8 +573,8 @@ int btrfs_read_chunk_tree(struct btrfs_fs_info *fs_info);
 struct btrfs_block_group *btrfs_create_chunk(struct btrfs_trans_handle *trans,
 					    u64 type);
 void btrfs_mapping_tree_free(struct extent_map_tree *tree);
-blk_status_t btrfs_map_bio(struct btrfs_fs_info *fs_info, struct bio *bio,
-			   int mirror_num);
+void btrfs_submit_bio(struct btrfs_fs_info *fs_info, struct bio *bio,
+		      int mirror_num);
 int btrfs_open_devices(struct btrfs_fs_devices *fs_devices,
 		       fmode_t flags, void *holder);
 struct btrfs_device *btrfs_scan_one_device(const char *path,
-- 
2.30.2

