Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 290FD473801
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Dec 2021 23:51:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237106AbhLMWvS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 13 Dec 2021 17:51:18 -0500
Received: from drax.kayaks.hungrycats.org ([174.142.148.226]:46086 "EHLO
        drax.kayaks.hungrycats.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240755AbhLMWvS (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 13 Dec 2021 17:51:18 -0500
Received: by drax.kayaks.hungrycats.org (Postfix, from userid 1002)
        id 38B58DE6FC; Mon, 13 Dec 2021 17:51:08 -0500 (EST)
Date:   Mon, 13 Dec 2021 17:51:08 -0500
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     Libor =?utf-8?B?S2xlcMOhxI0=?= <libor.klepac@bcom.cz>
Cc:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: Btrfs lockups on ubuntu with bees
Message-ID: <YbfOXO3ZPEXLB397@hungrycats.org>
References: <c9f1640177563f545ef70eb6ec1560faa1bb1bd7.camel@bcom.cz>
 <20211209044438.GO17148@hungrycats.org>
 <6b1f34700075ef5256800edfe2c486fee36902d6.camel@bcom.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6b1f34700075ef5256800edfe2c486fee36902d6.camel@bcom.cz>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Dec 09, 2021 at 09:23:53AM +0000, Libor Klepáč wrote:
> Hi,
> thanks for looking into it.
> More bellow
> 
> On St, 2021-12-08 at 23:44 -0500, Zygo Blaxell wrote:
> > On Fri, Nov 26, 2021 at 02:36:30PM +0000, Libor Klepáč wrote:
> > > Hi, .....
> > > 
> > > Any clue what can be done?
> > 
> > I am currently hitting this bug on all kernel versions starting from
> > 5.11.
> > Test runs end with the filesystem locked up, 100% CPU usage in bees
> > and the following lockdep dump:
> > 
> >         [Wed Dec  8 14:14:03 2021] Linux version 5.11.22-zb64-
> > e4d48558d24c+ (zblaxell@waya) (gcc (Debian 10.2.1-6) 10.2.1 20210110,
> > GNU ld (GNU Binutils for Debian) 2.37) #1 SMP Sun Dec 5 04:18:31 EST
> > 2021
> > 
> >         [Wed Dec  8 23:17:32 2021] sysrq: Show Locks Held
> >         [Wed Dec  8 23:17:32 2021] 
> >                                    Showing all locks held in the
> > system:
> >         [Wed Dec  8 23:17:32 2021] 1 lock held by in:imklog/3603:
> >         [Wed Dec  8 23:17:32 2021] 1 lock held by dmesg/3720:
> >         [Wed Dec  8 23:17:32 2021]  #0: ffff8a1406ac80e0 (&user-
> > >lock){+.+.}-{3:3}, at: devkmsg_read+0x4d/0x320
> >         [Wed Dec  8 23:17:32 2021] 3 locks held by bash/3721:
> >         [Wed Dec  8 23:17:32 2021]  #0: ffff8a142a589498
> > (sb_writers#4){.+.+}-{0:0}, at: ksys_write+0x70/0xf0
> >         [Wed Dec  8 23:17:32 2021]  #1: ffffffff98f199a0
> > (rcu_read_lock){....}-{1:2}, at: __handle_sysrq+0x5/0xa0
> >         [Wed Dec  8 23:17:32 2021]  #2: ffffffff98f199a0
> > (rcu_read_lock){....}-{1:2}, at: debug_show_all_locks+0x23/0x187
> >         [Wed Dec  8 23:17:32 2021] 1 lock held by btrfs-
> > transacti/6161:
> >         [Wed Dec  8 23:17:32 2021]  #0: ffff8a14e0178850 (&fs_info-
> > >transaction_kthread_mutex){+.+.}-{3:3}, at:
> > transaction_kthread+0x5a/0x1b0
> >         [Wed Dec  8 23:17:32 2021] 3 locks held by
> > crawl_257_265/6491:
> >         [Wed Dec  8 23:17:32 2021] 3 locks held by
> > crawl_257_291/6494:
> >         [Wed Dec  8 23:17:32 2021]  #0: ffff8a14bd092498
> > (sb_writers#12){.+.+}-{0:0}, at: vfs_dedupe_file_range_one+0x3b/0x180
> >         [Wed Dec  8 23:17:32 2021]  #1: ffff8a1410d7c848 (&sb-
> > >s_type->i_mutex_key#17){+.+.}-{3:3}, at:
> > lock_two_nondirectories+0x6b/0x70
> >         [Wed Dec  8 23:17:32 2021]  #2: ffff8a14161a39c8 (&sb-
> > >s_type->i_mutex_key#17/4){+.+.}-{3:3}, at:
> > lock_two_nondirectories+0x59/0x70
> >         [Wed Dec  8 23:17:32 2021] 4 locks held by
> > crawl_257_292/6502:
> >         [Wed Dec  8 23:17:32 2021]  #0: ffff8a14bd092498
> > (sb_writers#12){.+.+}-{0:0}, at: vfs_dedupe_file_range_one+0x3b/0x180
> >         [Wed Dec  8 23:17:32 2021]  #1: ffff8a131637a908 (&sb-
> > >s_type->i_mutex_key#17){+.+.}-{3:3}, at:
> > lock_two_nondirectories+0x6b/0x70
> >         [Wed Dec  8 23:17:32 2021]  #2: ffff8a14161a39c8 (&sb-
> > >s_type->i_mutex_key#17/4){+.+.}-{3:3}, at:
> > lock_two_nondirectories+0x59/0x70
> >         [Wed Dec  8 23:17:32 2021]  #3: ffff8a14bd0926b8
> > (sb_internal#2){.+.+}-{0:0}, at: btrfs_start_transaction+0x1e/0x20
> >         [Wed Dec  8 23:17:32 2021] 2 locks held by
> > crawl_257_293/6503:
> >         [Wed Dec  8 23:17:32 2021]  #0: ffff8a14bd092498
> > (sb_writers#12){.+.+}-{0:0}, at: vfs_dedupe_file_range_one+0x3b/0x180
> >         [Wed Dec  8 23:17:32 2021]  #1: ffff8a14161a39c8 (&sb-
> > >s_type->i_mutex_key#17){+.+.}-{3:3}, at:
> > btrfs_remap_file_range+0x2eb/0x3c0
> >         [Wed Dec  8 23:17:32 2021] 3 locks held by
> > crawl_256_289/6504:
> >         [Wed Dec  8 23:17:32 2021]  #0: ffff8a14bd092498
> > (sb_writers#12){.+.+}-{0:0}, at: vfs_dedupe_file_range_one+0x3b/0x180
> >         [Wed Dec  8 23:17:32 2021]  #1: ffff8a140f2c4748 (&sb-
> > >s_type->i_mutex_key#17){+.+.}-{3:3}, at:
> > lock_two_nondirectories+0x6b/0x70
> >         [Wed Dec  8 23:17:32 2021]  #2: ffff8a14161a39c8 (&sb-
> > >s_type->i_mutex_key#17/4){+.+.}-{3:3}, at:
> > lock_two_nondirectories+0x59/0x70
> > 
> >         [Wed Dec  8 23:17:32 2021]
> > =============================================
> > 
> > There's only one commit touching vfs_dedupe_file_range_one
> > between v5.10 and v5.15 (3078d85c9a10 "vfs: verify source area in
> > vfs_dedupe_file_range_one()"), so I'm now testing 5.11 with that
> > commit
> > reverted to see if it introduced a regression.
> > 
> 
> Lockup happened also at second customer, where we tried to use this
> solution.
> Good news is, that when we stop bees, it does not happen again and
> btrfs scrub says, that all data are ok.
> Bad news is, we will run out of disk space soon ;)

Downgrading to 5.10.82 seems to work around the issue (probably also
.83 and .84 too, but we have more testing hours on .82).

> Are you interested in trace from kernel? I saved it, but i don't know,
> if it's the same as before.

Sure.

> Thanks,
> Libor
> 
> 
> 
> > > We would really like to use btrfs for this use case, because
> > > nakivo,
> > > with this type of repository format, needs to be se to do full
> > > backup
> > > every x days and does not do deduplication on its own.
> > > 
> > > 
> > > With regards,
> > > Libor
> > > 
