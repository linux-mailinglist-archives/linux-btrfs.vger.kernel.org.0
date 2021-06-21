Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F7F63AE54F
	for <lists+linux-btrfs@lfdr.de>; Mon, 21 Jun 2021 10:53:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229937AbhFUIzl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 21 Jun 2021 04:55:41 -0400
Received: from mout.gmx.net ([212.227.17.20]:42795 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229618AbhFUIzk (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 21 Jun 2021 04:55:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1624265598;
        bh=xGyxc1FFHH6QCDZO74Zffbcu49EYtjgCBz+kBrrTuUA=;
        h=X-UI-Sender-Class:To:References:From:Subject:Date:In-Reply-To;
        b=X9BroMiE9dqndNDP52oaN7EGLrgUm9BIne/D2Jhhdfabx++4NHwxq4LSAYjM9BTcP
         ZBJFWd0jylSXN7VZ8j24n80z4fPmpBGkIFLZcobF0LWKztAbwn1ERTUtdGnY6OpyGm
         iUe/DIHLpDrSE0oqu0bh5ax13hOFrELi30svZU8E=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MKsnF-1lhAdU2HbZ-00LDSw; Mon, 21
 Jun 2021 10:53:18 +0200
To:     syzbot <syzbot+38cd5310bb0818ffc964@syzkaller.appspotmail.com>,
        clm@fb.com, dsterba@suse.com, josef@toxicpanda.com,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
References: <000000000000502c1a05c53fa2e1@google.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: [syzbot] general protection fault in detach_extent_buffer_page
Message-ID: <a6d02720-702b-0360-351e-b1470a6b105b@gmx.com>
Date:   Mon, 21 Jun 2021 16:53:12 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <000000000000502c1a05c53fa2e1@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:wKCJ2vgW4LyvkhBdSTISS852RbbuZAq8PGsysE1TvzapOhrZ19q
 dm+vtFUv9EfhOzUUmoSxZFU3x1Hot0w9wmN8PfpXg9RGJ5l23MImNYFdl4M5deQjWa2EB0L
 gnUGKwO4LUtszD9RcMlDXdqOpip8tDaN57b9dqGLOLlCVO5YhpsZoKE1QXXBNn+JPAjNt5M
 wV7zdlZM0gcbgpMCsmfcw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:37mz1NgMJbM=:igjM6W7o3/4Jlfp09YQjby
 jIjeRCBPR8/5tzpCxjUwo6V81grDXg0Hhv7vtNb1M1r1a+7be9f+kC09F/3fUPrkuArwqQzEr
 l2jQDIKbWIYRptgMDxnuAsIxKzIW7Xg7CUW2OiwPX9whGsquzhN7GQBKG18UQa8VAfRvDksHL
 pKdSIjSW691y15lN5Np32BYlBVHvkYERgPcVuNODvw0M8RHUblqL9WpLevrvIJl9XcRVAGR+b
 QehYnYWy8Bq08cxN0Jp+OPJ4Vnn5Atyff2GNGBnDlBqd5zFd3HKBuTnBPb8tFYrVSzMEE0gd9
 CgsFHGLVq2W3iMBXUKeKcambgJKymSpFMzlxfE4ocOJJNZXwlUEPmkoVu9/uVrfau0UiPvC+a
 u7MVbQVvCepRXPYSdOfkEakUfybSdUsESPACZj2nHxR9uWiALzvS9iAI/fnHJF75IczTqupUg
 FXONYMsfTmemaPy2Vu1UJt8XFcVcJSjyhVwKX7eHwCLrVdeQc289ff8IHHyQ+fK5dnzQTWjBc
 9Ni0X3zGcj9ZVwp1yOW4w9k4S1M09uQGFNfuu9VeMI61dLOY8Lq3kE2K6HdZZh7m4mWI9mllz
 h8YKKln0x+JQcQy0ybZ42fSTZ0l1RMVaPffjE1BhH8o0vWszVWNyCwvbwkCKo8wIWuKIa/Mla
 CBLQ23Dkd2Af+D/XbyfOZsK9fgPzs5HRHw2xcZgaawEtF7L4ZR8B3SJVa8lsGI+31/PXwFi3J
 NonOIkd0tTkPwuvlFViXxrc4tSprrGTlCkdyyeXbpMygmVadOHwPErasOM1mqoKEKhnuC2xCa
 nFgyUtpl+xykv7wVUHQtLsSoXvPPxr117x5o4C8Y7vLKg16KL449A6oltO96LCXA+Tn4tyVb4
 HnbLvaoCKqczgqpNsESnvgmxlRtKxs+cNoiNa8P9BBGyMUiQ+/NcueW9Le+I/mZnfXGFVkCG6
 f+UdP+pTBjJ1AGTOk4440rUckiHBOxiYKvVtxgueavSb5FR3Ek2CZ3icRz9K7oJFt+wWqJXVO
 Xb1s90wvpXOzW+KP2OMT76bprgcRtAdFtg94lWCpJ12bO8DhST6cuFYBW0W1Ogd5yzGMkMWyl
 /WjrbYnHvt09PddB2XQiy7hob7gxE/OorvEXZD0qSGgj7obshw4YmKj+w==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/6/21 =E4=B8=8B=E5=8D=881:06, syzbot wrote:
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    6b00bc63 Merge tag 'dmaengine-fix-5.13' of git://git.ker=
ne..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=3D1591a33fd000=
00
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3D7ca96a2d153c=
74b0
> dashboard link: https://syzkaller.appspot.com/bug?extid=3D38cd5310bb0818=
ffc964
> userspace arch: i386
>
> Unfortunately, I don't have any reproducer for this issue yet.
>
> IMPORTANT: if you fix the issue, please add the following tag to the com=
mit:
> Reported-by: syzbot+38cd5310bb0818ffc964@syzkaller.appspotmail.com
>
> general protection fault, probably for non-canonical address 0xdffffc000=
000002a: 0000 [#1] PREEMPT SMP KASAN
> KASAN: null-ptr-deref in range [0x0000000000000150-0x0000000000000157]
> CPU: 1 PID: 10005 Comm: syz-fuzzer Not tainted 5.13.0-rc6-syzkaller #0
> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.14.0-2 04/01/=
2014
> RIP: 0010:__lock_acquire+0xcf0/0x5230 kernel/locking/lockdep.c:4772
> Code: 3d 0e 41 bf 01 00 00 00 0f 86 8c 00 00 00 89 05 06 49 3d 0e e9 81 =
00 00 00 48 b8 00 00 00 00 00 fc ff df 4c 89 f2 48 c1 ea 03 <80> 3c 02 00 =
0f 85 82 2f 00 00 49 81 3e c0 b3 42 8f 0f 84 da f3 ff
> RSP: 0000:ffffc9000d27e9e0 EFLAGS: 00010002
> RAX: dffffc0000000000 RBX: 0000000000000000 RCX: 0000000000000000
> RDX: 000000000000002a RSI: 0000000000000001 RDI: 0000000000000001
> RBP: 0000000000000000 R08: 0000000000000001 R09: 0000000000000000
> R10: fffffbfff1b92d2a R11: 0000000000000000 R12: ffff888017401c40
> R13: 0000000000000000 R14: 0000000000000150 R15: 0000000000000000
> FS:  000000c013afc090(0000) GS:ffff88802cb00000(0000) knlGS:000000000000=
0000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00000000009a67f0 CR3: 000000001b446000 CR4: 0000000000150ee0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>   lock_acquire kernel/locking/lockdep.c:5512 [inline]
>   lock_acquire+0x1ab/0x740 kernel/locking/lockdep.c:5477
>   __raw_spin_lock include/linux/spinlock_api_smp.h:142 [inline]
>   _raw_spin_lock+0x2a/0x40 kernel/locking/spinlock.c:151
>   spin_lock include/linux/spinlock.h:354 [inline]
>   detach_extent_buffer_page+0x402/0xd20 fs/btrfs/extent_io.c:5446

This is the spin_lock() call for the if (mapped) branch.

It means, we got an extent buffer which has EXTENT_BUFFER_UNMAPPED bit
set, but its page->mapping is no long reliable.

I guess some racy for extent buffer page detaching is happening?

 From the code diff, the timing when we check EXTENT_BUFFER_UNMAPPED is
changed.

Previously it's checked out of the loop, but now we check it inside the
loop.
But it doesn't look possible as EXTENT_BUFFER_UNMAPPED is determined at
extent buffer alloc time.

Thus it's super weird.

Have you guys hit similar crash?

Thanks,
Qu

>   btrfs_release_extent_buffer_pages+0xf1/0x320 fs/btrfs/extent_io.c:5515
>   release_extent_buffer+0x242/0x2b0 fs/btrfs/extent_io.c:5985
>   try_release_extent_buffer+0x706/0x900 fs/btrfs/extent_io.c:7032
>   btree_releasepage+0x1fe/0x310 fs/btrfs/disk-io.c:1023
>   try_to_release_page+0x27b/0x3e0 mm/filemap.c:3856
>   shrink_page_list+0x3cb6/0x6060 mm/vmscan.c:1599
>   shrink_inactive_list+0x347/0xca0 mm/vmscan.c:2145
>   shrink_list mm/vmscan.c:2367 [inline]
>   shrink_lruvec+0x7f9/0x14f0 mm/vmscan.c:2662
>   shrink_node_memcgs mm/vmscan.c:2850 [inline]
>   shrink_node+0x868/0x1de0 mm/vmscan.c:2967
>   shrink_zones mm/vmscan.c:3170 [inline]
>   do_try_to_free_pages+0x388/0x14b0 mm/vmscan.c:3225
>   try_to_free_pages+0x29f/0x750 mm/vmscan.c:3464
>   __perform_reclaim mm/page_alloc.c:4430 [inline]
>   __alloc_pages_direct_reclaim mm/page_alloc.c:4451 [inline]
>   __alloc_pages_slowpath.constprop.0+0x84e/0x2140 mm/page_alloc.c:4855
>   __alloc_pages+0x422/0x500 mm/page_alloc.c:5213
>   alloc_pages+0x18c/0x2a0 mm/mempolicy.c:2272
>   __page_cache_alloc mm/filemap.c:1005 [inline]
>   __page_cache_alloc+0x303/0x3a0 mm/filemap.c:990
>   pagecache_get_page+0x38f/0x18d0 mm/filemap.c:1885
>   filemap_fault+0x166c/0x25b0 mm/filemap.c:2992
>   ext4_filemap_fault+0x87/0xc0 fs/ext4/inode.c:6194
>   __do_fault+0x10d/0x4d0 mm/memory.c:3680
>   do_read_fault mm/memory.c:3984 [inline]
>   do_fault mm/memory.c:4112 [inline]
>   handle_pte_fault mm/memory.c:4371 [inline]
>   __handle_mm_fault+0x2c5f/0x52c0 mm/memory.c:4506
>   handle_mm_fault+0x1bc/0x7e0 mm/memory.c:4604
>   do_user_addr_fault+0x483/0x1210 arch/x86/mm/fault.c:1390
>   handle_page_fault arch/x86/mm/fault.c:1475 [inline]
>   exc_page_fault+0x9e/0x180 arch/x86/mm/fault.c:1531
>   asm_exc_page_fault+0x1e/0x30 arch/x86/include/asm/idtentry.h:577
> RIP: 0033:0x455709
> Code: 24 40 8b 44 24 60 85 c0 7d 1b c7 44 24 70 ff ff ff ff 48 c7 44 24 =
78 00 00 00 00 48 8b 6c 24 40 48 83 c4 48 c3 48 8b 4c 24 50 <39> 41 20 7e =
db 48 8d 51 27 48 63 c0 48 8d 04 82 48 8d 40 01 8b 00
> RSP: 002b:000000c00d74b848 EFLAGS: 00010246
> RAX: 0000000000000000 RBX: 000000000099b3a0 RCX: 0000000000a03f30
> RDX: 0000000000495e89 RSI: 0000000000495e89 RDI: 0000000000495f60
> RBP: 000000c00d74b888 R08: 00000000000005fe R09: 000000c00038a600
> R10: 0000000000000001 R11: 0000000000000001 R12: 0000000000005608
> R13: 0000000000000200 R14: 000000000094b641 R15: 0000000000000000
> Modules linked in:
> ---[ end trace c2509809fbde7be8 ]---
> RIP: 0010:__lock_acquire+0xcf0/0x5230 kernel/locking/lockdep.c:4772
> Code: 3d 0e 41 bf 01 00 00 00 0f 86 8c 00 00 00 89 05 06 49 3d 0e e9 81 =
00 00 00 48 b8 00 00 00 00 00 fc ff df 4c 89 f2 48 c1 ea 03 <80> 3c 02 00 =
0f 85 82 2f 00 00 49 81 3e c0 b3 42 8f 0f 84 da f3 ff
> RSP: 0000:ffffc9000d27e9e0 EFLAGS: 00010002
> RAX: dffffc0000000000 RBX: 0000000000000000 RCX: 0000000000000000
> RDX: 000000000000002a RSI: 0000000000000001 RDI: 0000000000000001
> RBP: 0000000000000000 R08: 0000000000000001 R09: 0000000000000000
> R10: fffffbfff1b92d2a R11: 0000000000000000 R12: ffff888017401c40
> R13: 0000000000000000 R14: 0000000000000150 R15: 0000000000000000
> FS:  000000c013afc090(0000) GS:ffff88802cb00000(0000) knlGS:000000000000=
0000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00000000009a67f0 CR3: 000000001b446000 CR4: 0000000000150ee0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>
>
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
>
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
>
