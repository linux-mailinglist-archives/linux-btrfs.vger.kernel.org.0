Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B2C71DA30B
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 May 2020 22:44:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727949AbgESUov (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 19 May 2020 16:44:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726178AbgESUov (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 19 May 2020 16:44:51 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B6C6C08C5C0
        for <linux-btrfs@vger.kernel.org>; Tue, 19 May 2020 13:44:51 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id n5so697413wmd.0
        for <linux-btrfs@vger.kernel.org>; Tue, 19 May 2020 13:44:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ADlC8nzllFrlxcAJMJZNE6U2ntc1JEdJNWhCWxM281Q=;
        b=sOwd5z0Q1w1qSrsITgjd5DoPbvlXQrLWvLoKWgqNg0FHPCsSbnXn+lBlB9qjgUuTD2
         qSUDBT8S3cfnrfnA9Yx9QRy2tfIX0W89lCHQErKYMTkNXx0Ju6vxoF2Losai8isLCEPN
         I+Niz0Q2nZNKtXYW0OlS+YK7eCc/U/e+ycnGmtbdggZKXH+LcsTJH5hIGZHkfFiCPtxr
         GFwnFal+5TsnvmUS+2/qDxhn1ma4O+viQkIYzApcqieVG/5hIdT/RjuCz9MItsInfTeF
         Oom2F53SMJvf7I7p58dV4P+M1IU9K8J6Y5sBtp15M1aU0oWtdiKnYAxq97iuSz8Dqrjl
         1xkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ADlC8nzllFrlxcAJMJZNE6U2ntc1JEdJNWhCWxM281Q=;
        b=TXJ7MEaG0YGv7Tycg7eTvEjDf+2G9W03+s1wOcqvSQVtnrHlRR26Ev424k7yKzQXxT
         th5Lq9JnnczgF1AiwVjXWSrx0/iU3BjOybWr+s7NxNwhZ1DMMcbUOmgDKEn/I/tsBpFJ
         IpOkFUJsjTv5sU7KuDCxc0jTztVoIStCnJq33Tz1WZ6DdIrHfrkZ42PNyavpKhxKEQCh
         zaaLD/ErZYyubasXQ/YMq1giHBIpQ1YfkRCh9GlXYw8Qzxbiwffuv/lqueDnQ5kZ+o3z
         zpmR4rS9o7zJMLY7wwCuI0aMnGmwOjGbo+WnWmIpr4Tl5zFN/ryoZ3MtYfNxhJ8P/ZKh
         GLZQ==
X-Gm-Message-State: AOAM530IuCaX3kDgWD99fQWX0RQMCcYPCsaEGRJQ/c8mLio4zgWJ+GUe
        mcDw9IX7f0VlwWdPJWlGVSPu6P1elOQAlO0DJfPgfAiO/N/zcA==
X-Google-Smtp-Source: ABdhPJzb721vastCiLigvXYqnwSdCoPX+jRcOd97u/Y5/nB0KswxQ4/GMBylK4tVq1RmQ/FQv+x+bqeaz8pbYtgyL7M=
X-Received: by 2002:a05:600c:228d:: with SMTP id 13mr1248863wmf.182.1589921089748;
 Tue, 19 May 2020 13:44:49 -0700 (PDT)
MIME-Version: 1.0
References: <CAGAeKuuvqGsJaZr_JWBYk3uhQoJz+07+Sgo_YVrwL9C_UF=cfA@mail.gmail.com>
 <CAJCQCtR4zz+JzETFjmwPvqyzkSBYp-9PC7T6aP2+_Xkg5n3tSw@mail.gmail.com>
 <CAGAeKuv3y=rHvRsq6SVSQ+NadyUaFES94PpFu1zD74cO3B_eLA@mail.gmail.com>
 <CAJCQCtQXR+x4mG+jT34nhkE69sP94yio-97MLmd_ugKS+m96DQ@mail.gmail.com> <CAGAeKuvP=BUeBfsYLpp2xZoEdCWVwY-reAddNwxZL8UFrWf_yg@mail.gmail.com>
In-Reply-To: <CAGAeKuvP=BUeBfsYLpp2xZoEdCWVwY-reAddNwxZL8UFrWf_yg@mail.gmail.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Tue, 19 May 2020 14:44:33 -0600
Message-ID: <CAJCQCtSfMKoucwoaYAnRDgh8QmwHUOR9D5VuN4c6AUw9isNf2A@mail.gmail.com>
Subject: Re: I think he's dead, Jim
To:     Justin Engwer <justin@mautobu.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, May 19, 2020 at 12:45 PM Justin Engwer <justin@mautobu.com> wrote:
>
> On Mon, May 18, 2020 at 7:03 PM Chris Murphy <lists@colorremedies.com> wrote:
> >
> > On Mon, May 18, 2020 at 6:47 PM Justin Engwer <justin@mautobu.com> wrote:
> > >
> > > Thanks for getting back to me Chris. Here's the info requested:
> > >
> > > a. Kernels are:
> > > CentOS Linux (5.5.2-1.el7.elrepo.x86_64) 7 (Core)
> > > CentOS Linux (4.16.7-1.el7.elrepo.x86_64) 7 (Core)
> > > CentOS Linux (4.4.213-1.el7.elrepo.x86_64) 7 (Core)
> > >
> > > I was originally on 4.4, then updated to 4.16. After updating to 5.5 I
> > > must have screwed up the grub boot default as it started booting to
> > > 4.4.
> >
> > The problem happened while using kernel 5.5.2?
> >
>
> Likely 4.4

While it's a long term supported kernel, this is really difficult for
Btrfs because some fixes and features just don't ever get backported.
File systems are increasingly non-deterministic the older they get,
even with a static never changing kernel version. The LTS kernels are
perhaps best suited for distributions (public or internal) with
dedicated dev teams.

For example:
$ git diff --shortstat v4.4..v5.6 -- fs/btrfs
 109 files changed, 52729 insertions(+), 36600 deletions(-)
$ git diff --shortstat v4.4..v5.6 -- fs/btrfs/raid56.c
 1 file changed, 396 insertions(+), 373 deletions(-)
$ wc -l fs/btrfs/raid56.c
2749 fs/btrfs/raid56.c

Has this bug you're running into been fixed? *shrug*

I think if you're using raid1 or raid10 you could use 4.19 series but
you're probably still better off using something more recent, in
particular for raid56 so that you can use metadata raid1c3 instead of
raid6.





>
> > These:
> > parent transid verify failed on 2788917248 wanted 173258 found 173174
> >
> > suggest that the problem didn't happen too long ago. But the
> > difficulty I see is that the "found" ranges from 172716 to 173167.
> >
> > A further difficulty is the wanted ranges from 173237 to 173258. That
> > is really significant.
> >
> > Have there been crashes/power failures while the file system was being written?
> >
>
> Given the system is hard locking up when btrfs is accessing some data,
> yes most likely.

I don't expect hard lockups just because a power fail or crash has
confused the file system state on disk. If the proper ordering has
been honored, none of the written garbage is pointedd to by any
superblock. So the difficult but important question is, why might the
proper ordering not have been honored?

At least the Btrfs developers have said Btrfs theoretically does the
correct thing order wise; and dm-log-writes is one of the
contributions they've made so all file systems can test and do better
with respect to power failures.

Anyway, the question is more looking for a possibly prior event(s)
that might explain the transid discrepancies. And yeah crashes and
powerfails can do that, but it takes other things too like writes
being committed out of order - which is difficult to ensure with
multiple device file systems. Especially if they aren't telling the
whole truth when data is actually committed to stable media, but claim
so even when the data is merely in the write cache.



> Working on restoring. Will start with the 4 "good" drives. I recall
> years ago working in a computer repair shop if a drive was bad and we
> left it in the freezer overnight we could get data from it for a few
> hours, then it would be completely dead afterward. Might be worth a
> shot if nothing else works.
>
> Does BTRFS store whole files on single drives then use a parity across
> all of them or does it break single large files up, store them across
> different drives, then parity?

The latter.

The stripe element size is 64KiB (a.k.a. strip size, a.k.a. chunk in
mdadm terminology; btrfs chunks are the same as block groups). The
striping is per block group. And the order isn't always consistent.

So if metadata and data are raid6, it means everything is in 64KiB
"strips". Including the file system itself.


>
> >
> > > b. Physical drives are identical seagate SATA 3tb drives. Ancient
> > > bastards. Connected through a combination of LSI HBA and motherboard.
> >
> > Does the LSI HBA have a cache enabled? If its battery backed it's
> > probably OK but otherwise it should be disabled. And the write caches
> > on the drives should be disabled. That's the conservative
> > configuration. If the controller and drives really honor FUA/fsync
> > then it's OK to leave the write caches enabled. But the problem is if
> > they honor different flushes in different order you end up with an
> > inconsistent file system. And that's bad for Btrfs because repairing
> > inconsistency is difficult. It really just needs to be avoided in the
> > first place.
> >
>
> All cards are LSI 9211 or 9200 in the system. None of them have onboard caching.

Use hdparm -W to check the write cache on the drives and disable it on
all drives. Make sure not to use small w option -w, see man page.


> > I think that's a bug on the face of it. It shouldn't indefinitely hang.
> >
>
> Now mounts on Fedora. Drops to RO quickly though. See
> https://pastebin.com/94BbRamb

May 19 10:46:59 localhost.localdomain kernel: BTRFS: error (device
sdb) in btrfs_remove_chunk:2959: errno=-117 unknown
May 19 10:46:59 localhost.localdomain kernel: BTRFS info (device sdb):
forced readonly

It consistently gets tripped up removing block groups.


> I put the drives in a box with Fedora Rawhide connected directly to
> the motherboard. It looks like all of the supers are the same.
>
> [root@localhost ~]# btrfs rescue super -v /dev/sdb
> All Devices:
>         Device: id = 4, name = /dev/sdh
>         Device: id = 2, name = /dev/sdf
>         Device: id = 5, name = /dev/sde
>         Device: id = 3, name = /dev/sdd
>         Device: id = 1, name = /dev/sdb
>
> Before Recovering:
>         [All good supers]:
>                 device name = /dev/sdh
>                 superblock bytenr = 65536
>
>                 device name = /dev/sdh
>                 superblock bytenr = 67108864
>
>                 device name = /dev/sdh
>                 superblock bytenr = 274877906944
>
>                 device name = /dev/sdf
>                 superblock bytenr = 65536
>
>                 device name = /dev/sdf
>                 superblock bytenr = 67108864
>
>                 device name = /dev/sdf
>                 superblock bytenr = 274877906944
>
>                 device name = /dev/sde
>                 superblock bytenr = 65536
>
>                 device name = /dev/sde
>                 superblock bytenr = 67108864
>
>                 device name = /dev/sde
>                 superblock bytenr = 274877906944
>
>                 device name = /dev/sdd
>                 superblock bytenr = 65536
>
>                 device name = /dev/sdd
>                 superblock bytenr = 67108864
>
>                 device name = /dev/sdd
>                 superblock bytenr = 274877906944
>
>                 device name = /dev/sdb
>                 superblock bytenr = 65536
>
>                 device name = /dev/sdb
>                 superblock bytenr = 67108864
>
>                 device name = /dev/sdb
>                 superblock bytenr = 274877906944
>
>         [All bad supers]:
>
> All supers are valid, no need to recover

Interesting.


>
>
>
> I tried all mounting all three supers on sdb using "btrfs-select-super
> -s 0 /dev/sdb" and mounting with "mount /dev/sdb btrfs/ -t btrfs -o
> ro,nologreplay,degraded".  Still unable to get data. syslog here:
> https://pastebin.com/94BbRamb
>
> Results of btrfs check:
>
> [root@localhost ~]# btrfs check --readonly /dev/sde
> Opening filesystem to check...
> Checking filesystem on /dev/sde
> UUID: 64961501-b1d1-4470-8461-5c47aa5e72c6
> [1/7] checking root items
> parent transid verify failed on 2788917248 wanted 173258 found 173174
> checksum verify failed on 2788917248 found 000000E4 wanted 00000029
> checksum verify failed on 2788917248 found 000000E4 wanted 00000029
> bad tree block 2788917248, bytenr mismatch, want=2788917248, have=1438426880
> ERROR: failed to repair root items: Input/output error


btrfs inspect dump-t --follow -b 2788917248 /anydev/




>
> [root@localhost ~]# btrfs check -s 2 --readonly /dev/sde
> using SB copy 2, bytenr 274877906944
> Opening filesystem to check...
> Checking filesystem on /dev/sde
> UUID: 64961501-b1d1-4470-8461-5c47aa5e72c6
> [1/7] checking root items
> parent transid verify failed on 2788917248 wanted 173258 found 173174
> checksum verify failed on 2788917248 found 000000E4 wanted 00000029
> checksum verify failed on 2788917248 found 000000E4 wanted 00000029
> bad tree block 2788917248, bytenr mismatch, want=2788917248, have=1438426880
> ERROR: failed to repair root items: Input/output error
>
>
> I highly doubt any of this is a bug. This pretty much sums up my
> feelings right now: https://imgflip.com/i/422w78

It's probably not any one thing. That's the difficulty. There are
certainly a lot of bug fixes between 4.4 and 5.6. But also write
caches enabled, who knows if one or more drives fib about commits
actually being on disk, loss of writes in write cache during power
fail, etc. And these things can accumulate, not just happen all at the
same time.


--
Chris Murphy
