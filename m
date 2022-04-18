Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11DF3504D11
	for <lists+linux-btrfs@lfdr.de>; Mon, 18 Apr 2022 09:15:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236151AbiDRHRs (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 18 Apr 2022 03:17:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229962AbiDRHRp (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 18 Apr 2022 03:17:45 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20AC16575
        for <linux-btrfs@vger.kernel.org>; Mon, 18 Apr 2022 00:15:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1650266108; x=1681802108;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=FHJhQbbLnjYGV3TGSwNfM1v2GdUAfeJYW6wI/vjwJBA=;
  b=BOHcFZ1x5l3rkSYj3L6zkfI20alQAUXO/eqXo73y6FomfTRwtMb5C5K6
   qkgUe/BdhsUH1Dz1dl9RdWU8fvQdr5aaXNjXZqgZSvMUsqvvSXoKV9aO9
   7MWbhuZQFsSN8cSRLjxvYMXS2z2VnLmLrLT6njbLDdo7q15rh8QibPp4d
   NfdmN92mgC8XyA/f+/RuhZftqiHmqFa0JVvRexmvnywUupyMTzGZlscXb
   aThrKmWOlNiOibyTHLVrxw33WqHjXlo/fWin7BIRaaMuS0sppEALcUtDw
   4DztWp1/cLGmYKzGi9SBCAh84ALDCc0ZaGgEfIkITTk3jE3smw/sZHQEB
   Q==;
X-IronPort-AV: E=Sophos;i="5.90,269,1643644800"; 
   d="scan'208";a="310116601"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 18 Apr 2022 15:15:07 +0800
IronPort-SDR: MI0nNDE7j8uOPfLssqw7L74JR9LHD3pGmwdz+hTjEmEhGKsLTs8L5FIyxc7ofOGQDd2SMQFdVF
 yGcE4ur94ka9lILXhjss4k5ju8I7llf3cZ9+l3xvsUqV7OyFxc4Kuy6Ywov3LQTfxmZMRX5HZ1
 aOpTyEIiOtEQ5xyBY7MPodvbBKbxPiK9nH+vFGeq+iEZg3Nnd/QBQ/KAGaS/SsfQPJSqqDr7zi
 mAoRnEFpp8OYxJbTZrkk0FT7+8dtljqLQQiNIuzfLrV3oupUvW3aPptf03INMUfd0pLU58Y6zi
 wPedsNwKnhpwEseF1pcNvZ3a
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 17 Apr 2022 23:45:28 -0700
IronPort-SDR: /17YbDVUphiBCjTH3bCgOUMCEJAZg6zHjfBs3c/x6VwvXRA1iXbp/w+k8p2B2KTgwTmccxOLFH
 ZbUByS/3d52m9XNGfCrRoqAkmG1+EaqoZ1WgWL9oK5c3AIf5qxcq+RVg2R4Xs3c1D3ecAzgiGh
 kh1QSwTfpsZKf8PDArTq3MkT1Quxy3w0HMfNez4iACL67Wo2q5qeaXRiw7yhOQjpwltJv4KAfr
 /4AxKckNJrNz5dAW9lqWJnb/RH/bw5nJ1w950PEjQouUKy3M8VulBI9PzS87KkEjPyte1eEYLi
 zxc=
WDCIronportException: Internal
Received: from 5sry1z2.ad.shared (HELO naota-xeon.ad.shared) ([10.225.53.152])
  by uls-op-cesaip02.wdc.com with ESMTP; 18 Apr 2022 00:15:08 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org
Cc:     johannes.thumshirn@wdc.com, Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH] btrfs: zoned: use dedicated lock for data relocation
Date:   Mon, 18 Apr 2022 16:15:03 +0900
Message-Id: <4ebda439981990cd5903e4fba19f199b4eb36fba.1650266002.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
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

Fixes: 35156d852762 ("btrfs: zoned: only allow one process to add pages to a relocation inode")
CC: stable@vger.kernel.org # 5.16 869f4cdc73f9
CC: stable@vger.kernel.org # 5.17
Cc: Johannes Thumshirn <johannes.thumshirn@wdc.com>
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

