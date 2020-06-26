Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D553A20B002
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Jun 2020 12:46:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728079AbgFZKqo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 26 Jun 2020 06:46:44 -0400
Received: from mx2.suse.de ([195.135.220.15]:58110 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728051AbgFZKqo (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 26 Jun 2020 06:46:44 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 5D30DAC7A;
        Fri, 26 Jun 2020 10:46:41 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 62764DAA08; Fri, 26 Jun 2020 12:46:28 +0200 (CEST)
Date:   Fri, 26 Jun 2020 12:46:28 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: qgroup: add sysfs interface for debug
Message-ID: <20200626104628.GB27795@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20200619015946.65638-1-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200619015946.65638-1-wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

It does not pass even the self tests and qgroup creation:

[   26.275106] Btrfs loaded, crc32c=crc32c-intel, debug=on, integrity-checker=on, ref-verify=on
[   26.278075] BTRFS: selftest: sectorsize: 4096  nodesize: 4096
[   26.279861] BTRFS: selftest: running btrfs free space cache tests
[   26.281735] BTRFS: selftest: running extent only tests
[   26.283317] BTRFS: selftest: running bitmap only tests
[   26.284966] BTRFS: selftest: running bitmap and extent tests
[   26.286842] BTRFS: selftest: running space stealing from bitmap to extent tests
[   26.289587] BTRFS: selftest: running extent buffer operation tests
[   26.291507] BTRFS: selftest: running btrfs_split_item tests
[   26.293401] BTRFS: selftest: running extent I/O tests
[   26.295059] BTRFS: selftest: running find delalloc tests
[   26.475777] BTRFS: selftest: running find_first_clear_extent_bit test
[   26.477812] BTRFS: selftest: running extent buffer bitmap tests
[   26.499493] BTRFS: selftest: running inode tests
[   26.501164] BTRFS: selftest: running btrfs_get_extent tests
[   26.503599] BTRFS: selftest: running hole first btrfs_get_extent test
[   26.505971] BTRFS: selftest: running outstanding_extents tests
[   26.508136] BTRFS: selftest: running qgroup tests
[   26.509820] BTRFS: selftest: running qgroup add/remove tests
[   26.511566] BUG: sleeping function called from invalid context at mm/slab.h:567
[   26.514058] in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 117, name: modprobe
[   26.516671] 2 locks held by modprobe/117:
[   26.517980]  #0: ffff968162761a08 (&fs_info->qgroup_ioctl_lock){+.+.}-{3:3}, at: btrfs_create_qgroup+0x29/0xf0 [btrfs]
[   26.521114]  #1: ffff968162761960 (&fs_info->qgroup_lock){+.+.}-{2:2}, at: btrfs_create_qgroup+0x75/0xf0 [btrfs]
[   26.524120] CPU: 1 PID: 117 Comm: modprobe Not tainted 5.8.0-rc2-default+ #1154
[   26.526439] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.12.0-59-gc9ba527-rebuilt.opensuse.org 04/01/2014
[   26.529612] Call Trace:
[   26.530731]  dump_stack+0x78/0xa0
[   26.531983]  ___might_sleep.cold+0xa6/0xf9
[   26.533290]  ? kobject_set_name_vargs+0x1e/0x90
[   26.534674]  __kmalloc_track_caller+0x143/0x340
[   26.536122]  kvasprintf+0x64/0xc0
[   26.537257]  kobject_set_name_vargs+0x1e/0x90
[   26.538588]  kobject_init_and_add+0x5d/0xa0
[   26.539878]  ? lockdep_init_map_waits+0x4d/0x200
[   26.541398]  btrfs_sysfs_add_one_qgroup+0x72/0xa0 [btrfs]
[   26.543146]  add_qgroup_rb+0xb0/0x140 [btrfs]
[   26.544556]  btrfs_create_qgroup+0x80/0xf0 [btrfs]
[   26.546006]  test_no_shared_qgroup.isra.0+0x66/0x2b0 [btrfs]
[   26.547583]  btrfs_test_qgroups+0x1da/0x220 [btrfs]
[   26.549015]  btrfs_run_sanity_tests.cold+0x5c/0xd5 [btrfs]
[   26.550759]  ? 0xffffffffc0518000
[   26.551911]  init_btrfs_fs+0xf1/0x159 [btrfs]
[   26.553306]  do_one_initcall+0x63/0x320
[   26.554609]  ? rcu_read_lock_sched_held+0x5d/0x90
[   26.564925]  ? do_init_module+0x23/0x220
[   26.566180]  ? kmem_cache_alloc_trace+0x17b/0x2f0
[   26.567721]  do_init_module+0x5c/0x220
[   26.568978]  load_module+0xed8/0x1490
[   26.570252]  ? __do_sys_finit_module+0xbf/0xe0
[   26.571618]  __do_sys_finit_module+0xbf/0xe0
[   26.572955]  do_syscall_64+0x50/0xe0
[   26.574221]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[   26.575812] RIP: 0033:0x7fc269fa6649
[   26.577191] Code: Bad RIP value.
[   26.578341] RSP: 002b:00007ffffdc63a88 EFLAGS: 00000246 ORIG_RAX: 0000000000000139
[   26.580890] RAX: ffffffffffffffda RBX: 000055c8d63eba50 RCX: 00007fc269fa6649
[   26.582850] RDX: 0000000000000000 RSI: 000055c8d63c49d2 RDI: 000000000000000a
[   26.584887] RBP: 0000000000040000 R08: 0000000000000000 R09: 000055c8d63eedf0
[   26.586923] R10: 000000000000000a R11: 0000000000000246 R12: 000055c8d63c49d2
[   26.589341] R13: 000055c8d63e6f10 R14: 0000000000000000 R15: 000055c8d63ee530
[   26.591720]
[   26.592542] =============================
[   26.593931] [ BUG: Invalid wait context ]
[   26.595453] 5.8.0-rc2-default+ #1154 Tainted: G        W
[   26.597191] -----------------------------
[   26.598478] modprobe/117 is trying to lock:
[   26.599887] ffffffff8a11e370 (kernfs_mutex){+.+.}-{3:3}, at: kernfs_add_one+0x23/0x150
[   26.602366] other info that might help us debug this:
[   26.604184] context-{4:4}
[   26.605379] 2 locks held by modprobe/117:
[   26.606868]  #0: ffff968162761a08 (&fs_info->qgroup_ioctl_lock){+.+.}-{3:3}, at: btrfs_create_qgroup+0x29/0xf0 [btrfs]
[   26.610376]  #1: ffff968162761960 (&fs_info->qgroup_lock){+.+.}-{2:2}, at: btrfs_create_qgroup+0x75/0xf0 [btrfs]
[   26.613764] stack backtrace:
[   26.615038] CPU: 1 PID: 117 Comm: modprobe Tainted: G        W         5.8.0-rc2-default+ #1154
[   26.618100] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.12.0-59-gc9ba527-rebuilt.opensuse.org 04/01/2014
[   26.621610] Call Trace:
[   26.622731]  dump_stack+0x78/0xa0
[   26.624089]  __lock_acquire.cold+0xa0/0x16c
[   26.625593]  lock_acquire+0xa3/0x440
[   26.626951]  ? kernfs_add_one+0x23/0x150
[   26.628531]  __mutex_lock+0xa0/0xaf0
[   26.629958]  ? kernfs_add_one+0x23/0x150
[   26.631496]  ? kernfs_add_one+0x23/0x150
[   26.633669]  ? kernfs_add_one+0x23/0x150
[   26.635813]  kernfs_add_one+0x23/0x150
[   26.637438]  kernfs_create_dir_ns+0x58/0x80
[   26.638987]  sysfs_create_dir_ns+0x70/0xd0
[   26.640328]  ? rcu_read_lock_sched_held+0x5d/0x90
[   26.641799]  kobject_add_internal+0xbb/0x2d0
[   26.643162]  kobject_init_and_add+0x71/0xa0
[   26.644452]  ? lockdep_init_map_waits+0x4d/0x200
[   26.645889]  btrfs_sysfs_add_one_qgroup+0x72/0xa0 [btrfs]
[   26.647602]  add_qgroup_rb+0xb0/0x140 [btrfs]
[   26.649053]  btrfs_create_qgroup+0x80/0xf0 [btrfs]
[   26.650521]  test_no_shared_qgroup.isra.0+0x66/0x2b0 [btrfs]
[   26.652225]  btrfs_test_qgroups+0x1da/0x220 [btrfs]
[   26.653787]  btrfs_run_sanity_tests.cold+0x5c/0xd5 [btrfs]
[   26.655338]  ? 0xffffffffc0518000
[   26.656510]  init_btrfs_fs+0xf1/0x159 [btrfs]
[   26.657905]  do_one_initcall+0x63/0x320
[   26.659167]  ? rcu_read_lock_sched_held+0x5d/0x90
[   26.660563]  ? do_init_module+0x23/0x220
[   26.661841]  ? kmem_cache_alloc_trace+0x17b/0x2f0
[   26.663226]  do_init_module+0x5c/0x220
[   26.664428]  load_module+0xed8/0x1490
[   26.665607]  ? __do_sys_finit_module+0xbf/0xe0
[   26.666952]  __do_sys_finit_module+0xbf/0xe0
[   26.668253]  do_syscall_64+0x50/0xe0
[   26.669422]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[   26.670981] RIP: 0033:0x7fc269fa6649

And creating a qgoup fires the same warning:

[  145.501257] BUG: sleeping function called from invalid context at mm/slab.h:567
[  145.506681] in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 152, name: btrfs
[  145.521473] INFO: lockdep is turned off.
[  145.523000] CPU: 2 PID: 152 Comm: btrfs Tainted: G        W         5.8.0-rc2-default+ #1154
[  145.526231] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.12.0-59-gc9ba527-rebuilt.opensuse.org 04/01/2014
[  145.530130] Call Trace:
[  145.531296]  dump_stack+0x78/0xa0
[  145.532703]  ___might_sleep.cold+0xa6/0xf9
[  145.534287]  ? kobject_set_name_vargs+0x1e/0x90
[  145.536066]  __kmalloc_track_caller+0x143/0x340
[  145.537824]  kvasprintf+0x64/0xc0
[  145.539157]  kobject_set_name_vargs+0x1e/0x90
[  145.540769]  kobject_init_and_add+0x5d/0xa0
[  145.542348]  ? lockdep_init_map_waits+0x4d/0x200
[  145.544092]  btrfs_sysfs_add_one_qgroup+0x72/0xa0 [btrfs]
[  145.545966]  add_qgroup_rb+0xb0/0x140 [btrfs]
[  145.547654]  btrfs_create_qgroup+0x80/0xf0 [btrfs]
[  145.549266]  btrfs_ioctl+0x17bd/0x2540 [btrfs]
[  145.550739]  ? handle_mm_fault+0x732/0xa30
[  145.552305]  ? up_read+0x18/0x240
[  145.553623]  ? ksys_ioctl+0x68/0xa0
[  145.555029]  ksys_ioctl+0x68/0xa0
[  145.556451]  __x64_sys_ioctl+0x16/0x20
[  145.557898]  do_syscall_64+0x50/0xe0
[  145.559206]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[  145.560785] RIP: 0033:0x7f13619797b7
[  145.562035] Code: Bad RIP value.
[  145.563248] RSP: 002b:00007fff11e80428 EFLAGS: 00000206 ORIG_RAX: 0000000000000010
[  145.566129] RAX: ffffffffffffffda RBX: 00007fff11e805e8 RCX: 00007f13619797b7
[  145.568255] RDX: 00007fff11e80440 RSI: 000000004010942a RDI: 0000000000000003
[  145.570208] RBP: 0000000000000001 R08: 000055cc5da232a0 R09: 00007f1361a43a40
[  145.572201] R10: fffffffffffff486 R11: 0000000000000206 R12: 00007fff11e80440
[  145.574242] R13: 0000000000000003 R14: 0000000000000000 R15: 000055cc5d9d31ac
