Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C3813D1F73
	for <lists+linux-btrfs@lfdr.de>; Thu, 22 Jul 2021 09:58:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230418AbhGVHRc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 22 Jul 2021 03:17:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230048AbhGVHRa (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 22 Jul 2021 03:17:30 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13652C061575;
        Thu, 22 Jul 2021 00:58:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=EgGhUx4yzqyD/GIVSazVe5S/qr/x3vPRj6RyCg05ODA=; b=jIMmVRX1yiPY9Gr1wUWJFRpX9B
        pIUx2lqSAdNfpZUJRR4Rr/ysGuFFL0ozGnk+DHZdo+BQenGLeDRqHng7oHJ5aSNff2d/ZCgIahZhE
        PwGthQtIV0aKcx3Y7dFvYytxwzP/wiw2kv7qeUz/bCg9Rpw8qEObM4a6OptMym/5YQvzfIUwH/Z+3
        RR8uyCfn0uD2Sp4QhNE83Y90g/fTJ6uUSkU6KlsPgbb4Ax1rLQrthFV9EQBNcYLNiSK0tvCpKkGAh
        K+kwHi9eUQmTIwQ2wnk3lBNBMfe2Jco3N6S95j/0bFcMY22uO0txuuwkkY+LTJgoxbkE9k/pQQw30
        ltOQwjRg==;
Received: from [2001:4bb8:193:7660:643c:9899:473:314a] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m6TZy-00A1Sz-K4; Thu, 22 Jul 2021 07:57:23 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        linux-block@vger.kernel.org, linux-btrfs@vger.kernel.org
Subject: [PATCH 7/9] loop: don't grab a reference to the block device
Date:   Thu, 22 Jul 2021 09:54:00 +0200
Message-Id: <20210722075402.983367-8-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210722075402.983367-1-hch@lst.de>
References: <20210722075402.983367-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The whole device block device won't be removed while the disk is still
alive, so don't bother to grab a reference to it.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
---
 drivers/block/loop.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index f37b9e3d833c..62c5120cf744 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -1249,10 +1249,6 @@ static int loop_configure(struct loop_device *lo, fmode_t mode,
 	if (partscan)
 		lo->lo_disk->flags &= ~GENHD_FL_NO_PART_SCAN;
 
-	/* Grab the block_device to prevent its destruction after we
-	 * put /dev/loopXX inode. Later in __loop_clr_fd() we bdput(bdev).
-	 */
-	bdgrab(bdev);
 	mutex_unlock(&lo->lo_mutex);
 	if (partscan)
 		loop_reread_partitions(lo);
@@ -1332,7 +1328,6 @@ static int __loop_clr_fd(struct loop_device *lo, bool release)
 	blk_queue_physical_block_size(lo->lo_queue, 512);
 	blk_queue_io_min(lo->lo_queue, 512);
 	if (bdev) {
-		bdput(bdev);
 		invalidate_bdev(bdev);
 		bdev->bd_inode->i_mapping->wb_err = 0;
 	}
-- 
2.30.2

