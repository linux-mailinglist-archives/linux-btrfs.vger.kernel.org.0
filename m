Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 587257D6C2
	for <lists+linux-btrfs@lfdr.de>; Thu,  1 Aug 2019 09:56:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729091AbfHAH40 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 1 Aug 2019 03:56:26 -0400
Received: from mx2.suse.de ([195.135.220.15]:37636 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728974AbfHAH40 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 1 Aug 2019 03:56:26 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 90252AF77
        for <linux-btrfs@vger.kernel.org>; Thu,  1 Aug 2019 07:56:24 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH RFC] btrfs: qgroup: Introduce qgroup memory usage and soft limit
Date:   Thu,  1 Aug 2019 15:56:20 +0800
Message-Id: <20190801075620.26925-1-wqu@suse.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Btrfs can allocate a lot of btrfs_qgroup_extent_record, it can use a lot
of kernel memory and under extreme case it can cause OOM.

E.g. if we have 1024 subvolumes and they all share the same 4096 tree blocks.

Then if we trigger some workload to change the owner of all these 1024
tree blocks in one transaction, we will need:

 nr_tree_blocks * (sizeof(extent_record) + 2 * nr_subvols * sizeof(ulist_node))
 = 4096 * (64 + 2 * 1024 * 56)
 = 117506048 = 448.25MiB

That's not a small amount of memory.

So this patch introduces a simple qgroup memory limiter, it will check
if we hit the memory up limit when inserting qgroup extent record.

Such simple mechanism has the following limit:
- Soft limit only
  When we exceed the limit, we will only try our best to commit
  transaction when possible.
  Thus it's not ensured to prevent huge memory pressure.

- Limit based on estimation
  Since at the time of qgroup extent record insert, we only have
  record->old_roots (ulist of all subvolumes owning this extent in
  previous transaction), we don't have record->new_roots yet (calculate
  at commit transaction time).
  So we can only estimate that by double the memory usage of old_roots.

  This can cause both underestimation and overestimation.
  Underestimation happens for case like reflink, the original extent is
  only shared once, while after reflink it can be shared by a lot of
  more subvolumes.
  Overestimation happens for reference drop.

- Not working for qgroup subtree rescan
  Subtree rescan happens in one transaction, thus we have no way to
  commit transaction with trans handler hold.
  Qgroup subtree rescan flood will be addressed by pausing qgroup.

In fact, the need for such memory limitation is uncertain.

As the only possible scenario to generate so many records is qgroup
subtree rescan, but we're already purposing pausing qgroup to address
that, I doubt if it's possible to hit current hardcoded 128M memory
limit.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/ctree.h   |  8 ++++++++
 fs/btrfs/disk-io.c |  8 ++++++++
 fs/btrfs/qgroup.c  | 12 ++++++++++++
 3 files changed, 28 insertions(+)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 0a61dff27f57..da4a8c8f43a7 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -1096,6 +1096,14 @@ struct btrfs_fs_info {
 	struct rb_root qgroup_tree;
 	spinlock_t qgroup_lock;
 
+	/*
+	 * Monitor and limit btrfs_qgroup_extent_record memory usage.
+	 *
+	 * Both protected by qgroup_lock.
+	 */
+	u64 qgroup_mem_estimate;
+	u64 qgroup_mem_limit;
+
 	/*
 	 * used to avoid frequently calling ulist_alloc()/ulist_free()
 	 * when doing qgroup accounting, it must be protected by qgroup_lock.
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index deb74a8c191a..c4070824dea1 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -2171,6 +2171,14 @@ static void btrfs_init_qgroup(struct btrfs_fs_info *fs_info)
 	fs_info->qgroup_ulist = NULL;
 	fs_info->qgroup_rescan_running = false;
 	mutex_init(&fs_info->qgroup_rescan_lock);
+
+	/*
+	 * SZ_128M means we can have around 1M dirty extent record if each
+	 * one is owned by one root.
+	 * Or 113K records if each one is owned by 20 roots.
+	 */
+	fs_info->qgroup_mem_limit = SZ_128M;
+	fs_info->qgroup_mem_estimate = 0;
 }
 
 static int btrfs_init_workqueues(struct btrfs_fs_info *fs_info,
diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
index 7f4f8c4b4bb2..677806873f03 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -1543,6 +1543,15 @@ int btrfs_qgroup_trace_extent_nolock(struct btrfs_trans_handle *trans,
 	lockdep_assert_held(&delayed_refs->lock);
 	trace_btrfs_qgroup_trace_extent(fs_info, record);
 
+	if (record->old_roots) {
+		spin_lock(&fs_info->qgroup_lock);
+		fs_info->qgroup_mem_estimate += sizeof(*record) +
+			2 * record->old_roots->nnodes *
+			sizeof(struct ulist_node);
+		if (fs_info->qgroup_mem_estimate >= fs_info->qgroup_mem_limit)
+			btrfs_commit_transaction_locksafe(fs_info);
+		spin_unlock(&fs_info->qgroup_lock);
+	}
 	while (*p) {
 		parent_node = *p;
 		entry = rb_entry(parent_node, struct btrfs_qgroup_extent_record,
@@ -2558,6 +2567,9 @@ int btrfs_qgroup_account_extents(struct btrfs_trans_handle *trans)
 		kfree(record);
 
 	}
+	spin_lock(&fs_info->qgroup_lock);
+	fs_info->qgroup_mem_estimate = 0;
+	spin_unlock(&fs_info->qgroup_lock);
 	trace_qgroup_num_dirty_extents(fs_info, trans->transid,
 				       num_dirty_extents);
 	return ret;
-- 
2.22.0

