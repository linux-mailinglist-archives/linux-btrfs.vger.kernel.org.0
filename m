Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0B75660E84
	for <lists+linux-btrfs@lfdr.de>; Sat,  6 Jul 2019 04:38:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725945AbfGFCi1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 5 Jul 2019 22:38:27 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:33618 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725813AbfGFCi1 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 5 Jul 2019 22:38:27 -0400
Received: by mail-wm1-f67.google.com with SMTP id h19so8697508wme.0
        for <linux-btrfs@vger.kernel.org>; Fri, 05 Jul 2019 19:38:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FtemaPORz0ZMK/Vm3Lb8YzuoJIekC1vX9WgL82eeCjg=;
        b=qP9gG72orSGU0KsjMkCa1XSfDa6HrNn1lgUTjXX2auR2lDWIAJZ0sMMRB9BS4Rbn2o
         r7O6N0bK6Vl/50x4+jT+U4gfUuYmEkcvSBC1i4UgWQJ1Vq9la5AdUKLqk1PFaDuWOkJx
         7s8RwRSK4RH7W/m2/oBWc9h4HtA4KqOyQuK8Ol+F79putiJ0De/AYeEmsNxXg3PM/bh5
         F1WZ8CQVvWGjXRdcaoB1nTopZGvLUBx2z4ibG50v7/peQRN4gLcEc1khhrtVpDxX2793
         6BA7Xras0tpX9R0bhRByXRcPNIgLEv8qNrkrFHwxcC3kLayqds510nTlMaLO9h2tztIC
         RiMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FtemaPORz0ZMK/Vm3Lb8YzuoJIekC1vX9WgL82eeCjg=;
        b=crIfCA+FoHbOKKJ9BR51l2A4SAtRnuWOF2q04gC7PGhWAEg087Z93+RcU329p0Qvf6
         DeiGhgXPmh3OcMXwNsqHwPbhqX8lU3dGu9XKy0ra4uYmNVM/zjPPMAvS8o04ZXgQ3xS8
         nMEZ5V3rgZrDaTW9McqoNk5qSVrw76meGJHMERe2tAx7VUh0aZe0RUtMyZV7yGiw5KMO
         sqzyDQKEof8BeuCRuQcdltd1t2qKcQsksXpghKFON5RpPF3+1SXOwjIMZ2sfN/x7RIi6
         ZOuXV9jBf/Ta5YwyCM0rS1yYWf3UkBGZTuKXNiEVaq/wHsqPoRa55wnyw/vYc91qpYXs
         ljXA==
X-Gm-Message-State: APjAAAVq/kCF1t6muZQkozYh11/rKNeiLziAtZW4eQP1R8fcdQ2wZTZf
        xgIc/m7UT5Xllbi5R2r9ONEvErVXreVgXb8f2Yqdiw==
X-Google-Smtp-Source: APXvYqwfD2+xTZ6fJBzBd3VtFApxmsXyvqkvEUk+KHDcW9nhOhI0WhGGKsqjcqI967bjbkCjd4i7e1WSnKrfkTilasI=
X-Received: by 2002:a7b:ce95:: with SMTP id q21mr5446798wmj.65.1562380704570;
 Fri, 05 Jul 2019 19:38:24 -0700 (PDT)
MIME-Version: 1.0
References: <966f5562-1993-2a4f-0d6d-5cea69d6e1c6@gmail.com>
 <CAJCQCtRhXukLGrWTK1D5TLRhxwF6e31oewOSNDg2TAxSanavMA@mail.gmail.com> <a4920d21-3c90-9a96-9b44-f90d7b5eed3a@gmail.com>
In-Reply-To: <a4920d21-3c90-9a96-9b44-f90d7b5eed3a@gmail.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Fri, 5 Jul 2019 20:38:13 -0600
Message-ID: <CAJCQCtS87cQV4PWuDRaQmmY-N03XmGqN2hh8EQv8BqqVGRuxbw@mail.gmail.com>
Subject: Re: "kernel BUG" and segmentation fault with "device delete"
To:     Vladimir Panteleev <thecybershadow@gmail.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Jul 5, 2019 at 6:05 PM Vladimir Panteleev
<thecybershadow@gmail.com> wrote:

> On 05/07/2019 21.43, Chris Murphy wrote:

> > But I can't tell from the
> > above exactly when each drive was disconnected. In this scenario you
> > need to convert to raid1 first, wait for that to complete successfully
> > before you can do a device remove. That's clear.  Also clear is you
> > must use 'btrfs device remove' and it must complete before that device
> > is disconnected.
>
> Unfortunately as mentioned before that wasn't an option. I was
> performing this operation on a DM snapshot target backed by a file that
> certainly could not fit the result of a RAID10-to-RAID1 rebalance.

Then the total operation isn't possible. Maybe you could have made the
volume a seed, and then create a single device sprout on a new single
target, and later convert that sprout to raid1. But I'm not sure of
the state of multiple device seeds.


>
> > What I've never tried, but the man page implies, is you can specify
> > two devices at one time for 'btrfs device remove' if the profile and
> > the number of devices permits it.
>
> What I found surprising, was that "btrfs device delete missing" deletes
> exactly one device, instead of all missing devices. But, that might be
> simply because a device with RAID10 blocks should not have been
> mountable rw with two missing drives in the first place.

It's a really good question for developers if there is a good reason
to permit rw mount of a volume that's missing two or more devices for
raid 1, 10, or 5; and missing three or more for raid6. I cannot think
of a good reason to allow degraded,rw mounts for a raid10 missing two
devices.


> > This is actually worse, potentially because it means there's only one
> > copy of the system chunk on sdd1. It has not been replicated to sdf1,
> > but is on the missing device.
>
> I'm sorry, but that's not right. As I mentioned in my second email, if I
> use btrfs device replace, then it successfully rebuilds all missing
> data. So, there is no lost data with no remaining copies; btrfs is
> simply having some trouble moving it off of that device.
>
> Here is the filesystem info with a loop device replacing the missing drive:
>
> https://dump.thecybershadow.net/9a0c88c3720c55bcf7fee98630c2a8e1/00%3A02%3A17-upload.txt

Wow that's really interesting. So you did 'btrfs replace start' for
one of the missing drive devid's, with a loop device as the
replacement, and that worked and finished?!

Does this three device volume mount rw and not degraded? I guess it
must have because 'btrfs fi us' worked on it.

        devid    1 size 7.28TiB used 2.71TiB path /dev/sdd1
        devid    2 size 7.28TiB used 22.01GiB path /dev/loop0
        devid    3 size 7.28TiB used 2.69TiB path /dev/sdf1

OK so what happens now if you try to 'btrfs device remove /dev/loop0' ?


>
> > Depending on degraded operation for this task is the wrong strategy.
> > You needed to 'btrfs device delete/remove' before physically
> > disconnecting these drives.
> >
> > OK you definitely did this incorrectly if you're expecting to
> > disconnect two devices at the same time, and then "btrfs device delete
> > missing" instead of explicitly deleting drives by ID before you
> > physically disconnect them.
>
> I don't disagree in general, however, I did make sure that all data was
> accessible with two devices before proceeding with this endeavor.

Well there's definitely something screwy if Btrfs needs something on a
missing drive, which is indicated by its refusal to remove it from the
volume, and yet at same time it's possible to e.g. rsync every file to
/dev/null without any errors. That's a bug somewhere.


> >> OK so what did you do, in order, each command, interleaving the
> >> physical device removals.
>
> Well, at this point, I'm still quite confident that the BTRFS kernel bug
> is unrelated to this entire RAID10 thing, but I'll do so if you like.
> Unfortunately I do not have an exact record of this, but I can do my
> best to reconstruct it from memory.

I'm not a developer but a dev very well might need to have a simple
reproducer for this in order to locate the problem. But the call trace
might tell them what they need to know. I'm not sure.


>
> The reason I'm doing this in the first place is that I'm trying to split
> a 4-drive RAID10 array that was getting full. The goal was to move some
> data off of it to a new array, then delete it from its original
> location. I couldn't use rsync because most of the data was in
> snapshots, and I couldn't use btrfs send/receive because it bugs out
> with the old "chown oXXX-XXXXXXX-0 failed: No such file or directory"
> bug. So, my idea was:

I'm not familiar with that bug. That sounds like a receive side bug
not a send side bug. I wonder if receive will continue if you use the
-E 0 option, and the result will just be wrong owner on a few files.


>
> 1. Use device mapper to create a COW copy of all four devices, and
> operate on those (make the SATA devices read-only to ensure they're not
> touched)
> 2. Use btrfs-tune to change the UUID of the new filesystem
> 3. Delete 75%-ish of data off of the COW copy
> 4. Somehow convert the 4-disk RAID10 to 2-disk RAID1 without incurring a
> ton of writes to the COW copies
> 5. dd the contents of the COW copies to two new real disks
> 6. After ensuring the remaining data is safe on the new disks, delete it
> from the original array.
>
> For steps 2 and 3, I needed to specify the exact devices to work with.
> It's possible to specify the device list when mounting with -o device=,
> but for btrfstune, I had to bind-mount a fake partitions file over
> /proc/partitions. I can share the scripts I used for all this if you like.

No, it's fine.

> Have you had a chance to look at the kernel stack trace yet? It looks
> like it's running out of temporary space to perform a relocation. I
> think that is where we should be concentrating on.

I've looked at it but I can't really follow it. The comments in the
code don't really tell me much either other than Btrfs is confused,
and so you're seeing the warning and then error -28. It may really be
running out of global reserve for this operation, I can't really tell.

Qu will understand this better.

-- 
Chris Murphy
