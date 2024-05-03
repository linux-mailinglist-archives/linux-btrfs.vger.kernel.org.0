Return-Path: <linux-btrfs+bounces-4695-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7562C8BA5B2
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 May 2024 05:24:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1552B1F247E6
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 May 2024 03:24:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E57B7482EE;
	Fri,  3 May 2024 03:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="AZ5Sl9mk"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 189B21C2BD;
	Fri,  3 May 2024 03:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714706622; cv=none; b=rWZaY7GZaChx1QjbhSl0w71xqENsbaZdY/0DCMNt7LGuW1N5V71cxCA9Qq7X4C4uliflUitjfQVOleIBeD9hILv3eS0eKtX2utTEIZkLcKTAs1T88IzY4wWnzC1kjfADyUD5feWMc2ELUb/Z+rE6F488ztCZbYdQ2o/uh6RKt6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714706622; c=relaxed/simple;
	bh=EnKpZp8EH9OcwGRYFLkEA8rvenKo69dO9i87wnE60sM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YxQ6SrcfCBNWSQfM3ABif9olcm62YNu2c37cL/RHp0qcVJd+tKEqc5yGNEbWcbc6b8h/yoN5GDZvSLemhti2WR0BasQtHudmMF9seWGMSSZZLVEjlf5y6vO9u816rpThGnBciZ7YWcHYVvw/fUUnD3Wm8d34wJJvZR7/41AE9IE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=AZ5Sl9mk; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=K4odIiNSqP+0H56OG+pz6+Iekw8KUZOkkGGVMptw/H8=; b=AZ5Sl9mk2C6VMA0EUFDFv0la7Z
	TtXHmpmlgN8mHgdbwczNXL7kwWhL1rP8/dQN3Jbu/kYzpXBQ/diD3zZsvViNZV4vYy28FTMnn8BcN
	GHmzeZ6c61efj8ntXWfK+9JQY+TMQzeTsHuEixMcUKUzJ6u9Mp51KJcOde6Bkjto0fYWMtgPutSML
	klMe0PxcS3QqdIB1HsHSEBq+R87m67V4J3yQDSmjECyurgQr46E6qR4wtlogXMlhR8WyUS/mIwxYG
	M/IZ1ZBkqvO8U2uPfH1ZWsBNLM3Uaa4I2TerTDrzYbKDVQa84eRmb3cVdYoDo0SF0pj9wzP8u6/bw
	3gVTT4qg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1s2jWE-00A2Vy-1H;
	Fri, 03 May 2024 03:23:30 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Christian Brauner <brauner@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	linux-block@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>,
	linux-btrfs@vger.kernel.org,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v2 5/9] zram: don't bother with reopening - just use O_EXCL for open
Date: Fri,  3 May 2024 04:23:25 +0100
Message-Id: <20240503032329.2392931-5-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240503032329.2392931-1-viro@zeniv.linux.org.uk>
References: <20240503031833.GU2118490@ZenIV>
 <20240503032329.2392931-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 drivers/block/zram/zram_drv.c | 29 +++++++----------------------
 drivers/block/zram/zram_drv.h |  2 +-
 2 files changed, 8 insertions(+), 23 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index f0639df6cd18..58c3466dcb17 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -426,11 +426,10 @@ static void reset_bdev(struct zram *zram)
 	if (!zram->backing_dev)
 		return;
 
-	fput(zram->bdev_file);
 	/* hope filp_close flush all of IO */
 	filp_close(zram->backing_dev, NULL);
 	zram->backing_dev = NULL;
-	zram->bdev_file = NULL;
+	zram->bdev = NULL;
 	zram->disk->fops = &zram_devops;
 	kvfree(zram->bitmap);
 	zram->bitmap = NULL;
@@ -473,10 +472,8 @@ static ssize_t backing_dev_store(struct device *dev,
 	size_t sz;
 	struct file *backing_dev = NULL;
 	struct inode *inode;
-	struct address_space *mapping;
 	unsigned int bitmap_sz;
 	unsigned long nr_pages, *bitmap = NULL;
-	struct file *bdev_file = NULL;
 	int err;
 	struct zram *zram = dev_to_zram(dev);
 
@@ -497,15 +494,14 @@ static ssize_t backing_dev_store(struct device *dev,
 	if (sz > 0 && file_name[sz - 1] == '\n')
 		file_name[sz - 1] = 0x00;
 
-	backing_dev = filp_open(file_name, O_RDWR|O_LARGEFILE, 0);
+	backing_dev = filp_open(file_name, O_RDWR | O_LARGEFILE | O_EXCL, 0);
 	if (IS_ERR(backing_dev)) {
 		err = PTR_ERR(backing_dev);
 		backing_dev = NULL;
 		goto out;
 	}
 
-	mapping = backing_dev->f_mapping;
-	inode = mapping->host;
+	inode = backing_dev->f_mapping->host;
 
 	/* Support only block device in this moment */
 	if (!S_ISBLK(inode->i_mode)) {
@@ -513,14 +509,6 @@ static ssize_t backing_dev_store(struct device *dev,
 		goto out;
 	}
 
-	bdev_file = bdev_file_open_by_dev(inode->i_rdev,
-				BLK_OPEN_READ | BLK_OPEN_WRITE, zram, NULL);
-	if (IS_ERR(bdev_file)) {
-		err = PTR_ERR(bdev_file);
-		bdev_file = NULL;
-		goto out;
-	}
-
 	nr_pages = i_size_read(inode) >> PAGE_SHIFT;
 	bitmap_sz = BITS_TO_LONGS(nr_pages) * sizeof(long);
 	bitmap = kvzalloc(bitmap_sz, GFP_KERNEL);
@@ -531,7 +519,7 @@ static ssize_t backing_dev_store(struct device *dev,
 
 	reset_bdev(zram);
 
-	zram->bdev_file = bdev_file;
+	zram->bdev = I_BDEV(inode);
 	zram->backing_dev = backing_dev;
 	zram->bitmap = bitmap;
 	zram->nr_pages = nr_pages;
@@ -544,9 +532,6 @@ static ssize_t backing_dev_store(struct device *dev,
 out:
 	kvfree(bitmap);
 
-	if (bdev_file)
-		fput(bdev_file);
-
 	if (backing_dev)
 		filp_close(backing_dev, NULL);
 
@@ -587,7 +572,7 @@ static void read_from_bdev_async(struct zram *zram, struct page *page,
 {
 	struct bio *bio;
 
-	bio = bio_alloc(file_bdev(zram->bdev_file), 1, parent->bi_opf, GFP_NOIO);
+	bio = bio_alloc(zram->bdev, 1, parent->bi_opf, GFP_NOIO);
 	bio->bi_iter.bi_sector = entry * (PAGE_SIZE >> 9);
 	__bio_add_page(bio, page, PAGE_SIZE, 0);
 	bio_chain(bio, parent);
@@ -703,7 +688,7 @@ static ssize_t writeback_store(struct device *dev,
 			continue;
 		}
 
-		bio_init(&bio, file_bdev(zram->bdev_file), &bio_vec, 1,
+		bio_init(&bio, zram->bdev, &bio_vec, 1,
 			 REQ_OP_WRITE | REQ_SYNC);
 		bio.bi_iter.bi_sector = blk_idx * (PAGE_SIZE >> 9);
 		__bio_add_page(&bio, page, PAGE_SIZE, 0);
@@ -785,7 +770,7 @@ static void zram_sync_read(struct work_struct *work)
 	struct bio_vec bv;
 	struct bio bio;
 
-	bio_init(&bio, file_bdev(zw->zram->bdev_file), &bv, 1, REQ_OP_READ);
+	bio_init(&bio, zw->zram->bdev, &bv, 1, REQ_OP_READ);
 	bio.bi_iter.bi_sector = zw->entry * (PAGE_SIZE >> 9);
 	__bio_add_page(&bio, zw->page, PAGE_SIZE, 0);
 	zw->error = submit_bio_wait(&bio);
diff --git a/drivers/block/zram/zram_drv.h b/drivers/block/zram/zram_drv.h
index 37bf29f34d26..35e322144629 100644
--- a/drivers/block/zram/zram_drv.h
+++ b/drivers/block/zram/zram_drv.h
@@ -132,7 +132,7 @@ struct zram {
 	spinlock_t wb_limit_lock;
 	bool wb_limit_enable;
 	u64 bd_wb_limit;
-	struct file *bdev_file;
+	struct block_device *bdev;
 	unsigned long *bitmap;
 	unsigned long nr_pages;
 #endif
-- 
2.39.2


