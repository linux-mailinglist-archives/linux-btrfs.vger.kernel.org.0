Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D18DC3D1F6E
	for <lists+linux-btrfs@lfdr.de>; Thu, 22 Jul 2021 09:57:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230445AbhGVHQf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 22 Jul 2021 03:16:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230048AbhGVHQe (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 22 Jul 2021 03:16:34 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2191AC061575;
        Thu, 22 Jul 2021 00:57:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=yuP/pCtnR11GZVGb5kljqrI8PYv0AD14UlcUVTme0ic=; b=CUk8GybL+SSu+eLD04j1uGD6dK
        CLIepPp7G7A9/riuWxoqZEEjBFh+iqv1RDiznW5b6aKAlSfsJNUANyXdlmjm2lLgqtLRettS2EjVc
        +ecmV01R8ccn3u53r24r2nvtmk6Ri5ApO0DT/T1YgRk0Kd6C/cLnanbJlSLVVcbVAn+3Dja7yOqe8
        6Vo146yOA/KlircRkugs6jFd3ZLJrqlVJr0Lk+Trs+HMOmDUnTl8j/iCVT0+Kdu4kVwSQZjwjQqwI
        777iQncVsAwtHxAyH0Vlow+dEV0tGhkMUiFNO5HTKOCCLcN/mjqyxDhrmDSSzfvV3jcLvsvXCQ6Ph
        oO1j/2VA==;
Received: from [2001:4bb8:193:7660:643c:9899:473:314a] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m6TZC-00A1Mt-Lh; Thu, 22 Jul 2021 07:56:36 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        linux-block@vger.kernel.org, linux-btrfs@vger.kernel.org
Subject: [PATCH 5/9] block: change the refcounting for partitions
Date:   Thu, 22 Jul 2021 09:53:58 +0200
Message-Id: <20210722075402.983367-6-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210722075402.983367-1-hch@lst.de>
References: <20210722075402.983367-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Instead of acquiring an inode reference on open make sure partitions
always hold device model references to the disk while alive, and switch
open to grab only a device model reference to the opened block device.
If that is a partition the disk reference is transitively held by the
partition already.
---
 block/partitions/core.c |  9 ++++++-
 fs/block_dev.c          | 60 ++++++++++++++++-------------------------
 2 files changed, 31 insertions(+), 38 deletions(-)

diff --git a/block/partitions/core.c b/block/partitions/core.c
index 09c58a110a89..4f7a1a9cd544 100644
--- a/block/partitions/core.c
+++ b/block/partitions/core.c
@@ -261,6 +261,7 @@ static void part_release(struct device *dev)
 {
 	if (MAJOR(dev->devt) == BLOCK_EXT_MAJOR)
 		blk_free_ext_minor(MINOR(dev->devt));
+	put_disk(dev_to_bdev(dev)->bd_disk);
 	bdput(dev_to_bdev(dev));
 }
 
@@ -349,9 +350,13 @@ static struct block_device *add_partition(struct gendisk *disk, int partno,
 	if (xa_load(&disk->part_tbl, partno))
 		return ERR_PTR(-EBUSY);
 
+	/* ensure we always have a reference to the whole disk */
+	get_device(disk_to_dev(disk));
+
+	err = -ENOMEM;
 	bdev = bdev_alloc(disk, partno);
 	if (!bdev)
-		return ERR_PTR(-ENOMEM);
+		goto out_put_disk;
 
 	bdev->bd_start_sect = start;
 	bdev_set_nr_sectors(bdev, len);
@@ -420,6 +425,8 @@ static struct block_device *add_partition(struct gendisk *disk, int partno,
 	device_del(pdev);
 out_put:
 	put_device(pdev);
+out_put_disk:
+	put_disk(disk);
 	return ERR_PTR(err);
 }
 
diff --git a/fs/block_dev.c b/fs/block_dev.c
index 932f4034ad66..4a6c8c0a3bc9 100644
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
 /**
  * bdgrab -- Grab a reference to an already referenced block device
  * @bdev:	Block device to grab a reference to.
@@ -1282,16 +1272,14 @@ static void blkdev_put_whole(struct block_device *bdev, fmode_t mode)
 static int blkdev_get_part(struct block_device *part, fmode_t mode)
 {
 	struct gendisk *disk = part->bd_disk;
-	struct block_device *whole;
 	int ret;
 
 	if (part->bd_openers)
 		goto done;
 
-	whole = bdgrab(disk->part0);
-	ret = blkdev_get_whole(whole, mode);
+	ret = blkdev_get_whole(bdev_whole(part), mode);
 	if (ret)
-		goto out_put_whole;
+		return ret;
 
 	ret = -ENXIO;
 	if (!bdev_nr_sectors(part))
@@ -1306,9 +1294,7 @@ static int blkdev_get_part(struct block_device *part, fmode_t mode)
 	return 0;
 
 out_blkdev_put:
-	blkdev_put_whole(whole, mode);
-out_put_whole:
-	bdput(whole);
+	blkdev_put_whole(bdev_whole(part), mode);
 	return ret;
 }
 
@@ -1321,42 +1307,42 @@ static void blkdev_put_part(struct block_device *part, fmode_t mode)
 	blkdev_flush_mapping(part);
 	whole->bd_disk->open_partitions--;
 	blkdev_put_whole(whole, mode);
-	bdput(whole);
 }
 
 struct block_device *blkdev_get_no_open(dev_t dev)
 {
 	struct block_device *bdev;
-	struct gendisk *disk;
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
 
-	disk = bdev->bd_disk;
-	if (!kobject_get_unless_zero(&disk_to_dev(disk)->kobj))
-		goto bdput;
-	if (disk->flags & GENHD_FL_HIDDEN)
-		goto put_disk;
-	if (!try_module_get(bdev->bd_disk->fops->owner))
-		goto put_disk;
+	/* switch from the inode reference to a device mode one: */
+	bdev = &BDEV_I(inode)->bdev;
+	if (!kobject_get_unless_zero(&bdev->bd_device.kobj))
+		bdev = NULL;
+	iput(inode);
+
+	if (!bdev)
+		return NULL;
+	if ((bdev->bd_disk->flags & GENHD_FL_HIDDEN) ||
+	    !try_module_get(bdev->bd_disk->fops->owner)) {
+		put_device(&bdev->bd_device);
+		return NULL;
+	}
+
 	return bdev;
-put_disk:
-	put_disk(disk);
-bdput:
-	bdput(bdev);
-	return NULL;
 }
 
 void blkdev_put_no_open(struct block_device *bdev)
 {
 	module_put(bdev->bd_disk->fops->owner);
-	put_disk(bdev->bd_disk);
-	bdput(bdev);
+	put_device(&bdev->bd_device);
 }
 
 /**
-- 
2.30.2

