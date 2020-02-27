Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4D4DF1716FB
	for <lists+linux-btrfs@lfdr.de>; Thu, 27 Feb 2020 13:20:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728976AbgB0MUe (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 27 Feb 2020 07:20:34 -0500
Received: from mail-yw1-f49.google.com ([209.85.161.49]:44672 "EHLO
        mail-yw1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728956AbgB0MUe (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 27 Feb 2020 07:20:34 -0500
Received: by mail-yw1-f49.google.com with SMTP id t141so2749657ywc.11
        for <linux-btrfs@vger.kernel.org>; Thu, 27 Feb 2020 04:20:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6bfYsjkBV6RkETF5mF1owy2rXvYyJWsQ5xa0+ZYKPlA=;
        b=bBgQXIEkMkHgYclCh2ZVNHGLU+OUNxHb+SaULcEkxqcEEXTy7kmuMvvmph+dDnks62
         uxNNMbvDwVrzHEwmnGBeUowwYJC/3JMCxh70H40dsRB7F6bWZ01P5BLxYLIGW1Af118n
         5rndfSolcAf/Iw6enPVlVxDwHliYRh+7gqAzAarS3xHhpRTp3X7uSHxj4touTjN1FfL2
         fLOz0qMOlqK8Z7GdG/qcDCa/z19vHx+eMuq8ppfKumn2+nVrKiGIoV7Sgh5oxyfqFffd
         d/XVjuy8e1XhrEyiCBENkJaNDuByJU8xKyOfCNRk9x+WBdJp5N6FW16y0mbM4tLb4Jow
         oZEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6bfYsjkBV6RkETF5mF1owy2rXvYyJWsQ5xa0+ZYKPlA=;
        b=QtfKcqf065v2b6t4DUjkUxpLkYYYvXBlOprW3oCSNG0FnA4wa5k0/jW0xdRIieXuhK
         yoHeFOgL8o3m1M0sqmzwJ2ScojkOq3t0hLRZbROYDYBLn4AMOI3j+vHG5Vs25PbnC3p1
         YmTdcfZd5mJRgk+OErfMffCm/IM/21dDZHNMDC00FJuUnoHj+qDPzvTyboJnyapa1W2N
         XewxPl5pKunix1xol2J/eGfDoRkOkmsEKrS7opLXrX3sSGLD50eTfI4WfPeqjViFT5ea
         mze8NH9xjcXF4vibdNyfSAoxdGLT4SWd5m3mWXXJhJ4SstzFdfkBKYFl84LN1QoZvadZ
         TZHw==
X-Gm-Message-State: APjAAAV8dg5bxzqT9KevnnBwUGCNKP6aZb2o5XGAYI0CA1iUp4gig1K/
        W04EEPzp9OFArTh6LT/64vWSDI6ixla26UQydIY=
X-Google-Smtp-Source: APXvYqy13LUaQ3CFbu425CTu/9xqM6cnpFIDXvnLTBTAOZR8b8MIbn7OwmEHOKT9EWhUVprllB+Ofh5yU5vxfk36NMQ=
X-Received: by 2002:a81:6908:: with SMTP id e8mr1114745ywc.432.1582806033039;
 Thu, 27 Feb 2020 04:20:33 -0800 (PST)
MIME-Version: 1.0
References: <CAAW2-ZfunSiUscob==s6Pj+SpDjO6irBcyDtoOYarrJH1ychMQ@mail.gmail.com>
 <2fe5be2b-16ed-14b8-ef40-ee8c17b2021c@gmx.com> <CAAW2-Zfz8goOBCLovDpA7EtBwOsqKOAP5Ta_iS6KfDFDDmn47g@mail.gmail.com>
 <60fba046-0aef-3b25-1e7d-7e39f4884ffe@gmx.com> <CAAW2-ZdczvEfgKb++T9YGSOMxJB+jz3_mwqEt2+-g0Omr7tocQ@mail.gmail.com>
 <CAG_8rEfjNPwT4g2DwbS9atsurLvYazt7aV4o77HGv-fssNmheQ@mail.gmail.com> <CAJCQCtTYBOUDmWBAA4BAenkyZS6uY+f6Ao33uHMmr_16M_1Buw@mail.gmail.com>
In-Reply-To: <CAJCQCtTYBOUDmWBAA4BAenkyZS6uY+f6Ao33uHMmr_16M_1Buw@mail.gmail.com>
From:   Steven Fosdick <stevenfosdick@gmail.com>
Date:   Thu, 27 Feb 2020 12:20:21 +0000
Message-ID: <CAG_8rEcXpWUyUqmi3fe8BicZXQODJP2ZS69Z=BBcBPfAQBuSHA@mail.gmail.com>
Subject: Re: USB reset + raid6 = majority of files unreadable
To:     Chris Murphy <lists@colorremedies.com>
Cc:     Jonathan H <pythonnut@gmail.com>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Chris,

Thanks for getting back to me.  I have read your subsequent e-mails too.

On Thu, 27 Feb 2020 at 00:39, Chris Murphy <lists@colorremedies.com> wrote:

> Both read and write errors reported by the hardware. These aren't the
> typical UNC error though. I'm not sure what DID_BAD_TARGET means. Some
> errors might be suppressed.

What are UNC errors?  My suspicion is that the drive failed in some
catastrophic way rather than just experiencing a larger number of
errors.  Upon rebooting the drive made lots of clicking noises but did
not respond to whatever probe the BIOS does to find hard drives.

> Write errors are generally fatal. Read errors, if they include sector
> LBA, Btrfs can fix if there's an extra copy (dup, raid1, raid56, etc),
> otherwise, it may or may not be fatal depending on what's missing, and
> what's affected by it being missing.
>
> Btrfs might survive the write errors though with metadata raid1c3. But
> later you get more concerning messages...

So if each of these writes had succeeded, in that the drive reported
success, but then the drive was subsequently unable to read the data
back surely btrfs should be able to reconstruct the data in the failed
write as it will either be mirrored, in the case of metadata, or
raid5, in the case of data.  So why should this be worse if the drive
reports that the write has failed?

> Ahhh yeah. So for what it's worth, in an md driver backed world, this
> drive would have been ejected (faulty) upon the first write error. md
> does retries for reads but writes it pretty much considers the drive
> written off, which means the array is degraded.

That sounds very sensible.

> As btrfs doesn't have such a concept of faulty drives, ejected drives,
> yet; you kinda have to keep an eye on this, and setup monitoring so
> you know when the array goes degraded like this.

So given that I probably don't have a spare drive lying around to
replace the failed one and also given that this server is not
hot-plug, is there anything, other than just alerting me, that this
monitoring could do automatically to minimise or avoid damage to the
filesystem?  Can be btrfs be instructed to mark a drive missing and go
into degraded mode on-line?

> You need to replace the bad drive, and do a scrub to fix things up.

Qu previously asked Jonathan for the output of btrfs check.
I ran 'btrfs check --force --check-data-csum /dev/sda'
and it found no errors.  Does this check all accessible devices in the
filesystem or just the one specified on the command line?

I'll resume the scrub I started earlier.

> And double check with 'btrfs fi us /mountpoint/' that all block groups
> have one profile set, and that it's the correct one.

Here is the output:

# btrfs fi us /data
WARNING: RAID56 detected, not implemented
Overall:
    Device size:   21.83TiB
    Device allocated:   30.06GiB
    Device unallocated:   21.80TiB
    Device missing:    5.46TiB
    Used:   25.44GiB
    Free (estimated):      0.00B (min: 8.00EiB)
    Data ratio:       0.00
    Metadata ratio:       2.00
    Global reserve: 512.00MiB (used: 0.00B)

Data,RAID5: Size:8.93TiB, Used:8.93TiB (99.98%)
   /dev/sda    4.47TiB
   /dev/sdc    4.47TiB
   missing   65.00GiB
   /dev/sdb    4.40TiB

Metadata,RAID1: Size:15.00GiB, Used:12.72GiB (84.78%)
   /dev/sda    9.00GiB
   /dev/sdc   11.00GiB
   /dev/sdb   10.00GiB

System,RAID1: Size:32.00MiB, Used:816.00KiB (2.49%)
   /dev/sda   32.00MiB
   /dev/sdb   32.00MiB

Unallocated:
   /dev/sda 1006.00GiB
   /dev/sdc 1004.03GiB
   missing    5.39TiB
   /dev/sdb    1.04TiB

The only thing that looks odd to me is the overall summary in that
both "Device Allocated" and "Free (estimated)" seem wrong.

> That's not a good idea in my opinion... you really need to replace the
> drive. Otherwise you're doing a really expensive full rebalance while
> degraded, effectively. That means nothing else can go wrong or you're
> in much bigger trouble.

As you noted in your other e-mail I did add another device first.  I
would have used btrfs device replace but the documentation I found
said that the superblock of the device being removed needs to be
readable.  After the reboot the failed device was not found by the
BIOS or Linux so the superblock is not readable.

Is the documentation correct, or can device replace now cope with
completely unreadable devices?

> In particular it's really common for there to
> be a mismatch between physical drive SCT ERC timeouts, and the
> kernel's command timer. Mismatches can cause a of confusion because
> upon kernel timer being reached, it resets the block device that
> contains the "late" command, which then blows away that drive's entire
> command queue.

These are NAS-specific hard discs and the SCT ERC timeout is set to 70:


>
> https://raid.wiki.kernel.org/index.php/Timeout_Mismatch
>
>
> > Feb 10 19:38:36 meije kernel: BTRFS info (device sda): disk added /dev/sdb
> > Feb 10 19:39:18 meije kernel: BTRFS info (device sda): relocating
> > block group 10045992468480 flags data|raid5
> > Feb 10 19:39:27 meije kernel: BTRFS info (device sda): found 19 extents
> > Feb 10 19:39:34 meije kernel: BTRFS info (device sda): found 19 extents
> > Feb 10 19:39:39 meije kernel: BTRFS info (device sda): clearing
> > incompat feature flag for RAID56 (0x80)
> > Feb 10 19:39:39 meije kernel: BTRFS info (device sda): relocating
> > block group 10043844984832 flags data|raid5
>
> I'm not sure what's going on here. This is a raid6 volume and raid56
> flag is being cleared? That's unexpected and I dn't know why you have
> raid5 block groups on a raid6 array.
>
>
> > and at that point the device remove aborted with an I/O error.
>
> OK well you didn't include that so we have no idea if this I/O error
> is about the same failed device or another device. If it's another
> device it's more complicated what can happen to the array. Hence why
> timeout mismatches are important. And why it's important to have
> monitoring so you aren't running a degraded array for three days.
>
> >
> > I did discover I could use balance with a filter to balance much of
> > the onto the three working discs, away from the missing one but I also
> > discovered that whenever the checksum error appears the space cache
> > seems to get corrupted.  Any further balance attempt results in
> > getting stuck in a loop.  Mounting with clear_cache resolves that.
>
> This sounds like a bug. The default space cache is stored in the data
> block group which for you should be raid6, with a missing device it's
> effectively raid5. But there's some kind of conversion happening
> during the balance/missing device removal, hence the clearing of the
> raid56 flag per block group, and maybe this corruption is happening
> related to that removal.
>
> --
> Chris Murphy
