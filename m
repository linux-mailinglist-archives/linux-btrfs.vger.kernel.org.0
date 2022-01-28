Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2045D49FD16
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Jan 2022 16:48:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349683AbiA1Psr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 28 Jan 2022 10:48:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349682AbiA1Psq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 28 Jan 2022 10:48:46 -0500
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6582CC06173B
        for <linux-btrfs@vger.kernel.org>; Fri, 28 Jan 2022 07:48:46 -0800 (PST)
Received: by mail-il1-x132.google.com with SMTP id e8so5716740ilm.13
        for <linux-btrfs@vger.kernel.org>; Fri, 28 Jan 2022 07:48:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=f7F5BFQ2UktuErQ0VT+el97tIyCNzlkv+1xkzLdn8Kc=;
        b=TQiIMwj8MTzbjKdVZs1zBzSHbYd2Ru8sKKHbNZUEce4302dNUrPS7vKJe4IKJ+5B2g
         eCLKGaozJNCYlX+CyTvEMbZNwoot7zokGpuGsm363VTRcufEUxc4fVVESD8yTyQs37xY
         Y/idfvUQVFsVcjRotjn3f4YcbaEj+WvU6TJG7Qn5rUQsOS3uN8W0Kl9lm6wmusFmTprL
         cs3Cl3MOYoDrP5yCo+IqkGFpOPr0LM7aCnGGZ1o85rfwvVjLHkm1L6G/17t7DsI58zEl
         79f7GYukKbpW+/lpvhNNf9rvnnRmwgkeBTjO7jJqRjMY8NKn+fyFcX9NWfelO0Kt+yJM
         xGEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=f7F5BFQ2UktuErQ0VT+el97tIyCNzlkv+1xkzLdn8Kc=;
        b=QX9B3awf+louPH9x4mMfKfLfIzJyjP06KPOpX1YCUlRSHYVG21IYdtNoBPhaYtiVUg
         95FzAF6HyQO5BB8lKlnzo4cD+fGIOxjxLrGcW2titzYX5akL/VYPCH/X766RvaKoevuq
         yZwIGoZhkZqTyQ3KdaJCM/dXrrOo3xRvG+l7DNS5B1S/YNbaCEVyYOo7kqtdvjmeTFs3
         ED9QbJqX+/WF7PV77Lbc7nh4C6nSNsCTcAZJhIEV1YbYLod5kLVB3C3sTiC6AW7/K5jB
         N0GH9v6EzPzZSMZRf2N6I6okTKZeXWHytQ2Wzb7IZkKBkD7I1JihLpP/qdIWulGE5Nj7
         cXdg==
X-Gm-Message-State: AOAM531jThbcfi90xqh2TXdeKV99cRpy2OfAveZypE9+5gTr/Y6tXDVZ
        awYqV3DK3H2I0sA55UuDE6VoyLcGnyHzKUxvddI=
X-Google-Smtp-Source: ABdhPJyXVrbJ9sLn243oTWw9LYVg3t7u+a0FuioT2UE0w+HWH06oSDcnd4gOdhw35sZYgz832kZFkbKRfrO1NGS6wtk=
X-Received: by 2002:a05:6e02:1a8d:: with SMTP id k13mr6700025ilv.0.1643384925534;
 Fri, 28 Jan 2022 07:48:45 -0800 (PST)
MIME-Version: 1.0
References: <10e51417-2203-f0a4-2021-86c8511cc367@gmx.com> <CAMthOuOg8SVYrehoS4VS=Gj4paYyobmqX85bKzGxYcG-2oJBDA@mail.gmail.com>
 <1e7359dd-c021-0773-fb65-752fb7b6ac49@gmx.com>
In-Reply-To: <1e7359dd-c021-0773-fb65-752fb7b6ac49@gmx.com>
From:   Kai Krakow <hurikhan77+btrfs@gmail.com>
Date:   Fri, 28 Jan 2022 16:48:19 +0100
Message-ID: <CAMthOuPJrJbGXfKj_jdyKSbYGhjq_S9g3HKxku5rDVTpjKLamQ@mail.gmail.com>
Subject: Re: fstab autodegrag with 5.10 & 5.15 kernels, Debian?
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     piorunz <piorunz@gmx.com>, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hey Qu!

Am Fr., 28. Jan. 2022 um 14:01 Uhr schrieb Qu Wenruo <quwenruo.btrfs@gmx.com>:
> > I've tried autodefrag a few times, and usually it caused btrfs to
> > explode under some loads (usually databases and VMs), ending in
> > invalid tree states, and after reboot the FS was unmountable. This may
> > have changed meanwhile (last time I tried was in the 5.10 series).
> > YMMV. Run and test your backups.
>
> Mind to share more details?

I surely will when I hit that case again. Usually, I was able to
provoke situations where btrfs would spool "object not found, error
-28" (if my mind doesn't fool me) to dmesg. After this, the FS won't
mount again. Usually, bcache was involved but I don't think there's a
problem in bcache at this stage, it even happens without bcache
writeback, and it never happened without autodefrag. I'm pretty sure
there's a sync/serialization bug in autodefrag somewhere, it seems to
work just fine when running "btrfs filesystem defrag" (although I was
able to freeze the kernel with huge defrags but usually after a hard
reboot, the system was just fine). Device write caching is disabled
(if I can believe the drive firmware), so hard reboots never failed me
in the recent past. Except for the autodefrag case, btrfs has been
working super rock solid for me.


> "Run and test your backups" is always a good principle, but a shame to a
> fs developer.

Well, as written above, it has been super rock solid for me during the
past year - big thumbs up to you developers. The few losses I had were
due to some buggy writeback behavior of bcache together with my SSD
firmware - using bcache in write-around mode works around that. I'm
not even sure if bcache is to blame here (except for the 5.15.2 sector
size bug), and since using the data type hinting patches to place
metadata directly on SSD, and data directly on HDD only, the need for
using writeback bcache has been greatly reduced. Btrfs itself has
survived several hard reboots since then, either due to power loss, or
due to GPU freezes, or unsafe wake from hibernation. It just works,
but I didn't try autodefrag to stay on the safe side (and since I'm
using bees, and autodefrag breaks extent sharing, I'm not really
wanting to actively use autodefrag). The one time I used autodefrag,
it worked until I booted a qemu machine, error -28 was logged, and
then the FS was gone for good after reboot (open ctree failed). I
restored from backup and disabled autodefrag.

Maybe you want to recreate my setup of that time (5.10.y) and test for yourself:

4x HDD 3TB in meta=raid1 data=single mode, on top of one single bcache
(SSD 1TB), writeback mode doesn't seem to matter, bees running for
deduplication (1GB hash table), qemu with NTFS images (usafe caching
mode, cow or nocow doesn't seem to matter except for performance, but
raw vs qcow2 format may make the problem more or less frequent), other
VM solutions (VMware Workstation, VirtualBox) seem to provoke the
autodefrag problem much more often (especially with direct IO), write
flushing setting on the qemu image may have an impact, too.

My new setup since kernel 5.15 uses the metadata placement hinting
patches (https://github.com/kakra/linux/pull/20), and I've moved the
metadata to dedicated non-bcache partitions since then (which is
really a great and well performing setup, btw). Thus, I didn't test
autodefrag with that setup yet.


> It's better to be sure the problems you hit is already fixed, especially
> we're already doing bug hunts in defrag code recently, don't let the
> chance escape.

I may give it a retry later but currently I'm happy having to not
restore the FS (which takes 24h). I could probably try if defragging a
lot of files in parallel still freezes the system but since I'm
running with the metadata hinting patches, the whole process is
probably a lot more responsive anyways and may not even freeze the
system anymore.

In the end (at least for my case), it's probably better to have an
out-of-band defragger which integrates with bees. I think Zygo is
working on that (we chatted/mailed about how bees could recombine
extents, and how sorting of work is implemented currently).


[off-topic, maybe snip]
> > Database and VM workloads are not well suited for btrfs-cow. I'd
> > consider using `chattr +C` on the directories storing such data, then
> > backup the contents, purge the directory empty, and restore the
> > contents, thus properly recreating the files in nocow mode. This
> > allows the databases and VMs to write data in-place. You're losing
> > transactional guarantees and checksums but at least for databases,
> > this is probably better left to the database itself anyways. For VMs
> > it depends, usually the embedded VM filesystem running in the images
> > should detect errors properly. That said, qemu qcow2 works very well
> > for me even with cow but I disabled compression (`chattr +m`) for the
> > images directory ("+m" is supported by recent chattr versions).
>
> This may be off-topic as it's not defrag related anymore, but I have
> some crazy ideas like forced full block range compression for such files.

Happy to hear you're working on ideas, it's really appreciated.


> Like even if you just dirtied one byte of such file (which has something
> like forced_rewrite_block_size=16K), then the whole 16K aligned range
> will be re-dirtied, and forced to be written back (and forced to be
> compressed if it can).

At a first glance, this sounds like a total waste of resources - but I
think this repays very quickly because it reduces metadata overhead.
It could also reduce overly heavy fragmentation due to compression,
and reduce the pressure of orphan/hidden extents parts. So, it sounds
good on second thought. :-)


Regards,
Kai
