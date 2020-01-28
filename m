Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 429F614B304
	for <lists+linux-btrfs@lfdr.de>; Tue, 28 Jan 2020 11:50:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725974AbgA1Ku0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 28 Jan 2020 05:50:26 -0500
Received: from mx2.suse.de ([195.135.220.15]:52402 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725901AbgA1KuZ (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 28 Jan 2020 05:50:25 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 110C8ACEF;
        Tue, 28 Jan 2020 10:50:23 +0000 (UTC)
Subject: Re: [PATCH 1/2] Btrfs: fix race between adding and putting tree mod
 seq elements and nodes
To:     fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <20200122122320.30073-1-fdmanana@kernel.org>
From:   Nikolay Borisov <nborisov@suse.com>
Autocrypt: addr=nborisov@suse.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <0091d2d2-b43f-8cff-6466-2c86ef26c027@suse.com>
Date:   Tue, 28 Jan 2020 12:50:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200122122320.30073-1-fdmanana@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 22.01.20 г. 14:23 ч., fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> There is a race between adding and removing elements to the tree mod log
> list and rbtree that can lead to use-after-free problems.
> 
> Consider the following example that explains how/why the problems happens:
> 
> 1) Task A has mod log element with sequence number 200. It currently is
>    the only element in the mod log list;
> 
> 2) Task A calls btrfs_put_tree_mod_seq() because it no longer needs to
>    access the tree mod log. When it enters the function, it initializes
>    'min_seq' to (u64)-1. Then it acquires the lock 'tree_mod_seq_lock'
>    before checking if there are other elements in the mod seq list.
>    Since the list it empty, 'min_seq' remains set to (u64)-1. Then it
>    unlocks the lock 'tree_mod_seq_lock';
> 
> 3) Before task A acquires the lock 'tree_mod_log_lock', task B adds
>    itself to the mod seq list through btrfs_get_tree_mod_seq() and gets a
>    sequence number of 201;
> 
> 4) Some other task, name it task C, modifies a btree and because there
>    elements in the mod seq list, it adds a tree mod elem to the tree
>    mod log rbtree. That node added to the mod log rbtree is assigned
>    a sequence number of 202;
> 
> 5) Task B, which is doing fiemap and resolving indirect back references,
>    calls btrfs get_old_root(), with 'time_seq' == 201, which in turn
>    calls tree_mod_log_search() - the search returns the mod log node
>    from the rbtree with sequence number 202, created by task C;
> 
> 6) Task A now acquires the lock 'tree_mod_log_lock', starts iterating
>    the mod log rbtree and finds the node with sequence number 202. Since
>    202 is less than the previously computed 'min_seq', (u64)-1, it
>    removes the node and frees it;
> 
> 7) Task B still has a pointer to the node with sequence number 202, and
>    it dereferences the pointer itself and through the call to
>    __tree_mod_log_rewind(), resulting in a use-after-free problem._
> 
> This issue can be triggered sporadically with the test case generic/561
> from fstests, and it happens more frequently with a higher number of
> duperemove processes. When it happens to me, it either freezes the vm or
> it produces a trace like the following before crashing:
> 
>   [ 1245.321140] general protection fault: 0000 [#1] PREEMPT SMP DEBUG_PAGEALLOC PTI
>   [ 1245.321200] CPU: 1 PID: 26997 Comm: pool Not tainted 5.5.0-rc6-btrfs-next-52 #1
>   [ 1245.321235] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.12.0-0-ga698c8995f-prebuilt.qemu.org 04/01/2014
>   [ 1245.321287] RIP: 0010:rb_next+0x16/0x50
>   [ 1245.321307] Code: ....
>   [ 1245.321372] RSP: 0018:ffffa151c4d039b0 EFLAGS: 00010202
>   [ 1245.321388] RAX: 6b6b6b6b6b6b6b6b RBX: ffff8ae221363c80 RCX: 6b6b6b6b6b6b6b6b
>   [ 1245.321409] RDX: 0000000000000001 RSI: 0000000000000000 RDI: ffff8ae221363c80
>   [ 1245.321439] RBP: ffff8ae20fcc4688 R08: 0000000000000002 R09: 0000000000000000
>   [ 1245.321475] R10: ffff8ae20b120910 R11: 00000000243f8bb1 R12: 0000000000000038
>   [ 1245.321506] R13: ffff8ae221363c80 R14: 000000000000075f R15: ffff8ae223f762b8
>   [ 1245.321539] FS:  00007fdee1ec7700(0000) GS:ffff8ae236c80000(0000) knlGS:0000000000000000
>   [ 1245.321591] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>   [ 1245.321614] CR2: 00007fded4030c48 CR3: 000000021da16003 CR4: 00000000003606e0
>   [ 1245.321642] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>   [ 1245.321668] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>   [ 1245.321706] Call Trace:
>   [ 1245.321798]  __tree_mod_log_rewind+0xbf/0x280 [btrfs]
>   [ 1245.321841]  btrfs_search_old_slot+0x105/0xd00 [btrfs]
>   [ 1245.321877]  resolve_indirect_refs+0x1eb/0xc60 [btrfs]
>   [ 1245.321912]  find_parent_nodes+0x3dc/0x11b0 [btrfs]
>   [ 1245.321947]  btrfs_check_shared+0x115/0x1c0 [btrfs]
>   [ 1245.321980]  ? extent_fiemap+0x59d/0x6d0 [btrfs]
>   [ 1245.322029]  extent_fiemap+0x59d/0x6d0 [btrfs]
>   [ 1245.322066]  do_vfs_ioctl+0x45a/0x750
>   [ 1245.322081]  ksys_ioctl+0x70/0x80
>   [ 1245.322092]  ? trace_hardirqs_off_thunk+0x1a/0x1c
>   [ 1245.322113]  __x64_sys_ioctl+0x16/0x20
>   [ 1245.322126]  do_syscall_64+0x5c/0x280
>   [ 1245.322139]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
>   [ 1245.322155] RIP: 0033:0x7fdee3942dd7
>   [ 1245.322177] Code: ....
>   [ 1245.322258] RSP: 002b:00007fdee1ec6c88 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
>   [ 1245.322294] RAX: ffffffffffffffda RBX: 00007fded40210d8 RCX: 00007fdee3942dd7
>   [ 1245.322314] RDX: 00007fded40210d8 RSI: 00000000c020660b RDI: 0000000000000004
>   [ 1245.322337] RBP: 0000562aa89e7510 R08: 0000000000000000 R09: 00007fdee1ec6d44
>   [ 1245.322369] R10: 0000000000000073 R11: 0000000000000246 R12: 00007fdee1ec6d48
>   [ 1245.322390] R13: 00007fdee1ec6d40 R14: 00007fded40210d0 R15: 00007fdee1ec6d50
>   [ 1245.322423] Modules linked in: ....
>   [ 1245.323443] ---[ end trace 01de1e9ec5dff3cd ]---
> 
> Fix this by ensuring that btrfs_put_tree_mod_seq() computes the minimum
> sequence number and iterates the rbtree while holding the lock
> 'tree_mod_log_lock' in write mode. Also get rid of the 'tree_mod_seq_lock'
> lock, since it is now redundant.
> 
> Fixes: bd989ba359f2ac ("Btrfs: add tree modification log functions")
> Fixes: 097b8a7c9e48e2 ("Btrfs: join tree mod log code with the code holding back delayed refs")
> CC: stable@vger.kernel.org
> Signed-off-by: Filipe Manana <fdmanana@suse.com>


Reviewed-by: Nikolay Borisov <nborisov@suse.com>
