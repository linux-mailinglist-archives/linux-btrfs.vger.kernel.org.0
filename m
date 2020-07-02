Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16F8C2123AF
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Jul 2020 14:51:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728966AbgGBMvN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Jul 2020 08:51:13 -0400
Received: from mx2.suse.de ([195.135.220.15]:36986 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728851AbgGBMvN (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 2 Jul 2020 08:51:13 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 4D8F6B219A;
        Thu,  2 Jul 2020 12:51:12 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 4/8] btrfs: Don't check for btrfs_device::bdev in btrfs_end_bio
Date:   Thu,  2 Jul 2020 15:23:31 +0300
Message-Id: <20200702122335.9117-5-nborisov@suse.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200702122335.9117-1-nborisov@suse.com>
References: <20200702122335.9117-1-nborisov@suse.com>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

btrfs_map_bio ensures that all submitted bios to devices have valid
btrfs_device::bdev so this check can be removed from btrfs_end_bio. This
check was added in june 2012 597a60fadedf ("Btrfs: don't count I/O
statistic read errors for missing devices")  but then in October of the
same year another commit de1ee92ac3bc ("Btrfs: recheck bio against
block device when we map the bio") started checking for the presence of
btrfs_device::bdev before actually issuing the bio.

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 fs/btrfs/volumes.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 9560ac7e9ac9..cb9883c7f8b7 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -6262,17 +6262,16 @@ static void btrfs_end_bio(struct bio *bio)
 		if (bio->bi_status == BLK_STS_IOERR ||
 		    bio->bi_status == BLK_STS_TARGET) {
 			struct btrfs_device *dev = btrfs_io_bio(bio)->dev;
-			if (dev->bdev) {
-				if (bio_op(bio) == REQ_OP_WRITE)
-					btrfs_dev_stat_inc_and_print(dev,
+			ASSERT(dev->bdev);
+			if (bio_op(bio) == REQ_OP_WRITE)
+				btrfs_dev_stat_inc_and_print(dev,
 						BTRFS_DEV_STAT_WRITE_ERRS);
-				else if (!(bio->bi_opf & REQ_RAHEAD))
-					btrfs_dev_stat_inc_and_print(dev,
+			else if (!(bio->bi_opf & REQ_RAHEAD))
+				btrfs_dev_stat_inc_and_print(dev,
 						BTRFS_DEV_STAT_READ_ERRS);
-				if (bio->bi_opf & REQ_PREFLUSH)
-					btrfs_dev_stat_inc_and_print(dev,
+			if (bio->bi_opf & REQ_PREFLUSH)
+				btrfs_dev_stat_inc_and_print(dev,
 						BTRFS_DEV_STAT_FLUSH_ERRS);
-			}
 		}
 	}
 
-- 
2.17.1

