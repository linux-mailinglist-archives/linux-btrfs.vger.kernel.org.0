Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D58D232F77
	for <lists+linux-btrfs@lfdr.de>; Thu, 30 Jul 2020 11:26:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728624AbgG3J0o (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 30 Jul 2020 05:26:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726819AbgG3J0m (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 30 Jul 2020 05:26:42 -0400
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B6B2C061794
        for <linux-btrfs@vger.kernel.org>; Thu, 30 Jul 2020 02:26:42 -0700 (PDT)
Received: by mail-oi1-x244.google.com with SMTP id e6so2989325oii.4
        for <linux-btrfs@vger.kernel.org>; Thu, 30 Jul 2020 02:26:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9Gyfh+W/0x+kAkDpL/f7oe4mKY5d0P/lm76NklI7xuI=;
        b=lxJ2VJ/Wb/sc2p7DgRBtyAtNlS8QygzO0XpvxLOH0ln6ydNXb0Eyw3dB5idCQQt5Fo
         yxyfOgeFOg32/cqRGPQX3x61lKmwtjvFtOoccRTM+o7UyFUfArl72tkwOPJ5Uz0NHkSa
         rMCbcpNnNmZSpHVMgRVFkB1l9WWW6qC2ffPsqPRZYiPdNXywbyjbT/hicXb5UcslxwKB
         RtS8MQJia7HKFBwlhABBv6HJD+RU+9JN2KSXiA63JV+BWeBiPAOguOcciHSxIFUpvqRQ
         gmFemlodUeOnfQg49tVA2vMHpjwUvIu9UMvqbfpPQN7iesuNAqmrMlub6EdcaWCUipHB
         ethg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9Gyfh+W/0x+kAkDpL/f7oe4mKY5d0P/lm76NklI7xuI=;
        b=Au6wnRgt4l+FrcqLJMAskv+kSzwsTQTW5bqY9pF2uaKdDfHB80HTwsBextx2TAzsj4
         ejse+IxAgON1fopOvd69nSgpvQs96pFO7nmBwe/fKokgwkHUrlTBfruCVwByBqbNvva8
         8cv1gz7cGJLS/kJ9qtfAFeY7U348d/2j8Kb0oY3w8gE+S4wJe3XN+ZYGh6gmv1uNcBYn
         Yv8R4pgiSh0yYgOTX/gq6nwOCtdD5lsObKW4a5Gc4ziMOClSEFf4qTrf/qUda5907wDD
         PZQhStIn2CLaCXMC6mNE8MoSG5j0CGFJyccWN+eVho5lEpHP8oq64EQCtMDnoAEyTbcS
         iUZw==
X-Gm-Message-State: AOAM530XQoIzGdFksTaCIlZW6TWyRlG6YEzHAHLIvLy2bBU5xb2MvBmv
        VNxMjxDQdwEUF2pmtHi5YQfE9Nl2bI/VcZx6JHu3116u
X-Google-Smtp-Source: ABdhPJwOA6Yykfxs1PGz5e34qOW89D/2LFCWeNQnSygNSQRpwXw5b+OEkVxWN8OuQL+eucTCS++ff/BdxGyxvaMZGjk=
X-Received: by 2002:aca:758e:: with SMTP id q136mr755792oic.36.1596101201524;
 Thu, 30 Jul 2020 02:26:41 -0700 (PDT)
MIME-Version: 1.0
References: <CAPtuuyEM7YZe8oaqhLivMJLshcsuQWvGuvrmHO1=5ZhYVN7hHA@mail.gmail.com>
 <20200726000105.GG5890@hungrycats.org> <20200726001134.GH5890@hungrycats.org>
In-Reply-To: <20200726001134.GH5890@hungrycats.org>
From:   Davide Palma <dpfuturehacker@gmail.com>
Date:   Thu, 30 Jul 2020 11:26:34 +0200
Message-ID: <CAPtuuyGu5vksjhDtZOsWE9bOgnP1CTP5h81sxs=ME6AafNMgEQ@mail.gmail.com>
Subject: Re: Error: Failed to read chunk root, fs destroyed
To:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
Cc:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Thank you Zygo. Any btrfs check --repair will fail to open chunk root.
Looks like my fs is gone. Pro tip: don't use ramdisks in this silly
way :)

Il giorno dom 26 lug 2020 alle ore 02:11 Zygo Blaxell
<ce3g8jdj@umail.furryterror.org> ha scritto:

>
> On Sat, Jul 25, 2020 at 08:01:05PM -0400, Zygo Blaxell wrote:
> > On Thu, Jul 23, 2020 at 11:15:40PM +0200, Davide Palma wrote:
> > > Hello,
> > > What happened:
> > >
> > > I had a Gentoo linux install on a standard, ssd, btrfs partition.
> > > After I removed lots of files, I wanted to shrink the partition, so i
> > > shrunk it as much as possible and started a balance operation to
> > > squeeze out more unallocated space.
> >
> > The other order would have been better:  balance first to compact
> > free space, then shrink.  Balance and shrink are more or less the same
> > operation, but a balance can use all of the space on the filesystem to
> > eliminate free space gaps between extents, while a shrink can strictly
> > only use space below the target device size, considerably limiting its
> > flexibility.  If you do the shrink first, then balance has no free space
> > to work with that the shrink didn't already use.  If you do the balance
> > first, then block groups can be packed until the smallest amount of free
> > space remains in each one (often zero, but not always), then after the
> > balance, shrink can move full block groups around.
> >
> > That said, the amount of IO required increases rapidly for the last few
> > percent of free space.  You'd have to balance the entire filesystem to
> > get the last few percent, and you wouldn't be able to get all of it.
> > If the smallest extent on the filesystem is 112.004MiB then the maximum
> > space efficiency is 87.5%.
> >
> > > However, the balance operation was
> > > not progressing. (the behaviour was identical to the one described
> > > here https://www.opensuse-forum.de/thread/43376-btrfs-balance-caught-in-write-loop/
> > > ).
> >
> > This is the brtfs balance looping bug.  One of the triggers of the
> > bug is running low on space.
> >
> > > So I cancelled the balance and, following a piece of advice found
> > > on the net, created a ramdisk that worked as a second device for a
> > > raid1 setup.
> > >
> > > dd if=/dev/zero of=/var/tmp/btrfs bs=1G count=5
> > >
> > > losetup -v -f /var/tmp/btrfs
> > > btrfs device add /dev/loop0 .
> > >
> > > I tried running the balance again, but, as before, it wasn't
> > > progressing. So I decided to remove the ramdisk and reconvert the now
> > > raid1 partition to a single one. This is where the bad stuff began: As
> > > the process of converting raid1 to single is a balance, the balance
> > > looped and didn't progress. I also couldn't cancel it by ^C or SIGTERM
> > > or SIGKILL. Since I didn't know what to do, I just rebooted the PC
> > > (very bad decision!). The filesystem is now broken.
> >
> > > Please note I never tried dangerous options like zero-log or --repair.
> >
> > You didn't need to.  The most dangerous thing you did, by far, was adding
> > a ramdisk to a single-device btrfs that you intended to keep.  Compared
> > to that, zero-log is extremely safe.  Even --repair sometimes works.
> >
> > > I setted up an arch linux install on /dev/sda4 to keep on working and
> > > to try recovery.
> > >
> > > My environment:
> > > Gentoo linux: kernel 5.7.8, btrfs-progs 5.7
> > >
> > > Arch linux:
> > > uname -a
> > > Linux lenuovo 5.7.9-arch1-1 #1 SMP PREEMPT Thu, 16 Jul 2020 19:34:49
> > > +0000 x86_64 GNU/Linux
> > >
> > > btrfs --version
> > > btrfs-progs v5.7
> > >
> > > fdisk -l
> > > Disk /dev/sda: 223,58 GiB, 240057409536 bytes, 468862128 sectors
> > > Disk model: KINGSTON SUV400S
> > > Units: sectors of 1 * 512 = 512 bytes
> > > Sector size (logical/physical): 512 bytes / 512 bytes
> > > I/O size (minimum/optimal): 512 bytes / 512 bytes
> > > Disklabel type: gpt
> > > Disk identifier: 472C32BA-DDF3-4063-BBF7-629C7A68C195
> > >
> > > Dispositivo     Start      Fine   Settori   Size Tipo
> > > /dev/sda1        2048   8194047   8192000   3,9G Linux swap
> > > /dev/sda2     8194048   8521727    327680   160M EFI System
> > > /dev/sda3     8521728 302680063 294158336 140,3G Linux filesystem
> > > /dev/sda4   302680064 345087999  42407936  20,2G Linux filesystem
> > > /dev/sda5   345088000 468860927 123772928    59G Microsoft basic data
> > >
> > > The broken FS is /dev/sda3.
> > >
> > > Any combination of mount options without degraded fails with:
> > > BTRFS info (device sda3): disk space caching is enabled
> > > BTRFS info (device sda3): has skinny extents
> > > BTRFS error (device sda3): devid 2 uuid
> > > bc7154d2-bf0e-4ff4-b7cb-44e118148976 is missing
> > > BTRFS error (device sda3): failed to read the system array: -2
> > > BTRFS error (device sda3): open_ctree failed
> > >
> > > Any combination of mount options with degraded fails with:
> > > BTRFS info (device sda3): allowing degraded mounts
> > > BTRFS info (device sda3): disk space caching is enabled
> > > BTRFS info (device sda3): has skinny extents
> > > BTRFS warning (device sda3): devid 2 uuid
> > > bc7154d2-bf0e-4ff4-b7cb-44e118148976 is missing
> > > BTRFS error (device sda3): failed to read chunk root
> > > BTRFS error (device sda3): open_ctree failed
> > >
> > > This is also the error of every btrfs prog that tries to access the volume:
> > > btrfs check /dev/sda3
> > > Opening filesystem to check...
> > > warning, device 2 is missing
> > > bad tree block 315196702720, bytenr mismatch, want=315196702720, have=0
> > > ERROR: cannot read chunk root
> > > ERROR: cannot open file system
> > >
> > > btrfs restore /dev/sda3 -i -l
> > > warning, device 2 is missing
> > > bad tree block 315196702720, bytenr mismatch, want=315196702720, have=0
> > > ERROR: cannot read chunk root
> > > Could not open root, trying backup super
> > > warning, device 2 is missing
> > > bad tree block 315196702720, bytenr mismatch, want=315196702720, have=0
> > > ERROR: cannot read chunk root
> > > Could not open root, trying backup super
> > > ERROR: superblock bytenr 274877906944 is larger than device size 150609068032
> > > Could not open root, trying backup super
> > >
> > > btrfs rescue super-recover /dev/sda3
> > > All supers are valid, no need to recover
> > >
> > > btrfs inspect-internal dump-super -f /dev/sda3
> > > superblock: bytenr=65536, device=/dev/sda3
> > > ---------------------------------------------------------
> > > csum_type 0 (crc32c)
> > > csum_size 4
> > > csum 0x3d057827 [match]
> > > bytenr 65536
> > > flags 0x1
> > > ( WRITTEN )
> > > magic _BHRfS_M [match]
> > > fsid 8e42af34-3102-4547-b3ff-f3d976eafa9d
> > > metadata_uuid 8e42af34-3102-4547-b3ff-f3d976eafa9d
> > > label gentoo
> > > generation 8872486
> > > root 110264320
> > > sys_array_size 97
> > > chunk_root_generation 8863753
> > > root_level 1
> > > chunk_root 315196702720
> > > chunk_root_level 1
> > > log_root 0
> > > log_root_transid 0
> > > log_root_level 0
> > > total_bytes 151926079488
> > > bytes_used 89796988928
> > > sectorsize 4096
> > > nodesize 16384
> > > leafsize (deprecated) 16384
> > > stripesize 4096
> > > root_dir 6
> > > num_devices 2
> > > compat_flags 0x0
> > > compat_ro_flags 0x0
> > > incompat_flags 0x171
> > > ( MIXED_BACKREF |
> > >  COMPRESS_ZSTD |
> > >  BIG_METADATA |
> > >  EXTENDED_IREF |
> > >  SKINNY_METADATA )
> > > cache_generation 8872486
> > > uuid_tree_generation 283781
> > > dev_item.uuid 877550b0-11cc-4b12-944f-83ac2a08201c
> > > dev_item.fsid 8e42af34-3102-4547-b3ff-f3d976eafa9d [match]
> > > dev_item.type 0
> > > dev_item.total_bytes 148780351488
> > > dev_item.bytes_used 148779302912
> > > dev_item.io_align 4096
> > > dev_item.io_width 4096
> > > dev_item.sector_size 4096
> > > dev_item.devid 1
> > > dev_item.dev_group 0
> > > dev_item.seek_speed 0
> > > dev_item.bandwidth 0
> > > dev_item.generation 0
> > > sys_chunk_array[2048]:
> > > item 0 key (FIRST_CHUNK_TREE CHUNK_ITEM 315196702720)
> > > length 33554432 owner 2 stripe_len 65536 type SYSTEM
> > > io_align 65536 io_width 65536 sector_size 4096
> > > num_stripes 1 sub_stripes 1
> > > stripe 0 devid 2 offset 38797312
> > > dev_uuid bc7154d2-bf0e-4ff4-b7cb-44e118148976
> > > backup_roots[4]:
> > > backup 0:
> > > backup_tree_root: 110264320 gen: 8872486 level: 1
> > > backup_chunk_root: 315196702720 gen: 8863753 level: 1
> > > backup_extent_root: 110280704 gen: 8872486 level: 2
> > > backup_fs_root: 125812736 gen: 8872478 level: 3
> > > backup_dev_root: 104220278784 gen: 8863753 level: 0
> > > backup_csum_root: 125796352 gen: 8872486 level: 2
> > > backup_total_bytes: 151926079488
> > > backup_bytes_used: 89796988928
> > > backup_num_devices: 2
> > >
> > > backup 1:
> > > backup_tree_root: 191561728 gen: 8872483 level: 1
> > > backup_chunk_root: 315196702720 gen: 8863753 level: 1
> > > backup_extent_root: 191578112 gen: 8872483 level: 2
> > > backup_fs_root: 125812736 gen: 8872478 level: 3
> > > backup_dev_root: 104220278784 gen: 8863753 level: 0
> > > backup_csum_root: 297615360 gen: 8872483 level: 2
> > > backup_total_bytes: 151926079488
> > > backup_bytes_used: 89796988928
> > > backup_num_devices: 2
> > >
> > > backup 2:
> > > backup_tree_root: 398196736 gen: 8872484 level: 1
> > > backup_chunk_root: 315196702720 gen: 8863753 level: 1
> > > backup_extent_root: 398213120 gen: 8872484 level: 2
> > > backup_fs_root: 125812736 gen: 8872478 level: 3
> > > backup_dev_root: 104220278784 gen: 8863753 level: 0
> > > backup_csum_root: 45662208 gen: 8872484 level: 2
> > > backup_total_bytes: 151926079488
> > > backup_bytes_used: 89796988928
> > > backup_num_devices: 2
> > >
> > > backup 3:
> > > backup_tree_root: 70385664 gen: 8872485 level: 1
> > > backup_chunk_root: 315196702720 gen: 8863753 level: 1
> > > backup_extent_root: 70402048 gen: 8872485 level: 2
> > > backup_fs_root: 125812736 gen: 8872478 level: 3
> > > backup_dev_root: 104220278784 gen: 8863753 level: 0
> > > backup_csum_root: 76185600 gen: 8872485 level: 2
> > > backup_total_bytes: 151926079488
> > > backup_bytes_used: 89796988928
> > > backup_num_devices: 2
> > >
> > > chunk-recover:
> > > https://pastebin.com/MieHVxbd
> > >
> > > So, did I screw up btrfs so badly I don't deserve a recovery, or can
> > > something be done?
> >
> > Normally, if we are setting up a RAID0 or JBOD array, we are accepting
> > the risk that if any device in the array fails, we'll mkfs and start
> > over with a new filesystem.  Balances and device remove/shrink will move
> > data aggressively to the most-empty disk.
> >
> > If the chunk tree roots are now on the RAM device (very likely if the SSD
> > was full, a device added, then a balance/delete/resize-shrink started)
> > then they're gone forever.  Even old copies on the partition you were
> > trying to shrink would have been overwritten by other data by now.
> >
> > If a metadata block group was moved to the RAM device, the filesystem
> > is gone.  The data blocks will remain on disk, but there will be nothing
> > left behind to associate them with files any more.
> >
> > You might want to try:
> >
> >       1.  Make a dd copy of the disk, because the following steps
> >       might destroy the filesystem.
> >
> >       2.  btrfs rescue chunk-recover /dev/sda3
> >
> >       3.  btrfs check --repair --init-csum-tree /dev/sda3
>
> Whoops, that should be:
>
>         3.  btrfs check --repair --init-extent-tree /dev/sda3
>
> Maybe --init-csum-tree will be needed too, but it's not likely that any
> of these commands will work at this point.
>
> > but it looks like you already did step 2, and if that doesn't work
> > there is no step 3.
> >
> > > Thank you,
> > > David
