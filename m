Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6199F6B9C5A
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 Mar 2023 17:59:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230210AbjCNQ73 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 14 Mar 2023 12:59:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229951AbjCNQ72 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 14 Mar 2023 12:59:28 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 060AB9E500
        for <linux-btrfs@vger.kernel.org>; Tue, 14 Mar 2023 09:59:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=SOtXqtua60yI6JwuTEN0td7rIeAQSfeuIKl98eWi70A=; b=vaS19mcRkqWi2ToN1RBjgbWJs9
        UeGTh9qRcPF3hiBbIrad18E8S9+FrOv4byR5pyAP8uPF7KHkiDIJEvCNg9TZhyaOaKqUkQhOyJPWh
        6G10n32bGc88UxUaupeW0TUqqiugExIzaVlW0qCmEcR46GTDxl+ZfKynGblutAOzzSY9GRaU8OQxK
        AmIseWoUay1ieOpclcHpN9pR9h1TA1Wyrwrt/7TUxRsqs1gqJi4V97tQ00K0TwhUmVxljQv9MpZ4W
        eSDDsLoAZJpeMoJIcsfza3Agj7VpbAxnpR5XiZ9cbRi0WKxAd+e1vFVyAkt8r5d8OlbbC9ZTn4JVi
        zU7QZ8kA==;
Received: from [2001:4bb8:182:2e36:91ea:d0e2:233a:8356] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pc7za-00Avlm-28;
        Tue, 14 Mar 2023 16:59:19 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Johannes Thumshirn <jth@kernel.org>, linux-btrfs@vger.kernel.org
Subject: [PATCH 01/10] btrfs: use a plain workqueue for ordered_extent processing
Date:   Tue, 14 Mar 2023 17:59:01 +0100
Message-Id: <20230314165910.373347-2-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230314165910.373347-1-hch@lst.de>
References: <20230314165910.373347-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The endio_write_workers and endio_freespace_workers workqueues don't use
any of the ordering features in the btrfs_workqueue, so switch them to
plain Linux workqueues.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/disk-io.c      | 16 ++++++++--------
 fs/btrfs/fs.h           |  4 ++--
 fs/btrfs/ordered-data.c |  8 ++++----
 fs/btrfs/ordered-data.h |  2 +-
 fs/btrfs/super.c        |  2 --
 5 files changed, 15 insertions(+), 17 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index bb864cf2eed60f..0889eb81e71a7d 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -1993,8 +1993,10 @@ static void btrfs_stop_all_workers(struct btrfs_fs_info *fs_info)
 		destroy_workqueue(fs_info->rmw_workers);
 	if (fs_info->compressed_write_workers)
 		destroy_workqueue(fs_info->compressed_write_workers);
-	btrfs_destroy_workqueue(fs_info->endio_write_workers);
-	btrfs_destroy_workqueue(fs_info->endio_freespace_worker);
+	if (fs_info->endio_write_workers)
+		destroy_workqueue(fs_info->endio_write_workers);
+	if (fs_info->endio_freespace_worker)
+		destroy_workqueue(fs_info->endio_freespace_worker);
 	btrfs_destroy_workqueue(fs_info->delayed_workers);
 	btrfs_destroy_workqueue(fs_info->caching_workers);
 	btrfs_destroy_workqueue(fs_info->flush_workers);
@@ -2204,13 +2206,11 @@ static int btrfs_init_workqueues(struct btrfs_fs_info *fs_info)
 		alloc_workqueue("btrfs-endio-meta", flags, max_active);
 	fs_info->rmw_workers = alloc_workqueue("btrfs-rmw", flags, max_active);
 	fs_info->endio_write_workers =
-		btrfs_alloc_workqueue(fs_info, "endio-write", flags,
-				      max_active, 2);
+		alloc_workqueue("btrfs-endio-write", flags, max_active);
 	fs_info->compressed_write_workers =
 		alloc_workqueue("btrfs-compressed-write", flags, max_active);
 	fs_info->endio_freespace_worker =
-		btrfs_alloc_workqueue(fs_info, "freespace-write", flags,
-				      max_active, 0);
+		alloc_workqueue("btrfs-freespace-write", flags, max_active);
 	fs_info->delayed_workers =
 		btrfs_alloc_workqueue(fs_info, "delayed-meta", flags,
 				      max_active, 0);
@@ -4536,9 +4536,9 @@ void __cold close_ctree(struct btrfs_fs_info *fs_info)
 	 * the final btrfs_put_ordered_extent() (which must happen at
 	 * btrfs_finish_ordered_io() when we are unmounting).
 	 */
-	btrfs_flush_workqueue(fs_info->endio_write_workers);
+	flush_workqueue(fs_info->endio_write_workers);
 	/* Ordered extents for free space inodes. */
-	btrfs_flush_workqueue(fs_info->endio_freespace_worker);
+	flush_workqueue(fs_info->endio_freespace_worker);
 	btrfs_run_delayed_iputs(fs_info);
 
 	cancel_work_sync(&fs_info->async_reclaim_work);
diff --git a/fs/btrfs/fs.h b/fs/btrfs/fs.h
index 20d554a0c2ac0d..276a17780f2b1b 100644
--- a/fs/btrfs/fs.h
+++ b/fs/btrfs/fs.h
@@ -542,8 +542,8 @@ struct btrfs_fs_info {
 	struct workqueue_struct *endio_meta_workers;
 	struct workqueue_struct *rmw_workers;
 	struct workqueue_struct *compressed_write_workers;
-	struct btrfs_workqueue *endio_write_workers;
-	struct btrfs_workqueue *endio_freespace_worker;
+	struct workqueue_struct *endio_write_workers;
+	struct workqueue_struct *endio_freespace_worker;
 	struct btrfs_workqueue *caching_workers;
 
 	/*
diff --git a/fs/btrfs/ordered-data.c b/fs/btrfs/ordered-data.c
index 1848d0d1a9c41e..23f496f0d7b776 100644
--- a/fs/btrfs/ordered-data.c
+++ b/fs/btrfs/ordered-data.c
@@ -303,7 +303,7 @@ void btrfs_add_ordered_sum(struct btrfs_ordered_extent *entry,
 	spin_unlock_irq(&tree->lock);
 }
 
-static void finish_ordered_fn(struct btrfs_work *work)
+static void finish_ordered_fn(struct work_struct *work)
 {
 	struct btrfs_ordered_extent *ordered_extent;
 
@@ -330,7 +330,7 @@ void btrfs_mark_ordered_io_finished(struct btrfs_inode *inode,
 {
 	struct btrfs_ordered_inode_tree *tree = &inode->ordered_tree;
 	struct btrfs_fs_info *fs_info = inode->root->fs_info;
-	struct btrfs_workqueue *wq;
+	struct workqueue_struct *wq;
 	struct rb_node *node;
 	struct btrfs_ordered_extent *entry = NULL;
 	unsigned long flags;
@@ -439,8 +439,8 @@ void btrfs_mark_ordered_io_finished(struct btrfs_inode *inode,
 			refcount_inc(&entry->refs);
 			trace_btrfs_ordered_extent_mark_finished(inode, entry);
 			spin_unlock_irqrestore(&tree->lock, flags);
-			btrfs_init_work(&entry->work, finish_ordered_fn, NULL, NULL);
-			btrfs_queue_work(wq, &entry->work);
+			INIT_WORK(&entry->work, finish_ordered_fn);
+			queue_work(wq, &entry->work);
 			spin_lock_irqsave(&tree->lock, flags);
 		}
 		cur += len;
diff --git a/fs/btrfs/ordered-data.h b/fs/btrfs/ordered-data.h
index 18007f9c00add8..b8a92f040458f0 100644
--- a/fs/btrfs/ordered-data.h
+++ b/fs/btrfs/ordered-data.h
@@ -146,7 +146,7 @@ struct btrfs_ordered_extent {
 	/* a per root list of all the pending ordered extents */
 	struct list_head root_extent_list;
 
-	struct btrfs_work work;
+	struct work_struct work;
 
 	struct completion completion;
 	struct btrfs_work flush_work;
diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index d8885966e801cd..065b4fab1ee011 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -1632,8 +1632,6 @@ static void btrfs_resize_thread_pool(struct btrfs_fs_info *fs_info,
 	btrfs_workqueue_set_max(fs_info->hipri_workers, new_pool_size);
 	btrfs_workqueue_set_max(fs_info->delalloc_workers, new_pool_size);
 	btrfs_workqueue_set_max(fs_info->caching_workers, new_pool_size);
-	btrfs_workqueue_set_max(fs_info->endio_write_workers, new_pool_size);
-	btrfs_workqueue_set_max(fs_info->endio_freespace_worker, new_pool_size);
 	btrfs_workqueue_set_max(fs_info->delayed_workers, new_pool_size);
 }
 
-- 
2.39.2

