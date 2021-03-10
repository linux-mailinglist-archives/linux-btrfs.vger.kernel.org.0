Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 696FF3345BD
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Mar 2021 18:53:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233373AbhCJRwy convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Wed, 10 Mar 2021 12:52:54 -0500
Received: from james.kirk.hungrycats.org ([174.142.39.145]:43356 "EHLO
        james.kirk.hungrycats.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233191AbhCJRww (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 10 Mar 2021 12:52:52 -0500
Received: by james.kirk.hungrycats.org (Postfix, from userid 1002)
        id 3B4B29C438C; Wed, 10 Mar 2021 12:52:51 -0500 (EST)
Date:   Wed, 10 Mar 2021 12:52:51 -0500
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     Filipe Manana <fdmanana@gmail.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Subject: Re: misc-next a646ddc2bba2: kernel BUG at fs/btrfs/ctree.c:1210!
 tree mod log
Message-ID: <20210310175250.GO32440@hungrycats.org>
References: <20210227155037.GN28049@hungrycats.org>
 <CAL3q7H6UbqwM+vbxNDpLKq7Ld1+Z1MrQr3v6s21QtSF8Ro+ePw@mail.gmail.com>
 <20210305010809.GQ28049@hungrycats.org>
 <CAL3q7H4+bEHCgLdScTKFzLFYsh-yxazD+G4FsWv0RappeAgAZQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <CAL3q7H4+bEHCgLdScTKFzLFYsh-yxazD+G4FsWv0RappeAgAZQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Mar 05, 2021 at 12:45:08PM +0000, Filipe Manana wrote:
> On Fri, Mar 5, 2021 at 1:08 AM Zygo Blaxell
> <ce3g8jdj@umail.furryterror.org> wrote:
> >
> > On Tue, Mar 02, 2021 at 04:24:19PM +0000, Filipe Manana wrote:
> > > On Sat, Feb 27, 2021 at 3:53 PM Zygo Blaxell
> > > <ce3g8jdj@umail.furryterror.org> wrote:
> > > >
> > > > Hit this twice so far, while running the usual
> > > > balance/dedupe/rsync/snapshots/all at once on:
> > > >
> > > >         a646ddc2bba2 (kdave-gitlab/misc-next) btrfs: unlock extents in btrfs_zero_range in case of quota reservation errors
> > > >
> > > > Looks like tree mod log bugs are back (or never went away?).
> > >
> > > Different bugs causing similar problems.
> > >
> > > Try this:   https://pastebin.com/VkesNs4R
> >
> > I put that patch on top of a646ddc2bba2 and ran it on the same test VM
> > for a few days.  It has now reached its previous uptime record without
> > incident.
> >
> > It looks like a good fix.  I'll leave it running for a few days more to
> > be sure.
> 
> Great!
> 
> Ok, so that seems to confirm what I suspected and made me run into
> other sorts of weirdness during logical ino calls (returning
> unexpected results).
> I haven't hit the BUG_ON() as you do, but if this is indeed caused by
> allowing to reuse unwritten extent buffers in the same transaction,
> it's no wonder that BUG_ON() and many other weird issues happen.
> 
> Can you now try the following version?
> 
> https://pastebin.com/raw/5VHjzdn6
> 
> Leave it for at least as many days as you tested the previous patch,
> hell, even a week or more if you can.

Just to clean up the email thread:

The new patch (5VHjzdn6) has now run 87 hours on top of the original
misc-next a646ddc2bba2, exceeding the best uptime without a patch by
about 30 hours.

Now that I read this again, I notice I forgot to ask if you wanted the new
patch instead of the old one, or on top of it.  I guess it doesn't matter
now--I ran each one separately and they both worked for my test case.

> Thanks, much appreciated.
> 
> >
> > Thanks!
> >
> > > Thanks.
> > >
> > > >
> > > >         [40422.398920][T28995] BTRFS info (device dm-0): balance: canceled
> > > >         [40607.394003][T11577] BTRFS info (device dm-0): balance: start -dlimit=9
> > > >         [40607.398597][T11577] BTRFS info (device dm-0): relocating block group 315676950528 flags data
> > > >         [40643.279661][T11577] BTRFS info (device dm-0): found 12686 extents, loops 1, stage: move data extents
> > > >         [40692.752695][T11577] BTRFS info (device dm-0): found 12686 extents, loops 2, stage: update data pointers
> > > >         [40704.860522][T11577] BTRFS info (device dm-0): relocating block group 314603208704 flags data
> > > >         [40704.919977][T19054] ------------[ cut here ]------------
> > > >         [40704.921895][T19054] kernel BUG at fs/btrfs/ctree.c:1210!
> > > >         [40704.923497][T19054] invalid opcode: 0000 [#1] SMP KASAN PTI
> > > >         [40704.925549][T19054] CPU: 1 PID: 19054 Comm: crawl_335 Tainted: G        W         5.11.0-2d11c0084b02-misc-next+ #89
> > > >         [40704.929192][T19054] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.12.0-1 04/01/2014
> > > >         [40704.931640][T19054] RIP: 0010:__tree_mod_log_rewind+0x3b1/0x3c0
> > > >         [40704.933301][T19054] Code: 05 48 8d 74 10 65 ba 19 00 00 00 e8 89 f3 06 00 e9 a7 fd ff ff 4c 8d 7b 2c 4c 89 ff e8 f8 bd c8 ff 48 63 43 2c e9 a2 fe ff ff <0f> 0b 0f 0b 66 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 55 48
> > > >         [40704.938566][T19054] RSP: 0018:ffffc90001eb70b8 EFLAGS: 00010297
> > > >         [40704.940483][T19054] RAX: 0000000000000000 RBX: ffff88812344e400 RCX: ffffffffb28933b6
> > > >         [40704.942668][T19054] RDX: 0000000000000007 RSI: dffffc0000000000 RDI: ffff88812344e42c
> > > >         [40704.945002][T19054] RBP: ffffc90001eb7108 R08: 1ffff11020b60a20 R09: ffffed1020b60a20
> > > >         [40704.948513][T19054] R10: ffff888105b050f9 R11: ffffed1020b60a1f R12: 00000000000000ee
> > > >         [40704.951601][T19054] R13: ffff8880195520c0 R14: ffff8881bc958500 R15: ffff88812344e42c
> > > >         [40704.954607][T19054] FS:  00007fd1955e8700(0000) GS:ffff8881f5600000(0000) knlGS:0000000000000000
> > > >         [40704.957704][T19054] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > >         [40704.960125][T19054] CR2: 00007efdb7928718 CR3: 000000010103a006 CR4: 0000000000170ee0
> > > >         [40704.963186][T19054] Call Trace:
> > > >         [40704.964229][T19054]  btrfs_search_old_slot+0x265/0x10d0
> > > >         [40704.967068][T19054]  ? lock_acquired+0xbb/0x600
> > > >         [40704.969148][T19054]  ? btrfs_search_slot+0x1090/0x1090
> > > >         [40704.971106][T19054]  ? free_extent_buffer.part.61+0xd7/0x140
> > > >         [40704.973020][T19054]  ? free_extent_buffer+0x13/0x20
> > > >         [40704.974537][T19054]  resolve_indirect_refs+0x3e9/0xfc0
> > > >         [40704.976154][T19054]  ? lock_downgrade+0x3d0/0x3d0
> > > >         [40704.977602][T19054]  ? __kasan_check_read+0x11/0x20
> > > >         [40704.980765][T19054]  ? add_prelim_ref.part.11+0x150/0x150
> > > >         [40704.983136][T19054]  ? lock_downgrade+0x3d0/0x3d0
> > > >         [40704.985206][T19054]  ? __kasan_check_read+0x11/0x20
> > > >         [40704.987403][T19054]  ? lock_acquired+0xbb/0x600
> > > >         [40704.989309][T19054]  ? __kasan_check_write+0x14/0x20
> > > >         [40704.991385][T19054]  ? do_raw_spin_unlock+0xa8/0x140
> > > >         [40704.993454][T19054]  ? rb_insert_color+0x30/0x360
> > > >         [40704.995402][T19054]  ? prelim_ref_insert+0x12d/0x430
> > > >         [40704.997247][T19054]  find_parent_nodes+0x5c3/0x1830
> > > >         [40704.999305][T19054]  ? resolve_indirect_refs+0xfc0/0xfc0
> > > >         [40705.000951][T19054]  ? lock_release+0xc8/0x620
> > > >         [40705.002748][T19054]  ? fs_reclaim_acquire+0x67/0xf0
> > > >         [40705.004753][T19054]  ? lock_acquire+0xc7/0x510
> > > >         [40705.006233][T19054]  ? lock_downgrade+0x3d0/0x3d0
> > > >         [40705.007683][T19054]  ? lockdep_hardirqs_on_prepare+0x160/0x210
> > > >         [40705.009677][T19054]  ? lock_release+0xc8/0x620
> > > >         [40705.011405][T19054]  ? fs_reclaim_acquire+0x67/0xf0
> > > >         [40705.012937][T19054]  ? lock_acquire+0xc7/0x510
> > > >         [40705.014293][T19054]  ? poison_range+0x38/0x40
> > > >         [40705.015635][T19054]  ? unpoison_range+0x14/0x40
> > > >         [40705.017166][T19054]  ? trace_hardirqs_on+0x55/0x120
> > > >         [40705.018827][T19054]  btrfs_find_all_roots_safe+0x142/0x1e0
> > > >         [40705.020610][T19054]  ? find_parent_nodes+0x1830/0x1830
> > > >         [40705.022573][T19054]  ? btrfs_inode_flags_to_xflags+0x50/0x50
> > > >         [40705.024743][T19054]  iterate_extent_inodes+0x20e/0x580
> > > >         [40705.026839][T19054]  ? tree_backref_for_extent+0x230/0x230
> > > >         [40705.029021][T19054]  ? lock_downgrade+0x3d0/0x3d0
> > > >         [40705.030432][T19054]  ? read_extent_buffer+0xdd/0x110
> > > >         [40705.031909][T19054]  ? lock_downgrade+0x3d0/0x3d0
> > > >         [40705.033274][T19054]  ? __kasan_check_read+0x11/0x20
> > > >         [40705.034782][T19054]  ? lock_acquired+0xbb/0x600
> > > >         [40705.036234][T19054]  ? __kasan_check_write+0x14/0x20
> > > >         [40705.037670][T19054]  ? _raw_spin_unlock+0x22/0x30
> > > >         [40705.039014][T19054]  ? __kasan_check_write+0x14/0x20
> > > >         [40705.040419][T19054]  iterate_inodes_from_logical+0x129/0x170
> > > >         [40705.044668][T19054]  ? iterate_inodes_from_logical+0x129/0x170
> > > >         [40705.047340][T19054]  ? btrfs_inode_flags_to_xflags+0x50/0x50
> > > >         [40705.049936][T19054]  ? iterate_extent_inodes+0x580/0x580
> > > >         [40705.051938][T19054]  ? __vmalloc_node+0x92/0xb0
> > > >         [40705.053270][T19054]  ? init_data_container+0x34/0xb0
> > > >         [40705.054903][T19054]  ? init_data_container+0x34/0xb0
> > > >         [40705.056876][T19054]  ? kvmalloc_node+0x60/0x80
> > > >         [40705.058372][T19054]  btrfs_ioctl_logical_to_ino+0x158/0x230
> > > >         [40705.060233][T19054]  btrfs_ioctl+0x205e/0x4040
> > > >         [40705.061465][T19054]  ? __might_sleep+0x71/0xe0
> > > >         [40705.063108][T19054]  ? btrfs_ioctl_get_supported_features+0x30/0x30
> > > >         [40705.065188][T19054]  ? getrusage+0x4b6/0x9c0
> > > >         [40705.066678][T19054]  ? __kasan_check_read+0x11/0x20
> > > >         [40705.071937][T19054]  ? lock_release+0xc8/0x620
> > > >         [40705.075584][T19054]  ? __might_fault+0x64/0xd0
> > > >         [40705.084175][T19054]  ? lock_acquire+0xc7/0x510
> > > >         [40705.091566][T19054]  ? lock_downgrade+0x3d0/0x3d0
> > > >         [40705.095180][T19054]  ? lockdep_hardirqs_on_prepare+0x210/0x210
> > > >         [40705.099880][T19054]  ? lockdep_hardirqs_on_prepare+0x210/0x210
> > > >         [40705.101645][T19054]  ? __kasan_check_read+0x11/0x20
> > > >         [40705.103977][T19054]  ? do_vfs_ioctl+0xfc/0x9d0
> > > >         [40705.105936][T19054]  ? ioctl_file_clone+0xe0/0xe0
> > > >         [40705.107658][T19054]  ? lock_downgrade+0x3d0/0x3d0
> > > >         [40705.109423][T19054]  ? lockdep_hardirqs_on_prepare+0x210/0x210
> > > >         [40705.119233][T19054]  ? __kasan_check_read+0x11/0x20
> > > >         [40705.123581][T19054]  ? lock_release+0xc8/0x620
> > > >         [40705.125226][T19054]  ? __task_pid_nr_ns+0xd3/0x250
> > > >         [40705.126984][T19054]  ? lock_acquire+0xc7/0x510
> > > >         [40705.128678][T19054]  ? __fget_files+0x160/0x230
> > > >         [40705.130365][T19054]  ? __fget_light+0xf2/0x110
> > > >         [40705.131959][T19054]  __x64_sys_ioctl+0xc3/0x100
> > > >         [40705.133637][T19054]  do_syscall_64+0x37/0x80
> > > >         [40705.138627][T19054]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> > > >         [40705.140552][T19054] RIP: 0033:0x7fd1976e2427
> > > >         [40705.142005][T19054] Code: 00 00 90 48 8b 05 69 aa 0c 00 64 c7 00 26 00 00 00 48 c7 c0 ff ff ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 b8 10 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 39 aa 0c 00 f7 d8 64 89 01 48
> > > >         [40705.148519][T19054] RSP: 002b:00007fd1955e5cf8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
> > > >         [40705.151247][T19054] RAX: ffffffffffffffda RBX: 00007fd1955e5f40 RCX: 00007fd1976e2427
> > > >         [40705.153903][T19054] RDX: 00007fd1955e5f48 RSI: 00000000c038943b RDI: 0000000000000004
> > > >         [40705.156554][T19054] RBP: 0000000001000000 R08: 0000000000000000 R09: 00007fd1955e6120
> > > >         [40705.159228][T19054] R10: 0000557835366b00 R11: 0000000000000246 R12: 0000000000000004
> > > >         [40705.161902][T19054] R13: 00007fd1955e5f48 R14: 00007fd1955e5f40 R15: 00007fd1955e5ef8
> > > >         [40705.164567][T19054] Modules linked in:
> > > >         [40705.165991][T19054] ---[ end trace ec8931a1c36e57be ]---
> > > >
> > > >         (gdb) l *(__tree_mod_log_rewind+0x3b1)
> > > >         0xffffffff81893521 is in __tree_mod_log_rewind (fs/btrfs/ctree.c:1210).
> > > >         1205                     * the modification. as we're going backwards, we do the
> > > >         1206                     * opposite of each operation here.
> > > >         1207                     */
> > > >         1208                    switch (tm->op) {
> > > >         1209                    case MOD_LOG_KEY_REMOVE_WHILE_FREEING:
> > > >         1210                            BUG_ON(tm->slot < n);
> > > >         1211                            fallthrough;
> > > >         1212                    case MOD_LOG_KEY_REMOVE_WHILE_MOVING:
> > > >         1213                    case MOD_LOG_KEY_REMOVE:
> > > >         1214                            btrfs_set_node_key(eb, &tm->key, tm->slot);
> > >
> > >
> > >
> > > --
> > > Filipe David Manana,
> > >
> > > “Whether you think you can, or you think you can't — you're right.”
> > >
> 
> 
> 
> -- 
> Filipe David Manana,
> 
> “Whether you think you can, or you think you can't — you're right.”
