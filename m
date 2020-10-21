Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C33F29538A
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Oct 2020 22:38:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2505403AbgJUUiK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 21 Oct 2020 16:38:10 -0400
Received: from mx2.suse.de ([195.135.220.15]:50708 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2410455AbgJUUiK (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 21 Oct 2020 16:38:10 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 7C3F7AD85;
        Wed, 21 Oct 2020 20:38:07 +0000 (UTC)
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     dsterba@suse.com
Cc:     a.darwish@linutronix.de, dave@stgolabs.net,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Davidlohr Bueso <dbueso@suse.de>
Subject: [PATCH] btrfs: convert data_seqcount to seqcount_mutex_t
Date:   Wed, 21 Oct 2020 13:17:24 -0700
Message-Id: <20201021201724.27213-1-dave@stgolabs.net>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

By doing so we can associate the sequence counter to the chunk_mutex
for lockdep purposes (compiled-out otherwise) and also avoid
explicitly disabling preemption around the write region as it will now
be done automatically by the seqcount machinery based on the lock type.

Signed-off-by: Davidlohr Bueso <dbueso@suse.de>
---
 fs/btrfs/volumes.c |  2 +-
 fs/btrfs/volumes.h | 10 ++++------
 2 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 58b9c419a2b6..b6ee92ddc624 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -431,7 +431,7 @@ static struct btrfs_device *__alloc_device(struct btrfs_fs_info *fs_info)
 
 	atomic_set(&dev->reada_in_flight, 0);
 	atomic_set(&dev->dev_stats_ccnt, 0);
-	btrfs_device_data_ordered_init(dev);
+	btrfs_device_data_ordered_init(dev, fs_info);
 	INIT_RADIX_TREE(&dev->reada_zones, GFP_NOFS & ~__GFP_DIRECT_RECLAIM);
 	INIT_RADIX_TREE(&dev->reada_extents, GFP_NOFS & ~__GFP_DIRECT_RECLAIM);
 	extent_io_tree_init(fs_info, &dev->alloc_state,
diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index bf27ac07d315..ff3ec11bb9d2 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -39,10 +39,10 @@ struct btrfs_io_geometry {
 #if BITS_PER_LONG==32 && defined(CONFIG_SMP)
 #include <linux/seqlock.h>
 #define __BTRFS_NEED_DEVICE_DATA_ORDERED
-#define btrfs_device_data_ordered_init(device)	\
-	seqcount_init(&device->data_seqcount)
+#define btrfs_device_data_ordered_init(device, info)				\
+	seqcount_mutex_init(&device->data_seqcount, &info->chunk_mutex)
 #else
-#define btrfs_device_data_ordered_init(device) do { } while (0)
+#define btrfs_device_data_ordered_init(device, info) do { } while (0)
 #endif
 
 #define BTRFS_DEV_STATE_WRITEABLE	(0)
@@ -71,7 +71,7 @@ struct btrfs_device {
 	blk_status_t last_flush_error;
 
 #ifdef __BTRFS_NEED_DEVICE_DATA_ORDERED
-	seqcount_t data_seqcount;
+	seqcount_mutex_t data_seqcount;
 #endif
 
 	/* the internal btrfs device id */
@@ -162,11 +162,9 @@ btrfs_device_get_##name(const struct btrfs_device *dev)			\
 static inline void							\
 btrfs_device_set_##name(struct btrfs_device *dev, u64 size)		\
 {									\
-	preempt_disable();						\
 	write_seqcount_begin(&dev->data_seqcount);			\
 	dev->name = size;						\
 	write_seqcount_end(&dev->data_seqcount);			\
-	preempt_enable();						\
 }
 #elif BITS_PER_LONG==32 && defined(CONFIG_PREEMPTION)
 #define BTRFS_DEVICE_GETSET_FUNCS(name)					\
--
2.26.2

