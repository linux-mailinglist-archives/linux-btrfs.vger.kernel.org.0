Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A0C1211C16B
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Dec 2019 01:32:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727433AbfLLAbE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 11 Dec 2019 19:31:04 -0500
Received: from mx2.suse.de ([195.135.220.15]:42252 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727356AbfLLAbC (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 11 Dec 2019 19:31:02 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 6BA29ACF2;
        Thu, 12 Dec 2019 00:31:00 +0000 (UTC)
From:   Goldwyn Rodrigues <rgoldwyn@suse.de>
To:     linux-btrfs@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, hch@infradead.org,
        darrick.wong@oracle.com, fdmanana@kernel.org, dsterba@suse.cz,
        jthumshirn@suse.de, nborisov@suse.com,
        Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: [PATCH 5/8] fs: Remove dio_end_io()
Date:   Wed, 11 Dec 2019 18:30:40 -0600
Message-Id: <20191212003043.31093-6-rgoldwyn@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20191212003043.31093-1-rgoldwyn@suse.de>
References: <20191212003043.31093-1-rgoldwyn@suse.de>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Goldwyn Rodrigues <rgoldwyn@suse.com>

Since we removed the last user of dio_end_io(), remove the helper
function dio_end_io().

Reviewed-by: Nikolay Borisov <nborisov@suse.com>
Reviewed-by: Johannes Thumshirn <jthumshirn@suse.de>
Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
---
 fs/direct-io.c     | 19 -------------------
 include/linux/fs.h |  2 --
 2 files changed, 21 deletions(-)

diff --git a/fs/direct-io.c b/fs/direct-io.c
index 0ec4f270139f..fb19a77bec22 100644
--- a/fs/direct-io.c
+++ b/fs/direct-io.c
@@ -384,25 +384,6 @@ static void dio_bio_end_io(struct bio *bio)
 	spin_unlock_irqrestore(&dio->bio_lock, flags);
 }
 
-/**
- * dio_end_io - handle the end io action for the given bio
- * @bio: The direct io bio thats being completed
- *
- * This is meant to be called by any filesystem that uses their own dio_submit_t
- * so that the DIO specific endio actions are dealt with after the filesystem
- * has done it's completion work.
- */
-void dio_end_io(struct bio *bio)
-{
-	struct dio *dio = bio->bi_private;
-
-	if (dio->is_async)
-		dio_bio_end_aio(bio);
-	else
-		dio_bio_end_io(bio);
-}
-EXPORT_SYMBOL_GPL(dio_end_io);
-
 static inline void
 dio_bio_alloc(struct dio *dio, struct dio_submit *sdio,
 	      struct block_device *bdev,
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 3883adaa0e01..d708422f77e0 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3157,8 +3157,6 @@ enum {
 	DIO_SKIP_HOLES	= 0x02,
 };
 
-void dio_end_io(struct bio *bio);
-
 ssize_t __blockdev_direct_IO(struct kiocb *iocb, struct inode *inode,
 			     struct block_device *bdev, struct iov_iter *iter,
 			     get_block_t get_block,
-- 
2.16.4

