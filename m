Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05C2D7E02C5
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 Nov 2023 13:26:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346858AbjKCM0e (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 3 Nov 2023 08:26:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346700AbjKCM0d (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 3 Nov 2023 08:26:33 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2790B191
        for <linux-btrfs@vger.kernel.org>; Fri,  3 Nov 2023 05:26:30 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3676EC433C8
        for <linux-btrfs@vger.kernel.org>; Fri,  3 Nov 2023 12:26:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699014389;
        bh=dzE4bKY0pbUyGgOHm9sRsGOVv/yCOq1egatm2e5ZD+Q=;
        h=From:To:Subject:Date:From;
        b=nIn7UcRC+iacRC74rxfGSctj0pXNH1Z2RQ1y8Kdt/T4BtmWf5GToEmY0ztACE1Zf6
         Bz4f64CTRWdgzrqqDjDGfFXcnU2xwK9lgRxHD3yJw6wkt8k9AEkgzNawWo0Q6qVVPN
         fZn+18Dx6NWwJLyvfzVj6rzPDPHLTIt224QtOVOMeBIvMJUSxZ2A7FxqjXM25szPwp
         zOB1ivqYiaCTOFIOZQXsCgBfADiaAi4ln3UKFjIT0LBnX7fiKZGTVDNaDJ6QFcBzVq
         jOmu9Tlkg/g+ROYYYGhN8snywCnviJjo0f1M8IMUvOVtwZHKWFWoVG954j1gtiNGPq
         4t44NbT2qCb7w==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: fix race between accounting qgroup extents and removing a qgroup
Date:   Fri,  3 Nov 2023 12:26:25 +0000
Message-Id: <c339c5643ceba67771b559ffae0fb4c169426cef.1699014305.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

When doing qgroup accounting for an extent, we take the spinlock
fs_info->qgroup_lock and then add qgroups to the local list (iterator)
named "qgroups". These qgroups are found in the fs_info->qgroup_tree
rbtree. After we're done, we unlock fs_info->qgroup_lock and then call
qgroup_iterator_nested_clean(), which will iterate over all the qgroups
added to the local list "qgroups" and then delete them from the list.
Deleting a qgroup from the list can however result in a use-after-free
if a qgroup remove operation happens after we unlock fs_info->qgroup_lock
and before or while we are at qgroup_iterator_nested_clean().

Fix this by calling qgroup_iterator_nested_clean() while still holding
the lock fs_info->qgroup_lock - we don't need it under the 'out' label
since before taking the lock the "qgroups" list is always empty. This
guarantees safety because btrfs_remove_qgroup() takes that lock before
removing a qgroup from the rbtree fs_info->qgroup_tree.

This was reported by syzbot with the following stack traces:

   BUG: KASAN: slab-use-after-free in __list_del_entry_valid_or_report+0x2f/0x130 lib/list_debug.c:49
   Read of size 8 at addr ffff888027e420b0 by task kworker/u4:3/48

   CPU: 1 PID: 48 Comm: kworker/u4:3 Not tainted 6.6.0-syzkaller-10396-g4652b8e4f3ff #0
   Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/09/2023
   Workqueue: btrfs-qgroup-rescan btrfs_work_helper
   Call Trace:
    <TASK>
    __dump_stack lib/dump_stack.c:88 [inline]
    dump_stack_lvl+0x1e7/0x2d0 lib/dump_stack.c:106
    print_address_description mm/kasan/report.c:364 [inline]
    print_report+0x163/0x540 mm/kasan/report.c:475
    kasan_report+0x175/0x1b0 mm/kasan/report.c:588
    __list_del_entry_valid_or_report+0x2f/0x130 lib/list_debug.c:49
    __list_del_entry_valid include/linux/list.h:124 [inline]
    __list_del_entry include/linux/list.h:215 [inline]
    list_del_init include/linux/list.h:287 [inline]
    qgroup_iterator_nested_clean fs/btrfs/qgroup.c:2623 [inline]
    btrfs_qgroup_account_extent+0x18b/0x1150 fs/btrfs/qgroup.c:2883
    qgroup_rescan_leaf fs/btrfs/qgroup.c:3543 [inline]
    btrfs_qgroup_rescan_worker+0x1078/0x1c60 fs/btrfs/qgroup.c:3604
    btrfs_work_helper+0x37c/0xbd0 fs/btrfs/async-thread.c:315
    process_one_work kernel/workqueue.c:2630 [inline]
    process_scheduled_works+0x90f/0x1400 kernel/workqueue.c:2703
    worker_thread+0xa5f/0xff0 kernel/workqueue.c:2784
    kthread+0x2d3/0x370 kernel/kthread.c:388
    ret_from_fork+0x48/0x80 arch/x86/kernel/process.c:147
    ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:242
    </TASK>

   Allocated by task 6355:
    kasan_save_stack mm/kasan/common.c:45 [inline]
    kasan_set_track+0x4f/0x70 mm/kasan/common.c:52
    ____kasan_kmalloc mm/kasan/common.c:374 [inline]
    __kasan_kmalloc+0x98/0xb0 mm/kasan/common.c:383
    kmalloc include/linux/slab.h:600 [inline]
    kzalloc include/linux/slab.h:721 [inline]
    btrfs_quota_enable+0xee9/0x2060 fs/btrfs/qgroup.c:1209
    btrfs_ioctl_quota_ctl+0x143/0x190 fs/btrfs/ioctl.c:3705
    vfs_ioctl fs/ioctl.c:51 [inline]
    __do_sys_ioctl fs/ioctl.c:871 [inline]
    __se_sys_ioctl+0xf8/0x170 fs/ioctl.c:857
    do_syscall_x64 arch/x86/entry/common.c:51 [inline]
    do_syscall_64+0x44/0x110 arch/x86/entry/common.c:82
    entry_SYSCALL_64_after_hwframe+0x63/0x6b

   Freed by task 6355:
    kasan_save_stack mm/kasan/common.c:45 [inline]
    kasan_set_track+0x4f/0x70 mm/kasan/common.c:52
    kasan_save_free_info+0x28/0x40 mm/kasan/generic.c:522
    ____kasan_slab_free+0xd6/0x120 mm/kasan/common.c:236
    kasan_slab_free include/linux/kasan.h:164 [inline]
    slab_free_hook mm/slub.c:1800 [inline]
    slab_free_freelist_hook mm/slub.c:1826 [inline]
    slab_free mm/slub.c:3809 [inline]
    __kmem_cache_free+0x263/0x3a0 mm/slub.c:3822
    btrfs_remove_qgroup+0x764/0x8c0 fs/btrfs/qgroup.c:1787
    btrfs_ioctl_qgroup_create+0x185/0x1e0 fs/btrfs/ioctl.c:3811
    vfs_ioctl fs/ioctl.c:51 [inline]
    __do_sys_ioctl fs/ioctl.c:871 [inline]
    __se_sys_ioctl+0xf8/0x170 fs/ioctl.c:857
    do_syscall_x64 arch/x86/entry/common.c:51 [inline]
    do_syscall_64+0x44/0x110 arch/x86/entry/common.c:82
    entry_SYSCALL_64_after_hwframe+0x63/0x6b

   Last potentially related work creation:
    kasan_save_stack+0x3f/0x60 mm/kasan/common.c:45
    __kasan_record_aux_stack+0xad/0xc0 mm/kasan/generic.c:492
    __call_rcu_common kernel/rcu/tree.c:2667 [inline]
    call_rcu+0x167/0xa70 kernel/rcu/tree.c:2781
    kthread_worker_fn+0x4ba/0xa90 kernel/kthread.c:823
    kthread+0x2d3/0x370 kernel/kthread.c:388
    ret_from_fork+0x48/0x80 arch/x86/kernel/process.c:147
    ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:242

   Second to last potentially related work creation:
    kasan_save_stack+0x3f/0x60 mm/kasan/common.c:45
    __kasan_record_aux_stack+0xad/0xc0 mm/kasan/generic.c:492
    __call_rcu_common kernel/rcu/tree.c:2667 [inline]
    call_rcu+0x167/0xa70 kernel/rcu/tree.c:2781
    kthread_worker_fn+0x4ba/0xa90 kernel/kthread.c:823
    kthread+0x2d3/0x370 kernel/kthread.c:388
    ret_from_fork+0x48/0x80 arch/x86/kernel/process.c:147
    ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:242

   The buggy address belongs to the object at ffff888027e42000
    which belongs to the cache kmalloc-512 of size 512
   The buggy address is located 176 bytes inside of
    freed 512-byte region [ffff888027e42000, ffff888027e42200)

   The buggy address belongs to the physical page:
   page:ffffea00009f9000 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x27e40
   head:ffffea00009f9000 order:2 entire_mapcount:0 nr_pages_mapped:0 pincount:0
   flags: 0xfff00000000840(slab|head|node=0|zone=1|lastcpupid=0x7ff)
   page_type: 0xffffffff()
   raw: 00fff00000000840 ffff888012c41c80 ffffea0000a5ba00 dead000000000002
   raw: 0000000000000000 0000000080100010 00000001ffffffff 0000000000000000
   page dumped because: kasan: bad access detected
   page_owner tracks the page as allocated
   page last allocated via order 2, migratetype Unmovable, gfp_mask 0xd20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 4514, tgid 4514 (udevadm), ts 24598439480, free_ts 23755696267
    set_page_owner include/linux/page_owner.h:31 [inline]
    post_alloc_hook+0x1e6/0x210 mm/page_alloc.c:1536
    prep_new_page mm/page_alloc.c:1543 [inline]
    get_page_from_freelist+0x31db/0x3360 mm/page_alloc.c:3170
    __alloc_pages+0x255/0x670 mm/page_alloc.c:4426
    alloc_slab_page+0x6a/0x160 mm/slub.c:1870
    allocate_slab mm/slub.c:2017 [inline]
    new_slab+0x84/0x2f0 mm/slub.c:2070
    ___slab_alloc+0xc85/0x1310 mm/slub.c:3223
    __slab_alloc mm/slub.c:3322 [inline]
    __slab_alloc_node mm/slub.c:3375 [inline]
    slab_alloc_node mm/slub.c:3468 [inline]
    __kmem_cache_alloc_node+0x19d/0x270 mm/slub.c:3517
    kmalloc_trace+0x2a/0xe0 mm/slab_common.c:1098
    kmalloc include/linux/slab.h:600 [inline]
    kzalloc include/linux/slab.h:721 [inline]
    kernfs_fop_open+0x3e7/0xcc0 fs/kernfs/file.c:670
    do_dentry_open+0x8fd/0x1590 fs/open.c:948
    do_open fs/namei.c:3622 [inline]
    path_openat+0x2845/0x3280 fs/namei.c:3779
    do_filp_open+0x234/0x490 fs/namei.c:3809
    do_sys_openat2+0x13e/0x1d0 fs/open.c:1440
    do_sys_open fs/open.c:1455 [inline]
    __do_sys_openat fs/open.c:1471 [inline]
    __se_sys_openat fs/open.c:1466 [inline]
    __x64_sys_openat+0x247/0x290 fs/open.c:1466
    do_syscall_x64 arch/x86/entry/common.c:51 [inline]
    do_syscall_64+0x44/0x110 arch/x86/entry/common.c:82
    entry_SYSCALL_64_after_hwframe+0x63/0x6b
   page last free stack trace:
    reset_page_owner include/linux/page_owner.h:24 [inline]
    free_pages_prepare mm/page_alloc.c:1136 [inline]
    free_unref_page_prepare+0x8c3/0x9f0 mm/page_alloc.c:2312
    free_unref_page+0x37/0x3f0 mm/page_alloc.c:2405
    discard_slab mm/slub.c:2116 [inline]
    __unfreeze_partials+0x1dc/0x220 mm/slub.c:2655
    put_cpu_partial+0x17b/0x250 mm/slub.c:2731
    __slab_free+0x2b6/0x390 mm/slub.c:3679
    qlink_free mm/kasan/quarantine.c:166 [inline]
    qlist_free_all+0x75/0xe0 mm/kasan/quarantine.c:185
    kasan_quarantine_reduce+0x14b/0x160 mm/kasan/quarantine.c:292
    __kasan_slab_alloc+0x23/0x70 mm/kasan/common.c:305
    kasan_slab_alloc include/linux/kasan.h:188 [inline]
    slab_post_alloc_hook+0x67/0x3d0 mm/slab.h:762
    slab_alloc_node mm/slub.c:3478 [inline]
    slab_alloc mm/slub.c:3486 [inline]
    __kmem_cache_alloc_lru mm/slub.c:3493 [inline]
    kmem_cache_alloc+0x104/0x2c0 mm/slub.c:3502
    getname_flags+0xbc/0x4f0 fs/namei.c:140
    do_sys_openat2+0xd2/0x1d0 fs/open.c:1434
    do_sys_open fs/open.c:1455 [inline]
    __do_sys_openat fs/open.c:1471 [inline]
    __se_sys_openat fs/open.c:1466 [inline]
    __x64_sys_openat+0x247/0x290 fs/open.c:1466
    do_syscall_x64 arch/x86/entry/common.c:51 [inline]
    do_syscall_64+0x44/0x110 arch/x86/entry/common.c:82
    entry_SYSCALL_64_after_hwframe+0x63/0x6b

   Memory state around the buggy address:
    ffff888027e41f80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
    ffff888027e42000: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
   >ffff888027e42080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                        ^
    ffff888027e42100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
    ffff888027e42180: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb

Fixes: dce28769a33a ("btrfs: qgroup: use qgroup_iterator_nested to in qgroup_update_refcnt()")
Reported-by: syzbot+e0b615318f8fcfc01ceb@syzkaller.appspotmail.com
Link: https://lore.kernel.org/linux-btrfs/00000000000091a5b2060936bf6d@google.com/
Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/qgroup.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
index edb84cc03237..e48eba7e9379 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -2874,13 +2874,19 @@ int btrfs_qgroup_account_extent(struct btrfs_trans_handle *trans, u64 bytenr,
 	qgroup_update_counters(fs_info, &qgroups, nr_old_roots, nr_new_roots,
 			       num_bytes, seq);
 
+	/*
+	 * We're done using the iterator, release all its qgroups while holding
+	 * fs_info->qgroup_lock so that we don't race with btrfs_remove_qgroup()
+	 * and trigger use-after-free accesses to qgroups.
+	 */
+	qgroup_iterator_nested_clean(&qgroups);
+
 	/*
 	 * Bump qgroup_seq to avoid seq overlap
 	 */
 	fs_info->qgroup_seq += max(nr_old_roots, nr_new_roots) + 1;
 	spin_unlock(&fs_info->qgroup_lock);
 out_free:
-	qgroup_iterator_nested_clean(&qgroups);
 	ulist_free(old_roots);
 	ulist_free(new_roots);
 	return ret;
-- 
2.40.1

