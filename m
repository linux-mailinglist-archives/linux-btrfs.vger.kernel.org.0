Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B05FF1C1E26
	for <lists+linux-btrfs@lfdr.de>; Fri,  1 May 2020 21:59:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726930AbgEAT7G (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 1 May 2020 15:59:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726377AbgEAT7F (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 1 May 2020 15:59:05 -0400
Received: from mail-oo1-xc43.google.com (mail-oo1-xc43.google.com [IPv6:2607:f8b0:4864:20::c43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA1D0C061A0C
        for <linux-btrfs@vger.kernel.org>; Fri,  1 May 2020 12:59:05 -0700 (PDT)
Received: by mail-oo1-xc43.google.com with SMTP id q204so975993ooq.1
        for <linux-btrfs@vger.kernel.org>; Fri, 01 May 2020 12:59:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9o41ZOZdkZnmDCeb+txJzc+aYR3RspfDqQSNyPkD7kE=;
        b=L7xAyv94YKqs0toEJ+HmVusGtjfHxxYXIldS7b6icMsteBbKSIVhjJKOMeVf7nTwee
         jjg2e2tYpqNT+cNJZKyeZy03ue5PZtbeOR7tjQgaP8Q0mqsSRiaxuUBU4qFMQBMECTj2
         w3MXB9Px17fNpqtJ5QjAthmrarN5Iabxv7c3Lc+zeXNZOATdByE/VCxPJpzKsTSan3Iy
         U+27wYk/YRnjeq+vssz5iawKdFu7BhhIk5klz3v8SAHJ4vGzhRA0yPqU3qp+32k1NZpP
         Qqykg5hqmc7AZs3jVTxVk0QgXU2m8hPyZwzLBl5r8C6DquRFi3BPa5+psYbpOIn/TEgu
         UNpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9o41ZOZdkZnmDCeb+txJzc+aYR3RspfDqQSNyPkD7kE=;
        b=jteElSyc2/ojH5xeq7QyQ4niPUYdeM5HREXYP+P1f6HHbQZKDL7fFsACDB6LW6O/XO
         9Syv+biN5uxxcLOfkv7O5fQhOV9vvF0irKx+ZUfU/CLSGiFvfpnkllmjxVh8JDcGYSAm
         aUYoUzFOtYgiPhJMk5L/gSUP5JSaaYaCkTEW3L9lKKJ/BaNGCsNA0LdK7S3OFeMjR/eF
         DQaUdwB70p2kmokXfJ394mYI69RH1UNP6O7EcS9++Mcpa6uA22+UUBA1vKpPxLx7ouRJ
         Fm2JJJDLhbnrqJhESNKLuBgIa7BmlPaCBJU6Hb0fDo0AWKrGJ4pVB+VsowgVA5/YVj5L
         ZjAw==
X-Gm-Message-State: AGi0PubXaB3gO0mXZ0la5CH69iIWBjHPeAGi4n/Uh5XEarX28y0QEqMV
        jLA1LjbC4iiR5zoeS/XCMP8SDJh925Iu9A+nvLkCx1t5w5U=
X-Google-Smtp-Source: APiQypLowKwX6KD+NnxXO/psUcIDyLjchn3GxGnAMHjoNRCUf93c4s4vOG1QdBNqLPY8E71VJ0xsHW3LygNUHttU7t4=
X-Received: by 2002:a4a:ea91:: with SMTP id r17mr1847265ooh.18.1588363144965;
 Fri, 01 May 2020 12:59:04 -0700 (PDT)
MIME-Version: 1.0
References: <CAAhjAp1zghNnRpbA2WypBU9+Azeui8kTQiTj+DfbK-iX-z71WQ@mail.gmail.com>
 <CAJCQCtS7mbjEVchwbJS86ujAW+TrKHBk23oYtTNQnruiUr0XSg@mail.gmail.com>
In-Reply-To: <CAJCQCtS7mbjEVchwbJS86ujAW+TrKHBk23oYtTNQnruiUr0XSg@mail.gmail.com>
From:   Rollo ro <rollodroid@gmail.com>
Date:   Fri, 1 May 2020 21:58:29 +0200
Message-ID: <CAAhjAp33Kan3Aco1CWBVh54tatexNs3w=qJqLHq6yQjxzRjjjQ@mail.gmail.com>
Subject: Re: Can't repair raid 1 array after drive failure
To:     Chris Murphy <lists@colorremedies.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Am Fr., 1. Mai 2020 um 19:52 Uhr schrieb Chris Murphy <lists@colorremedies.com>:
>
> On Fri, May 1, 2020 at 11:02 AM Rollo ro <rollodroid@gmail.com> wrote:
> >
> > Hi again,
> > I'm still running into problems with btrfs. For testing purposes, I
> > created a raid 1 filesystem yesterday and let the computer copy a ton
> > of data on it over night:
> >
> > Label: 'BTRFS1'  uuid: 61e5aba9-6811-46ae-9396-35a72d3b1117
> >         Total devices 3 FS bytes used 1.15TiB
> >         devid    1 size 5.46TiB used 1.16TiB path /dev/sdc1
> >         devid    3 size 698.64GiB used 10.00GiB path /dev/sdf
> >         devid    4 size 1.82TiB used 1.15TiB path /dev/sde
> >
> > Today I started scrub and looked at the status some hours later, which
> > gave thousands of errors on drive 4:
>
> What happened to devid 2?

I added number 3 and removed 2 earlier. That worked without problems.

>
> >
> > root@OMV:/var# btrfs scrub status /srv/dev-disk-by-label-BTRFS1/
> > scrub status for 61e5aba9-6811-46ae-9396-35a72d3b1117
> >         scrub started at Fri May  1 11:37:36 2020, running for 04:37:48
> >         total bytes scrubbed: 1.58TiB with 75751000 errors
> >         error details: read=75751000
> >         corrected errors: 0, uncorrectable errors: 75750996,
> > unverified errors: 0
> >
> > (Not shown here that it was drive 4, but it was)
> >
> > Then found that the drive is missing:
> >
> > Label: 'BTRFS1'  uuid: 61e5aba9-6811-46ae-9396-35a72d3b1117
> >         Total devices 3 FS bytes used 1.15TiB
> >         devid    1 size 5.46TiB used 1.16TiB path /dev/sdc1
> >         devid    3 size 698.64GiB used 10.00GiB path /dev/sdf
> >         *** Some devices missing
> >
> > Canceled scrub:
> > root@OMV:/var# btrfs scrub cancel /srv/dev-disk-by-label-BTRFS1/
> > scrub cancelled
> >
> > Stats showing lots of error on sde, which is the missing drive:
> > root@OMV:/var# btrfs device stats /srv/dev-disk-by-label-BTRFS1/
> > [/dev/sdc1].write_io_errs    0
> > [/dev/sdc1].read_io_errs     0
> > [/dev/sdc1].flush_io_errs    0
> > [/dev/sdc1].corruption_errs  0
> > [/dev/sdc1].generation_errs  0
> > [/dev/sdf].write_io_errs    0
> > [/dev/sdf].read_io_errs     0
> > [/dev/sdf].flush_io_errs    0
> > [/dev/sdf].corruption_errs  0
> > [/dev/sdf].generation_errs  0
> > [/dev/sde].write_io_errs    154997860
> > [/dev/sde].read_io_errs     77170574
> > [/dev/sde].flush_io_errs    310
> > [/dev/sde].corruption_errs  0
> > [/dev/sde].generation_errs  0
> >
> >
> > I tried to replace
> > root@OMV:/var# btrfs replace start 2 /dev/sdb /srv/dev-disk-by-label-BTRFS1/ &
> > [1] 1809
> > root@OMV:/var# ERROR: '2' is not a valid devid for filesystem
> > '/srv/dev-disk-by-label-BTRFS1/'
> >
> > --> That's inconsistent with the device remove syntax, as it allows to
> > use a non-existing number? I try again using the /dev/sdx syntax, but
> > as sde is gone, I rescan and now it's sdi!
>
> devid 2 was missing from the very start of the email, so it is not a
> valid source for removal.

OK, I thought that any non-existing number can be used.

>
> And devices vanishing and reappearing as other nodes suggests they're
> on a flakey or transient bus. Are these SATA drives in USB enclosures?
> And if so how are they connected?

No, all the hard drives are internal drives connected to the
mainboard's SATA connectors. Additionaly there is an USB flash drive
for booting but that is not used for btrfs.

>
> A complete dmesg please (not trimmed, starting at boot) would be useful.

dmesg is spammed with btrfs warnings and errors, so all earlier
content is already gone. I can increase the buffer in grub
configuration and provide the complete dmesg next time.

>
> One device is missing, and another one vanished and reappeared, I
> don't know whether Btrfs can really handle this case perfectly.

But the first device I have removed, which worked without problems. I
had a healthy raid 1 of two disks then. I don't know why the other
drive got a new device name, but that may cause some extra problems.
Meanwhile I read about the timeout mismatch and will add the small
script from https://raid.wiki.kernel.org/index.php/Timeout_Mismatch
Maybe this prevents the drive to disappear in first place.

>
> > Version info:
> > btrfs-progs v4.20.1
> > Kernel 5.4.0-0.bpo.4-amd64
>
> It's probably not related to the problem, which seems to be hardware
> related.

I also guess there could be hardware problems. This is for testing and
practicing now. Later I will only keep the 6TB drive of my old drives
and get two new drives. And new cables.

> But btrfs-progs v4.20.1 is ~16 months development behind v5.6
> which is current. And thousands of changes in the kernel just for
> Btrfs.
> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/diff/?id=v5.6.8&id2=v5.4&dt=2

I use a Debian based NAS distribution (OpenMediaVault) that doesn't
provide a more recent version. I havn't figured out yet how to get a
more recent version as my Linux knowledge is quite limited.

While looking at dmesg I found this:
[Fri May  1 16:25:15 2020] BTRFS warning (device sdc1): lost page
write due to IO error on /dev/sde
[Fri May  1 16:25:15 2020] BTRFS error (device sdc1): error writing
primary super block to device 4
[Fri May  1 16:25:15 2020] BTRFS info (device sdc1): disk added /dev/sdb
[Fri May  1 16:25:49 2020] BUG: kernel NULL pointer dereference,
address: 0000000000000000

So I guess things are really messed up now. Maybe adding sdb has not
even worked correctly. I will increase the dmesg buffer and the fix of
the timeout problem and start again with a new filesystem.
Thanks for your help so far!

>
>
> --
> Chris Murphy
