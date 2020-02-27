Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C7C28170D49
	for <lists+linux-btrfs@lfdr.de>; Thu, 27 Feb 2020 01:39:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728019AbgB0AjY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 26 Feb 2020 19:39:24 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:35292 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727987AbgB0AjY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 26 Feb 2020 19:39:24 -0500
Received: by mail-wr1-f65.google.com with SMTP id w12so1180687wrt.2
        for <linux-btrfs@vger.kernel.org>; Wed, 26 Feb 2020 16:39:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pd1ehrHUMHuiJuwNBznf1kkjhAjShhInO1VrKJaFC4s=;
        b=GiCi2O1MICtBXSrB5Xjv+ONVaJ2fTTDRsJKNq+erYHHgl0d3ZxKG6qOvT3Psj0sW33
         y8h1xymcqXXho6iHEIyZ5MV4WMkO3d6lYVrHy9w3MEAiyehxeWJ/tkwWgjAieqvsWTHO
         UlZ73AKm++d9UQdBM6Bq0zm5JzGNHOAtA+5wqzYR9ZTTFaWN82BvRCy9ShXMWIaMqViG
         HNGywNDw0nxDz8lZTG7+HftGViTumPumHK2J5DDK3S2qBNZbL8VsPGU8FWaCQtMcMoBC
         tLK0XNdgTtghajTWfl2iC8aLIB0woJgBbRoyPYeVvKXDZIPYEDDJlREw7Ll00Z2Q67+c
         PZTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pd1ehrHUMHuiJuwNBznf1kkjhAjShhInO1VrKJaFC4s=;
        b=YNn94v+XGh9ekh2TTzFfGkXW+mifg0c+LXeRPjUcjz7bGxgLrP2msrLVE9wVgrfuuT
         igT0/lFxUTt4tSZiNALzZiL5CHjtPaiH3dEsY7WwYbXmuwpUtgBcou/1AU0wsHk1maIL
         c85b8JpFVh749HvsL6AXv2m3vgPhNAAMgcRpnXp2QAeMJK4xxU5oBVRsec4VXOxFHMhD
         x/FS/3gbb90TVcaWcuNji57tSFDvRjJq1cfd/WmK8z9tDEMSI+Ax4KArBnwaE1faV+q9
         6BsC1AEE2NSajuAtbqwzli5BsSLZ0zmjxCOlvBeiqoZKwF/UxPSpNysqW9wcYLcGiN4g
         DXOw==
X-Gm-Message-State: APjAAAVNFAlM+pPpBJbEPLuNayG6HI3o08dVwSL5ZuaXDyE0GNeysgE7
        qwwimYbL+WNrSo9ODQtSrqHsFxNarBL72+xGwHHQ5A==
X-Google-Smtp-Source: APXvYqzQvmRI5E2PEQohTdJtM4G8ayH5zAmWY2olSzgSEa2Pyz4ruwhmE2LM5hhqxON2HOB8sQ1phvgc9UOERuKgU3s=
X-Received: by 2002:adf:a48f:: with SMTP id g15mr1356665wrb.42.1582763961417;
 Wed, 26 Feb 2020 16:39:21 -0800 (PST)
MIME-Version: 1.0
References: <CAAW2-ZfunSiUscob==s6Pj+SpDjO6irBcyDtoOYarrJH1ychMQ@mail.gmail.com>
 <2fe5be2b-16ed-14b8-ef40-ee8c17b2021c@gmx.com> <CAAW2-Zfz8goOBCLovDpA7EtBwOsqKOAP5Ta_iS6KfDFDDmn47g@mail.gmail.com>
 <60fba046-0aef-3b25-1e7d-7e39f4884ffe@gmx.com> <CAAW2-ZdczvEfgKb++T9YGSOMxJB+jz3_mwqEt2+-g0Omr7tocQ@mail.gmail.com>
 <CAG_8rEfjNPwT4g2DwbS9atsurLvYazt7aV4o77HGv-fssNmheQ@mail.gmail.com>
In-Reply-To: <CAG_8rEfjNPwT4g2DwbS9atsurLvYazt7aV4o77HGv-fssNmheQ@mail.gmail.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Wed, 26 Feb 2020 17:39:05 -0700
Message-ID: <CAJCQCtTYBOUDmWBAA4BAenkyZS6uY+f6Ao33uHMmr_16M_1Buw@mail.gmail.com>
Subject: Re: USB reset + raid6 = majority of files unreadable
To:     Steven Fosdick <stevenfosdick@gmail.com>
Cc:     Jonathan H <pythonnut@gmail.com>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Feb 26, 2020 at 3:37 PM Steven Fosdick <stevenfosdick@gmail.com> wrote:

> It looks like the disc started to fail here:
>
> Jan 30 13:41:04 meije kernel: scsi_io_completion_action: 806 callbacks
> suppressed
> Jan 30 13:41:04 meije kernel: sd 3:0:0:0: [sde] tag#18 FAILED Result:
> hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK cmd_age=0s
> Jan 30 13:41:04 meije kernel: sd 3:0:0:0: [sde] tag#18 CDB: Read(16)
> 88 00 00 00 00 00 a2 d3 3b 00 00 00 00 40 00 00
> Jan 30 13:41:04 meije kernel: print_req_error: 806 callbacks suppressed
> Jan 30 13:41:04 meije kernel: blk_update_request: I/O error, dev sde,
> sector 2731752192 op 0x0:(READ) flags 0x80700 phys_seg 1 prio class 0
> Jan 30 13:41:04 meije kernel: sd 3:0:0:0: [sde] tag#15 FAILED Result:
> hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK cmd_age=0s
> Jan 30 13:41:04 meije kernel: sd 3:0:0:0: [sde] tag#15 CDB: Write(16)
> 8a 00 00 00 00 00 a2 d3 3b 00 00 00 00 08 00 00
> Jan 30 13:41:04 meije kernel: blk_update_request: I/O error, dev sde,
> sector 2731752192 op 0x1:(WRITE) flags 0x800 phys_seg 1 prio class 0
> Jan 30 13:41:04 meije kernel: btrfs_dev_stat_print_on_error: 732
> callbacks suppressed

Both read and write errors reported by the hardware. These aren't the
typical UNC error though. I'm not sure what DID_BAD_TARGET means. Some
errors might be suppressed.

Write errors are generally fatal. Read errors, if they include sector
LBA, Btrfs can fix if there's an extra copy (dup, raid1, raid56, etc),
otherwise, it may or may not be fatal depending on what's missing, and
what's affected by it being missing.

Btrfs might survive the write errors though with metadata raid1c3. But
later you get more concerning messages...


> This goes on for pages and quite a few days, I can extract more if it
> is of interest.

Ahhh yeah. So for what it's worth, in an md driver backed world, this
drive would have been ejected (faulty) upon the first write error. md
does retries for reads but writes it pretty much considers the drive
written off, which means the array is degraded.

As btrfs doesn't have such a concept of faulty drives, ejected drives,
yet; you kinda have to keep an eye on this, and setup monitoring so
you know when the array goes degraded like this.

It's vaguely possible to get the array into a kind of split brain
situation, if two drives experience transient write errors. And in
that case, right now, there's no recovery. Btrfs just gets too
confused.

You need to replace the bad drive, and do a scrub to fix things up.
And double check with 'btrfs fi us /mountpoint/' that all block groups
have one profile set, and that it's the correct one.


> then after mounting degraded, add a new device and attempt to remove
> the missing one:

That's not a good idea in my opinion... you really need to replace the
drive. Otherwise you're doing a really expensive full rebalance while
degraded, effectively. That means nothing else can go wrong or you're
in much bigger trouble. In particular it's really common for there to
be a mismatch between physical drive SCT ERC timeouts, and the
kernel's command timer. Mismatches can cause a of confusion because
upon kernel timer being reached, it resets the block device that
contains the "late" command, which then blows away that drive's entire
command queue.

https://raid.wiki.kernel.org/index.php/Timeout_Mismatch


> Feb 10 19:38:36 meije kernel: BTRFS info (device sda): disk added /dev/sdb
> Feb 10 19:39:18 meije kernel: BTRFS info (device sda): relocating
> block group 10045992468480 flags data|raid5
> Feb 10 19:39:27 meije kernel: BTRFS info (device sda): found 19 extents
> Feb 10 19:39:34 meije kernel: BTRFS info (device sda): found 19 extents
> Feb 10 19:39:39 meije kernel: BTRFS info (device sda): clearing
> incompat feature flag for RAID56 (0x80)
> Feb 10 19:39:39 meije kernel: BTRFS info (device sda): relocating
> block group 10043844984832 flags data|raid5

I'm not sure what's going on here. This is a raid6 volume and raid56
flag is being cleared? That's unexpected and I dn't know why you have
raid5 block groups on a raid6 array.


> and at that point the device remove aborted with an I/O error.

OK well you didn't include that so we have no idea if this I/O error
is about the same failed device or another device. If it's another
device it's more complicated what can happen to the array. Hence why
timeout mismatches are important. And why it's important to have
monitoring so you aren't running a degraded array for three days.

>
> I did discover I could use balance with a filter to balance much of
> the onto the three working discs, away from the missing one but I also
> discovered that whenever the checksum error appears the space cache
> seems to get corrupted.  Any further balance attempt results in
> getting stuck in a loop.  Mounting with clear_cache resolves that.

This sounds like a bug. The default space cache is stored in the data
block group which for you should be raid6, with a missing device it's
effectively raid5. But there's some kind of conversion happening
during the balance/missing device removal, hence the clearing of the
raid56 flag per block group, and maybe this corruption is happening
related to that removal.

-- 
Chris Murphy
