Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D655C40EEBF
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Sep 2021 03:31:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242266AbhIQBdD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 16 Sep 2021 21:33:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242196AbhIQBdC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 16 Sep 2021 21:33:02 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C922C061756;
        Thu, 16 Sep 2021 18:31:41 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id j6so7658070pfa.4;
        Thu, 16 Sep 2021 18:31:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=GqcbAraaZozZ1syoj2RndTqPjLnZwXf3Lnee5BLJwCA=;
        b=GeMKQZ1QAQZEdATzD9/WFsK7zd2sUqLUdsOs6CDSKeHOQAmNOm4s0p+fe2jtRLeQRW
         NEIagyHR6hwdf6E12ekASobKbevssCT1JLLQ8BTc6U974aMAitkjD9eTBSGMrx4YWQHr
         IIW3qf2glurhEmI8PKoNc7g9DuskZg1KLgc+MxxfmQ6w6iooR3D5UCFdEXadsdqfzmJi
         jdzMUUWMkOGqWJGBJ9Swt+u2IgoU8erItaUrO3DlQ1if04wAulWUCPJ6DBUjchf6M4sU
         fw1gkhaChE/KIJsfRSMswbvF2p7F6MPRrQY//FXvfXON63m7EDhwyImC7Aq3ksWu1/kP
         GhHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=GqcbAraaZozZ1syoj2RndTqPjLnZwXf3Lnee5BLJwCA=;
        b=XqqlE+9wbGlpl+cFt4/v0eFkSz+09cni2hX2iqL8VQYVgDcgGqkGx2MnfwTT6jqO+R
         yS/cWysdD/VScsnHzouap9OrCDL3t6C37zILnzC9ZxKV3YqnjiIhJZtbQBtjzff+laWX
         iAyQfMvwIVqS2ptjwJiRYHUSUzCk9asfoFVuqEh60C/2VEoYLHuobh/dVqKJTcj9ml9C
         15Hk5+1+RySsnVSbx7X+EtFwZPBhE2u2u7NupbhUX7ikDvKXCTSEV62Mf63Gnzgd+iXm
         rCehleChuGMirF4JDLuiC1jvjrW2+3veZ6mrg036LfQltphucD1zM8fxcMLJU6CxVpXG
         kd3A==
X-Gm-Message-State: AOAM530OxQtza8ClcWQq3PsI3R3XySxBnRdmK6+/m5Mln0T9YZWKrVLg
        QCqMeusrJA029Q286aPaChevyiBJtWOdh5iwTg==
X-Google-Smtp-Source: ABdhPJwBuPWd2C+muqQ4RKmPIJ7jtrt1BSayTlDvsTOTCm6YFIuQuJ0GGFTYTkp1Q2Mds9iYgH04TKwzyZUTlo6kbd8=
X-Received: by 2002:a05:6a00:2449:b0:43c:4a5e:55a6 with SMTP id
 d9-20020a056a00244900b0043c4a5e55a6mr7963887pfj.43.1631842300444; Thu, 16 Sep
 2021 18:31:40 -0700 (PDT)
MIME-Version: 1.0
From:   Hao Sun <sunhao.th@gmail.com>
Date:   Fri, 17 Sep 2021 09:31:29 +0800
Message-ID: <CACkBjsa363oKxyFWU=dgc29L2vkJ9E7_N487A_m0jMeVtKdeDQ@mail.gmail.com>
Subject: possible deadlock in btrfs_inode_lock
To:     clm@fb.com, dsterba@suse.com, Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org, Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello,

When using Healer to fuzz the latest Linux kernel, the following crash
was triggered.

HEAD commit: ff1ffd71d5f0 Merge tag 'hyperv-fixes-signed-20210915
git tree: upstream
console output:
https://drive.google.com/file/d/1CAm8j7zOSUnKKJELSHPqROGx9COkgGaT/view?usp=sharing
kernel config: https://drive.google.com/file/d/1zXpDhs-IdE7tX17B7MhaYP0VGUfP6m9B/view?usp=sharing
Syzlang reproducer:
https://drive.google.com/file/d/1i2yUPMQufCrleyUmX5amxWuIC1XR5R8i/view?usp=sharing

Sorry, I don't have a C reproducer for this crash but have a Syzlang reproducer.
Also, hope the symbolized report can help.
Here are the instructions on how to execute Syzlang prog:
https://github.com/google/syzkaller/blob/master/docs/executing_syzkaller_programs.md

If you fix this issue, please add the following tag to the commit:
Reported-by: Hao Sun <sunhao.th@gmail.com>

FAULT_INJECTION: forcing a failure.
name failslab, interval 1, probability 0, space 0, times 0
CPU: 2 PID: 19110 Comm: syz-executor Not tainted 5.15.0-rc1+ #18
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
rel-1.12.0-59-gc9ba5276e321-prebuilt.qemu.org 04/01/2014
Call Trace:
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x8d/0xcf lib/dump_stack.c:106
 fail_dump lib/fault-inject.c:52 [inline]
 should_fail+0x13c/0x160 lib/fault-inject.c:146
 should_failslab+0x5/0x10 mm/slab_common.c:1328
 slab_pre_alloc_hook.constprop.99+0x4e/0xc0 mm/slab.h:494
 slab_alloc_node mm/slub.c:3120 [inline]
 slab_alloc mm/slub.c:3214 [inline]
 kmem_cache_alloc+0x44/0x280 mm/slub.c:3219
 btrfs_add_delayed_tree_ref+0xa1/0x580 fs/btrfs/delayed-ref.c:913
 btrfs_alloc_tree_block+0x478/0x670 fs/btrfs/extent-tree.c:4853
 __btrfs_cow_block+0x16f/0x820 fs/btrfs/ctree.c:415
 btrfs_cow_block+0x12a/0x300 fs/btrfs/ctree.c:570
 btrfs_search_slot+0x6b0/0xee0 fs/btrfs/ctree.c:1768
 btrfs_lookup_file_extent+0x66/0x90 fs/btrfs/file-item.c:244
 btrfs_drop_extents+0x174/0x1140 fs/btrfs/file.c:741
 cow_file_range_inline.constprop.69+0x56f/0x8f0 fs/btrfs/inode.c:395
 cow_file_range+0x3f2/0x500 fs/btrfs/inode.c:1102
 btrfs_run_delalloc_range+0x720/0x950 fs/btrfs/inode.c:1959
 writepage_delalloc+0x158/0x1d0 fs/btrfs/extent_io.c:3798
 __extent_writepage+0x287/0x5f0 fs/btrfs/extent_io.c:4093
 extent_write_cache_pages+0x3a1/0x710 fs/btrfs/extent_io.c:5009
 extent_writepages+0x5f/0xe0 fs/btrfs/extent_io.c:5130
 do_writepages+0xec/0x260 mm/page-writeback.c:2364
 filemap_fdatawrite_wbc+0xa4/0xf0 mm/filemap.c:400
 __filemap_fdatawrite_range mm/filemap.c:433 [inline]
 filemap_fdatawrite_range+0x60/0x80 mm/filemap.c:451
 btrfs_fdatawrite_range+0x23/0x70 fs/btrfs/file.c:3733
 start_ordered_ops.constprop.37+0x55/0x90 fs/btrfs/file.c:2077
 btrfs_sync_file+0xd3/0x760 fs/btrfs/file.c:2153
 vfs_fsync_range+0x48/0xa0 fs/sync.c:200
 generic_write_sync include/linux/fs.h:2955 [inline]
 btrfs_file_write_iter+0x34f/0x510 fs/btrfs/file.c:2034
 call_write_iter include/linux/fs.h:2163 [inline]
 new_sync_write+0x18d/0x260 fs/read_write.c:507
 vfs_write+0x43b/0x4a0 fs/read_write.c:594
 ksys_write+0xd2/0x120 fs/read_write.c:647
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x34/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x46ae99
Code: f7 d8 64 89 02 b8 ff ff ff ff c3 66 0f 1f 44 00 00 48 89 f8 48
89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d
01 f0 ff ff 73 01 c3 48 c7 c1 bc ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fd518c59c48 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 000000000078c158 RCX: 000000000046ae99
RDX: 000000000000001b RSI: 00000000200059c0 RDI: 0000000000000004
RBP: 00007fd518c59c80 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000011
R13: 0000000000000000 R14: 000000000078c158 R15: 00007ffe8c304f80
BTRFS: error (device loop6) in cow_file_range_inline:397: errno=-12
Out of memory
BTRFS info (device loop6): forced readonly

======================================================
WARNING: possible circular locking dependency detected
5.15.0-rc1+ #18 Not tainted
------------------------------------------------------
syz-executor/19110 is trying to acquire lock:
ffff888015170f68 (&sb->s_type->i_mutex_key#22){+.+.}-{3:3}, at:
inode_lock include/linux/fs.h:786 [inline]
ffff888015170f68 (&sb->s_type->i_mutex_key#22){+.+.}-{3:3}, at:
btrfs_inode_lock+0x65/0xb0 fs/btrfs/inode.c:126

but task is already holding lock:
ffff8880118027b8 (btrfs-tree-01/1){+.+.}-{3:3}, at:
__btrfs_tree_lock+0x2e/0x1a0 fs/btrfs/locking.c:112

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #2 (btrfs-tree-01/1){+.+.}-{3:3}:
       down_write_nested+0x3b/0x70 kernel/locking/rwsem.c:1627
       __btrfs_tree_lock+0x2e/0x1a0 fs/btrfs/locking.c:112
       btrfs_init_new_buffer fs/btrfs/extent-tree.c:4740 [inline]
       btrfs_alloc_tree_block+0x19c/0x670 fs/btrfs/extent-tree.c:4818
       __btrfs_cow_block+0x16f/0x820 fs/btrfs/ctree.c:415
       btrfs_cow_block+0x12a/0x300 fs/btrfs/ctree.c:570
       btrfs_search_slot+0x6b0/0xee0 fs/btrfs/ctree.c:1768
       btrfs_insert_empty_items+0x80/0xf0 fs/btrfs/ctree.c:3905
       btrfs_new_inode+0x311/0xa60 fs/btrfs/inode.c:6530
       btrfs_create+0x12b/0x270 fs/btrfs/inode.c:6783
       lookup_open+0x660/0x780 fs/namei.c:3282
       open_last_lookups fs/namei.c:3352 [inline]
       path_openat+0x465/0xe20 fs/namei.c:3557
       do_filp_open+0xe3/0x170 fs/namei.c:3588
       do_sys_openat2+0x357/0x4a0 fs/open.c:1200
       do_sys_open+0x87/0xd0 fs/open.c:1216
       do_syscall_x64 arch/x86/entry/common.c:50 [inline]
       do_syscall_64+0x34/0xb0 arch/x86/entry/common.c:80
       entry_SYSCALL_64_after_hwframe+0x44/0xae

-> #1 (btrfs-tree-01){++++}-{3:3}:
       down_read_nested+0x3e/0x160 kernel/locking/rwsem.c:1589
       __btrfs_tree_read_lock+0x2e/0x1a0 fs/btrfs/locking.c:47
       btrfs_tree_read_lock fs/btrfs/locking.c:54 [inline]
       btrfs_read_lock_root_node+0x4f/0x1c0 fs/btrfs/locking.c:191
       btrfs_search_slot_get_root fs/btrfs/ctree.c:1623 [inline]
       btrfs_search_slot+0x7e4/0xee0 fs/btrfs/ctree.c:1728
       btrfs_lookup_match_dir+0x48/0xa0 fs/btrfs/dir-item.c:183
       btrfs_lookup_xattr+0x76/0xc0 fs/btrfs/dir-item.c:360
       btrfs_getxattr+0x8b/0x190 fs/btrfs/xattr.c:38
       __vfs_getxattr+0x62/0x90 fs/xattr.c:399
       cap_inode_need_killpriv+0x21/0x30 security/commoncap.c:300
       security_inode_need_killpriv+0x25/0x50 security/security.c:1408
       dentry_needs_remove_privs.part.22+0x1c/0x50 fs/inode.c:1909
       dentry_needs_remove_privs include/linux/fs.h:3623 [inline]
       file_remove_privs+0xde/0x160 fs/inode.c:1950
       btrfs_write_check.isra.33+0xe0/0x2a0 fs/btrfs/file.c:1620
       btrfs_buffered_write+0xe7/0x9f0 fs/btrfs/file.c:1679
       btrfs_file_write_iter+0x1b3/0x510 fs/btrfs/file.c:2029
       call_write_iter include/linux/fs.h:2163 [inline]
       new_sync_write+0x18d/0x260 fs/read_write.c:507
       vfs_write+0x43b/0x4a0 fs/read_write.c:594
       ksys_write+0xd2/0x120 fs/read_write.c:647
       do_syscall_x64 arch/x86/entry/common.c:50 [inline]
       do_syscall_64+0x34/0xb0 arch/x86/entry/common.c:80
       entry_SYSCALL_64_after_hwframe+0x44/0xae

-> #0 (&sb->s_type->i_mutex_key#22){+.+.}-{3:3}:
       check_prev_add kernel/locking/lockdep.c:3051 [inline]
       check_prevs_add kernel/locking/lockdep.c:3174 [inline]
       validate_chain kernel/locking/lockdep.c:3789 [inline]
       __lock_acquire+0x161f/0x1d60 kernel/locking/lockdep.c:5015
       lock_acquire+0x1f9/0x340 kernel/locking/lockdep.c:5625
       down_write+0x38/0x70 kernel/locking/rwsem.c:1517
       inode_lock include/linux/fs.h:786 [inline]
       btrfs_inode_lock+0x65/0xb0 fs/btrfs/inode.c:126
       btrfs_sync_file+0x166/0x760 fs/btrfs/file.c:2157
       vfs_fsync_range+0x48/0xa0 fs/sync.c:200
       generic_write_sync include/linux/fs.h:2955 [inline]
       btrfs_file_write_iter+0x34f/0x510 fs/btrfs/file.c:2034
       call_write_iter include/linux/fs.h:2163 [inline]
       new_sync_write+0x18d/0x260 fs/read_write.c:507
       vfs_write+0x43b/0x4a0 fs/read_write.c:594
       ksys_write+0xd2/0x120 fs/read_write.c:647
       do_syscall_x64 arch/x86/entry/common.c:50 [inline]
       do_syscall_64+0x34/0xb0 arch/x86/entry/common.c:80
       entry_SYSCALL_64_after_hwframe+0x44/0xae

other info that might help us debug this:

Chain exists of:
  &sb->s_type->i_mutex_key#22 --> btrfs-tree-01 --> btrfs-tree-01/1

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(btrfs-tree-01/1);
                               lock(btrfs-tree-01);
                               lock(btrfs-tree-01/1);
  lock(&sb->s_type->i_mutex_key#22);

 *** DEADLOCK ***

3 locks held by syz-executor/19110:
 #0: ffff88800e39c8f0 (&f->f_pos_lock){+.+.}-{3:3}, at:
__fdget_pos+0x55/0x60 fs/file.c:990
 #1: ffff888019325460 (sb_writers#16){.+.+}-{0:0}, at:
ksys_write+0xd2/0x120 fs/read_write.c:647
 #2: ffff8880118027b8 (btrfs-tree-01/1){+.+.}-{3:3}, at:
__btrfs_tree_lock+0x2e/0x1a0 fs/btrfs/locking.c:112

stack backtrace:
CPU: 0 PID: 19110 Comm: syz-executor Not tainted 5.15.0-rc1+ #18
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
rel-1.12.0-59-gc9ba5276e321-prebuilt.qemu.org 04/01/2014
Call Trace:
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x8d/0xcf lib/dump_stack.c:106
 check_noncircular+0x105/0x120 kernel/locking/lockdep.c:2131
 check_prev_add kernel/locking/lockdep.c:3051 [inline]
 check_prevs_add kernel/locking/lockdep.c:3174 [inline]
 validate_chain kernel/locking/lockdep.c:3789 [inline]
 __lock_acquire+0x161f/0x1d60 kernel/locking/lockdep.c:5015
 lock_acquire+0x1f9/0x340 kernel/locking/lockdep.c:5625
 down_write+0x38/0x70 kernel/locking/rwsem.c:1517
 inode_lock include/linux/fs.h:786 [inline]
 btrfs_inode_lock+0x65/0xb0 fs/btrfs/inode.c:126
 btrfs_sync_file+0x166/0x760 fs/btrfs/file.c:2157
 vfs_fsync_range+0x48/0xa0 fs/sync.c:200
 generic_write_sync include/linux/fs.h:2955 [inline]
 btrfs_file_write_iter+0x34f/0x510 fs/btrfs/file.c:2034
 call_write_iter include/linux/fs.h:2163 [inline]
 new_sync_write+0x18d/0x260 fs/read_write.c:507
 vfs_write+0x43b/0x4a0 fs/read_write.c:594
 ksys_write+0xd2/0x120 fs/read_write.c:647
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x34/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x46ae99
Code: f7 d8 64 89 02 b8 ff ff ff ff c3 66 0f 1f 44 00 00 48 89 f8 48
89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d
01 f0 ff ff 73 01 c3 48 c7 c1 bc ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fd518c59c48 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 000000000078c158 RCX: 000000000046ae99
RDX: 000000000000001b RSI: 00000000200059c0 RDI: 0000000000000004
RBP: 00007fd518c59c80 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000011
R13: 0000000000000000 R14: 000000000078c158 R15: 00007ffe8c304f80
