Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 856721309F5
	for <lists+linux-btrfs@lfdr.de>; Sun,  5 Jan 2020 22:17:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726823AbgAEVOD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 5 Jan 2020 16:14:03 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:42877 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726792AbgAEVOC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sun, 5 Jan 2020 16:14:02 -0500
Received: by mail-wr1-f66.google.com with SMTP id q6so47503157wro.9
        for <linux-btrfs@vger.kernel.org>; Sun, 05 Jan 2020 13:14:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=WVrSDmqMOXmsI+zhyrJg2y7P1y5URhHnJTkIhU8HV3Q=;
        b=A7d82QOf7kNqoAyALYXws8IC4lAfYzNueJbFaQp0MnEGbeoeZE6sWv9i3jbymXt+br
         lJ6Ukwgy0vIp6WzgbSNeOvPi2aayncB6F1zp7MMlEx0CMjMgxQww9KhSR9fj4wZa9bZa
         3U3DAb2Tm4mvAvUNMQlTi+dQ6bQ1sewQ2IqRxxW2l9vRhpm8O9WQEibq6aGD1oh8Rf3s
         4FVG2C/4LJn3NcQ5eZInDMr7xLiEiXyuYZud56CDnR4DGifeUHtq6HOcmeaIIEax+ElY
         /fcpYw6rlU+GRvf8MQ4a88qCrcbNJbmxuMnG4RBB87qv8wB8G+loTGWAO1orIGOmrUUC
         dn/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=WVrSDmqMOXmsI+zhyrJg2y7P1y5URhHnJTkIhU8HV3Q=;
        b=qD/zIsvNpOB7tLssIepgz9nqJgCvLVgfq+b18hGDuq0WrgumPjaUpWoJXHNV5rbVO9
         JD9vZ+WQQIUglRiawTl77JiMFT/Pd9x4l/9xIGP3Mqd6/XMBigbDepeVRly+F+jQyWdF
         awQTNeMUCLin3gnRPV0/efgKD77Qjx1amexcegoSbZMHx+jVbdOktjVyXadtERB830Og
         cpQf4R/aUv/VRUXXPB6IewvH0KT7c40dKTdrMixj4y4k5aMCsZtdzjvNfbMBtvrV1bF5
         BtojBxSxfD/8d9t0K8YMv/Aal+ChfdBA3tvF1BKGKmlcm4gGneML5B5VDhkgXKr0u5gL
         BdAg==
X-Gm-Message-State: APjAAAVZ9l2qnTe293acScaY+VuWcBg9bj8L326RKUZzTDJa1O+1WUKx
        R/96I2afvuyMSLtqe9fnsOHQD3buMNDtMaPI3ZdNrw==
X-Google-Smtp-Source: APXvYqxSGc3PUbPNMXr2qpY9H1Mk4VNVFaEN2mhck6Cj4BYbpob/cqJUdE0kf0/UaVyFIY4u/OqCg7Q8H+BLYPPZ4qk=
X-Received: by 2002:adf:f6c8:: with SMTP id y8mr99205651wrp.167.1578258839755;
 Sun, 05 Jan 2020 13:13:59 -0800 (PST)
MIME-Version: 1.0
References: <20191206034406.40167-1-wqu@suse.com> <2a220d44-fb44-66cf-9414-f1d0792a5d4f@oracle.com>
 <762365A0-8BDF-454B-ABA9-AB2F0C958106@icloud.com> <94a6d1b2-ae32-5564-22ee-6982e952b100@suse.com>
 <4C0C9689-3ECF-4DF7-9F7E-734B6484AA63@icloud.com> <f7fe057d-adc1-ace5-03b3-0f0e608d68a3@gmx.com>
 <9FB359ED-EAD4-41DD-B846-1422F2DC4242@icloud.com> <256D0504-6AEE-4A0E-9C62-CDF975FDE32D@icloud.com>
 <e04d1937-d70c-c891-4eea-c6fb70a45ab5@gmx.com> <8B00108E-4450-4448-8663-E5A5C0343E26@icloud.com>
 <CAJCQCtQAFRdutyVOt7JALtVsn-EeXhzNYYjdKpmS1Ts_6-6nMA@mail.gmail.com>
 <CC877460-A434-408F-B47D-5FAD0B03518C@icloud.com> <CAJCQCtS+a2WU01QCHXycLT8ktca-XV5JkO-KwtjRRzeEa4xikQ@mail.gmail.com>
 <3F43DDB8-0372-4CDE-B143-D2727D3447BC@icloud.com> <CAJCQCtRUQ3bz--5B7Gs9aGYdo6ybkJWQFy61ohWEc2y1BJ6XHA@mail.gmail.com>
 <938B37BF-E134-4F24-AC4F-93FECA6047FC@icloud.com>
In-Reply-To: <938B37BF-E134-4F24-AC4F-93FECA6047FC@icloud.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Sun, 5 Jan 2020 14:13:43 -0700
Message-ID: <CAJCQCtROKcVBNuWkyF5kRgJMuQ4g4YSxh5GL6QmuAJL=A-JROw@mail.gmail.com>
Subject: Re: 12 TB btrfs file system on virtual machine broke again
To:     Christian Wimmer <telefonchris@icloud.com>
Cc:     Chris Murphy <lists@colorremedies.com>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>, Qu WenRuo <wqu@suse.com>,
        Anand Jain <anand.jain@oracle.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, Jan 5, 2020 at 1:36 PM Christian Wimmer <telefonchris@icloud.com> w=
rote:
>
>
>
> > On 5. Jan 2020, at 17:30, Chris Murphy <lists@colorremedies.com> wrote:
> >
> > On Sun, Jan 5, 2020 at 12:48 PM Christian Wimmer
> > <telefonchris@icloud.com> wrote:
> >>
> >>
> >> #fdisk -l
> >> Disk /dev/sda: 256 GiB, 274877906944 bytes, 536870912 sectors
> >> Disk model: Suse 15.1-0 SSD
> >> Units: sectors of 1 * 512 =3D 512 bytes
> >> Sector size (logical/physical): 512 bytes / 4096 bytes
> >> I/O size (minimum/optimal): 4096 bytes / 4096 bytes
> >> Disklabel type: gpt
> >> Disk identifier: 186C0CD6-F3B8-471C-B2AF-AE3D325EC215
> >>
> >> Device         Start       End   Sectors  Size Type
> >> /dev/sda1       2048     18431     16384    8M BIOS boot
> >> /dev/sda2      18432 419448831 419430400  200G Linux filesystem
> >> /dev/sda3  532674560 536870878   4196319    2G Linux swap
> >
> >
> >
> >> btrfs insp dump-s /dev/sda2
> >>
> >>
> >> Here I have only btrfs-progs version 4.19.1:
> >>
> >> linux-ze6w:~ # btrfs version
> >> btrfs-progs v4.19.1
> >> linux-ze6w:~ # btrfs insp dump-s /dev/sda2
> >> superblock: bytenr=3D65536, device=3D/dev/sda2
> >> ---------------------------------------------------------
> >> csum_type               0 (crc32c)
> >> csum_size               4
> >> csum                    0x6d9388e2 [match]
> >> bytenr                  65536
> >> flags                   0x1
> >>                        ( WRITTEN )
> >> magic                   _BHRfS_M [match]
> >> fsid                    affdbdfa-7b54-4888-b6e9-951da79540a3
> >> metadata_uuid           affdbdfa-7b54-4888-b6e9-951da79540a3
> >> label
> >> generation              799183
> >> root                    724205568
> >> sys_array_size          97
> >> chunk_root_generation   797617
> >> root_level              1
> >> chunk_root              158835163136
> >> chunk_root_level        0
> >> log_root                0
> >> log_root_transid        0
> >> log_root_level          0
> >> total_bytes             272719937536
> >> bytes_used              106188886016
> >> sectorsize              4096
> >> nodesize                16384
> >> leafsize (deprecated)           16384
> >> stripesize              4096
> >> root_dir                6
> >> num_devices             1
> >> compat_flags            0x0
> >> compat_ro_flags         0x0
> >> incompat_flags          0x163
> >>                        ( MIXED_BACKREF |
> >>                          DEFAULT_SUBVOL |
> >>                          BIG_METADATA |
> >>                          EXTENDED_IREF |
> >>                          SKINNY_METADATA )
> >> cache_generation        799183
> >> uuid_tree_generation    557352
> >> dev_item.uuid           8968cd08-0c45-4aff-ab64-65f979b21694
> >> dev_item.fsid           affdbdfa-7b54-4888-b6e9-951da79540a3 [match]
> >> dev_item.type           0
> >> dev_item.total_bytes    272719937536
> >> dev_item.bytes_used     129973092352
> >> dev_item.io_align       4096
> >> dev_item.io_width       4096
> >> dev_item.sector_size    4096
> >> dev_item.devid          1
> >> dev_item.dev_group      0
> >> dev_item.seek_speed     0
> >> dev_item.bandwidth      0
> >> dev_item.generation     0
> >
> > Partition map says
> >> /dev/sda2      18432 419448831 419430400  200G Linux filesystem
> >
> > Btrfs super says
> >> total_bytes             272719937536
> >
> > 272719937536*512=3D532656128
> >
> > Kernel FITRIM want is want=3D532656128
> >
> > OK so the problem is the Btrfs super isn't set to the size of the
> > partition. The usual way this happens is user error: partition is
> > resized (shrink) without resizing the file system first. This file
> > system is still at risk of having problems even if you disable
> > fstrim.timer. You need to shrink the file system is the same size as
> > the partition.
> >
>
> Could this be a problem of Parallels Virtual machine that maybe sometimes=
 try to get more space on the hosting file system?
> One solution would be to have a fixed size of the disc file instead of a =
growing one.

I don't see how it's related. Parallels has no ability I'm aware of to
change the GPT partition map or the Btrfs super block - as in, rewrite
it out with a modification correctly including all checksums being
valid. This /dev/sda has somehow been mangled on purpose.

Again, from the GPT
> >> /dev/sda2      18432 419448831 419430400  200G Linux filesystem
> >> /dev/sda3  532674560 536870878   4196319    2G Linux swap

The end LBA for sda2 is 419448831, but the start LBA for sda3 is
532674560. There's a ~54G gap in there as if something was removed.
I'm not sure why a software installer would produce this kind of
layout on purpose, because it has no purpose.





>
> >
> >
> >> linux-ze6w:~ # systemctl status fstrim.timer
> >> =E2=97=8F fstrim.timer - Discard unused blocks once a week
> >>   Loaded: loaded (/usr/lib/systemd/system/fstrim.timer; enabled; vendo=
r preset: enabled)
> >>   Active: active (waiting) since Sun 2020-01-05 15:24:59 -03; 1h 19min=
 ago
> >>  Trigger: Mon 2020-01-06 00:00:00 -03; 7h left
> >>     Docs: man:fstrim
> >>
> >> Jan 05 15:24:59 linux-ze6w systemd[1]: Started Discard unused blocks o=
nce a week.
> >>
> >> linux-ze6w:~ # systemctl status fstrim.service
> >> =E2=97=8F fstrim.service - Discard unused blocks on filesystems from /=
etc/fstab
> >>   Loaded: loaded (/usr/lib/systemd/system/fstrim.service; static; vend=
or preset: disabled)
> >>   Active: inactive (dead)
> >>     Docs: man:fstrim(8)
> >> linux-ze6w:~ #
> >
> > OK so it's not set to run. Why do you have FITRIM being called?
>
> No idea.

Well you're going to have to find it. I can't do that for you.



>
> >
> > What are the mount options for this file system?
>
> should have been mounted like:
>
> UUID=3Dbb34b1db-ee47-4367-b207-1de1671087e7  /home/promise2          btrf=
s  defaults                      0  0
>
> /dev/sdc1 on /home/promise2 type btrfs (rw,relatime,space_cache,subvolid=
=3D5,subvol=3D/)

No discard option. So you need to find out what's calling fstrim. And
then stop using it and see if the problem goes away.


--=20
Chris Murphy
