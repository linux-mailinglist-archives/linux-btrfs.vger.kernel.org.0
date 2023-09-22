Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 701C07AAFAA
	for <lists+linux-btrfs@lfdr.de>; Fri, 22 Sep 2023 12:38:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233370AbjIVKiH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 22 Sep 2023 06:38:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233209AbjIVKiG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 22 Sep 2023 06:38:06 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 002D399
        for <linux-btrfs@vger.kernel.org>; Fri, 22 Sep 2023 03:37:59 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EA1FC433C7
        for <linux-btrfs@vger.kernel.org>; Fri, 22 Sep 2023 10:37:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695379079;
        bh=N5j/2ppra8PANtgz2Jdtq8uyaq5h+623ktk/+LsIvko=;
        h=From:To:Subject:Date:From;
        b=pkRKWYmE4rwcSjHDiinH72cTwAZh3nt8iqcPSJ83WCopcUDnEF805qKTOqvUED+qt
         jZ4JNyo+EdX9IeUNrE6gt5/KBq13KgkUce7TD0IBJin0v//WKpc6QzgBTYQj2SJHaH
         35zpM+fwr2Qe7ziP9yt8JnSnFN7fjHRO5f0GVotGn1ByGbiMx+N/LP3CTwTZS17OVp
         g4KkoMmlVIlxc9CPIC2CgekM3Ii4MH0iYrR+X2KpxfuwB/SSKj/eN2Kgnad0cnF+q/
         AB56vLM6wvORHsP9bqsJeOOK1r6s27ysBIkO+UEL8V9KT6X8kv11K8ggeDBvgXOYMW
         jQFuU5XWwN7CQ==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: move btrfs_defrag_root() to defrag.{c,h}
Date:   Fri, 22 Sep 2023 11:37:56 +0100
Message-Id: <9474fc4f5eca4a1e7bb38dd1cd2bd01537c4315a.1695335503.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

The btrfs_defrag_root() function does not really belong in the
transaction.{c,h} module and as we have a defrag.{c,h} nowadays,
move it to there instead. This also allows to stop exporting
btrfs_defrag_leaves(), so we can make it static.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/defrag.c      | 44 ++++++++++++++++++++++++++++++++++++++++--
 fs/btrfs/defrag.h      |  2 +-
 fs/btrfs/transaction.c | 39 -------------------------------------
 fs/btrfs/transaction.h |  1 -
 4 files changed, 43 insertions(+), 43 deletions(-)

diff --git a/fs/btrfs/defrag.c b/fs/btrfs/defrag.c
index f2ff4cbe8656..53544787c348 100644
--- a/fs/btrfs/defrag.c
+++ b/fs/btrfs/defrag.c
@@ -343,8 +343,8 @@ int btrfs_run_defrag_inodes(struct btrfs_fs_info *fs_info)
  * better reflect disk order
  */
 
-int btrfs_defrag_leaves(struct btrfs_trans_handle *trans,
-			struct btrfs_root *root)
+static int btrfs_defrag_leaves(struct btrfs_trans_handle *trans,
+			       struct btrfs_root *root)
 {
 	struct btrfs_path *path = NULL;
 	struct btrfs_key key;
@@ -460,6 +460,46 @@ int btrfs_defrag_leaves(struct btrfs_trans_handle *trans,
 	return ret;
 }
 
+/*
+ * Defrag a given btree.
+ * Every leaf in the btree is read and defragged.
+ */
+int btrfs_defrag_root(struct btrfs_root *root)
+{
+	struct btrfs_fs_info *info = root->fs_info;
+	int ret;
+
+	if (test_and_set_bit(BTRFS_ROOT_DEFRAG_RUNNING, &root->state))
+		return 0;
+
+	while (1) {
+		struct btrfs_trans_handle *trans;
+
+		trans = btrfs_start_transaction(root, 0);
+		if (IS_ERR(trans)) {
+			ret = PTR_ERR(trans);
+			break;
+		}
+
+		ret = btrfs_defrag_leaves(trans, root);
+
+		btrfs_end_transaction(trans);
+		btrfs_btree_balance_dirty(info);
+		cond_resched();
+
+		if (btrfs_fs_closing(info) || ret != -EAGAIN)
+			break;
+
+		if (btrfs_defrag_cancelled(info)) {
+			btrfs_debug(info, "defrag_root cancelled");
+			ret = -EAGAIN;
+			break;
+		}
+	}
+	clear_bit(BTRFS_ROOT_DEFRAG_RUNNING, &root->state);
+	return ret;
+}
+
 /*
  * Defrag specific helper to get an extent map.
  *
diff --git a/fs/btrfs/defrag.h b/fs/btrfs/defrag.h
index 5305f2283b5e..5a62763528d1 100644
--- a/fs/btrfs/defrag.h
+++ b/fs/btrfs/defrag.h
@@ -12,7 +12,7 @@ int btrfs_add_inode_defrag(struct btrfs_trans_handle *trans,
 			   struct btrfs_inode *inode, u32 extent_thresh);
 int btrfs_run_defrag_inodes(struct btrfs_fs_info *fs_info);
 void btrfs_cleanup_defrag_inodes(struct btrfs_fs_info *fs_info);
-int btrfs_defrag_leaves(struct btrfs_trans_handle *trans, struct btrfs_root *root);
+int btrfs_defrag_root(struct btrfs_root *root);
 
 static inline int btrfs_defrag_cancelled(struct btrfs_fs_info *fs_info)
 {
diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index 240dad25fa16..c05c2cd84688 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -1564,45 +1564,6 @@ static noinline int commit_fs_roots(struct btrfs_trans_handle *trans)
 	return 0;
 }
 
-/*
- * defrag a given btree.
- * Every leaf in the btree is read and defragged.
- */
-int btrfs_defrag_root(struct btrfs_root *root)
-{
-	struct btrfs_fs_info *info = root->fs_info;
-	struct btrfs_trans_handle *trans;
-	int ret;
-
-	if (test_and_set_bit(BTRFS_ROOT_DEFRAG_RUNNING, &root->state))
-		return 0;
-
-	while (1) {
-		trans = btrfs_start_transaction(root, 0);
-		if (IS_ERR(trans)) {
-			ret = PTR_ERR(trans);
-			break;
-		}
-
-		ret = btrfs_defrag_leaves(trans, root);
-
-		btrfs_end_transaction(trans);
-		btrfs_btree_balance_dirty(info);
-		cond_resched();
-
-		if (btrfs_fs_closing(info) || ret != -EAGAIN)
-			break;
-
-		if (btrfs_defrag_cancelled(info)) {
-			btrfs_debug(info, "defrag_root cancelled");
-			ret = -EAGAIN;
-			break;
-		}
-	}
-	clear_bit(BTRFS_ROOT_DEFRAG_RUNNING, &root->state);
-	return ret;
-}
-
 /*
  * Do all special snapshot related qgroup dirty hack.
  *
diff --git a/fs/btrfs/transaction.h b/fs/btrfs/transaction.h
index efc4fa9e2bd8..de58776de307 100644
--- a/fs/btrfs/transaction.h
+++ b/fs/btrfs/transaction.h
@@ -246,7 +246,6 @@ struct btrfs_trans_handle *btrfs_attach_transaction_barrier(
 int btrfs_wait_for_commit(struct btrfs_fs_info *fs_info, u64 transid);
 
 void btrfs_add_dead_root(struct btrfs_root *root);
-int btrfs_defrag_root(struct btrfs_root *root);
 void btrfs_maybe_wake_unfinished_drop(struct btrfs_fs_info *fs_info);
 int btrfs_clean_one_deleted_snapshot(struct btrfs_fs_info *fs_info);
 int btrfs_commit_transaction(struct btrfs_trans_handle *trans);
-- 
2.40.1

