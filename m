Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5F385FAE70
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Nov 2019 11:27:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727298AbfKMK1k (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 13 Nov 2019 05:27:40 -0500
Received: from mx2.suse.de ([195.135.220.15]:48246 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727247AbfKMK1j (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 13 Nov 2019 05:27:39 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 1B855B5FD;
        Wed, 13 Nov 2019 10:27:37 +0000 (UTC)
From:   Johannes Thumshirn <jthumshirn@suse.de>
To:     David Sterba <dsterba@suse.com>
Cc:     Qu Wenru <wqu@suse.com>,
        Linux BTRFS Mailinglist <linux-btrfs@vger.kernel.org>,
        Johannes Thumshirn <jthumshirn@suse.de>
Subject: [PATCH v2 7/7] btrfs: change btrfs_fs_devices::rotating to bool
Date:   Wed, 13 Nov 2019 11:27:28 +0100
Message-Id: <20191113102728.8835-8-jthumshirn@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20191113102728.8835-1-jthumshirn@suse.de>
References: <20191113102728.8835-1-jthumshirn@suse.de>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

struct btrfs_fs_devices::rotating currently is declared as an integer
variable but only used as a boolean.

Change the variable definition to bool and update to code touching it to
set 'true' and 'false'.

Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>
---
 fs/btrfs/volumes.c | 6 +++---
 fs/btrfs/volumes.h | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index ce9c6fa3a32c..6d3bfea2e2d5 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -644,7 +644,7 @@ static int btrfs_open_one_device(struct btrfs_fs_devices *fs_devices,
 
 	q = bdev_get_queue(bdev);
 	if (!blk_queue_nonrot(q))
-		fs_devices->rotating = 1;
+		fs_devices->rotating = true;
 
 	device->bdev = bdev;
 	clear_bit(BTRFS_DEV_STATE_IN_FS_METADATA, &device->dev_state);
@@ -2301,7 +2301,7 @@ static int btrfs_prepare_sprout(struct btrfs_fs_info *fs_info)
 	fs_devices->num_devices = 0;
 	fs_devices->open_devices = 0;
 	fs_devices->missing_devices = 0;
-	fs_devices->rotating = 0;
+	fs_devices->rotating = false;
 	fs_devices->seed = seed_devices;
 
 	generate_random_uuid(fs_devices->fsid);
@@ -2496,7 +2496,7 @@ int btrfs_init_new_device(struct btrfs_fs_info *fs_info, const char *device_path
 	atomic64_add(device->total_bytes, &fs_info->free_chunk_space);
 
 	if (!blk_queue_nonrot(q))
-		fs_devices->rotating = 1;
+		fs_devices->rotating = true;
 
 	orig_super_total_bytes = btrfs_super_total_bytes(fs_info->super_copy);
 	btrfs_set_super_total_bytes(fs_info->super_copy,
diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index 8e9513b3fe9d..fc1b564b9cfe 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -250,7 +250,7 @@ struct btrfs_fs_devices {
 	/* set when we find or add a device that doesn't have the
 	 * nonrot flag set
 	 */
-	int rotating;
+	bool rotating;
 
 	struct btrfs_fs_info *fs_info;
 	/* sysfs kobjects */
-- 
2.16.4

