Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E84C43D4597
	for <lists+linux-btrfs@lfdr.de>; Sat, 24 Jul 2021 09:20:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234214AbhGXGgD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 24 Jul 2021 02:36:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234105AbhGXGgC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 24 Jul 2021 02:36:02 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA242C061575;
        Sat, 24 Jul 2021 00:16:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=6EOaGCr0s/6Ie6xU1pfdp0zJGxARJ60XJ1Wx1SRxcio=; b=jQkEm8tXUhMBNDap4FjuickGj3
        eyeu0G8eEIRjfOXsjK5rFe0RfNmNw/Si3kbOQKKV2tcYVx9AecdjU+pkfTadgIgQwp2EYVDGlTywd
        pGtf3HBaMOD+66CARoVHp8JDRO4FEmc2rpBD8MsRhc3/5oRJOZMESKqjfShxGahrk1UtVdRJVVcD3
        fVjN64nEINa14X8A39wTaUZzGOemI/lkZYTBaUe9etfwyVJMMoRpWAmM0NkqDTbjiyHEEUMiY+xzL
        092fwD9S8g1JwQJHMI/BPU6NcRUtmzFoqsETX38TfpSzmA7sZnNw543Sk4lZYLU7E0l4hXW2jobMP
        mVD1wEqA==;
Received: from [2001:4bb8:184:87c5:85d0:a26b:ef67:d32c] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m7BtF-00C4i3-Ot; Sat, 24 Jul 2021 07:16:09 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        linux-block@vger.kernel.org, linux-btrfs@vger.kernel.org
Subject: [PATCH 09/10] block: remove bdgrab
Date:   Sat, 24 Jul 2021 09:12:48 +0200
Message-Id: <20210724071249.1284585-10-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210724071249.1284585-1-hch@lst.de>
References: <20210724071249.1284585-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

All callers are gone, and no one should grab a pure inode reference to
a block device anymore.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/block_dev.c         | 15 ---------------
 include/linux/blkdev.h |  1 -
 2 files changed, 16 deletions(-)

diff --git a/fs/block_dev.c b/fs/block_dev.c
index 4a6c8c0a3bc9..4f2c4e9e84f5 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -921,21 +921,6 @@ void bdev_add(struct block_device *bdev, dev_t dev)
 	insert_inode_hash(bdev->bd_inode);
 }
 
-/**
- * bdgrab -- Grab a reference to an already referenced block device
- * @bdev:	Block device to grab a reference to.
- *
- * Returns the block_device with an additional reference when successful,
- * or NULL if the inode is already beeing freed.
- */
-struct block_device *bdgrab(struct block_device *bdev)
-{
-	if (!igrab(bdev->bd_inode))
-		return NULL;
-	return bdev;
-}
-EXPORT_SYMBOL(bdgrab);
-
 long nr_blockdev_pages(void)
 {
 	struct inode *inode;
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 3177181c4326..98772da38bb1 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1984,7 +1984,6 @@ void blkdev_put_no_open(struct block_device *bdev);
 struct block_device *bdev_alloc(struct gendisk *disk, u8 partno);
 void bdev_add(struct block_device *bdev, dev_t dev);
 struct block_device *I_BDEV(struct inode *inode);
-struct block_device *bdgrab(struct block_device *bdev);
 void bdput(struct block_device *);
 int truncate_bdev_range(struct block_device *bdev, fmode_t mode, loff_t lstart,
 		loff_t lend);
-- 
2.30.2

