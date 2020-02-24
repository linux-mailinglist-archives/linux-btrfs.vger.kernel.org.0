Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BF4FE16AA23
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Feb 2020 16:32:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727693AbgBXPcW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 24 Feb 2020 10:32:22 -0500
Received: from mx2.suse.de ([195.135.220.15]:51036 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727498AbgBXPcW (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 24 Feb 2020 10:32:22 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id A13A5ADBE;
        Mon, 24 Feb 2020 15:32:20 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 1/2] btrfs: Implement DRW lock
Date:   Mon, 24 Feb 2020 17:32:18 +0200
Message-Id: <20200224153218.31304-1-nborisov@suse.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200224152637.30774-1-nborisov@suse.com>
References: <20200224152637.30774-1-nborisov@suse.com>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

A (D)ouble (R)eader (W)riter lock is a locking primitive that allows
to have multiple readers or multiple writers but not multiple readers
and writers holding it concurrently. The code is factored out from
the existing open-coded locking scheme used to exclude pending
snapshots from nocow writers and vice-versa. Current implementation
actually favors Readers (that is snapshot creaters) to writers (nocow
writers of the filesystem).

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 fs/btrfs/ctree.h   |  1 +
 fs/btrfs/locking.c | 90 ++++++++++++++++++++++++++++++++++++++++++++++
 fs/btrfs/locking.h | 21 +++++++++++
 3 files changed, 112 insertions(+)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index ad275d06e95f..efc2cd147141 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -33,6 +33,7 @@
 #include "extent_map.h"
 #include "async-thread.h"
 #include "block-rsv.h"
+#include "locking.h"
 
 struct btrfs_trans_handle;
 struct btrfs_transaction;
diff --git a/fs/btrfs/locking.c b/fs/btrfs/locking.c
index e713900f96b6..d890833694c9 100644
--- a/fs/btrfs/locking.c
+++ b/fs/btrfs/locking.c
@@ -565,3 +565,93 @@ struct extent_buffer *btrfs_read_lock_root_node(struct btrfs_root *root)
 	}
 	return eb;
 }
+
+/*
+ * DRW stands for double-reader-writer lock. It's used in situation where you
+ * want to provide A-B exclusion but not AA or BB. Currently implementation
+ * gives more priority to reader. If a reader and a writer both race to acquire
+ * their respective sides of the lock the writer would yield its lock as soon as
+ * it detects a concurrent reader. Additionally if there are pending readers no
+ * new writers would be allowed to come in and acquire the lock.
+ */
+int btrfs_drw_lock_init(struct btrfs_drw_lock *lock)
+{
+	int ret;
+
+	ret = percpu_counter_init(&lock->writers, 0, GFP_KERNEL);
+	if (ret)
+		return ret;
+
+	atomic_set(&lock->readers, 0);
+	init_waitqueue_head(&lock->pending_readers);
+	init_waitqueue_head(&lock->pending_writers);
+
+	return 0;
+}
+
+void btrfs_drw_lock_destroy(struct btrfs_drw_lock *lock)
+{
+	percpu_counter_destroy(&lock->writers);
+}
+
+/* Return true if acquisition is successful, false otherwise */
+bool btrfs_drw_try_write_lock(struct btrfs_drw_lock *lock)
+{
+	if (atomic_read(&lock->readers))
+		return false;
+
+	percpu_counter_inc(&lock->writers);
+
+	/*
+	 * Ensure writers count is updated before we check for
+	 * pending readers
+	 */
+	smp_mb();
+	if (atomic_read(&lock->readers)) {
+		btrfs_drw_write_unlock(lock);
+		return false;
+	}
+
+	return true;
+}
+
+void btrfs_drw_write_lock(struct btrfs_drw_lock *lock)
+{
+	while (true) {
+		if (btrfs_drw_try_write_lock(lock))
+			return;
+		wait_event(lock->pending_writers, !atomic_read(&lock->readers));
+	}
+}
+
+void btrfs_drw_write_unlock(struct btrfs_drw_lock *lock)
+{
+	percpu_counter_dec(&lock->writers);
+	cond_wake_up(&lock->pending_readers);
+}
+
+void btrfs_drw_read_lock(struct btrfs_drw_lock *lock)
+{
+	atomic_inc(&lock->readers);
+
+	/*
+	 * Ensure the pending reader count is perceieved BEFORE this reader
+	 * goes to sleep in case of active writers. This guarantees new writers
+	 * won't be allowed and that the current reader will be woken up when
+	 * the last active writer finishes its jobs.
+	 */
+	smp_mb__after_atomic();
+
+	wait_event(lock->pending_readers,
+		   percpu_counter_sum(&lock->writers) == 0);
+}
+
+void btrfs_drw_read_unlock(struct btrfs_drw_lock *lock)
+{
+	/*
+	 * atomic_dec_and_test implies a full barrier, so woken up writers
+	 * are guaranteed to see the decrement
+	 */
+	if (atomic_dec_and_test(&lock->readers))
+		wake_up(&lock->pending_writers);
+}
diff --git a/fs/btrfs/locking.h b/fs/btrfs/locking.h
index 21a285883e89..ba60318c53d5 100644
--- a/fs/btrfs/locking.h
+++ b/fs/btrfs/locking.h
@@ -7,12 +7,17 @@
 #define BTRFS_LOCKING_H
 
 #include "extent_io.h"
+#include <linux/atomic.h>
+#include <linux/wait.h>
+#include <linux/percpu_counter.h>
 
 #define BTRFS_WRITE_LOCK 1
 #define BTRFS_READ_LOCK 2
 #define BTRFS_WRITE_LOCK_BLOCKING 3
 #define BTRFS_READ_LOCK_BLOCKING 4
 
+struct btrfs_path;
+
 void btrfs_tree_lock(struct extent_buffer *eb);
 void btrfs_tree_unlock(struct extent_buffer *eb);
 
@@ -48,4 +53,20 @@ static inline void btrfs_tree_unlock_rw(struct extent_buffer *eb, int rw)
 		BUG();
 }
 
+
+struct btrfs_drw_lock {
+	atomic_t readers;
+	struct percpu_counter writers;
+	wait_queue_head_t pending_writers;
+	wait_queue_head_t pending_readers;
+};
+
+int btrfs_drw_lock_init(struct btrfs_drw_lock *lock);
+void btrfs_drw_lock_destroy(struct btrfs_drw_lock *lock);
+void btrfs_drw_write_lock(struct btrfs_drw_lock *lock);
+bool btrfs_drw_try_write_lock(struct btrfs_drw_lock *lock);
+void btrfs_drw_write_unlock(struct btrfs_drw_lock *lock);
+void btrfs_drw_read_lock(struct btrfs_drw_lock *lock);
+void btrfs_drw_read_unlock(struct btrfs_drw_lock *lock);
+
 #endif
-- 
2.17.1

