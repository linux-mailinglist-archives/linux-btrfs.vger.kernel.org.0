Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 017D816AA07
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Feb 2020 16:26:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727803AbgBXP0p (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 24 Feb 2020 10:26:45 -0500
Received: from mx2.suse.de ([195.135.220.15]:49004 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727670AbgBXP0o (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 24 Feb 2020 10:26:44 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 0F051AE24;
        Mon, 24 Feb 2020 15:26:42 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH v3 2/2] btrfs: Hook btrfs' DRW lock to locktorture infrastructure
Date:   Mon, 24 Feb 2020 17:26:37 +0200
Message-Id: <20200224152637.30774-3-nborisov@suse.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200224152637.30774-1-nborisov@suse.com>
References: <20200224152637.30774-1-nborisov@suse.com>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 fs/btrfs/locking.c           |  5 +++
 fs/btrfs/locking.h           |  1 +
 kernel/locking/locktorture.c | 77 +++++++++++++++++++++++++++++++++++-
 3 files changed, 82 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/locking.c b/fs/btrfs/locking.c
index d890833694c9..e7645f3fd9cd 100644
--- a/fs/btrfs/locking.c
+++ b/fs/btrfs/locking.c
@@ -614,6 +614,7 @@ bool btrfs_drw_try_write_lock(struct btrfs_drw_lock *lock)
 
 	return true;
 }
+EXPORT_SYMBOL(btrfs_drw_try_write_lock);
 
 void btrfs_drw_write_lock(struct btrfs_drw_lock *lock)
 {
@@ -623,12 +624,14 @@ void btrfs_drw_write_lock(struct btrfs_drw_lock *lock)
 		wait_event(lock->pending_writers, !atomic_read(&lock->readers));
 	}
 }
+EXPORT_SYMBOL(btrfs_drw_write_lock);
 
 void btrfs_drw_write_unlock(struct btrfs_drw_lock *lock)
 {
 	percpu_counter_dec(&lock->writers);
 	cond_wake_up(&lock->pending_readers);
 }
+EXPORT_SYMBOL(btrfs_drw_write_unlock);
 
 void btrfs_drw_read_lock(struct btrfs_drw_lock *lock)
 {
@@ -645,6 +648,7 @@ void btrfs_drw_read_lock(struct btrfs_drw_lock *lock)
 	wait_event(lock->pending_readers,
 		   percpu_counter_sum(&lock->writers) == 0);
 }
+EXPORT_SYMBOL(btrfs_drw_read_lock);
 
 void btrfs_drw_read_unlock(struct btrfs_drw_lock *lock)
 {
@@ -655,3 +659,4 @@ void btrfs_drw_read_unlock(struct btrfs_drw_lock *lock)
 	if (atomic_dec_and_test(&lock->readers))
 		wake_up(&lock->pending_writers);
 }
+EXPORT_SYMBOL(btrfs_drw_read_unlock);
diff --git a/fs/btrfs/locking.h b/fs/btrfs/locking.h
index ba60318c53d5..c56b0cf59357 100644
--- a/fs/btrfs/locking.h
+++ b/fs/btrfs/locking.h
@@ -10,6 +10,7 @@
 #include <linux/atomic.h>
 #include <linux/wait.h>
 #include <linux/percpu_counter.h>
+#include "extent_io.h"
 
 #define BTRFS_WRITE_LOCK 1
 #define BTRFS_READ_LOCK 2
diff --git a/kernel/locking/locktorture.c b/kernel/locking/locktorture.c
index 99475a66c94f..921afbd58fff 100644
--- a/kernel/locking/locktorture.c
+++ b/kernel/locking/locktorture.c
@@ -29,6 +29,8 @@
 #include <linux/slab.h>
 #include <linux/percpu-rwsem.h>
 #include <linux/torture.h>
+#include "../../fs/btrfs/ctree.h"
+#include "../../fs/btrfs/locking.h"
 
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Paul E. McKenney <paulmck@linux.ibm.com>");
@@ -84,6 +86,7 @@ struct lock_torture_ops {
 
 	unsigned long flags; /* for irq spinlocks */
 	const char *name;
+	bool multiple;
 };
 
 struct lock_torture_cxt {
@@ -599,6 +602,7 @@ static void torture_percpu_rwsem_up_read(void) __releases(pcpu_rwsem)
 	percpu_up_read(&pcpu_rwsem);
 }
 
+
 static struct lock_torture_ops percpu_rwsem_lock_ops = {
 	.init		= torture_percpu_rwsem_init,
 	.writelock	= torture_percpu_rwsem_down_write,
@@ -611,6 +615,76 @@ static struct lock_torture_ops percpu_rwsem_lock_ops = {
 	.name		= "percpu_rwsem_lock"
 };
 
+static struct btrfs_drw_lock torture_drw_lock;
+
+void torture_drw_init(void)
+{
+	BUG_ON(btrfs_drw_lock_init(&torture_drw_lock));
+}
+
+static int torture_drw_write_lock(void) __acquires(torture_drw_lock)
+{
+	btrfs_drw_write_lock(&torture_drw_lock);
+	return 0;
+}
+
+static void torture_drw_write_unlock(void) __releases(torture_drw_lock)
+{
+	btrfs_drw_write_unlock(&torture_drw_lock);
+}
+
+static int torture_drw_read_lock(void) __acquires(torture_drw_lock)
+{
+	btrfs_drw_read_lock(&torture_drw_lock);
+	return 0;
+}
+
+static void torture_drw_read_unlock(void) __releases(torture_drw_lock)
+{
+	btrfs_drw_read_unlock(&torture_drw_lock);
+}
+
+static void torture_drw_write_delay(struct torture_random_state *trsp)
+{
+	const unsigned long longdelay_ms = 100;
+
+	/* We want a long delay occasionally to force massive contention.  */
+	if (!(torture_random(trsp) %
+	      (cxt.nrealwriters_stress * 2000 * longdelay_ms)))
+		mdelay(longdelay_ms * 10);
+	else
+		mdelay(longdelay_ms / 10);
+	if (!(torture_random(trsp) % (cxt.nrealwriters_stress * 20000)))
+		torture_preempt_schedule();  /* Allow test to be preempted. */
+}
+
+static void torture_drw_read_delay(struct torture_random_state *trsp)
+{
+	const unsigned long longdelay_ms = 100;
+
+	/* We want a long delay occasionally to force massive contention.  */
+	if (!(torture_random(trsp) %
+	      (cxt.nrealreaders_stress * 2000 * longdelay_ms)))
+		mdelay(longdelay_ms * 2);
+	else
+		mdelay(longdelay_ms / 2);
+	if (!(torture_random(trsp) % (cxt.nrealreaders_stress * 20000)))
+		torture_preempt_schedule();  /* Allow test to be preempted. */
+}
+
+static struct lock_torture_ops btrfs_drw_lock_ops = {
+	.init		= torture_drw_init,
+	.writelock	= torture_drw_write_lock,
+	.write_delay	= torture_drw_write_delay,
+	.task_boost     = torture_boost_dummy,
+	.writeunlock	= torture_drw_write_unlock,
+	.readlock       = torture_drw_read_lock,
+	.read_delay     = torture_drw_read_delay, /* figure what to do with this */
+	.readunlock     = torture_drw_read_unlock,
+	.multiple = true,
+	.name		= "btrfs_drw_lock"
+};
+
 /*
  * Lock torture writer kthread.  Repeatedly acquires and releases
  * the lock, checking for duplicate acquisitions.
@@ -629,7 +703,7 @@ static int lock_torture_writer(void *arg)
 
 		cxt.cur_ops->task_boost(&rand);
 		cxt.cur_ops->writelock();
-		if (WARN_ON_ONCE(lock_is_write_held))
+		if (!cxt.cur_ops->multiple && WARN_ON_ONCE(lock_is_write_held))
 			lwsp->n_lock_fail++;
 		lock_is_write_held = 1;
 		if (WARN_ON_ONCE(lock_is_read_held))
@@ -851,6 +925,7 @@ static int __init lock_torture_init(void)
 #endif
 		&rwsem_lock_ops,
 		&percpu_rwsem_lock_ops,
+		&btrfs_drw_lock_ops
 	};
 
 	if (!torture_init_begin(torture_type, verbose))
-- 
2.17.1

