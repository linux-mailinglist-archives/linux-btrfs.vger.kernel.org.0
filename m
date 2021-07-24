Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4877C3D4593
	for <lists+linux-btrfs@lfdr.de>; Sat, 24 Jul 2021 09:20:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234171AbhGXGf3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 24 Jul 2021 02:35:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234105AbhGXGf2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 24 Jul 2021 02:35:28 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1896BC061575;
        Sat, 24 Jul 2021 00:16:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=UbJH2uNi4xkqJoAv1o4QkFE0/x91fO1Ho7MrY00dYvU=; b=ib4pjvnOreEAZYQnMKAotapcdU
        Sps3mst3InmDaNy9LMM420eSe3BiIoPLAt7lZLUgOuQEbXby1xOIlGWO39Vfcf/n9u6YvrbXvGnY/
        jz7QnhDkz5nZmKlt6DVjT4sr3hU/1CjI7GqnXwZ4yCcgW+HyGwRFxsZda2X3y9+rA5Z3hL53xLFOs
        3p7/y2h2q3XKRxTVvHsFt2fjpjAF37VH+7y6T8BLw/g1wuvNGRmmUb5l3mP7HYvMCAA/TdkPS9eDj
        4/mAuXHxFdWdEHGme5W+AyCQHrzgHW/QJTzEUSJy4iMPQ1XZrePQbA0d9XCHHPjr5HOnBs0x0NaZo
        xcLmORvA==;
Received: from [2001:4bb8:184:87c5:85d0:a26b:ef67:d32c] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m7BsI-00C4fA-1V; Sat, 24 Jul 2021 07:15:14 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        linux-block@vger.kernel.org, linux-btrfs@vger.kernel.org
Subject: [PATCH 07/10] btrfs: store a block_device in struct btrfs_ordered_extent
Date:   Sat, 24 Jul 2021 09:12:46 +0200
Message-Id: <20210724071249.1284585-8-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210724071249.1284585-1-hch@lst.de>
References: <20210724071249.1284585-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Store the block device instead of the gendisk in the btrfs_ordered_extent
structure intead of acquiring a reference to it later.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/inode.c        |  2 +-
 fs/btrfs/ordered-data.c |  2 --
 fs/btrfs/ordered-data.h |  3 +--
 fs/btrfs/zoned.c        | 12 ++++--------
 4 files changed, 6 insertions(+), 13 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 8f60314c36c5..0117d867ecf8 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -2992,7 +2992,7 @@ static int btrfs_finish_ordered_io(struct btrfs_ordered_extent *ordered_extent)
 		goto out;
 	}
 
-	if (ordered_extent->disk)
+	if (ordered_extent->bdev)
 		btrfs_rewrite_logical_zoned(ordered_extent);
 
 	btrfs_free_io_failure_record(inode, start, end);
diff --git a/fs/btrfs/ordered-data.c b/fs/btrfs/ordered-data.c
index 6eb41b7c0c84..5c0f8481e25e 100644
--- a/fs/btrfs/ordered-data.c
+++ b/fs/btrfs/ordered-data.c
@@ -190,8 +190,6 @@ static int __btrfs_add_ordered_extent(struct btrfs_inode *inode, u64 file_offset
 	entry->truncated_len = (u64)-1;
 	entry->qgroup_rsv = ret;
 	entry->physical = (u64)-1;
-	entry->disk = NULL;
-	entry->partno = (u8)-1;
 
 	ASSERT(type == BTRFS_ORDERED_REGULAR ||
 	       type == BTRFS_ORDERED_NOCOW ||
diff --git a/fs/btrfs/ordered-data.h b/fs/btrfs/ordered-data.h
index 566472004edd..b2d88aba8420 100644
--- a/fs/btrfs/ordered-data.h
+++ b/fs/btrfs/ordered-data.h
@@ -145,8 +145,7 @@ struct btrfs_ordered_extent {
 	 * command in a workqueue context
 	 */
 	u64 physical;
-	struct gendisk *disk;
-	u8 partno;
+	struct block_device *bdev;
 };
 
 /*
diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index 297c0b1c0634..907c2cc45c9c 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -1349,8 +1349,7 @@ void btrfs_record_physical_zoned(struct inode *inode, u64 file_offset,
 		return;
 
 	ordered->physical = physical;
-	ordered->disk = bio->bi_bdev->bd_disk;
-	ordered->partno = bio->bi_bdev->bd_partno;
+	ordered->bdev = bio->bi_bdev;
 
 	btrfs_put_ordered_extent(ordered);
 }
@@ -1362,18 +1361,16 @@ void btrfs_rewrite_logical_zoned(struct btrfs_ordered_extent *ordered)
 	struct extent_map_tree *em_tree;
 	struct extent_map *em;
 	struct btrfs_ordered_sum *sum;
-	struct block_device *bdev;
 	u64 orig_logical = ordered->disk_bytenr;
 	u64 *logical = NULL;
 	int nr, stripe_len;
 
 	/* Zoned devices should not have partitions. So, we can assume it is 0 */
-	ASSERT(ordered->partno == 0);
-	bdev = bdgrab(ordered->disk->part0);
-	if (WARN_ON(!bdev))
+	ASSERT(!bdev_is_partition(ordered->bdev));
+	if (WARN_ON(!ordered->bdev))
 		return;
 
-	if (WARN_ON(btrfs_rmap_block(fs_info, orig_logical, bdev,
+	if (WARN_ON(btrfs_rmap_block(fs_info, orig_logical, ordered->bdev,
 				     ordered->physical, &logical, &nr,
 				     &stripe_len)))
 		goto out;
@@ -1402,7 +1399,6 @@ void btrfs_rewrite_logical_zoned(struct btrfs_ordered_extent *ordered)
 
 out:
 	kfree(logical);
-	bdput(bdev);
 }
 
 bool btrfs_check_meta_write_pointer(struct btrfs_fs_info *fs_info,
-- 
2.30.2

