Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA869678253
	for <lists+linux-btrfs@lfdr.de>; Mon, 23 Jan 2023 17:55:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231940AbjAWQzA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 23 Jan 2023 11:55:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230315AbjAWQy7 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 23 Jan 2023 11:54:59 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46046F755
        for <linux-btrfs@vger.kernel.org>; Mon, 23 Jan 2023 08:54:51 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BE35560F84
        for <linux-btrfs@vger.kernel.org>; Mon, 23 Jan 2023 16:54:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEA90C433D2
        for <linux-btrfs@vger.kernel.org>; Mon, 23 Jan 2023 16:54:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674492890;
        bh=hELgvew/VVqHCDLP1JiRJ/C4q+MP5oyyQ+yEDbVFUBQ=;
        h=From:To:Subject:Date:From;
        b=kaAIgfELjxA5s4slO3ypLqTJrx0kbPqLuC4DLAFzQ9/QX/yVhAJYtzH4fK/azrrw5
         LeWrjQaGkSHofWRlxWALIK3lXKQbeTqtdJ+ouC8eBUU9ePSuZ2+oMd8VI2me1lp4H1
         MtH9Jh5/GxXdaZ26hZnKHlK/MAUrSx35W4Druaqr+3ESqCLoP6ryYw9fr+a5abEm+C
         XXB4VtTmSK6CAulEs2WkYhitrQ1N5GFAWCM9lPCuOhlC9bmWNbMvcXTLwuRkcZZ/du
         N/OcYvaFyuqtAWxdmklud+qniIqlZvQskjj/exzr9d6zH9eaZHvuLahJb/j0yt/hZu
         j6O0gI9Mf0k8w==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: lock the inode in shared mode before starting fiemap
Date:   Mon, 23 Jan 2023 16:54:46 +0000
Message-Id: <5c6c1cefa7df5fbe9c4dc2fe517f521760a2f4be.1674492773.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

Currently fiemap does not take the inode's lock (VFS lock), it only locks
a file range in the inode's io tree. This however can lead to a deadlock
if we have a concurrent fsync on the file and fiemap code triggers a fault
when accessing the user space buffer with fiemap_fill_next_extent(). The
deadlock happens on the inode's i_mmap_lock semaphore, which is taken both
by fsync and btrfs_page_mkwrite(). This deadlock was recently reported by
syzbot and triggers a trace like the following:

   task:syz-executor361 state:D stack:20264 pid:5668  ppid:5119   flags:0x00004004
   Call Trace:
    <TASK>
    context_switch kernel/sched/core.c:5293 [inline]
    __schedule+0x995/0xe20 kernel/sched/core.c:6606
    schedule+0xcb/0x190 kernel/sched/core.c:6682
    wait_on_state fs/btrfs/extent-io-tree.c:707 [inline]
    wait_extent_bit+0x577/0x6f0 fs/btrfs/extent-io-tree.c:751
    lock_extent+0x1c2/0x280 fs/btrfs/extent-io-tree.c:1742
    find_lock_delalloc_range+0x4e6/0x9c0 fs/btrfs/extent_io.c:488
    writepage_delalloc+0x1ef/0x540 fs/btrfs/extent_io.c:1863
    __extent_writepage+0x736/0x14e0 fs/btrfs/extent_io.c:2174
    extent_write_cache_pages+0x983/0x1220 fs/btrfs/extent_io.c:3091
    extent_writepages+0x219/0x540 fs/btrfs/extent_io.c:3211
    do_writepages+0x3c3/0x680 mm/page-writeback.c:2581
    filemap_fdatawrite_wbc+0x11e/0x170 mm/filemap.c:388
    __filemap_fdatawrite_range mm/filemap.c:421 [inline]
    filemap_fdatawrite_range+0x175/0x200 mm/filemap.c:439
    btrfs_fdatawrite_range fs/btrfs/file.c:3850 [inline]
    start_ordered_ops fs/btrfs/file.c:1737 [inline]
    btrfs_sync_file+0x4ff/0x1190 fs/btrfs/file.c:1839
    generic_write_sync include/linux/fs.h:2885 [inline]
    btrfs_do_write_iter+0xcd3/0x1280 fs/btrfs/file.c:1684
    call_write_iter include/linux/fs.h:2189 [inline]
    new_sync_write fs/read_write.c:491 [inline]
    vfs_write+0x7dc/0xc50 fs/read_write.c:584
    ksys_write+0x177/0x2a0 fs/read_write.c:637
    do_syscall_x64 arch/x86/entry/common.c:50 [inline]
    do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
    entry_SYSCALL_64_after_hwframe+0x63/0xcd
   RIP: 0033:0x7f7d4054e9b9
   RSP: 002b:00007f7d404fa2f8 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
   RAX: ffffffffffffffda RBX: 00007f7d405d87a0 RCX: 00007f7d4054e9b9
   RDX: 0000000000000090 RSI: 0000000020000000 RDI: 0000000000000006
   RBP: 00007f7d405a51d0 R08: 0000000000000000 R09: 0000000000000000
   R10: 0000000000000000 R11: 0000000000000246 R12: 61635f65646f6e69
   R13: 65646f7475616f6e R14: 7261637369646f6e R15: 00007f7d405d87a8
    </TASK>
   INFO: task syz-executor361:5697 blocked for more than 145 seconds.
         Not tainted 6.2.0-rc3-syzkaller-00376-g7c6984405241 #0
   "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
   task:syz-executor361 state:D stack:21216 pid:5697  ppid:5119   flags:0x00004004
   Call Trace:
    <TASK>
    context_switch kernel/sched/core.c:5293 [inline]
    __schedule+0x995/0xe20 kernel/sched/core.c:6606
    schedule+0xcb/0x190 kernel/sched/core.c:6682
    rwsem_down_read_slowpath+0x5f9/0x930 kernel/locking/rwsem.c:1095
    __down_read_common+0x54/0x2a0 kernel/locking/rwsem.c:1260
    btrfs_page_mkwrite+0x417/0xc80 fs/btrfs/inode.c:8526
    do_page_mkwrite+0x19e/0x5e0 mm/memory.c:2947
    wp_page_shared+0x15e/0x380 mm/memory.c:3295
    handle_pte_fault mm/memory.c:4949 [inline]
    __handle_mm_fault mm/memory.c:5073 [inline]
    handle_mm_fault+0x1b79/0x26b0 mm/memory.c:5219
    do_user_addr_fault+0x69b/0xcb0 arch/x86/mm/fault.c:1428
    handle_page_fault arch/x86/mm/fault.c:1519 [inline]
    exc_page_fault+0x7a/0x110 arch/x86/mm/fault.c:1575
    asm_exc_page_fault+0x22/0x30 arch/x86/include/asm/idtentry.h:570
   RIP: 0010:copy_user_short_string+0xd/0x40 arch/x86/lib/copy_user_64.S:233
   Code: 74 0a 89 (...)
   RSP: 0018:ffffc9000570f330 EFLAGS: 00050202
   RAX: ffffffff843e6601 RBX: 00007fffffffefc8 RCX: 0000000000000007
   RDX: 0000000000000000 RSI: ffffc9000570f3e0 RDI: 0000000020000120
   RBP: ffffc9000570f490 R08: 0000000000000000 R09: fffff52000ae1e83
   R10: fffff52000ae1e83 R11: 1ffff92000ae1e7c R12: 0000000000000038
   R13: ffffc9000570f3e0 R14: 0000000020000120 R15: ffffc9000570f3e0
    copy_user_generic arch/x86/include/asm/uaccess_64.h:37 [inline]
    raw_copy_to_user arch/x86/include/asm/uaccess_64.h:58 [inline]
    _copy_to_user+0xe9/0x130 lib/usercopy.c:34
    copy_to_user include/linux/uaccess.h:169 [inline]
    fiemap_fill_next_extent+0x22e/0x410 fs/ioctl.c:144
    emit_fiemap_extent+0x22d/0x3c0 fs/btrfs/extent_io.c:3458
    fiemap_process_hole+0xa00/0xad0 fs/btrfs/extent_io.c:3716
    extent_fiemap+0xe27/0x2100 fs/btrfs/extent_io.c:3922
    btrfs_fiemap+0x172/0x1e0 fs/btrfs/inode.c:8209
    ioctl_fiemap fs/ioctl.c:219 [inline]
    do_vfs_ioctl+0x185b/0x2980 fs/ioctl.c:810
    __do_sys_ioctl fs/ioctl.c:868 [inline]
    __se_sys_ioctl+0x83/0x170 fs/ioctl.c:856
    do_syscall_x64 arch/x86/entry/common.c:50 [inline]
    do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
    entry_SYSCALL_64_after_hwframe+0x63/0xcd
   RIP: 0033:0x7f7d4054e9b9
   RSP: 002b:00007f7d390d92f8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
   RAX: ffffffffffffffda RBX: 00007f7d405d87b0 RCX: 00007f7d4054e9b9
   RDX: 0000000020000100 RSI: 00000000c020660b RDI: 0000000000000005
   RBP: 00007f7d405a51d0 R08: 00007f7d390d9700 R09: 0000000000000000
   R10: 00007f7d390d9700 R11: 0000000000000246 R12: 61635f65646f6e69
   R13: 65646f7475616f6e R14: 7261637369646f6e R15: 00007f7d405d87b8
    </TASK>

What happens is the following:

1) Task A is doing an fsync, enters btrfs_sync_file() and flushes delalloc
   before locking the inode and the i_mmap_lock semaphore, that is, before
   calling btrfs_inode_lock();

2) After task A flushes delalloc and before it calls btrfs_inode_lock(),
   another task dirties a page;

3) Task B starts a fiemap without FIEMAP_FLAG_SYNC, so the page dirtied
   at step 2 remains dirty and unflushed. Then when it enters
   extent_fiemap() and it locks a file range that includes the range of
   the page dirtied in step 2;

4) Task A calls btrfs_inode_lock() and locks the inode (VFS lock) and the
   inode's i_mmap_lock semaphore in write mode. Then it tries to flush
   delalloc by calling start_ordered_ops(), which will block, at
   find_lock_delalloc_range(), when trying to lock the range of the page
   dirtied at step 2, since this range was locked by the fiemap task (at
   step 3);

5) Task B generates a page fault when accessing the user space fiemap
   buffer with a call to fiemap_fill_next_extent().

   The fault handler needs to call btrfs_page_mkwrite() for some other
   page of our inode, and there we deadlock when trying to lock the
   inode's i_mmap_lock semaphore in read mode, since the fsync task locked
   it in write mode (step 4) and the fsync task can not progress because
   it's waiting to lock a file range that is currently locked by us (the
   fiemap task, step 3).

Fix this by taking the inode's lock (VFS lock) in shared mode when
entering fiemap. This effectively serializes fiemap with fsync (except the
most expensive part of fsync, the log sync), preventing this deadlock.

Reported-by: syzbot+cc35f55c41e34c30dcb5@syzkaller.appspotmail.com
Link: https://lore.kernel.org/linux-btrfs/00000000000032dc7305f2a66f46@google.com/
Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/extent_io.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 9bd32daa9b9a..3bbf8703db2a 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -3826,6 +3826,7 @@ int extent_fiemap(struct btrfs_inode *inode, struct fiemap_extent_info *fieinfo,
 	lockend = round_up(start + len, inode->root->fs_info->sectorsize);
 	prev_extent_end = lockstart;
 
+	btrfs_inode_lock(inode, BTRFS_ILOCK_SHARED);
 	lock_extent(&inode->io_tree, lockstart, lockend, &cached_state);
 
 	ret = fiemap_find_last_extent_offset(inode, path, &last_extent_end);
@@ -4019,6 +4020,7 @@ int extent_fiemap(struct btrfs_inode *inode, struct fiemap_extent_info *fieinfo,
 
 out_unlock:
 	unlock_extent(&inode->io_tree, lockstart, lockend, &cached_state);
+	btrfs_inode_unlock(inode, BTRFS_ILOCK_SHARED);
 out:
 	free_extent_state(delalloc_cached_state);
 	btrfs_free_backref_share_ctx(backref_ctx);
-- 
2.35.1

