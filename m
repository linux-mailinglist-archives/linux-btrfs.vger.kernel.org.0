Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CC3D535BC8
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 May 2022 10:44:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349799AbiE0Inh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 27 May 2022 04:43:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346268AbiE0Ind (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 27 May 2022 04:43:33 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA1192AC53
        for <linux-btrfs@vger.kernel.org>; Fri, 27 May 2022 01:43:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=UhD5RxF+3M0A6imDKah3y64o23a8aOPSlCwhwsAxI6E=; b=JtDnxTGnwGJw6UJxEm8H6WWDvB
        H6E/JG+X5IVnCioPpxbQCyEnyHX4ukiX9aEUUGLdpiU3V24oZuambBIXOyNE8hCi9e9fvK+gMt7g5
        Sey8Ndae0sbinkkdgjR1ORYpvdxi/m/ayzzV572jbvYXwdQ716WyRH1la4uioEPQ310PB5taiHv2Q
        w2bFi/NpnfjiSSbI40mpRFQcizIgkPxN1m2+0TSYJsSFZq82boAi13pqo967TRAHIcdWXCeBIwJ3q
        s5RfmmTCaWuYs47NbUwsMUXNhiPFaon4h+igzeQQ9C/mDz1FARoay6blvJwqsWaNZXem8OfJtkVUo
        VNocV6wg==;
Received: from [2001:4bb8:18c:7298:b5ab:7d49:c6be:2011] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nuVZB-00H3Vf-VI; Fri, 27 May 2022 08:43:30 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Subject: [PATCH 3/9] btrfs: factor out a btrfs_map_repair_bio helper
Date:   Fri, 27 May 2022 10:43:14 +0200
Message-Id: <20220527084320.2130831-4-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220527084320.2130831-1-hch@lst.de>
References: <20220527084320.2130831-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Factor out the guts of repair_io_failure so that we have a new helper
to submit synchronous I/O for repair.  Unlike repair_io_failure itself
this helper also handles reads.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/extent_io.c | 82 ++++++--------------------------------------
 fs/btrfs/volumes.c   | 69 +++++++++++++++++++++++++++++++++++++
 fs/btrfs/volumes.h   |  2 ++
 3 files changed, 81 insertions(+), 72 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 54a0ec62c7b0d..27775031ed2d4 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -2308,27 +2308,13 @@ int free_io_failure(struct extent_io_tree *failure_tree,
 	return err;
 }
 
-/*
- * this bypasses the standard btrfs submit functions deliberately, as
- * the standard behavior is to write all copies in a raid setup. here we only
- * want to write the one bad copy. so we do the mapping for ourselves and issue
- * submit_bio directly.
- * to avoid any synchronization issues, wait for the data after writing, which
- * actually prevents the read that triggered the error from finishing.
- * currently, there can be no more than two copies of every data bit. thus,
- * exactly one rewrite is required.
- */
 static int repair_io_failure(struct btrfs_fs_info *fs_info, u64 ino, u64 start,
 			     u64 length, u64 logical, struct page *page,
 			     unsigned int pg_offset, int mirror_num)
 {
-	struct btrfs_device *dev;
 	struct bio_vec bvec;
 	struct bio bio;
-	u64 map_length = 0;
-	u64 sector;
-	struct btrfs_io_context *bioc = NULL;
-	int ret = 0;
+	int ret;
 
 	ASSERT(!(fs_info->sb->s_flags & SB_RDONLY));
 	BUG_ON(!mirror_num);
@@ -2336,67 +2322,19 @@ static int repair_io_failure(struct btrfs_fs_info *fs_info, u64 ino, u64 start,
 	if (btrfs_repair_one_zone(fs_info, logical))
 		return 0;
 
-	map_length = length;
-
-	/*
-	 * Avoid races with device replace and make sure our bioc has devices
-	 * associated to its stripes that don't go away while we are doing the
-	 * read repair operation.
-	 */
-	btrfs_bio_counter_inc_blocked(fs_info);
-	if (btrfs_is_parity_mirror(fs_info, logical, length)) {
-		/*
-		 * Note that we don't use BTRFS_MAP_WRITE because it's supposed
-		 * to update all raid stripes, but here we just want to correct
-		 * bad stripe, thus BTRFS_MAP_READ is abused to only get the bad
-		 * stripe's dev and sector.
-		 */
-		ret = btrfs_map_block(fs_info, BTRFS_MAP_READ, logical,
-				      &map_length, &bioc, 0);
-		if (ret)
-			goto out_counter_dec;
-		ASSERT(bioc->mirror_num == 1);
-	} else {
-		ret = btrfs_map_block(fs_info, BTRFS_MAP_WRITE, logical,
-				      &map_length, &bioc, mirror_num);
-		if (ret)
-			goto out_counter_dec;
-		BUG_ON(mirror_num != bioc->mirror_num);
-	}
-
-	sector = bioc->stripes[bioc->mirror_num - 1].physical >> 9;
-	dev = bioc->stripes[bioc->mirror_num - 1].dev;
-	btrfs_put_bioc(bioc);
-
-	if (!dev || !dev->bdev ||
-	    !test_bit(BTRFS_DEV_STATE_WRITEABLE, &dev->dev_state)) {
-		ret = -EIO;
-		goto out_counter_dec;
-	}
-
-	bio_init(&bio, dev->bdev, &bvec, 1, REQ_OP_WRITE | REQ_SYNC);
-	bio.bi_iter.bi_sector = sector;
+	bio_init(&bio, NULL, &bvec, 1, REQ_OP_WRITE | REQ_SYNC);
+	bio.bi_iter.bi_sector = logical >> 9;
 	__bio_add_page(&bio, page, length, pg_offset);
+	ret = btrfs_map_repair_bio(fs_info, &bio, mirror_num);
+	bio_uninit(&bio);
 
-	btrfsic_check_bio(&bio);
-	ret = submit_bio_wait(&bio);
-	if (ret) {
-		/* try to remap that extent elsewhere? */
-		btrfs_dev_stat_inc_and_print(dev, BTRFS_DEV_STAT_WRITE_ERRS);
-		goto out_bio_uninit;
-	}
+	if (ret)
+		return ret;
 
 	btrfs_info_rl_in_rcu(fs_info,
-		"read error corrected: ino %llu off %llu (dev %s sector %llu)",
-				  ino, start,
-				  rcu_str_deref(dev->name), sector);
-	ret = 0;
-
-out_bio_uninit:
-	bio_uninit(&bio);
-out_counter_dec:
-	btrfs_bio_counter_dec(fs_info);
-	return ret;
+		"read error corrected: ino %llu off %llu (logical %llu)",
+			  ino, start, logical);
+	return 0;
 }
 
 int btrfs_repair_eb_io_failure(const struct extent_buffer *eb, int mirror_num)
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 1954a3e1c93a9..515f5fccf3d17 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -6805,6 +6805,75 @@ blk_status_t btrfs_map_bio(struct btrfs_fs_info *fs_info, struct bio *bio,
 	return errno_to_blk_status(ret);
 }
 
+/*
+ * This bypasses the standard btrfs submit functions deliberately, as the
+ * standard behavior is to write all copies in a raid setup. Here we only want
+ * to write the one bad copy.  Sso do the mapping ourselves and submit directly
+ * and synchronously.
+ */
+int btrfs_map_repair_bio(struct btrfs_fs_info *fs_info, struct bio *bio,
+		int mirror_num)
+{
+	u64 logical = bio->bi_iter.bi_sector << 9;
+	u64 map_length = bio->bi_iter.bi_size;
+	struct btrfs_io_context *bioc = NULL;
+	struct btrfs_device *dev;
+	u64 sector;
+	int ret;
+
+	ASSERT(mirror_num);
+	ASSERT(bio_op(bio) == REQ_OP_WRITE);
+
+	/*
+	 * Avoid races with device replace and make sure our bioc has devices
+	 * associated to its stripes that don't go away while we are doing the
+	 * read repair operation.
+	 */
+	btrfs_bio_counter_inc_blocked(fs_info);
+	if (btrfs_is_parity_mirror(fs_info, logical, map_length)) {
+		/*
+		 * Note that we don't use BTRFS_MAP_WRITE because it's supposed
+		 * to update all raid stripes, but here we just want to correct
+		 * bad stripe, thus BTRFS_MAP_READ is abused to only get the bad
+		 * stripe's dev and sector.
+		 */
+		ret = btrfs_map_block(fs_info, BTRFS_MAP_READ, logical,
+				&map_length, &bioc, 0);
+		if (ret)
+			goto out_counter_dec;
+		ASSERT(bioc->mirror_num == 1);
+	} else {
+		ret = btrfs_map_block(fs_info, BTRFS_MAP_WRITE, logical,
+				&map_length, &bioc, mirror_num);
+		if (ret)
+			goto out_counter_dec;
+		BUG_ON(mirror_num != bioc->mirror_num);
+	}
+
+	sector = bioc->stripes[bioc->mirror_num - 1].physical >> 9;
+	dev = bioc->stripes[bioc->mirror_num - 1].dev;
+	btrfs_put_bioc(bioc);
+
+	if (!dev || !dev->bdev ||
+	    !test_bit(BTRFS_DEV_STATE_WRITEABLE, &dev->dev_state)) {
+		ret = -EIO;
+		goto out_counter_dec;
+	}
+
+	bio_set_dev(bio, dev->bdev);
+	bio->bi_iter.bi_sector = sector;
+
+	btrfsic_check_bio(bio);
+	submit_bio_wait(bio);
+
+	ret = blk_status_to_errno(bio->bi_status);
+	if (ret)
+		btrfs_dev_stat_inc_and_print(dev, BTRFS_DEV_STAT_WRITE_ERRS);
+out_counter_dec:
+	btrfs_bio_counter_dec(fs_info);
+	return ret;
+}
+
 static bool dev_args_match_fs_devices(const struct btrfs_dev_lookup_args *args,
 				      const struct btrfs_fs_devices *fs_devices)
 {
diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index 517288d46ecf5..00c87833ce841 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -565,6 +565,8 @@ struct btrfs_block_group *btrfs_create_chunk(struct btrfs_trans_handle *trans,
 void btrfs_mapping_tree_free(struct extent_map_tree *tree);
 blk_status_t btrfs_map_bio(struct btrfs_fs_info *fs_info, struct bio *bio,
 			   int mirror_num);
+int btrfs_map_repair_bio(struct btrfs_fs_info *fs_info, struct bio *bio,
+		int mirror_num);
 int btrfs_open_devices(struct btrfs_fs_devices *fs_devices,
 		       fmode_t flags, void *holder);
 struct btrfs_device *btrfs_scan_one_device(const char *path,
-- 
2.30.2

