Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45AE240A327
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 Sep 2021 04:15:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235873AbhINCQV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 13 Sep 2021 22:16:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230042AbhINCQV (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 13 Sep 2021 22:16:21 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 899FFC061574;
        Mon, 13 Sep 2021 19:15:04 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id k23-20020a17090a591700b001976d2db364so1550431pji.2;
        Mon, 13 Sep 2021 19:15:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=TBiT1s9alKg/oSooqVv6OWDteVE2Febc34bdsbXnCa0=;
        b=RuOIUQAOb71HSDQ6eeSB1B0tA3EG7OL/68p6WFjlUguQEDt0mx72GXVZSuH2GrXXP8
         vTnel+0qDihHiT+GqS79R5wbGRj3VZQe0e3hvNNdXI/KQVPIIvP5eXXfvpF/QXIq0Ne1
         o3uZLE0Cz6Jcpr1f3m+Pjc+3vA1PEly0J/n+U7HHAarOzEMbY8b4SNkNtqCpIQ/cgIt+
         OrkgOcoPwopnRzoi/lSPQ1UuEbezyu934EJl7q/1dffVDk9r96aRtiH3L4gu6gncOgD7
         7GqjlrhfqIC1PezlnhgOZK3y0gtBY7ZQd1zsdK68slKBlBYuBM9sMCsThkZQxNsDWd5t
         KGmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=TBiT1s9alKg/oSooqVv6OWDteVE2Febc34bdsbXnCa0=;
        b=QHWOoQ3wmYH5RrikOI94jWpjIx0M9fBLpO8s4Fwb5LYqMTGqhbsoHUSf6UZLATJBgu
         q9iarrHTzjfYBBLuRxJ9byopaQDW8TI0B5Z3/tK6oK+li9e7YEBjY7t0ombP4EunUQ0U
         xn/AaOcc0zhTGQvZz83B/UFeoYPWco7aQBBNjCf9dn6jX8+9VeZYzMJ+N2FDmq1aXr3Q
         Qi5jvEfONebFcUqdmiGPke5EgvLfIU8z5HaLfPdASEncy+VB/BkzixYlUvV89ZMuWk2s
         JVrUzrYkcglMFz6HqgNQS+HoglVR3MJv42CXQbxcthqJuGA80kDpDaEPmVZjhKOVdU0H
         KVjw==
X-Gm-Message-State: AOAM533Tmoka6a4/mgR8eF7tE5SEHuJ2Fs+hHxFmW5/3hEjltDL8eCVv
        Ok0H9I+Ozyw8XXnwfhAUHie+d8TgmFV0WVN047zJuSxGByqH
X-Google-Smtp-Source: ABdhPJwl/XhkGYLUNXGz26V313P+cabTyU+TnepWuqD45E5dGBOEGX9QsxDY8SffMUjjDlavs22yRQUhgXd+iAOSOVM=
X-Received: by 2002:a17:90a:b794:: with SMTP id m20mr2868541pjr.178.1631585703888;
 Mon, 13 Sep 2021 19:15:03 -0700 (PDT)
MIME-Version: 1.0
From:   Hao Sun <sunhao.th@gmail.com>
Date:   Tue, 14 Sep 2021 10:14:53 +0800
Message-ID: <CACkBjsYac=fRmNOYxmy9PV4m5jnkS27mWw+hYVtHLsofCEXpLw@mail.gmail.com>
Subject: WARNING in btrfs_add_link
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
https://drive.google.com/file/d/1k-EKaYce-IATg5g1DJgsip49IfG3GrpV/view?usp=sharing
kernel config: https://drive.google.com/file/d/1rUzyMbe5vcs6khA3tL9EHTLJvsUdWcgB/view?usp=sharing
C reproducer: https://drive.google.com/file/d/1YkHRFx6mtVvgXO6MEzuEpphazM1s4cgi/view?usp=sharing
Syzlang reproducer:
https://drive.google.com/file/d/1WgZC8xwdVLeWU2GuY_UC8tFmQD5fPENu/view?usp=sharing

If you fix this issue, please add the following tag to the commit:
Reported-by: Hao Sun <sunhao.th@gmail.com>

loop13: detected capacity change from 0 to 32768
BTRFS info (device loop13): disk space caching is enabled
BTRFS info (device loop13): has skinny extents
BTRFS info (device loop13): enabling ssd optimizations
FAULT_INJECTION: forcing a failure.
name failslab, interval 1, probability 0, space 0, times 0
CPU: 1 PID: 7350 Comm: syz-executor Not tainted 5.15.0-rc1 #16
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
 __btrfs_cow_block+0x16f/0x7d0 fs/btrfs/ctree.c:415
 btrfs_cow_block+0x12a/0x300 fs/btrfs/ctree.c:570
 btrfs_search_slot+0x6b0/0xee0 fs/btrfs/ctree.c:1768
 btrfs_insert_empty_items+0x80/0xf0 fs/btrfs/ctree.c:3905
 btrfs_insert_empty_item fs/btrfs/ctree.h:2905 [inline]
 insert_with_overflow+0x5e/0x170 fs/btrfs/dir-item.c:33
 btrfs_insert_dir_item+0xd2/0x290 fs/btrfs/dir-item.c:134
 btrfs_add_link+0xf1/0x660 fs/btrfs/inode.c:6631
 btrfs_add_nondir fs/btrfs/inode.c:6687 [inline]
 btrfs_create+0x21a/0x270 fs/btrfs/inode.c:6809
 lookup_open+0x660/0x780 fs/namei.c:3282
 open_last_lookups fs/namei.c:3352 [inline]
 path_openat+0x465/0xe20 fs/namei.c:3557
 do_filp_open+0xe3/0x170 fs/namei.c:3588
 do_sys_openat2+0x357/0x4a0 fs/open.c:1200
 do_sys_open+0x87/0xd0 fs/open.c:1216
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x34/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x46ae99
Code: f7 d8 64 89 02 b8 ff ff ff ff c3 66 0f 1f 44 00 00 48 89 f8 48
89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d
01 f0 ff ff 73 01 c3 48 c7 c1 bc ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fb8f3a31c48 EFLAGS: 00000246 ORIG_RAX: 0000000000000055
RAX: ffffffffffffffda RBX: 000000000078c0a0 RCX: 000000000046ae99
RDX: 0000000000000000 RSI: 00000000000000a1 RDI: 0000000020005800
RBP: 00007fb8f3a31c80 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000029
R13: 0000000000000000 R14: 000000000078c0a0 R15: 00007ffdb4e84790
------------[ cut here ]------------
WARNING: CPU: 3 PID: 7350 at fs/btrfs/inode.c:6636
btrfs_add_link+0x4c9/0x660 fs/btrfs/inode.c:6636
Modules linked in:
CPU: 3 PID: 7350 Comm: syz-executor Not tainted 5.15.0-rc1 #16
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
rel-1.12.0-59-gc9ba5276e321-prebuilt.qemu.org 04/01/2014
RIP: 0010:btrfs_add_link+0x4c9/0x660 fs/btrfs/inode.c:6636
Code: 4a ff 41 83 fd fb 0f 84 bd 00 00 00 41 83 fd e2 0f 84 b3 00 00
00 e8 c6 dd 4a ff 44 89 ee 48 c7 c7 38 25 39 85 e8 e7 e4 35 ff <0f> 0b
e8 b0 dd 4a ff 48 8b 7d a0 44 89 e9 ba ec 19 00 00 48 c7 c6
RSP: 0018:ffffc90005b8fab8 EFLAGS: 00010286
RAX: 0000000000000000 RBX: ffff88810853a560 RCX: ffffc90001229000
RDX: 0000000000040000 RSI: ffffffff812d18bc RDI: 00000000ffffffff
RBP: ffffc90005b8fb38 R08: 0000000000000000 R09: 0000000000000001
R10: ffffc90005b8f8a8 R11: 0000000000000004 R12: 0000000000000100
R13: 00000000fffffff4 R14: 0000000000000107 R15: ffff88810853aeb8
FS:  00007fb8f3a32700(0000) GS:ffff88813dd00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000563bd7c7d150 CR3: 0000000018c7f000 CR4: 0000000000750ee0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
PKRU: 55555554
Call Trace:
 btrfs_add_nondir fs/btrfs/inode.c:6687 [inline]
 btrfs_create+0x21a/0x270 fs/btrfs/inode.c:6809
 lookup_open+0x660/0x780 fs/namei.c:3282
 open_last_lookups fs/namei.c:3352 [inline]
 path_openat+0x465/0xe20 fs/namei.c:3557
 do_filp_open+0xe3/0x170 fs/namei.c:3588
 do_sys_openat2+0x357/0x4a0 fs/open.c:1200
 do_sys_open+0x87/0xd0 fs/open.c:1216
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x34/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x46ae99
Code: f7 d8 64 89 02 b8 ff ff ff ff c3 66 0f 1f 44 00 00 48 89 f8 48
89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d
01 f0 ff ff 73 01 c3 48 c7 c1 bc ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fb8f3a31c48 EFLAGS: 00000246 ORIG_RAX: 0000000000000055
RAX: ffffffffffffffda RBX: 000000000078c0a0 RCX: 000000000046ae99
RDX: 0000000000000000 RSI: 00000000000000a1 RDI: 0000000020005800
RBP: 00007fb8f3a31c80 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000029
R13: 0000000000000000 R14: 000000000078c0a0 R15: 00007ffdb4e84790
