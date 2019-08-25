Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C29A29C626
	for <lists+linux-btrfs@lfdr.de>; Sun, 25 Aug 2019 22:50:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728876AbfHYUuI convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Sun, 25 Aug 2019 16:50:08 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:39738 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728185AbfHYUuH (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 25 Aug 2019 16:50:07 -0400
Received: by mail-lj1-f193.google.com with SMTP id x4so13231550ljj.6
        for <linux-btrfs@vger.kernel.org>; Sun, 25 Aug 2019 13:50:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=/1RCJxlQJgT7qnexir1dQTAdd0xORnIIWy5tXkcL/6Q=;
        b=MfpwiLRzxBC4s8lSZidEMdxkcDsaSlxU9hvR7+gEDNraDcjX42hmcEWZntFDWajlUJ
         lVUsRAI9Ir8Y22wcxxqE3pJe92h6/fPED9bOcJiUkBTmnBodTIwE0IO0id2UQcmBALr2
         FqhjK3o/pIIt/5cAIYCJnEAw4uUF9Zg+XdcYeCNCg9vjoq2i6Hq0ls5uhSzSX0MFJ5Di
         GuM2aokwsehro2d/dZICkNHEEouevle7bGLeFXNq/bljo2/UhIMY+PQWTSu6wFRDNf0Y
         UpzV9d7f20dZ/tv8Fx+V6Zev7S9TgauO60sYMyOtUvPacBOuxPsadf74Uy+lb7Rig6Wp
         q96A==
X-Gm-Message-State: APjAAAXDPEeelh6iEHuQEhcm55as76g3Y5uJFSdtuW8k05GQ3BSElEBy
        BbuUZ/GjQzQeBmgA4jwHPW+mOAWsFLdPAq8u4aEoOcxL
X-Google-Smtp-Source: APXvYqzq7bQLjqnyhG+qpBesB2q72Mxqqzoy7Lf75+TkigincvqCXozqhNzOIMJ01dTgI5N24sHMgQXuU4EpOHtsK2U=
X-Received: by 2002:a2e:22c4:: with SMTP id i187mr8618042lji.41.1566766204513;
 Sun, 25 Aug 2019 13:50:04 -0700 (PDT)
MIME-Version: 1.0
References: <CAP-b2nNHVnfDyC2-F2pWtwUgjZxcqfwqYvNcBmknd5ZHauWoUw@mail.gmail.com>
 <cafc855e-b030-83ff-2984-dfb45a36d1b3@gmx.com> <CAP-b2nPJE_=957ARh+JMzOkVg4E_A_tAJPiN0e1BTyCLTZ=Jhw@mail.gmail.com>
 <55f9d2ff-b6b0-7f13-287e-c9916c57943f@gmx.com> <CAP-b2nM=s07wA0Yb9XQvea_ULZ=kui0UZNddGDa_gfd1C_m7qQ@mail.gmail.com>
In-Reply-To: <CAP-b2nM=s07wA0Yb9XQvea_ULZ=kui0UZNddGDa_gfd1C_m7qQ@mail.gmail.com>
From:   Daniel Clarke <dan@e-dan.co.uk>
Date:   Sun, 25 Aug 2019 21:49:52 +0100
Message-ID: <CAP-b2nNzzjsAbJGAi=R0yk6qvQ-bRM3__k-NBCb+oko7Ume+kQ@mail.gmail.com>
Subject: Re: BTRFS unable to mount after one failed disk in RAID 1
To:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello,

Not sure if you got my previous email (see below).

Today I ran another attempt at using btrfs restore, and it's picked up
a fair amount of files (about 80% of them).

Command used:

~$ btrfs restore -x -m -i -v --path-regex '^/(|home(|/dan(|/.*)))$'
/dev/sdb1 /mnt/ssd1/

and rerun without attributes/metadata in case it helped (no change though):

~$ btrfs restore -i -v --path-regex '^/(|home(|/dan(|/.*)))$'
/dev/sdb1 /mnt/ssd1/

I logged various output (stdout and stderr) and there is a fair amount
skipped with messages like below:

bad tree block 1058371960832, bytenr mismatch, want=1058371960832, have=0
bad tree block 1058371977216, bytenr mismatch, want=1058371977216, have=0
bad tree block 1058371993600, bytenr mismatch, want=1058371993600, have=0
bad tree block 1058372009984, bytenr mismatch, want=1058372009984, have=0
bad tree block 1058372026368, bytenr mismatch, want=1058372026368, have=0
bad tree block 1058372042752, bytenr mismatch, want=1058372042752, have=0
bad tree block 1058372059136, bytenr mismatch, want=1058372059136, have=0
bad tree block 1058372075520, bytenr mismatch, want=1058372075520, have=0
bad tree block 1058372091904, bytenr mismatch, want=1058372091904, have=0
bad tree block 1058372108288, bytenr mismatch, want=1058372108288, have=0
bad tree block 1058372124672, bytenr mismatch, want=1058372124672, have=0
bad tree block 1058405138432, bytenr mismatch, want=1058405138432, have=0
bad tree block 1058372075520, bytenr mismatch, want=1058372075520, have=0
Error searching -5
Error searching /mnt/ssd1/home/dan/Pictures/Malaysia Singapore 2012
bad tree block 1058405138432, bytenr mismatch, want=1058405138432, have=0

Is there any option to try to fix/recovery in these cases.

Thanks very much,

Dan


On Thu, 22 Aug 2019 at 21:10, Daniel Clarke <dan@e-dan.co.uk> wrote:
>
> Hi Qu,
>
> Thanks again,
>
> The dump-tree output ran really quick, but somewhat large so I've
> attached as a txt file.
>
> Your thoughts are correct, everything looks ok (RAID1) apart from this
> one item (DUP):
>
>     item 43 key (FIRST_CHUNK_TREE CHUNK_ITEM 1057666105344) itemoff
> 11355 itemsize 112
>         length 1073741824 owner 2 stripe_len 65536 type METADATA|DUP
>         io_align 65536 io_width 65536 sector_size 4096
>         num_stripes 2 sub_stripes 1
>             stripe 0 devid 2 offset 172873482240
>             dev_uuid a3889c61-07b3-4165-bc37-e9918e41ea8d
>             stripe 1 devid 2 offset 173947224064
>             dev_uuid a3889c61-07b3-4165-bc37-e9918e41ea8d
>
> Cheers,
>
> Dan
>
> On Thu, 22 Aug 2019 at 00:23, Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
> >
> >
> >
> > On 2019/8/22 上午2:51, Daniel Clarke wrote:
> > > Hi Qu,
> > >
> > > Many thanks for you response, see below:
> > >
> > >>
> > >>
> > >>
> > >> On 2019/8/21 上午3:42, Daniel Clarke wrote:
> > >>> Hi,
> > >>>
> > >>> I'm having some trouble recovering my data after a single disk has
> > >>> failed in a raid1 two disk setup.
> > >>>
> > >>> The original setup:
> > >>> mkfs.btrfs -L MASTER /dev/sdb1
> > >>> mount -o compress=zstd,noatime /dev/sdb1 /mnt/master
> > >>> btrfs subvolume create /mnt/master/home
> > >>> btrfs device add /dev/sdc1 /mnt/master
> > >>> btrfs balance start -dconvert=raid1 -mconvert=raid1 /mnt/master
> > >>>
> > >>> Mount after in fstab:
> > >>>
> > >>> UUID=70a651ab-4837-4891-9099-a6c8a52aa40f /mnt/master     btrfs
> > >>> defaults,noatime,compress=zstd 0      0
> > >>>
> > >>> Was working fine for about 8 months, however I found the filesystem
> > >>> went to read only,
> > >>
> > >> Dmesg of that please.
> > >>
> > >> And there is a known bug that an aborted transaction can cause race and
> > >> corrupt the fs.
> > >> Please provide the kernel version of that RO event.
> > >>
> > >
> > > When the original event occurred, the kernel version was:
> > > ~$ uname -a
> > > Linux dan-server 4.15.0-58-generic #64-Ubuntu SMP Tue Aug 6 11:12:41
> > > UTC 2019 x86_64 x86_64 x86_64 GNU/Linux
> >
> > A little old, but should be OK as I haven't see much problem related to
> > older kernel yet.
> >
> > >
> > > I've only got syslog going back 7 days, and it looks like the failure
> > > occurred before that without me knowing. I've attached syslog.7.gz for
> > > your information anyway.
> >
> > From that, the most obvious is your sdc1 has some hardware related
> > problem, a lot of read error directly from disk controller.
> >
> > >
> > > File system was read only at that point, but the restart failed, so I
> > > commented out the mount in fstab and tried manually.
> >
> > Consider how many read error and write error it hit, it's very possible
> > that btrfs goes RO as some tree blocks write fails, thus it goes RO.
> >
> > And considering it's sdc1 causing the problem, if you're using RAID1 for
> > both metadata and data, your sdb1 should be more or less OK.
> >
> > >
> > > Actually that first mount returned these errors (in attached syslog.3.gz):
> > > Aug 17 09:08:01 dan-server kernel: [   68.568642] BTRFS info (device
> > > sdb1): allowing degraded mounts
> > > Aug 17 09:08:01 dan-server kernel: [   68.568644] BTRFS info (device
> > > sdb1): disk space caching is enabled
> > > Aug 17 09:08:01 dan-server kernel: [   68.568645] BTRFS info (device
> > > sdb1): has skinny extents
> > > Aug 17 09:08:01 dan-server kernel: [   68.569781] BTRFS warning
> > > (device sdb1): devid 2 uuid a3889c61-07b3-4165-bc37-e9918e41ea8d is
> > > missing
> > > Aug 17 09:08:01 dan-server kernel: [   68.577883] BTRFS warning
> > > (device sdb1): devid 2 uuid a3889c61-07b3-4165-bc37-e9918e41ea8d is
> > > missing
> > > Aug 17 09:08:02 dan-server kernel: [   69.586393] BTRFS error (device
> > > sdb1): failed to read block groups: -5
> >
> > Then I'd say, some tree blocks are just missing, maybe you have some
> > SINGLE/DUP tree blocks on sdc1, thus causing the problem.
> >
> > It shouldn't be a problem if you only want RO mount.
> >
> > [...]
> > >> # btrfs ins dump-super -FfA /dev/sdc1
> > [...]
> > > stripesize        4096
> > > root_dir        6
> > > num_devices        2
> > > compat_flags        0x0
> > > compat_ro_flags        0x0
> > > incompat_flags        0x171
> > >             ( MIXED_BACKREF |
> > >               COMPRESS_ZSTD |
> > >               BIG_METADATA |
> > >               EXTENDED_IREF |
> > >               SKINNY_METADATA )
> > > cache_generation    8596
> > > uuid_tree_generation    8596
> > > dev_item.uuid        150986ba-521c-4eb0-85ec-9435edecaf2a
> > > dev_item.fsid        70a651ab-4837-4891-9099-a6c8a52aa40f [match]
> > > dev_item.type        0
> > > dev_item.total_bytes    2000397864960
> > > dev_item.bytes_used    1076996603904
> > > dev_item.io_align    4096
> > > dev_item.io_width    4096
> > > dev_item.sector_size    4096
> > > dev_item.devid        1
> > > dev_item.dev_group    0
> > > dev_item.seek_speed    0
> > > dev_item.bandwidth    0
> > > dev_item.generation    0
> > > sys_chunk_array[2048]:
> > >     item 0 key (FIRST_CHUNK_TREE CHUNK_ITEM 1769556934656)
> > >         length 33554432 owner 2 stripe_len 65536 type SYSTEM|RAID1
> > >         io_align 65536 io_width 65536 sector_size 4096
> > >         num_stripes 2 sub_stripes 1
> > >             stripe 0 devid 1 offset 2186280960
> > >             dev_uuid 150986ba-521c-4eb0-85ec-9435edecaf2a
> > >             stripe 1 devid 2 offset 885838053376
> > >             dev_uuid a3889c61-07b3-4165-bc37-e9918e41ea8d
> >
> > So system chunk is still OK, all RAID1.
> >
> > Then maybe some metadata chunks causing the problem. (can be caused by
> > btrfs-progs writes).
> >
> > If you want some more analyse why this mount fails, please provide the
> > following dump:
> > # btrfs ins dump-tree -t chunk /dev/sdb1
> >
> > Thanks,
> > Qu
> >
> > > backup_roots[4]:
> > >     backup 0:
> > >         backup_tree_root:    1507300622336    gen: 8594    level: 1
> > >         backup_chunk_root:    1769556934656    gen: 8191    level: 1
> > >         backup_extent_root:    1507302375424    gen: 8594    level: 2
> > >         backup_fs_root:        1506503901184    gen: 7886    level: 0
> > >         backup_dev_root:    1507550887936    gen: 8473    level: 1
> > >         backup_csum_root:    1507311517696    gen: 8594    level: 2
> > >         backup_total_bytes:    4000795729920
> > >         backup_bytes_used:    1075454636032
> > >         backup_num_devices:    2
> > >
> > >     backup 1:
> > >         backup_tree_root:    1507500949504    gen: 8595    level: 1
> > >         backup_chunk_root:    1769556934656    gen: 8191    level: 1
> > >         backup_extent_root:    1507297804288    gen: 8595    level: 2
> > >         backup_fs_root:        1506503901184    gen: 7886    level: 0
> > >         backup_dev_root:    1507550887936    gen: 8473    level: 1
> > >         backup_csum_root:    1768498708480    gen: 8595    level: 2
> > >         backup_total_bytes:    4000795729920
> > >         backup_bytes_used:    1075454439424
> > >         backup_num_devices:    2
> > >
> > >     backup 2:
> > >         backup_tree_root:    1768503099392    gen: 8596    level: 1
> > >         backup_chunk_root:    1769556934656    gen: 8191    level: 1
> > >         backup_extent_root:    1768503115776    gen: 8596    level: 2
> > >         backup_fs_root:        1506503901184    gen: 7886    level: 0
> > >         backup_dev_root:    1507550887936    gen: 8473    level: 1
> > >         backup_csum_root:    1768505966592    gen: 8596    level: 2
> > >         backup_total_bytes:    4000795729920
> > >         backup_bytes_used:    1075454439424
> > >         backup_num_devices:    2
> > >
> > >     backup 3:
> > >         backup_tree_root:    1507234676736    gen: 8593    level: 1
> > >         backup_chunk_root:    1769556934656    gen: 8191    level: 1
> > >         backup_extent_root:    1507234725888    gen: 8593    level: 2
> > >         backup_fs_root:        1506503901184    gen: 7886    level: 0
> > >         backup_dev_root:    1507550887936    gen: 8473    level: 1
> > >         backup_csum_root:    1507297738752    gen: 8593    level: 2
> > >         backup_total_bytes:    4000795729920
> > >         backup_bytes_used:    1075454636032
> > >         backup_num_devices:    2
> > >
> > >
> > >
> > >>
> > >>> [ 4044.863400] BTRFS error (device sdc1): open_ctree failed
> > >>>
> > >>> Pretty much the same thing with other mount options, with same
> > >>> messages in dmesg.
> > >>>
> > >>> ~$ btrfs check --init-extent-tree /dev/sdc1
> > >>
> > >> Why you're doing so?! It's already mentioned --init-extent-tree is UNSAFE!
> > >
> > > Apologies, saw it somewhere and tried in some desperation. It ran and
> > > exited in just a second though so maybe didn't do anything.
> > >
> > >>
> > >>> warning, device 2 is missing
> > >>> Checking filesystem on /dev/sdc1
> > >>> UUID: 70a651ab-4837-4891-9099-a6c8a52aa40f
> > >>> Creating a new extent tree
> > >>> bytenr mismatch, want=1058577645568, have=0
> > >>> Error reading tree block
> > >>> error pinning down used bytes
> > >>> ERROR: attempt to start transaction over already running one
> > >>
> > >> Transaction get aborted, exactly the situation where fs can get further
> > >> corrupted.
> > >>
> > >> The only good news is, we shouldn't have written much data as it's
> > >> happening in tree pinning down process, so no further damage.
> > >
> > > Thanks, that's what I'm hoping!
> > >
> > >>
> > >>> extent buffer leak: start 1768503115776 len 16384
> > >>>
> > >>> ~$ btrfs rescue super-recover -v /dev/sdc1
> > >>> All Devices:
> > >>> Device: id = 1, name = /dev/sdc1
> > >>>
> > >>> Before Recovering:
> > >>> [All good supers]:
> > >>> device name = /dev/sdc1
> > >>> superblock bytenr = 65536
> > >>>
> > >>> device name = /dev/sdc1
> > >>> superblock bytenr = 67108864
> > >>>
> > >>> device name = /dev/sdc1
> > >>> superblock bytenr = 274877906944
> > >>>
> > >>> [All bad supers]:
> > >>>
> > >>> All supers are valid, no need to recover
> > >>>
> > >>>
> > >>> ~$ sudo btrfs restore -mxs /dev/sdc1 /mnt/ssd1/
> > >>> warning, device 2 is missing
> > >>> bytenr mismatch, want=1057828618240, have=0
> > >>> Could not open root, trying backup super
> > >>> warning, device 2 is missing
> > >>> bytenr mismatch, want=1057828618240, have=0
> > >>> Could not open root, trying backup super
> > >>> warning, device 2 is missing
> > >>> bytenr mismatch, want=1057828618240, have=0
> > >>> Could not open root, trying backup super
> > >>>
> > >>> ~$ btrfs check /dev/sdc1
> > >>> warning, device 2 is missing
> > >>> bytenr mismatch, want=1057828618240, have=0
> > >>> ERROR: cannot open file system
> > >>>
> > >>> ~$ btrfs rescue zero-log /dev/sdc1
> > >>> warning, device 2 is missing
> > >>> bytenr mismatch, want=1057828618240, have=0
> > >>> ERROR: could not open ctree
> > >>>
> > >>> I'm only interested in getting it read-only mounted so I can copy
> > >>> somewhere else. Any ideas you have are welcome!
> > >>
> > >> It looks like some metadata tree blocks are still not in RAID1 mode.
> > >> Needs that ins dump-super output to confirm.
> > >>
> > >> Thanks,
> > >> Qu
> > >>
> > >>>
> > >>> Many Thanks,
> > >>>
> > >>> Daniel Clarke
> > >>>
> > >>
> > >
> > > Thanks again,
> > >
> > > Dan
> > >
> >
