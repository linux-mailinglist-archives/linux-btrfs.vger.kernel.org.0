Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF6463D1F8A
	for <lists+linux-btrfs@lfdr.de>; Thu, 22 Jul 2021 09:58:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231305AbhGVHSV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 22 Jul 2021 03:18:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231288AbhGVHST (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 22 Jul 2021 03:18:19 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9383CC06179A;
        Thu, 22 Jul 2021 00:58:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=DLetPscjPSvYX0+JLQEAhyT0z61r6wDFfOuKfNbPHc0=; b=uUWXzTto9SFDBQ55AQSrqQxHhN
        VZpzslCNdO/UWTiIvTBl6h4QJDqG1TnDRothEUBP07YQytD/asdapiS37ZAZtnKS2r9ByHoaEJ/Nd
        +C5Wir7XByznnyLuB62cTCoCEtzbi2eVknvFgAeumtVjfaS7MR14Iq+acJZnNII+NP70ZJJT2CSzF
        sKgrAGq7ngTcGr8C/YaA/J9pVk3TW5DehOfhNRHb+2BpASQcft6bmptyc7frsR5HVlbFyrBz4z4ia
        PGIZAfJxci7DvR9YvLaCZKEwvT4iPykqATCtXYBaJZohA78lOSDQQvs2wXmOX2lr6L+r0HzEgNczt
        OMxmjbxA==;
Received: from [2001:4bb8:193:7660:643c:9899:473:314a] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m6Taq-00A1WF-7Q; Thu, 22 Jul 2021 07:58:10 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        linux-block@vger.kernel.org, linux-btrfs@vger.kernel.org
Subject: [PATCH 9/9] block: remove bdput
Date:   Thu, 22 Jul 2021 09:54:02 +0200
Message-Id: <20210722075402.983367-10-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210722075402.983367-1-hch@lst.de>
References: <20210722075402.983367-1-hch@lst.de>
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
---
 block/genhd.c           | 4 ++--
 block/partitions/core.c | 2 +-
 fs/block_dev.c          | 6 ------
 include/linux/blkdev.h  | 1 -
 4 files changed, 3 insertions(+), 10 deletions(-)

diff --git a/block/genhd.c b/block/genhd.c
index 716f5ca479ad..5dbb99b57b33 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -1076,7 +1076,7 @@ static void disk_release(struct device *dev)
 	xa_destroy(&disk->part_tbl);
 	if (test_bit(GD_QUEUE_REF, &disk->state) && disk->queue)
 		blk_put_queue(disk->queue);
-	bdput(disk->part0);	/* frees the disk */
+	iput(disk->part0->bd_inode);	/* frees the disk */
 }
 struct class block_class = {
 	.name		= "block",
@@ -1261,7 +1261,7 @@ struct gendisk *__alloc_disk_node(int minors, int node_id)
 
 out_destroy_part_tbl:
 	xa_destroy(&disk->part_tbl);
-	bdput(disk->part0);
+	iput(disk->part0->bd_inode);
 out_free_disk:
 	kfree(disk);
 	return NULL;
diff --git a/block/partitions/core.c b/block/partitions/core.c
index 4f7a1a9cd544..2415bffc2771 100644
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

