Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D465C1CF6D5
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 May 2020 16:16:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730325AbgELOQm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 12 May 2020 10:16:42 -0400
Received: from mx2.suse.de ([195.135.220.15]:38434 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729773AbgELOQm (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 12 May 2020 10:16:42 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id EAB97B221
        for <linux-btrfs@vger.kernel.org>; Tue, 12 May 2020 14:16:42 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 910C7DA70B; Tue, 12 May 2020 16:15:46 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: Bug 5.7-rc: lockdep warning, chunk_mutex/device_list_mutex
Date:   Tue, 12 May 2020 16:15:46 +0200
Message-Id: <52b6ff4c2da5838393f5bd754310cfa6abcfcc7b3efb3c63c8d95824cb163d6d.dsterba@suse.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <5e955017351005f2cc4c0210f401935203de8496c56cb76f53547d435f502803.dsterba@suse.com>
References: 
MIME-Version: 1.0
Reference: <5e955017351005f2cc4c0210f401935203de8496c56cb76f53547d435f502803.dsterba@suse.com>
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

lockdep warning chunk_mutex vs device_list_mutex reversed during device
initialization. Reported once.

btrfs/161               [12:40:04][ 5172.154390] run fstests btrfs/161 at 2020-05-04 12:40:04
[ 5172.813371] BTRFS info (device vda): disk space caching is enabled
[ 5172.816196] BTRFS info (device vda): has skinny extents
[ 5173.611139] BTRFS: device fsid 812499c4-c1e2-4bb6-9234-efd07fac3aa1 devid 1 transid 5 /dev/vdb scanned by mkfs.btrfs (30700)
[ 5173.662731] BTRFS info (device vdb): disk space caching is enabled
[ 5173.664889] BTRFS info (device vdb): has skinny extents
[ 5173.666818] BTRFS info (device vdb): flagging fs with big metadata feature
[ 5173.682918] BTRFS info (device vdb): checking UUID tree
[ 5173.944065] BTRFS info (device vdb): disk space caching is enabled
[ 5173.946692] BTRFS info (device vdb): has skinny extents
[ 5174.036719] BTRFS info (device vdb): relocating block group 567279616 flags system|dup
[ 5174.075460] BTRFS info (device vdb): relocating block group 22020096 flags system|dup
[ 5174.118369] BTRFS info (device vdb): disk added /dev/vdc
[ 5174.250287] BTRFS info (device vdc): disk space caching is enabled
[ 5174.252235] BTRFS info (device vdc): has skinny extents
[ 5174.259812] 
[ 5174.260641] ======================================================
[ 5174.262652] WARNING: possible circular locking dependency detected
[ 5174.264662] 5.7.0-rc3-default+ #1094 Not tainted
[ 5174.266245] ------------------------------------------------------
[ 5174.268215] mount/30761 is trying to acquire lock:
[ 5174.269838] ffff8d950e4164e8 (&fs_devs->device_list_mutex){+.+.}-{3:3}, at: clone_fs_devices+0x3f/0x170 [btrfs]
[ 5174.272880] 
[ 5174.272880] but task is already holding lock:
[ 5174.275081] ffff8d952ae80980 (&fs_info->chunk_mutex){+.+.}-{3:3}, at: btrfs_read_chunk_tree+0x5a/0x2a0 [btrfs]
[ 5174.278232] 
[ 5174.278232] which lock already depends on the new lock.
[ 5174.278232] 
[ 5174.281372] 
[ 5174.281372] the existing dependency chain (in reverse order) is:
[ 5174.283784] 
[ 5174.283784] -> #1 (&fs_info->chunk_mutex){+.+.}-{3:3}:
[ 5174.286134]        __lock_acquire+0x581/0xae0
[ 5174.287563]        lock_acquire+0xa3/0x400
[ 5174.289033]        __mutex_lock+0xa0/0xaf0
[ 5174.290488]        btrfs_init_new_device+0x316/0x12f0 [btrfs]
[ 5174.292209]        btrfs_ioctl+0xc3c/0x2590 [btrfs]
[ 5174.293673]        ksys_ioctl+0x68/0xa0
[ 5174.294883]        __x64_sys_ioctl+0x16/0x20
[ 5174.296231]        do_syscall_64+0x50/0x210
[ 5174.297548]        entry_SYSCALL_64_after_hwframe+0x49/0xb3
[ 5174.299278] 
[ 5174.299278] -> #0 (&fs_devs->device_list_mutex){+.+.}-{3:3}:
[ 5174.301760]        check_prev_add+0x98/0xa20
[ 5174.303219]        validate_chain+0xa6c/0x29e0
[ 5174.304770]        __lock_acquire+0x581/0xae0
[ 5174.306274]        lock_acquire+0xa3/0x400
[ 5174.307716]        __mutex_lock+0xa0/0xaf0
[ 5174.309145]        clone_fs_devices+0x3f/0x170 [btrfs]
[ 5174.310757]        read_one_dev+0xc4/0x500 [btrfs]
[ 5174.312293]        btrfs_read_chunk_tree+0x202/0x2a0 [btrfs]
[ 5174.313946]        open_ctree+0x7a3/0x10db [btrfs]
[ 5174.315411]        btrfs_mount_root.cold+0xe/0xcc [btrfs]
[ 5174.317122]        legacy_get_tree+0x2d/0x60
[ 5174.318543]        vfs_get_tree+0x1d/0xb0
[ 5174.319844]        fc_mount+0xe/0x40
[ 5174.321122]        vfs_kern_mount.part.0+0x71/0x90
[ 5174.322688]        btrfs_mount+0x147/0x3e0 [btrfs]
[ 5174.324250]        legacy_get_tree+0x2d/0x60
[ 5174.325644]        vfs_get_tree+0x1d/0xb0
[ 5174.326978]        do_mount+0x7d5/0xa40
[ 5174.328294]        __x64_sys_mount+0x8e/0xd0
[ 5174.329829]        do_syscall_64+0x50/0x210
[ 5174.331260]        entry_SYSCALL_64_after_hwframe+0x49/0xb3
[ 5174.333102] 
[ 5174.333102] other info that might help us debug this:
[ 5174.333102] 
[ 5174.335988]  Possible unsafe locking scenario:
[ 5174.335988] 
[ 5174.338051]        CPU0                    CPU1
[ 5174.339490]        ----                    ----
[ 5174.340810]   lock(&fs_info->chunk_mutex);
[ 5174.342203]                                lock(&fs_devs->device_list_mutex);
[ 5174.344228]                                lock(&fs_info->chunk_mutex);
[ 5174.346161]   lock(&fs_devs->device_list_mutex);
[ 5174.347666] 
[ 5174.347666]  *** DEADLOCK ***
[ 5174.347666] 
[ 5174.350257] 3 locks held by mount/30761:
[ 5174.351558]  #0: ffff8d95358310e8 (&type->s_umount_key#24/1){+.+.}-{3:3}, at: alloc_super.isra.0+0xb3/0x3f0
[ 5174.354620]  #1: ffffffffc0451c30 (uuid_mutex){+.+.}-{3:3}, at: btrfs_read_chunk_tree+0x50/0x2a0 [btrfs]
[ 5174.357770]  #2: ffff8d952ae80980 (&fs_info->chunk_mutex){+.+.}-{3:3}, at: btrfs_read_chunk_tree+0x5a/0x2a0 [btrfs]
[ 5174.360835] stack backtrace:
[ 5174.371458] CPU: 0 PID: 30761 Comm: mount Not tainted 5.7.0-rc3-default+ #1094
[ 5174.373918] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.12.0-59-gc9ba527-rebuilt.opensuse.org 04/01/2014
[ 5174.377133] Call Trace:
[ 5174.378125]  dump_stack+0x71/0xa0
[ 5174.379316]  check_noncircular+0x16f/0x190
[ 5174.380673]  ? lock_acquire+0xa3/0x400
[ 5174.381938]  check_prev_add+0x98/0xa20
[ 5174.383161]  validate_chain+0xa6c/0x29e0
[ 5174.384481]  ? btrfs_mount+0x146/0x3e0 [btrfs]
[ 5174.385999]  ? ftrace_caller_op_ptr+0xe/0xe
[ 5174.387457]  ? btrfs_mount+0x146/0x3e0 [btrfs]
[ 5174.388965]  __lock_acquire+0x581/0xae0
[ 5174.390325]  lock_acquire+0xa3/0x400
[ 5174.391606]  ? clone_fs_devices+0x3f/0x170 [btrfs]
[ 5174.393146]  __mutex_lock+0xa0/0xaf0
[ 5174.394342]  ? clone_fs_devices+0x3f/0x170 [btrfs]
[ 5174.395906]  ? rcu_read_lock_sched_held+0x5d/0x90
[ 5174.397424]  ? module_assert_mutex_or_preempt+0x14/0x40
[ 5174.399028]  ? __module_address+0x28/0xf0
[ 5174.400422]  ? clone_fs_devices+0x3f/0x170 [btrfs]
[ 5174.401999]  ? static_obj+0x4f/0x60
[ 5174.403208]  ? lockdep_init_map_waits+0x4d/0x200
[ 5174.404749]  ? clone_fs_devices+0x3f/0x170 [btrfs]
[ 5174.406356]  clone_fs_devices+0x3f/0x170 [btrfs]
[ 5174.407863]  read_one_dev+0xc4/0x500 [btrfs]
[ 5174.409270]  btrfs_read_chunk_tree+0x202/0x2a0 [btrfs]
[ 5174.410846]  open_ctree+0x7a3/0x10db [btrfs]
[ 5174.412333]  btrfs_mount_root.cold+0xe/0xcc [btrfs]
[ 5174.413945]  ? vfs_parse_fs_string+0x84/0xb0
[ 5174.415263]  ? rcu_read_lock_sched_held+0x5d/0x90
[ 5174.416728]  ? kfree+0x211/0x3a0
[ 5174.417963]  legacy_get_tree+0x2d/0x60
[ 5174.419382]  vfs_get_tree+0x1d/0xb0
[ 5174.420621]  fc_mount+0xe/0x40
[ 5174.421747]  vfs_kern_mount.part.0+0x71/0x90
[ 5174.423156]  btrfs_mount+0x147/0x3e0 [btrfs]
[ 5174.424552]  ? vfs_parse_fs_string+0x84/0xb0
[ 5174.425943]  ? rcu_read_lock_sched_held+0x5d/0x90
[ 5174.427416]  ? kfree+0x211/0x3a0
[ 5174.428567]  ? legacy_get_tree+0x2d/0x60
[ 5174.429828]  legacy_get_tree+0x2d/0x60
[ 5174.431071]  vfs_get_tree+0x1d/0xb0
[ 5174.432391]  do_mount+0x7d5/0xa40
[ 5174.433673]  ? _copy_from_user+0x6a/0xa0
[ 5174.435045]  ? memdup_user+0x4e/0x90
[ 5174.436279]  __x64_sys_mount+0x8e/0xd0
[ 5174.437581]  do_syscall_64+0x50/0x210
[ 5174.438815]  entry_SYSCALL_64_after_hwframe+0x49/0xb3
[ 5174.440371] RIP: 0033:0x7f9084b35eba
[ 5174.446779] RSP: 002b:00007ffe01ce4178 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
[ 5174.449335] RAX: ffffffffffffffda RBX: 00007ffe01ce42f0 RCX: 00007f9084b35eba
[ 5174.451352] RDX: 00005559ef16dd70 RSI: 00005559ef166bb0 RDI: 00005559ef166b90
[ 5174.453507] RBP: 00005559ef166960 R08: 0000000000000000 R09: 00005559ef166010
[ 5174.455623] R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
[ 5174.457621] R13: 00005559ef166b90 R14: 00005559ef16dd70 R15: 00005559ef166960
