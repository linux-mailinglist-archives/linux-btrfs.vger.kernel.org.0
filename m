Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A461CDB7A7
	for <lists+linux-btrfs@lfdr.de>; Thu, 17 Oct 2019 21:38:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436949AbfJQTiz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 17 Oct 2019 15:38:55 -0400
Received: from mx2.suse.de ([195.135.220.15]:41408 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2436676AbfJQTiy (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 17 Oct 2019 15:38:54 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 21A82B019;
        Thu, 17 Oct 2019 19:38:52 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 4C8DCDA808; Thu, 17 Oct 2019 21:39:03 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 5/5] btrfs: document extent buffer locking
Date:   Thu, 17 Oct 2019 21:39:03 +0200
Message-Id: <ed989ccddbc8822e61df533d861d907ce0a43040.1571340084.git.dsterba@suse.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1571340084.git.dsterba@suse.com>
References: <cover.1571340084.git.dsterba@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/locking.c | 110 +++++++++++++++++++++++++++++++++++++++------
 1 file changed, 96 insertions(+), 14 deletions(-)

diff --git a/fs/btrfs/locking.c b/fs/btrfs/locking.c
index e0e0430577aa..2a0e828b4470 100644
--- a/fs/btrfs/locking.c
+++ b/fs/btrfs/locking.c
@@ -13,6 +13,48 @@
 #include "extent_io.h"
 #include "locking.h"
 
+/*
+ * Extent buffer locking
+ * ~~~~~~~~~~~~~~~~~~~~~
+ *
+ * The locks use a custom scheme that allows to do more operations than are
+ * available fromt current locking primitives. The building blocks are still
+ * rwlock and wait queues.
+ *
+ * Required semantics:
+ *
+ * - reader/writer exclusion
+ * - writer/writer exclusion
+ * - reader/reader sharing
+ * - spinning lock semantics
+ * - blocking lock semantics
+ * - try-lock semantics for readers and writers
+ * - one level nesting, allowing read lock to be taken by the same thread that
+ *   already has write lock
+ *
+ * The extent buffer locks (also called tree locks) manage access to eb data.
+ * We want concurrency of many readers and safe updates. The underlying locking
+ * is done by read-write spinlock and the blocking part is implemented using
+ * counters and wait queues.
+ *
+ * spinning semantics - the low-level rwlock is held so all other threads that
+ *                      want to take it are spinning on it.
+ *
+ * blocking semantics - the low-level rwlock is not held but the counter
+ *                      denotes how many times the blocking lock was held;
+ *                      sleeping is possible
+ *
+ * Write lock always allows only one thread to access the data.
+ *
+ *
+ * Debugging
+ * ~~~~~~~~~
+ *
+ * There are additional state counters that are asserted in various contexts,
+ * removed from non-debug build to reduce extent_buffer size and for
+ * performance reasons.
+ */
+
 #ifdef CONFIG_BTRFS_DEBUG
 static inline void btrfs_assert_spinning_writers_get(struct extent_buffer *eb)
 {
@@ -80,6 +122,15 @@ static void btrfs_assert_tree_write_locks_get(struct extent_buffer *eb) { }
 static void btrfs_assert_tree_write_locks_put(struct extent_buffer *eb) { }
 #endif
 
+/*
+ * Mark already held read lock as blocking. Can be nested in write lock by the
+ * same thread.
+ *
+ * Use when there are potentially long operations ahead so other thread waiting
+ * on the lock will not actively spin but sleep instead.
+ *
+ * The rwlock is released and blocking reader counter is increased.
+ */
 void btrfs_set_lock_blocking_read(struct extent_buffer *eb)
 {
 	trace_btrfs_set_lock_blocking_read(eb);
@@ -96,6 +147,14 @@ void btrfs_set_lock_blocking_read(struct extent_buffer *eb)
 	read_unlock(&eb->lock);
 }
 
+/*
+ * Mark already held write lock as blocking.
+ *
+ * Use when there are potentially long operations ahead so other threads
+ * waiting on the lock will not actively spin but sleep instead.
+ *
+ * The rwlock is released and blocking writers is set.
+ */
 void btrfs_set_lock_blocking_write(struct extent_buffer *eb)
 {
 	trace_btrfs_set_lock_blocking_write(eb);
@@ -127,8 +186,13 @@ void btrfs_set_lock_blocking_write(struct extent_buffer *eb)
 }
 
 /*
- * take a spinning read lock.  This will wait for any blocking
- * writers
+ * Lock the extent buffer for read. Wait for any writers (spinning or blocking).
+ * Can be nested in write lock by the same thread.
+ *
+ * Use when the locked section does only lightweight actions and busy waiting
+ * would be cheaper than making other threads do the wait/wake loop.
+ *
+ * The rwlock is held upon exit.
  */
 void btrfs_tree_read_lock(struct extent_buffer *eb)
 {
@@ -166,9 +230,10 @@ void btrfs_tree_read_lock(struct extent_buffer *eb)
 }
 
 /*
- * take a spinning read lock.
- * returns 1 if we get the read lock and 0 if we don't
- * this won't wait for blocking writers
+ * Lock extent buffer for read, optimistically expecting that there are no
+ * contending blocking writers. If there are, don't wait.
+ *
+ * Return 1 if the rwlock has been taken, 0 otherwise
  */
 int btrfs_tree_read_lock_atomic(struct extent_buffer *eb)
 {
@@ -188,8 +253,9 @@ int btrfs_tree_read_lock_atomic(struct extent_buffer *eb)
 }
 
 /*
- * returns 1 if we get the read lock and 0 if we don't
- * this won't wait for blocking writers
+ * Try-lock for read. Don't block or wait for contending writers.
+ *
+ * Retrun 1 if the rwlock has been taken, 0 otherwise
  */
 int btrfs_try_tree_read_lock(struct extent_buffer *eb)
 {
@@ -211,8 +277,10 @@ int btrfs_try_tree_read_lock(struct extent_buffer *eb)
 }
 
 /*
- * returns 1 if we get the read lock and 0 if we don't
- * this won't wait for blocking writers or readers
+ * Try-lock for write. May block until the lock is uncontended, but does not
+ * wait until it is free.
+ *
+ * Retrun 1 if the rwlock has been taken, 0 otherwise
  */
 int btrfs_try_tree_write_lock(struct extent_buffer *eb)
 {
@@ -233,7 +301,10 @@ int btrfs_try_tree_write_lock(struct extent_buffer *eb)
 }
 
 /*
- * drop a spinning read lock
+ * Release read lock. Must be used only if the lock is in spinning mode.  If
+ * the read lock is nested, must pair with read lock before the write unlock.
+ *
+ * The rwlock is not held upon exit.
  */
 void btrfs_tree_read_unlock(struct extent_buffer *eb)
 {
@@ -255,7 +326,11 @@ void btrfs_tree_read_unlock(struct extent_buffer *eb)
 }
 
 /*
- * drop a blocking read lock
+ * Release read lock, previously set to blocking by a pairing call to
+ * btrfs_set_lock_blocking_read(). Can be nested in write lock by the same
+ * thread.
+ *
+ * State of rwlock is unchanged, last reader wakes waiting threads.
  */
 void btrfs_tree_read_unlock_blocking(struct extent_buffer *eb)
 {
@@ -279,8 +354,10 @@ void btrfs_tree_read_unlock_blocking(struct extent_buffer *eb)
 }
 
 /*
- * take a spinning write lock.  This will wait for both
- * blocking readers or writers
+ * Lock for write. Wait for all blocking and spinning readers and writers. This
+ * starts context where reader lock could be nested by the same thread.
+ *
+ * The rwlock is held for write upon exit.
  */
 void btrfs_tree_lock(struct extent_buffer *eb)
 {
@@ -307,7 +384,12 @@ void btrfs_tree_lock(struct extent_buffer *eb)
 }
 
 /*
- * drop a spinning or a blocking write lock.
+ * Release the write lock, either blocking or spinning (ie. there's no need
+ * for an explicit blocking unlock, like btrfs_tree_read_unlock_blocking).
+ * This also ends the context for nesting, the read lock must have been
+ * released already.
+ *
+ * Tasks blocked and waiting are woken, rwlock is not held upon exit.
  */
 void btrfs_tree_unlock(struct extent_buffer *eb)
 {
-- 
2.23.0

