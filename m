Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CDC07E9A87
	for <lists+linux-btrfs@lfdr.de>; Wed, 30 Oct 2019 11:57:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727018AbfJ3K45 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 30 Oct 2019 06:56:57 -0400
Received: from mx2.suse.de ([195.135.220.15]:37724 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726999AbfJ3K44 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 30 Oct 2019 06:56:56 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 07819AD12;
        Wed, 30 Oct 2019 10:56:54 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id B5CCBDA783; Wed, 30 Oct 2019 11:57:03 +0100 (CET)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH v2 4/5] btrfs: document extent buffer locking
Date:   Wed, 30 Oct 2019 11:57:03 +0100
Message-Id: <a3865305dbfe7b00a9ff2068a4ff141360a563c2.1572432768.git.dsterba@suse.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1572432768.git.dsterba@suse.com>
References: <cover.1572432768.git.dsterba@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/locking.c | 172 +++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 158 insertions(+), 14 deletions(-)

diff --git a/fs/btrfs/locking.c b/fs/btrfs/locking.c
index 4cd593a2f58c..571c4826c428 100644
--- a/fs/btrfs/locking.c
+++ b/fs/btrfs/locking.c
@@ -13,6 +13,110 @@
 #include "extent_io.h"
 #include "locking.h"
 
+/*
+ * Extent buffer locking
+ * =====================
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
+ * The extent buffer locks (also called tree locks) manage access to eb data
+ * related to the storage in the b-tree (keys, items, but not the individual
+ * members of eb).
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
+ * ---------
+ *
+ * There are additional state counters that are asserted in various contexts,
+ * removed from non-debug build to reduce extent_buffer size and for
+ * performance reasons.
+ *
+ *
+ * Lock nesting
+ * ------------
+ *
+ * A write operation on a tree might indirectly start a look up on the same
+ * tree.  This can happen when btrfs_cow_block locks the tree and needs to
+ * lookup free extents.
+ *
+ * btrfs_cow_block
+ *   ..
+ *   alloc_tree_block_no_bg_flush
+ *     btrfs_alloc_tree_block
+ *       btrfs_reserve_extent
+ *         ..
+ *         load_free_space_cache
+ *           ..
+ *           btrfs_lookup_file_extent
+ *             btrfs_search_slot
+ *
+ *
+ * Locking pattern - spinning
+ * --------------------------
+ *
+ * The simple locking scenario, the +--+ denotes the spinning section.
+ *
+ * +- btrfs_tree_lock
+ * | - extent_buffer::rwlock is held
+ * | - no heavy operations should happen, eg. IO, memory allocations, large
+ * |   structure traversals
+ * +- btrfs_tree_unock
+*
+*
+ * Locking pattern - blocking
+ * --------------------------
+ *
+ * The blocking write uses the following scheme.  The +--+ denotes the spinning
+ * section.
+ *
+ * +- btrfs_tree_lock
+ * |
+ * +- btrfs_set_lock_blocking_write
+ *
+ *   - allowed: IO, memory allocations, etc.
+ *
+ * -- btrfs_tree_unlock - note, no explicit unblocking necessary
+ *
+ *
+ * Blocking read is similar.
+ *
+ * +- btrfs_tree_read_lock
+ * |
+ * +- btrfs_set_lock_blocking_read
+ *
+ *  - heavy operations allowed
+ *
+ * +- btrfs_tree_read_unlock_blocking
+ * |
+ * +- btrfs_tree_read_unlock
+ *
+ */
+
 #ifdef CONFIG_BTRFS_DEBUG
 static inline void btrfs_assert_spinning_writers_get(struct extent_buffer *eb)
 {
@@ -80,6 +184,15 @@ static void btrfs_assert_tree_write_locks_get(struct extent_buffer *eb) { }
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
@@ -96,6 +209,14 @@ void btrfs_set_lock_blocking_read(struct extent_buffer *eb)
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
@@ -115,8 +236,13 @@ void btrfs_set_lock_blocking_write(struct extent_buffer *eb)
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
@@ -154,9 +280,10 @@ void btrfs_tree_read_lock(struct extent_buffer *eb)
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
@@ -176,8 +303,9 @@ int btrfs_tree_read_lock_atomic(struct extent_buffer *eb)
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
@@ -199,8 +327,10 @@ int btrfs_try_tree_read_lock(struct extent_buffer *eb)
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
@@ -221,7 +351,10 @@ int btrfs_try_tree_write_lock(struct extent_buffer *eb)
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
@@ -243,7 +376,11 @@ void btrfs_tree_read_unlock(struct extent_buffer *eb)
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
@@ -267,8 +404,10 @@ void btrfs_tree_read_unlock_blocking(struct extent_buffer *eb)
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
@@ -295,7 +434,12 @@ void btrfs_tree_lock(struct extent_buffer *eb)
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

