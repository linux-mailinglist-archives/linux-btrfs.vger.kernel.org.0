Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE2DD38B2FC
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 May 2021 17:22:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235246AbhETPXQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 20 May 2021 11:23:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243775AbhETPXD (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 20 May 2021 11:23:03 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54A11C0613CE
        for <linux-btrfs@vger.kernel.org>; Thu, 20 May 2021 08:21:41 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id f8so13030176qth.6
        for <linux-btrfs@vger.kernel.org>; Thu, 20 May 2021 08:21:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=0dGhXd6l+JAf802cqmKwLC7EJofNrRCDMAW4nGocchY=;
        b=q5LyIXPlpO6g5g2vdwxM+X9HNXeB9ruwl+Bngz9k0o/PXlwZmJW+mDljbRtDwmhKQb
         4GNSi+i9DVzz8e61GWi+sysZMqZYxgMylc7skw48UVASxbsomCdbh1wPPhAuhv/b/FSy
         pS6w6TjFyINtt2xXfw2nPtH1P0+drcClf7AopU3RYg/WgpLJ0dmqEbKIs9PmZ8DsrE8A
         yP45mhfgtx/YnmdehYQRlEaSbZIB5+/uXgY2pktVJIJsg5jO+dNRCFIYFHVhL0jESfqv
         UFumVvuzZV5ID5kjpSnTuAtNa3lMIIkZxHhmsuu33KVfvug0qNuM3UQOX5qNMBcrfUh4
         XuyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0dGhXd6l+JAf802cqmKwLC7EJofNrRCDMAW4nGocchY=;
        b=R3FdOcc86DAWQ985ZOGx8gecR1G0ISnYVGWA0CTwPSAHHuV4W5Brt2sxRP7vO6jlJy
         OT07AltSp4txRrpwcCH1epGud21yElxRKeQDuWCa1eWTJDoirWdlbesBVcOWB67SXwis
         Cj3aXa03TtwfQMZhPpuXwpNN8j1/Pj+ybpihf0QzAPzk+oF0JxvkOFEJuO9KoG7D4pcY
         pP8+z/qcY+m7SuzVHCBO8z2AOKXzHh5dEewOk0k0RPFHpatoXvf32yO+QeP6BZw47Qwk
         31kAhru/L0EehGF46f9HV4JaGagqoknR8zybR7KRuvzW2UyZdxTd76yzZ0FGJw9YjVjR
         Z70g==
X-Gm-Message-State: AOAM532cInWtE183MMDR/FJHpPFqA3n+uzxuutHIr0MOA/Mcl6ggFiul
        t/IlbPW0MRWEI5KQa96r5ez+KEe9dq02Cw==
X-Google-Smtp-Source: ABdhPJyzcPP8qAvuPJZah22HMK4s4jRH/NTVIg2NcI0rmlO5+ZIDdifdq/lfgJ/vaKMaDc4FnXzNtw==
X-Received: by 2002:ac8:5459:: with SMTP id d25mr5808128qtq.385.1621524098764;
        Thu, 20 May 2021 08:21:38 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id u11sm1987390qtq.93.2021.05.20.08.21.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 May 2021 08:21:38 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 2/3] btrfs: add a btrfs_has_fs_error helper
Date:   Thu, 20 May 2021 11:21:32 -0400
Message-Id: <a4bc9de04778cf6aa038f5164d01cf467de32ed5.1621523846.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1621523846.git.josef@toxicpanda.com>
References: <cover.1621523846.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We have a few flags that are inconsistently used to describe the fs in
different states of failure.  As of

	btrfs: always abort the transaction if we abort a trans handle

we will always set BTRFS_FS_STATE_ERROR if we abort, so we don't have to
check both ABORTED and ERROR to see if things have gone wrong.  Add a
helper to check BTRFS_FS_STATE_HELPER and then convert all checkers of
FS_STATE_ERROR to use the helper.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/ctree.h       |  5 +++++
 fs/btrfs/disk-io.c     |  8 +++-----
 fs/btrfs/extent_io.c   |  2 +-
 fs/btrfs/file.c        |  2 +-
 fs/btrfs/inode.c       |  6 +++---
 fs/btrfs/scrub.c       |  2 +-
 fs/btrfs/super.c       |  2 +-
 fs/btrfs/transaction.c | 11 +++++------
 fs/btrfs/tree-log.c    |  2 +-
 9 files changed, 21 insertions(+), 19 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 938d8ebf4cf3..3c22c3308667 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -3531,6 +3531,11 @@ do {								\
 			  (errno), fmt, ##args);		\
 } while (0)
 
+static inline bool btrfs_has_fs_error(struct btrfs_fs_info *fs_info)
+{
+	return test_bit(BTRFS_FS_STATE_ERROR, &fs_info->fs_state);
+}
+
 __printf(5, 6)
 __cold
 void __btrfs_panic(struct btrfs_fs_info *fs_info, const char *function,
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 8c3db9076988..ab1d0b9f90e7 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -1969,8 +1969,7 @@ static int transaction_kthread(void *arg)
 		wake_up_process(fs_info->cleaner_kthread);
 		mutex_unlock(&fs_info->transaction_kthread_mutex);
 
-		if (unlikely(test_bit(BTRFS_FS_STATE_ERROR,
-				      &fs_info->fs_state)))
+		if (unlikely(btrfs_has_fs_error(fs_info)))
 			btrfs_cleanup_transaction(fs_info);
 		if (!kthread_should_stop() &&
 				(!btrfs_transaction_blocked(fs_info) ||
@@ -4221,7 +4220,7 @@ void btrfs_drop_and_free_fs_root(struct btrfs_fs_info *fs_info,
 		drop_ref = true;
 	spin_unlock(&fs_info->fs_roots_radix_lock);
 
-	if (test_bit(BTRFS_FS_STATE_ERROR, &fs_info->fs_state)) {
+	if (btrfs_has_fs_error(fs_info)) {
 		ASSERT(root->log_root == NULL);
 		if (root->reloc_root) {
 			btrfs_put_root(root->reloc_root);
@@ -4372,8 +4371,7 @@ void __cold close_ctree(struct btrfs_fs_info *fs_info)
 			btrfs_err(fs_info, "commit super ret %d", ret);
 	}
 
-	if (test_bit(BTRFS_FS_STATE_ERROR, &fs_info->fs_state) ||
-	    test_bit(BTRFS_FS_STATE_TRANS_ABORTED, &fs_info->fs_state))
+	if (btrfs_has_fs_error(fs_info))
 		btrfs_error_commit_super(fs_info);
 
 	kthread_stop(fs_info->transaction_kthread);
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 78d3f2ec90e0..c89871eabef8 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -4613,7 +4613,7 @@ int btree_write_cache_pages(struct address_space *mapping,
 	 *   extent io tree. Thus we don't want to submit such wild eb
 	 *   if the fs already has error.
 	 */
-	if (!test_bit(BTRFS_FS_STATE_ERROR, &fs_info->fs_state)) {
+	if (!btrfs_has_fs_error(fs_info)) {
 		ret = flush_write_bio(&epd);
 	} else {
 		ret = -EROFS;
diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 3b10d98b4ebb..3a68d55c1870 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -1999,7 +1999,7 @@ static ssize_t btrfs_file_write_iter(struct kiocb *iocb,
 	 * have opened a file as writable, we have to stop this write operation
 	 * to ensure consistency.
 	 */
-	if (test_bit(BTRFS_FS_STATE_ERROR, &inode->root->fs_info->fs_state))
+	if (btrfs_has_fs_error(inode->root->fs_info))
 		return -EROFS;
 
 	if (!(iocb->ki_flags & IOCB_DIRECT) &&
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index ca835ee61045..351b28366aa1 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -4221,7 +4221,7 @@ static void btrfs_prune_dentries(struct btrfs_root *root)
 	struct inode *inode;
 	u64 objectid = 0;
 
-	if (!test_bit(BTRFS_FS_STATE_ERROR, &fs_info->fs_state))
+	if (!btrfs_has_fs_error(fs_info))
 		WARN_ON(btrfs_root_refs(&root->root_item) != 0);
 
 	spin_lock(&root->inode_lock);
@@ -9703,7 +9703,7 @@ int btrfs_start_delalloc_snapshot(struct btrfs_root *root, bool in_reclaim_conte
 	};
 	struct btrfs_fs_info *fs_info = root->fs_info;
 
-	if (test_bit(BTRFS_FS_STATE_ERROR, &fs_info->fs_state))
+	if (btrfs_has_fs_error(fs_info))
 		return -EROFS;
 
 	return start_delalloc_inodes(root, &wbc, true, in_reclaim_context);
@@ -9722,7 +9722,7 @@ int btrfs_start_delalloc_roots(struct btrfs_fs_info *fs_info, long nr,
 	struct list_head splice;
 	int ret;
 
-	if (test_bit(BTRFS_FS_STATE_ERROR, &fs_info->fs_state))
+	if (btrfs_has_fs_error(fs_info))
 		return -EROFS;
 
 	INIT_LIST_HEAD(&splice);
diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index 485cda3eb8d7..4db4286069b0 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -3893,7 +3893,7 @@ static noinline_for_stack int scrub_supers(struct scrub_ctx *sctx,
 	int	ret;
 	struct btrfs_fs_info *fs_info = sctx->fs_info;
 
-	if (test_bit(BTRFS_FS_STATE_ERROR, &fs_info->fs_state))
+	if (btrfs_has_fs_error(fs_info))
 		return -EROFS;
 
 	/* Seed devices of a new filesystem has their own generation. */
diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index bc613218c8c5..eb6a48f0b236 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -2018,7 +2018,7 @@ static int btrfs_remount(struct super_block *sb, int *flags, char *data)
 		if (ret)
 			goto restore;
 	} else {
-		if (test_bit(BTRFS_FS_STATE_ERROR, &fs_info->fs_state)) {
+		if (btrfs_has_fs_error(fs_info)) {
 			btrfs_err(fs_info,
 				"Remounting read-write after error is not allowed");
 			ret = -EINVAL;
diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index e0a82aa7da89..f74ba158c0c3 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -285,7 +285,7 @@ static noinline int join_transaction(struct btrfs_fs_info *fs_info,
 	spin_lock(&fs_info->trans_lock);
 loop:
 	/* The file system has been taken offline. No new transactions. */
-	if (test_bit(BTRFS_FS_STATE_ERROR, &fs_info->fs_state)) {
+	if (btrfs_has_fs_error(fs_info)) {
 		spin_unlock(&fs_info->trans_lock);
 		return -EROFS;
 	}
@@ -333,7 +333,7 @@ static noinline int join_transaction(struct btrfs_fs_info *fs_info,
 		 */
 		kfree(cur_trans);
 		goto loop;
-	} else if (test_bit(BTRFS_FS_STATE_ERROR, &fs_info->fs_state)) {
+	} else if (btrfs_has_fs_error(fs_info)) {
 		spin_unlock(&fs_info->trans_lock);
 		kfree(cur_trans);
 		return -EROFS;
@@ -586,7 +586,7 @@ start_transaction(struct btrfs_root *root, unsigned int num_items,
 	/* Send isn't supposed to start transactions. */
 	ASSERT(current->journal_info != BTRFS_SEND_TRANS_STUB);
 
-	if (test_bit(BTRFS_FS_STATE_ERROR, &fs_info->fs_state))
+	if (btrfs_has_fs_error(fs_info))
 		return ERR_PTR(-EROFS);
 
 	if (current->journal_info) {
@@ -999,8 +999,7 @@ static int __btrfs_end_transaction(struct btrfs_trans_handle *trans,
 	if (throttle)
 		btrfs_run_delayed_iputs(info);
 
-	if (TRANS_ABORTED(trans) ||
-	    test_bit(BTRFS_FS_STATE_ERROR, &info->fs_state)) {
+	if (TRANS_ABORTED(trans) || btrfs_has_fs_error(info)) {
 		wake_up_process(info->transaction_kthread);
 		if (TRANS_ABORTED(trans))
 			err = trans->aborted;
@@ -2187,7 +2186,7 @@ int btrfs_commit_transaction(struct btrfs_trans_handle *trans)
 		 * abort to prevent writing a new superblock that reflects a
 		 * corrupt state (pointing to trees with unwritten nodes/leafs).
 		 */
-		if (test_bit(BTRFS_FS_STATE_TRANS_ABORTED, &fs_info->fs_state)) {
+		if (btrfs_has_fs_error(fs_info)) {
 			ret = -EROFS;
 			goto cleanup_transaction;
 		}
diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 16eca7d091fd..83d0b796d5d4 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -3310,7 +3310,7 @@ int btrfs_sync_log(struct btrfs_trans_handle *trans,
 	 * here would result in transid mismatches.  If there is an error here
 	 * just bail.
 	 */
-	if (test_bit(BTRFS_FS_STATE_ERROR, &fs_info->fs_state)) {
+	if (btrfs_has_fs_error(fs_info)) {
 		ret = -EIO;
 		btrfs_set_log_full_commit(trans);
 		btrfs_abort_transaction(trans, ret);
-- 
2.26.3

