Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C195E14DB1E
	for <lists+linux-btrfs@lfdr.de>; Thu, 30 Jan 2020 14:00:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727272AbgA3M7w (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 30 Jan 2020 07:59:52 -0500
Received: from mx2.suse.de ([195.135.220.15]:38344 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726980AbgA3M7t (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 30 Jan 2020 07:59:49 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id E276BB01D;
        Thu, 30 Jan 2020 12:59:46 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 1/2] btrfs: Implement DRW lock
Date:   Thu, 30 Jan 2020 14:59:41 +0200
Message-Id: <20200130125945.7383-2-nborisov@suse.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200130125945.7383-1-nborisov@suse.com>
References: <20200130125945.7383-1-nborisov@suse.com>
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
 fs/btrfs/Makefile   |  2 +-
 fs/btrfs/drw_lock.c | 71 +++++++++++++++++++++++++++++++++++++++++++++
 fs/btrfs/drw_lock.h | 23 +++++++++++++++
 3 files changed, 95 insertions(+), 1 deletion(-)
 create mode 100644 fs/btrfs/drw_lock.c
 create mode 100644 fs/btrfs/drw_lock.h

diff --git a/fs/btrfs/Makefile b/fs/btrfs/Makefile
index ca693dd554e9..dc60127791e6 100644
--- a/fs/btrfs/Makefile
+++ b/fs/btrfs/Makefile
@@ -10,7 +10,7 @@ btrfs-y += super.o ctree.o extent-tree.o print-tree.o root-tree.o dir-item.o \
 	   export.o tree-log.o free-space-cache.o zlib.o lzo.o zstd.o \
 	   compression.o delayed-ref.o relocation.o delayed-inode.o scrub.o \
 	   reada.o backref.o ulist.o qgroup.o send.o dev-replace.o raid56.o \
-	   uuid-tree.o props.o free-space-tree.o tree-checker.o
+	   uuid-tree.o props.o free-space-tree.o tree-checker.o drw_lock.o
 
 btrfs-$(CONFIG_BTRFS_FS_POSIX_ACL) += acl.o
 btrfs-$(CONFIG_BTRFS_FS_CHECK_INTEGRITY) += check-integrity.o
diff --git a/fs/btrfs/drw_lock.c b/fs/btrfs/drw_lock.c
new file mode 100644
index 000000000000..9681bf7544be
--- /dev/null
+++ b/fs/btrfs/drw_lock.c
@@ -0,0 +1,71 @@
+#include "drw_lock.h"
+#include "ctree.h"
+
+void btrfs_drw_lock_init(struct btrfs_drw_lock *lock)
+{
+	atomic_set(&lock->readers, 0);
+	percpu_counter_init(&lock->writers, 0, GFP_KERNEL);
+	init_waitqueue_head(&lock->pending_readers);
+	init_waitqueue_head(&lock->pending_writers);
+}
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
+		btrfs_drw_read_unlock(lock);
+		return false;
+	}
+
+	return true;
+}
+
+void btrfs_drw_write_lock(struct btrfs_drw_lock *lock)
+{
+	while(true) {
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
+	smp_mb__after_atomic();
+
+	wait_event(lock->pending_readers,
+		   percpu_counter_sum(&lock->writers) == 0);
+}
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
+
+
diff --git a/fs/btrfs/drw_lock.h b/fs/btrfs/drw_lock.h
new file mode 100644
index 000000000000..baff59561c06
--- /dev/null
+++ b/fs/btrfs/drw_lock.h
@@ -0,0 +1,23 @@
+#ifndef BTRFS_DRW_LOCK_H
+#define BTRFS_DRW_LOCK_H
+
+#include <linux/atomic.h>
+#include <linux/wait.h>
+#include <linux/percpu_counter.h>
+
+struct btrfs_drw_lock {
+	atomic_t readers;
+	struct percpu_counter writers;
+	wait_queue_head_t pending_writers;
+	wait_queue_head_t pending_readers;
+};
+
+void btrfs_drw_lock_init(struct btrfs_drw_lock *lock);
+void btrfs_drw_lock_destroy(struct btrfs_drw_lock *lock);
+void btrfs_drw_write_lock(struct btrfs_drw_lock *lock);
+bool btrfs_drw_try_write_lock(struct btrfs_drw_lock *lock);
+void btrfs_drw_write_unlock(struct btrfs_drw_lock *lock);
+void btrfs_drw_read_lock(struct btrfs_drw_lock *lock);
+void btrfs_drw_read_unlock(struct btrfs_drw_lock *lock);
+
+#endif
-- 
2.17.1

