Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5432C26E1CF
	for <lists+linux-btrfs@lfdr.de>; Thu, 17 Sep 2020 19:09:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727150AbgIQRIo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 17 Sep 2020 13:08:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727137AbgIQRIe (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 17 Sep 2020 13:08:34 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98971C061788
        for <linux-btrfs@vger.kernel.org>; Thu, 17 Sep 2020 10:08:33 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id w5so2866483wrp.8
        for <linux-btrfs@vger.kernel.org>; Thu, 17 Sep 2020 10:08:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iYEWTUFHFof4A3+LUAxrs3RqDwrA+xrJMEv7p3PRbdc=;
        b=NfIK0YbJZCJJnCfEnJwGkGG8azR0qVzuauNi4Gmy9fo8ijH9L/j7cKdTmZq9gVzb7y
         Mvgk/FdN0Zq5zFN//DgtlYCRX3ZyJkJoUNppyUVG798OGIjkkRODG4T8H9f8+iVe5RMm
         xhVkO+u0R1IPInQkbYoTTO4bLXiehhaOU07EM0IgEchV5MOJp6fi0vO3tPqy8QOalN3+
         IDQiljBphYhPmjdqzYjy+Sx+d0e5AkrQSIjRlzSHOoTrjUpAMpG6POXWUsj9a8nNUpPa
         PYnpkkzANpHkNzlzTpeQrYfKBgb6e11TWLDFwLusOa3vAUu0IYWuJtCBedUlyS1yP5qR
         FbMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iYEWTUFHFof4A3+LUAxrs3RqDwrA+xrJMEv7p3PRbdc=;
        b=NdyzkM6GkvF73BkZg1uE8ohub3Bc3+gqppl7v7973WoFFJarOWzRWUlSHZPT1ndex4
         jGVCRbLoX1rDDAvKnilPDB9SX7ZXWwKL7Mat8CUg4un/JsJkcWMrUHhVR5UiU8P3Yc3Y
         0NqBCwyiYscSKzqnsdMSBPKVBadSe7F5sk8JezuOrd8pgx0PjGQPVz0oNtHk3hdXoyS9
         WlKiQMRi0AlIQiyRGTOEZ2w6Rin05oO8VTr2SRdc9snek6gAA78x5xqLa5Xh5pPOxUuh
         FFQkm9OgquL7rBCHMnz5Efzi4yEz8pYUwk2TG7GYPPRh2G17oEFzBD3A7RPW/pRTxuEM
         ZKOw==
X-Gm-Message-State: AOAM530WU5ujpdkWuwjESuLEOKWP9eDlWxEvBGHQof0uYNNS+GYCDyPJ
        /HK+Bo+MQuBq5l7kxGfD8JHGsusnnJZFn3hiIdOhzQ==
X-Google-Smtp-Source: ABdhPJzhScIpyI3tS/M2fGQYCPGtED4ia91t6ycwn1X0AoOnpiUC7CLenzrvOIqwfTEeEggtzjHkekQvDHO8kZTyM/g=
X-Received: by 2002:adf:b74b:: with SMTP id n11mr7642087wre.274.1600362509778;
 Thu, 17 Sep 2020 10:08:29 -0700 (PDT)
MIME-Version: 1.0
References: <d3fced3f-6c2b-5ffa-fd24-b24ec6e7d4be@xmyslivec.cz>
 <CAJCQCtSfz+b38fW3zdcHwMMtO1LfXSq+0xgg_DaKShmAumuCWQ@mail.gmail.com>
 <29509e08-e373-b352-d696-fcb9f507a545@xmyslivec.cz> <CAJCQCtRx7NJP=-rX5g_n5ZL7ypX-5z_L6d6sk120+4Avs6rJUw@mail.gmail.com>
 <695936b4-67a2-c862-9cb6-5545b4ab3c42@xmyslivec.cz> <CAJCQCtQWNSd123OJ_Rp8NO0=upY2Mn+SE7pdMqmyizJP028Yow@mail.gmail.com>
 <2f2f1c21-c81b-55aa-6f77-e2d3f32d32cb@xmyslivec.cz> <CAJCQCtTQN60V=DEkNvDedq+usfmFB+SQP2SBezUaSeUjjY46nA@mail.gmail.com>
 <4b0dd0aa-f77b-16c8-107b-0182378f34e6@xmyslivec.cz> <CAJCQCtQWh2JBAL_SDRG-gMd9Z1TXad7aKjZVUGdY1Akj7fn5Qg@mail.gmail.com>
 <5e79d1f8-7632-48ef-de56-9e79cba87434@xmyslivec.cz>
In-Reply-To: <5e79d1f8-7632-48ef-de56-9e79cba87434@xmyslivec.cz>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Thu, 17 Sep 2020 11:08:13 -0600
Message-ID: <CAJCQCtTYAg-uNpk2WYv0QDWH+prfnDN5oKyKmvTVHjARu_w0Kw@mail.gmail.com>
Subject: Re: Linux RAID with btrfs stuck and consume 100 % CPU
To:     Vojtech Myslivec <vojtech@xmyslivec.cz>
Cc:     Chris Murphy <lists@colorremedies.com>,
        Song Liu <songliubraving@fb.com>,
        Michal Moravec <michal.moravec@logicworks.cz>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        Linux-RAID <linux-raid@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Sep 16, 2020 at 3:42 AM Vojtech Myslivec <vojtech@xmyslivec.cz> wrote:
>
> Hello,
>
> it seems my last e-mail was filtered as I can't find it in the archives.
> So I will resend it and include all attachments in one tarball.
>
>
> On 26. 08. 20 20:07, Chris Murphy wrote:> OK so from the attachments..
> >
> > cat /proc/<pid>/stack for md1_raid6
> >
> > [<0>] rq_qos_wait+0xfa/0x170
> > [<0>] wbt_wait+0x98/0xe0
> > [<0>] __rq_qos_throttle+0x23/0x30
> > [<0>] blk_mq_make_request+0x12a/0x5d0
> > [<0>] generic_make_request+0xcf/0x310
> > [<0>] submit_bio+0x42/0x1c0
> > [<0>] md_update_sb.part.71+0x3c0/0x8f0 [md_mod]
> > [<0>] r5l_do_reclaim+0x32a/0x3b0 [raid456]
> > [<0>] md_thread+0x94/0x150 [md_mod]
> > [<0>] kthread+0x112/0x130
> > [<0>] ret_from_fork+0x22/0x40
> >
> >
> > Btrfs snapshot flushing might instigate the problem but it seems to me
> > there's some kind of contention or blocking happening within md, and
> > that's why everything stalls. But I can't tell why.
> >
> > Do you have any iostat output at the time of this problem? I'm
> > wondering if md is waiting on disks. If not, try `iostat -dxm 5` and
> > share a few minutes before and after the freeze/hang.
> We have detected the issue at Monday 31.09.2020 15:24. It must happen
> sometimes between 15:22-15:24 as we monitor the state every 2 minutes.
>
> We have recorded stacks of blocked processes, sysrq+w command and
> requested `iostat`. Then in 15:45, we perform manual "unstuck" process
> by accessing md1 device via dd command (reading a few random blocks).
>
> I hope attached file names are self-explaining.
>
> Please let me know if we can do anything more to track the issue or if I
> forget something.
>
> Thanks a lot,
> Vojtech and Michal
>
>
>
> Description of the devices in iostat, just for recap:
> - sda-sdf: 6 HDD disks
> - sdg, sdh: 2 SSD disks
>
> - md0: raid1 over sdg1 and sdh1 ("SSD RAID", Physical Volume for LVM)
> - md1: our "problematic" raid6 over sda-sdf ("HDD RAID", btrfs
>        formatted)
>
> - Logical volumes over md0 Physical Volume (on SSD RAID)
>     - dm-0: 4G  LV for SWAP
>     - dm-1: 16G LV for root file system (ext4 formatted)
>     - dm-2: 1G  LV for md1 journal
>

It's kindof a complicated setup. When this problem happens, can you
check swap pressure?

/sys/fs/cgroup/memory.stat

pgfault and maybe also pgmajfault - see if they're going up; or also
you can look at vmstat and see how heavy swap is being used at the
time. The thing is.

Because any heavy eviction means writes to dm-0->md0 raid1->sdg+sdh
SSDs, which are the same SSDs that you have the md1 raid6 mdadm
journal going to. So if you have any kind of swap pressure, it very
likely will stop the journal or at least substantially slow it down,
and now you get blocked tasks as the pressure builds more and more
because now you have a ton of dirty writes in Btrfs that can't make it
to disk.

If there is minimal swap usage, then this hypothesis is false and
something else is going on. I also don't have an explanation why your
work around works.



-- 
Chris Murphy
