Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AB4434D967
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 Mar 2021 23:06:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231421AbhC2VGF convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Mon, 29 Mar 2021 17:06:05 -0400
Received: from james.kirk.hungrycats.org ([174.142.39.145]:32952 "EHLO
        james.kirk.hungrycats.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231158AbhC2VF7 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 29 Mar 2021 17:05:59 -0400
Received: by james.kirk.hungrycats.org (Postfix, from userid 1002)
        id D3BD79F09B9; Mon, 29 Mar 2021 17:05:48 -0400 (EDT)
Date:   Mon, 29 Mar 2021 17:05:48 -0400
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     Bas Hulsken <bas.hulsken@gmail.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: help needed with raid 6 filesystem with errors
Message-ID: <20210329210548.GR32440@hungrycats.org>
References: <aa80858116f3a23484dfcb001088d1dfa5e3c55a.camel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <aa80858116f3a23484dfcb001088d1dfa5e3c55a.camel@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Mar 29, 2021 at 02:03:06PM +0200, Bas Hulsken wrote:
> Dear list,

> due to a disk intermittently failing in my 4 disk array, I'm getting
> "transid verify failed" errors on my btrfs filesystem (see attached
> dmesg | grep -i btrfs dump in btrfs_dmesg.txt). 

Scary!  But in this case, it looks like they were automatically recovered
already.

> When I run a scrub,
> the bad disk (/dev/sdd) becomes unresponsive, so I'm hesitant to try
> that again (happened 3 times now, and was the root cause of the transid
> verify failed errors possibly, at least they did not show up earlier
> than the failed scrub). 

That is quite common when disks fail.  The extra IO load results in a
firmware crash, either due to failure of the electronics disrupting the
embedded CPU so it can't run any program correctly, or an error condition
in the rest of the disk that the firmware doesn't handle properly.
Any unflushed writes in the write cache at this time are lost.  Lost
metadata writes will result in parent transid verify failures later on.

Low end desktop drives have very large SCTERC timeouts but no SCTERC
controls, so they have very long IO error retry loops (2 minutes).
That can look like an intermittent failure in the logs, but in fact it's
an ordinary remappable UNC sector.  The kernel has a default timeout
of 30 seconds, so the kernel forces a drive reset before the drive can
report the bad block.  The drive can often be used normally by setting
the kernel timeout with 'echo 180 > /sys/block/sd.../device/timeout'.

Whether you _want_ to use a disk with firmware that waits two full
minutes before reporting an IO error is a separate question, but this
is a feature of several popular cheap drive models, and you _can_ use
these disks if needed.

> A new disk is on it's way to use btrfs replace,
> but I'm not sure whehter that will be a wise choice for a filesystem
> with errors. There was never a crash/power failure, so the filesystem
> was unmounted at every reboot, but as said on 3 occasions (after a
> scrub), that unmount was with on of the four drives unresponsive.

Note that 

	1.  in the logs each distinct bytenr occurs exactly once (more
	precisely, "not more than N - 1 times for a RAID profile with
	N copies"), and

	2.  it is immediately followed by 4x "read error corrected"

e.g.

> [38079.437411] BTRFS error (device sdg): parent transid verify failed on 12884760723456 wanted 360620 found 359101                                      
> [38079.457879] BTRFS info (device sdg): read error corrected: ino 0 off 12884760723456 (dev /dev/sdd sector 12559526656)                               
> [38079.459418] BTRFS info (device sdg): read error corrected: ino 0 off 12884760727552 (dev /dev/sdd sector 12559526664)                                
> [38079.460390] BTRFS info (device sdg): read error corrected: ino 0 off 12884760731648 (dev /dev/sdd sector 12559526672)                               
> [38079.460585] BTRFS info (device sdg): read error corrected: ino 0 off 12884760735744 (dev /dev/sdd sector 12559526680)                                

Metadata pages are 16K by default, and filesystem pages are 4K on
amd64/x86/arm/aarch64, so these 4 "read error corrected" lines are btrfs
replacing one broken metadata page on sdd using data from other mirrors.

If you are using raid1* metadata, this is part of normal recovery from
a disk failure.

The failing disk will not be keeping up with metadata updates (because
it's failing, you can't assume it will be doing anything correctly).
Writes will be lost on sdd that are not lost on the other mirror drives.
btrfs will continue without error as long as at least one mirror drive
is OK.  btrfs will notice during later reads that some metadata pages
are not up to date on the failing disk, and correct the failing disk
using redundant copies of the metadata from the other mirrors.

Similar correction is applied to data when the csums do not match.

nodatacow files (which do not have csums) will be corrupted.  That is
part of the cost of nodatacow--no recovery from data corruption errors.

> Funnily enough, after a reboot every time the filesystem gets mounted
> without issues (the unresponsive drive is back online), and btrfs
> check --readonly claims the filesystem has no errors (see attached
> btrfs_sdd_check.txt).

There's no error on the disk by the time you run btrfs check or reboot and
mount again.  "read error corrected" means correct data was written back
to the failing disk.  With UNC sector remapping in disk firmware, btrfs
could even repair the UNC sector so the disk is no longer failing.
The only hint would be "Reallocated sector count" in SMART stats--and
only if you are lucky enough to have that count reported accurately by
your drive firmware.

Possibly there are still error errors on disk, but btrfs check didn't
happen to read that particular block from that particular mirror.
btrfs check won't verify the contents of every mirror are correct--that
is what scrub is for.  If btrfs check passes, it means at least one
usable copy has been found for every metadata page in the filesystem.
Scrub can handle all remaining errors.

> There are 20 unique "transid very failed" errors, I've dumped
> all the blocks, but that file is too large to attach here,
> see https://steadydecline.net/public/btrfs_dump_failed_transid_blocks.txt),
> the super is in the attached btrfs_sdd_dump_super.txt
>
> Not sure what to do next, so seeking your advice! The important data
> on the drive is backed up, and I'll be running a verify to see if
> there are any corruptions overnight. Would still like to try to save
> the filesystem if possible though.

Replace the disk as usual.  There's no indication of unrecoverable
metadata failure.  btrfs found some damage on the failing disk, but
repaired it automatically.

Run 'btrfs replace' to reconstruct the content of the failing drive
on the new one.  Run a scrub after that's done to make sure all errors
were corrected (or identify damaged raid6 data blocks if they were not),
then resume your normal scrubbing schedule.

If possible, try keeping the old disk online during the replace operation,
in case there are errors on other disks too.  Use 'btrfs replace -r'
to prefer to read from other disks, and only use the failing disk as
a last resort.  Don't try too hard--a failing disk is a failing disk,
so if it's really broken, then let it go.

There is raid6 in this filesystem, so this list of bugs applies:

	https://lore.kernel.org/linux-btrfs/20200627030614.GW10769@hungrycats.org/

btrfs replace may hang a few times during recovery.  Reboot to work around
that bug (btrfs-replace-wrong-state-after-exit and btrfs-replace-lockup).

You may lose a few data blocks here and there (a "few" meaning about
"one in ten thousand corrupted blocks").  You can identify which data
blocks using scrub, or simply try to read all files and note any
IO errors encountered.  Delete the broken files and replace their
content from backups to work around that bug (read-repair-failure,
parity-update-failure).

> best regards,
> Bas
> 

> superblock: bytenr=65536, device=/dev/sdd
> ---------------------------------------------------------
> csum_type		1 (xxhash64)
> csum_size		8
> csum			0x3de224bec6584bb7 [match]
> bytenr			65536
> flags			0x1
> 			( WRITTEN )
> magic			_BHRfS_M [match]
> fsid			fce03447-ad88-4891-b91f-390665fcd5e7
> metadata_uuid		fce03447-ad88-4891-b91f-390665fcd5e7
> label			homedirs
> generation		368950
> root			12883568295936
> sys_array_size		193
> chunk_root_generation	367570
> root_level		1
> chunk_root		23134208
> chunk_root_level	1
> log_root		0
> log_root_transid	0
> log_root_level		0
> total_bytes		32006252888064
> bytes_used		13410457739264
> sectorsize		4096
> nodesize		16384
> leafsize (deprecated)	16384
> stripesize		4096
> root_dir		6
> num_devices		4
> compat_flags		0x0
> compat_ro_flags		0x0
> incompat_flags		0x9e1
> 			( MIXED_BACKREF |
> 			  BIG_METADATA |
> 			  EXTENDED_IREF |
> 			  RAID56 |
> 			  SKINNY_METADATA |
> 			  RAID1C34 )
> cache_generation	368950
> uuid_tree_generation	368950
> dev_item.uuid		691827bd-b866-42ad-b0c0-eb81a4bfcfeb
> dev_item.fsid		fce03447-ad88-4891-b91f-390665fcd5e7 [match]
> dev_item.type		0
> dev_item.total_bytes	8001563222016
> dev_item.bytes_used	6774245556224
> dev_item.io_align	4096
> dev_item.io_width	4096
> dev_item.sector_size	4096
> dev_item.devid		3
> dev_item.dev_group	0
> dev_item.seek_speed	0
> dev_item.bandwidth	0
> dev_item.generation	0
> sys_chunk_array[2048]:
> 	item 0 key (FIRST_CHUNK_TREE CHUNK_ITEM 22020096)
> 		length 8388608 owner 2 stripe_len 65536 type SYSTEM|RAID1C4
> 		io_align 65536 io_width 65536 sector_size 4096
> 		num_stripes 4 sub_stripes 1
> 			stripe 0 devid 1 offset 22020096
> 			dev_uuid 9c8b19be-c344-4be0-9726-34bf674d0349
> 			stripe 1 devid 2 offset 1048576
> 			dev_uuid 0542bb91-9989-4155-aec2-3baf0d848675
> 			stripe 2 devid 3 offset 1048576
> 			dev_uuid 691827bd-b866-42ad-b0c0-eb81a4bfcfeb
> 			stripe 3 devid 4 offset 1048576
> 			dev_uuid 51f99a35-7fca-4f38-8469-5fa12a1623a7
> backup_roots[4]:
> 	backup 0:
> 		backup_tree_root:	12883564068864	gen: 368949	level: 1
> 		backup_chunk_root:	23134208	gen: 367570	level: 1
> 		backup_extent_root:	12883562348544	gen: 368949	level: 2
> 		backup_fs_root:		12883557957632	gen: 368949	level: 2
> 		backup_dev_root:	12883678691328	gen: 367580	level: 1
> 		backup_csum_root:	12883558776832	gen: 368949	level: 3
> 		backup_total_bytes:	32006252888064
> 		backup_bytes_used:	13410457206784
> 		backup_num_devices:	4
> 
> 	backup 1:
> 		backup_tree_root:	12883568295936	gen: 368950	level: 1
> 		backup_chunk_root:	23134208	gen: 367570	level: 1
> 		backup_extent_root:	12883566575616	gen: 368950	level: 2
> 		backup_fs_root:		12883559759872	gen: 368950	level: 2
> 		backup_dev_root:	12883678691328	gen: 367580	level: 1
> 		backup_csum_root:	12883560382464	gen: 368950	level: 3
> 		backup_total_bytes:	32006252888064
> 		backup_bytes_used:	13410457739264
> 		backup_num_devices:	4
> 
> 	backup 2:
> 		backup_tree_root:	12883564462080	gen: 368947	level: 1
> 		backup_chunk_root:	23134208	gen: 367570	level: 1
> 		backup_extent_root:	12883563347968	gen: 368947	level: 2
> 		backup_fs_root:		12883555663872	gen: 368947	level: 2
> 		backup_dev_root:	12883678691328	gen: 367580	level: 1
> 		backup_csum_root:	12883562217472	gen: 368947	level: 3
> 		backup_total_bytes:	32006252888064
> 		backup_bytes_used:	13410457006080
> 		backup_num_devices:	4
> 
> 	backup 3:
> 		backup_tree_root:	12883566510080	gen: 368948	level: 1
> 		backup_chunk_root:	23134208	gen: 367570	level: 1
> 		backup_extent_root:	12883559759872	gen: 368948	level: 2
> 		backup_fs_root:		12883553746944	gen: 368948	level: 2
> 		backup_dev_root:	12883678691328	gen: 367580	level: 1
> 		backup_csum_root:	12883555434496	gen: 368948	level: 3
> 		backup_total_bytes:	32006252888064
> 		backup_bytes_used:	13410457116672
> 		backup_num_devices:	4
> 
> 

> [    0.864538] Btrfs loaded, crc32c=crc32c-generic, zoned=yes
> [   13.368410] BTRFS: device label homedirs devid 2 transid 367206 /dev/sde scanned by systemd-udevd (644)
> [   13.379691] BTRFS: device label homedirs devid 3 transid 367206 /dev/sdd scanned by systemd-udevd (646)
> [   13.382411] BTRFS: device label homedirs devid 4 transid 367206 /dev/sdc scanned by systemd-udevd (648)
> [   13.398436] BTRFS: device label homedirs devid 1 transid 367206 /dev/sdg scanned by systemd-udevd (652)
> [   13.750256] BTRFS info (device sdg): disk space caching is enabled
> [   13.750260] BTRFS info (device sdg): has skinny extents
> [   14.710747] BTRFS info (device sdg): bdev /dev/sdg errs: wr 0, rd 1, flush 0, corrupt 0, gen 0
> [   14.712675] BTRFS info (device sdg): bdev /dev/sde errs: wr 0, rd 0, flush 0, corrupt 23, gen 0
> [   14.714555] BTRFS info (device sdg): bdev /dev/sdd errs: wr 74390652, rd 1756348, flush 189, corrupt 37082, gen 21
> [   25.444099] BTRFS info (device sdg): checking UUID tree
> [ 5585.543078] BTRFS info (device sdg): scrub: started on devid 3
> [ 5661.646404] BTRFS error (device sdg): bdev /dev/sdd errs: wr 74390652, rd 1756348, flush 189, corrupt 37083, gen 21
> [ 5661.681282] BTRFS error (device sdg): unable to fixup (regular) error at logical 10102571008 on dev /dev/sdd
> [ 6001.726239] BTRFS info (device sdg): scrub: not finished on devid 3 with status: -125
> [ 6365.446732] BTRFS error (device sdg): parent transid verify failed on 12887115939840 wanted 359811 found 359779
> [ 6365.458935] BTRFS info (device sdg): read error corrected: ino 0 off 12887115939840 (dev /dev/sdd sector 12564126688)
> [ 6365.460173] BTRFS info (device sdg): read error corrected: ino 0 off 12887115943936 (dev /dev/sdd sector 12564126696)
> [ 6365.461201] BTRFS info (device sdg): read error corrected: ino 0 off 12887115948032 (dev /dev/sdd sector 12564126704)
> [ 6365.461472] BTRFS info (device sdg): read error corrected: ino 0 off 12887115952128 (dev /dev/sdd sector 12564126712)
> [ 6369.607540] BTRFS error (device sdg): parent transid verify failed on 12002143010816 wanted 357838 found 357635
> [ 6369.627007] BTRFS info (device sdg): read error corrected: ino 0 off 12002143010816 (dev /dev/sdd sector 11747925056)
> [ 6369.627946] BTRFS info (device sdg): read error corrected: ino 0 off 12002143014912 (dev /dev/sdd sector 11747925064)
> [ 6369.629425] BTRFS info (device sdg): read error corrected: ino 0 off 12002143019008 (dev /dev/sdd sector 11747925072)
> [ 6369.630019] BTRFS info (device sdg): read error corrected: ino 0 off 12002143023104 (dev /dev/sdd sector 11747925080)
> [ 6369.906563] BTRFS error (device sdg): parent transid verify failed on 12887116201984 wanted 359811 found 359780
> [ 6369.907822] BTRFS info (device sdg): read error corrected: ino 0 off 12887116201984 (dev /dev/sdd sector 12564127200)
> [ 6369.908297] BTRFS info (device sdg): read error corrected: ino 0 off 12887116206080 (dev /dev/sdd sector 12564127208)
> [ 6370.082144] BTRFS error (device sdg): parent transid verify failed on 12887116251136 wanted 359811 found 359780
> [ 6370.085084] BTRFS error (device sdg): parent transid verify failed on 12887116365824 wanted 359811 found 359780
> [ 6378.874360] BTRFS error (device sdg): parent transid verify failed on 12002146205696 wanted 357838 found 357635
> [ 6378.896865] BTRFS info (device sdg): read error corrected: ino 0 off 12002146205696 (dev /dev/sdd sector 11747931296)
> [ 6378.899224] BTRFS info (device sdg): read error corrected: ino 0 off 12002146209792 (dev /dev/sdd sector 11747931304)
> [ 6378.900376] BTRFS info (device sdg): read error corrected: ino 0 off 12002146213888 (dev /dev/sdd sector 11747931312)
> [ 6378.901048] BTRFS info (device sdg): read error corrected: ino 0 off 12002146217984 (dev /dev/sdd sector 11747931320)
> [ 6378.901332] BTRFS error (device sdg): parent transid verify failed on 12002146467840 wanted 357838 found 357635
> [ 6378.901890] BTRFS info (device sdg): read error corrected: ino 0 off 12002146467840 (dev /dev/sdd sector 11747931808)
> [ 6378.902122] BTRFS info (device sdg): read error corrected: ino 0 off 12002146471936 (dev /dev/sdd sector 11747931816)
> [ 6378.902318] BTRFS info (device sdg): read error corrected: ino 0 off 12002146476032 (dev /dev/sdd sector 11747931824)
> [ 6378.902525] BTRFS info (device sdg): read error corrected: ino 0 off 12002146480128 (dev /dev/sdd sector 11747931832)
> [ 6378.915275] BTRFS error (device sdg): parent transid verify failed on 12002147631104 wanted 357838 found 357635
> [ 6378.923147] BTRFS info (device sdg): read error corrected: ino 0 off 12002147631104 (dev /dev/sdd sector 11747934080)
> [ 6378.923804] BTRFS info (device sdg): read error corrected: ino 0 off 12002147635200 (dev /dev/sdd sector 11747934088)
> [ 6378.992162] BTRFS error (device sdg): parent transid verify failed on 12002146959360 wanted 357838 found 357635
> [ 6378.997017] BTRFS error (device sdg): parent transid verify failed on 12002147155968 wanted 357838 found 357635
> [ 6379.133024] BTRFS error (device sdg): parent transid verify failed on 12002146385920 wanted 357838 found 357635
> [ 6379.137035] BTRFS error (device sdg): parent transid verify failed on 12002146402304 wanted 357838 found 357635
> [ 6380.140516] BTRFS error (device sdg): parent transid verify failed on 12002146123776 wanted 357838 found 357635
> [ 6380.680832] BTRFS error (device sdg): parent transid verify failed on 12002240020480 wanted 357838 found 357635
> [13673.751319] BTRFS info (device sdg): scrub: started on devid 3
> [16826.036404] BTRFS info (device sdg): scrub: not finished on devid 3 with status: -125
> [23638.218998] BTRFS info (device sdg): disk space caching is enabled
> [23638.220428] BTRFS info (device sdg): has skinny extents
> [23639.167931] BTRFS info (device sdg): bdev /dev/sdg errs: wr 0, rd 1, flush 0, corrupt 0, gen 0
> [23639.169393] BTRFS info (device sdg): bdev /dev/sde errs: wr 0, rd 0, flush 0, corrupt 23, gen 0
> [23639.170871] BTRFS info (device sdg): bdev /dev/sdd errs: wr 74390652, rd 1756348, flush 189, corrupt 37083, gen 21
> [38079.437411] BTRFS error (device sdg): parent transid verify failed on 12884760723456 wanted 360620 found 359101
> [38079.457879] BTRFS info (device sdg): read error corrected: ino 0 off 12884760723456 (dev /dev/sdd sector 12559526656)
> [38079.459418] BTRFS info (device sdg): read error corrected: ino 0 off 12884760727552 (dev /dev/sdd sector 12559526664)
> [38079.460390] BTRFS info (device sdg): read error corrected: ino 0 off 12884760731648 (dev /dev/sdd sector 12559526672)
> [38079.460585] BTRFS info (device sdg): read error corrected: ino 0 off 12884760735744 (dev /dev/sdd sector 12559526680)
> [38221.384604] BTRFS error (device sdg): parent transid verify failed on 12887984144384 wanted 357793 found 357612
> [38221.402557] BTRFS info (device sdg): read error corrected: ino 0 off 12887984144384 (dev /dev/sdd sector 12565822400)
> [38221.404162] BTRFS info (device sdg): read error corrected: ino 0 off 12887984148480 (dev /dev/sdd sector 12565822408)
> [38221.404757] BTRFS info (device sdg): read error corrected: ino 0 off 12887984152576 (dev /dev/sdd sector 12565822416)
> [38221.405024] BTRFS info (device sdg): read error corrected: ino 0 off 12887984156672 (dev /dev/sdd sector 12565822424)
> [65806.904757] BTRFS error (device sdg): parent transid verify failed on 12884812627968 wanted 360627 found 359022
> [65806.918919] BTRFS info (device sdg): read error corrected: ino 0 off 12884812627968 (dev /dev/sdd sector 12559628032)
> [65806.920934] BTRFS info (device sdg): read error corrected: ino 0 off 12884812632064 (dev /dev/sdd sector 12559628040)
> [65806.922112] BTRFS info (device sdg): read error corrected: ino 0 off 12884812636160 (dev /dev/sdd sector 12559628048)
> [65806.922728] BTRFS info (device sdg): read error corrected: ino 0 off 12884812640256 (dev /dev/sdd sector 12559628056)
> [70219.837853] BTRFS warning (device sdg): csum failed root 5 ino 13004600 off 1388544 csum 0x89644c3d02062469 expected csum 0x006926a7eef0358f mirror 1
> [70219.841358] BTRFS error (device sdg): bdev /dev/sdd errs: wr 74390652, rd 1756348, flush 189, corrupt 37084, gen 21
> [70219.843858] BTRFS info (device sdg): read error corrected: ino 13004600 off 1388544 (dev /dev/sdd sector 8499704456)
> [70219.858611] BTRFS warning (device sdg): csum failed root 5 ino 13004600 off 1384448 csum 0x3281ab5806ee6c8f expected csum 0xf81ccd9e0fd3faa6 mirror 1
> [70219.862320] BTRFS error (device sdg): bdev /dev/sdd errs: wr 74390652, rd 1756348, flush 189, corrupt 37085, gen 21
> [70219.864440] BTRFS info (device sdg): read error corrected: ino 13004600 off 1384448 (dev /dev/sdd sector 8499704448)
> [85509.387364] BTRFS error (device sdg): parent transid verify failed on 12887136485376 wanted 359811 found 359594
> [85509.410871] BTRFS info (device sdg): read error corrected: ino 0 off 12887136485376 (dev /dev/sdd sector 12564166816)
> [85509.413277] BTRFS info (device sdg): read error corrected: ino 0 off 12887136489472 (dev /dev/sdd sector 12564166824)
> [85509.415928] BTRFS info (device sdg): read error corrected: ino 0 off 12887136493568 (dev /dev/sdd sector 12564166832)
> [85509.418011] BTRFS info (device sdg): read error corrected: ino 0 off 12887136497664 (dev /dev/sdd sector 12564166840)
> [86025.084757] BTRFS error (device sdg): parent transid verify failed on 12887142547456 wanted 359802 found 359785
> [86025.103698] BTRFS info (device sdg): read error corrected: ino 0 off 12887142547456 (dev /dev/sdd sector 12564178656)
> [86025.105889] BTRFS info (device sdg): read error corrected: ino 0 off 12887142551552 (dev /dev/sdd sector 12564178664)
> [86025.108065] BTRFS info (device sdg): read error corrected: ino 0 off 12887142555648 (dev /dev/sdd sector 12564178672)
> [86025.110341] BTRFS info (device sdg): read error corrected: ino 0 off 12887142559744 (dev /dev/sdd sector 12564178680)
> [89093.407662] BTRFS error (device sdg): parent transid verify failed on 12886944956416 wanted 357751 found 357579
> [89093.423399] BTRFS info (device sdg): read error corrected: ino 0 off 12886944956416 (dev /dev/sdd sector 12563792736)
> [89093.424792] BTRFS info (device sdg): read error corrected: ino 0 off 12886944960512 (dev /dev/sdd sector 12563792744)
> [89093.425905] BTRFS info (device sdg): read error corrected: ino 0 off 12886944964608 (dev /dev/sdd sector 12563792752)
> [89093.426976] BTRFS info (device sdg): read error corrected: ino 0 off 12886944968704 (dev /dev/sdd sector 12563792760)

> [1/7] checking root items
> [2/7] checking extents
> [3/7] checking free space cache
> [4/7] checking fs roots
> [5/7] checking only csums items (without verifying data)
> [6/7] checking root refs
> [7/7] checking quota groups skipped (not enabled on this FS)
> Opening filesystem to check...
> Checking filesystem on /dev/sdd
> UUID: fce03447-ad88-4891-b91f-390665fcd5e7
> found 13364248408064 bytes used, no error found
> total csum bytes: 26044304216
> total tree bytes: 29511155712
> total fs tree bytes: 1468596224
> total extent tree bytes: 232357888
> btree space waste bytes: 1737736698
> file data blocks allocated: 13545978748928
>  referenced 13336378105856

