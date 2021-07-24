Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C7583D4595
	for <lists+linux-btrfs@lfdr.de>; Sat, 24 Jul 2021 09:20:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234202AbhGXGfq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 24 Jul 2021 02:35:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234105AbhGXGfq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 24 Jul 2021 02:35:46 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD4F7C061575;
        Sat, 24 Jul 2021 00:16:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=sDE1smBli9fitr5GnrSimnKnLNhVr/cZJ4djtZ5t7y0=; b=Gcdn4I/Yu6lNCA9K05N1e6ZfbS
        v5IzR6k1LqssgZZZDolwutJE/y1ucAiB0UZjdkdAUNHhQJlZmZva87IdSr5NuAL0Dc7UmG55lUw+R
        0HG2rUexM0bIVl48LgThK/AQ4y9BbwBRdxk4R/BAFy59ZTiMby0bLVumlY0h/X41sbSn6Nmz/GayA
        e0vUbUoK+5QBngbBpOyECADXNRDNLuknIVjoB9Kh/hY790AIVu0fg2WO4n0ADWlKdF4RhcO2vsh3k
        1vayq8Nu3uZdvFTUbyT++2rZ3noImc6hjTAvLjJJEV4c4tVpMoKAAqu4zzIwQrrJfUqy5Vh0x7vpT
        PXCqa0dw==;
Received: from [2001:4bb8:184:87c5:85d0:a26b:ef67:d32c] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m7Bsq-00C4gq-GK; Sat, 24 Jul 2021 07:15:49 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        linux-block@vger.kernel.org, linux-btrfs@vger.kernel.org,
        Chaitanya Kulkarni <ckulkarnilinux@gmail.com>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 08/10] loop: don't grab a reference to the block device
Date:   Sat, 24 Jul 2021 09:12:47 +0200
Message-Id: <20210724071249.1284585-9-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210724071249.1284585-1-hch@lst.de>
References: <20210724071249.1284585-1-hch@lst.de>
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
Reviewed-by: Chaitanya Kulkarni <ckulkarnilinux@gmail.com>
Reviewed-by: Ming Lei <ming.lei@redhat.com>
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

