Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 692D2400171
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 Sep 2021 16:45:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349513AbhICOqL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 3 Sep 2021 10:46:11 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:12649 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349217AbhICOqH (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 3 Sep 2021 10:46:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1630680308; x=1662216308;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=wLfeO5bWCLkRRy8IvRP5oFdgttxSgpU6ArkEPp/BnLI=;
  b=dKNPOH0zKpXvc8MrQl51MUi7+4UodzxgXZBtu7ilwDg9U9cqOzRnzisn
   nP5HRhhnWmf7y8hEp1wR0Fq2w5Z1/sWFhpTS0PPcgQ70wDVtIG4g+KZHS
   yBOU22TeQz4Lj1j7S/BwyQUdOknIWp6/wUzSRJ5fN49JTeukpeTuGGIrk
   fdVE8hXVe+mepQPrQogYf3ulwDWyjrgS3ta1odWiAy0QaYmTiMn9iiFxm
   xM12pXjZNsOuRgUnc6YHfzp0A4AR08RsE8d42e8/8qdC9F+V99753kljm
   LiLCAt17KRNf/nW9xsTM4pDgCD7wHudvyJ4U3JZB7na745CoGM3N/adCp
   g==;
X-IronPort-AV: E=Sophos;i="5.85,265,1624291200"; 
   d="scan'208";a="179681185"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 03 Sep 2021 22:45:08 +0800
IronPort-SDR: W/+YXL1NKamFLcu/OlTrUdH6ce8WHMzBMQ0A2RrtgaXeVPlYwKL6woeqJG9cUXqCNX9TkYnIml
 cm99hy+hm4tbAwxSJ9I1kIAYl8wKwXwhtiOWPObEeDv5YXSV//s344d0lx6+Z/5Ppc36cG7vlT
 pSwoXgHOdFFTzx4Kr258xSmobOCfdjpYo9baaYJVc9wAKkNPj7V7C/ZlE8wpxy4OI/Wh7H787v
 jIuE8dg2o7XrM2po76NnXR/IiQ8wnocU3MNNEPOM4nmsu6vHJW79PsbpSc19n+Gk1+c4Y0Z7HL
 MmjD8ua3v1kkhC/dntqXA+mH
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2021 07:20:10 -0700
IronPort-SDR: LjMB1ZXBr7hp0yoCxDIhprpEUE6zwFuvYaPDVZABGxcKQzA2Tswr1iWM1vyc968HVc76ibLnvs
 74UPOaT/1saL8VFeiZWKUiDKAORNXezZFoEDbC3nwidG9dquHvzoK3ZDThJPPku8y8FHTzExwD
 nD6BXzF/kenKGMMfDLK0Uvwiq5WSmoW4w5Gy6lz9XQXzu160CSrOE1HpBmov6MOic+PxmDTNAv
 EJ0HQLpr3ofvOFpOizSaTVrNhveM85B3OYkZue4VypMlkOBGBkuWnvKs9WeM9dYyx+cdu+abk0
 1P8=
WDCIronportException: Internal
Received: from unknown (HELO redsun60.ssa.fujisawa.hgst.com) ([10.149.66.36])
  by uls-op-cesaip02.wdc.com with ESMTP; 03 Sep 2021 07:45:06 -0700
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     David Sterba <dsterba@suse.com>
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH 5/6] btrfs: zoned: allow preallocation for relocation inodes
Date:   Fri,  3 Sep 2021 23:44:46 +0900
Message-Id: <51f7e2a92f41d5c45861aedf5f518a94e57b0559.1630679569.git.johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1630679569.git.johannes.thumshirn@wdc.com>
References: <cover.1630679569.git.johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Now that we use a dedicated block group and regular WRITEs for data relocation,
we can preallocate the space needed for a relocated inode, just like
regular btrfs does as well.

Essentially this reverts commit 32430c614844 ("btrfs: zoned: enable relocation
on a zoned filesystem") as it is not needed anymore.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/relocation.c | 35 ++---------------------------------
 1 file changed, 2 insertions(+), 33 deletions(-)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 3c9c0aab7fc3..6f668bc01cd1 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -2853,31 +2853,6 @@ static noinline_for_stack int prealloc_file_extent_cluster(
 	if (ret)
 		return ret;
 
-	/*
-	 * On a zoned filesystem, we cannot preallocate the file region.
-	 * Instead, we dirty and fiemap_write the region.
-	 */
-	if (btrfs_is_zoned(inode->root->fs_info)) {
-		struct btrfs_root *root = inode->root;
-		struct btrfs_trans_handle *trans;
-
-		end = cluster->end - offset + 1;
-		trans = btrfs_start_transaction(root, 1);
-		if (IS_ERR(trans))
-			return PTR_ERR(trans);
-
-		inode->vfs_inode.i_ctime = current_time(&inode->vfs_inode);
-		i_size_write(&inode->vfs_inode, end);
-		ret = btrfs_update_inode(trans, root, inode);
-		if (ret) {
-			btrfs_abort_transaction(trans, ret);
-			btrfs_end_transaction(trans);
-			return ret;
-		}
-
-		return btrfs_end_transaction(trans);
-	}
-
 	btrfs_inode_lock(&inode->vfs_inode, 0);
 	for (nr = 0; nr < cluster->nr; nr++) {
 		start = cluster->boundary[nr] - offset;
@@ -3085,7 +3060,6 @@ static int relocate_one_page(struct inode *inode, struct file_ra_state *ra,
 static int relocate_file_extent_cluster(struct inode *inode,
 					struct file_extent_cluster *cluster)
 {
-	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
 	u64 offset = BTRFS_I(inode)->index_cnt;
 	unsigned long index;
 	unsigned long last_index;
@@ -3115,8 +3089,6 @@ static int relocate_file_extent_cluster(struct inode *inode,
 	for (index = (cluster->start - offset) >> PAGE_SHIFT;
 	     index <= last_index && !ret; index++)
 		ret = relocate_one_page(inode, ra, cluster, &cluster_nr, index);
-	if (btrfs_is_zoned(fs_info) && !ret)
-		ret = btrfs_wait_ordered_range(inode, 0, (u64)-1);
 	if (ret == 0)
 		WARN_ON(cluster_nr != cluster->nr);
 out:
@@ -3771,12 +3743,8 @@ static int __insert_orphan_inode(struct btrfs_trans_handle *trans,
 	struct btrfs_path *path;
 	struct btrfs_inode_item *item;
 	struct extent_buffer *leaf;
-	u64 flags = BTRFS_INODE_NOCOMPRESS | BTRFS_INODE_PREALLOC;
 	int ret;
 
-	if (btrfs_is_zoned(trans->fs_info))
-		flags &= ~BTRFS_INODE_PREALLOC;
-
 	path = btrfs_alloc_path();
 	if (!path)
 		return -ENOMEM;
@@ -3791,7 +3759,8 @@ static int __insert_orphan_inode(struct btrfs_trans_handle *trans,
 	btrfs_set_inode_generation(leaf, item, 1);
 	btrfs_set_inode_size(leaf, item, 0);
 	btrfs_set_inode_mode(leaf, item, S_IFREG | 0600);
-	btrfs_set_inode_flags(leaf, item, flags);
+	btrfs_set_inode_flags(leaf, item, BTRFS_INODE_NOCOMPRESS |
+					  BTRFS_INODE_PREALLOC);
 	btrfs_mark_buffer_dirty(leaf);
 out:
 	btrfs_free_path(path);
-- 
2.32.0

