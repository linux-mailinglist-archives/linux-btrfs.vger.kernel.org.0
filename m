Return-Path: <linux-btrfs+bounces-2922-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9918686C8F4
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Feb 2024 13:16:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C9A5B1C22B5D
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Feb 2024 12:16:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53CE77D081;
	Thu, 29 Feb 2024 12:16:27 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7991E7C0BB
	for <linux-btrfs@vger.kernel.org>; Thu, 29 Feb 2024 12:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709208983; cv=none; b=pvDnr6xyEDIeegkd2QyEoB94gqte+8C0bNd/8PC614fRQ7ipdAes8Z2C/ovXpgMlApplgnQfAd4qKXufkP0uE1yE2fAl7yHlL3IjJb4UtskLdMN9c6jLLJuGByU2DQc0P8yWVf7pW9aqR9RYKna6JWHWraE62KiphrcTNLqA/Dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709208983; c=relaxed/simple;
	bh=Crc+ks4/12zvw1/rtejqS0H2wZj1RGvqm44xmvC/Sp0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=bLLp0ZgWy7HT+UriFsnQNQUB1D3LF9eS3JMRkRIsuyS/0U9WkGCDSi0azSi9ksQR3Cd+mjc9eRKSjMwPGUr4vyRYaBLctyLzQSqnc4H0AnzsxqnUlySe6A7pv24BWTEYMMGNF9IuB1VAn4bhifeBNjhUcc6gwb07GSpWkZx5Ubk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a3ddc13bbb3so335592066b.0
        for <linux-btrfs@vger.kernel.org>; Thu, 29 Feb 2024 04:16:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709208980; x=1709813780;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e6d044lknQEF0wqYZf/NLeNemVZpP/8Phz3K4LTsJao=;
        b=GMDC049aw+8/3bhBeP/hGgAWwPMyolQibAOkKsbWEmw+OrncXIoaq5al4jQ1KKENyz
         dZLh53Is8P0Tt7QowkUeDYRO5tREfBjjWCIwWJ9ux/j1h6S6JIe2Ykwly54fgCgmV04c
         x/fagjAit204Gvh9ikrJVdYge6qfVvkFdgKNYyVdL+/XN/oOTKgAPpKgky4sUrepobpD
         f+4nq5QSDbAKgTreU9mwRW4m1TQbsJLvdG+GqgkfBmyoU9HORQZv8b0srh3oFnRsfMUg
         /78f7Ede9gfrlrQUOFmStNHgth8eoHDJsB9yFNwxrpYR39vXoKzFmceT4K7UTJ1Tgk/M
         ZgKQ==
X-Gm-Message-State: AOJu0YyElh7DBI0JIVjTYWGew3ihsdX7vNqP4EjisyWFj8V9iOyNcAlO
	WkIEANzc8Af5BH+FsLRB1IhHf+pgJY5w8qZvMDqiBkVdk8DrAaCqh2+hiyZo
X-Google-Smtp-Source: AGHT+IFM5db3ReEGS6dTFuGrq0sW+RRWTUE1pWKEYMbLxRBLsKTeEQR0zZ1jCGClqxVD6E8Ggs68Hw==
X-Received: by 2002:a17:906:af89:b0:a43:9d17:dfba with SMTP id mj9-20020a170906af8900b00a439d17dfbamr1354106ejb.31.1709208979506;
        Thu, 29 Feb 2024 04:16:19 -0800 (PST)
Received: from nuc.fritz.box (p200300f6f7068b00fa633ffffe02074c.dip0.t-ipconnect.de. [2003:f6:f706:8b00:fa63:3fff:fe02:74c])
        by smtp.gmail.com with ESMTPSA id s10-20020a1709060c0a00b00a3f8f0ab293sm633097ejf.147.2024.02.29.04.16.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Feb 2024 04:16:19 -0800 (PST)
From: Johannes Thumshirn <jth@kernel.org>
To: linux-btrfs@vger.kernel.org
Cc: Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH] btrfs: zoned: fix use-after-free in do_zone_finish
Date: Thu, 29 Feb 2024 13:16:04 +0100
Message-Id: <4b26736862c49050ef907e6f326ab34c0e82c6b8.1709208898.git.jth@kernel.org>
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

So grab a fresh reference to the chunk map and don't rely on the cached
version.

Many thanks to Shinichiro for analyzing the bug.

Reported-by: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/zoned.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index 3317bebfca95..c27d2214136e 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -2237,7 +2237,8 @@ static int do_zone_finish(struct btrfs_block_group *block_group, bool fully_writ
 	btrfs_clear_data_reloc_bg(block_group);
 	spin_unlock(&block_group->lock);
 
-	map = block_group->physical_map;
+	map = btrfs_find_chunk_map(fs_info, block_group->start,
+				   block_group->length);
 	for (i = 0; i < map->num_stripes; i++) {
 		struct btrfs_device *device = map->stripes[i].dev;
 		const u64 physical = map->stripes[i].physical;
-- 
2.35.3


