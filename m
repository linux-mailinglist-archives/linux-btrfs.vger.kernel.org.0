Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D64E54F4CB
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Jun 2022 12:04:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381475AbiFQKEg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 17 Jun 2022 06:04:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380451AbiFQKEf (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 17 Jun 2022 06:04:35 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 561656971B
        for <linux-btrfs@vger.kernel.org>; Fri, 17 Jun 2022 03:04:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=pzNG1ACMnxZUP2ZLXgdLfSNYDnXkQdt1HJzVhIl/kOM=; b=R2YpABdyuAK3bNQPCuYwCpbCiP
        yfROBsa5squcrD6Z6BsrrFWKKGgiDFfmYIt9K8kHpRljn8NFp7IbOBj8KkG3yyT6EO8UknwMkMYob
        MZK1M3AdSbv4bUVNmmVgpzCJNpk4BtE6ugzjdYfvg+I+6MHxjoZzHnH8Txbvkav5lD8Zf+GoLYePL
        YQhntKqF0JPubLEWz7KUkMnp+zSir0JVRfHIOLTZjxgE2bu1VroTQArOlWj5+imqRhTsc31vQHdbU
        2l9k8xcsD+UHtnJ91aCR06e8GaOseeCpBlU4dNQ7BSvawy0DPHqa2iY3wzdPL9al/4jzHUn6VQ6hA
        7cVRqPVA==;
Received: from [2001:4bb8:180:36f6:9c91:42c8:8d10:d7ed] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o28q8-006slO-RK; Fri, 17 Jun 2022 10:04:33 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     David Sterba <dsterba@suse.com>,
        Josef Bacik <josef@toxicpanda.com>, Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: [PATCH 05/10] btrfs: remove the raid56_parity_recover return value
Date:   Fri, 17 Jun 2022 12:04:09 +0200
Message-Id: <20220617100414.1159680-6-hch@lst.de>
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

Always consume the bio and call the end_io handler on error instead of
returning an error and letting the caller handle it.  This matches what
the block layer submission does and avoids any confusion on who
needs to handle errors.

Also use the proper bool type for the generic_io argument.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/raid56.c  | 39 ++++++++++++++++-----------------------
 fs/btrfs/raid56.h  |  4 ++--
 fs/btrfs/scrub.c   | 10 ++--------
 fs/btrfs/volumes.c |  2 +-
 4 files changed, 21 insertions(+), 34 deletions(-)

diff --git a/fs/btrfs/raid56.c b/fs/btrfs/raid56.c
index c0cc2d99509c9..cd39c233dfdeb 100644
--- a/fs/btrfs/raid56.c
+++ b/fs/btrfs/raid56.c
@@ -2200,12 +2200,11 @@ static int __raid56_parity_recover(struct btrfs_raid_bio *rbio)
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
-	int ret;
 
 	if (generic_io) {
 		ASSERT(bioc->mirror_num == mirror_num);
@@ -2214,9 +2213,8 @@ int raid56_parity_recover(struct bio *bio, struct btrfs_io_context *bioc,
 
 	rbio = alloc_rbio(fs_info, bioc);
 	if (IS_ERR(rbio)) {
-		if (generic_io)
-			btrfs_put_bioc(bioc);
-		return PTR_ERR(rbio);
+		bio->bi_status = errno_to_blk_status(PTR_ERR(rbio));
+		goto out_end_bio;
 	}
 
 	rbio->operation = BTRFS_RBIO_READ_REBUILD;
@@ -2228,10 +2226,9 @@ int raid56_parity_recover(struct bio *bio, struct btrfs_io_context *bioc,
 "%s could not find the bad stripe in raid56 so that we cannot recover any more (bio has logical %llu len %llu, bioc has map_type %llu)",
 			   __func__, bio->bi_iter.bi_sector << 9,
 			   (u64)bio->bi_iter.bi_size, bioc->map_type);
-		if (generic_io)
-			btrfs_put_bioc(bioc);
 		kfree(rbio);
-		return -EIO;
+		bio->bi_status = BLK_STS_IOERR;
+		goto out_end_bio;
 	}
 
 	if (generic_io) {
@@ -2258,24 +2255,20 @@ int raid56_parity_recover(struct bio *bio, struct btrfs_io_context *bioc,
 			rbio->failb--;
 	}
 
-	ret = lock_stripe_add(rbio);
+	if (lock_stripe_add(rbio))
+		return;
 
 	/*
-	 * __raid56_parity_recover will end the bio with
-	 * any errors it hits.  We don't want to return
-	 * its error value up the stack because our caller
-	 * will end up calling bio_endio with any nonzero
-	 * return
+	 * This adds our rbio to the list of rbios that will be handled after
+	 * the current lock owner is done.
 	 */
-	if (ret == 0)
-		__raid56_parity_recover(rbio);
-	/*
-	 * our rbio has been added to the list of
-	 * rbios that will be handled after the
-	 * currently lock owner is done
-	 */
-	return 0;
+	__raid56_parity_recover(rbio);
+	return;
 
+out_end_bio:
+	if (generic_io)
+		btrfs_put_bioc(bioc);
+	bio_endio(bio);
 }
 
 static void rmw_work(struct work_struct *work)
diff --git a/fs/btrfs/raid56.h b/fs/btrfs/raid56.h
index 3f223ae39462a..6f48f9e4c8694 100644
--- a/fs/btrfs/raid56.h
+++ b/fs/btrfs/raid56.h
@@ -165,8 +165,8 @@ static inline int nr_data_stripes(const struct map_lookup *map)
 
 struct btrfs_device;
 
-int raid56_parity_recover(struct bio *bio, struct btrfs_io_context *bioc,
-			  int mirror_num, int generic_io);
+void raid56_parity_recover(struct bio *bio, struct btrfs_io_context *bioc,
+			   int mirror_num, bool generic_io);
 void raid56_parity_write(struct bio *bio, struct btrfs_io_context *bioc);
 
 void raid56_add_scrub_pages(struct btrfs_raid_bio *rbio, struct page *page,
diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index ad7958d18158f..3afe5fa50a631 100644
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
index b30d4449ef18d..844ad637a0269 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -6770,7 +6770,7 @@ void btrfs_submit_bio(struct btrfs_fs_info *fs_info, struct bio *bio,
 		if (btrfs_op(bio) == BTRFS_MAP_WRITE)
 			raid56_parity_write(bio, bioc);
 		else
-			ret = raid56_parity_recover(bio, bioc, mirror_num, 1);
+			raid56_parity_recover(bio, bioc, mirror_num, true);
 		goto out_dec;
 	}
 
-- 
2.30.2

