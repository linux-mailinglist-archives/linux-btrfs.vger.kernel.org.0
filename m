Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C928CA7792
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Sep 2019 01:30:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726770AbfICXan (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 3 Sep 2019 19:30:43 -0400
Received: from mail-wm1-f53.google.com ([209.85.128.53]:40530 "EHLO
        mail-wm1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726177AbfICXan (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 3 Sep 2019 19:30:43 -0400
Received: by mail-wm1-f53.google.com with SMTP id t9so1342205wmi.5
        for <linux-btrfs@vger.kernel.org>; Tue, 03 Sep 2019 16:30:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jdWkuVoqAzHQvz/7azkQhBT4WzZCDWVtsnpE4kJ0Dug=;
        b=DJGVeqcBQ7fK5Ce9Gmr+Rx2eVn3DiSGix2eYa/aopkJ/OPha3TBgfsVaLbsyUQShFg
         1nmezCl5vYR9ExzMHqdAKAd6PPOK2AF/GMpi7VBQnLbJdpxz74rfP3omYOLErjBtP6rX
         5/0a+YlJgiUkPXYBXmajLqsgz6Kj8ac+M9lKKOEFDPMLcJAbNKt+0Xli0xa4C2ITV1gH
         6sNKFEIUn6Q7eDBlwc1ar5jhb3laT2c9JBwLQLsPGr10hXBKuOpFXjGFf7Snu8b4Mia1
         2j9LB1eaUkKdP5/rImqkEF4IPGkEGZ0Dg2Obx6GbKQpg0qIDDmTax1EwNiyxbfu7I/II
         wxOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jdWkuVoqAzHQvz/7azkQhBT4WzZCDWVtsnpE4kJ0Dug=;
        b=pJwSCcN92OF8aVhiLwIQANr9hceHUEF7VRpm2wvH4AOn8EYtaDvTE12dMTvGR7XcI8
         si0wJVgMRBK2m94+ok50DtUgs5S8zYURLYYOTOtnFIxfVblN2xevZnLQtiFB66rzhQOe
         +TM5lpleUS5uj/FNqcTLoNx5UedxPIbLf/sSZEm1VJSMy1yq6CHVJoMVkLzjNiODypz6
         kV9WGf0mUn6qU4RGnvokl9A7PP9t6LFqOgOq0AhkzpZWsJfVsdPfCtEv18VLUkJUVDhW
         tRBlCTUzYm2MYqGIzKT80rza7S4q+ZM+MCfa1AWwKJ7r0TGBY8gHoy4DzZfyJaGa0l8b
         +5EA==
X-Gm-Message-State: APjAAAX4S7u0ZPWRJ8Bi3vPA132PLYgcUnWGCYS5HsQvPGvbCx3GOSSd
        S0ktoGYAzcAnMtoZykIoj2+ogiAQTFNJLz+yhfyO8c6TP9Qm8Q==
X-Google-Smtp-Source: APXvYqwvF6AfrWsqfp3dfCGvZiUw+phnHRYWzievnpiHMllkSei3SF4WGaDIObc2NdqS26jqszzVJOCNw/ZiWcGQjMU=
X-Received: by 2002:a7b:c3cc:: with SMTP id t12mr1910478wmj.176.1567553440443;
 Tue, 03 Sep 2019 16:30:40 -0700 (PDT)
MIME-Version: 1.0
References: <f58d5ec1-4b38-ad8b-068d-d3bb1f616ec2@liland.com>
In-Reply-To: <f58d5ec1-4b38-ad8b-068d-d3bb1f616ec2@liland.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Tue, 3 Sep 2019 17:30:29 -0600
Message-ID: <CAJCQCtTqetLF1sMmgoPyN=2FOHu+MSSW-MGsN6NairLPdNmK+g@mail.gmail.com>
Subject: Re: Unmountable degraded BTRFS RAID6 filesystem
To:     Edmund Urbani <edmund.urbani@liland.com>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Sep 3, 2019 at 2:20 PM Edmund Urbani <edmund.urbani@liland.com> wrote:
>
>
> Hi all,
>
> two days ago my btrfs filesystem became quite slow and the logs showed a
> lot of I/O errors on one of the HDDs. I ordered a replacement drive and
> tried to remove the failing drive from the filesystem (btrfs device
> remove). That removal command did not finish but just sat there without
> any output.

What exact commands?

'btrfs device del missing' I expect causes reconstruction from parity
as well as a balance to create the new 9 device stripe width (well, 7
data + 2 parity). This is not an inherently bad thing to do, it should
work and should be COW. And there's one extra copy available in case
of an unrecoverable read error, it can still do additional
reconstruction.

Because it's a balance though, it might be really, really slow and I
don't think there is no way to cancel device removal. I don't think
it's possible to cancel it with btrfs balance stop.

How many subvolumes and snapshots? Are quotas enabled?


> Today the new drive arrived. Device removal still had not finished, but
> the filesystem had entered read-only mode last night.

Likely pre-existing problem is discovered during the balance, or bug
triggered, or both, and the file system goes read only to avoid
further corruption. Do you have kernel messages for the entire time
starting at 'device delete' until the file system goes read only?

> Linux phoenix 4.14.78-gentoo #1 SMP Mon Dec 3 09:25:24 CET 2018 x86_64

kernel 4.14.141 is the current version LTS for that series, and there
are hundreds of bug fix insertions/removals between just those two
versions
https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/diff/?id=v4.14.141&id2=v4.14.78&dt=2

between kernel 4.14.141 and 5.2.11, there are thousands of changes
just in Btrfs... thousands
https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/diff/?id=v5.2.11&id2=v4.14.141&dt=2

And quite a few in raid56.c which isn't that big to begin with, but
there are a lot of simplifications and improvements from what I can
tell
https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/diff/fs/btrfs/raid56.c?id=v5.2.11&id2=v4.14.141

Anyway, it's worth a try to try and mount with 5.2.11 using '-o
ro,degraded' and at least see if it will mount. But it gives you some
idea why there's a strong bias toward using newer kernels. It's too
hard to remember all the changes, even for developers.



> AMD Opteron(tm) Processor 6174 AuthenticAMD GNU/Linux
>
> *****
> btrfs --version
>
> btrfs-progs v4.19

This is OK, but the change log will show lots of bug fixes here too. I
wouldn't make changes (no repair attempts at all, including chunk
recover or --repair) until you get some dev advice about the next
step.


> [ 8904.358084] BTRFS info (device sda1): turning on discard

Unexpected.

> [ 8904.358088] BTRFS info (device sda1): allowing degraded mounts
> [ 8904.358089] BTRFS info (device sda1): disk space caching is enabled
> [ 8904.358091] BTRFS info (device sda1): has skinny extents
> [ 8904.361743] BTRFS warning (device sda1): devid 8 uuid
> 0e8b4aff-6d64-4d31-a135-705421928f94 is missing
> [ 8905.705036] BTRFS info (device sda1): bdev (null) errs: wr 0, rd
> 14809, flush 0, corrupt 4, gen 0
> [ 8905.705041] BTRFS info (device sda1): bdev /dev/sda1 errs: wr 0, rd
> 4, flush 0, corrupt 0, gen 0
> [ 8905.705052] BTRFS info (device sda1): bdev /dev/sdf1 errs: wr 0, rd
> 10543, flush 0, corrupt 0, gen 0
> [ 8905.705062] BTRFS info (device sda1): bdev /dev/sdc1 errs: wr 0, rd
> 8, flush 0, corrupt 0, gen 0

four devices with read errors

When was the last time the volume was scrubbed? Do you know for sure
these errors have not gone up at all since the last successful scrub?
And were any errors reported for that last scrub?


> I have tried all the mount / restore options listed here:
> https://forums.unraid.net/topic/46802-faq-for-unraid-v6/page/2/?tab=comments#comment-543490

Good. Stick with ro attempts for now. Including if you want to try a
newer kernel. If it succeeds to mount ro, my advice is to update
backups so at least critical information isn't lost. Back up while you
can. Any repair attempt makes changes that will risk the data being
permanently lost. So it's important to be really deliberate about any
changes.


> ... and all I keep getting is "bad tree block" errors. Superblocks seem
> fine (btrfs rescue super-reecover found no problem). I am considering
> trying "btrfs rescue chunk-recover" at this point.
>
> Could this help in my situation? What do you think?

I'm not sure if chunk recover can work on degraded volumes. Your best
bet is to not make any further changes to the volume itself.

Preserve all logs.

-- 
Chris Murphy
