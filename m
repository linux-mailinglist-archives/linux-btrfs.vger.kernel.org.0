Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACFEF3D4580
	for <lists+linux-btrfs@lfdr.de>; Sat, 24 Jul 2021 09:13:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234167AbhGXGdJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 24 Jul 2021 02:33:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229884AbhGXGdI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 24 Jul 2021 02:33:08 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2825FC061575;
        Sat, 24 Jul 2021 00:13:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=mbIbeGmh13wwxz96O7sSmFBmcvhWkF3OxLu0Zg4jK6s=; b=oGmShGtXef+aCVAn/ksuNtGnWK
        1ux1dlzbycqSjmBBnfbc3bELvx7GH5zaVogC5yDhkijSV+Qwvbx5RWx+eZ/26VU+aEiJ+x/sYrbaN
        oUKEldCjYliHawbhKgjRlXpjw+kyl7xWFRr/sX+eZl5rZuoP0H1AR/1tSutQ+2pxWCZtuZpRejmBI
        no0uUm1F7WpNwkfZF8G1Hm8AqGCEQxV6B0UXpLfAkcavBHyWI9ZU513sjgazliA0yytC0s7jHZEhb
        ilGa+wQTVhi+b2CadGyIKDbRU74ifU//LMSg3gYvg+04XWt91WQ5DvkdQpKx1qC0AUuOPgFur6HuN
        aP1epIlw==;
Received: from [2001:4bb8:184:87c5:85d0:a26b:ef67:d32c] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m7BqO-00C4WJ-4d; Sat, 24 Jul 2021 07:13:11 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        linux-block@vger.kernel.org, linux-btrfs@vger.kernel.org,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 01/10] block: delay freeing the gendisk
Date:   Sat, 24 Jul 2021 09:12:40 +0200
Message-Id: <20210724071249.1284585-2-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210724071249.1284585-1-hch@lst.de>
References: <20210724071249.1284585-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

blkdev_get_no_open acquires a reference to the block_device through
the block device inode and then tries to acquire a device model
reference to the gendisk.  But at this point the disk migh already
be freed (although the race is free).  Fix this by only freeing the
gendisk from the whole device bdevs ->free_inode callback as well.

Fixes: 22ae8ce8b892 ("block: simplify bdev/disk lookup in blkdev_get")
Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Reviewed-by: Ming Lei <ming.lei@redhat.com>
---
 block/genhd.c  | 3 +--
 fs/block_dev.c | 2 ++
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/block/genhd.c b/block/genhd.c
index af4d2ab4a633..298ee78c1bda 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -1079,10 +1079,9 @@ static void disk_release(struct device *dev)
 	disk_release_events(disk);
 	kfree(disk->random);
 	xa_destroy(&disk->part_tbl);
-	bdput(disk->part0);
 	if (test_bit(GD_QUEUE_REF, &disk->state) && disk->queue)
 		blk_put_queue(disk->queue);
-	kfree(disk);
+	bdput(disk->part0);	/* frees the disk */
 }
 struct class block_class = {
 	.name		= "block",
diff --git a/fs/block_dev.c b/fs/block_dev.c
index 0c424a0cadaa..9ef4f1fc2cb0 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -812,6 +812,8 @@ static void bdev_free_inode(struct inode *inode)
 	free_percpu(bdev->bd_stats);
 	kfree(bdev->bd_meta_info);
 
+	if (!bdev_is_partition(bdev))
+		kfree(bdev->bd_disk);
 	kmem_cache_free(bdev_cachep, BDEV_I(inode));
 }
 
-- 
2.30.2

