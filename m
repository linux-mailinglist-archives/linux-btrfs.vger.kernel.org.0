Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 37C8F130A42
	for <lists+linux-btrfs@lfdr.de>; Sun,  5 Jan 2020 23:28:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727145AbgAEW2a (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 5 Jan 2020 17:28:30 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:55703 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726851AbgAEW2a (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sun, 5 Jan 2020 17:28:30 -0500
Received: by mail-wm1-f66.google.com with SMTP id q9so13243786wmj.5
        for <linux-btrfs@vger.kernel.org>; Sun, 05 Jan 2020 14:28:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=7xKQVvOpxJX26Yw1QaTa16n4Xpjf5qUkn4xvs+eWTSU=;
        b=sJOE+lSCuCcKe7q9K3QwXvp/p2i7kg4Ygvee4iosWY3mrCzvtlWuHGTdAm0P59VeI3
         h7mSFDX/34PtHjKl8asXvo2khL0bT0zkHcMFLLv9i+zkGqBheT4SJ9UMb9235t9OQCmp
         fnqCUHo3cCMpccZ319R1zRP7ZI8sVJyRBW21YKCQes+P+SvApvO73ABn7TTSurcR5quo
         VAhHekEa7ZL4eG/qAejHEl9g7S9WOPv8N21vBgiQZkp9udljnMc5KumvDaehl+73qn/x
         ywnCh2GJGOCJcrTgujhvOXSe9jYubglD8V9OxZWRaq5vsFfyzOcQjTPJ/SrtzsGha6hg
         kMow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=7xKQVvOpxJX26Yw1QaTa16n4Xpjf5qUkn4xvs+eWTSU=;
        b=VcuB7fluQudxFGdmPF6NJ9wsNWjkVVjsnmNv+FGJqj6spbiXsTiF92TIRC8/l6nOc8
         MKvQbDs+nAOI0pvZGmwZIfGh4lr6G7kopqkV3Q77WYKClNBbIcvHp0coiDM2BHq92Xwd
         dMdn3Hks/ACUU41sHr9kAPlSuzLth7iIgEJGTe0pmfcROCJcdwh9BGGzfWwvnjbubIUV
         XtyQMvsvixsGF/JMQsPW8fPnRDURNHBSHVg4qfftFVGe/zYd3R28HIcGs3FAYcKz95X5
         KJpYLP5LviuWT+GVfjNhrznOacuxadF7FcBxMrDfBfFyaRFbLkQRECz7mgB2sldQKHMN
         SrIw==
X-Gm-Message-State: APjAAAVtyKte+VSBi0fTTymvuvuvZGynyivsHiy+ahx1bbVT4Ne2Zx/m
        fTvT0vM6cCR4g17JY7J6HuvuXnpKT3N7LU7+Pe1i+A==
X-Google-Smtp-Source: APXvYqxFCDY9CNOngwMQ6bMtznR5qmwA6Kb7RSHbFvDN8Bso46+kQmfPc6S4j2YG3eFGBy2Qa6U84RjvyS6lhGO0KA0=
X-Received: by 2002:a1c:770e:: with SMTP id t14mr33231449wmi.101.1578263307563;
 Sun, 05 Jan 2020 14:28:27 -0800 (PST)
MIME-Version: 1.0
References: <20191206034406.40167-1-wqu@suse.com> <2a220d44-fb44-66cf-9414-f1d0792a5d4f@oracle.com>
 <762365A0-8BDF-454B-ABA9-AB2F0C958106@icloud.com> <94a6d1b2-ae32-5564-22ee-6982e952b100@suse.com>
 <4C0C9689-3ECF-4DF7-9F7E-734B6484AA63@icloud.com> <f7fe057d-adc1-ace5-03b3-0f0e608d68a3@gmx.com>
 <9FB359ED-EAD4-41DD-B846-1422F2DC4242@icloud.com> <256D0504-6AEE-4A0E-9C62-CDF975FDE32D@icloud.com>
 <e04d1937-d70c-c891-4eea-c6fb70a45ab5@gmx.com> <8B00108E-4450-4448-8663-E5A5C0343E26@icloud.com>
 <CAJCQCtQAFRdutyVOt7JALtVsn-EeXhzNYYjdKpmS1Ts_6-6nMA@mail.gmail.com>
 <CC877460-A434-408F-B47D-5FAD0B03518C@icloud.com> <CAJCQCtS+a2WU01QCHXycLT8ktca-XV5JkO-KwtjRRzeEa4xikQ@mail.gmail.com>
 <3F43DDB8-0372-4CDE-B143-D2727D3447BC@icloud.com> <CAJCQCtRUQ3bz--5B7Gs9aGYdo6ybkJWQFy61ohWEc2y1BJ6XHA@mail.gmail.com>
 <938B37BF-E134-4F24-AC4F-93FECA6047FC@icloud.com> <CAJCQCtROKcVBNuWkyF5kRgJMuQ4g4YSxh5GL6QmuAJL=A-JROw@mail.gmail.com>
 <25D1F99C-F34A-48D6-BF62-42225765FBC1@icloud.com>
In-Reply-To: <25D1F99C-F34A-48D6-BF62-42225765FBC1@icloud.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Sun, 5 Jan 2020 15:28:11 -0700
Message-ID: <CAJCQCtQxN17UL7swO7vU6-ORVmHfQHteUQZ7iS1w7Y5XLHTpVA@mail.gmail.com>
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

On Sun, Jan 5, 2020 at 2:58 PM Christian Wimmer <telefonchris@icloud.com> w=
rote:
> > On 5. Jan 2020, at 18:13, Chris Murphy <lists@colorremedies.com> wrote:
> >
> > On Sun, Jan 5, 2020 at 1:36 PM Christian Wimmer <telefonchris@icloud.co=
m> wrote:
> >>
> >>
> >>
> >>> On 5. Jan 2020, at 17:30, Chris Murphy <lists@colorremedies.com> wrot=
e:
> >>>
> >>> On Sun, Jan 5, 2020 at 12:48 PM Christian Wimmer
> >>> <telefonchris@icloud.com> wrote:
> >>>>
> >>>>
> >>>> #fdisk -l
> >>>> Disk /dev/sda: 256 GiB, 274877906944 bytes, 536870912 sectors
> >>>> Disk model: Suse 15.1-0 SSD
> >>>> Units: sectors of 1 * 512 =3D 512 bytes
> >>>> Sector size (logical/physical): 512 bytes / 4096 bytes
> >>>> I/O size (minimum/optimal): 4096 bytes / 4096 bytes
> >>>> Disklabel type: gpt
> >>>> Disk identifier: 186C0CD6-F3B8-471C-B2AF-AE3D325EC215
> >>>>
> >>>> Device         Start       End   Sectors  Size Type
> >>>> /dev/sda1       2048     18431     16384    8M BIOS boot
> >>>> /dev/sda2      18432 419448831 419430400  200G Linux filesystem
> >>>> /dev/sda3  532674560 536870878   4196319    2G Linux swap
> >>>
> >>>
> >>>
> >>>> btrfs insp dump-s /dev/sda2
> >>>>
> >>>>
> >>>> Here I have only btrfs-progs version 4.19.1:
> >>>>
> >>>> linux-ze6w:~ # btrfs version
> >>>> btrfs-progs v4.19.1
> >>>> linux-ze6w:~ # btrfs insp dump-s /dev/sda2
> >>>> superblock: bytenr=3D65536, device=3D/dev/sda2
> >>>> ---------------------------------------------------------
> >>>> csum_type               0 (crc32c)
> >>>> csum_size               4
> >>>> csum                    0x6d9388e2 [match]
> >>>> bytenr                  65536
> >>>> flags                   0x1
> >>>>                       ( WRITTEN )
> >>>> magic                   _BHRfS_M [match]
> >>>> fsid                    affdbdfa-7b54-4888-b6e9-951da79540a3
> >>>> metadata_uuid           affdbdfa-7b54-4888-b6e9-951da79540a3
> >>>> label
> >>>> generation              799183
> >>>> root                    724205568
> >>>> sys_array_size          97
> >>>> chunk_root_generation   797617
> >>>> root_level              1
> >>>> chunk_root              158835163136
> >>>> chunk_root_level        0
> >>>> log_root                0
> >>>> log_root_transid        0
> >>>> log_root_level          0
> >>>> total_bytes             272719937536
> >>>> bytes_used              106188886016
> >>>> sectorsize              4096
> >>>> nodesize                16384
> >>>> leafsize (deprecated)           16384
> >>>> stripesize              4096
> >>>> root_dir                6
> >>>> num_devices             1
> >>>> compat_flags            0x0
> >>>> compat_ro_flags         0x0
> >>>> incompat_flags          0x163
> >>>>                       ( MIXED_BACKREF |
> >>>>                         DEFAULT_SUBVOL |
> >>>>                         BIG_METADATA |
> >>>>                         EXTENDED_IREF |
> >>>>                         SKINNY_METADATA )
> >>>> cache_generation        799183
> >>>> uuid_tree_generation    557352
> >>>> dev_item.uuid           8968cd08-0c45-4aff-ab64-65f979b21694
> >>>> dev_item.fsid           affdbdfa-7b54-4888-b6e9-951da79540a3 [match]
> >>>> dev_item.type           0
> >>>> dev_item.total_bytes    272719937536
> >>>> dev_item.bytes_used     129973092352
> >>>> dev_item.io_align       4096
> >>>> dev_item.io_width       4096
> >>>> dev_item.sector_size    4096
> >>>> dev_item.devid          1
> >>>> dev_item.dev_group      0
> >>>> dev_item.seek_speed     0
> >>>> dev_item.bandwidth      0
> >>>> dev_item.generation     0
> >>>
> >>> Partition map says
> >>>> /dev/sda2      18432 419448831 419430400  200G Linux filesystem
> >>>
> >>> Btrfs super says
> >>>> total_bytes             272719937536
> >>>
> >>> 272719937536*512=3D532656128
> >>>
> >>> Kernel FITRIM want is want=3D532656128
> >>>
> >>> OK so the problem is the Btrfs super isn't set to the size of the
> >>> partition. The usual way this happens is user error: partition is
> >>> resized (shrink) without resizing the file system first. This file
> >>> system is still at risk of having problems even if you disable
> >>> fstrim.timer. You need to shrink the file system is the same size as
> >>> the partition.
> >>>
> >>
> >> Could this be a problem of Parallels Virtual machine that maybe someti=
mes try to get more space on the hosting file system?
> >> One solution would be to have a fixed size of the disc file instead of=
 a growing one.
> >
> > I don't see how it's related. Parallels has no ability I'm aware of to
> > change the GPT partition map or the Btrfs super block - as in, rewrite
> > it out with a modification correctly including all checksums being
> > valid. This /dev/sda has somehow been mangled on purpose.
> >
> > Again, from the GPT
> >>>> /dev/sda2      18432 419448831 419430400  200G Linux filesystem
> >>>> /dev/sda3  532674560 536870878   4196319    2G Linux swap
> >
> > The end LBA for sda2 is 419448831, but the start LBA for sda3 is
> > 532674560. There's a ~54G gap in there as if something was removed.
> > I'm not sure why a software installer would produce this kind of
> > layout on purpose, because it has no purpose.
> >
> >
>
> Ok, understand. Very strange. Maybe we should forget about this particula=
r problem.
> Should I repair it somehow? And if yes, how?


> >>>> /dev/sda2      18432 419448831 419430400  200G Linux filesystem

delete this partition, recreate a new one with the same start LBA,
18432 and a new end LBA that matches the actual fs size:

18432+(272719937536/512)=3D532674560

write it and reboot the VM. You could instead resize Btrfs to match
the partition but that might piss off the kernel if Btrfs thinks it
needs to move block groups from a location outside the partition. So I
would just resize the partition. And then you need to do a scrub and a
btrfs check on this volume to see if it's damaged.

I don't know but I suspect it could be possible that this malformed
root might have resulted in a significant instability of the system at
some point, and in it's last states of confusion as it face planted,
wrote out very spurious data causing your broken Btrfs file system. I
can't prove that.






>
> >
> >
> >
> >>
> >>>
> >>>
> >>>> linux-ze6w:~ # systemctl status fstrim.timer
> >>>> =E2=97=8F fstrim.timer - Discard unused blocks once a week
> >>>>  Loaded: loaded (/usr/lib/systemd/system/fstrim.timer; enabled; vend=
or preset: enabled)
> >>>>  Active: active (waiting) since Sun 2020-01-05 15:24:59 -03; 1h 19mi=
n ago
> >>>> Trigger: Mon 2020-01-06 00:00:00 -03; 7h left
> >>>>    Docs: man:fstrim
> >>>>
> >>>> Jan 05 15:24:59 linux-ze6w systemd[1]: Started Discard unused blocks=
 once a week.
> >>>>
> >>>> linux-ze6w:~ # systemctl status fstrim.service
> >>>> =E2=97=8F fstrim.service - Discard unused blocks on filesystems from=
 /etc/fstab
> >>>>  Loaded: loaded (/usr/lib/systemd/system/fstrim.service; static; ven=
dor preset: disabled)
> >>>>  Active: inactive (dead)
> >>>>    Docs: man:fstrim(8)
> >>>> linux-ze6w:~ #
> >>>
> >>> OK so it's not set to run. Why do you have FITRIM being called?
> >>
> >> No idea.
> >
> > Well you're going to have to find it. I can't do that for you.
>
>
> Ok, I will have a look. Can I simply deactivate the service?

fstrim.service is a one shot. The usual method of it being activated
once per week is via fstrim.timer - but your status check of
fstrim.timer says it's disabled. So something else is running fstrim.
I have no idea what it is, you have to find it in order to deactivate
it.

This 12T file system is a single "device" backed by a 12T file on the
Promise drive? And it's a Parallel's formatted VM file? I guess I
would have used raw instead of a Parallels format. That way you can
inspect things from outside the VM. But that's perhaps a minor point.
Check that this 12T (virtual) physical block device inside the guest
has the exact correct size you expect. The partition start and end are
correct, and that this partition's size matches that of the Btrfs
super total_bytes or dev_item.total_bytes. Those two should be the
same if it's a single device Btrfs file system.

Something still doesn't pass the smell test so it's not at all clear
this is an fstrim bug and not some other file system vs device resize
problem.

--=20
Chris Murphy
