Return-Path: <linux-btrfs+bounces-3188-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A5B3A87849B
	for <lists+linux-btrfs@lfdr.de>; Mon, 11 Mar 2024 17:07:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C94001C211DD
	for <lists+linux-btrfs@lfdr.de>; Mon, 11 Mar 2024 16:07:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A26D482C4;
	Mon, 11 Mar 2024 16:07:17 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9E28482C3
	for <linux-btrfs@vger.kernel.org>; Mon, 11 Mar 2024 16:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710173236; cv=none; b=eIA0UxSoJls6NMB6K4c6YHn6pgoeC/Vmb0e3nMiR6zR8LmvA4441ECu3NjLE3y/s5En7f6/ek+hhki3+d3xrzSzDOtfm/Hd/KVWBThwNLTNnl82Sf8YB1ld19ICJ08yZUkD+gj98McrPuWNjnKDZl3p0hSioFX0huZXS9Zf3s+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710173236; c=relaxed/simple;
	bh=N9+PIuoum3ecbGs07t72uaZnDa6pTKPbJKk+rX6dMNg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=u1ocaUVKZf9wRqLMFRpht57UsPStTQl0cNh0Uem9lvwN2oZvUx5VPhQS9L/mwIfCrmisx3R/OZi74qeohOeg86G7m9gB7q56uUHuK9vdOlV3ynpC4EvK+boMWvhyYwOc7iEFNz6gxyjqlvnlHfzY3W0MTjuqB/Ri8tHGSsEutcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5139d80f8b6so2244555e87.1
        for <linux-btrfs@vger.kernel.org>; Mon, 11 Mar 2024 09:07:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710173233; x=1710778033;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xqcAMaRJtQJUT2yGWLQb8JocmMmivmHw8shVGNylPx4=;
        b=c03gVR5PAkGENHDM+n3xcax2eXzdpS/rOAPD9ku6OEKaxvmB3tp8ITO0DGl03Twgye
         uJoU6BIvTqbI1AUEE0Jn6fd2mdgX8jiEq957HoSggynj8q/tmetK4zU/7sEhBQPJwQag
         0TQk/ZwI0PExP4doiNvTNt49NSajeU0mUK7goqUrPwn1gjdiq1FANbxNTpYM26WTynWd
         SJIvzSKe7MJxABLJDM8OJ0WNXfMzpepkjn27a+/T8JSife6porjZ4eHETKmsPZT75cV7
         i2kvo4U2ipXM7NUGd+W2iNCkfIIQrv84nXs2p92G/s4+TBvetoakfjn9lTcenpjiqegj
         Lfug==
X-Gm-Message-State: AOJu0YwoYg8nt7hedpXDyCaJ2eDzBlP3iOesUYt5PeSYNrfGR2gH6Oq9
	1FLGPqGVrKaTUxpB4ULg8EsFENuUlboPHINC3fAAslsPkk6VBZ8Ys3MkZ2SdWyA=
X-Google-Smtp-Source: AGHT+IG9TkFN6fAxFvEarVXhQTm5Vh0HwwwMUPMWrufLXT6jvkzfp8yBCEVzOvU7IorbhSXaBt0b8w==
X-Received: by 2002:a05:6512:20b:b0:513:a8ae:66a3 with SMTP id a11-20020a056512020b00b00513a8ae66a3mr2222274lfo.5.1710173232520;
        Mon, 11 Mar 2024 09:07:12 -0700 (PDT)
Received: from nuc.fritz.box (p200300f6f7068b00fa633ffffe02074c.dip0.t-ipconnect.de. [2003:f6:f706:8b00:fa63:3fff:fe02:74c])
        by smtp.gmail.com with ESMTPSA id s11-20020a05600c45cb00b00413128042d0sm14780937wmo.48.2024.03.11.09.07.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Mar 2024 09:07:12 -0700 (PDT)
From: Johannes Thumshirn <jth@kernel.org>
To: linux-btrfs@vger.kernel.org
Cc: Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	Filipe Manana <fdmanana@suse.com>,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH v3] btrfs: zoned: fix use-after-free in do_zone_finish
Date: Mon, 11 Mar 2024 17:06:51 +0100
Message-Id: <c6ca670979be870fb7c4c2ad98c5b9a1b9938a05.1710173195.git.jth@kernel.org>
X-Mailer: git-send-email 2.35.3
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Shinichiro reported the following use-after-free triggered by the device
replace operation in fstests btrfs/070.

 BTRFS info (device nullb1): scrub: finished on devid 1 with status: 0
 ==================================================================
 BUG: KASAN: slab-use-after-free in do_zone_finish+0x91a/0xb90 [btrfs]
 Read of size 8 at addr ffff8881543c8060 by task btrfs-cleaner/3494007

 CPU: 0 PID: 3494007 Comm: btrfs-cleaner Tainted: G        W          6.8.0-rc5-kts #1
 Hardware name: Supermicro Super Server/X11SPi-TF, BIOS 3.3 02/21/2020
 Call Trace:
  <TASK>
  dump_stack_lvl+0x5b/0x90
  print_report+0xcf/0x670
  ? __virt_addr_valid+0x200/0x3e0
  kasan_report+0xd8/0x110
  ? do_zone_finish+0x91a/0xb90 [btrfs]
  ? do_zone_finish+0x91a/0xb90 [btrfs]
  do_zone_finish+0x91a/0xb90 [btrfs]
  btrfs_delete_unused_bgs+0x5e1/0x1750 [btrfs]
  ? __pfx_btrfs_delete_unused_bgs+0x10/0x10 [btrfs]
  ? btrfs_put_root+0x2d/0x220 [btrfs]
  ? btrfs_clean_one_deleted_snapshot+0x299/0x430 [btrfs]
  cleaner_kthread+0x21e/0x380 [btrfs]
  ? __pfx_cleaner_kthread+0x10/0x10 [btrfs]
  kthread+0x2e3/0x3c0
  ? __pfx_kthread+0x10/0x10
  ret_from_fork+0x31/0x70
  ? __pfx_kthread+0x10/0x10
  ret_from_fork_asm+0x1b/0x30
  </TASK>

 Allocated by task 3493983:
  kasan_save_stack+0x33/0x60
  kasan_save_track+0x14/0x30
  __kasan_kmalloc+0xaa/0xb0
  btrfs_alloc_device+0xb3/0x4e0 [btrfs]
  device_list_add.constprop.0+0x993/0x1630 [btrfs]
  btrfs_scan_one_device+0x219/0x3d0 [btrfs]
  btrfs_control_ioctl+0x26e/0x310 [btrfs]
  __x64_sys_ioctl+0x134/0x1b0
  do_syscall_64+0x99/0x190
  entry_SYSCALL_64_after_hwframe+0x6e/0x76

 Freed by task 3494056:
  kasan_save_stack+0x33/0x60
  kasan_save_track+0x14/0x30
  kasan_save_free_info+0x3f/0x60
  poison_slab_object+0x102/0x170
  __kasan_slab_free+0x32/0x70
  kfree+0x11b/0x320
  btrfs_rm_dev_replace_free_srcdev+0xca/0x280 [btrfs]
  btrfs_dev_replace_finishing+0xd7e/0x14f0 [btrfs]
  btrfs_dev_replace_by_ioctl+0x1286/0x25a0 [btrfs]
  btrfs_ioctl+0xb27/0x57d0 [btrfs]
  __x64_sys_ioctl+0x134/0x1b0
  do_syscall_64+0x99/0x190
  entry_SYSCALL_64_after_hwframe+0x6e/0x76

 The buggy address belongs to the object at ffff8881543c8000
  which belongs to the cache kmalloc-1k of size 1024
 The buggy address is located 96 bytes inside of
  freed 1024-byte region [ffff8881543c8000, ffff8881543c8400)

 The buggy address belongs to the physical page:
 page:00000000fe2c1285 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x1543c8
 head:00000000fe2c1285 order:3 entire_mapcount:0 nr_pages_mapped:0 pincount:0
 flags: 0x17ffffc0000840(slab|head|node=0|zone=2|lastcpupid=0x1fffff)
 page_type: 0xffffffff()
 raw: 0017ffffc0000840 ffff888100042dc0 ffffea0019e8f200 dead000000000002
 raw: 0000000000000000 0000000000100010 00000001ffffffff 0000000000000000
 page dumped because: kasan: bad access detected

 Memory state around the buggy address:
  ffff8881543c7f00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  ffff8881543c7f80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 >ffff8881543c8000: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                                        ^
  ffff8881543c8080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
  ffff8881543c8100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb

This UAF happens because we're accessing stale zone information of a
already removed btrfs_device in do_zone_finish().

The sequence of events is as follows:

btrfs_dev_replace_start
  btrfs_scrub_dev
   btrfs_dev_replace_finishing
    btrfs_dev_replace_update_device_in_mapping_tree <-- devices replaced
    btrfs_rm_dev_replace_free_srcdev
     btrfs_free_device                              <-- device freed

cleaner_kthread
 btrfs_delete_unused_bgs
  btrfs_zone_finish
   do_zone_finish              <-- refers the freed device

The reason for this is that we're using a cached pointer to the chunk_map
from the block group, but on device replace this cached pointer can
contain stale device entries.

The staleness comes from the fact, that btrfs_block_group::physical_map is
not a pointer to a btrfs_chunk_map but a memory copy of it.

Also take the fs_info::dev_replace::rwsem to prevent
btrfs_dev_replace_update_device_in_mapping_tree() from changing the device
underneath us again.

Note: btrfs_dev_replace_update_device_in_mapping_tree() is holding
fs_info::mapping_tree_lock, but as this is a spinning read/write lock we
cannot take it as the call to blkdev_zone_mgmt() requires a memory
allocation which may not sleep.
But btrfs_dev_replace_update_device_in_mapping_tree() is always called with
the fs_info::dev_replace::rwsem held in write mode.

Many thanks to Shinichiro for analyzing the bug.

Cc: Filipe Manana <fdmanana@suse.com>
Reported-by: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

---
Changes to v2:
- Also hold fs_info::dev_replace::rwsem to close race with replaceing
- v2 can be found here: https://lore.kernel.org/linux-btrfs/bb74e2b2a59797e085e2dfd44c904113439ecb46.1709539467.git.jth@kernel.org
Changes to v1:
- Don't clone chunk map but grab a reference
- v1 can be found here: https://lore.kernel.org/linux-btrfs/94b4286e-7c64-4573-a680-0360305d2db4@kernel.org
---
 fs/btrfs/zoned.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index 3317bebfca95..459d1af02c3c 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -1561,11 +1561,7 @@ int btrfs_load_block_group_zone_info(struct btrfs_block_group *cache, bool new)
 	if (!map)
 		return -EINVAL;
 
-	cache->physical_map = btrfs_clone_chunk_map(map, GFP_NOFS);
-	if (!cache->physical_map) {
-		ret = -ENOMEM;
-		goto out;
-	}
+	cache->physical_map = map;
 
 	zone_info = kcalloc(map->num_stripes, sizeof(*zone_info), GFP_NOFS);
 	if (!zone_info) {
@@ -1677,7 +1673,6 @@ int btrfs_load_block_group_zone_info(struct btrfs_block_group *cache, bool new)
 	}
 	bitmap_free(active);
 	kfree(zone_info);
-	btrfs_free_chunk_map(map);
 
 	return ret;
 }
@@ -2162,6 +2157,7 @@ static int do_zone_finish(struct btrfs_block_group *block_group, bool fully_writ
 	struct btrfs_chunk_map *map;
 	const bool is_metadata = (block_group->flags &
 			(BTRFS_BLOCK_GROUP_METADATA | BTRFS_BLOCK_GROUP_SYSTEM));
+	struct btrfs_dev_replace *dev_replace = &fs_info->dev_replace;
 	int ret = 0;
 	int i;
 
@@ -2237,6 +2233,7 @@ static int do_zone_finish(struct btrfs_block_group *block_group, bool fully_writ
 	btrfs_clear_data_reloc_bg(block_group);
 	spin_unlock(&block_group->lock);
 
+	down_read(&dev_replace->rwsem);
 	map = block_group->physical_map;
 	for (i = 0; i < map->num_stripes; i++) {
 		struct btrfs_device *device = map->stripes[i].dev;
@@ -2251,13 +2248,16 @@ static int do_zone_finish(struct btrfs_block_group *block_group, bool fully_writ
 				       zinfo->zone_size >> SECTOR_SHIFT,
 				       GFP_NOFS);
 
-		if (ret)
+		if (ret) {
+			up_read(&dev_replace->rwsem);
 			return ret;
+		}
 
 		if (!(block_group->flags & BTRFS_BLOCK_GROUP_DATA))
 			zinfo->reserved_active_zones++;
 		btrfs_dev_clear_active_zone(device, physical);
 	}
+	up_read(&dev_replace->rwsem);
 
 	if (!fully_written)
 		btrfs_dec_block_group_ro(block_group);
-- 
2.35.3


