Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6811F3D1284
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Jul 2021 17:36:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239961AbhGUOz3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 21 Jul 2021 10:55:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239960AbhGUOz2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 21 Jul 2021 10:55:28 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE5BEC061575;
        Wed, 21 Jul 2021 08:36:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=VLmrZ1nMakXrSQEwVKNiY15GTxcxuXeEsHd7IbCE5PY=; b=hcDnSX6aFOzCX0c9Xv3CT31FPt
        4QALR56bFqigBvrNjAVTaeOaYBxXPqoHX4tAYjgBzP8SpVynMUvs/RL5caIB+WawIFQ3L+en9B1Gm
        C+ySicjsz0iFPqPh36UAcLd9RwY6gD7X4Lvs2qLFctP8eVRXC7i2nr21ljcfz8yuldBt2Erz00kTl
        4LMcFmiJ8lqTqjkjyGB4i2YR8n8CRPIe1V6G41gioIfNhgFIecoPqwVMyGQbUK+R0dS9Bp3opHyE2
        QpcnucxBZLP0+wTbuEkINtt5KsB7UC2HlcoHWOCk7Icp8xZjHagNZep9p1qdU85wkRNVw2AXxriS9
        i1vH20PQ==;
Received: from [2001:4bb8:193:7660:d6d5:72f4:23f7:1898] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m6EG3-009L8K-RU; Wed, 21 Jul 2021 15:35:42 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-block@vger.kernel.org,
        linux-btrfs@vger.kernel.org
Subject: [PATCH 1/8] block: delay freeing the gendisk
Date:   Wed, 21 Jul 2021 17:35:16 +0200
Message-Id: <20210721153523.103818-2-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210721153523.103818-1-hch@lst.de>
References: <20210721153523.103818-1-hch@lst.de>
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
---
 block/genhd.c  | 3 +--
 fs/block_dev.c | 2 ++
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/block/genhd.c b/block/genhd.c
index af4d2ab4a633..e6d782714ad3 100644
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
+	bdput(disk->part0);
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

