Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D90231CE9E
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Feb 2021 18:05:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230429AbhBPREq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 16 Feb 2021 12:04:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230364AbhBPREl (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 16 Feb 2021 12:04:41 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 714F3C061756
        for <linux-btrfs@vger.kernel.org>; Tue, 16 Feb 2021 09:04:00 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id m22so16985117lfg.5
        for <linux-btrfs@vger.kernel.org>; Tue, 16 Feb 2021 09:04:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vlad.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=EhAAsfZb6OS6e4tS3QSkbZjdGqpFUbvkHqJIsl48rCQ=;
        b=L+Dz3I49x+8x5QlON0D3Se/d2ijoCufydtnKKmrmEJ6FaYSd5SnCzfWX5MaiGFaGE7
         MPn6y6pppcB8DzDnCSZQsGVlJC69Rm0hAtQmxXCiw6UDM5MW5kGxDMae4rk6R208dYhv
         qY8y3c/KV/H34D9hLQlKNXp30GgC3FmTO+HXs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=EhAAsfZb6OS6e4tS3QSkbZjdGqpFUbvkHqJIsl48rCQ=;
        b=Nx1OQjC96i1V38ThtzTl3+vcvwCOxGA0vQcK2zjKCgi+aU7s6tb83ZOAcW/SSnpGnK
         zccSgbfpDvduJ9WLnny5cEDLgGtaiLRdyJ5tGZ958qw3vyBpNNPvyR50gLfjDJnx9pI6
         onBGBeNwLq4/lLAeCWy55Se8IVQrkIpMhAjYNA1lgAYzJH1XjqwNEDXvDQIRlwjnphft
         2imiMydKc73wXnykFe+CyZgDpsC2xLACJygG42dw93ZaKHpT7kF/m1yZxXztMLJSvlzo
         X4TsHygMdK+g+qPtUTa0ZnZWjTCOquH5RytRGToudQra3rVYMrxKKeIFhcWgDHz1jh7K
         nAGw==
X-Gm-Message-State: AOAM531GocGtDqBP01kOEppH8cPphi5k4iHh0W0NuOJW5GR07puTLs5z
        Jp57WkcrxFptOjm5BUTGQve80D2FxEsTmkLGsA3b8A==
X-Google-Smtp-Source: ABdhPJxGOiZgX/GePL6MmD6xDuVt0oFBdrgQm3YYeSXhO/WB9TxP5rFYmGW0xEORehwS1vigJGFoqhtQRsFaR3IhIcY=
X-Received: by 2002:a05:6512:33c2:: with SMTP id d2mr11654576lfg.429.1613495037428;
 Tue, 16 Feb 2021 09:03:57 -0800 (PST)
MIME-Version: 1.0
References: <CAFTxqD_-OiGjA3EEycKwKGteYPmA6OjPhMxce8f1w8Ly=wd2pg@mail.gmail.com>
 <e70bbe98-f6dc-9eaa-8506-cd356a1c2ed8@suse.com> <CAFTxqD9E2egJ22MorzXPAHaNDKg5QoEBK=Cd4ChOdT6Odiy6Rg@mail.gmail.com>
 <aeed56c3-e641-46a1-5692-04c6ae75d212@gmail.com>
In-Reply-To: <aeed56c3-e641-46a1-5692-04c6ae75d212@gmail.com>
From:   "Pal, Laszlo" <vlad@vlad.hu>
Date:   Tue, 16 Feb 2021 18:03:21 +0100
Message-ID: <CAFTxqD-SpnKBRY9Ri9xWFfNgWuHYVggYwCPdyXgF6ipUAzxNTg@mail.gmail.com>
Subject: Re: performance recommendations
To:     Roman Stingler <roman.stingler@gmail.com>,
        linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

Thank you. So, I've installed a new centos7 with the same
configuration, old kernel and using btrfs. Then, upgraded the kernel
to 5.11 and all went well, so I thought let's do it on the prod server

Unfortunately when I boot on 5.11 sysroot mount times out and I have
something like this in log

btrfs open ctree failed

Any quick fix for this? I'm able to mount btrfs volume using a rescuCD
but I have the same issues, like rm a big file takes 10 minutes....

Thank you
Laszlo

On Tue, Feb 16, 2021 at 2:08 PM Roman Stingler <roman.stingler@gmail.com> w=
rote:
>
> first update your kernel to 5.10 it is lts now and try again.
>
> there have been 1 million updates to stability and performance
> improvements in the past year.
>
>
>
> On 2/16/21 9:54 AM, Pal, Laszlo wrote:
> > Thank you all for the quick response. The server is running, but as I
> > said the i/o perf. is not as good as it should be. I'm also thinking
> > the fragmentation is the issue but I also would like to optimise my
> > config and if possible keep this server running with acceptable
> > performance, so let me answer the questions below
> >
> > So, as far as I see the action plan is the following
> > - enable v2 space_cache. is this safe/stable enough?
> > - run defrag on old data, I suppose it will run weeks, but I'm ok with
> > it if the server can run smoothly during this process
> > - compress=3Dzstd is the recommended mount option? is this performing
> > better than the default?
> > - I'm also thinking to -after defrag- compress my logs with
> > traditional gzip compression and turn off on-the-fly compress (is this
> > a huge performance gain?)
> >
> > Any other suggestions?
> >
> > Thank you
> > Laszlo
> > ---
> >
> > uname -a
> > 3.10.0-1160.6.1.el7.x86_64 #1 SMP Tue Nov 17 13:59:11 UTC 2020 x86_64
> > x86_64 x86_64 GNU/Linux
> >
> >    btrfs --version
> >    btrfs-progs v4.9.1
> >
> >    btrfs fi show
> >    Label: 'centos'  uuid: 7017204b-1582-4b4e-ad04-9e55212c7d46
> > Total devices 2 FS bytes used 4.03TiB
> > devid    1 size 491.12GiB used 119.02GiB path /dev/sda2
> > devid    2 size 4.50TiB used 4.14TiB path /dev/sdb1
> >
> >    btrfs fi df
> >    btrfs fi df /var
> > Data, single: total=3D4.09TiB, used=3D3.96TiB
> > System, RAID1: total=3D8.00MiB, used=3D464.00KiB
> > Metadata, RAID1: total=3D81.00GiB, used=3D75.17GiB
> > GlobalReserve, single: total=3D512.00MiB, used=3D0.00B
> >
> >    dmesg > dmesg.log
> >    dmesg|grep -i btrfs
> >    [  491.729364] BTRFS warning (device sdb1): block group
> > 4619266686976 has wrong amount of free space
> >    [  491.729371] BTRFS warning (device sdb1): failed to load free
> > space cache for block group 4619266686976, rebuilding it now
> >
> >    CPU type and model
> >    processor : 11
> > vendor_id : GenuineIntel
> > cpu family : 6
> > model : 26
> > model name : Intel(R) Xeon(R) CPU           E5540  @ 2.53GHz
> > stepping : 4
> > microcode : 0x1d
> > cpu MHz : 2533.423
> > cache size : 8192 KB
> > 12 vCPU on esxi
> >
> > how much memory
> > 48 GB RAM
> >
> > type and model of hard disk
> > virtualized Fujitsu RAID on esxi
> >
> > is it raid
> > yes, the underlying virtualization provides redundancy, no sw RAID
> >
> > Kernel version
> > 3.10.0-1160.6.1.el7.x86_64
> >
> > your btrfs mount options probably in /etc/fstab
> > UUID=3D7017204b-1582-4b4e-ad04-9e55212c7d46 /
> > btrfs   defaults,noatime,autodefrag,subvol=3Droot     0 0
> > UUID=3D7017204b-1582-4b4e-ad04-9e55212c7d46 /var
> > btrfs   defaults,subvol=3Dvar,noatime,autodefrag      0 0
> >
> > size of log files
> > 4,5TB on /var
> >
> > have you snapshots
> > no
> >
> > have you tries tools like dedup remover
> > not yet
> >
> > things you do
> >
> > 1. Kernel update LTS kernel has been updated to 5.10 (maybe you have
> > to install it manually, because centos will be dropped -> reboot
> > maybe you have to remove your mount point in fstab and boot into
> > system and mount it later manually.
> > Is this absolutely necessary?
> >
> > 2. set mount options in fstab
> >      defaults,autodefrag,space_cache=3Dv2,compress=3Dzstd (autodefrag o=
nly on HDD)
> >      defaults,ssd,space_cache=3Dv2,compress=3Dzstd (for ssd)
> >
> >    autodefrag is already enabled. v2 space_cache is safe enough?
> >
> > 3. sudo btrfs scrub start /dev/sda (use your device)
> >      watch sudo btrfs scrub status /dev/sda (watch and wait until finis=
hed)
> >
> > 4. sudo btrfs device stats /dev/sda (your disk)
> >
> > 5.install smartmontools
> >     run sudo smartctl -x /dev/sda (use your disk)
> >     check
> > I think this is not applicable because this is a virtual disk,
> >
> > On Tue, Feb 16, 2021 at 8:17 AM Nikolay Borisov <nborisov@suse.com> wro=
te:
> >>
> >>
> >> On 15.02.21 =D0=B3. 16:53 =D1=87., Pal, Laszlo wrote:
> >>> Hi,
> >>>
> >>> I'm not sure this is the right place to ask, but let me try :) I have
> >>> a server where I mainly using btrfs because of the builtin compress
> >>> feature. This is a central log server, storing logs from tens of
> >>> thousands devices, using a text files in thousands of directories in
> >>> millions of files.
> >>>
> >>> I've started to think it was not the best idea to choose btrfs for th=
is :)
> >>>
> >>> The performance of this server was always worst than others where I
> >>> don't use btrfs, but I thought this is just because the i/o overhead
> >>> of compression and the not-so-good esx host providing the disk to thi=
s
> >>> machine. But now, even rm a single file takes ages, so there is
> >>> something definitely wrong. So, I'm looking for some recommendations
> >>> for such an environment where the data-security functions of btrfs is
> >>> not as important than the performance.
> >>>
> >>> I was searching the net for some comprehensive performance documents
> >>> for months, but I cannot find it so far.
> >>>
> >>> Thank you in advance
> >>> Laszlo
> >>>
> >> You are likely suffering fragmentation issues, given you hold log file=
s
> >> I'd assume you do a lot of small writes, each one results in a CoW
> >> operation which allocates space.  This results in increasing the size =
of
> >> the metadata tree and since you are likely using harddrives seeking is
> >> slow. To try and ascertain if that's really the case I'd advise you to
> >> show the output of the following commands:
> >>
> >> btrfs fi usage <mountpoint> - this will show the total used space on t=
he
> >> filesystem.
> >>
> >> Then run btrfs inspect-internal dump-tree -t5 </dev/xxx> | grep -c
> >> EXTENT_DATA
> >>
> >> Which will show how many data extents there are in the filesystem.
> >> Subsequently run btrfs inspect-internal dump-tree -t5 </dev/xxx> | gre=
p
> >> -c leaf which will show how many leaves there are in the filesystem.
> >> Then you have 2 options:
> >>
> >> a) Use btrfs defragment to actually rewrite leaves to try and make the=
m
> >> be closer so that seeks are going to become somewhat cheaper,
> >>
> >> b) Rewrite the logs files by copying them with no reflinks so that
> >> instead of 1 file consisting of multiple small extents just make them
> >> consist of 1 giant extent, also with your use case I'd assume you also
> >> want nocow to be enabled, unfortunately nodatacow precludes using
> >> compression.
> >>
> >>
