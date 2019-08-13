Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 713568BFAA
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 Aug 2019 19:34:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726573AbfHMReW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 13 Aug 2019 13:34:22 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:33038 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726062AbfHMReW (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 13 Aug 2019 13:34:22 -0400
Received: by mail-pg1-f196.google.com with SMTP id n190so10801956pgn.0
        for <linux-btrfs@vger.kernel.org>; Tue, 13 Aug 2019 10:34:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EBYZ0qggoH9V0oDPFnxs4X/nCG5DMmVMdfVVKgtkCCs=;
        b=wwuMNSA3AOFCjStp/StIi/F8A9auy0zB3ZNli8dN0Y/Xn9qxfVgsmLEJ+VOwhcJTDm
         Myo3W9z36cBAv+cAGFODuqKyV5c/vZIZ2RhCS+h2znVJVFoRcuVRd9bwLhNJwyirtBv/
         0O6ShSkda7bSAse90aH6Iw6mhyNz8bx46158JJN+So7F4Lh3cPkU6dcb88zqDagbiJCi
         xuN1eiJc39BHkgfPXyytgq7AEzup24cbab+4yHuejrvbeVGKvjq4b4bYr/TVmUVCBIb3
         LC/Oj+IgnVH6SA1iQJvwwIHyxezYUNfi4xoSrlMZAq/JnANegG93fdvB1MTBTrrF7zXn
         mVNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EBYZ0qggoH9V0oDPFnxs4X/nCG5DMmVMdfVVKgtkCCs=;
        b=BoT8HLL0Jsqt4ajgSuiz/BI49J8hW3U9vteF+lKEL9tgbb/4p+nv9RSXuC9GPahx/E
         dvRq+sWnanV6l4GG1gA3x3gmy+e9+pSx3zxlPIhPgnfUsY0vcxRh+RJ9CXQGG4bb+qpm
         3qeswH/482TUbZ3C4mumYlofPIg4FtCOf0x6WNKNFvl4oxlaIVi0psIzeS4cRwdI6lyE
         c/QSZNuIrTrmh+mKlxmCb3+t8fu6QgSVCIGtZt7mB08ePvBhTtwRZT4Yds/CY3NrxfbP
         4XgGWlmvwmQnYZZx6TmdjWAyF31wfUDaCS3uaSwGS22ONVdUbzTXV3fhHJO192XUF3V5
         /kLg==
X-Gm-Message-State: APjAAAV7R3pkkBNsRe2VdD4w9r6j5dz6zrMyCoQ4DILNCQwJxaYDG7wu
        WJVlU5xc0UbMlARrqlsYT/MQneMPGcY=
X-Google-Smtp-Source: APXvYqyfOAJEpAZZXUtg6wB2jRFhvdiEPjmoAmyd8SIo4Ty5hX7lXD2jM+6rR3h1v3lXnMYCNw4bag==
X-Received: by 2002:a17:90a:28e4:: with SMTP id f91mr3136073pjd.99.1565717660479;
        Tue, 13 Aug 2019 10:34:20 -0700 (PDT)
Received: from vader.thefacebook.com ([2620:10d:c090:200::1:f9b5])
        by smtp.gmail.com with ESMTPSA id x17sm11076151pff.62.2019.08.13.10.34.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Aug 2019 10:34:19 -0700 (PDT)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-btrfs@vger.kernel.org
Cc:     kernel-team@fb.com, Nikolay Borisov <nborisov@suse.com>,
        Filipe Manana <fdmanana@suse.com>
Subject: [PATCH v2 1/2] Btrfs: get rid of unique workqueue helper functions
Date:   Tue, 13 Aug 2019 10:33:43 -0700
Message-Id: <afaf532af471dd1a8a1f4af9de570127529323b0.1565717248.git.osandov@fb.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <cover.1565717247.git.osandov@fb.com>
References: <cover.1565717247.git.osandov@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Omar Sandoval <osandov@fb.com>

Commit 9e0af2376434 ("Btrfs: fix task hang under heavy compressed
write") worked around the issue that a recycled work item could get a
false dependency on the original work item due to how the workqueue code
guarantees non-reentrancy. It did so by giving different work functions
to different types of work.

However, the fix in "Btrfs: fix workqueue deadlock on dependent
filesystems" is more complete, as it prevents a work item from being
recycled at all (except for a tiny window that the kernel workqueue code
handles for us). This fix obsoletes the previous fix, so we don't need
the unique helpers for correctness. The only other reason to keep them
would be so they show up in stack traces, but they always seem to be
optimized to a tail call, so they don't show up anyways. So, let's just
get rid of the extra indirection.

While we're here, rename normal_work_helper() to the more informative
btrfs_work_helper().

Reviewed-by: Nikolay Borisov <nborisov@suse.com>
Reviewed-by: Filipe Manana <fdmanana@suse.com>
Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 fs/btrfs/async-thread.c  | 58 +++++++++-------------------------------
 fs/btrfs/async-thread.h  | 33 ++---------------------
 fs/btrfs/block-group.c   |  3 +--
 fs/btrfs/delayed-inode.c |  4 +--
 fs/btrfs/disk-io.c       | 34 ++++++++---------------
 fs/btrfs/inode.c         | 36 ++++++++-----------------
 fs/btrfs/ordered-data.c  |  1 -
 fs/btrfs/qgroup.c        |  1 -
 fs/btrfs/raid56.c        |  5 ++--
 fs/btrfs/reada.c         |  3 +--
 fs/btrfs/scrub.c         | 14 +++++-----
 fs/btrfs/volumes.c       |  3 +--
 12 files changed, 50 insertions(+), 145 deletions(-)

diff --git a/fs/btrfs/async-thread.c b/fs/btrfs/async-thread.c
index 6b8ad4a1b568..d105d3df6fa6 100644
--- a/fs/btrfs/async-thread.c
+++ b/fs/btrfs/async-thread.c
@@ -53,16 +53,6 @@ struct btrfs_workqueue {
 	struct __btrfs_workqueue *high;
 };
 
-static void normal_work_helper(struct btrfs_work *work);
-
-#define BTRFS_WORK_HELPER(name)					\
-noinline_for_stack void btrfs_##name(struct work_struct *arg)		\
-{									\
-	struct btrfs_work *work = container_of(arg, struct btrfs_work,	\
-					       normal_work);		\
-	normal_work_helper(work);					\
-}
-
 struct btrfs_fs_info *
 btrfs_workqueue_owner(const struct __btrfs_workqueue *wq)
 {
@@ -89,29 +79,6 @@ bool btrfs_workqueue_normal_congested(const struct btrfs_workqueue *wq)
 	return atomic_read(&wq->normal->pending) > wq->normal->thresh * 2;
 }
 
-BTRFS_WORK_HELPER(worker_helper);
-BTRFS_WORK_HELPER(delalloc_helper);
-BTRFS_WORK_HELPER(flush_delalloc_helper);
-BTRFS_WORK_HELPER(cache_helper);
-BTRFS_WORK_HELPER(submit_helper);
-BTRFS_WORK_HELPER(fixup_helper);
-BTRFS_WORK_HELPER(endio_helper);
-BTRFS_WORK_HELPER(endio_meta_helper);
-BTRFS_WORK_HELPER(endio_meta_write_helper);
-BTRFS_WORK_HELPER(endio_raid56_helper);
-BTRFS_WORK_HELPER(endio_repair_helper);
-BTRFS_WORK_HELPER(rmw_helper);
-BTRFS_WORK_HELPER(endio_write_helper);
-BTRFS_WORK_HELPER(freespace_write_helper);
-BTRFS_WORK_HELPER(delayed_meta_helper);
-BTRFS_WORK_HELPER(readahead_helper);
-BTRFS_WORK_HELPER(qgroup_rescan_helper);
-BTRFS_WORK_HELPER(extent_refs_helper);
-BTRFS_WORK_HELPER(scrub_helper);
-BTRFS_WORK_HELPER(scrubwrc_helper);
-BTRFS_WORK_HELPER(scrubnc_helper);
-BTRFS_WORK_HELPER(scrubparity_helper);
-
 static struct __btrfs_workqueue *
 __btrfs_alloc_workqueue(struct btrfs_fs_info *fs_info, const char *name,
 			unsigned int flags, int limit_active, int thresh)
@@ -302,12 +269,13 @@ static void run_ordered_work(struct btrfs_work *self)
 			 * original work item cannot depend on the recycled work
 			 * item in that case (see find_worker_executing_work()).
 			 *
-			 * Note that the work of one Btrfs filesystem may depend
-			 * on the work of another Btrfs filesystem via, e.g., a
-			 * loop device. Therefore, we must not allow the current
-			 * work item to be recycled until we are really done,
-			 * otherwise we break the above assumption and can
-			 * deadlock.
+			 * Note that different types of Btrfs work can depend on
+			 * each other, and one type of work on one Btrfs
+			 * filesystem may even depend on the same type of work
+			 * on another Btrfs filesystem via, e.g., a loop device.
+			 * Therefore, we must not allow the current work item to
+			 * be recycled until we are really done, otherwise we
+			 * break the above assumption and can deadlock.
 			 */
 			free_self = true;
 		} else {
@@ -331,8 +299,10 @@ static void run_ordered_work(struct btrfs_work *self)
 	}
 }
 
-static void normal_work_helper(struct btrfs_work *work)
+static void btrfs_work_helper(struct work_struct *normal_work)
 {
+	struct btrfs_work *work = container_of(normal_work, struct btrfs_work,
+					       normal_work);
 	struct __btrfs_workqueue *wq;
 	void *wtag;
 	int need_order = 0;
@@ -362,15 +332,13 @@ static void normal_work_helper(struct btrfs_work *work)
 		trace_btrfs_all_work_done(wq->fs_info, wtag);
 }
 
-void btrfs_init_work(struct btrfs_work *work, btrfs_work_func_t uniq_func,
-		     btrfs_func_t func,
-		     btrfs_func_t ordered_func,
-		     btrfs_func_t ordered_free)
+void btrfs_init_work(struct btrfs_work *work, btrfs_func_t func,
+		     btrfs_func_t ordered_func, btrfs_func_t ordered_free)
 {
 	work->func = func;
 	work->ordered_func = ordered_func;
 	work->ordered_free = ordered_free;
-	INIT_WORK(&work->normal_work, uniq_func);
+	INIT_WORK(&work->normal_work, btrfs_work_helper);
 	INIT_LIST_HEAD(&work->ordered_list);
 	work->flags = 0;
 }
diff --git a/fs/btrfs/async-thread.h b/fs/btrfs/async-thread.h
index 7861c9feba5f..c5bf2b117c05 100644
--- a/fs/btrfs/async-thread.h
+++ b/fs/btrfs/async-thread.h
@@ -29,42 +29,13 @@ struct btrfs_work {
 	unsigned long flags;
 };
 
-#define BTRFS_WORK_HELPER_PROTO(name)					\
-void btrfs_##name(struct work_struct *arg)
-
-BTRFS_WORK_HELPER_PROTO(worker_helper);
-BTRFS_WORK_HELPER_PROTO(delalloc_helper);
-BTRFS_WORK_HELPER_PROTO(flush_delalloc_helper);
-BTRFS_WORK_HELPER_PROTO(cache_helper);
-BTRFS_WORK_HELPER_PROTO(submit_helper);
-BTRFS_WORK_HELPER_PROTO(fixup_helper);
-BTRFS_WORK_HELPER_PROTO(endio_helper);
-BTRFS_WORK_HELPER_PROTO(endio_meta_helper);
-BTRFS_WORK_HELPER_PROTO(endio_meta_write_helper);
-BTRFS_WORK_HELPER_PROTO(endio_raid56_helper);
-BTRFS_WORK_HELPER_PROTO(endio_repair_helper);
-BTRFS_WORK_HELPER_PROTO(rmw_helper);
-BTRFS_WORK_HELPER_PROTO(endio_write_helper);
-BTRFS_WORK_HELPER_PROTO(freespace_write_helper);
-BTRFS_WORK_HELPER_PROTO(delayed_meta_helper);
-BTRFS_WORK_HELPER_PROTO(readahead_helper);
-BTRFS_WORK_HELPER_PROTO(qgroup_rescan_helper);
-BTRFS_WORK_HELPER_PROTO(extent_refs_helper);
-BTRFS_WORK_HELPER_PROTO(scrub_helper);
-BTRFS_WORK_HELPER_PROTO(scrubwrc_helper);
-BTRFS_WORK_HELPER_PROTO(scrubnc_helper);
-BTRFS_WORK_HELPER_PROTO(scrubparity_helper);
-
-
 struct btrfs_workqueue *btrfs_alloc_workqueue(struct btrfs_fs_info *fs_info,
 					      const char *name,
 					      unsigned int flags,
 					      int limit_active,
 					      int thresh);
-void btrfs_init_work(struct btrfs_work *work, btrfs_work_func_t helper,
-		     btrfs_func_t func,
-		     btrfs_func_t ordered_func,
-		     btrfs_func_t ordered_free);
+void btrfs_init_work(struct btrfs_work *work, btrfs_func_t func,
+		     btrfs_func_t ordered_func, btrfs_func_t ordered_free);
 void btrfs_queue_work(struct btrfs_workqueue *wq,
 		      struct btrfs_work *work);
 void btrfs_destroy_workqueue(struct btrfs_workqueue *wq);
diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 262e62ef52a5..8c3a443a6a60 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -695,8 +695,7 @@ int btrfs_cache_block_group(struct btrfs_block_group_cache *cache,
 	caching_ctl->block_group = cache;
 	caching_ctl->progress = cache->key.objectid;
 	refcount_set(&caching_ctl->count, 1);
-	btrfs_init_work(&caching_ctl->work, btrfs_cache_helper,
-			caching_thread, NULL, NULL);
+	btrfs_init_work(&caching_ctl->work, caching_thread, NULL, NULL);
 
 	spin_lock(&cache->lock);
 	/*
diff --git a/fs/btrfs/delayed-inode.c b/fs/btrfs/delayed-inode.c
index 6858a05606dd..d7127ea375c1 100644
--- a/fs/btrfs/delayed-inode.c
+++ b/fs/btrfs/delayed-inode.c
@@ -1366,8 +1366,8 @@ static int btrfs_wq_run_delayed_node(struct btrfs_delayed_root *delayed_root,
 		return -ENOMEM;
 
 	async_work->delayed_root = delayed_root;
-	btrfs_init_work(&async_work->work, btrfs_delayed_meta_helper,
-			btrfs_async_run_delayed_root, NULL, NULL);
+	btrfs_init_work(&async_work->work, btrfs_async_run_delayed_root, NULL,
+			NULL);
 	async_work->nr = nr;
 
 	btrfs_queue_work(fs_info->delayed_workers, &async_work->work);
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 589405eeb80f..fa4b6c3b166d 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -696,43 +696,31 @@ static void end_workqueue_bio(struct bio *bio)
 	struct btrfs_end_io_wq *end_io_wq = bio->bi_private;
 	struct btrfs_fs_info *fs_info;
 	struct btrfs_workqueue *wq;
-	btrfs_work_func_t func;
 
 	fs_info = end_io_wq->info;
 	end_io_wq->status = bio->bi_status;
 
 	if (bio_op(bio) == REQ_OP_WRITE) {
-		if (end_io_wq->metadata == BTRFS_WQ_ENDIO_METADATA) {
+		if (end_io_wq->metadata == BTRFS_WQ_ENDIO_METADATA)
 			wq = fs_info->endio_meta_write_workers;
-			func = btrfs_endio_meta_write_helper;
-		} else if (end_io_wq->metadata == BTRFS_WQ_ENDIO_FREE_SPACE) {
+		else if (end_io_wq->metadata == BTRFS_WQ_ENDIO_FREE_SPACE)
 			wq = fs_info->endio_freespace_worker;
-			func = btrfs_freespace_write_helper;
-		} else if (end_io_wq->metadata == BTRFS_WQ_ENDIO_RAID56) {
+		else if (end_io_wq->metadata == BTRFS_WQ_ENDIO_RAID56)
 			wq = fs_info->endio_raid56_workers;
-			func = btrfs_endio_raid56_helper;
-		} else {
+		else
 			wq = fs_info->endio_write_workers;
-			func = btrfs_endio_write_helper;
-		}
 	} else {
-		if (unlikely(end_io_wq->metadata ==
-			     BTRFS_WQ_ENDIO_DIO_REPAIR)) {
+		if (unlikely(end_io_wq->metadata == BTRFS_WQ_ENDIO_DIO_REPAIR))
 			wq = fs_info->endio_repair_workers;
-			func = btrfs_endio_repair_helper;
-		} else if (end_io_wq->metadata == BTRFS_WQ_ENDIO_RAID56) {
+		else if (end_io_wq->metadata == BTRFS_WQ_ENDIO_RAID56)
 			wq = fs_info->endio_raid56_workers;
-			func = btrfs_endio_raid56_helper;
-		} else if (end_io_wq->metadata) {
+		else if (end_io_wq->metadata)
 			wq = fs_info->endio_meta_workers;
-			func = btrfs_endio_meta_helper;
-		} else {
+		else
 			wq = fs_info->endio_workers;
-			func = btrfs_endio_helper;
-		}
 	}
 
-	btrfs_init_work(&end_io_wq->work, func, end_workqueue_fn, NULL, NULL);
+	btrfs_init_work(&end_io_wq->work, end_workqueue_fn, NULL, NULL);
 	btrfs_queue_work(wq, &end_io_wq->work);
 }
 
@@ -825,8 +813,8 @@ blk_status_t btrfs_wq_submit_bio(struct btrfs_fs_info *fs_info, struct bio *bio,
 	async->mirror_num = mirror_num;
 	async->submit_bio_start = submit_bio_start;
 
-	btrfs_init_work(&async->work, btrfs_worker_helper, run_one_async_start,
-			run_one_async_done, run_one_async_free);
+	btrfs_init_work(&async->work, run_one_async_start, run_one_async_done,
+			run_one_async_free);
 
 	async->bio_offset = bio_offset;
 
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 612c25aac15c..1cd28df6a126 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -1253,10 +1253,8 @@ static int cow_file_range_async(struct inode *inode, struct page *locked_page,
 		async_chunk[i].write_flags = write_flags;
 		INIT_LIST_HEAD(&async_chunk[i].extents);
 
-		btrfs_init_work(&async_chunk[i].work,
-				btrfs_delalloc_helper,
-				async_cow_start, async_cow_submit,
-				async_cow_free);
+		btrfs_init_work(&async_chunk[i].work, async_cow_start,
+				async_cow_submit, async_cow_free);
 
 		nr_pages = DIV_ROUND_UP(cur_end - start, PAGE_SIZE);
 		atomic_add(nr_pages, &fs_info->async_delalloc_pages);
@@ -2196,8 +2194,7 @@ int btrfs_writepage_cow_fixup(struct page *page, u64 start, u64 end)
 
 	SetPageChecked(page);
 	get_page(page);
-	btrfs_init_work(&fixup->work, btrfs_fixup_helper,
-			btrfs_writepage_fixup_worker, NULL, NULL);
+	btrfs_init_work(&fixup->work, btrfs_writepage_fixup_worker, NULL, NULL);
 	fixup->page = page;
 	btrfs_queue_work(fs_info->fixup_workers, &fixup->work);
 	return -EBUSY;
@@ -3190,7 +3187,6 @@ void btrfs_writepage_endio_finish_ordered(struct page *page, u64 start,
 	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
 	struct btrfs_ordered_extent *ordered_extent = NULL;
 	struct btrfs_workqueue *wq;
-	btrfs_work_func_t func;
 
 	trace_btrfs_writepage_end_io_hook(page, start, end, uptodate);
 
@@ -3199,16 +3195,12 @@ void btrfs_writepage_endio_finish_ordered(struct page *page, u64 start,
 					    end - start + 1, uptodate))
 		return;
 
-	if (btrfs_is_free_space_inode(BTRFS_I(inode))) {
+	if (btrfs_is_free_space_inode(BTRFS_I(inode)))
 		wq = fs_info->endio_freespace_worker;
-		func = btrfs_freespace_write_helper;
-	} else {
+	else
 		wq = fs_info->endio_write_workers;
-		func = btrfs_endio_write_helper;
-	}
 
-	btrfs_init_work(&ordered_extent->work, func, finish_ordered_fn, NULL,
-			NULL);
+	btrfs_init_work(&ordered_extent->work, finish_ordered_fn, NULL, NULL);
 	btrfs_queue_work(wq, &ordered_extent->work);
 }
 
@@ -8159,18 +8151,14 @@ static void __endio_write_update_ordered(struct inode *inode,
 	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
 	struct btrfs_ordered_extent *ordered = NULL;
 	struct btrfs_workqueue *wq;
-	btrfs_work_func_t func;
 	u64 ordered_offset = offset;
 	u64 ordered_bytes = bytes;
 	u64 last_offset;
 
-	if (btrfs_is_free_space_inode(BTRFS_I(inode))) {
+	if (btrfs_is_free_space_inode(BTRFS_I(inode)))
 		wq = fs_info->endio_freespace_worker;
-		func = btrfs_freespace_write_helper;
-	} else {
+	else
 		wq = fs_info->endio_write_workers;
-		func = btrfs_endio_write_helper;
-	}
 
 	while (ordered_offset < offset + bytes) {
 		last_offset = ordered_offset;
@@ -8178,9 +8166,8 @@ static void __endio_write_update_ordered(struct inode *inode,
 							   &ordered_offset,
 							   ordered_bytes,
 							   uptodate)) {
-			btrfs_init_work(&ordered->work, func,
-					finish_ordered_fn,
-					NULL, NULL);
+			btrfs_init_work(&ordered->work, finish_ordered_fn, NULL,
+					NULL);
 			btrfs_queue_work(wq, &ordered->work);
 		}
 		/*
@@ -10045,8 +10032,7 @@ static struct btrfs_delalloc_work *btrfs_alloc_delalloc_work(struct inode *inode
 	init_completion(&work->completion);
 	INIT_LIST_HEAD(&work->list);
 	work->inode = inode;
-	btrfs_init_work(&work->work, btrfs_flush_delalloc_helper,
-			btrfs_run_delalloc_work, NULL, NULL);
+	btrfs_init_work(&work->work, btrfs_run_delalloc_work, NULL, NULL);
 
 	return work;
 }
diff --git a/fs/btrfs/ordered-data.c b/fs/btrfs/ordered-data.c
index ae7f64a8facb..779a5dfa5324 100644
--- a/fs/btrfs/ordered-data.c
+++ b/fs/btrfs/ordered-data.c
@@ -546,7 +546,6 @@ u64 btrfs_wait_ordered_extents(struct btrfs_root *root, u64 nr,
 		spin_unlock(&root->ordered_extent_lock);
 
 		btrfs_init_work(&ordered->flush_work,
-				btrfs_flush_delalloc_helper,
 				btrfs_run_ordered_extent_work, NULL, NULL);
 		list_add_tail(&ordered->work_list, &works);
 		btrfs_queue_work(fs_info->flush_workers, &ordered->flush_work);
diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
index 8d3bd799ac7d..cfe45320293e 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -3275,7 +3275,6 @@ qgroup_rescan_init(struct btrfs_fs_info *fs_info, u64 progress_objectid,
 	memset(&fs_info->qgroup_rescan_work, 0,
 	       sizeof(fs_info->qgroup_rescan_work));
 	btrfs_init_work(&fs_info->qgroup_rescan_work,
-			btrfs_qgroup_rescan_helper,
 			btrfs_qgroup_rescan_worker, NULL, NULL);
 	return 0;
 }
diff --git a/fs/btrfs/raid56.c b/fs/btrfs/raid56.c
index f3d0576dd327..16c8af21b3fb 100644
--- a/fs/btrfs/raid56.c
+++ b/fs/btrfs/raid56.c
@@ -174,7 +174,7 @@ static void scrub_parity_work(struct btrfs_work *work);
 
 static void start_async_work(struct btrfs_raid_bio *rbio, btrfs_func_t work_func)
 {
-	btrfs_init_work(&rbio->work, btrfs_rmw_helper, work_func, NULL, NULL);
+	btrfs_init_work(&rbio->work, work_func, NULL, NULL);
 	btrfs_queue_work(rbio->fs_info->rmw_workers, &rbio->work);
 }
 
@@ -1727,8 +1727,7 @@ static void btrfs_raid_unplug(struct blk_plug_cb *cb, bool from_schedule)
 	plug = container_of(cb, struct btrfs_plug_cb, cb);
 
 	if (from_schedule) {
-		btrfs_init_work(&plug->work, btrfs_rmw_helper,
-				unplug_work, NULL, NULL);
+		btrfs_init_work(&plug->work, unplug_work, NULL, NULL);
 		btrfs_queue_work(plug->info->rmw_workers,
 				 &plug->work);
 		return;
diff --git a/fs/btrfs/reada.c b/fs/btrfs/reada.c
index 0b034c494355..719a6165fadb 100644
--- a/fs/btrfs/reada.c
+++ b/fs/btrfs/reada.c
@@ -792,8 +792,7 @@ static void reada_start_machine(struct btrfs_fs_info *fs_info)
 		/* FIXME we cannot handle this properly right now */
 		BUG();
 	}
-	btrfs_init_work(&rmw->work, btrfs_readahead_helper,
-			reada_start_machine_worker, NULL, NULL);
+	btrfs_init_work(&rmw->work, reada_start_machine_worker, NULL, NULL);
 	rmw->fs_info = fs_info;
 
 	btrfs_queue_work(fs_info->readahead_workers, &rmw->work);
diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index f7d4e03f4c5d..00b4ab8236b4 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -598,8 +598,8 @@ static noinline_for_stack struct scrub_ctx *scrub_setup_ctx(
 		sbio->index = i;
 		sbio->sctx = sctx;
 		sbio->page_count = 0;
-		btrfs_init_work(&sbio->work, btrfs_scrub_helper,
-				scrub_bio_end_io_worker, NULL, NULL);
+		btrfs_init_work(&sbio->work, scrub_bio_end_io_worker, NULL,
+				NULL);
 
 		if (i != SCRUB_BIOS_PER_SCTX - 1)
 			sctx->bios[i]->next_free = i + 1;
@@ -1720,8 +1720,7 @@ static void scrub_wr_bio_end_io(struct bio *bio)
 	sbio->status = bio->bi_status;
 	sbio->bio = bio;
 
-	btrfs_init_work(&sbio->work, btrfs_scrubwrc_helper,
-			 scrub_wr_bio_end_io_worker, NULL, NULL);
+	btrfs_init_work(&sbio->work, scrub_wr_bio_end_io_worker, NULL, NULL);
 	btrfs_queue_work(fs_info->scrub_wr_completion_workers, &sbio->work);
 }
 
@@ -2204,8 +2203,7 @@ static void scrub_missing_raid56_pages(struct scrub_block *sblock)
 		raid56_add_scrub_pages(rbio, spage->page, spage->logical);
 	}
 
-	btrfs_init_work(&sblock->work, btrfs_scrub_helper,
-			scrub_missing_raid56_worker, NULL, NULL);
+	btrfs_init_work(&sblock->work, scrub_missing_raid56_worker, NULL, NULL);
 	scrub_block_get(sblock);
 	scrub_pending_bio_inc(sctx);
 	raid56_submit_missing_rbio(rbio);
@@ -2743,8 +2741,8 @@ static void scrub_parity_bio_endio(struct bio *bio)
 
 	bio_put(bio);
 
-	btrfs_init_work(&sparity->work, btrfs_scrubparity_helper,
-			scrub_parity_bio_endio_worker, NULL, NULL);
+	btrfs_init_work(&sparity->work, scrub_parity_bio_endio_worker, NULL,
+			NULL);
 	btrfs_queue_work(fs_info->scrub_parity_workers, &sparity->work);
 }
 
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index fa6eb9e0ba89..9b684adad81c 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -6656,8 +6656,7 @@ struct btrfs_device *btrfs_alloc_device(struct btrfs_fs_info *fs_info,
 	else
 		generate_random_uuid(dev->uuid);
 
-	btrfs_init_work(&dev->work, btrfs_submit_helper,
-			pending_bios_fn, NULL, NULL);
+	btrfs_init_work(&dev->work, pending_bios_fn, NULL, NULL);
 
 	return dev;
 }
-- 
2.22.0

