Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EF9C22B8FC
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 Jul 2020 23:55:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726488AbgGWVzv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 23 Jul 2020 17:55:51 -0400
Received: from james.kirk.hungrycats.org ([174.142.39.145]:48564 "EHLO
        james.kirk.hungrycats.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726390AbgGWVzv (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 23 Jul 2020 17:55:51 -0400
Received: by james.kirk.hungrycats.org (Postfix, from userid 1002)
        id 9964177BA51; Thu, 23 Jul 2020 17:55:49 -0400 (EDT)
Date:   Thu, 23 Jul 2020 17:55:48 -0400
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v3 0/4] btrfs: handle signal interruption during
 relocation more gracefully
Message-ID: <20200723215548.GD5890@hungrycats.org>
References: <20200713010322.18507-1-wqu@suse.com>
 <20200715143749.GZ3703@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200715143749.GZ3703@twin.jikos.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jul 15, 2020 at 04:37:49PM +0200, David Sterba wrote:
> On Mon, Jul 13, 2020 at 09:03:18AM +0800, Qu Wenruo wrote:
> > This bug is reported by Hans van Kranenburg <hans@knorrie.org>, that
> > when a running btrfs balance get fatal signals (including SIGINT), some
> > bad things can happen, mostly forced RO caused by -EINTR.
> > 
> > It turns out that, although we have addressed the btrfs balance cancel
> > problems, we haven't addressed the signal related problems.
> > 
> > In theory, processes trapped into kernel space won't get interrupted by
> > signals, as signal callbacks happen in user space, but kernel code can
> > still check pending signals and change behavior accordingly.
> > 
> > In this case, the culprit is that, wait_reserve_ticket() can return
> > -EINTR if there is a pending fatal signal.
> > 
> > While for balance, a lot of situations can't handle the -EINTR from it,
> > especially for critical cleanup phase.
> > 
> > This patchset will address the bug in two directions:
> > - Catch fatal signal early
> >   Now btrfs_should_cancel_balance() will also check pending signals.
> >   And will exit gracefully and treat it as a canceled balance.
> 
> This should be safe as it's checked in known locations.
> 
> > - Don't allow -EINTR for critical cleanup
> >   For btrfs_drop_snapshot() for reloc trees, we shouldn't be interrupted
> >   by signal, thus we use btrfs_join_transaction() instead of
> >   btrfs_start_transaction().
> 
> This one is a bit more scary, but the interruption has been there
> already so we're not changing anything.
> 
> I haven't spotted anything obviously wrong so I'll add the patches to
> misc-next, thanks.

I applied these to a 5.7.9 kernel.

I ran my usual tests on the modified 5.7.9 kernel and also misc-next.
The usual test is balance, dedupe, scrub, rsync, and random cancels for
balance and scrub.  I added 'killall -INT btrfs' at random intervals to
the test to exercise these patches, which hits the balance thread with
SIGINT from time to time.

Both misc-next and 5.7.9 + this patch series crash in multiple test
runs with this kernel log:

	[120825.519759][T28142] BTRFS info (device dm-0): found 66 extents, loops 1, stage: move data extents
	[120944.279061][T28142] BTRFS info (device dm-0): balance: canceled
	[121295.243268][T28038] BTRFS info (device dm-0): balance: start -mlimit=1 -slimit=1
	[121295.651326][T28038] BTRFS info (device dm-0): relocating block group 10991411658752 flags metadata|raid1
	[121990.537451][T28038] BTRFS info (device dm-0): balance: canceled
	[122222.027422][ T3699] BTRFS info (device dm-0): balance: start -mlimit=1 -slimit=1
	[122222.111885][ T3699] BTRFS info (device dm-0): relocating block group 10991411658752 flags metadata|raid1
	[122488.936273][ T3699] BTRFS: error (device dm-0) in btrfs_drop_snapshot:5525: errno=-4 unknown
	[122488.949707][ T3699] BTRFS info (device dm-0): forced readonly
	[122494.355108][ T3699] BTRFS info (device dm-0): balance: canceled
	[122518.856935][ T4309] BTRFS: error (device dm-0) in btrfs_commit_transaction:2324: errno=-117 unknown (Error while writing out transaction)
	[122518.863579][ T4309] BTRFS warning (device dm-0): Skipping commit of aborted transaction.
	[122518.876014][ T4309] ------------[ cut here ]------------
	[122518.887336][ T4309] BTRFS: Transaction aborted (error -117)
	[122518.887379][ T4309] WARNING: CPU: 3 PID: 4309 at fs/btrfs/transaction.c:1894 cleanup_transaction+0x113/0x1a0
	[122518.906175][ T4309] Modules linked in:
	[122518.912471][ T4309] CPU: 3 PID: 4309 Comm: btrfs-transacti Tainted: G        W         5.7.9-8ffe3b022114+ #5
	[122518.930580][ T4309] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.12.0-1 04/01/2014
	[122518.948290][ T4309] RIP: 0010:cleanup_transaction+0x113/0x1a0
	[122518.951748][ T4309] Code: 0f ba af 08 1c 00 00 02 72 22 8b 85 50 ff ff ff 83 f8 fb 75 07 e9 74 00 00 00 eb 10 89 c6 48 c7 c7 c0 12 03 a0 e8 ae 13 89 ff <0f> 0b 8b 8d 50 ff ff ff
	 ba 66 07 00 00 48 c7 c6 20 19 03 a0 48 89
	[122518.992359][ T4309] RSP: 0018:ffffc90001557c98 EFLAGS: 00010286
	[122519.002693][ T4309] RAX: 0000000000000000 RBX: ffff888102aa30a8 RCX: 0000000000000001
	[122519.016653][ T4309] RDX: 0000000000000003 RSI: 0000000000000007 RDI: ffff8881f5ff4660
	[122519.029877][ T4309] RBP: ffffc90001557d68 R08: ffffed103ebfe8cd R09: ffffed103ebfe8cd
	[122519.042845][ T4309] R10: ffff8881f5ff4663 R11: ffffed103ebfe8cc R12: 1ffff920002aaf98
	[122519.055298][ T4309] R13: ffff888102aa30f8 R14: ffff888102aa30c8 R15: ffff8881f2f10000
	[122519.069403][ T4309] FS:  0000000000000000(0000) GS:ffff8881f5e00000(0000) knlGS:0000000000000000
	[122519.084616][ T4309] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
	[122519.096159][ T4309] CR2: 000055864c01c428 CR3: 00000001dc8a0001 CR4: 00000000001606e0
	[122519.109125][ T4309] Call Trace:
	[122519.114458][ T4309]  ? wait_current_trans+0x230/0x230
	[122519.121964][ T4309]  ? wait_for_completion+0x1b0/0x1b0
	[122519.125434][ T4309]  ? btrfs_trans_release_metadata+0x39/0x240
	[122519.127429][ T4309]  ? btrfs_commit_transaction+0x11f1/0x13c0
	[122519.129726][ T4309]  btrfs_commit_transaction+0x1233/0x13c0
	[122519.132040][ T4309]  ? btrfs_apply_pending_changes+0xa0/0xa0
	[122519.134194][ T4309]  ? start_transaction+0x189/0x8f0
	[122519.135786][ T4309]  transaction_kthread+0x235/0x25f
	[122519.137233][ T4309]  ? btrfs_cleanup_transaction+0xb70/0xb70
	[122519.138892][ T4309]  kthread+0x1f7/0x220
	[122519.140030][ T4309]  ? kthread_create_worker_on_cpu+0xc0/0xc0
	[122519.141735][ T4309]  ret_from_fork+0x3a/0x50
	[122519.143590][ T4309] irq event stamp: 1329280124
	[122519.145465][ T4309] hardirqs last  enabled at (1329280123): [<ffffffff9e204292>] console_unlock+0x572/0x720
	[122519.148790][ T4309] hardirqs last disabled at (1329280124): [<ffffffff9e005bc6>] trace_hardirqs_off_thunk+0x1a/0x1c
	[122519.151957][ T4309] softirqs last  enabled at (1329280114): [<ffffffff9fc0049b>] __do_softirq+0x49b/0x5e9
	[122519.155622][ T4309] softirqs last disabled at (1329280105): [<ffffffff9e128e32>] irq_exit+0x112/0x120
	[122519.168765][ T4309] ---[ end trace f36a6c74e2cf832a ]---
	[122519.178022][ T4309] BTRFS: error (device dm-0) in cleanup_transaction:1894: errno=-117 unknown

Here's another, which has a few extra messages as it fails:

	Jul 22 11:33:42 nebtest kernel: [ 8908.297238][ T1666] BTRFS info (device dm-0): balance: start -mlimit=1 -slimit=1
	Jul 22 11:33:42 nebtest kernel: [ 8908.356586][ T1666] BTRFS info (device dm-0): relocating block group 10991411658752 flags metadata|raid1
	Jul 22 11:39:21 nebtest kernel: [ 9247.805317][ T1666] BTRFS: error (device dm-0) in btrfs_drop_snapshot:5525: errno=-4 unknown
	Jul 22 11:39:21 nebtest kernel: [ 9247.823592][ T1666] BTRFS info (device dm-0): forced readonly
	Jul 22 11:39:22 nebtest kernel: [ 9249.223188][ T5135] BTRFS warning (device dm-0): could not allocate space for delete; will truncate on mount
	Jul 22 11:39:29 nebtest kernel: [ 9256.175871][ T1666] BTRFS info (device dm-0): balance: canceled
	Jul 22 11:39:53 nebtest kernel: [ 9279.763732][ T4484] BTRFS: error (device dm-0) in btrfs_commit_transaction:2324: errno=-117 unknown (Error while writing out transaction)
	Jul 22 11:39:53 nebtest kernel: [ 9279.784623][ T4484] BTRFS warning (device dm-0): Skipping commit of aborted transaction.
	Jul 22 11:39:53 nebtest kernel: [ 9279.798765][ T4484] ------------[ cut here ]------------
	Jul 22 11:39:53 nebtest kernel: [ 9279.806923][ T4484] BTRFS: Transaction aborted (error -117)
	Jul 22 11:39:53 nebtest kernel: [ 9279.806972][ T4484] WARNING: CPU: 2 PID: 4484 at fs/btrfs/transaction.c:1894 cleanup_transaction+0x113/0x1a0
	Jul 22 11:39:53 nebtest kernel: [ 9279.812663][ T4484] Modules linked in:
	Jul 22 11:39:53 nebtest kernel: [ 9279.819676][ T4484] CPU: 2 PID: 4484 Comm: btrfs-transacti Tainted: G        W         5.7.9-8ffe3b022114+ #5
	Jul 22 11:39:53 nebtest kernel: [ 9279.834426][ T4484] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.12.0-1 04/01/2014
	Jul 22 11:39:53 nebtest kernel: [ 9279.853728][ T4484] RIP: 0010:cleanup_transaction+0x113/0x1a0
	Jul 22 11:39:53 nebtest kernel: [ 9279.863910][ T4484] Code: 0f ba af 08 1c 00 00 02 72 22 8b 85 50 ff ff ff 83 f8 fb 75 07 e9 74 00 00 00 eb 10 89 c6 48 c7 c7 c0 12 03 88 e8 ae 13 89 ff <0f> 0b 8b 8d 50 ff ff ff 
	ba 66 07 00 00 48 c7 c6 20 19 03 88 48 89
	Jul 22 11:39:53 nebtest kernel: [ 9279.897125][ T4484] RSP: 0018:ffffc90000607c98 EFLAGS: 00010286
	Jul 22 11:39:53 nebtest kernel: [ 9279.908518][ T4484] RAX: 0000000000000000 RBX: ffff888014186f18 RCX: 0000000000000001
	Jul 22 11:39:53 nebtest kernel: [ 9279.922181][ T4484] RDX: 0000000000000003 RSI: 0000000000000007 RDI: ffff8881f0bf4660
	Jul 22 11:39:53 nebtest kernel: [ 9279.935680][ T4484] RBP: ffffc90000607d68 R08: ffffed103e17e8cd R09: ffffed103e17e8cd
	Jul 22 11:39:53 nebtest kernel: [ 9279.949021][ T4484] R10: ffff8881f0bf4663 R11: ffffed103e17e8cc R12: 1ffff920000c0f98
	Jul 22 11:39:53 nebtest kernel: [ 9279.962724][ T4484] R13: ffff888014186f68 R14: ffff888014186f38 R15: ffff8881de2b8000
	Jul 22 11:39:53 nebtest kernel: [ 9279.975836][ T4484] FS:  0000000000000000(0000) GS:ffff8881f0a00000(0000) knlGS:0000000000000000
	Jul 22 11:39:53 nebtest kernel: [ 9279.990300][ T4484] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
	Jul 22 11:39:53 nebtest kernel: [ 9280.001160][ T4484] CR2: 00007fff5ba8de4c CR3: 00000001d8008005 CR4: 00000000001606e0
	Jul 22 11:39:53 nebtest kernel: [ 9280.014075][ T4484] Call Trace:
	Jul 22 11:39:53 nebtest kernel: [ 9280.019903][ T4484]  ? wait_current_trans+0x230/0x230
	Jul 22 11:39:53 nebtest kernel: [ 9280.023119][ T4484]  ? wait_for_completion+0x1b0/0x1b0
	Jul 22 11:39:53 nebtest kernel: [ 9280.026261][ T4484]  ? btrfs_trans_release_metadata+0x39/0x240
	Jul 22 11:39:53 nebtest kernel: [ 9280.028884][ T4484]  ? btrfs_commit_transaction+0x11f1/0x13c0
	Jul 22 11:39:53 nebtest kernel: [ 9280.032146][ T4484]  btrfs_commit_transaction+0x1233/0x13c0
	Jul 22 11:39:53 nebtest kernel: [ 9280.035785][ T4484]  ? btrfs_apply_pending_changes+0xa0/0xa0
	Jul 22 11:39:53 nebtest kernel: [ 9280.039147][ T4484]  ? start_transaction+0x189/0x8f0
	Jul 22 11:39:53 nebtest kernel: [ 9280.042704][ T4484]  transaction_kthread+0x235/0x25f
	Jul 22 11:39:53 nebtest kernel: [ 9280.045130][ T4484]  ? btrfs_cleanup_transaction+0xb70/0xb70
	Jul 22 11:39:53 nebtest kernel: [ 9280.047178][ T4484]  kthread+0x1f7/0x220
	Jul 22 11:39:53 nebtest kernel: [ 9280.048376][ T4484]  ? kthread_create_worker_on_cpu+0xc0/0xc0
	Jul 22 11:39:53 nebtest kernel: [ 9280.050106][ T4484]  ret_from_fork+0x3a/0x50
	Jul 22 11:39:53 nebtest kernel: [ 9280.051344][ T4484] irq event stamp: 61013914
	Jul 22 11:39:53 nebtest kernel: [ 9280.052582][ T4484] hardirqs last  enabled at (61013913): [<ffffffff86204292>] console_unlock+0x572/0x720
	Jul 22 11:39:53 nebtest kernel: [ 9280.055322][ T4484] hardirqs last disabled at (61013914): [<ffffffff86005bc6>] trace_hardirqs_off_thunk+0x1a/0x1c
	Jul 22 11:39:53 nebtest kernel: [ 9280.058048][ T4484] softirqs last  enabled at (61013904): [<ffffffff87c0049b>] __do_softirq+0x49b/0x5e9
	Jul 22 11:39:53 nebtest kernel: [ 9280.061075][ T4484] softirqs last disabled at (61013895): [<ffffffff86128e32>] irq_exit+0x112/0x120
	Jul 22 11:39:53 nebtest kernel: [ 9280.064024][ T4484] ---[ end trace ec182f6ce07c2376 ]---

EIP is btrfs_abort_transaction, no surprise there:

	(gdb) l *(cleanup_transaction+0x113)
	0xffffffff81889bd3 is in cleanup_transaction (fs/btrfs/transaction.c:1894).
	1889            struct btrfs_fs_info *fs_info = trans->fs_info;
	1890            struct btrfs_transaction *cur_trans = trans->transaction;
	1891
	1892            WARN_ON(refcount_read(&trans->use_count) > 1);
	1893
	1894            btrfs_abort_transaction(trans, err);
	1895
	1896            spin_lock(&fs_info->trans_lock);
	1897
	1898            /*

These are the patches I have in the 5.7.9 kernel (cherry-picked from
linus/master and kdave/misc-next):

	btrfs: add comments for btrfs_reserve_flush_enum
	btrfs: relocation: review the call sites which can be interrupted by signal
	btrfs: avoid possible signal interruption of btrfs_drop_snapshot() on relocation tree
	btrfs: relocation: allow signal to cancel balance
	btrfs: reloc: clear DEAD_RELOC_TREE bit for orphan roots to prevent runaway balance

Note that I've been testing "clear DEAD_RELOC_TREE bit" since May
without incident.
