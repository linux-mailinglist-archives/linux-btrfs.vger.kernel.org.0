Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CC03419DCC
	for <lists+linux-btrfs@lfdr.de>; Mon, 27 Sep 2021 20:05:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235838AbhI0SHM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 27 Sep 2021 14:07:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234406AbhI0SG7 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 27 Sep 2021 14:06:59 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A2F7C061575
        for <linux-btrfs@vger.kernel.org>; Mon, 27 Sep 2021 11:05:21 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id c20so17486084qtb.2
        for <linux-btrfs@vger.kernel.org>; Mon, 27 Sep 2021 11:05:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=C+sRnEFpAnxheHvTzwYujbZH0DCNCRodpEoYDZA+Zp4=;
        b=e/q7+d0qd4yJ8NMFrFPNOoRRVeoiDHNqQu6423XkKMm3Sw317OeqCUsXReqITu9WSz
         vFf0lZ5JLdbS0OA3LHJrG9T9hdscUkHSHVatOUT1+kvKX5165neDXuUfwPNgVeB8BSVf
         3w3BLY0ySHN2sFPMrg27kZTEN68tUPqU+IQ06blzj9TaGfmIz3o9W4P0y1Z6g0GCaJx6
         JJRhyI/RNLAO8s+aqE67eCFP4tHp/uXBlWWS7Im7I4L5yxZN0WtdP64WYx3kdaYU8+Hy
         C7SV3RRqErQ9xUMg9y7kOWPMDJ0dG4Fn2Ln55UiSWaAefqhpI9UbNF1Ej2ALMhUJgyX8
         Zcmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=C+sRnEFpAnxheHvTzwYujbZH0DCNCRodpEoYDZA+Zp4=;
        b=OaJXI2CAyKyYVQnmafbjbUWoIbZ0PJ+ygMnMMVsmYurylKvmmDGK+Kc6ImPu5IIGUW
         5YbJDj381SFOyJ5GrxGmw8fNaZ31VTyh0Yvl2+Ik6jr3xe8XW2gycI2J00a1OoVJ0Bt7
         qqMWDWPrK1uOa2jOnk2VIAKLE9b7DR9xxes3Otl3aEjzN6mp3v7orX4ifQGelZsY3AmG
         LjJi/zxRAYfUzXPY+nSvQQsFUOtwtvNe8nEQ7L23gr9xN7xsI0IXmJ3zk3iIAYtLKWTN
         8kPaZkdffv3FACP6e/59QjBcrWi2sJK1UkkNdOTUvXzuxC+kQbClqdtpTy/uVzwVGkTO
         Wkpg==
X-Gm-Message-State: AOAM531LwR20z/aBhg46JfkzL653tGW3YRBuCWDNRimPCbpEDKg+a9UM
        FFhosiaLD0hpeQWLcut0qZGJx9Yhh0oWRg==
X-Google-Smtp-Source: ABdhPJwHhqPc/HevZLcZERVDonbMGXDVF1rHAr823t8XQrKF5EVyaEOxIP2TZdTkj9TB9Vacb/p3TA==
X-Received: by 2002:ac8:59cb:: with SMTP id f11mr1203529qtf.321.1632765920264;
        Mon, 27 Sep 2021 11:05:20 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id m68sm13155385qkb.105.2021.09.27.11.05.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Sep 2021 11:05:19 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v3 3/5] btrfs: add a BTRFS_FS_ERROR helper
Date:   Mon, 27 Sep 2021 14:05:12 -0400
Message-Id: <4790be90bba87904294617bec93c5dfe586bbd58.1632765815.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1632765815.git.josef@toxicpanda.com>
References: <cover.1632765815.git.josef@toxicpanda.com>
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
index 522ded06fd85..53f15decb523 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -3576,6 +3576,9 @@ do {								\
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
index c56973f7daae..f6f004d673a0 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -4876,7 +4876,7 @@ int btree_write_cache_pages(struct address_space *mapping,
 	 *   extent io tree. Thus we don't want to submit such wild eb
 	 *   if the fs already has error.
 	 */
-	if (!test_bit(BTRFS_FS_STATE_ERROR, &fs_info->fs_state)) {
+	if (!BTRFS_FS_ERROR(fs_info)) {
 		ret = flush_write_bio(&epd);
 	} else {
 		ret = -EROFS;
diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 7ff577005d0f..fdceab28587e 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -2013,7 +2013,7 @@ static ssize_t btrfs_file_write_iter(struct kiocb *iocb,
 	 * have opened a file as writable, we have to stop this write operation
 	 * to ensure consistency.
 	 */
-	if (test_bit(BTRFS_FS_STATE_ERROR, &inode->root->fs_info->fs_state))
+	if (BTRFS_FS_ERROR(inode->root->fs_info))
 		return -EROFS;
 
 	if (!(iocb->ki_flags & IOCB_DIRECT) &&
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 03a843b9659b..26d155e72152 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -4368,7 +4368,7 @@ static void btrfs_prune_dentries(struct btrfs_root *root)
 	struct inode *inode;
 	u64 objectid = 0;
 
-	if (!test_bit(BTRFS_FS_STATE_ERROR, &fs_info->fs_state))
+	if (!BTRFS_FS_ERROR(fs_info))
 		WARN_ON(btrfs_root_refs(&root->root_item) != 0);
 
 	spin_lock(&root->inode_lock);
@@ -9981,7 +9981,7 @@ int btrfs_start_delalloc_snapshot(struct btrfs_root *root, bool in_reclaim_conte
 	};
 	struct btrfs_fs_info *fs_info = root->fs_info;
 
-	if (test_bit(BTRFS_FS_STATE_ERROR, &fs_info->fs_state))
+	if (BTRFS_FS_ERROR(fs_info))
 		return -EROFS;
 
 	return start_delalloc_inodes(root, &wbc, true, in_reclaim_context);
@@ -10000,7 +10000,7 @@ int btrfs_start_delalloc_roots(struct btrfs_fs_info *fs_info, long nr,
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
index 720723611875..9e5937685896 100644
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

