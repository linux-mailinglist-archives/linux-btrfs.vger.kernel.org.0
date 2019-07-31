Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 65A1F7BE4E
	for <lists+linux-btrfs@lfdr.de>; Wed, 31 Jul 2019 12:24:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728214AbfGaKYA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 31 Jul 2019 06:24:00 -0400
Received: from mx2.suse.de ([195.135.220.15]:32898 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728098AbfGaKX7 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 31 Jul 2019 06:23:59 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 81515AFD4
        for <linux-btrfs@vger.kernel.org>; Wed, 31 Jul 2019 10:23:58 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH RFC 1/3] btrfs: Refactor btrfs_clean_one_deleted_snapshot() to use fs_info other than root
Date:   Wed, 31 Jul 2019 18:23:50 +0800
Message-Id: <20190731102352.6028-2-wqu@suse.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190731102352.6028-1-wqu@suse.com>
References: <20190731102352.6028-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

btrfs_clean_one_deleted_snapshot() will grab needed root from fs_info,
thus no need to pass a @root parameter.

Also refactor its sole caller, cleaner_kthread() to use fs_info other
than root.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/disk-io.c     | 7 +++----
 fs/btrfs/transaction.c | 4 ++--
 fs/btrfs/transaction.h | 2 +-
 3 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index deb74a8c191a..9c11ac5edef5 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -1689,8 +1689,7 @@ static void end_workqueue_fn(struct btrfs_work *work)
 
 static int cleaner_kthread(void *arg)
 {
-	struct btrfs_root *root = arg;
-	struct btrfs_fs_info *fs_info = root->fs_info;
+	struct btrfs_fs_info *fs_info = arg;
 	int again;
 
 	while (1) {
@@ -1723,7 +1722,7 @@ static int cleaner_kthread(void *arg)
 
 		btrfs_run_delayed_iputs(fs_info);
 
-		again = btrfs_clean_one_deleted_snapshot(root);
+		again = btrfs_clean_one_deleted_snapshot(fs_info);
 		mutex_unlock(&fs_info->cleaner_mutex);
 
 		/*
@@ -3124,7 +3123,7 @@ int open_ctree(struct super_block *sb,
 		goto fail_sysfs;
 	}
 
-	fs_info->cleaner_kthread = kthread_run(cleaner_kthread, tree_root,
+	fs_info->cleaner_kthread = kthread_run(cleaner_kthread, fs_info,
 					       "btrfs-cleaner");
 	if (IS_ERR(fs_info->cleaner_kthread))
 		goto fail_sysfs;
diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index 3f6811cdf803..48d3b5123129 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -2296,10 +2296,10 @@ int btrfs_commit_transaction(struct btrfs_trans_handle *trans)
  * because btrfs_commit_super will poke cleaner thread and it will process it a
  * few seconds later.
  */
-int btrfs_clean_one_deleted_snapshot(struct btrfs_root *root)
+int btrfs_clean_one_deleted_snapshot(struct btrfs_fs_info *fs_info)
 {
+	struct btrfs_root *root;
 	int ret;
-	struct btrfs_fs_info *fs_info = root->fs_info;
 
 	spin_lock(&fs_info->trans_lock);
 	if (list_empty(&fs_info->dead_roots)) {
diff --git a/fs/btrfs/transaction.h b/fs/btrfs/transaction.h
index 78c446c222b7..e72e6cf919e2 100644
--- a/fs/btrfs/transaction.h
+++ b/fs/btrfs/transaction.h
@@ -190,7 +190,7 @@ int btrfs_wait_for_commit(struct btrfs_fs_info *fs_info, u64 transid);
 
 void btrfs_add_dead_root(struct btrfs_root *root);
 int btrfs_defrag_root(struct btrfs_root *root);
-int btrfs_clean_one_deleted_snapshot(struct btrfs_root *root);
+int btrfs_clean_one_deleted_snapshot(struct btrfs_fs_info *fs_info);
 int btrfs_commit_transaction(struct btrfs_trans_handle *trans);
 int btrfs_commit_transaction_async(struct btrfs_trans_handle *trans,
 				   int wait_for_unblock);
-- 
2.22.0

