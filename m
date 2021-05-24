Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB81738E41F
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 May 2021 12:36:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232584AbhEXKhs (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 24 May 2021 06:37:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:49566 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232476AbhEXKho (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 24 May 2021 06:37:44 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CC22861132
        for <linux-btrfs@vger.kernel.org>; Mon, 24 May 2021 10:36:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621852562;
        bh=OtoidJ5+iBBb9ACif4keib0KiMFJjvwq1Hugb2KTFrw=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=sSc8P8sJ3vpc/4T1lnEqmLvjX68k6XHu+fCkkDRmf+UecOuLMtjo6rPT6X88lFj+2
         SInB7pCV3SizcVSOg7CXEwZ7vHMAPgW+bCj6i8qSZJGmk+boqVsEZNMvGLqsLphCt7
         oldm6NAO6/9ntCjAv9M/BfrBwWIaxu2rYGEkwq4jMwlpi5lUsMyCL5wp0q9HP4gOXC
         ZuvF47ukLx4DVQQMBl42hFPHnxFVYBUnTNHPkehGXIRAh1UDsp4K+rAZ07yEBPPHdp
         BZI094BO/nLij34gT9oOZPCoBjbj2G4++zEVK/K7Hf2m+EIgAR5ZvaIJptEk1L6Cxc
         Vb0K+HOBdEa7w==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 3/3] btrfs: don't set the full sync flag when truncation does not touch extents
Date:   Mon, 24 May 2021 11:35:55 +0100
Message-Id: <cd884705080efecfbd02a5fd123a2d2396f2f1a3.1621851896.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1621851896.git.fdmanana@suse.com>
References: <cover.1621851896.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

At btrfs_truncate() where we truncate the inode either to the same size
or to a smaller size, we always set the full sync flag on the inode.

This is needed in case the truncation drops or trims any file extent items
that start beyond or cross the new inode size, so that the next fsync
drops all inode items from the log and scans again the fs/subvolume tree
to find all items that must be logged.

However if the truncation does not drop or trims any file extent items, we
do not need to set the full sync flag and force the next fsync to use the
slow code path. So do not set the full sync flag in such cases.

One use case where it is frequent to do truncations that do not change
the inode size and do not drop any extents (no prealloc extents beyond
i_size) is when running Microsoft's SQL Server inside a Docker container.
One example workload is the one Philipp Fent reported recently, in the
thread with a link below. In this workload a large number of fsyncs are
preceded by such truncate operations.

After this change I constantly get the runtime for that workload from
Philipp to be reduced by about -12%, for example from 184 seconds down
to 162 seconds.

Link: https://lore.kernel.org/linux-btrfs/93c4600e-5263-5cba-adf0-6f47526e7561@in.tum.de/
Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/ctree.h            |  2 +-
 fs/btrfs/free-space-cache.c |  2 +-
 fs/btrfs/inode.c            | 41 +++++++++++++++++++++++++++----------
 fs/btrfs/tree-log.c         |  5 +++--
 4 files changed, 35 insertions(+), 15 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 1807e7a8d1d7..9f8a26b7cf41 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -3125,7 +3125,7 @@ int btrfs_truncate_block(struct btrfs_inode *inode, loff_t from, loff_t len,
 int btrfs_truncate_inode_items(struct btrfs_trans_handle *trans,
 			       struct btrfs_root *root,
 			       struct btrfs_inode *inode, u64 new_size,
-			       u32 min_type);
+			       u32 min_type, u64 *extents_found);
 
 int btrfs_start_delalloc_snapshot(struct btrfs_root *root,
 				  bool in_reclaim_context);
diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
index e54466fc101f..c72032224d46 100644
--- a/fs/btrfs/free-space-cache.c
+++ b/fs/btrfs/free-space-cache.c
@@ -327,7 +327,7 @@ int btrfs_truncate_free_space_cache(struct btrfs_trans_handle *trans,
 	 * need to check for -EAGAIN.
 	 */
 	ret = btrfs_truncate_inode_items(trans, root, BTRFS_I(inode),
-					 0, BTRFS_EXTENT_DATA_KEY);
+					 0, BTRFS_EXTENT_DATA_KEY, NULL);
 	if (ret)
 		goto fail;
 
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 64ddad66ded0..abb181b83947 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -4466,6 +4466,11 @@ static int btrfs_rmdir(struct inode *dir, struct dentry *dentry)
  * @min_type:		The minimum key type to remove. All keys with a type
  *			greater than this value are removed and all keys with
  *			this type are removed only if their offset is >= @new_size.
+ * @extents_found:	Output parameter that will contain the number of file
+ *			extent items that were removed or adjusted to the new
+ *			inode i_size. The caller is responsible for initializing
+ *			the counter. Also, it can be NULL if the caller does not
+ *			need this counter.
  *
  * Remove all keys associated with the inode from the given root that have a key
  * with a type greater than or equals to @min_type. When @min_type has a value of
@@ -4479,7 +4484,8 @@ static int btrfs_rmdir(struct inode *dir, struct dentry *dentry)
 int btrfs_truncate_inode_items(struct btrfs_trans_handle *trans,
 			       struct btrfs_root *root,
 			       struct btrfs_inode *inode,
-			       u64 new_size, u32 min_type)
+			       u64 new_size, u32 min_type,
+			       u64 *extents_found)
 {
 	struct btrfs_fs_info *fs_info = root->fs_info;
 	struct btrfs_path *path;
@@ -4625,6 +4631,9 @@ int btrfs_truncate_inode_items(struct btrfs_trans_handle *trans,
 		if (found_type != BTRFS_EXTENT_DATA_KEY)
 			goto delete;
 
+		if (extents_found != NULL)
+			(*extents_found)++;
+
 		if (extent_type != BTRFS_FILE_EXTENT_INLINE) {
 			u64 num_dec;
 
@@ -5460,7 +5469,7 @@ void btrfs_evict_inode(struct inode *inode)
 		trans->block_rsv = rsv;
 
 		ret = btrfs_truncate_inode_items(trans, root, BTRFS_I(inode),
-						 0, 0);
+						 0, 0, NULL);
 		trans->block_rsv = &fs_info->trans_block_rsv;
 		btrfs_end_transaction(trans);
 		btrfs_btree_balance_dirty(fs_info);
@@ -8671,6 +8680,7 @@ static int btrfs_truncate(struct inode *inode, bool skip_writeback)
 	struct btrfs_trans_handle *trans;
 	u64 mask = fs_info->sectorsize - 1;
 	u64 min_size = btrfs_calc_metadata_size(fs_info, 1);
+	u64 extents_found = 0;
 
 	if (!skip_writeback) {
 		ret = btrfs_wait_ordered_range(inode, inode->i_size & (~mask),
@@ -8728,20 +8738,13 @@ static int btrfs_truncate(struct inode *inode, bool skip_writeback)
 				      min_size, false);
 	BUG_ON(ret);
 
-	/*
-	 * So if we truncate and then write and fsync we normally would just
-	 * write the extents that changed, which is a problem if we need to
-	 * first truncate that entire inode.  So set this flag so we write out
-	 * all of the extents in the inode to the sync log so we're completely
-	 * safe.
-	 */
-	set_bit(BTRFS_INODE_NEEDS_FULL_SYNC, &BTRFS_I(inode)->runtime_flags);
 	trans->block_rsv = rsv;
 
 	while (1) {
 		ret = btrfs_truncate_inode_items(trans, root, BTRFS_I(inode),
 						 inode->i_size,
-						 BTRFS_EXTENT_DATA_KEY);
+						 BTRFS_EXTENT_DATA_KEY,
+						 &extents_found);
 		trans->block_rsv = &fs_info->trans_block_rsv;
 		if (ret != -ENOSPC && ret != -EAGAIN)
 			break;
@@ -8803,6 +8806,22 @@ static int btrfs_truncate(struct inode *inode, bool skip_writeback)
 	}
 out:
 	btrfs_free_block_rsv(fs_info, rsv);
+	/*
+	 * So if we truncate and then write and fsync we normally would just
+	 * write the extents that changed, which is a problem if we need to
+	 * first truncate that entire inode.  So set this flag so we write out
+	 * all of the extents in the inode to the sync log so we're completely
+	 * safe.
+	 *
+	 * If no extents were dropped or trimmed we don't need to force the next
+	 * fsync to truncate all the inode's items from the log and re-log them
+	 * all. This means the truncate operation did not change the file size,
+	 * or changed it to a smaller size but there was only an implicit hole
+	 * between the old i_size and the new i_size, and there were no prealloc
+	 * extents beyond i_size to drop.
+	 */
+	if (extents_found > 0)
+		set_bit(BTRFS_INODE_NEEDS_FULL_SYNC, &BTRFS_I(inode)->runtime_flags);
 
 	return ret;
 }
diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index fd6b1f13112e..11e7442e6690 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -4448,7 +4448,8 @@ static int btrfs_log_prealloc_extents(struct btrfs_trans_handle *trans,
 				ret = btrfs_truncate_inode_items(trans,
 							 root->log_root,
 							 inode, truncate_offset,
-							 BTRFS_EXTENT_DATA_KEY);
+							 BTRFS_EXTENT_DATA_KEY,
+							 NULL);
 			} while (ret == -EAGAIN);
 			if (ret)
 				goto out;
@@ -5396,7 +5397,7 @@ static int btrfs_log_inode(struct btrfs_trans_handle *trans,
 					  &inode->runtime_flags);
 				while(1) {
 					ret = btrfs_truncate_inode_items(trans,
-						log, inode, 0, 0);
+						log, inode, 0, 0, NULL);
 					if (ret != -EAGAIN)
 						break;
 				}
-- 
2.28.0

