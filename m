Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C1A440A37C
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 Sep 2021 04:20:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238162AbhINCVu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 13 Sep 2021 22:21:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237647AbhINCVn (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 13 Sep 2021 22:21:43 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0868DC06124A;
        Mon, 13 Sep 2021 19:18:50 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id oc9so7770239pjb.4;
        Mon, 13 Sep 2021 19:18:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=ZjnEUVDZlcQBlT0GPRypJ+Pr01YEVd6A0PfM6/6/JU8=;
        b=FuKVISuVIof2mHWazyjo/ImJ8SPpja1oAuZXbg/EaMk7MYKygmhHgEaPDVuKQN8B+h
         6HvpcYZhGJfow/r0XOAUXzW+b2aOLX2BtpsuFBm/EeMocSoQtDNxQqvlqs+uy8TKUeVl
         5OVYiMXH60r+M3Q4wmF2dc5xWlLPb9gmhCa2FbbQxpRKUA0SIqv0HkkZc1aUEgxpNK/t
         ScmQvjykf44cileBDblB+MREhxO4UATNVYrY2QLmfHt27+OYcFz6C2VqRO3azwHcVugX
         kRBZWnD464FuX2KAWCgO7toIbCe4OToDlF+vs2J7g/Y4hddbdEDP1tPTso4EsvitW/97
         uCsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=ZjnEUVDZlcQBlT0GPRypJ+Pr01YEVd6A0PfM6/6/JU8=;
        b=hV6JAQu5Yzdd/n9vMCanrHO9JnqtVLriCQvatmA9AzRn7+ij+bPuDW2XSzcEzOIqKy
         OEdgVAbgU+9Q9a/V3QmITKC25aA2el/z6ucd+x/tMrH51HvySTtYsKp/voYV9C6ubNlR
         Dxsc2+HZ/BmIhnwnX7v/CzC3pxYDu5Y6y5JwxtNnn63YODuKIl0QJx8TIPwhAsv3WWy2
         bH/j5Ky2h7KmFuX3HczyiZpXyOXdPgkj1TeXEKDHWlWbpNJL8/N9+EMxzQPjBRIS+n0H
         ZYtNTI9+i2FK8zvL5iir+J2nzKoeSYcXHKGvR98eZ2G12e1awdjh93row0ZGrNYRm+95
         enUw==
X-Gm-Message-State: AOAM530Q6096NwdU9+JBsPqwffIEZatgnpasOia9Im4apLYncNl3omrH
        iV9HUnWv1Yubqp2dA1nYSziY8LKiB4PgSKNxbw==
X-Google-Smtp-Source: ABdhPJyOV7beVC5e345M3tm6U3ZEfjzuYTRMIWcOy6QtiUcVOuBk00yTc2/JHZyULX/nafDZl9zyzGcPrkPs9fSarcs=
X-Received: by 2002:a17:902:d892:b0:138:abfd:ec7d with SMTP id
 b18-20020a170902d89200b00138abfdec7dmr13038354plz.15.1631585929382; Mon, 13
 Sep 2021 19:18:49 -0700 (PDT)
MIME-Version: 1.0
From:   Hao Sun <sunhao.th@gmail.com>
Date:   Tue, 14 Sep 2021 10:18:38 +0800
Message-ID: <CACkBjsarjoAK5mi17h-J6Ho9_OuizGL392GhHRhDfQmz7rvV3w@mail.gmail.com>
Subject: WARNING in btrfs_destroy_inode
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
https://drive.google.com/file/d/1EkNxlN6n1-wDS9noBR1g9RaPemdvLbS7/view?usp=sharing
kernel config: https://drive.google.com/file/d/1rUzyMbe5vcs6khA3tL9EHTLJvsUdWcgB/view?usp=sharing
C reproducer: https://drive.google.com/file/d/1iLdo-E88rP9jbMhZl4rqkGzXuZv-PuK-/view?usp=sharing
Syzlang reproducer:
https://drive.google.com/file/d/1VIpdHD0TOXhg_AMkgWvgBKZ4rInXaCvW/view?usp=sharing

If you fix this issue, please add the following tag to the commit:
Reported-by: Hao Sun <sunhao.th@gmail.com>

loop0: detected capacity change from 0 to 32768
BTRFS info (device loop0): disk space caching is enabled
BTRFS info (device loop0): has skinny extents
BTRFS info (device loop0): enabling ssd optimizations
FAULT_INJECTION: forcing a failure.
name failslab, interval 1, probability 0, space 0, times 0
CPU: 3 PID: 8658 Comm: syz-executor Not tainted 5.15.0-rc1 #16
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
 lsm_inode_alloc security/security.c:593 [inline]
 security_inode_alloc+0x2c/0xb0 security/security.c:1018
 inode_init_always+0x116/0x2d0 fs/inode.c:170
 alloc_inode+0x44/0xd0 fs/inode.c:242
 new_inode_pseudo+0x12/0x70 fs/inode.c:936
 new_inode+0x18/0x40 fs/inode.c:965
 btrfs_new_inode+0xee/0xa60 fs/btrfs/inode.c:6448
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
RIP: 0033:0x46ae99
Code: f7 d8 64 89 02 b8 ff ff ff ff c3 66 0f 1f 44 00 00 48 89 f8 48
89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d
01 f0 ff ff 73 01 c3 48 c7 c1 bc ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fa3990f1c48 EFLAGS: 00000246 ORIG_RAX: 0000000000000055
RAX: ffffffffffffffda RBX: 000000000078c0a0 RCX: 000000000046ae99
RDX: 0000000000000000 RSI: 00000000000000a1 RDI: 0000000020005800
RBP: 00007fa3990f1c80 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 000000000000000c
R13: 0000000000000000 R14: 000000000078c0a0 R15: 00007ffcee8291d0
------------[ cut here ]------------
WARNING: CPU: 3 PID: 8658 at fs/btrfs/inode.c:9150
btrfs_destroy_inode+0x207/0x340 fs/btrfs/inode.c:9150
Modules linked in:
CPU: 3 PID: 8658 Comm: syz-executor Not tainted 5.15.0-rc1 #16
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
rel-1.12.0-59-gc9ba5276e321-prebuilt.qemu.org 04/01/2014
RIP: 0010:btrfs_destroy_inode+0x207/0x340 fs/btrfs/inode.c:9150
Code: 00 00 4c 89 ef e8 19 a4 38 02 4d 85 f6 0f 85 4e ff ff ff e8 8b
5a 4a ff 4c 89 e7 e8 a3 39 fe ff e9 3c ff ff ff e8 79 5a 4a ff <0f> 0b
e8 72 5a 4a ff 48 83 bb d0 03 00 00 00 0f 84 22 fe ff ff e8
RSP: 0018:ffffc9000ce039d0 EFLAGS: 00010216
RAX: 0000000000024829 RBX: ffff888108670e18 RCX: ffffc90001239000
RDX: 0000000000040000 RSI: ffffffff81ed3787 RDI: ffff888108670e18
RBP: ffffffff81ed3580 R08: 0000000000000020 R09: 0000000000000001
R10: ffffc9000ce038b8 R11: 0000000000000003 R12: 0000000000000000
R13: ffff8881011dd9a0 R14: ffff88800d9f01a8 R15: 0000000000000000
FS:  00007fa3990f2700(0000) GS:ffff88813dd00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000001b74c48 CR3: 0000000109fec000 CR4: 0000000000750ee0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
PKRU: 55555554
Call Trace:
 alloc_inode+0x6e/0xd0 fs/inode.c:244
 new_inode_pseudo+0x12/0x70 fs/inode.c:936
 new_inode+0x18/0x40 fs/inode.c:965
 btrfs_new_inode+0xee/0xa60 fs/btrfs/inode.c:6448
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
RIP: 0033:0x46ae99
Code: f7 d8 64 89 02 b8 ff ff ff ff c3 66 0f 1f 44 00 00 48 89 f8 48
89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d
01 f0 ff ff 73 01 c3 48 c7 c1 bc ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fa3990f1c48 EFLAGS: 00000246 ORIG_RAX: 0000000000000055
RAX: ffffffffffffffda RBX: 000000000078c0a0 RCX: 000000000046ae99
RDX: 0000000000000000 RSI: 00000000000000a1 RDI: 0000000020005800
RBP: 00007fa3990f1c80 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 000000000000000c
R13: 0000000000000000 R14: 000000000078c0a0 R15: 00007ffcee8291d0
