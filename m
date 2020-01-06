Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9D05D1314C3
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 Jan 2020 16:25:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726437AbgAFPZ4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 6 Jan 2020 10:25:56 -0500
Received: from mx2.suse.de ([195.135.220.15]:60252 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726296AbgAFPZ4 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 6 Jan 2020 10:25:56 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 2DC8AAD09;
        Mon,  6 Jan 2020 15:25:53 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id BDA2DDA78B; Mon,  6 Jan 2020 16:25:42 +0100 (CET)
Date:   Mon, 6 Jan 2020 16:25:42 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Dennis Zhou <dennis@kernel.org>
Cc:     David Sterba <dsterba@suse.com>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Omar Sandoval <osandov@osandov.com>, kernel-team@fb.com,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 00/12] btrfs: async discard follow up
Message-ID: <20200106152542.GI3929@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Dennis Zhou <dennis@kernel.org>,
        David Sterba <dsterba@suse.com>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Omar Sandoval <osandov@osandov.com>, kernel-team@fb.com,
        linux-btrfs@vger.kernel.org
References: <cover.1577999991.git.dennis@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1577999991.git.dennis@kernel.org>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jan 02, 2020 at 04:26:34PM -0500, Dennis Zhou wrote:
> Dave applied 1-12 from v6 [1]. This is a follow up cleaning up the
> remaining 10 patches adding 2 more to deal with a rare -1 [2] that I
> haven't quite figured out how to repro. This is also available at [3].
> 
> This series is on top of btrfs-devel#misc-next-with-discard-v6 0c7be920bd7d.
> 
> [1] https://lore.kernel.org/linux-btrfs/cover.1576195673.git.dennis@kernel.org/
> [2] https://lore.kernel.org/linux-btrfs/20191217145541.GE3929@suse.cz/
> [3] https://git.kernel.org/pub/scm/linux/kernel/git/dennis/misc.git/log/?h=async-discard
> 
> Dennis Zhou (12):
>   btrfs: calculate discard delay based on number of extents
>   btrfs: add bps discard rate limit for async discard
>   btrfs: limit max discard size for async discard
>   btrfs: make max async discard size tunable
>   btrfs: have multiple discard lists
>   btrfs: only keep track of data extents for async discard
>   btrfs: keep track of discard reuse stats
>   btrfs: add async discard header
>   btrfs: increase the metadata allowance for the free_space_cache
>   btrfs: make smaller extents more likely to go into bitmaps
>   btrfs: ensure removal of discardable_* in free_bitmap()
>   btrfs: add correction to handle -1 edge case in async discard

I found this lockdep warning on the machine but can't tell what was the
exact load at the time. I did a few copy/delete/balance and git checkout
rounds, similar to the first testing loads. The branch tested was
basically current misc-next:

[251925.229374] ======================================================
[251925.235828] WARNING: possible circular locking dependency detected
[251925.242275] 5.5.0-rc4-1.ge195904-vanilla+ #553 Not tainted
[251925.248012] ------------------------------------------------------
[251925.254430] git/1531 is trying to acquire lock:
[251925.259191] ffff9f93e120e690 (&fs_info->reloc_mutex){+.+.}, at: btrfs_record_root_in_trans+0x44/0x70 [btrfs]
[251925.269419] 
[251925.269419] but task is already holding lock:
[251925.275629] ffff9f93df17bb38 (&mm->mmap_sem#2){++++}, at: vm_mmap_pgoff+0x71/0x100
[251925.283505] 
[251925.283505] which lock already depends on the new lock.
[251925.283505] 
[251925.292221] 
[251925.292221] the existing dependency chain (in reverse order) is:
[251925.300077] 
[251925.300077] -> #5 (&mm->mmap_sem#2){++++}:
[251925.306035]        __lock_acquire+0x3de/0x810
[251925.310612]        lock_acquire+0x95/0x1b0
[251925.314931]        __might_fault+0x60/0x80
[251925.319245]        _copy_from_user+0x1e/0xa0
[251925.323734]        get_sg_io_hdr+0xbb/0xf0
[251925.328053]        scsi_cmd_ioctl+0x213/0x430
[251925.332635]        cdrom_ioctl+0x3c/0x1499 [cdrom]
[251925.337657]        sr_block_ioctl+0xa0/0xd0 [sr_mod]
[251925.342845]        blkdev_ioctl+0x334/0xb70
[251925.347255]        block_ioctl+0x3f/0x50
[251925.351398]        do_vfs_ioctl+0x580/0x7b0
[251925.355790]        ksys_ioctl+0x3a/0x70
[251925.359845]        __x64_sys_ioctl+0x16/0x20
[251925.364347]        do_syscall_64+0x56/0x220
[251925.368750]        entry_SYSCALL_64_after_hwframe+0x49/0xbe
[251925.374538] 
[251925.374538] -> #4 (sr_mutex){+.+.}:
[251925.379877]        __lock_acquire+0x3de/0x810
[251925.384453]        lock_acquire+0x95/0x1b0
[251925.388768]        __mutex_lock+0xa0/0xb40
[251925.393074]        sr_block_open+0x9d/0x170 [sr_mod]
[251925.398254]        __blkdev_get+0xed/0x580
[251925.402574]        do_dentry_open+0x13c/0x3b0
[251925.407152]        do_last+0x18a/0x900
[251925.411117]        path_openat+0xa5/0x2b0
[251925.417191]        do_filp_open+0x91/0x100
[251925.421511]        do_sys_open+0x184/0x220
[251925.425817]        do_syscall_64+0x56/0x220
[251925.430220]        entry_SYSCALL_64_after_hwframe+0x49/0xbe
[251925.436008] 
[251925.436008] -> #3 (&bdev->bd_mutex){+.+.}:
[251925.441975]        __lock_acquire+0x3de/0x810
[251925.446538]        lock_acquire+0x95/0x1b0
[251925.450854]        __mutex_lock+0xa0/0xb40
[251925.455162]        __blkdev_get+0x7a/0x580
[251925.459488]        blkdev_get+0x78/0x150
[251925.463630]        blkdev_get_by_path+0x46/0x80
[251925.468413]        btrfs_get_bdev_and_sb+0x1b/0xb0 [btrfs]
[251925.474170]        open_fs_devices+0x77/0x280 [btrfs]
[251925.479482]        btrfs_open_devices+0x92/0xa0 [btrfs]
[251925.484967]        btrfs_mount_root+0x1fa/0x580 [btrfs]
[251925.490413]        legacy_get_tree+0x30/0x60
[251925.494899]        vfs_get_tree+0x23/0xb0
[251925.499139]        fc_mount+0xe/0x40
[251925.502933]        vfs_kern_mount.part.0+0x71/0x90
[251925.507981]        btrfs_mount+0x147/0x3e0 [btrfs]
[251925.512989]        legacy_get_tree+0x30/0x60
[251925.517477]        vfs_get_tree+0x23/0xb0
[251925.521707]        do_mount+0x7a8/0xa50
[251925.525751]        __x64_sys_mount+0x8e/0xd0
[251925.530243]        do_syscall_64+0x56/0x220
[251925.534646]        entry_SYSCALL_64_after_hwframe+0x49/0xbe
[251925.540427] 
[251925.540427] -> #2 (&fs_devs->device_list_mutex){+.+.}:
[251925.547434]        __lock_acquire+0x3de/0x810
[251925.552013]        lock_acquire+0x95/0x1b0
[251925.556328]        __mutex_lock+0xa0/0xb40
[251925.560677]        btrfs_run_dev_stats+0x35/0x90 [btrfs]
[251925.566243]        commit_cowonly_roots+0xb5/0x310 [btrfs]
[251925.571974]        btrfs_commit_transaction+0x508/0xb20 [btrfs]
[251925.578123]        sync_filesystem+0x74/0x90
[251925.582617]        generic_shutdown_super+0x22/0x100
[251925.587790]        kill_anon_super+0x14/0x30
[251925.592308]        btrfs_kill_super+0x12/0xa0 [btrfs]
[251925.597576]        deactivate_locked_super+0x31/0x70
[251925.602758]        cleanup_mnt+0x100/0x160
[251925.607074]        task_work_run+0x93/0xc0
[251925.611399]        exit_to_usermode_loop+0x9f/0xb0
[251925.616397]        do_syscall_64+0x1f0/0x220
[251925.620896]        entry_SYSCALL_64_after_hwframe+0x49/0xbe
[251925.626677] 
[251925.626677] -> #1 (&fs_info->tree_log_mutex){+.+.}:
[251925.633423]        __lock_acquire+0x3de/0x810
[251925.637997]        lock_acquire+0x95/0x1b0
[251925.642303]        __mutex_lock+0xa0/0xb40
[251925.646652]        btrfs_commit_transaction+0x4b0/0xb20 [btrfs]
[251925.652784]        sync_filesystem+0x74/0x90
[251925.657259]        generic_shutdown_super+0x22/0x100
[251925.662445]        kill_anon_super+0x14/0x30
[251925.666964]        btrfs_kill_super+0x12/0xa0 [btrfs]
[251925.672231]        deactivate_locked_super+0x31/0x70
[251925.677402]        cleanup_mnt+0x100/0x160
[251925.681716]        task_work_run+0x93/0xc0
[251925.686026]        exit_to_usermode_loop+0x9f/0xb0
[251925.691037]        do_syscall_64+0x1f0/0x220
[251925.695532]        entry_SYSCALL_64_after_hwframe+0x49/0xbe
[251925.701313] 
[251925.701313] -> #0 (&fs_info->reloc_mutex){+.+.}:
[251925.707789]        check_prev_add+0xa2/0xa90
[251925.712277]        validate_chain+0x6bf/0xbb0
[251925.716844]        __lock_acquire+0x3de/0x810
[251925.721420]        lock_acquire+0x95/0x1b0
[251925.725734]        __mutex_lock+0xa0/0xb40
[251925.730087]        btrfs_record_root_in_trans+0x44/0x70 [btrfs]
[251925.736260]        start_transaction+0xd8/0x590 [btrfs]
[251925.741737]        btrfs_dirty_inode+0x44/0xd0 [btrfs]
[251925.747103]        touch_atime+0xbe/0xe0
[251925.751268]        btrfs_file_mmap+0x3f/0x60 [btrfs]
[251925.756456]        mmap_region+0x3f7/0x680
[251925.760786]        do_mmap+0x36d/0x520
[251925.764744]        vm_mmap_pgoff+0x9d/0x100
[251925.769147]        ksys_mmap_pgoff+0x1a3/0x290
[251925.773812]        do_syscall_64+0x56/0x220
[251925.778215]        entry_SYSCALL_64_after_hwframe+0x49/0xbe
[251925.784005] 
[251925.784005] other info that might help us debug this:
[251925.784005] 
[251925.792546] Chain exists of:
[251925.792546]   &fs_info->reloc_mutex --> sr_mutex --> &mm->mmap_sem#2
[251925.792546] 
[251925.803779]  Possible unsafe locking scenario:
[251925.803779] 
[251925.810075]        CPU0                    CPU1
[251925.814820]        ----                    ----
[251925.819570]   lock(&mm->mmap_sem#2);
[251925.823354]                                lock(sr_mutex);
[251925.829059]                                lock(&mm->mmap_sem#2);
[251925.835363]   lock(&fs_info->reloc_mutex);
[251925.839674] 
[251925.839674]  *** DEADLOCK ***
[251925.839674] 
[251925.846136] 3 locks held by git/1531:
[251925.850015]  #0: ffff9f93df17bb38 (&mm->mmap_sem#2){++++}, at: vm_mmap_pgoff+0x71/0x100
[251925.858298]  #1: ffff9f93d6e3c488 (sb_writers#9){.+.+}, at: touch_atime+0x64/0xe0
[251925.866070]  #2: ffff9f93d6e3c6e8 (sb_internal#2){.+.+}, at: start_transaction+0x3e4/0x590 [btrfs]
[251925.875366] 
[251925.875366] stack backtrace:
[251925.880100] CPU: 5 PID: 1531 Comm: git Not tainted 5.5.0-rc4-1.ge195904-vanilla+ #553
[251925.888219] Hardware name: empty empty/S3993, BIOS PAQEX0-3 02/24/2008
[251925.894971] Call Trace:
[251925.897642]  dump_stack+0x71/0xa0
[251925.901178]  check_noncircular+0x177/0x190
[251925.905498]  check_prev_add+0xa2/0xa90
[251925.909481]  ? sched_clock_cpu+0x15/0x130
[251925.913710]  validate_chain+0x6bf/0xbb0
[251925.917772]  ? _raw_spin_unlock+0x1f/0x40
[251925.921995]  __lock_acquire+0x3de/0x810
[251925.926052]  lock_acquire+0x95/0x1b0
[251925.929890]  ? btrfs_record_root_in_trans+0x44/0x70 [btrfs]
[251925.935685]  __mutex_lock+0xa0/0xb40
[251925.939518]  ? btrfs_record_root_in_trans+0x44/0x70 [btrfs]
[251925.945348]  ? join_transaction+0x3f4/0x4b0 [btrfs]
[251925.950461]  ? sched_clock+0x5/0x10
[251925.954205]  ? btrfs_record_root_in_trans+0x44/0x70 [btrfs]
[251925.960045]  ? join_transaction+0x3f4/0x4b0 [btrfs]
[251925.965196]  ? btrfs_record_root_in_trans+0x44/0x70 [btrfs]
[251925.971015]  btrfs_record_root_in_trans+0x44/0x70 [btrfs]
[251925.976685]  start_transaction+0xd8/0x590 [btrfs]
[251925.981624]  ? ktime_get_coarse_real_ts64+0x70/0xd0
[251925.986781]  btrfs_dirty_inode+0x44/0xd0 [btrfs]
[251925.991624]  touch_atime+0xbe/0xe0
[251925.995271]  btrfs_file_mmap+0x3f/0x60 [btrfs]
[251925.999935]  mmap_region+0x3f7/0x680
[251926.003728]  do_mmap+0x36d/0x520
[251926.007180]  vm_mmap_pgoff+0x9d/0x100
[251926.011071]  ksys_mmap_pgoff+0x1a3/0x290
[251926.015216]  do_syscall_64+0x56/0x220
[251926.019095]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
[251926.024369] RIP: 0033:0x7f3d80959aca
[251926.028171] Code: 00 64 c7 00 13 00 00 00 eb d6 89 c3 e9 77 ff ff ff 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 49 89 ca b8 09 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 8e 63 2b 00 f7 d8 64 89 01 48
[251926.047306] RSP: 002b:00007ffcb8fa26c8 EFLAGS: 00000202 ORIG_RAX: 0000000000000009
[251926.055162] RAX: ffffffffffffffda RBX: 0000000000819e10 RCX: 00007f3d80959aca
[251926.062590] RDX: 0000000000000001 RSI: 0000000000819e10 RDI: 0000000000000000
[251926.070006] RBP: 0000000000000000 R08: 0000000000000003 R09: 0000000000000000
[251926.077424] R10: 0000000000000002 R11: 0000000000000202 R12: 0000000000000001
[251926.084853] R13: 0000000000000002 R14: 0000000000000003 R15: 0000000000000000
