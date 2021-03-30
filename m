Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6301334EF42
	for <lists+linux-btrfs@lfdr.de>; Tue, 30 Mar 2021 19:21:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231743AbhC3RUq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 30 Mar 2021 13:20:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232404AbhC3RUU (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 30 Mar 2021 13:20:20 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36B19C061762
        for <linux-btrfs@vger.kernel.org>; Tue, 30 Mar 2021 10:20:19 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id x21so19104619eds.4
        for <linux-btrfs@vger.kernel.org>; Tue, 30 Mar 2021 10:20:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=3r5dvr/KkeDbgYT/acddr6HavYhLbtdRP3VySU3fQp0=;
        b=o+3btsZ4xecFqw65FxmuKrjwbp1nP7deZXaDPX+YfWQ7bYU0XcI1+f6zacBGe+p0K4
         G63i1t/s4l1I117hdHyjwYtQ4GMXFe17ESbnBXz8XHKv9nvSYRdZMzZahh2soNnrrYr0
         7ekI2M3pPNmJTWRlOIcTN1aHRoir29xr5bpnFUOrzDmYVL+6kygX+aOiqvILnsgAtEtO
         ikW3M/rWCv970hARp9r3JoiRt8nCI6JGOZJzmFuSc+UkH1HpORSoaWlGTxZaETjCbdoI
         DgbNj8XqhHkGKvVICaNiqrG+swUcYhm3cv/8MM/a4q0ct8RYz1dgdBcEyydiM7uyHCmc
         1Rjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=3r5dvr/KkeDbgYT/acddr6HavYhLbtdRP3VySU3fQp0=;
        b=blgOZAwaVXof2P4ZPCtlMaon6gVqP356bfGO3Oh768fLfv+NtZQnxQlX18bw9C8kwh
         YLi4midqCEfKxZ5tsk01dK1W2xSEpqDaki/NVmorFU26/0+oeDe1XaWT3voy0cdIg6aB
         FdfNwuQUnGnUELKAqDsbPhahd8CAowGegZJO/GLV7QI6AOi3to1e/7S3RC+kwLzMo9xH
         7gVSldNiwPETlBkMBOV9h8oMnjGgSQVEGtsJgaXUSle+GdXBMt9rZIYhaqkzcVpwdD5D
         lKDvLLqRF5Yu7x6dxmr7Eu8GbpwTcwe/RwEEyjMSMYAQAR7IGe1b7+C6tk3RXp9LWZ1u
         N36w==
X-Gm-Message-State: AOAM533PUqnckspv6ygKH8M51vED1L7GRtHV4zu8nnW06JAigwcPi4U/
        c/Ojb7iDjyyEzdJ7XHe3pdBw5g6phWaJnw==
X-Google-Smtp-Source: ABdhPJzCMLaRPO16XUIgT0JiTOokjoO4isWmc1+NdRPnK67HnFVTu4e6QkbmS5KT5IBrFBisHgnxzg==
X-Received: by 2002:a05:6402:22f6:: with SMTP id dn22mr34325058edb.214.1617124816910;
        Tue, 30 Mar 2021 10:20:16 -0700 (PDT)
Received: from bedroom.steadydecline.net (59234cb1.static.cust.trined.nl. [89.35.76.177])
        by smtp.gmail.com with ESMTPSA id m7sm11553434edp.81.2021.03.30.10.20.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Mar 2021 10:20:15 -0700 (PDT)
Message-ID: <31daa35f244c7d2b57a6e1fad90743fe6f50741e.camel@gmail.com>
Subject: Re: help needed with raid 6 filesystem with errors
From:   Bas Hulsken <bas.hulsken@gmail.com>
To:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
Cc:     linux-btrfs@vger.kernel.org
Date:   Tue, 30 Mar 2021 19:20:14 +0200
In-Reply-To: <20210330154625.GS32440@hungrycats.org>
References: <aa80858116f3a23484dfcb001088d1dfa5e3c55a.camel@gmail.com>
         <20210329210548.GR32440@hungrycats.org>
         <f5ea34792746e4b44b2ce2ba332c005b2325808d.camel@gmail.com>
         <20210330154625.GS32440@hungrycats.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, 2021-03-30 at 11:46 -0400, Zygo Blaxell wrote:
> On Tue, Mar 30, 2021 at 03:01:57PM +0200, Bas Hulsken wrote:
> > I followed your advice, Zygo and Chris, and did both:
> > 1) smartctl -l scterc,70,70 /dev/sdX for all 4 drives in the array
> > (the
> > drives do support this)
> > 2) echo 180 > /sys/block/sdX/device/timeout for all 4 drives
> > 
> > with that I attempted another scrub (on the single failing device,
> > not
> > on the filesystem), but with bad results again. The drive is
> > basically
> > still not responsive after the first error, this is the error
> > according
> > to smartctl:
> > 
> > Error 4 occurred at disk power-on lifetime: 7124 hours (296 days +
> > 20
> > hours)
> >   When the command that caused the error occurred, the device was
> > active or idle.
> > 
> >   After command completion occurred, registers were:
> >   ER ST SC SN CL CH DH
> >   -- -- -- -- -- -- --
> >   40 41 98 68 24 00 40  Error: UNC at LBA = 0x00002468 = 9320
> > 
> >   Commands leading to the command that caused the error were:
> >   CR FR SC SN CL CH DH DC   Powered_Up_Time  Command/Feature_Name
> >   -- -- -- -- -- -- -- --  ----------------  --------------------
> >   60 80 00 80 25 00 40 00   2d+20:57:19.109  READ FPDMA QUEUED
> >   60 80 f8 80 23 00 40 00   2d+20:57:16.423  READ FPDMA QUEUED
> >   60 80 f0 80 21 00 40 00   2d+20:57:16.422  READ FPDMA QUEUED
> >   60 80 e8 80 1f 00 40 00   2d+20:57:16.421  READ FPDMA QUEUED
> >   60 80 e0 80 1d 00 40 00   2d+20:57:16.420  READ FPDMA QUEUED
> > 
> > The other errors are all the same (Error: UNC at LBA = 0x00002468 =
> > 9320), and at exactly the same LBA, once scrub gets to this LBA,
> > the
> > drives basically no longer responds, and querying it with smartctl
> > will
> > return garbage characters, or nothing at all. I've attached a dmesg
> > with also the io errors this time.
> > 
> > So: I conclude scub is not going to fix this problem, and I should
> > really replace the disk.
> 
> Agreed.  It is now properly configured, there are UNC sectors logged
> in
> SMART, and UNC recovery is still not working.  The drive is broken
> and
> will likely stay that way.
> 
> > @Zygo: following your advice, and using btrfs replace -r with the
> > failing drive online, I take it it reads only sectors from the
> > failing
> > disk if at least 2 other disks are failing at that spot (given it's
> > raid6), correct? 
> 
> That's the general idea.
> 
> > If so I would be comfortable giving that a shot. I do
> > expect that while doing a replace and reading the same LBA from the
> > disk, it will just crash again and ruin my replace.
> 
> There's still another redundant disk in the array, so there's no need
> to
> put too much effort into recovering one failing drive.  The disk
> seems
> really broken, so take it offline and do a replace in degraded mode.

Thanks for the clear help and explanations, I have 2 final questions
(famous last words :-) )
1) In your earlier reply you mentioned known bugs, including the
"Spurious read errors in btrfs raid5 degraded mode". Would replacing
with "-r" while the faulty drive is still online not prevent this from
happening? Assuming the replace speed is similar to the scrub speed,
I'm looking at 4 days to replace the drive, would prefer if I could
keep using the filesystem while that happens.. otherwise wiping it and
restoring from backup might actually be the fastest option.
2) If I go the offline way, how would I actually do that? I do not see
a command in the btrfs manual to flag a disk as faulty, or any other
command to move into "degraded" mode. I could unplug it while power off
ofcourse, is that the best / only way?


> 
> > thanks!
> > 
> > 
> > On Mon, 2021-03-29 at 17:05 -0400, Zygo Blaxell wrote:
> > > On Mon, Mar 29, 2021 at 02:03:06PM +0200, Bas Hulsken wrote:
> > > > Dear list,
> > > 
> > > > due to a disk intermittently failing in my 4 disk array, I'm
> > > > getting
> > > > "transid verify failed" errors on my btrfs filesystem (see
> > > > attached
> > > > dmesg | grep -i btrfs dump in btrfs_dmesg.txt). 
> > > 
> > > Scary!  But in this case, it looks like they were automatically
> > > recovered
> > > already.
> > > 
> > > > When I run a scrub,
> > > > the bad disk (/dev/sdd) becomes unresponsive, so I'm hesitant
> > > > to try
> > > > that again (happened 3 times now, and was the root cause of the
> > > > transid
> > > > verify failed errors possibly, at least they did not show up
> > > > earlier
> > > > than the failed scrub). 
> > > 
> > > That is quite common when disks fail.  The extra IO load results
> > > in a
> > > firmware crash, either due to failure of the electronics
> > > disrupting the
> > > embedded CPU so it can't run any program correctly, or an error
> > > condition
> > > in the rest of the disk that the firmware doesn't handle
> > > properly.
> > > Any unflushed writes in the write cache at this time are lost. 
> > > Lost
> > > metadata writes will result in parent transid verify failures
> > > later on.
> > > 
> > > Low end desktop drives have very large SCTERC timeouts but no
> > > SCTERC
> > > controls, so they have very long IO error retry loops (2
> > > minutes).
> > > That can look like an intermittent failure in the logs, but in
> > > fact
> > > it's
> > > an ordinary remappable UNC sector.  The kernel has a default
> > > timeout
> > > of 30 seconds, so the kernel forces a drive reset before the
> > > drive can
> > > report the bad block.  The drive can often be used normally by
> > > setting
> > > the kernel timeout with 'echo 180 >
> > > /sys/block/sd.../device/timeout'.
> > > 
> > > Whether you _want_ to use a disk with firmware that waits two
> > > full
> > > minutes before reporting an IO error is a separate question, but
> > > this
> > > is a feature of several popular cheap drive models, and you _can_
> > > use
> > > these disks if needed.
> > > 
> > > > A new disk is on it's way to use btrfs replace,
> > > > but I'm not sure whehter that will be a wise choice for a
> > > > filesystem
> > > > with errors. There was never a crash/power failure, so the
> > > > filesystem
> > > > was unmounted at every reboot, but as said on 3 occasions
> > > > (after a
> > > > scrub), that unmount was with on of the four drives
> > > > unresponsive.
> > > 
> > > Note that 
> > > 
> > >         1.  in the logs each distinct bytenr occurs exactly once
> > > (more
> > >         precisely, "not more than N - 1 times for a RAID profile
> > > with
> > >         N copies"), and
> > > 
> > >         2.  it is immediately followed by 4x "read error
> > > corrected"
> > > 
> > > e.g.
> > > 
> > > > [38079.437411] BTRFS error (device sdg): parent transid verify
> > > > failed
> > > > on 12884760723456 wanted 360620 found
> > > > 359101                                      
> > > > [38079.457879] BTRFS info (device sdg): read error corrected:
> > > > ino 0
> > > > off 12884760723456 (dev /dev/sdd sector
> > > > 12559526656)                               
> > > > [38079.459418] BTRFS info (device sdg): read error corrected:
> > > > ino 0
> > > > off 12884760727552 (dev /dev/sdd sector
> > > > 12559526664)                                
> > > > [38079.460390] BTRFS info (device sdg): read error corrected:
> > > > ino 0
> > > > off 12884760731648 (dev /dev/sdd sector
> > > > 12559526672)                               
> > > > [38079.460585] BTRFS info (device sdg): read error corrected:
> > > > ino 0
> > > > off 12884760735744 (dev /dev/sdd sector
> > > > 12559526680)                                
> > > 
> > > Metadata pages are 16K by default, and filesystem pages are 4K on
> > > amd64/x86/arm/aarch64, so these 4 "read error corrected" lines
> > > are
> > > btrfs
> > > replacing one broken metadata page on sdd using data from other
> > > mirrors.
> > > 
> > > If you are using raid1* metadata, this is part of normal recovery
> > > from
> > > a disk failure.
> > > 
> > > The failing disk will not be keeping up with metadata updates
> > > (because
> > > it's failing, you can't assume it will be doing anything
> > > correctly).
> > > Writes will be lost on sdd that are not lost on the other mirror
> > > drives.
> > > btrfs will continue without error as long as at least one mirror
> > > drive
> > > is OK.  btrfs will notice during later reads that some metadata
> > > pages
> > > are not up to date on the failing disk, and correct the failing
> > > disk
> > > using redundant copies of the metadata from the other mirrors.
> > > 
> > > Similar correction is applied to data when the csums do not
> > > match.
> > > 
> > > nodatacow files (which do not have csums) will be corrupted. 
> > > That is
> > > part of the cost of nodatacow--no recovery from data corruption
> > > errors.
> > > 
> > > > Funnily enough, after a reboot every time the filesystem gets
> > > > mounted
> > > > without issues (the unresponsive drive is back online), and
> > > > btrfs
> > > > check --readonly claims the filesystem has no errors (see
> > > > attached
> > > > btrfs_sdd_check.txt).
> > > 
> > > There's no error on the disk by the time you run btrfs check or
> > > reboot
> > > and
> > > mount again.  "read error corrected" means correct data was
> > > written
> > > back
> > > to the failing disk.  With UNC sector remapping in disk firmware,
> > > btrfs
> > > could even repair the UNC sector so the disk is no longer
> > > failing.
> > > The only hint would be "Reallocated sector count" in SMART stats-
> > > -and
> > > only if you are lucky enough to have that count reported
> > > accurately by
> > > your drive firmware.
> > > 
> > > Possibly there are still error errors on disk, but btrfs check
> > > didn't
> > > happen to read that particular block from that particular mirror.
> > > btrfs check won't verify the contents of every mirror are
> > > correct--that
> > > is what scrub is for.  If btrfs check passes, it means at least
> > > one
> > > usable copy has been found for every metadata page in the
> > > filesystem.
> > > Scrub can handle all remaining errors.
> > > 
> > > > There are 20 unique "transid very failed" errors, I've dumped
> > > > all the blocks, but that file is too large to attach here,
> > > > see 
> > > > https://steadydecline.net/public/btrfs_dump_failed_transid_blocks.txt
> > > > ),
> > > > the super is in the attached btrfs_sdd_dump_super.txt
> > > > 
> > > > Not sure what to do next, so seeking your advice! The important
> > > > data
> > > > on the drive is backed up, and I'll be running a verify to see
> > > > if
> > > > there are any corruptions overnight. Would still like to try to
> > > > save
> > > > the filesystem if possible though.
> > > 
> > > Replace the disk as usual.  There's no indication of
> > > unrecoverable
> > > metadata failure.  btrfs found some damage on the failing disk,
> > > but
> > > repaired it automatically.
> > > 
> > > Run 'btrfs replace' to reconstruct the content of the failing
> > > drive
> > > on the new one.  Run a scrub after that's done to make sure all
> > > errors
> > > were corrected (or identify damaged raid6 data blocks if they
> > > were
> > > not),
> > > then resume your normal scrubbing schedule.
> > > 
> > > If possible, try keeping the old disk online during the replace
> > > operation,
> > > in case there are errors on other disks too.  Use 'btrfs replace
> > > -r'
> > > to prefer to read from other disks, and only use the failing disk
> > > as
> > > a last resort.  Don't try too hard--a failing disk is a failing
> > > disk,
> > > so if it's really broken, then let it go.
> > > 
> > > There is raid6 in this filesystem, so this list of bugs applies:
> > > 
> > >         
> > > https://lore.kernel.org/linux-btrfs/20200627030614.GW10769@hungrycats.org/
> > > 
> > > btrfs replace may hang a few times during recovery.  Reboot to
> > > work
> > > around
> > > that bug (btrfs-replace-wrong-state-after-exit and btrfs-replace-
> > > lockup).
> > > 
> > > You may lose a few data blocks here and there (a "few" meaning
> > > about
> > > "one in ten thousand corrupted blocks").  You can identify which
> > > data
> > > blocks using scrub, or simply try to read all files and note any
> > > IO errors encountered.  Delete the broken files and replace their
> > > content from backups to work around that bug (read-repair-
> > > failure,
> > > parity-update-failure).
> > > 
> > > > best regards,
> > > > Bas
> > > > 
> > > 
> > > > superblock: bytenr=65536, device=/dev/sdd
> > > > ---------------------------------------------------------
> > > > csum_type               1 (xxhash64)
> > > > csum_size               8
> > > > csum                    0x3de224bec6584bb7 [match]
> > > > bytenr                  65536
> > > > flags                   0x1
> > > >                         ( WRITTEN )
> > > > magic                   _BHRfS_M [match]
> > > > fsid                    fce03447-ad88-4891-b91f-390665fcd5e7
> > > > metadata_uuid           fce03447-ad88-4891-b91f-390665fcd5e7
> > > > label                   homedirs
> > > > generation              368950
> > > > root                    12883568295936
> > > > sys_array_size          193
> > > > chunk_root_generation   367570
> > > > root_level              1
> > > > chunk_root              23134208
> > > > chunk_root_level        1
> > > > log_root                0
> > > > log_root_transid        0
> > > > log_root_level          0
> > > > total_bytes             32006252888064
> > > > bytes_used              13410457739264
> > > > sectorsize              4096
> > > > nodesize                16384
> > > > leafsize (deprecated)   16384
> > > > stripesize              4096
> > > > root_dir                6
> > > > num_devices             4
> > > > compat_flags            0x0
> > > > compat_ro_flags         0x0
> > > > incompat_flags          0x9e1
> > > >                         ( MIXED_BACKREF |
> > > >                           BIG_METADATA |
> > > >                           EXTENDED_IREF |
> > > >                           RAID56 |
> > > >                           SKINNY_METADATA |
> > > >                           RAID1C34 )
> > > > cache_generation        368950
> > > > uuid_tree_generation    368950
> > > > dev_item.uuid           691827bd-b866-42ad-b0c0-eb81a4bfcfeb
> > > > dev_item.fsid           fce03447-ad88-4891-b91f-390665fcd5e7
> > > > [match]
> > > > dev_item.type           0
> > > > dev_item.total_bytes    8001563222016
> > > > dev_item.bytes_used     6774245556224
> > > > dev_item.io_align       4096
> > > > dev_item.io_width       4096
> > > > dev_item.sector_size    4096
> > > > dev_item.devid          3
> > > > dev_item.dev_group      0
> > > > dev_item.seek_speed     0
> > > > dev_item.bandwidth      0
> > > > dev_item.generation     0
> > > > sys_chunk_array[2048]:
> > > >         item 0 key (FIRST_CHUNK_TREE CHUNK_ITEM 22020096)
> > > >                 length 8388608 owner 2 stripe_len 65536 type
> > > > SYSTEM|RAID1C4
> > > >                 io_align 65536 io_width 65536 sector_size 4096
> > > >                 num_stripes 4 sub_stripes 1
> > > >                         stripe 0 devid 1 offset 22020096
> > > >                         dev_uuid 9c8b19be-c344-4be0-9726-
> > > > 34bf674d0349
> > > >                         stripe 1 devid 2 offset 1048576
> > > >                         dev_uuid 0542bb91-9989-4155-aec2-
> > > > 3baf0d848675
> > > >                         stripe 2 devid 3 offset 1048576
> > > >                         dev_uuid 691827bd-b866-42ad-b0c0-
> > > > eb81a4bfcfeb
> > > >                         stripe 3 devid 4 offset 1048576
> > > >                         dev_uuid 51f99a35-7fca-4f38-8469-
> > > > 5fa12a1623a7
> > > > backup_roots[4]:
> > > >         backup 0:
> > > >                 backup_tree_root:       12883564068864  gen:
> > > > 368949     level: 1
> > > >                 backup_chunk_root:      23134208        gen:
> > > > 367570     level: 1
> > > >                 backup_extent_root:     12883562348544  gen:
> > > > 368949     level: 2
> > > >                 backup_fs_root:         12883557957632  gen:
> > > > 368949     level: 2
> > > >                 backup_dev_root:        12883678691328  gen:
> > > > 367580     level: 1
> > > >                 backup_csum_root:       12883558776832  gen:
> > > > 368949     level: 3
> > > >                 backup_total_bytes:     32006252888064
> > > >                 backup_bytes_used:      13410457206784
> > > >                 backup_num_devices:     4
> > > > 
> > > >         backup 1:
> > > >                 backup_tree_root:       12883568295936  gen:
> > > > 368950     level: 1
> > > >                 backup_chunk_root:      23134208        gen:
> > > > 367570     level: 1
> > > >                 backup_extent_root:     12883566575616  gen:
> > > > 368950     level: 2
> > > >                 backup_fs_root:         12883559759872  gen:
> > > > 368950     level: 2
> > > >                 backup_dev_root:        12883678691328  gen:
> > > > 367580     level: 1
> > > >                 backup_csum_root:       12883560382464  gen:
> > > > 368950     level: 3
> > > >                 backup_total_bytes:     32006252888064
> > > >                 backup_bytes_used:      13410457739264
> > > >                 backup_num_devices:     4
> > > > 
> > > >         backup 2:
> > > >                 backup_tree_root:       12883564462080  gen:
> > > > 368947     level: 1
> > > >                 backup_chunk_root:      23134208        gen:
> > > > 367570     level: 1
> > > >                 backup_extent_root:     12883563347968  gen:
> > > > 368947     level: 2
> > > >                 backup_fs_root:         12883555663872  gen:
> > > > 368947     level: 2
> > > >                 backup_dev_root:        12883678691328  gen:
> > > > 367580     level: 1
> > > >                 backup_csum_root:       12883562217472  gen:
> > > > 368947     level: 3
> > > >                 backup_total_bytes:     32006252888064
> > > >                 backup_bytes_used:      13410457006080
> > > >                 backup_num_devices:     4
> > > > 
> > > >         backup 3:
> > > >                 backup_tree_root:       12883566510080  gen:
> > > > 368948     level: 1
> > > >                 backup_chunk_root:      23134208        gen:
> > > > 367570     level: 1
> > > >                 backup_extent_root:     12883559759872  gen:
> > > > 368948     level: 2
> > > >                 backup_fs_root:         12883553746944  gen:
> > > > 368948     level: 2
> > > >                 backup_dev_root:        12883678691328  gen:
> > > > 367580     level: 1
> > > >                 backup_csum_root:       12883555434496  gen:
> > > > 368948     level: 3
> > > >                 backup_total_bytes:     32006252888064
> > > >                 backup_bytes_used:      13410457116672
> > > >                 backup_num_devices:     4
> > > > 
> > > > 
> > > 
> > > > [    0.864538] Btrfs loaded, crc32c=crc32c-generic, zoned=yes
> > > > [   13.368410] BTRFS: device label homedirs devid 2 transid
> > > > 367206
> > > > /dev/sde scanned by systemd-udevd (644)
> > > > [   13.379691] BTRFS: device label homedirs devid 3 transid
> > > > 367206
> > > > /dev/sdd scanned by systemd-udevd (646)
> > > > [   13.382411] BTRFS: device label homedirs devid 4 transid
> > > > 367206
> > > > /dev/sdc scanned by systemd-udevd (648)
> > > > [   13.398436] BTRFS: device label homedirs devid 1 transid
> > > > 367206
> > > > /dev/sdg scanned by systemd-udevd (652)
> > > > [   13.750256] BTRFS info (device sdg): disk space caching is
> > > > enabled
> > > > [   13.750260] BTRFS info (device sdg): has skinny extents
> > > > [   14.710747] BTRFS info (device sdg): bdev /dev/sdg errs: wr
> > > > 0, rd
> > > > 1, flush 0, corrupt 0, gen 0
> > > > [   14.712675] BTRFS info (device sdg): bdev /dev/sde errs: wr
> > > > 0, rd
> > > > 0, flush 0, corrupt 23, gen 0
> > > > [   14.714555] BTRFS info (device sdg): bdev /dev/sdd errs: wr
> > > > 74390652, rd 1756348, flush 189, corrupt 37082, gen 21
> > > > [   25.444099] BTRFS info (device sdg): checking UUID tree
> > > > [ 5585.543078] BTRFS info (device sdg): scrub: started on devid
> > > > 3
> > > > [ 5661.646404] BTRFS error (device sdg): bdev /dev/sdd errs: wr
> > > > 74390652, rd 1756348, flush 189, corrupt 37083, gen 21
> > > > [ 5661.681282] BTRFS error (device sdg): unable to fixup
> > > > (regular)
> > > > error at logical 10102571008 on dev /dev/sdd
> > > > [ 6001.726239] BTRFS info (device sdg): scrub: not finished on
> > > > devid
> > > > 3 with status: -125
> > > > [ 6365.446732] BTRFS error (device sdg): parent transid verify
> > > > failed
> > > > on 12887115939840 wanted 359811 found 359779
> > > > [ 6365.458935] BTRFS info (device sdg): read error corrected:
> > > > ino 0
> > > > off 12887115939840 (dev /dev/sdd sector 12564126688)
> > > > [ 6365.460173] BTRFS info (device sdg): read error corrected:
> > > > ino 0
> > > > off 12887115943936 (dev /dev/sdd sector 12564126696)
> > > > [ 6365.461201] BTRFS info (device sdg): read error corrected:
> > > > ino 0
> > > > off 12887115948032 (dev /dev/sdd sector 12564126704)
> > > > [ 6365.461472] BTRFS info (device sdg): read error corrected:
> > > > ino 0
> > > > off 12887115952128 (dev /dev/sdd sector 12564126712)
> > > > [ 6369.607540] BTRFS error (device sdg): parent transid verify
> > > > failed
> > > > on 12002143010816 wanted 357838 found 357635
> > > > [ 6369.627007] BTRFS info (device sdg): read error corrected:
> > > > ino 0
> > > > off 12002143010816 (dev /dev/sdd sector 11747925056)
> > > > [ 6369.627946] BTRFS info (device sdg): read error corrected:
> > > > ino 0
> > > > off 12002143014912 (dev /dev/sdd sector 11747925064)
> > > > [ 6369.629425] BTRFS info (device sdg): read error corrected:
> > > > ino 0
> > > > off 12002143019008 (dev /dev/sdd sector 11747925072)
> > > > [ 6369.630019] BTRFS info (device sdg): read error corrected:
> > > > ino 0
> > > > off 12002143023104 (dev /dev/sdd sector 11747925080)
> > > > [ 6369.906563] BTRFS error (device sdg): parent transid verify
> > > > failed
> > > > on 12887116201984 wanted 359811 found 359780
> > > > [ 6369.907822] BTRFS info (device sdg): read error corrected:
> > > > ino 0
> > > > off 12887116201984 (dev /dev/sdd sector 12564127200)
> > > > [ 6369.908297] BTRFS info (device sdg): read error corrected:
> > > > ino 0
> > > > off 12887116206080 (dev /dev/sdd sector 12564127208)
> > > > [ 6370.082144] BTRFS error (device sdg): parent transid verify
> > > > failed
> > > > on 12887116251136 wanted 359811 found 359780
> > > > [ 6370.085084] BTRFS error (device sdg): parent transid verify
> > > > failed
> > > > on 12887116365824 wanted 359811 found 359780
> > > > [ 6378.874360] BTRFS error (device sdg): parent transid verify
> > > > failed
> > > > on 12002146205696 wanted 357838 found 357635
> > > > [ 6378.896865] BTRFS info (device sdg): read error corrected:
> > > > ino 0
> > > > off 12002146205696 (dev /dev/sdd sector 11747931296)
> > > > [ 6378.899224] BTRFS info (device sdg): read error corrected:
> > > > ino 0
> > > > off 12002146209792 (dev /dev/sdd sector 11747931304)
> > > > [ 6378.900376] BTRFS info (device sdg): read error corrected:
> > > > ino 0
> > > > off 12002146213888 (dev /dev/sdd sector 11747931312)
> > > > [ 6378.901048] BTRFS info (device sdg): read error corrected:
> > > > ino 0
> > > > off 12002146217984 (dev /dev/sdd sector 11747931320)
> > > > [ 6378.901332] BTRFS error (device sdg): parent transid verify
> > > > failed
> > > > on 12002146467840 wanted 357838 found 357635
> > > > [ 6378.901890] BTRFS info (device sdg): read error corrected:
> > > > ino 0
> > > > off 12002146467840 (dev /dev/sdd sector 11747931808)
> > > > [ 6378.902122] BTRFS info (device sdg): read error corrected:
> > > > ino 0
> > > > off 12002146471936 (dev /dev/sdd sector 11747931816)
> > > > [ 6378.902318] BTRFS info (device sdg): read error corrected:
> > > > ino 0
> > > > off 12002146476032 (dev /dev/sdd sector 11747931824)
> > > > [ 6378.902525] BTRFS info (device sdg): read error corrected:
> > > > ino 0
> > > > off 12002146480128 (dev /dev/sdd sector 11747931832)
> > > > [ 6378.915275] BTRFS error (device sdg): parent transid verify
> > > > failed
> > > > on 12002147631104 wanted 357838 found 357635
> > > > [ 6378.923147] BTRFS info (device sdg): read error corrected:
> > > > ino 0
> > > > off 12002147631104 (dev /dev/sdd sector 11747934080)
> > > > [ 6378.923804] BTRFS info (device sdg): read error corrected:
> > > > ino 0
> > > > off 12002147635200 (dev /dev/sdd sector 11747934088)
> > > > [ 6378.992162] BTRFS error (device sdg): parent transid verify
> > > > failed
> > > > on 12002146959360 wanted 357838 found 357635
> > > > [ 6378.997017] BTRFS error (device sdg): parent transid verify
> > > > failed
> > > > on 12002147155968 wanted 357838 found 357635
> > > > [ 6379.133024] BTRFS error (device sdg): parent transid verify
> > > > failed
> > > > on 12002146385920 wanted 357838 found 357635
> > > > [ 6379.137035] BTRFS error (device sdg): parent transid verify
> > > > failed
> > > > on 12002146402304 wanted 357838 found 357635
> > > > [ 6380.140516] BTRFS error (device sdg): parent transid verify
> > > > failed
> > > > on 12002146123776 wanted 357838 found 357635
> > > > [ 6380.680832] BTRFS error (device sdg): parent transid verify
> > > > failed
> > > > on 12002240020480 wanted 357838 found 357635
> > > > [13673.751319] BTRFS info (device sdg): scrub: started on devid
> > > > 3
> > > > [16826.036404] BTRFS info (device sdg): scrub: not finished on
> > > > devid
> > > > 3 with status: -125
> > > > [23638.218998] BTRFS info (device sdg): disk space caching is
> > > > enabled
> > > > [23638.220428] BTRFS info (device sdg): has skinny extents
> > > > [23639.167931] BTRFS info (device sdg): bdev /dev/sdg errs: wr
> > > > 0, rd
> > > > 1, flush 0, corrupt 0, gen 0
> > > > [23639.169393] BTRFS info (device sdg): bdev /dev/sde errs: wr
> > > > 0, rd
> > > > 0, flush 0, corrupt 23, gen 0
> > > > [23639.170871] BTRFS info (device sdg): bdev /dev/sdd errs: wr
> > > > 74390652, rd 1756348, flush 189, corrupt 37083, gen 21
> > > > [38079.437411] BTRFS error (device sdg): parent transid verify
> > > > failed
> > > > on 12884760723456 wanted 360620 found 359101
> > > > [38079.457879] BTRFS info (device sdg): read error corrected:
> > > > ino 0
> > > > off 12884760723456 (dev /dev/sdd sector 12559526656)
> > > > [38079.459418] BTRFS info (device sdg): read error corrected:
> > > > ino 0
> > > > off 12884760727552 (dev /dev/sdd sector 12559526664)
> > > > [38079.460390] BTRFS info (device sdg): read error corrected:
> > > > ino 0
> > > > off 12884760731648 (dev /dev/sdd sector 12559526672)
> > > > [38079.460585] BTRFS info (device sdg): read error corrected:
> > > > ino 0
> > > > off 12884760735744 (dev /dev/sdd sector 12559526680)
> > > > [38221.384604] BTRFS error (device sdg): parent transid verify
> > > > failed
> > > > on 12887984144384 wanted 357793 found 357612
> > > > [38221.402557] BTRFS info (device sdg): read error corrected:
> > > > ino 0
> > > > off 12887984144384 (dev /dev/sdd sector 12565822400)
> > > > [38221.404162] BTRFS info (device sdg): read error corrected:
> > > > ino 0
> > > > off 12887984148480 (dev /dev/sdd sector 12565822408)
> > > > [38221.404757] BTRFS info (device sdg): read error corrected:
> > > > ino 0
> > > > off 12887984152576 (dev /dev/sdd sector 12565822416)
> > > > [38221.405024] BTRFS info (device sdg): read error corrected:
> > > > ino 0
> > > > off 12887984156672 (dev /dev/sdd sector 12565822424)
> > > > [65806.904757] BTRFS error (device sdg): parent transid verify
> > > > failed
> > > > on 12884812627968 wanted 360627 found 359022
> > > > [65806.918919] BTRFS info (device sdg): read error corrected:
> > > > ino 0
> > > > off 12884812627968 (dev /dev/sdd sector 12559628032)
> > > > [65806.920934] BTRFS info (device sdg): read error corrected:
> > > > ino 0
> > > > off 12884812632064 (dev /dev/sdd sector 12559628040)
> > > > [65806.922112] BTRFS info (device sdg): read error corrected:
> > > > ino 0
> > > > off 12884812636160 (dev /dev/sdd sector 12559628048)
> > > > [65806.922728] BTRFS info (device sdg): read error corrected:
> > > > ino 0
> > > > off 12884812640256 (dev /dev/sdd sector 12559628056)
> > > > [70219.837853] BTRFS warning (device sdg): csum failed root 5
> > > > ino
> > > > 13004600 off 1388544 csum 0x89644c3d02062469 expected csum
> > > > 0x006926a7eef0358f mirror 1
> > > > [70219.841358] BTRFS error (device sdg): bdev /dev/sdd errs: wr
> > > > 74390652, rd 1756348, flush 189, corrupt 37084, gen 21
> > > > [70219.843858] BTRFS info (device sdg): read error corrected:
> > > > ino
> > > > 13004600 off 1388544 (dev /dev/sdd sector 8499704456)
> > > > [70219.858611] BTRFS warning (device sdg): csum failed root 5
> > > > ino
> > > > 13004600 off 1384448 csum 0x3281ab5806ee6c8f expected csum
> > > > 0xf81ccd9e0fd3faa6 mirror 1
> > > > [70219.862320] BTRFS error (device sdg): bdev /dev/sdd errs: wr
> > > > 74390652, rd 1756348, flush 189, corrupt 37085, gen 21
> > > > [70219.864440] BTRFS info (device sdg): read error corrected:
> > > > ino
> > > > 13004600 off 1384448 (dev /dev/sdd sector 8499704448)
> > > > [85509.387364] BTRFS error (device sdg): parent transid verify
> > > > failed
> > > > on 12887136485376 wanted 359811 found 359594
> > > > [85509.410871] BTRFS info (device sdg): read error corrected:
> > > > ino 0
> > > > off 12887136485376 (dev /dev/sdd sector 12564166816)
> > > > [85509.413277] BTRFS info (device sdg): read error corrected:
> > > > ino 0
> > > > off 12887136489472 (dev /dev/sdd sector 12564166824)
> > > > [85509.415928] BTRFS info (device sdg): read error corrected:
> > > > ino 0
> > > > off 12887136493568 (dev /dev/sdd sector 12564166832)
> > > > [85509.418011] BTRFS info (device sdg): read error corrected:
> > > > ino 0
> > > > off 12887136497664 (dev /dev/sdd sector 12564166840)
> > > > [86025.084757] BTRFS error (device sdg): parent transid verify
> > > > failed
> > > > on 12887142547456 wanted 359802 found 359785
> > > > [86025.103698] BTRFS info (device sdg): read error corrected:
> > > > ino 0
> > > > off 12887142547456 (dev /dev/sdd sector 12564178656)
> > > > [86025.105889] BTRFS info (device sdg): read error corrected:
> > > > ino 0
> > > > off 12887142551552 (dev /dev/sdd sector 12564178664)
> > > > [86025.108065] BTRFS info (device sdg): read error corrected:
> > > > ino 0
> > > > off 12887142555648 (dev /dev/sdd sector 12564178672)
> > > > [86025.110341] BTRFS info (device sdg): read error corrected:
> > > > ino 0
> > > > off 12887142559744 (dev /dev/sdd sector 12564178680)
> > > > [89093.407662] BTRFS error (device sdg): parent transid verify
> > > > failed
> > > > on 12886944956416 wanted 357751 found 357579
> > > > [89093.423399] BTRFS info (device sdg): read error corrected:
> > > > ino 0
> > > > off 12886944956416 (dev /dev/sdd sector 12563792736)
> > > > [89093.424792] BTRFS info (device sdg): read error corrected:
> > > > ino 0
> > > > off 12886944960512 (dev /dev/sdd sector 12563792744)
> > > > [89093.425905] BTRFS info (device sdg): read error corrected:
> > > > ino 0
> > > > off 12886944964608 (dev /dev/sdd sector 12563792752)
> > > > [89093.426976] BTRFS info (device sdg): read error corrected:
> > > > ino 0
> > > > off 12886944968704 (dev /dev/sdd sector 12563792760)
> > > 
> > > > [1/7] checking root items
> > > > [2/7] checking extents
> > > > [3/7] checking free space cache
> > > > [4/7] checking fs roots
> > > > [5/7] checking only csums items (without verifying data)
> > > > [6/7] checking root refs
> > > > [7/7] checking quota groups skipped (not enabled on this FS)
> > > > Opening filesystem to check...
> > > > Checking filesystem on /dev/sdd
> > > > UUID: fce03447-ad88-4891-b91f-390665fcd5e7
> > > > found 13364248408064 bytes used, no error found
> > > > total csum bytes: 26044304216
> > > > total tree bytes: 29511155712
> > > > total fs tree bytes: 1468596224
> > > > total extent tree bytes: 232357888
> > > > btree space waste bytes: 1737736698
> > > > file data blocks allocated: 13545978748928
> > > >  referenced 13336378105856
> > > 
> > 
> 
> > [   10.340190] sd 4:0:2:0: [sdd] 15628053168 512-byte logical
> > blocks: (8.00 TB/7.28 TiB)
> > [   10.340191] sd 4:0:2:0: [sdd] 4096-byte physical blocks
> > [   10.340198] sd 4:0:2:0: [sdd] Write Protect is off
> > [   10.340200] sd 4:0:2:0: [sdd] Mode Sense: 00 3a 00 00
> > [   10.340211] sd 4:0:2:0: [sdd] Write cache: enabled, read cache:
> > enabled, doesn't support DPO or FUA
> > [   10.373337] sd 4:0:2:0: [sdd] Attached SCSI disk
> > [   13.368410] BTRFS: device label homedirs devid 2 transid 367206
> > /dev/sde scanned by systemd-udevd (644)
> > [   13.379691] BTRFS: device label homedirs devid 3 transid 367206
> > /dev/sdd scanned by systemd-udevd (646)
> > [   13.382411] BTRFS: device label homedirs devid 4 transid 367206
> > /dev/sdc scanned by systemd-udevd (648)
> > [   13.398436] BTRFS: device label homedirs devid 1 transid 367206
> > /dev/sdg scanned by systemd-udevd (652)
> > [   13.750256] BTRFS info (device sdg): disk space caching is
> > enabled
> > [   13.750260] BTRFS info (device sdg): has skinny extents
> > [   14.710747] BTRFS info (device sdg): bdev /dev/sdg errs: wr 0,
> > rd 1, flush 0, corrupt 0, gen 0
> > [   14.712675] BTRFS info (device sdg): bdev /dev/sde errs: wr 0,
> > rd 0, flush 0, corrupt 23, gen 0
> > [   14.714555] BTRFS info (device sdg): bdev /dev/sdd errs: wr
> > 74390652, rd 1756348, flush 189, corrupt 37082, gen 21
> > [   25.444099] BTRFS info (device sdg): checking UUID tree
> > [ 5585.543078] BTRFS info (device sdg): scrub: started on devid 3
> > [ 5661.646404] BTRFS error (device sdg): bdev /dev/sdd errs: wr
> > 74390652, rd 1756348, flush 189, corrupt 37083, gen 21
> > [ 5661.681282] BTRFS error (device sdg): unable to fixup (regular)
> > error at logical 10102571008 on dev /dev/sdd
> > [ 6001.726239] BTRFS info (device sdg): scrub: not finished on
> > devid 3 with status: -125
> > [ 6365.446732] BTRFS error (device sdg): parent transid verify
> > failed on 12887115939840 wanted 359811 found 359779
> > [ 6365.458935] BTRFS info (device sdg): read error corrected: ino 0
> > off 12887115939840 (dev /dev/sdd sector 12564126688)
> > [ 6365.460173] BTRFS info (device sdg): read error corrected: ino 0
> > off 12887115943936 (dev /dev/sdd sector 12564126696)
> > [ 6365.461201] BTRFS info (device sdg): read error corrected: ino 0
> > off 12887115948032 (dev /dev/sdd sector 12564126704)
> > [ 6365.461472] BTRFS info (device sdg): read error corrected: ino 0
> > off 12887115952128 (dev /dev/sdd sector 12564126712)
> > [ 6369.607540] BTRFS error (device sdg): parent transid verify
> > failed on 12002143010816 wanted 357838 found 357635
> > [ 6369.627007] BTRFS info (device sdg): read error corrected: ino 0
> > off 12002143010816 (dev /dev/sdd sector 11747925056)
> > [ 6369.627946] BTRFS info (device sdg): read error corrected: ino 0
> > off 12002143014912 (dev /dev/sdd sector 11747925064)
> > [ 6369.629425] BTRFS info (device sdg): read error corrected: ino 0
> > off 12002143019008 (dev /dev/sdd sector 11747925072)
> > [ 6369.630019] BTRFS info (device sdg): read error corrected: ino 0
> > off 12002143023104 (dev /dev/sdd sector 11747925080)
> > [ 6369.906563] BTRFS error (device sdg): parent transid verify
> > failed on 12887116201984 wanted 359811 found 359780
> > [ 6369.907822] BTRFS info (device sdg): read error corrected: ino 0
> > off 12887116201984 (dev /dev/sdd sector 12564127200)
> > [ 6369.908297] BTRFS info (device sdg): read error corrected: ino 0
> > off 12887116206080 (dev /dev/sdd sector 12564127208)
> > [ 6370.082144] BTRFS error (device sdg): parent transid verify
> > failed on 12887116251136 wanted 359811 found 359780
> > [ 6370.085084] BTRFS error (device sdg): parent transid verify
> > failed on 12887116365824 wanted 359811 found 359780
> > [ 6378.874360] BTRFS error (device sdg): parent transid verify
> > failed on 12002146205696 wanted 357838 found 357635
> > [ 6378.896860] repair_io_failure: 10 callbacks suppressed
> > [ 6378.896865] BTRFS info (device sdg): read error corrected: ino 0
> > off 12002146205696 (dev /dev/sdd sector 11747931296)
> > [ 6378.899224] BTRFS info (device sdg): read error corrected: ino 0
> > off 12002146209792 (dev /dev/sdd sector 11747931304)
> > [ 6378.900376] BTRFS info (device sdg): read error corrected: ino 0
> > off 12002146213888 (dev /dev/sdd sector 11747931312)
> > [ 6378.901048] BTRFS info (device sdg): read error corrected: ino 0
> > off 12002146217984 (dev /dev/sdd sector 11747931320)
> > [ 6378.901332] BTRFS error (device sdg): parent transid verify
> > failed on 12002146467840 wanted 357838 found 357635
> > [ 6378.901890] BTRFS info (device sdg): read error corrected: ino 0
> > off 12002146467840 (dev /dev/sdd sector 11747931808)
> > [ 6378.902122] BTRFS info (device sdg): read error corrected: ino 0
> > off 12002146471936 (dev /dev/sdd sector 11747931816)
> > [ 6378.902318] BTRFS info (device sdg): read error corrected: ino 0
> > off 12002146476032 (dev /dev/sdd sector 11747931824)
> > [ 6378.902525] BTRFS info (device sdg): read error corrected: ino 0
> > off 12002146480128 (dev /dev/sdd sector 11747931832)
> > [ 6378.915275] BTRFS error (device sdg): parent transid verify
> > failed on 12002147631104 wanted 357838 found 357635
> > [ 6378.923147] BTRFS info (device sdg): read error corrected: ino 0
> > off 12002147631104 (dev /dev/sdd sector 11747934080)
> > [ 6378.923804] BTRFS info (device sdg): read error corrected: ino 0
> > off 12002147635200 (dev /dev/sdd sector 11747934088)
> > [ 6378.992162] BTRFS error (device sdg): parent transid verify
> > failed on 12002146959360 wanted 357838 found 357635
> > [ 6378.997017] BTRFS error (device sdg): parent transid verify
> > failed on 12002147155968 wanted 357838 found 357635
> > [ 6379.133024] BTRFS error (device sdg): parent transid verify
> > failed on 12002146385920 wanted 357838 found 357635
> > [ 6379.137035] BTRFS error (device sdg): parent transid verify
> > failed on 12002146402304 wanted 357838 found 357635
> > [ 6380.140516] BTRFS error (device sdg): parent transid verify
> > failed on 12002146123776 wanted 357838 found 357635
> > [ 6380.680832] BTRFS error (device sdg): parent transid verify
> > failed on 12002240020480 wanted 357838 found 357635
> > [13673.751319] BTRFS info (device sdg): scrub: started on devid 3
> > [16826.036404] BTRFS info (device sdg): scrub: not finished on
> > devid 3 with status: -125
> > [23638.218998] BTRFS info (device sdg): disk space caching is
> > enabled
> > [23638.220428] BTRFS info (device sdg): has skinny extents
> > [23639.167931] BTRFS info (device sdg): bdev /dev/sdg errs: wr 0,
> > rd 1, flush 0, corrupt 0, gen 0
> > [23639.169393] BTRFS info (device sdg): bdev /dev/sde errs: wr 0,
> > rd 0, flush 0, corrupt 23, gen 0
> > [23639.170871] BTRFS info (device sdg): bdev /dev/sdd errs: wr
> > 74390652, rd 1756348, flush 189, corrupt 37083, gen 21
> > [38079.437411] BTRFS error (device sdg): parent transid verify
> > failed on 12884760723456 wanted 360620 found 359101
> > [38079.457874] repair_io_failure: 26 callbacks suppressed
> > [38079.457879] BTRFS info (device sdg): read error corrected: ino 0
> > off 12884760723456 (dev /dev/sdd sector 12559526656)
> > [38079.459418] BTRFS info (device sdg): read error corrected: ino 0
> > off 12884760727552 (dev /dev/sdd sector 12559526664)
> > [38079.460390] BTRFS info (device sdg): read error corrected: ino 0
> > off 12884760731648 (dev /dev/sdd sector 12559526672)
> > [38079.460585] BTRFS info (device sdg): read error corrected: ino 0
> > off 12884760735744 (dev /dev/sdd sector 12559526680)
> > [38221.384604] BTRFS error (device sdg): parent transid verify
> > failed on 12887984144384 wanted 357793 found 357612
> > [38221.402557] BTRFS info (device sdg): read error corrected: ino 0
> > off 12887984144384 (dev /dev/sdd sector 12565822400)
> > [38221.404162] BTRFS info (device sdg): read error corrected: ino 0
> > off 12887984148480 (dev /dev/sdd sector 12565822408)
> > [38221.404757] BTRFS info (device sdg): read error corrected: ino 0
> > off 12887984152576 (dev /dev/sdd sector 12565822416)
> > [38221.405024] BTRFS info (device sdg): read error corrected: ino 0
> > off 12887984156672 (dev /dev/sdd sector 12565822424)
> > [65806.904757] BTRFS error (device sdg): parent transid verify
> > failed on 12884812627968 wanted 360627 found 359022
> > [65806.918919] BTRFS info (device sdg): read error corrected: ino 0
> > off 12884812627968 (dev /dev/sdd sector 12559628032)
> > [65806.920934] BTRFS info (device sdg): read error corrected: ino 0
> > off 12884812632064 (dev /dev/sdd sector 12559628040)
> > [65806.922112] BTRFS info (device sdg): read error corrected: ino 0
> > off 12884812636160 (dev /dev/sdd sector 12559628048)
> > [65806.922728] BTRFS info (device sdg): read error corrected: ino 0
> > off 12884812640256 (dev /dev/sdd sector 12559628056)
> > [70219.837853] BTRFS warning (device sdg): csum failed root 5 ino
> > 13004600 off 1388544 csum 0x89644c3d02062469 expected csum
> > 0x006926a7eef0358f mirror 1
> > [70219.841358] BTRFS error (device sdg): bdev /dev/sdd errs: wr
> > 74390652, rd 1756348, flush 189, corrupt 37084, gen 21
> > [70219.843858] BTRFS info (device sdg): read error corrected: ino
> > 13004600 off 1388544 (dev /dev/sdd sector 8499704456)
> > [70219.858611] BTRFS warning (device sdg): csum failed root 5 ino
> > 13004600 off 1384448 csum 0x3281ab5806ee6c8f expected csum
> > 0xf81ccd9e0fd3faa6 mirror 1
> > [70219.862320] BTRFS error (device sdg): bdev /dev/sdd errs: wr
> > 74390652, rd 1756348, flush 189, corrupt 37085, gen 21
> > [70219.864440] BTRFS info (device sdg): read error corrected: ino
> > 13004600 off 1384448 (dev /dev/sdd sector 8499704448)
> > [85509.387364] BTRFS error (device sdg): parent transid verify
> > failed on 12887136485376 wanted 359811 found 359594
> > [85509.410871] BTRFS info (device sdg): read error corrected: ino 0
> > off 12887136485376 (dev /dev/sdd sector 12564166816)
> > [85509.413277] BTRFS info (device sdg): read error corrected: ino 0
> > off 12887136489472 (dev /dev/sdd sector 12564166824)
> > [85509.415928] BTRFS info (device sdg): read error corrected: ino 0
> > off 12887136493568 (dev /dev/sdd sector 12564166832)
> > [85509.418011] BTRFS info (device sdg): read error corrected: ino 0
> > off 12887136497664 (dev /dev/sdd sector 12564166840)
> > [86025.084757] BTRFS error (device sdg): parent transid verify
> > failed on 12887142547456 wanted 359802 found 359785
> > [86025.103698] BTRFS info (device sdg): read error corrected: ino 0
> > off 12887142547456 (dev /dev/sdd sector 12564178656)
> > [86025.105889] BTRFS info (device sdg): read error corrected: ino 0
> > off 12887142551552 (dev /dev/sdd sector 12564178664)
> > [86025.108065] BTRFS info (device sdg): read error corrected: ino 0
> > off 12887142555648 (dev /dev/sdd sector 12564178672)
> > [86025.110341] BTRFS info (device sdg): read error corrected: ino 0
> > off 12887142559744 (dev /dev/sdd sector 12564178680)
> > [89093.407662] BTRFS error (device sdg): parent transid verify
> > failed on 12886944956416 wanted 357751 found 357579
> > [89093.423399] BTRFS info (device sdg): read error corrected: ino 0
> > off 12886944956416 (dev /dev/sdd sector 12563792736)
> > [89093.424792] BTRFS info (device sdg): read error corrected: ino 0
> > off 12886944960512 (dev /dev/sdd sector 12563792744)
> > [89093.425905] BTRFS info (device sdg): read error corrected: ino 0
> > off 12886944964608 (dev /dev/sdd sector 12563792752)
> > [89093.426976] BTRFS info (device sdg): read error corrected: ino 0
> > off 12886944968704 (dev /dev/sdd sector 12563792760)
> > [175365.130738] BTRFS error (device sdg): parent transid verify
> > failed on 12886956064768 wanted 357752 found 357580
> > [175365.197967] BTRFS info (device sdg): read error corrected: ino
> > 0 off 12886956064768 (dev /dev/sdd sector 12563814432)
> > [175365.200168] BTRFS info (device sdg): read error corrected: ino
> > 0 off 12886956068864 (dev /dev/sdd sector 12563814440)
> > [175365.202271] BTRFS info (device sdg): read error corrected: ino
> > 0 off 12886956072960 (dev /dev/sdd sector 12563814448)
> > [175365.204354] BTRFS info (device sdg): read error corrected: ino
> > 0 off 12886956077056 (dev /dev/sdd sector 12563814456)
> > [176458.125146] BTRFS error (device sdg): parent transid verify
> > failed on 12887898587136 wanted 357785 found 357607
> > [176458.141330] BTRFS info (device sdg): read error corrected: ino
> > 0 off 12887898587136 (dev /dev/sdd sector 12565655296)
> > [176458.143944] BTRFS info (device sdg): read error corrected: ino
> > 0 off 12887898591232 (dev /dev/sdd sector 12565655304)
> > [176458.145887] BTRFS info (device sdg): read error corrected: ino
> > 0 off 12887898595328 (dev /dev/sdd sector 12565655312)
> > [176458.147776] BTRFS info (device sdg): read error corrected: ino
> > 0 off 12887898599424 (dev /dev/sdd sector 12565655320)
> > [229945.146691] BTRFS error (device sdg): parent transid verify
> > failed on 12885496791040 wanted 357700 found 357535
> > [229945.157340] BTRFS info (device sdg): read error corrected: ino
> > 0 off 12885496791040 (dev /dev/sdd sector 12560964288)
> > [229945.159127] BTRFS info (device sdg): read error corrected: ino
> > 0 off 12885496795136 (dev /dev/sdd sector 12560964296)
> > [229945.161000] BTRFS info (device sdg): read error corrected: ino
> > 0 off 12885496799232 (dev /dev/sdd sector 12560964304)
> > [229945.162835] BTRFS info (device sdg): read error corrected: ino
> > 0 off 12885496803328 (dev /dev/sdd sector 12560964312)
> > [229945.164764] BTRFS error (device sdg): parent transid verify
> > failed on 12885496807424 wanted 357700 found 357535
> > [229945.166985] BTRFS info (device sdg): read error corrected: ino
> > 0 off 12885496807424 (dev /dev/sdd sector 12560964320)
> > [229945.168927] BTRFS info (device sdg): read error corrected: ino
> > 0 off 12885496811520 (dev /dev/sdd sector 12560964328)
> > [229945.170807] BTRFS info (device sdg): read error corrected: ino
> > 0 off 12885496815616 (dev /dev/sdd sector 12560964336)
> > [229945.172695] BTRFS info (device sdg): read error corrected: ino
> > 0 off 12885496819712 (dev /dev/sdd sector 12560964344)
> > [230214.519209] BTRFS info (device sdg): scrub: started on devid 3
> > [230291.988628] BTRFS error (device sdg): bdev /dev/sdd errs: wr
> > 74390652, rd 1756348, flush 189, corrupt 37086, gen 21
> > [230291.997391] BTRFS error (device sdg): unable to fixup (regular)
> > error at logical 10102571008 on dev /dev/sdd
> > [233375.205625] BTRFS error (device sdg): parent transid verify
> > failed on 12887574511616 wanted 357774 found 357599
> > [233375.290159] BTRFS info (device sdg): read error corrected: ino
> > 0 off 12887574511616 (dev /dev/sdd sector 12565022336)
> > [233375.292087] BTRFS info (device sdg): read error corrected: ino
> > 0 off 12887574515712 (dev /dev/sdd sector 12565022344)
> > [233375.293908] BTRFS info (device sdg): read error corrected: ino
> > 0 off 12887574519808 (dev /dev/sdd sector 12565022352)
> > [233375.295647] BTRFS info (device sdg): read error corrected: ino
> > 0 off 12887574523904 (dev /dev/sdd sector 12565022360)
> > [233832.001374] BTRFS error (device sdg): parent transid verify
> > failed on 12887123804160 wanted 359811 found 359704
> > [233832.084098] BTRFS info (device sdg): read error corrected: ino
> > 0 off 12887123804160 (dev /dev/sdd sector 12564142048)
> > [233832.086073] BTRFS info (device sdg): read error corrected: ino
> > 0 off 12887123808256 (dev /dev/sdd sector 12564142056)
> > [233832.087796] BTRFS info (device sdg): read error corrected: ino
> > 0 off 12887123812352 (dev /dev/sdd sector 12564142064)
> > [233832.089507] BTRFS info (device sdg): read error corrected: ino
> > 0 off 12887123816448 (dev /dev/sdd sector 12564142072)
> > [239527.304785] BTRFS error (device sdg): parent transid verify
> > failed on 12886930227200 wanted 357751 found 357579
> > [239527.331156] BTRFS info (device sdg): read error corrected: ino
> > 0 off 12886930227200 (dev /dev/sdd sector 12563763968)
> > [239527.334237] BTRFS info (device sdg): read error corrected: ino
> > 0 off 12886930231296 (dev /dev/sdd sector 12563763976)
> > [239527.335905] BTRFS info (device sdg): read error corrected: ino
> > 0 off 12886930235392 (dev /dev/sdd sector 12563763984)
> > [239527.337596] BTRFS info (device sdg): read error corrected: ino
> > 0 off 12886930239488 (dev /dev/sdd sector 12563763992)
> > [241139.967354] BTRFS error (device sdg): parent transid verify
> > failed on 12001961410560 wanted 357836 found 357632
> > [241140.011489] BTRFS info (device sdg): read error corrected: ino
> > 0 off 12001961410560 (dev /dev/sdd sector 11747570368)
> > [241140.013559] BTRFS info (device sdg): read error corrected: ino
> > 0 off 12001961414656 (dev /dev/sdd sector 11747570376)
> > [241140.016843] BTRFS info (device sdg): read error corrected: ino
> > 0 off 12001961418752 (dev /dev/sdd sector 11747570384)
> > [241140.127471] BTRFS info (device sdg): read error corrected: ino
> > 0 off 12001961422848 (dev /dev/sdd sector 11747570392)
> > [244514.702945] BTRFS error (device sdg): parent transid verify
> > failed on 12887435296768 wanted 357767 found 357596
> > [244514.770956] BTRFS info (device sdg): read error corrected: ino
> > 0 off 12887435296768 (dev /dev/sdd sector 12564750432)
> > [244514.772944] BTRFS info (device sdg): read error corrected: ino
> > 0 off 12887435300864 (dev /dev/sdd sector 12564750440)
> > [244514.776232] BTRFS info (device sdg): read error corrected: ino
> > 0 off 12887435304960 (dev /dev/sdd sector 12564750448)
> > [244514.777671] BTRFS info (device sdg): read error corrected: ino
> > 0 off 12887435309056 (dev /dev/sdd sector 12564750456)
> > [244522.038809] BTRFS error (device sdg): parent transid verify
> > failed on 12887435313152 wanted 357767 found 357594
> > [244522.120518] BTRFS info (device sdg): read error corrected: ino
> > 0 off 12887435313152 (dev /dev/sdd sector 12564750464)
> > [244522.122291] BTRFS info (device sdg): read error corrected: ino
> > 0 off 12887435317248 (dev /dev/sdd sector 12564750472)
> > [244522.123582] BTRFS info (device sdg): read error corrected: ino
> > 0 off 12887435321344 (dev /dev/sdd sector 12564750480)
> > [244522.124836] BTRFS info (device sdg): read error corrected: ino
> > 0 off 12887435325440 (dev /dev/sdd sector 12564750488)
> > [246861.175551] BTRFS error (device sdg): parent transid verify
> > failed on 12887462084608 wanted 357768 found 357596
> > [246861.234507] BTRFS info (device sdg): read error corrected: ino
> > 0 off 12887462084608 (dev /dev/sdd sector 12564802752)
> > [246861.236349] BTRFS info (device sdg): read error corrected: ino
> > 0 off 12887462088704 (dev /dev/sdd sector 12564802760)
> > [246861.238165] BTRFS info (device sdg): read error corrected: ino
> > 0 off 12887462092800 (dev /dev/sdd sector 12564802768)
> > [246861.239863] BTRFS info (device sdg): read error corrected: ino
> > 0 off 12887462096896 (dev /dev/sdd sector 12564802776)
> > [248185.323608] sas: Enter sas_scsi_recover_host busy: 23 failed:
> > 23
> > [248185.324525] sas: trying to find task 0x0000000025b267cc
> > [248185.324530] sas: sas_scsi_find_task: aborting task
> > 0x0000000025b267cc
> > [248185.325468] sas: sas_scsi_find_task: task 0x0000000025b267cc is
> > aborted
> > [248185.326401] sas: sas_eh_handle_sas_errors: task
> > 0x0000000025b267cc is aborted
> > [248185.327366] sas: trying to find task 0x0000000040e3e246
> > [248185.327369] sas: sas_scsi_find_task: aborting task
> > 0x0000000040e3e246
> > [248185.328341] sas: sas_scsi_find_task: task 0x0000000040e3e246 is
> > aborted
> > [248185.329311] sas: sas_eh_handle_sas_errors: task
> > 0x0000000040e3e246 is aborted
> > [248185.330292] sas: trying to find task 0x0000000011fd3d76
> > [248185.330294] sas: sas_scsi_find_task: aborting task
> > 0x0000000011fd3d76
> > [248185.331274] sas: sas_scsi_find_task: task 0x0000000011fd3d76 is
> > aborted
> > [248185.332256] sas: sas_eh_handle_sas_errors: task
> > 0x0000000011fd3d76 is aborted
> > [248185.333270] sas: trying to find task 0x000000001aeb6768
> > [248185.333272] sas: sas_scsi_find_task: aborting task
> > 0x000000001aeb6768
> > [248185.334294] sas: sas_scsi_find_task: task 0x000000001aeb6768 is
> > aborted
> > [248185.335323] sas: sas_eh_handle_sas_errors: task
> > 0x000000001aeb6768 is aborted
> > [248185.336363] sas: trying to find task 0x00000000dcb4fb6a
> > [248185.336366] sas: sas_scsi_find_task: aborting task
> > 0x00000000dcb4fb6a
> > [248185.337411] sas: sas_scsi_find_task: task 0x00000000dcb4fb6a is
> > aborted
> > [248185.338462] sas: sas_eh_handle_sas_errors: task
> > 0x00000000dcb4fb6a is aborted
> > [248185.339536] sas: trying to find task 0x00000000713475b5
> > [248185.339538] sas: sas_scsi_find_task: aborting task
> > 0x00000000713475b5
> > [248185.340623] sas: sas_scsi_find_task: task 0x00000000713475b5 is
> > aborted
> > [248185.341727] sas: sas_eh_handle_sas_errors: task
> > 0x00000000713475b5 is aborted
> > [248185.342853] sas: trying to find task 0x0000000022bf1484
> > [248185.342856] sas: sas_scsi_find_task: aborting task
> > 0x0000000022bf1484
> > [248185.343986] sas: sas_scsi_find_task: task 0x0000000022bf1484 is
> > aborted
> > [248185.345107] sas: sas_eh_handle_sas_errors: task
> > 0x0000000022bf1484 is aborted
> > [248185.346232] sas: trying to find task 0x00000000c1be6881
> > [248185.346234] sas: sas_scsi_find_task: aborting task
> > 0x00000000c1be6881
> > [248185.347366] sas: sas_scsi_find_task: task 0x00000000c1be6881 is
> > aborted
> > [248185.348509] sas: sas_eh_handle_sas_errors: task
> > 0x00000000c1be6881 is aborted
> > [248185.349675] sas: trying to find task 0x0000000094632cad
> > [248185.349678] sas: sas_scsi_find_task: aborting task
> > 0x0000000094632cad
> > [248185.350855] sas: sas_scsi_find_task: task 0x0000000094632cad is
> > aborted
> > [248185.352028] sas: sas_eh_handle_sas_errors: task
> > 0x0000000094632cad is aborted
> > [248185.353217] sas: trying to find task 0x00000000369ca205
> > [248185.353219] sas: sas_scsi_find_task: aborting task
> > 0x00000000369ca205
> > [248185.354416] sas: sas_scsi_find_task: task 0x00000000369ca205 is
> > aborted
> > [248185.355621] sas: sas_eh_handle_sas_errors: task
> > 0x00000000369ca205 is aborted
> > [248185.356849] sas: ata7: end_device-4:2: cmd error handler
> > [248185.356910] sas: ata5: end_device-4:0: dev error handler
> > [248185.356930] sas: ata6: end_device-4:1: dev error handler
> > [248185.356937] sas: ata7: end_device-4:2: dev error handler
> > [248185.356943] ata7.00: exception Emask 0x1 SAct 0xfe581fff SErr
> > 0x0 action 0x6 frozen
> > [248185.356949] sas: ata8: end_device-4:3: dev error handler
> > [248185.356984] sas: ata9: end_device-4:4: dev error handler
> > [248185.357000] sas: ata10: end_device-4:5: dev error handler
> > [248185.358239] ata7.00: failed command: READ FPDMA QUEUED
> > [248185.359517] ata7.00: cmd 60/80:00:80:25:00/00:00:89:00:00/40
> > tag 0 ncq dma 65536 in
> >                          res 43/40:00:68:24:00/00:00:89:00:00/40
> > Emask 0x9 (media error)
> > [248185.362113] ata7.00: status: { DRDY SENSE ERR }
> > [248185.363412] ata7.00: error: { UNC }
> > [248185.364702] ata7.00: failed command: READ FPDMA QUEUED
> > [248185.366008] ata7.00: cmd 60/80:00:80:27:00/00:00:89:00:00/40
> > tag 1 ncq dma 65536 in
> >                          res 43/04:08:80:27:00/00:00:89:00:00/40
> > Emask 0x1 (device error)
> > [248185.368705] ata7.00: status: { DRDY SENSE ERR }
> > [248185.370059] ata7.00: error: { ABRT }
> > [248185.371406] ata7.00: failed command: READ FPDMA QUEUED
> > [248185.372764] ata7.00: cmd 60/80:00:00:17:00/00:00:89:00:00/40
> > tag 2 ncq dma 65536 in
> >                          res 43/04:10:00:17:00/00:00:89:00:00/40
> > Emask 0x1 (device error)
> > [248185.375565] ata7.00: status: { DRDY SENSE ERR }
> > [248185.376985] ata7.00: error: { ABRT }
> > [248185.378416] ata7.00: failed command: READ FPDMA QUEUED
> > [248185.379832] ata7.00: cmd 60/80:00:00:19:00/00:00:89:00:00/40
> > tag 3 ncq dma 65536 in
> >                          res 43/04:18:00:19:00/00:00:89:00:00/40
> > Emask 0x1 (device error)
> > [248185.382668] ata7.00: status: { DRDY SENSE ERR }
> > [248185.384082] ata7.00: error: { ABRT }
> > [248185.385477] ata7.00: failed command: READ FPDMA QUEUED
> > [248185.386881] ata7.00: cmd 60/80:00:00:1b:00/00:00:89:00:00/40
> > tag 4 ncq dma 65536 in
> >                          res 43/04:20:00:1b:00/00:00:89:00:00/40
> > Emask 0x1 (device error)
> > [248185.389716] ata7.00: status: { DRDY SENSE ERR }
> > [248185.391135] ata7.00: error: { ABRT }
> > [248185.392535] ata7.00: failed command: READ FPDMA QUEUED
> > [248185.393934] ata7.00: cmd 60/80:00:00:1d:00/00:00:89:00:00/40
> > tag 5 ncq dma 65536 in
> >                          res 43/04:28:00:1d:00/00:00:89:00:00/40
> > Emask 0x1 (device error)
> > [248185.396777] ata7.00: status: { DRDY SENSE ERR }
> > [248185.398192] ata7.00: error: { ABRT }
> > [248185.399596] ata7.00: failed command: READ FPDMA QUEUED
> > [248185.400996] ata7.00: cmd 60/80:00:00:1f:00/00:00:89:00:00/40
> > tag 6 ncq dma 65536 in
> >                          res 43/04:38:00:21:00/00:00:89:00:00/40
> > Emask 0x1 (device error)
> > [248185.403850] ata7.00: status: { DRDY SENSE ERR }
> > [248185.405203] ata7.00: error: { ABRT }
> > [248185.406527] ata7.00: failed command: READ FPDMA QUEUED
> > [248185.407800] ata7.00: cmd 60/80:00:00:21:00/00:00:89:00:00/40
> > tag 7 ncq dma 65536 in
> >                          res 43/04:38:00:21:00/00:00:89:00:00/40
> > Emask 0x1 (device error)
> > [248185.410355] ata7.00: status: { DRDY SENSE ERR }
> > [248185.411578] ata7.00: error: { ABRT }
> > [248185.412777] ata7.00: failed command: READ FPDMA QUEUED
> > [248185.413927] ata7.00: cmd 60/80:00:00:23:00/00:00:89:00:00/40
> > tag 8 ncq dma 65536 in
> >                          res 43/04:40:00:23:00/00:00:89:00:00/40
> > Emask 0x1 (device error)
> > [248185.416245] ata7.00: status: { DRDY SENSE ERR }
> > [248185.417361] ata7.00: error: { ABRT }
> > [248185.418456] ata7.00: failed command: READ FPDMA QUEUED
> > [248185.419549] ata7.00: cmd 60/80:00:00:25:00/00:00:89:00:00/40
> > tag 9 ncq dma 65536 in
> >                          res 43/04:48:00:25:00/00:00:89:00:00/40
> > Emask 0x1 (device error)
> > [248185.421744] ata7.00: status: { DRDY SENSE ERR }
> > [248185.422792] ata7.00: error: { ABRT }
> > [248185.423822] ata7.00: failed command: READ FPDMA QUEUED
> > [248185.424808] ata7.00: cmd 60/80:00:00:27:00/00:00:89:00:00/40
> > tag 10 ncq dma 65536 in
> >                          res 43/04:50:00:27:00/00:00:89:00:00/40
> > Emask 0x1 (device error)
> > [248185.426818] ata7.00: status: { DRDY SENSE ERR }
> > [248185.427812] ata7.00: error: { ABRT }
> > [248185.428803] ata7.00: failed command: READ FPDMA QUEUED
> > [248185.429755] ata7.00: cmd 60/80:00:80:29:00/00:00:89:00:00/40
> > tag 11 ncq dma 65536 in
> >                          res 43/04:58:80:29:00/00:00:89:00:00/40
> > Emask 0x1 (device error)
> > [248185.431691] ata7.00: status: { DRDY SENSE ERR }
> > [248185.432624] ata7.00: error: { ABRT }
> > [248185.433535] ata7.00: failed command: READ FPDMA QUEUED
> > [248185.434443] ata7.00: cmd 60/80:00:00:29:00/00:00:89:00:00/40
> > tag 12 ncq dma 65536 in
> >                          res 43/04:60:00:29:00/00:00:89:00:00/40
> > Emask 0x1 (device error)
> > [248185.436245] ata7.00: status: { DRDY SENSE ERR }
> > [248185.437136] ata7.00: error: { ABRT }
> > [248185.438016] ata7.00: failed command: READ FPDMA QUEUED
> > [248185.438870] ata7.00: cmd 60/00:00:00:24:00/01:00:89:00:00/40
> > tag 19 ncq dma 131072 in
> >                          res 43/04:60:00:29:00/00:00:89:00:00/40
> > Emask 0x5 (timeout)
> > [248185.440604] ata7.00: status: { DRDY SENSE ERR }
> > [248185.441465] ata7.00: error: { ABRT }
> > [248185.442319] ata7.00: failed command: READ FPDMA QUEUED
> > [248185.443150] ata7.00: cmd 60/00:00:00:26:00/01:00:89:00:00/40
> > tag 20 ncq dma 131072 in
> >                          res 43/04:60:00:29:00/00:00:89:00:00/40
> > Emask 0x5 (timeout)
> > [248185.444852] ata7.00: status: { DRDY SENSE ERR }
> > [248185.445689] ata7.00: error: { ABRT }
> > [248185.446501] ata7.00: failed command: READ FPDMA QUEUED
> > [248185.447298] ata7.00: cmd 60/00:00:00:28:00/01:00:89:00:00/40
> > tag 22 ncq dma 131072 in
> >                          res 43/04:60:00:29:00/00:00:89:00:00/40
> > Emask 0x5 (timeout)
> > [248185.448944] ata7.00: status: { DRDY SENSE ERR }
> > [248185.449739] ata7.00: error: { ABRT }
> > [248185.450510] ata7.00: failed command: READ FPDMA QUEUED
> > [248185.451277] ata7.00: cmd 60/80:00:80:17:00/00:00:89:00:00/40
> > tag 25 ncq dma 65536 in
> >                          res 43/04:60:00:29:00/00:00:89:00:00/40
> > Emask 0x5 (timeout)
> > [248185.452852] ata7.00: status: { DRDY SENSE ERR }
> > [248185.453617] ata7.00: error: { ABRT }
> > [248185.454362] ata7.00: failed command: READ FPDMA QUEUED
> > [248185.455106] ata7.00: cmd 60/80:00:80:19:00/00:00:89:00:00/40
> > tag 26 ncq dma 65536 in
> >                          res 43/04:60:00:29:00/00:00:89:00:00/40
> > Emask 0x5 (timeout)
> > [248185.456633] ata7.00: status: { DRDY SENSE ERR }
> > [248185.457391] ata7.00: error: { ABRT }
> > [248185.458160] ata7.00: failed command: READ FPDMA QUEUED
> > [248185.458913] ata7.00: cmd 60/80:00:80:1b:00/00:00:89:00:00/40
> > tag 27 ncq dma 65536 in
> >                          res 43/04:60:00:29:00/00:00:89:00:00/40
> > Emask 0x5 (timeout)
> > [248185.460403] ata7.00: status: { DRDY SENSE ERR }
> > [248185.461144] ata7.00: error: { ABRT }
> > [248185.461877] ata7.00: failed command: READ FPDMA QUEUED
> > [248185.462624] ata7.00: cmd 60/80:00:80:1d:00/00:00:89:00:00/40
> > tag 28 ncq dma 65536 in
> >                          res 43/04:60:00:29:00/00:00:89:00:00/40
> > Emask 0x5 (timeout)
> > [248185.464121] ata7.00: status: { DRDY SENSE ERR }
> > [248185.464859] ata7.00: error: { ABRT }
> > [248185.465581] ata7.00: failed command: READ FPDMA QUEUED
> > [248185.466291] ata7.00: cmd 60/80:00:80:1f:00/00:00:89:00:00/40
> > tag 29 ncq dma 65536 in
> >                          res 43/04:60:00:29:00/00:00:89:00:00/40
> > Emask 0x5 (timeout)
> > [248185.467748] ata7.00: status: { DRDY SENSE ERR }
> > [248185.468453] ata7.00: error: { ABRT }
> > [248185.469167] ata7.00: failed command: READ FPDMA QUEUED
> > [248185.469875] ata7.00: cmd 60/80:00:80:21:00/00:00:89:00:00/40
> > tag 30 ncq dma 65536 in
> >                          res 43/04:60:00:29:00/00:00:89:00:00/40
> > Emask 0x5 (timeout)
> > [248185.471309] ata7.00: status: { DRDY SENSE ERR }
> > [248185.472025] ata7.00: error: { ABRT }
> > [248185.472740] ata7.00: failed command: READ FPDMA QUEUED
> > [248185.473431] ata7.00: cmd 60/80:00:80:23:00/00:00:89:00:00/40
> > tag 31 ncq dma 65536 in
> >                          res 43/04:60:00:29:00/00:00:89:00:00/40
> > Emask 0x5 (timeout)
> > [248185.474881] ata7.00: status: { DRDY SENSE ERR }
> > [248185.475598] ata7.00: error: { ABRT }
> > [248185.476291] ata7: hard resetting link
> > [248185.642262] sas: sas_form_port: phy0 belongs to port2
> > already(1)!
> > [248187.732565] drivers/scsi/mvsas/mv_sas.c
> > 1415:mvs_I_T_nexus_reset for device[0]:rc= 0
> > [248192.916472] ata7.00: qc timeout (cmd 0xec)
> > [248192.917921] ata7.00: failed to IDENTIFY (I/O error,
> > err_mask=0x5)
> > [248192.919286] ata7.00: revalidation failed (errno=-5)
> > [248192.920627] ata7: hard resetting link
> > [248193.086049] sas: sas_form_port: phy0 belongs to port2
> > already(1)!
> > [248195.156355] drivers/scsi/mvsas/mv_sas.c
> > 1415:mvs_I_T_nexus_reset for device[0]:rc= 0
> > [248205.717134] ata7.00: qc timeout (cmd 0xa1)
> > [248205.717188] ata7.00: failed to IDENTIFY (I/O error,
> > err_mask=0x5)
> > [248205.717234] ata7.00: revalidation failed (errno=-5)
> > [248205.717274] ata7: hard resetting link
> > [248205.881563] sas: sas_form_port: phy0 belongs to port2
> > already(1)!
> > [248207.956064] drivers/scsi/mvsas/mv_sas.c
> > 1415:mvs_I_T_nexus_reset for device[0]:rc= 0
> > [248238.483453] ata7.00: qc timeout (cmd 0xa1)
> > [248238.484852] ata7.00: failed to IDENTIFY (I/O error,
> > err_mask=0x5)
> > [248238.486205] ata7.00: revalidation failed (errno=-5)
> > [248238.487539] ata7.00: disabled
> > [248238.653105] sas: sas_form_port: phy0 belongs to port2
> > already(1)!
> > [248240.723356] drivers/scsi/mvsas/mv_sas.c
> > 1415:mvs_I_T_nexus_reset for device[0]:rc= 0
> > [248240.875378] sd 4:0:2:0: [sdd] tag#341 FAILED Result:
> > hostbyte=DID_OK driverbyte=DRIVER_SENSE cmd_age=64s
> > [248240.876786] sd 4:0:2:0: [sdd] tag#341 Sense Key : Not Ready
> > [current] 
> > [248240.878170] sd 4:0:2:0: [sdd] tag#341 Add. Sense: Logical unit
> > not ready, hard reset required
> > [248240.879564] sd 4:0:2:0: [sdd] tag#341 CDB: Read(16) 88 00 00 00
> > 00 00 89 00 25 80 00 00 00 80 00 00
> > [248240.880971] blk_update_request: I/O error, dev sdd, sector
> > 2298488192 op 0x0:(READ) flags 0x0 phys_seg 16 prio class 0
> > [248240.882483] ata7: EH complete
> > [248240.883936] sas: --- Exit sas_scsi_recover_host: busy: 0
> > failed: 23 tries: 1
> > [248240.885612] sd 4:0:2:0: [sdd] tag#366 FAILED Result:
> > hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK cmd_age=0s
> > [248240.886930] sd 4:0:2:0: [sdd] tag#366 CDB: Write(16) 8a 00 00
> > 00 00 00 89 00 25 80 00 00 00 80 00 00
> > [248240.888059] blk_update_request: I/O error, dev sdd, sector
> > 2298488192 op 0x1:(WRITE) flags 0x0 phys_seg 16 prio class 0
> > [248240.889244] sd 4:0:2:0: [sdd] tag#369 FAILED Result:
> > hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK cmd_age=0s
> > [248240.890416] sd 4:0:2:0: [sdd] tag#369 CDB: Write(16) 8a 00 00
> > 00 00 00 00 46 11 00 00 00 00 80 00 00
> > [248240.891589] blk_update_request: I/O error, dev sdd, sector
> > 4591872 op 0x1:(WRITE) flags 0x0 phys_seg 2 prio class 0
> > [248240.892790] sd 4:0:2:0: [sdd] tag#370 FAILED Result:
> > hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK cmd_age=0s
> > [248240.894016] sd 4:0:2:0: [sdd] tag#370 CDB: Write(16) 8a 00 00
> > 00 00 00 00 7f a9 80 00 00 00 80 00 00
> > [248240.895262] blk_update_request: I/O error, dev sdd, sector
> > 8366464 op 0x1:(WRITE) flags 0x0 phys_seg 16 prio class 0
> > [248240.896719] sd 4:0:2:0: [sdd] tag#371 FAILED Result:
> > hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK cmd_age=0s
> > [248240.898440] sd 4:0:2:0: [sdd] tag#371 CDB: Write(16) 8a 00 00
> > 00 00 00 1a 92 86 70 00 00 01 90 00 00
> > [248240.898442] blk_update_request: I/O error, dev sdd, sector
> > 445810288 op 0x1:(WRITE) flags 0x0 phys_seg 50 prio class 0
> > [248240.898468] sd 4:0:2:0: [sdd] tag#373 FAILED Result:
> > hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK cmd_age=64s
> > [248240.898471] sd 4:0:2:0: [sdd] tag#373 CDB: Read(16) 88 00 00 00
> > 00 00 89 00 23 80 00 00 00 80 00 00
> > [248240.898473] blk_update_request: I/O error, dev sdd, sector
> > 2298487680 op 0x0:(READ) flags 0x0 phys_seg 16 prio class 0
> > [248240.898485] sd 4:0:2:0: [sdd] tag#374 FAILED Result:
> > hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK cmd_age=64s
> > [248240.898487] sd 4:0:2:0: [sdd] tag#374 CDB: Read(16) 88 00 00 00
> > 00 00 89 00 21 80 00 00 00 80 00 00
> > [248240.898489] blk_update_request: I/O error, dev sdd, sector
> > 2298487168 op 0x0:(READ) flags 0x0 phys_seg 16 prio class 0
> > [248240.898495] sd 4:0:2:0: [sdd] tag#375 FAILED Result:
> > hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK cmd_age=64s
> > [248240.898498] sd 4:0:2:0: [sdd] tag#375 CDB: Read(16) 88 00 00 00
> > 00 00 89 00 1f 80 00 00 00 80 00 00
> > [248240.898499] blk_update_request: I/O error, dev sdd, sector
> > 2298486656 op 0x0:(READ) flags 0x0 phys_seg 16 prio class 0
> > [248240.898506] sd 4:0:2:0: [sdd] tag#376 FAILED Result:
> > hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK cmd_age=64s
> > [248240.898516] sd 4:0:2:0: [sdd] tag#376 CDB: Read(16) 88 00 00 00
> > 00 00 89 00 1d 80 00 00 00 80 00 00
> > [248240.898518] blk_update_request: I/O error, dev sdd, sector
> > 2298486144 op 0x0:(READ) flags 0x0 phys_seg 16 prio class 0
> > [248240.898523] sd 4:0:2:0: [sdd] tag#379 FAILED Result:
> > hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK cmd_age=64s
> > [248240.898679] blk_update_request: I/O error, dev sdd, sector
> > 446460800 op 0x1:(WRITE) flags 0x0 phys_seg 112 prio class 0
> > [248240.899999] BTRFS error (device sdg): bdev /dev/sdd errs: wr
> > 74390652, rd 1756349, flush 189, corrupt 37086, gen 21
> > [248240.918953] BTRFS error (device sdg): bdev /dev/sdd errs: wr
> > 74390653, rd 1756349, flush 189, corrupt 37086, gen 21
> > [248240.919392] sd 4:0:2:0: [sdd] tag#379 CDB: Read(16) 88 00 00 00
> > 00 00 89 00 1b 80 00 00 00 80 00 00
> > [248241.032740] BTRFS error (device sdg): bdev /dev/sdd errs: wr
> > 74390653, rd 1756350, flush 189, corrupt 37086, gen 21
> > [248241.036581] BTRFS error (device sdg): bdev /dev/sdd errs: wr
> > 74390653, rd 1756351, flush 189, corrupt 37086, gen 21
> > [248241.157945] BTRFS warning (device sdg): i/o error at logical
> > 2347222237184 on dev /dev/sdd, physical 1176826544128, root 5,
> > inode 1119818, offset 1004863488, length 4096, links 1 (path:
> > <REMOVED>) 
> > [248241.157950] BTRFS error (device sdg): bdev /dev/sdd errs: wr
> > 74390653, rd 1756352, flush 189, corrupt 37086, gen 21
> > [248241.157957] BTRFS warning (device sdg): i/o error at logical
> > 2347223810048 on dev /dev/sdd, physical 1176827330560, root 5,
> > inode 1119818, offset 1006436352, length 4096, links 1 (path:
> > <REMOVED>)
> > [248241.157957] BTRFS warning (device sdg): i/o error at logical
> > 2347224858624 on dev /dev/sdd, physical 1176827854848, root 5,
> > inode 1119818, offset 1007484928, length 4096, links 1 (path:
> > <REMOVED>)
> > [248241.157971] BTRFS error (device sdg): bdev /dev/sdd errs: wr
> > 74390653, rd 1756353, flush 189, corrupt 37086, gen 21
> > [248241.158062] BTRFS warning (device sdg): i/o error at logical
> > 2347223285760 on dev /dev/sdd, physical 1176827068416, root 5,
> > inode 1119818, offset 1005912064, length 4096, links 1 (path:
> > <REMOVED>)
> > [248241.158071] BTRFS error (device sdg): bdev /dev/sdd errs: wr
> > 74390653, rd 1756354, flush 189, corrupt 37086, gen 21
> > [248241.158171] BTRFS warning (device sdg): i/o error at logical
> > 2347222761472 on dev /dev/sdd, physical 1176826806272, root 5,
> > inode 1119818, offset 1005387776, length 4096, links 1 (path:
> > <REMOVED>)
> > [248241.158178] BTRFS error (device sdg): bdev /dev/sdd errs: wr
> > 74390653, rd 1756355, flush 189, corrupt 37086, gen 21
> > [248241.163801] BTRFS error (device sdg): bdev /dev/sdd errs: wr
> > 74390653, rd 1756356, flush 189, corrupt 37086, gen 21
> > [248241.179914] BTRFS error (device sdg): bdev /dev/sdd errs: wr
> > 74390654, rd 1756356, flush 189, corrupt 37086, gen 21
> > [248241.198529] BTRFS error (device sdg): unable to fixup (regular)
> > error at logical 2347222237184 on dev /dev/sdd
> > [248241.198939] BTRFS error (device sdg): unable to fixup (regular)
> > error at logical 2347222761472 on dev /dev/sdd
> > [248241.199055] BTRFS error (device sdg): unable to fixup (regular)
> > error at logical 2347223285760 on dev /dev/sdd
> > [248241.199339] BTRFS warning (device sdg): i/o error at logical
> > 2347223351296 on dev /dev/sdd, physical 1176827133952, root 5,
> > inode 1119818, offset 1005977600, length 4096, links 1 (path:
> > <REMOVED>)
> > [248241.199945] BTRFS warning (device sdg): i/o error at logical
> > 2347222302720 on dev /dev/sdd, physical 1176826609664, root 5,
> > inode 1119818, offset 1004929024, length 4096, links 1 (path:
> > <REMOVED>)
> > [248241.200048] BTRFS error (device sdg): unable to fixup (regular)
> > error at logical 2347224858624 on dev /dev/sdd
> > [248241.200236] BTRFS warning (device sdg): i/o error at logical
> > 2347224924160 on dev /dev/sdd, physical 1176827920384, root 5,
> > inode 1119818, offset 1007550464, length 4096, links 1 (path:
> > <REMOVED>)
> > [248241.201048] BTRFS warning (device sdg): i/o error at logical
> > 2347222827008 on dev /dev/sdd, physical 1176826871808, root 5,
> > inode 1119818, offset 1005453312, length 4096, links 1 (path:
> > <REMOVED>)
> > [248241.201159] BTRFS error (device sdg): unable to fixup (regular)
> > error at logical 2347224334336 on dev /dev/sdd
> > [248241.201188] BTRFS error (device sdg): unable to fixup (regular)
> > error at logical 2347223810048 on dev /dev/sdd
> > [248241.216166] BTRFS error (device sdg): unable to fixup (regular)
> > error at logical 2347223875584 on dev /dev/sdd
> > [248241.220764] BTRFS error (device sdg): unable to fixup (regular)
> > error at logical 2347224924160 on dev /dev/sdd
> > [248241.223012] BTRFS error (device sdg): unable to fixup (regular)
> > error at logical 2347224399872 on dev /dev/sdd
> > [248241.224564] BTRFS error (device sdg): unable to fixup (regular)
> > error at logical 2347223351296 on dev /dev/sdd
> > [248241.552090] BTRFS warning (device sdg): lost page write due to
> > IO error on /dev/sdd (-5)
> > [248241.552801] BTRFS warning (device sdg): lost page write due to
> > IO error on /dev/sdd (-5)
> > [248241.553390] BTRFS warning (device sdg): lost page write due to
> > IO error on /dev/sdd (-5)
> > [248241.587414] BTRFS error (device sdg): error writing primary
> > super block to device 3
> > [248241.597855] BTRFS info (device sdg): scrub: not finished on
> > devid 3 with status: -125
> > [248246.510344] scsi_io_completion_action: 2646 callbacks
> > suppressed
> > [248246.510354] sd 4:0:2:0: [sdd] tag#339 FAILED Result:
> > hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK cmd_age=0s
> > [248246.513974] sd 4:0:2:0: [sdd] tag#346 FAILED Result:
> > hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK cmd_age=0s
> > [248246.515035] sd 4:0:2:0: [sdd] tag#339 CDB: Write(16) 8a 00 00
> > 00 00 00 00 2d 41 08 00 00 00 18 00 00
> > [248246.517310] sd 4:0:2:0: [sdd] tag#346 CDB: Read(16) 88 00 00 00
> > 00 00 00 2f 42 80 00 00 00 68 00 00
> > [248246.519554] print_req_error: 2647 callbacks suppressed
> > [248246.519556] blk_update_request: I/O error, dev sdd, sector
> > 2965768 op 0x1:(WRITE) flags 0x0 phys_seg 3 prio class 0
> > [248246.521786] blk_update_request: I/O error, dev sdd, sector
> > 3097216 op 0x0:(READ) flags 0x0 phys_seg 13 prio class 0
> > [248246.548440] sd 4:0:2:0: [sdd] tag#349 FAILED Result:
> > hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK cmd_age=0s
> > [248246.550622] sd 4:0:2:0: [sdd] tag#349 CDB: Write(16) 8a 00 00
> > 00 00 00 00 2f 42 e8 00 00 00 18 00 00
> > [248246.552762] blk_update_request: I/O error, dev sdd, sector
> > 3097320 op 0x1:(WRITE) flags 0x0 phys_seg 3 prio class 0
> > [248247.312672] sd 4:0:2:0: [sdd] tag#354 FAILED Result:
> > hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK cmd_age=0s
> > [248247.313341] sd 4:0:2:0: [sdd] tag#357 FAILED Result:
> > hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK cmd_age=0s
> > [248247.314351] sd 4:0:2:0: [sdd] tag#364 FAILED Result:
> > hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK cmd_age=0s
> > [248247.314358] sd 4:0:2:0: [sdd] tag#364 CDB: Write(16) 8a 00 00
> > 00 00 00 16 9f fe 80 00 00 00 80 00 00
> > [248247.314361] blk_update_request: I/O error, dev sdd, sector
> > 379584128 op 0x1:(WRITE) flags 0x0 phys_seg 16 prio class 0
> > [248247.314833] sd 4:0:2:0: [sdd] tag#354 CDB: Write(16) 8a 00 00
> > 00 00 00 16 9f fd 80 00 00 00 80 00 00
> > [248247.316918] sd 4:0:2:0: [sdd] tag#357 CDB: Write(16) 8a 00 00
> > 00 00 00 16 9f fe 00 00 00 00 80 00 00
> > [248247.318927] blk_update_request: I/O error, dev sdd, sector
> > 379583872 op 0x1:(WRITE) flags 0x0 phys_seg 16 prio class 0
> > [248247.320923] blk_update_request: I/O error, dev sdd, sector
> > 379584000 op 0x1:(WRITE) flags 0x0 phys_seg 16 prio class 0
> > [248247.339165] sd 4:0:2:0: [sdd] tag#320 FAILED Result:
> > hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK cmd_age=0s
> > [248247.341190] sd 4:0:2:0: [sdd] tag#320 CDB: Write(16) 8a 00 00
> > 00 00 00 16 9f ff 00 00 00 00 80 00 00
> > [248247.343224] blk_update_request: I/O error, dev sdd, sector
> > 379584256 op 0x1:(WRITE) flags 0x0 phys_seg 16 prio class 0
> > [248251.985758] sd 4:0:2:0: [sdd] tag#321 FAILED Result:
> > hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK cmd_age=0s
> > [248251.989913] sd 4:0:2:0: [sdd] tag#321 CDB: Read(16) 88 00 00 00
> > 00 00 00 2f 43 00 00 00 00 80 00 00
> > [248251.992006] blk_update_request: I/O error, dev sdd, sector
> > 3097344 op 0x0:(READ) flags 0x0 phys_seg 16 prio class 0
> > [248253.492058] sd 4:0:2:0: [sdd] tag#328 FAILED Result:
> > hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK cmd_age=0s
> > [248253.492083] sd 4:0:2:0: [sdd] tag#332 FAILED Result:
> > hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK cmd_age=0s
> > [248253.492125] sd 4:0:2:0: [sdd] tag#336 FAILED Result:
> > hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK cmd_age=0s
> > [248253.492132] sd 4:0:2:0: [sdd] tag#336 CDB: Write(16) 8a 00 00
> > 00 00 00 00 36 49 80 00 00 00 80 00 00
> > [248253.492134] blk_update_request: I/O error, dev sdd, sector
> > 3557760 op 0x1:(WRITE) flags 0x0 phys_seg 16 prio class 0
> > [248253.495611] sd 4:0:2:0: [sdd] tag#339 FAILED Result:
> > hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK cmd_age=0s
> > [248253.495617] sd 4:0:2:0: [sdd] tag#339 CDB: Write(16) 8a 00 00
> > 00 00 00 00 e0 4a f0 00 00 00 08 00 00
> > [248253.495619] blk_update_request: I/O error, dev sdd, sector
> > 14699248 op 0x1:(WRITE) flags 0x0 phys_seg 1 prio class 0
> > [248253.496193] sd 4:0:2:0: [sdd] tag#328 CDB: Write(16) 8a 00 00
> > 00 00 00 00 2c 4a 98 00 00 00 08 00 00
> > [248253.498278] sd 4:0:2:0: [sdd] tag#332 CDB: Write(16) 8a 00 00
> > 00 00 00 00 34 4f 80 00 00 00 80 00 00
> > [248253.500302] blk_update_request: I/O error, dev sdd, sector
> > 2902680 op 0x1:(WRITE) flags 0x0 phys_seg 1 prio class 0
> > [248253.516167] blk_update_request: I/O error, dev sdd, sector
> > 3428224 op 0x1:(WRITE) flags 0x0 phys_seg 16 prio class 0
> > [248254.191723] sd 4:0:2:0: [sdd] tag#343 FAILED Result:
> > hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK cmd_age=0s
> > [248254.195373] sd 4:0:2:0: [sdd] tag#343 CDB: Write(16) 8a 00 00
> > 00 00 00 1b 27 82 00 00 00 00 80 00 00
> > [248254.197609] blk_update_request: I/O error, dev sdd, sector
> > 455574016 op 0x1:(WRITE) flags 0x0 phys_seg 16 prio class 0
> > [248254.199941] sd 4:0:2:0: [sdd] tag#346 FAILED Result:
> > hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK cmd_age=0s
> > [248254.202240] sd 4:0:2:0: [sdd] tag#346 CDB: Write(16) 8a 00 00
> > 00 00 00 1b 27 82 80 00 00 00 80 00 00
> > [248254.204515] blk_update_request: I/O error, dev sdd, sector
> > 455574144 op 0x1:(WRITE) flags 0x0 phys_seg 16 prio class 0
> > [248254.206872] sd 4:0:2:0: [sdd] tag#353 FAILED Result:
> > hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK cmd_age=0s
> > [248254.209220] sd 4:0:2:0: [sdd] tag#353 CDB: Write(16) 8a 00 00
> > 00 00 00 1b 27 83 00 00 00 00 80 00 00
> > [248254.211586] blk_update_request: I/O error, dev sdd, sector
> > 455574272 op 0x1:(WRITE) flags 0x0 phys_seg 16 prio class 0
> > [248254.213992] sd 4:0:2:0: [sdd] tag#356 FAILED Result:
> > hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK cmd_age=0s
> > [248254.216369] sd 4:0:2:0: [sdd] tag#356 CDB: Write(16) 8a 00 00
> > 00 00 00 1b 27 83 80 00 00 00 80 00 00
> > [248254.216370] blk_update_request: I/O error, dev sdd, sector
> > 455574400 op 0x1:(WRITE) flags 0x0 phys_seg 16 prio class 0
> > [248254.216405] sd 4:0:2:0: [sdd] tag#359 FAILED Result:
> > hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK cmd_age=0s
> > [248254.216407] sd 4:0:2:0: [sdd] tag#359 CDB: Write(16) 8a 00 00
> > 00 00 00 1b 27 84 00 00 00 00 80 00 00
> > [248254.216408] blk_update_request: I/O error, dev sdd, sector
> > 455574528 op 0x1:(WRITE) flags 0x0 phys_seg 16 prio class 0
> > [248265.400125] scsi_io_completion_action: 9 callbacks suppressed
> > [248265.400136] sd 4:0:2:0: [sdd] tag#340 FAILED Result:
> > hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK cmd_age=0s
> > [248265.400977] sd 4:0:2:0: [sdd] tag#344 FAILED Result:
> > hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK cmd_age=0s
> > [248265.401965] sd 4:0:2:0: [sdd] tag#383 FAILED Result:
> > hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK cmd_age=0s
> > [248265.401972] sd 4:0:2:0: [sdd] tag#383 CDB: Write(16) 8a 00 00
> > 00 00 00 24 f7 b1 00 00 00 00 80 00 00
> > [248265.401974] print_req_error: 9 callbacks suppressed
> > [248265.401976] blk_update_request: I/O error, dev sdd, sector
> > 620212480 op 0x1:(WRITE) flags 0x0 phys_seg 16 prio class 0
> > [248265.402093] sd 4:0:2:0: [sdd] tag#322 FAILED Result:
> > hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK cmd_age=0s
> > [248265.402097] sd 4:0:2:0: [sdd] tag#322 CDB: Write(16) 8a 00 00
> > 00 00 00 24 f7 b1 80 00 00 00 80 00 00
> > [248265.402099] blk_update_request: I/O error, dev sdd, sector
> > 620212608 op 0x1:(WRITE) flags 0x0 phys_seg 16 prio class 0
> > [248265.402252] sd 4:0:2:0: [sdd] tag#325 FAILED Result:
> > hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK cmd_age=0s
> > [248265.402256] sd 4:0:2:0: [sdd] tag#325 CDB: Write(16) 8a 00 00
> > 00 00 00 24 f7 b2 00 00 00 00 80 00 00
> > [248265.402258] blk_update_request: I/O error, dev sdd, sector
> > 620212736 op 0x1:(WRITE) flags 0x0 phys_seg 16 prio class 0
> > [248265.402274] sd 4:0:2:0: [sdd] tag#340 CDB: Write(16) 8a 00 00
> > 00 00 00 24 f7 b0 00 00 00 00 80 00 00
> > [248265.402276] blk_update_request: I/O error, dev sdd, sector
> > 620212224 op 0x1:(WRITE) flags 0x0 phys_seg 16 prio class 0
> > [248265.404418] sd 4:0:2:0: [sdd] tag#344 CDB: Write(16) 8a 00 00
> > 00 00 00 24 f7 b0 80 00 00 00 80 00 00
> > [248265.404421] blk_update_request: I/O error, dev sdd, sector
> > 620212352 op 0x1:(WRITE) flags 0x0 phys_seg 16 prio class 0
> > [248265.407580] sd 4:0:2:0: [sdd] tag#328 FAILED Result:
> > hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK cmd_age=0s
> > [248265.438963] sd 4:0:2:0: [sdd] tag#328 CDB: Write(16) 8a 00 00
> > 00 00 00 24 f7 b2 80 00 00 00 80 00 00
> > [248265.441211] blk_update_request: I/O error, dev sdd, sector
> > 620212864 op 0x1:(WRITE) flags 0x0 phys_seg 16 prio class 0
> > [248265.443497] sd 4:0:2:0: [sdd] tag#335 FAILED Result:
> > hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK cmd_age=0s
> > [248265.445761] sd 4:0:2:0: [sdd] tag#335 CDB: Write(16) 8a 00 00
> > 00 00 00 24 f7 b3 00 00 00 00 80 00 00
> > [248265.447921] blk_update_request: I/O error, dev sdd, sector
> > 620212992 op 0x1:(WRITE) flags 0x0 phys_seg 16 prio class 0
> > [248265.450038] sd 4:0:2:0: [sdd] tag#338 FAILED Result:
> > hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK cmd_age=0s
> > [248265.452151] sd 4:0:2:0: [sdd] tag#338 CDB: Write(16) 8a 00 00
> > 00 00 00 24 f7 b3 80 00 00 00 80 00 00
> > [248265.454132] blk_update_request: I/O error, dev sdd, sector
> > 620213120 op 0x1:(WRITE) flags 0x0 phys_seg 16 prio class 0
> > [248265.456137] sd 4:0:2:0: [sdd] tag#346 FAILED Result:
> > hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK cmd_age=0s
> > [248265.458043] sd 4:0:2:0: [sdd] tag#346 CDB: Write(16) 8a 00 00
> > 00 00 00 24 f7 b4 00 00 00 00 80 00 00
> > [248265.459922] blk_update_request: I/O error, dev sdd, sector
> > 620213248 op 0x1:(WRITE) flags 0x0 phys_seg 16 prio class 0
> > [248265.461752] sd 4:0:2:0: [sdd] tag#352 FAILED Result:
> > hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK cmd_age=0s
> > [248265.463587] sd 4:0:2:0: [sdd] tag#352 CDB: Write(16) 8a 00 00
> > 00 00 00 24 f7 b4 80 00 00 00 80 00 00
> > [248265.465335] blk_update_request: I/O error, dev sdd, sector
> > 620213376 op 0x1:(WRITE) flags 0x0 phys_seg 16 prio class 0
> > [248271.623282] scsi_io_completion_action: 5 callbacks suppressed
> > [248271.623293] sd 4:0:2:0: [sdd] tag#380 FAILED Result:
> > hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK cmd_age=0s
> > [248271.623299] sd 4:0:2:0: [sdd] tag#382 FAILED Result:
> > hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK cmd_age=0s
> > [248271.625635] sd 4:0:2:0: [sdd] tag#321 FAILED Result:
> > hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK cmd_age=0s
> > [248271.625657] sd 4:0:2:0: [sdd] tag#321 CDB: Write(16) 8a 00 00
> > 00 00 00 1a 92 c0 00 00 00 00 80 00 00
> > [248271.625660] print_req_error: 5 callbacks suppressed
> > [248271.625662] blk_update_request: I/O error, dev sdd, sector
> > 445825024 op 0x1:(WRITE) flags 0x0 phys_seg 16 prio class 0
> > [248271.625735] sd 4:0:2:0: [sdd] tag#380 CDB: Write(16) 8a 00 00
> > 00 00 00 1a 92 bf 80 00 00 00 80 00 00
> > [248271.625782] sd 4:0:2:0: [sdd] tag#324 FAILED Result:
> > hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK cmd_age=0s
> > [248271.625786] sd 4:0:2:0: [sdd] tag#324 CDB: Write(16) 8a 00 00
> > 00 00 00 1a 92 c0 80 00 00 00 80 00 00
> > [248271.625788] blk_update_request: I/O error, dev sdd, sector
> > 445825152 op 0x1:(WRITE) flags 0x0 phys_seg 16 prio class 0
> > [248271.625998] sd 4:0:2:0: [sdd] tag#331 FAILED Result:
> > hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK cmd_age=0s
> > [248271.626002] sd 4:0:2:0: [sdd] tag#331 CDB: Write(16) 8a 00 00
> > 00 00 00 1a 92 c1 00 00 00 00 80 00 00
> > [248271.626003] blk_update_request: I/O error, dev sdd, sector
> > 445825280 op 0x1:(WRITE) flags 0x0 phys_seg 16 prio class 0
> > [248271.628180] sd 4:0:2:0: [sdd] tag#382 CDB: Write(16) 8a 00 00
> > 00 00 00 1a 92 bf 00 00 00 00 80 00 00
> > [248271.630551] blk_update_request: I/O error, dev sdd, sector
> > 445824896 op 0x1:(WRITE) flags 0x0 phys_seg 16 prio class 0
> > [248271.660964] blk_update_request: I/O error, dev sdd, sector
> > 445824768 op 0x1:(WRITE) flags 0x0 phys_seg 16 prio class 0
> > [248271.769033] sd 4:0:2:0: [sdd] tag#335 FAILED Result:
> > hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK cmd_age=0s
> > [248271.771463] sd 4:0:2:0: [sdd] tag#335 CDB: Write(16) 8a 00 00
> > 00 00 00 16 a0 39 00 00 00 00 80 00 00
> > [248271.772126] sd 4:0:2:0: [sdd] tag#338 FAILED Result:
> > hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK cmd_age=0s
> > [248271.773871] blk_update_request: I/O error, dev sdd, sector
> > 379599104 op 0x1:(WRITE) flags 0x0 phys_seg 16 prio class 0
> > [248271.775065] sd 4:0:2:0: [sdd] tag#355 FAILED Result:
> > hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK cmd_age=0s
> > [248271.775072] sd 4:0:2:0: [sdd] tag#355 CDB: Write(16) 8a 00 00
> > 00 00 00 17 a0 33 00 00 00 00 80 00 00
> > [248271.775074] blk_update_request: I/O error, dev sdd, sector
> > 396374784 op 0x1:(WRITE) flags 0x0 phys_seg 16 prio class 0
> > [248271.775090] sd 4:0:2:0: [sdd] tag#358 FAILED Result:
> > hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK cmd_age=0s
> > [248271.775093] sd 4:0:2:0: [sdd] tag#358 CDB: Write(16) 8a 00 00
> > 00 00 00 17 a0 33 80 00 00 00 80 00 00
> > [248271.775095] blk_update_request: I/O error, dev sdd, sector
> > 396374912 op 0x1:(WRITE) flags 0x0 phys_seg 16 prio class 0
> > [248271.775103] sd 4:0:2:0: [sdd] tag#361 FAILED Result:
> > hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK cmd_age=0s
> > [248271.775106] sd 4:0:2:0: [sdd] tag#361 CDB: Write(16) 8a 00 00
> > 00 00 00 17 a0 34 00 00 00 00 80 00 00
> > [248271.775108] blk_update_request: I/O error, dev sdd, sector
> > 396375040 op 0x1:(WRITE) flags 0x0 phys_seg 16 prio class 0
> > [248271.775132] blk_update_request: I/O error, dev sdd, sector
> > 426428928 op 0x1:(WRITE) flags 0x0 phys_seg 16 prio class 0
> > [248271.776264] sd 4:0:2:0: [sdd] tag#338 CDB: Write(16) 8a 00 00
> > 00 00 00 16 a0 39 80 00 00 00 80 00 00
> > [248271.829322] btrfs_dev_stat_print_on_error: 1552 callbacks
> > suppressed
> > [248271.829327] BTRFS error (device sdg): bdev /dev/sdd errs: wr
> > 74392181, rd 1756382, flush 190, corrupt 37086, gen 21
> > [248271.831689] BTRFS error (device sdg): bdev /dev/sdd errs: wr
> > 74392182, rd 1756382, flush 190, corrupt 37086, gen 21
> > [248271.832863] BTRFS error (device sdg): bdev /dev/sdd errs: wr
> > 74392183, rd 1756382, flush 190, corrupt 37086, gen 21
> > [248271.834033] BTRFS error (device sdg): bdev /dev/sdd errs: wr
> > 74392184, rd 1756382, flush 190, corrupt 37086, gen 21
> > [248271.835164] BTRFS error (device sdg): bdev /dev/sdd errs: wr
> > 74392185, rd 1756382, flush 190, corrupt 37086, gen 21
> > [248271.836004] BTRFS error (device sdg): bdev /dev/sdd errs: wr
> > 74392186, rd 1756382, flush 190, corrupt 37086, gen 21
> > [248271.836265] BTRFS error (device sdg): bdev /dev/sdd errs: wr
> > 74392187, rd 1756382, flush 190, corrupt 37086, gen 21
> > [248271.837319] BTRFS error (device sdg): bdev /dev/sdd errs: wr
> > 74392188, rd 1756382, flush 190, corrupt 37086, gen 21
> > [248271.838362] BTRFS error (device sdg): bdev /dev/sdd errs: wr
> > 74392189, rd 1756382, flush 190, corrupt 37086, gen 21
> > [248271.839402] BTRFS error (device sdg): bdev /dev/sdd errs: wr
> > 74392190, rd 1756382, flush 190, corrupt 37086, gen 21
> > [248272.029872] BTRFS warning (device sdg): lost page write due to
> > IO error on /dev/sdd (-5)
> > [248272.031357] BTRFS warning (device sdg): lost page write due to
> > IO error on /dev/sdd (-5)
> > [248272.031919] BTRFS warning (device sdg): lost page write due to
> > IO error on /dev/sdd (-5)
> > [248272.062041] BTRFS error (device sdg): error writing primary
> > super block to device 3
> > [248277.001230] scsi_io_completion_action: 173 callbacks suppressed
> > [248277.001240] sd 4:0:2:0: [sdd] tag#356 FAILED Result:
> > hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK cmd_age=0s
> > [248277.002605] sd 4:0:2:0: [sdd] tag#358 FAILED Result:
> > hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK cmd_age=0s
> > [248277.003050] sd 4:0:2:0: [sdd] tag#356 CDB: Write(16) 8a 00 00
> > 00 00 00 01 1d 79 80 00 00 00 80 00 00
> > [248277.004885] sd 4:0:2:0: [sdd] tag#358 CDB: Write(16) 8a 00 00
> > 00 00 00 01 1d 7a 00 00 00 00 80 00 00
> > [248277.006725] print_req_error: 174 callbacks suppressed
> > [248277.006727] blk_update_request: I/O error, dev sdd, sector
> > 18708864 op 0x1:(WRITE) flags 0x0 phys_seg 16 prio class 0
> > [248277.008574] blk_update_request: I/O error, dev sdd, sector
> > 18708992 op 0x1:(WRITE) flags 0x0 phys_seg 16 prio class 0
> > [248277.013396] sd 4:0:2:0: [sdd] tag#362 FAILED Result:
> > hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK cmd_age=0s
> > [248277.017475] sd 4:0:2:0: [sdd] tag#362 CDB: Write(16) 8a 00 00
> > 00 00 00 01 1d 79 00 00 00 00 80 00 00
> > [248277.019229] blk_update_request: I/O error, dev sdd, sector
> > 18708736 op 0x1:(WRITE) flags 0x0 phys_seg 16 prio class 0
> > [248277.022505] sd 4:0:2:0: [sdd] tag#365 FAILED Result:
> > hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK cmd_age=0s
> > [248277.024304] sd 4:0:2:0: [sdd] tag#365 CDB: Write(16) 8a 00 00
> > 00 00 00 01 1d 7a 80 00 00 00 80 00 00
> > [248277.026057] blk_update_request: I/O error, dev sdd, sector
> > 18709120 op 0x1:(WRITE) flags 0x0 phys_seg 16 prio class 0
> > [248277.906882] sd 4:0:2:0: [sdd] tag#325 FAILED Result:
> > hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK cmd_age=0s
> > [248277.906893] sd 4:0:2:0: [sdd] tag#327 FAILED Result:
> > hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK cmd_age=0s
> > [248277.908685] sd 4:0:2:0: [sdd] tag#325 CDB: Write(16) 8a 00 00
> > 00 00 00 00 2c 4b 80 00 00 00 80 00 00
> > [248277.910454] sd 4:0:2:0: [sdd] tag#327 CDB: Write(16) 8a 00 00
> > 00 00 00 00 34 53 80 00 00 00 80 00 00
> > [248277.910457] blk_update_request: I/O error, dev sdd, sector
> > 3429248 op 0x1:(WRITE) flags 0x0 phys_seg 16 prio class 0
> > [248277.912178] blk_update_request: I/O error, dev sdd, sector
> > 2902912 op 0x1:(WRITE) flags 0x0 phys_seg 16 prio class 0
> > [248277.917256] sd 4:0:2:0: [sdd] tag#326 FAILED Result:
> > hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK cmd_age=0s
> > [248277.918924] sd 4:0:2:0: [sdd] tag#326 CDB: Write(16) 8a 00 00
> > 00 00 00 00 36 4a 00 00 00 00 80 00 00
> > [248277.920584] blk_update_request: I/O error, dev sdd, sector
> > 3557888 op 0x1:(WRITE) flags 0x0 phys_seg 16 prio class 0
> > [248280.875522] sd 4:0:2:0: [sdd] tag#331 FAILED Result:
> > hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK cmd_age=0s
> > [248280.876631] sd 4:0:2:0: [sdd] tag#334 FAILED Result:
> > hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK cmd_age=0s
> > [248280.878928] sd 4:0:2:0: [sdd] tag#331 CDB: Write(16) 8a 00 00
> > 00 00 00 00 c2 a5 80 00 00 00 80 00 00
> > [248280.880663] sd 4:0:2:0: [sdd] tag#334 CDB: Write(16) 8a 00 00
> > 00 00 00 00 c2 a6 00 00 00 00 10 00 00
> > [248280.880666] blk_update_request: I/O error, dev sdd, sector
> > 12756480 op 0x1:(WRITE) flags 0x0 phys_seg 2 prio class 0
> > [248280.882378] blk_update_request: I/O error, dev sdd, sector
> > 12756352 op 0x1:(WRITE) flags 0x0 phys_seg 16 prio class 0
> > [248285.091160] sd 4:0:2:0: [sdd] tag#338 FAILED Result:
> > hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK cmd_age=0s
> > [248285.093669] sd 4:0:2:0: [sdd] tag#338 CDB: Write(16) 8a 00 00
> > 00 00 00 00 2f 6e 00 00 00 00 80 00 00
> > [248285.094997] blk_update_request: I/O error, dev sdd, sector
> > 3108352 op 0x1:(WRITE) flags 0x0 phys_seg 16 prio class 0
> > [248286.154539] sd 4:0:2:0: [sdd] tag#340 FAILED Result:
> > hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK cmd_age=0s
> > [248286.156053] sd 4:0:2:0: [sdd] tag#363 FAILED Result:
> > hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK cmd_age=0s
> > [248286.156475] sd 4:0:2:0: [sdd] tag#340 CDB: Write(16) 8a 00 00
> > 00 00 00 1b 2c d4 80 00 00 00 80 00 00
> > [248286.157669] sd 4:0:2:0: [sdd] tag#366 FAILED Result:
> > hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK cmd_age=0s
> > [248286.157675] sd 4:0:2:0: [sdd] tag#366 CDB: Write(16) 8a 00 00
> > 00 00 00 1b 2c d7 80 00 00 00 80 00 00
> > [248286.157677] blk_update_request: I/O error, dev sdd, sector
> > 455923584 op 0x1:(WRITE) flags 0x0 phys_seg 16 prio class 0
> > [248286.157794] sd 4:0:2:0: [sdd] tag#369 FAILED Result:
> > hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK cmd_age=0s
> > [248286.157798] sd 4:0:2:0: [sdd] tag#369 CDB: Write(16) 8a 00 00
> > 00 00 00 1b 2c d8 00 00 00 00 80 00 00
> > [248286.157800] blk_update_request: I/O error, dev sdd, sector
> > 455923712 op 0x1:(WRITE) flags 0x0 phys_seg 16 prio class 0
> > [248286.157908] sd 4:0:2:0: [sdd] tag#372 FAILED Result:
> > hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK cmd_age=0s
> > [248286.157912] sd 4:0:2:0: [sdd] tag#372 CDB: Write(16) 8a 00 00
> > 00 00 00 1b 2c d8 80 00 00 00 80 00 00
> > [248286.157913] blk_update_request: I/O error, dev sdd, sector
> > 455923840 op 0x1:(WRITE) flags 0x0 phys_seg 16 prio class 0
> > [248286.158098] sd 4:0:2:0: [sdd] tag#382 FAILED Result:
> > hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK cmd_age=0s
> > [248286.158101] sd 4:0:2:0: [sdd] tag#382 CDB: Write(16) 8a 00 00
> > 00 00 00 1b 2c d9 00 00 00 00 80 00 00
> > [248286.158103] blk_update_request: I/O error, dev sdd, sector
> > 455923968 op 0x1:(WRITE) flags 0x0 phys_seg 16 prio class 0
> > [248286.158255] sd 4:0:2:0: [sdd] tag#321 FAILED Result:
> > hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK cmd_age=0s
> > [248286.158259] sd 4:0:2:0: [sdd] tag#321 CDB: Write(16) 8a 00 00
> > 00 00 00 1b 2c d9 80 00 00 00 80 00 00
> > [248286.158260] blk_update_request: I/O error, dev sdd, sector
> > 455924096 op 0x1:(WRITE) flags 0x0 phys_seg 16 prio class 0
> > [248286.158390] sd 4:0:2:0: [sdd] tag#363 CDB: Write(16) 8a 00 00
> > 00 00 00 1b 2c d7 00 00 00 00 80 00 00
> > [248286.158414] sd 4:0:2:0: [sdd] tag#324 FAILED Result:
> > hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK cmd_age=0s
> > [248286.158418] sd 4:0:2:0: [sdd] tag#324 CDB: Write(16) 8a 00 00
> > 00 00 00 1b 2c da 00 00 00 00 80 00 00
> > [248286.158419] blk_update_request: I/O error, dev sdd, sector
> > 455924224 op 0x1:(WRITE) flags 0x0 phys_seg 16 prio class 0
> > [248286.160329] blk_update_request: I/O error, dev sdd, sector
> > 455922816 op 0x1:(WRITE) flags 0x0 phys_seg 16 prio class 0
> > [248286.160367] sd 4:0:2:0: [sdd] tag#347 FAILED Result:
> > hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK cmd_age=0s
> > [248286.162312] blk_update_request: I/O error, dev sdd, sector
> > 455923456 op 0x1:(WRITE) flags 0x0 phys_seg 16 prio class 0
> > [248286.172179] blk_update_request: I/O error, dev sdd, sector
> > 455924352 op 0x1:(WRITE) flags 0x0 phys_seg 16 prio class 0
> > [248286.172696] sd 4:0:2:0: [sdd] tag#347 CDB: Write(16) 8a 00 00
> > 00 00 00 1b 2c d5 00 00 00 00 80 00 00
> > [248290.623307] program smartctl is using a deprecated SCSI ioctl,
> > please convert it to SG_IO
> > [248290.624705] program smartctl is using a deprecated SCSI ioctl,
> > please convert it to SG_IO
> > [248290.626020] program smartctl is using a deprecated SCSI ioctl,
> > please convert it to SG_IO
> > [248291.988874] scsi_io_completion_action: 4 callbacks suppressed
> > [248291.988884] sd 4:0:2:0: [sdd] tag#336 FAILED Result:
> > hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK cmd_age=0s
> > [248291.993237] sd 4:0:2:0: [sdd] tag#336 CDB: Read(16) 88 00 00 00
> > 00 00 00 2f 81 00 00 00 00 80 00 00
> > [248291.995414] print_req_error: 4 callbacks suppressed
> > [248291.995417] blk_update_request: I/O error, dev sdd, sector
> > 3113216 op 0x0:(READ) flags 0x0 phys_seg 16 prio class 0
> > [248296.181222] program smartctl is using a deprecated SCSI ioctl,
> > please convert it to SG_IO
> > [248296.182569] program smartctl is using a deprecated SCSI ioctl,
> > please convert it to SG_IO
> > [248296.183866] program smartctl is using a deprecated SCSI ioctl,
> > please convert it to SG_IO
> > [248297.423222] sd 4:0:2:0: [sdd] tag#349 FAILED Result:
> > hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK cmd_age=0s
> > [248297.424233] sd 4:0:2:0: [sdd] tag#354 FAILED Result:
> > hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK cmd_age=0s
> > [248297.426301] sd 4:0:2:0: [sdd] tag#362 FAILED Result:
> > hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK cmd_age=0s
> > [248297.426309] sd 4:0:2:0: [sdd] tag#362 CDB: Write(16) 8a 00 00
> > 00 00 00 1a a0 f1 00 00 00 00 80 00 00
> > [248297.426311] blk_update_request: I/O error, dev sdd, sector
> > 446755072 op 0x1:(WRITE) flags 0x0 phys_seg 16 prio class 0
> > [248297.426421] sd 4:0:2:0: [sdd] tag#366 FAILED Result:
> > hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK cmd_age=0s
> > [248297.426424] sd 4:0:2:0: [sdd] tag#366 CDB: Write(16) 8a 00 00
> > 00 00 00 1a a0 f1 80 00 00 00 80 00 00
> > [248297.426426] blk_update_request: I/O error, dev sdd, sector
> > 446755200 op 0x1:(WRITE) flags 0x0 phys_seg 16 prio class 0
> > [248297.426559] sd 4:0:2:0: [sdd] tag#369 FAILED Result:
> > hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK cmd_age=0s
> > [248297.426562] sd 4:0:2:0: [sdd] tag#369 CDB: Write(16) 8a 00 00
> > 00 00 00 1a a0 f2 00 00 00 00 80 00 00
> > [248297.426564] blk_update_request: I/O error, dev sdd, sector
> > 446755328 op 0x1:(WRITE) flags 0x0 phys_seg 16 prio class 0
> > [248297.426667] sd 4:0:2:0: [sdd] tag#378 FAILED Result:
> > hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK cmd_age=0s
> > [248297.426670] sd 4:0:2:0: [sdd] tag#378 CDB: Write(16) 8a 00 00
> > 00 00 00 1a a0 f2 80 00 00 00 80 00 00
> > [248297.426672] blk_update_request: I/O error, dev sdd, sector
> > 446755456 op 0x1:(WRITE) flags 0x0 phys_seg 16 prio class 0
> > [248297.426834] sd 4:0:2:0: [sdd] tag#324 FAILED Result:
> > hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK cmd_age=0s
> > [248297.426837] sd 4:0:2:0: [sdd] tag#324 CDB: Write(16) 8a 00 00
> > 00 00 00 1a a0 f3 00 00 00 00 80 00 00
> > [248297.426839] blk_update_request: I/O error, dev sdd, sector
> > 446755584 op 0x1:(WRITE) flags 0x0 phys_seg 16 prio class 0
> > [248297.426942] sd 4:0:2:0: [sdd] tag#327 FAILED Result:
> > hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK cmd_age=0s
> > [248297.426945] sd 4:0:2:0: [sdd] tag#327 CDB: Write(16) 8a 00 00
> > 00 00 00 1a a0 f3 80 00 00 00 80 00 00
> > [248297.426947] blk_update_request: I/O error, dev sdd, sector
> > 446755712 op 0x1:(WRITE) flags 0x0 phys_seg 16 prio class 0
> > [248297.427050] sd 4:0:2:0: [sdd] tag#330 FAILED Result:
> > hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK cmd_age=0s
> > [248297.427054] sd 4:0:2:0: [sdd] tag#330 CDB: Write(16) 8a 00 00
> > 00 00 00 1a a0 f4 00 00 00 00 80 00 00
> > [248297.427055] blk_update_request: I/O error, dev sdd, sector
> > 446755840 op 0x1:(WRITE) flags 0x0 phys_seg 16 prio class 0
> > [248297.427179] sd 4:0:2:0: [sdd] tag#333 FAILED Result:
> > hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK cmd_age=0s
> > [248297.427182] sd 4:0:2:0: [sdd] tag#333 CDB: Write(16) 8a 00 00
> > 00 00 00 1a a0 f4 80 00 00 00 80 00 00
> > [248297.427184] blk_update_request: I/O error, dev sdd, sector
> > 446755968 op 0x1:(WRITE) flags 0x0 phys_seg 16 prio class 0
> > [248297.427383] blk_update_request: I/O error, dev sdd, sector
> > 446756096 op 0x1:(WRITE) flags 0x0 phys_seg 16 prio class 0
> > [248297.427419] sd 4:0:2:0: [sdd] tag#349 CDB: Write(16) 8a 00 00
> > 00 00 00 1a a0 f0 00 00 00 00 80 00 00
> > [248297.429588] sd 4:0:2:0: [sdd] tag#354 CDB: Write(16) 8a 00 00
> > 00 00 00 1a a0 f0 80 00 00 00 80 00 00
> > [248297.431651] blk_update_request: I/O error, dev sdd, sector
> > 446754816 op 0x1:(WRITE) flags 0x0 phys_seg 16 prio class 0
> > [248299.357237] program smartctl is using a deprecated SCSI ioctl,
> > please convert it to SG_IO
> > [248299.358591] program smartctl is using a deprecated SCSI ioctl,
> > please convert it to SG_IO
> > [248299.359863] program smartctl is using a deprecated SCSI ioctl,
> > please convert it to SG_IO
> > [248301.784416] btrfs_dev_stat_print_on_error: 85 callbacks
> > suppressed
> > [248301.784422] BTRFS error (device sdg): bdev /dev/sdd errs: wr
> > 74392275, rd 1756382, flush 191, corrupt 37086, gen 21
> > [248301.787139] BTRFS error (device sdg): bdev /dev/sdd errs: wr
> > 74392276, rd 1756382, flush 191, corrupt 37086, gen 21
> > [248301.793382] BTRFS error (device sdg): bdev /dev/sdd errs: wr
> > 74392277, rd 1756382, flush 191, corrupt 37086, gen 21
> > [248301.842622] BTRFS error (device sdg): bdev /dev/sdd errs: wr
> > 74392278, rd 1756382, flush 191, corrupt 37086, gen 21
> > [248301.857224] BTRFS error (device sdg): bdev /dev/sdd errs: wr
> > 74392279, rd 1756382, flush 191, corrupt 37086, gen 21
> > [248301.902699] BTRFS error (device sdg): bdev /dev/sdd errs: wr
> > 74392279, rd 1756383, flush 191, corrupt 37086, gen 21
> > [248301.923990] BTRFS error (device sdg): bdev /dev/sdd errs: wr
> > 74392279, rd 1756384, flush 191, corrupt 37086, gen 21
> > [248301.924022] BTRFS error (device sdg): bdev /dev/sdd errs: wr
> > 74392280, rd 1756384, flush 191, corrupt 37086, gen 21
> > [248301.980030] BTRFS error (device sdg): bdev /dev/sdd errs: wr
> > 74392280, rd 1756385, flush 191, corrupt 37086, gen 21
> > [248301.981996] BTRFS error (device sdg): bdev /dev/sdd errs: wr
> > 74392280, rd 1756386, flush 191, corrupt 37086, gen 21
> > [248302.482352] scsi_io_completion_action: 71 callbacks suppressed
> > [248302.482362] sd 4:0:2:0: [sdd] tag#324 FAILED Result:
> > hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK cmd_age=0s
> > [248302.486139] sd 4:0:2:0: [sdd] tag#324 CDB: Read(16) 88 00 00 00
> > 00 02 ec 9c 6d a0 00 00 00 20 00 00
> > [248302.488014] print_req_error: 71 callbacks suppressed
> > [248302.488017] blk_update_request: I/O error, dev sdd, sector
> > 12559609248 op 0x0:(READ) flags 0x1000 phys_seg 4 prio class 0
> > [248302.549043] sd 4:0:2:0: [sdd] tag#326 FAILED Result:
> > hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK cmd_age=0s
> > [248302.550971] sd 4:0:2:0: [sdd] tag#326 CDB: Read(16) 88 00 00 00
> > 00 00 00 2f 87 00 00 00 00 48 00 00
> > [248302.552860] blk_update_request: I/O error, dev sdd, sector
> > 3114752 op 0x0:(READ) flags 0x0 phys_seg 9 prio class 0
> > [248302.554768] sd 4:0:2:0: [sdd] tag#327 FAILED Result:
> > hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK cmd_age=0s
> > [248302.556682] sd 4:0:2:0: [sdd] tag#327 CDB: Read(16) 88 00 00 00
> > 00 00 00 2f 87 60 00 00 00 20 00 00
> > [248302.558558] blk_update_request: I/O error, dev sdd, sector
> > 3114848 op 0x0:(READ) flags 0x0 phys_seg 4 prio class 0
> > [248302.580488] sd 4:0:2:0: [sdd] tag#330 FAILED Result:
> > hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK cmd_age=0s
> > [248302.582404] sd 4:0:2:0: [sdd] tag#330 CDB: Write(16) 8a 00 00
> > 00 00 02 ec 9c 6d a0 00 00 00 08 00 00
> > [248302.584286] blk_update_request: I/O error, dev sdd, sector
> > 12559609248 op 0x1:(WRITE) flags 0x800 phys_seg 1 prio class 0
> > [248302.586227] sd 4:0:2:0: [sdd] tag#331 FAILED Result:
> > hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK cmd_age=0s
> > [248302.586284] sd 4:0:2:0: [sdd] tag#332 FAILED Result:
> > hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK cmd_age=0s
> > [248302.588144] sd 4:0:2:0: [sdd] tag#331 CDB: Write(16) 8a 00 00
> > 00 00 00 00 34 5a b0 00 00 00 18 00 00
> > [248302.590030] sd 4:0:2:0: [sdd] tag#332 CDB: Read(16) 88 00 00 00
> > 00 02 ec 9c 6e 20 00 00 00 20 00 00
> > [248302.591863] blk_update_request: I/O error, dev sdd, sector
> > 3431088 op 0x1:(WRITE) flags 0x0 phys_seg 3 prio class 0
> > [248302.593698] blk_update_request: I/O error, dev sdd, sector
> > 12559609376 op 0x0:(READ) flags 0x1000 phys_seg 4 prio class 0
> > [248302.604651] sd 4:0:2:0: [sdd] tag#336 FAILED Result:
> > hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK cmd_age=0s
> > [248302.606535] sd 4:0:2:0: [sdd] tag#336 CDB: Read(16) 88 00 00 00
> > 00 00 00 2f bb 00 00 00 00 80 00 00
> > [248302.608370] blk_update_request: I/O error, dev sdd, sector
> > 3128064 op 0x0:(READ) flags 0x0 phys_seg 16 prio class 0
> > [248302.613761] sd 4:0:2:0: [sdd] tag#345 FAILED Result:
> > hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK cmd_age=0s
> > [248302.614282] sd 4:0:2:0: [sdd] tag#346 FAILED Result:
> > hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK cmd_age=0s
> > [248302.615659] sd 4:0:2:0: [sdd] tag#345 CDB: Write(16) 8a 00 00
> > 00 00 00 00 2f 87 48 00 00 00 18 00 00
> > [248302.617550] sd 4:0:2:0: [sdd] tag#346 CDB: Write(16) 8a 00 00
> > 00 00 02 ec 9c 6e 20 00 00 00 08 00 00
> > [248302.617552] blk_update_request: I/O error, dev sdd, sector
> > 12559609376 op 0x1:(WRITE) flags 0x800 phys_seg 1 prio class 0
> > [248302.619395] blk_update_request: I/O error, dev sdd, sector
> > 3114824 op 0x1:(WRITE) flags 0x0 phys_seg 3 prio class 0
> > [248302.625183] sd 4:0:2:0: [sdd] tag#347 FAILED Result:
> > hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK cmd_age=0s
> > [248302.627048] sd 4:0:2:0: [sdd] tag#347 CDB: Read(16) 88 00 00 00
> > 00 02 ec 93 24 c0 00 00 00 20 00 00
> > [248302.628894] blk_update_request: I/O error, dev sdd, sector
> > 12559000768 op 0x0:(READ) flags 0x1000 phys_seg 4 prio class 0
> > [248303.042756] BTRFS warning (device sdg): lost page write due to
> > IO error on /dev/sdd (-5)
> > [248303.043453] BTRFS warning (device sdg): lost page write due to
> > IO error on /dev/sdd (-5)
> > [248303.044802] BTRFS warning (device sdg): lost page write due to
> > IO error on /dev/sdd (-5)
> > [248303.078613] BTRFS error (device sdg): error writing primary
> > super block to device 3
> > [248305.317351] program smartctl is using a deprecated SCSI ioctl,
> > please convert it to SG_IO
> > [248305.318565] program smartctl is using a deprecated SCSI ioctl,
> > please convert it to SG_IO
> > [248305.319737] program smartctl is using a deprecated SCSI ioctl,
> > please convert it to SG_IO
> > [248308.909087] scsi_io_completion_action: 401 callbacks suppressed
> > [248308.909097] sd 4:0:2:0: [sdd] tag#360 FAILED Result:
> > hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK cmd_age=0s
> > [248308.913267] sd 4:0:2:0: [sdd] tag#360 CDB: Write(16) 8a 00 00
> > 00 00 00 00 2a d3 80 00 00 00 80 00 00
> > [248308.915329] print_req_error: 402 callbacks suppressed
> > [248308.915332] blk_update_request: I/O error, dev sdd, sector
> > 2806656 op 0x1:(WRITE) flags 0x0 phys_seg 16 prio class 0
> > [248309.890321] sd 4:0:2:0: [sdd] tag#363 FAILED Result:
> > hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK cmd_age=0s
> > [248309.892430] sd 4:0:2:0: [sdd] tag#363 CDB: Write(16) 8a 00 00
> > 00 00 00 00 2a dd 80 00 00 00 80 00 00
> > [248309.894493] blk_update_request: I/O error, dev sdd, sector
> > 2809216 op 0x1:(WRITE) flags 0x0 phys_seg 16 prio class 0
> > [248309.930751] sd 4:0:2:0: [sdd] tag#366 FAILED Result:
> > hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK cmd_age=0s
> > [248309.932849] sd 4:0:2:0: [sdd] tag#366 CDB: Write(16) 8a 00 00
> > 00 00 00 00 2a dd 80 00 00 00 80 00 00
> > [248309.934920] blk_update_request: I/O error, dev sdd, sector
> > 2809216 op 0x1:(WRITE) flags 0x0 phys_seg 16 prio class 0
> > [248312.755530] sd 4:0:2:0: [sdd] tag#376 FAILED Result:
> > hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK cmd_age=0s
> > [248312.756811] sd 4:0:2:0: [sdd] tag#377 FAILED Result:
> > hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK cmd_age=0s
> > [248312.759632] sd 4:0:2:0: [sdd] tag#376 CDB: Read(16) 88 00 00 00
> > 00 00 00 2a df 00 00 00 00 18 00 00
> > [248312.761711] sd 4:0:2:0: [sdd] tag#377 CDB: Read(16) 88 00 00 00
> > 00 00 00 2a df 20 00 00 00 60 00 00
> > [248312.761714] blk_update_request: I/O error, dev sdd, sector
> > 2809632 op 0x0:(READ) flags 0x0 phys_seg 12 prio class 0
> > [248312.763824] blk_update_request: I/O error, dev sdd, sector
> > 2809600 op 0x0:(READ) flags 0x0 phys_seg 3 prio class 0
> > [248312.786251] sd 4:0:2:0: [sdd] tag#320 FAILED Result:
> > hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK cmd_age=0s
> > [248312.788341] sd 4:0:2:0: [sdd] tag#320 CDB: Write(16) 8a 00 00
> > 00 00 00 00 2a df 80 00 00 00 80 00 00
> > [248312.790341] sd 4:0:2:0: [sdd] tag#323 FAILED Result:
> > hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK cmd_age=0s
> > [248312.790392] blk_update_request: I/O error, dev sdd, sector
> > 2809728 op 0x1:(WRITE) flags 0x0 phys_seg 16 prio class 0
> > [248312.792452] sd 4:0:2:0: [sdd] tag#323 CDB: Write(16) 8a 00 00
> > 00 00 00 00 2a df 18 00 00 00 08 00 00
> > [248312.796556] blk_update_request: I/O error, dev sdd, sector
> > 2809624 op 0x1:(WRITE) flags 0x0 phys_seg 1 prio class 0
> > [248316.486643] sd 4:0:2:0: [sdd] tag#326 FAILED Result:
> > hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK cmd_age=0s
> > [248316.490876] sd 4:0:2:0: [sdd] tag#326 CDB: Write(16) 8a 00 00
> > 00 00 00 00 2a df 20 00 00 00 08 00 00
> > [248316.493033] blk_update_request: I/O error, dev sdd, sector
> > 2809632 op 0x1:(WRITE) flags 0x0 phys_seg 1 prio class 0
> > [248316.543702] sd 4:0:2:0: [sdd] tag#333 FAILED Result:
> > hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK cmd_age=0s
> > [248316.545897] sd 4:0:2:0: [sdd] tag#333 CDB: Write(16) 8a 00 00
> > 00 00 00 00 2a ea 00 00 00 00 80 00 00
> > [248316.548046] blk_update_request: I/O error, dev sdd, sector
> > 2812416 op 0x1:(WRITE) flags 0x0 phys_seg 16 prio class 0
> > [248316.874434] sd 4:0:2:0: [sdd] tag#335 FAILED Result:
> > hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK cmd_age=0s
> > [248316.874450] sd 4:0:2:0: [sdd] tag#338 FAILED Result:
> > hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK cmd_age=0s
> > [248316.874570] sd 4:0:2:0: [sdd] tag#344 FAILED Result:
> > hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK cmd_age=0s
> > [248316.874577] sd 4:0:2:0: [sdd] tag#344 CDB: Write(16) 8a 00 00
> > 00 00 01 fa 9f 37 00 00 00 00 80 00 00
> > [248316.874580] blk_update_request: I/O error, dev sdd, sector
> > 8499705600 op 0x1:(WRITE) flags 0x0 phys_seg 16 prio class 0
> > [248316.874638] sd 4:0:2:0: [sdd] tag#349 FAILED Result:
> > hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK cmd_age=0s
> > [248316.874644] sd 4:0:2:0: [sdd] tag#349 CDB: Write(16) 8a 00 00
> > 00 00 01 fa 9f 33 00 00 00 00 80 00 00
> > [248316.874660] blk_update_request: I/O error, dev sdd, sector
> > 8499704576 op 0x1:(WRITE) flags 0x0 phys_seg 16 prio class 0
> > [248316.876724] sd 4:0:2:0: [sdd] tag#335 CDB: Write(16) 8a 00 00
> > 00 00 01 fa 9f 34 88 00 00 00 10 00 00
> > [248316.878945] sd 4:0:2:0: [sdd] tag#338 CDB: Write(16) 8a 00 00
> > 00 00 01 fa 9f 33 80 00 00 00 80 00 00
> > [248316.881121] blk_update_request: I/O error, dev sdd, sector
> > 8499704968 op 0x1:(WRITE) flags 0x0 phys_seg 2 prio class 0
> > [248316.881146] sd 4:0:2:0: [sdd] tag#337 FAILED Result:
> > hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK cmd_age=0s
> > [248316.883317] blk_update_request: I/O error, dev sdd, sector
> > 8499704704 op 0x1:(WRITE) flags 0x0 phys_seg 16 prio class 0
> > [248316.885534] sd 4:0:2:0: [sdd] tag#337 CDB: Write(16) 8a 00 00
> > 00 00 01 fa 9f 32 78 00 00 00 08 00 00
> > [248316.887926] sd 4:0:2:0: [sdd] tag#357 FAILED Result:
> > hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK cmd_age=0s
> > [248316.889974] blk_update_request: I/O error, dev sdd, sector
> > 8499704440 op 0x1:(WRITE) flags 0x0 phys_seg 1 prio class 0
> > [248316.910572] sd 4:0:2:0: [sdd] tag#357 CDB: Write(16) 8a 00 00
> > 00 00 01 fa 9f 33 80 00 00 00 80 00 00
> > [248316.912873] blk_update_request: I/O error, dev sdd, sector
> > 8499704704 op 0x1:(WRITE) flags 0x0 phys_seg 16 prio class 0
> > [248318.558510] sd 4:0:2:0: [sdd] tag#371 FAILED Result:
> > hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK cmd_age=0s
> > [248318.560471] sd 4:0:2:0: [sdd] tag#371 CDB: Write(16) 8a 00 00
> > 00 00 00 00 2e 5e f8 00 00 00 30 00 00
> > [248318.561469] blk_update_request: I/O error, dev sdd, sector
> > 3038968 op 0x1:(WRITE) flags 0x0 phys_seg 6 prio class 0
> > [248318.568857] sd 4:0:2:0: [sdd] tag#376 FAILED Result:
> > hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK cmd_age=0s
> > [248318.569967] sd 4:0:2:0: [sdd] tag#376 CDB: Write(16) 8a 00 00
> > 00 00 00 00 2e 5f 28 00 00 00 30 00 00
> > [248318.571091] blk_update_request: I/O error, dev sdd, sector
> > 3039016 op 0x1:(WRITE) flags 0x0 phys_seg 6 prio class 0
> > [248322.218635] scsi_io_completion_action: 7 callbacks suppressed
> > [248322.218645] sd 4:0:2:0: [sdd] tag#342 FAILED Result:
> > hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK cmd_age=0s
> > [248322.221295] sd 4:0:2:0: [sdd] tag#342 CDB: Read(16) 88 00 00 00
> > 00 00 00 2b 61 50 00 00 00 10 00 00
> > [248322.222668] print_req_error: 7 callbacks suppressed
> > [248322.222670] blk_update_request: I/O error, dev sdd, sector
> > 2842960 op 0x0:(READ) flags 0x80700 phys_seg 2 prio class 0
> > [248322.225664] sd 4:0:2:0: [sdd] tag#343 FAILED Result:
> > hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK cmd_age=0s
> > [248322.226557] sd 4:0:2:0: [sdd] tag#344 FAILED Result:
> > hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK cmd_age=0s
> > [248322.227223] sd 4:0:2:0: [sdd] tag#343 CDB: Read(16) 88 00 00 00
> > 00 00 00 2b 61 50 00 00 00 08 00 00
> > [248322.228752] sd 4:0:2:0: [sdd] tag#344 CDB: Read(16) 88 00 00 00
> > 00 00 00 2b 61 58 00 00 00 08 00 00
> > [248322.230312] blk_update_request: I/O error, dev sdd, sector
> > 2842960 op 0x0:(READ) flags 0x100 phys_seg 1 prio class 0
> > [248322.231869] blk_update_request: I/O error, dev sdd, sector
> > 2842968 op 0x0:(READ) flags 0x100 phys_seg 1 prio class 0
> > [248322.233490] btrfs_dev_stat_print_on_error: 379 callbacks
> > suppressed
> > [248322.233493] BTRFS error (device sdg): bdev /dev/sdd errs: wr
> > 74392547, rd 1756498, flush 192, corrupt 37086, gen 21
> > [248322.235105] BTRFS error (device sdg): bdev /dev/sdd errs: wr
> > 74392547, rd 1756499, flush 192, corrupt 37086, gen 21
> > [248322.248514] sd 4:0:2:0: [sdd] tag#348 FAILED Result:
> > hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK cmd_age=0s
> > [248322.249822] sd 4:0:2:0: [sdd] tag#348 CDB: Write(16) 8a 00 00
> > 00 00 00 00 2b 61 50 00 00 00 10 00 00
> > [248322.251153] blk_update_request: I/O error, dev sdd, sector
> > 2842960 op 0x1:(WRITE) flags 0x800 phys_seg 2 prio class 0
> > [248322.252541] BTRFS error (device sdg): bdev /dev/sdd errs: wr
> > 74392548, rd 1756499, flush 192, corrupt 37086, gen 21
> > [248322.252544] BTRFS error (device sdg): bdev /dev/sdd errs: wr
> > 74392549, rd 1756499, flush 192, corrupt 37086, gen 21
> > [248322.811245] sd 4:0:2:0: [sdd] tag#349 FAILED Result:
> > hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK cmd_age=0s
> > [248322.813276] sd 4:0:2:0: [sdd] tag#349 CDB: Read(16) 88 00 00 00
> > 00 00 00 e4 58 90 00 00 00 70 00 00
> > [248322.815284] blk_update_request: I/O error, dev sdd, sector
> > 14964880 op 0x0:(READ) flags 0x0 phys_seg 14 prio class 0
> > [248322.817812] sd 4:0:2:0: [sdd] tag#371 FAILED Result:
> > hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK cmd_age=0s
> > [248322.819941] sd 4:0:2:0: [sdd] tag#371 CDB: Write(16) 8a 00 00
> > 00 00 00 1a 92 05 80 00 00 00 80 00 00
> > [248322.822087] blk_update_request: I/O error, dev sdd, sector
> > 445777280 op 0x1:(WRITE) flags 0x0 phys_seg 16 prio class 0
> > [248322.824255] sd 4:0:2:0: [sdd] tag#378 FAILED Result:
> > hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK cmd_age=0s
> > [248322.826384] sd 4:0:2:0: [sdd] tag#378 CDB: Write(16) 8a 00 00
> > 00 00 00 1a 92 06 00 00 00 01 80 00 00
> > [248322.828506] blk_update_request: I/O error, dev sdd, sector
> > 445777408 op 0x1:(WRITE) flags 0x0 phys_seg 37 prio class 0
> > [248322.830692] sd 4:0:2:0: [sdd] tag#379 FAILED Result:
> > hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK cmd_age=0s
> > [248322.832881] sd 4:0:2:0: [sdd] tag#379 CDB: Write(16) 8a 00 00
> > 00 00 00 1a 92 05 00 00 00 00 80 00 00
> > [248322.835079] blk_update_request: I/O error, dev sdd, sector
> > 445777152 op 0x1:(WRITE) flags 0x0 phys_seg 16 prio class 0
> > [248322.837353] sd 4:0:2:0: [sdd] tag#321 FAILED Result:
> > hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK cmd_age=0s
> > [248322.837510] sd 4:0:2:0: [sdd] tag#322 FAILED Result:
> > hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK cmd_age=0s
> > [248322.839600] sd 4:0:2:0: [sdd] tag#321 CDB: Write(16) 8a 00 00
> > 00 00 00 b0 0c 83 80 00 00 02 88 00 00
> > [248322.839602] blk_update_request: I/O error, dev sdd, sector
> > 2953610112 op 0x1:(WRITE) flags 0x0 phys_seg 81 prio class 0
> > [248322.841797] sd 4:0:2:0: [sdd] tag#322 CDB: Write(16) 8a 00 00
> > 00 00 00 00 e4 58 80 00 00 00 10 00 00
> > [248322.848390] blk_update_request: I/O error, dev sdd, sector
> > 14964864 op 0x1:(WRITE) flags 0x0 phys_seg 2 prio class 0
> > [248327.416729] sd 4:0:2:0: [sdd] tag#324 FAILED Result:
> > hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK cmd_age=0s
> > [248327.421220] sd 4:0:2:0: [sdd] tag#324 CDB: Read(16) 88 00 00 00
> > 00 00 00 2a fd 00 00 00 00 80 00 00
> > [248327.423519] blk_update_request: I/O error, dev sdd, sector
> > 2817280 op 0x0:(READ) flags 0x0 phys_seg 16 prio class 0
> > [248327.470800] sd 4:0:2:0: [sdd] tag#335 FAILED Result:
> > hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK cmd_age=0s
> > [248327.473099] sd 4:0:2:0: [sdd] tag#335 CDB: Write(16) 8a 00 00
> > 00 00 00 00 2a fd 80 00 00 00 80 00 00
> > [248327.475402] blk_update_request: I/O error, dev sdd, sector
> > 2817408 op 0x1:(WRITE) flags 0x0 phys_seg 16 prio class 0
> > [248328.659428] sd 4:0:2:0: [sdd] tag#336 FAILED Result:
> > hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK cmd_age=0s
> > [248328.661781] sd 4:0:2:0: [sdd] tag#336 CDB: Read(16) 88 00 00 00
> > 00 00 00 30 33 00 00 00 00 80 00 00
> > [248328.664121] blk_update_request: I/O error, dev sdd, sector
> > 3158784 op 0x0:(READ) flags 0x0 phys_seg 16 prio class 0
> > [248328.795900] sd 4:0:2:0: [sdd] tag#344 FAILED Result:
> > hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK cmd_age=0s
> > [248328.796631] sd 4:0:2:0: [sdd] tag#371 FAILED Result:
> > hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK cmd_age=0s
> > [248328.796908] sd 4:0:2:0: [sdd] tag#378 FAILED Result:
> > hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK cmd_age=0s
> > [248328.796912] sd 4:0:2:0: [sdd] tag#378 CDB: Read(16) 88 00 00 00
> > 00 00 00 fa 48 00 00 00 00 80 00 00
> > [248328.796913] blk_update_request: I/O error, dev sdd, sector
> > 16402432 op 0x0:(READ) flags 0x0 phys_seg 16 prio class 0
> > [248328.796937] sd 4:0:2:0: [sdd] tag#380 FAILED Result:
> > hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK cmd_age=0s
> > [248328.796940] sd 4:0:2:0: [sdd] tag#380 CDB: Read(16) 88 00 00 00
> > 00 00 00 b4 48 00 00 00 00 80 00 00
> > [248328.796941] blk_update_request: I/O error, dev sdd, sector
> > 11814912 op 0x0:(READ) flags 0x0 phys_seg 16 prio class 0
> > [248328.796978] sd 4:0:2:0: [sdd] tag#382 FAILED Result:
> > hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK cmd_age=0s
> > [248328.796980] sd 4:0:2:0: [sdd] tag#382 CDB: Read(16) 88 00 00 00
> > 00 00 19 68 48 00 00 00 00 80 00 00
> > [248328.796981] blk_update_request: I/O error, dev sdd, sector
> > 426264576 op 0x0:(READ) flags 0x0 phys_seg 16 prio class 0
> > [248328.797010] sd 4:0:2:0: [sdd] tag#383 FAILED Result:
> > hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK cmd_age=0s
> > [248328.797012] sd 4:0:2:0: [sdd] tag#383 CDB: Read(16) 88 00 00 00
> > 00 00 00 a8 14 80 00 00 00 80 00 00
> > [248328.797012] blk_update_request: I/O error, dev sdd, sector
> > 11015296 op 0x0:(READ) flags 0x0 phys_seg 16 prio class 0
> > [248328.797244] sd 4:0:2:0: [sdd] tag#344 CDB: Read(16) 88 00 00 00
> > 00 00 1a c5 c2 68 00 00 00 18 00 00
> > [248328.798432] sd 4:0:2:0: [sdd] tag#371 CDB: Read(16) 88 00 00 00
> > 00 00 1b ec 62 00 00 00 00 80 00 00
> > [248328.799583] blk_update_request: I/O error, dev sdd, sector
> > 449167976 op 0x0:(READ) flags 0x0 phys_seg 3 prio class 0
> > [248328.800763] blk_update_request: I/O error, dev sdd, sector
> > 468476416 op 0x0:(READ) flags 0x0 phys_seg 14 prio class 0
> > [248328.835435] sd 4:0:2:0: [sdd] tag#322 FAILED Result:
> > hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK cmd_age=0s
> > [248328.837098] sd 4:0:2:0: [sdd] tag#322 CDB: Write(16) 8a 00 00
> > 00 00 00 1a c6 49 80 00 00 00 80 00 00
> > [248328.838700] blk_update_request: I/O error, dev sdd, sector
> > 449202560 op 0x1:(WRITE) flags 0x0 phys_seg 16 prio class 0
> > [248328.848446] nfsd: last server has exited, flushing export cache
> > [248333.202511] scsi_io_completion_action: 22 callbacks suppressed
> > [248333.202522] sd 4:0:2:0: [sdd] tag#334 FAILED Result:
> > hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK cmd_age=0s
> > [248333.207259] sd 4:0:2:0: [sdd] tag#334 CDB: Read(16) 88 00 00 00
> > 00 02 ec 91 5b 40 00 00 00 20 00 00
> > [248333.209604] print_req_error: 22 callbacks suppressed
> > [248333.209606] blk_update_request: I/O error, dev sdd, sector
> > 12558883648 op 0x0:(READ) flags 0x1000 phys_seg 4 prio class 0
> > [248333.214330] BTRFS error (device sdg): bdev /dev/sdd errs: wr
> > 74392549, rd 1756500, flush 192, corrupt 37086, gen 21
> > [248333.235374] sd 4:0:2:0: [sdd] tag#336 FAILED Result:
> > hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK cmd_age=0s
> > [248333.237816] sd 4:0:2:0: [sdd] tag#336 CDB: Write(16) 8a 00 00
> > 00 00 02 ec 91 5b 40 00 00 00 08 00 00
> > [248333.240217] blk_update_request: I/O error, dev sdd, sector
> > 12558883648 op 0x1:(WRITE) flags 0x800 phys_seg 1 prio class 0
> > [248333.242657] BTRFS error (device sdg): bdev /dev/sdd errs: wr
> > 74392550, rd 1756500, flush 192, corrupt 37086, gen 21
> > [248333.245598] sd 4:0:2:0: [sdd] tag#337 FAILED Result:
> > hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK cmd_age=0s
> > [248333.248030] sd 4:0:2:0: [sdd] tag#337 CDB: Read(16) 88 00 00 00
> > 00 02 ec 9b c1 a0 00 00 00 20 00 00
> > [248333.250436] blk_update_request: I/O error, dev sdd, sector
> > 12559565216 op 0x0:(READ) flags 0x1000 phys_seg 4 prio class 0
> > [248333.252868] BTRFS error (device sdg): bdev /dev/sdd errs: wr
> > 74392550, rd 1756501, flush 192, corrupt 37086, gen 21
> > [248333.260039] sd 4:0:2:0: [sdd] tag#339 FAILED Result:
> > hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK cmd_age=0s
> > [248333.262465] sd 4:0:2:0: [sdd] tag#339 CDB: Write(16) 8a 00 00
> > 00 00 02 ec 9b c1 a0 00 00 00 08 00 00
> > [248333.264859] blk_update_request: I/O error, dev sdd, sector
> > 12559565216 op 0x1:(WRITE) flags 0x800 phys_seg 1 prio class 0
> > [248333.267309] BTRFS error (device sdg): bdev /dev/sdd errs: wr
> > 74392551, rd 1756501, flush 192, corrupt 37086, gen 21
> > [248333.270056] sd 4:0:2:0: [sdd] tag#340 FAILED Result:
> > hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK cmd_age=0s
> > [248333.272485] sd 4:0:2:0: [sdd] tag#340 CDB: Read(16) 88 00 00 00
> > 00 02 ec 9b 65 20 00 00 00 20 00 00
> > [248333.274875] blk_update_request: I/O error, dev sdd, sector
> > 12559541536 op 0x0:(READ) flags 0x1000 phys_seg 4 prio class 0
> > [248333.277279] BTRFS error (device sdg): bdev /dev/sdd errs: wr
> > 74392551, rd 1756502, flush 192, corrupt 37086, gen 21
> > [248333.288558] sd 4:0:2:0: [sdd] tag#342 FAILED Result:
> > hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK cmd_age=0s
> > [248333.290966] sd 4:0:2:0: [sdd] tag#342 CDB: Write(16) 8a 00 00
> > 00 00 02 ec 9b 65 20 00 00 00 08 00 00
> > [248333.293330] blk_update_request: I/O error, dev sdd, sector
> > 12559541536 op 0x1:(WRITE) flags 0x800 phys_seg 1 prio class 0
> > [248333.295720] BTRFS error (device sdg): bdev /dev/sdd errs: wr
> > 74392552, rd 1756502, flush 192, corrupt 37086, gen 21
> > [248333.298242] sd 4:0:2:0: [sdd] tag#343 FAILED Result:
> > hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK cmd_age=0s
> > [248333.300727] sd 4:0:2:0: [sdd] tag#343 CDB: Read(16) 88 00 00 00
> > 00 02 ec 93 1d e0 00 00 00 20 00 00
> > [248333.303196] blk_update_request: I/O error, dev sdd, sector
> > 12558999008 op 0x0:(READ) flags 0x1000 phys_seg 4 prio class 0
> > [248333.305681] BTRFS error (device sdg): bdev /dev/sdd errs: wr
> > 74392552, rd 1756503, flush 192, corrupt 37086, gen 21
> > [248333.317340] sd 4:0:2:0: [sdd] tag#345 FAILED Result:
> > hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK cmd_age=0s
> > [248333.319891] sd 4:0:2:0: [sdd] tag#345 CDB: Write(16) 8a 00 00
> > 00 00 02 ec 93 1d e0 00 00 00 08 00 00
> > [248333.322374] blk_update_request: I/O error, dev sdd, sector
> > 12558999008 op 0x1:(WRITE) flags 0x800 phys_seg 1 prio class 0
> > [248333.324918] BTRFS error (device sdg): bdev /dev/sdd errs: wr
> > 74392553, rd 1756503, flush 192, corrupt 37086, gen 21
> > [248333.327663] sd 4:0:2:0: [sdd] tag#346 FAILED Result:
> > hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK cmd_age=0s
> > [248333.330199] sd 4:0:2:0: [sdd] tag#346 CDB: Read(16) 88 00 00 00
> > 00 02 ec 93 21 60 00 00 00 20 00 00
> > [248333.332701] blk_update_request: I/O error, dev sdd, sector
> > 12558999904 op 0x0:(READ) flags 0x1000 phys_seg 4 prio class 0
> > [248333.335239] BTRFS error (device sdg): bdev /dev/sdd errs: wr
> > 74392553, rd 1756504, flush 192, corrupt 37086, gen 21
> > [248333.344839] sd 4:0:2:0: [sdd] tag#348 FAILED Result:
> > hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK cmd_age=0s
> > [248333.347378] sd 4:0:2:0: [sdd] tag#348 CDB: Write(16) 8a 00 00
> > 00 00 02 ec 93 21 60 00 00 00 08 00 00
> > [248333.349920] blk_update_request: I/O error, dev sdd, sector
> > 12558999904 op 0x1:(WRITE) flags 0x800 phys_seg 1 prio class 0
> > [248333.352520] BTRFS error (device sdg): bdev /dev/sdd errs: wr
> > 74392554, rd 1756504, flush 192, corrupt 37086, gen 21
> > [248333.832271] BTRFS warning (device sdg): lost page write due to
> > IO error on /dev/sdd (-5)
> > [248333.832933] BTRFS warning (device sdg): lost page write due to
> > IO error on /dev/sdd (-5)
> > [248333.833456] BTRFS warning (device sdg): lost page write due to
> > IO error on /dev/sdd (-5)
> > [248333.869878] BTRFS error (device sdg): error writing primary
> > super block to device 3
> > [248343.130021] scsi_io_completion_action: 211 callbacks suppressed
> > [248343.130032] sd 4:0:2:0: [sdd] tag#348 FAILED Result:
> > hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK cmd_age=0s
> > [248343.134636] sd 4:0:2:0: [sdd] tag#348 CDB: Write(16) 8a 00 00
> > 00 00 00 00 2e 66 00 00 00 00 80 00 00
> > [248343.134638] print_req_error: 212 callbacks suppressed
> > [248343.134640] blk_update_request: I/O error, dev sdd, sector
> > 3040768 op 0x1:(WRITE) flags 0x0 phys_seg 16 prio class 0
> > [248364.589574] program smartctl is using a deprecated SCSI ioctl,
> > please convert it to SG_IO
> > [248364.590844] program smartctl is using a deprecated SCSI ioctl,
> > please convert it to SG_IO
> > [248364.592072] program smartctl is using a deprecated SCSI ioctl,
> > please convert it to SG_IO
> > [248366.236244] program smartctl is using a deprecated SCSI ioctl,
> > please convert it to SG_IO
> > [248366.237644] program smartctl is using a deprecated SCSI ioctl,
> > please convert it to SG_IO
> > [248366.238892] program smartctl is using a deprecated SCSI ioctl,
> > please convert it to SG_IO
> > [248366.240126] program smartctl is using a deprecated SCSI ioctl,
> > please convert it to SG_IO
> > [248366.241384] program smartctl is using a deprecated SCSI ioctl,
> > please convert it to SG_IO
> > [248366.241397] program smartctl is using a deprecated SCSI ioctl,
> > please convert it to SG_IO
> > [248374.163464] sd 4:0:2:0: [sdd] tag#367 FAILED Result:
> > hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK cmd_age=0s
> > [248374.163473] sd 4:0:2:0: [sdd] tag#368 FAILED Result:
> > hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK cmd_age=0s
> > [248374.165017] sd 4:0:2:0: [sdd] tag#371 FAILED Result:
> > hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK cmd_age=0s
> > [248374.165024] sd 4:0:2:0: [sdd] tag#371 CDB: Write(16) 8a 00 00
> > 00 00 00 01 1f aa 00 00 00 00 80 00 00
> > [248374.165027] blk_update_request: I/O error, dev sdd, sector
> > 18852352 op 0x1:(WRITE) flags 0x0 phys_seg 16 prio class 0
> > [248374.165175] sd 4:0:2:0: [sdd] tag#374 FAILED Result:
> > hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK cmd_age=0s
> > [248374.165179] sd 4:0:2:0: [sdd] tag#374 CDB: Write(16) 8a 00 00
> > 00 00 00 01 1f aa 80 00 00 00 80 00 00
> > [248374.165180] blk_update_request: I/O error, dev sdd, sector
> > 18852480 op 0x1:(WRITE) flags 0x0 phys_seg 16 prio class 0
> > [248374.165443] sd 4:0:2:0: [sdd] tag#381 FAILED Result:
> > hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK cmd_age=0s
> > [248374.165450] sd 4:0:2:0: [sdd] tag#381 CDB: Write(16) 8a 00 00
> > 00 00 00 01 1f ab 00 00 00 00 80 00 00
> > [248374.165452] blk_update_request: I/O error, dev sdd, sector
> > 18852608 op 0x1:(WRITE) flags 0x0 phys_seg 16 prio class 0
> > [248374.166596] sd 4:0:2:0: [sdd] tag#321 FAILED Result:
> > hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK cmd_age=0s
> > [248374.166601] sd 4:0:2:0: [sdd] tag#321 CDB: Write(16) 8a 00 00
> > 00 00 00 01 0f 6e 00 00 00 00 80 00 00
> > [248374.166603] blk_update_request: I/O error, dev sdd, sector
> > 17788416 op 0x1:(WRITE) flags 0x0 phys_seg 16 prio class 0
> > [248374.166610] sd 4:0:2:0: [sdd] tag#322 FAILED Result:
> > hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK cmd_age=0s
> > [248374.166615] sd 4:0:2:0: [sdd] tag#322 CDB: Write(16) 8a 00 00
> > 00 00 00 01 0f 6d 80 00 00 00 80 00 00
> > [248374.166617] blk_update_request: I/O error, dev sdd, sector
> > 17788288 op 0x1:(WRITE) flags 0x0 phys_seg 16 prio class 0
> > [248374.166734] sd 4:0:2:0: [sdd] tag#326 FAILED Result:
> > hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK cmd_age=0s
> > [248374.166738] sd 4:0:2:0: [sdd] tag#326 CDB: Write(16) 8a 00 00
> > 00 00 00 01 0f 6e 80 00 00 00 10 00 00
> > [248374.166739] blk_update_request: I/O error, dev sdd, sector
> > 17788544 op 0x1:(WRITE) flags 0x0 phys_seg 2 prio class 0
> > [248374.167144] sd 4:0:2:0: [sdd] tag#367 CDB: Write(16) 8a 00 00
> > 00 00 00 01 1f a9 80 00 00 00 80 00 00
> > [248374.167777] sd 4:0:2:0: [sdd] tag#330 FAILED Result:
> > hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK cmd_age=0s
> > [248374.167781] sd 4:0:2:0: [sdd] tag#330 CDB: Write(16) 8a 00 00
> > 00 00 00 01 1a ef 80 00 00 00 80 00 00
> > [248374.167783] blk_update_request: I/O error, dev sdd, sector
> > 18542464 op 0x1:(WRITE) flags 0x0 phys_seg 8 prio class 0
> > [248374.167794] sd 4:0:2:0: [sdd] tag#332 FAILED Result:
> > hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK cmd_age=0s
> > [248374.167799] sd 4:0:2:0: [sdd] tag#332 CDB: Write(16) 8a 00 00
> > 00 00 00 01 1a f0 00 00 00 00 80 00 00
> > [248374.167801] blk_update_request: I/O error, dev sdd, sector
> > 18542592 op 0x1:(WRITE) flags 0x0 phys_seg 16 prio class 0
> > [248374.167954] blk_update_request: I/O error, dev sdd, sector
> > 18542720 op 0x1:(WRITE) flags 0x0 phys_seg 16 prio class 0
> > [248374.169024] sd 4:0:2:0: [sdd] tag#368 CDB: Write(16) 8a 00 00
> > 00 00 00 01 1f a9 00 00 00 00 80 00 00
> > [248374.170392] blk_update_request: I/O error, dev sdd, sector
> > 18855056 op 0x1:(WRITE) flags 0x0 phys_seg 14 prio class 0
> > [248374.211040] btrfs_dev_stat_print_on_error: 167 callbacks
> > suppressed
> > [248374.211044] BTRFS error (device sdg): bdev /dev/sdd errs: wr
> > 74392712, rd 1756513, flush 193, corrupt 37086, gen 21
> > [248374.213146] BTRFS error (device sdg): bdev /dev/sdd errs: wr
> > 74392713, rd 1756513, flush 193, corrupt 37086, gen 21
> > [248374.214110] BTRFS error (device sdg): bdev /dev/sdd errs: wr
> > 74392714, rd 1756513, flush 193, corrupt 37086, gen 21
> > [248374.214237] BTRFS error (device sdg): bdev /dev/sdd errs: wr
> > 74392715, rd 1756513, flush 193, corrupt 37086, gen 21
> > [248374.215286] BTRFS error (device sdg): bdev /dev/sdd errs: wr
> > 74392716, rd 1756513, flush 193, corrupt 37086, gen 21
> > [248374.216309] BTRFS error (device sdg): bdev /dev/sdd errs: wr
> > 74392717, rd 1756513, flush 193, corrupt 37086, gen 21
> > [248374.217330] BTRFS error (device sdg): bdev /dev/sdd errs: wr
> > 74392718, rd 1756513, flush 193, corrupt 37086, gen 21
> > [248374.219443] BTRFS error (device sdg): bdev /dev/sdd errs: wr
> > 74392719, rd 1756513, flush 193, corrupt 37086, gen 21
> > [248374.220569] BTRFS error (device sdg): bdev /dev/sdd errs: wr
> > 74392720, rd 1756513, flush 193, corrupt 37086, gen 21
> > [248374.221699] BTRFS error (device sdg): bdev /dev/sdd errs: wr
> > 74392721, rd 1756513, flush 193, corrupt 37086, gen 21
> > [248374.355125] BTRFS warning (device sdg): lost page write due to
> > IO error on /dev/sdd (-5)
> > [248374.355826] BTRFS warning (device sdg): lost page write due to
> > IO error on /dev/sdd (-5)
> > [248374.357122] BTRFS warning (device sdg): lost page write due to
> > IO error on /dev/sdd (-5)
> > [248374.389718] BTRFS error (device sdg): error writing primary
> > super block to device 3
> 


