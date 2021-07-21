Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB6E83D1292
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Jul 2021 17:37:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239963AbhGUO4p (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 21 Jul 2021 10:56:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239918AbhGUO4p (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 21 Jul 2021 10:56:45 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D708CC061575;
        Wed, 21 Jul 2021 08:37:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=+w6Rr29gIDk1wNuKf/xpu4+rFnUzeOZNDDXP8f8bW9U=; b=Rw5l3PlGp4XxSakzIu+g5R5gmt
        U5qpVXZXnQftGMGjO4ZLs0lumQp4Zq0sdp6+zbmn2Jj0VSyzx4MZIbLQe7WKhN4in2cpvoPTDQl8E
        Qjh3CDyuazQ7Ce6Tbv9pguNgbx7N5fRMPBPHoxgqKPOShWIJpzwnwC5B8o7P9bk2tQ/rhVhuF8ZOy
        My5wEZam4Bw95XaEaWJ8Nvz1irIDbm2Xs5y7gwNbn64LO8gMO8swfduPwJ5K4iGq3LJ5e8aYaW8MZ
        XGF9GoUJvu0nRQyHqEighZMEIxwuMeRR3Oqdlyr135jtgoHQyr13zh2+yItJLmRIcfJjBz6QJzyxZ
        NiIqLiPw==;
Received: from [2001:4bb8:193:7660:d6d5:72f4:23f7:1898] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m6EHB-009LEm-OC; Wed, 21 Jul 2021 15:36:53 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-block@vger.kernel.org,
        linux-btrfs@vger.kernel.org
Subject: [PATCH 4/8] block: don't grab a reference to the whole device in blkdev_get_part
Date:   Wed, 21 Jul 2021 17:35:19 +0200
Message-Id: <20210721153523.103818-5-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210721153523.103818-1-hch@lst.de>
References: <20210721153523.103818-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

blkdev_get_no_open already acquires a reference to the disk, which has
the same effect as the disk keeps a reference on the whole device bdev.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/block_dev.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/fs/block_dev.c b/fs/block_dev.c
index 24a6970f3623..7de519dcfdff 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -1282,16 +1282,14 @@ static void blkdev_put_whole(struct block_device *bdev, fmode_t mode)
 static int blkdev_get_part(struct block_device *part, fmode_t mode)
 {
 	struct gendisk *disk = part->bd_disk;
-	struct block_device *whole;
 	int ret;
 
 	if (part->bd_openers)
 		goto done;
 
-	whole = bdgrab(disk->part0);
-	ret = blkdev_get_whole(whole, mode);
+	ret = blkdev_get_whole(bdev_whole(part), mode);
 	if (ret)
-		goto out_put_whole;
+		return ret;
 
 	ret = -ENXIO;
 	if (!bdev_nr_sectors(part))
@@ -1306,9 +1304,7 @@ static int blkdev_get_part(struct block_device *part, fmode_t mode)
 	return 0;
 
 out_blkdev_put:
-	blkdev_put_whole(whole, mode);
-out_put_whole:
-	bdput(whole);
+	blkdev_put_whole(bdev_whole(part), mode);
 	return ret;
 }
 
@@ -1321,7 +1317,6 @@ static void blkdev_put_part(struct block_device *part, fmode_t mode)
 	blkdev_flush_mapping(part);
 	whole->bd_disk->open_partitions--;
 	blkdev_put_whole(whole, mode);
-	bdput(whole);
 }
 
 struct block_device *blkdev_get_no_open(dev_t dev)
-- 
2.30.2

