Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05F0C212389
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Jul 2020 14:40:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728861AbgGBMkT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Jul 2020 08:40:19 -0400
Received: from mx2.suse.de ([195.135.220.15]:48238 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728812AbgGBMkT (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 2 Jul 2020 08:40:19 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id BB07F101DA;
        Thu,  2 Jul 2020 12:40:17 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 3/8] btrfs: Record btrfs_device directly btrfs_io_bio
Date:   Thu,  2 Jul 2020 15:23:30 +0300
Message-Id: <20200702122335.9117-4-nborisov@suse.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200702122335.9117-1-nborisov@suse.com>
References: <20200702122335.9117-1-nborisov@suse.com>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Instead of recording stripe_index and using that to access correct
btrfs_device from btrfs_bio::stripes record the btrfs_device in
btrfs_io_bio. This will enable endio handlers to increment device
error counters on checksum errors.

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 fs/btrfs/raid56.c  | 1 +
 fs/btrfs/volumes.c | 9 ++-------
 fs/btrfs/volumes.h | 2 +-
 3 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/fs/btrfs/raid56.c b/fs/btrfs/raid56.c
index c870ef70f817..4efd9ed1a30e 100644
--- a/fs/btrfs/raid56.c
+++ b/fs/btrfs/raid56.c
@@ -1117,6 +1117,7 @@ static int rbio_add_io_page(struct btrfs_raid_bio *rbio,
 
 	/* put a new bio on the list */
 	bio = btrfs_io_bio_alloc(bio_max_len >> PAGE_SHIFT ?: 1);
+	btrfs_io_bio(bio)->dev = stripe->dev;
 	bio->bi_iter.bi_size = 0;
 	bio_set_dev(bio, stripe->dev->bdev);
 	bio->bi_iter.bi_sector = disk_start >> 9;
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index aabc6c922e04..9560ac7e9ac9 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -6261,12 +6261,7 @@ static void btrfs_end_bio(struct bio *bio)
 		atomic_inc(&bbio->error);
 		if (bio->bi_status == BLK_STS_IOERR ||
 		    bio->bi_status == BLK_STS_TARGET) {
-			unsigned int stripe_index =
-				btrfs_io_bio(bio)->stripe_index;
-			struct btrfs_device *dev;
-
-			BUG_ON(stripe_index >= bbio->num_stripes);
-			dev = bbio->stripes[stripe_index].dev;
+			struct btrfs_device *dev = btrfs_io_bio(bio)->dev;
 			if (dev->bdev) {
 				if (bio_op(bio) == REQ_OP_WRITE)
 					btrfs_dev_stat_inc_and_print(dev,
@@ -6319,7 +6314,7 @@ static void submit_stripe_bio(struct btrfs_bio *bbio, struct bio *bio,
 	struct btrfs_fs_info *fs_info = bbio->fs_info;
 
 	bio->bi_private = bbio;
-	btrfs_io_bio(bio)->stripe_index = dev_nr;
+	btrfs_io_bio(bio)->dev = dev;
 	bio->bi_end_io = btrfs_end_bio;
 	bio->bi_iter.bi_sector = physical >> 9;
 	btrfs_debug_in_rcu(fs_info,
diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index 75af2334b2e3..95aa0cca21e6 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -288,7 +288,7 @@ struct btrfs_fs_devices {
  */
 struct btrfs_io_bio {
 	unsigned int mirror_num;
-	unsigned int stripe_index;
+	struct btrfs_device *dev;
 	u64 logical;
 	u8 *csum;
 	u8 csum_inline[BTRFS_BIO_INLINE_CSUM_SIZE];
-- 
2.17.1

