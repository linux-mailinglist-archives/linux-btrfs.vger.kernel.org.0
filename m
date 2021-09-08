Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E36C403D7E
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 Sep 2021 18:19:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349239AbhIHQU7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 8 Sep 2021 12:20:59 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:3327 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349076AbhIHQU6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 8 Sep 2021 12:20:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1631117989; x=1662653989;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=wLfeO5bWCLkRRy8IvRP5oFdgttxSgpU6ArkEPp/BnLI=;
  b=M3IUbbJ6i5yDv4RZWNhSFBu92N6nePFD9R+GQlDlwnHy9kady5gl6fkr
   NrDzNAOxKosiDKa5WZ8j4mq2hLkDhbjN1zTbyvZbtEfE5XhPlC+1Fm0WH
   FSR7h9be4ObJS+zyIWyN/U5Gvi1MFdSz5aNQrubYbj/R7mGObvGAE6jdi
   +DGlSTHgLirIW6jeqLRL1aDgc+Cdlu07kJS0LAGk0ovFgBq+628P7LVUg
   c+DVJei0pf9uuKRl9WkiNLqth+g6LBwIOgnaKLtMw/DOHd8o0w2Ch91Cy
   e4R60YC8awFln8kVlObg4RRHvXwHUgch/lC9+RPJ79OWpsD9mcqI/LE/D
   Q==;
X-IronPort-AV: E=Sophos;i="5.85,278,1624291200"; 
   d="scan'208";a="179493949"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 09 Sep 2021 00:19:49 +0800
IronPort-SDR: ntOVoq+Vx9WLcmZr69im0RkPSmmpgg27BEKvOWYBFxc82J35Rp/7gH2aupL1K6eQqBWJgwxxdM
 zujWr+1dhW9bZnuFjX1Hv6Lj5ED05crDohct8/VBR4cn7F2ggleLHraBCrNX/ZkGKDlWJABzSn
 kBCUo8Ex/jU2ShTRg86ZB3XWJmrsMDz7FO/YXE7QfAldVmHkC9WaAH9c5sb7jzoGVkG+qEVO3U
 CmYugU12KNvhqo1k5dBBy498bc1srVdNO1M6p/GRYeLCQ3wJTsZh7LEq7nAHLiBMCEGO9ZhU7n
 u4YajV1vYx4cq6UFoqokQKoi
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2021 08:54:47 -0700
IronPort-SDR: tLueVy95m4Fb4vMK2yBHIUA3UWpxPolpCyIfExjvcj1bcUqYCcEzjE9oAmjkaaHgAoe9s9XFKL
 E0J4DkJvawHaUsN07sHlb9iH1z2pe8tiIPc1p8WJhvOuhQjB+ZL4IQIRlISMtp7ivtPJMLl/Ro
 0ML1rYTka2Ddg0HfohgYYieDPpUrFj5Bgat2feAHKo0OcTrF4Z/VXDcRW457H+CVhiUOy5Or/R
 zxsikINraaI8tPYg4ktt82fds9lP8cbJYzqaZ6sXlty156ftguszfWvjCWVIC1WO+MGuny9r78
 DSI=
WDCIronportException: Internal
Received: from unknown (HELO redsun60.ssa.fujisawa.hgst.com) ([10.149.66.36])
  by uls-op-cesaip02.wdc.com with ESMTP; 08 Sep 2021 09:19:50 -0700
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>,
        Filipe Manana <fdmanana@suse.com>
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v2 6/8] btrfs: zoned: allow preallocation for relocation inodes
Date:   Thu,  9 Sep 2021 01:19:30 +0900
Message-Id: <7610c58a491c87e444f359988cde477783197730.1631117101.git.johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1631117101.git.johannes.thumshirn@wdc.com>
References: <cover.1631117101.git.johannes.thumshirn@wdc.com>
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

