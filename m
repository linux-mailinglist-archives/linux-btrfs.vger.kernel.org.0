Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 76D9564CCA
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Jul 2019 21:28:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728087AbfGJT20 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 10 Jul 2019 15:28:26 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:36425 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726111AbfGJT20 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 10 Jul 2019 15:28:26 -0400
Received: by mail-pg1-f194.google.com with SMTP id l21so1708199pgm.3;
        Wed, 10 Jul 2019 12:28:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=mm1SnsW2u+mr0bNhyAzLcbP4q6SXoqO+q2aMLbRme3w=;
        b=scuDNSJNA6TWSKKOn2ZSU+juz1K5EGHHDaB7FRL1KC8SJ1YBhrykpq2YvIFz/JfzoQ
         Lnf4u5A2+BLSL8Wnud7LtcOVd+KeDjH8Kf7BkHPxsSYlhJcv9AVQgi5mWMmUUknUXhtI
         r4KeuT1Lkf7zarhh9D0grBmB68TyH4iB1hlz/a69Z4RmREFXer6tQBK+h4t9Chx/v9ds
         CyPGqYJv4MNjhCtxmGJKDWl2UOYyPSZso/mtXfte4UUCgKWkEE6nhNKXnBvwhWsI+7I9
         kX3ptaAmV5B0XVnAGgsPl8cmoJF2f4LNYoo+v2d3jJhpNNdBCqhhBgipXQDeYbTQJYoL
         F+Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=mm1SnsW2u+mr0bNhyAzLcbP4q6SXoqO+q2aMLbRme3w=;
        b=IoQWlYjJjvoWmmeF5UBP7/HVM7MDUhiMtf0M5UnCFq6Y7qBsRh/dNxcJ79WV7CHi6A
         nuL09+3R1Sr2PPHtaaXCJ0KlK9kfBPw/ZRT0J+rwU2F7+1apxDuzlW0eE/9YAAAB86ZR
         qrHN8aV0NfO6iPin2tjf2kTK+NNmBu9CvShckbYBywRJYikfw9avC86yvayGO3NTLaZZ
         q28DmbvyTKw927eNjQ3W7c4Gkzib71A6sHGRRN5a2VX4PgH3ao37t7w1fej7V8KvQiLE
         yYPLXylYShKw3jSSt4WMJ6aW2GgrcCUitDxdN/g2wbVGvJ1r2c+1X+1ht4a3FHMslqlh
         /qag==
X-Gm-Message-State: APjAAAU/c7/WOcROlOlqP0/TjsKt6WtvhsVLSn9q13GDuhWDq/ynoyyn
        SAzKRSmZ+2FZqws/gRhwSmU=
X-Google-Smtp-Source: APXvYqzhznd8XyFes9TF/pNn10k56dtNx65/MjvP8JoSME+N6wZpKlGzwQ3cdfnJQWwsbsMKvvrzOg==
X-Received: by 2002:a65:404d:: with SMTP id h13mr38065885pgp.71.1562786904935;
        Wed, 10 Jul 2019 12:28:24 -0700 (PDT)
Received: from localhost ([2620:10d:c091:500::3:2bbe])
        by smtp.gmail.com with ESMTPSA id s66sm3734889pfs.8.2019.07.10.12.28.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Jul 2019 12:28:24 -0700 (PDT)
From:   Tejun Heo <tj@kernel.org>
To:     josef@toxicpanda.com, clm@fb.com, dsterba@suse.com
Cc:     axboe@kernel.dk, jack@suse.cz, linux-kernel@vger.kernel.org,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 1/5] Btrfs: stop using btrfs_schedule_bio()
Date:   Wed, 10 Jul 2019 12:28:14 -0700
Message-Id: <20190710192818.1069475-2-tj@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190710192818.1069475-1-tj@kernel.org>
References: <20190710192818.1069475-1-tj@kernel.org>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Chris Mason <clm@fb.com>

btrfs_schedule_bio() hands IO off to a helper thread to do the actual
submit_bio() call.  This has been used to make sure async crc and
compression helpers don't get stuck on IO submission.  To maintain good
performance, over time the IO submission threads duplicated some IO
scheduler characteristics such as high and low priority IOs and they
also made some ugly assumptions about request allocation batch sizes.

All of this cost at least one extra context switch during IO submission,
and doesn't fit well with the modern blkmq IO stack.  So, this commit stops
using btrfs_schedule_bio().  We may need to adjust the number of async
helper threads for crcs and compression, but long term it's a better
path.

Signed-off-by: Chris Mason <clm@fb.com>
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/compression.c |  8 +++---
 fs/btrfs/disk-io.c     |  6 ++---
 fs/btrfs/inode.c       |  6 ++---
 fs/btrfs/volumes.c     | 55 +++---------------------------------------
 fs/btrfs/volumes.h     |  2 +-
 5 files changed, 15 insertions(+), 62 deletions(-)

diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index 84dd4a8980c5..dfc4eb9b7717 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -354,7 +354,7 @@ blk_status_t btrfs_submit_compressed_write(struct inode *inode, u64 start,
 				BUG_ON(ret); /* -ENOMEM */
 			}
 
-			ret = btrfs_map_bio(fs_info, bio, 0, 1);
+			ret = btrfs_map_bio(fs_info, bio, 0);
 			if (ret) {
 				bio->bi_status = ret;
 				bio_endio(bio);
@@ -384,7 +384,7 @@ blk_status_t btrfs_submit_compressed_write(struct inode *inode, u64 start,
 		BUG_ON(ret); /* -ENOMEM */
 	}
 
-	ret = btrfs_map_bio(fs_info, bio, 0, 1);
+	ret = btrfs_map_bio(fs_info, bio, 0);
 	if (ret) {
 		bio->bi_status = ret;
 		bio_endio(bio);
@@ -637,7 +637,7 @@ blk_status_t btrfs_submit_compressed_read(struct inode *inode, struct bio *bio,
 			sums += DIV_ROUND_UP(comp_bio->bi_iter.bi_size,
 					     fs_info->sectorsize);
 
-			ret = btrfs_map_bio(fs_info, comp_bio, mirror_num, 0);
+			ret = btrfs_map_bio(fs_info, comp_bio, mirror_num);
 			if (ret) {
 				comp_bio->bi_status = ret;
 				bio_endio(comp_bio);
@@ -661,7 +661,7 @@ blk_status_t btrfs_submit_compressed_read(struct inode *inode, struct bio *bio,
 		BUG_ON(ret); /* -ENOMEM */
 	}
 
-	ret = btrfs_map_bio(fs_info, comp_bio, mirror_num, 0);
+	ret = btrfs_map_bio(fs_info, comp_bio, mirror_num);
 	if (ret) {
 		comp_bio->bi_status = ret;
 		bio_endio(comp_bio);
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index deb74a8c191a..6b1ecc27913b 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -800,7 +800,7 @@ static void run_one_async_done(struct btrfs_work *work)
 	}
 
 	ret = btrfs_map_bio(btrfs_sb(inode->i_sb), async->bio,
-			async->mirror_num, 1);
+			    async->mirror_num);
 	if (ret) {
 		async->bio->bi_status = ret;
 		bio_endio(async->bio);
@@ -901,12 +901,12 @@ static blk_status_t btree_submit_bio_hook(struct inode *inode, struct bio *bio,
 					  BTRFS_WQ_ENDIO_METADATA);
 		if (ret)
 			goto out_w_error;
-		ret = btrfs_map_bio(fs_info, bio, mirror_num, 0);
+		ret = btrfs_map_bio(fs_info, bio, mirror_num);
 	} else if (!async) {
 		ret = btree_csum_one_bio(bio);
 		if (ret)
 			goto out_w_error;
-		ret = btrfs_map_bio(fs_info, bio, mirror_num, 0);
+		ret = btrfs_map_bio(fs_info, bio, mirror_num);
 	} else {
 		/*
 		 * kthread helpers are used to submit writes so that
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index a2aabdb85226..6e6df0eab324 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -2032,7 +2032,7 @@ static blk_status_t btrfs_submit_bio_hook(struct inode *inode, struct bio *bio,
 	}
 
 mapit:
-	ret = btrfs_map_bio(fs_info, bio, mirror_num, 0);
+	ret = btrfs_map_bio(fs_info, bio, mirror_num);
 
 out:
 	if (ret) {
@@ -7774,7 +7774,7 @@ static inline blk_status_t submit_dio_repair_bio(struct inode *inode,
 	if (ret)
 		return ret;
 
-	ret = btrfs_map_bio(fs_info, bio, mirror_num, 0);
+	ret = btrfs_map_bio(fs_info, bio, mirror_num);
 
 	return ret;
 }
@@ -8305,7 +8305,7 @@ static inline blk_status_t btrfs_submit_dio_bio(struct bio *bio,
 			goto err;
 	}
 map:
-	ret = btrfs_map_bio(fs_info, bio, 0, 0);
+	ret = btrfs_map_bio(fs_info, bio, 0);
 err:
 	return ret;
 }
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 1c2a6e4b39da..72326cc23985 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -6386,52 +6386,8 @@ static void btrfs_end_bio(struct bio *bio)
 	}
 }
 
-/*
- * see run_scheduled_bios for a description of why bios are collected for
- * async submit.
- *
- * This will add one bio to the pending list for a device and make sure
- * the work struct is scheduled.
- */
-static noinline void btrfs_schedule_bio(struct btrfs_device *device,
-					struct bio *bio)
-{
-	struct btrfs_fs_info *fs_info = device->fs_info;
-	int should_queue = 1;
-	struct btrfs_pending_bios *pending_bios;
-
-	/* don't bother with additional async steps for reads, right now */
-	if (bio_op(bio) == REQ_OP_READ) {
-		btrfsic_submit_bio(bio);
-		return;
-	}
-
-	WARN_ON(bio->bi_next);
-	bio->bi_next = NULL;
-
-	spin_lock(&device->io_lock);
-	if (op_is_sync(bio->bi_opf))
-		pending_bios = &device->pending_sync_bios;
-	else
-		pending_bios = &device->pending_bios;
-
-	if (pending_bios->tail)
-		pending_bios->tail->bi_next = bio;
-
-	pending_bios->tail = bio;
-	if (!pending_bios->head)
-		pending_bios->head = bio;
-	if (device->running_pending)
-		should_queue = 0;
-
-	spin_unlock(&device->io_lock);
-
-	if (should_queue)
-		btrfs_queue_work(fs_info->submit_workers, &device->work);
-}
-
 static void submit_stripe_bio(struct btrfs_bio *bbio, struct bio *bio,
-			      u64 physical, int dev_nr, int async)
+			      u64 physical, int dev_nr)
 {
 	struct btrfs_device *dev = bbio->stripes[dev_nr].dev;
 	struct btrfs_fs_info *fs_info = bbio->fs_info;
@@ -6449,10 +6405,7 @@ static void submit_stripe_bio(struct btrfs_bio *bbio, struct bio *bio,
 
 	btrfs_bio_counter_inc_noblocked(fs_info);
 
-	if (async)
-		btrfs_schedule_bio(dev, bio);
-	else
-		btrfsic_submit_bio(bio);
+	btrfsic_submit_bio(bio);
 }
 
 static void bbio_error(struct btrfs_bio *bbio, struct bio *bio, u64 logical)
@@ -6473,7 +6426,7 @@ static void bbio_error(struct btrfs_bio *bbio, struct bio *bio, u64 logical)
 }
 
 blk_status_t btrfs_map_bio(struct btrfs_fs_info *fs_info, struct bio *bio,
-			   int mirror_num, int async_submit)
+			   int mirror_num)
 {
 	struct btrfs_device *dev;
 	struct bio *first_bio = bio;
@@ -6542,7 +6495,7 @@ blk_status_t btrfs_map_bio(struct btrfs_fs_info *fs_info, struct bio *bio,
 			bio = first_bio;
 
 		submit_stripe_bio(bbio, bio, bbio->stripes[dev_nr].physical,
-				  dev_nr, async_submit);
+				  dev_nr);
 	}
 	btrfs_bio_counter_dec(fs_info);
 	return BLK_STS_OK;
diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index 136a3eb64604..e532d095c6a4 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -416,7 +416,7 @@ int btrfs_alloc_chunk(struct btrfs_trans_handle *trans, u64 type);
 void btrfs_mapping_init(struct btrfs_mapping_tree *tree);
 void btrfs_mapping_tree_free(struct btrfs_mapping_tree *tree);
 blk_status_t btrfs_map_bio(struct btrfs_fs_info *fs_info, struct bio *bio,
-			   int mirror_num, int async_submit);
+			   int mirror_num);
 int btrfs_open_devices(struct btrfs_fs_devices *fs_devices,
 		       fmode_t flags, void *holder);
 struct btrfs_device *btrfs_scan_one_device(const char *path,
-- 
2.17.1

