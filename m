Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AD9340A380
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 Sep 2021 04:21:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235213AbhINCWh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 13 Sep 2021 22:22:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235647AbhINCWf (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 13 Sep 2021 22:22:35 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5649FC061760;
        Mon, 13 Sep 2021 19:21:19 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id q22so10732315pfu.0;
        Mon, 13 Sep 2021 19:21:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=M4Tv9bjAaKp5byaEpuTY+Ye0rc/qVr7eDIPI/aZnN6c=;
        b=jlvmH5NQVI6CHzTX0hDJ6agNvZX996ohJUbrfnjWu6FY8jRUMCKDe3d+oy4vy2hdNG
         0m/Wtl3jwoensgbtRyki6ldnsQo7X60q1FOByW5SDxVS/B07pZVwqNDu/VbW68IO7NUg
         jNSATfQj55NadAQUBNcfVBBPbMDJUr/nJSXMfO/f1ohjd0jHm7063Jcf/vI/inOrmcbM
         cESO6CKKAzhi06VLfGrvUXWp9kMGtThUW4CvkgpxF/TrMe7M0zkDNfRxgJDM26hYr3yS
         rO5xKQNM2VJ4ZJhKrVOfxvKDzur0KOUcrq+e0W7qgXnRWIIw1YFaFxFs23iAEVRikra6
         EW+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=M4Tv9bjAaKp5byaEpuTY+Ye0rc/qVr7eDIPI/aZnN6c=;
        b=flcxfFwlhs2trOe8zUz1BMwfsJUHa5WMDnImtS4hFsMFRd06/He63yfO5gdtdM1V3b
         DM9y3K9+GuNN/Tfcfq2vESRFjid8pNDVp7NyThB4TKsYnaGmtCo2vHnc/7JpDdVEDqrT
         ixTe9dqEnRotiv/lR1kN2wSuzTre0NpeGbrD6+KQVOJbk/8nMvrjBsu72XD+nPV1+DcE
         3g4of5NpRqm+FvD3JMP1ydNEz31E4cksAc5og6nuQd4TueeRgZDzEf4EO/AogBfXNS66
         VXqCCuLmKFS67AAQdfqRCyLtDpD+6iMLtNZMLFCG2j4ZA8Vd2JjtNT/p3XdQ4dV7a2fi
         R9LQ==
X-Gm-Message-State: AOAM532SBtMNEzDBSywE6t9ppWvDSIy24tmt6LjKmoBF4r3+jm6vBFXB
        55/KKMwjoN7+z7XlwDLP/7zJXgEj71+mveuhiUlOdogGaInV
X-Google-Smtp-Source: ABdhPJyh1XYLDi/GFn071QQSG1EYkzG5lNGBezbIIw+PJLTVaiWNhKnh5EaEf9E8rVLAY79mVATS5i0QUAMmWiKaGac=
X-Received: by 2002:a62:920b:0:b0:3ec:7912:82be with SMTP id
 o11-20020a62920b000000b003ec791282bemr2487677pfd.34.1631586078786; Mon, 13
 Sep 2021 19:21:18 -0700 (PDT)
MIME-Version: 1.0
From:   Hao Sun <sunhao.th@gmail.com>
Date:   Tue, 14 Sep 2021 10:21:07 +0800
Message-ID: <CACkBjsbi1nc0woug-sdoB7u0tC10vdowSV71yL0zKBVR4i_2BA@mail.gmail.com>
Subject: WARNING in btrfs_sync_log
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
https://drive.google.com/file/d/1lmJTheZfyomG8EeaBnn4QYPIoQcXl12A/view?usp=sharing
kernel config: https://drive.google.com/file/d/1rUzyMbe5vcs6khA3tL9EHTLJvsUdWcgB/view?usp=sharing
C reproducer: https://drive.google.com/file/d/1ejGmKdXivo5Riz2L90rWIGD7tXS168RM/view?usp=sharing
Syzlang reproducer:
https://drive.google.com/file/d/1HlNZYZMwt3C71irTKL7cngOjJhLDH2Fl/view?usp=sharing

If you fix this issue, please add the following tag to the commit:
Reported-by: Hao Sun <sunhao.th@gmail.com>

loop3: detected capacity change from 0 to 32768
BTRFS info (device loop3): disk space caching is enabled
BTRFS info (device loop3): has skinny extents
BTRFS info (device loop3): enabling ssd optimizations
FAULT_INJECTION: forcing a failure.
name failslab, interval 1, probability 0, space 0, times 0
CPU: 0 PID: 23522 Comm: syz-executor Not tainted 5.15.0-rc1 #16
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
 kmem_cache_zalloc include/linux/slab.h:711 [inline]
 btrfs_alloc_path fs/btrfs/ctree.c:79 [inline]
 btrfs_insert_item+0x43/0x110 fs/btrfs/ctree.c:3931
 update_log_root fs/btrfs/tree-log.c:2968 [inline]
 btrfs_sync_log+0xbbb/0x13c0 fs/btrfs/tree-log.c:3196
 btrfs_sync_file+0x3b2/0x760 fs/btrfs/file.c:2285
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
RSP: 002b:00007f7f718d0c48 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 000000000078c0a0 RCX: 000000000046ae99
RDX: 000000000000001b RSI: 0000000020005880 RDI: 0000000000000008
RBP: 00007f7f718d0c80 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 000000000000001f
R13: 0000000000000000 R14: 000000000078c0a0 R15: 00007ffde6a0b1e0
------------[ cut here ]------------
WARNING: CPU: 0 PID: 23522 at fs/btrfs/tree-log.c:3205
btrfs_sync_log+0x124d/0x13c0 fs/btrfs/tree-log.c:3205
Modules linked in:
CPU: 0 PID: 23522 Comm: syz-executor Not tainted 5.15.0-rc1 #16
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
rel-1.12.0-59-gc9ba5276e321-prebuilt.qemu.org 04/01/2014
RIP: 0010:btrfs_sync_log+0x124d/0x13c0 fs/btrfs/tree-log.c:3205
Code: ff ff 41 83 fe fb 0f 84 aa 00 00 00 41 83 fe e2 0f 84 a0 00 00
00 e8 22 2f 45 ff 44 89 f6 48 c7 c7 38 25 39 85 e8 43 36 30 ff <0f> 0b
e8 0c 2f 45 ff 8b 8d a0 fd ff ff ba 85 0c 00 00 48 c7 c6 70
RSP: 0018:ffffc90001cf3a10 EFLAGS: 00010286
RAX: 0000000000000000 RBX: ffff88801e248000 RCX: ffffc90001261000
RDX: 0000000000040000 RSI: ffffffff812d18bc RDI: 00000000ffffffff
RBP: ffffc90001cf3cc0 R08: 0000000000000000 R09: 0000000000000001
R10: ffffc90001cf37a8 R11: 0000000000000004 R12: ffffc90001cf3ab0
R13: ffff88801dd2b000 R14: 00000000fffffff4 R15: ffff88801e248338
FS:  00007f7f718d1700(0000) GS:ffff88807dc00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fe7fcdb0000 CR3: 0000000013ddd000 CR4: 0000000000752ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
PKRU: 55555554
Call Trace:
 btrfs_sync_file+0x3b2/0x760 fs/btrfs/file.c:2285
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
RSP: 002b:00007f7f718d0c48 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 000000000078c0a0 RCX: 000000000046ae99
RDX: 000000000000001b RSI: 0000000020005880 RDI: 0000000000000008
RBP: 00007f7f718d0c80 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 000000000000001f
R13: 0000000000000000 R14: 000000000078c0a0 R15: 00007ffde6a0b1e0
