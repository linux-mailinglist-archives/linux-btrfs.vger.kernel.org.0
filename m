Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D870DFAE71
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Nov 2019 11:27:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727347AbfKMK1k (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 13 Nov 2019 05:27:40 -0500
Received: from mx2.suse.de ([195.135.220.15]:48240 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726597AbfKMK1k (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 13 Nov 2019 05:27:40 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 18AB9B52C;
        Wed, 13 Nov 2019 10:27:37 +0000 (UTC)
From:   Johannes Thumshirn <jthumshirn@suse.de>
To:     David Sterba <dsterba@suse.com>
Cc:     Qu Wenru <wqu@suse.com>,
        Linux BTRFS Mailinglist <linux-btrfs@vger.kernel.org>,
        Johannes Thumshirn <jthumshirn@suse.de>
Subject: [PATCH v2 6/7] btrfs: change btrfs_fs_devices::seeing to bool
Date:   Wed, 13 Nov 2019 11:27:27 +0100
Message-Id: <20191113102728.8835-7-jthumshirn@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20191113102728.8835-1-jthumshirn@suse.de>
References: <20191113102728.8835-1-jthumshirn@suse.de>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

struct btrfs_fs_devices::seeding currently is declared as an integer
variable but only used as a boolean.

Change the variable definition to bool and update to code touching it to
set 'true' and 'false'.

Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>
---
 fs/btrfs/volumes.c | 8 ++++----
 fs/btrfs/volumes.h | 2 +-
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 25e4608e20f1..ce9c6fa3a32c 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -634,7 +634,7 @@ static int btrfs_open_one_device(struct btrfs_fs_devices *fs_devices,
 		}
 
 		clear_bit(BTRFS_DEV_STATE_WRITEABLE, &device->dev_state);
-		fs_devices->seeding = 1;
+		fs_devices->seeding = true;
 	} else {
 		if (bdev_read_only(bdev))
 			clear_bit(BTRFS_DEV_STATE_WRITEABLE, &device->dev_state);
@@ -1139,7 +1139,7 @@ static int close_fs_devices(struct btrfs_fs_devices *fs_devices)
 	WARN_ON(fs_devices->open_devices);
 	WARN_ON(fs_devices->rw_devices);
 	fs_devices->opened = 0;
-	fs_devices->seeding = 0;
+	fs_devices->seeding = false;
 
 	return 0;
 }
@@ -2297,7 +2297,7 @@ static int btrfs_prepare_sprout(struct btrfs_fs_info *fs_info)
 	list_splice_init(&fs_devices->alloc_list, &seed_devices->alloc_list);
 	mutex_unlock(&fs_info->chunk_mutex);
 
-	fs_devices->seeding = 0;
+	fs_devices->seeding = false;
 	fs_devices->num_devices = 0;
 	fs_devices->open_devices = 0;
 	fs_devices->missing_devices = 0;
@@ -6681,7 +6681,7 @@ static struct btrfs_fs_devices *open_seed_devices(struct btrfs_fs_info *fs_info,
 		if (IS_ERR(fs_devices))
 			return fs_devices;
 
-		fs_devices->seeding = 1;
+		fs_devices->seeding = true;
 		fs_devices->opened = 1;
 		return fs_devices;
 	}
diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index 46987a2da786..8e9513b3fe9d 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -243,7 +243,7 @@ struct btrfs_fs_devices {
 	struct list_head alloc_list;
 
 	struct btrfs_fs_devices *seed;
-	int seeding;
+	bool seeding;
 
 	int opened;
 
-- 
2.16.4

