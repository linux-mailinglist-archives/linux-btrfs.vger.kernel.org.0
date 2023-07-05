Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D6E97491FB
	for <lists+linux-btrfs@lfdr.de>; Thu,  6 Jul 2023 01:42:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232011AbjGEXl7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 5 Jul 2023 19:41:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232007AbjGEXl6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 5 Jul 2023 19:41:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A86F1FE2
        for <linux-btrfs@vger.kernel.org>; Wed,  5 Jul 2023 16:41:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4241D61790
        for <linux-btrfs@vger.kernel.org>; Wed,  5 Jul 2023 23:41:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29C29C433C8
        for <linux-btrfs@vger.kernel.org>; Wed,  5 Jul 2023 23:41:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688600479;
        bh=58XSNG6I4fZJD/JyyKGfBP2plbSKBvnuwHh7J3oxqEE=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=GNRBV4/PSvexu4bYGAFOwuUFvVEXPOmjVvPVBePj78Z0w4CQhrfycar8w5thEZyL+
         ajkzP9LY7URhEMPJu1FEgSkOyUH7eHTwc5AAGUak46PXoS2H/3fmkD3fIM6OQWDEJA
         mTHKges06ALH2xuUPCrZu6e7D412V75Xu0BSD5C24xdM1WqlZmmIapV4GGxX8/7U8Y
         C/FkTeSRUPNEsyAkcyOf2MORr6BpZs7NKA0sDZLeepw12/HBH5M42jirJ+7iU7Y0xD
         kfhFmeIeefItp+uFLOxAfeNI9emiIVqOieZSHJfdS0p/na2zJaF2U6W4cGyB5c5XQc
         oZgdYOQlHW1zA==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2] btrfs: use irq safe locking when running and adding delayed iputs
Date:   Thu,  6 Jul 2023 00:41:16 +0100
Message-Id: <62367efff4973c3cce75d17fb57f0c9b28cc98fe.1688600170.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <51c4f7d153137c3bd79b3372bc8ba4d7b6717534.1688584524.git.fdmanana@suse.com>
References: <51c4f7d153137c3bd79b3372bc8ba4d7b6717534.1688584524.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

Running delayed iputs, which never happens in an irq context, needs to
lock the spinlock fs_info->delayed_iput_lock. When finishing bios for
data writes (irq context, bio.c) we call btrfs_put_ordered_extent() which
needs to add a delayed iput and for that it needs to acquire the spinlock
fs_info->delayed_iput_lock. Without disabling irqs when running delayed
iputs we can therefore deadlock on that spinlock. The same deadlock can
also happen when adding an inode to the delayed iputs list, since this
can be done outside an irq context as well.

Syzbot recently reported this, which results in the following trace:

  ================================
  WARNING: inconsistent lock state
  6.4.0-syzkaller-09904-ga507db1d8fdc #0 Not tainted
  --------------------------------
  inconsistent {IN-SOFTIRQ-W} -> {SOFTIRQ-ON-W} usage.
  btrfs-cleaner/16079 [HC0[0]:SC0[0]:HE1:SE1] takes:
  ffff888107804d20 (&fs_info->delayed_iput_lock){+.?.}-{2:2}, at: spin_lock include/linux/spinlock.h:350 [inline]
  ffff888107804d20 (&fs_info->delayed_iput_lock){+.?.}-{2:2}, at: btrfs_run_delayed_iputs+0x28/0xe0 fs/btrfs/inode.c:3523
  {IN-SOFTIRQ-W} state was registered at:
    lock_acquire kernel/locking/lockdep.c:5761 [inline]
    lock_acquire+0x1b1/0x520 kernel/locking/lockdep.c:5726
    __raw_spin_lock include/linux/spinlock_api_smp.h:133 [inline]
    _raw_spin_lock+0x2e/0x40 kernel/locking/spinlock.c:154
    spin_lock include/linux/spinlock.h:350 [inline]
    btrfs_add_delayed_iput+0x128/0x390 fs/btrfs/inode.c:3490
    btrfs_put_ordered_extent fs/btrfs/ordered-data.c:559 [inline]
    btrfs_put_ordered_extent+0x2f6/0x610 fs/btrfs/ordered-data.c:547
    __btrfs_bio_end_io fs/btrfs/bio.c:118 [inline]
    __btrfs_bio_end_io+0x136/0x180 fs/btrfs/bio.c:112
    btrfs_orig_bbio_end_io+0x86/0x2b0 fs/btrfs/bio.c:163
    btrfs_simple_end_io+0x105/0x380 fs/btrfs/bio.c:378
    bio_endio+0x589/0x690 block/bio.c:1617
    req_bio_endio block/blk-mq.c:766 [inline]
    blk_update_request+0x5c5/0x1620 block/blk-mq.c:911
    blk_mq_end_request+0x59/0x680 block/blk-mq.c:1032
    lo_complete_rq+0x1c6/0x280 drivers/block/loop.c:370
    blk_complete_reqs+0xb3/0xf0 block/blk-mq.c:1110
    __do_softirq+0x1d4/0x905 kernel/softirq.c:553
    run_ksoftirqd kernel/softirq.c:921 [inline]
    run_ksoftirqd+0x31/0x60 kernel/softirq.c:913
    smpboot_thread_fn+0x659/0x9e0 kernel/smpboot.c:164
    kthread+0x344/0x440 kernel/kthread.c:389
    ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308
  irq event stamp: 39
  hardirqs last  enabled at (39): [<ffffffff81d5ebc4>] __do_kmem_cache_free mm/slab.c:3558 [inline]
  hardirqs last  enabled at (39): [<ffffffff81d5ebc4>] kmem_cache_free mm/slab.c:3582 [inline]
  hardirqs last  enabled at (39): [<ffffffff81d5ebc4>] kmem_cache_free+0x244/0x370 mm/slab.c:3575
  hardirqs last disabled at (38): [<ffffffff81d5eb5e>] __do_kmem_cache_free mm/slab.c:3553 [inline]
  hardirqs last disabled at (38): [<ffffffff81d5eb5e>] kmem_cache_free mm/slab.c:3582 [inline]
  hardirqs last disabled at (38): [<ffffffff81d5eb5e>] kmem_cache_free+0x1de/0x370 mm/slab.c:3575
  softirqs last  enabled at (0): [<ffffffff814ac99f>] copy_process+0x227f/0x75c0 kernel/fork.c:2448
  softirqs last disabled at (0): [<0000000000000000>] 0x0

  other info that might help us debug this:
   Possible unsafe locking scenario:

         CPU0
         ----
    lock(&fs_info->delayed_iput_lock);
    <Interrupt>
      lock(&fs_info->delayed_iput_lock);

   *** DEADLOCK ***

  1 lock held by btrfs-cleaner/16079:
   #0: ffff888107804860 (&fs_info->cleaner_mutex){+.+.}-{3:3}, at: cleaner_kthread+0x103/0x4b0 fs/btrfs/disk-io.c:1463

  stack backtrace:
  CPU: 3 PID: 16079 Comm: btrfs-cleaner Not tainted 6.4.0-syzkaller-09904-ga507db1d8fdc #0
  Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.14.0-2 04/01/2014
  Call Trace:
   <TASK>
   __dump_stack lib/dump_stack.c:88 [inline]
   dump_stack_lvl+0xd9/0x150 lib/dump_stack.c:106
   print_usage_bug kernel/locking/lockdep.c:3978 [inline]
   valid_state kernel/locking/lockdep.c:4020 [inline]
   mark_lock_irq kernel/locking/lockdep.c:4223 [inline]
   mark_lock.part.0+0x1102/0x1960 kernel/locking/lockdep.c:4685
   mark_lock kernel/locking/lockdep.c:4649 [inline]
   mark_usage kernel/locking/lockdep.c:4598 [inline]
   __lock_acquire+0x8e4/0x5e20 kernel/locking/lockdep.c:5098
   lock_acquire kernel/locking/lockdep.c:5761 [inline]
   lock_acquire+0x1b1/0x520 kernel/locking/lockdep.c:5726
   __raw_spin_lock include/linux/spinlock_api_smp.h:133 [inline]
   _raw_spin_lock+0x2e/0x40 kernel/locking/spinlock.c:154
   spin_lock include/linux/spinlock.h:350 [inline]
   btrfs_run_delayed_iputs+0x28/0xe0 fs/btrfs/inode.c:3523
   cleaner_kthread+0x2e5/0x4b0 fs/btrfs/disk-io.c:1478
   kthread+0x344/0x440 kernel/kthread.c:389
   ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308
   </TASK>

So fix this by using spin_lock_irq() and spin_unlock_irq() when running
delayed iputs, and using spin_lock_irqsave() and spin_unlock_irqrestore()
when adding a delayed iput().

Reported-by: syzbot+da501a04be5ff533b102@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/linux-btrfs/000000000000d5c89a05ffbd39dd@google.com/
Fixes: ec63b84d4611 ("btrfs: add an ordered_extent pointer to struct btrfs_bio")
Signed-off-by: Filipe Manana <fdmanana@suse.com>
---

V2: Also make adding delayed iputs irq safe.
    Changed patch subject from:

    "btrfs: use spin_lock_irq() when running delayed iputs"

    to

    "btrfs: use irq safe locking when running and adding delayed iputs"

 fs/btrfs/inode.c | 35 +++++++++++++++++++++++++----------
 1 file changed, 25 insertions(+), 10 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index c8921589e2f3..b12850b31cb3 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -3482,15 +3482,21 @@ bool btrfs_data_csum_ok(struct btrfs_bio *bbio, struct btrfs_device *dev,
 void btrfs_add_delayed_iput(struct btrfs_inode *inode)
 {
 	struct btrfs_fs_info *fs_info = inode->root->fs_info;
+	unsigned long flags;
 
 	if (atomic_add_unless(&inode->vfs_inode.i_count, -1, 1))
 		return;
 
 	atomic_inc(&fs_info->nr_delayed_iputs);
-	spin_lock(&fs_info->delayed_iput_lock);
+	/*
+	 * Need to be irq safe here because we can be called from either an irq
+	 * context (see bio.c and btrfs_put_ordered_extent()) or a non-irq
+	 * context.
+	 */
+	spin_lock_irqsave(&fs_info->delayed_iput_lock, flags);
 	ASSERT(list_empty(&inode->delayed_iput));
 	list_add_tail(&inode->delayed_iput, &fs_info->delayed_iputs);
-	spin_unlock(&fs_info->delayed_iput_lock);
+	spin_unlock_irqrestore(&fs_info->delayed_iput_lock, flags);
 	if (!test_bit(BTRFS_FS_CLEANER_RUNNING, &fs_info->flags))
 		wake_up_process(fs_info->cleaner_kthread);
 }
@@ -3499,37 +3505,46 @@ static void run_delayed_iput_locked(struct btrfs_fs_info *fs_info,
 				    struct btrfs_inode *inode)
 {
 	list_del_init(&inode->delayed_iput);
-	spin_unlock(&fs_info->delayed_iput_lock);
+	spin_unlock_irq(&fs_info->delayed_iput_lock);
 	iput(&inode->vfs_inode);
 	if (atomic_dec_and_test(&fs_info->nr_delayed_iputs))
 		wake_up(&fs_info->delayed_iputs_wait);
-	spin_lock(&fs_info->delayed_iput_lock);
+	spin_lock_irq(&fs_info->delayed_iput_lock);
 }
 
 static void btrfs_run_delayed_iput(struct btrfs_fs_info *fs_info,
 				   struct btrfs_inode *inode)
 {
 	if (!list_empty(&inode->delayed_iput)) {
-		spin_lock(&fs_info->delayed_iput_lock);
+		spin_lock_irq(&fs_info->delayed_iput_lock);
 		if (!list_empty(&inode->delayed_iput))
 			run_delayed_iput_locked(fs_info, inode);
-		spin_unlock(&fs_info->delayed_iput_lock);
+		spin_unlock_irq(&fs_info->delayed_iput_lock);
 	}
 }
 
 void btrfs_run_delayed_iputs(struct btrfs_fs_info *fs_info)
 {
-
-	spin_lock(&fs_info->delayed_iput_lock);
+	/*
+	 * btrfs_put_ordered_extent() can run in irq context (see bio.c), which
+	 * calls btrfs_add_delayed_iput() and that needs to lock
+	 * fs_info->delayed_iput_lock. So we need to disable irqs here to
+	 * prevent a deadlock.
+	 */
+	spin_lock_irq(&fs_info->delayed_iput_lock);
 	while (!list_empty(&fs_info->delayed_iputs)) {
 		struct btrfs_inode *inode;
 
 		inode = list_first_entry(&fs_info->delayed_iputs,
 				struct btrfs_inode, delayed_iput);
 		run_delayed_iput_locked(fs_info, inode);
-		cond_resched_lock(&fs_info->delayed_iput_lock);
+		if (need_resched()) {
+			spin_unlock_irq(&fs_info->delayed_iput_lock);
+			cond_resched();
+			spin_lock_irq(&fs_info->delayed_iput_lock);
+		}
 	}
-	spin_unlock(&fs_info->delayed_iput_lock);
+	spin_unlock_irq(&fs_info->delayed_iput_lock);
 }
 
 /*
-- 
2.34.1

