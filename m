Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DA56D158A53
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Feb 2020 08:26:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727556AbgBKHZs (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 11 Feb 2020 02:25:48 -0500
Received: from mx2.suse.de ([195.135.220.15]:44814 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727041AbgBKHZs (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 11 Feb 2020 02:25:48 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 8FD1EAD66;
        Tue, 11 Feb 2020 07:25:46 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Jeff Mahoney <jeffm@suse.com>
Subject: [PATCH v2] btrfs: destroy qgroup extent records on transaction abort
Date:   Tue, 11 Feb 2020 15:25:37 +0800
Message-Id: <20200211072537.25751-1-wqu@suse.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Jeff Mahoney <jeffm@suse.com>

We clean up the delayed references when we abort a transaction but
we leave the pending qgroup extent records behind, leaking memory.

This patch destroyes the extent records when we destroy the delayed
refs and checks to ensure they're gone before releasing the transaction.

Fixes: 3368d001ba5df (btrfs: qgroup: Record possible quota-related extent for qgroup.)
Signed-off-by: Jeff Mahoney <jeffm@suse.com>
[Rebased to latest upstream, remove to_qgroup() helper, use
 rbtree_postorder_for_each_entry_safe() wrapper]
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
Changelog:
v2:
- Update the commit message to remove to_qgroup()
---
 fs/btrfs/disk-io.c     |  1 +
 fs/btrfs/qgroup.c      | 13 +++++++++++++
 fs/btrfs/qgroup.h      |  1 +
 fs/btrfs/transaction.c |  2 ++
 4 files changed, 17 insertions(+)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 7fa9bb79ad08..e8154e2747da 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -4275,6 +4275,7 @@ static int btrfs_destroy_delayed_refs(struct btrfs_transaction *trans,
 		cond_resched();
 		spin_lock(&delayed_refs->lock);
 	}
+	btrfs_qgroup_destroy_extent_records(trans);
 
 	spin_unlock(&delayed_refs->lock);
 
diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
index 98d9a50352d6..184e3f66ee94 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -4002,3 +4002,16 @@ int btrfs_qgroup_trace_subtree_after_cow(struct btrfs_trans_handle *trans,
 	}
 	return ret;
 }
+
+void btrfs_qgroup_destroy_extent_records(struct btrfs_transaction *trans)
+{
+	struct btrfs_delayed_ref_root *delayed_refs = &trans->delayed_refs;
+	struct btrfs_qgroup_extent_record *entry;
+	struct btrfs_qgroup_extent_record *next;
+	struct rb_root *root = &delayed_refs->dirty_extent_root;
+
+	rbtree_postorder_for_each_entry_safe(entry, next, root, node) {
+		ulist_free(entry->old_roots);
+		kfree(entry);
+	}
+}
diff --git a/fs/btrfs/qgroup.h b/fs/btrfs/qgroup.h
index 236f12224d52..1bc654459469 100644
--- a/fs/btrfs/qgroup.h
+++ b/fs/btrfs/qgroup.h
@@ -414,5 +414,6 @@ int btrfs_qgroup_add_swapped_blocks(struct btrfs_trans_handle *trans,
 		u64 last_snapshot);
 int btrfs_qgroup_trace_subtree_after_cow(struct btrfs_trans_handle *trans,
 		struct btrfs_root *root, struct extent_buffer *eb);
+void btrfs_qgroup_destroy_extent_records(struct btrfs_transaction *trans);
 
 #endif
diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index 33dcc88b428a..beb6c69cd1e5 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -121,6 +121,8 @@ void btrfs_put_transaction(struct btrfs_transaction *transaction)
 		BUG_ON(!list_empty(&transaction->list));
 		WARN_ON(!RB_EMPTY_ROOT(
 				&transaction->delayed_refs.href_root.rb_root));
+		WARN_ON(!RB_EMPTY_ROOT(
+				&transaction->delayed_refs.dirty_extent_root));
 		if (transaction->delayed_refs.pending_csums)
 			btrfs_err(transaction->fs_info,
 				  "pending csums is %llu",
-- 
2.25.0

