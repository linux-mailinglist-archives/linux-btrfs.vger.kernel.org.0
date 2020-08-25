Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4B39251213
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Aug 2020 08:30:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728912AbgHYGap (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 25 Aug 2020 02:30:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728705AbgHYGao (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 25 Aug 2020 02:30:44 -0400
Received: from mail-vk1-xa42.google.com (mail-vk1-xa42.google.com [IPv6:2607:f8b0:4864:20::a42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B08EAC061574
        for <linux-btrfs@vger.kernel.org>; Mon, 24 Aug 2020 23:30:43 -0700 (PDT)
Received: by mail-vk1-xa42.google.com with SMTP id o2so2561133vkn.9
        for <linux-btrfs@vger.kernel.org>; Mon, 24 Aug 2020 23:30:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=nChjs9v7vzkOoVWEE3yd43CYj88/kEyBj87DH/161nw=;
        b=DN9iqv5iCoa4Eb7uMzO0ky15nj30GJfPooak2r6BwFXvFldY4kre8x3VdY6xX3duog
         q7R+JZw4xFuVbrV93he7q1D/RgZUcivmKvty3fMiwT8xPqRcDgOQ6jaX7FXRg+sonR2Z
         A1X/nCu+vqbvlDGf4BoWPIWU6LkVamEkKgerTsbICTHw6rAWT6Z8gUWBiE1Qe/wWsfjQ
         JuHnNKaQF3QYc2F/xC+8lb1AqnFCo+aFpu8sRwyVTbe8xwDlY9eaeS0Q6wmpCtLSuHG8
         mOiSx+X9nkT07HaJ+FNUWG+JJWyJhh2rl+cIu9zuJ2OSZIQv5xXBKppdSCxBvZ4RUO+e
         bzgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=nChjs9v7vzkOoVWEE3yd43CYj88/kEyBj87DH/161nw=;
        b=YC2DauZJhqytAlHfstw4SF5hGtn3dCDydAjU9CdZnqj/uc0slXvd2xfzz2hyQVQ4W5
         g/DszWrdNLAHBICO0yxtGgnS3F++7vbnwheNRU+3GJHS7SXAET/n/+l1UsPxJmPauUKZ
         bSjToCHRMEMzyqLi/AeztHc8rKlsevrWzrQnTM8g0X7qq1aL8hixIQPjHpKUKAVkuirE
         rHRk7MVyniAEzOK67apZ82998pUcyWNrWFzqYOfYkzOSRiRT01Ddoyjuk3bzdKIS4DGL
         6jncgkvD7GDxVUNTAN0iwIwOvoDuY1lk3x+KZZBFjZWeRgms818FP3b/XB5eb7hqd0ZH
         Iftg==
X-Gm-Message-State: AOAM532F1EJ1vKIJXtzwfRDCv2DnsXYTAUe09IzotESpipThHaDqs/0r
        NJ0qvSEZWKBRt5boR3ZFKD1GRVmxztUM7sH2iFbt12VkcqxXqQ==
X-Google-Smtp-Source: ABdhPJwS6Y+cmqF5VyFGzJ6No1TH9dd+k1sISq4urUSJQpSEnPCUPg0ZCf3RCMEjDc9zCOVAS7z26cvxDzinrZ9inYQ=
X-Received: by 2002:a1f:320b:: with SMTP id y11mr4650996vky.57.1598337042777;
 Mon, 24 Aug 2020 23:30:42 -0700 (PDT)
MIME-Version: 1.0
References: <CAE8gLhn15dLELmeRy3TadcVg6UszxkhiB4tVL7NpEA_Q3m5sdg@mail.gmail.com>
 <CAJCQCtQHnyuhq-so15vZAKW7ih3GT++gUFj5s+AGTYfh=r143Q@mail.gmail.com>
In-Reply-To: <CAJCQCtQHnyuhq-so15vZAKW7ih3GT++gUFj5s+AGTYfh=r143Q@mail.gmail.com>
From:   MegaBrutal <megabrutal@gmail.com>
Date:   Tue, 25 Aug 2020 08:30:30 +0200
Message-ID: <CAE8gLh=iBLN7OgAHYggWUYP3xcoDPqwUaxqcYC=U9uKNdSnOJA@mail.gmail.com>
Subject: Re: Yet another guy with a "parent transid verify failed" problem
To:     Chris Murphy <lists@colorremedies.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Thanks, Chris!

Now I got something else...


[22116.465254] BTRFS critical (device dm-160): corrupt leaf:
block=3D28653215744 slot=3D22 extent bytenr=3D11525382144 len=3D958464 inva=
lid
generation, have 94701344 expect (0, 9898143]
[22116.465866] BTRFS: error (device dm-160) in
btrfs_run_delayed_refs:3083: errno=3D-5 IO failure
[22116.466480] BTRFS info (device dm-160): forced readonly


It seems a little friendlier as it doesn't lock the system like the
earlier message. When the previous "parent transid verify failed"
happened, it screwed up the system so much that I couldn't even do a
graceful reboot. (I couldn't even use sudo for example.) Luckily I
could stop the containers gracefully, but then I had to hard reset.


root@vmhost:~# btrfs fi us /
Overall:
    Device size:          20.46GiB
    Device allocated:          20.46GiB
    Device unallocated:           1.00MiB
    Device missing:             0.00B
    Used:              14.46GiB
    Free (estimated):           3.30GiB    (min: 3.30GiB)
    Data ratio:                  1.00
    Metadata ratio:              2.00
    Global reserve:         512.00MiB    (used: 0.00B)

Data,single: Size:16.95GiB, Used:13.64GiB
   /dev/mapper/vmhost--vg-vmhost--rootfs      16.95GiB

Metadata,DUP: Size:1.75GiB, Used:417.00MiB
   /dev/mapper/vmhost--vg-vmhost--rootfs       3.50GiB

System,DUP: Size:8.00MiB, Used:4.00KiB
   /dev/mapper/vmhost--vg-vmhost--rootfs      16.00MiB

Unallocated:
   /dev/mapper/vmhost--vg-vmhost--rootfs       1.00MiB


And... theoretically I started a scrub, but since the FS is read-only,
it can't record the status...


root@vmhost:~# btrfs scrub start /
WARNING: failed to open the progress status socket at
/var/lib/btrfs/scrub.progress.1b23076d-74fc-4091-9c02-fe3f02f02b96:
Read-only file system. Progress cannot be queried
WARNING: failed to write the progress status file: Read-only file
system. Status recording disabled
scrub started on /, fsid 1b23076d-74fc-4091-9c02-fe3f02f02b96 (pid=3D31845)
root@vmhost:~# btrfs scrub status /
scrub status for 1b23076d-74fc-4091-9c02-fe3f02f02b96
    no stats available
    total bytes scrubbed: 0.00B with 0 errors


So... I don't know how I will I know what it found. :/ Probably I
should have rebooted first or should have tried a remount,rw (no, that
doesn't work, because "Remounting read-write after error is not
allowed"). Now I don't know what to do because stopping all the
containers for a reboot and then restarting them is an ordeal, I won't
like if I have to do it often. At the moment I don't even have time
for that, and I'm having a SMART long test still running on one of the
drives.

I had 695 days of uptime before the power failure happened, so it
doesn't seem common, though it might be relevant that up to the day of
the failure, I was using a 2018 kernel build, because I had that as
the latest when I last started the system. :D And now I rebooted with
~2 year newer kernel as I had it installed but never actually booted
with it before. But it's the same major kernel version as the earlier
that comes with Ubuntu 18.04 (4.15.0-112-generic).

Can I add two linear LVs to BTRFS raid1, or shall I go with raw
partitions? Reclaiming space from LVM to create partitions would be
cumbersome, and I wouldn't like it as I couldn't resize and move the
FS dynamically like with LVM, so I'd probably pass on that. But the
former option would be possible.

I'm going ahead with this question, but I'm planning to add two SSDs
to the system in the following months, and move the root file system
to the SSD. Is there anything I should watch out for when I'm moving
and then using the file system, or can I just pvmove and then add the
"ssd" and probably "discard" mount options?


~ MegaBrutal



Chris Murphy <lists@colorremedies.com> ezt =C3=ADrta (id=C5=91pont: 2020. a=
ug.
25., K, 1:41):
>
> On Mon, Aug 24, 2020 at 5:01 PM MegaBrutal <megabrutal@gmail.com> wrote:
> >
> > Hi all,
> >
> > My home server computer with BTRFS root file system suffered a power
> > supply failure recently which caused a sudden power loss.
> >
> > Now the OS (Ubuntu 18.04) boots properly and it starts a bunch of LXC
> > containers with the applications the server is supposed to host. After
> > a certain time of running normally, the root filesystem gets remounted
> > read-only and the following messages appear in dmesg. Fortunately, the
> > file systems of the containers are not affected (they are mounted from
> > separate LVs).
> >
> > [57038.544637] BTRFS error (device dm-160): parent transid verify
> > failed on 169222144 wanted 9897860 found 9895362
>
> On the surface that looks like 1500 transaction IDs have been dropped.
> But it's more likely that this location has long since been
> deallocated and the recent commit should have been written there
> before the super block, but for some reason (firmware bug?) the
> current superblock was written before the metadata writes had been
> committed to stable media.
>
> That is, lost writes. It could be write order failure, and then you
> just got unlucky and had a crash so it turned into a lost write. Had
> there been no crash, eventually the write would have happened. It
> being out of order wouldn't matter.
>
> It's possible that the drive does this all the time. It's also
> possible it's 1 in 100 fsync/fua commands.
>
>
> > The usebackuproot mount was successful, but I'm not sure how it's
> > supposed to work... does it correct the file system after one mount
> > and then I'm supposed to mount the file system normally?
>
> That usebackuproot succeeded does further suggest a write order
> failure. The super block made it, but the tree root didn't or whatever
> exactly it's failing on that it expects but isn't there.
>
> The way it works it it'll try to use backup roots for mounting, these
> backup roots are in the super block. It's sorta like a "rollback"
> which means you are probably missing up to 1 minute's worth of data
> loss between the time of the crash and the last properly completed
> commit in which everything made it on stable media.
>
> At this point it's probably fixed. But it's possible this would have
> gone slightly better if the setup were using Btrfs raid1, because in
> that case there's a chance one drive didn't drop that write, and Btrfs
> would find what it wants on that drive, automatically.
>
> But you should do a `btrfs scrub` to see if there are other issues.
> And when you get a chance it's ideal to `btrfs check` because scrub
> only checks the checksums.
>
> Disabling the write caches in both drives might reduce the chance of
> this happening, but without testing it may only end up reducing write
> performance though probably not by much.
>
>
> >Or should I
> > always use the file system with usebackuproot from now on?
>
> No need. But even if you use it, btrfs will figure out the current
> root is OK and use it.
>
>
> >(It doesn't
> > feel right.) Anyway, after one mount with usebackuproot, now I started
> > the system regularly. But I'm not sure if it solved the problem,
> > whether usebackuproot did anything, especially that now I rebooted
> > with regular mount options. Since the problem presents itself after
> > hours of normal operation, I'm afraid that it might come back anytime.
> >
> > What to do if the problem reemerges?
>
> If either drive is dropping writes, there's a chance it'll really
> confuse the file system. And md raid1 scrub check just detects
> differences, it doesn't know which is correct. And if you do an md
> raid1 scrub repair then it just picks one as correct and stomps on the
> other one.
>
> What do you get for 'btrfs fi us /' ?
>
> Hopefully metadata is at least dup profile.
>
> In the short term I'd probably disable write caching on both drives
> because even if it's slower, it's incrementally safer. And also stop
> having power failures :D
>
> And in the longer term you want to redo this setup to use Btrfs raid1.
> That way it will explicitly rat out which of the two drives is
> dropping writes on power failures.
>
> --
> Chris Murphy
