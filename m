Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E675C17456A
	for <lists+linux-btrfs@lfdr.de>; Sat, 29 Feb 2020 07:33:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726170AbgB2GbW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 29 Feb 2020 01:31:22 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:46143 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725817AbgB2GbW (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 29 Feb 2020 01:31:22 -0500
Received: by mail-wr1-f67.google.com with SMTP id j7so5727207wrp.13
        for <linux-btrfs@vger.kernel.org>; Fri, 28 Feb 2020 22:31:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2J5I9jBzSqSszH/W9vRa6XLuIpLtNr//nEMIIHioOao=;
        b=aaNqSwdfsG51DkSssWRqjZ8fxAEULpGLnDF8iibt4BlF+FSFecIC/kDV1qoaBIhIRQ
         aIQBnxJ9W6745eKylegDFCneNZKp4P7VxUBdU5E+upI7oVAsMr0OgGcgCAh+rbhohFws
         ThUtVMzlEcI7FK84LE8T9doKdm44ACIxU7wU0eH5kr+izBebNEKEpiivNLwwgLK3pVua
         SDNODmbk22MkF7VFJm0RFJKRZDoRjKPRpftCY9s2PtV4LpjuQnfM1ErKz3wAwQtrYUJJ
         N43TEqStc2yqbwDn0+iaxelKaEmfSfeD+b1TB9L1rpwQmTM1nzjW6CIjwPNNxHtBhQme
         OnEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2J5I9jBzSqSszH/W9vRa6XLuIpLtNr//nEMIIHioOao=;
        b=E7VgGpQ8ehpjEvzAt0UlOUuq2filv9cu6cFRkRr3V1jQM7nmy/guC+qRUmiqesTnQ3
         PkgVJIBSiZQnf5fBjxvw43yqH48kO4aNk3DJ/mOy1cP7UW4OEWXpqmce2oK331FBCc9v
         jWR4QbueKH9HEiz2D4C7EjhNjmCECCfXLS35SYsloM8C+D4IxfQN8/EXwJYt8GFucz6w
         m+9tWaqGz/hSxlIvTnDoR/qKk7k+rtrOO9JTC6t1l9ncf6LN/1V0jRpfMC94AbhjNOGn
         EaWF9akCoJOe9UIIeGq6A7XSMHa0EVt0jFZ9fOdmhN7TiZgfPEknqTKoweNo740vwrUb
         Etlg==
X-Gm-Message-State: APjAAAWi3b/08UHO8Z+dSGQVhxcv9kzFw2HWNeTIllJf/qRc/a7vxjXb
        kAFBxUuCUUHuqy0q5AuSgkupypkOh/ExgqQJg/4qkg==
X-Google-Smtp-Source: APXvYqxBUDbihbuS7cNPcnTIoKXX6kLIss7BY5t6y6To1p/FhxnddWJwp5dX9XcDazzxD8lIb4nCu0YGhazTLDrgDh0=
X-Received: by 2002:a5d:6881:: with SMTP id h1mr8818581wru.236.1582957878041;
 Fri, 28 Feb 2020 22:31:18 -0800 (PST)
MIME-Version: 1.0
References: <CAAW2-ZfunSiUscob==s6Pj+SpDjO6irBcyDtoOYarrJH1ychMQ@mail.gmail.com>
 <2fe5be2b-16ed-14b8-ef40-ee8c17b2021c@gmx.com> <CAAW2-Zfz8goOBCLovDpA7EtBwOsqKOAP5Ta_iS6KfDFDDmn47g@mail.gmail.com>
 <60fba046-0aef-3b25-1e7d-7e39f4884ffe@gmx.com> <CAAW2-ZdczvEfgKb++T9YGSOMxJB+jz3_mwqEt2+-g0Omr7tocQ@mail.gmail.com>
 <CAG_8rEfjNPwT4g2DwbS9atsurLvYazt7aV4o77HGv-fssNmheQ@mail.gmail.com>
 <CAJCQCtTYBOUDmWBAA4BAenkyZS6uY+f6Ao33uHMmr_16M_1Buw@mail.gmail.com> <CAG_8rEcXpWUyUqmi3fe8BicZXQODJP2ZS69Z=BBcBPfAQBuSHA@mail.gmail.com>
In-Reply-To: <CAG_8rEcXpWUyUqmi3fe8BicZXQODJP2ZS69Z=BBcBPfAQBuSHA@mail.gmail.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Fri, 28 Feb 2020 23:31:01 -0700
Message-ID: <CAJCQCtR7prMai9dYndLZ4Wg4tSL7kHZaLLK8c5p_4fDG2qoYnA@mail.gmail.com>
Subject: Re: USB reset + raid6 = majority of files unreadable
To:     Steven Fosdick <stevenfosdick@gmail.com>
Cc:     Chris Murphy <lists@colorremedies.com>,
        Jonathan H <pythonnut@gmail.com>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Feb 27, 2020 at 5:20 AM Steven Fosdick <stevenfosdick@gmail.com> wrote:
>
> Chris,
>
> Thanks for getting back to me.  I have read your subsequent e-mails too.
>
> On Thu, 27 Feb 2020 at 00:39, Chris Murphy <lists@colorremedies.com> wrote:
>
> > Both read and write errors reported by the hardware. These aren't the
> > typical UNC error though. I'm not sure what DID_BAD_TARGET means. Some
> > errors might be suppressed.
>
> What are UNC errors?

Uncorrectable (read or write). An error associated with bad sectors.

> > Btrfs might survive the write errors though with metadata raid1c3. But
> > later you get more concerning messages...
>
> So if each of these writes had succeeded, in that the drive reported
> success, but then the drive was subsequently unable to read the data
> back surely btrfs should be able to reconstruct the data in the failed
> write as it will either be mirrored, in the case of metadata, or
> raid5, in the case of data.  So why should this be worse if the drive
> reports that the write has failed?

s/might/should


>
> > As btrfs doesn't have such a concept of faulty drives, ejected drives,
> > yet; you kinda have to keep an eye on this, and setup monitoring so
> > you know when the array goes degraded like this.
>
> So given that I probably don't have a spare drive lying around to
> replace the failed one and also given that this server is not
> hot-plug, is there anything, other than just alerting me, that this
> monitoring could do automatically to minimise or avoid damage to the
> filesystem?  Can be btrfs be instructed to mark a drive missing and go
> into degraded mode on-line?

No. I'm not sure how to quiet the kernel noise that'll happen for
every write failure. You could stop all writes, unmount, remove the
offending drive, and mount degraded, and that'll be quiet. I haven't
tried yanking the bad drive, then using -o remount,degraded, so I'm
not sure if that will silence things.


>
> > You need to replace the bad drive, and do a scrub to fix things up.
>
> Qu previously asked Jonathan for the output of btrfs check.
> I ran 'btrfs check --force --check-data-csum /dev/sda'
> and it found no errors.  Does this check all accessible devices in the
> filesystem or just the one specified on the command line?

I'm curious why you had to use force, but yes that should check all of
them. If this is a mounted file system, there's 'btrfs scrub' for this
purpose though too and it can be set to run read-only on a read-only
mounted file system.

> > And double check with 'btrfs fi us /mountpoint/' that all block groups
> > have one profile set, and that it's the correct one.
>
> Here is the output:
>
> # btrfs fi us /data
> WARNING: RAID56 detected, not implemented
> Overall:
>     Device size:   21.83TiB
>     Device allocated:   30.06GiB
>     Device unallocated:   21.80TiB
>     Device missing:    5.46TiB
>     Used:   25.44GiB
>     Free (estimated):      0.00B (min: 8.00EiB)
>     Data ratio:       0.00
>     Metadata ratio:       2.00
>     Global reserve: 512.00MiB (used: 0.00B)
>
> Data,RAID5: Size:8.93TiB, Used:8.93TiB (99.98%)
>    /dev/sda    4.47TiB
>    /dev/sdc    4.47TiB
>    missing   65.00GiB
>    /dev/sdb    4.40TiB
>
> Metadata,RAID1: Size:15.00GiB, Used:12.72GiB (84.78%)
>    /dev/sda    9.00GiB
>    /dev/sdc   11.00GiB
>    /dev/sdb   10.00GiB
>
> System,RAID1: Size:32.00MiB, Used:816.00KiB (2.49%)
>    /dev/sda   32.00MiB
>    /dev/sdb   32.00MiB
>
> Unallocated:
>    /dev/sda 1006.00GiB
>    /dev/sdc 1004.03GiB
>    missing    5.39TiB
>    /dev/sdb    1.04TiB
>
> The only thing that looks odd to me is the overall summary in that
> both "Device Allocated" and "Free (estimated)" seem wrong.

That looks like a bug. I'd try a newer btrfs-progs version. Kernel 5.1
is EOL but I don't think that's related to the usage info. Still, tons
of btrfs bugs fixed between 5.1 and 5.5...
https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/diff/fs/btrfs/?id=v5.5&id2=v5.1

Including raid56 specific fixes:z
https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/diff/fs/btrfs/raid56.c?id=v5.5&id2=v5.1


> As you noted in your other e-mail I did add another device first.  I
> would have used btrfs device replace but the documentation I found
> said that the superblock of the device being removed needs to be
> readable.  After the reboot the failed device was not found by the
> BIOS or Linux so the superblock is not readable.
>
> Is the documentation correct, or can device replace now cope with
> completely unreadable devices?

I'm not sure what btrfs-progs version you've got or what man page
you're looking at. But replace will work whether the drive being
replaced is present or not.

man btrfs replace

           On a live filesystem, duplicate the data to the target
device which is currently stored on the source device. If the source
device is not available anymore, or if the -r option is set, the data
is built only using the RAID redundancy mechanisms.

There are two requirements that don't apply to add then remove. a) the
replacement drive needs to be the same size or bigger than the source;
b) fs resize is not automatically performed, so if the replacement
drive is bigger, and if you want to use all of that space you need to
use 'btrfs fi resize <devid>:max' or whatever size you want it set to.


-- 
Chris Murphy
