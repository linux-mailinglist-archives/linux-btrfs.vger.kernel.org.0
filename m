Return-Path: <linux-btrfs+bounces-11016-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ADCEA17262
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 Jan 2025 18:48:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E88A73A9A0D
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 Jan 2025 17:47:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1992F1EE7BC;
	Mon, 20 Jan 2025 17:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iqMbjJ+F"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4079B1EE7AD
	for <linux-btrfs@vger.kernel.org>; Mon, 20 Jan 2025 17:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737395186; cv=none; b=krzHcIjUwuM2KmBkpg0vOMne7GYGp8kTt+IetL/3lHrK90Vc+sAnN83o830KmR4bIT3lAmpsmWrc9DRRfxNqbmpH9K/k77lS/k1hGLVQEF2fl+ySutSiocUOxiBfPH6F+0PnBmMeXNeiP2zH6MD/b8+hnQhBDBkxjwEb+KQBFW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737395186; c=relaxed/simple;
	bh=USO2xZcIYsXc5q4o6UC0z8qPCo+E+LGy9bFKYZ7ZMbY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=KcuCQgieqizd9uchXTXMvCMLORoUdNAAfhv6Y2psnP9fJVrs1nvlSwmysElubpH6PT/bHjpj4O5sndecogBKVpZUWFP1YwxnaAEwhBxSyCINBljsgxDUGKjeUBrEr9aOFjHTXrLEa/K4OG5DXY42wNLSN90CWNV1gSvyegOiXco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iqMbjJ+F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F02E8C4CEE2;
	Mon, 20 Jan 2025 17:46:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737395185;
	bh=USO2xZcIYsXc5q4o6UC0z8qPCo+E+LGy9bFKYZ7ZMbY=;
	h=From:To:Cc:Subject:Date:From;
	b=iqMbjJ+F9JnQRqGej5zAi3wcuQZT9hepttxLENgiBzknsL7TglU0GbtMIIrd2RYCM
	 utMD3ZpT2i0MgGdBOLVJMoiTS+FHBUXvD1Uv+0go6gxwR2MDTA1CcczHMUaRJXYtT+
	 EFnyJTaQdW0I+kEWtaY+AAHozdA3Nzbf2ky+chjGC6EgnqpJm39jk93qQggI8do5zX
	 /CoWjfYClzmJSdpD+8vJIccj+c9J9cBryGljD15qR/MtqnFDg2BxpmW9D3vqVkahbK
	 W1gMO5NNlFPMHycz8zqu75cAVWqoq3n84Gxjv7uKeu4Qkx6GA/BOCdbZhfAnJxLUh7
	 zceGSF6WlP2tA==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Cc: dvyukov@google.com
Subject: [PATCH] btrfs: fix use-after-free when attempting to join an aborted transaction
Date: Mon, 20 Jan 2025 17:46:21 +0000
Message-Id: <f81151ae971c956f9b7e496a92bb67222452aee0.1737395071.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

When we are trying to join the current transaction and if it's aborted,
we read its 'aborted' field after unlocking fs_info->trans_lock and
without holding any extra reference count on it. This means that a
concurrent task that is aborting the transaction may free the transaction
before we read its 'aborted' field, leading to a use-after-free.

Fix this by reading the 'aborted' field while holding fs_info->trans_lock
since any freeing task must first acquire that lock and set
fs_info->running_transaction to NULL before freeing the transaction.

This was reported by syzbot and Dmitry with the following stack traces
from KASAN:

   ==================================================================
   BUG: KASAN: slab-use-after-free in join_transaction+0xd9b/0xda0 fs/btrfs/transaction.c:278
   Read of size 4 at addr ffff888011839024 by task kworker/u4:9/1128

   CPU: 0 UID: 0 PID: 1128 Comm: kworker/u4:9 Not tainted 6.13.0-rc7-syzkaller-00019-gc45323b7560e #0
   Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
   Workqueue: events_unbound btrfs_async_reclaim_data_space
   Call Trace:
    <TASK>
    __dump_stack lib/dump_stack.c:94 [inline]
    dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
    print_address_description mm/kasan/report.c:378 [inline]
    print_report+0x169/0x550 mm/kasan/report.c:489
    kasan_report+0x143/0x180 mm/kasan/report.c:602
    join_transaction+0xd9b/0xda0 fs/btrfs/transaction.c:278
    start_transaction+0xaf8/0x1670 fs/btrfs/transaction.c:697
    flush_space+0x448/0xcf0 fs/btrfs/space-info.c:803
    btrfs_async_reclaim_data_space+0x159/0x510 fs/btrfs/space-info.c:1321
    process_one_work kernel/workqueue.c:3236 [inline]
    process_scheduled_works+0xa66/0x1840 kernel/workqueue.c:3317
    worker_thread+0x870/0xd30 kernel/workqueue.c:3398
    kthread+0x2f0/0x390 kernel/kthread.c:389
    ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
    ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
    </TASK>

   Allocated by task 5315:
    kasan_save_stack mm/kasan/common.c:47 [inline]
    kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
    poison_kmalloc_redzone mm/kasan/common.c:377 [inline]
    __kasan_kmalloc+0x98/0xb0 mm/kasan/common.c:394
    kasan_kmalloc include/linux/kasan.h:260 [inline]
    __kmalloc_cache_noprof+0x243/0x390 mm/slub.c:4329
    kmalloc_noprof include/linux/slab.h:901 [inline]
    join_transaction+0x144/0xda0 fs/btrfs/transaction.c:308
    start_transaction+0xaf8/0x1670 fs/btrfs/transaction.c:697
    btrfs_create_common+0x1b2/0x2e0 fs/btrfs/inode.c:6572
    lookup_open fs/namei.c:3649 [inline]
    open_last_lookups fs/namei.c:3748 [inline]
    path_openat+0x1c03/0x3590 fs/namei.c:3984
    do_filp_open+0x27f/0x4e0 fs/namei.c:4014
    do_sys_openat2+0x13e/0x1d0 fs/open.c:1402
    do_sys_open fs/open.c:1417 [inline]
    __do_sys_creat fs/open.c:1495 [inline]
    __se_sys_creat fs/open.c:1489 [inline]
    __x64_sys_creat+0x123/0x170 fs/open.c:1489
    do_syscall_x64 arch/x86/entry/common.c:52 [inline]
    do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
    entry_SYSCALL_64_after_hwframe+0x77/0x7f

   Freed by task 5336:
    kasan_save_stack mm/kasan/common.c:47 [inline]
    kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
    kasan_save_free_info+0x40/0x50 mm/kasan/generic.c:582
    poison_slab_object mm/kasan/common.c:247 [inline]
    __kasan_slab_free+0x59/0x70 mm/kasan/common.c:264
    kasan_slab_free include/linux/kasan.h:233 [inline]
    slab_free_hook mm/slub.c:2353 [inline]
    slab_free mm/slub.c:4613 [inline]
    kfree+0x196/0x430 mm/slub.c:4761
    cleanup_transaction fs/btrfs/transaction.c:2063 [inline]
    btrfs_commit_transaction+0x2c97/0x3720 fs/btrfs/transaction.c:2598
    insert_balance_item+0x1284/0x20b0 fs/btrfs/volumes.c:3757
    btrfs_balance+0x992/0x10c0 fs/btrfs/volumes.c:4633
    btrfs_ioctl_balance+0x493/0x7c0 fs/btrfs/ioctl.c:3670
    vfs_ioctl fs/ioctl.c:51 [inline]
    __do_sys_ioctl fs/ioctl.c:906 [inline]
    __se_sys_ioctl+0xf5/0x170 fs/ioctl.c:892
    do_syscall_x64 arch/x86/entry/common.c:52 [inline]
    do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
    entry_SYSCALL_64_after_hwframe+0x77/0x7f

   The buggy address belongs to the object at ffff888011839000
    which belongs to the cache kmalloc-2k of size 2048
   The buggy address is located 36 bytes inside of
    freed 2048-byte region [ffff888011839000, ffff888011839800)

   The buggy address belongs to the physical page:
   page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x11838
   head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
   flags: 0xfff00000000040(head|node=0|zone=1|lastcpupid=0x7ff)
   page_type: f5(slab)
   raw: 00fff00000000040 ffff88801ac42000 ffffea0000493400 dead000000000002
   raw: 0000000000000000 0000000000080008 00000001f5000000 0000000000000000
   head: 00fff00000000040 ffff88801ac42000 ffffea0000493400 dead000000000002
   head: 0000000000000000 0000000000080008 00000001f5000000 0000000000000000
   head: 00fff00000000003 ffffea0000460e01 ffffffffffffffff 0000000000000000
   head: 0000000000000008 0000000000000000 00000000ffffffff 0000000000000000
   page dumped because: kasan: bad access detected
   page_owner tracks the page as allocated
   page last allocated via order 3, migratetype Unmovable, gfp_mask 0xd20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 57, tgid 57 (kworker/0:2), ts 67248182943, free_ts 67229742023
    set_page_owner include/linux/page_owner.h:32 [inline]
    post_alloc_hook+0x1f3/0x230 mm/page_alloc.c:1558
    prep_new_page mm/page_alloc.c:1566 [inline]
    get_page_from_freelist+0x365c/0x37a0 mm/page_alloc.c:3476
    __alloc_pages_noprof+0x292/0x710 mm/page_alloc.c:4753
    alloc_pages_mpol_noprof+0x3e1/0x780 mm/mempolicy.c:2269
    alloc_slab_page+0x6a/0x110 mm/slub.c:2423
    allocate_slab+0x5a/0x2b0 mm/slub.c:2589
    new_slab mm/slub.c:2642 [inline]
    ___slab_alloc+0xc27/0x14a0 mm/slub.c:3830
    __slab_alloc+0x58/0xa0 mm/slub.c:3920
    __slab_alloc_node mm/slub.c:3995 [inline]
    slab_alloc_node mm/slub.c:4156 [inline]
    __do_kmalloc_node mm/slub.c:4297 [inline]
    __kmalloc_node_track_caller_noprof+0x2e9/0x4c0 mm/slub.c:4317
    kmalloc_reserve+0x111/0x2a0 net/core/skbuff.c:609
    __alloc_skb+0x1f3/0x440 net/core/skbuff.c:678
    alloc_skb include/linux/skbuff.h:1323 [inline]
    alloc_skb_with_frags+0xc3/0x820 net/core/skbuff.c:6612
    sock_alloc_send_pskb+0x91a/0xa60 net/core/sock.c:2884
    sock_alloc_send_skb include/net/sock.h:1803 [inline]
    mld_newpack+0x1c3/0xaf0 net/ipv6/mcast.c:1747
    add_grhead net/ipv6/mcast.c:1850 [inline]
    add_grec+0x1492/0x19a0 net/ipv6/mcast.c:1988
    mld_send_cr net/ipv6/mcast.c:2114 [inline]
    mld_ifc_work+0x691/0xd90 net/ipv6/mcast.c:2651
   page last free pid 5300 tgid 5300 stack trace:
    reset_page_owner include/linux/page_owner.h:25 [inline]
    free_pages_prepare mm/page_alloc.c:1127 [inline]
    free_unref_page+0xd3f/0x1010 mm/page_alloc.c:2659
    __slab_free+0x2c2/0x380 mm/slub.c:4524
    qlink_free mm/kasan/quarantine.c:163 [inline]
    qlist_free_all+0x9a/0x140 mm/kasan/quarantine.c:179
    kasan_quarantine_reduce+0x14f/0x170 mm/kasan/quarantine.c:286
    __kasan_slab_alloc+0x23/0x80 mm/kasan/common.c:329
    kasan_slab_alloc include/linux/kasan.h:250 [inline]
    slab_post_alloc_hook mm/slub.c:4119 [inline]
    slab_alloc_node mm/slub.c:4168 [inline]
    __do_kmalloc_node mm/slub.c:4297 [inline]
    __kmalloc_noprof+0x236/0x4c0 mm/slub.c:4310
    kmalloc_noprof include/linux/slab.h:905 [inline]
    kzalloc_noprof include/linux/slab.h:1037 [inline]
    fib_create_info+0xc14/0x25b0 net/ipv4/fib_semantics.c:1435
    fib_table_insert+0x1f6/0x1f20 net/ipv4/fib_trie.c:1231
    fib_magic+0x3d8/0x620 net/ipv4/fib_frontend.c:1112
    fib_add_ifaddr+0x40c/0x5e0 net/ipv4/fib_frontend.c:1156
    fib_netdev_event+0x375/0x490 net/ipv4/fib_frontend.c:1494
    notifier_call_chain+0x1a5/0x3f0 kernel/notifier.c:85
    __dev_notify_flags+0x207/0x400
    dev_change_flags+0xf0/0x1a0 net/core/dev.c:9045
    do_setlink+0xc90/0x4210 net/core/rtnetlink.c:3109
    rtnl_changelink net/core/rtnetlink.c:3723 [inline]
    __rtnl_newlink net/core/rtnetlink.c:3875 [inline]
    rtnl_newlink+0x1bb6/0x2210 net/core/rtnetlink.c:4012

   Memory state around the buggy address:
    ffff888011838f00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
    ffff888011838f80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
   >ffff888011839000: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                  ^
    ffff888011839080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
    ffff888011839100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
   ==================================================================

Reported-by: syzbot+45212e9d87a98c3f5b42@syzkaller.appspotmail.com
Link: https://lore.kernel.org/linux-btrfs/678e7da5.050a0220.303755.007c.GAE@google.com/
Reported-by: Dmitry Vyukov <dvyukov@google.com>
Link: https://lore.kernel.org/linux-btrfs/CACT4Y+ZFBdo7pT8L2AzM=vegZwjp-wNkVJZQf0Ta3vZqtExaSw@mail.gmail.com/
Fixes: 871383be592b ("btrfs: add missing unlocks to transaction abort paths")
Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/transaction.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index 15312013f2a3..aca83a98b75a 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -274,8 +274,10 @@ static noinline int join_transaction(struct btrfs_fs_info *fs_info,
 	cur_trans = fs_info->running_transaction;
 	if (cur_trans) {
 		if (TRANS_ABORTED(cur_trans)) {
+			const int abort_error = cur_trans->aborted;
+
 			spin_unlock(&fs_info->trans_lock);
-			return cur_trans->aborted;
+			return abort_error;
 		}
 		if (btrfs_blocked_trans_types[cur_trans->state] & type) {
 			spin_unlock(&fs_info->trans_lock);
-- 
2.45.2


