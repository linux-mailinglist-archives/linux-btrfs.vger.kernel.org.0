Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 827F93D1F76
	for <lists+linux-btrfs@lfdr.de>; Thu, 22 Jul 2021 09:58:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230452AbhGVHRm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 22 Jul 2021 03:17:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229642AbhGVHRm (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 22 Jul 2021 03:17:42 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A80AFC061575;
        Thu, 22 Jul 2021 00:58:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=6EOaGCr0s/6Ie6xU1pfdp0zJGxARJ60XJ1Wx1SRxcio=; b=D3/d8OwR5tBDEJ16l3TFeQW3Ij
        kFGx78NdmiveZyi+q0/tLwF1cQh9sMr5yCCo/M3LDBJ6fb1xsq3ikr4sQEqtPYEKg7eyK/TnlBI4W
        8yvxvlL4gU08h433gqm3PlNARbcKQAiPDfUD3Nj56HBaw/366GLZY9uJCQbJgVKdQHqAAML1Hhdv9
        TD+QiE6IvN1HLs6cgw4r+eAIK3uSxCiiAqFqeqJI7YvetTx867U1cpmitNTQHd/CQyOPjBKuVaUjv
        sDFToStybVpS5eEQS406l7zTbt2WcJNKK3mi6QQC6VKLgTtD/gPtr7cN9uz+g+wj8Eo8AZUXEV0bd
        I672ZB1Q==;
Received: from [2001:4bb8:193:7660:643c:9899:473:314a] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m6TaW-00A1VM-KP; Thu, 22 Jul 2021 07:57:55 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        linux-block@vger.kernel.org, linux-btrfs@vger.kernel.org
Subject: [PATCH 8/9] block: remove bdgrab
Date:   Thu, 22 Jul 2021 09:54:01 +0200
Message-Id: <20210722075402.983367-9-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210722075402.983367-1-hch@lst.de>
References: <20210722075402.983367-1-hch@lst.de>
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

