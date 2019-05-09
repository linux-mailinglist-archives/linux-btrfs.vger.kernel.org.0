Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 486DD183FA
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 May 2019 05:11:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726666AbfEIDLI convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Wed, 8 May 2019 23:11:08 -0400
Received: from james.kirk.hungrycats.org ([174.142.39.145]:36222 "EHLO
        james.kirk.hungrycats.org" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726548AbfEIDLI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 8 May 2019 23:11:08 -0400
Received: by james.kirk.hungrycats.org (Postfix, from userid 1002)
        id 491FF2EC7C4; Wed,  8 May 2019 23:11:07 -0400 (EDT)
Date:   Wed, 8 May 2019 23:11:07 -0400
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     Otto =?iso-8859-1?Q?Kek=E4l=E4inen?= <otto@seravo.fi>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: Howto read btrfs stack trace?
Message-ID: <20190509031106.GE20359@hungrycats.org>
References: <CAHj_TLB=bqYmt6imjS-QU7OUtvGzatcVDZeCeCj1EfJA-3neKQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <CAHj_TLB=bqYmt6imjS-QU7OUtvGzatcVDZeCeCj1EfJA-3neKQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, May 06, 2019 at 07:21:36PM +0300, Otto Kekäläinen wrote:
> Hello!
> 
> I attempted to run btrfs balance, but it crashed soon after start.

The stack traces you provided did not occur as the result of a crash.
Was there a crash after these?

> Status is stuck on this:
> 
> $ sudo btrfs balance status -v /data
> Balance on '/data' is running
> 0 out of about 10436 chunks balanced (1 considered), 100% left
> Dumping filters: flags 0x7, state 0x1, force is off
>   DATA (flags 0x0): balancing
>   METADATA (flags 0x0): balancing
>   SYSTEM (flags 0x0): balancing

This is a full balance, which is rarely (maybe never) useful.  Is this
just a test you are running?  You should only balance metadata when
converting between RAID profiles.

> Logs have the output below. How shall I read it and debug this situation?
> What are the next steps I could test/debug?
> 
> 
> kernel: BTRFS info (device dm-9): disk space caching is enabled
> kernel: BTRFS: has skinny extents
> kernel: BTRFS: checking UUID tree
> kernel: BTRFS info (device dm-9): relocating block group 13693423976448 flags 20
> kernel: INFO: task btrfs:2918 blocked for more than 120 seconds.

This warning indicates that something spent an unexpectedly long time
(more than 120 seconds) blocked in the kernel.

> kernel:       Not tainted 4.4.0-146-generic #172-Ubuntu
> kernel: "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables
> this message.

This advises you that you can change the timeout for the kernel warning
(e.g. echo 600 > /proc/sys/kernel/hung_task_timeout_secs, or add
'kernel.hung_task_timeout_secs=600' to /etc/sysctl.conf), or disable
the warning entirely.

On spinning disks I would set the timeout to at least 600 seconds
for btrfs.  More may be required, depending on disk performance and
filesystem size.  On older kernels, where space_cache=v2 is not available,
I'd set it to at least an hour.

You should consider upgrading the kernel to at least 4.9 (the first LTS
kernel with space_cache=v2 support), and switching to space_cache=v2.
space_cache=v1 does not scale well to large filesystems.

The balance should resume after some time.  There's only 6 minutes of
delay shown in these logs.  Balance might take anywhere from a few
minutes to multiple hours to handle each block group, depending on block
group type, how many snapshots you have, what dedupe tools you've run,
how full the disk is, whether you have qgroups enabled, whether snapshots
are being deleted at the same time, and other factors.

If it's really stuck (i.e. no progress after an hour), run 'echo w >
/proc/sysrq-trigger' and post the resulting dmesg logs.  This will show
all blocked tasks in the system.  There may be some other process involved
in a deadlock (note the mutex_lock calls on the stack) but we can't see
that process in these three traces.

Note that if the balance doesn't resume on its own, the most likely
outcome of this exercise is that you'll eventually identify a bug in
4.4 kernels that has been fixed years ago, and you'll need to upgrade
your kernel to get the fix.  It may save time to start by upgrading to
at least 4.19 (current LTS) and seeing if the problem still occurs.

> kernel: btrfs           D ffff88030bd07a98     0  2918   2892 0x00000000
> kernel:  ffff88030bd07a98 ffffffff81197240 ffffffff81e13500 ffff88033fe44e00
> kernel:  ffff88030bd08000 ffff88035dc88714 ffff88033fe44e00 00000000ffffffff
> kernel:  ffff88035dc88718 ffff88030bd07ab0 ffffffff8185e0b5 ffff88035dc88710
> kernel: Call Trace:
> kernel:  [<ffffffff81197240>] ? printk+0x5a/0x76
> kernel:  [<ffffffff8185e0b5>] schedule+0x35/0x80
> kernel:  [<ffffffff8185e40e>] schedule_preempt_disabled+0xe/0x10
> kernel:  [<ffffffff818602a7>] __mutex_lock_slowpath+0xb7/0x130
> kernel:  [<ffffffff8186033f>] mutex_lock+0x1f/0x30
> kernel:  [<ffffffffc047b01b>] btrfs_relocate_block_group+0x1ab/0x290 [btrfs]
> kernel:  [<ffffffffc044fe47>] btrfs_relocate_chunk.isra.39+0x47/0xd0 [btrfs]
> kernel:  [<ffffffffc04512fa>] __btrfs_balance+0x5ba/0xb90 [btrfs]
> kernel:  [<ffffffffc0451b60>] btrfs_balance+0x290/0x5f0 [btrfs]
> kernel:  [<ffffffffc045d031>] btrfs_ioctl_balance+0x381/0x390 [btrfs]
> kernel:  [<ffffffffc045fe30>] btrfs_ioctl+0x550/0x28c0 [btrfs]
> kernel:  [<ffffffff8120f84b>] ? mem_cgroup_try_charge+0x6b/0x1e0
> kernel:  [<ffffffff811a9ba7>] ? lru_cache_add_active_or_unevictable+0x27/0xa0
> kernel:  [<ffffffff811cc2ed>] ? handle_mm_fault+0xecd/0x1b80
> kernel:  [<ffffffff8123016f>] do_vfs_ioctl+0x2af/0x4b0
> kernel:  [<ffffffff8106dd51>] ? __do_page_fault+0x1c1/0x410
> kernel:  [<ffffffff812303e9>] SyS_ioctl+0x79/0x90
> kernel:  [<ffffffff81862a1b>] entry_SYSCALL_64_fastpath+0x22/0xcb
> kernel: INFO: task btrfs:2918 blocked for more than 120 seconds.
> kernel:       Not tainted 4.4.0-146-generic #172-Ubuntu
> kernel: "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables
> this message.
> kernel: btrfs           D ffff88030bd07a98     0  2918   2892 0x00000000
> kernel:  ffff88030bd07a98 ffffffff81197240 ffffffff81e13500 ffff88033fe44e00
> kernel:  ffff88030bd08000 ffff88035dc88714 ffff88033fe44e00 00000000ffffffff
> kernel:  ffff88035dc88718 ffff88030bd07ab0 ffffffff8185e0b5 ffff88035dc88710
> kernel: Call Trace:
> kernel:  [<ffffffff81197240>] ? printk+0x5a/0x76
> kernel:  [<ffffffff8185e0b5>] schedule+0x35/0x80
> kernel:  [<ffffffff8185e40e>] schedule_preempt_disabled+0xe/0x10
> kernel:  [<ffffffff818602a7>] __mutex_lock_slowpath+0xb7/0x130
> kernel:  [<ffffffff8186033f>] mutex_lock+0x1f/0x30
> kernel:  [<ffffffffc047b01b>] btrfs_relocate_block_group+0x1ab/0x290 [btrfs]
> kernel:  [<ffffffffc044fe47>] btrfs_relocate_chunk.isra.39+0x47/0xd0 [btrfs]
> kernel:  [<ffffffffc04512fa>] __btrfs_balance+0x5ba/0xb90 [btrfs]
> kernel:  [<ffffffffc0451b60>] btrfs_balance+0x290/0x5f0 [btrfs]
> kernel:  [<ffffffffc045d031>] btrfs_ioctl_balance+0x381/0x390 [btrfs]
> kernel:  [<ffffffffc045fe30>] btrfs_ioctl+0x550/0x28c0 [btrfs]
> kernel:  [<ffffffff8120f84b>] ? mem_cgroup_try_charge+0x6b/0x1e0
> kernel:  [<ffffffff811a9ba7>] ? lru_cache_add_active_or_unevictable+0x27/0xa0
> kernel:  [<ffffffff811cc2ed>] ? handle_mm_fault+0xecd/0x1b80
> kernel:  [<ffffffff8123016f>] do_vfs_ioctl+0x2af/0x4b0
> kernel:  [<ffffffff8106dd51>] ? __do_page_fault+0x1c1/0x410
> kernel:  [<ffffffff812303e9>] SyS_ioctl+0x79/0x90
> kernel:  [<ffffffff81862a1b>] entry_SYSCALL_64_fastpath+0x22/0xcb
> kernel: INFO: task btrfs:2918 blocked for more than 120 seconds.
> kernel:       Not tainted 4.4.0-146-generic #172-Ubuntu
> kernel: "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables
> this message.
> kernel: btrfs           D ffff88030bd07a98     0  2918   2892 0x00000000
> kernel:  ffff88030bd07a98 ffffffff81197240 ffffffff81e13500 ffff88033fe44e00
> kernel:  ffff88030bd08000 ffff88035dc88714 ffff88033fe44e00 00000000ffffffff
> kernel:  ffff88035dc88718 ffff88030bd07ab0 ffffffff8185e0b5 ffff88035dc88710
> kernel: Call Trace:
> kernel:  [<ffffffff81197240>] ? printk+0x5a/0x76
> kernel:  [<ffffffff8185e0b5>] schedule+0x35/0x80
> kernel:  [<ffffffff8185e40e>] schedule_preempt_disabled+0xe/0x10
> kernel:  [<ffffffff818602a7>] __mutex_lock_slowpath+0xb7/0x130
> kernel:  [<ffffffff8186033f>] mutex_lock+0x1f/0x30
> kernel:  [<ffffffffc047b01b>] btrfs_relocate_block_group+0x1ab/0x290 [btrfs]
> kernel:  [<ffffffffc044fe47>] btrfs_relocate_chunk.isra.39+0x47/0xd0 [btrfs]
> kernel:  [<ffffffffc04512fa>] __btrfs_balance+0x5ba/0xb90 [btrfs]
> kernel:  [<ffffffffc0451b60>] btrfs_balance+0x290/0x5f0 [btrfs]
> kernel:  [<ffffffffc045d031>] btrfs_ioctl_balance+0x381/0x390 [btrfs]
> kernel:  [<ffffffffc045fe30>] btrfs_ioctl+0x550/0x28c0 [btrfs]
> kernel:  [<ffffffff8120f84b>] ? mem_cgroup_try_charge+0x6b/0x1e0
> kernel:  [<ffffffff811a9ba7>] ? lru_cache_add_active_or_unevictable+0x27/0xa0
> kernel:  [<ffffffff811cc2ed>] ? handle_mm_fault+0xecd/0x1b80
> kernel:  [<ffffffff8123016f>] do_vfs_ioctl+0x2af/0x4b0
> kernel:  [<ffffffff8106dd51>] ? __do_page_fault+0x1c1/0x410
> kernel:  [<ffffffff812303e9>] SyS_ioctl+0x79/0x90
> kernel:  [<ffffffff81862a1b>] entry_SYSCALL_64_fastpath+0x22/0xcb
