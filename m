Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBEB3483AD4
	for <lists+linux-btrfs@lfdr.de>; Tue,  4 Jan 2022 04:09:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232504AbiADDJw convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Mon, 3 Jan 2022 22:09:52 -0500
Received: from drax.kayaks.hungrycats.org ([174.142.148.226]:33194 "EHLO
        drax.kayaks.hungrycats.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232503AbiADDJv (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 3 Jan 2022 22:09:51 -0500
Received: by drax.kayaks.hungrycats.org (Postfix, from userid 1002)
        id 7EA8B13709D; Mon,  3 Jan 2022 22:09:50 -0500 (EST)
Date:   Mon, 3 Jan 2022 22:09:50 -0500
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     Libor =?utf-8?B?S2xlcMOhxI0=?= <libor.klepac@bcom.cz>
Cc:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: Btrfs lockups on ubuntu with bees
Message-ID: <YdO6fnInJNMjlHkw@hungrycats.org>
References: <c9f1640177563f545ef70eb6ec1560faa1bb1bd7.camel@bcom.cz>
 <20211209044438.GO17148@hungrycats.org>
 <5f1f3114281659c7869cb3f8aa4016c85f2b47cb.camel@bcom.cz>
 <Yc9ZBE8lioRZY0cB@hungrycats.org>
 <8767d98bb4c9d705ac1fd00d27e93684d39d0cfd.camel@bcom.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <8767d98bb4c9d705ac1fd00d27e93684d39d0cfd.camel@bcom.cz>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Jan 03, 2022 at 10:47:08AM +0000, Libor Klepáč wrote:
> Hi,
> 
> On Pá, 2021-12-31 at 14:24 -0500, Zygo Blaxell wrote:
> > On Fri, Dec 24, 2021 at 11:40:56AM +0000, Libor Klepáč wrote:
> > > Hi, i think, we hit it on 5.10.x
> > 
> > Over the last week I've hit it every ~400 machine-hours on 5.10.80+
> > as well.  Compare to once every ~3 machine-hours for kernels after
> > 5.11-rc1.
> > 
> 
> What if i try to restart beesd every day. Should it help to avoid
> lockup?

Test results so far indicates it's a kernel issue that doesn't depend on
prior state, i.e. every Nth logical_ino or dedupe call, the kernel will
lock up.  N is pretty large (100 million or so on 5.10).  You can hit
the bug after 22 days of continuous beesing, or you can hit it in the
first 5 minutes, because it's behavior is stateless and random.

> > It does get worse when there is more contention for various locks,
> > so more bees threads or a different distribution of work between the
> > threads will reproduce it faster.
> 
> Ok, i will try to lower number of threads, if it helps

Lowering the number of threads reduces the number of dedupe/logical_ino
calls per second, so the rate at which you hit the Nth call gets slower.
It also reduces dedupe performance.  Anything that makes bees faster
seems to make the kernel crash more often.

> Thanks,
> 
> Libor
> 
> 
> > 
> > > Not sure what version is it
> > > Linux nakivo 5.10.0-051000-generic #202012132330 SMP Sun Dec 13
> > > 23:33:36 UTC 2020 x86_64 x86_64 x86_64 GNU/Linux
> > > 
> > > It is taken from
> > > https://kernel.ubuntu.com/~kernel-ppa/mainline/v5.10/
> > > 
> > > Maybe i should go for specific version like
> > > https://kernel.ubuntu.com/~kernel-ppa/mainline/v5.10.88/
> > > 
> > > It was running fine for few days with bees doing it's job.
> > > One thing i changed yesterday was changing
> > > --loadavg-target 5
> > > to
> > > --loadavg-target 6
> > > (VM has 6 virtual CPUs)
> > > 
> > > Here is trace from machine
> > > https://download.bcom.cz/btrfs/trace6.txt
> > > 
> > > Thanks,
> > > Libor
> > > 
> > > On St, 2021-12-08 at 23:44 -0500, Zygo Blaxell wrote:
> > > > On Fri, Nov 26, 2021 at 02:36:30PM +0000, Libor Klepáč wrote:
> > > > > Hi,
> > > > > we are trying to use btrfs with compression and deduplication
> > > > > using
> > > > > bees to host filesystem for nakivo repository.
> > > > > Nakivo repository is in "incremental with full backups" format
> > > > > -
> > > > > ie.
> > > > > one file per VM snapshot transferred from vmware, full backup
> > > > > every
> > > > > x
> > > > > days, no internal deduplication. 
> > > > > We have also disabled internal compression in nakivo repository
> > > > > and
> > > > > put
> > > > > compression-force=zstd:13 on filesystem.
> > > > > 
> > > > > It's a VM on vmware 6.7.0 Update 3 (Build 17700523) on Dell
> > > > > R540.
> > > > > It has 6vCPU, 16GB of ram.
> > > > > 
> > > > > Bees is run with this parameters
> > > > > OPTIONS="--strip-paths --no-timestamps --verbose 5 --loadavg-
> > > > > target
> > > > > 5 
> > > > > --thread-min 1"
> > > > > DB_SIZE=$((8*1024*1024*1024)) # 8G in bytes
> > > > > 
> > > > > 
> > > > > 
> > > > > Until today it was running ubuntu provided kernel 5.11.0-
> > > > > 40.44~20.04.2
> > > > > (not sure about exact upstream version),
> > > > > today we switched to 5.13.0-21.21~20.04.1 after first crash.
> > > > > 
> > > > > It was working ok for 7+days, all data were in (around 10TB),
> > > > > so i
> > > > > started bees. 
> > > > > It now locks the FS, bees runs on 100% CPU, i cannot enter
> > > > > directory
> > > > > with btrfs
> > > > > 
> > > > > # btrfs filesystem usage /mnt/btrfs/repo02/
> > > > > Overall:
> > > > >     Device size:                  20.00TiB
> > > > >     Device allocated:             10.88TiB
> > > > >     Device unallocated:            9.12TiB
> > > > >     Device missing:                  0.00B
> > > > >     Used:                         10.87TiB
> > > > >     Free (estimated):              9.13TiB      (min: 4.57TiB)
> > > > >     Data ratio:                       1.00
> > > > >     Metadata ratio:                   1.00
> > > > >     Global reserve:              512.00MiB      (used: 0.00B)
> > > > > 
> > > > > Data,single: Size:10.85TiB, Used:10.83TiB (99.91%)
> > > > >    /dev/sdd       10.85TiB
> > > > > 
> > > > > Metadata,single: Size:35.00GiB, Used:34.71GiB (99.17%)
> > > > >    /dev/sdd       35.00GiB
> > > > > 
> > > > > System,DUP: Size:32.00MiB, Used:1.14MiB (3.56%)
> > > > >    /dev/sdd       64.00MiB
> > > > > 
> > > > > Unallocated:
> > > > >    /dev/sdd        9.12TiB
> > > > > 
> > > > > This happened yesterday on kernel 5.11
> > > > > https://download.bcom.cz/btrfs/trace1.txt
> > > > > 
> > > > > This is today, on 5.13
> > > > > https://download.bcom.cz/btrfs/trace2.txt
> > > > > 
> > > > > this is trace from sysrq later, when i noticed it happened
> > > > > again
> > > > > https://download.bcom.cz/btrfs/trace3.txt
> > > > > 
> > > > > 
> > > > > Any clue what can be done?
> > > > 
> > > > I am currently hitting this bug on all kernel versions starting
> > > > from
> > > > 5.11.
> > > > Test runs end with the filesystem locked up, 100% CPU usage in
> > > > bees
> > > > and the following lockdep dump:
> > > > 
> > > >         [Wed Dec  8 14:14:03 2021] Linux version 5.11.22-zb64-
> > > > e4d48558d24c+ (zblaxell@waya) (gcc (Debian 10.2.1-6) 10.2.1
> > > > 20210110,
> > > > GNU ld (GNU Binutils for Debian) 2.37) #1 SMP Sun Dec 5 04:18:31
> > > > EST
> > > > 2021
> > > > 
> > > >         [Wed Dec  8 23:17:32 2021] sysrq: Show Locks Held
> > > >         [Wed Dec  8 23:17:32 2021] 
> > > >                                    Showing all locks held in the
> > > > system:
> > > >         [Wed Dec  8 23:17:32 2021] 1 lock held by in:imklog/3603:
> > > >         [Wed Dec  8 23:17:32 2021] 1 lock held by dmesg/3720:
> > > >         [Wed Dec  8 23:17:32 2021]  #0: ffff8a1406ac80e0 (&user-
> > > > > lock){+.+.}-{3:3}, at: devkmsg_read+0x4d/0x320
> > > >         [Wed Dec  8 23:17:32 2021] 3 locks held by bash/3721:
> > > >         [Wed Dec  8 23:17:32 2021]  #0: ffff8a142a589498
> > > > (sb_writers#4){.+.+}-{0:0}, at: ksys_write+0x70/0xf0
> > > >         [Wed Dec  8 23:17:32 2021]  #1: ffffffff98f199a0
> > > > (rcu_read_lock){....}-{1:2}, at: __handle_sysrq+0x5/0xa0
> > > >         [Wed Dec  8 23:17:32 2021]  #2: ffffffff98f199a0
> > > > (rcu_read_lock){....}-{1:2}, at: debug_show_all_locks+0x23/0x187
> > > >         [Wed Dec  8 23:17:32 2021] 1 lock held by btrfs-
> > > > transacti/6161:
> > > >         [Wed Dec  8 23:17:32 2021]  #0: ffff8a14e0178850
> > > > (&fs_info-
> > > > > transaction_kthread_mutex){+.+.}-{3:3}, at:
> > > > transaction_kthread+0x5a/0x1b0
> > > >         [Wed Dec  8 23:17:32 2021] 3 locks held by
> > > > crawl_257_265/6491:
> > > >         [Wed Dec  8 23:17:32 2021] 3 locks held by
> > > > crawl_257_291/6494:
> > > >         [Wed Dec  8 23:17:32 2021]  #0: ffff8a14bd092498
> > > > (sb_writers#12){.+.+}-{0:0}, at:
> > > > vfs_dedupe_file_range_one+0x3b/0x180
> > > >         [Wed Dec  8 23:17:32 2021]  #1: ffff8a1410d7c848 (&sb-
> > > > > s_type->i_mutex_key#17){+.+.}-{3:3}, at:
> > > > lock_two_nondirectories+0x6b/0x70
> > > >         [Wed Dec  8 23:17:32 2021]  #2: ffff8a14161a39c8 (&sb-
> > > > > s_type->i_mutex_key#17/4){+.+.}-{3:3}, at:
> > > > lock_two_nondirectories+0x59/0x70
> > > >         [Wed Dec  8 23:17:32 2021] 4 locks held by
> > > > crawl_257_292/6502:
> > > >         [Wed Dec  8 23:17:32 2021]  #0: ffff8a14bd092498
> > > > (sb_writers#12){.+.+}-{0:0}, at:
> > > > vfs_dedupe_file_range_one+0x3b/0x180
> > > >         [Wed Dec  8 23:17:32 2021]  #1: ffff8a131637a908 (&sb-
> > > > > s_type->i_mutex_key#17){+.+.}-{3:3}, at:
> > > > lock_two_nondirectories+0x6b/0x70
> > > >         [Wed Dec  8 23:17:32 2021]  #2: ffff8a14161a39c8 (&sb-
> > > > > s_type->i_mutex_key#17/4){+.+.}-{3:3}, at:
> > > > lock_two_nondirectories+0x59/0x70
> > > >         [Wed Dec  8 23:17:32 2021]  #3: ffff8a14bd0926b8
> > > > (sb_internal#2){.+.+}-{0:0}, at:
> > > > btrfs_start_transaction+0x1e/0x20
> > > >         [Wed Dec  8 23:17:32 2021] 2 locks held by
> > > > crawl_257_293/6503:
> > > >         [Wed Dec  8 23:17:32 2021]  #0: ffff8a14bd092498
> > > > (sb_writers#12){.+.+}-{0:0}, at:
> > > > vfs_dedupe_file_range_one+0x3b/0x180
> > > >         [Wed Dec  8 23:17:32 2021]  #1: ffff8a14161a39c8 (&sb-
> > > > > s_type->i_mutex_key#17){+.+.}-{3:3}, at:
> > > > btrfs_remap_file_range+0x2eb/0x3c0
> > > >         [Wed Dec  8 23:17:32 2021] 3 locks held by
> > > > crawl_256_289/6504:
> > > >         [Wed Dec  8 23:17:32 2021]  #0: ffff8a14bd092498
> > > > (sb_writers#12){.+.+}-{0:0}, at:
> > > > vfs_dedupe_file_range_one+0x3b/0x180
> > > >         [Wed Dec  8 23:17:32 2021]  #1: ffff8a140f2c4748 (&sb-
> > > > > s_type->i_mutex_key#17){+.+.}-{3:3}, at:
> > > > lock_two_nondirectories+0x6b/0x70
> > > >         [Wed Dec  8 23:17:32 2021]  #2: ffff8a14161a39c8 (&sb-
> > > > > s_type->i_mutex_key#17/4){+.+.}-{3:3}, at:
> > > > lock_two_nondirectories+0x59/0x70
> > > > 
> > > >         [Wed Dec  8 23:17:32 2021]
> > > > =============================================
> > > > 
> > > > There's only one commit touching vfs_dedupe_file_range_one
> > > > between v5.10 and v5.15 (3078d85c9a10 "vfs: verify source area in
> > > > vfs_dedupe_file_range_one()"), so I'm now testing 5.11 with that
> > > > commit
> > > > reverted to see if it introduced a regression.
> > > > 
> > > > > We would really like to use btrfs for this use case, because
> > > > > nakivo,
> > > > > with this type of repository format, needs to be se to do full
> > > > > backup
> > > > > every x days and does not do deduplication on its own.
> > > > > 
> > > > > 
> > > > > With regards,
> > > > > Libor
> > > > > 
