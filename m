Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D413540A426
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 Sep 2021 05:09:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238318AbhINDKX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 13 Sep 2021 23:10:23 -0400
Received: from mout.gmx.net ([212.227.15.19]:58885 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237372AbhINDKX (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 13 Sep 2021 23:10:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1631588938;
        bh=PpI+dROIruJsSS+oTc9h0XopWCPCfVRRN/mbE6iGnKg=;
        h=X-UI-Sender-Class:To:Cc:References:From:Subject:Date:In-Reply-To;
        b=Ab7kA9R/gUNM09TBs/iz3N3cY7RhREUsbapb1S+4Z+Y3p2XnpjLWmT/PE9I/+gDle
         fdjVOE+197ekeoC5X0qY6UniJFe43ToBBDgFTznRUeJvacwYCimW3TFbSOA7LYtlYY
         N+Zr/r+WiCI/b5laklIj4g/6VpzBz/uzVS10IV7g=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MMXQ5-1mANTS14gJ-00JZ5Q; Tue, 14
 Sep 2021 05:08:57 +0200
To:     Hao Sun <sunhao.th@gmail.com>, clm@fb.com, dsterba@suse.com,
        josef@toxicpanda.com, linux-btrfs@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
References: <CACkBjsbA4vLi8JRft7rDCvdksFbfzN-MeDtWcAYPQHJt_jXw2g@mail.gmail.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: WARNING in __btrfs_update_delayed_inode
Message-ID: <cb1ae339-afc8-3e8c-2f6e-32c59a4a6716@gmx.com>
Date:   Tue, 14 Sep 2021 11:08:53 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <CACkBjsbA4vLi8JRft7rDCvdksFbfzN-MeDtWcAYPQHJt_jXw2g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:o70K8vyu9AgUxwocZdXhXcb1N1v1OJyANWQQiX+jAFOe1HW7bo2
 YHkIDD/j8L3hi7TRaGJQ5MfUwjzPRStpj4vukDIfdiM1pzj3VVOjlvb52vL/YlfTWgX+rKm
 Y0ZqFalMG/k8M58wWZQ+pUZa2QEK9Rs9valdtrsXa/7NTmpIwagqq0jHPs7Y2jeiFdA4NjP
 ttCpr6YUMJlRk6LnrEUSw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:5FLvVtSKg8g=:LH+WcdzDjoYA/piUcrLkV7
 rlD0/3PQ5FPazwi2p9vUcdsqXABnXGLsz9uhrREcQ3foYdc72ZDt0ZLsXjqzQLjqHSThWLS+B
 RYlRy1brPxCMjSlTXE+anI1Vx23kSukaK0mGtpiGidZioJr0KAAIzPm+ua0Wp/t0P7zI6s511
 Odyj73xlxNN+7Vq/ITU1s1WgjmHmUL3INy6h1HMelyYmBveY0Uf9wtOzqEeLhIRaoR0cf7BgY
 dTff7k7L+l1M/qUmkaZbfob4zHb/JhrTIM70JeB0zDrT/6DlrxYH28wWWAEW3ibWUWmEFm/QH
 e/AF7dbIn0ou+KSM86A+nmsAUnPU8c+DijRuYN2liHs7koqyJeDBxVIyUVcF7oLX7BRc5Rnra
 sUJPsIsjn8jJMHKzWDxNunRRusJHGm/x9diyP3/6fUZ6mJLM6RyAugIowJF/NkJcwBK8CtT6s
 GnRYKvs6Pjngtd/F9QdQRvuHviGMpMD5QLe+viAohiCsuCEtMgnWIm01yp/QKad9YcUPzRuat
 f8kDfO9SxexzmOYdUxJc5bRHEdkstDo/oqDMGBrtgpGhpt8j8Rt60jvzrI4vQmlxCh7DcecHK
 zilpd3/j0iY9dOqqHL+RksBGKHbefWaGKYEkV7QDcPj11DV5buwcWVql/72Apb4EyUATRk5wW
 dWz0JfTShY0xXKgT664GpLZ6I5hc+P8Wobsl+eu9KoJypRPBuvTfn1IbxhRkn5HRI16DzXI8U
 SMPQTtV4uv3USRrgAHnZDt6AKt3XZ1o3t7Y/+oqK5iWQmlXHJX92sMvjqLwBm/Bpbhv7/Cz9W
 hNQ1Fsl00IQytqZTv2wL2hwfjx79I5iG1Vosz5PPIZcMar7G9TqQ3X/gvB+Q7w+9IO8j+Q1kz
 9WcvdqFSG4h/JIswJ93/FC1pgRpRvWprFHT9IvthRHfEF/qTZdM6SxwGcc16M97RsrAKba6Dc
 I8v6bsvxV3jIeUatbU34GEoDPgaF/ETgYCdmcP+kqn0JIUjwu2wnKmCbrT1q5SscE5Y1OHyAC
 O2/w6DpW2p+obuLMLxbrsK64VIxFdL50IXE1TZDGNVUJSskTAXBfZMzyvRFmnGs/Ym6048ExK
 d2Vz69k1YNfYXBjP9WUGUU899fVPJky+nycaJHmVz8iM2n/1r5OYgo3Qi6QL7BzPvGF4Z/6gq
 KZJp0AwfCnlHOySsR/LlLcNNMP
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/9/14 =E4=B8=8A=E5=8D=8810:11, Hao Sun wrote:
> Hello,
>
> When using Healer to fuzz the latest Linux kernel, the following crash
> was triggered.

Hey, it's a warning, not a crash.

>
> HEAD commit: 6880fa6c5660 Linux 5.15-rc1
> git tree: upstream
> console output:
> https://drive.google.com/file/d/1nhxxAfMLAbaBRaJdyjKU56syabhlgjsO/view?u=
sp=3Dsharing
> kernel config: https://drive.google.com/file/d/1rUzyMbe5vcs6khA3tL9EHTLJ=
vsUdWcgB/view?usp=3Dsharing
> Syzlang reproducer:
> https://drive.google.com/file/d/15RurS3tTTpzu-fdhlQYS-qY_vpx5RoFX/view?u=
sp=3Dsharing
>
> Sorry, I don't have a C reproducer for this crash but have a Syzlang
> reproducer. Also, hope the symbolized report can help.
> Here are the instructions on how to execute Syzlang prog:
> https://github.com/google/syzkaller/blob/master/docs/executing_syzkaller=
_programs.md
>
> If you fix this issue, please add the following tag to the commit:
> Reported-by: Hao Sun <sunhao.th@gmail.com>
>
> FAULT_INJECTION: forcing a failure.
> name failslab, interval 1, probability 0, space 0, times 0
> CPU: 3 PID: 7821 Comm: syz-executor Not tainted 5.15.0-rc1 #16
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
>   btrfs_alloc_delayed_extent_op fs/btrfs/delayed-ref.h:299 [inline]
>   btrfs_alloc_tree_block+0x38c/0x670 fs/btrfs/extent-tree.c:4833
>   __btrfs_cow_block+0x16f/0x7d0 fs/btrfs/ctree.c:415
>   btrfs_cow_block+0x12a/0x300 fs/btrfs/ctree.c:570
>   btrfs_search_slot+0x6b0/0xee0 fs/btrfs/ctree.c:1768
>   btrfs_lookup_inode+0x50/0x110 fs/btrfs/inode-item.c:408
>   __btrfs_update_delayed_inode+0x81/0x370 fs/btrfs/delayed-inode.c:948
>   btrfs_commit_inode_delayed_inode+0x14a/0x160 fs/btrfs/delayed-inode.c:=
1189
>   btrfs_log_inode+0x438/0x1ab0 fs/btrfs/tree-log.c:5385
>   btrfs_log_inode_parent+0x272/0x1110 fs/btrfs/tree-log.c:6168
>   btrfs_log_dentry_safe+0x3a/0x50 fs/btrfs/tree-log.c:6269
>   btrfs_sync_file+0x2cd/0x760 fs/btrfs/file.c:2264
>   vfs_fsync_range+0x48/0xa0 fs/sync.c:200
>   generic_write_sync include/linux/fs.h:2955 [inline]
>   btrfs_file_write_iter+0x34f/0x510 fs/btrfs/file.c:2034
>   call_write_iter include/linux/fs.h:2163 [inline]
>   new_sync_write+0x18d/0x260 fs/read_write.c:507
>   vfs_write+0x43b/0x4a0 fs/read_write.c:594
>   ksys_write+0xd2/0x120 fs/read_write.c:647
>   do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>   do_syscall_64+0x34/0xb0 arch/x86/entry/common.c:80
>   entry_SYSCALL_64_after_hwframe+0x44/0xae
> RIP: 0033:0x46ae99
> Code: f7 d8 64 89 02 b8 ff ff ff ff c3 66 0f 1f 44 00 00 48 89 f8 48
> 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d
> 01 f0 ff ff 73 01 c3 48 c7 c1 bc ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007f040bcc8c48 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
> RAX: ffffffffffffffda RBX: 000000000078c158 RCX: 000000000046ae99
> RDX: 000000000000001b RSI: 0000000020005a00 RDI: 0000000000000008
> RBP: 00007f040bcc8c80 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 000000000000002c
> R13: 0000000000000000 R14: 000000000078c158 R15: 00007ffcfffddd60
> ------------[ cut here ]------------
> WARNING: CPU: 3 PID: 7821 at fs/btrfs/delayed-inode.c:995

Any error causing btrfs to abort transaction (except -EIO) will cause
btrfs to output extra waing messages for debug purpose.

So all these warnings are *expected*.

Thanks,
Qu

> __btrfs_update_delayed_inode+0x318/0x370 fs/btrfs/delayed-inode.c:995
> Modules linked in:
> CPU: 3 PID: 7821 Comm: syz-executor Not tainted 5.15.0-rc1 #16
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
> rel-1.12.0-59-gc9ba5276e321-prebuilt.qemu.org 04/01/2014
> RIP: 0010:__btrfs_update_delayed_inode+0x318/0x370 fs/btrfs/delayed-inod=
e.c:995
> Code: a8 c8 19 00 00 03 72 24 e8 f5 26 43 ff 83 fd fb 74 3f 83 fd e2
> 74 3a e8 e6 26 43 ff 89 ee 48 c7 c7 38 25 39 85 e8 08 2e 2e ff <0f> 0b
> e8 d1 26 43 ff 89 e9 ba e3 03 00 00 4c 89 f7 48 c7 c6 70 39
> RSP: 0018:ffffc9000b13ba28 EFLAGS: 00010286
> RAX: 0000000000000000 RBX: ffff88810a46b090 RCX: ffffc90002791000
> RDX: 0000000000040000 RSI: ffffffff812d18bc RDI: 00000000ffffffff
> RBP: 00000000fffffff4 R08: 0000000000000000 R09: 0000000000000001
> R10: ffffc9000b13b840 R11: 0000000000000007 R12: ffff88810e51eb60
> R13: 00000000fffffff4 R14: ffff88810248f0d0 R15: ffff888111df8000
> FS:  00007f040bcc9700(0000) GS:ffff88813dd00000(0000) knlGS:000000000000=
0000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000000000400200 CR3: 000000010e5d6000 CR4: 0000000000750ee0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> PKRU: 55555554
> Call Trace:
>   btrfs_commit_inode_delayed_inode+0x14a/0x160 fs/btrfs/delayed-inode.c:=
1189
>   btrfs_log_inode+0x438/0x1ab0 fs/btrfs/tree-log.c:5385
>   btrfs_log_inode_parent+0x272/0x1110 fs/btrfs/tree-log.c:6168
>   btrfs_log_dentry_safe+0x3a/0x50 fs/btrfs/tree-log.c:6269
>   btrfs_sync_file+0x2cd/0x760 fs/btrfs/file.c:2264
>   vfs_fsync_range+0x48/0xa0 fs/sync.c:200
>   generic_write_sync include/linux/fs.h:2955 [inline]
>   btrfs_file_write_iter+0x34f/0x510 fs/btrfs/file.c:2034
>   call_write_iter include/linux/fs.h:2163 [inline]
>   new_sync_write+0x18d/0x260 fs/read_write.c:507
>   vfs_write+0x43b/0x4a0 fs/read_write.c:594
>   ksys_write+0xd2/0x120 fs/read_write.c:647
>   do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>   do_syscall_64+0x34/0xb0 arch/x86/entry/common.c:80
>   entry_SYSCALL_64_after_hwframe+0x44/0xae
> RIP: 0033:0x46ae99
> Code: f7 d8 64 89 02 b8 ff ff ff ff c3 66 0f 1f 44 00 00 48 89 f8 48
> 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d
> 01 f0 ff ff 73 01 c3 48 c7 c1 bc ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007f040bcc8c48 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
> RAX: ffffffffffffffda RBX: 000000000078c158 RCX: 000000000046ae99
> RDX: 000000000000001b RSI: 0000000020005a00 RDI: 0000000000000008
> RBP: 00007f040bcc8c80 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 000000000000002c
> R13: 0000000000000000 R14: 000000000078c158 R15: 00007ffcfffddd60
>
