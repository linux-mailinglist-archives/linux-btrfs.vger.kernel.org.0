Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C3C23D458A
	for <lists+linux-btrfs@lfdr.de>; Sat, 24 Jul 2021 09:19:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229884AbhGXGdv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 24 Jul 2021 02:33:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234176AbhGXGdv (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 24 Jul 2021 02:33:51 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28889C061757;
        Sat, 24 Jul 2021 00:14:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=ZXBsk5lN4o0pY7k/LMzIsn6c9Bn6b9We858oAiBedDs=; b=rfYL57ADdfOgsYSAfLPLx8Sg57
        D+bKHeIAalk33YR0B/g34prGkHC1NfcVZEvpuK5Nf6eDTQVIFRk/uFcbAseRruBu+IOTsI8vOgQz6
        flvqCaE6kq8Zi2QCRaFF9a4+3vpYlSvvJcXDYGMKSvLmaFEvP2MrmkyXCDFqpGaKeb+Qkj2VXCYH4
        Comkg5IqaUrjQ5zjCpv8oi2pZ7Oln5Suas0/NyNHbMHrm9MuPeQznA0uXApiMaqu+rBroAFkH/6bQ
        6NMUUuuJ0L0em60ILM8JiDPnDF7gq1W+8WOMROxpnM3MmQSeeeoSWM98+BvFX26qJUiPhzhlt3Iw1
        JLwTdL7w==;
Received: from [2001:4bb8:184:87c5:85d0:a26b:ef67:d32c] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m7Br6-00C4ZE-Sx; Sat, 24 Jul 2021 07:13:59 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        linux-block@vger.kernel.org, linux-btrfs@vger.kernel.org
Subject: [PATCH 03/10] block: unhash the block device inodes earlier
Date:   Sat, 24 Jul 2021 09:12:42 +0200
Message-Id: <20210724071249.1284585-4-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210724071249.1284585-1-hch@lst.de>
References: <20210724071249.1284585-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Unhash the block device inodes as early as possible.  This ensures that
the inode and thus block_device an't be found in the inode hash as soon
as we start deleting the disk, instead of finding it and rejecting it
later because GENHD_FL_UP is cleared.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/genhd.c           | 8 ++------
 block/partitions/core.c | 8 ++------
 2 files changed, 4 insertions(+), 12 deletions(-)

diff --git a/block/genhd.c b/block/genhd.c
index 298ee78c1bda..7b4beadaa694 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -581,6 +581,8 @@ void del_gendisk(struct gendisk *disk)
 	if (WARN_ON_ONCE(!disk->queue))
 		return;
 
+	remove_inode_hash(disk->part0->bd_inode);
+
 	blk_integrity_del(disk);
 	disk_del_events(disk);
 
@@ -592,12 +594,6 @@ void del_gendisk(struct gendisk *disk)
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
diff --git a/block/partitions/core.c b/block/partitions/core.c
index 9902b1635b7d..4540232e68f9 100644
--- a/block/partitions/core.c
+++ b/block/partitions/core.c
@@ -285,6 +285,8 @@ static void delete_partition(struct block_device *part)
 {
 	lockdep_assert_held(&part->bd_disk->open_mutex);
 
+	remove_inode_hash(part->bd_inode);
+
 	fsync_bdev(part);
 	__invalidate_device(part, true);
 
@@ -292,12 +294,6 @@ static void delete_partition(struct block_device *part)
 	kobject_put(part->bd_holder_dir);
 	device_del(&part->bd_device);
 
-	/*
-	 * Remove the block device from the inode hash, so that it cannot be
-	 * looked up any more even when openers still hold references.
-	 */
-	remove_inode_hash(part->bd_inode);
-
 	put_device(&part->bd_device);
 }
 
-- 
2.30.2

