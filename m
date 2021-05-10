Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEBA737976C
	for <lists+linux-btrfs@lfdr.de>; Mon, 10 May 2021 21:08:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231420AbhEJTJq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 10 May 2021 15:09:46 -0400
Received: from mx2.suse.de ([195.135.220.15]:39782 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230497AbhEJTJp (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 10 May 2021 15:09:45 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 920D7AE38;
        Mon, 10 May 2021 19:08:39 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id AE897DB228; Mon, 10 May 2021 21:06:10 +0200 (CEST)
Date:   Mon, 10 May 2021 21:06:10 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     dsterba@suse.cz, linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH] btrfs: avoid RCU stalls while running delayed iputs
Message-ID: <20210510190610.GY7604@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <c979946e8341274a0a45cfe9166cf6e4bea25a3e.1619707886.git.josef@toxicpanda.com>
 <20210429192547.GY7604@twin.jikos.cz>
 <4ad410ac-0739-0867-2d3b-a10eda7f7ea8@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4ad410ac-0739-0867-2d3b-a10eda7f7ea8@toxicpanda.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Apr 29, 2021 at 03:41:07PM -0400, Josef Bacik wrote:
> On 4/29/21 3:25 PM, David Sterba wrote:
> > On Thu, Apr 29, 2021 at 10:51:34AM -0400, Josef Bacik wrote:
> >> Generally a delayed iput is added when we might do the final iput, so
> >> usually we'll end up sleeping while processing the delayed iputs
> >> naturally.  However there's no guarantee of this, especially for small
> >> files.  In production we noticed 5 instances of RCU stalls while testing
> >> a kernel release overnight across 1000 machines, so this is relatively
> >> common
> >>
> >> host count: 5
> >> rcu: INFO: rcu_sched self-detected stall on CPU
> >>   rcu: \x091-....: (20998 ticks this GP) idle=59e/1/0x4000000000000002 softirq=12333372/12333372 fqs=3208
> >>   \x09(t=21031 jiffies g=27810193 q=41075) NMI backtrace for cpu 1
> >>   CPU: 1 PID: 1713 Comm: btrfs-cleaner Kdump: loaded Not tainted 5.6.13-0_fbk12_rc1_5520_gec92bffc1ec9 #1
> >>   "Hardware name: Quanta Tioga Pass Single Side 01-0030993006\x5cx0d/Tioga Pass Single Side, BIOS F08_3A24 05/13/2020"
> >>   Call Trace: <IRQ> dump_stack+0x50/0x70 nmi_cpu_backtrace.cold.6+0x30/0x65
> >>   ? lapic_can_unplug_cpu.cold.30+0x40/0x40 nmi_trigger_cpumask_backtrace+0xba/0xca
> >>   rcu_dump_cpu_stacks+0x99/0xc7 rcu_sched_clock_irq.cold.90+0x1b2/0x3a3
> >>   ? trigger_load_balance+0x5c/0x200 ? tick_sched_do_timer+0x60/0x60
> >>   ? tick_sched_do_timer+0x60/0x60 update_process_times+0x24/0x50
> >>   tick_sched_timer+0x37/0x70 __hrtimer_run_queues+0xfe/0x270
> >>   hrtimer_interrupt+0xf4/0x210 smp_apic_timer_interrupt+0x5e/0x120
> >>   apic_timer_interrupt+0xf/0x20 </IRQ>
> >>   RIP: 0010:queued_spin_lock_slowpath+0x17d/0x1b0
> >>   RSP: 0018:ffffc9000da5fe48 EFLAGS: 00000246 ORIG_RAX: ffffffffffffff13
> >>   RAX: 0000000000000000 RBX: ffff889fa81d0cd8 RCX: 0000000000000029
> >>   RDX: ffff889fff86c0c0 RSI: 0000000000080000 RDI: ffff88bfc2da7200
> >>   RBP: ffff888f2dcdd768 R08: 0000000001040000 R09: 0000000000000000
> >>   R10: 0000000000000001 R11: ffffffff82a55560 R12: ffff88bfc2da7200
> >>   R13: 0000000000000000 R14: ffff88bff6c2a360 R15: ffffffff814bd870
> >>   ? kzalloc.constprop.57+0x30/0x30 list_lru_add+0x5a/0x100
> >>   inode_lru_list_add+0x20/0x40 iput+0x1c1/0x1f0 run_delayed_iput_locked+0x46/0x90
> >>   btrfs_run_delayed_iputs+0x3f/0x60 cleaner_kthread+0xf2/0x120 kthread+0x10b/0x130
> > 
> > This got mangled, please resend or paste the correct version so I can
> > replace it.
> > 
> 
> Sorry that's actually what it looks like from our coalescing tool, I'll reformat 
> it and resend in a bit.  Thanks,

I fixed the formatting manually and applied to misc-next.
