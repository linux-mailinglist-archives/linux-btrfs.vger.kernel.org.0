Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 355C33D1F67
	for <lists+linux-btrfs@lfdr.de>; Thu, 22 Jul 2021 09:56:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230252AbhGVHPo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 22 Jul 2021 03:15:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230051AbhGVHPn (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 22 Jul 2021 03:15:43 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A220C061575;
        Thu, 22 Jul 2021 00:56:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=MrfK/pd5lPQFMuYt8109e1DhxgFkWG+yvxPoVqeqKHA=; b=pRwAsf64NNSNbBkDc8qMhyeiTn
        GSacmQ+fEufEU/3Yaf8nuJw0fexDhSeLxbi2RNLjh88L78e6QvSOD6RTXhc7yRqUp7URyjH0r5Vr5
        yDLaccNUna4LzsdV6v20U/I0rqpY32FO+uhnWv8qlUzd9bHPO8amw3ijNmMZ91QSCmDSvIHnHvZEF
        zKacZMSEvTc45Y7p+VuvgdNTCN2aL0yToAP9QZA4KROXJ7mJz6leldCyom0tDjSPYnokVZHRhd5eb
        qM/Ao33Wlgh3R9r+URaAeenGE2YMts9sC1cfcOFo1O0VH6/h3KHtVt8jIAjrd4tlCu8oCXoV0hnVM
        VypbQzEQ==;
Received: from [2001:4bb8:193:7660:643c:9899:473:314a] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m6TXz-00A1I8-Tm; Thu, 22 Jul 2021 07:55:31 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        linux-block@vger.kernel.org, linux-btrfs@vger.kernel.org
Subject: [PATCH 3/9] block: unhash the whole device inode earlier
Date:   Thu, 22 Jul 2021 09:53:56 +0200
Message-Id: <20210722075402.983367-4-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210722075402.983367-1-hch@lst.de>
References: <20210722075402.983367-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Unhash the whole device inode early in del_gendisk.  This allows to
remove the first GENHD_FL_UP check in the open path as we simply
won't find a just removed inode.  The second non-racy check after
taking open_mutex is still kept.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/genhd.c  | 7 +------
 fs/block_dev.c | 2 +-
 2 files changed, 2 insertions(+), 7 deletions(-)

diff --git a/block/genhd.c b/block/genhd.c
index 298ee78c1bda..716f5ca479ad 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -585,6 +585,7 @@ void del_gendisk(struct gendisk *disk)
 	disk_del_events(disk);
 
 	mutex_lock(&disk->open_mutex);
+	remove_inode_hash(disk->part0->bd_inode);
 	disk->flags &= ~GENHD_FL_UP;
 	blk_drop_partitions(disk);
 	mutex_unlock(&disk->open_mutex);
@@ -592,12 +593,6 @@ void del_gendisk(struct gendisk *disk)
 	fsync_bdev(disk->part0);
 	__invalidate_device(disk->part0, true);
 
-	/*
-	 * Unhash the bdev inode for this device so that it can't be looked
-	 * up any more even if openers still hold references to it.
-	 */
-	remove_inode_hash(disk->part0->bd_inode);
-
 	set_capacity(disk, 0);
 
 	if (!(disk->flags & GENHD_FL_HIDDEN)) {
diff --git a/fs/block_dev.c b/fs/block_dev.c
index 9ef4f1fc2cb0..932f4034ad66 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -1340,7 +1340,7 @@ struct block_device *blkdev_get_no_open(dev_t dev)
 	disk = bdev->bd_disk;
 	if (!kobject_get_unless_zero(&disk_to_dev(disk)->kobj))
 		goto bdput;
-	if ((disk->flags & (GENHD_FL_UP | GENHD_FL_HIDDEN)) != GENHD_FL_UP)
+	if (disk->flags & GENHD_FL_HIDDEN)
 		goto put_disk;
 	if (!try_module_get(bdev->bd_disk->fops->owner))
 		goto put_disk;
-- 
2.30.2

