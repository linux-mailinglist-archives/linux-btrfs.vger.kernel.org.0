Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E3813D1F6B
	for <lists+linux-btrfs@lfdr.de>; Thu, 22 Jul 2021 09:56:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230365AbhGVHQL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 22 Jul 2021 03:16:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230048AbhGVHQL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 22 Jul 2021 03:16:11 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4B94C061575;
        Thu, 22 Jul 2021 00:56:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=EgPA2g5HAtaj6T3/K33bbshvzBgDm7uDiBhDmQ9TnQ4=; b=vbuupET/tRtwz0C+qHCZRlbcVK
        aitT88opultPqb5dyI6ooq+DZawvoKEcYTDpSpHhcCo5rxSVc0p/Be0H/j0ohw4wwoEZHgH/agJkH
        SuT9XGaBsWtvwTGiMmbbychXzOerpPdWXPegWAU2SpPK8u1NxmqFJ9TmV1NXMWZgzazJDFuuhTfUu
        mvBChB1ukV+IrJkyNEf9XV4J+X37keXqc9uX4P3PpPBxrf6JI1M2MfcObMdsykWrM7p3i/YUk8L7X
        qi7onvZfYrbYz49eD9dvFu6Iw/Bi1huhLNTBygNPb2jj2Wurgp1B7qPKnuOlT+I48GmpINvof7xXv
        S3pUNiHw==;
Received: from [2001:4bb8:193:7660:643c:9899:473:314a] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m6TYj-00A1LH-85; Thu, 22 Jul 2021 07:56:10 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        linux-block@vger.kernel.org, linux-btrfs@vger.kernel.org
Subject: [PATCH 4/9] block: allocate bd_meta_info later in add_partitions
Date:   Thu, 22 Jul 2021 09:53:57 +0200
Message-Id: <20210722075402.983367-5-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210722075402.983367-1-hch@lst.de>
References: <20210722075402.983367-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Move the allocation of bd_meta_info after initializing the struct device
to avoid the special bdput error handling path.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/partitions/core.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/block/partitions/core.c b/block/partitions/core.c
index 9902b1635b7d..09c58a110a89 100644
--- a/block/partitions/core.c
+++ b/block/partitions/core.c
@@ -356,13 +356,6 @@ static struct block_device *add_partition(struct gendisk *disk, int partno,
 	bdev->bd_start_sect = start;
 	bdev_set_nr_sectors(bdev, len);
 
-	if (info) {
-		err = -ENOMEM;
-		bdev->bd_meta_info = kmemdup(info, sizeof(*info), GFP_KERNEL);
-		if (!bdev->bd_meta_info)
-			goto out_bdput;
-	}
-
 	pdev = &bdev->bd_device;
 	dname = dev_name(ddev);
 	if (isdigit(dname[strlen(dname) - 1]))
@@ -386,6 +379,13 @@ static struct block_device *add_partition(struct gendisk *disk, int partno,
 	}
 	pdev->devt = devt;
 
+	if (info) {
+		err = -ENOMEM;
+		bdev->bd_meta_info = kmemdup(info, sizeof(*info), GFP_KERNEL);
+		if (!bdev->bd_meta_info)
+			goto out_put;
+	}
+
 	/* delay uevent until 'holders' subdir is created */
 	dev_set_uevent_suppress(pdev, 1);
 	err = device_add(pdev);
@@ -415,9 +415,6 @@ static struct block_device *add_partition(struct gendisk *disk, int partno,
 		kobject_uevent(&pdev->kobj, KOBJ_ADD);
 	return bdev;
 
-out_bdput:
-	bdput(bdev);
-	return ERR_PTR(err);
 out_del:
 	kobject_put(bdev->bd_holder_dir);
 	device_del(pdev);
-- 
2.30.2

