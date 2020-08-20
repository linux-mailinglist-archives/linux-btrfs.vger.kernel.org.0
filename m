Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02F2624B045
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Aug 2020 09:42:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725852AbgHTHmz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 20 Aug 2020 03:42:55 -0400
Received: from mx2.suse.de ([195.135.220.15]:39404 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725797AbgHTHmy (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 20 Aug 2020 03:42:54 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 1AC8BAC8B
        for <linux-btrfs@vger.kernel.org>; Thu, 20 Aug 2020 07:43:19 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: add owner and fs_info for btrfs_device::alloc_state
Date:   Thu, 20 Aug 2020 15:42:46 +0800
Message-Id: <20200820074246.146503-1-wqu@suse.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Commit 1c11b63eff2a ("btrfs: replace pending/pinned chunks lists with io
tree") introduced btrfs_device::alloc_state extent io tree, but it
doesn't initialize the fs_info and owner member.

This means the following features are not properly supported:
- Fs owner report for insert_state() error
  Without fs_info initialized, although btrfs_err() won't panic, it
  won't output which fs is causing the error.

- Wrong owner for trace events
  alloc_state will get the owner as pinned extents.

Fix this by assiging proper fs_info and owner for
btrfs_device::alloc_state.

Fixes: 1c11b63eff2a ("btrfs: replace pending/pinned chunks lists with io tree")
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/extent-io-tree.h | 1 +
 fs/btrfs/volumes.c        | 7 ++++---
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/extent-io-tree.h b/fs/btrfs/extent-io-tree.h
index 219a09a2b734..250b8cbaaf97 100644
--- a/fs/btrfs/extent-io-tree.h
+++ b/fs/btrfs/extent-io-tree.h
@@ -48,6 +48,7 @@ enum {
 	IO_TREE_INODE_FILE_EXTENT,
 	IO_TREE_LOG_CSUM_RANGE,
 	IO_TREE_SELFTEST,
+	IO_TREE_DEVICE_ALLOC_STATE,
 };
 
 struct extent_io_tree {
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 1d5026fdfc75..4683533f3de3 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -405,7 +405,7 @@ void __exit btrfs_cleanup_fs_uuids(void)
  * Returned struct is not linked onto any lists and must be destroyed using
  * btrfs_free_device.
  */
-static struct btrfs_device *__alloc_device(void)
+static struct btrfs_device *__alloc_device(struct btrfs_fs_info *fs_info)
 {
 	struct btrfs_device *dev;
 
@@ -432,7 +432,8 @@ static struct btrfs_device *__alloc_device(void)
 	btrfs_device_data_ordered_init(dev);
 	INIT_RADIX_TREE(&dev->reada_zones, GFP_NOFS & ~__GFP_DIRECT_RECLAIM);
 	INIT_RADIX_TREE(&dev->reada_extents, GFP_NOFS & ~__GFP_DIRECT_RECLAIM);
-	extent_io_tree_init(NULL, &dev->alloc_state, 0, NULL);
+	extent_io_tree_init(fs_info, &dev->alloc_state,
+			    IO_TREE_DEVICE_ALLOC_STATE, NULL);
 
 	return dev;
 }
@@ -6524,7 +6525,7 @@ struct btrfs_device *btrfs_alloc_device(struct btrfs_fs_info *fs_info,
 	if (WARN_ON(!devid && !fs_info))
 		return ERR_PTR(-EINVAL);
 
-	dev = __alloc_device();
+	dev = __alloc_device(fs_info);
 	if (IS_ERR(dev))
 		return dev;
 
-- 
2.28.0

