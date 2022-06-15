Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0E9954CC6A
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Jun 2022 17:16:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347664AbiFOPPo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 15 Jun 2022 11:15:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346864AbiFOPPd (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 15 Jun 2022 11:15:33 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B52733C4B4
        for <linux-btrfs@vger.kernel.org>; Wed, 15 Jun 2022 08:15:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=kus4Ml/QHgHrVV4bg/0yNIWLerZTBLlAvrqG6dFIrzY=; b=c+vBWOUNcfeU+kUF2YXHkIc3b+
        xKF0D6LEs9Ebqa1FQSJlQ+MP9MGZPl3CS99g4guh3ad3GpEfzHuYOQpYD2OYnKLlq9wK+MCV4l5M1
        01rAHjoHDF+2ev7EAtOBduzIpchpADRvUtn++Uvc7rc9wW3e3Zq6F3W0WW6TjTehdP5lO3xizJoJ7
        VjMcI9sbDzisUNSsJKkySjsT9mhZSLAz7ogY4dKGDa0BPBnN6sfM2bsn29+JWkh+tXCuqP+Dq+ZL4
        JjtaoVlN4XRzoNxCGgjBv6xWsPpv6wiUJvVbB3xq/Gx391OlVq97Tl3IgQpMC36ZYn88xtZxilK4G
        a8Jjm+RQ==;
Received: from [2001:4bb8:180:36f6:5ab4:8a8:5e48:3d75] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o1Ujx-00F8tI-F5; Wed, 15 Jun 2022 15:15:29 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     David Sterba <dsterba@suse.com>,
        Josef Bacik <josef@toxicpanda.com>, Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: [PATCH 4/5] btrfs: remove the raid56_parity_{write,recover} return value
Date:   Wed, 15 Jun 2022 17:15:14 +0200
Message-Id: <20220615151515.888424-5-hch@lst.de>
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

Follow the pattern of the main bio submission helper and do not return
an error and always consume the bio.  This allows these functions to
consume the btrfs_bio_counter_ from the caller and thus avoid additional
roundtrips on that counter.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/raid56.c  | 51 ++++++++++++++++++++++++----------------------
 fs/btrfs/raid56.h  |  6 +++---
 fs/btrfs/scrub.c   | 10 ++-------
 fs/btrfs/volumes.c | 19 ++++++++---------
 4 files changed, 41 insertions(+), 45 deletions(-)

diff --git a/fs/btrfs/raid56.c b/fs/btrfs/raid56.c
index e071648f2c591..bd64147bd8bab 100644
--- a/fs/btrfs/raid56.c
+++ b/fs/btrfs/raid56.c
@@ -1809,7 +1809,7 @@ static void rbio_add_bio(struct btrfs_raid_bio *rbio, struct bio *orig_bio)
 /*
  * our main entry point for writes from the rest of the FS.
  */
-int raid56_parity_write(struct bio *bio, struct btrfs_io_context *bioc)
+void raid56_parity_write(struct bio *bio, struct btrfs_io_context *bioc)
 {
 	struct btrfs_fs_info *fs_info = bioc->fs_info;
 	struct btrfs_raid_bio *rbio;
@@ -1820,12 +1820,12 @@ int raid56_parity_write(struct bio *bio, struct btrfs_io_context *bioc)
 	rbio = alloc_rbio(fs_info, bioc);
 	if (IS_ERR(rbio)) {
 		btrfs_put_bioc(bioc);
-		return PTR_ERR(rbio);
+		ret = PTR_ERR(rbio);
+		goto out_err;
 	}
 	rbio->operation = BTRFS_RBIO_WRITE;
 	rbio_add_bio(rbio, bio);
 
-	btrfs_bio_counter_inc_noblocked(fs_info);
 	rbio->generic_bio_cnt = 1;
 
 	/*
@@ -1835,8 +1835,8 @@ int raid56_parity_write(struct bio *bio, struct btrfs_io_context *bioc)
 	if (rbio_is_full(rbio)) {
 		ret = full_stripe_write(rbio);
 		if (ret)
-			btrfs_bio_counter_dec(fs_info);
-		return ret;
+			goto out_err;
+		return;
 	}
 
 	cb = blk_check_plugged(btrfs_raid_unplug, fs_info, sizeof(*plug));
@@ -1851,9 +1851,14 @@ int raid56_parity_write(struct bio *bio, struct btrfs_io_context *bioc)
 	} else {
 		ret = __raid56_parity_write(rbio);
 		if (ret)
-			btrfs_bio_counter_dec(fs_info);
+			goto out_err;
 	}
-	return ret;
+	return;
+
+out_err:
+	btrfs_bio_counter_dec(fs_info);
+	bio->bi_status = errno_to_blk_status(ret);
+	bio_endio(bio);
 }
 
 /*
@@ -2199,8 +2204,8 @@ static int __raid56_parity_recover(struct btrfs_raid_bio *rbio)
  * so we assume the bio they send down corresponds to a failed part
  * of the drive.
  */
-int raid56_parity_recover(struct bio *bio, struct btrfs_io_context *bioc,
-			  int mirror_num, int generic_io)
+void raid56_parity_recover(struct bio *bio, struct btrfs_io_context *bioc,
+			   int mirror_num, bool generic_io)
 {
 	struct btrfs_fs_info *fs_info = bioc->fs_info;
 	struct btrfs_raid_bio *rbio;
@@ -2209,13 +2214,14 @@ int raid56_parity_recover(struct bio *bio, struct btrfs_io_context *bioc,
 	if (generic_io) {
 		ASSERT(bioc->mirror_num == mirror_num);
 		btrfs_bio(bio)->mirror_num = mirror_num;
+	} else {
+		btrfs_get_bioc(bioc);
 	}
 
 	rbio = alloc_rbio(fs_info, bioc);
 	if (IS_ERR(rbio)) {
-		if (generic_io)
-			btrfs_put_bioc(bioc);
-		return PTR_ERR(rbio);
+		ret = PTR_ERR(rbio);
+		goto out_err;
 	}
 
 	rbio->operation = BTRFS_RBIO_READ_REBUILD;
@@ -2227,18 +2233,12 @@ int raid56_parity_recover(struct bio *bio, struct btrfs_io_context *bioc,
 "%s could not find the bad stripe in raid56 so that we cannot recover any more (bio has logical %llu len %llu, bioc has map_type %llu)",
 			   __func__, bio->bi_iter.bi_sector << 9,
 			   (u64)bio->bi_iter.bi_size, bioc->map_type);
-		if (generic_io)
-			btrfs_put_bioc(bioc);
 		kfree(rbio);
-		return -EIO;
+		goto out_err;
 	}
 
-	if (generic_io) {
-		btrfs_bio_counter_inc_noblocked(fs_info);
+	if (generic_io)
 		rbio->generic_bio_cnt = 1;
-	} else {
-		btrfs_get_bioc(bioc);
-	}
 
 	/*
 	 * Loop retry:
@@ -2257,8 +2257,6 @@ int raid56_parity_recover(struct bio *bio, struct btrfs_io_context *bioc,
 			rbio->failb--;
 	}
 
-	ret = lock_stripe_add(rbio);
-
 	/*
 	 * __raid56_parity_recover will end the bio with
 	 * any errors it hits.  We don't want to return
@@ -2266,15 +2264,20 @@ int raid56_parity_recover(struct bio *bio, struct btrfs_io_context *bioc,
 	 * will end up calling bio_endio with any nonzero
 	 * return
 	 */
-	if (ret == 0)
+	if (lock_stripe_add(rbio) == 0)
 		__raid56_parity_recover(rbio);
+
 	/*
 	 * our rbio has been added to the list of
 	 * rbios that will be handled after the
 	 * currently lock owner is done
 	 */
-	return 0;
+	return;
 
+out_err:	
+	btrfs_put_bioc(bioc);
+	bio->bi_status = errno_to_blk_status(ret);
+	bio_endio(bio);
 }
 
 static void rmw_work(struct work_struct *work)
diff --git a/fs/btrfs/raid56.h b/fs/btrfs/raid56.h
index 9e4e0501e4e89..c94f503eb3832 100644
--- a/fs/btrfs/raid56.h
+++ b/fs/btrfs/raid56.h
@@ -175,9 +175,9 @@ static inline int nr_data_stripes(const struct map_lookup *map)
 
 struct btrfs_device;
 
-int raid56_parity_recover(struct bio *bio, struct btrfs_io_context *bioc,
-			  int mirror_num, int generic_io);
-int raid56_parity_write(struct bio *bio, struct btrfs_io_context *bioc);
+void raid56_parity_recover(struct bio *bio, struct btrfs_io_context *bioc,
+			   int mirror_num, bool generic_io);
+void raid56_parity_write(struct bio *bio, struct btrfs_io_context *bioc);
 
 void raid56_add_scrub_pages(struct btrfs_raid_bio *rbio, struct page *page,
 			    unsigned int pgoff, u64 logical);
diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index 18986d062cf63..f091e57222082 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -1376,18 +1376,12 @@ static int scrub_submit_raid56_bio_wait(struct btrfs_fs_info *fs_info,
 					struct scrub_sector *sector)
 {
 	DECLARE_COMPLETION_ONSTACK(done);
-	int ret;
-	int mirror_num;
 
 	bio->bi_iter.bi_sector = sector->logical >> 9;
 	bio->bi_private = &done;
 	bio->bi_end_io = scrub_bio_wait_endio;
-
-	mirror_num = sector->sblock->sectors[0]->mirror_num;
-	ret = raid56_parity_recover(bio, sector->recover->bioc,
-				    mirror_num, 0);
-	if (ret)
-		return ret;
+	raid56_parity_recover(bio, sector->recover->bioc,
+			      sector->sblock->sectors[0]->mirror_num, false);
 
 	wait_for_completion_io(&done);
 	return blk_status_to_errno(bio->bi_status);
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 739676944e94d..3a8c437bdd65b 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -6749,8 +6749,12 @@ void btrfs_submit_bio(struct btrfs_fs_info *fs_info, struct bio *bio,
 	btrfs_bio_counter_inc_blocked(fs_info);
 	ret = __btrfs_map_block(fs_info, btrfs_op(bio), logical,
 				&map_length, &bioc, mirror_num, 1);
-	if (ret)
-		goto out_dec;
+	if (ret) {
+		btrfs_bio_counter_dec(fs_info);
+		bio->bi_status = errno_to_blk_status(ret);
+		bio_endio(bio);
+		return;
+	}
 
 	total_devs = bioc->num_stripes;
 	bioc->orig_bio = bio;
@@ -6761,10 +6765,10 @@ void btrfs_submit_bio(struct btrfs_fs_info *fs_info, struct bio *bio,
 	if ((bioc->map_type & BTRFS_BLOCK_GROUP_RAID56_MASK) &&
 	    ((btrfs_op(bio) == BTRFS_MAP_WRITE) || (mirror_num > 1))) {
 		if (btrfs_op(bio) == BTRFS_MAP_WRITE)
-			ret = raid56_parity_write(bio, bioc);
+			raid56_parity_write(bio, bioc);
 		else
-			ret = raid56_parity_recover(bio, bioc, mirror_num, 1);
-		goto out_dec;
+			raid56_parity_recover(bio, bioc, mirror_num, true);
+		return;
 	}
 
 	if (map_length < length) {
@@ -6779,12 +6783,7 @@ void btrfs_submit_bio(struct btrfs_fs_info *fs_info, struct bio *bio,
 
 		submit_stripe_bio(bioc, bio, dev_nr, should_clone);
 	}
-out_dec:
 	btrfs_bio_counter_dec(fs_info);
-	if (ret) {
-		bio->bi_status = errno_to_blk_status(ret);
-		bio_endio(bio);
-	}
 }
 
 static bool dev_args_match_fs_devices(const struct btrfs_dev_lookup_args *args,
-- 
2.30.2

