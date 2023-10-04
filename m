Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FBC27B7D62
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Oct 2023 12:39:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242195AbjJDKjE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 4 Oct 2023 06:39:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242151AbjJDKjD (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 4 Oct 2023 06:39:03 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DFD8AF
        for <linux-btrfs@vger.kernel.org>; Wed,  4 Oct 2023 03:38:59 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BBF1C433CA
        for <linux-btrfs@vger.kernel.org>; Wed,  4 Oct 2023 10:38:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696415938;
        bh=oLTGQBL9PNHQl76M78/JXdTBCUnYrJja2thWsUYnhEM=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=W+LLmc0gN0bWWyFBEEORpk2WG8xmv/VFiFyFByFnCEleqZ892J8CstXMz11zXnlbx
         kQdM8LJp8CYufWS3dLDQn8uvLmFikOSI+1D/rxjvSQXRpZGOs4qHn4qXuWMcq6SYMX
         K1VrM9fIQR2r8c5BYWMpgDWTb63S46G9gBF9dCPnVS9t91eZsGE7w1i2ZQ8O9Zi0yJ
         2NNt3ktTUc0VWtjpoY1mLqAETxpVXGdarziyex6fPfyItgdsaW7SxL7kgbUoqN7uLz
         2r4PwI68mIoLZhkQLP4rBHCpLsXbxJkqKW0x6ZqzR9I0j+sAugGBdTlbafsc67rIjN
         szIJVz8ZJ09FA==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 2/6] btrfs: add and use helpers for reading and writing log_transid
Date:   Wed,  4 Oct 2023 11:38:49 +0100
Message-Id: <1d80f77c0b7d377e2d5b612f0a96f61fc8571786.1696415673.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1696415673.git.fdmanana@suse.com>
References: <cover.1696415673.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

Currently the log_transid field of a root is always modified while holding
the root's log_mutex locked. Most readers of a root's log_transid are also
holding the root's log_mutex locked, however there is one exception which
is btrfs_set_inode_last_trans() where we don't take the lock to avoid
blocking several operations if log syncing is happening in parallel.

Any races here should be harmless, and in the worst case they may cause a
fsync to log an inode when it's not really needed, so nothing bad from a
functional perspective.

To avoid data race warnings from tools like KCSAN and other issues such
as load and store tearing (amongst others, see [1]), create helpers to
access the log_transid field of a root using READ_ONCE() and WRITE_ONCE(),
and use these helpers where needed.

[1] https://lwn.net/Articles/793253/

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/ctree.h       | 18 ++++++++++++++++++
 fs/btrfs/disk-io.c     |  4 ++--
 fs/btrfs/transaction.h |  2 +-
 fs/btrfs/tree-log.c    |  2 +-
 4 files changed, 22 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 3ebb5229660a..c8f1d2d7c46c 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -191,6 +191,14 @@ struct btrfs_root {
 	atomic_t log_commit[2];
 	/* Used only for log trees of subvolumes, not for the log root tree */
 	atomic_t log_batch;
+	/*
+	 * Protected by the 'log_mutex' lock but can be read without holding
+	 * that lock to avoid unnecessary lock contention, in which case it
+	 * should be read using btrfs_get_root_log_transid() except if it's a
+	 * log tree in which case it can be directly accessed. Updates to this
+	 * field should always use btrfs_set_root_log_transid(), except for log
+	 * trees where the field can be updated directly.
+	 */
 	int log_transid;
 	/* No matter the commit succeeds or not*/
 	int log_transid_committed;
@@ -332,6 +340,16 @@ static inline u64 btrfs_root_id(const struct btrfs_root *root)
 	return root->root_key.objectid;
 }
 
+static inline int btrfs_get_root_log_transid(const struct btrfs_root *root)
+{
+	return READ_ONCE(root->log_transid);
+}
+
+static inline void btrfs_set_root_log_transid(struct btrfs_root *root, int log_transid)
+{
+	WRITE_ONCE(root->log_transid, log_transid);
+}
+
 static inline int btrfs_get_root_last_log_commit(const struct btrfs_root *root)
 {
 	return READ_ONCE(root->last_log_commit);
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index fe18c54cec10..c84d32951b26 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -675,7 +675,7 @@ static void __setup_root(struct btrfs_root *root, struct btrfs_fs_info *fs_info,
 	refcount_set(&root->refs, 1);
 	atomic_set(&root->snapshot_force_cow, 0);
 	atomic_set(&root->nr_swapfiles, 0);
-	root->log_transid = 0;
+	btrfs_set_root_log_transid(root, 0);
 	root->log_transid_committed = -1;
 	btrfs_set_root_last_log_commit(root, 0);
 	root->anon_dev = 0;
@@ -1004,7 +1004,7 @@ int btrfs_add_log_tree(struct btrfs_trans_handle *trans,
 
 	WARN_ON(root->log_root);
 	root->log_root = log_root;
-	root->log_transid = 0;
+	btrfs_set_root_log_transid(root, 0);
 	root->log_transid_committed = -1;
 	btrfs_set_root_last_log_commit(root, 0);
 	return 0;
diff --git a/fs/btrfs/transaction.h b/fs/btrfs/transaction.h
index f5bf3489d8c5..ff7580bbcf4e 100644
--- a/fs/btrfs/transaction.h
+++ b/fs/btrfs/transaction.h
@@ -175,7 +175,7 @@ static inline void btrfs_set_inode_last_trans(struct btrfs_trans_handle *trans,
 {
 	spin_lock(&inode->lock);
 	inode->last_trans = trans->transaction->transid;
-	inode->last_sub_trans = inode->root->log_transid;
+	inode->last_sub_trans = btrfs_get_root_log_transid(inode->root);
 	inode->last_log_commit = inode->last_sub_trans - 1;
 	spin_unlock(&inode->lock);
 }
diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 28a61a7dd371..958bb23d3d99 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -2958,7 +2958,7 @@ int btrfs_sync_log(struct btrfs_trans_handle *trans,
 	btrfs_set_root_node(&log->root_item, log->node);
 	memcpy(&new_root_item, &log->root_item, sizeof(new_root_item));
 
-	root->log_transid++;
+	btrfs_set_root_log_transid(root, root->log_transid + 1);
 	log->log_transid = root->log_transid;
 	root->log_start_pid = 0;
 	/*
-- 
2.40.1

