Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0654121D3F4
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Jul 2020 12:51:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729494AbgGMKvA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 13 Jul 2020 06:51:00 -0400
Received: from mx2.suse.de ([195.135.220.15]:60208 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728382AbgGMKvA (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 13 Jul 2020 06:51:00 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 8110DAE54
        for <linux-btrfs@vger.kernel.org>; Mon, 13 Jul 2020 10:50:59 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v4 2/3] btrfs: qgroup: try to flush qgroup space when we get -EDQUOT
Date:   Mon, 13 Jul 2020 18:50:48 +0800
Message-Id: <20200713105049.90663-3-wqu@suse.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200713105049.90663-1-wqu@suse.com>
References: <20200713105049.90663-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

[PROBLEM]
There are known problem related to how btrfs handles qgroup reserved
space.
One of the most obvious case is the the test case btrfs/153, which do
fallocate, then write into the preallocated range.

  btrfs/153 1s ... - output mismatch (see xfstests-dev/results//btrfs/153.out.bad)
      --- tests/btrfs/153.out     2019-10-22 15:18:14.068965341 +0800
      +++ xfstests-dev/results//btrfs/153.out.bad      2020-07-01 20:24:40.730000089 +0800
      @@ -1,2 +1,5 @@
       QA output created by 153
      +pwrite: Disk quota exceeded
      +/mnt/scratch/testfile2: Disk quota exceeded
      +/mnt/scratch/testfile2: Disk quota exceeded
       Silence is golden
      ...
      (Run 'diff -u xfstests-dev/tests/btrfs/153.out xfstests-dev/results//btrfs/153.out.bad'  to see the entire diff)

[CAUSE]
Since commit c6887cd11149 ("Btrfs: don't do nocow check unless we have to"),
we always reserve space no matter if it's COW or not.

Such behavior change is mostly for performance, and reverting it is not
a good idea anyway.

For preallcoated extent, we reserve qgroup data space for it already,
and since we also reserve data space for qgroup at buffered write time,
it needs twice the space for us to write into preallocated space.

This leads to the -EDQUOT in buffered write routine.

And we can't follow the same solution, unlike data/meta space check,
qgroup reserved space is shared between data/meta.
The EDQUOT can happen at the metadata reservation, so doing NODATACOW
check after qgroup reservation failure is not a solution.

[FIX]
To solve the problem, we don't return -EDQUOT directly, but every time
we got a -EDQUOT, we try to flush qgroup space by:
- Flush all inodes of the root
  NODATACOW writes will free the qgroup reserved at run_dealloc_range().
  However we don't have the infrastructure to only flush NODATACOW
  inodes, here we flush all inodes anyway.

- Wait ordered extents
  This would convert the preallocated metadata space into per-trans
  metadata, which can be freed in later transaction commit.

- Commit transaction
  This will free all per-trans metadata space.

Also we don't want to trigger flush too racy, so here we introduce a
per-root wait head and a new root status, to ensure if there is a running
qgroup flushing, we wait for it to end and don't start re-flush.

Fixes: c6887cd11149 ("Btrfs: don't do nocow check unless we have to")
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/ctree.h   |   4 ++
 fs/btrfs/disk-io.c |   1 +
 fs/btrfs/qgroup.c  | 101 +++++++++++++++++++++++++++++++++++++++++----
 3 files changed, 98 insertions(+), 8 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index c96c27f66999..318fad8e9908 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -1012,6 +1012,9 @@ enum {
 	BTRFS_ROOT_DEAD_TREE,
 	/* The root has a log tree. Used only for subvolume roots. */
 	BTRFS_ROOT_HAS_LOG_TREE,
+
+	/* Qgroup flushing is in progress */
+	BTRFS_ROOT_QGROUP_FLUSHING,
 };
 
 /*
@@ -1164,6 +1167,7 @@ struct btrfs_root {
 	spinlock_t qgroup_meta_rsv_lock;
 	u64 qgroup_meta_rsv_pertrans;
 	u64 qgroup_meta_rsv_prealloc;
+	wait_queue_head_t qgroup_flush_wait;
 
 	/* Number of active swapfiles */
 	atomic_t nr_swapfiles;
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index aa97a39e4b15..2fb0b43bc1c5 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -1116,6 +1116,7 @@ static void __setup_root(struct btrfs_root *root, struct btrfs_fs_info *fs_info,
 	mutex_init(&root->log_mutex);
 	mutex_init(&root->ordered_extent_mutex);
 	mutex_init(&root->delalloc_mutex);
+	init_waitqueue_head(&root->qgroup_flush_wait);
 	init_waitqueue_head(&root->log_writer_wait);
 	init_waitqueue_head(&root->log_commit_wait[0]);
 	init_waitqueue_head(&root->log_commit_wait[1]);
diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
index 28bf9bb6746f..1c3998ea45a3 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -3513,17 +3513,59 @@ static int qgroup_unreserve_range(struct btrfs_inode *inode,
 }
 
 /*
- * Reserve qgroup space for range [start, start + len).
+ * Try to free some space for qgroup.
  *
- * This function will either reserve space from related qgroups or doing
- * nothing if the range is already reserved.
+ * For qgroup, there are only 3 ways to free qgroup space:
+ * - Flush nodatacow write
+ *   Any nodatacow write will free its reserved data space at
+ *   run_delalloc_range().
+ *   In theory, we should only flush nodatacow inodes, but it's
+ *   not yet possible, so we need to flush the whole root.
  *
- * Return 0 for successful reserve
- * Return <0 for error (including -EQUOT)
+ * - Wait for ordered extents
+ *   When ordered extents are finished, their reserved metadata
+ *   is finally converted to per_trans status, which can be freed
+ *   by later commit transaction.
  *
- * NOTE: this function may sleep for memory allocation.
+ * - Commit transaction
+ *   This would free the meta_per_trans space.
+ *   In theory this shouldn't provide much space, but any more qgroup space
+ *   is needed.
  */
-int btrfs_qgroup_reserve_data(struct btrfs_inode *inode,
+static int try_flush_qgroup(struct btrfs_root *root)
+{
+	struct btrfs_trans_handle *trans;
+	int ret;
+
+	/*
+	 * We don't want to run flush again and again, so if there is a running
+	 * one, we won't try to start a new flush, but exit directly.
+	 */
+	if (test_and_set_bit(BTRFS_ROOT_QGROUP_FLUSHING, &root->state)) {
+		wait_event(root->qgroup_flush_wait,
+			!test_bit(BTRFS_ROOT_QGROUP_FLUSHING, &root->state));
+		return 0;
+	}
+
+	ret = btrfs_start_delalloc_snapshot(root);
+	if (ret < 0)
+		goto unlock;
+	btrfs_wait_ordered_extents(root, U64_MAX, 0, (u64)-1);
+
+	trans = btrfs_join_transaction(root);
+	if (IS_ERR(trans)) {
+		ret = PTR_ERR(trans);
+		goto unlock;
+	}
+
+	ret = btrfs_commit_transaction(trans);
+unlock:
+	clear_bit(BTRFS_ROOT_QGROUP_FLUSHING, &root->state);
+	wake_up(&root->qgroup_flush_wait);
+	return ret;
+}
+
+static int qgroup_reserve_data(struct btrfs_inode *inode,
 			struct extent_changeset **reserved_ret, u64 start,
 			u64 len)
 {
@@ -3576,6 +3618,34 @@ int btrfs_qgroup_reserve_data(struct btrfs_inode *inode,
 	return ret;
 }
 
+/*
+ * Reserve qgroup space for range [start, start + len).
+ *
+ * This function will either reserve space from related qgroups or doing
+ * nothing if the range is already reserved.
+ *
+ * Return 0 for successful reserve
+ * Return <0 for error (including -EQUOT)
+ *
+ * NOTE: This function may sleep for memory allocation, dirty page flushing and
+ *	 commit transaction. So caller should not hold any dirty page locked.
+ */
+int btrfs_qgroup_reserve_data(struct btrfs_inode *inode,
+			struct extent_changeset **reserved_ret, u64 start,
+			u64 len)
+{
+	int ret;
+
+	ret = qgroup_reserve_data(inode, reserved_ret, start, len);
+	if (ret <= 0 && ret != -EDQUOT)
+		return ret;
+
+	ret = try_flush_qgroup(inode->root);
+	if (ret < 0)
+		return ret;
+	return qgroup_reserve_data(inode, reserved_ret, start, len);
+}
+
 /* Free ranges specified by @reserved, normally in error path */
 static int qgroup_free_reserved_data(struct btrfs_inode *inode,
 			struct extent_changeset *reserved, u64 start, u64 len)
@@ -3744,7 +3814,7 @@ static int sub_root_meta_rsv(struct btrfs_root *root, int num_bytes,
 	return num_bytes;
 }
 
-int __btrfs_qgroup_reserve_meta(struct btrfs_root *root, int num_bytes,
+static int qgroup_reserve_meta(struct btrfs_root *root, int num_bytes,
 				enum btrfs_qgroup_rsv_type type, bool enforce)
 {
 	struct btrfs_fs_info *fs_info = root->fs_info;
@@ -3771,6 +3841,21 @@ int __btrfs_qgroup_reserve_meta(struct btrfs_root *root, int num_bytes,
 	return ret;
 }
 
+int __btrfs_qgroup_reserve_meta(struct btrfs_root *root, int num_bytes,
+				enum btrfs_qgroup_rsv_type type, bool enforce)
+{
+	int ret;
+
+	ret = qgroup_reserve_meta(root, num_bytes, type, enforce);
+	if (ret <= 0 && ret != -EDQUOT)
+		return ret;
+
+	ret = try_flush_qgroup(root);
+	if (ret < 0)
+		return ret;
+	return qgroup_reserve_meta(root, num_bytes, type, enforce);
+}
+
 void btrfs_qgroup_free_meta_all_pertrans(struct btrfs_root *root)
 {
 	struct btrfs_fs_info *fs_info = root->fs_info;
-- 
2.27.0

