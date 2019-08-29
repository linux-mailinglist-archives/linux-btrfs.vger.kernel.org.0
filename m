Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BC3C8A1271
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Aug 2019 09:17:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727347AbfH2HRi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 29 Aug 2019 03:17:38 -0400
Received: from mx2.suse.de ([195.135.220.15]:34794 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725853AbfH2HRi (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 29 Aug 2019 03:17:38 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 8A874B035
        for <linux-btrfs@vger.kernel.org>; Thu, 29 Aug 2019 07:17:37 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: volumes: Allow missing devices to be writeable
Date:   Thu, 29 Aug 2019 15:17:31 +0800
Message-Id: <20190829071731.11521-1-wqu@suse.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

[BUG]
There is a long existing bug that degraded mounted btrfs can allocate new
SINGLE/DUP chunks on a RAID1 fs:
  #!/bin/bash

  dev1=/dev/test/scratch1
  dev2=/dev/test/scratch2
  mnt=/mnt/btrfs

  umount $mnt &> /dev/null
  umount $dev1 &> /dev/null
  umount $dev2 &> /dev/null

  dmesg -C
  mkfs.btrfs -f -m raid1 -d raid1 $dev1 $dev2

  wipefs -fa $dev2

  mount -o degraded $dev1 $mnt
  btrfs balance start --full $mnt
  umount $mnt
  echo "=== chunk after degraded mount ==="
  btrfs ins dump-tree -t chunk $dev1 | grep stripe_len.*type

The result fs will have chunks with SINGLE and DUP only:
  === chunk after degraded mount ===
                  length 33554432 owner 2 stripe_len 65536 type SYSTEM
                  length 1073741824 owner 2 stripe_len 65536 type DATA
                  length 1073741824 owner 2 stripe_len 65536 type DATA|DUP
                  length 219676672 owner 2 stripe_len 65536 type METADATA|DUP
                  length 33554432 owner 2 stripe_len 65536 type SYSTEM|DUP

This behavior greatly breaks the RAID1 tolerance.

Even with missing device replaced, if the device with DUP/SINGLE chunks
on them get missing, the whole fs can't be mounted RW any more.
And we already have reports that user even can't mount the fs as some
essential tree blocks got written to those DUP chunks.

[CAUSE]
The cause is pretty simple, we treat missing devices as non-writable.
Thus when we need to allocate chunks, we can only fall back to single
device profiles (SINGLE and DUP).

[FIX]
Just consider the missing devices as WRITABLE, so we allocate new chunks
on them to maintain old profiles.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/volumes.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 56f751192a6c..cc30b1fa9306 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -7002,6 +7002,18 @@ static int read_one_dev(struct extent_buffer *leaf,
 
 	fill_device_from_item(leaf, dev_item, device);
 	set_bit(BTRFS_DEV_STATE_IN_FS_METADATA, &device->dev_state);
+
+	/*
+	 * We treat missing devices as writable, so that we can maintain
+	 * the existing profiles without degrading to DUP/SINGLE.
+	 */
+	if (test_bit(BTRFS_DEV_STATE_MISSING, &device->dev_state)) {
+		set_bit(BTRFS_DEV_STATE_WRITEABLE, &device->dev_state);
+		list_add(&device->dev_alloc_list,
+			 &fs_devices->alloc_list);
+		fs_devices->rw_devices++;
+	}
+
 	if (test_bit(BTRFS_DEV_STATE_WRITEABLE, &device->dev_state) &&
 	   !test_bit(BTRFS_DEV_STATE_REPLACE_TGT, &device->dev_state)) {
 		device->fs_devices->total_rw_bytes += device->total_bytes;
-- 
2.23.0

