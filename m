Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F63F3D128E
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Jul 2021 17:36:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240000AbhGUO4R (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 21 Jul 2021 10:56:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239989AbhGUO4Q (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 21 Jul 2021 10:56:16 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19D95C061575;
        Wed, 21 Jul 2021 08:36:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=DRl1bulNVhhJ/5L26dix7DT24Us5pkiiQGPRudilNhs=; b=rToEBv1z7Mg2mPNCvC/NNgK4U0
        AsP6kuSFFEGkHuz/1MzEevB2eELnqoR4u+MlR/mIgqLDyysWWXDE91XaSNWh9OU0/Yku4WjIL54SA
        3uGwZOZl92EZcxp55K5iJ6eGtGeWhAcG6+TfyjL2B4fLUceUFeh2rQ3UOZPrN5Dyow5wUci222p2V
        ArKASUyjQ7k+dhH8xlPUakASsHZ3HBGIz+A9xhppwO14d/33LMcThOU3gdG9kMaoyyJgHiC/nSOv9
        di8utWoiBv+W0Js3rAT0weCMY/PJqPfmgzktuWSm+A+cCGhKSLbiGJHqPrBJ5hMdxuGw0tHv7KH/W
        eTq9AhNA==;
Received: from [2001:4bb8:193:7660:d6d5:72f4:23f7:1898] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m6EGo-009LCj-BI; Wed, 21 Jul 2021 15:36:32 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-block@vger.kernel.org,
        linux-btrfs@vger.kernel.org
Subject: [PATCH 3/8] block: grab a device model reference in blkdev_get_no_open
Date:   Wed, 21 Jul 2021 17:35:18 +0200
Message-Id: <20210721153523.103818-4-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210721153523.103818-1-hch@lst.de>
References: <20210721153523.103818-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Opening a block device needs to ensure it is fully present instead of
just the allocated memory.  Switch from an inode reference as obtained
by bdget to a full device model reference.

In fact we should not use inode references for anything in the block
layer.  There are three users left, two can be trivially removed
and the third (xen-blkfront) is a complete mess that needs more
attention.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/block_dev.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/fs/block_dev.c b/fs/block_dev.c
index 9ef4f1fc2cb0..24a6970f3623 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -1342,9 +1342,16 @@ struct block_device *blkdev_get_no_open(dev_t dev)
 		goto bdput;
 	if ((disk->flags & (GENHD_FL_UP | GENHD_FL_HIDDEN)) != GENHD_FL_UP)
 		goto put_disk;
-	if (!try_module_get(bdev->bd_disk->fops->owner))
+	if (!try_module_get(disk->fops->owner))
 		goto put_disk;
+
+	/* switch to a device model reference instead of the inode one: */
+	if (!kobject_get_unless_zero(&bdev->bd_device.kobj))
+		goto put_module;
+	bdput(bdev);
 	return bdev;
+put_module:
+	module_put(disk->fops->owner);
 put_disk:
 	put_disk(disk);
 bdput:
@@ -1356,7 +1363,7 @@ void blkdev_put_no_open(struct block_device *bdev)
 {
 	module_put(bdev->bd_disk->fops->owner);
 	put_disk(bdev->bd_disk);
-	bdput(bdev);
+	put_device(&bdev->bd_device);
 }
 
 /**
-- 
2.30.2

