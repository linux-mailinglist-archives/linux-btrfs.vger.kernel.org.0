Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4D54C1023D7
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Nov 2019 13:06:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727811AbfKSMGC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 19 Nov 2019 07:06:02 -0500
Received: from mx2.suse.de ([195.135.220.15]:49292 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727316AbfKSMGB (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 19 Nov 2019 07:06:01 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id A31B1B3AF;
        Tue, 19 Nov 2019 12:05:59 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 2/6] btrfs: selftests: Add support for dummy devices
Date:   Tue, 19 Nov 2019 14:05:51 +0200
Message-Id: <20191119120555.6465-3-nborisov@suse.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191119120555.6465-1-nborisov@suse.com>
References: <20191119120555.6465-1-nborisov@suse.com>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Add basic infrastructure to create and link dummy btrfs_devices. This
will be used in the pending btrfs_rmap_block test which deals with
the  block groups.

Calling btrfs_alloc_dummy_device will link the newly created device to
the passed fs_info and the test framework will free dem once the test
is finished.

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 fs/btrfs/tests/btrfs-tests.c | 28 ++++++++++++++++++++++++++++
 fs/btrfs/tests/btrfs-tests.h |  1 +
 2 files changed, 29 insertions(+)

diff --git a/fs/btrfs/tests/btrfs-tests.c b/fs/btrfs/tests/btrfs-tests.c
index a7aca4141788..1710f2533d04 100644
--- a/fs/btrfs/tests/btrfs-tests.c
+++ b/fs/btrfs/tests/btrfs-tests.c
@@ -86,6 +86,28 @@ static void btrfs_destroy_test_fs(void)
 	unregister_filesystem(&test_type);
 }
 
+struct btrfs_device *btrfs_alloc_dummy_device(struct btrfs_fs_info *fs_info)
+{
+	struct btrfs_device *dev;
+
+	dev = kzalloc(sizeof(*dev),GFP_KERNEL);
+	if (!dev)
+		return ERR_PTR(-ENOMEM);
+
+	extent_io_tree_init(NULL, &dev->alloc_state, 0, NULL);
+	INIT_LIST_HEAD(&dev->dev_list);
+
+	list_add(&dev->dev_list, &fs_info->fs_devices->devices);
+
+	return dev;
+}
+
+static void btrfs_free_dummy_device(struct btrfs_device *dev)
+{
+	extent_io_tree_release(&dev->alloc_state);
+	kfree(dev);
+}
+
 struct btrfs_fs_info *btrfs_alloc_dummy_fs_info(u32 nodesize, u32 sectorsize)
 {
 	struct btrfs_fs_info *fs_info = kzalloc(sizeof(struct btrfs_fs_info),
@@ -132,12 +154,14 @@ struct btrfs_fs_info *btrfs_alloc_dummy_fs_info(u32 nodesize, u32 sectorsize)
 	INIT_LIST_HEAD(&fs_info->dirty_qgroups);
 	INIT_LIST_HEAD(&fs_info->dead_roots);
 	INIT_LIST_HEAD(&fs_info->tree_mod_seq_list);
+	INIT_LIST_HEAD(&fs_info->fs_devices->devices);
 	INIT_RADIX_TREE(&fs_info->buffer_radix, GFP_ATOMIC);
 	INIT_RADIX_TREE(&fs_info->fs_roots_radix, GFP_ATOMIC);
 	extent_io_tree_init(fs_info, &fs_info->freed_extents[0],
 			    IO_TREE_FS_INFO_FREED_EXTENTS0, NULL);
 	extent_io_tree_init(fs_info, &fs_info->freed_extents[1],
 			    IO_TREE_FS_INFO_FREED_EXTENTS1, NULL);
+	extent_map_tree_init(&fs_info->mapping_tree);
 	fs_info->pinned_extents = &fs_info->freed_extents[0];
 	set_bit(BTRFS_FS_STATE_DUMMY_FS_INFO, &fs_info->fs_state);
 
@@ -150,6 +174,7 @@ void btrfs_free_dummy_fs_info(struct btrfs_fs_info *fs_info)
 {
 	struct radix_tree_iter iter;
 	void **slot;
+	struct btrfs_device *dev, *temp;
 
 	if (!fs_info)
 		return;
@@ -180,6 +205,9 @@ void btrfs_free_dummy_fs_info(struct btrfs_fs_info *fs_info)
 	}
 	spin_unlock(&fs_info->buffer_lock);
 
+	btrfs_mapping_tree_free(&fs_info->mapping_tree);
+	list_for_each_entry_safe(dev, temp, &fs_info->fs_devices->devices, dev_list)
+		btrfs_free_dummy_device(dev);
 	btrfs_free_qgroup_config(fs_info);
 	btrfs_free_fs_roots(fs_info);
 	cleanup_srcu_struct(&fs_info->subvol_srcu);
diff --git a/fs/btrfs/tests/btrfs-tests.h b/fs/btrfs/tests/btrfs-tests.h
index 9e52527357d8..7a2d7ffbe30e 100644
--- a/fs/btrfs/tests/btrfs-tests.h
+++ b/fs/btrfs/tests/btrfs-tests.h
@@ -46,6 +46,7 @@ btrfs_alloc_dummy_block_group(struct btrfs_fs_info *fs_info, unsigned long lengt
 void btrfs_free_dummy_block_group(struct btrfs_block_group *cache);
 void btrfs_init_dummy_trans(struct btrfs_trans_handle *trans,
 			    struct btrfs_fs_info *fs_info);
+struct btrfs_device *btrfs_alloc_dummy_device(struct btrfs_fs_info *fs_info);
 #else
 static inline int btrfs_run_sanity_tests(void)
 {
-- 
2.17.1

