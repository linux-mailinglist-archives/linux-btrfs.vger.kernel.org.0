Return-Path: <linux-btrfs+bounces-15998-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A99EB213FE
	for <lists+linux-btrfs@lfdr.de>; Mon, 11 Aug 2025 20:16:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A0F91A2230F
	for <lists+linux-btrfs@lfdr.de>; Mon, 11 Aug 2025 18:16:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B613296BAD;
	Mon, 11 Aug 2025 18:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Uae0afUm"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AEBC2405E1;
	Mon, 11 Aug 2025 18:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754936121; cv=none; b=LlQWlTO0vlhpY38EfFezuiOLiHCWwGwBXd0/RRrk6jbTY8xJVjt4pbvG4oHeWyAayXmJImCuZ/lzMu5CI0LfMuHpQ4AOcYyvazZebhXcDamNR5IK/I4n7Jw/mCAiqQ9Q2F45ZUN57RT64pbXAmW+Y8pCT6941PcEmzrqisQGZT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754936121; c=relaxed/simple;
	bh=i3CFgTgaOVgs6rVHGnHbogoOuom+K3may1STKdsu0mA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sa4EqjQCSdmrcbCnByiRkMs+b8RrdSZqq9gA6JEhijelEd2tvk3e9z751+ukfYM62WfRqv93L+76rViRnE03IJna3GNAC3eCb5xtoZgnn65WgGXE8oxLlmAL0tvOFh3i5ts3OR2wl7h90Zjy3osKklrOvTzM4W5pXd28sKYr0Pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Uae0afUm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C93CAC4CEED;
	Mon, 11 Aug 2025 18:15:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754936121;
	bh=i3CFgTgaOVgs6rVHGnHbogoOuom+K3may1STKdsu0mA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Uae0afUmNoR8KA75DBNbdfNVvW4DcYug6cz7AdolgVFs9SQ+d0rhY+lM+COc+IIf9
	 Aq95eCDiCKptC8hUhrCrzyh48PdZM78pq9CummJ54DYD+kDiOJ6/HkHfIech24yVG3
	 nkNX6ADQWuGLnlWxW35pL48f+w8s3kno8qucUUE9cVpXGR2HUgZEff37o/jkoTAV59
	 3Qqxtjbvt4PEUE9+1pK4Z8PkALZzSam0GyITEycCamBv0hyk/6YeMQ/ovDoHKIoyP+
	 7vVcJOwu7joQKHnhFli2ZyBQRKMow0D+TrxlECK66pI9AnbaP2ps+atLTs4ZFueivG
	 Q9dSR6II4JEQw==
Date: Mon, 11 Aug 2025 08:15:19 -1000
From: Tejun Heo <tj@kernel.org>
To: Qu Wenruo <wqu@suse.com>
Cc: syzbot <syzbot+ead9101689c4ca30dbe8@syzkaller.appspotmail.com>,
	anna-maria@linutronix.de, clm@fb.com, dsterba@suse.com,
	frederic@kernel.org, josef@toxicpanda.com,
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com, tglx@linutronix.de,
	jiangshanlai@gmail.com
Subject: Re: [syzbot] [btrfs?] INFO: task hung in __alloc_workqueue (2)
Message-ID: <aJozN9LVgaPFX9dX@slm.duckdns.org>
References: <6899154b.050a0220.51d73.0094.GAE@google.com>
 <e3424457-8786-45dd-a0d9-ecc8bfae0829@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e3424457-8786-45dd-a0d9-ecc8bfae0829@suse.com>

Hello,

On Mon, Aug 11, 2025 at 08:02:40AM +0930, Qu Wenruo wrote:
...
> > Call Trace:
> >   <TASK>
> >   context_switch kernel/sched/core.c:5357 [inline]
> >   __schedule+0x16f3/0x4c20 kernel/sched/core.c:6961
> >   __schedule_loop kernel/sched/core.c:7043 [inline]
> >   schedule+0x165/0x360 kernel/sched/core.c:7058
> >   schedule_timeout+0x9a/0x270 kernel/time/sleep_timeout.c:75
> >   do_wait_for_common kernel/sched/completion.c:100 [inline]
> >   __wait_for_common kernel/sched/completion.c:121 [inline]
> >   wait_for_common kernel/sched/completion.c:132 [inline]
> >   wait_for_completion+0x2bf/0x5d0 kernel/sched/completion.c:153
> >   kthread_flush_worker+0x1c6/0x240 kernel/kthread.c:1563
> 
> This is flushing pwq_release_worker during error handling, and I didn't see
> anything btrfs specific except btrfs is allocating an ordered workqueue
> which utilizes WQ_UNBOUND flag.
> 
> And that WQ_UNBOUND flag is pretty widely used among other filesystems,
> maybe it's just btrfs have too many workqueues triggering this?
> 
> Adding workqueue maintainers.

That flush stall likely is a secondary effect of another failure. The
kthread worker is already spun up and running and the work function
pwq_release_workfn() grabs several locks. Maybe someone else is stalling on
those unless the kthread is somehow not allowed to run? Continued below.

> > Showing all locks held in the system:
> > 1 lock held by khungtaskd/38:
> >   #0: ffffffff8d9a8b80 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:331 [inline]
> >   #0: ffffffff8d9a8b80 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:841 [inline]
> >   #0: ffffffff8d9a8b80 (rcu_read_lock){....}-{1:3}, at: debug_show_all_locks+0x2e/0x180 kernel/locking/lockdep.c:6775
> > 1 lock held by udevd/5207:
> >   #0: ffff8880358bfa18 (&ep->lock){++++}-{3:3}, at: write_lock_irq include/linux/rwlock_rt.h:104 [inline]
> >   #0: ffff8880358bfa18 (&ep->lock){++++}-{3:3}, at: ep_poll fs/eventpoll.c:2127 [inline]
> >   #0: ffff8880358bfa18 (&ep->lock){++++}-{3:3}, at: do_epoll_wait+0x84d/0xbb0 fs/eventpoll.c:2560
> > 2 locks held by getty/5598:
> >   #0: ffff88823bfae8a0 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x25/0x70 drivers/tty/tty_ldisc.c:243
> >   #1: ffffc90003e8b2e0 (&ldata->atomic_read_lock){+.+.}-{4:4}, at: n_tty_read+0x444/0x1410 drivers/tty/n_tty.c:2222
> > 3 locks held by kworker/u8:3/5911:
> > 3 locks held by kworker/u8:7/5942:
> > 6 locks held by udevd/6060:
> > 1 lock held by udevd/6069:
> > 1 lock held by udevd/6190:
> > 6 locks held by udevd/6237:
~~~trimmed~~~

That's a lot of locks to be held, so something's not going right for sure.

> > Sending NMI from CPU 1 to CPUs 0:
> > NMI backtrace for cpu 0
> > CPU: 0 UID: 0 PID: 5911 Comm: kworker/u8:3 Tainted: G        W           6.16.0-syzkaller-11852-g479058002c32 #0 PREEMPT_{RT,(full)}
> > Tainted: [W]=WARN
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/12/2025
> > Workqueue: bat_events batadv_iv_send_outstanding_bat_ogm_packet
> > RIP: 0010:get_timer_this_cpu_base kernel/time/timer.c:939 [inline]
> > RIP: 0010:__mod_timer+0x81c/0xf60 kernel/time/timer.c:1101
> > Code: 01 00 00 00 48 8b 5c 24 20 41 0f b6 44 2d 00 84 c0 0f 85 72 06 00 00 8b 2b e8 f0 bb 49 09 41 89 c5 89 c3 bf 08 00 00 00 89 c6 <e8> 0f c1 12 00 41 83 fd 07 44 89 34 24 0f 87 69 06 00 00 e8 4c bc
> > RSP: 0018:ffffc90004fff680 EFLAGS: 00000082
> > RAX: 0000000000000000 RBX: 0000000000000000 RCX: f9fab87ca5ec6a00
> > RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000008
> > RBP: 0000000000200000 R08: 0000000000000000 R09: 0000000000000000
> > R10: dffffc0000000000 R11: fffff520009ffeac R12: ffff8880b8825a80
> > R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000802
> > FS:  0000000000000000(0000) GS:ffff8881268cd000(0000) knlGS:0000000000000000
> > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > CR2: 00007f46b6524000 CR3: 000000003afb2000 CR4: 00000000003526f0
> > Call Trace:
> >   <TASK>
> >   queue_delayed_work_on+0x18b/0x280 kernel/workqueue.c:2559
> >   queue_delayed_work include/linux/workqueue.h:684 [inline]
> >   batadv_forw_packet_queue+0x239/0x2a0 net/batman-adv/send.c:691
> >   batadv_iv_ogm_schedule_buff net/batman-adv/bat_iv_ogm.c:842 [inline]
> >   batadv_iv_ogm_schedule+0x892/0xf00 net/batman-adv/bat_iv_ogm.c:874
> >   batadv_iv_send_outstanding_bat_ogm_packet+0x6c6/0x7e0 net/batman-adv/bat_iv_ogm.c:1714
> >   process_one_work kernel/workqueue.c:3236 [inline]
> >   process_scheduled_works+0xae1/0x17b0 kernel/workqueue.c:3319
> >   worker_thread+0x8a0/0xda0 kernel/workqueue.c:3400
> >   kthread+0x711/0x8a0 kernel/kthread.c:463
> >   ret_from_fork+0x3f9/0x770 arch/x86/kernel/process.c:148
> >   ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
> >   </TASK>

So, task hung watchdog triggered and making all cpus dump their backtraces
and it's only one CPU. Is this a two CPU setup in a live lockup? I don't see
anything apparent and these are time based conditions that can be triggered
by severely overloading the system too. If you can reproduce the conditions,
seeing how the system is doing in general and whether the system can unwind
itself after killing the workload may be useful.

Thanks.

-- 
tejun

