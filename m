Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 330EE6E2D3
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Jul 2019 10:48:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726769AbfGSIsP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 19 Jul 2019 04:48:15 -0400
Received: from mx2.suse.de ([195.135.220.15]:38000 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726402AbfGSIsP (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 19 Jul 2019 04:48:15 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id F04C3AF10;
        Fri, 19 Jul 2019 08:48:12 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     paulmck@linux.ibm.com, linux-kernel@vger.kernel.org,
        Nikolay Borisov <nborisov@suse.com>
Subject: [RFC PATCH] btrfs: Hook btrfs' DRW lock to locktorture infrastructure
Date:   Fri, 19 Jul 2019 11:48:08 +0300
Message-Id: <20190719084808.5877-1-nborisov@suse.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190719083949.5351-1-nborisov@suse.com>
References: <20190719083949.5351-1-nborisov@suse.com>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---

Hello Paul, 

Here is the code I used to test the DRW lock via the lock torture infrastructure. 
It's rather ugly but got the job done for me. It's definitely not in a mergeable
form. At the very least I think including btrfs headers constitutes a violation 
of separation of different subsystems. Would it be acceptable to guard them 
behind something like "#if BTRFS && BTRFS_DEBUG" ? 

I'm really posting this just for posterity/provenance purposes. I'm fine with 
dropping the patch. 


 fs/btrfs/locking.h           |  1 +
 kernel/locking/locktorture.c | 77 +++++++++++++++++++++++++++++++++++-
 2 files changed, 77 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/locking.h b/fs/btrfs/locking.h
index 44378c65f843..27627d4fd3a9 100644
--- a/fs/btrfs/locking.h
+++ b/fs/btrfs/locking.h
@@ -9,6 +9,7 @@
 #include <linux/atomic.h>
 #include <linux/wait.h>
 #include <linux/percpu_counter.h>
+#include "extent_io.h"
 
 #define BTRFS_WRITE_LOCK 1
 #define BTRFS_READ_LOCK 2
diff --git a/kernel/locking/locktorture.c b/kernel/locking/locktorture.c
index 80a463d31a8d..774e10a25876 100644
--- a/kernel/locking/locktorture.c
+++ b/kernel/locking/locktorture.c
@@ -30,6 +30,8 @@
 #include <linux/slab.h>
 #include <linux/percpu-rwsem.h>
 #include <linux/torture.h>
+#include "../../fs/btrfs/ctree.h"
+#include "../../fs/btrfs/locking.h"
 
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Paul E. McKenney <paulmck@linux.ibm.com>");
@@ -85,6 +87,7 @@ struct lock_torture_ops {
 
 	unsigned long flags; /* for irq spinlocks */
 	const char *name;
+	bool multiple;
 };
 
 struct lock_torture_cxt {
@@ -600,6 +603,7 @@ static void torture_percpu_rwsem_up_read(void) __releases(pcpu_rwsem)
 	percpu_up_read(&pcpu_rwsem);
 }
 
+
 static struct lock_torture_ops percpu_rwsem_lock_ops = {
 	.init		= torture_percpu_rwsem_init,
 	.writelock	= torture_percpu_rwsem_down_write,
@@ -612,6 +616,76 @@ static struct lock_torture_ops percpu_rwsem_lock_ops = {
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
@@ -630,7 +704,7 @@ static int lock_torture_writer(void *arg)
 
 		cxt.cur_ops->task_boost(&rand);
 		cxt.cur_ops->writelock();
-		if (WARN_ON_ONCE(lock_is_write_held))
+		if (!cxt.cur_ops->multiple && WARN_ON_ONCE(lock_is_write_held))
 			lwsp->n_lock_fail++;
 		lock_is_write_held = 1;
 		if (WARN_ON_ONCE(lock_is_read_held))
@@ -852,6 +926,7 @@ static int __init lock_torture_init(void)
 #endif
 		&rwsem_lock_ops,
 		&percpu_rwsem_lock_ops,
+		&btrfs_drw_lock_ops
 	};
 
 	if (!torture_init_begin(torture_type, verbose))
-- 
2.17.1

