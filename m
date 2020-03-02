Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7F00C175197
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Mar 2020 02:50:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726714AbgCBBuv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 1 Mar 2020 20:50:51 -0500
Received: from mail-io1-f51.google.com ([209.85.166.51]:43554 "EHLO
        mail-io1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726562AbgCBBuv (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sun, 1 Mar 2020 20:50:51 -0500
Received: by mail-io1-f51.google.com with SMTP id n21so9751409ioo.10
        for <linux-btrfs@vger.kernel.org>; Sun, 01 Mar 2020 17:50:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eTfkeT/1uKL/VpVjVYSldjIqf4Ol6fGiNxRbhZ8JzY4=;
        b=W71dD7nHHFvjZBnBSONBcCSw88+ZLtFbYGkXwQ4ZftL1hSA+TU5/bk3iasH7mXvHF+
         jmRSAhLeeJh5SNnNt80sBH7KJAV71vF9omeEev2jpFa6Qlk5EyPmT/WaqsO6z8ipiaDO
         tpemOWKlUSpU99rzneWMDyUAERuz1eEiJ/ELsWrzHnvpa9GuAC+Od6oE9mAobljkt+HT
         ssAZ31W3Ashold9VZk7vsMbpKqNS0rz+Mz/sVYuddnwFgq336/lmk4O2UDaTz2Ok4fDp
         E+uEZcPLDk1k2WyG75eGV1EbVhcztKwFe8Yw2luMd1mltnfDcPpBX0TpRPlS/8jeraXd
         GmSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eTfkeT/1uKL/VpVjVYSldjIqf4Ol6fGiNxRbhZ8JzY4=;
        b=STZRa/5l4GKVyhIAzKLkgQcSg2s67csNIsMr8Yy92mmqt4knaqZg6TIlE8+0mafA8+
         7SXwO+yKuX1i0b/Iz/C7qb0iY4SsThaabDnOqozkth1NzXGPn2lhEKyfYocE8Ok1dUOo
         +UmyUgvFGNrQlxwu7tPY2DLpu81N4Q6aIyv1vpoPzrzb8n1VF8qjZzNAb47XQVFb/nip
         1tZ5vJEoZpT3rX3W3Au/Stbie/IqZaW2nGIEhfgNtit9l7DU6na51mEHQigDfC8eVvvf
         42HHhRq7aY/AgQQ7PyKKL9DJ6ZsPHyg/ZWf7kUoUkloahFASMRE4FfM2NCAFizQBQTgi
         9vrA==
X-Gm-Message-State: APjAAAWwcD1N/IE/F4zL2inqkoGgTamjZMDBO4+WVg0B7UKk2TPU4e7Y
        10GxWjon4ApRPWXK4GHMcqbbBCipwDFjxFOJebkpg735H+g=
X-Google-Smtp-Source: APXvYqx3R3enKls0qJTLdYYZ8WvIbENVa6MuNiAS3z0O13riW6v7nqGFidDZHrJK1GxKrG7jdtH9aUgUKuOu/xgjPgs=
X-Received: by 2002:a02:a795:: with SMTP id e21mr11875689jaj.1.1583113850189;
 Sun, 01 Mar 2020 17:50:50 -0800 (PST)
MIME-Version: 1.0
References: <CAG+QAKWwvevCz5zYDtkOO5V0AA7bJuoZWHJ2CZjc1ofsO-c7xQ@mail.gmail.com>
 <CAJCQCtQF8f0UsVuFU_TXxWJ2DZQcFZABTSwPu18ob7RcSUKW_A@mail.gmail.com>
In-Reply-To: <CAJCQCtQF8f0UsVuFU_TXxWJ2DZQcFZABTSwPu18ob7RcSUKW_A@mail.gmail.com>
From:   Rich Rauenzahn <rrauenza@gmail.com>
Date:   Sun, 1 Mar 2020 17:50:39 -0800
Message-ID: <CAG+QAKWdb37RfwFE3B7QweHmD0EZiKU=a_OT-ED6R1-ZWC3aew@mail.gmail.com>
Subject: Re: btrfs balance to add new drive taking ~60 hours, no progress?
To:     Chris Murphy <lists@colorremedies.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

[Resending because gmail on iphone didn't do plain text]

On Sun, Mar 1, 2020 at 5:10 PM Chris Murphy <lists@colorremedies.com> wrote:
>
> Free is 1.82 exactly half of  unallocated on one drive and no
> unallocate on the other drives, so yeah this file system is 100% full.
> Adding one drive was not enough, it's raid1. You needed to add two
> drives.

I'm not following the btrfs logic here - I had three drives, 2 x 1 TB
and a 1 x 4 TB and added a 4TB.

That was a total of 4TB in RAID0.  Wouldn't adding a fourth drive give
me 6TB and some of the blocks just moved from the three drives onto
the fourth during the rebalance?

Is there a particular 2nd copy policy I'm not aware of?

Or is it that it is trying to create new allocations on the new drive
as part of the balance but can't because they wouldn't be mirrored?
But I still don't get why it wouldn't move blocks from the full
drives...

>
> So now what? The problem is you have a balance in-progress, and a
> cancel in-progress, and I'm not sure which is less risky:
>
> - add another device, even if it's small like a 32G partition or flash drive
> - force reboot

I have a 150 GB of files I can remove ... I'll try that first.

Thank you for your help.

> What I *would* do before you do anything else is disable the write
> cache on all the drives. At least that way if you have to force a
> reboot, there's less of a chance COW and barrier guarantees can be
> thwarted.
>
> Be careful with hdparm, small w is dangerous, capital W is what you want.

Oh good idea!

>
>
> --
> Chris Murphy

On Sun, Mar 1, 2020 at 5:10 PM Chris Murphy <lists@colorremedies.com> wrote:
>
> On Sun, Mar 1, 2020 at 1:32 PM Rich Rauenzahn <rrauenza@gmail.com> wrote:
> >
> > (Is this just taking really long because I didn't provide filters when
> > balancing across the new drive?)
>
> I don't think so. It might be fairly wedged in because it has no
> unallocated space on 3 of 4 drives, and is writing into already
> allocated block groups.
>
> I think the mistake was adding only one new drive instead of two *and*
> then also doing a balance.
>
> I also think it's possible there's a bug, where Btrfs is trying too
> hard to avoid ENOSPC. Ironic if true. It should just give up, or at
> least it should cancel faster.
>
> >
> > $ sudo btrfs fi show /.BACKUPS/
> > Label: 'BACKUPS'  uuid: cfd65dcd-2a63-4fb1-89a7-0bb9ebe66ddf
> >         Total devices 4 FS bytes used 3.64TiB
> >         devid    2 size 1.82TiB used 1.82TiB path /dev/sda1
> >         devid    3 size 1.82TiB used 1.82TiB path /dev/sdc1
> >         devid    4 size 3.64TiB used 3.64TiB path /dev/sdb1
> >         devid    5 size 3.64TiB used 8.31MiB path /dev/sdj1
>
> This suggests 3 of 4 are full.
>
>
>
> > $ sudo btrfs fi usage /.BACKUPS/
> > Overall:
> >     Device size:                  10.92TiB
> >     Device allocated:              7.28TiB
> >     Device unallocated:            3.64TiB
> >     Device missing:                  0.00B
> >     Used:                          7.27TiB
> >     Free (estimated):              1.82TiB      (min: 1.82TiB)
> >     Data ratio:                       2.00
> >     Metadata ratio:                   2.00
> >     Global reserve:              512.00MiB      (used: 0.00B)
> >
> > Data,RAID1: Size:3.63TiB, Used:3.63TiB
> >    /dev/sda1       1.82TiB
> >    /dev/sdb1       3.63TiB
> >    /dev/sdc1       1.82TiB
> >    /dev/sdj1       8.31MiB
> >
> > Metadata,RAID1: Size:5.00GiB, Used:3.88GiB
> >    /dev/sda1       3.00GiB
> >    /dev/sdb1       5.00GiB
> >    /dev/sdc1       2.00GiB
> >
> > System,RAID1: Size:32.00MiB, Used:736.00KiB
> >    /dev/sda1      32.00MiB
> >    /dev/sdb1      32.00MiB
> >
> > Unallocated:
> >    /dev/sda1       1.00MiB
> >    /dev/sdb1       1.00MiB
> >    /dev/sdc1       1.00MiB
> >    /dev/sdj1       3.64TiB
>
> Free is 1.82 exactly half of  unallocated on one drive and no
> unallocate on the other drives, so yeah this file system is 100% full.
> Adding one drive was not enough, it's raid1. You needed to add two
> drives.
>
> So now what? The problem is you have a balance in-progress, and a
> cancel in-progress, and I'm not sure which is less risky:
>
> - add another device, even if it's small like a 32G partition or flash drive
> - force reboot
>
> What I *would* do before you do anything else is disable the write
> cache on all the drives. At least that way if you have to force a
> reboot, there's less of a chance COW and barrier guarantees can be
> thwarted.
>
> Be careful with hdparm, small w is dangerous, capital W is what you want.
>
> --
> Chris Murphy
