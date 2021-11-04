Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A57D445A7D
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 Nov 2021 20:15:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230442AbhKDTSK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 4 Nov 2021 15:18:10 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:49198 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231825AbhKDTSJ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 4 Nov 2021 15:18:09 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 6BEC3218B8;
        Thu,  4 Nov 2021 19:15:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1636053330;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=EG6z6bn8KSzpT00MfMJYCsr0ggojboWPGYqmpUChkIM=;
        b=hZbki1M7evdUcGJOCcifNqjyjAoKlwHQzH00U1b4YHoVv7YPMkwwTd9TQXA4E2tyTPJNu0
        MHDYtQl6AVmG5hBa4aV2gC5gfanpMQpdb3Ge3Y12/SEbOpsL73T7PfXIi/p2eQBnSlmDP6
        KD5f2/QO/7fZuLxk0tN2GMknXQDdjRE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1636053330;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=EG6z6bn8KSzpT00MfMJYCsr0ggojboWPGYqmpUChkIM=;
        b=GuAntrbQY39jSwvscGnrrr1sCqa2ORoBYmfu2J2u5MJEvAR/HuUDr5Uy0WSyRLYli3pgTx
        YhYMK87lfG66W8Dg==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 645472C14A;
        Thu,  4 Nov 2021 19:15:30 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id E20F5DA735; Thu,  4 Nov 2021 20:14:53 +0100 (CET)
Date:   Thu, 4 Nov 2021 20:14:53 +0100
From:   David Sterba <dsterba@suse.cz>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: silence lockdep when reading chunk tree during
 mount
Message-ID: <20211104191453.GE28560@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, fdmanana@kernel.org,
        linux-btrfs@vger.kernel.org
References: <505a4fbae1d44f4dee2da92be3126872d78c3589.1636029666.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <505a4fbae1d44f4dee2da92be3126872d78c3589.1636029666.git.fdmanana@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Nov 04, 2021 at 12:43:08PM +0000, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> Often some test cases like btrfs/161 trigger lockdep splats that complain
> about possible unsafe lock scenario due to the fact that during mount,
> when reading the chunk tree we end up calling blkdev_get_by_path() while
> holding a read lock on a leaf of the chunk tree. That produces a lockdep
> splat like the following:
> 
> [ 3653.683975] ======================================================
> [ 3653.685148] WARNING: possible circular locking dependency detected
> [ 3653.686301] 5.15.0-rc7-btrfs-next-103 #1 Not tainted
> [ 3653.687239] ------------------------------------------------------
> [ 3653.688400] mount/447465 is trying to acquire lock:
> [ 3653.689320] ffff8c6b0c76e528 (&disk->open_mutex){+.+.}-{3:3}, at: blkdev_get_by_dev.part.0+0xe7/0x320
> [ 3653.691054]
>                but task is already holding lock:
> [ 3653.692155] ffff8c6b0a9f39e0 (btrfs-chunk-00){++++}-{3:3}, at: __btrfs_tree_read_lock+0x24/0x110 [btrfs]
> [ 3653.693978]
>                which lock already depends on the new lock.
> 
> [ 3653.695510]
>                the existing dependency chain (in reverse order) is:
> [ 3653.696915]
>                -> #3 (btrfs-chunk-00){++++}-{3:3}:
> [ 3653.698053]        down_read_nested+0x4b/0x140
> [ 3653.698893]        __btrfs_tree_read_lock+0x24/0x110 [btrfs]
> [ 3653.699988]        btrfs_read_lock_root_node+0x31/0x40 [btrfs]
> [ 3653.701205]        btrfs_search_slot+0x537/0xc00 [btrfs]
> [ 3653.702234]        btrfs_insert_empty_items+0x32/0x70 [btrfs]
> [ 3653.703332]        btrfs_init_new_device+0x563/0x15b0 [btrfs]
> [ 3653.704439]        btrfs_ioctl+0x2110/0x3530 [btrfs]
> [ 3653.705405]        __x64_sys_ioctl+0x83/0xb0
> [ 3653.706215]        do_syscall_64+0x3b/0xc0
> [ 3653.706990]        entry_SYSCALL_64_after_hwframe+0x44/0xae
> [ 3653.708040]
>                -> #2 (sb_internal#2){.+.+}-{0:0}:
> [ 3653.708994]        lock_release+0x13d/0x4a0
> [ 3653.709533]        up_write+0x18/0x160
> [ 3653.710017]        btrfs_sync_file+0x3f3/0x5b0 [btrfs]
> [ 3653.710699]        __loop_update_dio+0xbd/0x170 [loop]
> [ 3653.711360]        lo_ioctl+0x3b1/0x8a0 [loop]
> [ 3653.711929]        block_ioctl+0x48/0x50
> [ 3653.712442]        __x64_sys_ioctl+0x83/0xb0
> [ 3653.712991]        do_syscall_64+0x3b/0xc0
> [ 3653.713519]        entry_SYSCALL_64_after_hwframe+0x44/0xae
> [ 3653.714233]
>                -> #1 (&lo->lo_mutex){+.+.}-{3:3}:
> [ 3653.715026]        __mutex_lock+0x92/0x900
> [ 3653.715648]        lo_open+0x28/0x60 [loop]
> [ 3653.716275]        blkdev_get_whole+0x28/0x90
> [ 3653.716867]        blkdev_get_by_dev.part.0+0x142/0x320
> [ 3653.717537]        blkdev_open+0x5e/0xa0
> [ 3653.718043]        do_dentry_open+0x163/0x390
> [ 3653.718604]        path_openat+0x3f0/0xa80
> [ 3653.719128]        do_filp_open+0xa9/0x150
> [ 3653.719652]        do_sys_openat2+0x97/0x160
> [ 3653.720197]        __x64_sys_openat+0x54/0x90
> [ 3653.720766]        do_syscall_64+0x3b/0xc0
> [ 3653.721285]        entry_SYSCALL_64_after_hwframe+0x44/0xae
> [ 3653.721986]
>                -> #0 (&disk->open_mutex){+.+.}-{3:3}:
> [ 3653.722775]        __lock_acquire+0x130e/0x2210
> [ 3653.723348]        lock_acquire+0xd7/0x310
> [ 3653.723867]        __mutex_lock+0x92/0x900
> [ 3653.724394]        blkdev_get_by_dev.part.0+0xe7/0x320
> [ 3653.725041]        blkdev_get_by_path+0xb8/0xd0
> [ 3653.725614]        btrfs_get_bdev_and_sb+0x1b/0xb0 [btrfs]
> [ 3653.726332]        open_fs_devices+0xd7/0x2c0 [btrfs]
> [ 3653.726999]        btrfs_read_chunk_tree+0x3ad/0x870 [btrfs]
> [ 3653.727739]        open_ctree+0xb8e/0x17bf [btrfs]
> [ 3653.728384]        btrfs_mount_root.cold+0x12/0xde [btrfs]
> [ 3653.729130]        legacy_get_tree+0x30/0x50
> [ 3653.729676]        vfs_get_tree+0x28/0xc0
> [ 3653.730192]        vfs_kern_mount.part.0+0x71/0xb0
> [ 3653.730800]        btrfs_mount+0x11d/0x3a0 [btrfs]
> [ 3653.731427]        legacy_get_tree+0x30/0x50
> [ 3653.731970]        vfs_get_tree+0x28/0xc0
> [ 3653.732486]        path_mount+0x2d4/0xbe0
> [ 3653.732997]        __x64_sys_mount+0x103/0x140
> [ 3653.733560]        do_syscall_64+0x3b/0xc0
> [ 3653.734080]        entry_SYSCALL_64_after_hwframe+0x44/0xae
> [ 3653.734782]
>                other info that might help us debug this:
> 
> [ 3653.735784] Chain exists of:
>                  &disk->open_mutex --> sb_internal#2 --> btrfs-chunk-00
> 
> [ 3653.737123]  Possible unsafe locking scenario:
> 
> [ 3653.737865]        CPU0                    CPU1
> [ 3653.738435]        ----                    ----
> [ 3653.739007]   lock(btrfs-chunk-00);
> [ 3653.739449]                                lock(sb_internal#2);
> [ 3653.740193]                                lock(btrfs-chunk-00);
> [ 3653.740955]   lock(&disk->open_mutex);
> [ 3653.741431]
>                 *** DEADLOCK ***
> 
> [ 3653.742176] 3 locks held by mount/447465:
> [ 3653.742739]  #0: ffff8c6acf85c0e8 (&type->s_umount_key#44/1){+.+.}-{3:3}, at: alloc_super+0xd5/0x3b0
> [ 3653.744114]  #1: ffffffffc0b28f70 (uuid_mutex){+.+.}-{3:3}, at: btrfs_read_chunk_tree+0x59/0x870 [btrfs]
> [ 3653.745563]  #2: ffff8c6b0a9f39e0 (btrfs-chunk-00){++++}-{3:3}, at: __btrfs_tree_read_lock+0x24/0x110 [btrfs]
> [ 3653.747066]
>                stack backtrace:
> [ 3653.747723] CPU: 4 PID: 447465 Comm: mount Not tainted 5.15.0-rc7-btrfs-next-103 #1
> [ 3653.748873] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014
> [ 3653.750592] Call Trace:
> [ 3653.750967]  dump_stack_lvl+0x57/0x72
> [ 3653.751526]  check_noncircular+0xf3/0x110
> [ 3653.752136]  ? stack_trace_save+0x4b/0x70
> [ 3653.752748]  __lock_acquire+0x130e/0x2210
> [ 3653.753356]  lock_acquire+0xd7/0x310
> [ 3653.753898]  ? blkdev_get_by_dev.part.0+0xe7/0x320
> [ 3653.754596]  ? lock_is_held_type+0xe8/0x140
> [ 3653.755125]  ? blkdev_get_by_dev.part.0+0xe7/0x320
> [ 3653.755729]  ? blkdev_get_by_dev.part.0+0xe7/0x320
> [ 3653.756338]  __mutex_lock+0x92/0x900
> [ 3653.756794]  ? blkdev_get_by_dev.part.0+0xe7/0x320
> [ 3653.757400]  ? do_raw_spin_unlock+0x4b/0xa0
> [ 3653.757930]  ? _raw_spin_unlock+0x29/0x40
> [ 3653.758437]  ? bd_prepare_to_claim+0x129/0x150
> [ 3653.758999]  ? trace_module_get+0x2b/0xd0
> [ 3653.759508]  ? try_module_get.part.0+0x50/0x80
> [ 3653.760072]  blkdev_get_by_dev.part.0+0xe7/0x320
> [ 3653.760661]  ? devcgroup_check_permission+0xc1/0x1f0
> [ 3653.761288]  blkdev_get_by_path+0xb8/0xd0
> [ 3653.761797]  btrfs_get_bdev_and_sb+0x1b/0xb0 [btrfs]
> [ 3653.762454]  open_fs_devices+0xd7/0x2c0 [btrfs]
> [ 3653.763055]  ? clone_fs_devices+0x8f/0x170 [btrfs]
> [ 3653.763689]  btrfs_read_chunk_tree+0x3ad/0x870 [btrfs]
> [ 3653.764370]  ? kvm_sched_clock_read+0x14/0x40
> [ 3653.764922]  open_ctree+0xb8e/0x17bf [btrfs]
> [ 3653.765493]  ? super_setup_bdi_name+0x79/0xd0
> [ 3653.766043]  btrfs_mount_root.cold+0x12/0xde [btrfs]
> [ 3653.766780]  ? rcu_read_lock_sched_held+0x3f/0x80
> [ 3653.767488]  ? kfree+0x1f2/0x3c0
> [ 3653.767979]  legacy_get_tree+0x30/0x50
> [ 3653.768548]  vfs_get_tree+0x28/0xc0
> [ 3653.769076]  vfs_kern_mount.part.0+0x71/0xb0
> [ 3653.769718]  btrfs_mount+0x11d/0x3a0 [btrfs]
> [ 3653.770381]  ? rcu_read_lock_sched_held+0x3f/0x80
> [ 3653.771086]  ? kfree+0x1f2/0x3c0
> [ 3653.771574]  legacy_get_tree+0x30/0x50
> [ 3653.772136]  vfs_get_tree+0x28/0xc0
> [ 3653.772673]  path_mount+0x2d4/0xbe0
> [ 3653.773201]  __x64_sys_mount+0x103/0x140
> [ 3653.773793]  do_syscall_64+0x3b/0xc0
> [ 3653.774333]  entry_SYSCALL_64_after_hwframe+0x44/0xae
> [ 3653.775094] RIP: 0033:0x7f648bc45aaa
> 
> This happens because through btrfs_read_chunk_tree(), which is called only
> during mount, ends up acquiring the mutex open_mutex of a block device
> while holding a read lock on a leaf of the chunk tree while other paths
> need to acquire other locks before locking extent buffers of the chunk
> tree.
> 
> Since at mount time when we call btrfs_read_chunk_tree() we know that
> we don't have other tasks running in parallel and modifying the chunk
> tree, we can simply skip locking of chunk tree extent buffers. So do
> that and move the assertion that checks the fs is not yet mounted to the
> top block of btrfs_read_chunk_tree(), with a comment before doing it.
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Added to misc-next, thanks.
