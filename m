Return-Path: <linux-btrfs+bounces-3681-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC7BA88F01D
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Mar 2024 21:30:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 44C05B2663D
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Mar 2024 20:30:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E849D152E1C;
	Wed, 27 Mar 2024 20:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=d.umn.edu header.i=@d.umn.edu header.b="doTJat+a"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mta-p6.oit.umn.edu (mta-p6.oit.umn.edu [134.84.196.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B692528366
	for <linux-btrfs@vger.kernel.org>; Wed, 27 Mar 2024 20:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.84.196.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711571435; cv=none; b=hZRtfXgEPYdM045UjmkvJRMQzFxxo6Z/Yd3Y3zvuyH9xvI6kmfV9ERAX5thQPnPkqxZuHCuDa67Pjzf42l5bX1mE2p6eVDRsdvnDJ0fUYRXj1u0V1Xn55s7uA5enRGbP+8AH2RapOzyOJkVlLZNCvit8Y2NWtkcO3PX0QVkNR9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711571435; c=relaxed/simple;
	bh=W4DaU4ojL2zd2ZVVHnc5/jG2wKt48mgyh7ShENLXD9Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pDM2whSiB97laxkOBojaWQ6dUxeifXHMZGxlIIOfDPat0NIenZzs5pbE+1P451Cc+Wm6VX8arUkfChg+9bS3Vq4/R6Ur+eTRSsvTS2iaS8bhKSM8CGsrF1Eb4Mjyd8HYoP22p5r2e2TLcAxSDjmiGwe1+lGWb8MWZKmdXJDuF/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=d.umn.edu; spf=pass smtp.mailfrom=d.umn.edu; dkim=pass (2048-bit key) header.d=d.umn.edu header.i=@d.umn.edu header.b=doTJat+a; arc=none smtp.client-ip=134.84.196.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=d.umn.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=d.umn.edu
Received: from localhost (unknown [127.0.0.1])
	by mta-p6.oit.umn.edu (Postfix) with ESMTP id 4V4dPT3FJWz9xgkh
	for <linux-btrfs@vger.kernel.org>; Wed, 27 Mar 2024 20:22:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p6.oit.umn.edu ([127.0.0.1])
	by localhost (mta-p6.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lwOumEa4nlsU for <linux-btrfs@vger.kernel.org>;
	Wed, 27 Mar 2024 15:22:05 -0500 (CDT)
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mta-p6.oit.umn.edu (Postfix) with ESMTPS id 4V4dPT0kVPz9xgks
	for <linux-btrfs@vger.kernel.org>; Wed, 27 Mar 2024 15:22:05 -0500 (CDT)
DMARC-Filter: OpenDMARC Filter v1.3.2 mta-p6.oit.umn.edu 4V4dPT0kVPz9xgks
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-p6.oit.umn.edu 4V4dPT0kVPz9xgks
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-5d8df7c5500so128402a12.2
        for <linux-btrfs@vger.kernel.org>; Wed, 27 Mar 2024 13:22:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=d.umn.edu; s=google; t=1711570924; x=1712175724; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YhuRO176jZi7M0wkcIU4DQVyPWuTw+7fIPLajSVwdeM=;
        b=doTJat+aIcey98yuD8BI0GvkXbZsQA5kf1PjszSGs4eddlqpbyWLiuk2mFec9l1AuN
         UbfpMYwHIB6FLR8W66pz6GtaxXjBBO60FuI5D44yXA6rjLWpAYkTN52JhaUh8Y4rxbbu
         aEXaJNjv/dQ9cZmB1yyFYP6w9ugsKNxfzHVSqEF6PxPueold6Kvcuiv4EC9R6xOjiBB+
         vIBMQF+zGm3xs+rUkHRa5ZHOwJHuppppLIq3Yntqc4dMbA9Wj5MjDma3vdIG56FXTk8O
         qagJKp4z3EILWmQ7DfW2NuxAUB1nz3JPBT4BruSkcqq1fwOLQrXXzAamoP80TOpMIpC5
         xVfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711570924; x=1712175724;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YhuRO176jZi7M0wkcIU4DQVyPWuTw+7fIPLajSVwdeM=;
        b=VscH5hcXzlxu3x5p9c9kzRGe81WEDZk5Zz0UBF4FLBonBauXaiaZLYnscvPu65x1KU
         ddu5/gQt7OsEylwqu9GMd1J2QfnjYRQTNiX/gZCFwZIebUxPzAQWoSIp7qIUnC+00zk5
         dkjFzb/I7eBSdzF3iOxzyqdrLoiZKRmz+p8aT8dw6f9i4k/RDIBjGY7W1s4weDgJqjPe
         tAXB4HyxE4nagawSKLfqlNjvIJzdfmmZMIigncBbVZ2v9i79RewBmOAoBNm9eqgZbPRw
         Zb2Mtvmv+Mod7DkS5gUNjCzLvSBDv3wqXqBZKpd8OSBfXC5Phe6SrtsO1fo6OaDMuChS
         Nq0w==
X-Gm-Message-State: AOJu0Yw0FGQe1vB3MdSKhDSWfTd5nnOtKLn3kSBsJnbeEF1AE3tHXhe0
	H5NXmgHnEuhL5df3ONIGQkRYOEFEtDuQfg4Gek5aA8wBh0Ta4u/JNtRgRDMhH0AfwOyKCK8JiIL
	8y20YcxsQKq0K1Guxd08SYTyDeYh2vcUnb+MVPd0cS4hA5/qSckHTfO1W35wcv+aat/MBi6mkkk
	wZZD8Q/k5d/XjvM7WS4gXQbuUPtwv55+kAfX43Rh4B7CnuCSSn
X-Received: by 2002:a17:90a:d70b:b0:2a1:ff27:3fa3 with SMTP id y11-20020a17090ad70b00b002a1ff273fa3mr296076pju.28.1711570923985;
        Wed, 27 Mar 2024 13:22:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHqHw7oSKlmwwgoWzmnbcXxghC0YeEA1nVTw6fyOm0mhEQYfLA2BZv22+BeWes0/NcecOyM30SuDdDTzKtSPQk=
X-Received: by 2002:a17:90a:d70b:b0:2a1:ff27:3fa3 with SMTP id
 y11-20020a17090ad70b00b002a1ff273fa3mr296061pju.28.1711570923627; Wed, 27 Mar
 2024 13:22:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAOLfK3UccL8z7Xf_KSp=foS6hM8Byf5n_21uwO96=9ND=-j84A@mail.gmail.com>
 <CA+H1V9x-pFAM-YQ1ncAqZE4e7j6R2xQXX6Ah9v1tMNf8CrW+yw@mail.gmail.com>
 <CAOLfK3We92ZBrvyvSDky9jrQwJNONeOE9qoaewbFCr02H8PuTw@mail.gmail.com>
 <CA+H1V9xjufQpsZHeMNmKNrV0BfuUsJ5G=x_-BEcRw7eNFhYPAw@mail.gmail.com>
 <CAOLfK3UEOMN-O9-u6j22CJ0jpRZUwB7R_x-zEH6-FXdgmqB7Lg@mail.gmail.com> <1eac6d15-4ead-46bc-9b60-02f1d120c885@tnonline.net>
In-Reply-To: <1eac6d15-4ead-46bc-9b60-02f1d120c885@tnonline.net>
From: Matt Zagrabelny <mzagrabe@d.umn.edu>
Date: Wed, 27 Mar 2024 15:21:51 -0500
Message-ID: <CAOLfK3UuMNn1Q2t-seqcOXu4xVbWQU4rOSVkY2qn4RsyOcBCAA@mail.gmail.com>
Subject: Re: raid1 root device with efi
To: Forza <forza@tnonline.net>
Cc: Btrfs BTRFS <linux-btrfs@vger.kernel.org>, 
	Matthew Warren <matthewwarren101010@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Forza and others,

On Sun, Mar 10, 2024 at 1:20=E2=80=AFPM Forza <forza@tnonline.net> wrote:
>
>
>
> On 2024-03-08 22:58, Matt Zagrabelny wrote:
> > On Fri, Mar 8, 2024 at 3:54=E2=80=AFPM Matthew Warren
> > <matthewwarren101010@gmail.com> wrote:
> >>
> >> On Fri, Mar 8, 2024 at 4:48=E2=80=AFPM Matt Zagrabelny <mzagrabe@d.umn=
.edu> wrote:
> >>>
> >>> Hi Qu and Matthew,
> >>>
> >>> On Fri, Mar 8, 2024 at 3:46=E2=80=AFPM Matthew Warren
> >>> <matthewwarren101010@gmail.com> wrote:
> >>>>
> >>>> On Fri, Mar 8, 2024 at 3:46=E2=80=AFPM Matt Zagrabelny <mzagrabe@d.u=
mn.edu> wrote:
> >>>>>
> >>>>> Greetings,
> >>>>>
> >>>>> I've read some conflicting info online about the best way to have a
> >>>>> raid1 btrfs root device.
> >>>>>
> >>>>> I've got two disks, with identical partitioning and I tried the
> >>>>> following scenario (call it scenario 1):
> >>>>>
> >>>>> partition 1: EFI
> >>>>> partition 2: btrfs RAID1 (/)
> >>>>>
> >>>>> There are some docs that claim that the above is possible...
> >>>>
> >>>> This is definitely possible. I use it on both my server and desktop =
with GRUB.
> >>>
> >>> Are there any docs you follow for this setup?
> >>>
> >>> Thanks for the info!
> >>>
> >>> -m
> >>
> >> The main important thing is that mdadm has several metadata versions.
> >> Versions 0.9 and 1.0 store the metadata at the end of the partition
> >> which allows UEFI to think the filesystem is EFI rather than mdadm
> >> raid.
> >> https://raid.wiki.kernel.org/index.php/RAID_superblock_formats#Sub-ver=
sions_of_the_version-1_superblock
> >>
> >> I followed the arch wiki for setting it up, so here's what I followed.
> >> https://wiki.archlinux.org/title/EFI_system_partition#ESP_on_software_=
RAID1
> >
> > Thanks for the hints. Hopefully there aren't any more unexpected issues=
.
> >
> > Cheers!
> >
> > -m
> >
>
> An alternative to mdadm is to simply have separate ESP partitions on
> each device. You can manually copy the contents between the two if you
> were to update the EFI bootloader. This way you can keep the 'other' ESP
> as backup during GRUB/EFI updates.
>
> This solution is what I use on one of my servers. GRUB2 supports Btrfs
> RAID1 so you do not need to have the kernel and initramfs on the ESP,
> though that works very well too.

Are folks using the "degraded" option in /etc/fstab or the grub mount
options for the btrfs mount?

I've read online [0] that the degraded option can cause issues due to
timeouts being exceeded.

Also, I'm seeing some confusing results of looking at the UUID of my disks:

root@achilles:~# blkid | grep /dev/sd
/dev/sdb2: UUID=3D"9a46a8ad-de37-48c0-ad96-2c54df42dd5a"
UUID_SUB=3D"7737fc5f-036d-4126-9d7c-f1726d550444" BLOCK_SIZE=3D"4096"
TYPE=3D"btrfs" PARTUUID=3D"3a22621c-a4e1-8641-aa0f-990a824fabf4"
/dev/sdb1: UUID=3D"BD42-AEB1" BLOCK_SIZE=3D"512" TYPE=3D"vfat"
PARTUUID=3D"43e432b1-6c68-4b5c-9c30-793fcc10a700"
/dev/sda2: UUID=3D"9a46a8ad-de37-48c0-ad96-2c54df42dd5a"
UUID_SUB=3D"9436f570-6d15-4c74-aff8-5bd85995d92d" BLOCK_SIZE=3D"4096"
TYPE=3D"btrfs" PARTUUID=3D"e3b4b268-99e8-4043-a879-acfc8318232b"
/dev/sda1: UUID=3D"BD42-AEB1" BLOCK_SIZE=3D"512" TYPE=3D"vfat"
PARTUUID=3D"02568ee9-db21-4d03-a898-3d1a106ecbec"

...why does /dev/sdb2 show up in the following /dev/disk/by-uuid, but
not /dev/sda2:

root@achilles:~# ls -alh /dev/disk/by-uuid/
total 0
drwxr-xr-x 2 root root  80 Mar 25 21:16 .
drwxr-xr-x 7 root root 140 Mar 25 21:16 ..
lrwxrwxrwx 1 root root  10 Mar 25 21:16
9a46a8ad-de37-48c0-ad96-2c54df42dd5a -> ../../sdb2
lrwxrwxrwx 1 root root  10 Mar 25 21:16 BD42-AEB1 -> ../../sda1

What do folks think about the following fstab?

root@achilles:~# cat /etc/fstab
# /etc/fstab: static file system information.
#
# Use 'blkid' to print the universally unique identifier for a
# device; this may be used with UUID=3D as a more robust way to name device=
s
# that works even if disks are added and removed. See fstab(5).
#
# systemd generates mount units based on this file, see systemd.mount(5).
# Please run 'systemctl daemon-reload' after making changes here.
#
# <file system>                           <mount point>   <type>
<options>                      <dump>  <pass>
# / was on /dev/sda2 during installation
UUID=3D9a46a8ad-de37-48c0-ad96-2c54df42dd5a /               btrfs
defaults,degraded,subvol=3D@     0       0
UUID=3D9a46a8ad-de37-48c0-ad96-2c54df42dd5a /home           btrfs
defaults,degraded,subvol=3D@home 0       0
# /boot/efi was on /dev/sda1 during installation
UUID=3DBD42-AEB1                            /boot/efi       vfat
umask=3D0077                     0       1

Some extra info, in case it is useful...

root@achilles:~# mount | grep /dev/sd
/dev/sda2 on / type btrfs
(rw,relatime,degraded,ssd,space_cache=3Dv2,subvolid=3D256,subvol=3D/@)
/dev/sda2 on /home type btrfs
(rw,relatime,degraded,ssd,space_cache=3Dv2,subvolid=3D257,subvol=3D/@home)
/dev/sda1 on /boot/efi type vfat
(rw,relatime,fmask=3D0077,dmask=3D0077,codepage=3D437,iocharset=3Dascii,sho=
rtname=3Dmixed,utf8,errors=3Dremount-ro)


root@achilles:~# btrfs device usage /
/dev/sda2, ID: 1
   Device size:           237.97GiB
   Device slack:              0.00B
   Data,RAID1:              2.00GiB
   Metadata,RAID1:          1.00GiB
   System,RAID1:           32.00MiB
   Unallocated:           234.94GiB

/dev/sdb2, ID: 2
   Device size:           237.97GiB
   Device slack:              0.00B
   Data,RAID1:              2.00GiB
   Metadata,RAID1:          1.00GiB
   System,RAID1:           32.00MiB
   Unallocated:           234.94GiB



Thanks for any help and/or advice!

-m


[0] https://www.reddit.com/r/btrfs/comments/kguqsg/degraded_boot_with_syste=
md/

