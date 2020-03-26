Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C95591949B0
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Mar 2020 22:03:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727352AbgCZVDW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 26 Mar 2020 17:03:22 -0400
Received: from mx2.suse.de ([195.135.220.15]:40300 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726034AbgCZVDW (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 26 Mar 2020 17:03:22 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id E8AC4AFDF;
        Thu, 26 Mar 2020 21:03:20 +0000 (UTC)
From:   Goldwyn Rodrigues <rgoldwyn@suse.de>
To:     linux-btrfs@vger.kernel.org
Cc:     Goldwyn Rodrigues <rgoldwyn@suse.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Nikolay Borisov <nborisov@suse.com>,
        Christoph Hellwig <hch@lst.de>,
        "Darrick J . Wong" <darrick.wong@oracle.com>
Subject: [PATCH 2/9] iomap: add a filesystem hook for direct I/O bio submission
Date:   Thu, 26 Mar 2020 16:02:47 -0500
Message-Id: <20200326210254.17647-3-rgoldwyn@suse.de>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200326210254.17647-1-rgoldwyn@suse.de>
References: <20200326210254.17647-1-rgoldwyn@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Goldwyn Rodrigues <rgoldwyn@suse.com>

This helps filesystems to perform tasks on the bio while submitting for
I/O. This could be post-write operations such as data CRC or data
replication for fs-handled RAID.

Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
Reviewed-by: Johannes Thumshirn <jthumshirn@suse.de>
Reviewed-by: Nikolay Borisov <nborisov@suse.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>
---
 fs/iomap/direct-io.c  | 15 ++++++++++-----
 include/linux/iomap.h |  2 ++
 2 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
index 23837926c0c5..63967fbd8b32 100644
--- a/fs/iomap/direct-io.c
+++ b/fs/iomap/direct-io.c
@@ -59,7 +59,7 @@ int iomap_dio_iopoll(struct kiocb *kiocb, bool spin)
 EXPORT_SYMBOL_GPL(iomap_dio_iopoll);
 
 static void iomap_dio_submit_bio(struct iomap_dio *dio, struct iomap *iomap,
-		struct bio *bio)
+		struct bio *bio, loff_t pos)
 {
 	atomic_inc(&dio->ref);
 
@@ -67,7 +67,12 @@ static void iomap_dio_submit_bio(struct iomap_dio *dio, struct iomap *iomap,
 		bio_set_polled(bio, dio->iocb);
 
 	dio->submit.last_queue = bdev_get_queue(iomap->bdev);
-	dio->submit.cookie = submit_bio(bio);
+	if (dio->dops && dio->dops->submit_io)
+		dio->submit.cookie = dio->dops->submit_io(
+				file_inode(dio->iocb->ki_filp),
+				iomap, bio, pos);
+	else
+		dio->submit.cookie = submit_bio(bio);
 }
 
 static ssize_t iomap_dio_complete(struct iomap_dio *dio)
@@ -191,7 +196,7 @@ iomap_dio_zero(struct iomap_dio *dio, struct iomap *iomap, loff_t pos,
 	get_page(page);
 	__bio_add_page(bio, page, len, 0);
 	bio_set_op_attrs(bio, REQ_OP_WRITE, flags);
-	iomap_dio_submit_bio(dio, iomap, bio);
+	iomap_dio_submit_bio(dio, iomap, bio, pos);
 }
 
 static loff_t
@@ -299,11 +304,11 @@ iomap_dio_bio_actor(struct inode *inode, loff_t pos, loff_t length,
 		}
 
 		dio->size += n;
-		pos += n;
 		copied += n;
 
 		nr_pages = iov_iter_npages(dio->submit.iter, BIO_MAX_PAGES);
-		iomap_dio_submit_bio(dio, iomap, bio);
+		iomap_dio_submit_bio(dio, iomap, bio, pos);
+		pos += n;
 	} while (nr_pages);
 
 	/*
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index 8b09463dae0d..5b4875344874 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -252,6 +252,8 @@ int iomap_writepages(struct address_space *mapping,
 struct iomap_dio_ops {
 	int (*end_io)(struct kiocb *iocb, ssize_t size, int error,
 		      unsigned flags);
+	blk_qc_t (*submit_io)(struct inode *inode, struct iomap *iomap,
+			struct bio *bio, loff_t file_offset);
 };
 
 ssize_t iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
-- 
2.25.0

