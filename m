Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1E34882B13
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 Aug 2019 07:35:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731620AbfHFFfo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 6 Aug 2019 01:35:44 -0400
Received: from mx2.suse.de ([195.135.220.15]:55310 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725798AbfHFFfn (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 6 Aug 2019 01:35:43 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id ADDFAAFCE
        for <linux-btrfs@vger.kernel.org>; Tue,  6 Aug 2019 05:35:42 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 1/3] btrfs: Refactor btrfs_clean_one_deleted_snapshot() to use fs_info other than root
Date:   Tue,  6 Aug 2019 13:35:33 +0800
Message-Id: <20190806053535.14375-2-wqu@suse.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190806053535.14375-1-wqu@suse.com>
References: <20190806053535.14375-1-wqu@suse.com>
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
index 5f7ee70b3d1a..dda4945c4beb 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -1681,8 +1681,7 @@ static void end_workqueue_fn(struct btrfs_work *work)
 
 static int cleaner_kthread(void *arg)
 {
-	struct btrfs_root *root = arg;
-	struct btrfs_fs_info *fs_info = root->fs_info;
+	struct btrfs_fs_info *fs_info = arg;
 	int again;
 
 	while (1) {
@@ -1715,7 +1714,7 @@ static int cleaner_kthread(void *arg)
 
 		btrfs_run_delayed_iputs(fs_info);
 
-		again = btrfs_clean_one_deleted_snapshot(root);
+		again = btrfs_clean_one_deleted_snapshot(fs_info);
 		mutex_unlock(&fs_info->cleaner_mutex);
 
 		/*
@@ -3161,7 +3160,7 @@ int open_ctree(struct super_block *sb,
 		goto fail_sysfs;
 	}
 
-	fs_info->cleaner_kthread = kthread_run(cleaner_kthread, tree_root,
+	fs_info->cleaner_kthread = kthread_run(cleaner_kthread, fs_info,
 					       "btrfs-cleaner");
 	if (IS_ERR(fs_info->cleaner_kthread))
 		goto fail_sysfs;
diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index e3adb714c04b..b78f853305d2 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -2338,10 +2338,10 @@ int btrfs_commit_transaction(struct btrfs_trans_handle *trans)
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
index 2c5a6f6e5bb0..96e1bc4f8ae5 100644
--- a/fs/btrfs/transaction.h
+++ b/fs/btrfs/transaction.h
@@ -193,7 +193,7 @@ int btrfs_wait_for_commit(struct btrfs_fs_info *fs_info, u64 transid);
 
 void btrfs_add_dead_root(struct btrfs_root *root);
 int btrfs_defrag_root(struct btrfs_root *root);
-int btrfs_clean_one_deleted_snapshot(struct btrfs_root *root);
+int btrfs_clean_one_deleted_snapshot(struct btrfs_fs_info *fs_info);
 int btrfs_commit_transaction(struct btrfs_trans_handle *trans);
 int btrfs_commit_transaction_async(struct btrfs_trans_handle *trans,
 				   int wait_for_unblock);
-- 
2.22.0

