Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 05EC916A98B
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Feb 2020 16:14:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727359AbgBXPOH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 24 Feb 2020 10:14:07 -0500
Received: from mx2.suse.de ([195.135.220.15]:44080 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727299AbgBXPOH (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 24 Feb 2020 10:14:07 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 13380B0BF;
        Mon, 24 Feb 2020 15:14:04 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id E5E1FDA727; Mon, 24 Feb 2020 16:13:45 +0100 (CET)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Johannes.Thumshirn@wdc.com, anand.jain@oracle.com,
        David Sterba <dsterba@suse.com>
Subject: [PATCH v2] btrfs: merge unlocking to common exit block in btrfs_commit_transaction
Date:   Mon, 24 Feb 2020 16:13:45 +0100
Message-Id: <20200224151345.14174-1-dsterba@suse.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <133258557ae4387d6a1d01bafa3e5214ca91228d.1582302545.git.dsterba@suse.com>
References: <133258557ae4387d6a1d01bafa3e5214ca91228d.1582302545.git.dsterba@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The tree_log_mutex and reloc_mutex locks are properly nested so we can
simplify error handling and add labels for them. This reduces line count
of the function.

Signed-off-by: David Sterba <dsterba@suse.com>
---

v2:
- fixed label after commit_fs_roots, to point to unlock_tree_log
- added comment after btrfs_handle_fs_error and keep the locks as is

 fs/btrfs/transaction.c | 58 +++++++++++++++++-------------------------
 1 file changed, 23 insertions(+), 35 deletions(-)

diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index fdfdfc426539..702e0f2b8307 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -2194,10 +2194,8 @@ int btrfs_commit_transaction(struct btrfs_trans_handle *trans)
 	 * core function of the snapshot creation.
 	 */
 	ret = create_pending_snapshots(trans);
-	if (ret) {
-		mutex_unlock(&fs_info->reloc_mutex);
-		goto scrub_continue;
-	}
+	if (ret)
+		goto unlock_reloc;
 
 	/*
 	 * We insert the dir indexes of the snapshots and update the inode
@@ -2210,16 +2208,12 @@ int btrfs_commit_transaction(struct btrfs_trans_handle *trans)
 	 * the nodes and leaves.
 	 */
 	ret = btrfs_run_delayed_items(trans);
-	if (ret) {
-		mutex_unlock(&fs_info->reloc_mutex);
-		goto scrub_continue;
-	}
+	if (ret)
+		goto unlock_reloc;
 
 	ret = btrfs_run_delayed_refs(trans, (unsigned long)-1);
-	if (ret) {
-		mutex_unlock(&fs_info->reloc_mutex);
-		goto scrub_continue;
-	}
+	if (ret)
+		goto unlock_reloc;
 
 	/*
 	 * make sure none of the code above managed to slip in a
@@ -2245,11 +2239,8 @@ int btrfs_commit_transaction(struct btrfs_trans_handle *trans)
 	mutex_lock(&fs_info->tree_log_mutex);
 
 	ret = commit_fs_roots(trans);
-	if (ret) {
-		mutex_unlock(&fs_info->tree_log_mutex);
-		mutex_unlock(&fs_info->reloc_mutex);
-		goto scrub_continue;
-	}
+	if (ret)
+		goto unlock_tree_log;
 
 	/*
 	 * Since the transaction is done, we can apply the pending changes
@@ -2267,29 +2258,20 @@ int btrfs_commit_transaction(struct btrfs_trans_handle *trans)
 	 * new delayed refs. Must handle them or qgroup can be wrong.
 	 */
 	ret = btrfs_run_delayed_refs(trans, (unsigned long)-1);
-	if (ret) {
-		mutex_unlock(&fs_info->tree_log_mutex);
-		mutex_unlock(&fs_info->reloc_mutex);
-		goto scrub_continue;
-	}
+	if (ret)
+		goto unlock_tree_log;
 
 	/*
 	 * Since fs roots are all committed, we can get a quite accurate
 	 * new_roots. So let's do quota accounting.
 	 */
 	ret = btrfs_qgroup_account_extents(trans);
-	if (ret < 0) {
-		mutex_unlock(&fs_info->tree_log_mutex);
-		mutex_unlock(&fs_info->reloc_mutex);
-		goto scrub_continue;
-	}
+	if (ret < 0)
+		goto unlock_tree_log;
 
 	ret = commit_cowonly_roots(trans);
-	if (ret) {
-		mutex_unlock(&fs_info->tree_log_mutex);
-		mutex_unlock(&fs_info->reloc_mutex);
-		goto scrub_continue;
-	}
+	if (ret)
+		goto unlock_tree_log;
 
 	/*
 	 * The tasks which save the space cache and inode cache may also
@@ -2297,9 +2279,7 @@ int btrfs_commit_transaction(struct btrfs_trans_handle *trans)
 	 */
 	if (TRANS_ABORTED(cur_trans)) {
 		ret = cur_trans->aborted;
-		mutex_unlock(&fs_info->tree_log_mutex);
-		mutex_unlock(&fs_info->reloc_mutex);
-		goto scrub_continue;
+		goto unlock_tree_log;
 	}
 
 	btrfs_prepare_extent_commit(fs_info);
@@ -2346,6 +2326,10 @@ int btrfs_commit_transaction(struct btrfs_trans_handle *trans)
 	if (ret) {
 		btrfs_handle_fs_error(fs_info, ret,
 				      "Error while writing out transaction");
+		/*
+		 * reloc_mutex has been unlocked, tree_log_mutex is still held
+		 * but we can't jump to unlock_tree_log causing double unlock
+		 */
 		mutex_unlock(&fs_info->tree_log_mutex);
 		goto scrub_continue;
 	}
@@ -2394,6 +2378,10 @@ int btrfs_commit_transaction(struct btrfs_trans_handle *trans)
 
 	return ret;
 
+unlock_tree_log:
+	mutex_unlock(&fs_info->tree_log_mutex);
+unlock_reloc:
+	mutex_unlock(&fs_info->reloc_mutex);
 scrub_continue:
 	btrfs_scrub_continue(fs_info);
 cleanup_transaction:
-- 
2.25.0

