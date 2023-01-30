Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27BDC681A84
	for <lists+linux-btrfs@lfdr.de>; Mon, 30 Jan 2023 20:31:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236074AbjA3TbL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 30 Jan 2023 14:31:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237479AbjA3TbK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 30 Jan 2023 14:31:10 -0500
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF62A1D938
        for <linux-btrfs@vger.kernel.org>; Mon, 30 Jan 2023 11:31:03 -0800 (PST)
Received: by mail-qt1-x82e.google.com with SMTP id h24so3102300qtr.0
        for <linux-btrfs@vger.kernel.org>; Mon, 30 Jan 2023 11:31:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=//HV2kg5e2F+eNDVLNcoaIIL6xuDXK6nN1CYRHI4GYY=;
        b=qUAMKyfsyS5yqbTQ2zajDLkm9VyfdHHyslN2C89jDaQc/PRmDy/6nRg3m6+FGA91BJ
         3qCcQnzBXJHLfma0J/aFZSyNqt8t0sMqHWg29bKo9ztnBIVXZ9844rhWT2eeHQe076bN
         +6CmeZc96b1qmndGsE52Te6p+SpV5/TFF5nrsBr+2fTnllJMKrx7SSDkt/EWNWFIKLO2
         6HCSdyptyZLPtXAhJkbwMqY/pKhpUGxXW0u5m1ZgLRWG3P6vdKIwDGnnrE73bNL3i4cQ
         oHfDkr2O8TCRVedoggChVRxjLyJ9eOpcaLoy1yR7pdfkLOlaNJ1aeUrx433Va3eDZHxu
         GfTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=//HV2kg5e2F+eNDVLNcoaIIL6xuDXK6nN1CYRHI4GYY=;
        b=tZdaZXedEw5AWe25hheZTWZ+EZ05uFFBxq0ZOKqf7ONzH5vbaHPoWaN177Bp/wmLW9
         ojQvG1AJ6gjpgV55tCKczz6nZKQBWI5lZKxo1TkeVkakSL6CwCNPWuCkM13hYlw++kfq
         F1mHtOJAiSYqGxK9ACVD2EBOMnldfAS4G4EAhJYX9ovhfia3GIb/OjokMP3XigUm/hD2
         tUKLTRM8X3qrN8NraXCAOKEEBnYlIzZCAsTXXkXvgTupEbkdOhOiLil++Q7ifI6O0qHm
         Pv5U/+jLLz7R06YiFMe2cPO8px2JH6ZciEGbvyYzuojng5GpldivQuZQOziQzdujeUZD
         dr1A==
X-Gm-Message-State: AO0yUKVvXLo047hLaOxXxGKKKx/kvIRKhT9TnVHw53gQO3fVSj4gHOXB
        HvBCs4v1SOmNzcrsj1sUfcHaPBG4Vv44hETgM6c=
X-Google-Smtp-Source: AK7set8MGsO0kUbHcYajJgBMi5YkxBWdIEsNy6piDWAL0OUI+zgKF0pwkuQOsWVmcdNLJKQXQHIYvg==
X-Received: by 2002:a05:622a:1713:b0:3b8:6cd5:eda with SMTP id h19-20020a05622a171300b003b86cd50edamr5736709qtk.47.1675107062617;
        Mon, 30 Jan 2023 11:31:02 -0800 (PST)
Received: from localhost (cpe-174-109-170-245.nc.res.rr.com. [174.109.170.245])
        by smtp.gmail.com with ESMTPSA id eb10-20020a05620a480a00b007112aa42c4fsm8375153qkb.135.2023.01.30.11.31.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jan 2023 11:31:01 -0800 (PST)
Date:   Mon, 30 Jan 2023 14:30:59 -0500
From:   Josef Bacik <josef@toxicpanda.com>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: lock the inode in shared mode before starting
 fiemap
Message-ID: <Y9ga88Xu3YS2gzvA@localhost.localdomain>
References: <5c6c1cefa7df5fbe9c4dc2fe517f521760a2f4be.1674492773.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5c6c1cefa7df5fbe9c4dc2fe517f521760a2f4be.1674492773.git.fdmanana@suse.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Jan 23, 2023 at 04:54:46PM +0000, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> Currently fiemap does not take the inode's lock (VFS lock), it only locks
> a file range in the inode's io tree. This however can lead to a deadlock
> if we have a concurrent fsync on the file and fiemap code triggers a fault
> when accessing the user space buffer with fiemap_fill_next_extent(). The
> deadlock happens on the inode's i_mmap_lock semaphore, which is taken both
> by fsync and btrfs_page_mkwrite(). This deadlock was recently reported by
> syzbot and triggers a trace like the following:
> 
>    task:syz-executor361 state:D stack:20264 pid:5668  ppid:5119   flags:0x00004004
>    Call Trace:
>     <TASK>
>     context_switch kernel/sched/core.c:5293 [inline]
>     __schedule+0x995/0xe20 kernel/sched/core.c:6606
>     schedule+0xcb/0x190 kernel/sched/core.c:6682
>     wait_on_state fs/btrfs/extent-io-tree.c:707 [inline]
>     wait_extent_bit+0x577/0x6f0 fs/btrfs/extent-io-tree.c:751
>     lock_extent+0x1c2/0x280 fs/btrfs/extent-io-tree.c:1742
>     find_lock_delalloc_range+0x4e6/0x9c0 fs/btrfs/extent_io.c:488
>     writepage_delalloc+0x1ef/0x540 fs/btrfs/extent_io.c:1863
>     __extent_writepage+0x736/0x14e0 fs/btrfs/extent_io.c:2174
>     extent_write_cache_pages+0x983/0x1220 fs/btrfs/extent_io.c:3091
>     extent_writepages+0x219/0x540 fs/btrfs/extent_io.c:3211
>     do_writepages+0x3c3/0x680 mm/page-writeback.c:2581
>     filemap_fdatawrite_wbc+0x11e/0x170 mm/filemap.c:388
>     __filemap_fdatawrite_range mm/filemap.c:421 [inline]
>     filemap_fdatawrite_range+0x175/0x200 mm/filemap.c:439
>     btrfs_fdatawrite_range fs/btrfs/file.c:3850 [inline]
>     start_ordered_ops fs/btrfs/file.c:1737 [inline]
>     btrfs_sync_file+0x4ff/0x1190 fs/btrfs/file.c:1839
>     generic_write_sync include/linux/fs.h:2885 [inline]
>     btrfs_do_write_iter+0xcd3/0x1280 fs/btrfs/file.c:1684
>     call_write_iter include/linux/fs.h:2189 [inline]
>     new_sync_write fs/read_write.c:491 [inline]
>     vfs_write+0x7dc/0xc50 fs/read_write.c:584
>     ksys_write+0x177/0x2a0 fs/read_write.c:637
>     do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>     do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
>     entry_SYSCALL_64_after_hwframe+0x63/0xcd
>    RIP: 0033:0x7f7d4054e9b9
>    RSP: 002b:00007f7d404fa2f8 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
>    RAX: ffffffffffffffda RBX: 00007f7d405d87a0 RCX: 00007f7d4054e9b9
>    RDX: 0000000000000090 RSI: 0000000020000000 RDI: 0000000000000006
>    RBP: 00007f7d405a51d0 R08: 0000000000000000 R09: 0000000000000000
>    R10: 0000000000000000 R11: 0000000000000246 R12: 61635f65646f6e69
>    R13: 65646f7475616f6e R14: 7261637369646f6e R15: 00007f7d405d87a8
>     </TASK>
>    INFO: task syz-executor361:5697 blocked for more than 145 seconds.
>          Not tainted 6.2.0-rc3-syzkaller-00376-g7c6984405241 #0
>    "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
>    task:syz-executor361 state:D stack:21216 pid:5697  ppid:5119   flags:0x00004004
>    Call Trace:
>     <TASK>
>     context_switch kernel/sched/core.c:5293 [inline]
>     __schedule+0x995/0xe20 kernel/sched/core.c:6606
>     schedule+0xcb/0x190 kernel/sched/core.c:6682
>     rwsem_down_read_slowpath+0x5f9/0x930 kernel/locking/rwsem.c:1095
>     __down_read_common+0x54/0x2a0 kernel/locking/rwsem.c:1260
>     btrfs_page_mkwrite+0x417/0xc80 fs/btrfs/inode.c:8526
>     do_page_mkwrite+0x19e/0x5e0 mm/memory.c:2947
>     wp_page_shared+0x15e/0x380 mm/memory.c:3295
>     handle_pte_fault mm/memory.c:4949 [inline]
>     __handle_mm_fault mm/memory.c:5073 [inline]
>     handle_mm_fault+0x1b79/0x26b0 mm/memory.c:5219
>     do_user_addr_fault+0x69b/0xcb0 arch/x86/mm/fault.c:1428
>     handle_page_fault arch/x86/mm/fault.c:1519 [inline]
>     exc_page_fault+0x7a/0x110 arch/x86/mm/fault.c:1575
>     asm_exc_page_fault+0x22/0x30 arch/x86/include/asm/idtentry.h:570
>    RIP: 0010:copy_user_short_string+0xd/0x40 arch/x86/lib/copy_user_64.S:233
>    Code: 74 0a 89 (...)
>    RSP: 0018:ffffc9000570f330 EFLAGS: 00050202
>    RAX: ffffffff843e6601 RBX: 00007fffffffefc8 RCX: 0000000000000007
>    RDX: 0000000000000000 RSI: ffffc9000570f3e0 RDI: 0000000020000120
>    RBP: ffffc9000570f490 R08: 0000000000000000 R09: fffff52000ae1e83
>    R10: fffff52000ae1e83 R11: 1ffff92000ae1e7c R12: 0000000000000038
>    R13: ffffc9000570f3e0 R14: 0000000020000120 R15: ffffc9000570f3e0
>     copy_user_generic arch/x86/include/asm/uaccess_64.h:37 [inline]
>     raw_copy_to_user arch/x86/include/asm/uaccess_64.h:58 [inline]
>     _copy_to_user+0xe9/0x130 lib/usercopy.c:34
>     copy_to_user include/linux/uaccess.h:169 [inline]
>     fiemap_fill_next_extent+0x22e/0x410 fs/ioctl.c:144
>     emit_fiemap_extent+0x22d/0x3c0 fs/btrfs/extent_io.c:3458
>     fiemap_process_hole+0xa00/0xad0 fs/btrfs/extent_io.c:3716
>     extent_fiemap+0xe27/0x2100 fs/btrfs/extent_io.c:3922
>     btrfs_fiemap+0x172/0x1e0 fs/btrfs/inode.c:8209
>     ioctl_fiemap fs/ioctl.c:219 [inline]
>     do_vfs_ioctl+0x185b/0x2980 fs/ioctl.c:810
>     __do_sys_ioctl fs/ioctl.c:868 [inline]
>     __se_sys_ioctl+0x83/0x170 fs/ioctl.c:856
>     do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>     do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
>     entry_SYSCALL_64_after_hwframe+0x63/0xcd
>    RIP: 0033:0x7f7d4054e9b9
>    RSP: 002b:00007f7d390d92f8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
>    RAX: ffffffffffffffda RBX: 00007f7d405d87b0 RCX: 00007f7d4054e9b9
>    RDX: 0000000020000100 RSI: 00000000c020660b RDI: 0000000000000005
>    RBP: 00007f7d405a51d0 R08: 00007f7d390d9700 R09: 0000000000000000
>    R10: 00007f7d390d9700 R11: 0000000000000246 R12: 61635f65646f6e69
>    R13: 65646f7475616f6e R14: 7261637369646f6e R15: 00007f7d405d87b8
>     </TASK>
> 
> What happens is the following:
> 
> 1) Task A is doing an fsync, enters btrfs_sync_file() and flushes delalloc
>    before locking the inode and the i_mmap_lock semaphore, that is, before
>    calling btrfs_inode_lock();
> 
> 2) After task A flushes delalloc and before it calls btrfs_inode_lock(),
>    another task dirties a page;
> 
> 3) Task B starts a fiemap without FIEMAP_FLAG_SYNC, so the page dirtied
>    at step 2 remains dirty and unflushed. Then when it enters
>    extent_fiemap() and it locks a file range that includes the range of
>    the page dirtied in step 2;
> 
> 4) Task A calls btrfs_inode_lock() and locks the inode (VFS lock) and the
>    inode's i_mmap_lock semaphore in write mode. Then it tries to flush
>    delalloc by calling start_ordered_ops(), which will block, at
>    find_lock_delalloc_range(), when trying to lock the range of the page
>    dirtied at step 2, since this range was locked by the fiemap task (at
>    step 3);
> 
> 5) Task B generates a page fault when accessing the user space fiemap
>    buffer with a call to fiemap_fill_next_extent().
> 
>    The fault handler needs to call btrfs_page_mkwrite() for some other
>    page of our inode, and there we deadlock when trying to lock the
>    inode's i_mmap_lock semaphore in read mode, since the fsync task locked
>    it in write mode (step 4) and the fsync task can not progress because
>    it's waiting to lock a file range that is currently locked by us (the
>    fiemap task, step 3).
> 
> Fix this by taking the inode's lock (VFS lock) in shared mode when
> entering fiemap. This effectively serializes fiemap with fsync (except the
> most expensive part of fsync, the log sync), preventing this deadlock.
> 
> Reported-by: syzbot+cc35f55c41e34c30dcb5@syzkaller.appspotmail.com
> Link: https://lore.kernel.org/linux-btrfs/00000000000032dc7305f2a66f46@google.com/
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
