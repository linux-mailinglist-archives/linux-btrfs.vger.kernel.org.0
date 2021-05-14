Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A483E380CC3
	for <lists+linux-btrfs@lfdr.de>; Fri, 14 May 2021 17:21:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233622AbhENPWt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 14 May 2021 11:22:49 -0400
Received: from mx2.suse.de ([195.135.220.15]:38552 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232430AbhENPWt (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 14 May 2021 11:22:49 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id AB0AFB1A9;
        Fri, 14 May 2021 15:21:36 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id C4C14DAF1B; Fri, 14 May 2021 17:19:05 +0200 (CEST)
Date:   Fri, 14 May 2021 17:19:05 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     fdmanana@kernel.org, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: release path before starting transaction when
 cloning inline extent
Message-ID: <20210514151905.GX7604@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Anand Jain <anand.jain@oracle.com>,
        fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <3ec5746e834bba2593b9f109a335743ac321b345.1620982607.git.fdmanana@suse.com>
 <b2d4303b-83a6-3a1c-acd9-393f2c76f638@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b2d4303b-83a6-3a1c-acd9-393f2c76f638@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, May 14, 2021 at 07:36:41PM +0800, Anand Jain wrote:
> On 14/05/2021 17:03, fdmanana@kernel.org wrote:
> > From: Filipe Manana <fdmanana@suse.com>
> > 
> > When cloning an inline extent there are a few cases, such as when we have
> > an implicit hole at file offset 0, where we start a transaction while
> > holding a read lock on a leaf. Starting the transaction results in a call
> > to sb_start_intwrite(), which results in doing a read lock on a percpu
> > semaphore. Lockdep doesn't like this and complains about it:
> > 
> > [   46.580704] ======================================================
> > [   46.580752] WARNING: possible circular locking dependency detected
> > [   46.580799] 5.13.0-rc1 #28 Not tainted
> > [   46.580832] ------------------------------------------------------
> > [   46.580877] cloner/3835 is trying to acquire lock:
> > [   46.580918] c00000001301d638 (sb_internal#2){.+.+}-{0:0}, at: clone_copy_inline_extent+0xe4/0x5a0
> > [   46.581167]
> > [   46.581167] but task is already holding lock:
> > [   46.581217] c000000007fa2550 (btrfs-tree-00){++++}-{3:3}, at: __btrfs_tree_read_lock+0x70/0x1d0
> > [   46.581293]
> > [   46.581293] which lock already depends on the new lock.
> > [   46.581293]
> > [   46.581351]
> > [   46.581351] the existing dependency chain (in reverse order) is:
> > [   46.581410]
> > [   46.581410] -> #1 (btrfs-tree-00){++++}-{3:3}:
> > [   46.581464]        down_read_nested+0x68/0x200
> > [   46.581536]        __btrfs_tree_read_lock+0x70/0x1d0
> > [   46.581577]        btrfs_read_lock_root_node+0x88/0x200
> > [   46.581623]        btrfs_search_slot+0x298/0xb70
> > [   46.581665]        btrfs_set_inode_index+0xfc/0x260
> > [   46.581708]        btrfs_new_inode+0x26c/0x950
> > [   46.581749]        btrfs_create+0xf4/0x2b0
> > [   46.581782]        lookup_open.isra.57+0x55c/0x6a0
> > [   46.581855]        path_openat+0x418/0xd20
> > [   46.581888]        do_filp_open+0x9c/0x130
> > [   46.581920]        do_sys_openat2+0x2ec/0x430
> > [   46.581961]        do_sys_open+0x90/0xc0
> > [   46.581993]        system_call_exception+0x3d4/0x410
> > [   46.582037]        system_call_common+0xec/0x278
> > [   46.582078]
> > [   46.582078] -> #0 (sb_internal#2){.+.+}-{0:0}:
> > [   46.582135]        __lock_acquire+0x1e90/0x2c50
> > [   46.582176]        lock_acquire+0x2b4/0x5b0
> > [   46.582263]        start_transaction+0x3cc/0x950
> > [   46.582308]        clone_copy_inline_extent+0xe4/0x5a0
> > [   46.582353]        btrfs_clone+0x5fc/0x880
> > [   46.582388]        btrfs_clone_files+0xd8/0x1c0
> > [   46.582434]        btrfs_remap_file_range+0x3d8/0x590
> > [   46.582481]        do_clone_file_range+0x10c/0x270
> > [   46.582558]        vfs_clone_file_range+0x1b0/0x310
> > [   46.582605]        ioctl_file_clone+0x90/0x130
> > [   46.582651]        do_vfs_ioctl+0x874/0x1ac0
> > [   46.582697]        sys_ioctl+0x6c/0x120
> > [   46.582733]        system_call_exception+0x3d4/0x410
> > [   46.582777]        system_call_common+0xec/0x278
> > [   46.582822]
> > [   46.582822] other info that might help us debug this:
> > [   46.582822]
> > [   46.582888]  Possible unsafe locking scenario:
> > [   46.582888]
> > [   46.582942]        CPU0                    CPU1
> > [   46.582984]        ----                    ----
> > [   46.583028]   lock(btrfs-tree-00);
> > [   46.583062]                                lock(sb_internal#2);
> > [   46.583119]                                lock(btrfs-tree-00);
> > [   46.583174]   lock(sb_internal#2);
> > [   46.583212]
> > [   46.583212]  *** DEADLOCK ***
> > [   46.583212]
> > [   46.583266] 6 locks held by cloner/3835:
> > [   46.583299]  #0: c00000001301d448 (sb_writers#12){.+.+}-{0:0}, at: ioctl_file_clone+0x90/0x130
> > [   46.583382]  #1: c00000000f6d3768 (&sb->s_type->i_mutex_key#15){+.+.}-{3:3}, at: lock_two_nondirectories+0x58/0xc0
> > [   46.583477]  #2: c00000000f6d72a8 (&sb->s_type->i_mutex_key#15/4){+.+.}-{3:3}, at: lock_two_nondirectories+0x9c/0xc0
> > [   46.583574]  #3: c00000000f6d7138 (&ei->i_mmap_lock){+.+.}-{3:3}, at: btrfs_remap_file_range+0xd0/0x590
> > [   46.583657]  #4: c00000000f6d35f8 (&ei->i_mmap_lock/1){+.+.}-{3:3}, at: btrfs_remap_file_range+0xe0/0x590
> > [   46.583743]  #5: c000000007fa2550 (btrfs-tree-00){++++}-{3:3}, at: __btrfs_tree_read_lock+0x70/0x1d0
> > [   46.583828]
> > [   46.583828] stack backtrace:
> > [   46.583872] CPU: 1 PID: 3835 Comm: cloner Not tainted 5.13.0-rc1 #28
> > [   46.583931] Call Trace:
> > [   46.583955] [c0000000167c7200] [c000000000c1ee78] dump_stack+0xec/0x144 (unreliable)
> > [   46.584052] [c0000000167c7240] [c000000000274058] print_circular_bug.isra.32+0x3a8/0x400
> > [   46.584123] [c0000000167c72e0] [c0000000002741f4] check_noncircular+0x144/0x190
> > [   46.584191] [c0000000167c73b0] [c000000000278fc0] __lock_acquire+0x1e90/0x2c50
> > [   46.584259] [c0000000167c74f0] [c00000000027aa94] lock_acquire+0x2b4/0x5b0
> > [   46.584317] [c0000000167c75e0] [c000000000a0d6cc] start_transaction+0x3cc/0x950
> > [   46.584388] [c0000000167c7690] [c000000000af47a4] clone_copy_inline_extent+0xe4/0x5a0
> > [   46.584457] [c0000000167c77c0] [c000000000af525c] btrfs_clone+0x5fc/0x880
> > [   46.584514] [c0000000167c7990] [c000000000af5698] btrfs_clone_files+0xd8/0x1c0
> > [   46.584583] [c0000000167c7a00] [c000000000af5b58] btrfs_remap_file_range+0x3d8/0x590
> > [   46.584652] [c0000000167c7ae0] [c0000000005d81dc] do_clone_file_range+0x10c/0x270
> > [   46.584722] [c0000000167c7b40] [c0000000005d84f0] vfs_clone_file_range+0x1b0/0x310
> > [   46.584793] [c0000000167c7bb0] [c00000000058bf80] ioctl_file_clone+0x90/0x130
> > [   46.584861] [c0000000167c7c10] [c00000000058c894] do_vfs_ioctl+0x874/0x1ac0
> > [   46.584922] [c0000000167c7d10] [c00000000058db4c] sys_ioctl+0x6c/0x120
> > [   46.584978] [c0000000167c7d60] [c0000000000364a4] system_call_exception+0x3d4/0x410
> > [   46.585046] [c0000000167c7e10] [c00000000000d45c] system_call_common+0xec/0x278
> > [   46.585114] --- interrupt: c00 at 0x7ffff7e22990
> > [   46.585160] NIP:  00007ffff7e22990 LR: 00000001000010ec CTR: 0000000000000000
> > [   46.585224] REGS: c0000000167c7e80 TRAP: 0c00   Not tainted  (5.13.0-rc1)
> > [   46.585280] MSR:  800000000280f033 <SF,VEC,VSX,EE,PR,FP,ME,IR,DR,RI,LE>  CR: 28000244  XER: 00000000
> > [   46.585374] IRQMASK: 0
> > [   46.585374] GPR00: 0000000000000036 00007fffffffdec0 00007ffff7f17100 0000000000000004
> > [   46.585374] GPR04: 000000008020940d 00007fffffffdf40 0000000000000000 0000000000000000
> > [   46.585374] GPR08: 0000000000000004 0000000000000000 0000000000000000 0000000000000000
> > [   46.585374] GPR12: 0000000000000000 00007ffff7ffa940 0000000000000000 0000000000000000
> > [   46.585374] GPR16: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
> > [   46.585374] GPR20: 0000000000000000 000000009123683e 00007fffffffdf40 0000000000000000
> > [   46.585374] GPR24: 0000000000000000 0000000000000000 0000000000000000 0000000000000004
> > [   46.585374] GPR28: 0000000100030260 0000000100030280 0000000000000003 000000000000005f
> > [   46.585919] NIP [00007ffff7e22990] 0x7ffff7e22990
> > [   46.585964] LR [00000001000010ec] 0x1000010ec
> > [   46.586010] --- interrupt: c00
> > 
> > This should be a false positive, as both locks are acquired in read mode.
> > Nevertheless, we don't need to hold a leaf locked when we start the
> > transaction, so just release the leaf (path) before starting it.
> > 
> > Reported-by: Ritesh Harjani <riteshh@linux.ibm.com>
> > Link: https://lore.kernel.org/linux-btrfs/20210513214404.xks77p566fglzgum@riteshh-domain/
> > Signed-off-by: Filipe Manana <fdmanana@suse.com>
> > ---
> >   fs/btrfs/reflink.c | 1 +
> >   1 file changed, 1 insertion(+)
> > 
> > diff --git a/fs/btrfs/reflink.c b/fs/btrfs/reflink.c
> > index f4ec06b53aa0..ae3fde71defb 100644
> > --- a/fs/btrfs/reflink.c
> > +++ b/fs/btrfs/reflink.c
> > @@ -291,6 +291,7 @@ static int clone_copy_inline_extent(struct inode *dst,
> >   		 *
> >   		 * 1 unit to update inode item
> >   		 */
> > +		btrfs_release_path(path);
> >   		trans = btrfs_start_transaction(root, 1);
> >   		if (IS_ERR(trans)) {
> >   			ret = PTR_ERR(trans);
> > 
> 
> Reviewed-by: Anand Jain <anand.jain@oracle.com>
> 
> Nit.
> It is better call btrfs_release_path() before the comments which belongs 
> to the btrfs_start_transaction() as shown below.
> No need to send a reroll. Maybe David could tweak it during the integration.

I agree placing it before the transaction comment is more appropriate
and given that it's not so obvious why the release is done I'd put a
comment like

/*
 * Release path before starting a new transaction so we don't hold locks
 * that would confuse lockdep
 */
