Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B940C2759FE
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Sep 2020 16:30:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726715AbgIWOaU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 23 Sep 2020 10:30:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:35972 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726650AbgIWOaU (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 23 Sep 2020 10:30:20 -0400
Received: from localhost.localdomain (bl8-197-74.dsl.telepac.pt [85.241.197.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 40E75206FB
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Sep 2020 14:30:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600871419;
        bh=pOnAbiAnp/ifBDfMhtKiWlNV9fEkGWPl/IVic1A8upo=;
        h=From:To:Subject:Date:From;
        b=ulV1P5hLh0IS9pgh2WaaKHQy4Ur5u6aBRqleZv5tUUXY/C5mq9IHWcec8riBlo7qW
         E1obeJOhrawVW9Pg2e51crkB8hmz3N11vI8nxR4pGx5M4wH8muFwjbKTR5Bvp+BXn/
         cM5h4Y2Pli7mIZA/DCxUzQ8/GiJT4KO2GP6b+FRw=
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: fix filesystem corruption after a device replace
Date:   Wed, 23 Sep 2020 15:30:16 +0100
Message-Id: <09c4d27ac71d847fdc5a030a7d860610039d5332.1600871060.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

We use a device's allocation state tree to track ranges in a device used
for allocated chunks, and we set ranges in this tree when allocating a new
chunk. However after a device replace operation, we were not setting the
allocated ranges in the new device's allocation state tree, so that tree
is empty after a device replace.

This means that a fitrim operation after a device replace will trim the
device ranges that have allocated chunks and extents, as we trim every
range for which there is not a range marked in the device's allocation
state tree. It is also important during chunk allocation, since the
device's allocation state is used to determine if a range is already
allocated when allocating a new chunk.

This is trivial to reproduce and the following script triggers the bug:

  $ cat reproducer.sh
  #!/bin/bash

  DEV1="/dev/sdg"
  DEV2="/dev/sdh"
  DEV3="/dev/sdi"

  wipefs -a $DEV1 $DEV2 $DEV3 &> /dev/null

  # Create a raid1 test fs on 2 devices.
  mkfs.btrfs -f -m raid1 -d raid1 $DEV1 $DEV2 > /dev/null
  mount $DEV1 /mnt/btrfs

  xfs_io -f -c "pwrite -S 0xab 0 10M" /mnt/btrfs/foo

  echo "Starting to replace $DEV1 with $DEV3"
  btrfs replace start -B $DEV1 $DEV3 /mnt/btrfs
  echo

  echo "Running fstrim"
  fstrim /mnt/btrfs
  echo

  echo "Unmounting filesystem"
  umount /mnt/btrfs

  echo "Mounting filesystem in degraded mode using $DEV3 only"
  wipefs -a $DEV1 $DEV2 &> /dev/null
  mount -o degraded $DEV3 /mnt/btrfs
  if [ $? -ne 0 ]; then
          dmesg | tail
          echo
          echo "Failed to mount in degraded mode"
          exit 1
  fi

  echo
  echo "File foo data (expected all bytes = 0xab):"
  od -A d -t x1 /mnt/btrfs/foo

  umount /mnt/btrfs

When running the reproducer:

  $ ./replace-test.sh
  wrote 10485760/10485760 bytes at offset 0
  10 MiB, 2560 ops; 0.0901 sec (110.877 MiB/sec and 28384.5216 ops/sec)
  Starting to replace /dev/sdg with /dev/sdi

  Running fstrim

  Unmounting filesystem
  Mounting filesystem in degraded mode using /dev/sdi only
  mount: /mnt/btrfs: wrong fs type, bad option, bad superblock on /dev/sdi, missing codepage or helper program, or other error.
  [19581.748641] BTRFS info (device sdg): dev_replace from /dev/sdg (devid 1) to /dev/sdi started
  [19581.803842] BTRFS info (device sdg): dev_replace from /dev/sdg (devid 1) to /dev/sdi finished
  [19582.208293] BTRFS info (device sdi): allowing degraded mounts
  [19582.208298] BTRFS info (device sdi): disk space caching is enabled
  [19582.208301] BTRFS info (device sdi): has skinny extents
  [19582.212853] BTRFS warning (device sdi): devid 2 uuid 1f731f47-e1bb-4f00-bfbb-9e5a0cb4ba9f is missing
  [19582.213904] btree_readpage_end_io_hook: 25839 callbacks suppressed
  [19582.213907] BTRFS error (device sdi): bad tree block start, want 30490624 have 0
  [19582.214780] BTRFS warning (device sdi): failed to read root (objectid=7): -5
  [19582.231576] BTRFS error (device sdi): open_ctree failed

  Failed to mount in degraded mode

So fix by setting all allocated ranges in the replace target device when
the replace operation is finishing, when we are holding the chunk mutex
and we can not race with new chunk allocations.

A test case for fstests follows soon.

Fixes: 1c11b63eff2a67 ("btrfs: replace pending/pinned chunks lists with io tree")
CC: stable@vger.kernel.org # 5.2+
Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/dev-replace.c | 40 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 39 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/dev-replace.c b/fs/btrfs/dev-replace.c
index 119721eeecf6..20ce1970015f 100644
--- a/fs/btrfs/dev-replace.c
+++ b/fs/btrfs/dev-replace.c
@@ -619,6 +619,37 @@ static void btrfs_dev_replace_update_device_in_mapping_tree(
 	write_unlock(&em_tree->lock);
 }
 
+/*
+ * When finishing the device replace, before swapping the source device with the
+ * target device we must update the chunk allocation state in the target device,
+ * as it is empty because replace works by directly copying the chunks and not
+ * through the normal chunk allocation path.
+ */
+static int btrfs_set_target_alloc_state(struct btrfs_device *srcdev,
+					struct btrfs_device *tgtdev)
+{
+	struct extent_state *cached_state = NULL;
+	u64 start = 0;
+	u64 found_start;
+	u64 found_end;
+	int ret = 0;
+
+	lockdep_assert_held(&srcdev->fs_info->chunk_mutex);
+
+	while (!find_first_extent_bit(&srcdev->alloc_state, start,
+				      &found_start, &found_end,
+				      CHUNK_ALLOCATED, &cached_state)) {
+		ret = set_extent_bits(&tgtdev->alloc_state, found_start,
+				      found_end, CHUNK_ALLOCATED);
+		if (ret)
+			break;
+		start = found_end + 1;
+	}
+
+	free_extent_state(cached_state);
+	return ret;
+}
+
 static int btrfs_dev_replace_finishing(struct btrfs_fs_info *fs_info,
 				       int scrub_ret)
 {
@@ -693,8 +724,14 @@ static int btrfs_dev_replace_finishing(struct btrfs_fs_info *fs_info,
 	dev_replace->time_stopped = ktime_get_real_seconds();
 	dev_replace->item_needs_writeback = 1;
 
-	/* replace old device with new one in mapping tree */
+	/*
+	 * Update allocation state in the new device and replace the old device
+	 * with the new one in the mapping tree.
+	 */
 	if (!scrub_ret) {
+		scrub_ret = btrfs_set_target_alloc_state(src_device, tgt_device);
+		if (scrub_ret)
+			goto error;
 		btrfs_dev_replace_update_device_in_mapping_tree(fs_info,
 								src_device,
 								tgt_device);
@@ -705,6 +742,7 @@ static int btrfs_dev_replace_finishing(struct btrfs_fs_info *fs_info,
 				 btrfs_dev_name(src_device),
 				 src_device->devid,
 				 rcu_str_deref(tgt_device->name), scrub_ret);
+error:
 		up_write(&dev_replace->rwsem);
 		mutex_unlock(&fs_info->chunk_mutex);
 		mutex_unlock(&fs_info->fs_devices->device_list_mutex);
-- 
2.28.0

