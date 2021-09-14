Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0B8E40A388
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 Sep 2021 04:24:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237454AbhINCZw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 13 Sep 2021 22:25:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235213AbhINCZv (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 13 Sep 2021 22:25:51 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BF9DC061574;
        Mon, 13 Sep 2021 19:24:35 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id k23-20020a17090a591700b001976d2db364so1565011pji.2;
        Mon, 13 Sep 2021 19:24:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=mFtaEiqqYDzNMLrfN5SM449lPxfZfrlK4+HH8BkLiD8=;
        b=oLJwcPhmIxxadtxdvIofAZG+y85SMJ2N+XzB2xhGm8ke6Lxcwx4Bs1DW84ytQyCLVQ
         QrHI6HWEkInX4pdCXuouhLMBv/h/pG3uSZ6io8i2e58j2NRpEs2tV/K/6q985lmtPLxS
         YdNK0kJCfiOubxifiLGgoaRStSEoNs6kqpFKrCv5/dGEAoyuNj+t8FfE3z0lkQBTq1oH
         CPkpIu5sXGCG5Pyu41N38vhKiOH2OeKppls1Xusq6ijSObF5BtdqxdODG1sTSoPhFPl0
         h+DG1/3AhuCpsR9zp01oOijC6L15nBMbsZvumOvzqgSPICOVtXcF3wpgzAV4MlDCqNmi
         CSPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=mFtaEiqqYDzNMLrfN5SM449lPxfZfrlK4+HH8BkLiD8=;
        b=5NYJdHDsIWh/Oq0J3jO2EJAg/N6YY0ThzZriFeeBht0EAhF03rFFF13X0ERNAeSL9k
         ArgByHjFtePTaksCZd7ULAov8paCEt2kqZJ2gxGIebHF6xCIespQ4SiH1DdasPth6NBu
         kd9JCCm7aN3D+s2ZYeOjQeOjoSSmYiVZGKzVG+eht+GZen40lbeOZpgkWssl7nfxXtgh
         YS0UIDdxCP9/z9p6qAM0l2g3rptbgVjNwykApnC/k2J8ZA5j4QSYTHLRvw+WPoxH784n
         SHR8oJ7sBDy28+H6w/zxNUyxC0SpoSTdsg9HYTIcDeSEF4I4L/jd0SMULA9JA6EZ2nEy
         eEnA==
X-Gm-Message-State: AOAM531Vp8KqRP2vhIOCRDiatWzohjlzm7whVTYxbyXFO4KTz57eQaK9
        5kq45DRRLYju62qJixUq0CfKDCw8UGCIucbpuD1ofILxynJ9
X-Google-Smtp-Source: ABdhPJydLfr2MY2ixicBwJBAxy95CfAdwyMxnopwcnhPLWocf7RlZP1cGESv687kgYDdz7TmXKzncKSeqLlTU7GEOmI=
X-Received: by 2002:a17:90b:4b52:: with SMTP id mi18mr2792588pjb.112.1631586274501;
 Mon, 13 Sep 2021 19:24:34 -0700 (PDT)
MIME-Version: 1.0
From:   Hao Sun <sunhao.th@gmail.com>
Date:   Tue, 14 Sep 2021 10:24:23 +0800
Message-ID: <CACkBjsbP4DpRNc0YNBzhYxtwSX1-7krBvFrWB2J3O1Kae3NgTg@mail.gmail.com>
Subject: WARNING in cow_file_range_inline
To:     clm@fb.com, dsterba@suse.com, josef@toxicpanda.com,
        linux-btrfs@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello,

When using Healer to fuzz the latest Linux kernel, the following crash
was triggered.

HEAD commit: 6880fa6c5660 Linux 5.15-rc1
git tree: upstream
console output:
https://drive.google.com/file/d/17DFBJtsnY_h29uJ65fGamMlGRVsIv31I/view?usp=sharing
kernel config: https://drive.google.com/file/d/1rUzyMbe5vcs6khA3tL9EHTLJvsUdWcgB/view?usp=sharing
Syzlang reproducer:
https://drive.google.com/file/d/1Ymq-g9WYhukVEb43nZbAJvrKeWVZkcrX/view?usp=sharing

Sorry, I don't have a C reproducer for this crash but have a Syzlang
reproducer. Also, hope the symbolized report can help.
Here are the instructions on how to execute Syzlang prog:
https://github.com/google/syzkaller/blob/master/docs/executing_syzkaller_programs.md

If you fix this issue, please add the following tag to the commit:
Reported-by: Hao Sun <sunhao.th@gmail.com>

FAULT_INJECTION: forcing a failure.
name failslab, interval 1, probability 0, space 0, times 0
CPU: 0 PID: 8122 Comm: syz-executor Not tainted 5.15.0-rc1 #16
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
 btrfs_alloc_delayed_extent_op fs/btrfs/delayed-ref.h:299 [inline]
 btrfs_alloc_tree_block+0x38c/0x670 fs/btrfs/extent-tree.c:4833
 __btrfs_cow_block+0x16f/0x7d0 fs/btrfs/ctree.c:415
 btrfs_cow_block+0x12a/0x300 fs/btrfs/ctree.c:570
 btrfs_search_slot+0x6b0/0xee0 fs/btrfs/ctree.c:1768
 btrfs_lookup_file_extent+0x66/0x90 fs/btrfs/file-item.c:244
 btrfs_drop_extents+0x174/0x1100 fs/btrfs/file.c:741
 cow_file_range_inline.constprop.69+0x570/0x8a0 fs/btrfs/inode.c:395
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
RSP: 002b:00007f56408e2c48 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 000000000078c158 RCX: 000000000046ae99
RDX: 000000000000001b RSI: 0000000020005a00 RDI: 0000000000000008
RBP: 00007f56408e2c80 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 000000000000000f
R13: 0000000000000000 R14: 000000000078c158 R15: 00007fff60e50b60
------------[ cut here ]------------
WARNING: CPU: 0 PID: 8122 at fs/btrfs/inode.c:397
cow_file_range_inline.constprop.69+0x783/0x8a0 fs/btrfs/inode.c:397
Modules linked in:
CPU: 0 PID: 8122 Comm: syz-executor Not tainted 5.15.0-rc1 #16
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
rel-1.12.0-59-gc9ba5276e321-prebuilt.qemu.org 04/01/2014
RIP: 0010:cow_file_range_inline.constprop.69+0x783/0x8a0 fs/btrfs/inode.c:397
Code: a8 c8 19 00 00 03 72 24 e8 4a 74 4b ff 83 fb fb 74 3c 83 fb e2
74 37 e8 3b 74 4b ff 89 de 48 c7 c7 38 25 39 85 e8 5d 7b 36 ff <0f> 0b
e8 26 74 4b ff 48 8b 7c 24 08 89 d9 ba 8d 01 00 00 48 c7 c6
RSP: 0018:ffffc9000a407728 EFLAGS: 00010286
RAX: 0000000000000000 RBX: 00000000fffffff4 RCX: ffffc9000275d000
RDX: 0000000000040000 RSI: ffffffff812d18bc RDI: 00000000ffffffff
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000001
R10: ffffc9000a407370 R11: 0000000000000004 R12: ffff888105540000
R13: 0000000000000000 R14: 000000000000001b R15: ffff888014754168
FS:  00007f56408e3700(0000) GS:ffff88807dc00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000400200 CR3: 0000000106cdc000 CR4: 0000000000750ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
PKRU: 55555554
Call Trace:
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
RSP: 002b:00007f56408e2c48 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 000000000078c158 RCX: 000000000046ae99
RDX: 000000000000001b RSI: 0000000020005a00 RDI: 0000000000000008
RBP: 00007f56408e2c80 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 000000000000000f
R13: 0000000000000000 R14: 000000000078c158 R15: 00007fff60e50b60
