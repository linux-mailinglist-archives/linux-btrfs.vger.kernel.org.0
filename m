Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 834A740A5B5
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 Sep 2021 07:06:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239281AbhINFHq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 14 Sep 2021 01:07:46 -0400
Received: from mout.gmx.net ([212.227.15.18]:60167 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232829AbhINFHp (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 14 Sep 2021 01:07:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1631595981;
        bh=Z+vmMnqEbbjO1kaOM2G+sc0ONOdE6bPgYVsOqAEsmMg=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=MopUhP6LbS1JEcnko77ozBff/KkjdEQYRRzaoG7KxhefBei5s1Y+Jyh3ilKWdvVst
         jvH5DjueG4medkw1ulgLs+pVGdo3/B7siyav1P21T9/XNOieW1jwHqVSOAD3G2FnyL
         vjy4BsbT4FI9p6iaKoZ3GUxS7rT74Ohlyi/Wv/0w=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1N5VHM-1mxjte1dUY-016vI3; Tue, 14
 Sep 2021 07:06:21 +0200
Subject: Re: kernel BUG in btrfs_free_tree_block
To:     Hao Sun <sunhao.th@gmail.com>, clm@fb.com, dsterba@suse.com,
        josef@toxicpanda.com, linux-btrfs@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
References: <CACkBjsbyFhwDgK0oBuu3P9Z0EqSpsb==9K_S+dxNwBj=qU_n=g@mail.gmail.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <60259e9c-6126-b963-e475-cbc435501738@gmx.com>
Date:   Tue, 14 Sep 2021 13:06:16 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <CACkBjsbyFhwDgK0oBuu3P9Z0EqSpsb==9K_S+dxNwBj=qU_n=g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:6FDbhcfkgnQ3MWNj/onVRD5el39WPpIxXHiCTcdUcvfZ3l1muOk
 SU4NjiojfwL4tpEFqyFAqwHJUFjPhnd13NPSTCsfU9tL3WIYWqO3uizCyUAyASwItnvk3tS
 Ji+9hQtIviTlOWueVpZN7RMc6y893ccFVGndGX6S35oP1vgNYlyX57gie7p6fOiItYNn739
 lPeopaCQLrPAfzUfWA6pQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:D+IGTOS/pi8=:sqEcskEZfFm9AkykKDK2iQ
 oGKANBoekrcX9tQu4nogTnWivgFkMaZVFbA268Fm1Rzj0P9hJbe1Hxj/1k3MTiIHtvRzoZmpM
 1hyfrp++zEIVO56Dkr9f/Qav2TJ3xviMAlQzAlXVm2McsxOrz1n44bKYgRri93kmpv+9jPOLO
 9/QB846o6zFw4gcwPOQm3dWPqtcTiajcmNvfNJX67M1nCtVp/MqD+W2f/agUs04mUmTdINoW1
 Ou7rY5oeRm1z0fCpNGHqjQobhOfhF1TcQ9FpgY7CHl6ucVcsNLlL4sfQUCuSOqSjUMr6me0aS
 6wXNGVoU7Jq5vgZfek4/XK7haalgjNLO4Rbf1iDVFzUNnymJjg5n21w1Cx3Qvdls0Ph2KWK4y
 XTsUzbfPDYM4S0XZYkDioEN8/VMcHWz+VmlsqDYVaRi6MOIj2rzHj8STS8NoKy0U6fvwwlnXf
 h8KcuFCTx4lW0cSFng/nT67Gl3FyY8B4+0iWJZylAJSSDAZ1HKlV6/Gz5NcsTSnO0GsPhHKA7
 49dIqojnggdrkxhcERsfxnH0+0zOYW5nTMN4e4LOOpSzWC/fGLxHErajxB+jHiPMIbFEnmHvK
 BhQdFXCI6xW7UhkL+/1PTpHDHz2TBM5Fl4cTAGqvS01tUamBd9AkzTUZyg5xkBMUTLL5WnWM9
 vr9JJy2DC62YFVk1XeQTuoloTipDE/7IrSQx2n06BInOJsrGve9Cq70mZcqhzuSFg15dpyIGp
 L+Fw33diQr+92cSJFxuuRDLKyJFE4mnZxbkyKYZe/U4dNbb9kRtqfPXN5qcTMXqtZ4mC1xczq
 iSN9DKCvx1nv/QLwk55P+to1ZSy6Jv9xf8+NwDaKJmaLWD5FbaDfDZ21ITVu5AZoetlx5ii8m
 lZgM2jQmioTigvCk98ONeKEgp6s1bfY1O997xO58RLqb2EG3/mR+3T5WuDbysh4zWl51cHdAG
 Iyju0NG7puBod4x4hY7avhoqTR2u81EJtCMv49GgAwjB1VIBJ7s7GmpC39t56hhifZLmUMn56
 M54NZbqOUrCeMmKMKyIv2F5vZIGtWLEuZOEXO+sE9294EJD45VcORHIVd30z2EivL13egzSC1
 j61Mo09jmMOxOCi0OG3ozfRgd1aGRJMmy3M3zX/nwDytfd4Fe1Fv5vUo1ef45Xl3AGQAfgB0d
 WgXA16xFFwjLhOhE3q5CnUHiEp
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/9/14 =E4=B8=8A=E5=8D=8810:07, Hao Sun wrote:
> Hello,
>
> When using Healer to fuzz the latest Linux kernel, the following crash
> was triggered.
>
> HEAD commit: 6880fa6c5660 Linux 5.15-rc1
> git tree: upstream
> console output:
> https://drive.google.com/file/d/1Dj7_zR7EzzSb0ba9M7QS43O3jrWBdaGW/view?u=
sp=3Dsharing
> kernel config: https://drive.google.com/file/d/1rUzyMbe5vcs6khA3tL9EHTLJ=
vsUdWcgB/view?usp=3Dsharing
> C reproducer: https://drive.google.com/file/d/19Of7kky0AvoVCnDh45TfsFDgQ=
_HBZW67/view?usp=3Dsharing
> Syzlang reproducer:
> https://drive.google.com/file/d/10Ltk6J-pt41zI95k8B5gI-sZBZjI4Wyh/view?u=
sp=3Dsharing
>
> If you fix this issue, please add the following tag to the commit:
> Reported-by: Hao Sun <sunhao.th@gmail.com>
>
> loop13: detected capacity change from 0 to 32768
> BTRFS: device fsid 88a22be4-8cb5-4ed2-8c2d-1957ce391952 devid 1
> transid 7 /dev/loop13 scanned by syz-executor (7196)
> BTRFS info (device loop13): disk space caching is enabled
> BTRFS info (device loop13): has skinny extents
> BTRFS info (device loop13): enabling ssd optimizations
> FAULT_INJECTION: forcing a failure.
> name failslab, interval 1, probability 0, space 0, times 1
> CPU: 3 PID: 7196 Comm: syz-executor Not tainted 5.15.0-rc1 #16
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
>   btrfs_add_delayed_tree_ref+0xa1/0x580 fs/btrfs/delayed-ref.c:913
>   btrfs_free_tree_block+0x14c/0x440 fs/btrfs/extent-tree.c:3296

This is a direct BUG_ON() handling -ENOMEM.

For this particular case, it looks like aborting transaction is the only
solution, or we will need to change tons of code to accept an error
return value.


And a quick grep would show at least 21 such errors. ("BUG_ON.*ENOMEM")

Maybe it's time for us to start a new round of BUG_ON() hunt.

Thanks,
Qu

>   __btrfs_cow_block+0x5f6/0x7d0 fs/btrfs/ctree.c:465
>   btrfs_cow_block+0x12a/0x300 fs/btrfs/ctree.c:570
>   btrfs_search_slot+0x6b0/0xee0 fs/btrfs/ctree.c:1768
>   btrfs_insert_empty_items+0x80/0xf0 fs/btrfs/ctree.c:3905
>   btrfs_new_inode+0x311/0xa60 fs/btrfs/inode.c:6530
>   btrfs_create+0x12b/0x270 fs/btrfs/inode.c:6783
>   lookup_open+0x660/0x780 fs/namei.c:3282
>   open_last_lookups fs/namei.c:3352 [inline]
>   path_openat+0x465/0xe20 fs/namei.c:3557
>   do_filp_open+0xe3/0x170 fs/namei.c:3588
>   do_sys_openat2+0x357/0x4a0 fs/open.c:1200
>   do_sys_open+0x87/0xd0 fs/open.c:1216
>   do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>   do_syscall_64+0x34/0xb0 arch/x86/entry/common.c:80
>   entry_SYSCALL_64_after_hwframe+0x44/0xae
> RIP: 0033:0x46ae99
> Code: f7 d8 64 89 02 b8 ff ff ff ff c3 66 0f 1f 44 00 00 48 89 f8 48
> 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d
> 01 f0 ff ff 73 01 c3 48 c7 c1 bc ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007f0ffa345c48 EFLAGS: 00000246 ORIG_RAX: 0000000000000055
> RAX: ffffffffffffffda RBX: 000000000078c0a0 RCX: 000000000046ae99
> RDX: 0000000000000000 RSI: 00000000000000a1 RDI: 0000000020005800
> RBP: 00007f0ffa345c80 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 000000000000001d
> R13: 0000000000000000 R14: 000000000078c0a0 R15: 00007ffd3f5c1ed0
> ------------[ cut here ]------------
> kernel BUG at fs/btrfs/extent-tree.c:3297!
> invalid opcode: 0000 [#1] PREEMPT SMP
> CPU: 3 PID: 7196 Comm: syz-executor Not tainted 5.15.0-rc1 #16
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
> rel-1.12.0-59-gc9ba5276e321-prebuilt.qemu.org 04/01/2014
> RIP: 0010:btrfs_free_tree_block+0x159/0x440 fs/btrfs/extent-tree.c:3297
> Code: 5b 5d 41 5c 41 5d 41 5e 41 5f c3 e8 81 9d 4d ff 31 d2 4c 89 e7
> 48 89 e6 e8 e4 96 09 00 85 c0 0f 84 68 ff ff ff e8 67 9d 4d ff <0f> 0b
> e8 60 9d 4d ff 48 83 bd df 01 00 00 fa 74 27 e8 51 9d 4d ff
> RSP: 0018:ffffc9000528f7c8 EFLAGS: 00010246
> RAX: 0000000000040000 RBX: ffff888104ba4d80 RCX: ffffc9000125d000
> RDX: 0000000000040000 RSI: ffffffff81e9f499 RDI: ffffffff853cbec6
> RBP: ffff888103c67000 R08: 0000000000000068 R09: 0000000000000001
> R10: ffffc9000528f638 R11: 0000000000000005 R12: ffff888106374000
> R13: 0000000000000001 R14: ffff88810965c000 R15: 0000000000000000
> FS:  00007f0ffa346700(0000) GS:ffff88813dd00000(0000) knlGS:000000000000=
0000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000000000788000 CR3: 000000001aa9c000 CR4: 0000000000750ee0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> PKRU: 55555554
> Call Trace:
>   __btrfs_cow_block+0x5f6/0x7d0 fs/btrfs/ctree.c:465
>   btrfs_cow_block+0x12a/0x300 fs/btrfs/ctree.c:570
>   btrfs_search_slot+0x6b0/0xee0 fs/btrfs/ctree.c:1768
>   btrfs_insert_empty_items+0x80/0xf0 fs/btrfs/ctree.c:3905
>   btrfs_new_inode+0x311/0xa60 fs/btrfs/inode.c:6530
>   btrfs_create+0x12b/0x270 fs/btrfs/inode.c:6783
>   lookup_open+0x660/0x780 fs/namei.c:3282
>   open_last_lookups fs/namei.c:3352 [inline]
>   path_openat+0x465/0xe20 fs/namei.c:3557
>   do_filp_open+0xe3/0x170 fs/namei.c:3588
>   do_sys_openat2+0x357/0x4a0 fs/open.c:1200
>   do_sys_open+0x87/0xd0 fs/open.c:1216
>   do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>   do_syscall_64+0x34/0xb0 arch/x86/entry/common.c:80
>   entry_SYSCALL_64_after_hwframe+0x44/0xae
> RIP: 0033:0x46ae99
> Code: f7 d8 64 89 02 b8 ff ff ff ff c3 66 0f 1f 44 00 00 48 89 f8 48
> 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d
> 01 f0 ff ff 73 01 c3 48 c7 c1 bc ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007f0ffa345c48 EFLAGS: 00000246 ORIG_RAX: 0000000000000055
> RAX: ffffffffffffffda RBX: 000000000078c0a0 RCX: 000000000046ae99
> RDX: 0000000000000000 RSI: 00000000000000a1 RDI: 0000000020005800
> RBP: 00007f0ffa345c80 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 000000000000001d
> R13: 0000000000000000 R14: 000000000078c0a0 R15: 00007ffd3f5c1ed0
> Modules linked in:
> Dumping ftrace buffer:
>     (ftrace buffer empty)
> ---[ end trace 917bc653bd051886 ]---
> RIP: 0010:btrfs_free_tree_block+0x159/0x440 fs/btrfs/extent-tree.c:3297
> Code: 5b 5d 41 5c 41 5d 41 5e 41 5f c3 e8 81 9d 4d ff 31 d2 4c 89 e7
> 48 89 e6 e8 e4 96 09 00 85 c0 0f 84 68 ff ff ff e8 67 9d 4d ff <0f> 0b
> e8 60 9d 4d ff 48 83 bd df 01 00 00 fa 74 27 e8 51 9d 4d ff
> RSP: 0018:ffffc9000528f7c8 EFLAGS: 00010246
> RAX: 0000000000040000 RBX: ffff888104ba4d80 RCX: ffffc9000125d000
> RDX: 0000000000040000 RSI: ffffffff81e9f499 RDI: ffffffff853cbec6
> RBP: ffff888103c67000 R08: 0000000000000068 R09: 0000000000000001
> R10: ffffc9000528f638 R11: 0000000000000005 R12: ffff888106374000
> R13: 0000000000000001 R14: ffff88810965c000 R15: 0000000000000000
> FS:  00007f0ffa346700(0000) GS:ffff88813dd00000(0000) knlGS:000000000000=
0000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000000000788000 CR3: 000000001aa9c000 CR4: 0000000000750ee0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> PKRU: 55555554
>
