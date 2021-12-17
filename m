Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D75C747849A
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Dec 2021 06:38:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233010AbhLQFih (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 17 Dec 2021 00:38:37 -0500
Received: from drax.kayaks.hungrycats.org ([174.142.148.226]:40540 "EHLO
        drax.kayaks.hungrycats.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230052AbhLQFig (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 17 Dec 2021 00:38:36 -0500
Received: by drax.kayaks.hungrycats.org (Postfix, from userid 1002)
        id DECF8F923D; Fri, 17 Dec 2021 00:38:35 -0500 (EST)
Date:   Fri, 17 Dec 2021 00:38:35 -0500
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>,
        Josef Bacik <josef@toxicpanda.com>
Subject: Re: bisected: btrfs dedupe regression in v5.11-rc1: 3078d85c9a10
 vfs: verify source area in vfs_dedupe_file_range_one()
Message-ID: <YbwiW5+wLnNH7Cp8@hungrycats.org>
References: <20211210183456.GP17148@hungrycats.org>
 <25f4d4fd-1727-1c9f-118a-150d9c263c93@suse.com>
 <YbfTYFQVGCU0Whce@hungrycats.org>
 <fc395aed-2cbd-f6e5-d167-632c14a07188@suse.com>
 <Ybj1jVYu3MrUzVTD@hungrycats.org>
 <c6125582-a1dc-1114-8211-48437dbf4976@suse.com>
 <YbrPkZVC/MazdQdc@hungrycats.org>
 <ab295d78-d250-fe8f-33a5-09cc90d5e406@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ab295d78-d250-fe8f-33a5-09cc90d5e406@suse.com>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Dec 16, 2021 at 11:29:06PM +0200, Nikolay Borisov wrote:
> 
> 
> On 16.12.21 г. 7:33, Zygo Blaxell wrote:
> > On Wed, Dec 15, 2021 at 12:25:04AM +0200, Nikolay Borisov wrote:
> >> Huhz, this means there is an open transaction handle somewhere o_O. I
> >> checked back the stacktraces in your original email but couldn't see
> >> where that might be coming from. I.e all processes are waiting on
> >> wait_current_trans and this happens _before_ the transaction handle is
> >> opened, hence num_extwriters can't have been incremented by them.
> >>
> >> When an fs wedges, and you get again num_extwriters can you provde the
> >> output of "echo w > /proc/sysrq-trigger"
> > 
> > Here you go...
> 
> <snip>
> 
> > 
> > Again we have "3 locks held" but no list of locks.  WTF is 10883 doing?
> > Well, first of all it's using 100% CPU in the kernel.  Some samples of
> > kernel stacks:
> > 
> > 	# cat /proc/*/task/10883/stack
> > 	[<0>] down_read_nested+0x32/0x140
> > 	[<0>] __btrfs_tree_read_lock+0x2d/0x110
> > 	[<0>] btrfs_tree_read_lock+0x10/0x20
> > 	[<0>] btrfs_search_old_slot+0x627/0x8a0
> > 	[<0>] btrfs_next_old_leaf+0xcb/0x340
> > 	[<0>] find_parent_nodes+0xcd7/0x1c40
> > 	[<0>] btrfs_find_all_leafs+0x63/0xb0
> > 	[<0>] iterate_extent_inodes+0xc8/0x270
> > 	[<0>] iterate_inodes_from_logical+0x9f/0xe0
> 
> That's the real culprit, in this case we are not searching the commit
> root hence we've attached to the transaction.  So we are doing backref
> resolution which either:
> 
> a) Hits some pathological case and loops for very long time, backref
> resolution is known to take a lot of time.

backref resolve is known to take a long time, which is why bees measures
that time, and avoids extents where the kernel CPU time in LOGICAL_INO
starts climbing up the exponential curve.  In older kernels performance
got worse as more extent refs were added, but it did so slowly enough
that bees could detect and evade the bug before it created multi-second
transaction latencies.  Since 5.7 this isn't really a problem any more,
but bees still has this workaround in its code.

This bug is not that bug:  CPU usage in LOGICAL_INO goes from less than
100 ms to >40 hours (the longest I've let it run before forcing reboot)
in a single step.  On this test setup the 100 ms threshold is hit about
once every 18 testing hours, or once per 2.3M LOGICAL_INO calls, and
it's only 150 ms or so.  Usually these happen when the kernel thread
gets stuck with the CPU bill for flushing delayed refs or something
equally harmless, and they happen hours before the lockup (if at all).

In the "take a lot of time" case, we get a lot of warning as the time
ramps up.  In this case, we go from zero to two days with nothing
in between.

> b) We hit a bug in backref resolution and loop forever which again
> results in the transaction being kept open.
> 
> Now I wonder why you were able to bisect this to the seemingly unrelated
> commit in the vfs code.

Meh, bisection isn't particularly reliable, and this bug might be very
sensitive to its environment, particularly if it's a race condition
between two or more threads running a tight loop over the same objects
(like tree mod log).  I've been running a few more bisection runs and
they're landing all over the place, including things like TI SoC commits.
So I'm now testing btrfs commits chosen myself instead of following
git's bisect algorithm.

There's a definite probability shift somewhere in the middle of v5.11-rc1.
We go from hourly failure rates below 0.002 at v5.10 to above 0.3 by
v5.11-rc1.  But that could as easily be a 10-year-old bug surfacing due
to apparently unrelated changes as it is something that was added in
v5.11-rc1 itself.

> Josef any ideas how to proceed further to debug why backref resolution
> takes a long time and if it's just an infinite loop?
> 
> > 	[<0>] btrfs_ioctl_logical_to_ino+0x183/0x210
> > 	[<0>] btrfs_ioctl+0xa81/0x2fb0
> > 	[<0>] __x64_sys_ioctl+0x91/0xc0
> > 	[<0>] do_syscall_64+0x38/0x90
> > 	[<0>] entry_SYSCALL_64_after_hwframe+0x44/0xa9
> > 	# cat /proc/*/task/10883/stack
> > 	# cat /proc/*/task/10883/stack
> > 	[<0>] __tree_mod_log_rewind+0x57/0x250
> > 	# cat /proc/*/task/10883/stack
> > 	[<0>] __tree_mod_log_rewind+0x57/0x250
> > 	# cat /proc/*/task/10883/stack
> > 	# cat /proc/*/task/10883/stack
> > 	[<0>] __tree_mod_log_rewind+0x57/0x250
> > 	# cat /proc/*/task/10883/stack
> > 	[<0>] __tree_mod_log_rewind+0x57/0x250
> > 	# cat /proc/*/task/10883/stack
> > 	[<0>] __tree_mod_log_rewind+0x57/0x250
> > 	# cat /proc/*/task/10883/stack
> > 	[<0>] __tree_mod_log_rewind+0x57/0x250
> > 	# cat /proc/*/task/10883/stack
> > 	# cat /proc/*/task/10883/stack
> > 	[<0>] __tree_mod_log_rewind+0x57/0x250
> > 	# cat /proc/*/task/10883/stack
> > 	# cat /proc/*/task/10883/stack
> > 	[<0>] __tree_mod_log_rewind+0x57/0x250
> > 	# cat /proc/*/task/10883/stack
> > 	[<0>] __tree_mod_log_rewind+0x57/0x250
> > 	# cat /proc/*/task/10883/stack
> > 	# cat /proc/*/task/10883/stack
> > 	# cat /proc/*/task/10883/stack
> > 	[<0>] free_extent_buffer.part.0+0x51/0xa0
> > 	# cat /proc/*/task/10883/stack
> > 	[<0>] find_held_lock+0x38/0x90
> > 	[<0>] kmem_cache_alloc+0x22d/0x360
> > 	[<0>] __alloc_extent_buffer+0x2a/0xa0
> > 	[<0>] btrfs_clone_extent_buffer+0x42/0x130
> > 	[<0>] btrfs_search_old_slot+0x660/0x8a0
> > 	[<0>] btrfs_next_old_leaf+0xcb/0x340
> > 	[<0>] find_parent_nodes+0xcd7/0x1c40
> > 	[<0>] btrfs_find_all_leafs+0x63/0xb0
> > 	[<0>] iterate_extent_inodes+0xc8/0x270
> > 	[<0>] iterate_inodes_from_logical+0x9f/0xe0
> > 	[<0>] btrfs_ioctl_logical_to_ino+0x183/0x210
> > 	[<0>] btrfs_ioctl+0xa81/0x2fb0
> > 	[<0>] __x64_sys_ioctl+0x91/0xc0
> > 	[<0>] do_syscall_64+0x38/0x90
> > 	[<0>] entry_SYSCALL_64_after_hwframe+0x44/0xa9
> > 
> > So it looks like tree mod log is doing some infinite (or very large
> > finite) looping in the LOGICAL_INO ioctl.  That ioctl holds a transaction
> > open while it runs, but it's not blocked per se, so it doesn't show up
> > in SysRq-W output.
> > 
> 
