Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2EE024C275
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Aug 2020 17:47:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729289AbgHTPrK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 20 Aug 2020 11:47:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729308AbgHTPqh (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 20 Aug 2020 11:46:37 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26A3EC061385
        for <linux-btrfs@vger.kernel.org>; Thu, 20 Aug 2020 08:46:37 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id t23so1510005qto.3
        for <linux-btrfs@vger.kernel.org>; Thu, 20 Aug 2020 08:46:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=HqkyoUC2cQHJ075Ujjc9kOQLxnbLAJ3oCdzUJOmuyt8=;
        b=PXfBjsMvqkc62m4aZF3rDeiETgmtKmoSbrmSOT5KWU7M/9gyQ+xiDb7TxjQCGTAHGI
         ENsdf5AHaWbYQJoHCQ4W4vN3NUKOyOG0jzSIY6VF1H53En33oy3RI4wio3hwNMQumvhY
         Hl0vlx6Pm2ZJvoBIWMI02n4f9jrW9fqGukIE9tm+fwSOAmPut1QKELimF90isXX72g+K
         7dg/wPKo1Z2kmc3P9Y4nHd+5vZd4br2/SJkW+2z3NeFDjgACiBYNsBA1bxw3UA1iJsNy
         zOB9qG2eukAxd+rckwDzLfF22V1CSHWRf6Zh8LmHE2Pz+2VTgPaRVe92NOkgY1OmWk4e
         Xm2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HqkyoUC2cQHJ075Ujjc9kOQLxnbLAJ3oCdzUJOmuyt8=;
        b=mRMkmb/t4HC0xEaHg0vESNUT2qIy10ee0WYKWhoODG/qJFW5G8fbJt6tasQU2jtFjR
         WhUn4YMIWRf3o4OLpWCoAeu+oN4Wps83AFGfEzG3ESWhMhLBCkq//QAZ6yVQh/u2LeiV
         SLlI3LpEiqsijkJLIOAnrPm8+Gd6ROaYpNSi6bWBzs5J9TKcaGN3HLTBcM9xAVHvqTxy
         u9zfDBoMDAvsc39e+v4uFsy9KyFlWshwpbVeYsKNxv9B83nYspNPqw8qnEX3ihakhP7Y
         3cqzV6x0MvEeyp2wSizKDWl7h0P+7Uq80IhRHTZn7/hv7ALwSueonZmQbKYBD5sSvj9K
         DldQ==
X-Gm-Message-State: AOAM531oWXTFA9uvwQSDKzjseFemCHhMEcR0k5F9Fr/xIvqgux2IPc8c
        qKwX2Uj3d+e2oWW6Cbk8KwAxx575fxRajxD1
X-Google-Smtp-Source: ABdhPJwhbrxL5fHQVHwZ9brsySYkGbOPiGGWwW5a6Pm73wWYSgnc5HBuQlTYUvzPDgh8DPESkbSAFw==
X-Received: by 2002:ac8:3ae5:: with SMTP id x92mr3193570qte.139.1597938395344;
        Thu, 20 Aug 2020 08:46:35 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id m30sm3453407qtm.46.2020.08.20.08.46.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2020 08:46:34 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 10/12] btrfs: change our extent buffer lock to a rw_semaphore
Date:   Thu, 20 Aug 2020 11:46:09 -0400
Message-Id: <a34e67a2b1804ff57e488e685fcfe32acea7daed.1597938191.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <cover.1597938190.git.josef@toxicpanda.com>
References: <cover.1597938190.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Historically we've implemented our own locking because we wanted to be
able to selectively spin or sleep based on what we were doing in the
tree.  For instance, if all of our nodes were in cache then there's
rarely a reason to need to sleep waiting for node locks, as they'll
likely become available soon.  At the time this code was written the
rw_semaphore didn't do adaptive spinning, and thus was orders of
magnitude slower than our home grown locking.

However now the opposite is the case.  There are a few problems with how
we implement blocking locks, namely that we use a normal waitqueue and
simply wake everybody up in reverse sleep order.  This leads to some
suboptimal performance behavior, and a lot of context switches in highly
contended cases.  rw_semaphores actually do this properly, and also have
adaptive spinning that works relatively well.

The locking code is also a bit of a bear to understand, and we lose the
benefit of lockdep for the most part because the blocking states of the
lock are simply ad-hoc and not mapped into lockdep.

So rework the locking code to drop all of this custom locking stuff, and
simply use a rw_semaphore for everything.  This makes the locking much
simpler for everything, as we can now drop a lot of cruft and blocking
transitions.  The performance numbers vary depending on the workload,
because generally speaking there doesn't tend to be a lot of contention
on the btree.  However on my test system which is an 80 core single
socket system with 256gib of RAM and a 2tib NVME drive I get the
following results (with all debug options off)

dbench 200 baseline
Throughput 216.056 MB/sec  200 clients  200 procs  max_latency=1471.197 ms

dbench 200 with patch
Throughput 737.188 MB/sec  200 clients  200 procs  max_latency=714.346 ms

Previously we also used fs_mark to test this sort of contention, and
those results are far less impressive, mostly because there's not enough
tasks to really stress the locking

fs_mark -d /d[0-15] -S 0 -L 20 -n 100000 -s 0 -t 16

baseline
  verage Files/sec:     160166.7
  p50 Files/sec: 165832
  p90 Files/sec: 123886
  p99 Files/sec: 123495

  real    3m26.527s
  user    2m19.223s
  sys     48m21.856s

patched
  Average Files/sec:     164135.7
  p50 Files/sec: 171095
  p90 Files/sec: 122889
  p99 Files/sec: 113819

  real    3m29.660s
  user    2m19.990s
  sys     44m12.259s

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/extent_io.c  |  13 +-
 fs/btrfs/extent_io.h  |  21 +--
 fs/btrfs/locking.c    | 378 +++++++-----------------------------------
 fs/btrfs/locking.h    |   2 +-
 fs/btrfs/print-tree.c |  11 +-
 5 files changed, 67 insertions(+), 358 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 35a095ed694a..bd0c7e728ca2 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -4987,12 +4987,8 @@ __alloc_extent_buffer(struct btrfs_fs_info *fs_info, u64 start,
 	eb->len = len;
 	eb->fs_info = fs_info;
 	eb->bflags = 0;
-	rwlock_init(&eb->lock);
-	atomic_set(&eb->blocking_readers, 0);
-	eb->blocking_writers = 0;
+	init_rwsem(&eb->lock);
 	eb->lock_recursed = false;
-	init_waitqueue_head(&eb->write_lock_wq);
-	init_waitqueue_head(&eb->read_lock_wq);
 
 	btrfs_leak_debug_add(&fs_info->eb_leak_lock, &eb->leak_list,
 			     &fs_info->allocated_ebs);
@@ -5008,13 +5004,6 @@ __alloc_extent_buffer(struct btrfs_fs_info *fs_info, u64 start,
 		> MAX_INLINE_EXTENT_BUFFER_SIZE);
 	BUG_ON(len > MAX_INLINE_EXTENT_BUFFER_SIZE);
 
-#ifdef CONFIG_BTRFS_DEBUG
-	eb->spinning_writers = 0;
-	atomic_set(&eb->spinning_readers, 0);
-	atomic_set(&eb->read_locks, 0);
-	eb->write_locks = 0;
-#endif
-
 	return eb;
 }
 
diff --git a/fs/btrfs/extent_io.h b/fs/btrfs/extent_io.h
index 9e1e22f1586a..3f5dcc982fb8 100644
--- a/fs/btrfs/extent_io.h
+++ b/fs/btrfs/extent_io.h
@@ -99,31 +99,14 @@ struct extent_buffer {
 	int read_mirror;
 	struct rcu_head rcu_head;
 	pid_t lock_owner;
-
-	int blocking_writers;
-	atomic_t blocking_readers;
 	bool lock_recursed;
+	struct rw_semaphore lock;
+
 	/* >= 0 if eb belongs to a log tree, -1 otherwise */
 	short log_index;
 
-	/* protects write locks */
-	rwlock_t lock;
-
-	/* readers use lock_wq while they wait for the write
-	 * lock holders to unlock
-	 */
-	wait_queue_head_t write_lock_wq;
-
-	/* writers use read_lock_wq while they wait for readers
-	 * to unlock
-	 */
-	wait_queue_head_t read_lock_wq;
 	struct page *pages[INLINE_EXTENT_BUFFER_PAGES];
 #ifdef CONFIG_BTRFS_DEBUG
-	int spinning_writers;
-	atomic_t spinning_readers;
-	atomic_t read_locks;
-	int write_locks;
 	struct list_head leak_list;
 #endif
 };
diff --git a/fs/btrfs/locking.c b/fs/btrfs/locking.c
index 133a6dd5f29b..fa2f50241693 100644
--- a/fs/btrfs/locking.c
+++ b/fs/btrfs/locking.c
@@ -17,45 +17,8 @@
  * Extent buffer locking
  * =====================
  *
- * The locks use a custom scheme that allows to do more operations than are
- * available fromt current locking primitives. The building blocks are still
- * rwlock and wait queues.
- *
- * Required semantics:
- *
- * - reader/writer exclusion
- * - writer/writer exclusion
- * - reader/reader sharing
- * - spinning lock semantics
- * - blocking lock semantics
- * - try-lock semantics for readers and writers
- * - one level nesting, allowing read lock to be taken by the same thread that
- *   already has write lock
- *
- * The extent buffer locks (also called tree locks) manage access to eb data
- * related to the storage in the b-tree (keys, items, but not the individual
- * members of eb).
- * We want concurrency of many readers and safe updates. The underlying locking
- * is done by read-write spinlock and the blocking part is implemented using
- * counters and wait queues.
- *
- * spinning semantics - the low-level rwlock is held so all other threads that
- *                      want to take it are spinning on it.
- *
- * blocking semantics - the low-level rwlock is not held but the counter
- *                      denotes how many times the blocking lock was held;
- *                      sleeping is possible
- *
- * Write lock always allows only one thread to access the data.
- *
- *
- * Debugging
- * ---------
- *
- * There are additional state counters that are asserted in various contexts,
- * removed from non-debug build to reduce extent_buffer size and for
- * performance reasons.
- *
+ * We currently use a rw_semaphore for the tree locking, and the semantics are
+ * exactly the same.  The only exception is recursion, which is described below.
  *
  * Lock recursion
  * ------------
@@ -75,115 +38,8 @@
  *           btrfs_lookup_file_extent
  *             btrfs_search_slot
  *
- *
- * Locking pattern - spinning
- * --------------------------
- *
- * The simple locking scenario, the +--+ denotes the spinning section.
- *
- * +- btrfs_tree_lock
- * | - extent_buffer::rwlock is held
- * | - no heavy operations should happen, eg. IO, memory allocations, large
- * |   structure traversals
- * +- btrfs_tree_unock
-*
-*
- * Locking pattern - blocking
- * --------------------------
- *
- * The blocking write uses the following scheme.  The +--+ denotes the spinning
- * section.
- *
- * +- btrfs_tree_lock
- * |
- * +- btrfs_set_lock_blocking_write
- *
- *   - allowed: IO, memory allocations, etc.
- *
- * -- btrfs_tree_unlock - note, no explicit unblocking necessary
- *
- *
- * Blocking read is similar.
- *
- * +- btrfs_tree_read_lock
- * |
- * +- btrfs_set_lock_blocking_read
- *
- *  - heavy operations allowed
- *
- * +- btrfs_tree_read_unlock_blocking
- * |
- * +- btrfs_tree_read_unlock
- *
  */
 
-#ifdef CONFIG_BTRFS_DEBUG
-static inline void btrfs_assert_spinning_writers_get(struct extent_buffer *eb)
-{
-	WARN_ON(eb->spinning_writers);
-	eb->spinning_writers++;
-}
-
-static inline void btrfs_assert_spinning_writers_put(struct extent_buffer *eb)
-{
-	WARN_ON(eb->spinning_writers != 1);
-	eb->spinning_writers--;
-}
-
-static inline void btrfs_assert_no_spinning_writers(struct extent_buffer *eb)
-{
-	WARN_ON(eb->spinning_writers);
-}
-
-static inline void btrfs_assert_spinning_readers_get(struct extent_buffer *eb)
-{
-	atomic_inc(&eb->spinning_readers);
-}
-
-static inline void btrfs_assert_spinning_readers_put(struct extent_buffer *eb)
-{
-	WARN_ON(atomic_read(&eb->spinning_readers) == 0);
-	atomic_dec(&eb->spinning_readers);
-}
-
-static inline void btrfs_assert_tree_read_locks_get(struct extent_buffer *eb)
-{
-	atomic_inc(&eb->read_locks);
-}
-
-static inline void btrfs_assert_tree_read_locks_put(struct extent_buffer *eb)
-{
-	atomic_dec(&eb->read_locks);
-}
-
-static inline void btrfs_assert_tree_read_locked(struct extent_buffer *eb)
-{
-	BUG_ON(!atomic_read(&eb->read_locks));
-}
-
-static inline void btrfs_assert_tree_write_locks_get(struct extent_buffer *eb)
-{
-	eb->write_locks++;
-}
-
-static inline void btrfs_assert_tree_write_locks_put(struct extent_buffer *eb)
-{
-	eb->write_locks--;
-}
-
-#else
-static void btrfs_assert_spinning_writers_get(struct extent_buffer *eb) { }
-static void btrfs_assert_spinning_writers_put(struct extent_buffer *eb) { }
-static void btrfs_assert_no_spinning_writers(struct extent_buffer *eb) { }
-static void btrfs_assert_spinning_readers_put(struct extent_buffer *eb) { }
-static void btrfs_assert_spinning_readers_get(struct extent_buffer *eb) { }
-static void btrfs_assert_tree_read_locked(struct extent_buffer *eb) { }
-static void btrfs_assert_tree_read_locks_get(struct extent_buffer *eb) { }
-static void btrfs_assert_tree_read_locks_put(struct extent_buffer *eb) { }
-static void btrfs_assert_tree_write_locks_get(struct extent_buffer *eb) { }
-static void btrfs_assert_tree_write_locks_put(struct extent_buffer *eb) { }
-#endif
-
 /*
  * Mark already held read lock as blocking. Can be nested in write lock by the
  * same thread.
@@ -195,18 +51,6 @@ static void btrfs_assert_tree_write_locks_put(struct extent_buffer *eb) { }
  */
 void btrfs_set_lock_blocking_read(struct extent_buffer *eb)
 {
-	trace_btrfs_set_lock_blocking_read(eb);
-	/*
-	 * No lock is required.  The lock owner may change if we have a read
-	 * lock, but it won't change to or away from us.  If we have the write
-	 * lock, we are the owner and it'll never change.
-	 */
-	if (eb->lock_recursed && current->pid == eb->lock_owner)
-		return;
-	btrfs_assert_tree_read_locked(eb);
-	atomic_inc(&eb->blocking_readers);
-	btrfs_assert_spinning_readers_put(eb);
-	read_unlock(&eb->lock);
 }
 
 /*
@@ -219,30 +63,20 @@ void btrfs_set_lock_blocking_read(struct extent_buffer *eb)
  */
 void btrfs_set_lock_blocking_write(struct extent_buffer *eb)
 {
-	trace_btrfs_set_lock_blocking_write(eb);
-	/*
-	 * No lock is required.  The lock owner may change if we have a read
-	 * lock, but it won't change to or away from us.  If we have the write
-	 * lock, we are the owner and it'll never change.
-	 */
-	if (eb->lock_recursed && current->pid == eb->lock_owner)
-		return;
-	if (eb->blocking_writers == 0) {
-		btrfs_assert_spinning_writers_put(eb);
-		btrfs_assert_tree_locked(eb);
-		WRITE_ONCE(eb->blocking_writers, 1);
-		write_unlock(&eb->lock);
-	}
 }
 
 /*
- * Lock the extent buffer for read. Wait for any writers (spinning or blocking).
- * Can be nested in write lock by the same thread.
+ * __btrfs_tree_read_lock: Lock the extent buffer for read.
+ * @eb - the eb to be locked.
+ * @nest - the nesting level to be used for lockdep.
+ * @recurse - if this lock is able to be recursed.
  *
- * Use when the locked section does only lightweight actions and busy waiting
- * would be cheaper than making other threads do the wait/wake loop.
+ * This takes the read lock on the extent buffer, using the specified nesting
+ * level for lockdep purposes.
  *
- * The rwlock is held upon exit.
+ * If you specify recurse = true, then we will allow this to be taken if we
+ * currently own the lock already.  This should only be used in specific
+ * usecases, and the subsequent unlock will not change the state of the lock.
  */
 void __btrfs_tree_read_lock(struct extent_buffer *eb, enum btrfs_lock_nesting nest,
 			    bool recurse)
@@ -251,33 +85,33 @@ void __btrfs_tree_read_lock(struct extent_buffer *eb, enum btrfs_lock_nesting ne
 
 	if (trace_btrfs_tree_read_lock_enabled())
 		start_ns = ktime_get_ns();
-again:
-	read_lock(&eb->lock);
-	BUG_ON(eb->blocking_writers == 0 &&
-	       current->pid == eb->lock_owner);
-	if (eb->blocking_writers) {
-		if (current->pid == eb->lock_owner) {
-			/*
-			 * This extent is already write-locked by our thread.
-			 * We allow an additional read lock to be added because
-			 * it's for the same thread. btrfs_find_all_roots()
-			 * depends on this as it may be called on a partly
-			 * (write-)locked tree.
-			 */
-			WARN_ON(!recurse);
-			BUG_ON(eb->lock_recursed);
-			eb->lock_recursed = true;
-			read_unlock(&eb->lock);
-			trace_btrfs_tree_read_lock(eb, start_ns);
-			return;
+
+	if (unlikely(recurse)) {
+		/* First see if we can grab the lock outright. */
+		if (down_read_trylock(&eb->lock))
+			goto out;
+
+		/*
+		 * Ok still doesn't necessarily mean we are already holding the
+		 * lock, check the owner.
+		 */
+		if (eb->lock_owner != current->pid) {
+			down_read_nested(&eb->lock, nest);
+			goto out;
 		}
-		read_unlock(&eb->lock);
-		wait_event(eb->write_lock_wq,
-			   READ_ONCE(eb->blocking_writers) == 0);
-		goto again;
+
+		/*
+		 * Ok we have actually recursed, but we should only be recursing
+		 * once, so blow up if we're already recursed, otherwise set
+		 * ->lock_recursed and carry on.
+		 */
+		BUG_ON(eb->lock_recursed);
+		eb->lock_recursed = true;
+		goto out;
 	}
-	btrfs_assert_tree_read_locks_get(eb);
-	btrfs_assert_spinning_readers_get(eb);
+	down_read_nested(&eb->lock, nest);
+out:
+	eb->lock_owner = current->pid;
 	trace_btrfs_tree_read_lock(eb, start_ns);
 }
 
@@ -294,74 +128,42 @@ void btrfs_tree_read_lock(struct extent_buffer *eb)
  */
 int btrfs_tree_read_lock_atomic(struct extent_buffer *eb)
 {
-	if (READ_ONCE(eb->blocking_writers))
-		return 0;
-
-	read_lock(&eb->lock);
-	/* Refetch value after lock */
-	if (READ_ONCE(eb->blocking_writers)) {
-		read_unlock(&eb->lock);
-		return 0;
-	}
-	btrfs_assert_tree_read_locks_get(eb);
-	btrfs_assert_spinning_readers_get(eb);
-	trace_btrfs_tree_read_lock_atomic(eb);
-	return 1;
+	return btrfs_try_tree_read_lock(eb);
 }
 
 /*
- * Try-lock for read. Don't block or wait for contending writers.
+ * Try-lock for read.
  *
  * Retrun 1 if the rwlock has been taken, 0 otherwise
  */
 int btrfs_try_tree_read_lock(struct extent_buffer *eb)
 {
-	if (READ_ONCE(eb->blocking_writers))
-		return 0;
-
-	if (!read_trylock(&eb->lock))
-		return 0;
-
-	/* Refetch value after lock */
-	if (READ_ONCE(eb->blocking_writers)) {
-		read_unlock(&eb->lock);
-		return 0;
+	if (down_read_trylock(&eb->lock)) {
+		eb->lock_owner = current->pid;
+		trace_btrfs_try_tree_read_lock(eb);
+		return 1;
 	}
-	btrfs_assert_tree_read_locks_get(eb);
-	btrfs_assert_spinning_readers_get(eb);
-	trace_btrfs_try_tree_read_lock(eb);
-	return 1;
+	return 0;
 }
 
 /*
- * Try-lock for write. May block until the lock is uncontended, but does not
- * wait until it is free.
+ * Try-lock for write.
  *
  * Retrun 1 if the rwlock has been taken, 0 otherwise
  */
 int btrfs_try_tree_write_lock(struct extent_buffer *eb)
 {
-	if (READ_ONCE(eb->blocking_writers) || atomic_read(&eb->blocking_readers))
-		return 0;
-
-	write_lock(&eb->lock);
-	/* Refetch value after lock */
-	if (READ_ONCE(eb->blocking_writers) || atomic_read(&eb->blocking_readers)) {
-		write_unlock(&eb->lock);
-		return 0;
+	if (down_write_trylock(&eb->lock)) {
+		eb->lock_owner = current->pid;
+		trace_btrfs_try_tree_write_lock(eb);
+		return 1;
 	}
-	btrfs_assert_tree_write_locks_get(eb);
-	btrfs_assert_spinning_writers_get(eb);
-	eb->lock_owner = current->pid;
-	trace_btrfs_try_tree_write_lock(eb);
-	return 1;
+	return 0;
 }
 
 /*
- * Release read lock. Must be used only if the lock is in spinning mode.  If
- * the read lock is nested, must pair with read lock before the write unlock.
- *
- * The rwlock is not held upon exit.
+ * Release read lock.  If the read lock was recursed then the lock stays in the
+ * original state that it was before it was recursively locked.
  */
 void btrfs_tree_read_unlock(struct extent_buffer *eb)
 {
@@ -376,10 +178,8 @@ void btrfs_tree_read_unlock(struct extent_buffer *eb)
 		eb->lock_recursed = false;
 		return;
 	}
-	btrfs_assert_tree_read_locked(eb);
-	btrfs_assert_spinning_readers_put(eb);
-	btrfs_assert_tree_read_locks_put(eb);
-	read_unlock(&eb->lock);
+	eb->lock_owner = 0;
+	up_read(&eb->lock);
 }
 
 /*
@@ -391,30 +191,15 @@ void btrfs_tree_read_unlock(struct extent_buffer *eb)
  */
 void btrfs_tree_read_unlock_blocking(struct extent_buffer *eb)
 {
-	trace_btrfs_tree_read_unlock_blocking(eb);
-	/*
-	 * if we're nested, we have the write lock.  No new locking
-	 * is needed as long as we are the lock owner.
-	 * The write unlock will do a barrier for us, and the lock_recursed
-	 * field only matters to the lock owner.
-	 */
-	if (eb->lock_recursed && current->pid == eb->lock_owner) {
-		eb->lock_recursed = false;
-		return;
-	}
-	btrfs_assert_tree_read_locked(eb);
-	WARN_ON(atomic_read(&eb->blocking_readers) == 0);
-	/* atomic_dec_and_test implies a barrier */
-	if (atomic_dec_and_test(&eb->blocking_readers))
-		cond_wake_up_nomb(&eb->read_lock_wq);
-	btrfs_assert_tree_read_locks_put(eb);
+	btrfs_tree_read_unlock(eb);
 }
 
 /*
- * Lock for write. Wait for all blocking and spinning readers and writers. This
- * starts context where reader lock could be nested by the same thread.
+ * __btrfs_tree_lock: Lock for write.
+ * @eb - the eb to lock.
+ * @nest - the nesting to use for the lock.
  *
- * The rwlock is held for write upon exit.
+ * Returns with the eb->lock write locked.
  */
 void __btrfs_tree_lock(struct extent_buffer *eb, enum btrfs_lock_nesting nest)
 	__acquires(&eb->lock)
@@ -424,19 +209,7 @@ void __btrfs_tree_lock(struct extent_buffer *eb, enum btrfs_lock_nesting nest)
 	if (trace_btrfs_tree_lock_enabled())
 		start_ns = ktime_get_ns();
 
-	WARN_ON(eb->lock_owner == current->pid);
-again:
-	wait_event(eb->read_lock_wq, atomic_read(&eb->blocking_readers) == 0);
-	wait_event(eb->write_lock_wq, READ_ONCE(eb->blocking_writers) == 0);
-	write_lock(&eb->lock);
-	/* Refetch value after lock */
-	if (atomic_read(&eb->blocking_readers) ||
-	    READ_ONCE(eb->blocking_writers)) {
-		write_unlock(&eb->lock);
-		goto again;
-	}
-	btrfs_assert_spinning_writers_get(eb);
-	btrfs_assert_tree_write_locks_get(eb);
+	down_write_nested(&eb->lock, nest);
 	eb->lock_owner = current->pid;
 	trace_btrfs_tree_lock(eb, start_ns);
 }
@@ -447,42 +220,13 @@ void btrfs_tree_lock(struct extent_buffer *eb)
 }
 
 /*
- * Release the write lock, either blocking or spinning (ie. there's no need
- * for an explicit blocking unlock, like btrfs_tree_read_unlock_blocking).
- * This also ends the context for nesting, the read lock must have been
- * released already.
- *
- * Tasks blocked and waiting are woken, rwlock is not held upon exit.
+ * Release the write lock.
  */
 void btrfs_tree_unlock(struct extent_buffer *eb)
 {
-	/*
-	 * This is read both locked and unlocked but always by the same thread
-	 * that already owns the lock so we don't need to use READ_ONCE
-	 */
-	int blockers = eb->blocking_writers;
-
-	BUG_ON(blockers > 1);
-
-	btrfs_assert_tree_locked(eb);
 	trace_btrfs_tree_unlock(eb);
 	eb->lock_owner = 0;
-	btrfs_assert_tree_write_locks_put(eb);
-
-	if (blockers) {
-		btrfs_assert_no_spinning_writers(eb);
-		/* Unlocked write */
-		WRITE_ONCE(eb->blocking_writers, 0);
-		/*
-		 * We need to order modifying blocking_writers above with
-		 * actually waking up the sleepers to ensure they see the
-		 * updated value of blocking_writers
-		 */
-		cond_wake_up(&eb->write_lock_wq);
-	} else {
-		btrfs_assert_spinning_writers_put(eb);
-		write_unlock(&eb->lock);
-	}
+	up_write(&eb->lock);
 }
 
 /*
diff --git a/fs/btrfs/locking.h b/fs/btrfs/locking.h
index e74ae478b778..9c43c64de9c5 100644
--- a/fs/btrfs/locking.h
+++ b/fs/btrfs/locking.h
@@ -111,7 +111,7 @@ btrfs_read_lock_root_node(struct btrfs_root *root)
 
 #ifdef CONFIG_BTRFS_DEBUG
 static inline void btrfs_assert_tree_locked(struct extent_buffer *eb) {
-	BUG_ON(!eb->write_locks);
+	lockdep_assert_held(&eb->lock);
 }
 #else
 static inline void btrfs_assert_tree_locked(struct extent_buffer *eb) { }
diff --git a/fs/btrfs/print-tree.c b/fs/btrfs/print-tree.c
index 61f44e78e3c9..6668dbe2b9d2 100644
--- a/fs/btrfs/print-tree.c
+++ b/fs/btrfs/print-tree.c
@@ -151,15 +151,8 @@ static void print_uuid_item(struct extent_buffer *l, unsigned long offset,
 static void print_eb_refs_lock(struct extent_buffer *eb)
 {
 #ifdef CONFIG_BTRFS_DEBUG
-	btrfs_info(eb->fs_info,
-"refs %u lock (w:%d r:%d bw:%d br:%d sw:%d sr:%d) lock_owner %u current %u",
-		   atomic_read(&eb->refs), eb->write_locks,
-		   atomic_read(&eb->read_locks),
-		   eb->blocking_writers,
-		   atomic_read(&eb->blocking_readers),
-		   eb->spinning_writers,
-		   atomic_read(&eb->spinning_readers),
-		   eb->lock_owner, current->pid);
+	btrfs_info(eb->fs_info, "refs %u lock_owner %u current %u",
+		   atomic_read(&eb->refs), eb->lock_owner, current->pid);
 #endif
 }
 
-- 
2.24.1

