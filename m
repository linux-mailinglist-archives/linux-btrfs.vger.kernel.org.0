Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A54BE471A7
	for <lists+linux-btrfs@lfdr.de>; Sat, 15 Jun 2019 20:25:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727132AbfFOSZS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 15 Jun 2019 14:25:18 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:37665 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727107AbfFOSZR (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 15 Jun 2019 14:25:17 -0400
Received: by mail-qk1-f195.google.com with SMTP id d15so3815513qkl.4;
        Sat, 15 Jun 2019 11:25:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=YOUrDCMg1yDLfqXbDj7+733WP4wT9Kq/3RGxh4FkPz0=;
        b=cvHkYQG8X0HXtsqTco0RaZecgA5i/7cLmz0YZUl/MLokK4JWRwXCDUvrEw7++BjQtU
         cc50svs5FzEtynEO0c4PtBVFVst+N00hRbaGD6F/MdzZURvSJC7qnCQLrxGAWauRSWEe
         l5z5C9VDU2KaynosUMCWZZ+XV9vpNeaFo8FLEoH8vBI6YjlhnszyNefavDHw4AWnaVRo
         ulBEUkoll/7mVGK29o4hluF8J+Y7d7f8BULmK4n0WXLr9vEFzTZKyq7HHDVW+R4gJIHM
         M7p5Xk2OLF7rldn4uJ4DB4+PPr6u/ianEwxgGO5bxWBwPh4ocADH5nmyxaae1uZDGnZ1
         6a8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=YOUrDCMg1yDLfqXbDj7+733WP4wT9Kq/3RGxh4FkPz0=;
        b=BeY0hmbrCh31AzFvBH3EjWaxSxK4u8aSggr/zRBP7dtS2vaItk6GwX7YZ3tJdKMZ0E
         8LFlIi1RpuOOOgsxMOtsqamqjtxYwKtnag+zydRFVwbRzMIof5Mx0KnmG1DSvufS8wDO
         uRTZpXmcMRs8uMPAoZr8mAF8Vr87A9/zRAWROKB7mhp7URzWz0zt4fcH/qdEG7nHcmbo
         BN4+OKfEtmSSSJEhL707GZl7e/AeHEvePqHDFFtetG/gdlIfwZXSYuSM+APH93R7DNw6
         pKLoig1YzoAy2uD6noqKWo37dKWViALGe9JS4OJi+kVRK+I7hhBisdEECbbkzTprA2zn
         5/bA==
X-Gm-Message-State: APjAAAV/VOHs/cYAtEn702cToahdTv+2z7ibVtRM9iEfQTD8jaLz3YRd
        v8SpBaI38PQ+Mqwz4YUv9K4=
X-Google-Smtp-Source: APXvYqxRed92zUp/aw0i5gOYaxpXI0CPIxh4WJ0r3A01+20vWe9I+pHRW4oytSSHjxNJtAOL4Ksj1Q==
X-Received: by 2002:a37:a854:: with SMTP id r81mr4984090qke.53.1560623115842;
        Sat, 15 Jun 2019 11:25:15 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::4883])
        by smtp.gmail.com with ESMTPSA id o66sm3445473qkb.90.2019.06.15.11.25.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 15 Jun 2019 11:25:15 -0700 (PDT)
From:   Tejun Heo <tj@kernel.org>
To:     dsterba@suse.com, clm@fb.com, josef@toxicpanda.com,
        axboe@kernel.dk, jack@suse.cz
Cc:     linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 5/9] Btrfs: stop using btrfs_schedule_bio()
Date:   Sat, 15 Jun 2019 11:24:49 -0700
Message-Id: <20190615182453.843275-6-tj@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190615182453.843275-1-tj@kernel.org>
References: <20190615182453.843275-1-tj@kernel.org>
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
index 4ec1df369e47..873261b932b8 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -355,7 +355,7 @@ blk_status_t btrfs_submit_compressed_write(struct inode *inode, u64 start,
 				BUG_ON(ret); /* -ENOMEM */
 			}
 
-			ret = btrfs_map_bio(fs_info, bio, 0, 1);
+			ret = btrfs_map_bio(fs_info, bio, 0);
 			if (ret) {
 				bio->bi_status = ret;
 				bio_endio(bio);
@@ -385,7 +385,7 @@ blk_status_t btrfs_submit_compressed_write(struct inode *inode, u64 start,
 		BUG_ON(ret); /* -ENOMEM */
 	}
 
-	ret = btrfs_map_bio(fs_info, bio, 0, 1);
+	ret = btrfs_map_bio(fs_info, bio, 0);
 	if (ret) {
 		bio->bi_status = ret;
 		bio_endio(bio);
@@ -638,7 +638,7 @@ blk_status_t btrfs_submit_compressed_read(struct inode *inode, struct bio *bio,
 			sums += DIV_ROUND_UP(comp_bio->bi_iter.bi_size,
 					     fs_info->sectorsize);
 
-			ret = btrfs_map_bio(fs_info, comp_bio, mirror_num, 0);
+			ret = btrfs_map_bio(fs_info, comp_bio, mirror_num);
 			if (ret) {
 				comp_bio->bi_status = ret;
 				bio_endio(comp_bio);
@@ -662,7 +662,7 @@ blk_status_t btrfs_submit_compressed_read(struct inode *inode, struct bio *bio,
 		BUG_ON(ret); /* -ENOMEM */
 	}
 
-	ret = btrfs_map_bio(fs_info, comp_bio, mirror_num, 0);
+	ret = btrfs_map_bio(fs_info, comp_bio, mirror_num);
 	if (ret) {
 		comp_bio->bi_status = ret;
 		bio_endio(comp_bio);
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 663efce22d98..b34240406f36 100644
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
index d519c3520e87..91b161fb1521 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -2032,7 +2032,7 @@ static blk_status_t btrfs_submit_bio_hook(struct inode *inode, struct bio *bio,
 	}
 
 mapit:
-	ret = btrfs_map_bio(fs_info, bio, mirror_num, 0);
+	ret = btrfs_map_bio(fs_info, bio, mirror_num);
 
 out:
 	if (ret) {
@@ -7764,7 +7764,7 @@ static inline blk_status_t submit_dio_repair_bio(struct inode *inode,
 	if (ret)
 		return ret;
 
-	ret = btrfs_map_bio(fs_info, bio, mirror_num, 0);
+	ret = btrfs_map_bio(fs_info, bio, mirror_num);
 
 	return ret;
 }
@@ -8295,7 +8295,7 @@ static inline blk_status_t btrfs_submit_dio_bio(struct bio *bio,
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
index b8a0e8d0672d..8c7bd79b234a 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -415,7 +415,7 @@ int btrfs_alloc_chunk(struct btrfs_trans_handle *trans, u64 type);
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

