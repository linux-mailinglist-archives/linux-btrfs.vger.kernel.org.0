Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB7B63D4599
	for <lists+linux-btrfs@lfdr.de>; Sat, 24 Jul 2021 09:20:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234217AbhGXGgU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 24 Jul 2021 02:36:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234105AbhGXGgU (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 24 Jul 2021 02:36:20 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2256C061575;
        Sat, 24 Jul 2021 00:16:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=HCm9uW4E4/3DOcRfmm9HD39m8G2hjpMR0GIiHTmeNNs=; b=ABt/PzvpW/Q+hHON2g66n5CL/W
        /rI8i6tQ/f/s6m9WhFJ5sVII0/CAbTU77H9bPgxR0kONR9g0zEnzD8ZH5M759+njc5+e9QZNpjyH8
        vFJ3JmzhRujHzsgJwU4MDoaqecrkB60NfVAW7SNun2i2D/x7SdbNJoKVhICzDWoIJqRlg2GLqFR9b
        kfNrDV9z4/uDTrHFeiWoguHRSVuhlKTFX6pnqbhCATQ4B1Kq01MpOAMqm1AwRvrPoy8YdwkhaX0yD
        Ddww1ZfOMYLWc5i5PsqnAfr2fCTogEy0tQzOcXAO0zLVzxPm1piknMV5vbxVn7dQIl5U/CphYE0iI
        PZNmCJbw==;
Received: from [2001:4bb8:184:87c5:85d0:a26b:ef67:d32c] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m7BtW-00C4k0-D2; Sat, 24 Jul 2021 07:16:25 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        linux-block@vger.kernel.org, linux-btrfs@vger.kernel.org,
        Chaitanya Kulkarni <ckulkarnilinux@gmail.com>
Subject: [PATCH 10/10] block: remove bdput
Date:   Sat, 24 Jul 2021 09:12:49 +0200
Message-Id: <20210724071249.1284585-11-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210724071249.1284585-1-hch@lst.de>
References: <20210724071249.1284585-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Now that we've stopped using inode references for anything meaninful
in the block layer get rid of the helper to put it and just open code
the call to iput on the block_device inode.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Reviewed-by: Chaitanya Kulkarni <ckulkarnilinux@gmail.com>
---
 block/genhd.c           | 4 ++--
 block/partitions/core.c | 2 +-
 fs/block_dev.c          | 6 ------
 include/linux/blkdev.h  | 1 -
 4 files changed, 3 insertions(+), 10 deletions(-)

diff --git a/block/genhd.c b/block/genhd.c
index 7b4beadaa694..700d9d291546 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -1077,7 +1077,7 @@ static void disk_release(struct device *dev)
 	xa_destroy(&disk->part_tbl);
 	if (test_bit(GD_QUEUE_REF, &disk->state) && disk->queue)
 		blk_put_queue(disk->queue);
-	bdput(disk->part0);	/* frees the disk */
+	iput(disk->part0->bd_inode);	/* frees the disk */
 }
 struct class block_class = {
 	.name		= "block",
@@ -1262,7 +1262,7 @@ struct gendisk *__alloc_disk_node(int minors, int node_id)
 
 out_destroy_part_tbl:
 	xa_destroy(&disk->part_tbl);
-	bdput(disk->part0);
+	iput(disk->part0->bd_inode);
 out_free_disk:
 	kfree(disk);
 	return NULL;
diff --git a/block/partitions/core.c b/block/partitions/core.c
index 1b02073a2047..8d8be1187b9e 100644
--- a/block/partitions/core.c
+++ b/block/partitions/core.c
@@ -262,7 +262,7 @@ static void part_release(struct device *dev)
 	if (MAJOR(dev->devt) == BLOCK_EXT_MAJOR)
 		blk_free_ext_minor(MINOR(dev->devt));
 	put_disk(dev_to_bdev(dev)->bd_disk);
-	bdput(dev_to_bdev(dev));
+	iput(dev_to_bdev(dev)->bd_inode);
 }
 
 static int part_uevent(struct device *dev, struct kobj_uevent_env *env)
diff --git a/fs/block_dev.c b/fs/block_dev.c
index 4f2c4e9e84f5..6658f40ae492 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -934,12 +934,6 @@ long nr_blockdev_pages(void)
 	return ret;
 }
 
-void bdput(struct block_device *bdev)
-{
-	iput(bdev->bd_inode);
-}
-EXPORT_SYMBOL(bdput);
- 
 /**
  * bd_may_claim - test whether a block device can be claimed
  * @bdev: block device of interest
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 98772da38bb1..b94de1d194b8 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1984,7 +1984,6 @@ void blkdev_put_no_open(struct block_device *bdev);
 struct block_device *bdev_alloc(struct gendisk *disk, u8 partno);
 void bdev_add(struct block_device *bdev, dev_t dev);
 struct block_device *I_BDEV(struct inode *inode);
-void bdput(struct block_device *);
 int truncate_bdev_range(struct block_device *bdev, fmode_t mode, loff_t lstart,
 		loff_t lend);
 
-- 
2.30.2

