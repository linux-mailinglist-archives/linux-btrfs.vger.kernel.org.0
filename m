Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5F4B519878B
	for <lists+linux-btrfs@lfdr.de>; Tue, 31 Mar 2020 00:44:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728987AbgC3WoS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 30 Mar 2020 18:44:18 -0400
Received: from mail-wm1-f51.google.com ([209.85.128.51]:36807 "EHLO
        mail-wm1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728876AbgC3WoR (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 30 Mar 2020 18:44:17 -0400
Received: by mail-wm1-f51.google.com with SMTP id g62so599041wme.1
        for <linux-btrfs@vger.kernel.org>; Mon, 30 Mar 2020 15:44:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=AHkmID5MF0aA8+00m5TkESML1WXZA/hbgzjzjuf/s/w=;
        b=FZ7VsjE7Hw/BJM73wi1E4XXyvU+UpBrNHCqfADz+QZL7IJg8qI3MfLWlOn5FoElBet
         B/EegCmwHJmtqiPIfeNnjjg0zRVd9rPBK7Jji4Suxbzh6j7okEywGNsmPXW8cpbgHjgg
         nl+dJrzPbZfsXiY7E72HrU/1ibshWXsbhVUqxkKGw1usV1KlaNKLaI9mVqYZk84sfBIb
         tP9h1ozU8eEOIjlyxmh2f9uDa5gHQGzHcqJ++jNMKCuLwTdZx2cCSAy6jyCVyK6XzeTb
         d66DMNZtxZbWCpfumAbxyq9uQ9Q6onEvkIBMqJdSCW70Qz+/m5/ysGbTOT+3sejp23oN
         +e5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=AHkmID5MF0aA8+00m5TkESML1WXZA/hbgzjzjuf/s/w=;
        b=g/9OzpKMccgj64gM3qP7nhyi2vjaqKEbn0dfGUIr0KQfKHnfUPr3iRg+gDC81sfxne
         niA8S/zcKQxXZlEpFeQvZBpl/gfWRDesj/r7kVuusu0yANxR0cACqxxEDd/dab76RDyN
         TdOwvnkKfR2LLSEshWJz9jeGjxDwm19AOx+tFgM+Gatszo5jz9pxIX/Wy7+gIHMp06KD
         sn0fiSf3lWD/oB0pNi9s7EJNnlFpFbWeSk6PDq3FvpDV8frxthrwtcuSF5p9hEqNuDzi
         iKYTpeLAIP3vXuDXcbu2LeA3fSY3em9CgZ0VnSvDZw6H4RknSJIjsgBSPdBAwybmf1mu
         hW9g==
X-Gm-Message-State: ANhLgQ2hUx79eHkVdDprV76HNiN0jaz33fdX8UDQaC2Bh1Ufbkopq6gn
        DtyNAwGwBUEt+3o+ULRkU/6bYLqur+jGLE6f6xsjcg==
X-Google-Smtp-Source: ADFU+vuoKFnQORUWnsd0SvSfPdf0eWm834hUzzRK/8ZVwE5hAOBlnXx4qRmpF89hQzhdTVDMwaTujzdY1Cs+6Ig/afk=
X-Received: by 2002:a7b:c105:: with SMTP id w5mr325497wmi.168.1585608254281;
 Mon, 30 Mar 2020 15:44:14 -0700 (PDT)
MIME-Version: 1.0
References: <CAPuGWB8Aqvr6po0-nJskh_5W3rUv1+y2P2U-pYMAJ_wwKnLjkA@mail.gmail.com>
 <CAJCQCtTGo_phSJ+rw4Y6nqsDrcmQdLDMX4osQ=4kZe5yZc21Ug@mail.gmail.com>
 <CAPuGWB-XyYya263K2gWriv5sGVLQbbzpKD3R01GkxiwNw-LdTA@mail.gmail.com> <CAPuGWB_D-waGWv4YNsF9N0dbnA+2ztJvMjmxs9PK5qG_PUFU7Q@mail.gmail.com>
In-Reply-To: <CAPuGWB_D-waGWv4YNsF9N0dbnA+2ztJvMjmxs9PK5qG_PUFU7Q@mail.gmail.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Mon, 30 Mar 2020 16:43:57 -0600
Message-ID: <CAJCQCtQ9rgjnv_CkWVECe3vM71aWSrhRL-sbDZ_+K9AjX8p3PA@mail.gmail.com>
Subject: Re: How do damaged root trees happen and how to protect against power cut?
To:     Carsten Behling <carsten.behling@googlemail.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Mar 24, 2020 at 1:54 AM Carsten Behling
<carsten.behling@googlemail.com> wrote:

> Mo., 23. M=C3=A4rz, 16:58 (vor 15 Stunden)
> an Chris
> > Seed device?
> >
> > Create a Btrfs file system, use space_cache v2,
> > compress-force=3Dzstd:16, and write the root image. Resize the file
> > system to minimum. Set the seed flag. That's the base image. Part of
> > the provisioning will be to 'btrfs device add' a 2nd partition, and
> > remount read-write. This means two Btrfs file systems exist, each with
> > their own UUID. You can reference the read-only seed by its UUID; and
> > you can reference the read-write volume by its own UUID. On-disk
> > metadata for this read-write volume points to both the read-only seed
> > devid1, and the writable 2nd device devid2.
> >
> > Make sure write cache on the physical media is disabled.
>
> Are this the correct steps in detail:

I can't sanity check every single step. But I'll comment on what I can.

>
> 1. Partition SD card with:
> - (write Bootloader ...)
> - first partition boot (FAT32 (0x0b), 50MB)
> - second partition (Linux Native (0x83), minimum possible size to fit roo=
tfs)
> - third partition (Linux Native (0x83), rest
> - (write boot files (kernel ...))

Seems like bootloader happens later, whether BIOS or UEFI.


>
> 2. Create seed device on development host:
>
> # mkfs.btrfs --rootdir ~/rootfs --shrink /dev/sda2 # sda is my SD card de=
vice
> # btrfstune -S 1 /dev/sda2
> # dd if=3D/dev/zero of=3D/dev/sda3 bs=3D1024
> # mount /dev/sda2 /mnt
> # btrfs device add /dev/sda3 /mnt
> # hdparm -W 0 /dev/sda3 # disable write cache

I haven't populated a btrfs file system using --rootdir option of
mkfs. I've only ever done it by using kernel code (mounted file
system) and then just shrink the resulting file system to minimum size
and/or fstrim so that it's a sparse file. That way I can also take
advantage of fs compression for the seed.

I'd substitute the dd command above with 'blkdiscard' and relocate it
to step 1 as a preparation step.

Pretty sure you need 'mount -o remount,rw' before it's possible to add
a 2nd device.

The hdparm step is probably only important for production use.


>
> 3. Mount on embedded device
>
> - Kernel command line option: "root=3D/dev/mmcblk0p2 ro rootwait"
> - Later, 'systemd-remount-fs.service' remounts seed device 'rw' by
> appliying mmount options from fstab:
> ...
> # 'defaults' includes 'rw', 'ROOT' is /dev/mmcblk0p2 (seed device)
> LABEL=3DROOT       /                    btrfs
> defaults,noatime,nodiratime,space_cache=3Dv2,compress-force=3Dzstd:16
>  1  1
> ...


The read-only seed device itself can't be mounted read-write. That's
the point of a seed-device. All changes go to the 2nd device. What you
really want to do during production is mount by the fs UUID of the
"sprout".

At mkfs time, devid 1 (first device, which becomes the read-only seed)
has an fs UUID.

When you 'btrfs dev add' a 2nd device to a seed, that 2nd device is
sometimes called a "sprout" device, let's call it devid 2. A new fs
UUID is generated, which is a Btrfs volume made of two devices, devid1
and devid2.

Therefore, if you use root=3DUUID=3DfsUUID"seed" this would mount the
read-only seed, and could be used as a way to "reset" the system. If
you use root=3DUUID=3DfsUUID"sprout" then this references both devid1 and
devid2, and will mount read-write by default.

It's superfluous detail for your use case, but for the sake of a
complete answer, a "sprout" isn't always 2 devices, even though it
starts that way. It is possible to delete devid1, which then causes
replication of the seed to the sprout. Once finished, devid1, the
seed, is removed. And now the seed and sprout are each single device
Btrfs volumes and totally independent.

Anyway, for your "reset" option, you probably need one of two things.
a) read-only rootfs support in the initramfs so that you can boot the
read-only seed or b) setup a ramdisk, such a zram device, and use it
as a volatile "sprout", now you can remount sysroot read-write, and
perform the reset which would be something like doing a blkdiscard on
the "sprout" device you want to get rid of, and then create a new
persistent sprout. This double use of the seed is completely valid.

There is one possible gotcha you can run into, but again don't think
it applies to your use case:

btrfs multiple devices confusion: automatically unmounted /home,
clobbered ssh session
https://github.com/systemd/systemd/issues/14674


--=20
Chris Murphy
