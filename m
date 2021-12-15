Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3013E47639F
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Dec 2021 21:44:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236499AbhLOUoC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 15 Dec 2021 15:44:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235170AbhLOUoB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 15 Dec 2021 15:44:01 -0500
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5580DC061574
        for <linux-btrfs@vger.kernel.org>; Wed, 15 Dec 2021 12:44:01 -0800 (PST)
Received: by mail-qt1-x830.google.com with SMTP id t11so23204952qtw.3
        for <linux-btrfs@vger.kernel.org>; Wed, 15 Dec 2021 12:44:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=uuzwQ/NOx0tmYx9ryKw2+wYA+36D5Bz+20L/BsmmYrA=;
        b=oov8YyO+q24+LJy+aJlS0vJWC4U4hHiPGCiY4KGj4uHz5nAk+Z4T+5VMzCv6TcLPaz
         di+aimNZW2C55oQlnGN6j152+o4XVpEbx8spa+CZwZpWUasEgK6bQ5NQap1hqpY1jQWP
         vXTwPQQiKIPYKtp+P2YlfYMud+Ecg0ia31eSb0M13iB+EkeLS+MXsFBWo9k78uw2lB3r
         mWWNP3jVwHdlUV0DyKLkXPTu8cTdyOjk5dzf6J9KvPPmonjUej6nb5hsqg0aSuoyfDdv
         JOys7YJ41o0Fi5eLYquNLTgUN5jKmOSe8TnJmW3Sws14MtkHtR+84nARUKvh+faEtK/1
         1Z0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uuzwQ/NOx0tmYx9ryKw2+wYA+36D5Bz+20L/BsmmYrA=;
        b=IfP34s6jZehqxC9UKSz1MDwzr4PDhFeMuHhwQBAHHdFxIXIIJpA3iCyhD7ZI80dkHI
         EnPXWl72cmP4tkQ4JrkXrPp4etPpJKNlkc7RrViLdy7rWDbg4VV0G5M6AX3N9TA0IhtC
         1H75hOqL2Vz6DS09u2lqLHtg+MSdLk253FLvruPfD8qHHT6VWl5OlvavfAfRRTRaTWnh
         ZmO78d9bB7ZlSFN6uRRP9l7jig4ky6NuVsEHCXtiVcNMRIm5x9fx8oOEtETrNKdxhGtt
         zfcZCfRJH5DcNZSFlhVNGZObkcDGvjV4nes0Z25OGN1Ic7Tbh2dtte3Ffu4HIxIOWrRy
         2EwA==
X-Gm-Message-State: AOAM5331gB+nh9iex60FkZzq3AiylynS3JD78jfVYscYHOsRiNXgfYK8
        etPmDr3KOhHbz0pcKeQgNDl+/HxrF9mgPw==
X-Google-Smtp-Source: ABdhPJx8pGo4LwI078p7V9GpXEtPKoNLU+LB4ppgdo/4upFszurJqEejbFih6bA5NRR1Kk/lJD/4Ew==
X-Received: by 2002:a05:622a:388:: with SMTP id j8mr14086912qtx.366.1639601040102;
        Wed, 15 Dec 2021 12:44:00 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id p1sm1654256qke.109.2021.12.15.12.43.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Dec 2021 12:43:59 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 9/9] btrfs: add garbage collection tree support
Date:   Wed, 15 Dec 2021 15:43:45 -0500
Message-Id: <779baa39333d89fba8f23fa6f9b769e0cb1d735c.1639600854.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1639600854.git.josef@toxicpanda.com>
References: <cover.1639600854.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This patch adds the support for loading the gc tree, and running the
inode garbage collection work.  Every time the transaction is committed
we'll kick off helpers to run any items in the GC tree.  Currently we
just have the inode item collection, which will handle the work of
deleting the inode items once an inode is unlinked.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/Makefile      |   2 +-
 fs/btrfs/ctree.h       |   8 ++
 fs/btrfs/disk-io.c     |   8 +-
 fs/btrfs/gc-tree.c     | 223 +++++++++++++++++++++++++++++++++++++++++
 fs/btrfs/gc-tree.h     |  15 +++
 fs/btrfs/inode.c       |  13 +++
 fs/btrfs/transaction.c |   3 +
 7 files changed, 270 insertions(+), 2 deletions(-)
 create mode 100644 fs/btrfs/gc-tree.c
 create mode 100644 fs/btrfs/gc-tree.h

diff --git a/fs/btrfs/Makefile b/fs/btrfs/Makefile
index 3dcf9bcc2326..514f117d253c 100644
--- a/fs/btrfs/Makefile
+++ b/fs/btrfs/Makefile
@@ -30,7 +30,7 @@ btrfs-y += super.o ctree.o extent-tree.o print-tree.o root-tree.o dir-item.o \
 	   reada.o backref.o ulist.o qgroup.o send.o dev-replace.o raid56.o \
 	   uuid-tree.o props.o free-space-tree.o tree-checker.o space-info.o \
 	   block-rsv.o delalloc-space.o block-group.o discard.o reflink.o \
-	   subpage.o tree-mod-log.o
+	   subpage.o tree-mod-log.o gc-tree.o
 
 btrfs-$(CONFIG_BTRFS_FS_POSIX_ACL) += acl.o
 btrfs-$(CONFIG_BTRFS_FS_CHECK_INTEGRITY) += check-integrity.o
diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 720ea66e37c1..eb0715602948 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -855,6 +855,9 @@ struct btrfs_fs_info {
 	struct btrfs_workqueue *fixup_workers;
 	struct btrfs_workqueue *delayed_workers;
 
+	/* Used to run the GC work. */
+	struct btrfs_workqueue *gc_workers;
+
 	struct task_struct *transaction_kthread;
 	struct task_struct *cleaner_kthread;
 	u32 thread_pool_size;
@@ -1002,6 +1005,9 @@ struct btrfs_fs_info {
 
 	struct semaphore uuid_tree_rescan_sem;
 
+	/* Used to run GC in the background. */
+	struct work_struct gc_work;
+
 	/* Used to reclaim the metadata space in the background. */
 	struct work_struct async_reclaim_work;
 	struct work_struct async_data_reclaim_work;
@@ -1137,6 +1143,8 @@ enum {
 	BTRFS_ROOT_QGROUP_FLUSHING,
 	/* We started the orphan cleanup for this root. */
 	BTRFS_ROOT_ORPHAN_CLEANUP,
+	/* GC is happening on this root. */
+	BTRFS_ROOT_GC_RUNNING,
 };
 
 /*
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 98b37850d614..aefe1edacd57 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -2268,6 +2268,7 @@ static void btrfs_stop_all_workers(struct btrfs_fs_info *fs_info)
 	 */
 	btrfs_destroy_workqueue(fs_info->endio_meta_workers);
 	btrfs_destroy_workqueue(fs_info->endio_meta_write_workers);
+	btrfs_destroy_workqueue(fs_info->gc_workers);
 }
 
 static void free_root_extent_buffers(struct btrfs_root *root)
@@ -2477,6 +2478,8 @@ static int btrfs_init_workqueues(struct btrfs_fs_info *fs_info)
 		btrfs_alloc_workqueue(fs_info, "qgroup-rescan", flags, 1, 0);
 	fs_info->discard_ctl.discard_workers =
 		alloc_workqueue("btrfs_discard", WQ_UNBOUND | WQ_FREEZABLE, 1);
+	fs_info->gc_workers =
+		btrfs_alloc_workqueue(fs_info, "garbage-collect", flags, max_active, 1);
 
 	if (!(fs_info->workers && fs_info->delalloc_workers &&
 	      fs_info->flush_workers &&
@@ -2487,7 +2490,7 @@ static int btrfs_init_workqueues(struct btrfs_fs_info *fs_info)
 	      fs_info->caching_workers && fs_info->readahead_workers &&
 	      fs_info->fixup_workers && fs_info->delayed_workers &&
 	      fs_info->qgroup_rescan_workers &&
-	      fs_info->discard_ctl.discard_workers)) {
+	      fs_info->discard_ctl.discard_workers && fs_info->gc_workers)) {
 		return -ENOMEM;
 	}
 
@@ -4588,6 +4591,9 @@ void __cold close_ctree(struct btrfs_fs_info *fs_info)
 	 */
 	kthread_park(fs_info->cleaner_kthread);
 
+	/* Stop the gc workers. */
+	btrfs_flush_workqueue(fs_info->gc_workers);
+
 	/* wait for the qgroup rescan worker to stop */
 	btrfs_qgroup_wait_for_completion(fs_info, false);
 
diff --git a/fs/btrfs/gc-tree.c b/fs/btrfs/gc-tree.c
new file mode 100644
index 000000000000..7df7236f805c
--- /dev/null
+++ b/fs/btrfs/gc-tree.c
@@ -0,0 +1,223 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include "ctree.h"
+#include "gc-tree.h"
+#include "btrfs_inode.h"
+#include "disk-io.h"
+#include "transaction.h"
+#include "inode-item.h"
+
+struct gc_work {
+	struct btrfs_work work;
+	struct btrfs_root *root;
+};
+
+static struct btrfs_root *inode_gc_root(struct btrfs_inode *inode)
+{
+	struct btrfs_fs_info *fs_info = inode->root->fs_info;
+	struct btrfs_key key = {
+		.objectid = BTRFS_GC_TREE_OBJECTID,
+		.type = BTRFS_ROOT_ITEM_KEY,
+		.offset = btrfs_ino(inode) % fs_info->nr_global_roots,
+	};
+
+	return btrfs_global_root(fs_info, &key);
+}
+
+static int add_gc_item(struct btrfs_root *root, struct btrfs_key *key,
+		       struct btrfs_block_rsv *rsv)
+{
+	struct btrfs_path *path;
+	struct btrfs_trans_handle *trans;
+	int ret = 0;
+
+	path = btrfs_alloc_path();
+	if (!path)
+		return -ENOMEM;
+
+	trans = btrfs_gc_rsv_refill_and_join(root, rsv);
+	if (IS_ERR(trans)) {
+		ret = PTR_ERR(trans);
+		goto out;
+	}
+
+	trans->block_rsv = rsv;
+	ret = btrfs_insert_empty_item(trans, root, path, key, 0);
+	trans->block_rsv = &root->fs_info->trans_block_rsv;
+	btrfs_end_transaction(trans);
+out:
+	btrfs_free_path(path);
+	return ret;
+}
+
+static void delete_gc_item(struct btrfs_root *root, struct btrfs_path *path,
+			   struct btrfs_block_rsv *rsv, struct btrfs_key *key)
+{
+	struct btrfs_trans_handle *trans;
+	int ret;
+
+	trans = btrfs_gc_rsv_refill_and_join(root, rsv);
+	if (IS_ERR(trans))
+		return;
+
+	ret = btrfs_search_slot(trans, root, key, path, -1, 1);
+	if (ret > 0)
+		ret = -ENOENT;
+	if (ret < 0)
+		return;
+	btrfs_del_item(trans, root, path);
+	btrfs_release_path(path);
+	btrfs_end_transaction(trans);
+}
+
+static int gc_inode(struct btrfs_fs_info *fs_info, struct btrfs_block_rsv *rsv,
+		    struct btrfs_key *key)
+{
+	struct btrfs_root *root = btrfs_get_fs_root(fs_info, key->objectid, true);
+	struct btrfs_trans_handle *trans;
+	int ret = 0;
+
+	if (IS_ERR(root)) {
+		ret = PTR_ERR(root);
+
+		/* We are deleting this subvolume, just delete the GC item for it. */
+		if (ret == -ENOENT)
+			return 0;
+
+		btrfs_err(fs_info, "failed to look up root during gc %llu: %d",
+			  key->objectid, ret);
+		return ret;
+	}
+
+	do {
+		struct btrfs_truncate_control control = {
+			.ino = key->offset,
+			.new_size = 0,
+			.min_type = 0,
+		};
+
+		trans = btrfs_gc_rsv_refill_and_join(root, rsv);
+		if (IS_ERR(trans)) {
+			ret = PTR_ERR(trans);
+			break;
+		}
+
+		trans->block_rsv = rsv;
+
+		ret = btrfs_truncate_inode_items(trans, root, &control);
+
+		trans->block_rsv = &fs_info->trans_block_rsv;
+		btrfs_end_transaction(trans);
+		btrfs_btree_balance_dirty(fs_info);
+	} while (ret == -ENOSPC || ret == -EAGAIN);
+
+	btrfs_put_root(root);
+	return ret;
+}
+
+static void gc_work_fn(struct btrfs_work *work)
+{
+	struct gc_work *gc_work = container_of(work, struct gc_work, work);
+	struct btrfs_root *root = gc_work->root;
+	struct btrfs_fs_info *fs_info = root->fs_info;
+	struct btrfs_path *path;
+	struct btrfs_block_rsv *rsv;
+	int ret;
+
+	path = btrfs_alloc_path();
+	if (!path)
+		goto out;
+
+	rsv = btrfs_alloc_block_rsv(fs_info, BTRFS_BLOCK_RSV_TEMP);
+	if (!rsv)
+		goto out_path;
+	rsv->size = btrfs_calc_metadata_size(fs_info, 1);
+	rsv->failfast = 1;
+
+	while (btrfs_fs_closing(fs_info) &&
+	       !btrfs_first_item(root, path)) {
+		struct btrfs_key key;
+
+		btrfs_item_key_to_cpu(path->nodes[0], &key, path->slots[0]);
+		btrfs_release_path(path);
+
+		switch (key.type) {
+		case BTRFS_GC_INODE_ITEM_KEY:
+			ret = gc_inode(root->fs_info, rsv, &key);
+			break;
+		default:
+			ASSERT(0);
+			ret = -EINVAL;
+			break;
+		}
+
+		if (!ret)
+			delete_gc_item(root, path, rsv, &key);
+	}
+	btrfs_free_block_rsv(fs_info, rsv);
+out_path:
+	btrfs_free_path(path);
+out:
+	clear_bit(BTRFS_ROOT_GC_RUNNING, &root->state);
+	kfree(gc_work);
+}
+
+/**
+ * btrfs_queue_gc_work - queue work for non-empty GC roots.
+ * @fs_info: The fs_info for the file system.
+ *
+ * This walks through all of the garbage collection roots and schedules the
+ * work structs to chew through their work.
+ */
+void btrfs_queue_gc_work(struct btrfs_fs_info *fs_info)
+{
+	struct btrfs_root *root;
+	struct gc_work *gc_work;
+	struct btrfs_key key = {
+		.objectid = BTRFS_GC_TREE_OBJECTID,
+		.type = BTRFS_ROOT_ITEM_KEY,
+	};
+	int nr_global_roots = fs_info->nr_global_roots;
+	int i;
+
+	if (!btrfs_fs_incompat(fs_info, EXTENT_TREE_V2))
+		return;
+
+	if (btrfs_fs_closing(fs_info))
+		return;
+
+	for (i = 0; i < nr_global_roots; i++) {
+		key.offset = i;
+		root = btrfs_global_root(fs_info, &key);
+		if (test_and_set_bit(BTRFS_ROOT_GC_RUNNING, &root->state))
+			continue;
+		gc_work = kmalloc(sizeof(struct gc_work), GFP_KERNEL);
+		if (!gc_work) {
+			clear_bit(BTRFS_ROOT_GC_RUNNING, &root->state);
+			continue;
+		}
+		gc_work->root = root;
+		btrfs_init_work(&gc_work->work, gc_work_fn, NULL, NULL);
+		btrfs_queue_work(fs_info->gc_workers, &gc_work->work);
+	}
+}
+
+/**
+ * btrfs_add_inode_gc_item - add a gc item for an inode that needs to be removed.
+ * @inode: The inode that needs to have a gc item added.
+ * @rsv: The block rsv to use for the reservation.
+ *
+ * This adds the gc item for the given inode.  This must be called during evict
+ * to make sure nobody else is going to access this inode.
+ */
+int btrfs_add_inode_gc_item(struct btrfs_inode *inode,
+			    struct btrfs_block_rsv *rsv)
+{
+	struct btrfs_key key = {
+		.objectid = inode->root->root_key.objectid,
+		.type = BTRFS_GC_INODE_ITEM_KEY,
+		.offset = btrfs_ino(inode),
+	};
+
+	return add_gc_item(inode_gc_root(inode), &key, rsv);
+}
diff --git a/fs/btrfs/gc-tree.h b/fs/btrfs/gc-tree.h
new file mode 100644
index 000000000000..d744f45f8c8e
--- /dev/null
+++ b/fs/btrfs/gc-tree.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef BTRFS_GC_TREE_H
+#define BTRFS_GC_TREE_H
+
+struct btrfs_fs_info;
+struct btrfs_inode;
+struct btrfs_block_rsv;
+
+void btrfs_queue_gc_work(struct btrfs_fs_info *fs_info);
+int btrfs_add_inode_gc_item(struct btrfs_inode *inode,
+			    struct btrfs_block_rsv *rsv);
+
+#endif
+
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index cc4e077686c3..6fadf28608f1 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -55,6 +55,7 @@
 #include "zoned.h"
 #include "subpage.h"
 #include "inode-item.h"
+#include "gc-tree.h"
 
 struct btrfs_iget_args {
 	u64 ino;
@@ -5207,6 +5208,17 @@ void btrfs_evict_inode(struct inode *inode)
 	rsv->size = btrfs_calc_metadata_size(fs_info, 1);
 	rsv->failfast = 1;
 
+	/*
+	 * If we have extent tree v2 enabled, insert our gc item and we're done,
+	 * remove the orphan item if we succeeded.
+	 */
+	if (btrfs_fs_incompat(fs_info, EXTENT_TREE_V2)) {
+		ret = btrfs_add_inode_gc_item(BTRFS_I(inode), rsv);
+		if (ret)
+			goto free_rsv;
+		goto delete_orphan;
+	}
+
 	btrfs_i_size_write(BTRFS_I(inode), 0);
 
 	while (1) {
@@ -5242,6 +5254,7 @@ void btrfs_evict_inode(struct inode *inode)
 	 * If it turns out that we are dropping too many of these, we might want
 	 * to add a mechanism for retrying these after a commit.
 	 */
+delete_orphan:
 	trans = btrfs_gc_rsv_refill_and_join(root, rsv);
 	if (!IS_ERR(trans)) {
 		trans->block_rsv = rsv;
diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index 5a5a72a32e76..7742786ecdb4 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -22,6 +22,7 @@
 #include "block-group.h"
 #include "space-info.h"
 #include "zoned.h"
+#include "gc-tree.h"
 
 #define BTRFS_ROOT_TRANS_TAG 0
 
@@ -2420,6 +2421,8 @@ int btrfs_commit_transaction(struct btrfs_trans_handle *trans)
 	btrfs_put_transaction(cur_trans);
 	btrfs_put_transaction(cur_trans);
 
+	btrfs_queue_gc_work(fs_info);
+
 	if (trans->type & __TRANS_FREEZABLE)
 		sb_end_intwrite(fs_info->sb);
 
-- 
2.26.3

