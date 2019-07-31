Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8BF027BE50
	for <lists+linux-btrfs@lfdr.de>; Wed, 31 Jul 2019 12:24:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728290AbfGaKYD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 31 Jul 2019 06:24:03 -0400
Received: from mx2.suse.de ([195.135.220.15]:32924 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728098AbfGaKYC (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 31 Jul 2019 06:24:02 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id BAF63AFD4
        for <linux-btrfs@vger.kernel.org>; Wed, 31 Jul 2019 10:24:00 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH RFC 3/3] btrfs: Pause and resume qgroup for snapshot drop
Date:   Wed, 31 Jul 2019 18:23:52 +0800
Message-Id: <20190731102352.6028-4-wqu@suse.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190731102352.6028-1-wqu@suse.com>
References: <20190731102352.6028-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Btrfs qgroup has one big performance overhead for certain snapshot drop.

Current btrfs_drop_snapshot() will try its best to find the highest
shared node, and just drop one ref of that common node.
This behavior is good for minimize extent tree modification, but a
disaster for qgroup.

Example:
      Root 300  Root 301
        A         B
        | \     / |
        |    X    |
        | /     \ |
        C         D
      /   \     /   \
     E     F    G    H
    / \   / \  / \   / \
   I   J K  L  M  N O   P

In above case, if we're dropping root 301, btrfs_drop_snapshot() will
only drop one ref for tree block C and D.

But for qgroup, tree blocks E~P also have their owner changed, from
300, 301 to 300 only.

Currently we use btrfs_qgroup_trace_subtree() to manually re-dirty tree
block E~P. And since such ref change happens in one transaction for each
ref drop, we can't split the overhead to different transactions.

This could cause qgroup extent record flood, hugely damage performance
or even cause OOM for too many qgroup extent records.

This patch will try to solve it in a different method, since we can't
split the overhead into different transactions, instead of doing such
heavy work, we just pause qgroup at the very beginning of
btrfs_drop_snapshot().

So later owner change won't trigger qgroup subtree trace, and after
all subvolumes get removed, we just trigger a qgroup rescan to rebuild
qgroup accounting.

Also, to co-operate previous qgroup balance optimization, we don't need
to pause qgroup to balance, thus introduce a new parameter for
btrfs_drop_snapshot() to inform caller that we have other optimization
to handle balance.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/ctree.h       |  3 ++-
 fs/btrfs/disk-io.c     |  2 ++
 fs/btrfs/extent-tree.c | 13 ++++++++++++-
 fs/btrfs/relocation.c  |  4 ++--
 fs/btrfs/transaction.c |  4 ++--
 5 files changed, 20 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 0a61dff27f57..ef6db258e75d 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -3016,7 +3016,8 @@ static inline int btrfs_next_item(struct btrfs_root *root, struct btrfs_path *p)
 int btrfs_leaf_free_space(struct extent_buffer *leaf);
 int __must_check btrfs_drop_snapshot(struct btrfs_root *root,
 				     struct btrfs_block_rsv *block_rsv,
-				     int update_ref, int for_reloc);
+				     int update_ref, int for_reloc,
+				     int pause_qgroup);
 int btrfs_drop_subtree(struct btrfs_trans_handle *trans,
 			struct btrfs_root *root,
 			struct extent_buffer *node,
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 9c11ac5edef5..106b2bfff794 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -1747,6 +1747,8 @@ static int cleaner_kthread(void *arg)
 		if (kthread_should_stop())
 			return 0;
 		if (!again) {
+			if (btrfs_quota_is_paused(fs_info))
+				btrfs_quota_resume(fs_info);
 			set_current_state(TASK_INTERRUPTIBLE);
 			schedule();
 			__set_current_state(TASK_RUNNING);
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 5faf057f6f37..a0b5de3216c8 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -9236,7 +9236,7 @@ static noinline int walk_up_tree(struct btrfs_trans_handle *trans,
  */
 int btrfs_drop_snapshot(struct btrfs_root *root,
 			 struct btrfs_block_rsv *block_rsv, int update_ref,
-			 int for_reloc)
+			 int for_reloc, int pause_qgroup)
 {
 	struct btrfs_fs_info *fs_info = root->fs_info;
 	struct btrfs_path *path;
@@ -9343,6 +9343,17 @@ int btrfs_drop_snapshot(struct btrfs_root *root,
 		}
 	}
 
+	/*
+	 * If this subvolume is shared, and pretty high, we tend to pause
+	 * qgroup to avoid qgroup extent records flood due to sudden subtree
+	 * owner change happened in one transaction.
+	 */
+	if (test_bit(BTRFS_FS_QUOTA_ENABLED, &fs_info->flags) &&
+	    pause_qgroup && (root->root_key.offset ||
+	     btrfs_root_last_snapshot(&root->root_item)) &&
+	    btrfs_header_level(root->node))
+		btrfs_quota_pause(trans);
+
 	wc->restarted = test_bit(BTRFS_ROOT_DEAD_TREE, &root->state);
 	wc->level = level;
 	wc->shared_level = -1;
diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 22a3c69864fa..ceacf1155495 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -2190,14 +2190,14 @@ static int clean_dirty_subvols(struct reloc_control *rc)
 			root->reloc_root = NULL;
 			if (reloc_root) {
 
-				ret2 = btrfs_drop_snapshot(reloc_root, NULL, 0, 1);
+				ret2 = btrfs_drop_snapshot(reloc_root, NULL, 0, 1, 0);
 				if (ret2 < 0 && !ret)
 					ret = ret2;
 			}
 			btrfs_put_fs_root(root);
 		} else {
 			/* Orphan reloc tree, just clean it up */
-			ret2 = btrfs_drop_snapshot(root, NULL, 0, 1);
+			ret2 = btrfs_drop_snapshot(root, NULL, 0, 1, 0);
 			if (ret2 < 0 && !ret)
 				ret = ret2;
 		}
diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index 48d3b5123129..7fe318318e28 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -2317,9 +2317,9 @@ int btrfs_clean_one_deleted_snapshot(struct btrfs_fs_info *fs_info)
 
 	if (btrfs_header_backref_rev(root->node) <
 			BTRFS_MIXED_BACKREF_REV)
-		ret = btrfs_drop_snapshot(root, NULL, 0, 0);
+		ret = btrfs_drop_snapshot(root, NULL, 0, 0, 1);
 	else
-		ret = btrfs_drop_snapshot(root, NULL, 1, 0);
+		ret = btrfs_drop_snapshot(root, NULL, 1, 0, 1);
 
 	return (ret < 0) ? 0 : 1;
 }
-- 
2.22.0

