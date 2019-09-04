Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7E198A7AC4
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Sep 2019 07:36:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725966AbfIDFgn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 4 Sep 2019 01:36:43 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:35004 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725267AbfIDFgn (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 4 Sep 2019 01:36:43 -0400
Received: by mail-wm1-f68.google.com with SMTP id n10so1991709wmj.0
        for <linux-btrfs@vger.kernel.org>; Tue, 03 Sep 2019 22:36:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ghojf4VWeVETkHMlY+MuCZU5ZovZmZYTXE+9FTmJCiQ=;
        b=ieg2DscyaDu6lP8w3UWV2zZkBk8J1CxDiWlT/cA3Mvetd3mC1JOYvsWGldmmwWxeX1
         j0n98Y9V64xzNnEQ34XviEcRVL3LKnXMS2wEwH7KRjhJZbVSPQcnxQruYrDB+RQxXkf2
         NZTtWvy8b2u6MvKZr/B19/vayvWMTawSvJwnBHPfVQ4lFgfKDKYEoVGwvs+tIiFshe0d
         CIAJEpzGzhNL9CtDAImUd9At6GiEgVb7KTcUnGibUp64Ii1n18p1Kpt1qT9DvtjyLX+v
         DNbdAgWbIN4gxTh6Ua2Wbw37U4bb+dmKPggc+i1INxHUOpxSW/ZyS7a3Fn50+hHybkUJ
         cERw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ghojf4VWeVETkHMlY+MuCZU5ZovZmZYTXE+9FTmJCiQ=;
        b=seDraEuqnTtiTavkKO277s11lwxx4SEAirhM+KLEsZ9R0jQB9FxpOpvNZC8xu8lMoy
         Ibn9qYmDT+JunfIcNNZ3B6DHRpeNW8A8IbqDhC+zpy7Qh1E+rLtGNBdLqHHYFfZfhI98
         UXXtMpzqU07vnd6xG4Yrl6OUT4yZq6Ci/33eysy51Kr6o9KVBa4WE6FWiRD8aoxBO96R
         gLIXWXsV3rU4Zln25bTevHg5D8Q+vhQKqYbQu0Ep35zFK41A4spVLd77VxildA2skA4G
         2HzYcJgDoOyULcWcisishzi5QCIc9huCv7eELjkxV62YMwm4zjsSC0WENX/iJT7GSGsS
         wAlA==
X-Gm-Message-State: APjAAAUse0JfE1TbSCOjG/XcvOKYtaBABP+Uo70nc9Qr1a6n7fJ9JUSN
        /sJq5B2Piiw9H2H4JTSJi4iTRKX9O22bPo4Me+/kjeToUig=
X-Google-Smtp-Source: APXvYqybx2YwmRfmjo1C6ruTzFfkdQuU01IEPM+d9M5dY/nah/+bpouSXg1cpHTV/9F20VgJ4FdSCmzXULFmOTX+Gm0=
X-Received: by 2002:a1c:e709:: with SMTP id e9mr2745507wmh.65.1567575399893;
 Tue, 03 Sep 2019 22:36:39 -0700 (PDT)
MIME-Version: 1.0
References: <f58d5ec1-4b38-ad8b-068d-d3bb1f616ec2@liland.com>
 <CAJCQCtTqetLF1sMmgoPyN=2FOHu+MSSW-MGsN6NairLPdNmK+g@mail.gmail.com> <c57b8314-4914-628c-f62b-c5291a6be53c@liland.com>
In-Reply-To: <c57b8314-4914-628c-f62b-c5291a6be53c@liland.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Tue, 3 Sep 2019 23:36:29 -0600
Message-ID: <CAJCQCtT5WecG26YXE6EVwhv52xSY_sm8GqgLDoQbZBUom4Pw7Q@mail.gmail.com>
Subject: Re: Unmountable degraded BTRFS RAID6 filesystem
To:     Edmund Urbani <edmund.urbani@liland.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Sep 3, 2019 at 10:41 PM Edmund Urbani <edmund.urbani@liland.com> wrote:
>
> Also there are a few of these:
> Sep  1 21:10:17 phoenix kernel: ata6.00: exception Emask 0x0 SAct
> 0x10000020 SErr 0x0 action 0x0
> Sep  1 21:10:17 phoenix kernel: ata6.00: irq_stat 0x40000008
> Sep  1 21:10:17 phoenix kernel: ata6.00: failed command: READ FPDMA QUEUED
> Sep  1 21:10:17 phoenix kernel: ata6.00: cmd
> 60/20:28:80:66:09/00:00:50:01:00/40 tag 5 ncq dma 16384 in\x0a
> res 41/40:00:88:66:09/00:00:50:01:00/40 Emask 0x409 (media error) <F>
> Sep  1 21:10:17 phoenix kernel: ata6.00: status: { DRDY ERR }
> Sep  1 21:10:17 phoenix kernel: ata6.00: error: { UNC }
> Sep  1 21:10:17 phoenix kernel: ata6.00: configured for UDMA/133
> Sep  1 21:10:17 phoenix kernel: sd 5:0:0:0: [sdf] tag#5 UNKNOWN(0x2003)
> Result: hostbyte=0x00 driverbyte=0x08
> Sep  1 21:10:17 phoenix kernel: sd 5:0:0:0: [sdf] tag#5 Sense Key : 0x3
> [current]
> Sep  1 21:10:17 phoenix kernel: sd 5:0:0:0: [sdf] tag#5 ASC=0x11 ASCQ=0x4
> Sep  1 21:10:17 phoenix kernel: sd 5:0:0:0: [sdf] tag#5 CDB: opcode=0x88
> 88 00 00 00 00 01 50 09 66 80 00 00 00 20 00 00
> Sep  1 21:10:17 phoenix kernel: print_req_error: I/O error, dev sdf,
> sector 5637760640
> Sep  1 21:10:17 phoenix kernel: BTRFS error (device sdb1): bdev
> /dev/sdf1 errs: wr 0, rd 289, flush 0, corrupt 0, gen 0
> Sep  1 21:10:17 phoenix kernel: ata6: EH complete
> Sep  1 21:10:17 phoenix kernel: BTRFS warning (device sdb1): sdb1
> checksum verify failed on 70943861833728 wanted 49137758 found 776101D6
> level 0
> Sep  1 21:10:17 phoenix kernel: BTRFS warning (device sdb1): sdb1
> checksum verify failed on 70943861833728 wanted 49137758 found 776101D6
> level 0
> Sep  1 21:10:17 phoenix kernel: BTRFS warning (device sdb1): sdb1
> checksum verify failed on 70943861833728 wanted 49137758 found 776101D6
> level 0
> Sep  1 21:10:17 phoenix kernel: BTRFS warning (device sdb1): sdb1
> checksum verify failed on 70943861833728 wanted 49137758 found 776101D6
> level 0
> Sep  1 21:10:17 phoenix kernel: BTRFS warning (device sdb1): sdb1
> checksum verify failed on 70943861833728 wanted 49137758 found 776101D6
> level 0
> Sep  1 21:10:17 phoenix kernel: BTRFS warning (device sdb1): sdb1
> checksum verify failed on 70943861833728 wanted 49137758 found 776101D6
> level 0
> Sep  1 21:10:17 phoenix kernel: BTRFS warning (device sdb1): sdb1
> checksum verify failed on 70943861833728 wanted 49137758 found 776101D6
> level 0
> Sep  1 21:10:17 phoenix kernel: BTRFS warning (device sdb1): sdb1
> checksum verify failed on 70943861833728 wanted 49137758 found 776101D6
> level 0
> Sep  1 21:10:17 phoenix kernel: BTRFS warning (device sdb1): sdb1
> checksum verify failed on 70943861833728 wanted 49137758 found 776101D6
> level 0

OK so the file system is not degraded, but sdb1 is giving you
problems, so you've deleted it and its in the process of being removed
(fs shrink, move chunks, and restripe).

Here /dev/sdf has  issued an uncorrectable read error. Classic case of
bad sector. And btrfs is trying to get data off sdb1 to try and fix
it, but this fails with checksum errors multiple times. So basically
it is a two device failure for the stripe currently being read. It
should still be possible to recover the stripe unless there is one
more error from another drive - but the included dmesg doesn't go on
far enough to tell us how this event turned out.


> I am still looking for log entries related to the filesystem going
> read-only. Not sure when exactly that happened and the logs are spammed
> with plenty of the above...

They're relevant because if there's a third failure at the same time,
and if it affects metadata, reconstruction isn't possible, the
metadata is missing. So then it's, what's missing and can it be
manually reconstructed. It's super tedious.





> >> [ 8904.358088] BTRFS info (device sda1): allowing degraded mounts
> >> [ 8904.358089] BTRFS info (device sda1): disk space caching is enabled
> >> [ 8904.358091] BTRFS info (device sda1): has skinny extents
> >> [ 8904.361743] BTRFS warning (device sda1): devid 8 uuid
> >> 0e8b4aff-6d64-4d31-a135-705421928f94 is missing
> >> [ 8905.705036] BTRFS info (device sda1): bdev (null) errs: wr 0, rd
> >> 14809, flush 0, corrupt 4, gen 0
> >> [ 8905.705041] BTRFS info (device sda1): bdev /dev/sda1 errs: wr 0, rd
> >> 4, flush 0, corrupt 0, gen 0
> >> [ 8905.705052] BTRFS info (device sda1): bdev /dev/sdf1 errs: wr 0, rd
> >> 10543, flush 0, corrupt 0, gen 0
> >> [ 8905.705062] BTRFS info (device sda1): bdev /dev/sdc1 errs: wr 0, rd
> >> 8, flush 0, corrupt 0, gen 0
> > four devices with read errors
> >
> > When was the last time the volume was scrubbed? Do you know for sure
> > these errors have not gone up at all since the last successful scrub?
> > And were any errors reported for that last scrub?
> Oh, that must have been quite a while ago. Sometime in 2018? Maybe? All
> these drives have been up and running for several years now. sda and sdc
> should still be fine, the replaced drive is sdb and sdf is next in line.

There's evidence of four drives with problems at some point in time.
And there's evidence in the kernel messages above of at least two
problems at the same time with the same stripe. So, all it takes is
one more problem with that stripe, and then that stripe can't be
recovered - and if it's a metadata stripe? That's 512KiB of metadata
lost, which is quite a lot, it probably kills the file system,
depending on where it happens. If it's data - no big deal. Btrfs won't
even care, it will just report EIO and the path to the bad file, and
continue on.

The whole point of regular scrubs is to prevent single sector
corruptions and failures. If you don't do that, they can accumulate
over time and then it's a huge problem when just one drive dies. So
when did you last do a scrub? Are they all the same make model drive?
Do they all have the same SCT ERC value? And is that value, for all
drives, less than the value found at /sys/block/sdN/device/timeout ?



> >
> >
> >> I have tried all the mount / restore options listed here:
> >> https://forums.unraid.net/topic/46802-faq-for-unraid-v6/page/2/?tab=comments#comment-543490
> > Good. Stick with ro attempts for now. Including if you want to try a
> > newer kernel. If it succeeds to mount ro, my advice is to update
> > backups so at least critical information isn't lost. Back up while you
> > can. Any repair attempt makes changes that will risk the data being
> > permanently lost. So it's important to be really deliberate about any
> > changes.
> I'll let you know, when I have the new kernel up and running.

I think you should have all the original drives installed, and try to
mount -o ro first. And if that doesn't work, try -o ro,degraded, and
then we'll just have to see which drive it doesn't like.



--
Chris Murphy
