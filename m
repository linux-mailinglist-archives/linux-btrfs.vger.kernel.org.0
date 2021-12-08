Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD0C746D7F3
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 Dec 2021 17:18:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236737AbhLHQWH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 8 Dec 2021 11:22:07 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:39054 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236712AbhLHQWD (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 8 Dec 2021 11:22:03 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 3D83F212C6;
        Wed,  8 Dec 2021 16:18:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1638980310;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8GSRJTtidIZ+41LZtld7WCs9FUMsBySoGH1IcdruVp0=;
        b=XpIwfiuzBWT9MWjVY7kXamWCWm62l3JPr7onaUXmA8lKBcN206/YueipYh7GLDTz/UKCCE
        Dg6XO3Bh8X3opP+ooI9SX3IZDjEcMWDM4LTBiYVSm17tctWtOdXltXGlD/7kYYXHtCJzLy
        fvKE/AkIzYNC4CQd40vocHVVlt9ITD4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1638980310;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8GSRJTtidIZ+41LZtld7WCs9FUMsBySoGH1IcdruVp0=;
        b=Io4kUuzi+Ij4UKzZpmOPU0jIqMckgRdpXu3eQpO/j24p1G9IjNI0kQVme+tqAILKDX2Y1C
        5RsqPyurPtXLlqCw==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 0D5D8A3B93;
        Wed,  8 Dec 2021 16:18:30 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 955F5DA799; Wed,  8 Dec 2021 17:18:14 +0100 (CET)
Date:   Wed, 8 Dec 2021 17:18:14 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Naohiro Aota <naohiro.aota@wdc.com>
Cc:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>
Subject: Re: [PATCH 0/3] btrfs: zoned: fix zoned extent allocator
Message-ID: <20211208161814.GL28560@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Naohiro Aota <naohiro.aota@wdc.com>,
        linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>
References: <20211207153549.2946602-1-naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211207153549.2946602-1-naohiro.aota@wdc.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Dec 08, 2021 at 12:35:46AM +0900, Naohiro Aota wrote:
> There are several reports of hung_task on btrfs recently.
> 
> - https://github.com/naota/linux/issues/59
> - https://lore.kernel.org/linux-btrfs/CAJCQCtR=jztS3P34U_iUNoBodExHcud44OQ8oe4Jn3TK=1yFNw@mail.gmail.com/T/
> 
> The stack trace of hung is like this:
> 
> [  739.991925][   T25] INFO: task kworker/u4:0:7 blocked for more than 122 seconds.
> [  739.994821][   T25]       Not tainted 5.16.0-rc3+ #56
> [  739.996676][   T25] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> [  739.999600][   T25] task:kworker/u4:0    state:D stack:    0 pid:    7 ppid:     2 flags:0x00004000
> [  740.002656][   T25] Workqueue: writeback wb_workfn (flush-btrfs-5)
> [  740.004894][   T25] Call Trace:
> [  740.006113][   T25]  <TASK>
> [  740.007143][   T25]  __schedule+0x9e3/0x23b0
> [  740.008657][   T25]  ? io_schedule_timeout+0x190/0x190
> [  740.010529][   T25]  ? blk_start_plug_nr_ios+0x270/0x270
> [  740.012385][   T25]  ? _raw_spin_unlock_irq+0x28/0x50
> [  740.014163][   T25]  schedule+0xed/0x280
> [  740.015567][   T25]  io_schedule+0xfb/0x180
> [  740.017026][   T25]  folio_wait_bit_common+0x386/0x840
> [  740.018839][   T25]  ? delete_from_page_cache+0x220/0x220
> [  740.020744][   T25]  ? __this_cpu_preempt_check+0x13/0x20
> [  740.022645][   T25]  ? filemap_range_has_page+0x210/0x210
> [  740.024588][   T25]  __folio_lock+0x17/0x20
> [  740.026197][   T25]  extent_write_cache_pages+0x78c/0xba0 [btrfs]
> [  740.028776][   T25]  ? __extent_writepage+0x980/0x980 [btrfs]
> [  740.031026][   T25]  ? __kasan_check_read+0x11/0x20
> [  740.032916][   T25]  ? __lock_acquire+0x1772/0x5a10
> [  740.034611][   T25]  extent_writepages+0x1e8/0x3b0 [btrfs]
> [  740.036636][   T25]  ? extent_write_locked_range+0x580/0x580 [btrfs]
> [  740.038828][   T25]  ? lockdep_hardirqs_on_prepare+0x410/0x410
> [  740.040929][   T25]  btrfs_writepages+0xe/0x10 [btrfs]
> [  740.042879][   T25]  do_writepages+0x187/0x610
> [  740.044239][   T25]  ? page_writeback_cpu_online+0x20/0x20
> [  740.045810][   T25]  ? sched_clock+0x9/0x10
> [  740.047015][   T25]  ? sched_clock_cpu+0x18/0x1b0
> [  740.048341][   T25]  ? find_held_lock+0x3c/0x130
> [  740.049649][   T25]  ? __this_cpu_preempt_check+0x13/0x20
> [  740.051155][   T25]  ? lock_release+0x3fd/0xed0
> [  740.052358][   T25]  ? __this_cpu_preempt_check+0x13/0x20
> [  740.053775][   T25]  ? lock_is_held_type+0xe4/0x140
> [  740.055059][   T25]  __writeback_single_inode+0xd7/0xa90
> [  740.056399][   T25]  writeback_sb_inodes+0x4e8/0xff0
> [  740.057693][   T25]  ? sync_inode_metadata+0xe0/0xe0
> [  740.058918][   T25]  ? down_read_trylock+0x45/0x50
> [  740.060003][   T25]  ? trylock_super+0x1b/0xc0
> [  740.061050][   T25]  __writeback_inodes_wb+0xba/0x210
> [  740.062123][   T25]  wb_writeback+0x5b3/0x8b0
> [  740.063075][   T25]  ? __writeback_inodes_wb+0x210/0x210
> [  740.064158][   T25]  ? __local_bh_enable_ip+0xaa/0x120
> [  740.065196][   T25]  ? __local_bh_enable_ip+0xaa/0x120
> [  740.066180][   T25]  ? trace_hardirqs_on+0x2b/0x130
> [  740.067117][   T25]  ? wb_workfn+0x2cc/0xe80
> [  740.067943][   T25]  ? get_nr_dirty_inodes+0x130/0x1c0
> [  740.068909][   T25]  wb_workfn+0x6f5/0xe80
> [  740.069674][   T25]  ? inode_wait_for_writeback+0x40/0x40
> [  740.070841][   T25]  ? __this_cpu_preempt_check+0x13/0x20
> [  740.071834][   T25]  ? lock_acquire+0x1c1/0x4f0
> [  740.072630][   T25]  ? lock_release+0xed0/0xed0
> [  740.073483][   T25]  ? lock_downgrade+0x7c0/0x7c0
> [  740.074374][   T25]  ? __this_cpu_preempt_check+0x13/0x20
> [  740.075342][   T25]  ? lock_is_held_type+0xe4/0x140
> [  740.076236][   T25]  process_one_work+0x826/0x14e0
> [  740.077045][   T25]  ? lock_is_held_type+0xe4/0x140
> [  740.077921][   T25]  ? pwq_dec_nr_in_flight+0x250/0x250
> [  740.078842][   T25]  ? lockdep_hardirqs_off+0x99/0xe0
> [  740.079699][   T25]  worker_thread+0x59b/0x1050
> [  740.080478][   T25]  ? process_one_work+0x14e0/0x14e0
> [  740.081306][   T25]  kthread+0x38f/0x460
> [  740.081955][   T25]  ? set_kthread_struct+0x110/0x110
> [  740.082769][   T25]  ret_from_fork+0x22/0x30
> [  740.083476][   T25]  </TASK>
> [  740.083972][   T25] INFO: task aio-dio-write-v:1459 blocked for more than 122 seconds.
> [  740.085202][   T25]       Not tainted 5.16.0-rc3+ #56
> [  740.085970][   T25] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> [  740.087238][   T25] task:aio-dio-write-v state:D stack:    0 pid: 1459 ppid:   542 flags:0x00004000
> [  740.088676][   T25] Call Trace:
> [  740.089269][   T25]  <TASK>
> [  740.089780][   T25]  __schedule+0x9e3/0x23b0
> [  740.090644][   T25]  ? io_schedule_timeout+0x190/0x190
> [  740.091614][   T25]  ? blk_start_plug_nr_ios+0x270/0x270
> [  740.092649][   T25]  ? _raw_spin_unlock_irq+0x28/0x50
> [  740.093531][   T25]  schedule+0xed/0x280
> [  740.094323][   T25]  io_schedule+0xfb/0x180
> [  740.095095][   T25]  folio_wait_bit_common+0x386/0x840
> [  740.095868][   T25]  ? delete_from_page_cache+0x220/0x220
> [  740.096730][   T25]  ? lock_is_held_type+0xe4/0x140
> [  740.097432][   T25]  ? filemap_range_has_page+0x210/0x210
> [  740.098252][   T25]  __filemap_get_folio+0x4d3/0x8f0
> [  740.099016][   T25]  ? filemap_range_needs_writeback+0xb0/0xb0
> [  740.099953][   T25]  ? lock_contended+0xdf0/0xdf0
> [  740.100663][   T25]  pagecache_get_page+0x19/0xc0
> [  740.101400][   T25]  prepare_pages+0x205/0x4c0 [btrfs]
> [  740.102274][   T25]  btrfs_buffered_write+0x5e0/0x1060 [btrfs]
> [  740.103402][   T25]  ? btrfs_dirty_pages+0x2c0/0x2c0 [btrfs]
> [  740.104480][   T25]  ? __up_read+0x1a9/0x7b0
> [  740.105260][   T25]  ? up_write+0x480/0x480
> [  740.106024][   T25]  ? btrfs_file_llseek+0x600/0x600 [btrfs]
> [  740.107157][   T25]  btrfs_file_write_iter+0x84e/0xfa0 [btrfs]
> [  740.108239][   T25]  ? lock_downgrade+0x7c0/0x7c0
> [  740.109091][   T25]  aio_write+0x314/0x820
> [  740.109888][   T25]  ? cpumask_weight.constprop.0+0x40/0x40
> [  740.110846][   T25]  ? kvm_sched_clock_read+0x18/0x40
> [  740.111677][   T25]  ? sched_clock_cpu+0x18/0x1b0
> [  740.112765][   T25]  ? __this_cpu_preempt_check+0x13/0x20
> [  740.114113][   T25]  ? lock_release+0x3fd/0xed0
> [  740.115264][   T25]  ? lock_downgrade+0x7c0/0x7c0
> [  740.116505][   T25]  io_submit_one.constprop.0+0xba3/0x1a50
> [  740.117894][   T25]  ? io_submit_one.constprop.0+0xba3/0x1a50
> [  740.119180][   T25]  ? kvm_sched_clock_read+0x18/0x40
> [  740.120036][   T25]  ? sched_clock+0x9/0x10
> [  740.120764][   T25]  ? sched_clock_cpu+0x18/0x1b0
> [  740.121619][   T25]  ? __x64_sys_io_getevents_time32+0x2a0/0x2a0
> [  740.122628][   T25]  ? lock_release+0x3fd/0xed0
> [  740.123522][   T25]  __x64_sys_io_submit+0x15d/0x2b0
> [  740.124417][   T25]  ? __x64_sys_io_submit+0x15d/0x2b0
> [  740.125363][   T25]  ? io_submit_one.constprop.0+0x1a50/0x1a50
> [  740.126322][   T25]  ? __this_cpu_preempt_check+0x13/0x20
> [  740.127243][   T25]  ? lock_is_held_type+0xe4/0x140
> [  740.128071][   T25]  ? lockdep_hardirqs_on+0x7e/0x100
> [  740.128915][   T25]  ? syscall_enter_from_user_mode+0x25/0x80
> [  740.129872][   T25]  ? trace_hardirqs_on+0x2b/0x130
> [  740.130694][   T25]  do_syscall_64+0x3b/0x90
> [  740.131380][   T25]  entry_SYSCALL_64_after_hwframe+0x44/0xae
> [  740.132351][   T25] RIP: 0033:0x7f5c03578679
> [  740.133117][   T25] RSP: 002b:00007fffa4f030e8 EFLAGS: 00000246 ORIG_RAX: 00000000000000d1
> [  740.134468][   T25] RAX: ffffffffffffffda RBX: 00007f5c034746c0 RCX: 00007f5c03578679
> [  740.135749][   T25] RDX: 0000561f67b701d0 RSI: 0000000000000037 RDI: 00007f5c03676000
> [  740.137151][   T25] RBP: 00007f5c03676000 R08: 0000000000000000 R09: 0000000000000000
> [  740.138505][   T25] R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000037
> [  740.139831][   T25] R13: 0000000000000000 R14: 0000561f67b701d0 R15: 0000561f67b701d0
> [  740.141263][   T25]  </TASK>
> [  740.141793][   T25]
> [  740.141793][   T25] Showing all locks held in the system:
> [  740.143126][   T25] 3 locks held by kworker/u4:0/7:
> [  740.143982][   T25]  #0: ffff888100d4d948 ((wq_completion)writeback){+.+.}-{0:0}, at: process_one_work+0x740/0x14e0
> [  740.145599][   T25]  #1: ffffc9000007fda8 ((work_completion)(&(&wb->dwork)->work)){+.+.}-{0:0}, at: process_one_work+0x770/0x14e0
> [  740.147521][   T25]  #2: ffff8881771760e8 (&type->s_umount_key#30){++++}-{3:3}, at: trylock_super+0x1b/0xc0
> [  740.149084][   T25] 1 lock held by khungtaskd/25:
> [  740.149916][   T25]  #0: ffffffff833cee00 (rcu_read_lock){....}-{1:2}, at: debug_show_all_locks+0x5f/0x27f
> [  740.151491][   T25] 1 lock held by aio-dio-write-v/1459:
> [  740.152458][   T25]  #0: ffff888172999b10 (&sb->s_type->i_mutex_key#13){++++}-{3:3}, at: btrfs_inode_lock+0x3f/0x70 [btrfs]
> [  740.154487][   T25]
> [  740.154920][   T25] =============================================
> [  740.154920][   T25]
> [  740.156347][   T25] Kernel panic - not syncing: hung_task: blocked tasks
> [  740.157548][   T25] CPU: 0 PID: 25 Comm: khungtaskd Not tainted 5.16.0-rc3+ #56
> [  740.158826][   T25] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS d55cb5a 04/01/2014
> [  740.160265][   T25] Call Trace:
> [  740.160788][   T25]  <TASK>
> [  740.161240][   T25]  dump_stack_lvl+0x49/0x5e
> [  740.162045][   T25]  dump_stack+0x10/0x12
> [  740.162642][   T25]  panic+0x1e2/0x478
> [  740.163330][   T25]  ? __warn_printk+0xf3/0xf3
> [  740.164041][   T25]  watchdog.cold+0x118/0x137
> [  740.164741][   T25]  ? reset_hung_task_detector+0x30/0x30
> [  740.165537][   T25]  kthread+0x38f/0x460
> [  740.166202][   T25]  ? set_kthread_struct+0x110/0x110
> [  740.167022][   T25]  ret_from_fork+0x22/0x30
> [  740.167782][   T25]  </TASK>
> [  740.168520][   T25] Kernel Offset: disabled
> [  740.169285][   T25] ---[ end Kernel panic - not syncing: hung_task: blocked tasks ]---
> 
> While we are debugging this issue, we found some faulty behaviors on
> the zoned extent allocator. It is not the root cause of the hung as we
> see a similar report also on a regular btrfs. But, it looks like that
> early -ENOSPC is, at least, making the hung to happen often.
> 
> So, this series fixes the faulty behaviors of the zoned extent
> allocator.
> 
> Patch 1 fixes a case when allocation fails in a dedicated block group.
> 
> Patches 2 and 3 fix the chunk allocation condition for zoned
> allocator, so that it won't block a possible chunk allocation.
> 
> Naohiro Aota (3):
>   btrfs: zoned: unset dedicated block group on allocation failure
>   btrfs: add extent allocator hook to decide to allocate chunk or not
>   btrfs: zoned: fix chunk allocation condition for zoned allocator

All seem to be relevant for 5.16-rc so I'll add them to misc-next now to
give it some testing, pull request next week. Thanks.
