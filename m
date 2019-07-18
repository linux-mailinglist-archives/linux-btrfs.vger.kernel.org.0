Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 41A156C949
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Jul 2019 08:28:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726703AbfGRG1z (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 18 Jul 2019 02:27:55 -0400
Received: from mx2.suse.de ([195.135.220.15]:50744 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726450AbfGRG1y (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 18 Jul 2019 02:27:54 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id C7620ADF1
        for <linux-btrfs@vger.kernel.org>; Thu, 18 Jul 2019 06:27:53 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: Allow more disks missing for RAID10
Date:   Thu, 18 Jul 2019 14:27:49 +0800
Message-Id: <20190718062749.11276-1-wqu@suse.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

RAID10 can accept as much as half of its disks to be missing, as long as
each sub stripe still has a good mirror.

Thanks to the per-chunk degradable check, we can handle it pretty easily
now.

So Add this special check for RAID10, to allow user to be creative
(or crazy) using btrfs RAID10.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/volumes.c | 45 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index f209127a8bc6..65b10d13fc2d 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -7088,6 +7088,42 @@ int btrfs_read_sys_array(struct btrfs_fs_info *fs_info)
 	return -EIO;
 }
 
+static bool check_raid10_rw_degradable(struct btrfs_fs_info *fs_info,
+				       struct extent_map *em)
+{
+	struct map_lookup *map = em->map_lookup;
+	int sub_stripes = map->sub_stripes;
+	int num_stripes = map->num_stripes;
+	int tolerance = 1;
+	int i, j;
+
+	ASSERT(sub_stripes == 2);
+	ASSERT(num_stripes % sub_stripes == 0);
+	/*
+	 * Check substripes as a group, in each group we need to
+	 * have at least one good mirror;
+	 */
+	for (i = 0; i < num_stripes / sub_stripes; i ++) {
+		int missing = 0;
+		for (j = 0; j < sub_stripes; j++) {
+			struct btrfs_device *dev = map->stripes[i * 2 + j].dev;
+
+			if (!dev || !dev->bdev ||
+			    test_bit(BTRFS_DEV_STATE_MISSING, &dev->dev_state) ||
+			    dev->last_flush_error)
+				missing++;
+		}
+		if (missing > tolerance) {
+			btrfs_warn(fs_info,
+"chunk %llu stripes %d,%d missing %d devices, max tolerance is %d for writable mount",
+				   em->start, i, i + sub_stripes - 1, missing,
+				   tolerance);
+			return false;
+		}
+	}
+	return true;
+}
+
 /*
  * Check if all chunks in the fs are OK for read-write degraded mount
  *
@@ -7119,6 +7155,14 @@ bool btrfs_check_rw_degradable(struct btrfs_fs_info *fs_info,
 		int i;
 
 		map = em->map_lookup;
+		if (map->type & BTRFS_BLOCK_GROUP_RAID10) {
+			ret = check_raid10_rw_degradable(fs_info, em);
+			if (!ret) {
+				free_extent_map(em);
+				goto out;
+			}
+			goto next;
+		}
 		max_tolerated =
 			btrfs_get_num_tolerated_disk_barrier_failures(
 					map->type);
@@ -7141,6 +7185,7 @@ bool btrfs_check_rw_degradable(struct btrfs_fs_info *fs_info,
 			ret = false;
 			goto out;
 		}
+next:
 		next_start = extent_map_end(em);
 		free_extent_map(em);
 
-- 
2.22.0

