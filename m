Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4B3E03002D
	for <lists+linux-btrfs@lfdr.de>; Thu, 30 May 2019 18:30:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726576AbfE3QaI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 30 May 2019 12:30:08 -0400
Received: from mx2.suse.de ([195.135.220.15]:60640 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726045AbfE3QaH (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 30 May 2019 12:30:07 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 3FE7BAFDB
        for <linux-btrfs@vger.kernel.org>; Thu, 30 May 2019 16:30:06 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 5C9C2DA85E; Thu, 30 May 2019 18:31:00 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 1/3] btrfs: switch extent_buffer blocking_writers from atomic to int
Date:   Thu, 30 May 2019 18:31:00 +0200
Message-Id: <ebba72a9ef564b27fb5f652e3edcfbca3e981a10.1559233731.git.dsterba@suse.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1559233731.git.dsterba@suse.com>
References: <cover.1559233731.git.dsterba@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The blocking_writers is either 0 or 1 and always updated under the lock,
so we don't need the atomic_t semantics.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/extent_io.c  |  2 +-
 fs/btrfs/extent_io.h  |  2 +-
 fs/btrfs/locking.c    | 46 +++++++++++++++++++------------------------
 fs/btrfs/print-tree.c |  2 +-
 4 files changed, 23 insertions(+), 29 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 2f38c10d2bfb..57b6de9df7c4 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -4823,7 +4823,7 @@ __alloc_extent_buffer(struct btrfs_fs_info *fs_info, u64 start,
 	eb->bflags = 0;
 	rwlock_init(&eb->lock);
 	atomic_set(&eb->blocking_readers, 0);
-	atomic_set(&eb->blocking_writers, 0);
+	eb->blocking_writers = 0;
 	eb->lock_nested = false;
 	init_waitqueue_head(&eb->write_lock_wq);
 	init_waitqueue_head(&eb->read_lock_wq);
diff --git a/fs/btrfs/extent_io.h b/fs/btrfs/extent_io.h
index aa18a16a6ed7..201da61dfc21 100644
--- a/fs/btrfs/extent_io.h
+++ b/fs/btrfs/extent_io.h
@@ -167,7 +167,7 @@ struct extent_buffer {
 	struct rcu_head rcu_head;
 	pid_t lock_owner;
 
-	atomic_t blocking_writers;
+	int blocking_writers;
 	atomic_t blocking_readers;
 	bool lock_nested;
 	/* >= 0 if eb belongs to a log tree, -1 otherwise */
diff --git a/fs/btrfs/locking.c b/fs/btrfs/locking.c
index 2f6c3c7851ed..5feb01147e19 100644
--- a/fs/btrfs/locking.c
+++ b/fs/btrfs/locking.c
@@ -111,10 +111,10 @@ void btrfs_set_lock_blocking_write(struct extent_buffer *eb)
 	 */
 	if (eb->lock_nested && current->pid == eb->lock_owner)
 		return;
-	if (atomic_read(&eb->blocking_writers) == 0) {
+	if (eb->blocking_writers == 0) {
 		btrfs_assert_spinning_writers_put(eb);
 		btrfs_assert_tree_locked(eb);
-		atomic_inc(&eb->blocking_writers);
+		eb->blocking_writers++;
 		write_unlock(&eb->lock);
 	}
 }
@@ -148,12 +148,11 @@ void btrfs_clear_lock_blocking_write(struct extent_buffer *eb)
 	 */
 	if (eb->lock_nested && current->pid == eb->lock_owner)
 		return;
-	BUG_ON(atomic_read(&eb->blocking_writers) != 1);
 	write_lock(&eb->lock);
+	BUG_ON(eb->blocking_writers != 1);
 	btrfs_assert_spinning_writers_get(eb);
-	/* atomic_dec_and_test implies a barrier */
-	if (atomic_dec_and_test(&eb->blocking_writers))
-		cond_wake_up_nomb(&eb->write_lock_wq);
+	if (--eb->blocking_writers == 0)
+		cond_wake_up(&eb->write_lock_wq);
 }
 
 /*
@@ -167,12 +166,10 @@ void btrfs_tree_read_lock(struct extent_buffer *eb)
 	if (trace_btrfs_tree_read_lock_enabled())
 		start_ns = ktime_get_ns();
 again:
-	BUG_ON(!atomic_read(&eb->blocking_writers) &&
-	       current->pid == eb->lock_owner);
-
 	read_lock(&eb->lock);
-	if (atomic_read(&eb->blocking_writers) &&
-	    current->pid == eb->lock_owner) {
+	BUG_ON(eb->blocking_writers == 0 &&
+	       current->pid == eb->lock_owner);
+	if (eb->blocking_writers && current->pid == eb->lock_owner) {
 		/*
 		 * This extent is already write-locked by our thread. We allow
 		 * an additional read lock to be added because it's for the same
@@ -185,10 +182,10 @@ void btrfs_tree_read_lock(struct extent_buffer *eb)
 		trace_btrfs_tree_read_lock(eb, start_ns);
 		return;
 	}
-	if (atomic_read(&eb->blocking_writers)) {
+	if (eb->blocking_writers) {
 		read_unlock(&eb->lock);
 		wait_event(eb->write_lock_wq,
-			   atomic_read(&eb->blocking_writers) == 0);
+			   eb->blocking_writers == 0);
 		goto again;
 	}
 	btrfs_assert_tree_read_locks_get(eb);
@@ -203,11 +200,11 @@ void btrfs_tree_read_lock(struct extent_buffer *eb)
  */
 int btrfs_tree_read_lock_atomic(struct extent_buffer *eb)
 {
-	if (atomic_read(&eb->blocking_writers))
+	if (eb->blocking_writers)
 		return 0;
 
 	read_lock(&eb->lock);
-	if (atomic_read(&eb->blocking_writers)) {
+	if (eb->blocking_writers) {
 		read_unlock(&eb->lock);
 		return 0;
 	}
@@ -223,13 +220,13 @@ int btrfs_tree_read_lock_atomic(struct extent_buffer *eb)
  */
 int btrfs_try_tree_read_lock(struct extent_buffer *eb)
 {
-	if (atomic_read(&eb->blocking_writers))
+	if (eb->blocking_writers)
 		return 0;
 
 	if (!read_trylock(&eb->lock))
 		return 0;
 
-	if (atomic_read(&eb->blocking_writers)) {
+	if (eb->blocking_writers) {
 		read_unlock(&eb->lock);
 		return 0;
 	}
@@ -245,13 +242,11 @@ int btrfs_try_tree_read_lock(struct extent_buffer *eb)
  */
 int btrfs_try_tree_write_lock(struct extent_buffer *eb)
 {
-	if (atomic_read(&eb->blocking_writers) ||
-	    atomic_read(&eb->blocking_readers))
+	if (eb->blocking_writers || atomic_read(&eb->blocking_readers))
 		return 0;
 
 	write_lock(&eb->lock);
-	if (atomic_read(&eb->blocking_writers) ||
-	    atomic_read(&eb->blocking_readers)) {
+	if (eb->blocking_writers || atomic_read(&eb->blocking_readers)) {
 		write_unlock(&eb->lock);
 		return 0;
 	}
@@ -322,10 +317,9 @@ void btrfs_tree_lock(struct extent_buffer *eb)
 	WARN_ON(eb->lock_owner == current->pid);
 again:
 	wait_event(eb->read_lock_wq, atomic_read(&eb->blocking_readers) == 0);
-	wait_event(eb->write_lock_wq, atomic_read(&eb->blocking_writers) == 0);
+	wait_event(eb->write_lock_wq, eb->blocking_writers == 0);
 	write_lock(&eb->lock);
-	if (atomic_read(&eb->blocking_readers) ||
-	    atomic_read(&eb->blocking_writers)) {
+	if (atomic_read(&eb->blocking_readers) || eb->blocking_writers) {
 		write_unlock(&eb->lock);
 		goto again;
 	}
@@ -340,7 +334,7 @@ void btrfs_tree_lock(struct extent_buffer *eb)
  */
 void btrfs_tree_unlock(struct extent_buffer *eb)
 {
-	int blockers = atomic_read(&eb->blocking_writers);
+	int blockers = eb->blocking_writers;
 
 	BUG_ON(blockers > 1);
 
@@ -351,7 +345,7 @@ void btrfs_tree_unlock(struct extent_buffer *eb)
 
 	if (blockers) {
 		btrfs_assert_no_spinning_writers(eb);
-		atomic_dec(&eb->blocking_writers);
+		eb->blocking_writers--;
 		/* Use the lighter barrier after atomic */
 		smp_mb__after_atomic();
 		cond_wake_up_nomb(&eb->write_lock_wq);
diff --git a/fs/btrfs/print-tree.c b/fs/btrfs/print-tree.c
index 1141ca5fae6a..7cb4f1fbe043 100644
--- a/fs/btrfs/print-tree.c
+++ b/fs/btrfs/print-tree.c
@@ -155,7 +155,7 @@ static void print_eb_refs_lock(struct extent_buffer *eb)
 "refs %u lock (w:%d r:%d bw:%d br:%d sw:%d sr:%d) lock_owner %u current %u",
 		   atomic_read(&eb->refs), atomic_read(&eb->write_locks),
 		   atomic_read(&eb->read_locks),
-		   atomic_read(&eb->blocking_writers),
+		   eb->blocking_writers,
 		   atomic_read(&eb->blocking_readers),
 		   atomic_read(&eb->spinning_writers),
 		   atomic_read(&eb->spinning_readers),
-- 
2.21.0

