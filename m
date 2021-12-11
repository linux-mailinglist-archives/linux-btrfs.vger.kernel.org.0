Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC154471103
	for <lists+linux-btrfs@lfdr.de>; Sat, 11 Dec 2021 03:53:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234633AbhLKC5W (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 10 Dec 2021 21:57:22 -0500
Received: from drax.kayaks.hungrycats.org ([174.142.148.226]:37820 "EHLO
        drax.kayaks.hungrycats.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229886AbhLKC5W (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 10 Dec 2021 21:57:22 -0500
Received: by drax.kayaks.hungrycats.org (Postfix, from userid 1002)
        id 6E117D0776; Fri, 10 Dec 2021 21:53:45 -0500 (EST)
Date:   Fri, 10 Dec 2021 21:53:45 -0500
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     Lukas Pirl <btrfs@lukas-pirl.de>
Cc:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: Balance loop on "device delete missing"? (RAID 1, Linux 5.15,
 "found 1 extents, stage: update data pointers")
Message-ID: <20211211025344.GR17148@hungrycats.org>
References: <5a73c349971ff005640af3854667f492e0697724.camel@lukas-pirl.de>
 <f5766e3cb0e2b7bcf3ef45cb7b9a7f3ef96b07ce.camel@lukas-pirl.de>
 <20211202181152.GK17148@hungrycats.org>
 <d946882c8042f779cdccc8de59cc10166f77fb04.camel@lukas-pirl.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d946882c8042f779cdccc8de59cc10166f77fb04.camel@lukas-pirl.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Dec 10, 2021 at 02:28:28PM +0100, Lukas Pirl wrote:
> (friendly, humble re-post)
> 
> Hello Zygo,
> 
> it took me (and the disks) a while to report back; here we go:
> 
> On Thu, 2021-12-02 13:11 -0500, Zygo Blaxell wrote as excerpted:
> > > On Thu, 2021-11-25 19:06 +0100, Lukas Pirl wrote as excerpted:
> > > > Dear btrfs community,
> > > > 
> > > > this is another report of a probably endless balance which loops on
> > > > "found 1 extents, stage: update data pointers".
> > > > 
> > > > I observe it on a btrfs RAID 1 on around 7 luks-encrypted spinning
> > > > disks (more fs details below) used for storing cold data. One disk
> > > > failed physically. Now, I try to "btrfs device delete missing". The
> > > > operation runs forever (probably, waited more than 30 days, another
> > > > time more than 50 days).
> > > > 
> > > > dmesg says:
> > > > [      22:26] BTRFS info (device dm-1): relocating block group
> > > > 1109204664320
> > > > flags data|raid1
> > > > [      22:27] BTRFS info (device dm-1): found 4164 extents, stage: move
> > > > data
> > > > extents
> > > > [  +5.476247] BTRFS info (device dm-1): found 4164 extents, stage:
> > > > update
> > > > data pointers
> > > > [  +2.545299] BTRFS info (device dm-1): found 1 extents, stage: update
> > > > data
> > > > pointers
> > > > 
> > > > and then the last message repeats every ~ .25 seconds ("forever").
> > > > Memory and CPU usage are not excessive (most is IO wait, I assume).
> > > > 
> > > > What I have tried:
> > > > * Linux 4 (multiple minor versions, don't remember which exactly)
> > > > * Linux 5.10
> > > > * Linux 5.15
> > > > * btrfs-progs v5.15
> > > > * remove subvolues (before: ~ 200, after: ~ 90)
> > > > * free space cache v1, v2, none
> > > > * reboot, restart removal/balance (multiple times)
> > 
> > Does it always happen on the same block group?  If so, that points to
> > something lurking in your metadata.  If a reboot fixes it for one block
> > group and then it gets stuck on some other block group, it points to
> > an issue in kernel memory state.
> 
> Although I haven't paid attention to the block group number in the past,
> another run of ``btrfs dev del`` just now gave the same last block group
> number (1109204664320) before, presumably, looping.
> 
> > What do you get from 'btrfs check --readonly'?
> 
> $ btrfs check --readonly --mode lowmem /dev/disk/by-label/pool_16-03
> 
> [1/7] checking root items
> Opening filesystem to check...
> warning, device 6 is missing
> Checking filesystem on /dev/disk/by-label/pool_16-03
> UUID: 59301fea-434a-4c43-bb45-08fcfe8ce113
> [2/7] checking extents
> ERROR: extent[1109584044032, 8192] referencer count mismatch (root: 276,
> owner: 1154248, offset: 100401152) wanted: 1, have: 0
> ERROR: errors found in extent allocation tree or chunk allocation
> [3/7] checking free space tree
> [4/7] checking fs roots
> [5/7] checking only csums items (without verifying data)
> [6/7] checking root refs done with fs roots in lowmem mode, skipping
> [7/7] checking quota groups skipped (not enabled on this FS)
> found 4252313206784 bytes used, error(s) found
> total csum bytes: 4128183360
> total tree bytes: 25053184000
> total fs tree bytes: 16415014912
> total extent tree bytes: 3662594048
> btree space waste bytes: 4949241278
> file data blocks allocated: 8025128243200
>  referenced 7552211206144

OK that's not too bad, just one bad reference.

> So what can be done? ``check --repair``? Or too dangerous? :)

If you have backups are you are prepared to restore them, you can try
check --repair.

> Thanks for your help
> 
> Lukas
> 
> > > > ======================================================================
> > > > 
> > > > filesystem show
> > > > ===============
> > > > 
> > > > Label: 'pool_16-03'  uuid: 59301fea-434a-xxxx-bb45-08fcfe8ce113
> > > >         Total devices 8 FS bytes used 3.84TiB
> > > >         devid    1 size 931.51GiB used 592.00GiB path /dev/mapper/WD-
> > > > WCAU45xxxx03
> > > >         devid    3 size 1.82TiB used 1.37TiB path /dev/mapper/WD-
> > > > WCAZAFxxxx78
> > > >         devid    4 size 931.51GiB used 593.00GiB path /dev/mapper/WD-
> > > > WCC4J7xxxxSZ
> > > >         devid    5 size 1.82TiB used 1.46TiB path /dev/mapper/WD-
> > > > WCC4M2xxxxXH
> > > >         devid    7 size 931.51GiB used 584.00GiB path
> > > > /dev/mapper/S1xxxxJ3
> > > >         devid    9 size 2.73TiB used 2.28TiB path /dev/mapper/WD-
> > > > WCC4N3xxxx17
> > > >         devid   10 size 3.64TiB used 1.03TiB path /dev/mapper/WD-
> > > > WCC7K2xxxxNS
> > > >         *** Some devices missing
> > > > 
> > > > subvolumes
> > > > ==========
> > > > 
> > > > ~ 90, of which ~ 60 are read-only snapshots of the other ~ 30
> > > > 
> > > > filesystem usage
> > > > ================
> > > > 
> > > > Overall:
> > > >     Device size:                  12.74TiB
> > > >     Device allocated:              8.36TiB
> > > >     Device unallocated:            4.38TiB
> > > >     Device missing:                  0.00B
> > > >     Used:                          7.69TiB
> > > >     Free (estimated):              2.50TiB      (min: 2.50TiB)
> > > >     Free (statfs, df):             1.46TiB
> > > >     Data ratio:                       2.00
> > > >     Metadata ratio:                   2.00
> > > >     Global reserve:              512.00MiB      (used: 48.00KiB)
> > > >     Multiple profiles:                  no
> > > > 
> > > > Data,RAID1: Size:4.14TiB, Used:3.82TiB (92.33%)
> > > >    /dev/mapper/WD-WCAU45xxxx03   584.00GiB
> > > >    /dev/mapper/WD-WCAZAFxxxx78     1.35TiB
> > > >    /dev/mapper/WD-WCC4J7xxxxSZ   588.00GiB
> > > >    /dev/mapper/WD-WCC4M2xxxxXH     1.44TiB
> > > >    missing       510.00GiB
> > > >    /dev/mapper/S1xxxxJ3  579.00GiB
> > > >    /dev/mapper/WD-WCC4N3xxxx17     2.26TiB
> > > >    /dev/mapper/WD-WCC7K2xxxxNS     1.01TiB
> > > > 
> > > > Metadata,RAID1: Size:41.00GiB, Used:23.14GiB (56.44%)
> > > >    /dev/mapper/WD-WCAU45xxxx03     8.00GiB
> > > >    /dev/mapper/WD-WCAZAFxxxx78    17.00GiB
> > > >    /dev/mapper/WD-WCC4J7xxxxSZ     5.00GiB
> > > >    /dev/mapper/WD-WCC4M2xxxxXH    13.00GiB
> > > >    missing         3.00GiB
> > > >    /dev/mapper/S1xxxxJ3    5.00GiB
> > > >    /dev/mapper/WD-WCC4N3xxxx17    16.00GiB
> > > >    /dev/mapper/WD-WCC7K2xxxxNS    15.00GiB
> > > > 
> > > > System,RAID1: Size:32.00MiB, Used:848.00KiB (2.59%)
> > > >    missing        32.00MiB
> > > >    /dev/mapper/WD-WCC4N3xxxx17    32.00MiB
> > > > 
> > > > Unallocated:
> > > >    /dev/mapper/WD-WCAU45xxxx03   339.51GiB
> > > >    /dev/mapper/WD-WCAZAFxxxx78   461.01GiB
> > > >    /dev/mapper/WD-WCC4J7xxxxSZ   338.51GiB
> > > >    /dev/mapper/WD-WCC4M2xxxxXH   373.01GiB
> > > >    missing      -513.03GiB
> > > >    /dev/mapper/S1xxxxJ3  347.51GiB
> > > >    /dev/mapper/WD-WCC4N3xxxx17   460.47GiB
> > > >    /dev/mapper/WD-WCC7K2xxxxNS     2.61TiB
> > > > 
> > > > dump-super
> > > > ==========
> > > > 
> > > > superblock: bytenr=65536, device=/dev/mapper/WD-WCAU45xxxx03
> > > > ---------------------------------------------------------
> > > > csum_type               0 (crc32c)
> > > > csum_size               4
> > > > csum                    0x51beb068 [match]
> > > > bytenr                  65536
> > > > flags                   0x1
> > > >                         ( WRITTEN )
> > > > magic                   _BHRfS_M [match]
> > > > fsid                    59301fea-434a-xxxx-bb45-08fcfe8ce113
> > > > metadata_uuid           59301fea-434a-xxxx-bb45-08fcfe8ce113
> > > > label                   pool_16-03
> > > > generation              113519755
> > > > root                    15602414796800
> > > > sys_array_size          129
> > > > chunk_root_generation   63394299
> > > > root_level              1
> > > > chunk_root              19216820502528
> > > > chunk_root_level        1
> > > > log_root                0
> > > > log_root_transid        0
> > > > log_root_level          0
> > > > total_bytes             16003136864256
> > > > bytes_used              4227124142080
> > > > sectorsize              4096
> > > > nodesize                16384
> > > > leafsize (deprecated)   16384
> > > > stripesize              4096
> > > > root_dir                6
> > > > num_devices             8
> > > > compat_flags            0x0
> > > > compat_ro_flags         0x0
> > > > incompat_flags          0x371
> > > >                         ( MIXED_BACKREF |
> > > >                           COMPRESS_ZSTD |
> > > >                           BIG_METADATA |
> > > >                           EXTENDED_IREF |
> > > >                           SKINNY_METADATA |
> > > >                           NO_HOLES )
> > > > cache_generation        2975866
> > > > uuid_tree_generation    113519755
> > > > dev_item.uuid           a9b2e4ea-404c-xxxx-a450-dc84b0956ce1
> > > > dev_item.fsid           59301fea-434a-xxxx-bb45-08fcfe8ce113 [match]
> > > > dev_item.type           0
> > > > dev_item.total_bytes    1000201740288
> > > > dev_item.bytes_used     635655159808
> > > > dev_item.io_align       4096
> > > > dev_item.io_width       4096
> > > > dev_item.sector_size    4096
> > > > dev_item.devid          1
> > > > dev_item.dev_group      0
> > > > dev_item.seek_speed     0
> > > > dev_item.bandwidth      0
> > > > dev_item.generation     0
> > > > 
> > > > device stats
> > > > ============
> > > > 
> > > > [/dev/mapper/WD-WCAU45xxxx03].write_io_errs    0
> > > > [/dev/mapper/WD-WCAU45xxxx03].read_io_errs     0
> > > > [/dev/mapper/WD-WCAU45xxxx03].flush_io_errs    0
> > > > [/dev/mapper/WD-WCAU45xxxx03].corruption_errs  0
> > > > [/dev/mapper/WD-WCAU45xxxx03].generation_errs  0
> > > > [/dev/mapper/WD-WCAZAFxxxx78].write_io_errs    0
> > > > [/dev/mapper/WD-WCAZAFxxxx78].read_io_errs     0
> > > > [/dev/mapper/WD-WCAZAFxxxx78].flush_io_errs    0
> > > > [/dev/mapper/WD-WCAZAFxxxx78].corruption_errs  0
> > > > [/dev/mapper/WD-WCAZAFxxxx78].generation_errs  0
> > > > [/dev/mapper/WD-WCC4J7xxxxSZ].write_io_errs    0
> > > > [/dev/mapper/WD-WCC4J7xxxxSZ].read_io_errs     1
> > > > [/dev/mapper/WD-WCC4J7xxxxSZ].flush_io_errs    0
> > > > [/dev/mapper/WD-WCC4J7xxxxSZ].corruption_errs  0
> > > > [/dev/mapper/WD-WCC4J7xxxxSZ].generation_errs  0
> > > > [/dev/mapper/WD-WCC4M2xxxxXH].write_io_errs    0
> > > > [/dev/mapper/WD-WCC4M2xxxxXH].read_io_errs     0
> > > > [/dev/mapper/WD-WCC4M2xxxxXH].flush_io_errs    0
> > > > [/dev/mapper/WD-WCC4M2xxxxXH].corruption_errs  0
> > > > [/dev/mapper/WD-WCC4M2xxxxXH].generation_errs  0
> > > > [devid:6].write_io_errs    0
> > > > [devid:6].read_io_errs     0
> > > > [devid:6].flush_io_errs    0
> > > > [devid:6].corruption_errs  72016
> > > > [devid:6].generation_errs  100
> > > > [/dev/mapper/S1xxxxJ3].write_io_errs    0
> > > > [/dev/mapper/S1xxxxJ3].read_io_errs     0
> > > > [/dev/mapper/S1xxxxJ3].flush_io_errs    0
> > > > [/dev/mapper/S1xxxxJ3].corruption_errs  2
> > > > [/dev/mapper/S1xxxxJ3].generation_errs  0
> > > > [/dev/mapper/WD-WCC4N3xxxx17].write_io_errs    0
> > > > [/dev/mapper/WD-WCC4N3xxxx17].read_io_errs     0
> > > > [/dev/mapper/WD-WCC4N3xxxx17].flush_io_errs    0
> > > > [/dev/mapper/WD-WCC4N3xxxx17].corruption_errs  0
> > > > [/dev/mapper/WD-WCC4N3xxxx17].generation_errs  0
> > > > [/dev/mapper/WD-WCC7K2xxxxNS].write_io_errs    0
> > > > [/dev/mapper/WD-WCC7K2xxxxNS].read_io_errs     0
> > > > [/dev/mapper/WD-WCC7K2xxxxNS].flush_io_errs    0
> > > > [/dev/mapper/WD-WCC7K2xxxxNS].corruption_errs  0
> > > > [/dev/mapper/WD-WCC7K2xxxxNS].generation_errs  0
> > > 
> 
> 


