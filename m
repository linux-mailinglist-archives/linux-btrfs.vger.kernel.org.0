Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6914B40BDB5
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Sep 2021 04:20:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232666AbhIOCVc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 14 Sep 2021 22:21:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbhIOCVb (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 14 Sep 2021 22:21:31 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF51EC061574;
        Tue, 14 Sep 2021 19:20:13 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id me5-20020a17090b17c500b0019af76b7bb4so3118377pjb.2;
        Tue, 14 Sep 2021 19:20:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=EfwGINLwvUb87bKHUJCAOOhi5xyh4UQBwHdyMSmXFAk=;
        b=WFQp3yn1qyygn5wrUSnmN46N1jkmhZ4wsdt8Pr16eKZ1koXHMwuuw/B+M51ZT4ROaA
         rcfMOj8wgMqiqk/l4Pc2qLfFkngt1wCmRPG2z7NkMFU82NZLBwsAVBAgRXKuhfm00HC8
         kUDrZ4Hw8ScKkQXMnb/7t7UdXOP+TZky0PW4SR13vS6uxlPDv2SLigov4PXWUonTzYMK
         ndiIzfHNV1EUAIPFx/MQTNoYD1QqrGL8ivtjRRUQRO7/SYwraXEKN0FwOmKHpiXvPtND
         AUS5rj5/wAUiSmPOUbuWsQyH9cfNS6TLdMuLA9d7ZeaVex7XYzzD4a2yubY2rNJkS+IC
         1FZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=EfwGINLwvUb87bKHUJCAOOhi5xyh4UQBwHdyMSmXFAk=;
        b=Yip/zravzrGnuqIniWcVt+vRXnudDwdX122dNqY9GdSUjMJ0zLi05HBHYy8uiQ77IQ
         kTBLL9p4sczMcAFUdT2F75mBuRb+CT5FgZq51MlHBmbv3bGZSDhB/cq/pfex2luQct3v
         N1iAyL0Bz1vCTbfT9nC2VbabyjaV/UEB76/3TrGAZYbzYv/f5qjofFNSsKvIPB7WfllD
         SXZqks2+PbztO1Opi/ecmaIAumVKAh3mjabmZfOV8eR+a++He8iZ0DKSctdmzZ2NhdIA
         F54hrkVMBIKTPqJEWp3MHac39lv8Vci2anmzUqVmRuDrDFq5HWAoF684iG6QP+sGfpxi
         mXAg==
X-Gm-Message-State: AOAM530c/Atqs9ImJ4xu0B4Sd6fXqYCEHJ2IKDD8I4vVP614tS8dEMGZ
        GS0Tipwcy/xop6Fw/Hk4FhLgN2jhDsp2LKJ5gg==
X-Google-Smtp-Source: ABdhPJxmQJFJTFITcPnt74e3ZG/Yt4rHE3oY35H7Fpfxg0ztFbDwrFjpHL4Kr16czxE+nwA+Ocdh2Mvt2jYHiqiIylY=
X-Received: by 2002:a17:902:7b84:b0:13b:90a7:e270 with SMTP id
 w4-20020a1709027b8400b0013b90a7e270mr13027773pll.21.1631672413243; Tue, 14
 Sep 2021 19:20:13 -0700 (PDT)
MIME-Version: 1.0
From:   Hao Sun <sunhao.th@gmail.com>
Date:   Wed, 15 Sep 2021 10:20:02 +0800
Message-ID: <CACkBjsYjkubyQBvBy7aaQStk_i1UuCu7oPNYXhZhvhWvBCM3ag@mail.gmail.com>
Subject: kernel BUG in __clear_extent_bit
To:     clm@fb.com, dsterba@suse.com, Josef Bacik <josef@toxicpanda.com>,
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
https://drive.google.com/file/d/1-9wwV6-OmBcJvHGCbMbP5_uCVvrUdTp3/view?usp=sharing
kernel config: https://drive.google.com/file/d/1rUzyMbe5vcs6khA3tL9EHTLJvsUdWcgB/view?usp=sharing
C reproducer: https://drive.google.com/file/d/1eXePTqMQ5ZA0TWtgpTX50Ez4q9ZKm_HE/view?usp=sharing
Syzlang reproducer:
https://drive.google.com/file/d/11s13louoKZ7Uz0mdywM2jmE9B1JEIt8U/view?usp=sharing

If you fix this issue, please add the following tag to the commit:
Reported-by: Hao Sun <sunhao.th@gmail.com>

loop1: detected capacity change from 0 to 32768
BTRFS info (device loop1): disk space caching is enabled
BTRFS info (device loop1): has skinny extents
BTRFS info (device loop1): enabling ssd optimizations
FAULT_INJECTION: forcing a failure.
name failslab, interval 1, probability 0, space 0, times 0
CPU: 1 PID: 25852 Comm: syz-executor Not tainted 5.15.0-rc1 #16
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
 alloc_extent_state+0x1e/0x1c0 fs/btrfs/extent_io.c:340
 alloc_extent_state_atomic include/linux/spinlock.h:403 [inline]
 __clear_extent_bit+0x646/0x6b0 fs/btrfs/extent_io.c:820
 try_release_extent_state fs/btrfs/extent_io.c:5218 [inline]
 try_release_extent_mapping+0x296/0x320 fs/btrfs/extent_io.c:5315
 __btrfs_releasepage fs/btrfs/inode.c:8493 [inline]
 btrfs_releasepage+0xcf/0x1a0 fs/btrfs/inode.c:8506
 try_to_release_page+0xe7/0x1c0 mm/filemap.c:3964
 invalidate_complete_page mm/truncate.c:203 [inline]
 invalidate_inode_page+0x10e/0x1d0 mm/truncate.c:255
 __invalidate_mapping_pages+0x104/0x310 mm/truncate.c:494
 btrfs_direct_write fs/btrfs/file.c:1997 [inline]
 btrfs_file_write_iter+0x398/0x510 fs/btrfs/file.c:2027
 call_write_iter include/linux/fs.h:2163 [inline]
 aio_write+0x165/0x360 fs/aio.c:1578
 __io_submit_one fs/aio.c:1833 [inline]
 io_submit_one+0x9dd/0x1490 fs/aio.c:1880
 __do_sys_io_submit fs/aio.c:1939 [inline]
 __se_sys_io_submit fs/aio.c:1909 [inline]
 __x64_sys_io_submit+0xba/0x310 fs/aio.c:1909
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x34/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x46ae99
Code: f7 d8 64 89 02 b8 ff ff ff ff c3 66 0f 1f 44 00 00 48 89 f8 48
89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d
01 f0 ff ff 73 01 c3 48 c7 c1 bc ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ff0725c5c48 EFLAGS: 00000246 ORIG_RAX: 00000000000000d1
RAX: ffffffffffffffda RBX: 000000000078c0a0 RCX: 000000000046ae99
RDX: 0000000020005880 RSI: 0000000000000001 RDI: 00007ff07259d000
RBP: 00007ff0725c5c80 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000032
R13: 0000000000000000 R14: 000000000078c0a0 R15: 00007ffd0c8ba9c0
------------[ cut here ]------------
kernel BUG at fs/btrfs/extent_io.c:821!
invalid opcode: 0000 [#1] PREEMPT SMP
CPU: 1 PID: 25852 Comm: syz-executor Not tainted 5.15.0-rc1 #16
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
rel-1.12.0-59-gc9ba5276e321-prebuilt.qemu.org 04/01/2014
RIP: 0010:__clear_extent_bit+0x653/0x6b0 fs/btrfs/extent_io.c:821
Code: 13 f5 ff ff 48 8b 7c 24 18 e8 d9 19 37 02 e9 ef fd ff ff e8 4f
d0 48 ff e8 6a df ff ff 48 85 c0 49 89 c6 75 99 e8 3d d0 48 ff <0f> 0b
e8 36 d0 48 ff 0f 0b e9 6f fe ff ff e8 2a d0 48 ff 48 8d 7b
RSP: 0018:ffffc9000d7a3968 EFLAGS: 00010212
RAX: 000000000002763c RBX: ffff88810f074000 RCX: ffffc90000b45000
RDX: 0000000000040000 RSI: ffffffff81eec1c3 RDI: ffffffff853cbec6
RBP: 0000000000000000 R08: 0000000000000088 R09: 0000000000000001
R10: ffffc9000d7a3838 R11: 0000000000000001 R12: 000000000000ffff
R13: 0000000000000fff R14: 0000000000000000 R15: ffff88810cd96788
FS:  00007ff0725c6700(0000) GS:ffff88813dc00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ff07259d000 CR3: 000000001c337000 CR4: 0000000000750ee0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
PKRU: 55555554
Call Trace:
 try_release_extent_state fs/btrfs/extent_io.c:5218 [inline]
 try_release_extent_mapping+0x296/0x320 fs/btrfs/extent_io.c:5315
 __btrfs_releasepage fs/btrfs/inode.c:8493 [inline]
 btrfs_releasepage+0xcf/0x1a0 fs/btrfs/inode.c:8506
 try_to_release_page+0xe7/0x1c0 mm/filemap.c:3964
 invalidate_complete_page mm/truncate.c:203 [inline]
 invalidate_inode_page+0x10e/0x1d0 mm/truncate.c:255
 __invalidate_mapping_pages+0x104/0x310 mm/truncate.c:494
 btrfs_direct_write fs/btrfs/file.c:1997 [inline]
 btrfs_file_write_iter+0x398/0x510 fs/btrfs/file.c:2027
 call_write_iter include/linux/fs.h:2163 [inline]
 aio_write+0x165/0x360 fs/aio.c:1578
 __io_submit_one fs/aio.c:1833 [inline]
 io_submit_one+0x9dd/0x1490 fs/aio.c:1880
 __do_sys_io_submit fs/aio.c:1939 [inline]
 __se_sys_io_submit fs/aio.c:1909 [inline]
 __x64_sys_io_submit+0xba/0x310 fs/aio.c:1909
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x34/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x46ae99
Code: f7 d8 64 89 02 b8 ff ff ff ff c3 66 0f 1f 44 00 00 48 89 f8 48
89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d
01 f0 ff ff 73 01 c3 48 c7 c1 bc ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ff0725c5c48 EFLAGS: 00000246 ORIG_RAX: 00000000000000d1
RAX: ffffffffffffffda RBX: 000000000078c0a0 RCX: 000000000046ae99
RDX: 0000000020005880 RSI: 0000000000000001 RDI: 00007ff07259d000
RBP: 00007ff0725c5c80 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000032
R13: 0000000000000000 R14: 000000000078c0a0 R15: 00007ffd0c8ba9c0
Modules linked in:
Dumping ftrace buffer:
   (ftrace buffer empty)
---[ end trace 3bbc6e927d377de3 ]---
RIP: 0010:__clear_extent_bit+0x653/0x6b0 fs/btrfs/extent_io.c:821
Code: 13 f5 ff ff 48 8b 7c 24 18 e8 d9 19 37 02 e9 ef fd ff ff e8 4f
d0 48 ff e8 6a df ff ff 48 85 c0 49 89 c6 75 99 e8 3d d0 48 ff <0f> 0b
e8 36 d0 48 ff 0f 0b e9 6f fe ff ff e8 2a d0 48 ff 48 8d 7b
RSP: 0018:ffffc9000d7a3968 EFLAGS: 00010212
RAX: 000000000002763c RBX: ffff88810f074000 RCX: ffffc90000b45000
RDX: 0000000000040000 RSI: ffffffff81eec1c3 RDI: ffffffff853cbec6
RBP: 0000000000000000 R08: 0000000000000088 R09: 0000000000000001
R10: ffffc9000d7a3838 R11: 0000000000000001 R12: 000000000000ffff
R13: 0000000000000fff R14: 0000000000000000 R15: ffff88810cd96788
FS:  00007ff0725c6700(0000) GS:ffff88813dc00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ff07259d000 CR3: 000000001c337000 CR4: 0000000000750ee0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
PKRU: 55555554
