Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71A3240BDB7
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Sep 2021 04:20:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229747AbhIOCWG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 14 Sep 2021 22:22:06 -0400
Received: from mout.gmx.net ([212.227.15.19]:36357 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229645AbhIOCWF (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 14 Sep 2021 22:22:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1631672441;
        bh=6g6rnXrog0xK7g0GHR9hed1ulwxCAeCCVqohockep0A=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=lW8NQTqKZJMdP1FbWle664PkYTJTl7yZlYYiGXUN5YUv+McH7bH1KC08KAo+eVq0b
         fgrVe3GZSmb6ejwU+I3b6b7ycw330tBdwk3E9kv6bBiNRQXckjyGlKZVEj07SYUeo8
         giYu/AFwCMOTPgiDPNiQsNneutFhqiY0HSPErKQ0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MKKUv-1mCEhL3fup-00LkCs; Wed, 15
 Sep 2021 04:20:41 +0200
Subject: Re: WARNING in btrfs_run_delayed_refs
To:     Hao Sun <sunhao.th@gmail.com>, clm@fb.com, dsterba@suse.com,
        Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
References: <CACkBjsa0wQ5oDQh0CABfV-UoAa9czS6DAuAA0fBrM_HhVxd6+w@mail.gmail.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <a911ac2c-d743-03ea-513d-0b9756808d17@gmx.com>
Date:   Wed, 15 Sep 2021 10:20:36 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <CACkBjsa0wQ5oDQh0CABfV-UoAa9czS6DAuAA0fBrM_HhVxd6+w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:7HWp7s984H56YcN2Sf4efyLPHDPOR+OFL28ctafQB+rGkPtadPe
 Si4TbyAO3DhekcQtpPH00N+FVQ4dWDOmjkEY8SpJwy6XC+Oo9euIdOaqgo4BGB5V/AuHwg+
 YiGlPbsUa6/V7r6HD2fA1vLSJJXDDVupTEYr4YCweCFsoTmNu4+kwIoAHZbF2XSeUsi4Fqu
 lMySMgfgKwXPIQoTwmVow==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:7Vu67TLYEo4=:5kl2Gq+UmfPmwMiqIKAbGT
 P24zG4XzRTDr5EJbXkcY7V16RTDYZrWaPyzUHs0d1oA2bY4UHbea2F08MwFqpYcI30YfSUGCS
 I0ih+D8MbTWHrWYEGoWWIKVT6FnoBgFdcwSkJnHFl+pYY9aOvhzNqmVkQB1RinPLY7AE+2POx
 NjxK4LyBaD6XL2Ej8PeSg4ZmeEvsWimYlpaDLjUGdw3uEuDHYnzpBgl9II7fpzs/Dnjza9mL0
 aoO9R4Y7aKle61BHLL8/F9KPI6Bt4oWCuiDl/1xVHBWBhr3VogeGk0kgcNJMbYXeCe/bjx4zl
 RW3VCwRBeMBpHSw0xUeBUjPfZOKQgKHcAmS1CEz7WVA3u8fXSnQjVNsn/wC7ghBDpcDMVypVo
 8HmzCVkM/drXJnuZ3u3yXqnGw0qPAmJwXKKJmou+pkSOKLPLF76qiBAyYXcZga2drHYpj2mBu
 AdynTULJ9l1MqKcl1JrUH+zcJegSs2jMZrjm2PLkxWL+AylXs4REurVejGBwjuAlP8N/bvMLt
 0QwXuPj1rpcmomex9hm914kLf6vMyWpK9yzGMrsF6Wd1K6rhxC69DISzFS99pGsa0l7Qwo7u5
 lw+S1tnel6Ca8DumpLatvRKblkI8/dNVuqai0fOqu14Yg0oBneegdTHf9srknObgq/8rtSEFk
 vjM41TtMdCwybr+wjcmMEhM2E00P9a2FzUSj1tILNeR3PYiaLrb4RmYIxAISDqyTXzZkmZOC5
 hEvNG3WIbjw1WdbuohexydeufINyXcHc5ja8RGKPq0Kb5jW50XM1IzH4otwhtb9NNHHWFZrsW
 h037832vhW2fnNZIZMvyPrHbjBljh0+VeT5IGaJAfmidewSj/2f+Ax1AI0eOKjGPZ1rCCPpbt
 JH42eX/3ryP9npQ55eEnInpR+2SV9o8oLM8fMVLkXnaCgZw+8mqLOa29e0JpElGz7876UWcZM
 Y8leKcmwDAUN7KSDX3NXph0+szW1y4lp9IZmhR5YqlbV7tGFWxcUMzz3la5NhLkTgGfqX3TNm
 dOwGW2V3jYX+KzT/w5//E6+m8A0u5y7pVBhXUNGGgGyUwHgHyPGG/cMt+OO3S8B/lb2rDfRyw
 jZ+XNUimWl8/VzK28R/YKPiqugu3FuJzy7nY4WxmnaPUsaTrWIkJyEER+pzzMZQdlvpQqQxn5
 KNL5tuSPa4uyaw4dSsencXK01r
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/9/15 =E4=B8=8A=E5=8D=8810:14, Hao Sun wrote:
> Hello,
>
> When using Healer to fuzz the latest Linux kernel, the following crash
> was triggered.
>
> HEAD commit: 6880fa6c5660 Linux 5.15-rc1
> git tree: upstream
> console output:
> https://drive.google.com/file/d/1gd0dl74MyvvVAYqsCDKSGmcfpZszD0kt/view?u=
sp=3Dsharing
> kernel config: https://drive.google.com/file/d/1rUzyMbe5vcs6khA3tL9EHTLJ=
vsUdWcgB/view?usp=3Dsharing
> C reproducer: https://drive.google.com/file/d/1WKQukijOJ7D0NYk1iKf47FESj=
YfAjrlz/view?usp=3Dsharing
> Syzlang reproducer:
> https://drive.google.com/file/d/1Gi9-Mgbrjw1OI-ymO4zDVIFej2Qf4ppL/view?u=
sp=3Dsharing
>
> If you fix this issue, please add the following tag to the commit:
> Reported-by: Hao Sun <sunhao.th@gmail.com>
>
> loop11: detected capacity change from 0 to 32768
> BTRFS info (device loop11): disk space caching is enabled
> BTRFS info (device loop11): has skinny extents
> BTRFS info (device loop11): enabling ssd optimizations
> FAULT_INJECTION: forcing a failure.
> name failslab, interval 1, probability 0, space 0, times 0
> CPU: 0 PID: 7769 Comm: syz-executor Not tainted 5.15.0-rc1 #16
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
>   __btrfs_free_extent.isra.53+0x7b/0x1180 fs/btrfs/extent-tree.c:2942
>   run_delayed_tree_ref fs/btrfs/extent-tree.c:1687 [inline]
>   run_one_delayed_ref fs/btrfs/extent-tree.c:1711 [inline]
>   btrfs_run_delayed_refs_for_head fs/btrfs/extent-tree.c:1952 [inline]
>   __btrfs_run_delayed_refs+0x83e/0x1a00 fs/btrfs/extent-tree.c:2017
>   btrfs_run_delayed_refs+0xb1/0x2b0 fs/btrfs/extent-tree.c:2148
>   btrfs_commit_transaction+0x7d/0x1430 fs/btrfs/transaction.c:2065
>   btrfs_sync_fs+0x9a/0x430 fs/btrfs/super.c:1426
>   btrfs_ioctl+0x209b/0x3be0 fs/btrfs/ioctl.c:4970
>   vfs_ioctl fs/ioctl.c:51 [inline]
>   __do_sys_ioctl fs/ioctl.c:874 [inline]
>   __se_sys_ioctl fs/ioctl.c:860 [inline]
>   __x64_sys_ioctl+0xb6/0x100 fs/ioctl.c:860
>   do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>   do_syscall_64+0x34/0xb0 arch/x86/entry/common.c:80
>   entry_SYSCALL_64_after_hwframe+0x44/0xae
> RIP: 0033:0x46ae99
> Code: f7 d8 64 89 02 b8 ff ff ff ff c3 66 0f 1f 44 00 00 48 89 f8 48
> 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d
> 01 f0 ff ff 73 01 c3 48 c7 c1 bc ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007f8ac08c7c48 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
> RAX: ffffffffffffffda RBX: 000000000078c0a0 RCX: 000000000046ae99
> RDX: 0000000000000000 RSI: 0000000000009408 RDI: 0000000000000003
> RBP: 00007f8ac08c7c80 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000003
> R13: 0000000000000000 R14: 000000000078c0a0 R15: 00007ffccc1d6390
> ------------[ cut here ]------------
> WARNING: CPU: 0 PID: 7769 at fs/btrfs/extent-tree.c:2150
> btrfs_run_delayed_refs+0x245/0x2b0 fs/btrfs/extent-tree.c:2150

This is again btrfs_abort_transaction().

This makes me wonder, should we add ENOMEM to abort transaction warning
condition to make the ENOMEM injection code happy.

Mind to test the following diff?

Thanks,
Qu

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 8c6ee947a68d..6bc79f6716fa 100644
=2D-- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -3548,7 +3548,8 @@ do {
                 \
         /* Report first abort since mount */                    \
         if (!test_and_set_bit(BTRFS_FS_STATE_TRANS_ABORTED,     \
                         &((trans)->fs_info->fs_state))) {       \
-               if ((errno) !=3D -EIO && (errno) !=3D -EROFS) {           =
  \
+               if ((errno) !=3D -EIO && (errno) !=3D -EROFS &&     \
+                   (errno) !=3D -ENOMEM) {                       \
                         WARN(1, KERN_DEBUG                              \
                         "BTRFS: Transaction aborted (error %d)\n",      \
                         (errno));                                       \

> Modules linked in:
> CPU: 0 PID: 7769 Comm: syz-executor Not tainted 5.15.0-rc1 #16
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
> rel-1.12.0-59-gc9ba5276e321-prebuilt.qemu.org 04/01/2014
> RIP: 0010:btrfs_run_delayed_refs+0x245/0x2b0 fs/btrfs/extent-tree.c:2150
> Code: 72 2d e8 ce a4 4d ff 8b 04 24 83 f8 fb 74 49 83 f8 e2 74 44 e8
> bc a4 4d ff 8b 04 24 48 c7 c7 38 25 39 85 89 c6 e8 db ab 38 ff <0f> 0b
> 8b 04 24 89 04 24 e8 9e a4 4d ff 8b 04 24 ba 66 08 00 00 4c
> RSP: 0018:ffffc9000509bcc8 EFLAGS: 00010286
> RAX: 0000000000000000 RBX: ffff888014054000 RCX: ffffc9000cb3c000
> RDX: 0000000000040000 RSI: ffffffff812d18bc RDI: 00000000ffffffff
> RBP: ffff888014054000 R08: 0000000000000000 R09: 0000000000000001
> R10: 0000000000000000 R11: 0000000000000000 R12: ffff88801f13e800
> R13: ffff8880091b2000 R14: ffff88801f13e800 R15: 0000000000000000
> FS:  00007f8ac08c8700(0000) GS:ffff88813dc00000(0000) knlGS:000000000000=
0000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007fc39085b000 CR3: 000000010e194000 CR4: 0000000000750ee0
> DR0: 0000000000003000 DR1: 0000000000001000 DR2: 0000000000010000
> DR3: 000000000000d000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> PKRU: 55555554
> Call Trace:
>   btrfs_commit_transaction+0x7d/0x1430 fs/btrfs/transaction.c:2065
>   btrfs_sync_fs+0x9a/0x430 fs/btrfs/super.c:1426
>   btrfs_ioctl+0x209b/0x3be0 fs/btrfs/ioctl.c:4970
>   vfs_ioctl fs/ioctl.c:51 [inline]
>   __do_sys_ioctl fs/ioctl.c:874 [inline]
>   __se_sys_ioctl fs/ioctl.c:860 [inline]
>   __x64_sys_ioctl+0xb6/0x100 fs/ioctl.c:860
>   do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>   do_syscall_64+0x34/0xb0 arch/x86/entry/common.c:80
>   entry_SYSCALL_64_after_hwframe+0x44/0xae
> RIP: 0033:0x46ae99
> Code: f7 d8 64 89 02 b8 ff ff ff ff c3 66 0f 1f 44 00 00 48 89 f8 48
> 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d
> 01 f0 ff ff 73 01 c3 48 c7 c1 bc ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007f8ac08c7c48 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
> RAX: ffffffffffffffda RBX: 000000000078c0a0 RCX: 000000000046ae99
> RDX: 0000000000000000 RSI: 0000000000009408 RDI: 0000000000000003
> RBP: 00007f8ac08c7c80 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000003
> R13: 0000000000000000 R14: 000000000078c0a0 R15: 00007ffccc1d6390
>
