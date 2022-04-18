Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96D2D504C6A
	for <lists+linux-btrfs@lfdr.de>; Mon, 18 Apr 2022 07:50:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236678AbiDRFxR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 18 Apr 2022 01:53:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236148AbiDRFxR (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 18 Apr 2022 01:53:17 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2254C55A3
        for <linux-btrfs@vger.kernel.org>; Sun, 17 Apr 2022 22:50:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1650261038; x=1681797038;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=xoCMnmczuljhDtFeo3A0IFPvsEmbEiaihOA2cNgQvYo=;
  b=djcXnKpl2+lJ+7GIHpb+fa5I9T7xSs6pZ6tf96Hjj3wFEUpuz6W/NN4H
   irkXXbkQrKjNvg5N1FCbkDTIepB4Qy8EJ9KlmfWzec0uEJ9aIMokf4N/r
   6NzAMPVXt7n1FqVu3QI+fH7Tsz50ZwbSCRRjSmwukLD6rKKH7XoMUaeup
   /L5/sDRcLPWZbC9DjMDEbgJL19LTaV/CCUZ6D6aJ/dWfA7HKGBp+YNoS8
   /hHCHBxnRkd3Lcn/loMYNsehtdSEOQyI2AowUF0kYUROCU5NdQtnS2AmP
   xmMSjID4Tp922WkvxHLnyRMEJYvhuCJVRbniVQkbfUBHtUk3cNf8SLS+k
   w==;
X-IronPort-AV: E=Sophos;i="5.90,267,1643644800"; 
   d="scan'208";a="302331499"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 18 Apr 2022 13:50:32 +0800
IronPort-SDR: 8i9fN6O+/j46VsgFNJe7DQ9BogErPqdaSdv1G6/etOpgZkA41vXUgXxT4zjtyX1Au+yF5ndKOF
 BCHX7JRB5JD8Ojhs8C0oPn71h35QnkZRKkvQpviGj8XPyjnXrRhav9eGUWjUyKqw08ItU8u4Rl
 mDAu6G7/ESOHOXI5jLnPzwrOkaj0VfCq0FqF11fgqjFPnQiYhdl9BBkaAZfRc2G8o/WAXFx/tX
 mWuq4tKBAn0PjWtB4ol1Fu6q+QVCw8+tpwsW5GtKow6V4YxQ3s2vuVdIfU7C3L28WqYHJ/nKrd
 ULKxIJ0wCaIr23g9eKWmXJy1
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 17 Apr 2022 22:20:51 -0700
IronPort-SDR: C4ANNov/CS3AgD9NDWjW1ozSlOHJtOLzcCmJGjfUZhOc3Wht/z9tgNV/4/89BmmCYkD46jCwtD
 1B6teylCqosLoNkdtrSBnKVCy5nZoYnWBSgXNkroL1aWUeYZuoMm/wAQZYjRIiAq5QRuRDJaL8
 z2560Oao7PDa3KaPhDH1xlXDpHo0ztksF0J1qbxxu2jGZItTK0l4fvQbAiuQaBX7M58aRr7fGi
 Y89nzmXwqHiPg4GYLON1c/zIGrw48lloldwfDHHFK/Q2sJmRPdeHwrTnlPtwrucoSpnZEAnpJX
 9hY=
WDCIronportException: Internal
Received: from hfp4fb3.ad.shared (HELO naota-xeon.ad.shared) ([10.225.53.140])
  by uls-op-cesaip01.wdc.com with ESMTP; 17 Apr 2022 22:50:30 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org
Cc:     johannes.thumshirn@wdc.com, Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH] btrfs: zoned: use dedicated lock for data relocation
Date:   Mon, 18 Apr 2022 14:50:20 +0900
Message-Id: <1ad4d3f6ed32ab2d3352adb6da7ba4ff049e79a0.1650257630.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Currently, we use btrfs_inode_{lock,unlock}() to grant an exclusive
writeback of the relocation data inode in
btrfs_zoned_data_reloc_{lock,unlock}(). However, that can cause a deadlock
in the following path.

Thread A takes btrfs_inode_lock() and waits for metadata reservation by
e.g, waiting for writeback:

prealloc_file_extent_cluster()
  - btrfs_inode_lock(&inode->vfs_inode, 0);
  - btrfs_prealloc_file_range()
  ...
    - btrfs_replace_file_extents()
      - btrfs_start_transaction
      ...
        - btrfs_reserve_metadata_bytes()

Thread B (e.g, doing a writeback work) needs to wait for the inode lock to
continue writeback process:

do_writepages
  - btrfs_writepages
    - extent_writpages
      - btrfs_zoned_data_reloc_lock(BTRFS_I(inode));
        - btrfs_inode_lock()

The deadlock is caused by relying on the vfs_inode's lock. By using it, we
introduced unnecessary exclusion of writeback and
btrfs_prealloc_file_range(). Also, the lock at this point is useless as we
don't have any dirty pages in the inode yet.

Introduce fs_info->zoned_data_reloc_io_lock and use it for the exclusive
writeback.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/ctree.h   | 1 +
 fs/btrfs/disk-io.c | 1 +
 fs/btrfs/zoned.h   | 4 ++--
 3 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 55dee124ee44..580a392d7c37 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -1056,6 +1056,7 @@ struct btrfs_fs_info {
 	 */
 	spinlock_t relocation_bg_lock;
 	u64 data_reloc_bg;
+	struct mutex zoned_data_reloc_io_lock;
 
 	u64 nr_global_roots;
 
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 2689e8589627..2a0284c2430e 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -3179,6 +3179,7 @@ void btrfs_init_fs_info(struct btrfs_fs_info *fs_info)
 	mutex_init(&fs_info->reloc_mutex);
 	mutex_init(&fs_info->delalloc_root_mutex);
 	mutex_init(&fs_info->zoned_meta_io_lock);
+	mutex_init(&fs_info->zoned_data_reloc_io_lock);
 	seqlock_init(&fs_info->profiles_lock);
 
 	INIT_LIST_HEAD(&fs_info->dirty_cowonly_roots);
diff --git a/fs/btrfs/zoned.h b/fs/btrfs/zoned.h
index fc2034e66ce3..de923fc8449d 100644
--- a/fs/btrfs/zoned.h
+++ b/fs/btrfs/zoned.h
@@ -361,7 +361,7 @@ static inline void btrfs_zoned_data_reloc_lock(struct btrfs_inode *inode)
 	struct btrfs_root *root = inode->root;
 
 	if (btrfs_is_data_reloc_root(root) && btrfs_is_zoned(root->fs_info))
-		btrfs_inode_lock(&inode->vfs_inode, 0);
+		mutex_lock(&root->fs_info->zoned_data_reloc_io_lock);
 }
 
 static inline void btrfs_zoned_data_reloc_unlock(struct btrfs_inode *inode)
@@ -369,7 +369,7 @@ static inline void btrfs_zoned_data_reloc_unlock(struct btrfs_inode *inode)
 	struct btrfs_root *root = inode->root;
 
 	if (btrfs_is_data_reloc_root(root) && btrfs_is_zoned(root->fs_info))
-		btrfs_inode_unlock(&inode->vfs_inode, 0);
+		mutex_unlock(&root->fs_info->zoned_data_reloc_io_lock);
 }
 
 #endif
-- 
2.35.1

