Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDE7B1D9FE6
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 May 2020 20:46:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726596AbgESSp5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 19 May 2020 14:45:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726290AbgESSp4 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 19 May 2020 14:45:56 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3061C08C5C0
        for <linux-btrfs@vger.kernel.org>; Tue, 19 May 2020 11:45:55 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id d3so263155pln.1
        for <linux-btrfs@vger.kernel.org>; Tue, 19 May 2020 11:45:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mautobu-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=H3iF1Y4JxmPMLMmOckSt3TdA1YJuej3L3VuFubu/Vcs=;
        b=xXPmIPRG8pJjZOH1I0qsSOxDJg5GSLI4NB9ph0ly7Z/08g3v+XD0pzQDlvlnRnpzNn
         JPrntdhK4mqjPaR6Zkd+6demv1r+6+PhI/7uH3z/zn1K0dYfe23V0fmRVIIfGKNS6u19
         s/+uBTdFwdc0ubAx77JW9Yj1lXRbiZXjinjW4po4LXeS3v+Hn9KM9RY4lMvWKumAlCBC
         3qsH3Uz3NI4q7fsw1ZSSZSvnit5yEVdgHjU5vMyoMpLZhzoDBiSdRbva478xSzFyMlUw
         dLxLSc2oDGBppgh5rBFZ7XyIS2+zk4aLJlZmyehP0WPBieU8lshDrL2j2VDbEEbeygMv
         gv6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=H3iF1Y4JxmPMLMmOckSt3TdA1YJuej3L3VuFubu/Vcs=;
        b=CWRkGZBQ6aR+C3nszWHqpiiPyq975wbNc5fb5XTVCWwPV9kPRd2mFuKkGjx/XLJcME
         coj/Hnh69Lkf/Iuoi3VJUXY9RF75FuUkpuhiQhMEobxXwDY/gJ7PB4mmhzda0RlJfSrv
         +E8LqbbJ2RmoCq/NLlnGcuwYh5oM+GBBLLqVFd4QB8r/ir5EfBqF8xIoykuo0qP/pMyc
         +fZYC19c/8Rt4VSNpg5EIC6E2Crzt0c5/qJVAsNyUsvhUUg0wgg2fjNLq/sf2YMRxsn6
         V3j0Ow13iYTPBd1oRju/KWIqq5xWWLMEo2u/5htfq3qnPSYPdxwLK7/I1S8tKvnwkuFF
         kAAQ==
X-Gm-Message-State: AOAM532wilNRv5aLs5e17l2dIyGcO6WxB+07UioNQRGgLQT8aKx0Kiak
        /xlqJE/+Hn5uiHFIAHhaSNW7tuKi++LnVwXvnWcm3wVoTIU=
X-Google-Smtp-Source: ABdhPJzhf3vEXzQmxkLl1eVr76oFYTUbpT/okX35UBs6dwQ+Y07JgouJKr3HbnABoEpxEFpfgmXqdKkIdvY0qP/q74U=
X-Received: by 2002:a17:90a:748:: with SMTP id s8mr889562pje.221.1589913954955;
 Tue, 19 May 2020 11:45:54 -0700 (PDT)
MIME-Version: 1.0
References: <CAGAeKuuvqGsJaZr_JWBYk3uhQoJz+07+Sgo_YVrwL9C_UF=cfA@mail.gmail.com>
 <CAJCQCtR4zz+JzETFjmwPvqyzkSBYp-9PC7T6aP2+_Xkg5n3tSw@mail.gmail.com>
 <CAGAeKuv3y=rHvRsq6SVSQ+NadyUaFES94PpFu1zD74cO3B_eLA@mail.gmail.com> <CAJCQCtQXR+x4mG+jT34nhkE69sP94yio-97MLmd_ugKS+m96DQ@mail.gmail.com>
In-Reply-To: <CAJCQCtQXR+x4mG+jT34nhkE69sP94yio-97MLmd_ugKS+m96DQ@mail.gmail.com>
From:   Justin Engwer <justin@mautobu.com>
Date:   Tue, 19 May 2020 11:45:44 -0700
Message-ID: <CAGAeKuvP=BUeBfsYLpp2xZoEdCWVwY-reAddNwxZL8UFrWf_yg@mail.gmail.com>
Subject: Re: I think he's dead, Jim
To:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, May 18, 2020 at 7:03 PM Chris Murphy <lists@colorremedies.com> wrote:
>
> On Mon, May 18, 2020 at 6:47 PM Justin Engwer <justin@mautobu.com> wrote:
> >
> > Thanks for getting back to me Chris. Here's the info requested:
> >
> > a. Kernels are:
> > CentOS Linux (5.5.2-1.el7.elrepo.x86_64) 7 (Core)
> > CentOS Linux (4.16.7-1.el7.elrepo.x86_64) 7 (Core)
> > CentOS Linux (4.4.213-1.el7.elrepo.x86_64) 7 (Core)
> >
> > I was originally on 4.4, then updated to 4.16. After updating to 5.5 I
> > must have screwed up the grub boot default as it started booting to
> > 4.4.
>
> The problem happened while using kernel 5.5.2?
>

Likely 4.4

> These:
> parent transid verify failed on 2788917248 wanted 173258 found 173174
>
> suggest that the problem didn't happen too long ago. But the
> difficulty I see is that the "found" ranges from 172716 to 173167.
>
> A further difficulty is the wanted ranges from 173237 to 173258. That
> is really significant.
>
> Have there been crashes/power failures while the file system was being written?
>

Given the system is hard locking up when btrfs is accessing some data,
yes most likely.

>
> > btrfs-progs v4.9.1
>
> This is too old to attempt a repair. The errors reported seem
> reliable, but there might be other problems going on that it's not
> catching, so I suggest updating it in any case.
>
> Try this:
> https://copr.fedorainfracloud.org/coprs/ngompa/btrfs-progs-el8/
>
> But I can't recommend a repair except as a last resort. It seems like
> things can't get worse, but it's better to be prepared. It also
> includes more capable offline scrape tool 'btrfs restore'.
>

Working on restoring. Will start with the 4 "good" drives. I recall
years ago working in a computer repair shop if a drive was bad and we
left it in the freezer overnight we could get data from it for a few
hours, then it would be completely dead afterward. Might be worth a
shot if nothing else works.

Does BTRFS store whole files on single drives then use a parity across
all of them or does it break single large files up, store them across
different drives, then parity?

>
> > b. Physical drives are identical seagate SATA 3tb drives. Ancient
> > bastards. Connected through a combination of LSI HBA and motherboard.
>
> Does the LSI HBA have a cache enabled? If its battery backed it's
> probably OK but otherwise it should be disabled. And the write caches
> on the drives should be disabled. That's the conservative
> configuration. If the controller and drives really honor FUA/fsync
> then it's OK to leave the write caches enabled. But the problem is if
> they honor different flushes in different order you end up with an
> inconsistent file system. And that's bad for Btrfs because repairing
> inconsistency is difficult. It really just needs to be avoided in the
> first place.
>

All cards are LSI 9211 or 9200 in the system. None of them have onboard caching.

> >
> > c. Not a vm. They host(ed) vms though.
> >
> > d. [root@kvm2 ~]# btrfs fi us recovery/mount/
> > WARNING: RAID56 detected, not implemented
> > WARNING: RAID56 detected, not implemented
> > WARNING: RAID56 detected, not implemented
> > Overall:
> >     Device size:                  13.64TiB
> >     Device allocated:                0.00B
> >     Device unallocated:           13.64TiB
> >     Device missing:                  0.00B
> >     Used:                            0.00B
> >     Free (estimated):                0.00B      (min: 8.00EiB)
> >     Data ratio:                       0.00
> >     Metadata ratio:                   0.00
> >     Global reserve:              512.00MiB      (used: 0.00B)
> >
> > Data,RAID6: Size:4.39TiB, Used:0.00B
> >    /dev/sdh        1.46TiB
> >    /dev/sdi        1.46TiB
> >    /dev/sdl        1.46TiB
> >    /dev/sdo        1.46TiB
> >    /dev/sdp        1.46TiB
> >
> > Metadata,RAID6: Size:7.12GiB, Used:176.00KiB
>
> This is more difficult to recover from since it can spread a single
> transaction across multiple disks, and it's harder (sometimes
> impossible) to guarantee atomic updates. It's recommended to use
> raid1c3 or raid1c4 in this configuration. I understand that's not
> supported by the older kernels you were using, hopefully this was an
> experimental setup.
>

Noted. It's a homelab, so it's not ideal but not a huge issue. Just
time consuming to rebuild.

> >
> > f. Mounting without ro,norecovery,degraded results in immediate system
> > lockup and nothing in dmesg.
> >
> >  mount -o ro,norecovery,degraded /dev/sdi recovery/mount/
>
> I think that's a bug on the face of it. It shouldn't indefinitely hang.
>

Now mounts on Fedora. Drops to RO quickly though. See
https://pastebin.com/94BbRamb

> >
> > May 18 17:38:46 kvm2.mordor.local kernel: BTRFS info (device sdi):
> > disabling log replay at mount time
> > May 18 17:38:46 kvm2.mordor.local kernel: BTRFS info (device sdi):
> > allowing degraded mounts
> > May 18 17:38:46 kvm2.mordor.local kernel: BTRFS info (device sdi):
> > disk space caching is enabled
> > May 18 17:38:46 kvm2.mordor.local kernel: BTRFS info (device sdi): has
> > skinny extents
> > May 18 17:38:46 kvm2.mordor.local kernel: BTRFS info (device sdi):
> > bdev /dev/sdl errs: wr 12, rd 264, flush 4, corrupt 0, gen 0
>
> From the reddit threat, all of these errors are confined to a single drive.
>
> Unfortunately there's more than one thing going on. If it were just
> one or two problems, then in theory Btrfs can deal with it. But looks
> like there's one device problem, corrupt extent tree, and checksum
> failure preventing further recovery.
>
> Another thing to check that frequently causes problems with raid on
> Linux, whether Btrfs, LVM or mdadm, are timeout mismatches between
> drive firmware and the kernel command timer.
>
> https://raid.wiki.kernel.org/index.php/Timeout_Mismatch
>
> If it were my problem, in order:
>
> - Update btrfs progs and the kernel. Recent versions should at least
> fail with some sane error reporting, or it's a bug. Not every problem
> can be fixed, but there shouldn't be crashes.
>
> - 'btrfs rescue super -v /anydev/'  - this should check all supers on
> all devices and see if they're the same or not. I don't recommend
> repairing yet if there are differences. It's vaguely possible that
> there is a really old one that might point to a tree that isn't
> busted. And then point btrfs check at that old super.
>
> - 'btrfs check --readonly' to update the report; also, for multiple
> devices you only need to run this command on any one of them.
>
> - try to 'mount -o ro,nologreplay' first and if that doesn't work try
> 'mount -o ro,nologreplay,degraded'
>
> I suggest ssh into this system and use 'journalctl -fk' to follow the
> journal while you do these things in case there are kernel message; in
> particular if it leads to a hang or crash, hopefully this will still
> catch it. And in a second shell, I suggest having sysrq enabled and
> ready to issue sysrq+t.
>
> It's a lot to collect and tediou. But the better the information the
> more likely it'll attract developer attention to see if there's a bug
> that needs to be fixed. Also, that might not happen for a while. So
> it's best to collect as much info as possible now in case you have to
> give up and move on.
>
> --
> Chris Murphy


I put the drives in a box with Fedora Rawhide connected directly to
the motherboard. It looks like all of the supers are the same.

[root@localhost ~]# btrfs rescue super -v /dev/sdb
All Devices:
        Device: id = 4, name = /dev/sdh
        Device: id = 2, name = /dev/sdf
        Device: id = 5, name = /dev/sde
        Device: id = 3, name = /dev/sdd
        Device: id = 1, name = /dev/sdb

Before Recovering:
        [All good supers]:
                device name = /dev/sdh
                superblock bytenr = 65536

                device name = /dev/sdh
                superblock bytenr = 67108864

                device name = /dev/sdh
                superblock bytenr = 274877906944

                device name = /dev/sdf
                superblock bytenr = 65536

                device name = /dev/sdf
                superblock bytenr = 67108864

                device name = /dev/sdf
                superblock bytenr = 274877906944

                device name = /dev/sde
                superblock bytenr = 65536

                device name = /dev/sde
                superblock bytenr = 67108864

                device name = /dev/sde
                superblock bytenr = 274877906944

                device name = /dev/sdd
                superblock bytenr = 65536

                device name = /dev/sdd
                superblock bytenr = 67108864

                device name = /dev/sdd
                superblock bytenr = 274877906944

                device name = /dev/sdb
                superblock bytenr = 65536

                device name = /dev/sdb
                superblock bytenr = 67108864

                device name = /dev/sdb
                superblock bytenr = 274877906944

        [All bad supers]:

All supers are valid, no need to recover



I tried all mounting all three supers on sdb using "btrfs-select-super
-s 0 /dev/sdb" and mounting with "mount /dev/sdb btrfs/ -t btrfs -o
ro,nologreplay,degraded".  Still unable to get data. syslog here:
https://pastebin.com/94BbRamb

Results of btrfs check:

[root@localhost ~]# btrfs check --readonly /dev/sde
Opening filesystem to check...
Checking filesystem on /dev/sde
UUID: 64961501-b1d1-4470-8461-5c47aa5e72c6
[1/7] checking root items
parent transid verify failed on 2788917248 wanted 173258 found 173174
checksum verify failed on 2788917248 found 000000E4 wanted 00000029
checksum verify failed on 2788917248 found 000000E4 wanted 00000029
bad tree block 2788917248, bytenr mismatch, want=2788917248, have=1438426880
ERROR: failed to repair root items: Input/output error

[root@localhost ~]# btrfs check -s 2 --readonly /dev/sde
using SB copy 2, bytenr 274877906944
Opening filesystem to check...
Checking filesystem on /dev/sde
UUID: 64961501-b1d1-4470-8461-5c47aa5e72c6
[1/7] checking root items
parent transid verify failed on 2788917248 wanted 173258 found 173174
checksum verify failed on 2788917248 found 000000E4 wanted 00000029
checksum verify failed on 2788917248 found 000000E4 wanted 00000029
bad tree block 2788917248, bytenr mismatch, want=2788917248, have=1438426880
ERROR: failed to repair root items: Input/output error


I highly doubt any of this is a bug. This pretty much sums up my
feelings right now: https://imgflip.com/i/422w78


-- 

Justin Engwer
