Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F2553D12A1
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Jul 2021 17:38:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240046AbhGUO5r (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 21 Jul 2021 10:57:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239912AbhGUO5q (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 21 Jul 2021 10:57:46 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3873AC06179A;
        Wed, 21 Jul 2021 08:38:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=mq3s3MlPrrHCTu21Vhkw6lau0FtaRZ+ohY6DRxCoHfc=; b=abAwAOxjorfNgU9ZxzP6Evn1nC
        o+cSQBC/rxum54/Kd82exUKgNKs41aD6P7L119fJ4P6VOQkS4w585xC89dG7VaFajAlecfnNByY8Z
        vcqRRxKOxV/dQilPgo2q8P10vf/7EBY5xAB+jjLzblxUiCEPVoJSuQmnaQTCJrr7bYeSNcNa62mOM
        bAvR24QC75/XRzxkqPbxauh70OpQQr97Qj9u74PAIZNxZ8Rla+Uh9qx6mwRHsGdpze+7egNtOD4k5
        JQgy1htNMaKPclmfC3DqMdptZLQmxSLd3oWkLXFg4ezUNQXksG5dZtpW821cDfTvDpSWkO2xPfyLW
        zbGu9Vjw==;
Received: from [2001:4bb8:193:7660:d6d5:72f4:23f7:1898] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m6EI9-009LNh-So; Wed, 21 Jul 2021 15:37:56 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-block@vger.kernel.org,
        linux-btrfs@vger.kernel.org
Subject: [PATCH 7/8] block: remove bdgrab
Date:   Wed, 21 Jul 2021 17:35:22 +0200
Message-Id: <20210721153523.103818-8-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210721153523.103818-1-hch@lst.de>
References: <20210721153523.103818-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

All callers are gone, and no one should grab a pure inode reference to
a block device anymore.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/block_dev.c         | 15 ---------------
 include/linux/blkdev.h |  1 -
 2 files changed, 16 deletions(-)

diff --git a/fs/block_dev.c b/fs/block_dev.c
index 7de519dcfdff..5c56d88fd838 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -931,21 +931,6 @@ static struct block_device *bdget(dev_t dev)
 	return &BDEV_I(inode)->bdev;
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

