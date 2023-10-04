Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00AFE7B7D60
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Oct 2023 12:39:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242138AbjJDKjD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 4 Oct 2023 06:39:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242191AbjJDKjB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 4 Oct 2023 06:39:01 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27A26B7
        for <linux-btrfs@vger.kernel.org>; Wed,  4 Oct 2023 03:38:58 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A030C433C8
        for <linux-btrfs@vger.kernel.org>; Wed,  4 Oct 2023 10:38:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696415937;
        bh=EseAbabR5mlDTqsWprArFxDdKmDzWorSCWCOy50pyB0=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=NE8NEdwJNhc6+3Z90HM61HtErgyM0ZvU83zHULOTO+S4OXnGv5KyQpBYZajZLroos
         gph1g7Yb7BFCMFUs47WqF1GaVmflSwKv8hppep1HowKUGukdFdyECVBhde7X0uEBCc
         IC8AkvHGOh7y6fyTMZeTYUx4PA+Tu1l2d3v6XHlZrEqJOF7LOVegWjkq2turKQp0s5
         u9uwhkY8GiBhqCRzT1idVv/hArT5ZIOrtziQH7yfFPzkIZ6wA9MCYZn1onsYNvJG5S
         y1nhbOVFVsiKLqZLmUdehT39keKEEXH4YH1EpjUbuBmP0DmNgqcex8IQKufcT4S82A
         UAz7cT3NqFM/A==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 1/6] btrfs: add and use helpers for reading and writing last_log_commit
Date:   Wed,  4 Oct 2023 11:38:48 +0100
Message-Id: <b3319eb9fc301af8e735a556243c33b5b410a212.1696415673.git.fdmanana@suse.com>
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

Currently, the last_log_commit of a root can be accessed concurrently
without any lock protection. Readers can be calling btrfs_inode_in_log()
early in a fsync call, which reads a root's last_log_commit, while a
writer can change the last_log_commit while a log tree if being synced,
at btrfs_sync_log(). Any races here should be harmless, and in the worst
case they may cause a fsync to log an inode when it's not really needed,
so nothing bad from a functional perspective.

To avoid data race warnings from tools like KCSAN and other issues such
as load and store tearing (amongst others, see [1]), create helpers to
access the last_log_commit field of a root using READ_ONCE() and
WRITE_ONCE(), and use these helpers everywhere.

[1] https://lwn.net/Articles/793253/

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/btrfs_inode.h |  2 +-
 fs/btrfs/ctree.h       | 16 +++++++++++++++-
 fs/btrfs/disk-io.c     |  4 ++--
 fs/btrfs/tree-log.c    |  4 ++--
 4 files changed, 20 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/btrfs_inode.h b/fs/btrfs/btrfs_inode.h
index 81bf514d988f..d32ef248828e 100644
--- a/fs/btrfs/btrfs_inode.h
+++ b/fs/btrfs/btrfs_inode.h
@@ -390,7 +390,7 @@ static inline bool btrfs_inode_in_log(struct btrfs_inode *inode, u64 generation)
 	spin_lock(&inode->lock);
 	if (inode->logged_trans == generation &&
 	    inode->last_sub_trans <= inode->last_log_commit &&
-	    inode->last_sub_trans <= inode->root->last_log_commit)
+	    inode->last_sub_trans <= btrfs_get_root_last_log_commit(inode->root))
 		ret = true;
 	spin_unlock(&inode->lock);
 	return ret;
diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 208a1888ca07..3ebb5229660a 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -194,7 +194,11 @@ struct btrfs_root {
 	int log_transid;
 	/* No matter the commit succeeds or not*/
 	int log_transid_committed;
-	/* Just be updated when the commit succeeds. */
+	/*
+	 * Just be updated when the commit succeeds. Use
+	 * btrfs_get_root_last_log_commit() and btrfs_set_root_last_log_commit()
+	 * to access this field.
+	 */
 	int last_log_commit;
 	pid_t log_start_pid;
 
@@ -328,6 +332,16 @@ static inline u64 btrfs_root_id(const struct btrfs_root *root)
 	return root->root_key.objectid;
 }
 
+static inline int btrfs_get_root_last_log_commit(const struct btrfs_root *root)
+{
+	return READ_ONCE(root->last_log_commit);
+}
+
+static inline void btrfs_set_root_last_log_commit(struct btrfs_root *root, int commit_id)
+{
+	WRITE_ONCE(root->last_log_commit, commit_id);
+}
+
 /*
  * Structure that conveys information about an extent that is going to replace
  * all the extents in a file range.
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index ff3802986b3e..fe18c54cec10 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -677,7 +677,7 @@ static void __setup_root(struct btrfs_root *root, struct btrfs_fs_info *fs_info,
 	atomic_set(&root->nr_swapfiles, 0);
 	root->log_transid = 0;
 	root->log_transid_committed = -1;
-	root->last_log_commit = 0;
+	btrfs_set_root_last_log_commit(root, 0);
 	root->anon_dev = 0;
 	if (!dummy) {
 		extent_io_tree_init(fs_info, &root->dirty_log_pages,
@@ -1006,7 +1006,7 @@ int btrfs_add_log_tree(struct btrfs_trans_handle *trans,
 	root->log_root = log_root;
 	root->log_transid = 0;
 	root->log_transid_committed = -1;
-	root->last_log_commit = 0;
+	btrfs_set_root_last_log_commit(root, 0);
 	return 0;
 }
 
diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 2c4685316c43..28a61a7dd371 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -3133,8 +3133,8 @@ int btrfs_sync_log(struct btrfs_trans_handle *trans,
 	 * someone else already started it. We use <= and not < because the
 	 * first log transaction has an ID of 0.
 	 */
-	ASSERT(root->last_log_commit <= log_transid);
-	root->last_log_commit = log_transid;
+	ASSERT(btrfs_get_root_last_log_commit(root) <= log_transid);
+	btrfs_set_root_last_log_commit(root, log_transid);
 
 out_wake_log_root:
 	mutex_lock(&log_root_tree->log_mutex);
-- 
2.40.1

