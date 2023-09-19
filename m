Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45E9E7A693E
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Sep 2023 18:56:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231775AbjISQ4K (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 19 Sep 2023 12:56:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231651AbjISQ4J (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 19 Sep 2023 12:56:09 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FB228E
        for <linux-btrfs@vger.kernel.org>; Tue, 19 Sep 2023 09:56:02 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 2FED61FF1F;
        Tue, 19 Sep 2023 16:56:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1695142561; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=8ULR1s3o0T7rD+4EsbNftebaJ9DrcvE6EKygAyy3rGw=;
        b=hY7ErIgr0chZmVH5gdKVfd6RWS++LvVbBuLNCfdg9pV18cfE+XeKWBdfCXCnbxnt/ry8j3
        0/hs1QhmlcB7lXCWKA5Xx0l1TZFVxloR+EL2aKmMuwJQ2URaagJz3geEOGdlhN4FwJkDdu
        w8apGAbWWzCkYvqg1UIk4+DhkGi4z3g=
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 0FB7F2C142;
        Tue, 19 Sep 2023 16:56:01 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 11CF8DA7D7; Tue, 19 Sep 2023 18:49:26 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH] btrfs: merge ordered work callbacks in btrfs_work into one
Date:   Tue, 19 Sep 2023 18:49:23 +0200
Message-ID: <20230919164923.10172-1-dsterba@suse.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

There are two callbacks defined in btrfs_work but only two actually make
use of them, otherwise there are NULLs. We can get rid of the freeing
callback making it a special case of the normal work. This reduces the
size of btrfs_work by 8 bytes, final layout:

struct btrfs_work {
        btrfs_func_t               func;                 /*     0     8 */
        btrfs_ordered_func_t       ordered_func;         /*     8     8 */
        struct work_struct         normal_work;          /*    16    32 */
        struct list_head           ordered_list;         /*    48    16 */
        /* --- cacheline 1 boundary (64 bytes) --- */
        struct btrfs_workqueue *   wq;                   /*    64     8 */
        long unsigned int          flags;                /*    72     8 */

        /* size: 80, cachelines: 2, members: 6 */
        /* last cacheline: 16 bytes */
};

This in turn reduces size of other structures (on a release config):

- async_chunk			 160 ->  152
- async_submit_bio		 152 ->  144
- btrfs_async_delayed_work	 104 ->   96
- btrfs_caching_control		 176 ->  168
- btrfs_delalloc_work		 144 ->  136
- btrfs_fs_info			3608 -> 3600
- btrfs_ordered_extent		 440 ->  424
- btrfs_writepage_fixup		 104 ->   96

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/async-thread.c      | 11 +++++-----
 fs/btrfs/async-thread.h      |  6 +++---
 fs/btrfs/bio.c               | 17 ++++++++-------
 fs/btrfs/block-group.c       |  2 +-
 fs/btrfs/delayed-inode.c     |  3 +--
 fs/btrfs/inode.c             | 41 +++++++++++++++++++-----------------
 fs/btrfs/ordered-data.c      |  4 ++--
 fs/btrfs/qgroup.c            |  2 +-
 include/trace/events/btrfs.h |  7 ++----
 9 files changed, 46 insertions(+), 47 deletions(-)

diff --git a/fs/btrfs/async-thread.c b/fs/btrfs/async-thread.c
index 714ca74b66bf..9e261aac671e 100644
--- a/fs/btrfs/async-thread.c
+++ b/fs/btrfs/async-thread.c
@@ -243,7 +243,7 @@ static void run_ordered_work(struct btrfs_workqueue *wq,
 			break;
 		trace_btrfs_ordered_sched(work);
 		spin_unlock_irqrestore(lock, flags);
-		work->ordered_func(work);
+		work->ordered_func(work, false);
 
 		/* now take the lock again and drop our item from the list */
 		spin_lock_irqsave(lock, flags);
@@ -278,7 +278,7 @@ static void run_ordered_work(struct btrfs_workqueue *wq,
 			 * We don't want to call the ordered free functions with
 			 * the lock held.
 			 */
-			work->ordered_free(work);
+			work->ordered_func(work, true);
 			/* NB: work must not be dereferenced past this point. */
 			trace_btrfs_all_work_done(wq->fs_info, work);
 		}
@@ -286,7 +286,7 @@ static void run_ordered_work(struct btrfs_workqueue *wq,
 	spin_unlock_irqrestore(lock, flags);
 
 	if (free_self) {
-		self->ordered_free(self);
+		self->ordered_func(self, true);
 		/* NB: self must not be dereferenced past this point. */
 		trace_btrfs_all_work_done(wq->fs_info, self);
 	}
@@ -301,7 +301,7 @@ static void btrfs_work_helper(struct work_struct *normal_work)
 
 	/*
 	 * We should not touch things inside work in the following cases:
-	 * 1) after work->func() if it has no ordered_free
+	 * 1) after work->func() if it has no ordered_func(..., true) to free
 	 *    Since the struct is freed in work->func().
 	 * 2) after setting WORK_DONE_BIT
 	 *    The work may be freed in other threads almost instantly.
@@ -330,11 +330,10 @@ static void btrfs_work_helper(struct work_struct *normal_work)
 }
 
 void btrfs_init_work(struct btrfs_work *work, btrfs_func_t func,
-		     btrfs_func_t ordered_func, btrfs_func_t ordered_free)
+		     btrfs_ordered_func_t ordered_func)
 {
 	work->func = func;
 	work->ordered_func = ordered_func;
-	work->ordered_free = ordered_free;
 	INIT_WORK(&work->normal_work, btrfs_work_helper);
 	INIT_LIST_HEAD(&work->ordered_list);
 	work->flags = 0;
diff --git a/fs/btrfs/async-thread.h b/fs/btrfs/async-thread.h
index 30f66c5e2e6e..62b8a0d57898 100644
--- a/fs/btrfs/async-thread.h
+++ b/fs/btrfs/async-thread.h
@@ -13,11 +13,11 @@ struct btrfs_fs_info;
 struct btrfs_workqueue;
 struct btrfs_work;
 typedef void (*btrfs_func_t)(struct btrfs_work *arg);
+typedef void (*btrfs_ordered_func_t)(struct btrfs_work *arg, bool);
 
 struct btrfs_work {
 	btrfs_func_t func;
-	btrfs_func_t ordered_func;
-	btrfs_func_t ordered_free;
+	btrfs_ordered_func_t ordered_func;
 
 	/* Don't touch things below */
 	struct work_struct normal_work;
@@ -35,7 +35,7 @@ struct btrfs_workqueue *btrfs_alloc_ordered_workqueue(
 				struct btrfs_fs_info *fs_info, const char *name,
 				unsigned int flags);
 void btrfs_init_work(struct btrfs_work *work, btrfs_func_t func,
-		     btrfs_func_t ordered_func, btrfs_func_t ordered_free);
+		     btrfs_ordered_func_t ordered_func);
 void btrfs_queue_work(struct btrfs_workqueue *wq,
 		      struct btrfs_work *work);
 void btrfs_destroy_workqueue(struct btrfs_workqueue *wq);
diff --git a/fs/btrfs/bio.c b/fs/btrfs/bio.c
index ab7ee090b606..4f3b693a16b1 100644
--- a/fs/btrfs/bio.c
+++ b/fs/btrfs/bio.c
@@ -574,13 +574,20 @@ static void run_one_async_start(struct btrfs_work *work)
  *
  * At IO completion time the csums attached on the ordered extent record are
  * inserted into the tree.
+ *
+ * If called with @do_free == true, then it will free the work struct.
  */
-static void run_one_async_done(struct btrfs_work *work)
+static void run_one_async_done(struct btrfs_work *work, bool do_free)
 {
 	struct async_submit_bio *async =
 		container_of(work, struct async_submit_bio, work);
 	struct bio *bio = &async->bbio->bio;
 
+	if (do_free) {
+		kfree(container_of(work, struct async_submit_bio, work));
+		return;
+	}
+
 	/* If an error occurred we just want to clean up the bio and move on. */
 	if (bio->bi_status) {
 		btrfs_orig_bbio_end_io(async->bbio);
@@ -596,11 +603,6 @@ static void run_one_async_done(struct btrfs_work *work)
 	__btrfs_submit_bio(bio, async->bioc, &async->smap, async->mirror_num);
 }
 
-static void run_one_async_free(struct btrfs_work *work)
-{
-	kfree(container_of(work, struct async_submit_bio, work));
-}
-
 static bool should_async_write(struct btrfs_bio *bbio)
 {
 	/* Submit synchronously if the checksum implementation is fast. */
@@ -642,8 +644,7 @@ static bool btrfs_wq_submit_bio(struct btrfs_bio *bbio,
 	async->smap = *smap;
 	async->mirror_num = mirror_num;
 
-	btrfs_init_work(&async->work, run_one_async_start, run_one_async_done,
-			run_one_async_free);
+	btrfs_init_work(&async->work, run_one_async_start, run_one_async_done);
 	btrfs_queue_work(fs_info->workers, &async->work);
 	return true;
 }
diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 72dbfb410e42..2b9aaeefaf76 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -935,7 +935,7 @@ int btrfs_cache_block_group(struct btrfs_block_group *cache, bool wait)
 	caching_ctl->block_group = cache;
 	refcount_set(&caching_ctl->count, 2);
 	atomic_set(&caching_ctl->progress, 0);
-	btrfs_init_work(&caching_ctl->work, caching_thread, NULL, NULL);
+	btrfs_init_work(&caching_ctl->work, caching_thread, NULL);
 
 	spin_lock(&cache->lock);
 	if (cache->cached != BTRFS_CACHE_NO) {
diff --git a/fs/btrfs/delayed-inode.c b/fs/btrfs/delayed-inode.c
index 3609709e424a..8ba045ae1d75 100644
--- a/fs/btrfs/delayed-inode.c
+++ b/fs/btrfs/delayed-inode.c
@@ -1379,8 +1379,7 @@ static int btrfs_wq_run_delayed_node(struct btrfs_delayed_root *delayed_root,
 		return -ENOMEM;
 
 	async_work->delayed_root = delayed_root;
-	btrfs_init_work(&async_work->work, btrfs_async_run_delayed_root, NULL,
-			NULL);
+	btrfs_init_work(&async_work->work, btrfs_async_run_delayed_root, NULL);
 	async_work->nr = nr;
 
 	btrfs_queue_work(fs_info->delayed_workers, &async_work->work);
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index b5e0ed3a36f7..514d2e8a4f52 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -1566,8 +1566,11 @@ static noinline int cow_file_range(struct btrfs_inode *inode,
  * Phase two of compressed writeback.  This is the ordered portion of the code,
  * which only gets called in the order the work was queued.  We walk all the
  * async extents created by compress_file_range and send them down to the disk.
+ *
+ * If called with @do_free == true then it'll try to finish the work and free
+ * the work struct eventually.
  */
-static noinline void submit_compressed_extents(struct btrfs_work *work)
+static noinline void submit_compressed_extents(struct btrfs_work *work, bool do_free)
 {
 	struct async_chunk *async_chunk = container_of(work, struct async_chunk,
 						     work);
@@ -1576,6 +1579,21 @@ static noinline void submit_compressed_extents(struct btrfs_work *work)
 	unsigned long nr_pages;
 	u64 alloc_hint = 0;
 
+	if (do_free) {
+		struct async_chunk *async_chunk;
+		struct async_cow *async_cow;
+
+		async_chunk = container_of(work, struct async_chunk, work);
+		btrfs_add_delayed_iput(async_chunk->inode);
+		if (async_chunk->blkcg_css)
+			css_put(async_chunk->blkcg_css);
+
+		async_cow = async_chunk->async_cow;
+		if (atomic_dec_and_test(&async_cow->num_chunks))
+			kvfree(async_cow);
+		return;
+	}
+
 	nr_pages = (async_chunk->end - async_chunk->start + PAGE_SIZE) >>
 		PAGE_SHIFT;
 
@@ -1592,21 +1610,6 @@ static noinline void submit_compressed_extents(struct btrfs_work *work)
 		cond_wake_up_nomb(&fs_info->async_submit_wait);
 }
 
-static noinline void async_cow_free(struct btrfs_work *work)
-{
-	struct async_chunk *async_chunk;
-	struct async_cow *async_cow;
-
-	async_chunk = container_of(work, struct async_chunk, work);
-	btrfs_add_delayed_iput(async_chunk->inode);
-	if (async_chunk->blkcg_css)
-		css_put(async_chunk->blkcg_css);
-
-	async_cow = async_chunk->async_cow;
-	if (atomic_dec_and_test(&async_cow->num_chunks))
-		kvfree(async_cow);
-}
-
 static bool run_delalloc_compressed(struct btrfs_inode *inode,
 				    struct page *locked_page, u64 start,
 				    u64 end, struct writeback_control *wbc)
@@ -1684,7 +1687,7 @@ static bool run_delalloc_compressed(struct btrfs_inode *inode,
 		}
 
 		btrfs_init_work(&async_chunk[i].work, compress_file_range,
-				submit_compressed_extents, async_cow_free);
+				submit_compressed_extents);
 
 		nr_pages = DIV_ROUND_UP(cur_end - start, PAGE_SIZE);
 		atomic_add(nr_pages, &fs_info->async_delalloc_pages);
@@ -2848,7 +2851,7 @@ int btrfs_writepage_cow_fixup(struct page *page)
 	ihold(inode);
 	btrfs_page_set_checked(fs_info, page, page_offset(page), PAGE_SIZE);
 	get_page(page);
-	btrfs_init_work(&fixup->work, btrfs_writepage_fixup_worker, NULL, NULL);
+	btrfs_init_work(&fixup->work, btrfs_writepage_fixup_worker, NULL);
 	fixup->page = page;
 	fixup->inode = BTRFS_I(inode);
 	btrfs_queue_work(fs_info->fixup_workers, &fixup->work);
@@ -9215,7 +9218,7 @@ static struct btrfs_delalloc_work *btrfs_alloc_delalloc_work(struct inode *inode
 	init_completion(&work->completion);
 	INIT_LIST_HEAD(&work->list);
 	work->inode = inode;
-	btrfs_init_work(&work->work, btrfs_run_delalloc_work, NULL, NULL);
+	btrfs_init_work(&work->work, btrfs_run_delalloc_work, NULL);
 
 	return work;
 }
diff --git a/fs/btrfs/ordered-data.c b/fs/btrfs/ordered-data.c
index 55c7d5543265..b133ea0bc459 100644
--- a/fs/btrfs/ordered-data.c
+++ b/fs/btrfs/ordered-data.c
@@ -365,7 +365,7 @@ static void btrfs_queue_ordered_fn(struct btrfs_ordered_extent *ordered)
 	struct btrfs_workqueue *wq = btrfs_is_free_space_inode(inode) ?
 		fs_info->endio_freespace_worker : fs_info->endio_write_workers;
 
-	btrfs_init_work(&ordered->work, finish_ordered_fn, NULL, NULL);
+	btrfs_init_work(&ordered->work, finish_ordered_fn, NULL);
 	btrfs_queue_work(wq, &ordered->work);
 }
 
@@ -712,7 +712,7 @@ u64 btrfs_wait_ordered_extents(struct btrfs_root *root, u64 nr,
 		spin_unlock(&root->ordered_extent_lock);
 
 		btrfs_init_work(&ordered->flush_work,
-				btrfs_run_ordered_extent_work, NULL, NULL);
+				btrfs_run_ordered_extent_work, NULL);
 		list_add_tail(&ordered->work_list, &works);
 		btrfs_queue_work(fs_info->flush_workers, &ordered->flush_work);
 
diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
index ae7e2d79209f..07716332603b 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -3583,7 +3583,7 @@ qgroup_rescan_init(struct btrfs_fs_info *fs_info, u64 progress_objectid,
 	mutex_unlock(&fs_info->qgroup_rescan_lock);
 
 	btrfs_init_work(&fs_info->qgroup_rescan_work,
-			btrfs_qgroup_rescan_worker, NULL, NULL);
+			btrfs_qgroup_rescan_worker, NULL);
 	return 0;
 }
 
diff --git a/include/trace/events/btrfs.h b/include/trace/events/btrfs.h
index 638412ab090d..279a7a0c90c0 100644
--- a/include/trace/events/btrfs.h
+++ b/include/trace/events/btrfs.h
@@ -1561,7 +1561,6 @@ DECLARE_EVENT_CLASS(btrfs__work,
 		__field(	const void *,	wq			)
 		__field(	const void *,	func			)
 		__field(	const void *,	ordered_func		)
-		__field(	const void *,	ordered_free		)
 		__field(	const void *,	normal_work		)
 	),
 
@@ -1570,14 +1569,12 @@ DECLARE_EVENT_CLASS(btrfs__work,
 		__entry->wq		= work->wq;
 		__entry->func		= work->func;
 		__entry->ordered_func	= work->ordered_func;
-		__entry->ordered_free	= work->ordered_free;
 		__entry->normal_work	= &work->normal_work;
 	),
 
-	TP_printk_btrfs("work=%p (normal_work=%p) wq=%p func=%ps ordered_func=%p "
-		  "ordered_free=%p",
+	TP_printk_btrfs("work=%p (normal_work=%p) wq=%p func=%ps ordered_func=%p",
 		  __entry->work, __entry->normal_work, __entry->wq,
-		   __entry->func, __entry->ordered_func, __entry->ordered_free)
+		   __entry->func, __entry->ordered_func)
 );
 
 /*
-- 
2.41.0

