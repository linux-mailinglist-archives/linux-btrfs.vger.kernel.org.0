Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2092C504BBF
	for <lists+linux-btrfs@lfdr.de>; Mon, 18 Apr 2022 06:43:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236514AbiDREqA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 18 Apr 2022 00:46:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236283AbiDREp7 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 18 Apr 2022 00:45:59 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A17FB17052
        for <linux-btrfs@vger.kernel.org>; Sun, 17 Apr 2022 21:43:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=07hNFD1fYyyocCmvLDqianVyuUGSE1yUKd42koT3oTs=; b=cVLaw1hFw50RtBQ/phsVwpb0i4
        PDcygKT81sVdeLTnavMWPputwcVB3ht3oLvwHlrWBi//jOJLs6io7MZgBu49QII0DSSOIMbcZ5E7S
        p8rErU+Y7Fsug5Gc4uhF8YXN7GWQBDSIL/qs57LIGOX14xlJJKL1kBduvYcdNtk1I9sq9LgKyrbTM
        MYkZHeJ6mZkoFFwISaBmYF8jttdrRdZxbfArpPP0RVREdxB8Tf6KBr4aLuugccuhE8G4ujkf9SiGZ
        9/4QKwwzZZW1B8+yHGXLcu6oK/ZpTFjvHW7qfoE5xBSBZZd5jo7zUGWOyhoW1VksqVIXPkxaIdrmS
        Cr+M6miA==;
Received: from [2a02:1205:504b:4280:f5dd:42a4:896c:d877] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ngJEL-00FYRA-Lt; Mon, 18 Apr 2022 04:43:18 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>
Cc:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Subject: [PATCH 1/3] btrfs: simplify WQ_HIGHPRI handling in struct btrfs_workqueue
Date:   Mon, 18 Apr 2022 06:43:09 +0200
Message-Id: <20220418044311.359720-2-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220418044311.359720-1-hch@lst.de>
References: <20220418044311.359720-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Just let the one callers that want optional WQ_HIGHPRI handling allocate
a separate btrfs_workqueue for that.  This allows to rename
struct __btrfs_workqueue to btrfs_workqueue, remove a pointer indirection
and separate allocation for all btrfs_workqueue users and generally
simplify the code.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/async-thread.c      | 123 +++++++----------------------------
 fs/btrfs/async-thread.h      |   7 +-
 fs/btrfs/ctree.h             |   1 +
 fs/btrfs/disk-io.c           |  14 ++--
 fs/btrfs/super.c             |   1 +
 include/trace/events/btrfs.h |  32 ++++-----
 6 files changed, 50 insertions(+), 128 deletions(-)

diff --git a/fs/btrfs/async-thread.c b/fs/btrfs/async-thread.c
index 43c89952b7d25..44e04059bbfc3 100644
--- a/fs/btrfs/async-thread.c
+++ b/fs/btrfs/async-thread.c
@@ -15,13 +15,12 @@
 enum {
 	WORK_DONE_BIT,
 	WORK_ORDER_DONE_BIT,
-	WORK_HIGH_PRIO_BIT,
 };
 
 #define NO_THRESHOLD (-1)
 #define DFT_THRESHOLD (32)
 
-struct __btrfs_workqueue {
+struct btrfs_workqueue {
 	struct workqueue_struct *normal_wq;
 
 	/* File system this workqueue services */
@@ -48,12 +47,7 @@ struct __btrfs_workqueue {
 	spinlock_t thres_lock;
 };
 
-struct btrfs_workqueue {
-	struct __btrfs_workqueue *normal;
-	struct __btrfs_workqueue *high;
-};
-
-struct btrfs_fs_info * __pure btrfs_workqueue_owner(const struct __btrfs_workqueue *wq)
+struct btrfs_fs_info * __pure btrfs_workqueue_owner(const struct btrfs_workqueue *wq)
 {
 	return wq->fs_info;
 }
@@ -66,22 +60,22 @@ struct btrfs_fs_info * __pure btrfs_work_owner(const struct btrfs_work *work)
 bool btrfs_workqueue_normal_congested(const struct btrfs_workqueue *wq)
 {
 	/*
-	 * We could compare wq->normal->pending with num_online_cpus()
+	 * We could compare wq->pending with num_online_cpus()
 	 * to support "thresh == NO_THRESHOLD" case, but it requires
 	 * moving up atomic_inc/dec in thresh_queue/exec_hook. Let's
 	 * postpone it until someone needs the support of that case.
 	 */
-	if (wq->normal->thresh == NO_THRESHOLD)
+	if (wq->thresh == NO_THRESHOLD)
 		return false;
 
-	return atomic_read(&wq->normal->pending) > wq->normal->thresh * 2;
+	return atomic_read(&wq->pending) > wq->thresh * 2;
 }
 
-static struct __btrfs_workqueue *
-__btrfs_alloc_workqueue(struct btrfs_fs_info *fs_info, const char *name,
-			unsigned int flags, int limit_active, int thresh)
+struct btrfs_workqueue *btrfs_alloc_workqueue(struct btrfs_fs_info *fs_info,
+		const char *name, unsigned int flags, int limit_active,
+		int thresh)
 {
-	struct __btrfs_workqueue *ret = kzalloc(sizeof(*ret), GFP_KERNEL);
+	struct btrfs_workqueue *ret = kzalloc(sizeof(*ret), GFP_KERNEL);
 
 	if (!ret)
 		return NULL;
@@ -105,12 +99,8 @@ __btrfs_alloc_workqueue(struct btrfs_fs_info *fs_info, const char *name,
 		ret->thresh = thresh;
 	}
 
-	if (flags & WQ_HIGHPRI)
-		ret->normal_wq = alloc_workqueue("btrfs-%s-high", flags,
-						 ret->current_active, name);
-	else
-		ret->normal_wq = alloc_workqueue("btrfs-%s", flags,
-						 ret->current_active, name);
+	ret->normal_wq = alloc_workqueue("btrfs-%s", flags, ret->current_active,
+					 name);
 	if (!ret->normal_wq) {
 		kfree(ret);
 		return NULL;
@@ -119,41 +109,7 @@ __btrfs_alloc_workqueue(struct btrfs_fs_info *fs_info, const char *name,
 	INIT_LIST_HEAD(&ret->ordered_list);
 	spin_lock_init(&ret->list_lock);
 	spin_lock_init(&ret->thres_lock);
-	trace_btrfs_workqueue_alloc(ret, name, flags & WQ_HIGHPRI);
-	return ret;
-}
-
-static inline void
-__btrfs_destroy_workqueue(struct __btrfs_workqueue *wq);
-
-struct btrfs_workqueue *btrfs_alloc_workqueue(struct btrfs_fs_info *fs_info,
-					      const char *name,
-					      unsigned int flags,
-					      int limit_active,
-					      int thresh)
-{
-	struct btrfs_workqueue *ret = kzalloc(sizeof(*ret), GFP_KERNEL);
-
-	if (!ret)
-		return NULL;
-
-	ret->normal = __btrfs_alloc_workqueue(fs_info, name,
-					      flags & ~WQ_HIGHPRI,
-					      limit_active, thresh);
-	if (!ret->normal) {
-		kfree(ret);
-		return NULL;
-	}
-
-	if (flags & WQ_HIGHPRI) {
-		ret->high = __btrfs_alloc_workqueue(fs_info, name, flags,
-						    limit_active, thresh);
-		if (!ret->high) {
-			__btrfs_destroy_workqueue(ret->normal);
-			kfree(ret);
-			return NULL;
-		}
-	}
+	trace_btrfs_workqueue_alloc(ret, name);
 	return ret;
 }
 
@@ -162,7 +118,7 @@ struct btrfs_workqueue *btrfs_alloc_workqueue(struct btrfs_fs_info *fs_info,
  * This hook WILL be called in IRQ handler context,
  * so workqueue_set_max_active MUST NOT be called in this hook
  */
-static inline void thresh_queue_hook(struct __btrfs_workqueue *wq)
+static inline void thresh_queue_hook(struct btrfs_workqueue *wq)
 {
 	if (wq->thresh == NO_THRESHOLD)
 		return;
@@ -174,7 +130,7 @@ static inline void thresh_queue_hook(struct __btrfs_workqueue *wq)
  * This hook is called in kthread content.
  * So workqueue_set_max_active is called here.
  */
-static inline void thresh_exec_hook(struct __btrfs_workqueue *wq)
+static inline void thresh_exec_hook(struct btrfs_workqueue *wq)
 {
 	int new_current_active;
 	long pending;
@@ -217,7 +173,7 @@ static inline void thresh_exec_hook(struct __btrfs_workqueue *wq)
 	}
 }
 
-static void run_ordered_work(struct __btrfs_workqueue *wq,
+static void run_ordered_work(struct btrfs_workqueue *wq,
 			     struct btrfs_work *self)
 {
 	struct list_head *list = &wq->ordered_list;
@@ -305,7 +261,7 @@ static void btrfs_work_helper(struct work_struct *normal_work)
 {
 	struct btrfs_work *work = container_of(normal_work, struct btrfs_work,
 					       normal_work);
-	struct __btrfs_workqueue *wq;
+	struct btrfs_workqueue *wq = work->wq;
 	int need_order = 0;
 
 	/*
@@ -318,7 +274,6 @@ static void btrfs_work_helper(struct work_struct *normal_work)
 	 */
 	if (work->ordered_func)
 		need_order = 1;
-	wq = work->wq;
 
 	trace_btrfs_work_sched(work);
 	thresh_exec_hook(wq);
@@ -350,8 +305,8 @@ void btrfs_init_work(struct btrfs_work *work, btrfs_func_t func,
 	work->flags = 0;
 }
 
-static inline void __btrfs_queue_work(struct __btrfs_workqueue *wq,
-				      struct btrfs_work *work)
+void btrfs_queue_work(struct btrfs_workqueue *wq,
+		      struct btrfs_work *work)
 {
 	unsigned long flags;
 
@@ -366,54 +321,22 @@ static inline void __btrfs_queue_work(struct __btrfs_workqueue *wq,
 	queue_work(wq->normal_wq, &work->normal_work);
 }
 
-void btrfs_queue_work(struct btrfs_workqueue *wq,
-		      struct btrfs_work *work)
-{
-	struct __btrfs_workqueue *dest_wq;
-
-	if (test_bit(WORK_HIGH_PRIO_BIT, &work->flags) && wq->high)
-		dest_wq = wq->high;
-	else
-		dest_wq = wq->normal;
-	__btrfs_queue_work(dest_wq, work);
-}
-
-static inline void
-__btrfs_destroy_workqueue(struct __btrfs_workqueue *wq)
-{
-	destroy_workqueue(wq->normal_wq);
-	trace_btrfs_workqueue_destroy(wq);
-	kfree(wq);
-}
-
 void btrfs_destroy_workqueue(struct btrfs_workqueue *wq)
 {
 	if (!wq)
 		return;
-	if (wq->high)
-		__btrfs_destroy_workqueue(wq->high);
-	__btrfs_destroy_workqueue(wq->normal);
+	destroy_workqueue(wq->normal_wq);
+	trace_btrfs_workqueue_destroy(wq);
 	kfree(wq);
 }
 
 void btrfs_workqueue_set_max(struct btrfs_workqueue *wq, int limit_active)
 {
-	if (!wq)
-		return;
-	wq->normal->limit_active = limit_active;
-	if (wq->high)
-		wq->high->limit_active = limit_active;
-}
-
-void btrfs_set_work_high_priority(struct btrfs_work *work)
-{
-	set_bit(WORK_HIGH_PRIO_BIT, &work->flags);
+	if (wq)
+		wq->limit_active = limit_active;
 }
 
 void btrfs_flush_workqueue(struct btrfs_workqueue *wq)
 {
-	if (wq->high)
-		flush_workqueue(wq->high->normal_wq);
-
-	flush_workqueue(wq->normal->normal_wq);
+	flush_workqueue(wq->normal_wq);
 }
diff --git a/fs/btrfs/async-thread.h b/fs/btrfs/async-thread.h
index 3204daa51b955..07960529b3601 100644
--- a/fs/btrfs/async-thread.h
+++ b/fs/btrfs/async-thread.h
@@ -11,8 +11,6 @@
 
 struct btrfs_fs_info;
 struct btrfs_workqueue;
-/* Internal use only */
-struct __btrfs_workqueue;
 struct btrfs_work;
 typedef void (*btrfs_func_t)(struct btrfs_work *arg);
 typedef void (*btrfs_work_func_t)(struct work_struct *arg);
@@ -25,7 +23,7 @@ struct btrfs_work {
 	/* Don't touch things below */
 	struct work_struct normal_work;
 	struct list_head ordered_list;
-	struct __btrfs_workqueue *wq;
+	struct btrfs_workqueue *wq;
 	unsigned long flags;
 };
 
@@ -40,9 +38,8 @@ void btrfs_queue_work(struct btrfs_workqueue *wq,
 		      struct btrfs_work *work);
 void btrfs_destroy_workqueue(struct btrfs_workqueue *wq);
 void btrfs_workqueue_set_max(struct btrfs_workqueue *wq, int max);
-void btrfs_set_work_high_priority(struct btrfs_work *work);
 struct btrfs_fs_info * __pure btrfs_work_owner(const struct btrfs_work *work);
-struct btrfs_fs_info * __pure btrfs_workqueue_owner(const struct __btrfs_workqueue *wq);
+struct btrfs_fs_info * __pure btrfs_workqueue_owner(const struct btrfs_workqueue *wq);
 bool btrfs_workqueue_normal_congested(const struct btrfs_workqueue *wq);
 void btrfs_flush_workqueue(struct btrfs_workqueue *wq);
 
diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 55dee124ee447..383aba168e1d2 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -847,6 +847,7 @@ struct btrfs_fs_info {
 	 * two
 	 */
 	struct btrfs_workqueue *workers;
+	struct btrfs_workqueue *hipri_workers;
 	struct btrfs_workqueue *delalloc_workers;
 	struct btrfs_workqueue *flush_workers;
 	struct btrfs_workqueue *endio_workers;
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 2689e85896272..980616cc08bfc 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -874,9 +874,9 @@ blk_status_t btrfs_wq_submit_bio(struct inode *inode, struct bio *bio,
 	async->status = 0;
 
 	if (op_is_sync(bio->bi_opf))
-		btrfs_set_work_high_priority(&async->work);
-
-	btrfs_queue_work(fs_info->workers, &async->work);
+		btrfs_queue_work(fs_info->hipri_workers, &async->work);
+	else
+		btrfs_queue_work(fs_info->workers, &async->work);
 	return 0;
 }
 
@@ -2286,6 +2286,7 @@ static void btrfs_stop_all_workers(struct btrfs_fs_info *fs_info)
 {
 	btrfs_destroy_workqueue(fs_info->fixup_workers);
 	btrfs_destroy_workqueue(fs_info->delalloc_workers);
+	btrfs_destroy_workqueue(fs_info->hipri_workers);
 	btrfs_destroy_workqueue(fs_info->workers);
 	btrfs_destroy_workqueue(fs_info->endio_workers);
 	btrfs_destroy_workqueue(fs_info->endio_raid56_workers);
@@ -2465,6 +2466,9 @@ static int btrfs_init_workqueues(struct btrfs_fs_info *fs_info)
 
 	fs_info->workers =
 		btrfs_alloc_workqueue(fs_info, "worker",
+				      flags, max_active, 16);
+	fs_info->hipri_workers =
+		btrfs_alloc_workqueue(fs_info, "worker-high",
 				      flags | WQ_HIGHPRI, max_active, 16);
 
 	fs_info->delalloc_workers =
@@ -2512,8 +2516,8 @@ static int btrfs_init_workqueues(struct btrfs_fs_info *fs_info)
 	fs_info->discard_ctl.discard_workers =
 		alloc_workqueue("btrfs_discard", WQ_UNBOUND | WQ_FREEZABLE, 1);
 
-	if (!(fs_info->workers && fs_info->delalloc_workers &&
-	      fs_info->flush_workers &&
+	if (!(fs_info->workers && fs_info->hipri_workers &&
+	      fs_info->delalloc_workers && fs_info->flush_workers &&
 	      fs_info->endio_workers && fs_info->endio_meta_workers &&
 	      fs_info->endio_meta_write_workers &&
 	      fs_info->endio_write_workers && fs_info->endio_raid56_workers &&
diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 206f44005c52a..2236024aca648 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -1903,6 +1903,7 @@ static void btrfs_resize_thread_pool(struct btrfs_fs_info *fs_info,
 	       old_pool_size, new_pool_size);
 
 	btrfs_workqueue_set_max(fs_info->workers, new_pool_size);
+	btrfs_workqueue_set_max(fs_info->hipri_workers, new_pool_size);
 	btrfs_workqueue_set_max(fs_info->delalloc_workers, new_pool_size);
 	btrfs_workqueue_set_max(fs_info->caching_workers, new_pool_size);
 	btrfs_workqueue_set_max(fs_info->endio_workers, new_pool_size);
diff --git a/include/trace/events/btrfs.h b/include/trace/events/btrfs.h
index f068ff30d6541..5cbc60b938535 100644
--- a/include/trace/events/btrfs.h
+++ b/include/trace/events/btrfs.h
@@ -24,7 +24,7 @@ struct btrfs_free_cluster;
 struct map_lookup;
 struct extent_buffer;
 struct btrfs_work;
-struct __btrfs_workqueue;
+struct btrfs_workqueue;
 struct btrfs_qgroup_extent_record;
 struct btrfs_qgroup;
 struct extent_io_tree;
@@ -1457,42 +1457,38 @@ DEFINE_EVENT(btrfs__work, btrfs_ordered_sched,
 	TP_ARGS(work)
 );
 
-DECLARE_EVENT_CLASS(btrfs__workqueue,
+DECLARE_EVENT_CLASS(btrfs_workqueue,
 
-	TP_PROTO(const struct __btrfs_workqueue *wq,
-		 const char *name, int high),
+	TP_PROTO(const struct btrfs_workqueue *wq,
+		 const char *name),
 
-	TP_ARGS(wq, name, high),
+	TP_ARGS(wq, name),
 
 	TP_STRUCT__entry_btrfs(
 		__field(	const void *,	wq			)
 		__string(	name,	name			)
-		__field(	int ,	high			)
 	),
 
 	TP_fast_assign_btrfs(btrfs_workqueue_owner(wq),
 		__entry->wq		= wq;
 		__assign_str(name, name);
-		__entry->high		= high;
 	),
 
-	TP_printk_btrfs("name=%s%s wq=%p", __get_str(name),
-		  __print_flags(__entry->high, "",
-				{(WQ_HIGHPRI),	"-high"}),
+	TP_printk_btrfs("name=%s wq=%p", __get_str(name),
 		  __entry->wq)
 );
 
-DEFINE_EVENT(btrfs__workqueue, btrfs_workqueue_alloc,
+DEFINE_EVENT(btrfs_workqueue, btrfs_workqueue_alloc,
 
-	TP_PROTO(const struct __btrfs_workqueue *wq,
-		 const char *name, int high),
+	TP_PROTO(const struct btrfs_workqueue *wq,
+		 const char *name),
 
-	TP_ARGS(wq, name, high)
+	TP_ARGS(wq, name)
 );
 
-DECLARE_EVENT_CLASS(btrfs__workqueue_done,
+DECLARE_EVENT_CLASS(btrfs_workqueue_done,
 
-	TP_PROTO(const struct __btrfs_workqueue *wq),
+	TP_PROTO(const struct btrfs_workqueue *wq),
 
 	TP_ARGS(wq),
 
@@ -1507,9 +1503,9 @@ DECLARE_EVENT_CLASS(btrfs__workqueue_done,
 	TP_printk_btrfs("wq=%p", __entry->wq)
 );
 
-DEFINE_EVENT(btrfs__workqueue_done, btrfs_workqueue_destroy,
+DEFINE_EVENT(btrfs_workqueue_done, btrfs_workqueue_destroy,
 
-	TP_PROTO(const struct __btrfs_workqueue *wq),
+	TP_PROTO(const struct btrfs_workqueue *wq),
 
 	TP_ARGS(wq)
 );
-- 
2.30.2

