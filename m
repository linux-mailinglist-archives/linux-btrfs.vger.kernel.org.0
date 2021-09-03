Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71F2640016D
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 Sep 2021 16:45:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349033AbhICOqB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 3 Sep 2021 10:46:01 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:12649 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235394AbhICOqB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 3 Sep 2021 10:46:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1630680301; x=1662216301;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zPl1Kb2xxD/sV+r0/CoOpxRrM5fVBtpaOd7IzKRg3xM=;
  b=JnMcn8NPKm0hTV93730NZSJTUMwIqVh4mzqyZ0ptfDTmG7cN3XzaNOG2
   z9zAP5qOhdPntDs5RCCcmr3NXhJT+Dez76Ag+W7+QQvOQwR87I+WkZrUp
   94ODTcaTQTIvLNWnCt/1GiKM6EaE9XdoLWnziZe8Yk/Uhc8O5i19SjQko
   1LBRa/gWXAit9nFeURWeWPs9r6MWfy3H6Akl5J1Un+1/uYDCZx9JPsX2i
   7T/dmEDNRV0zujYfQ6KYyO9niY5tBAjnzN+KYh0xn/ltUtY1841bsaeAB
   S/CaPCSlA0Vt6XNmeek8b4S0GizMXb1N7aRZCAdRr5wLrtxlAca96XRdJ
   g==;
X-IronPort-AV: E=Sophos;i="5.85,265,1624291200"; 
   d="scan'208";a="179681170"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 03 Sep 2021 22:45:01 +0800
IronPort-SDR: vL+upddS3mWY5JeioF2r97ddU57UZkAkP0Pq+SVrV0N0pj34EGRqQdN5JbY3BAWkp1Ku+CBt56
 YuxPc+zMcONec8wYamYCz+qAxkXdk5KOjY+XRWTs4v9HriQmdy997aZy735vS1H3CjppN9R3ET
 rChFkzBuK3OkDTeiSzXVyJdvIKbh9VLoIqHotzgcvE912Ku9VzoTsBa5tDbnlAoDDO1p31Qeol
 +1IsrGspIrKTn9R5g4rZC6s/Qn4RwBt3ANtRZ3PMcR1r/nhP8YC6p3kvEM1sobX4ltuyyTKdp2
 vFy8S2eTjiIKSoAz4Y+pQUcC
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2021 07:20:04 -0700
IronPort-SDR: kJkw5r0V31+MehgenUHj3qhcZhS5j/VqHOupNfRcDcayJSSdWGT9LSErEsfvVJpMeQgPfPsAbW
 UVLm0Uaas5olvPEbDaaD8sax/0qPIu4FfTSHclJsZ8qbvsitjCunR1enQzqyiIqN6BtgL07NWk
 DlkW6AGi1agrlfcsJAQkm6Pz1OkCdQQeyQGWKvvQS67QvX+39aX6RWshmpe6uVIruAUa+i9DZL
 nBdtCxlJ1rWQLS2R3SPqMRRs5mlUUH8k/olZAHu6OeMT0VfslFVBw/Lh1zB/kYSx2cglhEyhAA
 pLY=
WDCIronportException: Internal
Received: from unknown (HELO redsun60.ssa.fujisawa.hgst.com) ([10.149.66.36])
  by uls-op-cesaip02.wdc.com with ESMTP; 03 Sep 2021 07:45:00 -0700
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     David Sterba <dsterba@suse.com>
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH 1/6] btrfs: introduce btrfs_is_data_reloc_root
Date:   Fri,  3 Sep 2021 23:44:42 +0900
Message-Id: <9f8e2c5add21ca257c7b5df8e86c87c2de9b672e.1630679569.git.johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1630679569.git.johannes.thumshirn@wdc.com>
References: <cover.1630679569.git.johannes.thumshirn@wdc.com>
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
index 41ea50f48cfe..9a6be409c1d6 100644
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
index 0517f31a3bed..8e1a46e9c63e 100644
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

