Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FFF140BF5C
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Sep 2021 07:34:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235806AbhIOFfR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 15 Sep 2021 01:35:17 -0400
Received: from mout.gmx.net ([212.227.15.19]:49127 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230304AbhIOFfR (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 15 Sep 2021 01:35:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1631684031;
        bh=WO8ktNjvPlDwOS807Fk+zCa8AUoQlNru5MtaSEoQgpg=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=AohD4FHNsPDyTSdKt23lwVF/Jp0UPbbE9JPJe68bXtkdzuwEEtx05o3jJ1cND0r2W
         bWEb/XCTAFzRm9UR3k5V6czCtSfpToLhvS/fD2pinANtl0EsBAU4AAs7jRWhn6wrle
         PkOTpvQqMY18s5PotJ7PGMEbrJ3WpZOBC9/rDMQk=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1Md6Mj-1mziN20TT9-00aFsv; Wed, 15
 Sep 2021 07:33:51 +0200
Subject: Re: kernel BUG in __clear_extent_bit
To:     Hao Sun <sunhao.th@gmail.com>, clm@fb.com, dsterba@suse.com,
        Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
References: <CACkBjsYjkubyQBvBy7aaQStk_i1UuCu7oPNYXhZhvhWvBCM3ag@mail.gmail.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <145029f0-5bc5-73fd-14ee-75b5829a3334@gmx.com>
Date:   Wed, 15 Sep 2021 13:33:47 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <CACkBjsYjkubyQBvBy7aaQStk_i1UuCu7oPNYXhZhvhWvBCM3ag@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:CUyibiy6EID5SmYXGfEXAESuRqQ2iVtShGZ5BGFrnO9a1rnrbeL
 C8KftzNuFvgt2nD34cSmp5p97RF0reQ0FkesG9oahHL2XAl03RMiXBPDAq/Ur3oWMygXiMb
 H8gofS1Ta34G1o2sAFJCq05fJiUm0eu578ewgq2Hcw4qqUrA/UErRfSzDMo1o1tFxIgz0eU
 P0+K6rFDTF1Iu1NvREYeA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:YGyfwt5POXw=:A9kRJ1v1pgb/6pmsYImxnP
 E+QcmFHQCPpOQm4L1pUrgbxinOdY8tNq6fBvEsycbm3RJTWeKAj7NBaDzKADmgRynyhApGqkx
 trN3zRF31tWX+PlbIujB3NXYGHmMJlUTnGU/9r+NfQcGDKFzwn+xJCl9YEHiWVnFfpIQ3XdmC
 K5rIBuK2l6GqsVkJcuTqsGWC8duPizrAqILN1v3i1d+aylk6QtjIKjuDNVq28+4GJJFFl+FEt
 yDQVU9HzQ3hmBOlfmEy4ObSbBLvwdyhVfHIUVawDT01CIeNqhCuAEeN311d0uYFNo1FLMR8IM
 YY2Z8yrnMNtGloWsgP0yTz4fEUUl223+rFXJw9PCdWZA0H0BV6gjcro9kqJ3Sta2KPXy3/hyW
 gpUHa9WKHYB6DIK2CW6RWTRiH/xTEzMmydWapQkLv/9hZzeUAa+mQPJTr1p8hrp+M7PfVkHdL
 hud6IDt8DoGfvI6QLj/tWh7W74Ph1RkxtuVUMfFn+OK3RUkVhIWilMVZNJ8xSUupVnHqi4eug
 Z9y5B7TGfH5Tq8S2udeLms9vSczPokdNRAFRz0dOcQ1SKHmTTkbU2PSRXfc7eSHI9QO1CsC3c
 zaSNoklIE9YdV7nkboFi+CDjP6EugidCjJhAJopyzecv8j5FmQTW6MXqci4fLmHuv7C7OUrKc
 GkujHnNAxXqKXFekyk+4vVTI7We5nz7/lCJWajQ9tN9B/7WfWM/RimqDEJXTVxK33DdaBgHe7
 jb5ENnCwXnPW2peqUFGXqTvsRH+VvW1e6dPuVtxzJmy29uENjAKE1GxUkGDzPy5I+6mHHfyhJ
 /jk4Uz5hAS9SWwwN+eLaoGqO9UUoNe/a3+HLe6E65NZ+cUgwM6MR95ZVdkT1nRHY6pZutQHWU
 C+u43RzOtnVRSLJEhvblWFAGOzABNU14JMIGtEIvEZUN4r/xRiVyAzM/7uDoiO0GjPlZayF8i
 RW9naXLcIvFdodMqsgT3yy6w9flk9wjJXy7fj70S0LvCFfDJRedHx38fFhGalL4BNqZoZFT0I
 fz35wQK9N8JGKkaSA4zWA04D0TLYhmqntFBzWxCv7ymeWsDXGbqTXQAxaUsRXQ/lhRx2VTUEc
 Ju33DzNWfXj7Ha73pqQh3N3RfuQk8Wo3/GhXDsZRQ01yv2omBt0XPMAi8cbbwXXh6ABjs2rW5
 Js6tQtIIfsaY27kqahepTwliXH
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/9/15 =E4=B8=8A=E5=8D=8810:20, Hao Sun wrote:
> Hello,
>
> When using Healer to fuzz the latest Linux kernel, the following crash
> was triggered.
>
> HEAD commit: 6880fa6c5660 Linux 5.15-rc1
> git tree: upstream
> console output:
> https://drive.google.com/file/d/1-9wwV6-OmBcJvHGCbMbP5_uCVvrUdTp3/view?u=
sp=3Dsharing
> kernel config: https://drive.google.com/file/d/1rUzyMbe5vcs6khA3tL9EHTLJ=
vsUdWcgB/view?usp=3Dsharing
> C reproducer: https://drive.google.com/file/d/1eXePTqMQ5ZA0TWtgpTX50Ez4q=
9ZKm_HE/view?usp=3Dsharing
> Syzlang reproducer:
> https://drive.google.com/file/d/11s13louoKZ7Uz0mdywM2jmE9B1JEIt8U/view?u=
sp=3Dsharing
>
> If you fix this issue, please add the following tag to the commit:
> Reported-by: Hao Sun <sunhao.th@gmail.com>
>
> loop1: detected capacity change from 0 to 32768
> BTRFS info (device loop1): disk space caching is enabled
> BTRFS info (device loop1): has skinny extents
> BTRFS info (device loop1): enabling ssd optimizations
> FAULT_INJECTION: forcing a failure.
> name failslab, interval 1, probability 0, space 0, times 0
> CPU: 1 PID: 25852 Comm: syz-executor Not tainted 5.15.0-rc1 #16
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
> rel-1.12.0-59-gc9ba5276e321-prebuilt.qemu.org 04/01/2014
> Call Trace:
>   __dump_stack lib/dump_stack.c:88 [inline]
>   dump_stack_lvl+0x8d/0xcf lib/dump_stack.c:106
>   fail_dump lib/fault-inject.c:52 [inline]
>   should_fail+0x13c/0x160 lib/fault-inject.c:146
>   should_failslab+0x5/0x10 mm/slab_common.c:1328
>   slab_pre_alloc_hook.constprop.99+0x4e/0xc0 mm/slab.h:494
>   slab_alloc_node mm/slub.c:3120 [inline]
>   slab_alloc mm/slub.c:3214 [inline]
>   kmem_cache_alloc+0x44/0x280 mm/slub.c:3219
>   alloc_extent_state+0x1e/0x1c0 fs/btrfs/extent_io.c:340

This is the one of the core systems btrfs uses, and we really don't want
that to fail.

Thus in fact it does some preallocation to prevent failure.

But for error injection case, we can still hit BUG_ON() which is used to
catch ENOMEM.

Thanks,
Qu

>   alloc_extent_state_atomic include/linux/spinlock.h:403 [inline]
>   __clear_extent_bit+0x646/0x6b0 fs/btrfs/extent_io.c:820
>   try_release_extent_state fs/btrfs/extent_io.c:5218 [inline]
>   try_release_extent_mapping+0x296/0x320 fs/btrfs/extent_io.c:5315
>   __btrfs_releasepage fs/btrfs/inode.c:8493 [inline]
>   btrfs_releasepage+0xcf/0x1a0 fs/btrfs/inode.c:8506
>   try_to_release_page+0xe7/0x1c0 mm/filemap.c:3964
>   invalidate_complete_page mm/truncate.c:203 [inline]
>   invalidate_inode_page+0x10e/0x1d0 mm/truncate.c:255
>   __invalidate_mapping_pages+0x104/0x310 mm/truncate.c:494
>   btrfs_direct_write fs/btrfs/file.c:1997 [inline]
>   btrfs_file_write_iter+0x398/0x510 fs/btrfs/file.c:2027
>   call_write_iter include/linux/fs.h:2163 [inline]
>   aio_write+0x165/0x360 fs/aio.c:1578
>   __io_submit_one fs/aio.c:1833 [inline]
>   io_submit_one+0x9dd/0x1490 fs/aio.c:1880
>   __do_sys_io_submit fs/aio.c:1939 [inline]
>   __se_sys_io_submit fs/aio.c:1909 [inline]
>   __x64_sys_io_submit+0xba/0x310 fs/aio.c:1909
>   do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>   do_syscall_64+0x34/0xb0 arch/x86/entry/common.c:80
>   entry_SYSCALL_64_after_hwframe+0x44/0xae
> RIP: 0033:0x46ae99
> Code: f7 d8 64 89 02 b8 ff ff ff ff c3 66 0f 1f 44 00 00 48 89 f8 48
> 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d
> 01 f0 ff ff 73 01 c3 48 c7 c1 bc ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007ff0725c5c48 EFLAGS: 00000246 ORIG_RAX: 00000000000000d1
> RAX: ffffffffffffffda RBX: 000000000078c0a0 RCX: 000000000046ae99
> RDX: 0000000020005880 RSI: 0000000000000001 RDI: 00007ff07259d000
> RBP: 00007ff0725c5c80 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000032
> R13: 0000000000000000 R14: 000000000078c0a0 R15: 00007ffd0c8ba9c0
> ------------[ cut here ]------------
> kernel BUG at fs/btrfs/extent_io.c:821!
> invalid opcode: 0000 [#1] PREEMPT SMP
> CPU: 1 PID: 25852 Comm: syz-executor Not tainted 5.15.0-rc1 #16
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
> rel-1.12.0-59-gc9ba5276e321-prebuilt.qemu.org 04/01/2014
> RIP: 0010:__clear_extent_bit+0x653/0x6b0 fs/btrfs/extent_io.c:821
> Code: 13 f5 ff ff 48 8b 7c 24 18 e8 d9 19 37 02 e9 ef fd ff ff e8 4f
> d0 48 ff e8 6a df ff ff 48 85 c0 49 89 c6 75 99 e8 3d d0 48 ff <0f> 0b
> e8 36 d0 48 ff 0f 0b e9 6f fe ff ff e8 2a d0 48 ff 48 8d 7b
> RSP: 0018:ffffc9000d7a3968 EFLAGS: 00010212
> RAX: 000000000002763c RBX: ffff88810f074000 RCX: ffffc90000b45000
> RDX: 0000000000040000 RSI: ffffffff81eec1c3 RDI: ffffffff853cbec6
> RBP: 0000000000000000 R08: 0000000000000088 R09: 0000000000000001
> R10: ffffc9000d7a3838 R11: 0000000000000001 R12: 000000000000ffff
> R13: 0000000000000fff R14: 0000000000000000 R15: ffff88810cd96788
> FS:  00007ff0725c6700(0000) GS:ffff88813dc00000(0000) knlGS:000000000000=
0000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007ff07259d000 CR3: 000000001c337000 CR4: 0000000000750ee0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> PKRU: 55555554
> Call Trace:
>   try_release_extent_state fs/btrfs/extent_io.c:5218 [inline]
>   try_release_extent_mapping+0x296/0x320 fs/btrfs/extent_io.c:5315
>   __btrfs_releasepage fs/btrfs/inode.c:8493 [inline]
>   btrfs_releasepage+0xcf/0x1a0 fs/btrfs/inode.c:8506
>   try_to_release_page+0xe7/0x1c0 mm/filemap.c:3964
>   invalidate_complete_page mm/truncate.c:203 [inline]
>   invalidate_inode_page+0x10e/0x1d0 mm/truncate.c:255
>   __invalidate_mapping_pages+0x104/0x310 mm/truncate.c:494
>   btrfs_direct_write fs/btrfs/file.c:1997 [inline]
>   btrfs_file_write_iter+0x398/0x510 fs/btrfs/file.c:2027
>   call_write_iter include/linux/fs.h:2163 [inline]
>   aio_write+0x165/0x360 fs/aio.c:1578
>   __io_submit_one fs/aio.c:1833 [inline]
>   io_submit_one+0x9dd/0x1490 fs/aio.c:1880
>   __do_sys_io_submit fs/aio.c:1939 [inline]
>   __se_sys_io_submit fs/aio.c:1909 [inline]
>   __x64_sys_io_submit+0xba/0x310 fs/aio.c:1909
>   do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>   do_syscall_64+0x34/0xb0 arch/x86/entry/common.c:80
>   entry_SYSCALL_64_after_hwframe+0x44/0xae
> RIP: 0033:0x46ae99
> Code: f7 d8 64 89 02 b8 ff ff ff ff c3 66 0f 1f 44 00 00 48 89 f8 48
> 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d
> 01 f0 ff ff 73 01 c3 48 c7 c1 bc ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007ff0725c5c48 EFLAGS: 00000246 ORIG_RAX: 00000000000000d1
> RAX: ffffffffffffffda RBX: 000000000078c0a0 RCX: 000000000046ae99
> RDX: 0000000020005880 RSI: 0000000000000001 RDI: 00007ff07259d000
> RBP: 00007ff0725c5c80 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000032
> R13: 0000000000000000 R14: 000000000078c0a0 R15: 00007ffd0c8ba9c0
> Modules linked in:
> Dumping ftrace buffer:
>     (ftrace buffer empty)
> ---[ end trace 3bbc6e927d377de3 ]---
> RIP: 0010:__clear_extent_bit+0x653/0x6b0 fs/btrfs/extent_io.c:821
> Code: 13 f5 ff ff 48 8b 7c 24 18 e8 d9 19 37 02 e9 ef fd ff ff e8 4f
> d0 48 ff e8 6a df ff ff 48 85 c0 49 89 c6 75 99 e8 3d d0 48 ff <0f> 0b
> e8 36 d0 48 ff 0f 0b e9 6f fe ff ff e8 2a d0 48 ff 48 8d 7b
> RSP: 0018:ffffc9000d7a3968 EFLAGS: 00010212
> RAX: 000000000002763c RBX: ffff88810f074000 RCX: ffffc90000b45000
> RDX: 0000000000040000 RSI: ffffffff81eec1c3 RDI: ffffffff853cbec6
> RBP: 0000000000000000 R08: 0000000000000088 R09: 0000000000000001
> R10: ffffc9000d7a3838 R11: 0000000000000001 R12: 000000000000ffff
> R13: 0000000000000fff R14: 0000000000000000 R15: ffff88810cd96788
> FS:  00007ff0725c6700(0000) GS:ffff88813dc00000(0000) knlGS:000000000000=
0000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007ff07259d000 CR3: 000000001c337000 CR4: 0000000000750ee0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> PKRU: 55555554
>
