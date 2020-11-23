Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB15D2C0FC2
	for <lists+linux-btrfs@lfdr.de>; Mon, 23 Nov 2020 17:13:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389866AbgKWQG4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 23 Nov 2020 11:06:56 -0500
Received: from mx2.suse.de ([195.135.220.15]:55234 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387403AbgKWQG4 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 23 Nov 2020 11:06:56 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id B18FBAEBE;
        Mon, 23 Nov 2020 16:06:54 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 7CB7EDA818; Mon, 23 Nov 2020 17:05:06 +0100 (CET)
Date:   Mon, 23 Nov 2020 17:05:06 +0100
From:   David Sterba <dsterba@suse.cz>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: fix lockdep splat when reading qgroup config on
 mount
Message-ID: <20201123160506.GD8669@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, fdmanana@kernel.org,
        linux-btrfs@vger.kernel.org
References: <0343c1f0b12747805d837106ada99e10468363b6.1606141632.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0343c1f0b12747805d837106ada99e10468363b6.1606141632.git.fdmanana@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Nov 23, 2020 at 02:28:44PM +0000, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> Lockdep reported the following splat when running test btrfs/190 from
> fstests:
> 
> [ 9482.126098] ======================================================
> [ 9482.126184] WARNING: possible circular locking dependency detected
> [ 9482.126281] 5.10.0-rc4-btrfs-next-73 #1 Not tainted
> [ 9482.126365] ------------------------------------------------------
> [ 9482.126456] mount/24187 is trying to acquire lock:
> [ 9482.126534] ffffa0c869a7dac0 (&fs_info->qgroup_rescan_lock){+.+.}-{3:3}, at: qgroup_rescan_init+0x43/0xf0 [btrfs]
> [ 9482.126647]
>                but task is already holding lock:
> [ 9482.126777] ffffa0c892ebd3a0 (btrfs-quota-00){++++}-{3:3}, at: __btrfs_tree_read_lock+0x27/0x120 [btrfs]
> [ 9482.126886]
>                which lock already depends on the new lock.
> 
> [ 9482.127078]
>                the existing dependency chain (in reverse order) is:
> [ 9482.127213]
>                -> #1 (btrfs-quota-00){++++}-{3:3}:
> [ 9482.127366]        lock_acquire+0xd8/0x490
> [ 9482.127436]        down_read_nested+0x45/0x220
> [ 9482.127528]        __btrfs_tree_read_lock+0x27/0x120 [btrfs]
> [ 9482.127613]        btrfs_read_lock_root_node+0x41/0x130 [btrfs]
> [ 9482.127702]        btrfs_search_slot+0x514/0xc30 [btrfs]
> [ 9482.127788]        update_qgroup_status_item+0x72/0x140 [btrfs]
> [ 9482.127877]        btrfs_qgroup_rescan_worker+0xde/0x680 [btrfs]
> [ 9482.127964]        btrfs_work_helper+0xf1/0x600 [btrfs]
> [ 9482.128039]        process_one_work+0x24e/0x5e0
> [ 9482.128110]        worker_thread+0x50/0x3b0
> [ 9482.128181]        kthread+0x153/0x170
> [ 9482.128256]        ret_from_fork+0x22/0x30
> [ 9482.128327]
>                -> #0 (&fs_info->qgroup_rescan_lock){+.+.}-{3:3}:
> [ 9482.128464]        check_prev_add+0x91/0xc60
> [ 9482.128551]        __lock_acquire+0x1740/0x3110
> [ 9482.128623]        lock_acquire+0xd8/0x490
> [ 9482.130029]        __mutex_lock+0xa3/0xb30
> [ 9482.130590]        qgroup_rescan_init+0x43/0xf0 [btrfs]
> [ 9482.131577]        btrfs_read_qgroup_config+0x43a/0x550 [btrfs]
> [ 9482.132175]        open_ctree+0x1228/0x18a0 [btrfs]
> [ 9482.132756]        btrfs_mount_root.cold+0x13/0xed [btrfs]
> [ 9482.133325]        legacy_get_tree+0x30/0x60
> [ 9482.133866]        vfs_get_tree+0x28/0xe0
> [ 9482.134392]        fc_mount+0xe/0x40
> [ 9482.134908]        vfs_kern_mount.part.0+0x71/0x90
> [ 9482.135428]        btrfs_mount+0x13b/0x3e0 [btrfs]
> [ 9482.135942]        legacy_get_tree+0x30/0x60
> [ 9482.136444]        vfs_get_tree+0x28/0xe0
> [ 9482.136949]        path_mount+0x2d7/0xa70
> [ 9482.137438]        do_mount+0x75/0x90
> [ 9482.137923]        __x64_sys_mount+0x8e/0xd0
> [ 9482.138400]        do_syscall_64+0x33/0x80
> [ 9482.138873]        entry_SYSCALL_64_after_hwframe+0x44/0xa9
> [ 9482.139346]
>                other info that might help us debug this:
> 
> [ 9482.140735]  Possible unsafe locking scenario:
> 
> [ 9482.141594]        CPU0                    CPU1
> [ 9482.142011]        ----                    ----
> [ 9482.142411]   lock(btrfs-quota-00);
> [ 9482.142806]                                lock(&fs_info->qgroup_rescan_lock);
> [ 9482.143216]                                lock(btrfs-quota-00);
> [ 9482.143629]   lock(&fs_info->qgroup_rescan_lock);
> [ 9482.144056]
>                 *** DEADLOCK ***
> 
> [ 9482.145242] 2 locks held by mount/24187:
> [ 9482.145637]  #0: ffffa0c8411c40e8 (&type->s_umount_key#44/1){+.+.}-{3:3}, at: alloc_super+0xb9/0x400
> [ 9482.146061]  #1: ffffa0c892ebd3a0 (btrfs-quota-00){++++}-{3:3}, at: __btrfs_tree_read_lock+0x27/0x120 [btrfs]
> [ 9482.146509]
>                stack backtrace:
> [ 9482.147350] CPU: 1 PID: 24187 Comm: mount Not tainted 5.10.0-rc4-btrfs-next-73 #1
> [ 9482.147788] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.13.0-0-gf21b5a4aeb02-prebuilt.qemu.org 04/01/2014
> [ 9482.148709] Call Trace:
> [ 9482.149169]  dump_stack+0x8d/0xb5
> [ 9482.149628]  check_noncircular+0xff/0x110
> [ 9482.150090]  check_prev_add+0x91/0xc60
> [ 9482.150561]  ? kvm_clock_read+0x14/0x30
> [ 9482.151017]  ? kvm_sched_clock_read+0x5/0x10
> [ 9482.151470]  __lock_acquire+0x1740/0x3110
> [ 9482.151941]  ? __btrfs_tree_read_lock+0x27/0x120 [btrfs]
> [ 9482.152402]  lock_acquire+0xd8/0x490
> [ 9482.152887]  ? qgroup_rescan_init+0x43/0xf0 [btrfs]
> [ 9482.153354]  __mutex_lock+0xa3/0xb30
> [ 9482.153826]  ? qgroup_rescan_init+0x43/0xf0 [btrfs]
> [ 9482.154301]  ? qgroup_rescan_init+0x43/0xf0 [btrfs]
> [ 9482.154768]  ? qgroup_rescan_init+0x43/0xf0 [btrfs]
> [ 9482.155226]  qgroup_rescan_init+0x43/0xf0 [btrfs]
> [ 9482.155690]  btrfs_read_qgroup_config+0x43a/0x550 [btrfs]
> [ 9482.156160]  open_ctree+0x1228/0x18a0 [btrfs]
> [ 9482.156643]  btrfs_mount_root.cold+0x13/0xed [btrfs]
> [ 9482.157108]  ? rcu_read_lock_sched_held+0x5d/0x90
> [ 9482.157567]  ? kfree+0x31f/0x3e0
> [ 9482.158030]  legacy_get_tree+0x30/0x60
> [ 9482.158489]  vfs_get_tree+0x28/0xe0
> [ 9482.158947]  fc_mount+0xe/0x40
> [ 9482.159403]  vfs_kern_mount.part.0+0x71/0x90
> [ 9482.159875]  btrfs_mount+0x13b/0x3e0 [btrfs]
> [ 9482.160335]  ? rcu_read_lock_sched_held+0x5d/0x90
> [ 9482.160805]  ? kfree+0x31f/0x3e0
> [ 9482.161260]  ? legacy_get_tree+0x30/0x60
> [ 9482.161714]  legacy_get_tree+0x30/0x60
> [ 9482.162166]  vfs_get_tree+0x28/0xe0
> [ 9482.162616]  path_mount+0x2d7/0xa70
> [ 9482.163070]  do_mount+0x75/0x90
> [ 9482.163525]  __x64_sys_mount+0x8e/0xd0
> [ 9482.163986]  do_syscall_64+0x33/0x80
> [ 9482.164437]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> [ 9482.164902] RIP: 0033:0x7f51e907caaa
> 
> This happens because at btrfs_read_qgroup_config() we can call
> qgroup_rescan_init() while holding a read lock on a quota btree leaf,
> acquired by the previous call to btrfs_search_slot_for_read(), and
> qgroup_rescan_init() acquires the mutex qgroup_rescan_lock.
> 
> A qgroup rescan worker does the opposite: it acquires the mutex
> qgroup_rescan_lock, at btrfs_qgroup_rescan_worker(), and then tries to
> update the qgroup status item in the quota btree through the call to
> update_qgroup_status_item(). This inversion of locking order
> between the qgroup_rescan_lock mutex and quota btree locks causes the
> splat.
> 
> Fix this simply by releasing and freeing the path before calling
> qgroup_rescan_init() at btrfs_read_qgroup_config().
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Added to misc-next, thanks.
