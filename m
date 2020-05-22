Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F06A1DE70D
	for <lists+linux-btrfs@lfdr.de>; Fri, 22 May 2020 14:39:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729492AbgEVMjK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 22 May 2020 08:39:10 -0400
Received: from mx2.suse.de ([195.135.220.15]:59158 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728801AbgEVMjJ (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 22 May 2020 08:39:09 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 8E46FAEDA;
        Fri, 22 May 2020 12:39:11 +0000 (UTC)
From:   Goldwyn Rodrigues <rgoldwyn@suse.de>
To:     linux-btrfs@vger.kernel.org
Cc:     hch@infradead.org, dsterba@suse.cz,
        Goldwyn Rodrigues <rgoldwyn@suse.com>,
        Nikolay Borisov <nborisov@suse.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH 5/7] fs: Remove dio_end_io()
Date:   Fri, 22 May 2020 07:38:35 -0500
Message-Id: <20200522123837.1196-6-rgoldwyn@suse.de>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200522123837.1196-1-rgoldwyn@suse.de>
References: <20200522123837.1196-1-rgoldwyn@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Goldwyn Rodrigues <rgoldwyn@suse.com>

Since we removed the last user of dio_end_io(), remove the helper
function dio_end_io().

Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
Reviewed-by: Nikolay Borisov <nborisov@suse.com>
Reviewed-by: Johannes Thumshirn <jthumshirn@suse.de>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 fs/direct-io.c     | 19 -------------------
 include/linux/fs.h |  2 --
 2 files changed, 21 deletions(-)

diff --git a/fs/direct-io.c b/fs/direct-io.c
index 00b4d15bb811..c44d60f375bc 100644
--- a/fs/direct-io.c
+++ b/fs/direct-io.c
@@ -386,25 +386,6 @@ static void dio_bio_end_io(struct bio *bio)
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
index 366c533d30cd..e84623d5e173 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3187,8 +3187,6 @@ enum {
 	DIO_SKIP_HOLES	= 0x02,
 };
 
-void dio_end_io(struct bio *bio);
-
 ssize_t __blockdev_direct_IO(struct kiocb *iocb, struct inode *inode,
 			     struct block_device *bdev, struct iov_iter *iter,
 			     get_block_t get_block,
-- 
2.25.0

