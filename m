Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0E06411167
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 Sep 2021 10:54:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236000AbhITIzy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 20 Sep 2021 04:55:54 -0400
Received: from mout.gmx.net ([212.227.17.21]:33887 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234238AbhITIzp (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 20 Sep 2021 04:55:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1632128054;
        bh=6MDEIcsCNVlrstla+snizgCFR8JkuQ2l/5o/9fF4UEs=;
        h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
        b=ZwWpEsbB6+FExELIrOlv7/zlgRKIzvCLRMXxc4MccA/zrrLKH81G5dtiUKT3VHjcj
         nP/CEYm5OQROMPqFChJpCFNAQzSW+Flu0bZ/jX3jqrrsVOlIRQCP4uo6/SSq/hWLA6
         wRYCFWisl4sckj5kkS+lh+fj+VUyjCqWJlhq3Ebs=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MTRQq-1mIINl3pqW-00TjJy; Mon, 20
 Sep 2021 10:54:14 +0200
Message-ID: <b9a39e9b-4489-a059-f226-b3c1e92f6f5d@gmx.com>
Date:   Mon, 20 Sep 2021 16:54:10 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Subject: Re: [PATCH] btrfs: unlock the newly allocated extent buffer in
 btrfs_alloc_tree_block()
Content-Language: en-US
To:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org, Hao Sun <sunhao.th@gmail.com>
References: <20210914065759.38793-1-wqu@suse.com>
 <20210920084822.GA9286@twin.jikos.cz>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20210920084822.GA9286@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:59qUM9UwWtS4S215KqVUAwl8K+vzY7OoxruOoWK7+Z/6Awk4bif
 kagaKloVQjt4GhVVt5uMOE9ghx32eLrqQ0SId8H1S64HhUbYIBYuq+yq+xWGUJZPRKDOLOB
 iCt//PkL9BJVODs4pqbJISmz+IQmZJhD4YOPR/ynamdMm6ajdBe0usIGBgV56FHORmY1ebq
 ek9MPst4WlYm4eBkmw5ZA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:CZjx2RKcZkg=:ewJE+abyfNAIJqAFS7vk68
 y+43O5CMQUSJH/TdWGShMYPCHrFyYvs+9jicf9Ko+H1qFXpTiu39M4IYKUgE+xCUvWaA7wajT
 rmzs0TpnUL7QVs13SdQHve6EzfmGL2JQ7UFBEDlNkIOWNUUew0MNaD3KhOY5oAwK/DsBS85JA
 0if3jz4PgCHnFVFhAaX1ivRy0Mrl5Q5Lb7C1vseLu1T6gQPF1c6iyFPVO7TMLhUIYdH2SxJ+X
 M/BIKpoE8lcV+bLLYQlhYoP05VqpxuRKzIRJBjqezVY9LCaoUGbO3I6ZcR2HedsOT4/rBun4I
 idUmhZWaiWST+qVZcZSbrUUb2yLNtvJ2clHXSbsyr48oS+KCpy/lWdpePVldHON7Lf5r4vn2D
 35kHk+4Fmx2NJRpPdsRkAJcSWphsNeRs+yM3AsegghOtm6tmdaiqSIzQ3T7Vy5CIa4rmlG/tW
 OkOZ1Ua+4lL5aLALrGCFu2KNIlCd0ilvAXRZ1mq/kQpjUPrubvtHgE3T0NghI2AKTz2IUNYlX
 ENho0fLmq8LP7h4aR3PKsCfwxPr/5+ZgrzW1jsndbobDXuKMq1qQP/wI7x9calDJGLJG3KQf5
 udGw8C6w3oQ7JRvKg/jdNv/6qC6gu80mha6WscVfD8sZY3ZKIEXcs3fGR2obrh10WgyPTEPAo
 cL5O37aDCGVn6bX8NQkS53w4KK3YkJ7La0NtP3GDfQ8D9EFQLaPKKIwU8CXgShwvVXEFo4pAI
 dOnP5wHd+sbd4SAjIHEx9a+Y5EkLL9Lvuwns7grzrlo9mp2gFtzc3xYayGLy4G/F2tjCSuLJJ
 cToxuScDKRozZ5bJhpWIJDa7vSdtuNS7xBDVA+weojujMzGwMCTLDo1Mh0wHxRkQPPFJZsZR5
 SJ8U1o58E8iEabstLIbaJIh7x1kLrsMNqBAaPeUJLp4Ug1VBkKAn74IlMLPYUUBJza+j/TmoZ
 Dbw8x9gXPGwE8PuIvimu4elhAO0epyXLn9NRnoWH8iKtSDixrv4CyHCKN0VMx7xACRX2PBRDR
 gI4RW2rrQOyZnHMchz7O1IzirSIYmMiDNkh0WJQ4XTQSA5R0hqMy7wFlX8ou26jRpX13E3pTV
 qLTYIM3iVX055Q=
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/9/20 16:48, David Sterba wrote:
> On Tue, Sep 14, 2021 at 02:57:59PM +0800, Qu Wenruo wrote:
>> [BUG]
>> There is a very detailed bug report that injected ENOMEM error could
>> leave a tree block locked while we return to user-space:
>>
>>    BTRFS info (device loop0): enabling ssd optimizations
>>    FAULT_INJECTION: forcing a failure.
>>    name failslab, interval 1, probability 0, space 0, times 0
>>    CPU: 0 PID: 7579 Comm: syz-executor Not tainted 5.15.0-rc1 #16
>>    Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
>>    rel-1.12.0-59-gc9ba5276e321-prebuilt.qemu.org 04/01/2014
>>    Call Trace:
>>     __dump_stack lib/dump_stack.c:88 [inline]
>>     dump_stack_lvl+0x8d/0xcf lib/dump_stack.c:106
>>     fail_dump lib/fault-inject.c:52 [inline]
>>     should_fail+0x13c/0x160 lib/fault-inject.c:146
>>     should_failslab+0x5/0x10 mm/slab_common.c:1328
>>     slab_pre_alloc_hook.constprop.99+0x4e/0xc0 mm/slab.h:494
>>     slab_alloc_node mm/slub.c:3120 [inline]
>>     slab_alloc mm/slub.c:3214 [inline]
>>     kmem_cache_alloc+0x44/0x280 mm/slub.c:3219
>>     btrfs_alloc_delayed_extent_op fs/btrfs/delayed-ref.h:299 [inline]
>>     btrfs_alloc_tree_block+0x38c/0x670 fs/btrfs/extent-tree.c:4833
>>     __btrfs_cow_block+0x16f/0x7d0 fs/btrfs/ctree.c:415
>>     btrfs_cow_block+0x12a/0x300 fs/btrfs/ctree.c:570
>>     btrfs_search_slot+0x6b0/0xee0 fs/btrfs/ctree.c:1768
>>     btrfs_insert_empty_items+0x80/0xf0 fs/btrfs/ctree.c:3905
>>     btrfs_new_inode+0x311/0xa60 fs/btrfs/inode.c:6530
>>     btrfs_create+0x12b/0x270 fs/btrfs/inode.c:6783
>>     lookup_open+0x660/0x780 fs/namei.c:3282
>>     open_last_lookups fs/namei.c:3352 [inline]
>>     path_openat+0x465/0xe20 fs/namei.c:3557
>>     do_filp_open+0xe3/0x170 fs/namei.c:3588
>>     do_sys_openat2+0x357/0x4a0 fs/open.c:1200
>>     do_sys_open+0x87/0xd0 fs/open.c:1216
>>     do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>>     do_syscall_64+0x34/0xb0 arch/x86/entry/common.c:80
>>     entry_SYSCALL_64_after_hwframe+0x44/0xae
>>    RIP: 0033:0x46ae99
>>    Code: f7 d8 64 89 02 b8 ff ff ff ff c3 66 0f 1f 44 00 00 48 89 f8 48
>>    89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> =
3d
>>    01 f0 ff ff 73 01 c3 48 c7 c1 bc ff ff ff f7 d8 64 89 01 48
>>    RSP: 002b:00007f46711b9c48 EFLAGS: 00000246 ORIG_RAX: 00000000000000=
55
>>    RAX: ffffffffffffffda RBX: 000000000078c0a0 RCX: 000000000046ae99
>>    RDX: 0000000000000000 RSI: 00000000000000a1 RDI: 0000000020005800
>>    RBP: 00007f46711b9c80 R08: 0000000000000000 R09: 0000000000000000
>>    R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000017
>>    R13: 0000000000000000 R14: 000000000078c0a0 R15: 00007ffc129da6e0
>>
>>    =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
>>    WARNING: lock held when returning to user space!
>>    5.15.0-rc1 #16 Not tainted
>>    ------------------------------------------------
>>    syz-executor/7579 is leaving the kernel with locks still held!
>>    1 lock held by syz-executor/7579:
>>     #0: ffff888104b73da8 (btrfs-tree-01/1){+.+.}-{3:3}, at:
>>    __btrfs_tree_lock+0x2e/0x1a0 fs/btrfs/locking.c:112
>>
>> [CAUSE]
>> In btrfs_alloc_tree_block(), after btrfs_init_new_buffer(), the new
>> extent buffer @buf is locked, but if later operations like adding
>> delayed tree ref fails, we just free @buf without unlocking it,
>> resulting above warning.
>>
>> [FIX]
>> Unlock @buf in out_free_buf: tag.
>>
>> Reported-by: Hao Sun <sunhao.th@gmail.com>
>> Link: https://lore.kernel.org/linux-btrfs/CACkBjsZ9O6Zr0KK1yGn=3D1rQi6C=
rh1yeCRdTSBxx9R99L4xdn-Q@mail.gmail.com/
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>
> I found the following lockdep report, it's been with recent misc-next
> and the functions on stack match what this patch touches but I haven't
> done a deeper analysis so this could be a false trace (though the
> warning seems legit).
>
> The workload was some file creation/copy and relocation but I don't have
> a more specific information.
>
> [10898.966572] BTRFS info (device sdd10): balance: start -musage=3D50 -s=
usage=3D50
> [10898.980261] BTRFS info (device sdd10): relocating block group 1955195=
78112 flags system
> [10906.757623] BTRFS info (device sdd10): relocating block group 1911480=
64768 flags metadata
> [11401.635794]
> [11401.637392] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> [11401.643647] WARNING: possible circular locking dependency detected
> [11401.649956] 5.15.0-rc1-git+ #810 Not tainted
> [11401.654315] ------------------------------------------------------
> [11401.660588] btrfs/11698 is trying to acquire lock:
> [11401.665467] ffff8bb384bf7068 (btrfs-treloc-03#2){+.+.}-{3:3}, at: __b=
trfs_tree_lock+0x2c/0x140 [btrfs]
> [11401.675102]
> [11401.675102] but task is already holding lock:
> [11401.681029] ffff8bb3ce5a4110 (btrfs-tree-02/1){+.+.}-{3:3}, at: __btr=
fs_tree_lock+0x2c/0x140 [btrfs]
> [11401.690417]
> [11401.690417] which lock already depends on the new lock.
> [11401.690417]
> [11401.698700]
> [11401.698700] the existing dependency chain (in reverse order) is:
> [11401.706272]
> [11401.706272] -> #2 (btrfs-tree-02/1){+.+.}-{3:3}:
> [11401.712473]        __lock_acquire+0x3e5/0x730
> [11401.716906]        lock_acquire.part.0+0x5f/0x190
> [11401.721700]        down_write_nested+0x49/0x130
> [11401.726310]        __btrfs_tree_lock+0x2c/0x140 [btrfs]
> [11401.731744]        btrfs_init_new_buffer+0x7d/0x2c0 [btrfs]
> [11401.737510]        btrfs_alloc_tree_block+0x13b/0x350 [btrfs]
> [11401.743459]        __btrfs_cow_block+0x144/0x600 [btrfs]
> [11401.748967]        btrfs_cow_block+0x107/0x160 [btrfs]
> [11401.754306]        btrfs_search_slot+0x67a/0xc00 [btrfs]
> [11401.759809]        btrfs_lookup_dir_item+0x7c/0xe0 [btrfs]
> [11401.765507]        __btrfs_unlink_inode+0xaa/0x4f0 [btrfs]
> [11401.771184]        btrfs_unlink+0x87/0x100 [btrfs]
> [11401.776154]        vfs_unlink+0x101/0x210
> [11401.780250]        do_unlinkat+0x19c/0x2c0
> [11401.784435]        __x64_sys_unlinkat+0x34/0x60
> [11401.789057]        do_syscall_64+0x3d/0xb0
> [11401.793253]        entry_SYSCALL_64_after_hwframe+0x44/0xae
> [11401.798914]
> [11401.798914] -> #1 (btrfs-tree-02){++++}-{3:3}:
> [11401.804947]        __lock_acquire+0x3e5/0x730
> [11401.809381]        lock_acquire.part.0+0x5f/0x190
> [11401.814185]        down_write_nested+0x49/0x130
> [11401.818810]        __btrfs_tree_lock+0x2c/0x140 [btrfs]
> [11401.824247]        btrfs_search_slot+0x2a1/0xc00 [btrfs]
> [11401.829759]        do_relocation+0x12c/0x6f0 [btrfs]
> [11401.834942]        relocate_tree_block+0x1a6/0x270 [btrfs]
> [11401.840646]        relocate_tree_blocks+0xe8/0x260 [btrfs]
> [11401.846358]        relocate_block_group+0x200/0x580 [btrfs]
> [11401.852146]        btrfs_relocate_block_group+0x18b/0x350 [btrfs]
> [11401.858455]        btrfs_relocate_chunk+0x38/0x120 [btrfs]
> [11401.864166]        __btrfs_balance+0x2ea/0x490 [btrfs]
> [11401.869511]        btrfs_balance+0x4d3/0x7c0 [btrfs]
> [11401.874684]        btrfs_ioctl_balance+0x31c/0x3e0 [btrfs]
> [11401.880382]        __x64_sys_ioctl+0x83/0xa0
> [11401.884736]        do_syscall_64+0x3d/0xb0
> [11401.888924]        entry_SYSCALL_64_after_hwframe+0x44/0xae
> [11401.894573]
> [11401.894573] -> #0 (btrfs-treloc-03#2){+.+.}-{3:3}:
> [11401.900946]        check_prev_add+0x91/0xc30
> [11401.905293]        validate_chain+0x56f/0x840
> [11401.909740]        __lock_acquire+0x3e5/0x730
> [11401.914186]        lock_acquire.part.0+0x5f/0x190
> [11401.918979]        down_write_nested+0x49/0x130
> [11401.923607]        __btrfs_tree_lock+0x2c/0x140 [btrfs]
> [11401.929064]        btrfs_lock_root_node+0x31/0x40 [btrfs]
> [11401.934671]        btrfs_search_slot+0x58e/0xc00 [btrfs]
> [11401.940164]        replace_path+0x57e/0xc70 [btrfs]
> [11401.945241]        merge_reloc_root+0x222/0x8c0 [btrfs]
> [11401.950667]        merge_reloc_roots+0xf0/0x290 [btrfs]
> [11401.956119]        relocate_block_group+0x2d7/0x580 [btrfs]
> [11401.961910]        btrfs_relocate_block_group+0x18b/0x350 [btrfs]
> [11401.968204]        btrfs_relocate_chunk+0x38/0x120 [btrfs]
> [11401.973905]        __btrfs_balance+0x2ea/0x490 [btrfs]
> [11401.979239]        btrfs_balance+0x4d3/0x7c0 [btrfs]
> [11401.984423]        btrfs_ioctl_balance+0x31c/0x3e0 [btrfs]
> [11401.990117]        __x64_sys_ioctl+0x83/0xa0
> [11401.994456]        do_syscall_64+0x3d/0xb0
> [11401.998642]        entry_SYSCALL_64_after_hwframe+0x44/0xae
> [11402.004323]
> [11402.004323] other info that might help us debug this:
> [11402.004323]
> [11402.012465] Chain exists of:
> [11402.012465]   btrfs-treloc-03#2 --> btrfs-tree-02 --> btrfs-tree-02/1
> [11402.012465]
> [11402.023382]  Possible unsafe locking scenario:
> [11402.023382]
> [11402.029395]        CPU0                    CPU1
> [11402.034004]        ----                    ----
> [11402.038622]   lock(btrfs-tree-02/1);
> [11402.042287]                                lock(btrfs-tree-02);
> [11402.048288]                                lock(btrfs-tree-02/1);
> [11402.054476]   lock(btrfs-treloc-03#2);

This means ABBA tree lock.

But the patch I submitted only touched the error handling part of
btrfs_alloc_tree_block(), and all the possible error causes are -ENOMEM.


The lockdep report just shows that under certain call path we're holding
the tree lock in a bad sequence, no matter if my patch is applied or not.

Thanks,
Qu

> [11402.060166]
> [11402.060166]  *** DEADLOCK ***
> [11402.060166]
> [11402.066212] 5 locks held by btrfs/11698:
> [11402.070210]  #0: ffff8bb4fab09478 (sb_writers#9){.+.+}-{0:0}, at: btr=
fs_ioctl_balance+0x47/0x3e0 [btrfs]
> [11402.079923]  #1: ffff8bb48520a370 (&fs_info->reclaim_bgs_lock){+.+.}-=
{3:3}, at: __btrfs_balance+0x179/0x490 [btrfs]
> [11402.090584]  #2: ffff8bb4852088e0 (&fs_info->cleaner_mutex){+.+.}-{3:=
3}, at: btrfs_relocate_block_group+0x183/0x350 [btrfs]
> [11402.101965]  #3: ffff8bb4fab09698 (sb_internal#2){.+.+}-{0:0}, at: me=
rge_reloc_root+0x11c/0x8c0 [btrfs]
> [11402.111616]  #4: ffff8bb3ce5a4110 (btrfs-tree-02/1){+.+.}-{3:3}, at: =
__btrfs_tree_lock+0x2c/0x140 [btrfs]
> [11402.121418]
> [11402.121418] stack backtrace:
> [11402.125880] CPU: 7 PID: 11698 Comm: btrfs Not tainted 5.15.0-rc1-git+=
 #810
> [11402.132843] Hardware name: empty empty/S3993, BIOS PAQEX0-3 02/24/200=
8
> [11402.139470] Call Trace:
> [11402.141989]  dump_stack_lvl+0x45/0x59
> [11402.145736]  check_noncircular+0xf3/0x110
> [11402.149827]  ? check_irq_usage+0xaa/0x3f0
> [11402.153943]  check_prev_add+0x91/0xc30
> [11402.157783]  validate_chain+0x56f/0x840
> [11402.161719]  __lock_acquire+0x3e5/0x730
> [11402.165654]  lock_acquire.part.0+0x5f/0x190
> [11402.169924]  ? __btrfs_tree_lock+0x2c/0x140 [btrfs]
> [11402.175013]  ? lock_acquire+0xa0/0x150
> [11402.178839]  ? __btrfs_tree_lock+0x2c/0x140 [btrfs]
> [11402.183949]  down_write_nested+0x49/0x130
> [11402.188043]  ? __btrfs_tree_lock+0x2c/0x140 [btrfs]
> [11402.193127]  __btrfs_tree_lock+0x2c/0x140 [btrfs]
> [11402.198039]  btrfs_lock_root_node+0x31/0x40 [btrfs]
> [11402.203148]  btrfs_search_slot+0x58e/0xc00 [btrfs]
> [11402.208117]  replace_path+0x57e/0xc70 [btrfs]
> [11402.212680]  merge_reloc_root+0x222/0x8c0 [btrfs]
> [11402.217593]  ? lock_release+0x68/0x140
> [11402.221427]  ? _raw_spin_unlock+0x1f/0x40
> [11402.225522]  merge_reloc_roots+0xf0/0x290 [btrfs]
> [11402.230439]  relocate_block_group+0x2d7/0x580 [btrfs]
> [11402.235721]  btrfs_relocate_block_group+0x18b/0x350 [btrfs]
> [11402.241521]  btrfs_relocate_chunk+0x38/0x120 [btrfs]
> [11402.246688]  __btrfs_balance+0x2ea/0x490 [btrfs]
> [11402.251524]  btrfs_balance+0x4d3/0x7c0 [btrfs]
> [11402.256181]  btrfs_ioctl_balance+0x31c/0x3e0 [btrfs]
> [11402.261377]  __x64_sys_ioctl+0x83/0xa0
> [11402.265205]  do_syscall_64+0x3d/0xb0
> [11402.268853]  entry_SYSCALL_64_after_hwframe+0x44/0xae
> [11402.273985] RIP: 0033:0x7fedef5ff6c7
> [11402.277642] Code: 00 00 00 48 8b 05 c1 67 2b 00 64 c7 00 26 00 00 00 =
48 c7 c0 ff ff ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 b8 10 00 00 00 0f 05=
 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 91 67 2b 00 f7 d8 64 89 01 48
> [11402.296539] RSP: 002b:00007ffda9289e78 EFLAGS: 00000246 ORIG_RAX: 000=
0000000000010
> [11402.304211] RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007fed=
ef5ff6c7
> [11402.311439] RDX: 00007ffda9289f10 RSI: 00000000c4009420 RDI: 00000000=
00000003
> [11402.318657] RBP: 00007ffda928c866 R08: 00000000004c4cab R09: 00000000=
00000013
> [11402.325877] R10: 0000000022494966 R11: 0000000000000246 R12: 00000000=
00000001
> [11402.333115] R13: 00007ffda9289f10 R14: 0000000000000000 R15: 00007ffd=
a9289f08
> [11432.564100] BTRFS info (device sdd10): found 30943 extents, stage: mo=
ve data extents
>
