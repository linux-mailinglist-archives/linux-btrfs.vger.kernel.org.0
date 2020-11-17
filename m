Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E6852B5BDA
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Nov 2020 10:37:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726016AbgKQJgJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 17 Nov 2020 04:36:09 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:7553 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725747AbgKQJgI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 17 Nov 2020 04:36:08 -0500
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4Cb15j2QDvzhYBs;
        Tue, 17 Nov 2020 17:35:53 +0800 (CST)
Received: from linux-lmwb.huawei.com (10.175.103.112) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.487.0; Tue, 17 Nov 2020 17:36:00 +0800
From:   Zou Wei <zou_wei@huawei.com>
To:     <clm@fb.com>, <josef@toxicpanda.com>, <dsterba@suse.com>
CC:     <linux-btrfs@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Zou Wei <zou_wei@huawei.com>
Subject: [PATCH -next] btrfs: remove unused variable
Date:   Tue, 17 Nov 2020 17:47:43 +0800
Message-ID: <1605606463-78936-1-git-send-email-zou_wei@huawei.com>
X-Mailer: git-send-email 2.6.2
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.175.103.112]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Fix variable set but not used compilation warnings:

fs/btrfs/ctree.c:1581:6: warning: variable ‘parent_level’ set but not used [-Wunused-but-set-variable]
  int parent_level;
      ^~~~~~~~~~~~

fs/btrfs/zoned.c:503:6: warning: variable ‘zone_size’ set but not used [-Wunused-but-set-variable]
  u64 zone_size;
      ^~~~~~~~~

Signed-off-by: Zou Wei <zou_wei@huawei.com>
---
 fs/btrfs/ctree.c | 3 ---
 fs/btrfs/zoned.c | 2 --
 2 files changed, 5 deletions(-)

diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index 32a57a7..e5a0941 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -1578,13 +1578,10 @@ int btrfs_realloc_node(struct btrfs_trans_handle *trans,
 	int end_slot;
 	int i;
 	int err = 0;
-	int parent_level;
 	u32 blocksize;
 	int progress_passed = 0;
 	struct btrfs_disk_key disk_key;
 
-	parent_level = btrfs_header_level(parent);
-
 	WARN_ON(trans->transaction != fs_info->running_transaction);
 	WARN_ON(trans->transid != fs_info->generation);
 
diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index fa9cc61..742f088 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -500,7 +500,6 @@ int btrfs_sb_log_location_bdev(struct block_device *bdev, int mirror, int rw,
 	unsigned int zone_sectors;
 	u32 sb_zone;
 	int ret;
-	u64 zone_size;
 	u8 zone_sectors_shift;
 	sector_t nr_sectors = bdev->bd_part->nr_sects;
 	u32 nr_zones;
@@ -515,7 +514,6 @@ int btrfs_sb_log_location_bdev(struct block_device *bdev, int mirror, int rw,
 	zone_sectors = bdev_zone_sectors(bdev);
 	if (!is_power_of_2(zone_sectors))
 		return -EINVAL;
-	zone_size = zone_sectors << SECTOR_SHIFT;
 	zone_sectors_shift = ilog2(zone_sectors);
 	nr_zones = nr_sectors >> zone_sectors_shift;
 
-- 
2.6.2

