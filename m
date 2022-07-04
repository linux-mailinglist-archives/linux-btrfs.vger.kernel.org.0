Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39D9E564FE7
	for <lists+linux-btrfs@lfdr.de>; Mon,  4 Jul 2022 10:44:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232217AbiGDIoX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 4 Jul 2022 04:44:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230233AbiGDIoW (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 4 Jul 2022 04:44:22 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2227B7D4
        for <linux-btrfs@vger.kernel.org>; Mon,  4 Jul 2022 01:44:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=ABprDIJLyk7KRfI7Yo3bPLcNX7HVChVRW64LL7IyZqk=; b=mh3CXaFutq9/RxlKOztmgmjq5q
        c4aGj6y4KMVYU9DkEVCJ0V3OIoBqwzeVHolyxj8reH4re36zMHduwKQKU7eYnilqfaee9Zn6jJmh6
        TW9leuUk+EneNcufqRce0HM3WIOx1xK5OrUIECNEoMxGLtl7HKemVsHlxgpeqcpBpqrYFKME7pvyT
        fVyVOG1ggsTzR5FH5pKoAOiiRXavjK1mqJGlhcmEGi0mV2wBWW/nPNOKAufmKXLbxEw9U6ZEejd34
        E/vRY10FzNCvfKA7vbjwwUKQH+eMZBebvBK7xaw93TmfkfsVGElx359hRtInQb7/Qwe4VIEjWB58S
        lAovYvdA==;
Received: from [2001:4bb8:189:3c4a:9cc7:69df:e5dc:ef11] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o8Hgo-0068KX-U4; Mon, 04 Jul 2022 08:44:19 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: [PATCH 4/7] btrfs: properly abstract the parity raid bio handling
Date:   Mon,  4 Jul 2022 10:44:03 +0200
Message-Id: <20220704084406.106929-5-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220704084406.106929-1-hch@lst.de>
References: <20220704084406.106929-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The parity raid write/recover functionality is currently now very well
abstracted from the bio submission and completion handling in volumes.c:

 - the raid56 code directly completes the original btrfs_bio fed into
   btrfs_submit_bio instead of dispatching back to volumes.c
 - the raid56 code consumes the bioc and bio_counter references taken
   by volumes.c, which also leads to ugly special casing of the calls
   from the scrub code into the raid56 code

To fix this up supply a bi_end_io handler that calls back into the
volumes.c machinery, which then puts the bioc, decrements the bio_counter
and completes the original bio, and updates the scrub code to also
take ownership of the bioc and bio_counter in all cases.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/raid56.c  | 45 +++++++--------------------------------------
 fs/btrfs/raid56.h  |  4 +---
 fs/btrfs/scrub.c   |  7 +++++--
 fs/btrfs/volumes.c | 18 +++++++++++++++++-
 4 files changed, 30 insertions(+), 44 deletions(-)

diff --git a/fs/btrfs/raid56.c b/fs/btrfs/raid56.c
index 1afe32d5ab017..d767814653249 100644
--- a/fs/btrfs/raid56.c
+++ b/fs/btrfs/raid56.c
@@ -275,7 +275,6 @@ static void merge_rbio(struct btrfs_raid_bio *dest,
 	/* Also inherit the bitmaps from @victim. */
 	bitmap_or(&dest->dbitmap, &victim->dbitmap, &dest->dbitmap,
 		  dest->stripe_nsectors);
-	dest->generic_bio_cnt += victim->generic_bio_cnt;
 	bio_list_init(&victim->bio_list);
 }
 
@@ -814,8 +813,6 @@ static void rbio_orig_end_io(struct btrfs_raid_bio *rbio, blk_status_t err)
 	struct bio *cur = bio_list_get(&rbio->bio_list);
 	struct bio *extra;
 
-	if (rbio->generic_bio_cnt)
-		btrfs_bio_counter_sub(rbio->bioc->fs_info, rbio->generic_bio_cnt);
 	/*
 	 * Clear the data bitmap, as the rbio may be cached for later usage.
 	 * do this before before unlock_stripe() so there will be no new bio
@@ -946,6 +943,7 @@ static struct btrfs_raid_bio *alloc_rbio(struct btrfs_fs_info *fs_info,
 	spin_lock_init(&rbio->bio_list_lock);
 	INIT_LIST_HEAD(&rbio->stripe_cache);
 	INIT_LIST_HEAD(&rbio->hash_list);
+	btrfs_get_bioc(bioc);
 	rbio->bioc = bioc;
 	rbio->nr_pages = num_pages;
 	rbio->nr_sectors = num_sectors;
@@ -1813,15 +1811,12 @@ void raid56_parity_write(struct bio *bio, struct btrfs_io_context *bioc)
 
 	rbio = alloc_rbio(fs_info, bioc);
 	if (IS_ERR(rbio)) {
-		btrfs_put_bioc(bioc);
 		ret = PTR_ERR(rbio);
-		goto out_dec_counter;
+		goto fail;
 	}
 	rbio->operation = BTRFS_RBIO_WRITE;
 	rbio_add_bio(rbio, bio);
 
-	rbio->generic_bio_cnt = 1;
-
 	/*
 	 * don't plug on full rbios, just get them out the door
 	 * as quickly as we can
@@ -1829,7 +1824,7 @@ void raid56_parity_write(struct bio *bio, struct btrfs_io_context *bioc)
 	if (rbio_is_full(rbio)) {
 		ret = full_stripe_write(rbio);
 		if (ret)
-			goto out_dec_counter;
+			goto fail;
 		return;
 	}
 
@@ -1844,13 +1839,12 @@ void raid56_parity_write(struct bio *bio, struct btrfs_io_context *bioc)
 	} else {
 		ret = __raid56_parity_write(rbio);
 		if (ret)
-			goto out_dec_counter;
+			goto fail;
 	}
 
 	return;
 
-out_dec_counter:
-	btrfs_bio_counter_dec(fs_info);
+fail:
 	bio->bi_status = errno_to_blk_status(ret);
 	bio_endio(bio);
 }
@@ -2198,18 +2192,11 @@ static int __raid56_parity_recover(struct btrfs_raid_bio *rbio)
  * of the drive.
  */
 void raid56_parity_recover(struct bio *bio, struct btrfs_io_context *bioc,
-			   int mirror_num, bool generic_io)
+			   int mirror_num)
 {
 	struct btrfs_fs_info *fs_info = bioc->fs_info;
 	struct btrfs_raid_bio *rbio;
 
-	if (generic_io) {
-		ASSERT(bioc->mirror_num == mirror_num);
-		btrfs_bio(bio)->mirror_num = mirror_num;
-	} else {
-		btrfs_get_bioc(bioc);
-	}
-
 	rbio = alloc_rbio(fs_info, bioc);
 	if (IS_ERR(rbio)) {
 		bio->bi_status = errno_to_blk_status(PTR_ERR(rbio));
@@ -2225,14 +2212,11 @@ void raid56_parity_recover(struct bio *bio, struct btrfs_io_context *bioc,
 "%s could not find the bad stripe in raid56 so that we cannot recover any more (bio has logical %llu len %llu, bioc has map_type %llu)",
 			   __func__, bio->bi_iter.bi_sector << 9,
 			   (u64)bio->bi_iter.bi_size, bioc->map_type);
-		kfree(rbio);
+		__free_raid_bio(rbio);
 		bio->bi_status = BLK_STS_IOERR;
 		goto out_end_bio;
 	}
 
-	if (generic_io)
-		rbio->generic_bio_cnt = 1;
-
 	/*
 	 * Loop retry:
 	 * for 'mirror == 2', reconstruct from all other stripes.
@@ -2261,8 +2245,6 @@ void raid56_parity_recover(struct bio *bio, struct btrfs_io_context *bioc,
 	return;
 
 out_end_bio:
-	btrfs_bio_counter_dec(fs_info);
-	btrfs_put_bioc(bioc);
 	bio_endio(bio);
 }
 
@@ -2326,13 +2308,6 @@ struct btrfs_raid_bio *raid56_parity_alloc_scrub_rbio(struct bio *bio,
 	ASSERT(i < rbio->real_stripes);
 
 	bitmap_copy(&rbio->dbitmap, dbitmap, stripe_nsectors);
-
-	/*
-	 * We have already increased bio_counter when getting bioc, record it
-	 * so we can free it at rbio_orig_end_io().
-	 */
-	rbio->generic_bio_cnt = 1;
-
 	return rbio;
 }
 
@@ -2772,12 +2747,6 @@ raid56_alloc_missing_rbio(struct bio *bio, struct btrfs_io_context *bioc)
 		return NULL;
 	}
 
-	/*
-	 * When we get bioc, we have already increased bio_counter, record it
-	 * so we can free it at rbio_orig_end_io()
-	 */
-	rbio->generic_bio_cnt = 1;
-
 	return rbio;
 }
 
diff --git a/fs/btrfs/raid56.h b/fs/btrfs/raid56.h
index 6f48f9e4c8694..91d5c0adad151 100644
--- a/fs/btrfs/raid56.h
+++ b/fs/btrfs/raid56.h
@@ -89,8 +89,6 @@ struct btrfs_raid_bio {
 	 */
 	int bio_list_bytes;
 
-	int generic_bio_cnt;
-
 	refcount_t refs;
 
 	atomic_t stripes_pending;
@@ -166,7 +164,7 @@ static inline int nr_data_stripes(const struct map_lookup *map)
 struct btrfs_device;
 
 void raid56_parity_recover(struct bio *bio, struct btrfs_io_context *bioc,
-			   int mirror_num, bool generic_io);
+			   int mirror_num);
 void raid56_parity_write(struct bio *bio, struct btrfs_io_context *bioc);
 
 void raid56_add_scrub_pages(struct btrfs_raid_bio *rbio, struct page *page,
diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index 3afe5fa50a631..5f9ecb6d5b997 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -1381,7 +1381,7 @@ static int scrub_submit_raid56_bio_wait(struct btrfs_fs_info *fs_info,
 	bio->bi_private = &done;
 	bio->bi_end_io = scrub_bio_wait_endio;
 	raid56_parity_recover(bio, sector->recover->bioc,
-			      sector->sblock->sectors[0]->mirror_num, false);
+			      sector->sblock->sectors[0]->mirror_num);
 
 	wait_for_completion_io(&done);
 	return blk_status_to_errno(bio->bi_status);
@@ -2102,6 +2102,7 @@ static void scrub_missing_raid56_end_io(struct bio *bio)
 	struct scrub_block *sblock = bio->bi_private;
 	struct btrfs_fs_info *fs_info = sblock->sctx->fs_info;
 
+	btrfs_bio_counter_dec(fs_info);
 	if (bio->bi_status)
 		sblock->no_io_error_seen = 0;
 
@@ -2204,6 +2205,7 @@ static void scrub_missing_raid56_pages(struct scrub_block *sblock)
 	scrub_block_get(sblock);
 	scrub_pending_bio_inc(sctx);
 	raid56_submit_missing_rbio(rbio);
+	btrfs_put_bioc(bioc);
 	return;
 
 rbio_out:
@@ -2774,6 +2776,7 @@ static void scrub_parity_bio_endio_worker(struct work_struct *work)
 						    work);
 	struct scrub_ctx *sctx = sparity->sctx;
 
+	btrfs_bio_counter_dec(sctx->fs_info);
 	scrub_free_parity(sparity);
 	scrub_pending_bio_dec(sctx);
 }
@@ -2824,6 +2827,7 @@ static void scrub_parity_check_and_repair(struct scrub_parity *sparity)
 					      sparity->scrub_dev,
 					      &sparity->dbitmap,
 					      sparity->nsectors);
+	btrfs_put_bioc(bioc);
 	if (!rbio)
 		goto rbio_out;
 
@@ -2835,7 +2839,6 @@ static void scrub_parity_check_and_repair(struct scrub_parity *sparity)
 	bio_put(bio);
 bioc_out:
 	btrfs_bio_counter_dec(fs_info);
-	btrfs_put_bioc(bioc);
 	bitmap_or(&sparity->ebitmap, &sparity->ebitmap, &sparity->dbitmap,
 		  sparity->nsectors);
 	spin_lock(&sctx->stat_lock);
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 7689c7cdb1859..b4230ffcf35ff 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -6666,6 +6666,20 @@ static void btrfs_end_bio_work(struct work_struct *work)
 	bbio->bio.bi_end_io(&bbio->bio);
 }
 
+static void btrfs_raid56_end_io(struct bio *bio)
+{
+	struct btrfs_io_context *bioc = bio->bi_private;
+	struct btrfs_bio *bbio = btrfs_bio(bio);
+
+	btrfs_bio_counter_dec(bioc->fs_info);
+	bbio->mirror_num = bioc->mirror_num;
+	bio->bi_end_io = bioc->end_io;
+	bio->bi_private = bioc->private;
+	bio->bi_end_io(bio);
+
+	btrfs_put_bioc(bioc);
+}
+
 static void btrfs_end_bio(struct bio *bio)
 {
 	struct btrfs_io_stripe *stripe = bio->bi_private;
@@ -6801,10 +6815,12 @@ void btrfs_submit_bio(struct btrfs_fs_info *fs_info, struct bio *bio, int mirror
 
 	if ((bioc->map_type & BTRFS_BLOCK_GROUP_RAID56_MASK) &&
 	    ((btrfs_op(bio) == BTRFS_MAP_WRITE) || (mirror_num > 1))) {
+		bio->bi_private = bioc;
+		bio->bi_end_io = btrfs_raid56_end_io;
 		if (btrfs_op(bio) == BTRFS_MAP_WRITE)
 			raid56_parity_write(bio, bioc);
 		else
-			raid56_parity_recover(bio, bioc, mirror_num, true);
+			raid56_parity_recover(bio, bioc, mirror_num);
 		return;
 	}
 
-- 
2.30.2

