Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9E6AE97C3E
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Aug 2019 16:15:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729249AbfHUOOb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 21 Aug 2019 10:14:31 -0400
Received: from mx2.suse.de ([195.135.220.15]:34200 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726484AbfHUOOa (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 21 Aug 2019 10:14:30 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id BFBB1AD3B;
        Wed, 21 Aug 2019 14:14:28 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 6C715DA7DB; Wed, 21 Aug 2019 16:14:54 +0200 (CEST)
Date:   Wed, 21 Aug 2019 16:14:53 +0200
From:   David Sterba <dsterba@suse.cz>
To:     David Sterba <dsterba@suse.cz>
Cc:     Omar Sandoval <osandov@osandov.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH v2 0/2] Btrfs: workqueue cleanups
Message-ID: <20190821141453.GI18575@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Omar Sandoval <osandov@osandov.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <cover.1565717247.git.osandov@fb.com>
 <20190821132021.GA18575@twin.jikos.cz>
 <20190821132446.GB18575@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190821132446.GB18575@twin.jikos.cz>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Aug 21, 2019 at 03:24:46PM +0200, David Sterba wrote:
> On Wed, Aug 21, 2019 at 03:20:21PM +0200, David Sterba wrote:
> > On Tue, Aug 13, 2019 at 10:33:42AM -0700, Omar Sandoval wrote:
> > > From: Omar Sandoval <osandov@fb.com>
> > > 
> > > This does some cleanups to the Btrfs workqueue code following my
> > > previous fix [1]. Changed since v1 [2]:
> > > 
> > > - Removed errant Fixes: tag in patch 1
> > > - Fixed a comment typo in patch 2
> > > - Added NB: to comments in patch 2
> > > - Added Nikolay and Filipe's reviewed-by tags
> > > 
> > > Thanks!
> > > 
> > > 1: https://lore.kernel.org/linux-btrfs/0bea516a54b26e4e1c42e6fe47548cb48cc4172b.1565112813.git.osandov@fb.com/
> > > 2: https://lore.kernel.org/linux-btrfs/cover.1565680721.git.osandov@fb.com/
> > > 
> > > Omar Sandoval (2):
> > >   Btrfs: get rid of unique workqueue helper functions
> > >   Btrfs: get rid of pointless wtag variable in async-thread.c
> > 
> > The patches seem to cause crashes inside the worques, happend several
> > times in random patches, sample stacktrace below. This blocks me from
> > testing so I'll move the patches out of misc-next for now and add back
> > once there's a fix.
> 
> Another possibility is that the cleanup patches make it more likely to
> happen and the root cause is "Btrfs: fix workqueue deadlock on dependent
> filesystems".

With just the deadlock fix on top<F2>, crashed in btrfs/011;

[ 2847.115355] general protection fault: 0000 [#1] SMP
[ 2847.120304] CPU: 0 PID: 10594 Comm: kworker/u8:3 Not tainted 5.3.0-rc5-default+ #699
[ 2847.124830] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.12.1-0-ga5cab58-prebuilt.qemu.org 04/01/2014
[ 2847.128328] Workqueue: btrfs-worker btrfs_worker_helper [btrfs]
[ 2847.130135] RIP: 0010:__lock_acquire+0x815/0x1100
[ 2847.136626] RSP: 0018:ffffb3e8c3dbfcd0 EFLAGS: 00010002
[ 2847.137627] RAX: 0000000000000000 RBX: 0000000000000086 RCX: 0000000000000000
[ 2847.138690] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 6b6b6b6b6b6b6ba3
[ 2847.139989] RBP: 0000000000000000 R08: 0000000000000001 R09: 0000000000000001
[ 2847.141055] R10: 6b6b6b6b6b6b6ba3 R11: 0000000000000000 R12: 0000000000000001
[ 2847.142113] R13: 0000000000000000 R14: 0000000000000000 R15: ffffa26aa1ab29c0
[ 2847.143251] FS:  0000000000000000(0000) GS:ffffa26abd400000(0000) knlGS:0000000000000000
[ 2847.145539] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 2847.147154] CR2: 00007f70c6c2977c CR3: 0000000031011000 CR4: 00000000000006f0
[ 2847.149046] Call Trace:
[ 2847.149683]  ? lockdep_hardirqs_on+0x103/0x190
[ 2847.150482]  ? trace_hardirqs_on_thunk+0x1a/0x20
[ 2847.151355]  lock_acquire+0x95/0x1a0
[ 2847.152205]  ? normal_work_helper+0x264/0x5f0 [btrfs]
[ 2847.153035]  _raw_spin_lock_irqsave+0x3c/0x80
[ 2847.153774]  ? normal_work_helper+0x264/0x5f0 [btrfs]
[ 2847.154597]  normal_work_helper+0x264/0x5f0 [btrfs]
[ 2847.155609]  process_one_work+0x22f/0x5b0
[ 2847.156487]  worker_thread+0x50/0x3b0
[ 2847.157275]  ? process_one_work+0x5b0/0x5b0
[ 2847.158356]  kthread+0x11a/0x130
[ 2847.159035]  ? kthread_create_worker_on_cpu+0x70/0x70
[ 2847.160186]  ret_from_fork+0x24/0x30
[ 2847.160828] Modules linked in: btrfs libcrc32c xor zstd_decompress zstd_compress xxhash raid6_pq loop
[ 2847.162540] ---[ end trace 4b931bab091a0069 ]---
[ 2847.163650] RIP: 0010:__lock_acquire+0x815/0x1100
[ 2847.168293] RSP: 0018:ffffb3e8c3dbfcd0 EFLAGS: 00010002
[ 2847.169286] RAX: 0000000000000000 RBX: 0000000000000086 RCX: 0000000000000000
[ 2847.170348] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 6b6b6b6b6b6b6ba3
[ 2847.171456] RBP: 0000000000000000 R08: 0000000000000001 R09: 0000000000000001
[ 2847.172874] R10: 6b6b6b6b6b6b6ba3 R11: 0000000000000000 R12: 0000000000000001
[ 2847.173937] R13: 0000000000000000 R14: 0000000000000000 R15: ffffa26aa1ab29c0
[ 2847.175727] FS:  0000000000000000(0000) GS:ffffa26abd400000(0000) knlGS:0000000000000000
[ 2847.177985] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 2847.179435] CR2: 00007f70c6c2977c CR3: 0000000031011000 CR4: 00000000000006f0
[ 2847.180657] BUG: sleeping function called from invalid context at include/linux/cgroup-defs.h:760
[ 2847.182056] in_atomic(): 1, irqs_disabled(): 1, pid: 10594, name: kworker/u8:3
[ 2847.183465] INFO: lockdep is turned off.
[ 2847.185401] irq event stamp: 37147954
[ 2847.187257] hardirqs last  enabled at (37147953): [<ffffffffa00029da>] trace_hardirqs_on_thunk+0x1a/0x20
[ 2847.190661] hardirqs last disabled at (37147954): [<ffffffffa073f8d6>] _raw_spin_lock_irqsave+0x16/0x80
[ 2847.193732] softirqs last  enabled at (37147952): [<ffffffffa0a00358>] __do_softirq+0x358/0x52b
[ 2847.196321] softirqs last disabled at (37147905): [<ffffffffa0088d6d>] irq_exit+0x9d/0xb0
[ 2847.198554] CPU: 0 PID: 10594 Comm: kworker/u8:3 Tainted: G      D           5.3.0-rc5-default+ #699
[ 2847.201083] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.12.1-0-ga5cab58-prebuilt.qemu.org 04/01/2014
[ 2847.203894] Workqueue: btrfs-worker btrfs_worker_helper [btrfs]
[ 2847.205305] Call Trace:
[ 2847.206010]  dump_stack+0x67/0x90
[ 2847.206943]  ___might_sleep.cold+0x9f/0xf2
[ 2847.208080]  exit_signals+0x30/0x110
[ 2847.209173]  do_exit+0xb7/0x920
[ 2847.210176]  ? kthread+0x11a/0x130
[ 2847.211261]  rewind_stack_do_exit+0x17/0x20
[ 2847.212571] note: kworker/u8:3[10594] exited with preempt_count 1
