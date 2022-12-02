Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68518640A9B
	for <lists+linux-btrfs@lfdr.de>; Fri,  2 Dec 2022 17:25:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233966AbiLBQZn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 2 Dec 2022 11:25:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234032AbiLBQZV (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 2 Dec 2022 11:25:21 -0500
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19BDA92FD7
        for <linux-btrfs@vger.kernel.org>; Fri,  2 Dec 2022 08:23:47 -0800 (PST)
Received: by mail-qt1-x834.google.com with SMTP id fz10so5832261qtb.3
        for <linux-btrfs@vger.kernel.org>; Fri, 02 Dec 2022 08:23:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gYRue2PSPyCdr3N5J0uM3L/k24/b+TS8eFiwp26Be00=;
        b=UqSeUGHqC4cdRRVYSQnAceEpwqoZhcVcVNW2cuhoisjclC4+vnivkX09Fkws77Lekw
         K0Zver8O4X2Q8QsRru4shRhLXb1k01Raea3f6A/vyEGCkgkqX3atDE/5iDtZRzDBtnIM
         5ffP6vQM0slbZBGFKdxxmRqRu1oWP212WpOwgZUA2Vo8l1dyo0zpwSO1D6DtddWXjB7J
         HQDkvOs7xb6hknLbzjKiPbLxrhfFefNxgYhiy/nRGb9z2V+vlnww4FK8XZ4mdQ3AW6jm
         5cMOmxxlv1xNAU3AU3NmBHNf8eoENJswkTfdqSw2Czes8nOCI2ahq192oj/5rIZfPogH
         GLuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gYRue2PSPyCdr3N5J0uM3L/k24/b+TS8eFiwp26Be00=;
        b=hGoufsI5559En11inU0n7F6iUgZFpgcR2HUkmLT785SZOCqr5o1lhzdDPaLB9ysbYv
         tafmVnUVM4U+b87THP0ZIXNLZ2yWoZ5PIbtdmLGKjHr0lrcQ+MnLMo84XGuMseImwSki
         xvopB0HHW+K8pKMPo8vOxbFSUCEv0wi+sAZXUn5tR3ZhivADYGhnVkDw0ITTr2FHNLoJ
         /84n+kbmVESu6jLBeFJce2AASzMFx0AE0WynQ/5Kstcgd/aAawAqUa98DKBdUYLPWT4x
         5Qv6QMW14TuVSOS0R1NNqDbIYqVBjhFmVFwnI56hoRRrxQx3zmj0zKnu6NIaY7SAZqcK
         y55Q==
X-Gm-Message-State: ANoB5plqkgVoF6qhC9+/CxcgYuqzAPIB0/KrJBMh439rhIPN9nIzAhkj
        WjR0jGS8jVaQnbfshew/Pp80mtjwCRk6xnM4
X-Google-Smtp-Source: AA0mqf7msikWr48o+dFAkLJgzCZEOIRIA2tn1IT2v5QNoOJB7rZWhVdtX6Ht3+IcSMeC/AwIUIKiBg==
X-Received: by 2002:a05:622a:1496:b0:3a5:7eb0:4962 with SMTP id t22-20020a05622a149600b003a57eb04962mr47603245qtx.525.1669998225780;
        Fri, 02 Dec 2022 08:23:45 -0800 (PST)
Received: from localhost (cpe-174-109-170-245.nc.res.rr.com. [174.109.170.245])
        by smtp.gmail.com with ESMTPSA id h4-20020a05620a400400b006fcb4e01345sm813243qko.24.2022.12.02.08.23.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Dec 2022 08:23:45 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v4 09/10] btrfs-progs: sync async-thread.[ch] from the kernel
Date:   Fri,  2 Dec 2022 11:23:31 -0500
Message-Id: <3a89c1b787a17b56e88ebbab857ae86edc37ea1a.1669998153.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1669998153.git.josef@toxicpanda.com>
References: <cover.1669998153.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We won't actually use the async code in progs, however we call the
helpers and such all over the normal code, so sync this into btrfs-progs
to make syncing other parts of the kernel easier.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 Makefile                     |   1 +
 common/internal.h            |   4 +
 kerncompat.h                 |  81 ++++++++-
 kernel-lib/bitops.h          |  12 ++
 kernel-lib/trace.h           |  29 +++
 kernel-shared/async-thread.c | 339 +++++++++++++++++++++++++++++++++++
 kernel-shared/async-thread.h |  46 +++++
 7 files changed, 511 insertions(+), 1 deletion(-)
 create mode 100644 kernel-lib/trace.h
 create mode 100644 kernel-shared/async-thread.c
 create mode 100644 kernel-shared/async-thread.h

diff --git a/Makefile b/Makefile
index 94599f8c..6ad85784 100644
--- a/Makefile
+++ b/Makefile
@@ -153,6 +153,7 @@ objects = \
 	kernel-lib/rbtree.o	\
 	kernel-lib/tables.o	\
 	kernel-shared/accessors.o	\
+	kernel-shared/async-thread.o	\
 	kernel-shared/backref.o \
 	kernel-shared/ctree.o	\
 	kernel-shared/delayed-ref.o	\
diff --git a/common/internal.h b/common/internal.h
index d5ea9986..81729964 100644
--- a/common/internal.h
+++ b/common/internal.h
@@ -39,4 +39,8 @@
 #define max_t(type,x,y) \
 	({ type __x = (x); type __y = (y); __x > __y ? __x: __y; })
 
+#define clamp_t(type, val, lo, hi) min_t(type, max_t(type, val, lo), hi)
+
+#define clamp_val(val, lo, hi) clamp_t(typeof(val), val, lo, hi)
+
 #endif
diff --git a/kerncompat.h b/kerncompat.h
index 3f9f2cbc..2863a88f 100644
--- a/kerncompat.h
+++ b/kerncompat.h
@@ -218,6 +218,28 @@ static inline int mutex_is_locked(struct mutex *m)
 	return (m->lock != 1);
 }
 
+static inline void spin_lock_init(spinlock_t *lock)
+{
+	lock->lock = 0;
+}
+
+static inline void spin_lock(spinlock_t *lock)
+{
+	lock->lock++;
+}
+
+static inline void spin_unlock(spinlock_t *lock)
+{
+	lock->lock--;
+}
+
+#define spin_lock_irqsave(_l, _f) do { _f = 0; spin_lock((_l)); } while (0)
+
+static inline void spin_unlock_irqrestore(spinlock_t *lock, unsigned long flags)
+{
+	spin_unlock(lock);
+}
+
 #define cond_resched()		do { } while (0)
 #define preempt_enable()	do { } while (0)
 #define preempt_disable()	do { } while (0)
@@ -540,6 +562,9 @@ do {									\
 	(x) = (val);							\
 } while (0)
 
+#define smp_rmb() do {} while (0)
+#define smp_mb__before_atomic() do {} while (0)
+
 typedef struct refcount_struct {
 	int refs;
 } refcount_t;
@@ -548,9 +573,18 @@ typedef u32 blk_status_t;
 typedef u32 blk_opf_t;
 typedef int atomic_t;
 
-struct work_struct {
+struct work_struct;
+typedef void (*work_func_t)(struct work_struct *work);
+
+struct workqueue_struct {
 };
 
+struct work_struct {
+	work_func_t func;
+};
+
+#define INIT_WORK(_w, _f) do { (_w)->func = (_f); } while (0)
+
 typedef struct wait_queue_head_s {
 } wait_queue_head_t;
 
@@ -566,6 +600,7 @@ struct va_format {
 #define __user
 #define __init
 #define __cold
+#define __pure
 
 #define __printf(a, b)                  __attribute__((__format__(printf, a, b)))
 
@@ -576,4 +611,48 @@ static inline bool sb_rdonly(struct super_block *sb)
 
 #define unlikely(cond) (cond)
 
+static inline void atomic_set(atomic_t *a, int val)
+{
+	*a = val;
+}
+
+static inline int atomic_read(const atomic_t *a)
+{
+	return *a;
+}
+
+static inline void atomic_inc(atomic_t *a)
+{
+	(*a)++;
+}
+
+static inline void atomic_dec(atomic_t *a)
+{
+	(*a)--;
+}
+
+static inline struct workqueue_struct *alloc_workqueue(const char *name,
+						       unsigned long flags,
+						       int max_active, ...)
+{
+	return (struct workqueue_struct *)5;
+}
+
+static inline void destroy_workqueue(struct workqueue_struct *wq)
+{
+}
+
+static inline void flush_workqueue(struct workqueue_struct *wq)
+{
+}
+
+static inline void workqueue_set_max_active(struct workqueue_struct *wq,
+					    int max_active)
+{
+}
+
+static inline void queue_work(struct workqueue_struct *wq, struct work_struct *work)
+{
+}
+
 #endif
diff --git a/kernel-lib/bitops.h b/kernel-lib/bitops.h
index e0b85215..b9bf3b38 100644
--- a/kernel-lib/bitops.h
+++ b/kernel-lib/bitops.h
@@ -12,6 +12,8 @@
 #define BITS_TO_LONGS(nr)       DIV_ROUND_UP(nr, BITS_PER_BYTE * sizeof(long))
 #define BITS_TO_U64(nr)         DIV_ROUND_UP(nr, BITS_PER_BYTE * sizeof(u64))
 #define BITS_TO_U32(nr)         DIV_ROUND_UP(nr, BITS_PER_BYTE * sizeof(u32))
+#define BIT_MASK(nr)            (1UL << ((nr) % BITS_PER_LONG))
+#define BIT_WORD(nr)            ((nr) / BITS_PER_LONG)
 
 #define for_each_set_bit(bit, addr, size) \
 	for ((bit) = find_first_bit((addr), (size));		\
@@ -34,6 +36,16 @@ static inline void clear_bit(int nr, unsigned long *addr)
 	addr[nr / BITS_PER_LONG] &= ~(1UL << (nr % BITS_PER_LONG));
 }
 
+static inline bool test_and_set_bit(unsigned long nr, unsigned long *addr)
+{
+	unsigned long mask = BIT_MASK(nr);
+	unsigned long *p = ((unsigned long *)addr) + BIT_WORD(nr);
+	unsigned long old = *p;
+
+	*p = old | mask;
+	return (old & mask) != 0;
+}
+
 /**
  * hweightN - returns the hamming weight of a N-bit word
  * @x: the word to weigh
diff --git a/kernel-lib/trace.h b/kernel-lib/trace.h
new file mode 100644
index 00000000..086bcd10
--- /dev/null
+++ b/kernel-lib/trace.h
@@ -0,0 +1,29 @@
+#ifndef __PROGS_TRACE_H__
+#define __PROGS_TRACE_H__
+
+static inline void trace_btrfs_workqueue_alloc(void *ret, const char *name)
+{
+}
+
+static inline void trace_btrfs_ordered_sched(struct btrfs_work *work)
+{
+}
+
+static inline void trace_btrfs_all_work_done(struct btrfs_fs_info *fs_info,
+					     struct btrfs_work *work)
+{
+}
+
+static inline void trace_btrfs_work_sched(struct btrfs_work *work)
+{
+}
+
+static inline void trace_btrfs_work_queued(struct btrfs_work *work)
+{
+}
+
+static inline void trace_btrfs_workqueue_destroy(void *wq)
+{
+}
+
+#endif /* __PROGS_TRACE_H__ */
diff --git a/kernel-shared/async-thread.c b/kernel-shared/async-thread.c
new file mode 100644
index 00000000..811668da
--- /dev/null
+++ b/kernel-shared/async-thread.c
@@ -0,0 +1,339 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2007 Oracle.  All rights reserved.
+ * Copyright (C) 2014 Fujitsu.  All rights reserved.
+ */
+
+#include "kerncompat.h"
+#include "async-thread.h"
+#include "ctree.h"
+#include "kernel-lib/trace.h"
+#include "kernel-lib/bitops.h"
+
+enum {
+	WORK_DONE_BIT,
+	WORK_ORDER_DONE_BIT,
+};
+
+#define NO_THRESHOLD (-1)
+#define DFT_THRESHOLD (32)
+
+struct btrfs_workqueue {
+	struct workqueue_struct *normal_wq;
+
+	/* File system this workqueue services */
+	struct btrfs_fs_info *fs_info;
+
+	/* List head pointing to ordered work list */
+	struct list_head ordered_list;
+
+	/* Spinlock for ordered_list */
+	spinlock_t list_lock;
+
+	/* Thresholding related variants */
+	atomic_t pending;
+
+	/* Up limit of concurrency workers */
+	int limit_active;
+
+	/* Current number of concurrency workers */
+	int current_active;
+
+	/* Threshold to change current_active */
+	int thresh;
+	unsigned int count;
+	spinlock_t thres_lock;
+};
+
+struct btrfs_fs_info * __pure btrfs_workqueue_owner(const struct btrfs_workqueue *wq)
+{
+	return wq->fs_info;
+}
+
+struct btrfs_fs_info * __pure btrfs_work_owner(const struct btrfs_work *work)
+{
+	return work->wq->fs_info;
+}
+
+bool btrfs_workqueue_normal_congested(const struct btrfs_workqueue *wq)
+{
+	/*
+	 * We could compare wq->pending with num_online_cpus()
+	 * to support "thresh == NO_THRESHOLD" case, but it requires
+	 * moving up atomic_inc/dec in thresh_queue/exec_hook. Let's
+	 * postpone it until someone needs the support of that case.
+	 */
+	if (wq->thresh == NO_THRESHOLD)
+		return false;
+
+	return atomic_read(&wq->pending) > wq->thresh * 2;
+}
+
+struct btrfs_workqueue *btrfs_alloc_workqueue(struct btrfs_fs_info *fs_info,
+					      const char *name, unsigned int flags,
+					      int limit_active, int thresh)
+{
+	struct btrfs_workqueue *ret = kzalloc(sizeof(*ret), GFP_KERNEL);
+
+	if (!ret)
+		return NULL;
+
+	ret->fs_info = fs_info;
+	ret->limit_active = limit_active;
+	atomic_set(&ret->pending, 0);
+	if (thresh == 0)
+		thresh = DFT_THRESHOLD;
+	/* For low threshold, disabling threshold is a better choice */
+	if (thresh < DFT_THRESHOLD) {
+		ret->current_active = limit_active;
+		ret->thresh = NO_THRESHOLD;
+	} else {
+		/*
+		 * For threshold-able wq, let its concurrency grow on demand.
+		 * Use minimal max_active at alloc time to reduce resource
+		 * usage.
+		 */
+		ret->current_active = 1;
+		ret->thresh = thresh;
+	}
+
+	ret->normal_wq = alloc_workqueue("btrfs-%s", flags, ret->current_active,
+					 name);
+	if (!ret->normal_wq) {
+		kfree(ret);
+		return NULL;
+	}
+
+	INIT_LIST_HEAD(&ret->ordered_list);
+	spin_lock_init(&ret->list_lock);
+	spin_lock_init(&ret->thres_lock);
+	trace_btrfs_workqueue_alloc(ret, name);
+	return ret;
+}
+
+/*
+ * Hook for threshold which will be called in btrfs_queue_work.
+ * This hook WILL be called in IRQ handler context,
+ * so workqueue_set_max_active MUST NOT be called in this hook
+ */
+static inline void thresh_queue_hook(struct btrfs_workqueue *wq)
+{
+	if (wq->thresh == NO_THRESHOLD)
+		return;
+	atomic_inc(&wq->pending);
+}
+
+/*
+ * Hook for threshold which will be called before executing the work,
+ * This hook is called in kthread content.
+ * So workqueue_set_max_active is called here.
+ */
+static inline void thresh_exec_hook(struct btrfs_workqueue *wq)
+{
+	int new_current_active;
+	long pending;
+	int need_change = 0;
+
+	if (wq->thresh == NO_THRESHOLD)
+		return;
+
+	atomic_dec(&wq->pending);
+	spin_lock(&wq->thres_lock);
+	/*
+	 * Use wq->count to limit the calling frequency of
+	 * workqueue_set_max_active.
+	 */
+	wq->count++;
+	wq->count %= (wq->thresh / 4);
+	if (!wq->count)
+		goto  out;
+	new_current_active = wq->current_active;
+
+	/*
+	 * pending may be changed later, but it's OK since we really
+	 * don't need it so accurate to calculate new_max_active.
+	 */
+	pending = atomic_read(&wq->pending);
+	if (pending > wq->thresh)
+		new_current_active++;
+	if (pending < wq->thresh / 2)
+		new_current_active--;
+	new_current_active = clamp_val(new_current_active, 1, wq->limit_active);
+	if (new_current_active != wq->current_active)  {
+		need_change = 1;
+		wq->current_active = new_current_active;
+	}
+out:
+	spin_unlock(&wq->thres_lock);
+
+	if (need_change) {
+		workqueue_set_max_active(wq->normal_wq, wq->current_active);
+	}
+}
+
+static void run_ordered_work(struct btrfs_workqueue *wq,
+			     struct btrfs_work *self)
+{
+	struct list_head *list = &wq->ordered_list;
+	struct btrfs_work *work;
+	spinlock_t *lock = &wq->list_lock;
+	unsigned long flags;
+	bool free_self = false;
+
+	while (1) {
+		spin_lock_irqsave(lock, flags);
+		if (list_empty(list))
+			break;
+		work = list_entry(list->next, struct btrfs_work,
+				  ordered_list);
+		if (!test_bit(WORK_DONE_BIT, &work->flags))
+			break;
+		/*
+		 * Orders all subsequent loads after reading WORK_DONE_BIT,
+		 * paired with the smp_mb__before_atomic in btrfs_work_helper
+		 * this guarantees that the ordered function will see all
+		 * updates from ordinary work function.
+		 */
+		smp_rmb();
+
+		/*
+		 * we are going to call the ordered done function, but
+		 * we leave the work item on the list as a barrier so
+		 * that later work items that are done don't have their
+		 * functions called before this one returns
+		 */
+		if (test_and_set_bit(WORK_ORDER_DONE_BIT, &work->flags))
+			break;
+		trace_btrfs_ordered_sched(work);
+		spin_unlock_irqrestore(lock, flags);
+		work->ordered_func(work);
+
+		/* now take the lock again and drop our item from the list */
+		spin_lock_irqsave(lock, flags);
+		list_del(&work->ordered_list);
+		spin_unlock_irqrestore(lock, flags);
+
+		if (work == self) {
+			/*
+			 * This is the work item that the worker is currently
+			 * executing.
+			 *
+			 * The kernel workqueue code guarantees non-reentrancy
+			 * of work items. I.e., if a work item with the same
+			 * address and work function is queued twice, the second
+			 * execution is blocked until the first one finishes. A
+			 * work item may be freed and recycled with the same
+			 * work function; the workqueue code assumes that the
+			 * original work item cannot depend on the recycled work
+			 * item in that case (see find_worker_executing_work()).
+			 *
+			 * Note that different types of Btrfs work can depend on
+			 * each other, and one type of work on one Btrfs
+			 * filesystem may even depend on the same type of work
+			 * on another Btrfs filesystem via, e.g., a loop device.
+			 * Therefore, we must not allow the current work item to
+			 * be recycled until we are really done, otherwise we
+			 * break the above assumption and can deadlock.
+			 */
+			free_self = true;
+		} else {
+			/*
+			 * We don't want to call the ordered free functions with
+			 * the lock held.
+			 */
+			work->ordered_free(work);
+			/* NB: work must not be dereferenced past this point. */
+			trace_btrfs_all_work_done(wq->fs_info, work);
+		}
+	}
+	spin_unlock_irqrestore(lock, flags);
+
+	if (free_self) {
+		self->ordered_free(self);
+		/* NB: self must not be dereferenced past this point. */
+		trace_btrfs_all_work_done(wq->fs_info, self);
+	}
+}
+
+static void btrfs_work_helper(struct work_struct *normal_work)
+{
+	struct btrfs_work *work = container_of(normal_work, struct btrfs_work,
+					       normal_work);
+	struct btrfs_workqueue *wq = work->wq;
+	int need_order = 0;
+
+	/*
+	 * We should not touch things inside work in the following cases:
+	 * 1) after work->func() if it has no ordered_free
+	 *    Since the struct is freed in work->func().
+	 * 2) after setting WORK_DONE_BIT
+	 *    The work may be freed in other threads almost instantly.
+	 * So we save the needed things here.
+	 */
+	if (work->ordered_func)
+		need_order = 1;
+
+	trace_btrfs_work_sched(work);
+	thresh_exec_hook(wq);
+	work->func(work);
+	if (need_order) {
+		/*
+		 * Ensures all memory accesses done in the work function are
+		 * ordered before setting the WORK_DONE_BIT. Ensuring the thread
+		 * which is going to executed the ordered work sees them.
+		 * Pairs with the smp_rmb in run_ordered_work.
+		 */
+		smp_mb__before_atomic();
+		set_bit(WORK_DONE_BIT, &work->flags);
+		run_ordered_work(wq, work);
+	} else {
+		/* NB: work must not be dereferenced past this point. */
+		trace_btrfs_all_work_done(wq->fs_info, work);
+	}
+}
+
+void btrfs_init_work(struct btrfs_work *work, btrfs_func_t func,
+		     btrfs_func_t ordered_func, btrfs_func_t ordered_free)
+{
+	work->func = func;
+	work->ordered_func = ordered_func;
+	work->ordered_free = ordered_free;
+	INIT_WORK(&work->normal_work, btrfs_work_helper);
+	INIT_LIST_HEAD(&work->ordered_list);
+	work->flags = 0;
+}
+
+void btrfs_queue_work(struct btrfs_workqueue *wq, struct btrfs_work *work)
+{
+	unsigned long flags;
+
+	work->wq = wq;
+	thresh_queue_hook(wq);
+	if (work->ordered_func) {
+		spin_lock_irqsave(&wq->list_lock, flags);
+		list_add_tail(&work->ordered_list, &wq->ordered_list);
+		spin_unlock_irqrestore(&wq->list_lock, flags);
+	}
+	trace_btrfs_work_queued(work);
+	queue_work(wq->normal_wq, &work->normal_work);
+}
+
+void btrfs_destroy_workqueue(struct btrfs_workqueue *wq)
+{
+	if (!wq)
+		return;
+	destroy_workqueue(wq->normal_wq);
+	trace_btrfs_workqueue_destroy(wq);
+	kfree(wq);
+}
+
+void btrfs_workqueue_set_max(struct btrfs_workqueue *wq, int limit_active)
+{
+	if (wq)
+		wq->limit_active = limit_active;
+}
+
+void btrfs_flush_workqueue(struct btrfs_workqueue *wq)
+{
+	flush_workqueue(wq->normal_wq);
+}
diff --git a/kernel-shared/async-thread.h b/kernel-shared/async-thread.h
new file mode 100644
index 00000000..90657605
--- /dev/null
+++ b/kernel-shared/async-thread.h
@@ -0,0 +1,46 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2007 Oracle.  All rights reserved.
+ * Copyright (C) 2014 Fujitsu.  All rights reserved.
+ */
+
+#ifndef BTRFS_ASYNC_THREAD_H
+#define BTRFS_ASYNC_THREAD_H
+
+#include "kerncompat.h"
+#include "kernel-lib/list.h"
+
+struct btrfs_fs_info;
+struct btrfs_workqueue;
+struct btrfs_work;
+typedef void (*btrfs_func_t)(struct btrfs_work *arg);
+
+struct btrfs_work {
+	btrfs_func_t func;
+	btrfs_func_t ordered_func;
+	btrfs_func_t ordered_free;
+
+	/* Don't touch things below */
+	struct work_struct normal_work;
+	struct list_head ordered_list;
+	struct btrfs_workqueue *wq;
+	unsigned long flags;
+};
+
+struct btrfs_workqueue *btrfs_alloc_workqueue(struct btrfs_fs_info *fs_info,
+					      const char *name,
+					      unsigned int flags,
+					      int limit_active,
+					      int thresh);
+void btrfs_init_work(struct btrfs_work *work, btrfs_func_t func,
+		     btrfs_func_t ordered_func, btrfs_func_t ordered_free);
+void btrfs_queue_work(struct btrfs_workqueue *wq,
+		      struct btrfs_work *work);
+void btrfs_destroy_workqueue(struct btrfs_workqueue *wq);
+void btrfs_workqueue_set_max(struct btrfs_workqueue *wq, int max);
+struct btrfs_fs_info * __pure btrfs_work_owner(const struct btrfs_work *work);
+struct btrfs_fs_info * __pure btrfs_workqueue_owner(const struct btrfs_workqueue *wq);
+bool btrfs_workqueue_normal_congested(const struct btrfs_workqueue *wq);
+void btrfs_flush_workqueue(struct btrfs_workqueue *wq);
+
+#endif
-- 
2.26.3

