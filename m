Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7FC93D12A7
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Jul 2021 17:38:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240063AbhGUO6F (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 21 Jul 2021 10:58:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240062AbhGUO6E (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 21 Jul 2021 10:58:04 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61C70C061575;
        Wed, 21 Jul 2021 08:38:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=uM2IDLBT3+Rvi8KOFX4nLAoMywh5C8Lsp0Ru5hR1yyI=; b=N2245fOK7YHQXal86uocL9+T50
        xUzCM1/mPMRryZPcPrEoc9FXPsBAvXJqBez8cyamSko/cLDW2CH06Xwf1krjv/MgLlIYXg6Lb3QE3
        6ldQ3NbeOfL+cRWnuyOaMItcyKOGi0KS1KSyVq+T+IUZuEPU9G0kGfGzIAZ5NQoarYtnkGntmmfmA
        iadaGyRGqoUPyaAYEhcsN6L1+9+LYEOC2Hs3zs7CRm82i56B8gdX14/7pSwyyK3bBMpu7qzfoG/kW
        lyeyZF1834UsbkXUVAUk309pHSOSfVys9wmYebaNfzXvRy5AGRJYvKu3pE7fsBrAsEc3TRHk4inv8
        v4jPzJMQ==;
Received: from [2001:4bb8:193:7660:d6d5:72f4:23f7:1898] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m6EIT-009LOq-4a; Wed, 21 Jul 2021 15:38:16 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-block@vger.kernel.org,
        linux-btrfs@vger.kernel.org
Subject: [PATCH 8/8] block: remove bdget/bdput
Date:   Wed, 21 Jul 2021 17:35:23 +0200
Message-Id: <20210721153523.103818-9-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210721153523.103818-1-hch@lst.de>
References: <20210721153523.103818-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Now that we've stopped using inode references for anything meaninful
in the block layer get rid of the helpers for it and just open code
the places that look up a block device by dev_t and drop the main
inode reference held by the device model.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/genhd.c           |  4 ++--
 block/partitions/core.c |  8 ++++----
 fs/block_dev.c          | 34 ++++++++++------------------------
 include/linux/blkdev.h  |  1 -
 4 files changed, 16 insertions(+), 31 deletions(-)

diff --git a/block/genhd.c b/block/genhd.c
index e6d782714ad3..3ea27bee0615 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -1081,7 +1081,7 @@ static void disk_release(struct device *dev)
 	xa_destroy(&disk->part_tbl);
 	if (test_bit(GD_QUEUE_REF, &disk->state) && disk->queue)
 		blk_put_queue(disk->queue);
-	bdput(disk->part0);
+	iput(disk->part0->bd_inode); /* actually frees the disk */
 }
 struct class block_class = {
 	.name		= "block",
@@ -1266,7 +1266,7 @@ struct gendisk *__alloc_disk_node(int minors, int node_id)
 
 out_destroy_part_tbl:
 	xa_destroy(&disk->part_tbl);
-	bdput(disk->part0);
+	iput(disk->part0->bd_inode);
 out_free_disk:
 	kfree(disk);
 	return NULL;
diff --git a/block/partitions/core.c b/block/partitions/core.c
index 9902b1635b7d..4397ac9f905e 100644
--- a/block/partitions/core.c
+++ b/block/partitions/core.c
@@ -261,7 +261,7 @@ static void part_release(struct device *dev)
 {
 	if (MAJOR(dev->devt) == BLOCK_EXT_MAJOR)
 		blk_free_ext_minor(MINOR(dev->devt));
-	bdput(dev_to_bdev(dev));
+	iput(dev_to_bdev(dev)->bd_inode);
 }
 
 static int part_uevent(struct device *dev, struct kobj_uevent_env *env)
@@ -360,7 +360,7 @@ static struct block_device *add_partition(struct gendisk *disk, int partno,
 		err = -ENOMEM;
 		bdev->bd_meta_info = kmemdup(info, sizeof(*info), GFP_KERNEL);
 		if (!bdev->bd_meta_info)
-			goto out_bdput;
+			goto out_iput;
 	}
 
 	pdev = &bdev->bd_device;
@@ -415,8 +415,8 @@ static struct block_device *add_partition(struct gendisk *disk, int partno,
 		kobject_uevent(&pdev->kobj, KOBJ_ADD);
 	return bdev;
 
-out_bdput:
-	bdput(bdev);
+out_iput:
+	iput(bdev->bd_inode);
 	return ERR_PTR(err);
 out_del:
 	kobject_put(bdev->bd_holder_dir);
diff --git a/fs/block_dev.c b/fs/block_dev.c
index 5c56d88fd838..8747c264e64c 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -921,16 +921,6 @@ void bdev_add(struct block_device *bdev, dev_t dev)
 	insert_inode_hash(bdev->bd_inode);
 }
 
-static struct block_device *bdget(dev_t dev)
-{
-	struct inode *inode;
-
-	inode = ilookup(blockdev_superblock, dev);
-	if (!inode)
-		return NULL;
-	return &BDEV_I(inode)->bdev;
-}
-
 long nr_blockdev_pages(void)
 {
 	struct inode *inode;
@@ -944,12 +934,6 @@ long nr_blockdev_pages(void)
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
@@ -1308,18 +1292,20 @@ struct block_device *blkdev_get_no_open(dev_t dev)
 {
 	struct block_device *bdev;
 	struct gendisk *disk;
+	struct inode *inode;
 
-	bdev = bdget(dev);
-	if (!bdev) {
+	inode = ilookup(blockdev_superblock, dev);
+	if (!inode) {
 		blk_request_module(dev);
-		bdev = bdget(dev);
-		if (!bdev)
+		inode = ilookup(blockdev_superblock, dev);
+		if (!inode)
 			return NULL;
 	}
 
+	bdev = &BDEV_I(inode)->bdev;
 	disk = bdev->bd_disk;
 	if (!kobject_get_unless_zero(&disk_to_dev(disk)->kobj))
-		goto bdput;
+		goto iput;
 	if ((disk->flags & (GENHD_FL_UP | GENHD_FL_HIDDEN)) != GENHD_FL_UP)
 		goto put_disk;
 	if (!try_module_get(disk->fops->owner))
@@ -1328,14 +1314,14 @@ struct block_device *blkdev_get_no_open(dev_t dev)
 	/* switch to a device model reference instead of the inode one: */
 	if (!kobject_get_unless_zero(&bdev->bd_device.kobj))
 		goto put_module;
-	bdput(bdev);
+	iput(bdev->bd_inode);
 	return bdev;
 put_module:
 	module_put(disk->fops->owner);
 put_disk:
 	put_disk(disk);
-bdput:
-	bdput(bdev);
+iput:
+	iput(bdev->bd_inode);
 	return NULL;
 }
 
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

