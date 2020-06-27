Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35B3B20BDC6
	for <lists+linux-btrfs@lfdr.de>; Sat, 27 Jun 2020 04:45:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726594AbgF0Cpa (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 26 Jun 2020 22:45:30 -0400
Received: from james.kirk.hungrycats.org ([174.142.39.145]:42390 "EHLO
        james.kirk.hungrycats.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725992AbgF0Cpa (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 26 Jun 2020 22:45:30 -0400
Received: by james.kirk.hungrycats.org (Postfix, from userid 1002)
        id 0A5327358FD; Fri, 26 Jun 2020 22:45:27 -0400 (EDT)
Date:   Fri, 26 Jun 2020 22:45:26 -0400
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     linux-btrfs@vger.kernel.org
Subject: Lockdep splat on 5.4.43 with mmap file writers
Message-ID: <20200627024526.GV10769@hungrycats.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

A process that does writes through mmap()ped files hits a lockdep splat
fairly early in almost every boot on 5.4.x kernels:

        [ 2584.231624][ T3865] 
        [ 2584.231630][ T3865] ======================================================
        [ 2584.231632][ T3865] WARNING: possible circular locking dependency detected
        [ 2584.231635][ T3865] 5.4.41-zb64-4b623f143c7c+ #1 Not tainted
        [ 2584.231637][ T3865] ------------------------------------------------------
        [ 2584.231639][ T3865] mmap_writer main/3865 is trying to acquire lock:
        [ 2584.231641][ T3865] ffff988086025520 (&fs_info->reloc_mutex){+.+.}, at: btrfs_record_root_in_trans+0x48/0x70
        [ 2584.231649][ T3865] 
        [ 2584.231649][ T3865] but task is already holding lock:
        [ 2584.231650][ T3865] ffff988097cc75c8 (sb_pagefaults){.+.+}, at: btrfs_page_mkwrite+0x68/0x4f0
        [ 2584.231654][ T3865] 
        [ 2584.231654][ T3865] which lock already depends on the new lock.
        [ 2584.231654][ T3865] 
        [ 2584.231656][ T3865] 
        [ 2584.231656][ T3865] the existing dependency chain (in reverse order) is:
        [ 2584.231658][ T3865] 
        [ 2584.231658][ T3865] -> #9 (sb_pagefaults){.+.+}:
        [ 2584.231663][ T3865]        __sb_start_write+0x158/0x240
        [ 2584.231666][ T3865]        btrfs_page_mkwrite+0x68/0x4f0
        [ 2584.231669][ T3865]        do_page_mkwrite+0x57/0xd0
        [ 2584.231672][ T3865]        __handle_mm_fault+0xe4e/0x12f0
        [ 2584.231674][ T3865]        handle_mm_fault+0x173/0x360
        [ 2584.231677][ T3865]        __do_page_fault+0x263/0x510
        [ 2584.231679][ T3865]        do_page_fault+0x2c/0x1c0
        [ 2584.231683][ T3865]        page_fault+0x39/0x40
        [ 2584.231684][ T3865] 
        [ 2584.231684][ T3865] -> #8 (&mm->mmap_sem#2){++++}:
        [ 2584.231690][ T3865]        down_write+0x49/0x120
        [ 2584.231693][ T3865]        mpol_rebind_mm+0x23/0x60
        [ 2584.231697][ T3865]        cpuset_attach+0x139/0x1f0
        [ 2584.231699][ T3865]        cgroup_migrate_execute+0x3de/0x490
        [ 2584.231702][ T3865]        cgroup_migrate+0xd0/0x140
        [ 2584.231704][ T3865]        cgroup_attach_task+0x2d3/0x410
        [ 2584.231706][ T3865]        __cgroup1_procs_write.constprop.17+0xf1/0x150
        [ 2584.231708][ T3865]        cgroup1_tasks_write+0x10/0x20
        [ 2584.231711][ T3865]        cgroup_file_write+0x99/0x230
        [ 2584.231714][ T3865]        kernfs_fop_write+0xe8/0x1c0
        [ 2584.231717][ T3865]        __vfs_write+0x1b/0x40
        [ 2584.231719][ T3865]        vfs_write+0xc0/0x1e0
        [ 2584.231721][ T3865]        ksys_write+0x67/0xe0
        [ 2584.231723][ T3865]        __x64_sys_write+0x1a/0x20
        [ 2584.231726][ T3865]        do_syscall_64+0x5f/0x1f0
        [ 2584.231728][ T3865]        entry_SYSCALL_64_after_hwframe+0x49/0xbe
        [ 2584.231729][ T3865] 
        [ 2584.231729][ T3865] -> #7 (&cpuset_rwsem){++++}:
        [ 2584.231733][ T3865]        cpuset_read_lock+0x42/0xc0
        [ 2584.231736][ T3865]        __sched_setscheduler+0x56c/0xab0
        [ 2584.231739][ T3865]        _sched_setscheduler+0x64/0x90
        [ 2584.231741][ T3865]        sched_setscheduler_nocheck+0x10/0x20
        [ 2584.231743][ T3865]        __kthread_create_on_node+0x18a/0x1d0
        [ 2584.231746][ T3865]        kthread_create_on_node+0x49/0x60
        [ 2584.231748][ T3865]        create_worker+0xcc/0x1a0
        [ 2584.231751][ T3865]        workqueue_prepare_cpu+0x3e/0x80
        [ 2584.231753][ T3865]        cpuhp_invoke_callback+0xb4/0x910
        [ 2584.231755][ T3865]        _cpu_up+0xaf/0x150
        [ 2584.231757][ T3865]        do_cpu_up+0x85/0xc0
        [ 2584.231758][ T3865]        cpu_up+0x13/0x20
        [ 2584.231761][ T3865]        smp_init+0x61/0xb6
        [ 2584.231764][ T3865]        kernel_init_freeable+0x14c/0x27a
        [ 2584.231766][ T3865]        kernel_init+0xe/0x103
        [ 2584.231768][ T3865]        ret_from_fork+0x27/0x50
        [ 2584.231769][ T3865] 
        [ 2584.231769][ T3865] -> #6 (cpu_hotplug_lock.rw_sem){++++}:
        [ 2584.231773][ T3865]        cpus_read_lock+0x42/0xc0
        [ 2584.231775][ T3865]        kmem_cache_create_usercopy+0x2d/0x230
        [ 2584.231778][ T3865]        kmem_cache_create+0x16/0x20
        [ 2584.231781][ T3865]        bioset_init+0x162/0x2c0
        [ 2584.231784][ T3865]        init_bio+0xad/0xd9
        [ 2584.231787][ T3865]        do_one_initcall+0x61/0x2ea
        [ 2584.231789][ T3865]        kernel_init_freeable+0x1e9/0x27a
        [ 2584.231791][ T3865]        kernel_init+0xe/0x103
        [ 2584.231793][ T3865]        ret_from_fork+0x27/0x50
        [ 2584.231794][ T3865] 
        [ 2584.231794][ T3865] -> #5 (bio_slab_lock){+.+.}:
        [ 2584.231797][ T3865]        __mutex_lock+0xa1/0x9f0
        [ 2584.231800][ T3865]        mutex_lock_nested+0x1b/0x20
        [ 2584.231802][ T3865]        bioset_init+0xba/0x2c0
        [ 2584.231805][ T3865]        blk_alloc_queue_node+0x7c/0x2e0
        [ 2584.231807][ T3865]        blk_mq_init_queue+0x20/0x70
        [ 2584.231813][ T3865]        nbd_dev_add+0x164/0x2e0 [nbd]
        [ 2584.231816][ T3865]        soundcore_open+0x1bc/0x240 [soundcore]
        [ 2584.231819][ T3865]        do_one_initcall+0x61/0x2ea
        [ 2584.231821][ T3865]        do_init_module+0x60/0x230
        [ 2584.231823][ T3865]        load_module+0x22e4/0x25f0
        [ 2584.231825][ T3865]        __do_sys_finit_module+0xbd/0x120
        [ 2584.231827][ T3865]        __x64_sys_finit_module+0x1a/0x20
        [ 2584.231829][ T3865]        do_syscall_64+0x5f/0x1f0
        [ 2584.231831][ T3865]        entry_SYSCALL_64_after_hwframe+0x49/0xbe
        [ 2584.231832][ T3865] 
        [ 2584.231832][ T3865] -> #4 (nbd_index_mutex){+.+.}:
        [ 2584.231836][ T3865]        __mutex_lock+0xa1/0x9f0
        [ 2584.231838][ T3865]        mutex_lock_nested+0x1b/0x20
        [ 2584.231842][ T3865]        nbd_open+0x21/0x220 [nbd]
        [ 2584.231844][ T3865]        __blkdev_get+0xf0/0x5a0
        [ 2584.231846][ T3865]        blkdev_get+0xe5/0x150
        [ 2584.231848][ T3865]        blkdev_open+0x9f/0xb0
        [ 2584.231850][ T3865]        do_dentry_open+0x155/0x400
        [ 2584.231853][ T3865]        vfs_open+0x2d/0x30
        [ 2584.231855][ T3865]        path_openat+0x310/0xcd0
        [ 2584.231857][ T3865]        do_filp_open+0x93/0x100
        [ 2584.231860][ T3865]        do_sys_open+0x184/0x230
        [ 2584.231862][ T3865]        __x64_sys_openat+0x20/0x30
        [ 2584.231864][ T3865]        do_syscall_64+0x5f/0x1f0
        [ 2584.231867][ T3865]        entry_SYSCALL_64_after_hwframe+0x49/0xbe
        [ 2584.231868][ T3865] 
        [ 2584.231868][ T3865] -> #3 (&bdev->bd_mutex){+.+.}:
        [ 2584.231871][ T3865]        __mutex_lock+0xa1/0x9f0
        [ 2584.231873][ T3865]        mutex_lock_nested+0x1b/0x20
        [ 2584.231875][ T3865]        __blkdev_get+0x7d/0x5a0
        [ 2584.231877][ T3865]        blkdev_get+0x6b/0x150
        [ 2584.231879][ T3865]        blkdev_get_by_path+0x4d/0x90
        [ 2584.231882][ T3865]        btrfs_get_bdev_and_sb+0x20/0xb0
        [ 2584.231884][ T3865]        open_fs_devices+0x87/0x2a0
        [ 2584.231886][ T3865]        btrfs_open_devices+0x95/0xa0
        [ 2584.231889][ T3865]        btrfs_mount_root+0x2e8/0x6c0
        [ 2584.231892][ T3865]        legacy_get_tree+0x34/0x60
        [ 2584.231894][ T3865]        vfs_get_tree+0x2d/0xc0
        [ 2584.231896][ T3865]        fc_mount+0x12/0x40
        [ 2584.231898][ T3865]        vfs_kern_mount.part.37+0x61/0xa0
        [ 2584.231901][ T3865]        vfs_kern_mount+0x13/0x20
        [ 2584.231903][ T3865]        btrfs_mount+0x16f/0x850
        [ 2584.231905][ T3865]        legacy_get_tree+0x34/0x60
        [ 2584.231907][ T3865]        vfs_get_tree+0x2d/0xc0
        [ 2584.231909][ T3865]        do_mount+0x899/0xa50
        [ 2584.231911][ T3865]        ksys_mount+0xb6/0xd0
        [ 2584.231914][ T3865]        __x64_sys_mount+0x25/0x30
        [ 2584.231916][ T3865]        do_syscall_64+0x5f/0x1f0
        [ 2584.231918][ T3865]        entry_SYSCALL_64_after_hwframe+0x49/0xbe
        [ 2584.231920][ T3865] 
        [ 2584.231920][ T3865] -> #2 (&fs_devs->device_list_mutex){+.+.}:
        [ 2584.231923][ T3865]        __mutex_lock+0xa1/0x9f0
        [ 2584.231925][ T3865]        mutex_lock_nested+0x1b/0x20
        [ 2584.231928][ T3865]        btrfs_run_dev_stats+0x46/0x470
        [ 2584.231930][ T3865]        commit_cowonly_roots+0xb0/0x2f0
        [ 2584.231932][ T3865]        btrfs_commit_transaction+0x50e/0xa70
        [ 2584.231934][ T3865]        btrfs_sync_fs+0xcb/0x1b0
        [ 2584.231936][ T3865]        sync_filesystem+0x76/0x90
        [ 2584.231939][ T3865]        btrfs_remount+0x8c/0x490
        [ 2584.231941][ T3865]        legacy_reconfigure+0x42/0x50
        [ 2584.231943][ T3865]        reconfigure_super+0xa8/0x230
        [ 2584.231945][ T3865]        do_mount+0x972/0xa50
        [ 2584.231947][ T3865]        ksys_mount+0xb6/0xd0
        [ 2584.231950][ T3865]        __x64_sys_mount+0x25/0x30
        [ 2584.231952][ T3865]        do_syscall_64+0x5f/0x1f0
        [ 2584.231954][ T3865]        entry_SYSCALL_64_after_hwframe+0x49/0xbe
        [ 2584.231955][ T3865] 
        [ 2584.231955][ T3865] -> #1 (&fs_info->tree_log_mutex){+.+.}:
        [ 2584.231959][ T3865]        __mutex_lock+0xa1/0x9f0
        [ 2584.231961][ T3865]        mutex_lock_nested+0x1b/0x20
        [ 2584.231963][ T3865]        btrfs_commit_transaction+0x4b3/0xa70
        [ 2584.231966][ T3865]        btrfs_sync_fs+0xcb/0x1b0
        [ 2584.231968][ T3865]        sync_filesystem+0x76/0x90
        [ 2584.231970][ T3865]        btrfs_remount+0x8c/0x490
        [ 2584.231972][ T3865]        legacy_reconfigure+0x42/0x50
        [ 2584.231974][ T3865]        reconfigure_super+0xa8/0x230
        [ 2584.231977][ T3865]        do_mount+0x972/0xa50
        [ 2584.231979][ T3865]        ksys_mount+0xb6/0xd0
        [ 2584.231981][ T3865]        __x64_sys_mount+0x25/0x30
        [ 2584.231983][ T3865]        do_syscall_64+0x5f/0x1f0
        [ 2584.231985][ T3865]        entry_SYSCALL_64_after_hwframe+0x49/0xbe
        [ 2584.231986][ T3865] 
        [ 2584.231986][ T3865] -> #0 (&fs_info->reloc_mutex){+.+.}:
        [ 2584.231991][ T3865]        __lock_acquire+0xfed/0x1760
        [ 2584.231993][ T3865]        lock_acquire+0xbd/0x1a0
        [ 2584.231995][ T3865]        __mutex_lock+0xa1/0x9f0
        [ 2584.231997][ T3865]        mutex_lock_nested+0x1b/0x20
        [ 2584.232000][ T3865]        btrfs_record_root_in_trans+0x48/0x70
        [ 2584.232002][ T3865]        start_transaction+0xb7/0x510
        [ 2584.232004][ T3865]        btrfs_join_transaction+0x1d/0x20
        [ 2584.232006][ T3865]        btrfs_dirty_inode+0x4b/0xe0
        [ 2584.232008][ T3865]        btrfs_update_time+0x78/0xd0
        [ 2584.232011][ T3865]        file_update_time+0xe1/0x130
        [ 2584.232013][ T3865]        btrfs_page_mkwrite+0xf8/0x4f0
        [ 2584.232015][ T3865]        do_page_mkwrite+0x57/0xd0
        [ 2584.232018][ T3865]        __handle_mm_fault+0xe4e/0x12f0
        [ 2584.232020][ T3865]        handle_mm_fault+0x173/0x360
        [ 2584.232022][ T3865]        __do_page_fault+0x263/0x510
        [ 2584.232024][ T3865]        do_page_fault+0x2c/0x1c0
        [ 2584.232026][ T3865]        page_fault+0x39/0x40
        [ 2584.232027][ T3865] 
        [ 2584.232027][ T3865] other info that might help us debug this:
        [ 2584.232027][ T3865] 
        [ 2584.232028][ T3865] Chain exists of:
        [ 2584.232028][ T3865]   &fs_info->reloc_mutex --> &mm->mmap_sem#2 --> sb_pagefaults
        [ 2584.232028][ T3865] 
        [ 2584.232032][ T3865]  Possible unsafe locking scenario:
        [ 2584.232032][ T3865] 
        [ 2584.232033][ T3865]        CPU0                    CPU1
        [ 2584.232034][ T3865]        ----                    ----
        [ 2584.232036][ T3865]   lock(sb_pagefaults);
        [ 2584.232038][ T3865]                                lock(&mm->mmap_sem#2);
        [ 2584.232040][ T3865]                                lock(sb_pagefaults);
        [ 2584.232041][ T3865]   lock(&fs_info->reloc_mutex);
        [ 2584.232043][ T3865] 
        [ 2584.232043][ T3865]  *** DEADLOCK ***
        [ 2584.232043][ T3865] 
        [ 2584.232045][ T3865] 3 locks held by mmap_writer main/3865:
        [ 2584.232047][ T3865]  #0: ffff987ff449b138 (&mm->mmap_sem#2){++++}, at: __do_page_fault+0x44b/0x510
        [ 2584.232050][ T3865]  #1: ffff988097cc75c8 (sb_pagefaults){.+.+}, at: btrfs_page_mkwrite+0x68/0x4f0
        [ 2584.232054][ T3865]  #2: ffff988097cc76f8 (sb_internal){.+.+}, at: start_transaction+0x361/0x510
        [ 2584.232058][ T3865] 
        [ 2584.232058][ T3865] stack backtrace:
        [ 2584.232061][ T3865] CPU: 1 PID: 3865 Comm: mmap_writer main Not tainted 5.4.41-zb64-4b623f143c7c+ #1
        [ 2584.232063][ T3865] Hardware name: System manufacturer System Product Name/A55BM-E, BIOS 1302 01/20/2014
        [ 2584.232064][ T3865] Call Trace:
        [ 2584.232069][ T3865]  dump_stack+0x98/0xda
        [ 2584.232072][ T3865]  print_circular_bug.isra.40.cold.57+0x13c/0x141
        [ 2584.232075][ T3865]  check_noncircular+0x19a/0x1b0
        [ 2584.232079][ T3865]  __lock_acquire+0xfed/0x1760
        [ 2584.232083][ T3865]  lock_acquire+0xbd/0x1a0
        [ 2584.232086][ T3865]  ? btrfs_record_root_in_trans+0x48/0x70
        [ 2584.232089][ T3865]  ? btrfs_record_root_in_trans+0x48/0x70
        [ 2584.232092][ T3865]  __mutex_lock+0xa1/0x9f0
        [ 2584.232095][ T3865]  ? btrfs_record_root_in_trans+0x48/0x70
        [ 2584.232097][ T3865]  ? find_held_lock+0x3c/0xb0
        [ 2584.232100][ T3865]  ? find_held_lock+0x3c/0xb0
        [ 2584.232103][ T3865]  ? sched_clock+0x9/0x10
        [ 2584.232106][ T3865]  ? join_transaction+0x113/0x440
        [ 2584.232110][ T3865]  mutex_lock_nested+0x1b/0x20
        [ 2584.232113][ T3865]  ? join_transaction+0x113/0x440
        [ 2584.232115][ T3865]  ? mutex_lock_nested+0x1b/0x20
        [ 2584.232118][ T3865]  btrfs_record_root_in_trans+0x48/0x70
        [ 2584.232120][ T3865]  start_transaction+0xb7/0x510
        [ 2584.232124][ T3865]  ? trace_raw_output_preemptirq_template+0x40/0x60
        [ 2584.232127][ T3865]  btrfs_join_transaction+0x1d/0x20
        [ 2584.232130][ T3865]  btrfs_dirty_inode+0x4b/0xe0
        [ 2584.232133][ T3865]  btrfs_update_time+0x78/0xd0
        [ 2584.232135][ T3865]  file_update_time+0xe1/0x130
        [ 2584.232139][ T3865]  btrfs_page_mkwrite+0xf8/0x4f0
        [ 2584.232142][ T3865]  ? lockdep_init_map+0x4a/0x1f0
        [ 2584.232145][ T3865]  do_page_mkwrite+0x57/0xd0
        [ 2584.232148][ T3865]  __handle_mm_fault+0xe4e/0x12f0
        [ 2584.232153][ T3865]  handle_mm_fault+0x173/0x360
        [ 2584.232156][ T3865]  __do_page_fault+0x263/0x510
        [ 2584.232159][ T3865]  do_page_fault+0x2c/0x1c0
        [ 2584.232162][ T3865]  page_fault+0x39/0x40
        [ 2584.232165][ T3865] RIP: 0033:0x7f4c291fb8d8
        [ 2584.232169][ T3865] Code: 89 5f ed 48 89 4f f5 89 57 fc c3 0f 1f 80 00 00 00 00 f3 0f 6f 46 cd 4c 8b 4e dd 4c 8b 56 e5 4c 8b 5e ed 48 8b 4e f5 8b 56 fc <f3> 0f 7f 47 cd 4c 89 4f dd 4c 89 57 e5 4c 89 5f ed 48 89 4f f5 89
        [ 2584.232171][ T3865] RSP: 002b:00007ffee6e86328 EFLAGS: 00010207
        [ 2584.232174][ T3865] RAX: 00007f4c1f000000 RBX: 0000000000000033 RCX: 2f10a9338c6f9c77
        [ 2584.232176][ T3865] RDX: 000000005cbc222f RSI: 000055e3b1e4ee90 RDI: 00007f4c1f000033
        [ 2584.232177][ T3865] RBP: 000055e3b19f8e50 R08: 00007ffee6e86450 R09: d4743a666b2538d9
        [ 2584.232179][ T3865] R10: 97d88d17d9fd01b2 R11: dd48569c9d61b4d3 R12: 0000000000000000
        [ 2584.232181][ T3865] R13: 000055e3b1e4ee5d R14: 000055e3b1e6e210 R15: 00007ffee6e86588

