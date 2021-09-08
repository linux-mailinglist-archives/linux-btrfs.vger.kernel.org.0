Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32EBE403D79
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 Sep 2021 18:19:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348697AbhIHQUw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 8 Sep 2021 12:20:52 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:3327 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347311AbhIHQUv (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 8 Sep 2021 12:20:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1631117982; x=1662653982;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=GYpFKNRpd41hqGMfWj37r2AMYvC9qtlunoHuJXbFeGA=;
  b=iy7OQ7fvQz1APDottisZdHbmFpVXBdjldOkenDtJEBhd/aXSB8KEqCFY
   qflSZfqmU916EWpIHzeB9uczqkTYOucMNXflHZsNgGBKdV49cRMAtXRV+
   SyKZ++Hv11wnGdwxqD4V84rf/B2AyW8WoM0dzt9abhJwyqj0Wf7YBtbUs
   9RpPUJRfc9jmtU6NByj8Bnz2q3VdAyqWuo2MUTh23DOQGZhkeStcz9oa1
   HYmPKfPp5WM+b6Rq+gxxKSdoFfC62wXuEMdM+zK9BRBEeXmZCK2wO6w31
   qXwPa273kYRKzP7/uSs3ura6iMP8kpE4VnJbMGNaVmoXHrTLf0jQ/LNOm
   w==;
X-IronPort-AV: E=Sophos;i="5.85,278,1624291200"; 
   d="scan'208";a="179493935"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 09 Sep 2021 00:19:42 +0800
IronPort-SDR: IDMvioCEgkKC5T+XypvCrIAY0Al9xFL3wLEmPyO6XpsFxDudn9Ma7jTOr/kYoudM97iNiSf6dy
 hq+NUYx+EuV4/E6Aq2GupLFDtJd916Zn/cKYPfes4ksPDcM/gQvh/jhn7hs5P/WYfnE5VR31bb
 p0Npcq0wZy2W9pnNcpkQ7BJ5BldhJ12r5qKXBV32vsRictYHDE94Mzn3Odj3qpsFZcbVvNECtq
 uU8+QGuL/YSx9yms/Sg/3b24f6MEIWR9TjafhyjcQy18JLRfWZQgGf+nL33GfVxnalqtz2Ni3O
 mxRMX46pykoIr3mxeOODdam4
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2021 08:54:40 -0700
IronPort-SDR: x4xUruK5I4s9SmY6jbW6areFNtNR0FCs8lKnAQIfxk/0nbQlwtdgA4DLY2V4+PRk0PQT9e4Ick
 GIf1uOuQMakrXHKxLDxLoocWu2wOvfs57szJzUy28DdIz8G5eX7IB0CKysam3M1QmOs/h7D1bo
 cBYZGQRylL334jnfI7ahCk0rccPobWWhiC0KdaiPX7/COpDIrZrRZRMDrOpcO6Ye17XKxX/7+Z
 XO68CwkQWWn73IFKechDEjCmiOXkQRUQmGUlrLAXb0KkSbrpOH5wYjQc2RGS8pn9sR4zOcyA03
 iFY=
WDCIronportException: Internal
Received: from unknown (HELO redsun60.ssa.fujisawa.hgst.com) ([10.149.66.36])
  by uls-op-cesaip02.wdc.com with ESMTP; 08 Sep 2021 09:19:43 -0700
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>,
        Filipe Manana <fdmanana@suse.com>
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v2 1/8] btrfs: introduce btrfs_is_data_reloc_root
Date:   Thu,  9 Sep 2021 01:19:25 +0900
Message-Id: <79cc0b662b3ece2d27b22ba35535ad58b0b0755d.1631117101.git.johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1631117101.git.johannes.thumshirn@wdc.com>
References: <cover.1631117101.git.johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

There are several places in our codebase where we check if a root is the
root of the data reloc tree and subsequent patches will introduce more.

Factor out the check into a small helper function instead of open coding
it multiple times.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Reviewed-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/ctree.h       |  5 +++++
 fs/btrfs/disk-io.c     |  2 +-
 fs/btrfs/extent-tree.c |  2 +-
 fs/btrfs/inode.c       | 19 ++++++++-----------
 fs/btrfs/relocation.c  |  2 +-
 5 files changed, 16 insertions(+), 14 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 38870ae46cbb..8cc0b29e24ee 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -3846,6 +3846,11 @@ static inline bool btrfs_is_zoned(const struct btrfs_fs_info *fs_info)
 	return fs_info->zoned != 0;
 }
 
+static inline bool btrfs_is_data_reloc_root(const struct btrfs_root *root)
+{
+	return root->root_key.objectid == BTRFS_DATA_RELOC_TREE_OBJECTID;
+}
+
 /*
  * We use page status Private2 to indicate there is an ordered extent with
  * unfinished IO.
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 7d80e5b22d32..d63c5e776a96 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -1500,7 +1500,7 @@ static int btrfs_init_fs_root(struct btrfs_root *root, dev_t anon_dev)
 		goto fail;
 
 	if (root->root_key.objectid != BTRFS_TREE_LOG_OBJECTID &&
-	    root->root_key.objectid != BTRFS_DATA_RELOC_TREE_OBJECTID) {
+	    !btrfs_is_data_reloc_root(root)) {
 		set_bit(BTRFS_ROOT_SHAREABLE, &root->state);
 		btrfs_check_and_init_root_item(&root->root_item);
 	}
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 7d03ffa04bce..239e09f7239a 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -2376,7 +2376,7 @@ int btrfs_cross_ref_exist(struct btrfs_root *root, u64 objectid, u64 offset,
 
 out:
 	btrfs_free_path(path);
-	if (root->root_key.objectid == BTRFS_DATA_RELOC_TREE_OBJECTID)
+	if (btrfs_is_data_reloc_root(root))
 		WARN_ON(ret > 0);
 	return ret;
 }
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index a3ce50289888..e89e16a9c56c 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -1150,7 +1150,7 @@ static noinline int cow_file_range(struct btrfs_inode *inode,
 	 * fails during the stage where it updates the bytenr of file extent
 	 * items.
 	 */
-	if (root->root_key.objectid == BTRFS_DATA_RELOC_TREE_OBJECTID)
+	if (btrfs_is_data_reloc_root(root))
 		min_alloc_size = num_bytes;
 	else
 		min_alloc_size = fs_info->sectorsize;
@@ -1186,8 +1186,7 @@ static noinline int cow_file_range(struct btrfs_inode *inode,
 		if (ret)
 			goto out_drop_extent_cache;
 
-		if (root->root_key.objectid ==
-		    BTRFS_DATA_RELOC_TREE_OBJECTID) {
+		if (btrfs_is_data_reloc_root(root)) {
 			ret = btrfs_reloc_clone_csums(inode, start,
 						      cur_alloc_size);
 			/*
@@ -1503,8 +1502,7 @@ static int fallback_to_cow(struct btrfs_inode *inode, struct page *locked_page,
 			   int *page_started, unsigned long *nr_written)
 {
 	const bool is_space_ino = btrfs_is_free_space_inode(inode);
-	const bool is_reloc_ino = (inode->root->root_key.objectid ==
-				   BTRFS_DATA_RELOC_TREE_OBJECTID);
+	const bool is_reloc_ino = btrfs_is_data_reloc_root(inode->root);
 	const u64 range_bytes = end + 1 - start;
 	struct extent_io_tree *io_tree = &inode->io_tree;
 	u64 range_start = start;
@@ -1866,8 +1864,7 @@ static noinline int run_delalloc_nocow(struct btrfs_inode *inode,
 			btrfs_dec_nocow_writers(fs_info, disk_bytenr);
 		nocow = false;
 
-		if (root->root_key.objectid ==
-		    BTRFS_DATA_RELOC_TREE_OBJECTID)
+		if (btrfs_is_data_reloc_root(root))
 			/*
 			 * Error handled later, as we must prevent
 			 * extent_clear_unlock_delalloc() in error handler
@@ -2206,7 +2203,7 @@ void btrfs_clear_delalloc_extent(struct inode *vfs_inode,
 		if (btrfs_is_testing(fs_info))
 			return;
 
-		if (root->root_key.objectid != BTRFS_DATA_RELOC_TREE_OBJECTID &&
+		if (!btrfs_is_data_reloc_root(root) &&
 		    do_list && !(state->state & EXTENT_NORESERVE) &&
 		    (*bits & EXTENT_CLEAR_DATA_RESV))
 			btrfs_free_reserved_data_space_noquota(fs_info, len);
@@ -2531,7 +2528,7 @@ blk_status_t btrfs_submit_data_bio(struct inode *inode, struct bio *bio,
 		goto mapit;
 	} else if (async && !skip_sum) {
 		/* csum items have already been cloned */
-		if (root->root_key.objectid == BTRFS_DATA_RELOC_TREE_OBJECTID)
+		if (btrfs_is_data_reloc_root(root))
 			goto mapit;
 		/* we're doing a write, do the async checksumming */
 		ret = btrfs_wq_submit_bio(inode, bio, mirror_num, bio_flags,
@@ -3307,7 +3304,7 @@ unsigned int btrfs_verify_data_csum(struct btrfs_io_bio *io_bio, u32 bio_offset,
 		u64 file_offset = pg_off + page_offset(page);
 		int ret;
 
-		if (root->root_key.objectid == BTRFS_DATA_RELOC_TREE_OBJECTID &&
+		if (btrfs_is_data_reloc_root(root) &&
 		    test_range_bit(io_tree, file_offset,
 				   file_offset + sectorsize - 1,
 				   EXTENT_NODATASUM, 1, NULL)) {
@@ -4008,7 +4005,7 @@ noinline int btrfs_update_inode(struct btrfs_trans_handle *trans,
 	 * without delay
 	 */
 	if (!btrfs_is_free_space_inode(inode)
-	    && root->root_key.objectid != BTRFS_DATA_RELOC_TREE_OBJECTID
+	    && !btrfs_is_data_reloc_root(root)
 	    && !test_bit(BTRFS_FS_LOG_RECOVERING, &fs_info->flags)) {
 		btrfs_update_root_times(trans, root);
 
diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 63d2b22cf438..3c9c0aab7fc3 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -4391,7 +4391,7 @@ int btrfs_reloc_cow_block(struct btrfs_trans_handle *trans,
 		return 0;
 
 	BUG_ON(rc->stage == UPDATE_DATA_PTRS &&
-	       root->root_key.objectid == BTRFS_DATA_RELOC_TREE_OBJECTID);
+	       btrfs_is_data_reloc_root(root));
 
 	level = btrfs_header_level(buf);
 	if (btrfs_header_generation(buf) <=
-- 
2.32.0

