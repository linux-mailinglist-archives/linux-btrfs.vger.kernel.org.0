Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 57E8F1202B7
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 Dec 2019 11:36:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727391AbfLPKgk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 16 Dec 2019 05:36:40 -0500
Received: from mail-vk1-f196.google.com ([209.85.221.196]:35497 "EHLO
        mail-vk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727099AbfLPKgk (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 16 Dec 2019 05:36:40 -0500
Received: by mail-vk1-f196.google.com with SMTP id o187so1480063vka.2
        for <linux-btrfs@vger.kernel.org>; Mon, 16 Dec 2019 02:36:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ceremcem-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:cc;
        bh=hVaBcxAAWgHYcDPMs9pfhjqr51zOwC10bJnnaYbSRIs=;
        b=I9+ZP6e3YRmTm1k9H9PlpXZHbLep2dInpt9FeZhxaaAgWxigLnNykcPovy4u4wS1yj
         1F3QV88xQsKTaoHcxE6THg3W0wqmHMT8Bbc0wpyrxbZZZ0gA0YwBrRmu0UXQSFcgH/ou
         ZWKUGYMf9+9nHQoSB7M43JcXHn63PlsB0j7GGBAGxNAQBrtt50r3WrvRCyInKa9JjEAm
         7Nbm8E1h1Kx64zhfj8tBvnF9+1cjIDuNVkPzt4yeWTq60mBf1/ki+dycqRsjlacS229B
         O7ryjYMcmiURza+AGkqNH4r5aVkPalleqLNVMPyB2qzMi+Dh5Nxg1PT9vLCZCDIDLVU3
         LNLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:cc;
        bh=hVaBcxAAWgHYcDPMs9pfhjqr51zOwC10bJnnaYbSRIs=;
        b=l5880pw13cK8T8+mbm6dvkQR0AsE33MvTOT9GyhMdbqmw+ser3eIHv0PQj869DpL8+
         CgsyceOezJ05JX/p3QocxvIv/hr1rV34NPmiBzWiqaOBWmoNq5//jBzR/UBzf37geOJo
         dt2vv1lBd560400yrZ1fBwRoQ6vKLV9pwHsVfpF6MRFwewmRAMfA881vEPH2euelwWbj
         70uy9SKXqXLWyzbQjB2vjonAHtGuWp5/U4QKElwTqBAxpBd05JNS41/Qy52I36ZxzRCo
         UgJxf5/+qN2KGoxvA963BwrAU1LCTgbjMn3QySxXz5dOj3xsPmvzti4n36P9fbM71nN/
         oHGw==
X-Gm-Message-State: APjAAAXdGK9XdTrir34/ms37NAs6omFz80djgnR0cCyTUfjT1niuus13
        wG49/rrlQTh24Pjwnc66+sRT6WRPNSqqGwIZ+2RL+f7vVkA=
X-Google-Smtp-Source: APXvYqzh9RkpuKHP7gkcZAn4vzOClMM4i7qkS7ZXCemtZwigJ4Y46BQ2/Nsl1VpFIYA9s/lBk3TOVBxHOAcA33Ki0gE=
X-Received: by 2002:ac5:ce8f:: with SMTP id 15mr23973007vke.81.1576492598278;
 Mon, 16 Dec 2019 02:36:38 -0800 (PST)
MIME-Version: 1.0
References: <CAN4oSBdH-+BmSLO7DC3u-oBwabNRH2jY2UUO+J0zdxeJTu5FCg@mail.gmail.com>
 <20191211160000.GB14837@angband.pl> <CAN4oSBeUY=dVq5MAZ6bdDs1d5p3BVacEdffzsvCS+80O1iO7jg@mail.gmail.com>
 <CAJCQCtQMxVrmhuiv04wVBanhn2vPuxDwLWwU0QheSMnbPB_Sxw@mail.gmail.com>
In-Reply-To: <CAJCQCtQMxVrmhuiv04wVBanhn2vPuxDwLWwU0QheSMnbPB_Sxw@mail.gmail.com>
From:   Cerem Cem ASLAN <ceremcem@ceremcem.net>
Date:   Mon, 16 Dec 2019 13:36:27 +0300
Message-ID: <CAN4oSBfmjuUS-MwrrcMMmvf7gN7pntAafy8aLP9Su0G-dpTYjg@mail.gmail.com>
Subject: Re: Is it logical to use a disk that scrub fails but smartctl succeeds?
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

> But if there's a scant amount of minimum necessary metadata intact,
> you will get your data off, even if there are errors in the data
> (that's one of the options in restore is to ignore errors). Whereas
> normal operation Btrfs won't hand over anything with checksum errors,
> you get EIO instead. So there's a decent chance of getting the data
> off the drive this way.
>
> First order of priority is to get data off the drive, if you don't
> have a current backup.
> Second, once you have a backup or already do, demote this drive
> entirely, and start your restore from backup using good drives.

+

> That drive is toast.. the giveaway here is the over 1000 "Current
> Pending Sectors.".. there's no point trying to convert this drive to
> DUP,, it must simply be stopped, and what files you can successfully
> copy consider lucky.

Right after those comments I changed my priority to get the data off
to a reliable location (and not converting the profile to DUP) before
renewing the drives. Luckily, merging the good files from three
mirrored machines made it possible to recover nearly all data (all
important data except a few unimportant corrupted log files). Thanks
again and again for this valuable redirection.

> Oh and last but actually I should have mentioned it first, because
> you'll want to do this right away. You might check if this drive has
> configurable SCT ERC.
>
> smartctl -l scterc /dev/

SCT Error Recovery Control:
           Read: Disabled
          Write: Disabled

It seems like the drive has STC ERC support but disabled. However some
weird error is thrown with your correct syntax:

=======> INVALID ARGUMENT TO -l: scterc,1800,70

It's an interesting approach to setup long read time windows. I'll
keep this in mind even though this time I'm determined to make the
correct setup that will make such a data scraping job unnecessary.


> I wasn't clear on why your backup is supposed to be bad... BTRFS should have
> caught any errors during the backup and stopped things with I/O errors.

My strategy was setting up multiple machines that will sync with each
other over the network. Database part was easy since CouchDB has the
synchronization feature out of the box. For the rest of the system
(I'm using LXC containers per service) I would use `btrf send | btrfs
receive` every hour by rotating a single snapshot. I didn't setup a
RAID-1 profile because I thought it's not necessary in this context.

First problem was that I "hoped" the machine would just crash with
"DRDY ERR"s when the disk has *any* problems. I was hoping to be
notified on the very first error by a total system failure. Obviously
it doesn't work like that. Neither OS nor the rest of the applications
may not throw any error till it attempts to read or write to that
corrupted file. So those corruptions took place without noticing. This
was my mistake and I learnt that I should check the filesystem by
`btrfs scrub`. The "bad idea" part was this: Expecting an immediate
disk failure notification by total system crash.

Second problem is I mistakenly thought that `btrfs sub snap` would
throw the same "Input/output error"s just like `cp` does. However, it
turns out, this was not the case, which is totally logical. If we had
such a checksum control while snapshotting, a snapshot operation would
take too long. I'm just realizing that.

After monitoring those corruption events, I still think that I don't
need a RAID-1 setup in order not to loose data. However, a RAID-1
setup will greatly shorten the recovery time of the problematic node.

Now I think the good idea is: Make RAID-1, "monitor-disk-health", be
prepared to replace the disks on the fly.
