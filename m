Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E7CC2112489
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Dec 2019 09:20:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727520AbfLDIU0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 4 Dec 2019 03:20:26 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:32819 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727501AbfLDIUZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 4 Dec 2019 03:20:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1575447626; x=1606983626;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=aTDT/TuW1C009nCSV5xqCnFu5EeDZEvFd1SEUSwdmj4=;
  b=AN5FfVVTtCMORwsMhQn6vRW7hBkkoMcLlMqJqPaVGqS2SkMFQxkQQR6q
   hfyiYadOQUjGPQ818InY89wte3199p9VdFRTbb6/SukCRetCI7BIHWYl8
   Sa5pOhQoCixR39V4AcjwJERBmPReUPOS87rvO6RIjzmFscpMB1xODpVUD
   x47hHnqRxCgkJqc+qQnZn9cxdlM1b3McpnFD2+W7AHBsXO6uaG9SlPCe9
   0PB03sUO6UFSB/RzDYmXjdhmXEZXPGQtIWtgFtYMRX6rbfsGcCE9GVf6B
   REIPvlorss5ffu+erOqAjk4DHPwc3BJQFAkp1cfI6kHDlmKvdjQ1X/dr5
   w==;
IronPort-SDR: jHlLqCZJb6Nz54Gkk//vjH1Xa0R8n3j87HHaKqG7kWMvavRsphdKGgZRXEafA3iIFCyT3nxl6G
 IfW67wFHqwFxefyLDtjjvXsXFC18dEi4PidQU4TN8QdnD4DvMF4zcateCMn9xelA7nvLIDyXXd
 5nikNAMepBUYUqXs+LK78yHJ2p3cRQBBWb6jmtHn04rajino/wjiVxujq0NbwG+H9aWDHwS8Ey
 htkNFdaPVP58aeX3OyLFH0m4L1hJAYeUzHn55+eBVBYA36hRvtF3qv7T04I99wUdY1ZCDKR5IJ
 vhI=
X-IronPort-AV: E=Sophos;i="5.69,276,1571673600"; 
   d="scan'208";a="125355129"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 04 Dec 2019 16:20:25 +0800
IronPort-SDR: MwuDIQGVjIEyv3PliLJ/ig2O5JoKoCWemgn9eosIgdXvOA5mliKEBEAkBoWAt5gPWvIJqz/PJS
 nix6O92UStKbOfJQJEuTiQE09c152Wn1vdV3G9Dnqry1jH2yGzRraHGOjGkvxzEvlnIG4B8YQ1
 JuNw/izVLaHbMgjWSetKLNyFRhYaQJBPjLfw9PpTx8qOBrShCIlN5CXA8iwowTARncQ9rOxoFt
 g7riiBS0F4BuZs9z71LTVPhDds6l+eH5UdSDGV50SR6NIuuleY7FjqXRasfB/mCNsmU/OjiqbK
 oHGDPVhGYitZBwL07IdNrdF4
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2019 00:14:50 -0800
IronPort-SDR: +097Cr6xmLASFAwdhNviHkNNzzNiEWxVKR62Hjg+HRsYNOfUEO4V/xRqQb3fE7y/pUqsvKRG8J
 AXnNO5dqnmJiFT9GM9WMs7Sh7YwuzLSeQ6V0rg72hLu1S9K4o5iXCtN9Yzx+hAub1hKI8HMxA3
 FFBapW77u/JK21Udt/tSKK24IfLD3y4IXlHI/UflrIdssjsw8aHtbAB14TzaE19+P8/qfPVe9Y
 pRlLQPyDFgVToOWuupxwVFPqJCreV8s6zoqUvnTNxHpUWJKOQxcd6t0m6WE1yRn+2QhNaUr2VH
 GUw=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com (HELO naota.fujisawa.hgst.com) ([10.149.53.115])
  by uls-op-cesaip02.wdc.com with ESMTP; 04 Dec 2019 00:20:22 -0800
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        Nikolay Borisov <nborisov@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Hannes Reinecke <hare@suse.com>,
        Anand Jain <anand.jain@oracle.com>,
        linux-fsdevel@vger.kernel.org, Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v5 27/28] btrfs: enable tree-log on HMZONED mode
Date:   Wed,  4 Dec 2019 17:17:34 +0900
Message-Id: <20191204081735.852438-28-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191204081735.852438-1-naohiro.aota@wdc.com>
References: <20191204081735.852438-1-naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The tree-log feature does not work on HMZONED mode as is. Blocks for a
tree-log tree are allocated mixed with other metadata blocks, and btrfs
writes and syncs the tree-log blocks to devices at the time of fsync(),
which is different timing than a global transaction commit. As a result,
both writing tree-log blocks and writing other metadata blocks become
non-sequential writes which HMZONED mode must avoid.

Also, since we can start more than one log transactions per subvolume at
the same time, nodes from multiple transactions can be allocated
interleaved. Such mixed allocation results in non-sequential writes at the
time of log transaction commit. The nodes of the global log root tree
(fs_info->log_root_tree), also have the same mixed allocation problem.

This patch assigns a dedicated block group for tree-log blocks to separate
two metadata writing streams (for tree-log blocks and other metadata
blocks). As a result, each write stream can now be written to devices
separately. "fs_info->treelog_bg" tracks the dedicated block group and
btrfs assign "treelog_bg" on-demand on tree-log block allocation time.

Then, this patch serializes log transactions by waiting for a committing
transaction when someone tries to start a new transaction, to avoid the
mixed allocation problem. We must also wait for running log transactions
from another subvolume, but there is no easy way to detect which subvolume
root is running a log transaction. So, this patch forbids starting a new
log transaction when the global log root tree is already allocated by other
subvolumes.

Furthermore, this patch aligns the allocation order of nodes of
"fs_info->log_root_tree" and nodes of "root->log_root" with the writing
order of the nodes, by delaying allocation of the root node of
"fs_info->log_root_tree," so that, the node buffers can go out sequentially
to devices.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/block-group.c |  7 +++++
 fs/btrfs/ctree.h       |  2 ++
 fs/btrfs/disk-io.c     |  8 ++---
 fs/btrfs/extent-tree.c | 71 +++++++++++++++++++++++++++++++++++++-----
 fs/btrfs/tree-log.c    | 49 ++++++++++++++++++++++++-----
 5 files changed, 116 insertions(+), 21 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 6f7d29171adf..93e6c617d68e 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -910,6 +910,13 @@ int btrfs_remove_block_group(struct btrfs_trans_handle *trans,
 	btrfs_return_cluster_to_free_space(block_group, cluster);
 	spin_unlock(&cluster->refill_lock);
 
+	if (btrfs_fs_incompat(fs_info, HMZONED)) {
+		spin_lock(&fs_info->treelog_bg_lock);
+		if (fs_info->treelog_bg == block_group->start)
+			fs_info->treelog_bg = 0;
+		spin_unlock(&fs_info->treelog_bg_lock);
+	}
+
 	path = btrfs_alloc_path();
 	if (!path) {
 		ret = -ENOMEM;
diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 18d2d0581e68..cba8a169002c 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -907,6 +907,8 @@ struct btrfs_fs_info {
 #endif
 
 	struct mutex hmzoned_meta_io_lock;
+	spinlock_t treelog_bg_lock;
+	u64 treelog_bg;
 };
 
 static inline struct btrfs_fs_info *btrfs_sb(struct super_block *sb)
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 914c517d26b0..9c2b2fbf0cdb 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -1360,16 +1360,10 @@ int btrfs_init_log_root_tree(struct btrfs_trans_handle *trans,
 			     struct btrfs_fs_info *fs_info)
 {
 	struct btrfs_root *log_root;
-	int ret;
 
 	log_root = alloc_log_tree(trans, fs_info);
 	if (IS_ERR(log_root))
 		return PTR_ERR(log_root);
-	ret = btrfs_alloc_log_tree_node(trans, log_root);
-	if (ret) {
-		kfree(log_root);
-		return ret;
-	}
 	WARN_ON(fs_info->log_root_tree);
 	fs_info->log_root_tree = log_root;
 	return 0;
@@ -2841,6 +2835,8 @@ int __cold open_ctree(struct super_block *sb,
 
 	fs_info->send_in_progress = 0;
 
+	spin_lock_init(&fs_info->treelog_bg_lock);
+
 	ret = btrfs_alloc_stripe_hash_table(fs_info);
 	if (ret) {
 		err = ret;
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 69c4ce8ec83e..9b9608097f7f 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -3704,8 +3704,10 @@ static int find_free_extent_unclustered(struct btrfs_block_group *bg,
  */
 
 static int find_free_extent_zoned(struct btrfs_block_group *cache,
-				  struct find_free_extent_ctl *ffe_ctl)
+				  struct find_free_extent_ctl *ffe_ctl,
+				  bool for_treelog)
 {
+	struct btrfs_fs_info *fs_info = cache->fs_info;
 	struct btrfs_space_info *space_info = cache->space_info;
 	struct btrfs_free_space_ctl *ctl = cache->free_space_ctl;
 	u64 start = cache->start;
@@ -3718,12 +3720,26 @@ static int find_free_extent_zoned(struct btrfs_block_group *cache,
 	btrfs_hmzoned_data_io_lock(cache);
 	spin_lock(&space_info->lock);
 	spin_lock(&cache->lock);
+	spin_lock(&fs_info->treelog_bg_lock);
+
+	ASSERT(!for_treelog || cache->start == fs_info->treelog_bg ||
+	       fs_info->treelog_bg == 0);
 
 	if (cache->ro) {
 		ret = -EAGAIN;
 		goto out;
 	}
 
+	/*
+	 * Do not allow currently using block group to be tree-log
+	 * dedicated block group.
+	 */
+	if (for_treelog && !fs_info->treelog_bg &&
+	    (cache->used || cache->reserved)) {
+		ret = 1;
+		goto out;
+	}
+
 	avail = cache->length - cache->alloc_offset;
 	if (avail < num_bytes) {
 		ffe_ctl->max_extent_size = avail;
@@ -3731,6 +3747,9 @@ static int find_free_extent_zoned(struct btrfs_block_group *cache,
 		goto out;
 	}
 
+	if (for_treelog && !fs_info->treelog_bg)
+		fs_info->treelog_bg = cache->start;
+
 	ffe_ctl->found_offset = start + cache->alloc_offset;
 	cache->alloc_offset += num_bytes;
 	spin_lock(&ctl->tree_lock);
@@ -3738,12 +3757,15 @@ static int find_free_extent_zoned(struct btrfs_block_group *cache,
 	spin_unlock(&ctl->tree_lock);
 
 	ASSERT(IS_ALIGNED(ffe_ctl->found_offset,
-			  cache->fs_info->stripesize));
+			  fs_info->stripesize));
 	ffe_ctl->search_start = ffe_ctl->found_offset;
 	__btrfs_add_reserved_bytes(cache, ffe_ctl->ram_bytes, num_bytes,
 				   ffe_ctl->delalloc);
 
 out:
+	if (ret && for_treelog)
+		fs_info->treelog_bg = 0;
+	spin_unlock(&fs_info->treelog_bg_lock);
 	spin_unlock(&cache->lock);
 	spin_unlock(&space_info->lock);
 	/* if succeeds, unlock after submit_bio */
@@ -3891,7 +3913,7 @@ static int find_free_extent_update_loop(struct btrfs_fs_info *fs_info,
 static noinline int find_free_extent(struct btrfs_fs_info *fs_info,
 				u64 ram_bytes, u64 num_bytes, u64 empty_size,
 				u64 hint_byte, struct btrfs_key *ins,
-				u64 flags, int delalloc)
+				u64 flags, int delalloc, bool for_treelog)
 {
 	int ret = 0;
 	struct btrfs_free_cluster *last_ptr = NULL;
@@ -3970,6 +3992,13 @@ static noinline int find_free_extent(struct btrfs_fs_info *fs_info,
 		spin_unlock(&last_ptr->lock);
 	}
 
+	if (hmzoned && for_treelog) {
+		spin_lock(&fs_info->treelog_bg_lock);
+		if (fs_info->treelog_bg)
+			hint_byte = fs_info->treelog_bg;
+		spin_unlock(&fs_info->treelog_bg_lock);
+	}
+
 	ffe_ctl.search_start = max(ffe_ctl.search_start,
 				   first_logical_byte(fs_info, 0));
 	ffe_ctl.search_start = max(ffe_ctl.search_start, hint_byte);
@@ -4015,8 +4044,15 @@ static noinline int find_free_extent(struct btrfs_fs_info *fs_info,
 	list_for_each_entry(block_group,
 			    &space_info->block_groups[ffe_ctl.index], list) {
 		/* If the block group is read-only, we can skip it entirely. */
-		if (unlikely(block_group->ro))
+		if (unlikely(block_group->ro)) {
+			if (hmzoned && for_treelog) {
+				spin_lock(&fs_info->treelog_bg_lock);
+				if (block_group->start == fs_info->treelog_bg)
+					fs_info->treelog_bg = 0;
+				spin_unlock(&fs_info->treelog_bg_lock);
+			}
 			continue;
+		}
 
 		btrfs_grab_block_group(block_group, delalloc);
 		ffe_ctl.search_start = block_group->start;
@@ -4062,7 +4098,25 @@ static noinline int find_free_extent(struct btrfs_fs_info *fs_info,
 			goto loop;
 
 		if (hmzoned) {
-			ret = find_free_extent_zoned(block_group, &ffe_ctl);
+			u64 bytenr = block_group->start;
+			u64 log_bytenr;
+			bool skip;
+
+			/*
+			 * Do not allow non-tree-log blocks in the
+			 * dedicated tree-log block group, and vice versa.
+			 */
+			spin_lock(&fs_info->treelog_bg_lock);
+			log_bytenr = fs_info->treelog_bg;
+			skip = log_bytenr &&
+				((for_treelog && bytenr != log_bytenr) ||
+				 (!for_treelog && bytenr == log_bytenr));
+			spin_unlock(&fs_info->treelog_bg_lock);
+			if (skip)
+				goto loop;
+
+			ret = find_free_extent_zoned(block_group, &ffe_ctl,
+						     for_treelog);
 			if (ret)
 				goto loop;
 			/*
@@ -4222,12 +4276,13 @@ int btrfs_reserve_extent(struct btrfs_root *root, u64 ram_bytes,
 	bool final_tried = num_bytes == min_alloc_size;
 	u64 flags;
 	int ret;
+	bool for_treelog = root->root_key.objectid == BTRFS_TREE_LOG_OBJECTID;
 
 	flags = get_alloc_profile_by_root(root, is_data);
 again:
 	WARN_ON(num_bytes < fs_info->sectorsize);
 	ret = find_free_extent(fs_info, ram_bytes, num_bytes, empty_size,
-			       hint_byte, ins, flags, delalloc);
+			       hint_byte, ins, flags, delalloc, for_treelog);
 	if (!ret && !is_data) {
 		btrfs_dec_block_group_reservations(fs_info, ins->objectid);
 	} else if (ret == -ENOSPC) {
@@ -4245,8 +4300,8 @@ int btrfs_reserve_extent(struct btrfs_root *root, u64 ram_bytes,
 
 			sinfo = btrfs_find_space_info(fs_info, flags);
 			btrfs_err(fs_info,
-				  "allocation failed flags %llu, wanted %llu",
-				  flags, num_bytes);
+			"allocation failed flags %llu, wanted %llu treelog %d",
+				  flags, num_bytes, for_treelog);
 			if (sinfo)
 				btrfs_dump_space_info(fs_info, sinfo,
 						      num_bytes, 1);
diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 6f757361db53..e155418f24ba 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -18,6 +18,7 @@
 #include "compression.h"
 #include "qgroup.h"
 #include "inode-map.h"
+#include "hmzoned.h"
 
 /* magic values for the inode_only field in btrfs_log_inode:
  *
@@ -105,6 +106,7 @@ static noinline int replay_dir_deletes(struct btrfs_trans_handle *trans,
 				       struct btrfs_root *log,
 				       struct btrfs_path *path,
 				       u64 dirid, int del_all);
+static void wait_log_commit(struct btrfs_root *root, int transid);
 
 /*
  * tree logging is a special write ahead log used to make sure that
@@ -139,16 +141,25 @@ static int start_log_trans(struct btrfs_trans_handle *trans,
 			   struct btrfs_log_ctx *ctx)
 {
 	struct btrfs_fs_info *fs_info = root->fs_info;
+	bool hmzoned = btrfs_fs_incompat(fs_info, HMZONED);
 	int ret = 0;
 
 	mutex_lock(&root->log_mutex);
 
+again:
 	if (root->log_root) {
+		int index = (root->log_transid + 1) % 2;
+
 		if (btrfs_need_log_full_commit(trans)) {
 			ret = -EAGAIN;
 			goto out;
 		}
 
+		if (hmzoned && atomic_read(&root->log_commit[index])) {
+			wait_log_commit(root, root->log_transid - 1);
+			goto again;
+		}
+
 		if (!root->log_start_pid) {
 			clear_bit(BTRFS_ROOT_MULTI_LOG_TASKS, &root->state);
 			root->log_start_pid = current->pid;
@@ -157,8 +168,13 @@ static int start_log_trans(struct btrfs_trans_handle *trans,
 		}
 	} else {
 		mutex_lock(&fs_info->tree_log_mutex);
-		if (!fs_info->log_root_tree)
+		if (hmzoned && fs_info->log_root_tree) {
+			ret = -EAGAIN;
+			mutex_unlock(&fs_info->tree_log_mutex);
+			goto out;
+		} else if (!fs_info->log_root_tree) {
 			ret = btrfs_init_log_root_tree(trans, fs_info);
+		}
 		mutex_unlock(&fs_info->tree_log_mutex);
 		if (ret)
 			goto out;
@@ -191,11 +207,19 @@ static int start_log_trans(struct btrfs_trans_handle *trans,
  */
 static int join_running_log_trans(struct btrfs_root *root)
 {
+	bool hmzoned = btrfs_fs_incompat(root->fs_info, HMZONED);
 	int ret = -ENOENT;
 
 	mutex_lock(&root->log_mutex);
+again:
 	if (root->log_root) {
+		int index = (root->log_transid + 1) % 2;
+
 		ret = 0;
+		if (hmzoned && atomic_read(&root->log_commit[index])) {
+			wait_log_commit(root, root->log_transid - 1);
+			goto again;
+		}
 		atomic_inc(&root->log_writers);
 	}
 	mutex_unlock(&root->log_mutex);
@@ -2724,6 +2748,8 @@ static noinline int walk_down_log_tree(struct btrfs_trans_handle *trans,
 					btrfs_clean_tree_block(next);
 					btrfs_wait_tree_block_writeback(next);
 					btrfs_tree_unlock(next);
+					btrfs_redirty_list_add(
+						trans->transaction, next);
 				} else {
 					if (test_and_clear_bit(EXTENT_BUFFER_DIRTY, &next->bflags))
 						clear_extent_buffer_dirty(next);
@@ -3128,6 +3154,11 @@ int btrfs_sync_log(struct btrfs_trans_handle *trans,
 
 	mutex_lock(&log_root_tree->log_mutex);
 
+	mutex_lock(&fs_info->tree_log_mutex);
+	if (!log_root_tree->node)
+		btrfs_alloc_log_tree_node(trans, log_root_tree);
+	mutex_unlock(&fs_info->tree_log_mutex);
+
 	/*
 	 * Now we are safe to update the log_root_tree because we're under the
 	 * log_mutex, and we're a current writer so we're holding the commit
@@ -3285,16 +3316,20 @@ static void free_log_tree(struct btrfs_trans_handle *trans,
 		.process_func = process_one_buffer
 	};
 
-	ret = walk_log_tree(trans, log, &wc);
-	if (ret) {
-		if (trans)
-			btrfs_abort_transaction(trans, ret);
-		else
-			btrfs_handle_fs_error(log->fs_info, ret, NULL);
+	if (log->node) {
+		ret = walk_log_tree(trans, log, &wc);
+		if (ret) {
+			if (trans)
+				btrfs_abort_transaction(trans, ret);
+			else
+				btrfs_handle_fs_error(log->fs_info, ret, NULL);
+		}
 	}
 
 	clear_extent_bits(&log->dirty_log_pages, 0, (u64)-1,
 			  EXTENT_DIRTY | EXTENT_NEW | EXTENT_NEED_WAIT);
+	if (trans && log->node)
+		btrfs_redirty_list_add(trans->transaction, log->node);
 	free_extent_buffer(log->node);
 	kfree(log);
 }
-- 
2.24.0

