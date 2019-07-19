Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0A0A76E2AB
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Jul 2019 10:40:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727329AbfGSIkF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 19 Jul 2019 04:40:05 -0400
Received: from mx2.suse.de ([195.135.220.15]:35718 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726402AbfGSIj5 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 19 Jul 2019 04:39:57 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id D2771ACD1;
        Fri, 19 Jul 2019 08:39:55 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     paulmck@linux.ibm.com, andrea.parri@amarulasolutions.com,
        linux-kernel@vger.kernel.org, Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH v2 1/2] btrfs: Implement DRW lock
Date:   Fri, 19 Jul 2019 11:39:48 +0300
Message-Id: <20190719083949.5351-2-nborisov@suse.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190719083949.5351-1-nborisov@suse.com>
References: <20190719083949.5351-1-nborisov@suse.com>
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
 fs/btrfs/locking.c | 88 ++++++++++++++++++++++++++++++++++++++++++++++
 fs/btrfs/locking.h | 20 +++++++++++
 3 files changed, 109 insertions(+)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index da97ff10f421..b7c9359b24a0 100644
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
index 98fccce4208c..702c956ed028 100644
--- a/fs/btrfs/locking.c
+++ b/fs/btrfs/locking.c
@@ -354,3 +354,91 @@ void btrfs_tree_unlock(struct extent_buffer *eb)
 		write_unlock(&eb->lock);
 	}
 }
+
+
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
+EXPORT_SYMBOL(btrfs_drw_lock_init);
+
+void btrfs_drw_lock_destroy(struct btrfs_drw_lock *lock)
+{
+	percpu_counter_destroy(&lock->writers);
+}
+
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
+EXPORT_SYMBOL(btrfs_drw_try_write_lock);
+
+void btrfs_drw_write_lock(struct btrfs_drw_lock *lock)
+{
+	while (true) {
+		if (btrfs_drw_try_write_lock(lock))
+			return;
+		wait_event(lock->pending_writers, !atomic_read(&lock->readers));
+	}
+}
+EXPORT_SYMBOL(btrfs_drw_write_lock);
+
+void btrfs_drw_write_unlock(struct btrfs_drw_lock *lock)
+{
+	percpu_counter_dec(&lock->writers);
+	cond_wake_up(&lock->pending_readers);
+}
+EXPORT_SYMBOL(btrfs_drw_write_unlock);
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
+EXPORT_SYMBOL(btrfs_drw_read_lock);
+
+void btrfs_drw_read_unlock(struct btrfs_drw_lock *lock)
+{
+	/*
+	 * Atomic RMW operations imply full barrier, so woken up writers
+	 * are guaranteed to see the decrement
+	 */
+	if (atomic_dec_and_test(&lock->readers))
+		wake_up(&lock->pending_writers);
+}
+EXPORT_SYMBOL(btrfs_drw_read_unlock);
diff --git a/fs/btrfs/locking.h b/fs/btrfs/locking.h
index 595014f64830..44378c65f843 100644
--- a/fs/btrfs/locking.h
+++ b/fs/btrfs/locking.h
@@ -6,6 +6,10 @@
 #ifndef BTRFS_LOCKING_H
 #define BTRFS_LOCKING_H
 
+#include <linux/atomic.h>
+#include <linux/wait.h>
+#include <linux/percpu_counter.h>
+
 #define BTRFS_WRITE_LOCK 1
 #define BTRFS_READ_LOCK 2
 #define BTRFS_WRITE_LOCK_BLOCKING 3
@@ -39,4 +43,20 @@ static inline void btrfs_tree_unlock_rw(struct extent_buffer *eb, int rw)
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

