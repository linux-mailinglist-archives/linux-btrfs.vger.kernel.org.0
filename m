Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9815329312
	for <lists+linux-btrfs@lfdr.de>; Mon,  1 Mar 2021 22:01:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238554AbhCAU67 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 1 Mar 2021 15:58:59 -0500
Received: from mx2.suse.de ([195.135.220.15]:45492 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243665AbhCAUzx (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 1 Mar 2021 15:55:53 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id C6D4DAAC5;
        Mon,  1 Mar 2021 20:55:06 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id EB23FDA7AA; Mon,  1 Mar 2021 21:53:11 +0100 (CET)
Date:   Mon, 1 Mar 2021 21:53:11 +0100
From:   David Sterba <dsterba@suse.cz>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org, casey@schaufler-ca.com,
        Filipe Manana <fdmanana@suse.com>
Subject: Re: [PATCH] btrfs: fix warning when creating a directory with smack
 enabled
Message-ID: <20210301205311.GD7604@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, fdmanana@kernel.org,
        linux-btrfs@vger.kernel.org, casey@schaufler-ca.com,
        Filipe Manana <fdmanana@suse.com>
References: <556c75e2762f240b09aeaf21f13a318ae55b1675.1614361829.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <556c75e2762f240b09aeaf21f13a318ae55b1675.1614361829.git.fdmanana@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Feb 26, 2021 at 05:51:44PM +0000, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> When we have smack enabled, during the creation of a directory smack may
> attempt to add a "smack transmute" xattr on the inode, which results in
> the following warning and trace:
> 
> [  220.732359] ------------[ cut here ]------------
> [  220.732398] WARNING: CPU: 3 PID: 2548 at fs/btrfs/transaction.c:537 start_transaction+0x489/0x4f0
> [  220.732400] Modules linked in: nft_objref nf_conntrack_netbios_ns (...)
> [  220.732439] CPU: 3 PID: 2548 Comm: mkdir Not tainted 5.9.0-rc2smack+ #81
> [  220.732441] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-2.fc32 04/01/2014
> [  220.732444] RIP: 0010:start_transaction+0x489/0x4f0
> [  220.732447] Code: e9 be fc ff ff (...)
> [  220.732449] RSP: 0018:ffffc90001887d10 EFLAGS: 00010202
> [  220.732452] RAX: ffff88816f1e0000 RBX: 0000000000000201 RCX: 0000000000000003
> [  220.732454] RDX: 0000000000000201 RSI: 0000000000000002 RDI: ffff888177849000
> [  220.732456] RBP: ffff888177849000 R08: 0000000000000001 R09: 0000000000000004
> [  220.732458] R10: ffffffff825e8f7a R11: 0000000000000003 R12: ffffffffffffffe2
> [  220.732460] R13: 0000000000000000 R14: ffff88803d884270 R15: ffff8881680d8000
> [  220.732463] FS:  00007f67317b8440(0000) GS:ffff88817bcc0000(0000) knlGS:0000000000000000
> [  220.732465] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  220.732467] CR2: 00007f67247a22a8 CR3: 000000004bfbc002 CR4: 0000000000370ee0
> [  220.732472] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [  220.732474] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [  220.732475] Call Trace:
> [  220.732480]  ? slab_free_freelist_hook+0xea/0x1b0
> [  220.732483]  ? trace_hardirqs_on+0x1c/0xe0
> [  220.732490]  btrfs_setxattr_trans+0x3c/0xf0
> [  220.732496]  __vfs_setxattr+0x63/0x80
> [  220.732502]  smack_d_instantiate+0x2d3/0x360
> [  220.732507]  security_d_instantiate+0x29/0x40
> [  220.732511]  d_instantiate_new+0x38/0x90
> [  220.732515]  btrfs_mkdir+0x1cf/0x1e0
> [  220.732521]  vfs_mkdir+0x14f/0x200
> [  220.732525]  do_mkdirat+0x6d/0x110
> [  220.732531]  do_syscall_64+0x2d/0x40
> [  220.732534]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> [  220.732537] RIP: 0033:0x7f673196ae6b
> [  220.732540] Code: 8b 05 11 (...)
> [  220.732542] RSP: 002b:00007ffc3c679b18 EFLAGS: 00000246 ORIG_RAX: 0000000000000053
> [  220.732545] RAX: ffffffffffffffda RBX: 00000000000001ff RCX: 00007f673196ae6b
> [  220.732547] RDX: 0000000000000000 RSI: 00000000000001ff RDI: 00007ffc3c67a30d
> [  220.732549] RBP: 00007ffc3c67a30d R08: 00000000000001ff R09: 0000000000000000
> [  220.732551] R10: 000055d3e39fe930 R11: 0000000000000246 R12: 0000000000000000
> [  220.732553] R13: 00007ffc3c679cd8 R14: 00007ffc3c67a30d R15: 00007ffc3c679ce0
> [  220.732563] irq event stamp: 11029
> [  220.732566] hardirqs last  enabled at (11037): [<ffffffff81153fe6>] console_unlock+0x486/0x670
> [  220.732569] hardirqs last disabled at (11044): [<ffffffff81153c01>] console_unlock+0xa1/0x670
> [  220.732572] softirqs last  enabled at (8864): [<ffffffff81e0102f>] asm_call_on_stack+0xf/0x20
> [  220.732575] softirqs last disabled at (8851): [<ffffffff81e0102f>] asm_call_on_stack+0xf/0x20
> [  220.732577] ---[ end trace 8f958916039daced ]---
> 
> This happens because at btrfs_mkdir() we call d_instantiate_new() while
> holding a transaction handle, which results in the following call chain:
> 
>   btrfs_mkdir()
>      trans = btrfs_start_transaction(root, 5);
> 
>      d_instantiate_new()
>         smack_d_instantiate()
>             __vfs_setxattr()
>                 btrfs_setxattr_trans()
>                    btrfs_start_transaction()
>                       start_transaction()
>                          WARN_ON()
>                            --> a tansaction start has TRANS_EXTWRITERS
>                                set in its type
>                          h->orig_rsv = h->block_rsv
>                          h->block_rsv = NULL
> 
>      btrfs_end_transaction(trans)
> 
> Besides the warning triggered at start_transaction.c, we set the handle's
> block_rsv to NULL which may cause some surprises later on.
> 
> So fix this by making btrfs_setxattr_trans() not start a transaction when
> we already have a handle on one, stored in current->journal_info, and use
> that handle. We are good to use the handle because at btrfs_mkdir() we did
> reserve space for the xattr and the inode item.
> 
> Reported-by: Casey Schaufler <casey@schaufler-ca.com>
> Link: https://lore.kernel.org/linux-btrfs/434d856f-bd7b-4889-a6ec-e81aaebfa735@schaufler-ca.com/
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Thanks, added to misc-next.
