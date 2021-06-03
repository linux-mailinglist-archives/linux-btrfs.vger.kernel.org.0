Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A60F239AE27
	for <lists+linux-btrfs@lfdr.de>; Fri,  4 Jun 2021 00:39:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229702AbhFCWlD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 3 Jun 2021 18:41:03 -0400
Received: from mail-wr1-f50.google.com ([209.85.221.50]:34661 "EHLO
        mail-wr1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbhFCWlC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 3 Jun 2021 18:41:02 -0400
Received: by mail-wr1-f50.google.com with SMTP id q5so7386138wrm.1
        for <linux-btrfs@vger.kernel.org>; Thu, 03 Jun 2021 15:39:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=va1w7+hEgGgzH5kxhkeyKo01UK+8UPv5JcTYKBvLv8g=;
        b=Af+6iOYgIs2+7WY8Gc651GXhaTSoPz/f+y/KuqO4dQcGdENHVDcOqxDfTIs8dnrPrk
         tBP6c564orcv2a3EyGRgSEGSu1zQc8HYVF0iWaXYtzTEA/6sERlfNybRENcfJ1F1Y+lT
         CX/6YTBu4RWBDVfqjNLHulvvl4ICw2slBrwtiYSpVJscG27BDeWdY00QKkKbfy0IstS/
         qRIan5AYWqiXSG8DT/Z9ET3gwRivi93mFflAeL/IQz8yLDs7B2wtQMUsvSDffTsQU8v2
         CH5rXzaoB4OqjSjnE+ltcIWj8QWhQ3+tReS9C7Siv7av3vxmVyL7MPhbAITQ9Gihgu1+
         Sv8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=va1w7+hEgGgzH5kxhkeyKo01UK+8UPv5JcTYKBvLv8g=;
        b=oNJW6J5/C7n4fO27woA12//rHwwZ/h7gxQvgr+Lc2PizeH0gZK+MvFHBEsW7MFoQRr
         utaQQ3JFo+OLmDwZ5hKlXey4UYCJnuEyH2P19/NuimHjlNGCy+WtQ7AHACMdkuNJnzLN
         5XMYpY6s/cd4gJsLCkHVFO96Q/Htf22hHPZECWi2xaT/JpoWvjJRIL9uZ0m9/K//W0HE
         uylYTCQhBIU/OsVaAeQ0RP4rt0OYtQ9b7HPfllxxqWIA9xOdOCRIvC9Eaa8yrjfFa0RR
         4Z/IXODI5apxFbOAVkqpU+4DaXmz8LcFWxtEe6O7KVrNA7ijBeciahR1TTNGrwavdD9c
         EfGQ==
X-Gm-Message-State: AOAM530nDFNxRfFB/NX98UBzUdP0wQfTPEArCVeDpmLjmO0ahe9glBXN
        R/AXxRqCbJxhCTjgrNj/Y2vDgPLodtz0PdoIgyIx7A==
X-Google-Smtp-Source: ABdhPJwfXhNEU+1q/p9FNNrQEM2aDKls3m+8BnU2BNop2ngVQEM416Iga2Lslf0F0iKNlJjbJ8FUEBUK+4LNXsbgIUM=
X-Received: by 2002:adf:8b4a:: with SMTP id v10mr654480wra.274.1622759896882;
 Thu, 03 Jun 2021 15:38:16 -0700 (PDT)
MIME-Version: 1.0
References: <cf633d62-73ab-1ce2-f31c-a4a8407a38b4@gmail.com>
In-Reply-To: <cf633d62-73ab-1ce2-f31c-a4a8407a38b4@gmail.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Thu, 3 Jun 2021 16:37:59 -0600
Message-ID: <CAJCQCtRkZPqQ_Rfx1Kk6rXZ_GyxDcLymdFjJkS12zZZ0mep3vQ@mail.gmail.com>
Subject: Re: Corrupted data, failed drive(s)
To:     Gaardiolor <gaardiolor@gmail.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jun 3, 2021 at 10:51 AM Gaardiolor <gaardiolor@gmail.com> wrote:
>
> Hello,
>
> I could use some help with some issues I'm having with my drives.
>
> I've got 4 disks in raid1.
> --
> [17:59:07]root@kiwi:/storage/samba/storage# btrfs filesystem df /storage/
> Data, RAID1: total=4.39TiB, used=4.38TiB
> System, RAID1: total=32.00MiB, used=720.00KiB
> Metadata, RAID1: total=6.00GiB, used=4.66GiB
> GlobalReserve, single: total=512.00MiB, used=0.00B
>
> [17:59:10]root@kiwi:/storage/samba/storage# btrfs filesystem show
> Label: none  uuid: 8ce9e167-57ea-4cf8-8678-3049ba028c12
>          Total devices 4 FS bytes used 4.38TiB
>          devid    1 size 3.64TiB used 3.10TiB path /dev/sdc
>          devid    2 size 3.64TiB used 3.14TiB path /dev/sdb
>          devid    3 size 1.82TiB used 1.32TiB path /dev/sda
>          devid    4 size 1.82TiB used 1.21TiB path /dev/sdd
> --
>
> I'm having some issues with faulty disk(s). /dev/sdd is bad for sure,
> SMART is complaining.
> --
> # smartctl -aq errorsonly /dev/sdd
> ATA Error Count: 108 (device log contains only the most recent five errors)
> Error 108 occurred at disk power-on lifetime: 47563 hours (1981 days +
> 19 hours)
> Error 107 occurred at disk power-on lifetime: 47563 hours (1981 days +
> 19 hours)
> Error 106 occurred at disk power-on lifetime: 47563 hours (1981 days +
> 19 hours)
> Error 105 occurred at disk power-on lifetime: 47563 hours (1981 days +
> 19 hours)
> Error 104 occurred at disk power-on lifetime: 47563 hours (1981 days +
> 19 hours)
> --
>
> Also in /var/log/messages:
> --
> Jun  3 17:47:21 kiwi smartd[1112]: Device: /dev/sdd [SAT], 3088
> Currently unreadable (pending) sectors
> Jun  3 17:47:21 kiwi smartd[1112]: Device: /dev/sdd [SAT], 3088 Offline
> uncorrectable sectors
> --
>
> However, the other disks also generate errors.
> --
> [18:00:35]root@kiwi:/storage/samba/storage# btrfs device stats /dev/sda
> [/dev/sda].write_io_errs    0
> [/dev/sda].read_io_errs     0
> [/dev/sda].flush_io_errs    0
> [/dev/sda].corruption_errs  408
> [/dev/sda].generation_errs  0
> [18:00:39]root@kiwi:/storage/samba/storage# btrfs device stats /dev/sdb
> [/dev/sdb].write_io_errs    0
> [/dev/sdb].read_io_errs     0
> [/dev/sdb].flush_io_errs    0
> [/dev/sdb].corruption_errs  322
> [/dev/sdb].generation_errs  0
> [18:00:42]root@kiwi:/storage/samba/storage# btrfs device stats /dev/sdc
> [/dev/sdc].write_io_errs    0
> [/dev/sdc].read_io_errs     0
> [/dev/sdc].flush_io_errs    0
> [/dev/sdc].corruption_errs  1283
> [/dev/sdc].generation_errs  0
> [18:00:43]root@kiwi:/storage/samba/storage# btrfs device stats /dev/sdd
> [/dev/sdd].write_io_errs    0
> [/dev/sdd].read_io_errs     1582
> [/dev/sdd].flush_io_errs    0
> [/dev/sdd].corruption_errs  1310
> [/dev/sdd].generation_errs  0
> -
>
> /dev/sdd is the only one with read_io_errs.
>
> I've tried unpacking a .tar.gz from /storage to another filesystem, but
> the tar.gz was obviously corrupt. Very strange filenames which were,
> because of the name, pretty difficult to remove. I will not post the
> filenames here, it'd probably crash the internet. I'm also getting:
> --
> gzip: stdin: invalid compressed data--crc error
> tar: Child returned status 1
> tar: Error is not recoverable: exiting now
> --
>
> I can't btrfs remove /dev/sdd . The command below ran for a while (I
> could see the allocated space of /dev/sdd decrease with btrfs fi us
> /storage/), but then errored:
> --
> root@kiwi:~# btrfs device remove /dev/sdd /storage/
>   ERROR: error removing device '/dev/sdd': Input/output error
> --
>
>
> I have a couple of questions:
>
> 1) Unpacking some .tar.gz files from /storage resulted in files with
> weird names, data was unusable. But, it's raid1. Why is my data corrupt,
> I've read that BTRFS checks the checksum on read ?

It suggests an additional problem, but we kinda need full dmesg to
figure it out I think. If it were just one device having either
partial or full failure, you'd get a bunch of messages indicating
those failure or csum mismatches as  well as fixup attempts which then
either succeed or fail. But no EIO. That there's EIO  suggests both
copies are somehow bad, so it could be two independent problems. That
there's four drives with a small number of reported corruptions could
mean some common problem affecting all of them: cabling or power
supply.


> 2) Are all my 4 drives faulty because of the corruption_errs ? If so, 4
> faulty drives is somewhat unusual. Any other possibilities ?
> 3) Given that
> - I can't 'btrfs device remove' the device
> - I do not have a free SATA port
> - I'd prefer a method that doesn't unnecessarily take a very long time

You really don't want to remove a drive unless it's on fire. Partial
failures, you're better off leaving it in, until ready to be replaced.
And even then it is officially left in until replace completes. Btrfs
is AOK with partially failing drives, it can unambiguously determine
when any block is untrustworthy. But the partial failure case also
means possibly quite a lot of *good* blocks that you might need in
order to recover from this situation, so you don't want to throw the
baby out with the bath water, so to speak.



>
> What's the best way to migrate to a different device ? I'm guessing,
> after doing some reading:
> - shutdown
> - physically remove faulty disk
> - boot
> - verify /dev/sdd is missing, and that I've removed the correct disk
> - shutdown
> - connect new disk, it will also be /dev/sdd, because I have no other
> free SATA port
> - boot
> - check that the new disk is /dev/sdd
> - mount -o degraded /dev/sda /storage
> - btrfs replace start 4 /dev/sdd /storage
> - btrfs balance /storage

You can but again this throws away quite a lot of good blocks, both
data and metadata. Only if all three of the other drives are perfect
is this a good idea and there's some evidence it isn't.

I'd say your top priority is freshen the backups of most important
things you cannot stand to lose from this file system in case it gets
much worse. Then try to figure out what's wrong and fix that. The
direct causes need to be discovered and fixed, and the above sequence
doesn't identify multiple problems; it just assumes it's this one
drive. And the available evidence suggests more than one thing is
going on. If this is cable or dirty/noisy power supply related, the
recovery process itself can be negatively affected and make things
worse (more corruptions).

I think a better approach, as finicky as they can be, is a USB SATA
enclosure connected to an externally powered hub. Really you want a
fifth SATA port, even if it's eSATA. But barring that, I think it's
less risky to keep all four drives together, to do the replacement.



-- 
Chris Murphy
