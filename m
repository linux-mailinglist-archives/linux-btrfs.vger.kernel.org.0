Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4F1E3EA60D
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Aug 2021 15:55:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237782AbhHLNzZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 12 Aug 2021 09:55:25 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:14212 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237820AbhHLNyf (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 12 Aug 2021 09:54:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1628776450; x=1660312450;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=3COVlyNHYvAKkccrO/2zL0YSa9+zJb0lv0ZDmiI6fWs=;
  b=RRQJ9yBuLytMTGKKV4E4TCKA9u8TX0yb+GoNHB/AE4+SRwIOPeIV5CsY
   JezMYG+MismTzmcwmF0LF+IuRxpodq5ITdrvBGeB/0M2RtU25WPQmGarB
   MIwt9YvvBwjZOt5FCIgOnVKltU94UYWUDa2qVO68imGW+QE7M65eml8o8
   RPdubLPEiFcWR2LDRBWCAnJSP+sM/HqySSqi+oEIO/pXVo10/a+sf+19b
   lftemu+r+UuTbimaBZ/0tCuxHlTpTf0ueCSC9lzmYkVwEoxQUJ0Gd6k3b
   59PXWuEf4LEOMUyrlpqX7g66Lqsg1tM9nGsp8zxgcYqTrw+gt1fkck2SQ
   Q==;
X-IronPort-AV: E=Sophos;i="5.84,316,1620662400"; 
   d="scan'208";a="181849473"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 12 Aug 2021 21:54:04 +0800
IronPort-SDR: ScwQNBQwfSA2u+Y80QeCoPA+GJTuMyGthl6a9qXbyBTg5d5PdowmYCE3Cwwly1Bjh821RBR0iy
 O2iIthDT9nMfB9v7Z3wIVz3BvjSfCPl/oG0tD+TsXHJGx0gvKFVbzs8xhaEj+F3uhGgn48S6Yb
 7jfEGP62KeEmfBi2Xz1dty8WCjcnLG+Rn3VkioweLXlyk562T4iA+n9vL2Hu5mLeCAmDIcvOm6
 SlqZIJzyfQdKX32GnMkzde+kCogYLz/wbxzoZfn96S1xln4J7w9APEI8IKAGWHD3DSU9BNxvBh
 PxMlCpjp4/regI9Wvn5c4h3N
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2021 06:31:23 -0700
IronPort-SDR: cD0KVASAFJ5gp9sYzCjx6KAbJMrZeAznkaCDX6Rtl8QBGUlRIJcUTVLkDUmbOGu9AryGaobChg
 3DDyz/LPchIUmaG1rAXSkPbW0qvU8GZklWCuuIilhDBFccn0YnBFahtS8ivx0J/pxdl//MWtfH
 Wb95gUAK6iuCwpId7IQW0cnqexCCfZcBGQ3NhyCm4MclXvxXa8kxAaC3qd4MhIW2PTSLWtuJ35
 H0LzNRNWQLEI/ZRANs3XA6q222oPH9Lul1N5Sg7gAoqak3Y2gZb089Ck60Vk+WTVU3KZppAI1J
 cOw=
WDCIronportException: Internal
Received: from unknown (HELO redsun60.ssa.fujisawa.hgst.com) ([10.149.66.36])
  by uls-op-cesaip02.wdc.com with ESMTP; 12 Aug 2021 06:54:04 -0700
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     David Sterba <dsterba@suse.com>
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>,
        Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH] btrfs: zoned: exclude relocation and page writeback
Date:   Thu, 12 Aug 2021 22:53:49 +0900
Message-Id: <a858fb2ff980db27b3638e92f7d2d7a416b8e81e.1628776260.git.johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Relocation in a zoned filesystem can fail with a transaction abort with
error -22 (EINVAL). This happens because the relocation code assumes that
the extents we relocated the data to have the same size the source extents
had and ensures this by preallocating the extents.

But in a zoned filesystem we can't preallocate the extents as this would
break the sequential write required rule. Therefore it can happen that the
writeback process kicks in while we're still adding pages to a
delallocation range and starts writing out dirty pages.

This then creates destination extents that are smaller than the source
extents, triggering the following safety check in get_new_location():

 1034         if (num_bytes != btrfs_file_extent_disk_num_bytes(leaf, fi)) {
 1035                 ret = -EINVAL;
 1036                 goto out;
 1037         }

One possible solution to address this problem is to mutually exclude page
writeback and adding pages to the relocation inode. This ensures, that
we're not submitting an extent before all needed pages have been added to
it.

Introduce a new lock in the btrfs_inode which is only taken *IFF* the
inode is a data relocation inode on a zoned filesystem to mutually exclude
relocation's construction of extents and page writeback.

Fixes: 32430c614844 ("btrfs: zoned: enable relocation on a zoned filesystem")
Reported-by: David Sterba <dsterba@suse.com>
Cc: Filipe Manana <fdmanana@suse.com>
Cc: Naohiro Aota <naohiro.aota@wdc.com>
Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/btrfs_inode.h |  3 +++
 fs/btrfs/extent_io.c   |  4 ++++
 fs/btrfs/inode.c       |  1 +
 fs/btrfs/relocation.c  | 10 +++++++---
 fs/btrfs/zoned.h       | 27 +++++++++++++++++++++++++++
 5 files changed, 42 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/btrfs_inode.h b/fs/btrfs/btrfs_inode.h
index 76ee1452c57b..954e772f18e8 100644
--- a/fs/btrfs/btrfs_inode.h
+++ b/fs/btrfs/btrfs_inode.h
@@ -231,6 +231,9 @@ struct btrfs_inode {
 
 	struct rw_semaphore i_mmap_lock;
 	struct inode vfs_inode;
+
+	/* Protects relocation from page writeback on a zoned FS */
+	struct mutex relocation_lock;
 };
 
 static inline u32 btrfs_inode_sectorsize(const struct btrfs_inode *inode)
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 96de6e70d06c..59c79eb51612 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -5005,7 +5005,9 @@ static int extent_write_cache_pages(struct address_space *mapping,
 				continue;
 			}
 
+			btrfs_zoned_relocation_io_lock(BTRFS_I(inode));
 			ret = __extent_writepage(page, wbc, epd);
+			btrfs_zoned_relocation_io_unlock(BTRFS_I(inode));
 			if (ret < 0) {
 				done = 1;
 				break;
@@ -5056,7 +5058,9 @@ int extent_write_full_page(struct page *page, struct writeback_control *wbc)
 		.sync_io = wbc->sync_mode == WB_SYNC_ALL,
 	};
 
+	btrfs_zoned_relocation_io_lock(BTRFS_I(page->mapping->host));
 	ret = __extent_writepage(page, wbc, &epd);
+	btrfs_zoned_relocation_io_unlock(BTRFS_I(page->mapping->host));
 	ASSERT(ret <= 0);
 	if (ret < 0) {
 		end_write_bio(&epd, ret);
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index afe9dcda860b..8e8e56f79a86 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -9120,6 +9120,7 @@ struct inode *btrfs_alloc_inode(struct super_block *sb)
 	INIT_LIST_HEAD(&ei->delayed_iput);
 	RB_CLEAR_NODE(&ei->rb_node);
 	init_rwsem(&ei->i_mmap_lock);
+	mutex_init(&ei->relocation_lock);
 
 	return inode;
 }
diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 914d403b4415..8630d45e0fca 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -25,6 +25,7 @@
 #include "backref.h"
 #include "misc.h"
 #include "subpage.h"
+#include "zoned.h"
 
 /*
  * Relocation overview
@@ -3069,8 +3070,6 @@ static int relocate_one_page(struct inode *inode, struct file_ra_state *ra,
 	unlock_page(page);
 	put_page(page);
 
-	balance_dirty_pages_ratelimited(inode->i_mapping);
-	btrfs_throttle(fs_info);
 	if (btrfs_should_cancel_balance(fs_info))
 		ret = -ECANCELED;
 	return ret;
@@ -3111,9 +3110,14 @@ static int relocate_file_extent_cluster(struct inode *inode,
 		goto out;
 
 	last_index = (cluster->end - offset) >> PAGE_SHIFT;
+	btrfs_zoned_relocation_io_lock(BTRFS_I(inode));
 	for (index = (cluster->start - offset) >> PAGE_SHIFT;
-	     index <= last_index && !ret; index++)
+	     index <= last_index && !ret; index++) {
 		ret = relocate_one_page(inode, ra, cluster, &cluster_nr, index);
+	}
+	btrfs_zoned_relocation_io_unlock(BTRFS_I(inode));
+	balance_dirty_pages_ratelimited(inode->i_mapping);
+	btrfs_throttle(fs_info);
 	if (btrfs_is_zoned(fs_info) && !ret)
 		ret = btrfs_wait_ordered_range(inode, 0, (u64)-1);
 	if (ret == 0)
diff --git a/fs/btrfs/zoned.h b/fs/btrfs/zoned.h
index 4b299705bb12..70d2d65bf5cc 100644
--- a/fs/btrfs/zoned.h
+++ b/fs/btrfs/zoned.h
@@ -8,6 +8,7 @@
 #include "volumes.h"
 #include "disk-io.h"
 #include "block-group.h"
+#include "btrfs_inode.h"
 
 /*
  * Block groups with more than this value (percents) of unusable space will be
@@ -304,6 +305,32 @@ static inline void btrfs_zoned_meta_io_unlock(struct btrfs_fs_info *fs_info)
 	mutex_unlock(&fs_info->zoned_meta_io_lock);
 }
 
+static inline void btrfs_zoned_relocation_io_lock(struct btrfs_inode *inode)
+{
+	struct btrfs_root *root = inode->root;
+
+	if (!btrfs_is_zoned(root->fs_info))
+		return;
+
+	if (root->root_key.objectid != BTRFS_DATA_RELOC_TREE_OBJECTID)
+		return;
+
+	mutex_lock(&inode->relocation_lock);
+}
+
+static inline void btrfs_zoned_relocation_io_unlock(struct btrfs_inode *inode)
+{
+	struct btrfs_root *root = inode->root;
+
+	if (!btrfs_is_zoned(root->fs_info))
+		return;
+
+	if (root->root_key.objectid != BTRFS_DATA_RELOC_TREE_OBJECTID)
+		return;
+
+	mutex_unlock(&inode->relocation_lock);
+}
+
 static inline void btrfs_clear_treelog_bg(struct btrfs_block_group *bg)
 {
 	struct btrfs_fs_info *fs_info = bg->fs_info;
-- 
2.32.0

