Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07C1E423221
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Oct 2021 22:35:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236110AbhJEUh0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 5 Oct 2021 16:37:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230352AbhJEUhZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 5 Oct 2021 16:37:25 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1341C061749
        for <linux-btrfs@vger.kernel.org>; Tue,  5 Oct 2021 13:35:34 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id q125so250899qkd.12
        for <linux-btrfs@vger.kernel.org>; Tue, 05 Oct 2021 13:35:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AHZt3EPuSy/iy2NVdNAyF4jU9ZFPmTXvjmTacJy9MHg=;
        b=lmeVPaRsYMlcktEAdO9uGvK4ztohB6DcOjFXKpn4hmnThnyfsiUjadcNxsnBSUAbY5
         KU5Qvr8YhBclRxsnEIRNGHOALkVMS+HjvEmJmWcPD0EwdP91PhqfM5f+M/SFXCm9CkOg
         ubtJA5Rl1LrE7Zax/MyiZpNKoALdRpw2ZxkW4EuuIKLTKlQamkLW8YkI2fszegHoFHuA
         1sA6ruVv9eoPZ1oEg3Dekta2HXKhgPcObmG5k0cKXEl4pcmcDwWKzWjiVIHALjBYuknw
         TCLpdfkvPE81DW5yMll87epGKDYf6a6Kgyz9yt0Lsgr34RtarAfGeU890a/CMXunVlUJ
         tlRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AHZt3EPuSy/iy2NVdNAyF4jU9ZFPmTXvjmTacJy9MHg=;
        b=0pEugLz3r9A0uIvw1rA253AH16QqtszBtgUx0umQoyr+xev3XqQ0tVkiPERn49zvne
         ceFZVkmiizKx8du/Wq5f0/lqFe66YZCFVzLliKhjOmFhi+EZ9kfZXzAbnljHbGD6GmdG
         IILCyypP3X7kmP5B0t+RU6aipsuu2Jf6GJihiBniV2a8WjnDdTsWAZCFjUv2b8UZ4Q+G
         H7HhEWSlI/0AVJsXgLaYOvQFLwo8aH6sBTEiGCFl59IzUWQmg7y51j+ZnMbmyy+23+Cz
         Gqeu1dZBfSWK8IzCjKlWXQ35cauWemfmki2ep+CtBqw9jPH2PcPqXGul11OrqJPJezi0
         7b2g==
X-Gm-Message-State: AOAM532JjjmQMUEDK7h3EEbhgKr+sJRwadfSsj2EMYnT6Z3IlPuIOQyg
        cNdw6AQFHndIgOlmvo5oWgsw/E5W25fTaw==
X-Google-Smtp-Source: ABdhPJxWEc/Oy6moQANbxNGGiRcNjeq3bFQayNhsJ5XlNiiDPkforKh3dqEVvmY6WiC3UAgnxRHr2A==
X-Received: by 2002:a37:45c4:: with SMTP id s187mr16701592qka.125.1633466133858;
        Tue, 05 Oct 2021 13:35:33 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id b14sm12097194qtk.64.2021.10.05.13.35.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Oct 2021 13:35:33 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Anand Jain <anand.jain@oracle.com>
Subject: [PATCH v4 3/5] btrfs: add a BTRFS_FS_ERROR helper
Date:   Tue,  5 Oct 2021 16:35:25 -0400
Message-Id: <6a296199cacaf7ec138e8e25d6cbf79644434bbf.1633465964.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1633465964.git.josef@toxicpanda.com>
References: <cover.1633465964.git.josef@toxicpanda.com>
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
helper to check BTRFS_FS_STATE_ERROR and then convert all checkers of
FS_STATE_ERROR to use the helper.

Reviewed-by: Anand Jain <anand.jain@oracle.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/ctree.h       |  3 +++
 fs/btrfs/disk-io.c     |  8 +++-----
 fs/btrfs/extent_io.c   |  2 +-
 fs/btrfs/file.c        |  2 +-
 fs/btrfs/inode.c       |  6 +++---
 fs/btrfs/scrub.c       |  2 +-
 fs/btrfs/super.c       |  2 +-
 fs/btrfs/transaction.c | 11 +++++------
 fs/btrfs/tree-log.c    |  2 +-
 9 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 9c730e718d20..3d234469c132 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -3607,6 +3607,9 @@ do {								\
 			  (errno), fmt, ##args);		\
 } while (0)
 
+#define BTRFS_FS_ERROR(fs_info)	(unlikely(test_bit(BTRFS_FS_STATE_ERROR, \
+						   &(fs_info)->fs_state)))
+
 __printf(5, 6)
 __cold
 void __btrfs_panic(struct btrfs_fs_info *fs_info, const char *function,
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 37637539c5ab..1ae30b29f2b5 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -1954,8 +1954,7 @@ static int transaction_kthread(void *arg)
 		wake_up_process(fs_info->cleaner_kthread);
 		mutex_unlock(&fs_info->transaction_kthread_mutex);
 
-		if (unlikely(test_bit(BTRFS_FS_STATE_ERROR,
-				      &fs_info->fs_state)))
+		if (BTRFS_FS_ERROR(fs_info))
 			btrfs_cleanup_transaction(fs_info);
 		if (!kthread_should_stop() &&
 				(!btrfs_transaction_blocked(fs_info) ||
@@ -4232,7 +4231,7 @@ void btrfs_drop_and_free_fs_root(struct btrfs_fs_info *fs_info,
 		drop_ref = true;
 	spin_unlock(&fs_info->fs_roots_radix_lock);
 
-	if (test_bit(BTRFS_FS_STATE_ERROR, &fs_info->fs_state)) {
+	if (BTRFS_FS_ERROR(fs_info)) {
 		ASSERT(root->log_root == NULL);
 		if (root->reloc_root) {
 			btrfs_put_root(root->reloc_root);
@@ -4383,8 +4382,7 @@ void __cold close_ctree(struct btrfs_fs_info *fs_info)
 			btrfs_err(fs_info, "commit super ret %d", ret);
 	}
 
-	if (test_bit(BTRFS_FS_STATE_ERROR, &fs_info->fs_state) ||
-	    test_bit(BTRFS_FS_STATE_TRANS_ABORTED, &fs_info->fs_state))
+	if (BTRFS_FS_ERROR(fs_info))
 		btrfs_error_commit_super(fs_info);
 
 	kthread_stop(fs_info->transaction_kthread);
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index d022654af420..b10dc75eef1c 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -4908,7 +4908,7 @@ int btree_write_cache_pages(struct address_space *mapping,
 	 *   extent io tree. Thus we don't want to submit such wild eb
 	 *   if the fs already has error.
 	 */
-	if (!test_bit(BTRFS_FS_STATE_ERROR, &fs_info->fs_state)) {
+	if (!BTRFS_FS_ERROR(fs_info)) {
 		ret = flush_write_bio(&epd);
 	} else {
 		ret = -EROFS;
diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 98f6e5c8d62c..62673ad5f0ba 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -2019,7 +2019,7 @@ static ssize_t btrfs_file_write_iter(struct kiocb *iocb,
 	 * have opened a file as writable, we have to stop this write operation
 	 * to ensure consistency.
 	 */
-	if (test_bit(BTRFS_FS_STATE_ERROR, &inode->root->fs_info->fs_state))
+	if (BTRFS_FS_ERROR(inode->root->fs_info))
 		return -EROFS;
 
 	if (!(iocb->ki_flags & IOCB_DIRECT) &&
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index df716d1bd2f1..034488f6b1a0 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -4376,7 +4376,7 @@ static void btrfs_prune_dentries(struct btrfs_root *root)
 	struct inode *inode;
 	u64 objectid = 0;
 
-	if (!test_bit(BTRFS_FS_STATE_ERROR, &fs_info->fs_state))
+	if (!BTRFS_FS_ERROR(fs_info))
 		WARN_ON(btrfs_root_refs(&root->root_item) != 0);
 
 	spin_lock(&root->inode_lock);
@@ -9994,7 +9994,7 @@ int btrfs_start_delalloc_snapshot(struct btrfs_root *root, bool in_reclaim_conte
 	};
 	struct btrfs_fs_info *fs_info = root->fs_info;
 
-	if (test_bit(BTRFS_FS_STATE_ERROR, &fs_info->fs_state))
+	if (BTRFS_FS_ERROR(fs_info))
 		return -EROFS;
 
 	return start_delalloc_inodes(root, &wbc, true, in_reclaim_context);
@@ -10013,7 +10013,7 @@ int btrfs_start_delalloc_roots(struct btrfs_fs_info *fs_info, long nr,
 	struct list_head splice;
 	int ret;
 
-	if (test_bit(BTRFS_FS_STATE_ERROR, &fs_info->fs_state))
+	if (BTRFS_FS_ERROR(fs_info))
 		return -EROFS;
 
 	INIT_LIST_HEAD(&splice);
diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index bd3cd7427391..b1c26a90243b 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -3955,7 +3955,7 @@ static noinline_for_stack int scrub_supers(struct scrub_ctx *sctx,
 	int	ret;
 	struct btrfs_fs_info *fs_info = sctx->fs_info;
 
-	if (test_bit(BTRFS_FS_STATE_ERROR, &fs_info->fs_state))
+	if (BTRFS_FS_ERROR(fs_info))
 		return -EROFS;
 
 	/* Seed devices of a new filesystem has their own generation. */
diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 7f91d62c2225..a1c54a2c787c 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -2006,7 +2006,7 @@ static int btrfs_remount(struct super_block *sb, int *flags, char *data)
 		if (ret)
 			goto restore;
 	} else {
-		if (test_bit(BTRFS_FS_STATE_ERROR, &fs_info->fs_state)) {
+		if (BTRFS_FS_ERROR(fs_info)) {
 			btrfs_err(fs_info,
 				"Remounting read-write after error is not allowed");
 			ret = -EINVAL;
diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index 14b9fdc8aaa9..1c3a1189c0bd 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -283,7 +283,7 @@ static noinline int join_transaction(struct btrfs_fs_info *fs_info,
 	spin_lock(&fs_info->trans_lock);
 loop:
 	/* The file system has been taken offline. No new transactions. */
-	if (test_bit(BTRFS_FS_STATE_ERROR, &fs_info->fs_state)) {
+	if (BTRFS_FS_ERROR(fs_info)) {
 		spin_unlock(&fs_info->trans_lock);
 		return -EROFS;
 	}
@@ -331,7 +331,7 @@ static noinline int join_transaction(struct btrfs_fs_info *fs_info,
 		 */
 		kfree(cur_trans);
 		goto loop;
-	} else if (test_bit(BTRFS_FS_STATE_ERROR, &fs_info->fs_state)) {
+	} else if (BTRFS_FS_ERROR(fs_info)) {
 		spin_unlock(&fs_info->trans_lock);
 		kfree(cur_trans);
 		return -EROFS;
@@ -579,7 +579,7 @@ start_transaction(struct btrfs_root *root, unsigned int num_items,
 	bool do_chunk_alloc = false;
 	int ret;
 
-	if (test_bit(BTRFS_FS_STATE_ERROR, &fs_info->fs_state))
+	if (BTRFS_FS_ERROR(fs_info))
 		return ERR_PTR(-EROFS);
 
 	if (current->journal_info) {
@@ -991,8 +991,7 @@ static int __btrfs_end_transaction(struct btrfs_trans_handle *trans,
 	if (throttle)
 		btrfs_run_delayed_iputs(info);
 
-	if (TRANS_ABORTED(trans) ||
-	    test_bit(BTRFS_FS_STATE_ERROR, &info->fs_state)) {
+	if (TRANS_ABORTED(trans) || BTRFS_FS_ERROR(info)) {
 		wake_up_process(info->transaction_kthread);
 		if (TRANS_ABORTED(trans))
 			err = trans->aborted;
@@ -2155,7 +2154,7 @@ int btrfs_commit_transaction(struct btrfs_trans_handle *trans)
 		 * abort to prevent writing a new superblock that reflects a
 		 * corrupt state (pointing to trees with unwritten nodes/leafs).
 		 */
-		if (test_bit(BTRFS_FS_STATE_TRANS_ABORTED, &fs_info->fs_state)) {
+		if (BTRFS_FS_ERROR(fs_info)) {
 			ret = -EROFS;
 			goto cleanup_transaction;
 		}
diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index a99aa57b8886..994ea456e904 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -3335,7 +3335,7 @@ int btrfs_sync_log(struct btrfs_trans_handle *trans,
 	 * writing the super here would result in transid mismatches.  If there
 	 * is an error here just bail.
 	 */
-	if (test_bit(BTRFS_FS_STATE_ERROR, &fs_info->fs_state)) {
+	if (BTRFS_FS_ERROR(fs_info)) {
 		ret = -EIO;
 		btrfs_set_log_full_commit(trans);
 		btrfs_abort_transaction(trans, ret);
-- 
2.26.3

